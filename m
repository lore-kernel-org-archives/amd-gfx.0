Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8404CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 09:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 426C210E0DB;
	Wed, 29 Oct 2025 09:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5GRjEEP";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5AA10E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 09:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6G+mDytNuwo98rzESGwpq8ERdacL/5fg7vyefDHrZZg0f+zREMWb+by4P0S38XWsElvjgGyhhReZgrYvIBY70a6OnNlq4VV9wXEfT39wAnYKXjwQswMsyBaGyKx1mhFL+4QnAMU1fX6H2UvWNs3zkxtLGKH0G5UypwQ5m1mxY+yBKN1NLxCKckPy2eKs0ta3olGxAYX1My8JvvoRhsaQz/lfEVYfrb4ZCLSr6D5hBoIgiv9KhoRVbpTq/OJa+lX8tjV/DbijN89YFAU2qFq1K5APp4MKhL0OjcMejI7Kx+tSIlc+aL291NAxFeBXC3cpM3IXYlAUzJvzKxiS1aJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X779uzwS+JlOqmvqasszg+c25fuvMcDjTObIioG66go=;
 b=l3AqU8+/ZsTWgsfX6EPS/7Yq6a533DS4vqs1EzhDLtAwIMzBXtFsNZp8jUU1JVsd6g8wSoML8gytZxopZLKhwuGOGRGHDEV6igSV6fnXhvJjFS0X2eyGXHiXI07FOVU22UEvsigqWLbK2IVFQQnhqyWDxVzZlKzWlGiwuOdkAoV65gg6D4+ZRsSYvqTF8NNqWbglWa+d8A/BNYZJyEyF6/U/eDAK+KJIbPSLLMOdtB13KeA/4ta5w3atRTJnecMapk+FM5mVX4ajeSJJPTs4pITVNJsXtB3TCQ4XJNrTouG6zE/Idu1ZkxdG002/9ewMhPNog0pSVdJ6e8Ov+g3Nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X779uzwS+JlOqmvqasszg+c25fuvMcDjTObIioG66go=;
 b=E5GRjEEPrMK8up2+jOlA90k/nbBxNAvWKrfOUdg+ZOjjVqarH4Q0HfEXCM6Q2NjfP7uvmkbWF9XIEDTi4Ka0Dmbzjp5GxJzQ2GN1ztT6eRkFHsaCUfTHqFX3vzfrygylvbFM/of3iEtJHSj6w6Gv6SwzbSMvOwpyII8LO9tOHWE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA5PPFD911547FB.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 09:05:56 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:05:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 02/10] drm/amd/pm: remove smu response check
Thread-Topic: [PATCH 02/10] drm/amd/pm: remove smu response check
Thread-Index: AQHcSLDNPN6DY43EW0Kpf+BNEnHAkbTY1NxQ
Date: Wed, 29 Oct 2025 09:05:55 +0000
Message-ID: <PH7PR12MB599743F04F465AD3DD257AC782FAA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
 <20251029084751.1701305-2-ganglxie@amd.com>
In-Reply-To: <20251029084751.1701305-2-ganglxie@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T09:05:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA5PPFD911547FB:EE_
x-ms-office365-filtering-correlation-id: f64d2f43-4971-4735-ba59-08de16ca5e7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?vpOmq3mveM25Wl9fMDTZhSLyMtFyeCF4t8IrBdoOC2u3jvku/6MJB7etAlro?=
 =?us-ascii?Q?QaPfiQ+FTzUcyGvRWHvf7QUj12KMKaNGN8QaUOGEwyL+3WRKSWN7tVoGAesG?=
 =?us-ascii?Q?P8DdyJpov4QyzytdQQJoR2VB48tjorDFl7dfCY6jBzUZb0n2AARMRRGg6FMH?=
 =?us-ascii?Q?twiio4WNHeEACWy90H4wXHNOhCs+Vy0Ty1qqqEs9WrKFSa3f642BqJL7gWs6?=
 =?us-ascii?Q?9r4U9pXrWgejylaTkS5v61nXvxq4MHUjF7Z/nqOTOsC1FC7XdEq89q4cVTCa?=
 =?us-ascii?Q?+iL5ZlsMF9NuoDKVMAmaciSJgviB7TIjtqD4gH6l+c4chZmRAFsd7r12Cmrt?=
 =?us-ascii?Q?LjPqRtnfc+b2TvxzoI6f5QbpX3vnVchjUqgmGHwnTZhPqBS7ND3CH608evAx?=
 =?us-ascii?Q?r2gN/MSCNhC1ac67ekAoya1tKc6XC2/Q6BvRef5CVUprW4GHUnc08ePHOrDg?=
 =?us-ascii?Q?N1rLIKaKmBM0jY10s3Qi3OBtKicPz7M3gO4PV9HY0PsnlcGJOMJs13Yp6PLa?=
 =?us-ascii?Q?iyTFoHohKDHHZALIsNpgPhosgXKCig5cfaUohggAPVcFZoPZUwQGvIgsDunW?=
 =?us-ascii?Q?93lplb9rOjhcLwY2/Y7A6XZ8rXGmcMItI+3bqYz3rfME303npIMVD906N2T4?=
 =?us-ascii?Q?l4rz6g9k750R+9l8JmVrmwyTU8TCWNNaBa9z8Qzy3tR9HfApLampN/Jb7KG6?=
 =?us-ascii?Q?k2iuOEevju4T6Xp8tLFBm721CXILth33ROu0vhWj7xFFPRKHeFDnTVCN6QTu?=
 =?us-ascii?Q?2lA0c+L/M30OC+/M+EMA695dObWcTMhaD5sBd3ExQXJslM5x8L2v9L8mQ3tz?=
 =?us-ascii?Q?RQmlJCJIZS/ikctMbUrMo2iGmgKIab2+ePANubN78UYq949N6jNti6ubukAO?=
 =?us-ascii?Q?JyXeBGEc6ScMNidhkWki0BxlTwCIX7E2gmd4OrHFRIVhQgqp/IfmEJztVKIk?=
 =?us-ascii?Q?pAIds6Wq/nTMqNIQtlxW7uhKDa67MdQ+9gDdGyVsJ3ogcINLVEIlhfsnQulT?=
 =?us-ascii?Q?dYj0hZ/aah9T64Q3Jgl601uULcboPu8zB7J1EVTuGPWEhIWZRyLqXB+ld3yd?=
 =?us-ascii?Q?N1GdDj9Q2cRqBs5OmXBIBftksufgbXVP6+tg5v2I1wQPMJRUuqbgYrM7z5Ox?=
 =?us-ascii?Q?Lln1ZG/HCAckXppRGgRrF1EkQkvoKOMJ+hTPDs0RpqqVrL69yljZce2//xX8?=
 =?us-ascii?Q?c3blGpTOv9ZMk4EbLiKQkquz54jdOWsLlyl+tA/oUkh5Ug/fPy4wBIhi73DL?=
 =?us-ascii?Q?9gN/LsxglMdU+WRJx7s/TKr7koqNgYrirvEVZBW9YfaJISmmAVud2PQxHRcR?=
 =?us-ascii?Q?DqwIpqPLezZl/CfUrxuqup924XBldteSUuaaL2/M1k05ByO+DiGpAOuDPzvf?=
 =?us-ascii?Q?ZBbYXUOda0tb0q3Yohszg49KPUrkAXVCLr3MiDB3emEfS/iEW5Y2++n3LpPy?=
 =?us-ascii?Q?HegSVxT+OAV/aW82lIl2CYlozZqUrom5TQs+qdUgAMNMU0inND/UttL80DEr?=
 =?us-ascii?Q?e6m5ELMjzAbQZxSqNLaHUD4lt9apkNZPxgBH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/zAp0JvjWStYu60BEDt96aDhFc/izAn4CjMDuZ5dHF/T3dJ5LB/4VhH0Vh56?=
 =?us-ascii?Q?aUUzBkn1LYS3CWiHDhaSeMXgcO7XjO3ZvmxC8N96Zsd8DNq2MozkfeWlrWDK?=
 =?us-ascii?Q?HzxgFOI25OSUume67DsPUnffkN/kwFa7pjJSLMJvre8ZnsQqmpogHPLes3q1?=
 =?us-ascii?Q?MxbI1KF8oP/MLxiazAhfL76cCmMblH/98f88+1oUsQzCEsmrrUJrwDiNUlqB?=
 =?us-ascii?Q?lKXUm24/FZpkFyB2iNbY3tGGx56R4Y3ii0G2C2nOHNm+ShXBc8WzD5hHM9RN?=
 =?us-ascii?Q?sz9FENRDab3c1pf0H4KQS/wa+O6010JekGlVMvXs+P5So1y2iB6k9XhMhTX3?=
 =?us-ascii?Q?mas2PGbycGf5dyplxGUPNpIFvReB8UnudstQ+IXttEsoOvfVYEaTVab5jGnR?=
 =?us-ascii?Q?x2AVfBCESRyLh0oSJbHF9ld2ludu/ZGUsbVf0yTeOUpt/l4wZOonyWxq5jD1?=
 =?us-ascii?Q?kVj9EVtorSY/O2iD5W4VGyQ+S0y8jjRG/93OdEyGRnZulWNghYi8ErfNeOn4?=
 =?us-ascii?Q?SgpZFDh+KNf9t+HkkOOE1dsGwqo/fT2xW5Nl2khRJnwLQDnrudk2KLDeB0kd?=
 =?us-ascii?Q?FKj7bm427PAnd9T9pthP5iVPybzKP6vrVsg8ix1DQYRrjLh+E/dXYXn3mi2/?=
 =?us-ascii?Q?p2wDQEr9Op/T6W6jh63GGOwEDWEtbvmge+X6UfY+FBzsSIpdfTrdoXMTYAFj?=
 =?us-ascii?Q?ZDV7RyZ3atKb+gXAQXGcDh5BysvTX2tEpO/mnJNUNsttyeFy8uEIaGlpOqlB?=
 =?us-ascii?Q?k/X2b9z2eiV6xuRiCmB6AKVfQzkGBjo0h67fx9uxu/wnuUV0qroTsybr11IP?=
 =?us-ascii?Q?TK+GCKScjnsPEjZFUEnCVFVsvzppPYc2S/JltroUsoqv6BhTjTajZv4/qp84?=
 =?us-ascii?Q?+4D3k36cGMwDlZYIvvxJuCsqL9HBqDz4bFGGJeN4XNWjC2E0buPsPMs4KKul?=
 =?us-ascii?Q?fBj+UQqPvfHIFQ1kQoc6JtdkG8Mm+jx93SReE72m4c3PJD5fGv1RwgeSi2Cq?=
 =?us-ascii?Q?j09gzyuTQA5oXAwhHBPX6hTOQdGmuN/j0SulXchKYn8ZH12d3ca3tbib/IJK?=
 =?us-ascii?Q?VGb0dk7VTfYnWTeXzKeW0aHLVeVEgZBfaeAyOG7KLziIyOFZ7Od/rSmZamf6?=
 =?us-ascii?Q?3nTQcqGWZF4kbOe4ABZw51bs4/sYclyw5ka5QOzfklUPoOsMG1DYvfhVN7tl?=
 =?us-ascii?Q?3Flz8YCPgPw/69A1/OCx6XsXYe65rEBPdS+c7ubaRTDrMXVIWyNpNdPFumUp?=
 =?us-ascii?Q?JCM0ejfC4MeIFZCf86xx/QDjWE5wbiGAQKGae7TNoN398/plT3TxUGjPKHOu?=
 =?us-ascii?Q?ZO53CTHn/ke+sLhicVPSCCVzg+pDv/3q2w6Y3lcUzwscQgnVDeIfPgHeyhIf?=
 =?us-ascii?Q?Zp45vHxfLomoE4/e7psXrO1v7xI4RM5ylBohfG2EppZFwMEvASdF8w4IbrKi?=
 =?us-ascii?Q?ig0Ay9yQ4Oe8+SF7VU8IYq+gWJaYQAT4aCidVP6qKH5llpBRr9SY4yG4tTAZ?=
 =?us-ascii?Q?xJmArj+DQcRTOJva+3iB4wRiZBQY4nwnWSNB+WDOPV4eunJW3Gs1f7LWjxhY?=
 =?us-ascii?Q?COL/0k3buvtStz1/cQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64d2f43-4971-4735-ba59-08de16ca5e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:05:55.7083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dhrgYeTV8BcPnlhthY1Oo1gb55p8FgovQY5d+T8JeWdXWwQYT5GXwEMCe1jzQgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

-       case SMU_RESP_DEBUG_END:

Please remove this macro together,  with that fixed, the patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Wednesday, October 29, 2025 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH 02/10] drm/amd/pm: remove smu response check

Remove switch entry for SMU_RESP_DEBUG_END to process it in default entry a=
s a generic error, because its meaning may varies among different socs.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index a8961a8f5c42..eea5ff69e5ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -168,10 +168,6 @@ static void __smu_cmn_reg_print_error(struct smu_conte=
xt *smu,
                                    "SMU: I'm very busy for your command: i=
ndex:%d param:0x%08X message:%s",
                                    msg_index, param, message);
                break;
-       case SMU_RESP_DEBUG_END:
-               dev_err_ratelimited(adev->dev,
-                                   "SMU: I'm debugging!");
-               break;
        case SMU_RESP_UNEXP:
                if (amdgpu_device_bus_status_check(smu->adev)) {
                        /* print error immediately if device is off the bus=
 */
--
2.34.1


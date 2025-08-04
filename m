Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FC1C87FD3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 04:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77CB10E11F;
	Mon,  4 Aug 2025 04:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s0mBrcmY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1459D10E11F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 04:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJSjMsfgHgrJzYIyT4Y1oUo4str3XjFW14el0A8MAPYHTDufgejKWWiGMryr5aTP3o29EnamDM7VrH4nU1wx8GzVc7U2SOjXGOop4HqOfUzknNF+Dg0ZHBWbGECAOVnGsiql5GsQFAz9NLf1HjSXcUsRIbYRBNwgXi9h2LoxGVUc0qnJyTpjadNssFPQ6cAwQ8pLP7d1WmyX50P6ThAUg9Cxv0QhbYbjPHCGCUy5HKk6ndgSxHBrM2xZu2n6KKFVfYOZ7R9g782302vJlw4+ziW7fQ4mMUoBJMgngxHUC41/VVsawwxJQqHRPrVyR/XtxnuWjJF0Rk4XrZiNTDsjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5F9Lr75UBlekYBqXsRRs2qx9/X3jzki4Mpv+96G+Abs=;
 b=EsOqAEtuEblTLXF0dlhpnN+YSqt7+HEY9CXKBxQXLaj+tDB1ZYyfcJXxFRH399EUCFcEs3BRgb8PefNwX0TkcJ6KIzld/0CVphozhwH/WB4dW1u/ksPFIJ7CYlI0qsC67Zn2aCyxFDZt9iRaILYJUwmHwWxm1vUclB1OBGrJsfjsyXBd3z9brHwFFInklP1Is0dz1nKMZ9WWKJLMCdekbP4+jOXxRqKYWmCaOUIz7lj0R7KJaiA/vWCooDwQV3xuTSQEoTtOer6yz7QuxiL0e8NnIfePDBf3SWtC/GsQHc8pAAAoyqEBfNZbyLbbaBWWltUUrXBdVU/Eb/3k6Pd+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F9Lr75UBlekYBqXsRRs2qx9/X3jzki4Mpv+96G+Abs=;
 b=s0mBrcmYTza945/98RI4xKrKKuhY1YnHBXZQMM3v7LpNM+ABkVthJ7M8a8IhHrnouDLM/Jn5aIMW8XktxxMbJCf5jxETvUtDWynBNWx6k3Ff+E/H16R+X5uMXa33nqvuCcSeFhVgBbkxtCoAzYNwcjQcza6/KjYWWsOvmW3jNfs=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 04:09:33 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8989.015; Mon, 4 Aug 2025
 04:09:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Allow static metrics table query in VF
Thread-Topic: [PATCH] drm/amd/pm: Allow static metrics table query in VF
Thread-Index: AQHcAxDNTy1O6pHtR0mH0EhanZPGiLRR4s/g
Date: Mon, 4 Aug 2025 04:09:32 +0000
Message-ID: <PH7PR12MB599796F6BFB8F2CBDE853FD08223A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250801181850.1712440-1-lijo.lazar@amd.com>
In-Reply-To: <20250801181850.1712440-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-04T04:01:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB6568:EE_
x-ms-office365-filtering-correlation-id: 9df2a37b-f79e-47c4-017b-08ddd30cb7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9Csts41jUqWEvHeyuJHUBOeXciW3Ose06ZMEv8LeWYWs4YGboFKEZlmNPpTm?=
 =?us-ascii?Q?n7DQD7erWwPhURdg8aNWnRlZFXgRFS9xz1R6milCKsFOKTnbChwcYlNNP2ye?=
 =?us-ascii?Q?1Zm9PBt80om9dWRyZGMf5FD3rPCOP9vDnz1VIRYKG8fRZePJaOrya06V8VKf?=
 =?us-ascii?Q?cGv8h59XRkJ37qwBJT5BKkmBLbRmNNgs4ihdA37hC6cch7rEO68DZFH9fgX4?=
 =?us-ascii?Q?81EWaRzyhQ8GZSf1cURJxE+/geiDaAiFvt6mBviMzFlcUkvFv/sW+2xPrABL?=
 =?us-ascii?Q?+ivnmJyDStJU8/61BYx6I1xvXGhL+aWrwW3rWQg10YOQ2QzEIw/q0cV/h5go?=
 =?us-ascii?Q?g6i+MAadrRKeB1slPXLRpCpzqbj7auOQ4mz2SFk7qbW5lkwxVcL3/o1tC2hi?=
 =?us-ascii?Q?j2sExAWQ1bYzJ+repqvVHNy0/NFG8YhBxBfUfvsQyVggmkeXHMn0QQ/jNv82?=
 =?us-ascii?Q?IOBw/edzszq2P5rafED/+oU3atQFhUhnoQCMAOsB2ROoPWBTGTI95ZppBnbY?=
 =?us-ascii?Q?RsUwhux9kLnxlu4DQ3VwUYik3aSbDLX9Y1jzt4J1LPTe6SP29vM17IrKH6Ix?=
 =?us-ascii?Q?XWirX/7xeOlP79MB3/ZGlPypazZbW+uuZf1wkVfe+sEjymg0rRPYapNCVEAE?=
 =?us-ascii?Q?0KYR3yrV6ug6ThlISOS/66i2f4KWOXCaPwbEJE6NMYLaDRkVyoCZK0DS+y6L?=
 =?us-ascii?Q?hhEDP5HFxEymulfKetteNJQVwiTIf9tHGX4hqVtO8Mz8zAhhfMuHZlNQD+/u?=
 =?us-ascii?Q?JYiPoofwymte1/qS5UqMedNMO7133gbMf7It8GvErFSCcKVZosHlUaXBM0eY?=
 =?us-ascii?Q?o7Gmy3O3BGxJUpNQFKtXviFaHspl3xcdwQe9s9k37D1HCIwHeFxrdlkUckaP?=
 =?us-ascii?Q?N9yjHaYEvPEqF39jRPJPD8hjteVidzVShODFrMewRWbJRMnrrjCKIN4ioNHQ?=
 =?us-ascii?Q?p/FCo/ImRn5VBAWPOZnr23aUg7Medh9ff82DyRQFWLYOeYIXfqoJf2dgoK9H?=
 =?us-ascii?Q?6kf1bcqYlMIwdoPxCgGXHnP92/TsPJ0iEDF7VvtGQeWMDoUkKWweXSoHgAMo?=
 =?us-ascii?Q?rjSpYpNXYvcM2mDmEquYqt7nAz04lDet5rsR8s8MdqBKXmlMcBn/zZ4k93mr?=
 =?us-ascii?Q?UIUveTvbLt0R57QOYbF2OqR2S5SqiKKpJT1dYjuB2uZwZMBE1k51fXgaEIkm?=
 =?us-ascii?Q?R6ZIMNY3r9x3uwgtfKyUXOU0n7htdtvxD33GM316kVjzXruEDLuGucNIrtKh?=
 =?us-ascii?Q?wy/rYRAO6nY/GtkkAemYnnZlGLcQ+ZlbsoXvS7tLu6Sb7JZQ3JuDFYw+GIPv?=
 =?us-ascii?Q?n04U8LiJJLPcPfT1B9KpLBONLLlB1KEC590JKy/iiTC9fgF3gfW2w1cnTV+v?=
 =?us-ascii?Q?XehFUC10fJxzTpjKqYRk08jOG1KyohMLNChOAMFZl44Ii3j6g/3pDHKMWP3o?=
 =?us-ascii?Q?OKBb4wZKkBCKksuQ8TM0Kag8j5qMQdbgqojFcyhXRzENzyWaAz6+pQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dkxrcPjy64Z6WPcouqLVDWGyUkieZ3Fe65RI13rmSz2sLOV5OTEqSFLWpMPx?=
 =?us-ascii?Q?aUJsmwgMo1CxFnI0Pa/btHCkLM7lb1QJHHM6JkQKWJZ+gsm9yMQ3rcpPXzon?=
 =?us-ascii?Q?jRgo8nmmbEwNGRfE+sDGHhaUH7hTDsqsgtjHKy1BdHAQs5yZU2CHQ0R9365d?=
 =?us-ascii?Q?+WuSjG37oFk9YHtylJTcS0G8MyJr/3EfhODI9dxOckW8Y8ZRpA99CPiY1ctT?=
 =?us-ascii?Q?OWzlmku3GRugIQhRMHmUzl2c0Ib8RTEUGHed+Ngx7O9/eHVwZY6F+r5Tx8QF?=
 =?us-ascii?Q?La6tNCME+6U9aD8aL+7ab5/fOBCel1yrN0WTVD+fyoxrfpV0M1DAEgKUV0HU?=
 =?us-ascii?Q?Vw4z68ryaPAVC89G8Fh310W6HSRalLVowDztT+DGjUDlPZUihWYV4Ejbv/aA?=
 =?us-ascii?Q?2nvnLaiEAhLC8baQpYbLH6wQlaIWf71WhoWkVkyRMWqOH6aO1snbdzY+pjJT?=
 =?us-ascii?Q?6NTvc0u0g7tQLOeOTMm8GfxvjDZ6803u984Z0lzWvNYgbwYCv+lO+Kva1Zlk?=
 =?us-ascii?Q?WYg3fO5DA6aqxGCgOCl5kZK5/XGkIiFInyKEPu1TchkjtMACnhRcuOn798qV?=
 =?us-ascii?Q?jGHZ4iEYiEp+x4wiky4Krg4OZ59s5SvnQH1ymsA+ARaEQbOa2Fpeh4r+oWuG?=
 =?us-ascii?Q?5q3X2ZxNUGfnmqJS/0wRLo+BUC7e5+5GQv7/+jhFQplue3l2UejxvThWmFA2?=
 =?us-ascii?Q?xfwI4zCySUmwP65v9kj1jEIj5rz5woCuGEg30vAjXm4XGM/YQ0Ccn0k9sWf4?=
 =?us-ascii?Q?sSwQRuVw3j5iSEobecU2jBRzh+NQpV0Sxow/ynhJOIgdIoddT77XfM0XTaKy?=
 =?us-ascii?Q?fdL98mjNtlZg0TvAk+UX5rEa1vB/z4ucyfW07zpM2eAy0X4EZNi7QepX88pt?=
 =?us-ascii?Q?tHmMHh69vGdAuXieE87N46eoc9kcH7g04vL73m35R8rbMubN73MNGNM2QFVO?=
 =?us-ascii?Q?a6Ws1/6BaKMMK//shmhxcGIcIm7eJQvjGxH6MZqTOxcQXqcqSInrM0ia63fb?=
 =?us-ascii?Q?/67hO5YVTxaIhURzk4oBpOz4DaJSe1bqX/afYvzvzty1ht4nfsjsCwLOVd1t?=
 =?us-ascii?Q?dq8V/pIfP5VUit+1oybCuuPyC3pIZqZOld0nRlx5bnPmRJXaEaVHObG2b+Pp?=
 =?us-ascii?Q?IxrVBzhg0/pncKAXCrJd2c+rin43pMSRiq5GDW5UAwk2LQwUUfAwnLY+7O87?=
 =?us-ascii?Q?eGaAeFjw0y1phYBc2Qg/brco3/NWtcWW4jmaHk8hD4hnq7p1J4wvi5vE6kZX?=
 =?us-ascii?Q?CgJOFrDxytAipStcuc21pgbGyi1PYYQL3oP5fkz01xP5qTIXVyhqRYaUBB5u?=
 =?us-ascii?Q?KWOnGblug28IJosconZiJfhHMzBdozPtDm6ovWVJh/hRpe4GpuDopZ+TDhsF?=
 =?us-ascii?Q?1FbTXmsshr4m8KJfoE8eFD58s3bjTAlD0jDuX6YblzRHUUAvTdVdrAN1/m4/?=
 =?us-ascii?Q?Xfe2ZiFsy2Nkqd+Q6Z9/Q1Cxpg2e7BhIHaZhpm/E8QRf7mHTQiVrgvCczQrb?=
 =?us-ascii?Q?oBPmKjkg/JHzwCJz1wPcYEQt37vkGuFt7nB2ZcFS/BGhRJez5eEr0FJaSKkf?=
 =?us-ascii?Q?7ivpLQzbtnhAZq1yqaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df2a37b-f79e-47c4-017b-08ddd30cb7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 04:09:32.9827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxVzdbVWNIvTF3XcGgIHhBsSA9tmWHOL/178aP5+RYiv92I6z9YM8XIkWG807Px3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
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

Please add necessary pmfw version checks to ensure that this msg can run pr=
operly on vf mode, because the old pmfw is only support pf query.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Saturday, August 2, 2025 02:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Allow static metrics table query in VF

Allow statics metrics table to be queried on SMUv13.0.6 SOCs in VF mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..148941d7ba51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -177,7 +177,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlin=
gPolicy,             0),
        MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,  =
                     0),
        MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,   =
                    0),
-       MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMet=
ricsTable,           0),
+       MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMet=
ricsTable,           1),
 };

 // clang-format on
--
2.49.0


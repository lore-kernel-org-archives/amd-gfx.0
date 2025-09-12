Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27611CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 09:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD43D10EBE9;
	Fri, 12 Sep 2025 09:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QWZzjd3t";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB6B10EBE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 09:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcsz9QLBn2s6XjSatzWTeie1xupaW4WmhJhaTOondXvhe7pmNWiwEsEWx8t1bxxdvi9I/I3lqBgJVCaUNsDPXix+rYG8KvgbwwNExfTl6POtTr3nAkDB0lPe3pbR2gHZIROC04MJctH7kbHu9wZEdEZ2bXF+FdpwUamCm4WGpzka713St33zlTIC4ArFF4xB035/4bes7NQ6bHvsk8kF453d57urbyrIRa4NE9Wgynqh8N0CRC2MsHUqZl+b/mjxTqCbFkpsVhZGvUHYVW9l0nHk9NZebqBhBa5r6d/7JN1TSdOzNH1rN3kCU4cL/f/jCAfS6gi6INn+XnHBh8LU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoEH8IhS/ogDtNZ/H0KPhmMxw6S7KUCBGG3Fv3SfiKU=;
 b=uHnK1T7HDOwshFRDVJdSz4cQb+WHkEHtEgoo8jVE1exrHE+63H3i4QWxQ4HvqY+77O/iFgRqJvLpuL3cK8BaNMl3OIXrlBsgN3obqauIUbF72mQOBZh9/Q7G5OFl3eqnpy+v1c1XSg9hjtH1zZo3mchIQ4vvtLgUhtYZ8RqhBKBfLMnTmpesek+B0hbX1XD/iqncX41J1k0p2axxCO5DmGE816RnZP7zGe5d7X8GqRwmnrdApzOr14M8OCvvJgiLCus4lx2K1eUbLcvtT23ijdsX3jTUoI0JgfxxqWhU1ehyqr8MXZAHTjGt2rLW6LWgpy8pQP5En0Orbl+/86oFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoEH8IhS/ogDtNZ/H0KPhmMxw6S7KUCBGG3Fv3SfiKU=;
 b=QWZzjd3tCL21meq1aVFsUtNSARMZTBTwqFy8BDGU+w7RSN+NpPaTDrm0ZvtnmEsrpgmHzvaI+x46FyPj7oNMmIFQa7Lq4JxMJYyRO7nC65VLeGvaIRGZpYYv2+45QJCxCPeR4RR+M4SSyP2TumaWu5hBvk1YEblnyIh2NYfrMv4=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Fri, 12 Sep
 2025 09:42:53 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:42:53 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init()
 stage
Thread-Topic: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init()
 stage
Thread-Index: AQHcI7xZmGcYC1TEz02+iRxlOI1lS7SPQETwgAAG7gCAAAQZgA==
Date: Fri, 12 Sep 2025 09:42:53 +0000
Message-ID: <DS0PR12MB7804AB5323A73232D2E058849708A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250912080734.3121325-1-kevinyang.wang@amd.com>
 <DS0PR12MB7804BB857D2738008AA8E7E69708A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <PH7PR12MB5997F993C5483CF4B89B42F28208A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997F993C5483CF4B89B42F28208A@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-12T09:03:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|MW4PR12MB6850:EE_
x-ms-office365-filtering-correlation-id: 9c532f9a-33d6-4eab-fc64-08ddf1e0beef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sGakS6zFfhrF3CH4aZ/zthW0jZheJq004NMBeOmVUcP0pOYACuGMXzioGY2R?=
 =?us-ascii?Q?tbP7EFpGmi15PtWKvC1uMDXuhu/PxBimY4TQ1fNlVnxnd6Fa3S8NA0lJIvyq?=
 =?us-ascii?Q?g4RkcoxzYBiDqrfxsTtGr0cQFpUSoKbtxwtkkuznBtmZbG2RLxC51Q4gZNPx?=
 =?us-ascii?Q?Ge1dUP1rfXoStqYr+mrj7PV4Rn3i2Np5945dbbR4rpwiIhwB/wnLE3M6lJcN?=
 =?us-ascii?Q?XyOJsoSCNU8QLkjRBVJOIc9WfODxefpLyp1Cof0kTAtA5BbkFbKeh25E+qPl?=
 =?us-ascii?Q?z7csDQIHaFz4HAKiTgUk9M8hKosP5wmNB36xGR7Xg85GcY2gLMKa8a3SiRBS?=
 =?us-ascii?Q?Q63xEUGtGiEZqBW5BzEszuTaNUryXGLyfAjn6v6N8RA6EZt8yTvLmW4i4GKC?=
 =?us-ascii?Q?6UhymOSDQDMMk/pOjzK4UNDKdSQML003qmhNe+xT/UYbLugAGVDwV3jBZuRx?=
 =?us-ascii?Q?F5M3VGtLL4UTZvlLuAjJR23KP+v3xI0bBWUQKodpfnlquopKXkbNWJ3UMT9Q?=
 =?us-ascii?Q?eVTIxYNj9hjFEpUNrHrTSb+RdNWdTbnk2L0K5GNnk+tnyJgZlrL2AQdSYxXe?=
 =?us-ascii?Q?HpfEwwNVH4ekioYS80xdIgMXYYoG0N3mySafBjqjQFpv4lIJvZylN8YlNpxI?=
 =?us-ascii?Q?nCdsytP5SJN1D1kLdVSXEXTQtwJssxcazdALJjKnEGJdU6QfhBbHm1nCbduV?=
 =?us-ascii?Q?CX/WhDppSFhQOrEm2EHpvJUVvjrU+A48g2RxZKx0iMZrSsocmvBr79cGvCbW?=
 =?us-ascii?Q?RICMECq3gbO+GlrFzQVhAXsl38NCC06k9LUqn7nDd0VceNVVnIVcS3Zh/iQR?=
 =?us-ascii?Q?ySICKi3dtJgY/npdntbMuft/GV9q4YVbPliXdCP+fR9HzsDdIhpnKf2I51kk?=
 =?us-ascii?Q?Xza0aY4CtGQENJ3dLRbnfDI9vqdHXW4y3uWJni3sTPC6hd5dg7c8h8OCwJhY?=
 =?us-ascii?Q?sJlB1Q0pWdvz1fXDa3F9bV8b5uTYwYz5tRPLqt6M7nSxj+TxctxXRgj01zjw?=
 =?us-ascii?Q?Mm2Czivg3KwUNkkTgHDjeSJJWNugMrDktg2/FT5hM7sbhdyLxjscJl8okaJs?=
 =?us-ascii?Q?KFMtysm4TfS1lMfX1pcWAclSID69mUUmkbjZNoABx0DmKSRYiZpj2U5zSWAM?=
 =?us-ascii?Q?bIHp2r1xhS3fDj6qzSlPg1ewgWo89zr6hmhfS2GjJgMTBI1GIq3ZFRaYMs8K?=
 =?us-ascii?Q?HAVXDiF71xC5Eyh3gK9KBPncofcJeR1cbzKszOW/ti7VGrwAcvJQzinx6g7Q?=
 =?us-ascii?Q?gDamWV95o1NCLmHTwXrKrCZ7iH+xod/QcvXgJpT96CWBZktMLVLoDb4g8khy?=
 =?us-ascii?Q?b2ASeRQ/Myq4d+1rK5QrQA59EsAwxqlycGr/GI8TixB3x31/QyE2XsOEsgle?=
 =?us-ascii?Q?4NgRQl737XGVV+GAYT0szApLkIUdJY1BTF+Grcd9rwGiyOXRP3wHcj5Yg3OC?=
 =?us-ascii?Q?k8fj19dfk+gcRmPHSeZbn9ZsmV+qU+7lF+b5PjJw8GbG6tjS3pd5q4BO93uy?=
 =?us-ascii?Q?cTvi3nT39cIkC0w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zAe9EOL4P6pVy8jOt1PkBsDykiQn2GLTsnTpM0LLeXOqvBb61rqpNANpME5O?=
 =?us-ascii?Q?8rLQ9G7IlneB2tVmuq21037JP23YdB5TvqFZJbZfpXxDNsETR2PqnV2+4Wv9?=
 =?us-ascii?Q?hJHD5lKTIZSJLTjVREMv5OcPMeNWvHay7Xyc5cGRopJzbNYp6N2hZvE43eth?=
 =?us-ascii?Q?ofWghYzA7LfPQn6whaza5UfReComf0RDBvrJGZaHAAhm6Xd2dxu/wMphCK07?=
 =?us-ascii?Q?oESCiLyR9OwlArNLW30PBTobn4t8BWmy+hcERujs1VQULhF+capubDiA+DjL?=
 =?us-ascii?Q?nQ1eGd8mVu4TTvAFcmpn2BLGa9BASDUxfbAOawO3bzZkjVTnd/aNIq9BLBba?=
 =?us-ascii?Q?30IBc6XXL8iyD6PqeIRojjSmdEeuFMiWKqhyTN8Rjas41iTlE1mILTLf2v6G?=
 =?us-ascii?Q?Dcc1gD5KZXn0xoLMTAv5LkM9p4e33xyPOvw+xHgOzn58joJWmvTwxdk/5cFk?=
 =?us-ascii?Q?v5IwkrNF8SW7fSQJZmu7wlVzSNI0uuNU3lfokw64QgX6h7XVVFN5Jj6KTwuM?=
 =?us-ascii?Q?R6GXJIduK6fsEK9ZrXY9925YTc9SqAYnXkg+E8ZZJ8bub7EIRtcEfAwJblrZ?=
 =?us-ascii?Q?W0gdDLhuNuiYCck1oDtuUDthxhAEXX1alFUHpLZsyz29/yKOh3DkBtE88Cbf?=
 =?us-ascii?Q?Lt5EP/O9wKAwX+mdJ/My7m2k05shbZ/dj4l4YdK2n5BUNtxXNUPh9/nLEAZb?=
 =?us-ascii?Q?HxkkdjBAWvvM1Rhm9olwpsfWPE7zSwb+6JXzkKz+DO8thU5E+vkSqX0bgS1d?=
 =?us-ascii?Q?MoSa73uFLDs1LbwiOGs5veNkyCps9X9Og882TB8bTw9GQDXK4dSBAHxuhZak?=
 =?us-ascii?Q?uWy03K6AgFvbnNtbWd4a6Vic5Wf+9SyWX4UBcV0W/9MoKFelnbjZWNthD9cm?=
 =?us-ascii?Q?ovrD3YW3ktZTywb1P+S5gFardn4UEOvOW4mE5uFkIe2T52zSKArDEn+iLbtl?=
 =?us-ascii?Q?3ugMpIKaHVp+O3LzIeaJL9wj9rb5aE9mgkY3nEo974PffHZBP11168V3lKVO?=
 =?us-ascii?Q?JMzxaAucJM1+LHwWuhH5pnLyea5pMwHP7W8EdvWeDAd1cWfbl0GG/pcL1u9n?=
 =?us-ascii?Q?SZiFDyv/JUtPssqrdRunpg+xd5/vELcsH0hXYYxkm0rZ8rDn0eDz9yQMIHRZ?=
 =?us-ascii?Q?/5CVFi1mKY+Ct1etFsLKOIbdcE9KSmRnVs87zKjxpr2LZQsFp+IYMmHPoUFw?=
 =?us-ascii?Q?/aaqyirKjsFyDgi42p3rhZScjX7fdE4PkUbji+/pfwb1ABf86eAoo5UqdCm8?=
 =?us-ascii?Q?f8pzS/2gcJPQ5LpkP+7wN9R+tcWeX3YgrXgZyKMTaK904WAJmTYemY0bmJ1J?=
 =?us-ascii?Q?Xs9cXXH6K8ogHLkhzWm4h7t3JPIjan1WhbsZuIGIh90iNuI4neAPkmW1axlv?=
 =?us-ascii?Q?8sC1XeGD7GtXrYTzojCvIklZigXtwFofnNTtBHvEtAozjCkaT0wRtCPHsem/?=
 =?us-ascii?Q?0sAokwiA9XtiVUlbz43NTqdtUg2ax67Y3pMP8SWqBJagpdSXdAkavHaRTYuF?=
 =?us-ascii?Q?0wqvirbPdyxCpZJDF68dVkhzB0ePCwQBHJq2K9qSua6TCoeKjbTqwycCZbYM?=
 =?us-ascii?Q?woklBk3BqLUP1mtG4yM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c532f9a-33d6-4eab-fc64-08ddf1e0beef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:42:53.4208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/chk5Dw1bGFwedtNE10N/+UudZ+xG/i9hVQpZ1m7+u7f7DvGSYee0NLUGLYFHNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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

[Public]

late_init is the right place to apply any late WA (after that there is no o=
ther opportunity). There are already multiple callbacks done during hw_init=
. Any other SOC specific thing can be done during one of them.

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, September 12, 2025 2:57 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init=
() stage

[Public]

>> There needs to be a specific callback to do SOC specific things during l=
ate_init stage. Presently post_init is providing that, I don't think that s=
hould be moved.

@post_init: Helper function for asic specific workarounds.

In the previous code, the "post_init" was mainly used to implement specific=
 WA for smu. If you check these codes, it would be more reasonable to put t=
hem in the hw init stage.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 12, 2025 17:04
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Subject: RE: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init=
() stage

[Public]

There needs to be a specific callback to do SOC specific things during late=
_init stage. Presently post_init is providing that, I don't think that shou=
ld be moved.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, September 12, 2025 1:38 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init() s=
tage

it is more reasonable to move smu post_init() from late_init() to hw_init()=
 stage, beacuse the smu specific hw init should be done before call other i=
p block late_init funcs.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index b140f6fc50f6..f113b1b1b925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -891,12 +891,6 @@ static int smu_late_init(struct amdgpu_ip_block *ip_bl=
ock)
        if (!smu->pm_enabled)
                return 0;

-       ret =3D smu_post_init(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to post smu init!\n");
-               return ret;
-       }
-
        /*
         * Explicitly notify PMFW the power mode the system in. Since
         * the PMFW may boot the ASIC with a different mode.
@@ -1957,6 +1951,12 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_bl=
ock)
                return ret;
        }

+       ret =3D smu_post_init(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to post smu init!\n");
+               return ret;
+       }
+
        adev->pm.dpm_enabled =3D true;

        dev_info(adev->dev, "SMU is initialized successfully!\n");
--
2.34.1




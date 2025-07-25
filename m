Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45811C87FCA
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Jul 2025 09:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7C310E263;
	Sat, 26 Jul 2025 09:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I40X5s/t";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B5610E15D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 08:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlbE3FdCo/xXOo9ngkLLyguZCUDRjSzzu4PGLfumk83MAVfqHdKrQNIafMQEQ5kS/DgvFgxWKxQNswxfp4s2E1coKsrJKXYWwGEjukJZtNGRBzy1Y0zw5/Q9a9igRsS92ukJoB5IBo+VfTiz/rk3FSVqCkkaqoMY2tsAQESXTeC/oO2Le8w2DnC03PH6F3fra1x5VVit7UcIOOheEvSUFAOexlc0hgbR3+/PAT1gMcEjyzmNThyaaL6C+5fucOTUq/9I1I9JKuAFD+GWZknyZII7dLTQ7jvcx7ljWbee/TZ9qDG4UYRgBer/TtoG+kixB33+phFNsdBXDji4HhqrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FDk7S7Y/teD14XrD+VVkGYcAXLZkEFZJGH2XQkMD6s=;
 b=HBbfdHxeAYZCowWN0A7ZopynFJ1SPKr1EyxmTpQzOhSd0tp14RMX5HnbFksycBsCMOnyTzv7xwuDWbX/2eiuq1wFXBqPtzViSN39DAPwRwFl7exMgo/9aBAwPz/gVEkLWWbqWTx+jKiDNhOUGcvfBNC0ql+NYu6GMNz2q4c3RewzlnuuaL11idrehnsnSmGUEKtGcstmaGUgMIZksFquQn5xJjfUxbWWO14Kx38vymj7Id6ftJnHt9JoolIZZvociGepNa36GWwzVGpyCKoblQdxZhWPFgt9c6V1q5dLq8tWZzxKW7Dv55rK/jekBmCVsI/rUyI4G5APRZIURfte+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FDk7S7Y/teD14XrD+VVkGYcAXLZkEFZJGH2XQkMD6s=;
 b=I40X5s/t6pursUug/kXmMVZofpXc2RDiaGw49/XfynNB8H+LaBoX61RNntoQedqOkoYlCjZwufxJ8LZH/Lgl7Lqr5IVTsRYCnZHmkkYaVWvfZ0u+ikqe7ZD7gcDd9+dkgD/wnHsVtmsqLXQbkC2WCpv0hvvDxYmjXg1CZsPVS5I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 08:58:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 08:58:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: brahma_sw_dev <brahma_sw_dev@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add kicker fws loading for gfx12/smu14/psp14
Thread-Topic: [PATCH] drm/amdgpu: add kicker fws loading for gfx12/smu14/psp14
Thread-Index: AQHb7KDtSJpmtK+KvE+NPl/aLYAV0bQhf1WQgCC96FCAAGh5UA==
Date: Fri, 25 Jul 2025 08:58:05 +0000
Message-ID: <BN9PR12MB52578A30A1F66C0AE485A120FC59A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250704050043.5631-1-Frank.Min@amd.com>
 <SN7PR12MB6932C1DC44F417E46ADBB1E7E942A@SN7PR12MB6932.namprd12.prod.outlook.com>
 <PH7PR12MB693439C86AAB18BC5B49B7A3E959A@PH7PR12MB6934.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB693439C86AAB18BC5B49B7A3E959A@PH7PR12MB6934.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-04T06:24:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8277:EE_
x-ms-office365-filtering-correlation-id: 11adbc72-d512-445c-7da9-08ddcb595ed3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?v7mSA1L5/DWLIoxeQZv/tlS5jvrIUlnuPmntGxokrW2BbYDEbEbXP82Gs+/D?=
 =?us-ascii?Q?KJHAiwLBLob7hY+UIUH56G+radkWw6yOVS0t3XBofAsC2t2IYfMj0xs1IRuj?=
 =?us-ascii?Q?GqFgj6l45Ee+StwWGSDRAlF75ciqYwEiJufGpiBYWJ00pfkfEvYgFIUXKJQq?=
 =?us-ascii?Q?4CAEiU4oeGTFFoCOFBAbSa6Y5ymMzGEWpDmMmTcLcf5lNss+MWiU8fXCRgNs?=
 =?us-ascii?Q?5NrZoyoQ278lqy48lVFchUAjEe39NmB8vS4o0XfT2WrJxWEajosLxOJv7p1j?=
 =?us-ascii?Q?upx2BtwvpFU7f290TaLUXkOjXLq2dLrqM45AIB/TG/38lzRQihakshqq6wRf?=
 =?us-ascii?Q?J5A9Gs1IZ2swVIjUVUDRsTynKRepBevwwxkz/IBngun3sFW70rLmx2C/vxnt?=
 =?us-ascii?Q?ISk4Lm71WOXvw2WVLvMCuTFqASAPKcyM5nrTJNuJfpf6TTT1pz3rl9rfN47V?=
 =?us-ascii?Q?K1zIKMO3r2sDoCcoGX/Yek/GS+zhm8YAgjlWdWWQNHbFZa1dc2MZBs/x0Yf+?=
 =?us-ascii?Q?/OmShUDTTprWWFiAyDfOvHmXRpSvQS+NDav8Y0q/QgggO4eyqx4zRkyOoKAr?=
 =?us-ascii?Q?PfiNiqqp8yzr+NpXaXoAymCCQlU5ezXk5k8lr20ZSHRxtG2DGaVKXFgrnN+7?=
 =?us-ascii?Q?w5bT5pCkcf02wLlYFh/y4/vF4uWJD2d6JB3guzYHA2935J5hTsP1QgQp9KYI?=
 =?us-ascii?Q?71G3k7RI0kOsC7Y6bNAkJ6GqDlslOBneWKQARwnLMlLfmSLo224EpgOQKgmm?=
 =?us-ascii?Q?8VgAb2oO0aGmXhxZzjNjTZ6V11lFzcaSrHkUJIAADC33NBdZpww1GafKcBwO?=
 =?us-ascii?Q?V3lVmfBE7vnIQyvin2yanlYjSjRReo8sOiRERNk9ie1ZclAJTMt+37Sv+zCW?=
 =?us-ascii?Q?8b9DdFOm+CTKEYcbadh2RsHsZiXZEmIB91oOb0ffMdAXqnpdGDcANxrzgWWp?=
 =?us-ascii?Q?8FMP+c+UlL9G/7aA621cf0mahWue1DUYUweuMvEgf5PMU+jl9umSPj4UHWDC?=
 =?us-ascii?Q?D3PtQmCK4iJHIHx5+gSvSZhkL0XMNUahhcvA33j3wxSI1hvGm8gucZ8jbWPs?=
 =?us-ascii?Q?O59LQ6uaYvqryIAwXq2wGCPoFkzViMC19ty6Mngc2gdxhsekBI5CqLt1mXL6?=
 =?us-ascii?Q?TLV5piayUpc/8zkFc1iBznvMVan8OvrtCCC73HbTfM1gCWHr/A7K6ucPDR8X?=
 =?us-ascii?Q?I3wXmB/C1oWNwTrkdkgykGkqLRFQYC5KRp+KbpnAFsWnmmp/nVRxPMjQDo9D?=
 =?us-ascii?Q?I4Hwo0stJzRg7TrYM3zJNlRME/xii9zQJN7nXVn2+fSyXLBO36y4UqBNcfhJ?=
 =?us-ascii?Q?FX+OSB8a+h27OEmGim7PuGh8fhjjUp81KeVQfRVIV/Dg3z+vsElC23jip2fA?=
 =?us-ascii?Q?4+qsWzxfW7Y7GetZ8XBiL2VEj4ETINmAZaQP92q1PAAO4ySNLO0hrjor+mvr?=
 =?us-ascii?Q?/1jK0vgDTOXNiu2/TtrSR92tOwl8zF9dWAp0t3PL6e6mtyoTpHFuyw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JSPyXi5GE6aWHDhsM7Ib115ISCYXignRr8UN3p5VujWAgZXJbcKkmUqfmz5a?=
 =?us-ascii?Q?zulgmhosVFX/MHcurSuX+e7hbL+mY5weVRlilf6PV97bgljzFTKmjYxzQ3mH?=
 =?us-ascii?Q?2rv9ASY3EhkB/i4V8K3nWWOmDdqpDZWAg3rBvRFwPRg0nTpLVL5jFCYvPG8C?=
 =?us-ascii?Q?EYUn0IPBQ1aXI0xpKhGKfHRevcB4f08j/Owh9prB4hMB9mUJCogV3E6ox4tB?=
 =?us-ascii?Q?WsWrQ4TA6ameqOZXisN1VS+aS2DgrJO6d9FBOBxJZbFuLJ64sdcd+oeTqzET?=
 =?us-ascii?Q?DGT91h+ItF48bwRs4qTqdmuBPNr8aTffBsVk/X0aKJKIvGxMsRpxhW1Cfcd9?=
 =?us-ascii?Q?Kspvls94JG90Zv5oini2zhjyARSkLC6jy6yqbQyb08iAi4mufO5Wnlwcx6hk?=
 =?us-ascii?Q?NUWk1zyk01CNnq7Q+QfIj4Yhc93da7od06lgn2IgWb4val53IHrBvQXU5J66?=
 =?us-ascii?Q?ia3MpFeW8SyImyP+a73YAPToP5r0zTsr0eR3JYiLDTALHV49u6veO+Lp5tvT?=
 =?us-ascii?Q?2YMqb9L9f+JIoRHvHcZkWz59R3S3D7HwJ3v3LV9viRWzeCwrFEKTjVCZOO/+?=
 =?us-ascii?Q?ICL/vrFdz+XOxLwJMRdjuvQCGtETFqV/pTTSaNJYTXy5od7UotuulzZSNFJ/?=
 =?us-ascii?Q?R9eMlqNap0mbfi7s0FD4wb9cJX2KvZfB1hy/DeykPCxszEfWPpcbn5BS0prO?=
 =?us-ascii?Q?J9ArKaBv0HIZiOEqKuARLrhb5zjksi1/NQO2iTPNKS/3by96YaNkY9V1Qwkz?=
 =?us-ascii?Q?p83sqKU8Bus6MrlGuIg+ssWo2Im/wdOsY293ArYyjtsiETg1TfkBzmwPy9/d?=
 =?us-ascii?Q?A6Z4UXbrjD8ZyxcaCrfLScQ7piFjRlYecHVPp/7rLg3xUavKROmJI76pEn+q?=
 =?us-ascii?Q?ab/8fQ5KeblS5dD9tKkPRTSAvTBXysz+5dnyH6O9GOYd3nQaXgnzVd+vzUip?=
 =?us-ascii?Q?57xgZ55cakzRDIc2MkyfF4UaOyK9eWKMNF0awlNODKl1QcjDxfi8O1MCkTVW?=
 =?us-ascii?Q?aiKuWNY9y/Uh+a+cnRij3roaIylx+ghtBfjHSTzMxqA/SmFppfWKkZhKtQ6L?=
 =?us-ascii?Q?FFb7hZR6nRut2bUVuuWxM+QeLHvnr7Fqtg4bnHIDQCoVExy5wm6lS5gEdz52?=
 =?us-ascii?Q?QecseJ80/OcocPJcCzLyMklOO7i3jJ0gAq1cxVHuLij0bYoRWc3Ob9MhvD6q?=
 =?us-ascii?Q?3AjJQhLpxdMuWRIACH13AtaKOFaFP8bEdPTYzqRPwG8fyaaoBwGSojh47bTp?=
 =?us-ascii?Q?KU1Zf0xfklctDCtz4nMbJHxG1noy5YwwgXcj6U4ZHNm64nHtMpmzKnzMfHp2?=
 =?us-ascii?Q?/Kgwy9crsV+PIp2jfiAN6wM01x2Apg7BKtaWKplqcQ1sOZYjiKqDF5eUPwLp?=
 =?us-ascii?Q?iIh9GzE6DIxOc2uHDxbh4/QRvCssrcyClT1aW2YHgVtYCmbfZxhZxhV8/xag?=
 =?us-ascii?Q?Bufs1rAsJEjfIRZhm+dSSESMACFqRysPx9pjrHOo7/7y1X/YdVv8YLMIncqa?=
 =?us-ascii?Q?RFC2zIzSWrhrRxnzX8OCOs6KgIQEtq5vj028YadhFlG1zKCOLdQ1lZAovaje?=
 =?us-ascii?Q?4AUXSIV8Ayorz+2Ry50=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11adbc72-d512-445c-7da9-08ddcb595ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 08:58:05.9595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KipUsXLXAo1OVCEqHot8bexN5ghf01FluTNN6W1Qi7XEMQOpkyl8OYB39pKwsKwkxJuL7f8G+evf2MIlwTjagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
X-Mailman-Approved-At: Sat, 26 Jul 2025 09:21:28 +0000
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Friday, July 25, 2025 10:25
To: amd-gfx@lists.freedesktop.org
Cc: brahma_sw_dev <brahma_sw_dev@amd.com>; Zhang, Hawking <Hawking.Zhang@am=
d.com>; Gao, Likun <Likun.Gao@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amdgpu: add kicker fws loading for gfx12/smu14/psp14

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

1. Add kicker firmwares loading for gfx12/smu14/psp14

2. Register additional MODULE_FIRMWARE entries for kicker fws
   - gc_12_0_1_rlc_kicker.bin
   - gc_12_0_1_imu_kicker.bin
   - psp_14_0_3_sos_kicker.bin
   - psp_14_0_3_ta_kicker.bin
   - smu_14_0_3_kicker.bin

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         | 14 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c         | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 11 ++++++++---
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index a0b50a8ac9c4..e96f24e9ad57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -32,6 +32,7 @@

 static const struct kicker_device kicker_device_list[] =3D {
        {0x744B, 0x00},
+       {0x7551, 0xC8}
 };

 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_hea=
der *hdr) diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu=
/drm/amd/amdgpu/gfx_v12_0.c
index e4fc42470cf3..de77674df7aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -79,6 +79,7 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_0_1_rlc_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_toc.bin");

 static const struct amdgpu_hwip_reg_entry gc_reg_list_12_0[] =3D { @@ -586=
,7 +587,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *=
adev, const char *

 static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)  {
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err;
        const struct rlc_firmware_header_v2_0 *rlc_hdr;
        uint16_t version_major;
@@ -613,9 +614,14 @@ static int gfx_v12_0_init_microcode(struct amdgpu_devi=
ce *adev)
        amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME_P0_ST=
ACK);

        if (!amdgpu_sriov_vf(adev)) {
-               err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
-                                          AMDGPU_UCODE_REQUIRED,
-                                          "amdgpu/%s_rlc.bin", ucode_prefi=
x);
+               if(amdgpu_is_kicker_fw(adev))
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
+                                                  AMDGPU_UCODE_REQUIRED,
+                                                  "amdgpu/%s_rlc_kicker.bi=
n", ucode_prefix);
+               else
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
+                                                  AMDGPU_UCODE_REQUIRED,
+                                                  "amdgpu/%s_rlc.bin", uco=
de_prefix);
                if (err)
                        goto out;
                rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev->=
gfx.rlc_fw->data; diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/dri=
vers/gpu/drm/amd/amdgpu/imu_v12_0.c
index df898dbb746e..d9a05d1c60ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -34,12 +34,13 @@

 MODULE_FIRMWARE("amdgpu/gc_12_0_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu_kicker.bin");

 #define TRANSFER_RAM_MASK      0x001c0000

 static int imu_v12_0_init_microcode(struct amdgpu_device *adev)  {
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err;
        const struct imu_firmware_header_v1_0 *imu_hdr;
        struct amdgpu_firmware_info *info =3D NULL; @@ -47,8 +48,12 @@ stat=
ic int imu_v12_0_init_microcode(struct amdgpu_device *adev)
        DRM_DEBUG("\n");

        amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(=
ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_=
REQUIRED,
-                                  "amdgpu/%s_imu.bin", ucode_prefix);
+       if (amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu_kicker.bin", ucod=
e_prefix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu.bin", ucode_prefi=
x);
        if (err)
                goto out;

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v14_0.c
index 36ef4a72ad1d..38dfc5c19f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -34,7 +34,9 @@
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_2_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_sos_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_3_ta_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_5_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_5_ta.bin");

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 76c1adda83db..f9b0938c57ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -62,13 +62,14 @@ const int decoded_link_width[8] =3D {0, 1, 2, 4, 8, 12,=
 16, 32};

 MODULE_FIRMWARE("amdgpu/smu_14_0_2.bin");
 MODULE_FIRMWARE("amdgpu/smu_14_0_3.bin");
+MODULE_FIRMWARE("amdgpu/smu_14_0_3_kicker.bin");

 #define ENABLE_IMU_ARG_GFXOFF_ENABLE           1

 int smu_v14_0_init_microcode(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err =3D 0;
        const struct smc_firmware_header_v1_0 *hdr;
        const struct common_firmware_header *header; @@ -79,8 +80,12 @@ int=
 smu_v14_0_init_microcode(struct smu_context *smu)
                return 0;

        amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof=
(ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUI=
RED,
-                                  "amdgpu/%s.bin", ucode_prefix);
+       if (amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s_kicker.bin", ucode_pr=
efix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s.bin", ucode_prefix);
        if (err)
                goto out;

--
2.43.0



Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE91C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 05:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859B888697;
	Mon,  4 Aug 2025 05:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qiIixmvC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3389D10E127
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 05:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMwzfee292ptTquW6nigs9j7Q1yJHaozg3EXc8tHJtr1GUPx++nGyyg2SNtUGLOWSPmotpbBn2FIgS8nhKaVEUjCCUXFwaP5UdC2X0GnjlNqgbxn/Q3852I18Se+JDYUtu3gEaW7iczXUW/966rqXXXYth+WmAFtUzP5jaynTuT36KhUcgCUd3lQDAkpNpmPi355yxOVhVhu7kaZEGHKHGRscop/u087ljSHwCjoVwmxQSfKeF68wPlHCg+0mJuEDaAEcvHN69XYYAFK6b4V7ztnun8+NBiBdO7Ivx7lICxDm8wuzj9kHH+e1+iRjd9XSDWXvRVZrnlJyBZgqFo15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHDvLVMFHrByliyktkJ7TTc+fT+mhaDP4May2btSBuY=;
 b=e2WX0WGDnBST1zJVB9BwIJaUV5RUPoj+4e2Xx3yXwHTJIpBeCFnHfRroljqDVN/d08zpqj/hY3z9McDcEdn2r3GcV6+6NeRuFWPS5a0G75xOhyoWgwoY78KOoK4uGpwEXkr1vM7MmhNikW9OuOGuNFTLXYL+kCbrBkOm8gR4xT/eHqDj96PBYp79evUbYum+JfnsIwgFaRMc/Q4+MC8w9ZAsCHskexvqLZy2hTO9gJ+e5zBc482BML4Jee1vcSax/xxZab9riTPVm6zmVCGDoWE+IuvCVKjIqhHGFDF1IzAxV1jVCrU9twL0mZsphSKdwl5yw3iWwwNsLwoFGkjYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHDvLVMFHrByliyktkJ7TTc+fT+mhaDP4May2btSBuY=;
 b=qiIixmvCaNTNqswadXDeUQKi0FfXCfuWqcSe38uzPKg+GYuNYAfxxkPNkMxSAD3zyIL1lUCKdtfCuMcAsXKDWMbvMGXOxr2mgJmFmzmjkInHtXbxdnuEqJCYIGuanBZFEOEUBXbLBDs5rAhuqL+dU9YaiesRK2yPSK8EYNqQTow=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 05:18:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8989.015; Mon, 4 Aug 2025
 05:18:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Make static table support conditional
Thread-Topic: [PATCH] drm/amd/pm: Make static table support conditional
Thread-Index: AQHcBP3Rava3dPAzD0al0yfFQBqS/7RR8qkA
Date: Mon, 4 Aug 2025 05:18:26 +0000
Message-ID: <PH7PR12MB5997BA960188F8D6914F810C8223A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250804050810.1729100-1-lijo.lazar@amd.com>
In-Reply-To: <20250804050810.1729100-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-04T05:12:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL3PR12MB6377:EE_
x-ms-office365-filtering-correlation-id: 6aa2e892-bcd2-47ff-6c19-08ddd3165767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?A2fFvcLbmR6EfNg360T91NAoAeWG3lhfSROlkjpbXahmTLLqvBVqFbYZmh/m?=
 =?us-ascii?Q?43E8iODdTLkerpMKyvBDonxSFocOjzGtvcvtRaCFEFVHfUVVfR35nc//1lAl?=
 =?us-ascii?Q?a1bZn7/NtWb5ftRfqQ82t00S9s3LNW4Phgz7wEi2d8HvCRyI/8iuNWV583Ax?=
 =?us-ascii?Q?lVYrL1avO0y4pYUQxnkRYhhMkXKyRxNbzW7a7XL6+/syH9gejUqZp4nwfPtA?=
 =?us-ascii?Q?8jb2ZOLoegQVeu4TSCTrS5UJxAhTWLXItNokaA+1J8jK2XYGlZNvvg9xayNv?=
 =?us-ascii?Q?nBQZQRePTwSt9xzmesbru0UZJ0cvVhMocyFh0qE5CYXZqBL08X5xBNoCfBSu?=
 =?us-ascii?Q?UvKFk+J4yAWmloE7zOpiEgJZtn4E9QqQzxmTjPDr7sxykP4ePJRfaDlXd/AP?=
 =?us-ascii?Q?wviCzUq6RBNuPpSkM32YABSfb9paYrf4nyAqfpxU+EVgUrqGAa78uJR+0MR5?=
 =?us-ascii?Q?BsS0PyPnajSEDpOjDZQRyPmAOPmce5eL1V6YS+++tlBB7ePNb++PY0ODKu/H?=
 =?us-ascii?Q?MXHqjlAZHzVdKuDUAPaaydR5Rt7BHhEUcmkd+aNOBAVTxjl502gwridt6HeH?=
 =?us-ascii?Q?WTM5/iCgP5CF/o5Cx31ZZbs4/9jye5mWiopHMxnGUXkRp5Ibn+VJC9zH459N?=
 =?us-ascii?Q?sCrNbopfos8C3c/ojRn6EB76nUx3GZUbAuJggCogR4IDGXP1qViT7uqaDNt8?=
 =?us-ascii?Q?/IZRwPJ3F12Wv/MVh+Lcganmr7EafOLVKyIaDhuATydxtA0YJkijQmPxag4/?=
 =?us-ascii?Q?j3bgCzbrFMpjPgCAn+bBzCFRPmf9FA+I7j17eNUKN35fGe1MCvC07URiuRxm?=
 =?us-ascii?Q?F6wX5qpSZZhzgjXglkLrcufwVZSNb8bAm6A2yf/YWMXmrBEBflKPxxmFDin9?=
 =?us-ascii?Q?cG/98kKhhyml3SX2wcq5GBNnB5TfamtHq+x9+ddIzaa8Tg9/PEsMKjr7EQSl?=
 =?us-ascii?Q?Mr17c/vp74Z7LgbCFqn4rSTZafzTh6DodjUcIawUUSUjxp5IMG3guEm5Xez0?=
 =?us-ascii?Q?Qgs+IyjyDNUBzbXcyhfwpDkKLOHHZV2CYGhb6pfI4lPNOR8td0NqmWd3+F3B?=
 =?us-ascii?Q?caAiRfVneWFIoLKmShJsHoCFaIII+CFx5tLzXyHiCdPIpkyE3PCe5TmpPks9?=
 =?us-ascii?Q?CnZzRqa8Hj06HiE+w57gpk06fetQ8AORff+VflEwUNylpdJKAEUPu9A0iI31?=
 =?us-ascii?Q?ujnzb0GBaT+yxkNyYDfNfUW1HvQNfwa5y2rPn1qZPA4yFZ7yROhyxsiEAuks?=
 =?us-ascii?Q?ii6+yHDJBCg8UTDF6ByGN0QfcVrU3NBjgPisl+6O+/n7T6ii3mFTmz8zsVPu?=
 =?us-ascii?Q?QLBkp8291GnejB9j1il0a0NdU/LpPjFxfbt4kN5j24iKFpliMP+0gQfuNU8Y?=
 =?us-ascii?Q?o4CeB1syvWZrQAlCcph6aWvn4xkfYONrUK5frvaseKlaBCMktR+ZELyDXOOO?=
 =?us-ascii?Q?VF00a9C5kP8sm4XyHx91Ax0ZGFv0VBNvgBM/rGOm/Ubw8mbgWpung2XuCAQp?=
 =?us-ascii?Q?OV77UcOX+boYd/w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k+J5Dg2FmIv/Q5XQDZ2bn8EA9Px4zVRZoPJXLL4190JJUtbkmVe9H9jSR6lm?=
 =?us-ascii?Q?K2c0WCDkQ9aAI2jEjd50sLslOcFgy67jGiRVzuNBJ2dlFyvFvHyfRqqZoJ8G?=
 =?us-ascii?Q?Z37NqI7ZPEGxVmMSK5jzWXJsOtnIIEBJ9TTOC7AEyDRbXrpJQSq71k44DnfG?=
 =?us-ascii?Q?AudsJ+ZVsP45rtdPxCuaYvcWInbQUsSdk8jP+e8HkdDyKXGAAXDVQPu8oJv0?=
 =?us-ascii?Q?P0juMBauu9yyVtW5wmZFZWTAS3gX8nXo6RvxUyKLes1FCpL2+oRx+XiGasMo?=
 =?us-ascii?Q?PZrsoy35xur4a8Nj1pfUckFO2cZUEopVRKPWP4U8DzO5BhCm5C/SS//LBWfZ?=
 =?us-ascii?Q?NjVax1BAI2sVlM5MRHTaMuP9FX8n+nvwKPyNAw16htVw6k5Gs/uFTu26qum3?=
 =?us-ascii?Q?WueU1ZuvysjH2jgf00L8tr74tAUiEqlac01Aqz/G4BMOY+LK97fLmXXwQrf4?=
 =?us-ascii?Q?7L4WJaI4vvoaG3t22JDpu0kUj8Rus9Iq/837DSZYGYiXW1PCgYWJsQOP9Mh4?=
 =?us-ascii?Q?o/QnMJI9qrlMtiTnweRH8Yx44Y3Igv5CQ1sywmLUfKQY+8n5vjxjZG2PAabH?=
 =?us-ascii?Q?fxhbwUPqD2gOUoQd/hk1yLE7Bv+gBGJ+rY1Bf5fT3rKAwY6hYj0pwtnDedFh?=
 =?us-ascii?Q?WwBKfzAubBu44fpPM5fBbAEYB5bFIG3nK/HDpdf2iDW8RYcMxpdwlIiU4jIo?=
 =?us-ascii?Q?yHpEf+Eoh3W0nvjQXX9+bV4ulh1ZaQmx8E34TpsNRyXG0KYiSSc78fTHw82p?=
 =?us-ascii?Q?rdmgVgZUaOInAkrkOOsgLZhUdYRTdm/uqwBa2bpwhsedXUozrhhkUBi/vz+j?=
 =?us-ascii?Q?yimA8kxyO7MveeOWpJX5yq6AOgRVLO2zzjsl6SXqBEB8GK8kZeIoB2e/tOGz?=
 =?us-ascii?Q?Nm4dlf0V8GaJIfza8+O5ZlQejG8cOobjAwCTQA5xfyqq4X5T6bCaguPsqW1b?=
 =?us-ascii?Q?1LeYRtzUTp482LPZfDXEaFWXfZnA72O12dpbYQp/qunJdNzjjil5WyPhB6Q4?=
 =?us-ascii?Q?vzIi9hgXi8do7hV9YWXUIolvRF7SOGpEJV/Sz2cPhvCwsgxCbNvweiSdHT7h?=
 =?us-ascii?Q?ns6EESWXOlEDWGEPsqvPU4zJ/YNjuWEyyyXmJMSpCoTD9ERbq8itCVqYLXLw?=
 =?us-ascii?Q?+22vJaeeqxMKnbrxWwiqxim3fyIsTeDthknthFe1fRQWuOzH+25XnxhfO1Fj?=
 =?us-ascii?Q?5RzOPDke3w84VOFr7apFpav3B6ZFa0mWlDxbMX0hkZHoQiEdA01u/7uJGqCj?=
 =?us-ascii?Q?cFVp8VdCoFdd4RpNRidQjnWfcQQrgdshyjca5U6h3MEIrJ+7uDw04TyY0SAt?=
 =?us-ascii?Q?T+RaeO/zYqqnw6NpvWoOIBY3ZwHZ+IeY/8iLO3eRlegtLZsKM87qPMRXhZuX?=
 =?us-ascii?Q?2q3cBwluwViAPub1k0EugCvS5jboaI7Rr6MStlpJ3tY54ZpD/Arcfs2VaUg5?=
 =?us-ascii?Q?ivUr9u7FSnwXXUlTEL7sWbl28b2c1qTHEJpmmow3iX+n6RAYM6zhFK66krjM?=
 =?us-ascii?Q?cnC04v0Og4HtXTGXfcWo7YtHE9QegTp7rwRd32FO87riNW31ihlb3x604GiU?=
 =?us-ascii?Q?HBIZ+eJtMkJRpmTYOew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa2e892-bcd2-47ff-6c19-08ddd3165767
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 05:18:26.5033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwbmGp9bCp3r8tcDn5Ok/jbpe8r5VTxdRrkIfx9eNKgSoqDpR1tUb+dUj5ePDxhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Btw,
the hex version value is not easy to review and maintain, we'd better add a=
 new helper macro to support version check further, .e.g: SMU_FW_VERSION(a,=
 b, c,d)

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, August 4, 2025 13:08
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Make static table support conditional

Add PMFW version check for static table support on SMU v13.0.6 VFs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ad014b50c300..21cef59dbcce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -402,14 +402,28 @@ static void smu_v13_0_6_init_caps(struct smu_context =
*smu)
                if ((pgm =3D=3D 7 && fw_ver >=3D 0x7550E00) ||
                    (pgm =3D=3D 0 && fw_ver >=3D 0x00557E00))
                        smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS)=
);
-               if ((pgm =3D=3D 0 && fw_ver >=3D 0x00557F01) ||
-                   (pgm =3D=3D 7 && fw_ver >=3D 0x7551000)) {
-                       smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
-                       smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+
+               if (amdgpu_sriov_vf(adev)) {
+                       if ((pgm =3D=3D 0 && fw_ver >=3D 0x00558000) ||
+                           (pgm =3D=3D 7 && fw_ver >=3D 0x7551000)) {
+                               smu_v13_0_6_cap_set(smu,
+                                                   SMU_CAP(STATIC_METRICS)=
);
+                               smu_v13_0_6_cap_set(smu,
+                                                   SMU_CAP(BOARD_VOLTAGE))=
;
+                               smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSI=
ON));
+                       }
+               } else {
+                       if ((pgm =3D=3D 0 && fw_ver >=3D 0x00557F01) ||
+                           (pgm =3D=3D 7 && fw_ver >=3D 0x7551000)) {
+                               smu_v13_0_6_cap_set(smu,
+                                                   SMU_CAP(STATIC_METRICS)=
);
+                               smu_v13_0_6_cap_set(smu,
+                                                   SMU_CAP(BOARD_VOLTAGE))=
;
+                       }
+                       if ((pgm =3D=3D 0 && fw_ver >=3D 0x00558000) ||
+                           (pgm =3D=3D 7 && fw_ver >=3D 0x7551000))
+                               smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSI=
ON));
                }
-               if ((pgm =3D=3D 0 && fw_ver >=3D 0x00558000) ||
-                   (pgm =3D=3D 7 && fw_ver >=3D 0x7551000))
-                       smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
        }
        if (((pgm =3D=3D 7) && (fw_ver >=3D 0x7550700)) ||
            ((pgm =3D=3D 0) && (fw_ver >=3D 0x00557900)) ||
--
2.49.0


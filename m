Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980A8CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9F410FD6E;
	Wed, 14 Oct 2026 12:13:42 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED3210FD68
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1OzmG1gmr9eDAZ8iPdzYHmp6PQ/LgiqMMG2py6CETFWbFiLcPyUcC1VN5hOzOUHowS0WRzC1aQ8FfJC11LfXiA23pa4vH5wkktu1gpXSOEI4fIUkFqj19A2fENMIRDmNQuYmeEE+F8HyE/IezBZT87lL6GO1eZ1u3PzAqIWyfQTV0nExVGwI2PHYjwZyNjD7Fdeu0H32kx31y1QXeFsgmNfP84YhTga8K8h1iaSryXnweHuVpO3gHpnlEJ0/AjSGPh7SUsN9H6s+4hy1FoS51BR7NttWdtRhwaM6BeinWu34J6g/gaDcJxTRLDkW4flJjhGcPlGTNjXsZ/a658rkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60YVRtCAfJdyZUDLDSx4BnnsN4az17aA+CP05IiKoqs=;
 b=pp3jgCab/X0gRC79S/rOOSK/rHRGhAqFlkFTYlW3NeaBV5MEkOsFauoR3wwUOfQFZgTXyiJCfgdHiqsjdwNOI7Mp3FcwN+qPpThP44YX1htqvpnBTdcJyziDYH42mXt6OfBW3vcVu1fzsCIcsD3zkspUbTtOiWV76dlPym5hwFCtfXs/PlgBP3j2VDDzK2bNtyM5rbzltDJngTRZqwUd7hsdZV97805q9xhfB4cmc4hAlCvuKcH8kHLqMiwX3p+X7Gr3ywGn2bBoha7FYBrpYZshtNBrM6/DdU2gKTFcMr4L64Bs4xF3v6mckROgMDJyImbtJkHzv8Jz7K3aTpL7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60YVRtCAfJdyZUDLDSx4BnnsN4az17aA+CP05IiKoqs=;
 b=JZKk9Mf7xNopezqudIiYrZBjGKoOjie82jWsERKBC1prJ/dvcQ4ep9iaxyDw5SVa5DOX90dRce+fJvQES0/mCTv22WGnyYgJeIKPSe/MMLGPXIbbHZ2LRo35BfJlgicRQm3e466OdwpiZC04rjcDSIMj5ykSPaGtHNwZu3xvo8k=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by DS0PR12MB7630.namprd12.prod.outlook.com
 (2603:10b6:8:11d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 12:13:26 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 12:13:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>,
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block
 feature mask
Thread-Topic: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block
 feature mask
Thread-Index: AQHdW9CsqpQ/KrIZ3U++SyrkT7yWeLb88qwg
Date: Wed, 14 Oct 2026 12:13:26 +0000
Message-ID: <BN7PPFFF39339DDE681F375E351C9D0CAF6FC9D2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20261014113858.289753-1-Stanley.Yang@amd.com>
In-Reply-To: <20261014113858.289753-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T12:11:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|DS0PR12MB7630:EE_
x-ms-office365-filtering-correlation-id: 19d7e9a8-0446-4728-4e45-08df29ec8d32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|38070700021|56012099006|22082099003|18002099003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: rOOHeC/pFRWgWTrOuHJoGEaFxXDlOv5blmaun1GIyzyEQIv9ZBPT+6gaPhd7c/sf36iy318BiFxK+k8sVuUERYTg8OeEFTTUOu1BcikP4V2H9sNCloV9jD0kqWvL3qDSvwq293y1uVxldsN1lIWghcJgeDmXb+NVrs80uHckCJ4DVC1jeDiaSxu4bGApT+xsYnDA5qm54hzFDAM25IvRrU9GL2B9a2HOf5zG21HQmtdtvi3sjg7V1j3oL7Zzba14ibEMPYW+kzD8wJXXO0YuSImfSzaMMRFNUHXqnW1DcxmFbxmIy4vBP27SMJsIrLVOz2UsEr3q8IyolrCTEkgTFGBcTshJxoS0CR514D5/Kmv1/SbhBwlz4AyIGoqJAfrgjt4u4lHp23E/SNSBuhCr86gJhRrG0KlYTAe/fjPqIujLNZCG77iwJdLrtp4JyBrgVOe495APnC9zyTEwfUrqlsPAg4gRIvf/5irvvJI8qsLEsicl9RP2tNr9pb6sdeGDEV3JQB0RcvDGQYsf1GOAMy8kF7gV7V/In/SsXc+HhWZ+NEpk7USqTmYYgKsgYbtGFMnuEu0AFIQ/INBQvMbvgNJEV3uZD6NgJ0yLv35yZDW7Ojb+9QWo00n3MY28fKvsCWtkd03nPi/tRuppXHtqZbk2H1MQmJ2cW5/AAFYLJKuEnwpofxTtDrzBBvw3HBrpTuasXSGtAHnW+8Jea+W/YKmn7QNc5q+rmBrQUHV/Crw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(38070700021)(56012099006)(22082099003)(18002099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8G8ivmJs7jeJ01DSTZjYMmPHnrH9WRoB04uDCIG/69mGMyEWAhRczVYzexKF?=
 =?us-ascii?Q?avN8kBQII19ZLWnn/VPyKODTZTihsqcN2xLqxS7MXCB4JsLkbBTl/JY1jAGH?=
 =?us-ascii?Q?cPOseZnXKz6qzlyapQID/IPsGIowmQQSCO10pxBpjsRqs4biMIStuNR2HXqy?=
 =?us-ascii?Q?EN0l8/VbvOdqOmRicFQK8xzqlc5FvUUfNimR516QhDpYs2yo0eXLz60RUlgh?=
 =?us-ascii?Q?vmvxzl/IV6g++9T0uANhhy5uvoZaYL3W2ZaRZ/A4Ndq67YyKLWDmbMIeKwt6?=
 =?us-ascii?Q?cF4PRZOyiUzr62KDek3ZrH5HsNGHxygNJWJkivwh0lPv/LYaLJK7AcMtaFEs?=
 =?us-ascii?Q?+S4TfUwOJyjDCndKI/eIcRu8p5xj83AU3zU9locs3bmiaCg38Awe1nnMZSi4?=
 =?us-ascii?Q?FB9T+i70ZBIbtADUaU/f0nNPY+F0HYIB7NE0gCxNlxSdH1ruNJvWGKYe2E05?=
 =?us-ascii?Q?Y1b5te22/Uah0Mmpwhq9LAO0AOHVzYiVGUb/Vq1TQBofoUqpB/1CONaFbU7k?=
 =?us-ascii?Q?4bS/QX2bG3vrVqujYA2GGUIS8S6uO8lz/WLpr9C7w4VMg1vw9YyPCg7CVC0Y?=
 =?us-ascii?Q?dRD7PT+goa0hLHcWZnrm+BJnJWPUr3B1NQWeO9jdLO8mW5mv2I18WVriKbd7?=
 =?us-ascii?Q?dHYVAtMfiu31BS17PaL1tLJ/xxF+wviPgK7YcLOB0LZye8TsUDYmYLJ2O9Be?=
 =?us-ascii?Q?/VQ99LHAppUUUsaH3IcdGOcIQC7sgU9ILaaOY1Z77XJ9Rzh+pz9YUNK9fmiC?=
 =?us-ascii?Q?1Xxjhz50hkUQLG7yrKYIwFunLZwcz2Aqt8BsvfhflqVemwc+IYHvzEVEKU3w?=
 =?us-ascii?Q?xR88W29Vwu/BeBq6OoWtVBqQ7hDpeinpZWr5OkXALzSf1ETbTQaK7HDXDgpc?=
 =?us-ascii?Q?D450UYhi+Xr/aXEqFl6p0tdr2SnXNHWqeR3c9ms0Hk7BqD/eUyMXYYSOY1gR?=
 =?us-ascii?Q?xLKDs1PbZrM0nB81VLkJtAwgAttYh5hV8/8v1MHRq0HUvkjx6Wr+d4w7+1QL?=
 =?us-ascii?Q?pbmW/NN+EwkhJJq1STLO0N3fN8fo0Mh7hjh6KgS+6jotV4fJLYFrSyMEJamG?=
 =?us-ascii?Q?QuDxy6HD8Ks0Ldc4aJm1Qzd6tYa/zIIusquW1mJtVeKINLUZ9TRLE1mCaws0?=
 =?us-ascii?Q?lUdSRYT0EE9qUDZMbc0Pr4RcKyEWhJ6J0UW7Z1IsUZ+uBvh9x2urwlJLWDJy?=
 =?us-ascii?Q?sHAEi1gFUg7TidUxhONGrqee2LM516D4dbrtRdBf2cAwrG3NDqF5dtTkZhqb?=
 =?us-ascii?Q?ZPgRX3zuG9MXOCbSWhoKiUrT1fZY3krcq1hn23xU+1S8fzRaF4c/EEQCILM7?=
 =?us-ascii?Q?xj+2Tyy9B3IODYMszx3ZWmCslIYpNuaZBCLfcZlSkVUn44svzXYqRgiXB94y?=
 =?us-ascii?Q?UHzZTRchtJ9zwEihJMb/61Ln+EwfoA1fXYnhPPGvkKlQ2lxmuRUuGoWpPF0y?=
 =?us-ascii?Q?ONyggRyU4eSU9KxyyFWcwUBV+7w9BsP4d87DpYDfDP4tqblpbYtcVdEQ0Yhz?=
 =?us-ascii?Q?WTpdpof428n0NBoz4DwiSIF0J8uLHakAvd3ZvsWyvWRhkEJDXYpjeZszB/t5?=
 =?us-ascii?Q?LU/eaHEpVSjVz8W+dTihec4rV3lCpO2ntQmpU1BSsaSw3uMZLJEftos7IF/A?=
 =?us-ascii?Q?b3p/6aw4BKskPqeiySxNTW/wtKnUkzatgcNnyngH/Ya2NOCRq4XOofjbvBuA?=
 =?us-ascii?Q?elvXEhlk/6vdgTFNTmT9VSlOUUOyHyTP7IeRmZOafxjRPB2g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d7e9a8-0446-4728-4e45-08df29ec8d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 12:13:26.7481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNv1j4lDhokyUetdLrI/GQWBWsIriavnHQoa81ZHYSVCh+lZ2XBUg64d98lJqnUvrcX0jPZOAFQDcNjRSrn9Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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

AMD General

In this case, we should check the is_app_apu flag explicitly rather than ch=
ecking AMD_IS_APU.

Regards,
Hawking

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Wednesday, October 14, 2026 7:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Liu,=
 Xiang(Dean) <Xiang.Liu@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; Xie, =
Patrick <Gangliang.Xie@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block feature=
 mask

the register c2pmsg_127 design only applies to dGPU not APU platform, so ha=
rd code ras block feature mask on APU platform.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h    |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c b/drivers/gpu/drm=
/amd/ras/core/ras_psp_v13_0.c
index 49ba57f58878c..fe971cf19e493 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
@@ -80,13 +80,23 @@ static int ras_psp_v13_0_get_ras_block_maps(struct ras_=
core_context *ras_core,  static int ras_psp_v13_0_get_ras_hw_caps(struct ra=
s_core_context *ras_core,
                                struct ras_hw_caps *ras_cap)
 {
-       uint32_t ras_hw_cap, bit;
+       uint32_t ras_hw_cap =3D 0, bit;
        uint32_t i;

        if (!ras_cap)
                return -EINVAL;

-       ras_hw_cap =3D RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMP0_S=
MN_C2PMSG_127);
+       /*
+        * driver only manages a few IP block RAS fearure
+        * when GPU is connected CPU through XGMI
+        */
+       if (RAS_DEV_GET_DEVICE_FLAGS(ras_core->dev) & AMD_IS_APU) {
+               ras_hw_cap |=3D (1 << AMDGPU_RAS_BLOCK__GFX |
+                                          1 << AMDGPU_RAS_BLOCK__SDMA |
+                                          1 << AMDGPU_RAS_BLOCK__MMHUB);
+       } else {
+               ras_hw_cap =3D RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, =
regMP0_SMN_C2PMSG_127);
+       }

        ras_cap->poison_supported =3D true;
        ras_cap->flex_mca_enabled =3D false;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/am=
d/ras/ras_mgr/ras_sys.h
index de3da5571ef82..fada8b1b41453 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -107,6 +107,12 @@
                adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) : m=
ask); \
 })

+#define RAS_DEV_GET_DEVICE_FLAGS(dev) \ ({ \
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
+       adev->flags; \
+})
+
 static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *roo=
t, void *iter)  {
        return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->in=
dex);
--
2.43.0


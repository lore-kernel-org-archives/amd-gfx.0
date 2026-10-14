Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F96CC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 13:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADD410F3F2;
	Wed, 14 Oct 2026 13:31:40 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D6B10E0CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 13:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuW0Hm+gLlOVr6fknUeRMbjGubMUhPntRkiNVabNv/t+JXxCYLfexp4FxQ4SO/wCKLVzaDlVtUGma5mE/OjYMsFhkP/9p52G8iFCICQRZqxI8+PgtwPoLYkN4Y1C8SLqwyjsVhSlW28r8K476Di6oh2cvghyN0f54Ee2xmhr92Ys7CglRD70zT411Ge2rLm+Uiyd6ixXGF93uZWswhlLgYotEkaL5u4+hK2Om2U/qGi0a+MvMXpUEI05gnREJ8+TSR779QDUYAlF+p/Pd3jBs6zxKujCZM+CTjgPKLRhujJdF7mw3cxQv6I9dk9mPPU1/H4gWGLCe7ub2W058SEO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcgQ4MCTkFWzbbZ77Pu3+B9hOToqSjVPdLkBvQ2tzVk=;
 b=Go1WqY1t/Y6qYyZN4VvVPrJLACRDQVe2/VQ//G4Z19iC8edjj2A9PDNX7ggJOlRxyJTlnSy+tqeiIsTLFKlhr1mTDKZ5rtKwPdafNba5fz4/+KoIe9lepIktMUMw44ESnkgioSQNMTn7A1n9mQ63eMATW4S2bYArMwQ30UOI1sPp2WyJNIsSKXtn6AuBkUp2gFOl/1e06LydTE6gZueovLRvt4k97B1C8c6ixqAAdtbbcYUoiSJnRbcqDXWOWSImuXgHJ2nty5TGFhX8jDr4of8RwEEnAvzDr2hkMZoqroX92xftAyEXpI8IlTWIShIt64mwWOBdebmhvo4WBEOI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcgQ4MCTkFWzbbZ77Pu3+B9hOToqSjVPdLkBvQ2tzVk=;
 b=ASxOOcQxkyHO2zjK25VZxQG2+9XEeNyEay/kFNNOSes+TMuQPeBsbWM460U2/QU9iKKkh17WphsuWjs6u+r6PQ2caiZPEyLvGt7VjGqjOB3e18V7x8bvR1sHH+whxQ0gZkOIzGVyJBcFLLzvA/bWoLQe1BC6qBuqvbWzUk7nrsc=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by CY5PR12MB6106.namprd12.prod.outlook.com
 (2603:10b6:930:29::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 14 Oct
 2026 13:31:28 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 13:31:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>,
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH Review v2 1/1] drm/amd/ras: Fix APU platform ras block
 feature mask
Thread-Topic: [PATCH Review v2 1/1] drm/amd/ras: Fix APU platform ras block
 feature mask
Thread-Index: AQHdW9tOLDSC+3GRikC45KJweA2HwLb9CL0A
Date: Wed, 14 Oct 2026 13:31:27 +0000
Message-ID: <BN7PPFFF39339DD7267682025A6CB8EE5BCFC9D2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20261014125358.320557-1-Stanley.Yang@amd.com>
In-Reply-To: <20261014125358.320557-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T13:30:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|CY5PR12MB6106:EE_
x-ms-office365-filtering-correlation-id: ffd99608-7e1b-4b6c-c2fb-08df29f77358
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261009223027099003|22082099003|18002099003|38070700021|56012099006|10067099003|11063799006;
x-microsoft-antispam-message-info: wEC4nAbipf31fSkqh0FqgweFXw9NKK4sjhIh5J9SQz96uAlKmOW8ei9eaPlIzv6TVy7fInNm1UUaKUJtg2iyiUcDt5i/77YkDK7UNNEX9dXOnczgSPBuL8c59V3Rau3E11Gjb9R/1ky/W46aWLrOuiUo7p5AEL1Jq7ukkcR92rLlaI6f6YZDYcHPVvuNyM+PtL4+zakHsdRnMs6jyqY2h0z5/FLDguabSilwOhhhsHbsduHqbdnJLdRyLJ1CQmsLJVGILo2jtqi2DRTXQTUTSP4e8kvadfaIA6RRQ7e1v/L0vEB8el3JXkt/100cHIEiThsDHjj/hA7/QeeQCEVdHcKfywhTFE0yuSQrTCvDG5pktwdNkK8H5nCSd1lmNdCKy8ubTibSEisQWE/XgF+sv5cHsCYzTtSAnqfEM5lbeu3pkYsou2RF/PpYNHzoj/CQ4xYJTeU0rHxV9+zZd6bnCeS02mAX71pHAr20MbpvASuWvOa9z+Prtj9rekOt4XdBkhp0qtyZf+nY84T/YIYN1qCYXD+FQAaoPQcDILTylIq0X6jrS8NNTmeVVIf6fgKdlxBvFfYpnK7BBfWChyNhoVESIz9cwT3OjGcWqXyc7zXN4S5OV3VLURBSYwS0GPKgxKYyGKjzDaUaPjk1R8KTsxUg5JHJha7zNOYAg/E5sdpN92stY67iq8g4qa9sAF9q2S4yvqqYorUcqmosZT2E4HPOOY3uYXVYNPGDPv1ZjFU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261009223027099003)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A8tQh6mddcEwLTqkO/nUvbOQT96SyuU+VP9YkIjyjxl254Q88NF6InOXFdsl?=
 =?us-ascii?Q?h5Hldw6m0GO9nlq7wVVsGQ5hg6vAGiMikw7gc19YD3Gwma0L2y86jhDesYv/?=
 =?us-ascii?Q?jANAqw7hGROWgkrKBGkqD82o54M0gHTtDMexkwgErMJaNs1u+0TEuVwkpgxD?=
 =?us-ascii?Q?7r0j5gEZLqnjQE0Z6Ws7ucPbUTOcAQv9Kz13kuIFfc8PRlaU/19yWjIJoHNa?=
 =?us-ascii?Q?UChWE/kk9V/foioUG5WACcJUJnddS0WT/x3tJlZBIjxOO7V+9AzLAIrhxdAS?=
 =?us-ascii?Q?pno9DG3AMfv8bqpuAJOwEG2WXAUvGW3Q9AJgFUtXO0GnrB/7L8+l1QPcMLGO?=
 =?us-ascii?Q?nXgifR9mjKeoYW31o/R1hZp+C49DZNouG0K9DJV47/ppM836AD/U/0bS0J2s?=
 =?us-ascii?Q?zTdrBNiNgM27r66JuqLnlg5A3MHQBPdnY5QRGSpwPgNHBUKi3WKm/XW3vnwS?=
 =?us-ascii?Q?Ub0UsfXXihk/7Cj6qql1gCmVXxCurdLzKttOlh265dW/rz+LFQywkaWDgIYS?=
 =?us-ascii?Q?4l74YDuCLpSOWUir5Fs/00yrkmo9dhAhY7/nDH0bfjwTtKYVb3dN63oHYfOk?=
 =?us-ascii?Q?JsJJGApSIEHMcIZ5JKOj1kOCkRSAugzf1RysmCAA/PK8GjZs0q4jyXeBLiGV?=
 =?us-ascii?Q?Ucu7AWBvU5yy7jeN9TZAFZUfr+aRflCE3alb3Qvb04Hn7aYRZNZ3iwwKrDan?=
 =?us-ascii?Q?7kvZKudn7xAQc1qq/7KeVNMLnTP6sZ2wBBbVgObCNl0SPuOafiLXR7RRXXc6?=
 =?us-ascii?Q?17cdToEL8aUPG8Dvik4F3Cv8NFM0jOmoV8hbH7jiDbYhxt0SxFaRF2DGz9nq?=
 =?us-ascii?Q?LkyTN+lUkmsT60HS89CPk6e8fMqZBoUyT/N9fPkLCwj2DhSWDEKDvieIV5TU?=
 =?us-ascii?Q?LIdmdyk6jSRrAxoKyb3aM7YKo/Y1oWRRX2hED0Xbr02Qi9xygTdAPvUaxFHE?=
 =?us-ascii?Q?C80GgQIH/AMd6OWL029mAbHnfB+H2Uatfr9KHnjroDSK0djl8GHFWsBhCaEm?=
 =?us-ascii?Q?cGACfA8P8nfYBs4aUEJBVOQCMUmm89mPlAV8HabXMVOYUlkpC2J9YjoPf1ap?=
 =?us-ascii?Q?VqVUrkcsYSodw8Vi6PIPnojxkf/2wRA+ULFKlZuJ8pgbLI6/OUyHo+WuawAi?=
 =?us-ascii?Q?R9ok11plYACx/Bzl8N6F4G4YdmFCzSO5NCHl55ujYYzk4UEBAIDmBcSxHqlS?=
 =?us-ascii?Q?Nf+5EQqrcd4wb3uxCp3zE/lYkJ5U+8T6rSYhyrTYUkf3tMU3rmYzqaCrYqSg?=
 =?us-ascii?Q?80Ck2G9D4WvaVopuuvdVXFhw7saWZEnLEgw59uEhQZ+cLYtqRdGtv0kBe/Ed?=
 =?us-ascii?Q?vKhJZFlbSHvZZTCKfW2N0+XLoSqjUOgoURUUKSWUWoxblNJUStlT9L+8o3Bc?=
 =?us-ascii?Q?OkOygyUg68OhWYKqOm0gZyqZOwz2kgViPmDi+uscv4Ybv8+tz7Mj0Fh6y5Dx?=
 =?us-ascii?Q?Q6az4kLb3q2Zh3ODkizyQq43aDU1SRs0wrHN5GfR99cqILzfE5+3FPgNLJrV?=
 =?us-ascii?Q?Gg0Mhi59n1Bt54aRyZHcv20CTGrI4D743vEsP6Zv7MeMDVcRNPG0zKdHSDSN?=
 =?us-ascii?Q?MWS5MioWt4uYicfKVpW1GCgdtqZvJJY/mPmUd6PfPuldB2buZwoPVW+UeG/4?=
 =?us-ascii?Q?mJMmeoy8JSU65HOMqqvFkvHBuhwTFCkN4t5uxBpxrK43ZMoQK1ArRpv77s77?=
 =?us-ascii?Q?H73dstWrUTkvqfQA3l98UCpTmM4mBqzN93qOcP7DBY+MFaJk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd99608-7e1b-4b6c-c2fb-08df29f77358
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 13:31:27.8237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XncSEz96ndNNKPX9Y25PTog/5ivXDFUPFyNjCziKvfWksg+UoOB/3k2PDdJuWkc0xE1KlnkGSldLJHWE7sTr6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Wednesday, October 14, 2026 8:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Liu,=
 Xiang(Dean) <Xiang.Liu@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; Xie, =
Patrick <Gangliang.Xie@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review v2 1/1] drm/amd/ras: Fix APU platform ras block feat=
ure mask

the register c2pmsg_127 design only applies to dGPU not APU platform, so ha=
rd code ras block feature mask on APU platform.

Changed from v1:
        replace AMD_IS_APU with is_app_apu for judgment

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h    |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c b/drivers/gpu/drm=
/amd/ras/core/ras_psp_v13_0.c
index 49ba57f58878..bdd3da2c66f3 100644
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
+       if (RAS_DEV_IS_APP_APU(ras_core->dev)) {
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
index 1c5e02de7fca..00ff12ccb01a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -106,6 +106,12 @@
        amdgpu_ip_map_logical_to_dev_mask(&adev->ip_map, ip##_HWIP, mask); =
\
 })

+#define RAS_DEV_IS_APP_APU(dev) \
+({ \
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
+       adev->gmc.is_app_apu; \
+})
+
 static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *roo=
t, void *iter)  {
        return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->in=
dex);
--
2.43.0


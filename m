Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E266CCF9E7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 17:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E503410E845;
	Wed, 25 Sep 2024 17:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jFatx0gk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C2710E845
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 17:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeOzs7OHcbDyTBHHQSkoPKw9bnTrudx/aHOzCQpScUC2HYHidM19mtYns5dbueSOrAY4ZlDbSBUjWHS/mthWez+dPRwu895b+J3GoOQoSF195d3SafP4+pTct0s4blvWV4er1kHpTY1ztGSBepSioLoymYnVV+GHlPcJ/vRVEvjBfSXC2m41CoQAbck3qSGnHRywGnENfpzGaGxlwE/fbxLr/HbeD/IOZImg8hz9OwOA+qOo1gxbf+QJB1UTaKUJmcSG2Z18ZhTqchHjs/Jd951Po55EB+AWKjdBfW0dw3fC0kOEl82Ad6cvSQe6IhQQQisYaU3mN5IP1IUA2Oysug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn9J96pYkTSARjE999oc0iENHK1AT1NeOzSWtUpCLjs=;
 b=My+BUC/uOV8urTG4xMP0vd5GnHZY/GdOwdv/Q38mjYeCKEyoAMcGIHTdfOAsdvg8ZvBAfjndmXXiiQlnjDSAlQL4JZxFXVdXhQwuJEZNZiH0EUqX6eV1OKQJPG7YkjbVH7hQACu9unJGbD7GVuzeRXrApcROietCWaI/rzwgzK8X5Jpb0i8+VSu2NGdqIc2tRlom0pzYNDyjnP6TvhjWsdhoPB4N+RzopKQbTCwO8OrDXl7J7BE7Qi4BYZ3Mnq8qKTBZpO0QZxgVmelccYFe0j0DuAAVsSnBuR7DPfphZzvUKTgzCrTaaiL/+Dr0N0OhXEVeMF/8kGb5x/JESnzgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn9J96pYkTSARjE999oc0iENHK1AT1NeOzSWtUpCLjs=;
 b=jFatx0gkOfsRFF2WkGKX1MPl0nHZyb/V0Wk1QyGsFINLx6DRY5w+5JrcAnvgHoW61CBO2eXoi/QZ/4UpiLvvphQyjT6uLX6xoDd1CARz9z22/4H3xcNa4/CqMwPSiSz1Ltco64j3lA8VSP7+488CZoXHJ9V4bmreKYHsvJa09z4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 17:57:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 17:57:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
CC: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Du, Bin" <Bin.Du@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: init saw registers for mmhub v1.0
Thread-Topic: [PATCH 2/2] drm/amdgpu: init saw registers for mmhub v1.0
Thread-Index: AQHbDvi4jia1DOrjyUmYEz+4Iq+7qbJoyskf
Date: Wed, 25 Sep 2024 17:57:40 +0000
Message-ID: <BL1PR12MB5144E7EF8E7F67F4D5F74217F7692@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240925030951.603486-1-lingshan.zhu@amd.com>
 <20240925030951.603486-3-lingshan.zhu@amd.com>
In-Reply-To: <20240925030951.603486-3-lingshan.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-25T17:57:40.512Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM6PR12MB4204:EE_
x-ms-office365-filtering-correlation-id: 650b8de2-d0d5-433d-c97d-08dcdd8b8c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?z8JkxXCmWMYsVJJL75WeAG+F/K4yfJSWPhh+ZgtqSpua8MZlTkqfpxaMa6wW?=
 =?us-ascii?Q?d0jz99obdM2nqOEpGoWaP0vp+2s0uMa5yuV3c+eRTpPSGpRjef7+nikBEy8t?=
 =?us-ascii?Q?wLwrSOthKJKBvwXRLES3RW/urWQPEg5aN+p6Q07MH8RBt/m0tVufeUSnxw4b?=
 =?us-ascii?Q?1Q08wKQRcIV7geq15SVFH18fVb7tUDgDXsMtHzYcH2wCn1DQNsq+VsZvxGyI?=
 =?us-ascii?Q?RwMAI4EGAm3kOXatw4zl1vqnh9sTPuMdBoB9AgZhwswMHZLnbnIrzat74EsO?=
 =?us-ascii?Q?GcdFsqqdnIzXshM+nakUtJnTFphqTCjKcOnsI/0/GOgxzCj9OclrZhIAVHie?=
 =?us-ascii?Q?IXQlRx7mQl3XetnPpZ84UJq8eZd6ADrYWCfGw1HDev5bELeaHkxm9TaPIXUL?=
 =?us-ascii?Q?qPdv8rRaR5GYadp6oxoWuJ9uqTkFkPrcJ01+o/3VqmKQumCeRh8H934r0hoj?=
 =?us-ascii?Q?AxGIwZaBs/o+rYhouFj/rLk+uiROZqRAG5EPy5+5cB7X0FlJWTs/PucFqFNK?=
 =?us-ascii?Q?5PsU4Sewp5zs8TfN59xPQ16uGb6uWbbnHZQQirT8qoZLLZjS7ulFkTY+N4f3?=
 =?us-ascii?Q?SfuffYrVLbB0m6nK5++A+60nSuModol5PjSKsHZl9PKKC9X7Nvp8G2feHCWo?=
 =?us-ascii?Q?r/hi8BenjcUfQ7mxsYFXtp9He0TeVrFdJcDzJgQ1oaVaLPphQZRdSRpIo2MH?=
 =?us-ascii?Q?Glj6J5WbUcI7+g2iQ81Fw4RlJAZksM3PTYxv1ZCEemMJUO4Or8HcPvYbT124?=
 =?us-ascii?Q?Rg3LpgBCWSLAkpYbzs5IeLj8iVUw4XxFT0MHXUM9BwLstidfUfEzLXP0RGUG?=
 =?us-ascii?Q?1t/s+rumeCoMTy3gQu5gTV2m9UV5z3up4dEuQhTRfhvMfT1xD7DfXnGPC9W2?=
 =?us-ascii?Q?BkJIT24uU+odeezOdn0BBy49P1L02SFC/K0Oe8bs5RZoYqnHZgoc3jvVwcx9?=
 =?us-ascii?Q?aO/wXfgH9stw3gRoSvaHPvAp1k2aHn5nS282JoGF2SN7rR2b89iLb2daP5jc?=
 =?us-ascii?Q?7XWYHiy849HMI+7z6FDON6gMd5Xi49SZKLOYrVrVafKZFSSaNTd5XRd6eRBD?=
 =?us-ascii?Q?jZkwxS6BrnCo3o2fBtNO42Ycou90rO3eLfU0+XIJ0Jc7P0S6h3MPnIn5GHh/?=
 =?us-ascii?Q?rllL0iNypv1IIqPodl0HWR3O/V7HofSLYlPZh+lJNHNnEVc0UoIrRQOKKOzz?=
 =?us-ascii?Q?a+P3TlLmfJ3xjnSKXFc9g+JDkMU8Dlosk4cZiRpDlKHQZki2HtmH4D7QNIYs?=
 =?us-ascii?Q?muDOGyv8i1NRnbysuY8WK9tKT2bInAEbQ+x2XX/fxd7Qm0eaZoEYUXbXBdL4?=
 =?us-ascii?Q?w7gRGWfP8bL0fUQDxK4iRDF4Rx/l+W3E4053KWB3VQ6vkPTIMMwa9AFXkzLH?=
 =?us-ascii?Q?J6bs7n30h7P7r81sDyUt+j0ZBJYmL+Tw8jDsAnB7X5KxgAdK0Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rotUTUxzcruYz7/M5FMIXNc+aA4EDXcPNKCgX5liF/1uFB4bY1E0ELRYGpDk?=
 =?us-ascii?Q?vfrsU3DyoHfdD2OppkEfU9YfV4I68/wPX0YmGudmdfl4DbP4moLFf+NgYo8S?=
 =?us-ascii?Q?NZJQ2MmhB5sI4eVg/lyHSV/ULFZZff36soZZv2XN4XMgMmKJjV4O0s6n0LSn?=
 =?us-ascii?Q?PO3RWsm2JsD4oVrMNBMTPTkysFKSl4kMsErWFZ2AVZwxK0itcuCW6rLHwkJT?=
 =?us-ascii?Q?MDpIk1HmJGSL+hFuTZyr8913MJrCJwFaIiAxf6wxjbbwGcwCnjuhG5jE46Xw?=
 =?us-ascii?Q?hSiQ4Pr0z4/taSqP/sbq60pTL9pRzGc0XHR09GLj9y/nzlJJUqwKa77ne2Mh?=
 =?us-ascii?Q?eSrKsha9iz6uyNhETK5TUtqBci4YLTwVKxIQlK0X8v6ipxfmUIXS5osB13f0?=
 =?us-ascii?Q?Rz3biw5Tyb9RYLbEZYbRfxhrU9ouB8yV9FDvHGdYJWXFDVgPZ9k3V0EUibsd?=
 =?us-ascii?Q?0UinE0vVMLqnzgDawUS5AN+MLzhdiJBOoJgxmzh6TKQTbA4Rmx3UiNYdkXQz?=
 =?us-ascii?Q?/QbyIg8P51BuPJl0/TfFndAw3OyBA4n143kLW3PmpclrlreLS+VAvtdL/pRm?=
 =?us-ascii?Q?4pFM3m7yx+7F4HRb/XMiZa97ZsfbkF/GpYAYYqek+gET9cZ6hCHc3snRRbUj?=
 =?us-ascii?Q?wAqgyHRdt2EXUhnQvs1olW4DmZA0kD0GdRB6K6O9Dzpo0V+JUat/2SvwZFci?=
 =?us-ascii?Q?Yp97NORzRyykqbDD4D/brjZNfejmr8YYh4bFw66yALzcewMwlcmQSO886W3h?=
 =?us-ascii?Q?GPLHlIYZHXZP6F6MYhX6Cd3wi8Aw8qEbHzg67r9ggh9/hkvrWI8pZWnfGtDL?=
 =?us-ascii?Q?fL9VOJw8VTE67jCywtS2kGFwlltwqsq88oCAPZAS/zF0WWpKQs4qnTREVfUD?=
 =?us-ascii?Q?XR1vD9KCYmufVDwSjJPRN5rE6dCWp/5QFIwPSZxEolBVUdgMwEm2K6wv5VLy?=
 =?us-ascii?Q?dHZm1CrqLQGlE9yqy8LSY2ybisLFjj7HKGgQK3dZXsTGK9EEyfso/CE7MpEV?=
 =?us-ascii?Q?ORZ8TR4XFSmbSbvy2Vxia9kLRdttvHFy/uGfAxxmSWk79jEuPjfVJ4YAY856?=
 =?us-ascii?Q?Y/T1kSFTl6/vXRB20YNfWD1+mKwHE3WE0Sa0Y1xZKSVJP90d7QasTaIYE0tK?=
 =?us-ascii?Q?YyUR0fXRP27D7CsDohpDBOrsbHwoKwhrRuZ3ptlPqtZUgmCgwbKMPYps8FEg?=
 =?us-ascii?Q?dbIMoNYuwZmKnj1IO4xftwSxmmhxOSooQSlvFlJf4YJHvknARVO6tG6GfCa1?=
 =?us-ascii?Q?SjUV8G0k4Upo1nbNMyRft8NmFIUPhuNmtQHPM6o0aXOsMNENK0982FpUihqF?=
 =?us-ascii?Q?xNkBL2POnxOZmavZu6N3mwUvwaCp5fYA+gfTKva7U8fdselg11BsmuCpvlm5?=
 =?us-ascii?Q?pYAnG877jl2KVfxniJ+OZjUqmF0PChH8n70JgYjrpZJJNEV4Jw+x1YxCSBxK?=
 =?us-ascii?Q?jWzCTQnVueJQGVpY2cOGw59XJStT/iILA0NKj99hrxKiDMIPhrRgXmCjqp9Y?=
 =?us-ascii?Q?ZCd/q4POupNgqnbL6z/izRShqNEivoJ90VgyLp09IC2XCuTsUa7AZvFHAiFn?=
 =?us-ascii?Q?U2mhrY0krFZz6y9/9NM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E7EF8E7F67F4D5F74217F7692BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650b8de2-d0d5-433d-c97d-08dcdd8b8c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 17:57:40.8087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4Gxw35RTjO58G2UAU1xFE0D0Wx4cKiStUi+W8ZDopDheW8HpeS3Np4peVf/u3steF0xTyM/umfHOdSaXo2PcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

--_000_BL1PR12MB5144E7EF8E7F67F4D5F74217F7692BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
Sent: Tuesday, September 24, 2024 11:09 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>; Zhu, Lingshan <Lingshan.Zhu@amd.com>; Du, Bin <Bin.=
Du@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: init saw registers for mmhub v1.0

This commits init registers in the Stand Along Walker
for mmhub v1.0, to support ISP use cases.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reported-and-Tested-by: Du Bin <bin.du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       | 49 +++++++++++++++++++
 .../include/asic_reg/mmhub/mmhub_1_0_offset.h | 23 +++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c
index e3ddd22aa172..e9a6f33ca710 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -229,6 +229,52 @@ static void mmhub_v1_0_disable_identity_aperture(struc=
t amdgpu_device *adev)
                      0);
 }

+static void mmhub_v1_0_init_saw(struct amdgpu_device *adev)
+{
+       uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
+       uint32_t tmp;
+
+       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32 */
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO=
32,
+                           lower_32_bits(pt_base >> 12));
+
+       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32 */
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI=
32,
+                           upper_32_bits(pt_base >> 12));
+
+       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32 */
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_L=
O32,
+                           (u32)(adev->gmc.gart_start >> 12));
+
+       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32 */
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_H=
I32,
+                           (u32)(adev->gmc.gart_start >> 44));
+
+       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32 */
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO3=
2,
+                           (u32)(adev->gmc.gart_end >> 12));
+
+       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32 */
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI3=
2,
+                           (u32)(adev->gmc.gart_end >> 44));
+
+       /* Program SAW CONTEXT0 CNTL */
+       tmp =3D RREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_CNTL);
+       tmp |=3D 1 << CONTEXT0_CNTL_ENABLE_OFFSET;
+       tmp &=3D ~(3 << CONTEXT0_CNTL_PAGE_TABLE_DEPTH_OFFSET);
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_CNTL, tmp);
+
+       /* Disable all Contexts except Context0 */
+       tmp =3D 0xfffe;
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXTS_DISABLE, tmp);
+
+       /* Program SAW CNTL4 */
+       tmp =3D RREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CNTL4);
+       tmp |=3D 1 << VMC_TAP_PDE_REQUEST_SNOOP_OFFSET;
+       tmp |=3D 1 << VMC_TAP_PTE_REQUEST_SNOOP_OFFSET;
+       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CNTL4, tmp);
+}
+
 static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 {
         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -283,6 +329,9 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_=
device *adev)
                                     i * hub->ctx_addr_distance,
                                     upper_32_bits(adev->vm_manager.max_pfn=
 - 1));
         }
+
+       if (amdgpu_ip_version(adev, ISP_HWIP, 0))
+               mmhub_v1_0_init_saw(adev);
 }

 static void mmhub_v1_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
index 2c3ce243861a..380e44230bda 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
@@ -1232,6 +1232,29 @@
 #define mmMC_VM_MX_L1_PERFCOUNTER_HI                                      =
                             0x059d
 #define mmMC_VM_MX_L1_PERFCOUNTER_HI_BASE_IDX                             =
                             0

+// Stand Alone Walker Registers
+#define VMC_TAP_PDE_REQUEST_SNOOP_OFFSET                                  =
                             8
+#define VMC_TAP_PTE_REQUEST_SNOOP_OFFSET                                  =
                             11
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32                    =
                             0x0606
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32_BASE_IDX           =
                             0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32                    =
                             0x0607
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32_BASE_IDX           =
                             0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32                   =
                             0x0608
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32_BASE_IDX          =
                             0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32                   =
                             0x0609
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32_BASE_IDX          =
                             0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32                     =
                             0x060a
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32_BASE_IDX            =
                             0
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32                     =
                             0x060b
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32_BASE_IDX            =
                             0
+#define mmVM_L2_SAW_CONTEXT0_CNTL                                         =
                             0x0604
+#define mmVM_L2_SAW_CONTEXT0_CNTL_BASE_IDX                                =
                             0
+#define CONTEXT0_CNTL_ENABLE_OFFSET                                       =
                             0
+#define CONTEXT0_CNTL_PAGE_TABLE_DEPTH_OFFSET                             =
                             1
+#define mmVM_L2_SAW_CONTEXTS_DISABLE                                      =
                             0x060c
+#define mmVM_L2_SAW_CONTEXTS_DISABLE_BASE_IDX                             =
                             0
+#define mmVM_L2_SAW_CNTL4                                                 =
                             0x0603
+#define mmVM_L2_SAW_CNTL4_BASE_IDX                                        =
                             0

 // addressBlock: mmhub_utcl2_atcl2dec
 // base address: 0x69900
--
2.43.5


--_000_BL1PR12MB5144E7EF8E7F67F4D5F74217F7692BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhu, Lingshan &lt;Lin=
gshan.Zhu@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 24, 2024 11:09 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;; Zhu, Lingshan &lt;Lingshan.Zhu@a=
md.com&gt;; Du, Bin &lt;Bin.Du@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: init saw registers for mmhub v1.0</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This commits init registers in the Stand Along Wal=
ker<br>
for mmhub v1.0, to support ISP use cases.<br>
<br>
Signed-off-by: Zhu Lingshan &lt;lingshan.zhu@amd.com&gt;<br>
Reported-and-Tested-by: Du Bin &lt;bin.du@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 49 +++++++++++++++++++<br>
&nbsp;.../include/asic_reg/mmhub/mmhub_1_0_offset.h | 23 +++++++++<br>
&nbsp;2 files changed, 72 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c<br>
index e3ddd22aa172..e9a6f33ca710 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
@@ -229,6 +229,52 @@ static void mmhub_v1_0_disable_identity_aperture(struc=
t amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&nbsp;}<br>
&nbsp;<br>
+static void mmhub_v1_0_init_saw(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd_ad=
dr(adev-&gt;gart.bo);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0=
_PAGE_TABLE_BASE_ADDR_LO32 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXT0_PAGE_TABLE_BASE_ADDR_LO32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; lower_32_bits(pt_base &gt;&gt; 12));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0=
_PAGE_TABLE_BASE_ADDR_HI32 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXT0_PAGE_TABLE_BASE_ADDR_HI32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; upper_32_bits(pt_base &gt;&gt; 12));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0=
_PAGE_TABLE_START_ADDR_LO32 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXT0_PAGE_TABLE_START_ADDR_LO32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 12));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0=
_PAGE_TABLE_START_ADDR_HI32 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXT0_PAGE_TABLE_START_ADDR_HI32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 44));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0=
_PAGE_TABLE_END_ADDR_LO32 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXT0_PAGE_TABLE_END_ADDR_LO32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 12));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0=
_PAGE_TABLE_END_ADDR_HI32 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXT0_PAGE_TABLE_END_ADDR_HI32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 44));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program SAW CONTEXT0 CNTL */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(MMHUB, 0, mmVM_L=
2_SAW_CONTEXT0_CNTL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 1 &lt;&lt; CONTEXT0_CNTL_ENA=
BLE_OFFSET;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~(3 &lt;&lt; CONTEXT0_CN=
TL_PAGE_TABLE_DEPTH_OFFSET);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXT0_CNTL, tmp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable all Contexts except Contex=
t0 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D 0xfffe;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CO=
NTEXTS_DISABLE, tmp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program SAW CNTL4 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(MMHUB, 0, mmVM_L=
2_SAW_CNTL4);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 1 &lt;&lt; VMC_TAP_PDE_REQUE=
ST_SNOOP_OFFSET;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D 1 &lt;&lt; VMC_TAP_PTE_REQUE=
ST_SNOOP_OFFSET;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CN=
TL4, tmp);<br>
+}<br>
+<br>
&nbsp;static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)<=
br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =
=3D &amp;adev-&gt;vmhub[AMDGPU_MMHUB0(0)];<br>
@@ -283,6 +329,9 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i * hub-=
&gt;ctx_addr_distance,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32=
_bits(adev-&gt;vm_manager.max_pfn - 1));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, ISP_HWIP,=
 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mmhub_v1_0_init_saw(adev);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void mmhub_v1_0_program_invalidation(struct amdgpu_device *ade=
v)<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h<br>
index 2c3ce243861a..380e44230bda 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h<br>
@@ -1232,6 +1232,29 @@<br>
&nbsp;#define mmMC_VM_MX_L1_PERFCOUNTER_HI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x059d<br>
&nbsp;#define mmMC_VM_MX_L1_PERFCOUNTER_HI_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
+// Stand Alone Walker Registers<br>
+#define VMC_TAP_PDE_REQUEST_SNOOP_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
+#define VMC_TAP_PTE_REQUEST_SNOOP_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0606<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32_BASE_IDX&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0607<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32_BASE_IDX&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0608<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32_BASE_IDX&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0609<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32_BASE_IDX&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x060a<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32_BASE_IDX&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x060b<br>
+#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32_BASE_IDX&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0<br>
+#define mmVM_L2_SAW_CONTEXT0_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x0604<br>
+#define mmVM_L2_SAW_CONTEXT0_CNTL_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define CONTEXT0_CNTL_ENABLE_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
+#define CONTEXT0_CNTL_PAGE_TABLE_DEPTH_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 1<br>
+#define mmVM_L2_SAW_CONTEXTS_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x060c<br>
+#define mmVM_L2_SAW_CONTEXTS_DISABLE_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0<br>
+#define mmVM_L2_SAW_CNTL4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0603<br>
+#define mmVM_L2_SAW_CNTL4_BASE_IDX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
&nbsp;// addressBlock: mmhub_utcl2_atcl2dec<br>
&nbsp;// base address: 0x69900<br>
-- <br>
2.43.5<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E7EF8E7F67F4D5F74217F7692BL1PR12MB5144namp_--

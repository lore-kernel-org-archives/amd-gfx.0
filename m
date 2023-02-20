Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB79BC64EC4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 02:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBD710E0F6;
	Mon, 20 Feb 2023 02:31:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4422110E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 02:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE1li9wF/1mmXkQNIgXAhfr3+fOZG0ciCD/9LAr52VjglpcrjMU0AmUDSjUilMoyzqN0VG8QqJ9lUOfjzj55Di5gGb6Hy6TxWslYWLqOxmc6s7NucInGOyim0qEd0nbcciWMkp0VUNYLjVzNjoMYMPmkIgu5tRBRHhDyOrMbD4Olk6dax8J7Fj55O0TqbMlniZ1LOArvuh0w/a6PUJ8shWgE98ZcBuOCUYvFJQV9gyKqVQzl1tGaEdN5BJYSiMLYIUDdhN9aMFn9am73Y6XTQAO4pRS7/H6x3xnTL8v7zN4m7Svt7RKEmRaQpXIOutN0a9tGpDTL+JvPFhiHcoqaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LR97YlLgVrLT7V3zPWl+LiJ1yeS2ldpWBtCByfKDdk=;
 b=bVCYhRQHTWCuo310UtoZskcB5iA48cXDZxRKZex2fq+6TY40shgQpRFgJqYRMZTcGAIkYkcukNYQ59GTsY4W+USB4LhKx3Ik8pbs85nv3SHZTRyqLgt9c1C+V7EDbxIePWNWFIu0NTW6OHuazMTIPjg84uSfv7tEC1FGSuU8n9RoSQSrLYqUgnkEo3Mzj+vA8rIWvTzSqxUqREGAM/W41vNKLBJT9onnfzBCWBrOvKbQyAeY1yBe8GffP5GGYfS+l6rniSuU3FxPYmALJ5lqc6qkSD9iXYHHZEYVRSzmogrgooMZHmO32YehU5Vjo+l1pb3zDr3Xb/QefeRSuuQFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LR97YlLgVrLT7V3zPWl+LiJ1yeS2ldpWBtCByfKDdk=;
 b=cv2J/8gNWux9xBj021RgA87ZeRQ7aQJ8p39YJBu8WgrCZOUJ7YAzcSwL+zcmDwl+voFsirgRw6YyK3EH/YJvccuqzrsjQB5sETuN1DQ/hHn4wQMktSJOVE9x3W8TgVE0F+ikj4Q2V40k2KK39VQ2b7oZDMd3YdWWK0Jufv+dOyY=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 02:31:25 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::4083:34d5:f1ee:396a]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::4083:34d5:f1ee:396a%8]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 02:31:25 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect active rb bitmap for gfx11
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect active rb bitmap for gfx11
Thread-Index: AQHZRMge16LFKCgBq02aTkCLK+LaSK7XHT3w
Date: Mon, 20 Feb 2023 02:31:25 +0000
Message-ID: <DM4PR12MB5181518AACDD7FF60296C945EFA49@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230220010840.17333-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230220010840.17333-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4348:EE_
x-ms-office365-filtering-correlation-id: 2b2625f8-25f8-46a4-d435-08db12ea902a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rO2U0C/RasFobMJ9+vQZJ3Ad7q6vxzlswcPbpILpbKTyWAb7sI9FRQpR/tvymEneShlE6ivDbjsjCfiO/1ruqbWw/iIuw/L/4soC5x6S3HzuRHG92EZ+N0pd0TbyrKeiVjIXnjUHboirR4OiaRk3ciIhLNFRTFXUVQS6e7E6w1Q0K0WmwDSLnueOkR6+YJuD1I3vrud0LpFg9fPTMDQhg9KbtZInHDLucPrnAyUZ7pnf5M+2P/Wxd66NaggBY8mxoY+c9d4nK/hth0Mq6g2gCKm4BhtJjTJVCLX+VQNCMZ5iu9ww9CRdZjPIgP/UKLogWfSG0Vvd4qxisSW3Pci4cGw4EMUCVWdjH8tc0ZB8KJYCNBO41ysJ0xVCoOhLWdfLsFVVhVr8cbtPu48jZat8jKkzy9dSA/Tv0SW4OhMhrpPBCVfjECuyQRZJkaRhrsAOcAx9ZL3ae+KVWsNiUEPDgQKKu6/EoeTrKcuIgFRfT4UYMH5v6wi38OCTunZnMItktFtlKXKEboqxGS+cT9ul5eGbbI8Fy/PlBN6pgJ4+jOFsjFkAUw0vpelGBHw4cvo3UIQZbgvCwg0o2UIEDnfQLLhsasRJnWeKU+J30oB1D244ZJ/WQkqcPwGdxAOSK7Rqf/pDcOHobKtnYCeNZw2Gai1T98EP8aOnNUL+tPetNnd+mEqX6NqpRtPVJjh5suK7UMqLENKz1JckSfFOslOnbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199018)(66946007)(76116006)(110136005)(316002)(6636002)(66556008)(8936002)(83380400001)(52536014)(66446008)(66476007)(4326008)(64756008)(8676002)(41300700001)(6506007)(53546011)(26005)(186003)(9686003)(478600001)(7696005)(71200400001)(38070700005)(55016003)(33656002)(86362001)(2906002)(5660300002)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Otv1NqHyf1m1BdceNICC1ITrxh0++hVnMA4YTPhIpkBSCNdv6T6El3sSMiXv?=
 =?us-ascii?Q?Pv0FafgMTgx+rO8k3imihT5qUzoISaSKhCOqDiXYZOMw5XyBXScVmBHMMzcc?=
 =?us-ascii?Q?Mt0gDXArVbpdFK3YzonFyOa8b6k4n6xMxvqNwqANbNGNlSbe4Ng0euSMrk69?=
 =?us-ascii?Q?4GNBZFoD8xnA4pGpfTMmCRRm/+ybYKK54RqV0UEu1gt9zzFoLeEOEj0lQJlf?=
 =?us-ascii?Q?g/DrHpzj7rliXiGsMik/7jgBvYZCa7YmJMp1re/lBwXeQa4VWF1y1+1h0kQC?=
 =?us-ascii?Q?5zKFS2dARWe26LHxZfw7y0cMP5tZEKdba/5Yd7rkgo0jIc7nU0UyG2oP228C?=
 =?us-ascii?Q?XL8C+b1erfemSwHuvN4xQ1o8gwEJJZ8NbfoCtWNmGxilDREnHKwdRGboHfzn?=
 =?us-ascii?Q?rjpJO2xhYuARQexu3sOGwvCvJobzQ7koHGJfTPT9isUmxxqakye2j3xoN2Ex?=
 =?us-ascii?Q?tokRPg5EgPBZsdMnigD8VqafD4kNbQ+qeuyQ1wywff+8ku9O5G31o0ssxmRz?=
 =?us-ascii?Q?xkDWtIzj5Jq1pPO5D6sd9DUgSCs9pNYp5W7sAzx/b1lNRF1fPT1/JMFusjqG?=
 =?us-ascii?Q?DEgIemDGB1TaTxjWgSYvG+XKtYRIulLbK/I08bAAvRBbM2ke327HkIGGKXQT?=
 =?us-ascii?Q?K4gR4moHTUlr4B+Dkka+700CeEMHq/Oco7JvhYnP3KeeGXwIEk/EZfZWtpHA?=
 =?us-ascii?Q?/xrw5Gh4m98CR39LLTIPNYd1oyZByNnurzjQqZFf8znuu4Oyou0xS0O1K11G?=
 =?us-ascii?Q?SQVZ5yPIMzxVttr66xacJKUSBRt/SQ1YAVT0AWmLPF0pnKEnu88dIMPCf/92?=
 =?us-ascii?Q?Qo8bhMNsnJR/3K1et7bfRVDZ3yxYIxn0XEuVSPjJX+CVgfcbEF8PHAJzPehX?=
 =?us-ascii?Q?A4NYR2+wgdgVW6YQ3YmMNuyHQTN54piLRLc3ZQDSvOjtHAfBvEIr7XmMcENN?=
 =?us-ascii?Q?7gnOp2V8UjbTaKX+9opvT9svR+MoGLsplzJZBGJEnunznq8ycfvuATILSXVo?=
 =?us-ascii?Q?r3Dje/8LKxwOo3y8LdDTV5NFCeCvsph+9JuNW63w7Ue4M2bOSpb8OisqFczd?=
 =?us-ascii?Q?t1QNMT363p3sBPlNjt6xinxx3Jr8GDk8LtZsxuhz/U7knPsfsx0tjV2SLWZg?=
 =?us-ascii?Q?IQcV+vWc3HOL91tRvutG9fTSaX/ZB06+8XxQ2/gpM1TIzxboI7cpGw9DomEv?=
 =?us-ascii?Q?9Z9p+VV4UxWbc1SY2JNPKB2IswWY4f7wz1/54YyykzkYwluNAkjjrjgdi6LA?=
 =?us-ascii?Q?uychzDxvNMDh2wETQlirue8o3sitxTwGVlwRyVGg6XGtGi8MrSUaEr0IMa+L?=
 =?us-ascii?Q?00y4F/BXJV7BYEtetpcryqQsu5Mx3L7YwxkAqRXbEcW5MFp6C50o6F0A4Jpt?=
 =?us-ascii?Q?9yf78OQaK6UKwljqfXLBg4pzMlIj+h6fD29YAXuzIMXpfo2pjpikCESlQb+L?=
 =?us-ascii?Q?3cZiJEdJmglf4BSzc/gOz4DWqlm8Gvr4grp2GZo+4X82oidhxY5uCQlyOBKe?=
 =?us-ascii?Q?+pfvlG9Hd+FCyUZd7Sz1spZnB7nvQzVNVJKA5muPyoLPOtaM+V/+CThWtB9h?=
 =?us-ascii?Q?brXUCZrkAdMrOFwiV4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2625f8-25f8-46a4-d435-08db12ea902a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 02:31:25.3118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IHcFKq7zWHhWpATVHqQ6xhNtJ1w9Ngn7qK6qm/++BxfaUyI55J9v6tJTSnJ+Yyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking =
Zhang
Sent: Monday, February 20, 2023 9:09 AM
To: amd-gfx@lists.freedesktop.org; Xu, Feifei <Feifei.Xu@amd.com>; Gao, Lik=
un <Likun.Gao@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix incorrect active rb bitmap for gfx11

GFX v11 changes RB_BACKEND_DISABLE related registers from per SA to global =
ones. The approach to query active rb bitmap needs to be changed accordingl=
y. Query per SE setting returns wrong active RB bitmap especially in the ca=
se when some of SA are disabled. With the new approach, driver will generat=
e the active rb bitmap based on active SA bitmap and global active RB bitma=
p.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 78 +++++++++++++++++---------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index e7e5a2c31896..7b7f01b304cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1503,44 +1503,70 @@ static void gfx_v11_0_select_se_sh(struct amdgpu_de=
vice *adev, u32 se_num,
 	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, data);  }
=20
-static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+static u32 gfx_v11_0_get_sa_active_bitmap(struct amdgpu_device *adev)
 {
-	u32 data, mask;
+	u32 gc_disabled_sa_mask, gc_user_disabled_sa_mask, sa_mask;
+
+	gc_disabled_sa_mask =3D RREG32_SOC15(GC, 0, regCC_GC_SA_UNIT_DISABLE);
+	gc_disabled_sa_mask =3D REG_GET_FIELD(gc_disabled_sa_mask,
+					   CC_GC_SA_UNIT_DISABLE,
+					   SA_DISABLE);
+	gc_user_disabled_sa_mask =3D RREG32_SOC15(GC, 0, regGC_USER_SA_UNIT_DISAB=
LE);
+	gc_user_disabled_sa_mask =3D REG_GET_FIELD(gc_user_disabled_sa_mask,
+						 GC_USER_SA_UNIT_DISABLE,
+						 SA_DISABLE);
+	sa_mask =3D amdgpu_gfx_create_bitmask(adev->gfx.config.max_sh_per_se *
+					    adev->gfx.config.max_shader_engines);
=20
-	data =3D RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
-	data |=3D RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	return sa_mask & (~(gc_disabled_sa_mask | gc_user_disabled_sa_mask));=20
+}
=20
-	data &=3D CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
-	data >>=3D GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
+static u32 gfx_v11_0_get_rb_active_bitmap(struct amdgpu_device *adev) {
+	u32 gc_disabled_rb_mask, gc_user_disabled_rb_mask;
+	u32 rb_mask;
=20
-	mask =3D amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
-					 adev->gfx.config.max_sh_per_se);
+	gc_disabled_rb_mask =3D RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
+	gc_disabled_rb_mask =3D REG_GET_FIELD(gc_disabled_rb_mask,
+					    CC_RB_BACKEND_DISABLE,
+					    BACKEND_DISABLE);
+	gc_user_disabled_rb_mask =3D RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DI=
SABLE);
+	gc_user_disabled_rb_mask =3D REG_GET_FIELD(gc_user_disabled_rb_mask,
+						 GC_USER_RB_BACKEND_DISABLE,
+						 BACKEND_DISABLE);
+	rb_mask =3D amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_s=
e *
+					    adev->gfx.config.max_shader_engines);
=20
-	return (~data) & mask;
+	return rb_mask & (~(gc_disabled_rb_mask | gc_user_disabled_rb_mask));
 }
=20
 static void gfx_v11_0_setup_rb(struct amdgpu_device *adev)  {
-	int i, j;
-	u32 data;
-	u32 active_rbs =3D 0;
-	u32 rb_bitmap_width_per_sh =3D adev->gfx.config.max_backends_per_se /
-					adev->gfx.config.max_sh_per_se;
+	u32 rb_bitmap_width_per_sa;
+	u32 max_sa;
+	u32 active_sa_bitmap;
+	u32 global_active_rb_bitmap;
+	u32 active_rb_bitmap =3D 0;
+	u32 i;
=20
-	mutex_lock(&adev->grbm_idx_mutex);
-	for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
-		for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v11_0_select_se_sh(adev, i, j, 0xffffffff);
-			data =3D gfx_v11_0_get_rb_active_bitmap(adev);
-			active_rbs |=3D data << ((i * adev->gfx.config.max_sh_per_se + j) *
-					       rb_bitmap_width_per_sh);
-		}
+	/* query sa bitmap from SA_UNIT_DISABLE registers */
+	active_sa_bitmap =3D gfx_v11_0_get_sa_active_bitmap(adev);
+	/* query rb bitmap from RB_BACKEND_DISABLE registers */
+	global_active_rb_bitmap =3D gfx_v11_0_get_rb_active_bitmap(adev);
+
+	/* generate active rb bitmap according to active sa bitmap */
+	max_sa =3D adev->gfx.config.max_shader_engines *
+		 adev->gfx.config.max_sh_per_se;
+	rb_bitmap_width_per_sa =3D adev->gfx.config.max_backends_per_se /
+				 adev->gfx.config.max_sh_per_se;
+	for (i =3D 0; i < max_sa; i++) {
+		if (active_sa_bitmap & (1 << i))
+			active_rb_bitmap |=3D (0x3 << (i * rb_bitmap_width_per_sa));
 	}
-	gfx_v11_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-	mutex_unlock(&adev->grbm_idx_mutex);
=20
-	adev->gfx.config.backend_enable_mask =3D active_rbs;
-	adev->gfx.config.num_rbs =3D hweight32(active_rbs);
+	active_rb_bitmap |=3D global_active_rb_bitmap;
+	adev->gfx.config.backend_enable_mask =3D active_rb_bitmap;
+	adev->gfx.config.num_rbs =3D hweight32(active_rb_bitmap);
 }
=20
 #define DEFAULT_SH_MEM_BASES	(0x6000)
--
2.17.1


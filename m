Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45380C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 01:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB05810E096;
	Mon, 20 Feb 2023 01:09:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB0A10E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 01:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTJ4Rbsiz3McOWm5+lWuICVPyQdjHSv1Alu1C+Aa8NmWcxT4kbXwtppBtCS2v+m3CqnPvxCBbd234onQog8B7gCGm/GVKH7dvmREG+V8UnzbWDoUf3vBPYTOO/aR2Hmk9M4Tu9FpvbIO7Ciy4hv2o+wTB6crkOhIxaTZksfd+0RhKBhv9iAZv1K/st9f7nOF5KR6O+YnvZY/Y1S8zzVGvAHNH919N4Mzv2U9Stz/kdjIEAeGPVD7Rsvpb4HBHD/3UfqSk7XL9Gwpj4WQcUDD3TQXqOHyejwrS1CpCBtVe5VoSkgcji6MdxGk7MAkyW+oWMUpXwweuKQR0jew0nColA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2rcD2ADBMXM3hlP8FF/inVDskCym1P0HKLREUnXDTQ=;
 b=J2YTg6bYFuzykyFuvhmVvv26a4STA2vEsx2u42o6No5qhk5Zxwq5fWC/dX+k+bK8xzIX7Zlh4QAwo/6RAjDI7IVNDKCAZNlO2AGmm96vLzXfqLRfiocppMYnoic/r3MWep/7LutjDE/kF/R47aJjYjck6O0wxdmdKipfFvaEDUYR7fLDSlmyOy2opkMyA5HbzH/gSQ8G5hB1akhSjYFu3GewfBJKu3K4+gWXKZKGJEMVCULhntokaLnrxSFX5f3bCCoL108sp5j9PLy/bZe1L2DCxfkf+gJdlHOU9+Y9nC2kDncl/sdU0FSadjHuiAEEngJo/ibej24PCPaE1BGA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2rcD2ADBMXM3hlP8FF/inVDskCym1P0HKLREUnXDTQ=;
 b=nYLFwRIgJL4F+Q25qdcyT/7fUj08htW32teIJUmMIUXL+1LOShS1xAa6COTO85OC49ogaodr8E4khBWmbmNctj423C2/Kpx/HBS3Lx/hhUoW0+tTCqqs/6s4107xpLBGwVrOsHRhM7F3NkGPx92eQjDplWO9+/P5YSu/0q8ByxA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 01:09:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::ffe7:2ff1:c01d:6070%8]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 01:09:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect active rb bitmap for gfx11
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect active rb bitmap for gfx11
Thread-Index: AQHZRCwhNbs6GljOwkKj4J6ijqqUHK7XB2yQ
Date: Mon, 20 Feb 2023 01:09:48 +0000
Message-ID: <BN9PR12MB52571EEA0B9EA31141A7DB97FCA49@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230219063328.13184-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230219063328.13184-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB7254:EE_
x-ms-office365-filtering-correlation-id: e2d3b2ea-a307-481f-bde7-08db12df295a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buY6he4aia/ns7pEHiE/kV2+Bu8b3yIDpPq3YIhlftkDjol+q15QfDWQU7xolRZhD9ph9iJwzboeRtlyzHzvEg++98wmYWq82e2RvFzEgR6eIKVl+2efZ7cAdcMqUpYe3ei0t1oD1pfU5Ospu7BdUOzZa2+pRrsQSahq2s/vda8VPLrKQaZqIP+tF4UKG+gnlC3lMy7uiA64mfyran/6Z52cN+iFqRatLTaT7QNPBXckzs8n3ZHEFgOdzxzvLB5dZioRrWV4z3Cl7XaODNDI4AAZlt5iRYaNDgb511fhEj+1S6LjnoS/a3h2t8YEEqsypdGCArceWCsPM2AVv9F8spUH3w2n9ZPFJlDrk7Wzon3CLYw1FIKffEbR/2VvdQy8fi8AEAZ9CpySqkLBx3Vayw0LfJ6pxaxydDoH1+sN8d5EpJ0roPtgOMHbZOz3S0aosiEKz2XLHxqkkzCkQLE18S6v88EDtkBs4uPoAmmegTyisEE90mHrvicaRfX31LiYUbfagGXUUzFqh+Ec40xGGfl/Qsyb3hETaanE0gft/eNC2xJx1iGZzARxQV8z8d+qA8SPRp29yNjj0746FhetDuqdXPdMhucD+LixhK/LsRhvTy2QWkJ/Nroc0U9HdsT6Mln7e1Lv/CeyrT9tua5Tu9lD4UACpLYCpw6xuPhe0dPcUbQK+Jm0ddADLJKPjOhh9P8Tx10SyFT6WMYAgXamKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199018)(83380400001)(38100700002)(5660300002)(8936002)(2906002)(110136005)(122000001)(55016003)(33656002)(86362001)(38070700005)(478600001)(53546011)(6506007)(7696005)(26005)(76116006)(66476007)(66446008)(64756008)(66946007)(66556008)(71200400001)(52536014)(9686003)(186003)(6636002)(8676002)(316002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZW3gLojIdrLQzqMimUPGCIsEziSqOhZl795l/lJvppa7A/tfluBYlqD+nHoL?=
 =?us-ascii?Q?tasfc97tUvb971EHZVr1yAI15iQnVsmAu/nvhfBaR7akyoJKpVSa1P4bCJD2?=
 =?us-ascii?Q?/5+3M6/FkDrdoflDNz90bSWu8GJVdToeChrBuyx6DOtEyKOtN3IQYFCrz5DI?=
 =?us-ascii?Q?i1lw70jL7bY+Dyz9P56IjqtbkGrsw2y5GQ7mFwdeKQ7vnQBhXvQW0mDSdJzy?=
 =?us-ascii?Q?FdNyS7q3KEZmNzKqPwhoQhZ9N7dXs5v8cvOeAQWH6Ky6v0X2yghbCZiPuQGp?=
 =?us-ascii?Q?195Icy0qj3KeHS7yxZrS7r6x4Vywcp91Rg8ShIFqUrT/ST+KM42S1nbCnR/t?=
 =?us-ascii?Q?Fkh6sRl1SzINkl2vi5GPRgKTWm3jTjEZ/A2tAkobPuLYcUw7657SbYLBuZwt?=
 =?us-ascii?Q?3wrYKbljSXwl3RqucTBrNBu+ScWr3lQE9dAoQA1wWzLjKyBNXL2vnhuDdx5v?=
 =?us-ascii?Q?T1gl5HGyy+Hwh89cu8y5GrAfyVRUOXu5fpqr2+8fM2tW+gkxEp0BLknSy0rx?=
 =?us-ascii?Q?cCoe2y7d7P8s6n3KztTKT6wHMtdStOIkAElXOO/MleeAyht9C2JMY0Zfa/p0?=
 =?us-ascii?Q?SiGWrKrWQvz8aM1fDrl3l2g4RSI4KVRrcSSKoqKPNiWHXdsktMAftFQF3eSC?=
 =?us-ascii?Q?46hzyH5GB3IYFAXMJD+DkQf1/RShRgFi3qfaSqPBlQcQES44navtf+k1+OU0?=
 =?us-ascii?Q?+mqTkpvMchINYfj724zVP2oQp6dEEUo7mkxEsOjNVe43G9x3bmFSs6jGkO5F?=
 =?us-ascii?Q?9DMU9YYi8ZjZo5hvCu41va3hBR1Qjj8qn1jaYFhc61wi+vUS603vUFB0jQd3?=
 =?us-ascii?Q?q0rjEjLjHxaY3BnxlOg9PeX1arg+FlIJ6J05PHiKgMYGcOfQrylaY5/I1cC1?=
 =?us-ascii?Q?tsmJuU16yZR3TwZ/+BoYHcmuzRxjo1cLvwzbI8daYBJTJlO6SJ1Nyo+BEiMX?=
 =?us-ascii?Q?EmoFmBo3zuFc0Xm1VjG75ScKUwpHIrNgK1hZYm8Ymk218sos+t/o8+dFeHy4?=
 =?us-ascii?Q?X1eA7xxPGIbnWpPuCW5Un47Y7ZIvTguKfR1doaDHmuWXgvK771T/ryQprUu7?=
 =?us-ascii?Q?Nu86I/Ha5CG/UodYxo6501WqtGpQ5NP4wK2s747ITnFVdd75s9vB1sIVuzJM?=
 =?us-ascii?Q?fwfHoI/LccQ84oQubpcWzgsT/jPQtAl8t604VWds1Xq1qeqUql4v6IvYKHOw?=
 =?us-ascii?Q?eUglKKIiNQ7kJ2XRbvV71vKV6RU7btcueK4VkzUmG0lNCGdLN0Rk22hgGM0E?=
 =?us-ascii?Q?DM8UkCWd83jDgaex0IbG+SCIqQRgCLgWrTsOevrDDHMyylY3YpbTgxOUbkaT?=
 =?us-ascii?Q?KgaHgp4uu5uT+mZpdwJOHR/PKYkWLlURsmurkc1TCSdEUZPf+xu0z4U05Fvj?=
 =?us-ascii?Q?JoJGR5w92nRbh8F0ZYZ0i/Lii492a2C8VxwHneBe8PE63tFWX5bVj3skubPH?=
 =?us-ascii?Q?kYAbuYPeX8iF+N4Dg1fEL43KGhtxrMKI2gHdzkzceZZpRtJRVRnGfRM2qgzZ?=
 =?us-ascii?Q?NbO66rW6WRw+RViN2l5wm8mJ7cznEM42kTXhvqqns5OHBuSVEFpheJu6zvZM?=
 =?us-ascii?Q?AuwBRjLEV2rbADeOkFoxqin7pOzUTPt2TC3+lpSg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d3b2ea-a307-481f-bde7-08db12df295a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 01:09:48.3564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vlk7LJC3ueVTvoJaj77J/lZ7Eh9/uP7N/IngCr5+FJQ4MNdLwqh7Xp6vQDORdIf3LNCi+SgXAB1RwOHU/oEN9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

Please ignore this one. Some code needs to be optimized. I'll send out anot=
her one for the review.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Sunday, February 19, 2023 14:33
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 75 +++++++++++++++++---------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index e7e5a2c31896..87a6cdac3d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1503,44 +1503,67 @@ static void gfx_v11_0_select_se_sh(struct amdgpu_de=
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
+	u32 active_rb_bitmap =3D 0;
+	u32 max_sa;
+	u32 active_sa_bitmap;
+	u32 global_active_rb_bitmap;
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
+	for (i =3D 0; i < max_sa; i++) {
+		if (active_sa_bitmap & (1 << i))
+			active_rb_bitmap |=3D 0x3 << (i * 2);
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


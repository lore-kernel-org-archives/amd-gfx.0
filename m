Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4399EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 06:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1DE18AB13;
	Thu, 21 Jul 2022 06:50:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98B718AB44
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 06:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB48VPFfiRhKYc1uHo6+cb9Ih7i2XYMVEJJoGD+6H+5irC/1oE4SrvC84JjaoX8srQ5DejDhIv06nLYUi4CNYX42otd1eR/ewcOCvLtQNV8+5dMzKyuc0Prau1brCERPrrJReIa/HgOtOHrZpKTJ1fcY34rteQDpk9qjI+RcTCum6k4kLgFaoGpk3/6rK0vxFAUrBikTCpMu71bplM1rdRnNLSh4PMAwuM+aYvDJ8/+vpocBQ1uddEBJTejVoW86Ai3iUUorLZgktugmdgObSsDD/uSQnjImfms4HVsW2egF8qOhBGKf7xnkoVaoV9FVdxpElM9U+Uu8iiKf+8f0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Khm3aUwi+7sZ5Otdp+79qhgAHPyKZWcNc/JdInCAV80=;
 b=ATRH0gmhvQ4wjTky2IJcYGfw7B8GSUK85grztb8syLxLYfXmrb8vkA5lmqZ4VHfvUgqWvJUd5d9sYdG9a8CCrCaEF5EXsNnpmzzBet8JpeqNonI1qvCkVagWaLYu0uefZAzUvviTdMqR+FWzIzskvGxE57nhkzHbIVFa+9QBcVu1axFshuzVSp+gy/8r7xtNZijVqXiyXFxtHe7SKrnNEN76CySDM8hwlxIYpVfbdeArvwFsiG/7O3JkyYhwUnL+kHMDptZ6iw68ecYpVT6/TNHYnpahoTaQGd67GA29AipARtGBZnA0CqpeoT8JNn/CwdDooShGojBm6qfvGVSjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Khm3aUwi+7sZ5Otdp+79qhgAHPyKZWcNc/JdInCAV80=;
 b=ea1h/9/gV9QxYlaxFFf1Bc1iGa5KJ7xDsKReeqOETCyn6XNS4f0tCyNCgGWGcC+2lO4wEJLEIcGpYIgziIIzR32MxTZM5uMczOWWpROvyg0VMoN0PoRBPsmDA7IXpnnsj/0O1CqBiFfrYgMSCyOBOFluV8d0lTPAkkPl61jxTdc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 06:50:22 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5438.025; Thu, 21 Jul 2022
 06:50:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
Thread-Topic: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
Thread-Index: AQHYnMoR/QNmKxb3ZEeQyPrFfR2RKK2IYpPw
Date: Thu, 21 Jul 2022 06:50:22 +0000
Message-ID: <DM5PR12MB2469655C5B71D0A2D2A958E6F1919@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220721061942.2517331-1-shikai.guo@amd.com>
In-Reply-To: <20220721061942.2517331-1-shikai.guo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54ecfcca-cbf4-44fb-ac74-08da6ae548a7
x-ms-traffictypediagnostic: MN2PR12MB4549:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRX9UyCKc0GodCSAxsNnF0nk7GT3sgAxHraIStbqx4duRJDvFD/VpiXkm2hF6UOFA5FCLvoQ3tyRqREotUqGuqFMsPWdWpKd6uL/mFByHBHi9CuyAxoWobMBTW3iFpgQhx/zMMYassgSxEJ7+IXRo0iF9LVfhr5NDHkHZJSX/oM1iaFVPp/7w0+OBPa4L21DPPh1i2g3yesbXLDaeZQXN5ySsacZT83lBK4AD37/o055jY1U/m64KdbrhhaJ26/SdHPf8HbouE71tSQjk6Ef9NUbeNa9kD0FqMs2/7+5fXL1vavCkI+TUVikXxvTZpwPPLgEpDDut4h26H1eEHy3uxhGuoAM+gZnCKez7DBmzaI64ko9X1JGQieGYvCMrZUmiQyG/ZxDsQsVa3pq1fGnSkNXx1H0OJAvVK9qG9U55F+RiDBGS1dubEoVCFNpVVJBTdxFaLjzHLVAjLNWEBmbfJYnoAWn+EIqSt0UtD8vWpd58z8jdz07iAPPfcJwhUhT3NYajDktMIVLANix8Osvt8XzvlmmKvw5cX+H/qusshyGryvXJgXO1qAiMdMRVEwA63zTjcGRjzueEQyKc0FSn00CGBHnOlRLrs7Yr5175aF8nVvGqmQUiW+PiY5FVoHnD4tZygYvT5J7kHA8BtM5F7Poa9yYiZ7mxZFoR8saRE5V2qny2zPzb9VOuDG2mYHjQ5pFIDwliFFizFKWUwksTfkxh8Oanfkwwa73g2WakEVOdwyUhB1Nx+6Kfi8C4yU7N8RY2gd3hYKNGyreJStlbzTFV63981L/NhU2Ymd345HPjBYLbOPZwIO5Jndx1kjU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(55016003)(66556008)(110136005)(54906003)(66476007)(66446008)(66946007)(76116006)(9686003)(71200400001)(4326008)(8676002)(64756008)(5660300002)(86362001)(52536014)(478600001)(316002)(8936002)(122000001)(83380400001)(53546011)(2906002)(6506007)(7696005)(186003)(33656002)(38100700002)(38070700005)(26005)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8HG7bLpNBngLV2zSGnfOqx7WhFnvWuQsSWSzg6kfmVJlouXsUowUlo+GGuVH?=
 =?us-ascii?Q?+FK7WtAOk2NW+mXdjRgVXvMmVfXcSdMHlLHtHBazDhBJ4fHWPR3BOvhovkXj?=
 =?us-ascii?Q?xHWGN9Chs5Ui6HlAzMWb9zIpvEH8PDMsimeLm/zO0H2qq3yVp2hNoIGiJEgo?=
 =?us-ascii?Q?fL0VgiX4RUbAHoYlUUM9nKNhKfkoHBlQdrQnTNg2uoruQ8xtn2CzRSY8bYYV?=
 =?us-ascii?Q?agGdPJt6BnY0BJ/yhyBWpBXNfnthByNhJGKOeT0mAeeQaJBC3MVLDKsoQjPp?=
 =?us-ascii?Q?SCKdHn2whCBaFAAkrTchs86ywnmsyMjiTnhu63eAsbxcdE+lzwj3PqzD52pu?=
 =?us-ascii?Q?oGGXuzym/mvKc9dlP2rklTJoNFIajpjMnroS1Sa/0Jt+n5n1O4KqKCroFztt?=
 =?us-ascii?Q?v52SqLaDoMUDqCyjowAyVoA5i8VH1V5kYE+C2CsHFWKZzaM2CydiDSpIfJBM?=
 =?us-ascii?Q?B0T/VybIh3ZNfOP/yRA4GibjbZrIiTEKZPTvh5UNK41NW5R4z2GvIiJkaov4?=
 =?us-ascii?Q?EeoipGOWOa3L8CfthpXLYspdb/LgzfoBbU+NtIwyPHtG5AUSQN8kVaMkaDwM?=
 =?us-ascii?Q?efcembnGSrNm5EuQkduVD17tSxzCsfa9X3PSxn1jq2315HC3+09eEr+mb+Hr?=
 =?us-ascii?Q?L6MuSVuZSXBIKJiN3YaGJwA2pEF3l3ghDliM3XRkU2SUH63lpWa9KyLIKcrU?=
 =?us-ascii?Q?kLqnRe0QUYpwhk3etU93pTr0tQF9DhIuvEDRRyivsZmoNRRXqx5uKiHcIXi5?=
 =?us-ascii?Q?FvKXokla1Rmd3qrpG+DdrgD+UovtIKmns22ie34Y2H4gGnEMx9EZkhiS+li+?=
 =?us-ascii?Q?i/RVH41LUS8+fLJVA06iE2s1uD2nvoeSUJbDItivaceRWbuAj8e2EkmaVEo2?=
 =?us-ascii?Q?Oj+cpi6FlbsdVQiAUjod6w6aDQSugfVfrpLOB+ymQ0IFlGlY4jr08t8/CPJB?=
 =?us-ascii?Q?YvKLQvIi3hQ9KESF37B3BHw3eCmghC/fe9JHbATOb4KTn97r9ebZy+p3kH31?=
 =?us-ascii?Q?jZvZrh5t5SXrVTtP+S+jQDPWK4uXMuzKjvzUpTttfew96uyf1NPl+UjzahHP?=
 =?us-ascii?Q?Aol66Vrq6PYsNxLnIwu36v/PzrHN0xJdmC4F/z3THf5r7CVm0SUAe+V8qI8o?=
 =?us-ascii?Q?Rgl/nfyCcgo2kzeGBag0svc3GVaMNFkY2eCW6eNoG7YX6c/Bm8YxNR8dDnE2?=
 =?us-ascii?Q?rlEQ/7Q/2nGy5d3QUJrY1qmNop9z0GeqGcxOYvKBajhFpSxScvnIzznle9cy?=
 =?us-ascii?Q?PgtcmLDgGfbf/msguwJk0EyMQ5lpP8G5T+UNicM9BoW7sxR+r5hVJzu3WKZk?=
 =?us-ascii?Q?rkjRg7thPZfkqqyHkoRkS8EIsFSdsljm28pKBl8leKn2KNKpeuPQ+ydortg+?=
 =?us-ascii?Q?Xywlh3gUUb4VWTPYwNBS5DKXU4RZbL4QNd85hUWxgFEhGRyOWb+ubHtdtqEx?=
 =?us-ascii?Q?jbG1PQKms+8rb4nRIugdW/eSd+xMWhANOhyBTiWKnERdgcKdCaQauSJM0QVs?=
 =?us-ascii?Q?aLoIGd0rdK34R78rw6cnGEyxjJutDmGIEvCopXE1uy9IAROBEY453cPOPhcm?=
 =?us-ascii?Q?JRmQo5Layz9HmQbnDsI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ecfcca-cbf4-44fb-ac74-08da6ae548a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:50:22.4881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKTfqWY67VqsFx1hKX2B0pB7HsKPAr57L49QFd6xMQw4tPmKTB1Wz+i1MOdthmr11GceyI126qPZ9O4djlmEyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Guo,
 Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

*@smu: amdgpu_device pointer

I guess a typo here, smu is not amdgpu device pointer.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shikai.g=
uo@amd.com
Sent: Thursday, July 21, 2022 2:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Lia=
ng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Guo, Shikai <Shikai.Guo@amd.co=
m>
Subject: [PATCH] drm/admdgpu: Add get_gfx_off_status interface

From: Shikai Guo <Shikai.Guo@amd.com>

add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.

Signed-off-by: Shikai Guo <shikai.guo@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 70cbc46341a3..cac48121d72b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -31,6 +31,7 @@
 #include "smu_v13_0_1_ppsmc.h"
 #include "smu_v13_0_1_pmfw.h"
 #include "smu_cmn.h"
+#include "asic_reg/smuio/smuio_13_0_2_offset.h"
=20
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -42,6 +43,9 @@
 #undef pr_info
 #undef pr_debug
=20
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT			0x1
+
 #define FEATURE_MASK(feature) (1ULL << feature)  #define SMC_DPM_FEATURE (=
 \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -587,6 +591,31 @@ static ssize_=
t yellow_carp_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_1);  }
=20
+/**
+ * yellow_carp_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: amdgpu_device pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=3DGFXOFF(default).
+ * Returns 1=3DTransition out of GFX State.
+ * Returns 2=3DNot in GFXOFF.
+ * Returns 3=3DTransition into GFXOFF.
+ */
+static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)=20
+{
+	uint32_t reg;
+	uint32_t gfxOff_Status =3D 0;
+	struct amdgpu_device *adev =3D smu->adev;
+
+	reg =3D RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
+	gfxOff_Status =3D (reg & SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
+		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
+
+	return gfxOff_Status;
+}
+
 static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)  {
 	struct smu_table_context *smu_table =3D &smu->smu_table; @@ -1186,6 +1215=
,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs =3D {
 	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location =3D smu_v13_0_set_driver_table_location,
 	.gfx_off_control =3D smu_v13_0_gfx_off_control,
+	.get_gfx_off_status =3D yellow_carp_get_gfxoff_status,
 	.post_init =3D yellow_carp_post_smu_init,
 	.mode2_reset =3D yellow_carp_mode2_reset,
 	.get_dpm_ultimate_freq =3D yellow_carp_get_dpm_ultimate_freq,
--
2.25.1


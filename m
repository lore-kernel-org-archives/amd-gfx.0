Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E0C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 08:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34C310E1E3;
	Thu,  9 Nov 2023 08:02:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BA310E1D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMn6tiit1vZSOG5PrBZZ6GPqDaCBQbC37AKePjZmRVqnvSFa8PgybMaiIDANtrdirhdxBSqeKqAE0BIBfawDvY5iUN8S9mUnRYsLiKOX3zrLq9Dz3PAPpL7lfM56BWKd6LiSNZVsC8TU+tvzqEac9V8uLeXmkG7PS+UqkEwQGtLqbpVG/GZHjKR14yfgpVLawi/ORaS2/DycIdyaP990iF9MrI09h9YkJ4z5vaXAOr3fQqmlTGE0dqFwSrVi0dF2hmGeBdvV/WoB3sJ/WIC+iqmLljgkayTVvxQNCky64x1t5yeezUKKyk4352Zf1qpNAYiWQyA+GSS1vC0yPrjw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q47nUj+x86gDlJTutIWIV6jGBIDMj7XNBkA9M5arc/I=;
 b=bIDzpstHmXJhepL3mZKZapu5CRHVBWaJtvUVSdWDd/U8KNpkPsOcdsmJ96Tkc3JO++b4ylDvBgINGsE0nX+DDP+m+Ci7t4dPv32UeZX2LZlkIRwXdS/oacTyr4Kq4J86T2smrt5JRD4Cke3bJXnkq/K21+FLDWmFs2BiILptTAYshuk3NTfn5i4gBLWZrwbEAZYM/O8u56/JhgZEZ3G03payI3Ldmz0+5DCp28r6ncr5yvsbmPNJU0fP22X0fh3AorwDN4eHjhFJZlqHdYas2e9XlfwFxEqP9lSCQwqC7R6e8tPgpQuEGPsZVqU/ZxOZMa6S3IyqysLHAmsW7Axxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q47nUj+x86gDlJTutIWIV6jGBIDMj7XNBkA9M5arc/I=;
 b=Nf4g6BbWG/lU0SBbe7I+vfkwTIU4FfzM+c/sBgxo9FuE6eISiGrd5CX0fss2BFQOE/kGnBt9kay/08ZtzTltlfkD6y4k2npvxhbQrp4nuVJIjA8LskHtO9MHalx7iApo5N/JdU/Lkfs3IIHN5dsoKx9b0btaAdBPcRDmh95rB84=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 08:02:10 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 08:02:10 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Move mca debug mode decision to ras
Thread-Topic: [PATCH] drm/amdgpu: Move mca debug mode decision to ras
Thread-Index: AQHaEs1XnxnOAsgO7EavMWaIBPTNtLBxnrYg
Date: Thu, 9 Nov 2023 08:02:10 +0000
Message-ID: <PH7PR12MB59976DDA141B0B84438B104482AFA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231109052629.550827-1-lijo.lazar@amd.com>
In-Reply-To: <20231109052629.550827-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB5925:EE_
x-ms-office365-filtering-correlation-id: 1d6a82af-ac2d-468b-2bec-08dbe0fa2ce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVUEhyuqfwl7Uxr8AndPLEMQJHWbA7oR/16tNxIeCFDQyq1DT1px5Aw1sRl2JH9aIAbZvZCz46eE/WixCnMj4Kds+1THISRyy3RoRDy9LH0+rsv2GbKQyhO2nUHeZ2p+eKity3HJkgsZPzEbe9uVznY2hPWfj+HMLj3csdDPkgkzFldWMwlBpI/gGJ2H1AVoJrY5PDhi4SI3JXIVUcOG+6mnoiEngBn6fmJ5MzIl7HZYSwNUtXTwfl4/TVi6cnqS/Qs9+z3WayO+uHcbyI1Cqydc94ue+VnP9s6ArYfbDMnWQC/+gS5246SZoYWyfxE8MUS8mQCt8X3IB1YIYEOkHL8kAhEol/VOjQjOywLJdAl8XkA/OKK6HSYgqHDi6Q0zEPTKYd4pogQKZN6rlrwnQjDjxGy4vvp4gfdAfqb3CS/nBo7m+uCV4aC/8wLRCl2tKsannSugXz6k++91ippuDwCtQy55VuKo5CGGY6u/V+0vLBZeOyDHW+651Fo8e4rF/SSe0AVYhmMmlz78V4boGuf2uIrwbgIwIjT8L/YZPqTui7x8ygYlJ82RBRUzbVZVgwM5eNsRYtIC4HdFowNz2cLmqwcSRSJpLdk9z8fuI+J5DtHv5NYM2i0EiTTBkY25
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(7696005)(478600001)(6506007)(38070700009)(86362001)(122000001)(33656002)(38100700002)(83380400001)(9686003)(110136005)(26005)(54906003)(66946007)(41300700001)(2906002)(53546011)(71200400001)(316002)(52536014)(5660300002)(76116006)(8936002)(66556008)(4326008)(66446008)(8676002)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1tGxavR0flqEq/E5EQ8juupYH9N1cs8pTwvJBn4MBgkJkcE6SwIKPsO06+U?=
 =?us-ascii?Q?v690cC/1upcnn2K5z1cxxEXXeicMWO42G8FKijFXrO3c3RoN8ROzGnb7ujrQ?=
 =?us-ascii?Q?OQfO9CtMS64Myofdtiqss/FnMNpBAvIg5u19QdNXQApf8PVKXlvNe9sbdXed?=
 =?us-ascii?Q?oHNtiBgzMPGlulofWwCYG4CkdTLX2I1aC/jBLbA9C97zQMrkTp8vv/ByCivk?=
 =?us-ascii?Q?b4Qv5AlgeBGCh/u7MvUClmZwJtpdyZgjEut/WOKLNbGsiV3zoSs1s0ZK5ncr?=
 =?us-ascii?Q?R9dtpWDcgXurHNKTivEmhrm+ROSWtSVyihpzxs6NCIB0gqN1y7YvgsKkt8z/?=
 =?us-ascii?Q?8to4UtQhRYChHIFgqfQeGj8ua5ex6dBoQ6KxPE8J2KUkQt28u10Xt0HwRYU+?=
 =?us-ascii?Q?FYdMR5I4J3oMwhS/i2WJkUx98gwTIVnW8GAgwg1br2qtyN8UceyHJeBMVQH9?=
 =?us-ascii?Q?tHHGoEjxsm/nIGzjkfeuLEJWW8Q9+3vh8lTzF1uDuV2ZwqyvfL8lwG+YmuGa?=
 =?us-ascii?Q?lMIs15wr0ppbq1iVXJuXhCB2IS4YDKF2pp51I4uh7NZUIc8Wxq0zR3eAf7i9?=
 =?us-ascii?Q?NzSboLYvL4zO/JV+zird+b5mgC8DjE+djUTfXORrpIdyq8yQeOEor9Sp5rPn?=
 =?us-ascii?Q?3/XFtWUDF2+5E80tiO8SKSU3SUZu7+qZjEtfNTZ1d960Nmva/ijI6ILvuH3D?=
 =?us-ascii?Q?Tp9GEAMMDDNmX/TNsRgys17R5lvH/3SJOclyiztgHdRAgLQUnhPObK9lMODE?=
 =?us-ascii?Q?LTX8nxEbaW/fGE3ZEuLRaNLekNHBzdCVLwLDZRsjITMgazel8pmy1jtlzwBc?=
 =?us-ascii?Q?xcYxchCZX+OH0q6d4crQ6xbML0H7e9b4aF1KLQXR2WE3mRCFXimw1IwSKgIY?=
 =?us-ascii?Q?05mEXIV2FmfUK/uXXUvYPi8GHzN67DDh8RBR4BiH6r0WPxomMLa2+W8gZOsG?=
 =?us-ascii?Q?Su+Kwrn2dae7dJn+W1Ge3R3eoIi1aGp3AZEWVTk1yN6n7hd1EqH2Ab6ELKU0?=
 =?us-ascii?Q?hh2S+ZifgKjG04jQMuoG2iKFBTA3+025q+VaT7EZ+guDSb9twvcin6bx3cdu?=
 =?us-ascii?Q?ApeOqpei80Rn9iE9uY5QY6HfUDpdPvN94FBmCxMUuawUr9oltvTcVbHeBCci?=
 =?us-ascii?Q?Deq22ztIvJC8MCmNtK4EjRvRxYhq1vPONfQiCmIGZowpYMifYjACZM62FRsX?=
 =?us-ascii?Q?ug/2Cpmhl1kc7QZiO/M3pz/erJIaNYxUvoy1Uo+/7Y22kc1dGp148jDkWw0y?=
 =?us-ascii?Q?dSPBbQxyuTWoFAgPyvqjSDgLjeCpNu6UzPqACWgRuQY7ngK7fae0a8Zj8Duk?=
 =?us-ascii?Q?vg7pTCYSJbQ0yQ+MIv93V231qk9v1L+AhRuM0BuX08PeSx7HxqqjGveupCAr?=
 =?us-ascii?Q?t/JNyJ+fOg3alZE1UaPYB1AnpeGZSD5AKVCkacW0ba/VILVooOtXb+51kVJI?=
 =?us-ascii?Q?OrM4yajUSDZ46PSGFQYUtL0uqFICdOhu9WMVuYqwLaG+zrrmzCUyA9qXitok?=
 =?us-ascii?Q?qRHDZ841eo/ef847weGDHd8Td+McztYBr4e4SkuRRWmWrkzF3yB9ukWl5egn?=
 =?us-ascii?Q?26J4jibY4u3lS3QeINw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a82af-ac2d-468b-2bec-08dbe0fa2ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 08:02:10.2051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 291TWBmN2xUjwnEt4LQZIYQ+WjJnw6Sta+uIvenOpkzcMMSHVtaDVPgkZ0LXcwu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Lijo,

after our private discussion, in driver polling mode,  the RAS will return =
0 error count in driver probe stage (at that time the debug mode is in off =
state).
In the case of driver polling mode, debug mode needs to be turned on in adv=
ance.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>=20
Sent: Thursday, November 9, 2023 1:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Zhou1, Tao <Ta=
o.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Move mca debug mode decision to ras

Refactor code such that ras block decides the default mca debug mode, and n=
ot swsmu block.

By default mca debug mode is set to true for now.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 12 ------------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 5a828c175e3a..cb51a46e8535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -218,7 +218,7 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u6=
4 val)
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
 	int ret;
=20
-	ret =3D amdgpu_mca_smu_set_debug_mode(adev, val ? true : false);
+	ret =3D amdgpu_ras_set_mca_debug_mode(adev, val ? true : false);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b7fe5951b166..b2e9ed65a061 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3120,6 +3120,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 			amdgpu_ras_block_late_init_default(adev, &obj->ras_comm);
 	}
=20
+	amdgpu_ras_set_mca_debug_mode(adev, true);
+
 	return 0;
 }
=20
@@ -3375,12 +3377,18 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev=
)
 	return 0;
 }
=20
-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable=
)
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool=20
+enable)
 {
 	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+	int ret;
=20
-	if (con)
-		con->is_mca_debug_mode =3D enable;
+	if (con) {
+		ret =3D amdgpu_mca_smu_set_debug_mode(adev, enable);
+		if (!ret)
+			con->is_mca_debug_mode =3D enable;
+	}
+
+	return ret;
 }
=20
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev) diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_ras.h
index 665414c22ca9..e1e0fc66ea49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -767,7 +767,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu=
_device *adev);
=20
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *=
ras_con);
=20
-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable=
);
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool=20
+enable);
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
=20
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, diff --git a=
/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cecd210397d6..404db2b0fb71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1524,7 +1524,6 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_=
context *smu, bool enable)
 	if (smu->smc_fw_version < 0x554800)
 		return 0;
=20
-	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_P=
OLL_MASK,
 					       NULL);
@@ -2346,16 +2345,6 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(str=
uct smu_context *smu,
 	return ret;
 }
=20
-static int smu_v13_0_6_post_init(struct smu_context *smu) -{
-	struct amdgpu_device *adev =3D smu->adev;
-
-	if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
-		return smu_v13_0_6_mca_set_debug_mode(smu, true);
-
-	return 0;
-}
-
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)=
  {
 	struct smu_context *smu =3D adev->powerplay.pp_handle; @@ -2945,7 +2934,6=
 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
 	.i2c_init =3D smu_v13_0_6_i2c_control_init,
 	.i2c_fini =3D smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num =3D smu_v13_0_6_smu_send_hbm_bad_page_num,
-	.post_init =3D smu_v13_0_6_post_init,
 };
=20
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
--
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2339CC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 06:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D264112CB2;
	Thu, 21 Jul 2022 06:22:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1A6112CB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 06:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N230RZ9jK7LNIDC4I0JGyyQvIH5ALgLN3ojOEHVNcRwi1DQ7o2y90cBtnb8WvCIQjKeSh9gF7RQiTySSC7b8G2SpR4iaB/q10HrMmneTg+FWHW1MtbnQFXVlXXFTrFsteppjizB85+37tv8J2RXpXZeDeTOiQg7/beKFqjJfo3Mt3ZxwRUsnVOcPCC0F6actfLiIBH038CkORLzOe1eFXvDGLBpZtS6lA12MUrwxrCvCuzp5j+6VnngA2nbgZjAEIaLfi1mFrKpi34Cqh10SEMYi0lrWxdMRoAtysRnd6TcWxfVx8Ffm2rtQKwYSwUhJPPhoKzaekr04g7G954ffjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzFfPp17QncHaodG/ctCD+sLcx2ouPl+93DakcnbTFc=;
 b=SO1mUge9GWcf/06SeQE7Z+Idsa9vxdU80JQ47Thi7pjjBRh8R9MkxlJwarWAz94Ox/Nh60u+ml8vb1x+B/qHASR1HFiC2Ae8hhLAmJGT0fBoKSiYvFf+zXGy8LMIB7IC5Wug0n1ICt4Cwk8xu5DVwg68sx2iP4lNPv24AQp4R5VW8AMCBnv1AcqR6Gt/kLLOvAv4IB/DdcaPeJ1j+vuZEjUHS3MzC6yRiPBvNeEd6xQR+RPlJwxeHJZnX2SV58VsvrzInC5S9ZGfXXTtjnESqOs/yyBfzeO0K8GG1xVZjRu3o9LATmZt/XCB81x8N5GIjO3mBFIsK3GGXiCaD6v/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzFfPp17QncHaodG/ctCD+sLcx2ouPl+93DakcnbTFc=;
 b=YVh70N/Vv4MoG3Ql17CwRsb0/R7CMe9zI8ATAXW6mh0sIu6D021CpVyc5Kx3y+nvH/WvYw1ATBJfhq+Vt1MRx+49fTG59lrUBmTZpaKVHmns8bQOtCA9sntrwS4VYpw2QAtsbfni/9QJowfAQbpI/K/ZftRtuH6Xso0VClZApj8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Thu, 21 Jul 2022 06:22:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382%7]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 06:22:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Guo, Shikai" <Shikai.Guo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
Thread-Topic: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
Thread-Index: AQHYnMn9LcQq50Oi9EqEInohKjiRe62IWt7g
Date: Thu, 21 Jul 2022 06:22:28 +0000
Message-ID: <DM6PR12MB2619F1442EF61A61F0C5D405E4919@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220721061942.2517331-1-shikai.guo@amd.com>
In-Reply-To: <20220721061942.2517331-1-shikai.guo@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-21T06:22:25Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ac3b20ca-ce3a-405a-80c2-038eebfd76a3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bad56a4f-1213-4adc-ba2d-08da6ae162b4
x-ms-traffictypediagnostic: CY4PR12MB1752:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gL9X2OgvrsreNfQwQrlEwTaslVmI5soBS5tRj39IgA04ZCdeOQZPv3Lv4Q2H7xV00iJQNeQr802B+QeI1wKfZVcJwmzVCXerKIREhqj5gLvd+4Pd10Kze19lGJJ7EyBD9n/53dvPkI979awGaPiwsagPNewaVW9PPcXT1Xn8rhKcTyB2swtuq7bcQXPhq+RwaED/wOiioesztuajPeSOiWIG/eD9Nz+d30gRFzRh06JCmKC9RvLAmAo4Ky6pjVuiFFL+faD7BiPGlxLSgadjhkabVyxyNeoDUqJ7GaK4a54D6qw/lBZTA3WHO+amWrm9O04sUO6XqOgOFjWlZc8fYqgIuuYa78RMp6e2HZKF6iAofkVCCjKF0qF91EfAhPeNtZIcnEVUykTJNQWunvO2UGD1zIn9fNydGESwkO2CaMjfNjXOc3eTThINqk6Cxnl0H9dHkxEB6UAjDyR/7VI7aTHfDedwdc9PKsGCJ2Ysxr+srE9fIgmyMuIpwf3VTLFYw2evqWH9ViNWRlbrOokZhwmJKk1o67XESQEspc3tRkaZoUqAWXcRxxZKSmmOK+tY3spfjuODTtdmTe/SeRilwgry7nS/CLaI0R0ZNXaPlCdqJgV8rbZ+rBZC8aEL7Eug6oVtWeNkeUFzT0IR6z0cxy11w0PH+fev4ogFYQQCNP65IWgmZd6OspGD/k8ZNo4h/xPK/IVBB0UqhueYrNcjssdWdLEXF4fbFspfZJSW2WCDzSzvuKdJk1JpPVz8SO6kimNzYNGr/tVAqsIp1CF4SRJmROepkYwKWSGCJFBoHkGkKPHwicj83kfS5vfwJI91
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(9686003)(83380400001)(122000001)(41300700001)(186003)(2906002)(478600001)(26005)(71200400001)(38070700005)(64756008)(66946007)(8936002)(66556008)(76116006)(5660300002)(66446008)(4326008)(38100700002)(52536014)(33656002)(6506007)(86362001)(53546011)(110136005)(66476007)(7696005)(54906003)(8676002)(55016003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syBlrj6LHyYSnPNUp2k8ESgpVHdKdeZJ83dpkJHMiX59vmGiLD1CoK4zG5ld?=
 =?us-ascii?Q?wGZRoDnb1jBbdOdVt0dmq0PnnU3N4fyvX/2+TDsMCRDCXIU8nEibA3rYAKsP?=
 =?us-ascii?Q?pR4h864E0FGQL95xoXMWJQs+4yvuZPdbCNwtqERg1wC14KI17d9U0xm8cRGh?=
 =?us-ascii?Q?sB9Mu9IUtlmBd0grnVXwnJU2p2wTXGT0Vt3VurBNJjUIQHTBG+kPetDaxsRR?=
 =?us-ascii?Q?phRlcfFe4FhAUTa2YhS6H1yuGuksiWYZtTkEHUCtdVJESS43VBEYEdf4GfXT?=
 =?us-ascii?Q?4tT7OV2rQzL+FDft/G4NAQBHGBf55d3nLQl4wH5hCyzrHMw4CduXb//3Aneg?=
 =?us-ascii?Q?vKmZ4GXD+6GbySxUDEdjmFeud5L3PKB7wTZ0S/JLBXK1KPLzy4Gbe6naAfEg?=
 =?us-ascii?Q?gmeHeOKFYhOg32UqrlDMS1oS/m/V37AuIKi+MseAWiffsUphg30Kc4seCD1Y?=
 =?us-ascii?Q?Yn4YDXAcDYGU0sGh47GOpEx4ZixC+Y5aV50eDkFhvBsRX9PllW6gKUHdV7xi?=
 =?us-ascii?Q?3Z9JOeJncWrJ56HJM4oWSjlEY4vp7kfkEiO5fwmw3fU8NkzXWnYd8tgNa89U?=
 =?us-ascii?Q?G2OmSfQr6ipkws/5F8WbQSPhrKlUAu54eR/SBWoeurFOSd0gLs6zh0quA6Oh?=
 =?us-ascii?Q?p4hEixwpdbovVoNHvoj7x0sIm8f0SaJn3ltBSyuoH9wL8aDHBLtM1kD0af9r?=
 =?us-ascii?Q?gvS1gvbEJB257Y0NUr+9hK3WDofI/C5QPfRpKMJoeyWKlhQkXkt/1kzHJJt/?=
 =?us-ascii?Q?OtXEIsdxlBX/CBWABmaBxiB3lntXfESfx/yfnL3ULlx8NDWh3GhKKlCExJ1J?=
 =?us-ascii?Q?F/njyKly2FZobooaP2VLThf0u2EPzKLpRGvZ+YdJYRjI/JIav0U87VXFUpDS?=
 =?us-ascii?Q?i8yeQHxNcLayBzL/vb5ZsxHdboVK2mlj+39mWdwrrVtG21PomDaWUOkuG8R5?=
 =?us-ascii?Q?+XqX+Qrj/qSQntoMXo87jFD8nAaYfAb4hC3agz4oDO4XZt47G86ZV2bmp/wk?=
 =?us-ascii?Q?Fn1n/Kq0Oc2fgoUycXlr+hcnC/K1sJnPLeTcZ7WHsllesgbpJoIYvGp6WZoy?=
 =?us-ascii?Q?ueqodo32iyqf5ujI5U3dle+m2jo3pE0oqTum49Ru3Tsns/Cz4S8dDqjSLGYA?=
 =?us-ascii?Q?XLTwA7/+xkfyJAj4syRg2Gw8CS5ER3OLlyafzRil/O6fojoJjjgonq09CCe5?=
 =?us-ascii?Q?WzywG4cVSDijpya7gvbmU/3oEwCWd+zIZzDGjHKXx/WVJaAJp/IA1PoRM07/?=
 =?us-ascii?Q?kxbQfP7E29wLr8a3B0Ho0BjiiqMAdJ74R6oN+5xXAA6WhOELJ4C4QlNTtnHB?=
 =?us-ascii?Q?3lZGNNxRPN00gTDkMzNo+o2EZRm5y/kvpc4X+GMWjFa2tmS+q+wZfrt/PDgF?=
 =?us-ascii?Q?KD2nxYzlp3iRiLDoMXhRopCYvvlkuKOD64afR3V0bDB7JLnzEP7JeA3SbEWP?=
 =?us-ascii?Q?ekZ1hxVh4TKJUQgUZZV2Wliaug5LMbfW5aFbDrR2/zfvLfoWB9FJEobf91k4?=
 =?us-ascii?Q?E+vb760OYcLqKpDJPg/JWk+h8e250EwgZKIiIxvKGQIKx3W9rB74A59QwFXO?=
 =?us-ascii?Q?bYCqLKxUYpPz2BfUVRQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad56a4f-1213-4adc-ba2d-08da6ae162b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:22:28.2387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lsURvKqrpKg0YIIJQrNJZWkKp0SaClVbsPWnC6ln3Lr5vdGEmvuoKLMdYrCxO63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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
 Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Guo, Shikai <Shikai.Guo@amd.com>
> Sent: Thursday, July 21, 2022 2:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Guo,
> Shikai <Shikai.Guo@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>
> Subject: [PATCH] drm/admdgpu: Add get_gfx_off_status interface
>=20
> From: Shikai Guo <Shikai.Guo@amd.com>
>=20
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
>=20
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30
> +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 70cbc46341a3..cac48121d72b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -31,6 +31,7 @@
>  #include "smu_v13_0_1_ppsmc.h"
>  #include "smu_v13_0_1_pmfw.h"
>  #include "smu_cmn.h"
> +#include "asic_reg/smuio/smuio_13_0_2_offset.h"
>=20
>  /*
>   * DO NOT use these for err/warn/info/debug messages.
> @@ -42,6 +43,9 @@
>  #undef pr_info
>  #undef pr_debug
>=20
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK
> 	0x00000006L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT
> 		0x1
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)
>  #define SMC_DPM_FEATURE ( \
>  	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
> @@ -587,6 +591,31 @@ static ssize_t yellow_carp_get_gpu_metrics(struct
> smu_context *smu,
>  	return sizeof(struct gpu_metrics_v2_1);
>  }
>=20
> +/**
> + * yellow_carp_get_gfxoff_status - get gfxoff status
> + *
> + * @smu: amdgpu_device pointer
> + *
> + * This function will be used to get gfxoff status
> + *
> + * Returns 0=3DGFXOFF(default).
> + * Returns 1=3DTransition out of GFX State.
> + * Returns 2=3DNot in GFXOFF.
> + * Returns 3=3DTransition into GFXOFF.
> + */
> +static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
> +{
> +	uint32_t reg;
> +	uint32_t gfxOff_Status =3D 0;
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	reg =3D RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
> +	gfxOff_Status =3D (reg &
> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
> +		>>
> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
> +
> +	return gfxOff_Status;
> +}
> +
>  static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)
>  {
>  	struct smu_table_context *smu_table =3D &smu->smu_table;
> @@ -1186,6 +1215,7 @@ static const struct pptable_funcs
> yellow_carp_ppt_funcs =3D {
>  	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
>  	.set_driver_table_location =3D smu_v13_0_set_driver_table_location,
>  	.gfx_off_control =3D smu_v13_0_gfx_off_control,
> +	.get_gfx_off_status =3D yellow_carp_get_gfxoff_status,
>  	.post_init =3D yellow_carp_post_smu_init,
>  	.mode2_reset =3D yellow_carp_mode2_reset,
>  	.get_dpm_ultimate_freq =3D yellow_carp_get_dpm_ultimate_freq,
> --
> 2.25.1

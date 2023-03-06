Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A41BC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 07:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A767710E0E7;
	Mon,  6 Mar 2023 07:28:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F081B10E0E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 07:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhVH0OaM6sW677J8kmv4p8jrdOILwarEklhEo3geaHivmE3YHgJb96UR8zQ8OKdYLdsm+rvCUcFLpSgfFc+qzrAMp4268T362OfUdLZc89L2n/34uOHThvbqapuFc+WQ9RyxzGXBg/ibsUSTc3M/lbsvQW8F2gEGlMWVe+Wm7LyDqQDDdzORdJ8uxvYBjUVapN0UqRdgkrP/4ThJMo+ij84V2p9zo/t5zRW9YSmCnyEnVR49EY1vT8Kgfa1lAwfWig3FyhcOmq232Nx4MNeLUogG3dLxkpBsGQw0wZA6QrXJVVOcobfcaneXsFkn7MFewb1IaLhXnxjX0C/kkkY3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL3K5YWAOs2ENL1byH6BSk0dTJylKWxDxOqjMTvlwtU=;
 b=mFi2KTdVb1FkI+HmDi9/fbF6By+6cBX2TY7zNc7HlgvLoAEN77EfKB9sTvEwjhT2Dbq5RaDd8UolTOH2GJUmVJ5jb3Vd1jeSj0phKrWq+UIcgPmLBLUedqVgtnxRlCU5UnRrwcciEhpBlDFbQeMe1IdK/4A9fObMPwGAnc24+39yE603E8RlMzZyidcAcou8lNuxFafqNetKLis2t0Ez3ibYbl8ouDdRTe9dne7Ao3KJW0Q8Kn4IdMGUaUmAs+7IGoKs2gTVFnYMPyakHMvQCZi7x/Uy3Np2WsYKnYVc2teSb3teQrHf63vonAs3rThfgVhsdOFPn2h9QH5S32xnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL3K5YWAOs2ENL1byH6BSk0dTJylKWxDxOqjMTvlwtU=;
 b=f6V4YSJZSr+nvitlOP3AHdQaXeGLX+EOclI+dzfvlguSnH2cpi0hslyatZEyXJuwvqWKfVO3aaQm5f+tx1tcndceWSYaVH0H8JoyUDawDAsM7FwFo4X+mKLhxCVKj0fdtdB2T84uwjDiFvhvIxaXtjqTVv0NYUcWSsRj2k7hDys=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Mon, 6 Mar
 2023 07:28:21 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 07:28:20 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 09/11] drm/amdgpu: Rework xgmi_wafl_pcs ras sw_init
Thread-Topic: [PATCH 09/11] drm/amdgpu: Rework xgmi_wafl_pcs ras sw_init
Thread-Index: AQHZT9QCNGRe4BzZvkeZBugCo+Q4pK7tWngQ
Date: Mon, 6 Mar 2023 07:28:20 +0000
Message-ID: <BL1PR12MB53343A77AAEDD676473B30FB9AB69@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
 <20230306023200.29158-10-Hawking.Zhang@amd.com>
In-Reply-To: <20230306023200.29158-10-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|DS7PR12MB8348:EE_
x-ms-office365-filtering-correlation-id: 549fe91a-49f5-4977-928b-08db1e145cd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXuM8LQUTjC/zIHtV4QCk4j8NOpCd1CPaswUKX3zhuqvUn3j1LnHWHUsIrA1xa/6igNBrL2EQQojZ06gHpsYBxTiqG1XQ5oaSK3eCloViFhLCBj3KD8lP3956OoQNgpsylQaf51arI4f2WsFJXFTvsXjwnWnLXre10p37hKGP5xPfGuPKtmAS9VTNM1t2z/yFC2AqVSKX8yNQwX1HvceRYyzzCTvmpdLZwLSlcxscEllF0iHkT9tfnNaGzM3LEj4QOOnkbpi4/KNLdhq0l8UKEG3U4Zt8sSr1ENk3n+gC2kxuH1sLeAUD+MJVEmCKKPpCCfPf5TeX7YLz7wjQEfUFtgSB8bzrBr0PmUZ1lGlILkE7ETEuM4EcXLfjk+Nb49W4yvHugPYwrtK8dhbQIBj9dMR48BTfD1m07noBtE7w5l5B2vun3GA9OPW45vn7nlBHOA5wmGoUoMuHf+VD9rSuuiSvekpcSdSRDhh6hd241azNtcdOa5gWK130NcwtlC5oluvJOjMqXsO+eyIcRCss9QTiqOS/AmZu+pH42r1cLwWYFdHAUoLr9KILqOC81gtAha2mI2Zt2oPuZpTQhFo8bzeujZdINPYvXnq/1wQUofiaAXOuK8QK4qEaA9osDxh40Y21LsEHhWuFHAFzkIhuUCY864M1ViTtNClwIuQyGJv1JLtIKYe2z6ANAGaP4Cd4WiyVUfxLa/oap30nOkECQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199018)(26005)(55016003)(53546011)(478600001)(6506007)(7696005)(186003)(316002)(110136005)(9686003)(38070700005)(71200400001)(6636002)(8676002)(8936002)(41300700001)(33656002)(52536014)(5660300002)(86362001)(122000001)(38100700002)(2906002)(76116006)(66446008)(66476007)(64756008)(66946007)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TvMm6NpNJfInasmA8fdKrsu7BJvSqa6/TDiihcRx0i3lE8RnTBq36Lwac1yk?=
 =?us-ascii?Q?VWUmHIRlwOR2XAiIGUYQAD7xFX+nqf8jncYYKQyL3BNtqrBa49P7I2GuKVQT?=
 =?us-ascii?Q?/br39MnxmZsx4cx3eetYsdhmzAmPT4HdHX4me8WvifkpaolB7N4Sqc24jLDk?=
 =?us-ascii?Q?/kjZ6LpuaePJV5IpPnJVcg/zqQQkn3RN1kj7amrkv5KZcdqJ72O1UD4YGtse?=
 =?us-ascii?Q?MMhTiOq0/5DWq7uCq/EJiGhGoXtgv57X8U+D7+5D0QMC7RFRoyEZeL1UP4j5?=
 =?us-ascii?Q?ThOYXAg64ga3EFEPcJfZsstyETXprHyI4dU7ra9KVa5+nBTik1v380X3yMGS?=
 =?us-ascii?Q?K+vX2xE5rT/QPB6Gs6VWJDIWrMWCDXMmrSWiQw7D8rZM0MI7nPvHRqutSb2p?=
 =?us-ascii?Q?cmkshwZdIvbn1U70lmRQQMxM04HH38M8+NtzkYQM//2hZABJKJUxyfNNVRbz?=
 =?us-ascii?Q?//On4Bg+EPaV1yxdFIMuFXo/0R+WZoDmpE5sqNZ0mODF9yQrTETEWQ5bL6iz?=
 =?us-ascii?Q?GNJ4SQamOQVwvaVUxRBAUr2ZuCL7IMekqVuKf7PkNaz21Grllzmyncx5mTCR?=
 =?us-ascii?Q?du0WA3Y29HlK1kR8Ai2RM/thoEaGtbpHoK2XZH8Lk1niIGOzp8aPKIlmn3t0?=
 =?us-ascii?Q?Xdg4oVD2ag851i3H0wrPi7w7z3uPOO6PuMmhyi1cndV/Yl4tO9396d1NZ/It?=
 =?us-ascii?Q?QWvPqwcZlNtAu3g4fhNMbacoINzr6+Rw2n1O+umez5K/OP78LUnQ3mSsHUzL?=
 =?us-ascii?Q?SvB6febFXij5KQVbMjiSrs0HeDfOZvE9DfYlH5iw+QHH2Y5Khv6S7rS2loy/?=
 =?us-ascii?Q?VrtJ7nN77MEbQFCWKmZDhknBLcsw9FBDFAC05Xvp+aMP4+fpSyvF8rzHLzRZ?=
 =?us-ascii?Q?nDwCPPGjgHhO7kHpvJK6EDO4m4INoQPil7afn60l6KpCnT3Ll7ifJ9ET8Bye?=
 =?us-ascii?Q?JFvo42dYeLp8QhLkO2ExferEBL56UMX4wFpyqz+m+ijlwjBSU/J0VuDKkwOi?=
 =?us-ascii?Q?p58BXkBN9flnAgG9ZfQDbUbD1MtwSiT18HAqRDafBhOEHbluKgDSLk3hNCcZ?=
 =?us-ascii?Q?XL75sQnsoQSI99yQ8OpwuEzpzQGwvRtWAx9ooLiJWqJVxbdCzPi6ctyswTr7?=
 =?us-ascii?Q?0v1o8uTQY1IYrYUbhx1KdW9cylSqHHFuLpw8Ki6oLGaIjN3duZVc7SDCDswc?=
 =?us-ascii?Q?MX2uf1zRkYZvBkiMPeeZ0a3vl773ASLmTs3VeN9WGMnnECbBdayZD2aiRM1h?=
 =?us-ascii?Q?JnZk5I4ILscpUV2sHcZ14sPzcFg6FiwVizL7XrjaLrBhwrt8WbkcgROQj2Na?=
 =?us-ascii?Q?m35fP1CppT+2xB3iyBcitEf/Cb6dchy08VOEPndMVD2cW7ux05MRgQCY1+AD?=
 =?us-ascii?Q?hJLALugNQEe903FX/Omnhw9kjEfO1ujosI3C4ODH3G3rEWFKMGnieS/v+b4m?=
 =?us-ascii?Q?1rcheZHZ8hjgbnQg78lb10vudHv9kfFxnTukIxwHFL9KXldNYhXsQxofQSY/?=
 =?us-ascii?Q?5lsLlcuDyR02f22S++30nQle7Lqg6gdtc+0JbkenZJnil7QoR13HuBOknnUK?=
 =?us-ascii?Q?OXiNr4n0dfxjRc68dPw6b9OmJRquE94drT35y27A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549fe91a-49f5-4977-928b-08db1e145cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 07:28:20.8711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Ju8nYGllcLaISJFwhFLpW3TKwK9JdLcsP3guuKLauFCfSWdwoyiYg5+9VQmRoxNl5rGNzZ7i817dqHio24h1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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



> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 6, 2023 10:32 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 09/11] drm/amdgpu: Rework xgmi_wafl_pcs ras sw_init
>=20
> To align with other IP blocks.
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  9 +++++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28
> +++++++++++++++++++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  7 ++++++
>  4 files changed, 37 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 524e2c9b3012..d4685d22be60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -500,9 +500,12 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device
> *adev)
>=20
>  	/* xgmi ras block */
>  	if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__XGMI_WAFL)) {
> -		adev->gmc.xgmi.ras =3D &xgmi_ras;
> -		amdgpu_ras_register_ras_block(adev, &adev-
> >gmc.xgmi.ras->ras_block);
> -		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras-
> >ras_block.ras_comm;
> +		r =3D amdgpu_xgmi_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize
> xgmi_wafl_pcs ras block!\n");
> +			return r;
> +		}
> +
>  	}
>=20
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index fef1575cd0cf..3fe24348d199 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1048,12 +1048,30 @@ struct amdgpu_ras_block_hw_ops
> xgmi_ras_hw_ops =3D {
>=20
>  struct amdgpu_xgmi_ras xgmi_ras =3D {
>  	.ras_block =3D {
> -		.ras_comm =3D {
> -			.name =3D "xgmi_wafl",
> -			.block =3D AMDGPU_RAS_BLOCK__XGMI_WAFL,
> -			.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
> -		},
>  		.hw_ops =3D &xgmi_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_xgmi_ras_late_init,
>  	},
>  };
> +
> +int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev) {
> +	int err;
> +	struct amdgpu_xgmi_ras *ras;
> +
> +	if (!adev->gmc.xgmi.ras)
> +		return 0;
> +
> +	ras =3D adev->gmc.xgmi.ras;
> +	err =3D amdgpu_ras_register_ras_block(adev, &ras->ras_block);
> +	if (err) {
> +		dev_err(adev->dev, "Failed to register xgmi_wafl_pcs ras
> block!\n");
> +		return err;
> +	}
> +
> +	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl_pcs");
> +	ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__XGMI_WAFL;
> +	ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +	adev->gmc.xgmi.ras_if =3D &ras->ras_block.ras_comm;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 30dcc1681b4e..86fbf56938f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -73,5 +73,6 @@ static inline bool amdgpu_xgmi_same_hive(struct
> amdgpu_device *adev,
>  		adev->gmc.xgmi.hive_id &&
>  		adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id);  }
> +int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 67c2a5186b8a..2a8dc9b52c2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1381,6 +1381,12 @@ static void gmc_v9_0_set_mca_ras_funcs(struct
> amdgpu_device *adev)
>  	}
>  }
>=20
> +static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev) {
> +	if (!adev->gmc.xgmi.connected_to_cpu)

[Stanley]: Can we use if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__ =
XGMI_WAFL)) instead of if (!adev->gmc.xgmi.connected_to_cpu)
	    to keep the ip ras judgment uniform.

Regards,
Stanley
> +		adev->gmc.xgmi.ras =3D &xgmi_ras;
> +}
> +
>  static int gmc_v9_0_early_init(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -1404,6 +1410,7 @@ static int gmc_v9_0_early_init(void *handle)
>  	gmc_v9_0_set_gfxhub_funcs(adev);
>  	gmc_v9_0_set_hdp_ras_funcs(adev);
>  	gmc_v9_0_set_mca_ras_funcs(adev);
> +	gmc_v9_0_set_xgmi_ras_funcs(adev);
>=20
>  	adev->gmc.shared_aperture_start =3D 0x2000000000000000ULL;
>  	adev->gmc.shared_aperture_end =3D
> --
> 2.17.1


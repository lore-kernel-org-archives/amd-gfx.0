Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168A1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 01:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44B961501
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 01:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C44B961501
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3192D89F63;
	Wed, 17 Nov 2021 01:49:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508B289F63
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 01:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0wAeBBlAHfSqatXIsyX4NikLG3zUyTr08RzWfyNhRLCh2QDzOkLj27vwzUAf3rqP7QkeqwcrfUubyOPZapEehofvlsgEgC+Ao8l7fSKo+xXHnPS1jsnOQqAwsO1+QTxGo5DAI4EvC+Rnp8hZK2r7GYgXkxmW9mnulp/EHNBvIsMarws5uddjADXraUppSwFe+4M0BtacPrculFRfgqQQ/V5eXcx/zchgbq1EPKkzUi35un/LZH8r0TymkDEpYy4YlbLp27NjW0r37pGg4WmPse7XHH9/6vZE51EkvW1uN3xyKUj/uHIC7nV1AnXXJxmo+9VcLOse77eWjX+WQRfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFdS08VmyKJY3vxTwLmqddrPtkeLw0gcJ722dM9ppKo=;
 b=OtKC66CF28Bn0JKX6B2DZw+CoBwju8TzToRrMhPFCvG8EQCsYX3io8jC3AZhZDEywU1M0gWSD+S+H5/DotsXrJtj/D4OtJoE/1la6iPmQhbM6fzmbiP0ixREf1bivvt1WMsc0ySvAwTnJ/a/fZXyuTVRR/NOmEXic7dgnhMsogV37z0dPaiUNlSI2E95ZNxLcK1aN3LUEo5MnnNdS7HP/boNf0mVgGrthurZQcRkOgYTjGiRtzmOUBydmnxfNr/1iomjs+DmaqvSc6po/4KNJnnsdq4qslO+NQNjyc4rrk8STdxp5jyRCodAYv9JPQQtd8+2MT1brzgRrF7Ow7Zotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFdS08VmyKJY3vxTwLmqddrPtkeLw0gcJ722dM9ppKo=;
 b=yPiqN4Pernv9yT0HItQCG0nn6NcZw3YsfA2uDsCXh2cHj0tSkJVu9F/uyoWR+mpBZdWhePXxxfTZxxtoaLLhJ/+ihZoDfsMKgchPQc3+sVSJR5yoHvztENTcUMfAaPyQbhYSFvq7UZFGpFX8TnvdD7ihmyHwbbIhJo6jvHErrfw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26; Wed, 17 Nov 2021 01:49:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 01:49:36 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Thread-Topic: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
Thread-Index: AQHX2tTp+WHT/BIDiEW8NjY885+scKwG9NtQ
Date: Wed, 17 Nov 2021 01:49:36 +0000
Message-ID: <DM6PR12MB26197FC5FC5D094BC9D5F33AE49A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211116102855.3775-1-tao.zhou1@amd.com>
In-Reply-To: <20211116102855.3775-1-tao.zhou1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-17T01:49:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=46456e19-d113-4f15-a6da-22b65644b5a4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a48c9ad-8d63-4a18-aad1-08d9a96c82be
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB32743F3B12530ED35FEB71EEE49A9@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I0AF3Kx4NNJj1fIbLKYhIwG8shP3COoU+LmUyWi+DjoKi9bc55FhgX0rId9wyZwfkzf7/4rAEVNAm3X2AbcaPGDDECqSw8BDLaR8DVHMPHG5f/B/q21cXw6XZuv5vrA14MrECdFobXhMFF34nuvUaZJt1nf7E2CvslxXTrYDR6yxc/KXLCYH44jqQMtq87DubP4ux3ORS9GTIX/st0p6r2HMy88B5uQwDiAuFFyzAwql/OFUArkOYrgir4NjHxFtFLYRUz+L2rirB2CtLo36lyTWMg1rNZBmjDeVlbakGowaHnP6ypihK2dzAhpSeQXiYO6N7i9EObL0dcrYbbL5iyRG1EDlrjS2cbLl7dY+tlryQbOxr2XemrOIuq2dlAXIS+fsDK3AhvxQnAM84x0bJpbLSACyYb0C/8oqIHgfczlFZyT0TNkf7NxeST2fAm/GHNfk5qMJqZiOVyj38A1ZD2ehVTlvutQrcpIHSEsBnMKg4bL5EcSId58cSYXgr9DWAFZLWQyeF8ViKcNMgPTrevJo73hhOP3dyhGMuQRgRUclE+WKB4Icmr0/YxxIURDIc1chlUfhtviqUloprEf9bElpLLzZW29ffabHM/+l/0upPFiL8ZuefUtz4zy4uSJsHFNoE3XEQrs7u3wJ61s7mcjZafG5CFTQgiXoa7yOeTob2/QiBnwZuNXxnYwQYdHogpWkpFxPVO1D0uQjqob98bRe6ZfV2HJp6w52kFSKNKo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(6636002)(86362001)(38100700002)(2906002)(921005)(71200400001)(38070700005)(33656002)(508600001)(53546011)(9686003)(55016002)(6506007)(7696005)(5660300002)(26005)(316002)(64756008)(8676002)(8936002)(52536014)(66446008)(66556008)(110136005)(66946007)(66476007)(76116006)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YE32010EJdgFHCigkJSO92TbWUMFBi6SRKBQw9spWDDvppivs2mrZqZHozGq?=
 =?us-ascii?Q?zGSXRPm8YonBZXD5w54ZNECNHOLJSZ0xGcq2mOO9uhfeYvEipMrVJcXby3mL?=
 =?us-ascii?Q?DXnwsIm3iUzZeo3baGzl4gPXCM2E1PBsdTYthOEapnFGOe9rswu5c0KZW7yO?=
 =?us-ascii?Q?AgJoqnwgg0SpfHqyZ6E8ynHHD16CJM/Iju1Kptoi8Vw67SQcWggiNsQXGNaU?=
 =?us-ascii?Q?JXtyoQareikcgc0xVeCONeXbfNLYySi0tYgN+zkRffK6jGqAWmqg1jfpbZV0?=
 =?us-ascii?Q?cBUBl/URXuQLlmqNOBHwoG5GbjfjuTvGdcejQ01H+F9MpcNwl4+rg33AXuf+?=
 =?us-ascii?Q?+NiAC9cGxWO0zJuaZhgAs7F2vpcf8TekQ/JVYRWxZg1yEQ/k1HXNsPElMtEF?=
 =?us-ascii?Q?OfZRqHKGnQh3JVNVT7yNhB+PNkE71rtps/kEk1H56R6v7KOuOxK71WURkjWI?=
 =?us-ascii?Q?ZtuqjOdsC9TqmbhGcK/QCGm2gZrhCzvf3k0vAN1R0BFWG67pkLwk7fLA1W0g?=
 =?us-ascii?Q?JR1Y4U0anHjFnqUpTn29z2IY1alpf6rvGelVkUe1kveyqpgGSk0Bus2RjVhu?=
 =?us-ascii?Q?UATt95JSgHogDOHBYiLFznV8HDa3bG5tvpF9v2Bg7o+wgQipuTOtPDjqfwz0?=
 =?us-ascii?Q?J7uE2n78gc16NfLEUdmQ8d8atLH/arlG1KpzsZXUh71PrLbuG3UUCyMyCI53?=
 =?us-ascii?Q?JkNUhi/Z9+F5w3v94fKzgsaqMTDcOAXFj24o9/vuhUwIk/P7NclZoiI3dePl?=
 =?us-ascii?Q?X919mZMlU8BpcpL+fFweyJLPsO0RSHxHSAuj+wBqaG4xSZfdaa9rWskWYhVf?=
 =?us-ascii?Q?gRKuzxtuy5E6YzuFCAKHeW1cAdXajnSjSU0XXekfzSMk1VdjtbYeQyDZrZXw?=
 =?us-ascii?Q?hBD3NTWpFk2sZKfqUXN1ete5zKjkAS3VxcXrlggVcWKJ2/Now5Yc0pfO9weM?=
 =?us-ascii?Q?L/Yd2pCbvl0wD2QfZX4XMVw1huphYMVhnRmcVNPyyBK0bV+L0wFakT27Mtm6?=
 =?us-ascii?Q?HjxU/mE4xd4iyBDVfbLfdU2s5W2P/mgWtve84gcmCZeU/2m/29quCm1UvCNW?=
 =?us-ascii?Q?ODH5GsAsjglqBKhsUzq4342TXf5MdEal5q0DeSCJ1lQmD94Ot4ba5jd5kMxl?=
 =?us-ascii?Q?rS77h7yzm0kWpu9W5b2c2zX2fNbs4x6FgQ/qmhD6aRZb4SncqTRXIHf6KSDZ?=
 =?us-ascii?Q?YqWriREwAPM0sh2jBQUVq7UGB4WVEX7ztq4WZsCEVCumsBIlcHx+nUxyhfK+?=
 =?us-ascii?Q?rkFr9vF7bMFcBHaUlIwQYrVTNAdL+WY6JglYlc47meMr7eFTX5Ir6Fp2L9il?=
 =?us-ascii?Q?E9zXJK1L6dRrA8Y22risAtQFpTC1E5aoF4IJfviPjwMIcGWjqxQtauZlJTkq?=
 =?us-ascii?Q?rhFpFPZsp6StP5yeVYY+uzAaFwMVos3d+s6+gcTfUjPqqLpzgRzcMfMgvltV?=
 =?us-ascii?Q?NVMIJ/VYzzZgfWB2RPBDBYxXvRF9gWFIqp0Z9G/l0qknfxd4PPOgZbwN6CZK?=
 =?us-ascii?Q?RELTyr41W/WLDFdesPFnU/MuVc7CCsezVsPizcR3OmRIwR9N5lxlM9VqE5yL?=
 =?us-ascii?Q?duI/2FLBk0vQixRY87Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a48c9ad-8d63-4a18-aad1-08d9a96c82be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 01:49:36.3132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sc8F+Bjd/MZviwfI3ksY9pXXq97gr3Bk7IwFAsC8y6pvLOLz96sifD8wtS5uyEfc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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

[AMD Official Use Only]

With the concern from Guchun addressed, the patch is reviewed-by: Evan Quan=
 <evan.quan@amd.com>

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, November 16, 2021 6:29 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: support new mode-1 reset interface (v2)
>=20
> If gpu reset is triggered by ras fatal error, tell it to smu in mode-1
> reset message.
>=20
> v2: move mode-1 reset function to aldebaran_ppt.c since it's aldebaran
> specific currently.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |  3 +-
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 36
> ++++++++++++++++++-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 -----------
>  3 files changed, 37 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> index e5d3b0d1a032..bbc608c990b0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -29,6 +29,8 @@
>  #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
>  #define SMU13_DRIVER_IF_VERSION_ALDE 0x07
>=20
> +#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> +
>  /* MP Apertures */
>  #define MP0_Public			0x03800000
>  #define MP0_SRAM			0x03900000
> @@ -216,7 +218,6 @@ int smu_v13_0_baco_set_state(struct smu_context
> *smu, enum smu_baco_state state)
>  int smu_v13_0_baco_enter(struct smu_context *smu);
>  int smu_v13_0_baco_exit(struct smu_context *smu);
>=20
> -int smu_v13_0_mode1_reset(struct smu_context *smu);
>  int smu_v13_0_mode2_reset(struct smu_context *smu);
>=20
>  int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum
> smu_clk_type clk_type,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 59a7d276541d..e50d4491aa96 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1765,6 +1765,40 @@ static ssize_t aldebaran_get_gpu_metrics(struct
> smu_context *smu,
>  	return sizeof(struct gpu_metrics_v1_3);
>  }
>=20
> +static int aldebaran_mode1_reset(struct smu_context *smu)
> +{
> +	u32 smu_version, fatal_err, param;
> +	int ret =3D 0;
> +	struct amdgpu_device *adev =3D smu->adev;
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	fatal_err =3D 0;
> +	param =3D SMU_RESET_MODE_1;
> +
> +	/*
> +	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
> +	*/
> +	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +	if (smu_version < 0x00440700)
> +		ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_Mode1Reset, NULL);
> +	else {
> +		/* fatal error triggered by ras, PMFW supports the flag
> +		   from 68.44.0 */
> +		if ((smu_version >=3D 0x00442c00) && ras &&
> +		    atomic_read(&ras->in_recovery))
> +			fatal_err =3D 1;
> +
> +		param |=3D (fatal_err << 16);
> +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +					SMU_MSG_GfxDeviceDriverReset,
> param, NULL);
> +	}
> +
> +	if (!ret)
> +		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> +
> +	return ret;
> +}
> +
>  static int aldebaran_mode2_reset(struct smu_context *smu)
>  {
>  	u32 smu_version;
> @@ -1925,7 +1959,7 @@ static const struct pptable_funcs
> aldebaran_ppt_funcs =3D {
>  	.get_gpu_metrics =3D aldebaran_get_gpu_metrics,
>  	.mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
>  	.mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
> -	.mode1_reset =3D smu_v13_0_mode1_reset,
> +	.mode1_reset =3D aldebaran_mode1_reset,
>  	.set_mp1_state =3D aldebaran_set_mp1_state,
>  	.mode2_reset =3D aldebaran_mode2_reset,
>  	.wait_for_event =3D smu_v13_0_wait_for_event,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 35145db6eedf..4d96099a9bb1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -60,8 +60,6 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
>=20
>  #define SMU13_VOLTAGE_SCALE 4
>=20
> -#define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
> -
>  #define LINK_WIDTH_MAX				6
>  #define LINK_SPEED_MAX				3
>=20
> @@ -1424,25 +1422,6 @@ int smu_v13_0_set_azalia_d3_pme(struct
> smu_context *smu)
>  	return ret;
>  }
>=20
> -int smu_v13_0_mode1_reset(struct smu_context *smu)
> -{
> -	u32 smu_version;
> -	int ret =3D 0;
> -	/*
> -	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
> -	*/
> -	smu_cmn_get_smc_version(smu, NULL, &smu_version);
> -	if (smu_version < 0x00440700)
> -		ret =3D smu_cmn_send_smc_msg(smu,
> SMU_MSG_Mode1Reset, NULL);
> -	else
> -		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
> -
> -	if (!ret)
> -		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> -
> -	return ret;
> -}
> -
>  static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
>  					     uint64_t event_arg)
>  {
> --
> 2.17.1

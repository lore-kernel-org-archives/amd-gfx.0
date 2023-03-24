Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2551BC6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 07:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B871910E509;
	Fri, 24 Mar 2023 07:16:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A76310E50B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 07:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZVLNGN0XFM75NGRD7q/HZnlyFXSVDaS18j+KvxsNAawjCamumKSFBYgEpUiKH/+U7wQWiTpKkAXmevpG93zw2R9/t66tbCTLgXVtEvjzQSEnpWVACvHPeo5QzrnOtWcO66wTpf1dqHV6x9f6yNpFCiabq6cdwV4WV65t7zyIVHDf6e9c1JWfrdlplALcXvRyMXHQa5xCy/VrzZQfg3pMvtZ984vkuSMi1cqw3Wv18D85Uw/B/8xTOpybWZlEG5ytN7FkKCEAojAalGephYI2RrEdB/h/gVaJjrtKKGLkSFIZzBcnxIV/4wXJnbnErU13/nTD2gjQap7X3xWHzyXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDSzeuFSgjeK+Eyne7IKGbybo5yA9dwcgO01jjSrHAY=;
 b=Xq5sB4x9jJ/lZX9OJHT4WQa776On3Vpb/U8yhJ8ia2vLDuY8qp5GbF9sdMlLQIaQpUU8g1s3OVj701AEE37nFZrCwwgxCxgGOeofLLk/y/e4Lz9LvYWIfPdrSOJ3/u02r1vH2mvvbhF1WHkWTjxXbvKJ0TQgVr7ddquSoK6LdPaLzqGLW9ZSI+j4E6TzlAre7QRpe4+3+Ly7FeH4CyKxGqnVpXnuUSdql/JmhVOHhcP9GZtlPw6YBrAvpYTnHoXK25bswV6X08NNsSmPVzWaRO+1xgqtmO4cW88Dc7U2rrsXyXnANDuOoHHWRIirCbl7C2rew/68Om2PLelMUBrwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDSzeuFSgjeK+Eyne7IKGbybo5yA9dwcgO01jjSrHAY=;
 b=FTaypVRVzpxRpSKzAm4jAOS6cGm+bQ3A7WOs/nngwqbQketAs79KJysC86JUueEqjQAMFXeJ3uOBoe+8jveQ/moCrUP9cHgraKWcoqrFv7t6Ea8ahxjI5XM2VGCiQBqFoY9kZTy5PjpwCn5z0bb+BWKWT4bgbI4mWCZt9ouNjQU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:16:33 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 07:16:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Topic: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Index: AQHZXh+HSWWpT8ZhyUCEFJFD2JRF8a8Jg+oQ
Date: Fri, 24 Mar 2023 07:16:32 +0000
Message-ID: <DM6PR12MB2619B6EE8AEC9FC8A9632D4BE4849@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230324070812.1304117-1-tim.huang@amd.com>
In-Reply-To: <20230324070812.1304117-1-tim.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-24T07:16:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e1dc0047-75d9-4e84-b46c-656fc104febd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MN2PR12MB4205:EE_
x-ms-office365-filtering-correlation-id: 6747c659-18ba-4022-4478-08db2c37b242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4lq53tmqSdnI+/HlUIjxkAIoNlkuXQNp8ZxDFs2RsGsDQAV2tyS+pjMx9OfzXtOD8j5hi5cYitC3FG1cYdeyZi0whhn6AYW0PQ4nsI2/B5ededXw+EtKiEbPZXvBccnXo28VBJy9LpkV0aUPivpFyA/Whvssp8eM9OYfgZCIEb1Lr9xbem08XgwOnjNFrkxyQA5NIlWbVrbUjNFWDIQ9ixFG0peZJC1Joh0EphoqT0JSYmqozdsT1T2yF5KYhnEowAskiTEzY4VbNeUiPPc0sUNZcIUUC4MXoHQzF16TKOPZJOn8F6EQh+4Vg9/S3M2VYGhQroaFyOT5foRTCxZtiCQx/VZ1qui1sZu2NGTn4z6rmCVxUvyGGGJlCLACyfd0usz49faOpokHD5hQu9l43p0fJ4V0ldYlBilWSBeigcbljDJZ/z5d+6eerFZcoN0Fwy5iBX8Ed5GC5Rm9n0TI9wqiuY2pvpAVf7DIFTogMvTorvXEdl21VgA9wPnjyu7mjf9clcmehzEUAOZ6naXltlIJCYaqm1YaFrGWlVFCOX2XZPBdXcWFBFU1oXgxUfeiWDsmQiW+TlORAgSTAoVvgG+OlOCH6P6eE4h59la4jNo9fC4eqFMbXOWsAF8tMIgVkpY+MRg8lXndq7yD3IFx5/NpfSKHnX3xU2sFEyl4dS8l+t3Q2C0QyL3B5fNaRKmUzj9R+0RLN5WmrzUOjCoow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(66476007)(64756008)(8676002)(66556008)(66946007)(66446008)(4326008)(54906003)(76116006)(110136005)(41300700001)(5660300002)(122000001)(316002)(53546011)(26005)(52536014)(6506007)(8936002)(186003)(478600001)(9686003)(83380400001)(71200400001)(7696005)(86362001)(33656002)(55016003)(38100700002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wp1mlvuNFR6XR4qlMRa/MLq7Glb1NuDMZ1B3nWkOPDiU0j8sQDkOb3EAWe8C?=
 =?us-ascii?Q?Gvlpz2BgYG/QEmtQzgdPCiL7wAs/HAFR65c6ht9f3LZ1ZAIZHIOesdHB++x7?=
 =?us-ascii?Q?cNfnzfDrkmiRkGBTX1MN++DbUexd6Hj0uNBQVzpt2gZLxsivKF/axNz4D5Ok?=
 =?us-ascii?Q?3fmDCbsydidK867vJGb5J2vKMzHUttAy38Bth6t04QHmBi7Bm+8PGZiQFLBW?=
 =?us-ascii?Q?IIvLxo+qPEcxw9r31GEQzyIzHiSiKTfQTTbzX+VqGa+L/vAiQhnn/chFz7KH?=
 =?us-ascii?Q?a2bG97ISq7/07OfAXCCAMfj1GYG6QwEGF3zX00ddG/zqwkautuv5apj+q0m4?=
 =?us-ascii?Q?mctdCUvtPzIDReNfK31/QgvAxSXw1ZeekUxvC3NgbF9I46i30YeHMBUUg2ct?=
 =?us-ascii?Q?MOPHKcAbXDsb/tL0Q0wQrk7dh14KMT+P6tKO5giNUtVceg23XnbqnAhpkdIH?=
 =?us-ascii?Q?Owd8rPkvGLhCdmUEGcZ7OLrrNc3zxO5McHFWRdcezzZ049D62XKYWvy7hWi5?=
 =?us-ascii?Q?8HxHnaPW9Ot4OELSo2lSeRMXFpG/n3nZQB3D9u+APNoM6gaCrZm7O9TpAiYp?=
 =?us-ascii?Q?bQiZWfq8l4FjwR7a0ENAgDnHKAVvFD5ocy9N3ZJRkV9cDK8KkQ2Ydl6pmlOs?=
 =?us-ascii?Q?bBRM68emIofdddwNtBmWtmUjMVqDW9ckNLyz0xdXXJ9s2M+nSMClskezqHdm?=
 =?us-ascii?Q?kSQ7ZzLdco6n1aPDwESY/W4MUkC3NCn9hDXLKQ1pFUoPM2X0tJS84Eu+7YHy?=
 =?us-ascii?Q?hPHU1JNCOwcPLPvuZ2a/lM+lxdTjJOXTR3mGiD9LJsuxdtKtlM0NKuuIjc45?=
 =?us-ascii?Q?BWoLqQ83QR5zGUlOegzepB3DVNj0UQlUcdpFCaHYNjYENJWk09R/53WUCMHG?=
 =?us-ascii?Q?3VSdccRh2+Zfbn5W0NMOhdkG6ifsjS066lDi76dpXZ1VybIEtcZjSFe0AqXj?=
 =?us-ascii?Q?CuxKmdsa11G7lFdif5lCdScVHzxgKvuOaBhxPx5jTiFHrr6lMXW+IgMWB+T8?=
 =?us-ascii?Q?0NLGPlNS1gjAQsqKSG3lj7sYqD8s+uD1S2ctCIONZwMl8bXzjiTNiz89LMbH?=
 =?us-ascii?Q?m4Qj5+Z/gfdneDagt28216BPZ5bmnTOqbYj9lEJQDOdPpI0Au12lUUR9uT0h?=
 =?us-ascii?Q?rnGzArA3PM3I0pM7nCn88vY1xHEaRtKZvUxTOvjiqq8Y43Aq5073uKtOvfR3?=
 =?us-ascii?Q?+xGJsPOIdXP7C2OOeLHjc7f94qv8zY6Nc6XKhsmYrio/N3P3vVs4O18veXRk?=
 =?us-ascii?Q?NgmBM3rVhwg5oBGwJrVju6ehrckp9ji8cZvMC6fEnLHD3AUny3FwRb5YK+dD?=
 =?us-ascii?Q?5vYBaNwj0zybnxnxSuKH6aNfqKw5nOTQCEPUSTtyqKsSbAKeYcNS3Jil66/R?=
 =?us-ascii?Q?S37XOfB53jtlokSSvcms2Cylk60/5AtQAWXINJakJszqcMAvGr9AF1oE1GBp?=
 =?us-ascii?Q?C1AEbLgFKljAIK06roAr0zZ4v8aS46pjLzeUqwqwvSVlhHNVWgR8CV8v0opW?=
 =?us-ascii?Q?QbnV5Xq1kb7djAzkqsFKZe0UMNjwJHaHpV0agoPbwCs3Rbq0xZs/VolA1WlS?=
 =?us-ascii?Q?Afw24BAHDI2vnny8iSE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6747c659-18ba-4022-4478-08db2c37b242
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:16:32.7942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAfnpdrY5DAY2abzenYN907Hl0pnKyUF5Rwr2eNfRQHucYKYQd7KwwpY8FWkXjhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tim
> Huang
> Sent: Friday, March 24, 2023 3:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Ma, Li <Li.Ma@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
>=20
> If the gfx imu is poweroff when suspend, then
> it need to be re-enabled when resume.
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40
> ++++++++++++++++-------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..94fe8593444a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -162,10 +162,15 @@ int smu_get_dpm_freq_range(struct smu_context
> *smu,
>=20
>  int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
>  {
> -	if (!smu->ppt_funcs || !smu->ppt_funcs-
> >set_gfx_power_up_by_imu)
> -		return -EOPNOTSUPP;
This assumes that all APUs need to support the ->set_gfx_power_up_by_imu in=
t interface.
Otherwise, the driver loading will fail?
Is that expected?

Evan
> +	int ret =3D 0;
> +	struct amdgpu_device *adev =3D smu->adev;
>=20
> -	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
> +	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
> +		ret =3D smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
> +		if (ret)
> +			dev_err(adev->dev, "Failed to enable gfx imu!\n");
> +	}
> +	return ret;
>  }
>=20
>  static u32 smu_get_mclk(void *handle, bool low)
> @@ -196,6 +201,19 @@ static u32 smu_get_sclk(void *handle, bool low)
>  	return clk_freq * 100;
>  }
>=20
> +static int smu_set_gfx_imu_enable(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
> +		return 0;
> +
> +	if (amdgpu_in_reset(smu->adev) || adev->in_s0ix)
> +		return 0;
> +
> +	return smu_set_gfx_power_up_by_imu(smu);
> +}
> +
>  static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>  				  bool enable)
>  {
> @@ -1396,15 +1414,9 @@ static int smu_hw_init(void *handle)
>  	}
>=20
>  	if (smu->is_apu) {
> -		if ((smu->ppt_funcs->set_gfx_power_up_by_imu) &&
> -				likely(adev->firmware.load_type =3D=3D
> AMDGPU_FW_LOAD_PSP)) {
> -			ret =3D smu->ppt_funcs-
> >set_gfx_power_up_by_imu(smu);
> -			if (ret) {
> -				dev_err(adev->dev, "Failed to Enable gfx
> imu!\n");
> -				return ret;
> -			}
> -		}
> -
> +		ret =3D smu_set_gfx_imu_enable(smu);
> +		if (ret)
> +			return ret;
>  		smu_dpm_set_vcn_enable(smu, true);
>  		smu_dpm_set_jpeg_enable(smu, true);
>  		smu_set_gfx_cgpg(smu, true);
> @@ -1681,6 +1693,10 @@ static int smu_resume(void *handle)
>  		return ret;
>  	}
>=20
> +	ret =3D smu_set_gfx_imu_enable(smu);
> +	if (ret)
> +		return ret;
> +
>  	smu_set_gfx_cgpg(smu, true);
>=20
>  	smu->disable_uclk_switch =3D 0;
> --
> 2.25.1

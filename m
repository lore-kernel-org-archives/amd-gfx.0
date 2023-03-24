Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD6C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 07:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BF310E50C;
	Fri, 24 Mar 2023 07:26:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED2D10E50C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 07:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJIUFD6QM7E+/h5k7/l4uulKfxf8V9J5sAUfHI/9kzPJ9PKA16K5wj0WQjEkbrvGJNLVsO409YfuhHXQSahKGMYYnvpqCrLsRpWrMuT4yb6vyQe/WT7CW+ilVGYr/flANdB9sxl4+7QxelCl50vkMbP3SOqzgcyClWjYgeYirO8EoRzlLdGlyMQsGtZ4AmGuDkrBskldqdlEuCQQCxma54q0ovnebFbcwzmPmLyprL2d7HEVxMgb2pLULdcakObtxDP3bG5Vlcn+B5Kp6SLMd9MkfdsTpOTKdVd2X1LB5HYKkx+IbR3OCRos2bo01G/6yX+fG4FjT8ZTvEXwQTmaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4+qpaFqEkwZXCb3yQZ8V3e23Doc2V2ExKLuUq72K/8=;
 b=P8nVTET7d+jLIxKc0Y3zU2nvFf7OQ7cyDCRzIGEAOPAJvavgNJ5e5TWZ9/PizqoytnOvZSsglmNjz7gk+0kz7RiEL1msp1uqUf0J5w6nUPckJvkIj4SmFflolczwwRg9CNsVsb1dsDtVCJjN+lecun7MynvqOpY95d71Fdq26BXHznPlj3yrC0ooKn3TTrijQyvFw6Ju+P0zQw+0hZMg3fmurFaIJrbj/tt3+1EiATWcXn4xCY0wXQ/Cd+VGmZoF2M/7V40DTJEwrkFluJnEhqJLnOZCvBjzBxVUtRX7tc/MhSoXTjtX8utPM8ThAtkSl18blj7BcvcJ1PXzlGn/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4+qpaFqEkwZXCb3yQZ8V3e23Doc2V2ExKLuUq72K/8=;
 b=W61iHEGdK2ANuhjQ+oJYlA3C9duIN6lMfZ/n+5of9u74pTm5lipZmcXSgo484YOgNG8m4Yy1WkhCbahklHikgbVeLXfH5g/3407fCLIihiDMs/w05rraklu5o746mxDu6MgcRzRgq+tlNd0cY47N6BkX7XYBDQw0NIqvh4ED5ow=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB5310.namprd12.prod.outlook.com (2603:10b6:5:39e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Fri, 24 Mar 2023 07:26:24 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 07:26:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Topic: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Thread-Index: AQHZXh+HSdCaSx0480C2N9YS7tmuMK8Jhygg
Date: Fri, 24 Mar 2023 07:26:23 +0000
Message-ID: <DM5PR12MB2469985A3A3C5BD4279EDD87F1849@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230324070812.1304117-1-tim.huang@amd.com>
In-Reply-To: <20230324070812.1304117-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM4PR12MB5310:EE_
x-ms-office365-filtering-correlation-id: d0501b0a-d1f4-4512-4d31-08db2c391299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESCBlCgkuxoOVBoMrqEqW2N3oPbTkPhWBTa2LFm7srW7t+/7pzxIJllmTktcUk0A7wMmlLad4eOGvuBshazQfflWye/bUxuF6xTSyn4sJ5FGBk36rh+1y1pLWzoZ/apkeQOhDthJIuHdu893jWAJIQ6zKBTHUqRvMGIpHU7+KiqqRu3wCqbeV9+mgx7qTgazTVfmT9LcIf0k08wMSEL6qdxim2/k+GIWgBaS44VCudWRAff2jD1U0uqmx4JFB992NaIWRFUPxiCcY+u57Znhy4k6fVfSwj/2uGpnFX7bIm24DKj3fPrGdCR8QAuboA7ZrpLkUYcM0LeDKDxu8gcHMEGRWB0x78ICJ2tM+EhMBxLBGY0e1HTrHCBvQN5og8Bibz4P1Z4Yy35xHziKEvMsCSGakOTp2klDhafs6FfnZ0t1/ZHazYgakkUrYL7cYnvh3jaAoNo4QWr+5LL0XFGu6qz5lyUQeBvC87lCZnLt7KAYjx7vKffWdolGGHMpgMgUJe81+49AH5XySzrJxClx+B1lOH19raPyN+PYeK4A1RGQsFkkuo+uMb1zbc3n7H71FJl6VqNzIn9PnLD7fPQD2TFBgOSzQeztfE0QESypgd3Yky6WdnGOu0R/ttnyRxLl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199018)(38100700002)(122000001)(6506007)(186003)(26005)(53546011)(9686003)(8936002)(5660300002)(4326008)(52536014)(41300700001)(33656002)(2906002)(7696005)(478600001)(38070700005)(71200400001)(86362001)(66556008)(66446008)(76116006)(110136005)(316002)(55016003)(8676002)(66946007)(54906003)(64756008)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WDlB6rNDh2N9Hgoprbh0yxIKavdbANv/v3BaydFgdrpL3mR7s4Y7ukwMxcWS?=
 =?us-ascii?Q?2BZw1uU4I+CmV2eF1wCdPhhdVYpC30qdhmOdjAvlCFSzInRm57scGwGQMHUn?=
 =?us-ascii?Q?OPJvGaytvHJym6+LqU3rSJ9CymF6rI0yivrQFbFtuu4sp6w2GCjs7v1b29c1?=
 =?us-ascii?Q?UZhmdbwJRohS88f1p8yx8sTN8ngEfxg+9ptVvrrxtU3Omtf/B0xJPBY4kwbD?=
 =?us-ascii?Q?PW1uvQVebtTzFw1akkEedQqURQJlQkM1l+xPEkUT/CacqHISMXWLgXz8meIj?=
 =?us-ascii?Q?WLDwRw7G/1IjEzzjgY1IvODBX+jn4jXTL3fi333e5LPsBno/1reoCYAc8dCK?=
 =?us-ascii?Q?nK4idrgCXKMJThJXwKxMfWr8kINy5ThzR14tvH8jnaWWZVARRmwxlcp57Pnx?=
 =?us-ascii?Q?HiNh3oeMSzCDQTjkXGoJD61d3nBCfKDHED+QtMaZdd5e5n1Pj+lkfg1y6jOf?=
 =?us-ascii?Q?PFsAE8oNmvs402Bd5g93MzJE4Zb+0EszR5niAxuCqW0NDt3vU6iLhUaeRkgk?=
 =?us-ascii?Q?EXVyJQIje5JylD4YlFkWxb04xFys+gFZRGYvkvjooimzuB9ixFsJWs8Eakox?=
 =?us-ascii?Q?iq7n5H1p1FgELDcemHaL3Dmm/uSXW81N0/BhBlfEaV9bcaH4PuftTrqPm4Qe?=
 =?us-ascii?Q?szdWN6AG804YHeOw6yCEPHRGFTzE9yMEGFd7FLOkMRL82GqPszWQYvoYS9ro?=
 =?us-ascii?Q?EuudUVR1JjHG3Zx5HWhdTI1iHEzJwHDgqZTIPzfxwBjSAPorx9rAQK7xsxLX?=
 =?us-ascii?Q?gLIX3JkL87eBvXd9588d79ZZLSn8ZH3lL/qnh91Ifr+xhQbcTDVHjmB8XK5X?=
 =?us-ascii?Q?HDbSQh3TMMWde1quJ/s/TKqCMJQwA05X5LHUGfi+IRAsnqQ7gk4tS/wBSBCf?=
 =?us-ascii?Q?AxhnsDGwCDuDzeQHH+9rChnHB63DMIa4H8rLnXG/nWVGfaQ7kbRPBSkWkXl2?=
 =?us-ascii?Q?+kkLLT+H0HZ3gtQ90Pxl//7ku2BoskO1vliFN3/hGyWV+ZNMvMhSgYPpM+6m?=
 =?us-ascii?Q?z8BGZDd3Te4p/9TpMr6nkUJ79qoRaNfD+y27mROjaYbgPg5eQgtdAO5hb7MB?=
 =?us-ascii?Q?++kiIYWOT3frYFWENXtLONxaT38i0xrZGEGBqLAaGxp+n9SMd6VTVHOJ0MIn?=
 =?us-ascii?Q?5VTLMflYlTJSwJJv+fHIn0GDSq4kKooOZEyPN1cmVlTIWQx+L8niztO9iRN8?=
 =?us-ascii?Q?U3qFST4+zKuza7nwVP3sq8+mQFiRbRwucycKPX6RzEl/vjJkkjSVgBfN4mDT?=
 =?us-ascii?Q?+jecLhIyMI+I22hiI2V/xLQS1t5u5gl9gun9G0IJJcuyoqr6h8ujSATvWlN0?=
 =?us-ascii?Q?KcM0i4oOkxi81a0ekcGn+LTFJnBb9OlpJ5OrODy/AaOgYZKkrlPl/JPrHkFE?=
 =?us-ascii?Q?Y0byTp7GvzTVSylMOIRZV1x4d7iTKK9i7tZEAPHfbk1A7/ehkyjL7z8O+Mn7?=
 =?us-ascii?Q?b/069UFVtFkeRqmAalqvZ27wNuDvGertyr8PIjnVCF5eM9VcXfAjeXTCf0uW?=
 =?us-ascii?Q?J4Y+tfM5ne5SDQo9nY1wmddM26s4HjsH8NfwE6WIslvvaKmmRs5d/SSXLrVl?=
 =?us-ascii?Q?ZKcfAfGnlyZIOTTnTy0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0501b0a-d1f4-4512-4d31-08db2c391299
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:26:23.9539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQtS6CSyojJrKOJvwg+eXXVuHQdwSDswArp1hIj3Tt9+6GPYaV2SMEF9fYi8GolxQMnh5qkqVUEKPSbKhU4G0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5310
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
> If the gfx imu is poweroff when suspend, then it need to be re-enabled wh=
en
> resume.
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 ++++++++++++++++-
> ------
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
>  int smu_set_gfx_power_up_by_imu(struct smu_context *smu)  {
> -	if (!smu->ppt_funcs || !smu->ppt_funcs->set_gfx_power_up_by_imu)
> -		return -EOPNOTSUPP;
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
>  static u32 smu_get_mclk(void *handle, bool low) @@ -196,6 +201,19 @@
> static u32 smu_get_sclk(void *handle, bool low)
>  	return clk_freq * 100;
>  }
>=20
> +static int smu_set_gfx_imu_enable(struct smu_context *smu) {
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
> +		return 0;
> +
> +	if (amdgpu_in_reset(smu->adev) || adev->in_s0ix)
> +		return 0;
> +
> +	return smu_set_gfx_power_up_by_imu(smu); }
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

smu_set_gfx_imu_enable in smu_hw_init is valid when sum->is_apu is true. So=
 such check is still necessary in smu_resume?

Regards,
Guchun

>  	smu_set_gfx_cgpg(smu, true);
>=20
>  	smu->disable_uclk_switch =3D 0;
> --
> 2.25.1


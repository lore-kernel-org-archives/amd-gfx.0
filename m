Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86648C76196
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 02:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2403510E0C0;
	Wed, 29 Mar 2023 02:11:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4115A10E0C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 02:11:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVEIb0fcxeY7rgYZMautsHS3IwO0A2MdvkjLzMhYq9fVvXzbwj2/oMwqpj5hCJBQZx1i3uQnZkusNn+mpPzTBPMbsg8eARFZlcnn4t9YR587fxe2qWU25/Tca5uHd4D35cGFfiElfDpev8OSR5PSxGetj5mQqyAyj0WwWmTsSM/KmKDNc+Et1ggWzAEkuR/5KpvNWFNk2BN6Fsgxv/yUDB6sBtj2RYxUylSkQ2AwiZe4wExVKFkVjQd8GTEIOB+L9DJbPOvEGwJyBi9YRutHgOdHj1LXzv4iHORE8s1Rwsca/F/JCym43xqP6Qweacr6YbMPTFOfLBALXwMsunFE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+TyEDLq9AbgTKFCK1X69yJAtzz4BrwjR9vyjRydPzo=;
 b=JP639au3gi9TXwUtCiKV7wuUPx2ENRrEYTyHvWUVO1L2KDBXcl/xaiJiFiGnP0TW7CbK2czxETEHpuGFYnjfdOae6ztIPYfDErdlNfe6u3hdz4dRrMzgRLOm9Ogk0fhqcScByETF9Ap/1GffR8hvXPTw6Xc87FfyOVKjlZQzsd97UHHspz5FU37LtVWuCHsEwT8yvatbXs9NBFr7L42azjnGPghMWRduPf7cQNd+Ctfjs+/Sw7efkqnx3zNSm/ksUrx6+2DLaEbDOSsWy+g3V0+VqmzKaKOuIiffXkxsev3p1gCdrCn4ceR0GaLOR6XkwcyJjYz+k30ycG3sHSDmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+TyEDLq9AbgTKFCK1X69yJAtzz4BrwjR9vyjRydPzo=;
 b=xHzAjvHRpb3VMsH1/JOiazJhmoj30Wt9ai1FVctqfHcl3ApP1eDXGbJqPw0nveZLaYXQWj/fcvV2g1T2wduOxtPHSx5xLVWyfrlkRfww7ifwJUPYi5cDCGA/n7SO1iIcawq3s08hfxNivT7IrzGtMKt/BQsATeg/A3VBfo1eBLk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 02:11:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 02:11:31 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some asics
Thread-Topic: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some asics
Thread-Index: AQHZYWpSdr/i0zJ8Z0yCUu9nGIMRlK8RA/hg
Date: Wed, 29 Mar 2023 02:11:31 +0000
Message-ID: <DM6PR12MB26192C4687DE015320972F2FE4899@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230328114141.1154742-1-Tong.Liu01@amd.com>
In-Reply-To: <20230328114141.1154742-1-Tong.Liu01@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-29T02:11:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1df8a165-5084-4641-a497-290ca4465b34;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MN0PR12MB5763:EE_
x-ms-office365-filtering-correlation-id: 3be860f1-862f-4cac-de04-08db2ffae9e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCucNQH0sg2e7R7Y0fiWG+V/jMfOYH2MQisuf4UUW8JyMNZ7ZTjFogjEs2kchChJZy1i7IM/taLhEUWSvGgtvonTZ9C7DX+i3NoSH6cma+aNB6xYloc5StKNL6w3294uHq97lRygKaqk40tJAexHd29Ka21Ysqy3wTq9Pktm4NnkVttTKuTWNg22zPEn2RHkhmA39nmBhvYl0YjIOTMvoqQHHeaRaTbekSChAUihmPw263bGYfgk+0EhkZLQN6Dot/N2k3MO0caQYtOc3tMDk7hORymbdlDS6j4t5NSCnZ4KzoSuYXsvTx8li9SpeotgQ6FiU2nJsTnRVgsmTPU4uvZUF3SGUnY/srEsgSSvVcY5kZPn+8H67mzb0aDuVVxpwZrDn2cpBpdJQU7S9xTlTAzc83sDzTKhQ5XrjybE4XZCSGdJ86nJk2u2GNJp5aAy4vcuiZpfYi5RDrcGfiZfkFxVJfdbER6mIYKGR4zsgRnLKa8DcdologHeLFqYzjndPdu7L05EVzxzWfhDwceSzcIz8cgrjirbjBracVL4eUoMVJpdRZr3NT9j2ewaG/+E6nVCeMiBa5D7k1XSaY+mshE25NtpRzX01RjbXVypxAvL3+DuMm/kadJ71O9+6KEO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(54906003)(110136005)(6506007)(53546011)(478600001)(83380400001)(4326008)(66946007)(66556008)(76116006)(316002)(26005)(9686003)(7696005)(71200400001)(8676002)(64756008)(66476007)(66446008)(186003)(41300700001)(122000001)(8936002)(52536014)(5660300002)(2906002)(33656002)(38070700005)(38100700002)(55016003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jjfSdxyjqq/eJEn5ht59M0k2McvIRz2TW2JSinOWCr+KS3dP7kuELm9JT3cN?=
 =?us-ascii?Q?dak/PSBfKgY6SY6od6iBrKwdUTiGxeXPF1qNXi137YTEkrRzUxSZbMb2as7G?=
 =?us-ascii?Q?s5JrwWA5BjrHTVsopD5/9vY3R0tAYzX6qbvHHjP+AJ/22wk2jb02of6JJ0BX?=
 =?us-ascii?Q?FHqjGWNdoTS4ZAo5EQ+hldyGTxEY4UGYAiMRczNm+XLevvkw573yEvgZd+Gi?=
 =?us-ascii?Q?1pG15ezYJQLyehItdNQft/Z9w7QFiZaU2/rx1wMsVomCN+jhJ3WUbTvav48L?=
 =?us-ascii?Q?fm2DoTSofbKlGXkLhF/+1wXl1HWBfP+CQU+wMNN0HRwTDqOtPAdrWMOenyuB?=
 =?us-ascii?Q?vbrVJ1YNGNKnm6nYux4lUC5VbeQeQMjps+VUfnhC8vwxfLtyMd19JbZwy4/b?=
 =?us-ascii?Q?iySu9zBZM/LUOJ28WYiNls2pONsJ/dlUVPioO4WAidcPnhRqQAeqfLPzS6Rl?=
 =?us-ascii?Q?R/xGtaYB/Ev/bIOjfGTw2P3biovyHA5+FJYZAFa4gJ4YZacqoGkzU7yGqkAt?=
 =?us-ascii?Q?vTbE02AE9VQJyd4GVv3+932uLPucV6rj/KIAKMP6bdzLp60PswA5aC5bBPFM?=
 =?us-ascii?Q?ybUSE59Bl/LJkJNmiYaERSF8IJ8JHz7alzONHJ4ZBcTLR2+DP47JloBgC8io?=
 =?us-ascii?Q?jf33a6c/tAwPVo11ygrx9aPPgYn8LbhiyjiXDotQS/9dTu70WsesrTwQLNLn?=
 =?us-ascii?Q?wsL/Xba2no2nO5sc7qrjqIbhrhACgZQSFCbrxzffbvPFkbAgQ2hU2zMz1U4X?=
 =?us-ascii?Q?PFaG5tMajnDt7u2mVVFkXLYKPN+zK5pXqyI26+jixGONOfeBCYgaM50qG8jL?=
 =?us-ascii?Q?XT3pZP0H6xp6p7LGIzL3yGrpL5gS1zCVobLLxx3I9O/0p/RXPz+gUTcWKutz?=
 =?us-ascii?Q?/uZ7+JXWWQGvjGs5Jd0gqsPSeo06G5GZoSF8yp3ASnDoOFB9BNm84h+g9Nk/?=
 =?us-ascii?Q?Vi2ClzF6eEKlI5uyjCPGXBM9yYgQ5saA96UivvNu4CoWcqWkY0WEYpIhd97P?=
 =?us-ascii?Q?Q/QUqKeowg+HS8gfgMP4faZ2rnsFpvwhRMp7gk72bOtesONeySZEn170VLOh?=
 =?us-ascii?Q?3QJFjp4gSIrIT32QNa+pROBcx/ZnHZOd/WB64PZNE/0cgq6IXWlwVBKcgiL7?=
 =?us-ascii?Q?FDlxUBJvVDEI1YAdJQ3GKUY2oMxbvTIva9jOARgTianMYLeGcWmlqWVF+5AE?=
 =?us-ascii?Q?hplsa0Ikl52wpQWx5UEPd2idvn6BimzlUwn1vOI8nGDjN+/c5T+qjxkg6m4z?=
 =?us-ascii?Q?nwjqog/LCVAH10tRD9MKACUMvKTUhYOLIUWkb3mXZc0R6gtc5bJK9/ewS3kF?=
 =?us-ascii?Q?9phjFMimle9xu/A0iyuX+5p93icV2Qp7A2WtafAELcD8a/pqFfIeQw+jOHN0?=
 =?us-ascii?Q?T4iK3Q3WnLadskJ4F5mZHa+u0v6FrTY5R9A7E55pju49u/itKceBLFqP2iFa?=
 =?us-ascii?Q?3Ft/DN3aU4zHx1wpgunflrO56mdg6TWTjk1cjShC0WkqGZyT0Le2d4pS2hBl?=
 =?us-ascii?Q?ndBTb7tB2OJHjg5O9vPgsTlE+tx1oNoYgAO/5AU/rbbJ05eHcF7A6SxuVOv/?=
 =?us-ascii?Q?FennMvhc8jyTfDNyELA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be860f1-862f-4cac-de04-08db2ffae9e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 02:11:31.5139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcx5iXgYOXPxkGd4QYGrH2/JPY5OZJ+Yr6JqIW7VsQ5Jg2QV5uPsEt4vtWoWS2I5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Liu01,
 Tong \(Esther\)" <Tong.Liu01@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

IIRC, the VCLK1 always have the same frequency as VCLK0 with our current im=
plementation.
So, is it necessary to provide another sysfs node for checking vclk1 freque=
ncy?

BR
Evan
> -----Original Message-----
> From: Tong Liu01 <Tong.Liu01@amd.com>
> Sent: Tuesday, March 28, 2023 7:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
> Subject: [PATCH] drm/amdgpu: enable sysfs node pp_dpm_vclk1 for some
> asics
>=20
> Add sysfs node pp_dpm_vclk1 for gc11.0.3
>=20
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 22
> +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ++++
>  3 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 86b6b0c9fb02..fe75497eeeab 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -104,6 +104,7 @@ enum pp_clock_type {
>  	PP_FCLK,
>  	PP_DCEFCLK,
>  	PP_VCLK,
> +	PP_VCLK1,
>  	PP_DCLK,
>  	OD_SCLK,
>  	OD_MCLK,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d75a67cfe523..1da6e9469450 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1180,6 +1180,21 @@ static ssize_t amdgpu_set_pp_dpm_vclk(struct
> device *dev,
>  	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK, buf, count);
>  }
>=20
> +static ssize_t amdgpu_get_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return amdgpu_get_pp_dpm_clock(dev, PP_VCLK1, buf);
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK1, buf, count);
> +}
> +
>  static ssize_t amdgpu_get_pp_dpm_dclk(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -2002,6 +2017,7 @@ static struct amdgpu_device_attr
> amdgpu_device_attrs[] =3D {
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,
> 		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> @@ -2091,6 +2107,12 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  		      gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
>  		      gc_ver =3D=3D IP_VERSION(11, 0, 3)))
>  			*states =3D ATTR_STATE_UNSUPPORTED;
> +	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
> +		if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
> +		       gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev-
> >vcn.num_vcn_inst >=3D 2))
> +			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>  		if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
>  		      gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..bffbef3f666d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2006,6 +2006,8 @@ static int smu_force_ppclk_levels(void *handle,
>  		clk_type =3D SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type =3D SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type =3D SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type =3D SMU_DCLK; break;
>  	case OD_SCLK:
> @@ -2393,6 +2395,8 @@ static enum smu_clk_type
> smu_convert_to_smuclk(enum pp_clock_type type)
>  		clk_type =3D SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type =3D SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type =3D SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type =3D SMU_DCLK; break;
>  	case OD_SCLK:
> --
> 2.34.1

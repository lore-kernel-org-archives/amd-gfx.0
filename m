Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD6EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 05:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54FC110EACB;
	Mon, 13 Dec 2021 05:45:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C439A10EACB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 05:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfuAys0TmMEfSg4Jjg0XkMRB6Jeg4Pno6P5dxwRt3gkttrLY3oQENL+7npjhqX88j8isxDqToJ6qS7gRJq4zJRhMge6/0/3h/x+ni2oEcgLGpHDxXZJaASbq5+Yu5I0BbLqg+LSlI8LeNcFNeewwk9rpXblWkR88BF1cYj0vEjK86yYBchxQBylar/sCU/jnOtPqxtFJn/8wIPk2CKNLf0rvqsRSVGhusDyLoUzgiuwwqpO1kyvWj4Gv3cDQpmU9lW7R1Ct1uQLC72R3rl1ds5HTQLaEM22sikQ9IJE6A9XYdyDfw7ei84QLvBE48/8La2/u2rDNWZWFmk0RFQQgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqSc6tAbSn21E/Uw4M6zm0z0RL7KThyv+bt81BemmcQ=;
 b=ii4as+RkBTq685z7Jmtw2WnBj5SGQ5OL2Lu0Fw+A9De7eIXzuvlcjpHmNU14U0msvKVFq168whnFyTdKxQ0NKSBGukKo2cRGLgvGe8DJqXwTQbNxuRc/nq+zhWdtUClp+3v/tXCuIhqpVqFkjxSXZpQ4cqGUqYKrX7JEGI18gzUl7PQdRABwRDWvrxujUWI49xgiS/+/gQtuRraLHM3dhnT7NmcQAyq/YhNYgQP2pBPDsBAMYqmE7Jxu+InqAdZsRQj/CMBrR8+0ffPA/7O79N8RCW2j3lCo1H75x0GTtcELbQ3EeW+JgA3KjHDqDS+Z/ez5D0Sa67H3P3tXEtdvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqSc6tAbSn21E/Uw4M6zm0z0RL7KThyv+bt81BemmcQ=;
 b=JcH+WDoDx8DWRqadcedfLhxD7kcNrT5IJ/Q8uYLDxzy3l+97HkMmmx2BjDYNrCF0p2WZLF0pW/U+5ynHU2HgfW+jF7qolBq1dEnmz+eNU004pNs/mMruS2MdSnKrrasfJqv9xhBtj2TMdoVV1tfd0qgmijabzC2y6yAD9Tzd8Xg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Mon, 13 Dec 2021 05:45:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 05:45:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V5 15/16] drm/amd/pm: revise the performance level setting
 APIs
Thread-Topic: [PATCH V5 15/16] drm/amd/pm: revise the performance level
 setting APIs
Thread-Index: AQHX79TyNnI2r6DOOkO1uWaQU5kE/qwv4RQAgAAIShA=
Date: Mon, 13 Dec 2021 05:45:24 +0000
Message-ID: <DM6PR12MB26194D50ECF7DE6D1DA6EE1DE4749@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
 <20211213035223.772700-16-evan.quan@amd.com>
 <DM5PR12MB2469965CA3B320B4D9716905F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469965CA3B320B4D9716905F1749@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-13T05:45:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a3892cb1-c6db-42bd-a27d-8419e4b97d9d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 512d74c5-3e15-4fa2-4d0b-08d9bdfbc297
x-ms-traffictypediagnostic: DM5PR12MB1452:EE_
x-microsoft-antispam-prvs: <DM5PR12MB14529F7732301638B0A4978CE4749@DM5PR12MB1452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lkznWxfG++tYtFkk+e9dpT/fOxqS/ncbX2dNH0kegNU2iSR5y3CUMAtoOh9RcmqkbfOikb+axDA2bfxCef8Azk4l4InsYKJZcXguSE6TMbb3IrHCV4A1FR2aL8walS2L4QucyxbqjTbTv83fGnok5w5qKko2H01qApBA4ho2qqpvVu/tm0kTSCqCSDgHo32itJ5m385xLADvT+Pr0Y4XHmTebMuVOBBbX8nCXSYjHCQQviz6OthoM7ZGJgRJOdgbFccHvpV9WoZJR0hdoFbjnEPHi0Ii+ricLIY5qhcDFqoNo3R5L0xlSUz/ZTaQ6I49UlPFA3KyArV9h0xCZEWF3llQbdUr6vSJLAeseQiTFOdKYbhD8aYlLnPEwqygvVWsNaCTGP2s1+uAQ7d1L/TTWiCQAihq1ta2jjIhatlNq6MU19vXkBKkGTmhqIdqaMHFzN8m5e5FduGdWgn9Kx4cqJjPoMbD1uM864wXbdjNsFzC6Vuf3/hj+lVpLAH7BhEkaUL2xQUWDLcxcZehXum6l/piQkqj5TYrA4GrUQt84elOQ8zPXxBzJULphE4v4pJCEAuRY5SC+GSZ+dBNk3hiJc86yPa2K3uqJRBfHowTR+gWR8yZuAo2N33TiVU0ba0eT5sV2Mylwe75hEIpImVkGjei74QOY6YblAUbnHaQI4V+q5n2FMZvw+Knq3Zo//3hWD4gEDz4qCFEcCP+RGrqzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(66556008)(66446008)(26005)(316002)(66476007)(64756008)(55016003)(8676002)(86362001)(54906003)(8936002)(30864003)(38100700002)(83380400001)(5660300002)(53546011)(52536014)(9686003)(6506007)(76116006)(66946007)(33656002)(110136005)(508600001)(186003)(38070700005)(122000001)(4326008)(2906002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ytRt3aRQuuj7sAHCryeH/jELSAfdq6Q5vR19NiuU5duqFDYzysL33flj41VI?=
 =?us-ascii?Q?HEDu3oYGgPUifH+a9Hmb2uwdyVUquwKC/+wrpFIAZYuOHjxpukNWzEgNzBy/?=
 =?us-ascii?Q?6pmgZlJtSnT0MwGWQwZSsfr83Xf5YdF2Uj8Hfgr63BpDNFzDBzh9wWHDEBMk?=
 =?us-ascii?Q?ynI7fzv9GUxczzkKj1dgPYtP2m4EDR1oBQ7ltfFa1X14agkNofie3xo4VMvH?=
 =?us-ascii?Q?y/TcXdv9MkMyaDZts0OWwcw5n5crKeHNatCnNvtx1JEsXgVLqGSpg0onqokL?=
 =?us-ascii?Q?nG3KtLB2YYO54FXdeEikazqNyU8jPYTaqtbsCzVQkJ+wmZ0RHL1dXcZU/HHu?=
 =?us-ascii?Q?3TZzmTdg3s045nQ8dYUWlhvnm45zz5gvbdGBViXMSNDyIhK0YgMx+pIeDRXH?=
 =?us-ascii?Q?PA6RhnI8kc82MHL81DsvbuXTKPObkFw5BlBG6XllNJ+JOvd/6OUTBMpUojmM?=
 =?us-ascii?Q?ES+wHp2M3WzXpP+0V25y9qip92u+G7N2TPcdMGNG1H6ShK3tz6nYe3hMp29K?=
 =?us-ascii?Q?x922sZPbwzUweSXRFVPUPP1qBov/YRmyC717urWfKtT2Bf3rEPmEPVMARBuU?=
 =?us-ascii?Q?8ovjdAxE6/MGp29KnQYhc6zliNz1L5lM+aVYfmqrRHLrpGNEQ6YyahcYNHS4?=
 =?us-ascii?Q?FEYCBzO9k4ek1qt6fwfsUG7RDK9VCOxwKBTczEfRLD8KsHkHZJyBJTOc4E4D?=
 =?us-ascii?Q?KkI9g9w17ZtvmEsuUe7heQ8ipI8FCUyityinF/zzHU14xf7FtaeNP93o7VA/?=
 =?us-ascii?Q?5uq3qlqKRtOUs2RaxSTj2Z6SNDLDpBOcp2jHH/g130Ga8OCyNYCOu3wimhL+?=
 =?us-ascii?Q?xOLX9NwB3upH++Hj8e4polpSzE5wtfUTApD3wFxdurxQ62y1EwbL9VSbb4gW?=
 =?us-ascii?Q?4CQW1dhlQpClzZnRK5PQMZmO1roHMh00gne64z/+ePdAlT57wgGDdjTL4eqw?=
 =?us-ascii?Q?W4Z5Hsx4PMDG8AUb/Wy1XNCluSHq4B8kxcgB47Fgz8z6ECQu87NKvx98ae+8?=
 =?us-ascii?Q?lItMeg/RhjsVSFsdoCj6lOfcND2WyA/CWXtOou4TgtCDa3x7M2HkZBiUzR2/?=
 =?us-ascii?Q?Oq+A6xobfBsO+6coF4ZvWpNlBoifv8N2phWwpvO/3JkHOHHkq88xTkf7tFs9?=
 =?us-ascii?Q?uGMA+RqWc/6oGtyRLUpkBARYR2Yf4QZZymQhzv1mVrCDBZNlwyy+0QmQWNh6?=
 =?us-ascii?Q?ao3SA2AzY7AnKKzFx9Ku6cGTjyq0n/kKgd96kZfWwFPmyXUfGZmwmX1wKhFZ?=
 =?us-ascii?Q?dgV8pcmw9QO40DdMu4Cj95ckGoLEgDztOE6Gs7Q1zhoixkFsCBYy1D+/SUwg?=
 =?us-ascii?Q?zNeIicdNKT1BOApGXEi6wxHgzKoX6ifO2R4JiZkz6nIofyZq5ircJo21JBTF?=
 =?us-ascii?Q?VrIqF7u5zcq17f/iS0d4BDXGybQHp2h2Fmvk+FMaAx/JELOf3ewf/n6QamJ0?=
 =?us-ascii?Q?1qpCqffAfCSvBnVyatzAH4m1IwJo1dOTg8rIvHaRg0OYd5/asGA5T5S16Jwt?=
 =?us-ascii?Q?m79wVASS+lEf5DGbsRhf+RosfJtNhI/hJjdzAF9ylcyn+dWGBMHqJQq4+JeV?=
 =?us-ascii?Q?FTa+wRUy0OuGKfwPbYg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d74c5-3e15-4fa2-4d0b-08d9bdfbc297
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 05:45:24.7722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGZmgQZbL3QwGRZOfUjw2ew0lsnO/lQcYg+bYI+lbeAyjKUoYsxA3d5VyH2mjBd5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, December 13, 2021 1:15 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: RE: [PATCH V5 15/16] drm/amd/pm: revise the performance level
> setting APIs
>=20
> [Public]
>=20
> A coding style nitpick.
>=20
> 	int ret =3D 0;
> +	uint32_t profile_mode_mask =3D
> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
> +
> 	AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
> +
> 	AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
> +
> 	AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>=20
> It's better to declare short variable at the end. So pls move "int ret =
=3D 0;" after
> profile_mode_mask.
[Quan, Evan] Sure, will update that.

BR
Evan
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan
> Quan
> Sent: Monday, December 13, 2021 11:52 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH V5 15/16] drm/amd/pm: revise the performance level
> setting APIs
>=20
> Avoid cross callings which make lock protection enforcement on
> amdgpu_dpm_force_performance_level() impossible.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ie658140f40ab906ce2ec47576a086062b61076a6
> --
> v1->v2:
>   - drop unused enable_umd_pstate callback(Lijo)
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 29 ++++++++++++++++---
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 17 ++++++-----
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 12 --------
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 15 ----------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
>  6 files changed, 34 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index f57a1478f0fe..fb6ad56ad6f1 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -268,7 +268,6 @@ enum amd_dpm_forced_level;
>   * @set_clockgating_state: enable/disable cg for the IP block
>   * @set_powergating_state: enable/disable pg for the IP block
>   * @get_clockgating_state: get current clockgating status
> - * @enable_umd_pstate: enable UMD powerstate
>   *
>   * These hooks provide an interface for controlling the operational stat=
e
>   * of IP blocks. After acquiring a list of IP blocks for the GPU in use,=
 @@ -
> 299,7 +298,6 @@ struct amd_ip_funcs {
>  	int (*set_powergating_state)(void *handle,
>  				     enum amd_powergating_state state);
>  	void (*get_clockgating_state)(void *handle, u32 *flags);
> -	int (*enable_umd_pstate)(void *handle, enum
> amd_dpm_forced_level *level);
>  };
>=20
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index ce80430c0eb6..106f6ee955f4 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -301,6 +301,10 @@ static ssize_t
> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  	enum amd_dpm_forced_level level;
>  	enum amd_dpm_forced_level current_level;
>  	int ret =3D 0;
> +	uint32_t profile_mode_mask =3D
> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
> +
> 	AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
> +
> 	AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
> +
> 	AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>=20
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> @@ -354,10 +358,7 @@ static ssize_t
> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  	}
>=20
>  	/* profile_exit setting is valid only when current mode is in profile
> mode */
> -	if (!(current_level &
> (AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD |
> -	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
> -	    AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
> -	    AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)) &&
> +	if (!(current_level & profile_mode_mask) &&
>  	    (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
>  		pr_err("Currently not in any profile mode!\n");
>  		pm_runtime_mark_last_busy(ddev->dev);
> @@ -365,6 +366,26 @@ static ssize_t
> amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>  		return -EINVAL;
>  	}
>=20
> +	if (!(current_level & profile_mode_mask) &&
> +	      (level & profile_mode_mask)) {
> +		/* enter UMD Pstate */
> +		amdgpu_device_ip_set_powergating_state(adev,
> +
> AMD_IP_BLOCK_TYPE_GFX,
> +
> AMD_PG_STATE_UNGATE);
> +		amdgpu_device_ip_set_clockgating_state(adev,
> +
> AMD_IP_BLOCK_TYPE_GFX,
> +
> AMD_CG_STATE_UNGATE);
> +	} else if ((current_level & profile_mode_mask) &&
> +		    !(level & profile_mode_mask)) {
> +		/* exit UMD Pstate */
> +		amdgpu_device_ip_set_clockgating_state(adev,
> +
> AMD_IP_BLOCK_TYPE_GFX,
> +						       AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(adev,
> +
> AMD_IP_BLOCK_TYPE_GFX,
> +						       AMD_PG_STATE_GATE);
> +	}
> +
>  	if (amdgpu_dpm_force_performance_level(adev, level)) {
>  		pm_runtime_mark_last_busy(ddev->dev);
>  		pm_runtime_put_autosuspend(ddev->dev);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 3c6ee493e410..9613c6181c17 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -953,6 +953,7 @@ static struct amdgpu_ps
> *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
>=20
>  static int amdgpu_dpm_change_power_state_locked(struct
> amdgpu_device *adev)  {
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>  	struct amdgpu_ps *ps;
>  	enum amd_pm_state_type dpm_state;
>  	int ret;
> @@ -976,7 +977,7 @@ static int
> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>  	else
>  		return -EINVAL;
>=20
> -	if (amdgpu_dpm =3D=3D 1 && adev->powerplay.pp_funcs-
> >print_power_state) {
> +	if (amdgpu_dpm =3D=3D 1 && pp_funcs->print_power_state) {
>  		printk("switching from power state:\n");
>  		amdgpu_dpm_print_power_state(adev, adev-
> >pm.dpm.current_ps);
>  		printk("switching to power state:\n"); @@ -985,14 +986,14
> @@ static int amdgpu_dpm_change_power_state_locked(struct
> amdgpu_device *adev)
>=20
>  	/* update whether vce is active */
>  	ps->vce_active =3D adev->pm.dpm.vce_active;
> -	if (adev->powerplay.pp_funcs->display_configuration_changed)
> +	if (pp_funcs->display_configuration_changed)
>  		amdgpu_dpm_display_configuration_changed(adev);
>=20
>  	ret =3D amdgpu_dpm_pre_set_power_state(adev);
>  	if (ret)
>  		return ret;
>=20
> -	if (adev->powerplay.pp_funcs->check_state_equal) {
> +	if (pp_funcs->check_state_equal) {
>  		if (0 !=3D amdgpu_dpm_check_state_equal(adev, adev-
> >pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
>  			equal =3D false;
>  	}
> @@ -1000,24 +1001,24 @@ static int
> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>  	if (equal)
>  		return 0;
>=20
> -	if (adev->powerplay.pp_funcs->set_power_state)
> -		adev->powerplay.pp_funcs->set_power_state(adev-
> >powerplay.pp_handle);
> +	if (pp_funcs->set_power_state)
> +		pp_funcs->set_power_state(adev->powerplay.pp_handle);
>=20
>  	amdgpu_dpm_post_set_power_state(adev);
>=20
>  	adev->pm.dpm.current_active_crtcs =3D adev-
> >pm.dpm.new_active_crtcs;
>  	adev->pm.dpm.current_active_crtc_count =3D adev-
> >pm.dpm.new_active_crtc_count;
>=20
> -	if (adev->powerplay.pp_funcs->force_performance_level) {
> +	if (pp_funcs->force_performance_level) {
>  		if (adev->pm.dpm.thermal_active) {
>  			enum amd_dpm_forced_level level =3D adev-
> >pm.dpm.forced_level;
>  			/* force low perf level for thermal */
> -			amdgpu_dpm_force_performance_level(adev,
> AMD_DPM_FORCED_LEVEL_LOW);
> +			pp_funcs->force_performance_level(adev,
> AMD_DPM_FORCED_LEVEL_LOW);
>  			/* save the user's level */
>  			adev->pm.dpm.forced_level =3D level;
>  		} else {
>  			/* otherwise, user selected level */
> -			amdgpu_dpm_force_performance_level(adev,
> adev->pm.dpm.forced_level);
> +			pp_funcs->force_performance_level(adev, adev-
> >pm.dpm.forced_level);
>  		}
>  	}
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index d57d5c28c013..5a14ddd3ef05 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -323,12 +323,6 @@ static void pp_dpm_en_umd_pstate(struct
> pp_hwmgr  *hwmgr,
>  		if (*level & profile_mode_mask) {
>  			hwmgr->saved_dpm_level =3D hwmgr->dpm_level;
>  			hwmgr->en_umd_pstate =3D true;
> -			amdgpu_device_ip_set_powergating_state(hwmgr-
> >adev,
> -					AMD_IP_BLOCK_TYPE_GFX,
> -					AMD_PG_STATE_UNGATE);
> -			amdgpu_device_ip_set_clockgating_state(hwmgr-
> >adev,
> -						AMD_IP_BLOCK_TYPE_GFX,
> -						AMD_CG_STATE_UNGATE);
>  		}
>  	} else {
>  		/* exit umd pstate, restore level, enable gfx cg*/ @@ -336,12
> +330,6 @@ static void pp_dpm_en_umd_pstate(struct pp_hwmgr  *hwmgr,
>  			if (*level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
>  				*level =3D hwmgr->saved_dpm_level;
>  			hwmgr->en_umd_pstate =3D false;
> -			amdgpu_device_ip_set_clockgating_state(hwmgr-
> >adev,
> -					AMD_IP_BLOCK_TYPE_GFX,
> -					AMD_CG_STATE_GATE);
> -			amdgpu_device_ip_set_powergating_state(hwmgr-
> >adev,
> -					AMD_IP_BLOCK_TYPE_GFX,
> -					AMD_PG_STATE_GATE);
>  		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5fbad92738b..29f521854796 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1674,14 +1674,7 @@ static int smu_enable_umd_pstate(void *handle,
>  		/* enter umd pstate, save current level, disable gfx cg*/
>  		if (*level & profile_mode_mask) {
>  			smu_dpm_ctx->saved_dpm_level =3D smu_dpm_ctx-
> >dpm_level;
> -			smu_dpm_ctx->enable_umd_pstate =3D true;
>  			smu_gpo_control(smu, false);
> -			amdgpu_device_ip_set_powergating_state(smu-
> >adev,
> -
> AMD_IP_BLOCK_TYPE_GFX,
> -
> AMD_PG_STATE_UNGATE);
> -			amdgpu_device_ip_set_clockgating_state(smu-
> >adev,
> -
> AMD_IP_BLOCK_TYPE_GFX,
> -
> AMD_CG_STATE_UNGATE);
>  			smu_gfx_ulv_control(smu, false);
>  			smu_deep_sleep_control(smu, false);
>  			amdgpu_asic_update_umd_stable_pstate(smu-
> >adev, true); @@ -1691,16 +1684,9 @@ static int
> smu_enable_umd_pstate(void *handle,
>  		if (!(*level & profile_mode_mask)) {
>  			if (*level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
>  				*level =3D smu_dpm_ctx->saved_dpm_level;
> -			smu_dpm_ctx->enable_umd_pstate =3D false;
>  			amdgpu_asic_update_umd_stable_pstate(smu-
> >adev, false);
>  			smu_deep_sleep_control(smu, true);
>  			smu_gfx_ulv_control(smu, true);
> -			amdgpu_device_ip_set_clockgating_state(smu-
> >adev,
> -
> AMD_IP_BLOCK_TYPE_GFX,
> -
> AMD_CG_STATE_GATE);
> -			amdgpu_device_ip_set_powergating_state(smu-
> >adev,
> -
> AMD_IP_BLOCK_TYPE_GFX,
> -
> AMD_PG_STATE_GATE);
>  			smu_gpo_control(smu, true);
>  		}
>  	}
> @@ -2146,7 +2132,6 @@ const struct amd_ip_funcs smu_ip_funcs =3D {
>  	.soft_reset =3D NULL,
>  	.set_clockgating_state =3D smu_set_clockgating_state,
>  	.set_powergating_state =3D smu_set_powergating_state,
> -	.enable_umd_pstate =3D smu_enable_umd_pstate,
>  };
>=20
>  const struct amdgpu_ip_block_version smu_v11_0_ip_block =3D diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 9d4a85c39ad2..778196167de2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -363,7 +363,6 @@ struct smu_dpm_context {
>  	uint32_t dpm_context_size;
>  	void *dpm_context;
>  	void *golden_dpm_context;
> -	bool enable_umd_pstate;
>  	enum amd_dpm_forced_level dpm_level;
>  	enum amd_dpm_forced_level saved_dpm_level;
>  	enum amd_dpm_forced_level requested_dpm_level;
> --
> 2.29.0

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE32D2E01E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 08:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571B410E786;
	Wed, 23 Oct 2024 08:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R44hZp2u";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B7E10E786
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 08:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i56Ysh1QDlJybeita6uXkTCDdQYJXt27Mokn2TCwvN1kvEkJF+OhVYS/W1KTq8KKum4WspqHUNyPovTTHsdMsbNK2W3tJ0KWeIDNjHZ0yrEYzNwqJA6IwabqKXzBD1tyFCdi0qq9nKD/9oCRmjThR0MOsU7uVAZFqY8SAp5s5W4zU4kor/VUBAuTHzUsNKcOdPcBqRXEQvRwXR922YWqMTNsDRkC8dqOgJN5YzyB+nRKWSFNzhZItoHd3OD3DEC+xcsdbHeOAtaCDnar/pC0O0UZn6MH6zsPSnwJtfYYicvL5rmi0ewJVrNj1s/jD8dhj6BojeMPj0F8oUxnV0dltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPEEXW6QW+ojGpcOJ4z+Lm9T9yL68yEKuPbEtZ56aj8=;
 b=hK5WXXyg8AVjE1DN/6QyqWy4D/lnniXB9mxc+JYyLxeUG/X0dd2V6LRcsg18rIchHPeJrxsF/SOZY4Scfm30HNrdYhV8PIMORKDs5Dfoh3C+87XA+eZHsjOzF3UwThpFC41L2Bfq6HXi336oUntPhS6B0TaQbFaGFbJtJAeILx9fllkpCiFYWGkwSzYc4RySb1ap7Yr+cr8EE96jX2/PR7HSMMc8WFB7moDbH4zXPZrDNhr478LLv/dihvrvo+Vb70aNAKt3RcsSEaTC1l0kt2FMGIodcvcjzTKBLHyc9reNp7+EgQXgK9UTtR2gCGRgWfbg3I7yyKG8OD240VpqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPEEXW6QW+ojGpcOJ4z+Lm9T9yL68yEKuPbEtZ56aj8=;
 b=R44hZp2uasafaMvE6YnZJrbDSm9Ix8PD4Pwqgn5qiyGlVJnoMUAeMarMcAFnEn8v910qaMtCYuAYCxwiPnO6ItBgHDV12cU7P0e+STAc/PWzaJcRvkMO0DEgDya/DfsmwNkxE3oOw0FT8mD+pI8QtUtOsSYnQJ6/HcEeeRXDAEY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 08:09:25 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 08:09:25 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
Thread-Index: AQHbHg2S9Q7S+WlsDEqU6j9plY5fkLKUCO1A
Date: Wed, 23 Oct 2024 08:09:24 +0000
Message-ID: <DS7PR12MB600573E09E971FDCDBD3EEEBFB4D2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
 <20241014074902.1837757-2-Prike.Liang@amd.com>
In-Reply-To: <20241014074902.1837757-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f2a97aca-3a2d-42b7-b1ae-494fe0943011;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-23T08:06:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 8db31f59-6772-41c0-6903-08dcf33a022b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?skh6s7DjBwyjztFlAVuPResc1GfyJSH4yYmZ/wBs02ALbAZfhGJ1uFARm7jI?=
 =?us-ascii?Q?X1VGIH8UW4oMClW+OIDKLezAwe4X6riCyEcwrADgjy5Mw4i73gJpgmQZ7Mi8?=
 =?us-ascii?Q?Ks/rPmxeq1Wa/RS6givOkrzmmnIGbTWhI74TxvblMtsJcutOSV+4Qhuv4AGO?=
 =?us-ascii?Q?oB9AXuxFPkdn/n1SFnOqYrzygxvwjXa+KSPNr1D7tnyhl642+UXvVb/l+5Gp?=
 =?us-ascii?Q?bo3scYdjRpxCVdy4BOQ8/bRie/GrxS7vySGCtlpmWWP06/qGszu/LPcjvxHn?=
 =?us-ascii?Q?++UsOsb3uGBzorUxwnae5HuZlufz75hNIgFmKy2UsPs1oFjPzIlx7yLF4FfK?=
 =?us-ascii?Q?qqC4RSYNHdX/akgNl7VTjwBmZB95X/5FNsszyrUxXmP03ejE6WkH78lM5/CP?=
 =?us-ascii?Q?a7kPIltvYNlVyP/BTLheXNgqUL2B26VVYbmRVhHvRQ6x91lAUVvm9NNUeaRt?=
 =?us-ascii?Q?jcdvVPsa/ZJoEBsZ/UkFLQ7Fs1tTABBc5zEO4RLyMr2q4WgnJJFE99RB9Ngq?=
 =?us-ascii?Q?81ERIopUDn+TWUBpIKtKHQsM4YMEk5EQRwiL93sQvuzMto7zdAlJ/ibCKq/w?=
 =?us-ascii?Q?hoyxDYJ2mfxPCAtqxMlJ+B4fyK4SihnupQ2V6D4CgUSqytAqpRPXJ6qkv0rl?=
 =?us-ascii?Q?laFOdRgjw9vDdCbRschOYrlQUJNgqLtY0CwVElEQt3elgdW61TcaQLvN+Inv?=
 =?us-ascii?Q?uDN9nmOeetcC9rvSVTgGCdLwXIGV4bcaH+FMuONF45fG9Rx4bv64Ho70xuPp?=
 =?us-ascii?Q?MHYX6PfEY/niEAC3T6TVwLt10Rcuab8eKD0MMWVQ83dAnfwvPduxN5YZ8pn8?=
 =?us-ascii?Q?W0BC+Ujj2ihV38EU2dV67NXn6vfGVl2adsLAXqpPBOE4LYX0XSpvDxHNzBGJ?=
 =?us-ascii?Q?YQWN8M/CBVflRHdFZlfR/equRU5U75QJTcSApjM+3of4px36efGeM0gFmrpV?=
 =?us-ascii?Q?bTAE8w4h2zw8HO+SEtJmVr/TX32kHa6fcdqt2LVuCckUaNywoc0kHp+pA2m/?=
 =?us-ascii?Q?wEUxcbK2WoGXWvqJw1i9Zr2yH8NaKybIRAwVei/yPsK0RmSPSmQS5Uosk2fw?=
 =?us-ascii?Q?BSHNvaVMtxq6OgRJg71VJP7pyNYMUJfIhOGUarN7mmWpzJrnBLfoQtCndD0Z?=
 =?us-ascii?Q?9mQR+4FIBmRp8BiOM0eN48wnRjVYqS5ychBJqkfuhgLTGcZv1btw3SOK6311?=
 =?us-ascii?Q?plHzZXlH6Wf5obrV9RIV+P8YEkegAUmq5Ko7aykYKSGmL/IpQ3j8tV4G4SbR?=
 =?us-ascii?Q?UsiL4Y91cMe7Ctg/339rNgJWSvpr/y2ksr+At9u3UV1pLN/qyCPnKHU1Jo3+?=
 =?us-ascii?Q?sgcEI+B8OrAhJskUV7BTzfgBu54UB2UgXqtF2It60aCw93KrmCO1sxrrEF/7?=
 =?us-ascii?Q?VeL2aRI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hvRwQVRFSpogqT40FmVyidUpqrC/mJQD3TveaUgugGEy0olsrmc130B9BH6+?=
 =?us-ascii?Q?LpMsLtTqFggokh3j5nlReekqoVC8sj/F24Q5xNWOSv3Lnv8RYV+ZVnglklKC?=
 =?us-ascii?Q?6Ux6q3cMWvMXBAS4obHUbSvFh1waHrq4QDcrzURwEnZKgy7wVZYvDrBP1QeN?=
 =?us-ascii?Q?8Gf7dlEdOOE2FeJD9O4JXCPs4GYjr4iBEtAVOQ0wHVPnhSTv8wJAWjkeD/iA?=
 =?us-ascii?Q?abGlKqjxV9wOChsKIa0iGr57Yxf8HBT64UpWO3hufXLZksICHX3jDscBpasr?=
 =?us-ascii?Q?PBr7XZkoBGzVxbjGF2P7ZPD6yb+atsqHv1kglGnSLbVMq6NfLtlWyKwDVUQT?=
 =?us-ascii?Q?3+DFb7f/N6aFt4xGRvhlK3ztl6Hau9a9v7XyjZG/NwXnWEbaYK0YhqkNwfZn?=
 =?us-ascii?Q?i0QuPFtwYIMIdQibtUWBQ4gSr/puYYWVCsYMiqqoVkdNUb1/jIq7uUahO0Gu?=
 =?us-ascii?Q?6bMaUthirlbZU3fVGpNCnXS7oHpqOUt2yFpO1j+5gesWXQ5c2fgOWoQ1Icc6?=
 =?us-ascii?Q?iMRE0fWKik8NtGfbEGCMzrGL8D4ChlQRVHxcicPNHFW9C0dQLlmLBM9pLh87?=
 =?us-ascii?Q?6urH/9vvn9zsCdeO6pcRt1Do5sQ1WkPBsTDAhg+h5+0SJYxud3BAcko29VMV?=
 =?us-ascii?Q?TZYhBYXjoPzedsgoytO8Jk/LZvHZT0e6BSJHiT9WkQvu7HEoZG7tvPtvYIah?=
 =?us-ascii?Q?BpeAOh6Dm0xqQ6g7TQsxGw0gtoM3wbfz/RtlJs7xfygX2jUUkRWJ5kwKJz7U?=
 =?us-ascii?Q?hyBuhrmNgENCQ+DzjHTYUEdS+jw2J/YLQ2t0rxfT6ZUzgOKMaiU3UGAs2+ky?=
 =?us-ascii?Q?bGnCjYsF0kopkBSktXKRs1b28GWR0+eIeayR1S65cLEYpqzLM/Jbjwub2Jwy?=
 =?us-ascii?Q?j88x1OWFaqmpvb246mzPDkUMzwNsWobF/FTvsLjuVN8YfFlSsWEF24lcqxpv?=
 =?us-ascii?Q?7v79HZPvrcPRYPdJChSBd71Py0VvIhztv6k1Mo1iU18RaiB3BICL2+/gmiJL?=
 =?us-ascii?Q?nqcst71oDZIFghtNurI9gr45jM7diOZcW8sczrPyciSfzpQogjTxDF03qIAj?=
 =?us-ascii?Q?a02jeabhAEdsdhU4iDRxtO7HfIUhZaTIoMbfK7cmMm0IG6yPZiyhOGzZFncL?=
 =?us-ascii?Q?Nsl/IYL6t24SaTrLlQzGOqGkBNxxxEhSljAilIcZnPI+OSI2GTBuRTvXgrdQ?=
 =?us-ascii?Q?igoY56hru3+pC9gghYjzHCC9p90qtJOYbfdB/lxRXNfHJCajpebL7TNZ1Z9x?=
 =?us-ascii?Q?kD72KgmyiB/sVNEAyIC87cspLexJakI+xKBx9FfJ3OhUtNPcXTAxAUTbeAyG?=
 =?us-ascii?Q?T4xeyhwpRoBWeyIah6IoHZPtuVLmsdkpxnJjn+4M/SgTpPGAsZ5ygAlL8xLT?=
 =?us-ascii?Q?tN/iaJWeePMDPFU4L1o89O/ahpHCDhf1NfOPKV42iwjUWUMO8SXSzmAcPAgA?=
 =?us-ascii?Q?S0DmpZwhifl/NUZ8cjB4IfXSRhgqNztLVy4mF6gaTt236EUnF7cQIBecio4h?=
 =?us-ascii?Q?+qZvXGRCN9T/EIUveoJ8xt7rsVfBggBDJ3NMP+ohXO755KZfBv3HmYWyCv0U?=
 =?us-ascii?Q?rNB8PXzErWV3JqCJuG0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db31f59-6772-41c0-6903-08dcf33a022b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 08:09:24.9713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5QTJu1m8qUwG8r5ECPkn0CmV81/CDbAxSZW6vtmNdsV25gNZhE/SpqORr3AIlhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping on this series.

Thanks,
Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Monday, October 14, 2024 3:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
>
> To check the status of S3 suspend completion, use the PM core
> pm_suspend_global_flags bit(1) to detect S3 abort events. Therefore, clea=
n up the
> AMDGPU driver's private flag suspend_complete.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 2 +-
>  5 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..9b35763ae0a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1111,8 +1111,6 @@ struct amdgpu_device {
>       bool                            in_s3;
>       bool                            in_s4;
>       bool                            in_s0ix;
> -     /* indicate amdgpu suspension status */
> -     bool                            suspend_complete;
>
>       enum pp_mp1_state               mp1_state;
>       struct amdgpu_doorbell_index doorbell_index; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 680e44fdee6e..78972151b970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>
> -     adev->suspend_complete =3D false;
>       if (amdgpu_acpi_is_s0ix_active(adev))
>               adev->in_s0ix =3D true;
>       else if (amdgpu_acpi_is_s3_active(adev)) @@ -2516,7 +2515,6 @@ stat=
ic
> int amdgpu_pmops_suspend_noirq(struct device *dev)
>       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>
> -     adev->suspend_complete =3D true;
>       if (amdgpu_acpi_should_gpu_reset(adev))
>               return amdgpu_asic_reset(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index be320d753507..ba8e66744376 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_devi=
ce
> *adev)
>        * confirmed that the APU gfx10/gfx11 needn't such update.
>        */
>       if (adev->flags & AMD_IS_APU &&
> -                     adev->in_s3 && !adev->suspend_complete) {
> -             DRM_INFO(" Will skip the CSB packet resubmit\n");
> +                     adev->in_s3 && !pm_resume_via_firmware()) {
> +             DRM_INFO("Will skip the CSB packet resubmit\n");
>               return 0;
>       }
>       r =3D amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);=
 diff --git
> a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 12ff6cf568dc..d9d11131a744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct
> amdgpu_device *adev)
>        *    performing pm core test.
>        */
>       if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -                     !pm_resume_via_firmware()) {
> -             adev->suspend_complete =3D false;
> +                     !pm_resume_via_firmware())
>               return true;
> -     } else {
> -             adev->suspend_complete =3D true;
> +     else
>               return false;
> -     }
>  }
>
>  static int soc15_asic_reset(struct amdgpu_device *adev) diff --git
> a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index c4b950e75133..7a47a21ef00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -904,7 +904,7 @@ static bool soc21_need_reset_on_resume(struct
> amdgpu_device *adev)
>        * 2) S3 suspend got aborted and TOS is active.
>        */
>       if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
> -         !adev->suspend_complete) {
> +         !pm_resume_via_firmware()) {
>               sol_reg1 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>               msleep(100);
>               sol_reg2 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
> --
> 2.34.1


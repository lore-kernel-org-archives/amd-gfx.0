Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19739C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE2761205
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CE2761205
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020F36E922;
	Wed, 10 Nov 2021 16:05:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF4A6E922
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 16:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUd2eVl/QAeOaMqsjsYptFk9q3EIRM7J00iwfsIWkR1kWKi2bLki2Y4NPxm0ZUAj3ReSQ6Rsi4OxD/y6cJ4+pdgboenxR5MSmleUBnrX8NgYG/Hd12sg0WmqoAZabHpPmlrWiJu/eTfbFEMfUv8e2xHYf2sf+8cgKeSEDqwzDBiUbu+MxzJN4oeB4I7GauF7Da8XlkxoHAPDwb5CF22yIBFfm4zdXfmqxJxpQlkToSl9THYr2Aff5xdKtsBFMfqoQ+UrD7dvvebD71XGNaUItEVdSVlgPFALZ3bJZNAT0FAiTSzXyZIIePvGbf1o0vsKgjJNoqR5XFJ0b1h7sI6YPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T41ipBDSr6O/HoL0JvUqjEoHbMfdbkDFzuCqztMp1+4=;
 b=hNsbB0t4D28yOTVb98IOy9W/ZR+RI7x7dhjH2fFpf1EjeHNnhRjNiJQMOEhYqslKjnNpjGQd+clBIB7DYJPqPwZZCqVODDOGCCg+BKaAdPeHDVz4YW9lYkqJPSydomVWoj3UzxLG9T8emYq84Ir1Xh+VQgC/i7IyqAv12xpWlOIe7UGu1fl48v6I9bOAgMyxR8L1fsFHq2ELVW1eYOuSHhyIulI2d2jU6oR5jSsUZZw3a09ayrgj7FbgYdJfZZ6Sbr4uvadoDJbrx1EUyhEwl+LNaSrkmb+2LA4kC3R2scw3Brci8NP6ijGONlZ3x/cIpIxBcCGN/diAK3oDsdrOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T41ipBDSr6O/HoL0JvUqjEoHbMfdbkDFzuCqztMp1+4=;
 b=ShBV3yTOKVdazN3yUrcRlIt2mCGRPPr10oc+7OcZcU9bqIhMGfzuukMK8PjJBnKE5MUdL1z73OhGOrgKnQfOtDOKKOLa8FJgJJiz5DhdXjhU3B9YcJNWDc4q1U1D8tB/xY1604HekzftqHR27i8yuq6VUx7eufZ6pnK+7Je1IVI=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4012.namprd12.prod.outlook.com (2603:10b6:5:1cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 16:05:05 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:05:05 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform
 profile notification
Thread-Topic: [RFC 2/2] drm/amd/pm: Add support for reacting to platform
 profile notification
Thread-Index: AQHX1fuN+Gs9jWQ/l0O92ikqoZKw0Kv83zWAgAAM12A=
Date: Wed, 10 Nov 2021 16:05:05 +0000
Message-ID: <DM6PR12MB39300185FB03556E914290C297939@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211110062343.10041-1-mario.limonciello@amd.com>
 <20211110062343.10041-3-mario.limonciello@amd.com>
 <CADnq5_MGbOh_Xbg6y4hH6qrSok_YKMj0c4Ma6ZKAE835cm2-hw@mail.gmail.com>
In-Reply-To: <CADnq5_MGbOh_Xbg6y4hH6qrSok_YKMj0c4Ma6ZKAE835cm2-hw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-10T16:00:06.9552235Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d491ce34-ba22-41b4-2098-08d9a463dc48
x-ms-traffictypediagnostic: DM6PR12MB4012:
x-microsoft-antispam-prvs: <DM6PR12MB4012C8EE443D7257AD05E6BD97939@DM6PR12MB4012.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LAKmFJ6oc8YgmrM7+WQv1SeV5H4ks6vLCzbLjAmtNoa7rOEoD6N0bp4o7d/m6wSEVzWT/IoUW39ZHS0uOvV46g5e7dFy+3/Mg6SByzJmV3YIF3CPd66401CJfG2bMBGEXcjUiyPXqg0B1/ANINmyCIKvnHFy2KkbpjHGzMzoYqCT+5tSfVds65mxp9jxtpJ+rEJRjZX/qBiMIfgJrKJytKIG6Z4r0T5j/JXzGslBtOPBqSmGk958ctwnVUvSJHxP8mjl6t+V5dPV3kaV74JqmXNGh2X43dlDfs17kmoLNA7XhiSSW/jDkl06uxgGM5FOyKFT7Q5ICWGbOyYu+uBBWK8EsxOD7ZRtT4sRD+NdMBXPRlXcVP5SbENVBzouTEDbvMARjRKRqQIQdLYyejGR0ZYYRGDvFj+H+NoZNd2eSyzg7F34ntLaqWju2ILsn+WVEIPbvVM3prtnKJR8nseV6q7V2EIXHZyxfqmSau5Qz7lvDkpTLgNMG8gb6z2uKB0XBAarvTqcPKnrLNQeYnXH10Lw1mKmbIEKRuo3cIKcZOIIvYZH/zVI6yKP8HtEq6RlUVuloFG++mK7SqcJF+prVB4/Fe8+ftBc/Aqwb+Sb632Ykq9+0R1bQ4nEPurGCH0y1ATKq3DbXfkVbs7Y/GHPMhBJR863k3HSksNjod6Jvq5gBSC7djVxC3IBplqjcw/7QingPohD2W4MO7wRxorjzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(53546011)(8676002)(38070700005)(26005)(110136005)(86362001)(33656002)(52536014)(64756008)(122000001)(2906002)(66446008)(66556008)(316002)(5660300002)(66946007)(91956017)(71200400001)(8936002)(76116006)(66476007)(4326008)(55016002)(15650500001)(9686003)(186003)(83380400001)(508600001)(6636002)(38100700002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W4eNp9sH8c2wzlFwWrINuyQOkKQnKInaj00HzYGTc7xHB7abTCHbORFuui1Y?=
 =?us-ascii?Q?7SG+65rzU+bdrFJE2dp86ix0DQguA8db1yVOAUF96I8jE9uVAipglAope7hI?=
 =?us-ascii?Q?JEbnOyszyypUFK8EcKnuj7jBVnRglMYp2NJkuKEsSPsmTJNTTNFo7W7dz7Ry?=
 =?us-ascii?Q?lEWkb7Z5oG3zmAN9LSIw85Lp+wBYbBiLMqegNO6gRAKFL+P60M0V1PaN1T6p?=
 =?us-ascii?Q?3taC7GXmO4fYkpGAwNCoigNNU7cHLvqkciseetPuEjxXOySW+mfndGWmLiiD?=
 =?us-ascii?Q?1fRlTGqF54WuOB1zhfm5GSdvaGthbvVGEqB0FMqAoazj1+sg3jxZYZETMWWy?=
 =?us-ascii?Q?xatCvFhiIDv+snhnkYBwmYYLHFLpDcsSCY4N1CTiX6qQ4F9ce7QYi+SPYydY?=
 =?us-ascii?Q?V023myRIhVejJ1soC6oXJ1nveSzBC6mTWXrE2OkY5JR4w7e+VSQMj37EFemE?=
 =?us-ascii?Q?/uwuVo9CAVrKMdfCHSRqekF5MBYCxsIC2tTYbasM0DiaVgV78+iezBNbJpf5?=
 =?us-ascii?Q?c6ROQF5LB6Mkl3u8SPsymCm1HPTiPQ38F+jnQC50HeLtZWA7VJUCF3snfGm0?=
 =?us-ascii?Q?L6Rij8/uKdfAwFDMQFKi0dMLCYRs9BROeOsyoCafARhyMYU8G/Xnk0BrytSx?=
 =?us-ascii?Q?xSgf4tTwzwU9jkVAjWEIV+/6BBxCJEnvxBfooFfq8atdDhbxHNP8GAPsYAL2?=
 =?us-ascii?Q?4PsEw9rM3mdRqvNPFqqUIN+tbU913cO4Lcym+ODvx2dan8U8St9v/1iqK84h?=
 =?us-ascii?Q?tcSV5o3y8QKTdRplLbIQ9JEOt1BQK+kss93+Q7qNDWeIatLxh4v+juBUffSp?=
 =?us-ascii?Q?q0/SBkFqN0Gz1WFRtD35jSGrdpywNxHD5gOXmE+wsxok7LiON+uIPcXsWtBY?=
 =?us-ascii?Q?EUiPdtQXoUaKZJdFGBLgPK3mlKc50cmKFA16r0StMtyedqJK/mc41T5fYDs8?=
 =?us-ascii?Q?HjYGvsqAenB0rF0DyhJaPWT94oESlH08Say/Ycpa6SOcBVIZ9locqIuQ4a0M?=
 =?us-ascii?Q?YC5zJWZz6517aEie6Tb/h9pNLzvA0z9LHsGHpo3BtAbRPL7nLYHXn7xNDGGA?=
 =?us-ascii?Q?gTfztODHT2dobzLXcuLPbYDT9oAoOuTkre9Iq9SzanbeHg0VYBogKbmgJljv?=
 =?us-ascii?Q?vOnxc8K6sgq6lnD/nBti0IcpnKKvWATQyFtxCeZiwsSSuHWGFN1UVhMZClKP?=
 =?us-ascii?Q?iooReHdTXK1S8PBCL7yZxw9CLwku1bqWSrLmmxfznbUMnXPaGwCTx5i3O1zT?=
 =?us-ascii?Q?jOOQLRqBQ0WVrwhwJYkplC6bogJvAM78y7OsA16GFOveR+Th90NnLS093DXY?=
 =?us-ascii?Q?IslaDupqTMI2zud0PLcw7v3AjZYphnxcc6M+vxcfLjr9Zu+yb9Fsut+TpMiC?=
 =?us-ascii?Q?Uo/hxCBnfLx3NSkC2KLcryi/ubImKNA7tsJ9wj5R1z2iv8FMi9e75hEi36jh?=
 =?us-ascii?Q?zzcKap4BvYCo/Za2cLUf50WLMtNRcff3FAgPdx4ZH6uM8rJoagiPkJm3yHYM?=
 =?us-ascii?Q?TclRBSHZcQ6DcvjXTLfVWju/CrKizs24tOIxTKqvGtqoSbzDwghsDsnt+Yh1?=
 =?us-ascii?Q?dD6+1hClpFK56W37U1dY6ZBBocJweoT8nwFO9wFb?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB39300185FB03556E914290C297939DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d491ce34-ba22-41b4-2098-08d9a463dc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 16:05:05.2468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7SaByU3/JcfdLk03zSTrib2dg4/jHuFM5ytXQ7YWVSLcl4KMhnP8gAzxe5qCWQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB39300185FB03556E914290C297939DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I feel it's better to leave to platform vendors. For ex: for APU cases they=
 may have implementations in which their BIOSes talk to PMFW and this might=
 be driving something else here.

Also, not sure how to handle a case like, say a laptop with Intel CPU and A=
MD dgpu.

Thanks,
Lijo

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexdeucher@gmail.com>
Sent: Wednesday, 10 November 2021, 8:44 pm
To: Limonciello, Mario
Cc: amd-gfx list
Subject: Re: [RFC 2/2] drm/amd/pm: Add support for reacting to platform pro=
file notification

On Wed, Nov 10, 2021 at 1:24 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Various drivers provide platform profile support to let users set a hint
> in their GUI whether they want to run in a high performance, low battery
> life or balanced configuration.
>
> Drivers that provide this typically work with the firmware on their syste=
m
> to configure hardware.  In the case of AMDGPU however, the notification
> path doesn't come through firmware and can instead be provided directly
> to the driver from a notification chain.
>
> Use the information of the newly selected profile to tweak
> `dpm_force_performance_level` to that profile IFF the user hasn't manuall=
y
> selected `manual` or any other `profile_*` options.

I don't think we want to force the performance level.  This interface
forces various fixed clock configurations for debugging and profiling.
I think what we'd want to select here is the power profile (see
amdgpu_set_pp_power_profile_mode()).  For this interface you can
select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,
VIDEO, VR, COMPUTE, etc.).  These still use dynamic power management,
but they adjust the heuristics used by the GPU to select power states
so the GPU performance ramps up/down more or less aggressively.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h |   3 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 105 +++++++++++++++++++++++-----
>  2 files changed, 90 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index b85b67a88a3d..27b0be23b6ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>
>         struct amdgpu_reset_control     *reset_cntl;
>         uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_I=
NSTANCE];
> +
> +       /* platform profile notifications */
> +       struct notifier_block           platform_profile_notifier;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 41472ed99253..33fc52b90d4c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -32,6 +32,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/nospec.h>
> +#include <linux/platform_profile.h>
>  #include <linux/pm_runtime.h>
>  #include <asm/processor.h>
>  #include "hwmgr.h"
> @@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct dev=
ice *dev,
>         return count;
>  }
>
> +static int amdgpu_get_forced_level(struct device *dev, enum amd_dpm_forc=
ed_level *level)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +       int ret;
> +
> +       if (amdgpu_in_reset(adev))
> +               return -EPERM;
> +       if (adev->in_suspend && !adev->in_runpm)
> +               return -EPERM;
> +
> +       ret =3D pm_runtime_get_sync(ddev->dev);
> +       if (ret < 0) {
> +               pm_runtime_put_autosuspend(ddev->dev);
> +               return ret;
> +       }
> +
> +       if (adev->powerplay.pp_funcs->get_performance_level)
> +               *level =3D amdgpu_dpm_get_performance_level(adev);
> +       else
> +               *level =3D adev->pm.dpm.forced_level;
> +
> +       pm_runtime_mark_last_busy(ddev->dev);
> +       pm_runtime_put_autosuspend(ddev->dev);
> +
> +       return 0;
> +}
>
>  /**
>   * DOC: power_dpm_force_performance_level
> @@ -264,29 +292,13 @@ static ssize_t amdgpu_get_power_dpm_force_performan=
ce_level(struct device *dev,
>                                                             struct device=
_attribute *attr,
>                                                             char *buf)
>  {
> -       struct drm_device *ddev =3D dev_get_drvdata(dev);
> -       struct amdgpu_device *adev =3D drm_to_adev(ddev);
>         enum amd_dpm_forced_level level =3D 0xff;
>         int ret;
>
> -       if (amdgpu_in_reset(adev))
> -               return -EPERM;
> -       if (adev->in_suspend && !adev->in_runpm)
> -               return -EPERM;
> +       ret =3D amdgpu_get_forced_level(dev, &level);
>
> -       ret =3D pm_runtime_get_sync(ddev->dev);
> -       if (ret < 0) {
> -               pm_runtime_put_autosuspend(ddev->dev);
> +       if (ret < 0)
>                 return ret;
> -       }
> -
> -       if (adev->powerplay.pp_funcs->get_performance_level)
> -               level =3D amdgpu_dpm_get_performance_level(adev);
> -       else
> -               level =3D adev->pm.dpm.forced_level;
> -
> -       pm_runtime_mark_last_busy(ddev->dev);
> -       pm_runtime_put_autosuspend(ddev->dev);
>
>         return sysfs_emit(buf, "%s\n",
>                           (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "aut=
o" :
> @@ -405,6 +417,59 @@ static ssize_t amdgpu_set_power_dpm_force_performanc=
e_level(struct device *dev,
>         return count;
>  }
>
> +static void amdgpu_update_profile(struct device *dev, enum platform_prof=
ile_option *profile)
> +{
> +       enum amd_dpm_forced_level level;
> +       const char *str;
> +       int ret;
> +
> +       ret =3D amdgpu_get_forced_level(dev, &level);
> +       if (ret < 0)
> +               return;
> +
> +       /* only update profile if we're in fixed modes right now that nee=
d updating */
> +       switch (level) {
> +       case AMD_DPM_FORCED_LEVEL_LOW:
> +               if (*profile < PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       case AMD_DPM_FORCED_LEVEL_HIGH:
> +               if (*profile > PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       case AMD_DPM_FORCED_LEVEL_AUTO:
> +               if (*profile =3D=3D PLATFORM_PROFILE_BALANCED)
> +                       return;
> +               break;
> +       default:
> +               dev_dbg(dev, "refusing to update amdgpu profile from %d\n=
", level);
> +               return;
> +       }
> +       if (*profile > PLATFORM_PROFILE_BALANCED)
> +               str =3D "high";
> +       else if (*profile < PLATFORM_PROFILE_BALANCED)
> +               str =3D "low";
> +       else
> +               str =3D "auto";
> +
> +       dev_dbg(dev, "updating platform profile to %s\n", str);
> +       amdgpu_set_power_dpm_force_performance_level(dev, NULL, str, 0);
> +}
> +
> +static int amdgpu_platform_profile_notifier_call(struct notifier_block *=
nb,
> +                                                 unsigned long action, v=
oid *data)
> +{
> +       if (action =3D=3D PLATFORM_PROFILE_CHANGED) {
> +               enum platform_profile_option *profile =3D data;
> +               struct amdgpu_device *adev;
> +
> +               adev =3D container_of(nb, struct amdgpu_device, platform_=
profile_notifier);
> +               amdgpu_update_profile(adev->dev, profile);
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
>  static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>                 struct device_attribute *attr,
>                 char *buf)
> @@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev=
)
>         if (ret)
>                 return ret;
>
> +       adev->platform_profile_notifier.notifier_call =3D amdgpu_platform=
_profile_notifier_call;
> +       platform_profile_register_notifier(&adev->platform_profile_notifi=
er);
> +
>         adev->pm.sysfs_initialized =3D true;
>
>         return 0;
> @@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *ade=
v)
>         if (adev->pm.int_hwmon_dev)
>                 hwmon_device_unregister(adev->pm.int_hwmon_dev);
>
> +       platform_profile_unregister_notifier(&adev->platform_profile_noti=
fier);
>         amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  }
>
> --
> 2.25.1
>


--_000_DM6PR12MB39300185FB03556E914290C297939DM6PR12MB3930namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
I feel it's better to leave to platform vendors. For ex: for APU cases they=
 may have implementations in which their BIOSes talk to PMFW and this might=
 be driving something else here.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Also, not sure how to handle a case like, say a laptop with Intel CPU and A=
MD dgpu.</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<div id=3D"id-f61421a9-d54c-4f81-aa61-517d64763a14" class=3D"ms-outlook-mob=
ile-reference-message">
<div style=3D"font-family: sans-serif; font-size: 13.2pt; color: rgb(0, 0, =
0);"><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg"><strong>From:</strong> amd-gfx &lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexdeucher@gmail=
.com&gt;<br>
<strong>Sent:</strong> Wednesday, 10 November 2021, 8:44 pm<br>
<strong>To:</strong> Limonciello, Mario<br>
<strong>Cc:</strong> amd-gfx list<br>
<strong>Subject:</strong> Re: [RFC 2/2] drm/amd/pm: Add support for reactin=
g to platform profile notification<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style><font size=3D"=
2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">On Wed, Nov 10, 2021 at 1:24 AM Mario Limonciello<=
br>
&lt;mario.limonciello@amd.com&gt; wrote:<br>
&gt;<br>
&gt; Various drivers provide platform profile support to let users set a hi=
nt<br>
&gt; in their GUI whether they want to run in a high performance, low batte=
ry<br>
&gt; life or balanced configuration.<br>
&gt;<br>
&gt; Drivers that provide this typically work with the firmware on their sy=
stem<br>
&gt; to configure hardware.&nbsp; In the case of AMDGPU however, the notifi=
cation<br>
&gt; path doesn't come through firmware and can instead be provided directl=
y<br>
&gt; to the driver from a notification chain.<br>
&gt;<br>
&gt; Use the information of the newly selected profile to tweak<br>
&gt; `dpm_force_performance_level` to that profile IFF the user hasn't manu=
ally<br>
&gt; selected `manual` or any other `profile_*` options.<br>
<br>
I don't think we want to force the performance level.&nbsp; This interface<=
br>
forces various fixed clock configurations for debugging and profiling.<br>
I think what we'd want to select here is the power profile (see<br>
amdgpu_set_pp_power_profile_mode()).&nbsp; For this interface you can<br>
select various profiles (BOOTUP_DEFAULT, 3D_FULL_SCREEN, POWER_SAVING,<br>
VIDEO, VR, COMPUTE, etc.).&nbsp; These still use dynamic power management,<=
br>
but they adjust the heuristics used by the GPU to select power states<br>
so the GPU performance ramps up/down more or less aggressively.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h |&nbsp;&nbsp; 3 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp; | 105 +++++++++++++++++=
++++++-----<br>
&gt;&nbsp; 2 files changed, 90 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index b85b67a88a3d..27b0be23b6ac 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1097,6 +1097,9 @@ struct amdgpu_device {<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_co=
ntrol&nbsp;&nbsp;&nbsp;&nbsp; *reset_cntl;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_versions[HW_ID_MAX][HW=
IP_MAX_INSTANCE];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* platform profile notification=
s */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct notifier_block&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_profile_notifier=
;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static inline struct amdgpu_device *drm_to_adev(struct drm_devic=
e *ddev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c<br>
&gt; index 41472ed99253..33fc52b90d4c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; @@ -32,6 +32,7 @@<br>
&gt;&nbsp; #include &lt;linux/hwmon.h&gt;<br>
&gt;&nbsp; #include &lt;linux/hwmon-sysfs.h&gt;<br>
&gt;&nbsp; #include &lt;linux/nospec.h&gt;<br>
&gt; +#include &lt;linux/platform_profile.h&gt;<br>
&gt;&nbsp; #include &lt;linux/pm_runtime.h&gt;<br>
&gt;&nbsp; #include &lt;asm/processor.h&gt;<br>
&gt;&nbsp; #include &quot;hwmgr.h&quot;<br>
&gt; @@ -200,6 +201,33 @@ static ssize_t amdgpu_set_power_dpm_state(struct =
device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static int amdgpu_get_forced_level(struct device *dev, enum amd_dpm_f=
orced_level *level)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
rm_to_adev(ddev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&am=
p; !adev-&gt;in_runpm)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ddev=
-&gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-=
&gt;get_performance_level)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *level =3D amdgpu_dpm_get_performance_level(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *level =3D adev-&gt;pm.dpm.forced_level;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&=
gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-=
&gt;dev);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * DOC: power_dpm_force_performance_level<br>
&gt; @@ -264,29 +292,13 @@ static ssize_t amdgpu_get_power_dpm_force_perfor=
mance_level(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dev=
ice_attribute *attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)=
<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
rm_to_adev(ddev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_le=
vel level =3D 0xff;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_suspend &amp;&am=
p; !adev-&gt;in_runpm)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EPERM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_get_forced_level(=
dev, &amp;level);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(ddev=
-&gt;dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-&gt;dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-=
&gt;get_performance_level)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; level =3D amdgpu_dpm_get_performance_level(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; level =3D adev-&gt;pm.dpm.forced_level;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(ddev-&=
gt;dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(ddev-=
&gt;dev);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf,=
 &quot;%s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? &quot;auto&quot; :<br=
>
&gt; @@ -405,6 +417,59 @@ static ssize_t amdgpu_set_power_dpm_force_perform=
ance_level(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static void amdgpu_update_profile(struct device *dev, enum platform_p=
rofile_option *profile)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level level;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *str;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_get_forced_level(=
dev, &amp;level);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only update profile if we're =
in fixed modes right now that need updating */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_LOW:<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (*profile &lt; PLATFORM_PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_HIGH:<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (*profile &gt; PLATFORM_PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_AUTO:<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (*profile =3D=3D PLATFORM_PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_dbg(dev, &quot;refusing to update amdgpu profile from %=
d\n&quot;, level);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*profile &gt; PLATFORM_PROFI=
LE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; str =3D &quot;high&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (*profile &lt; PLATFORM_=
PROFILE_BALANCED)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; str =3D &quot;low&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; str =3D &quot;auto&quot;;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(dev, &quot;updating plat=
form profile to %s\n&quot;, str);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_power_dpm_force_perfo=
rmance_level(dev, NULL, str, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int amdgpu_platform_profile_notifier_call(struct notifier_bloc=
k *nb,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsig=
ned long action, void *data)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (action =3D=3D PLATFORM_PROFI=
LE_CHANGED) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum platform_profile_option *profile =3D data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev =3D container_of(nb, struct amdgpu_device, platform_pr=
ofile_notifier);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_update_profile(adev-&gt;dev, profile);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NOTIFY_OK;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static ssize_t amdgpu_get_pp_num_states(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; @@ -3506,6 +3571,9 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;platform_profile_notifi=
er.notifier_call =3D amdgpu_platform_profile_notifier_call;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_profile_register_notifi=
er(&amp;adev-&gt;platform_profile_notifier);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.sysfs_init=
ialized =3D true;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -3519,6 +3587,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.int_hw=
mon_dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmon_device_unregister(adev-&gt;pm.int_hwmon_dev=
);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; platform_profile_unregister_noti=
fier(&amp;adev-&gt;platform_profile_notifier);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_attr_rem=
ove_groups(adev, &amp;adev-&gt;pm.pm_attr_list);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font><br>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB39300185FB03556E914290C297939DM6PR12MB3930namp_--

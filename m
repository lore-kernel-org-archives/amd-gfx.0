Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE3CCD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 08:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB04F10E797;
	Wed, 10 Jun 2026 08:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThSJFNRC";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64EC10E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 08:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTYWvsl504iXOQFiFifI+Q6LnsxotwsE9a5q6NGG+IaaXFesysvuR4SqfWaSUmSlPrDL5h1hUey4UYbzEVAJwaK7YYX7cK4HKeqr+RUJc4cVVcgUFpiypqZlqBl/Jjjs5wKxLkLwmD+AfihyMC6Gr/QVpM0lse9KlElrpBTKFEhnzLmFGT6EWQuGjloRZ8GZBMiA1NA5gwn2BlultjCR6UlHU7FCfUZx2uldPG5wRXbW+4jJZ/CjuUsVB4LHV0IBpvOfSO5JtMZBeaq03l3hDmDvzsCXiEd1hYMHaWJ+qE2LApFb0Sj7mEJF4e9dXi3i2yJ8iW5WflUlNVOaKFnYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/1WG0kNNlcVJuLvYQz9r79GQdhlCMh+v01r32v0FYo=;
 b=n/MSGzENxj79BTbwAqCeu2VMOiIpV0i/IX5ajDSt7G2jQDowTa0jW6Q73SENsFGfMrpBe/UbRybyOEE1ajbGiV11WBzzCdqygPb01vF1b3xsuyQT3pRH5Ifuj0MEK6IAuWdue6GVOZtNcGUwTwCZPNhdHyrlVPt6CxQk+dG39O+vTgKErQS5poiYlQAa6O83nIAGtZhIaknCaFT1BwSMkncE7kyKl+XpBGWWjq0WfW7syp6nnFgy31CAjP+Osqq4rXXX5Zp/lfsUBDOloqx/EY693yggPpLtK9JsPr4qun+49CfxyU4FX553V4zqCuXDA7WIRCfuL1m6tUyNoY273g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/1WG0kNNlcVJuLvYQz9r79GQdhlCMh+v01r32v0FYo=;
 b=ThSJFNRCSKnLB7YHVUDRbpoMKQgIxO7DLyLG5alci/XbDOuYQ7clG7WvDOg3NNbEMmfHFRINajPyaO6i2lk5OL3FwGoo+HpaDc+FL48+mNseU9g1hkwn6G3qEP/p6BI0VV0HqUKp4ZKdxTggS3dDUUHaxSXRKO4cD0e8VdPUsuo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 08:12:32 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:12:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Implement check_bad_page_unlock for uniras
Thread-Topic: [PATCH] drm/amdgpu/ras: Implement check_bad_page_unlock for
 uniras
Thread-Index: AQHc+IqgdZWueVswYkCpi10IVH3oLrY3a9DA
Date: Wed, 10 Jun 2026 08:12:31 +0000
Message-ID: <PH7PR12MB8796CE805788C2861D25D22FB01A2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260610033823.613644-1-cesun102@amd.com>
In-Reply-To: <20260610033823.613644-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-10T07:55:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7289:EE_
x-ms-office365-filtering-correlation-id: 0c559449-77c4-4146-5870-08dec6c8055a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: b+Oy+SSiYm4T0yibqjEKnw2Omwk2/9NJ+JaMihQhmskNU8EXDsEnndzu00HyQAEyfe3K90cQdQ6O17LpfIA4grmDc+b2TBFdVUAKUguA9TWfEoMKBGG0gceAEv/xGX6Eg1cstAJnuBaQEisCfbT9fdxg661XeId0EZccUbfE+olU0p6kT5BYYl3Dm9HX7X5Wx+dKuLEQfMUlCGN9ntAwSM/JN/5XaFpC2/0zZs1WyFnQzfhqKP5oXh4CA861y0BMI8YdxVPaY30BJ8MBkweCoQy6tiFzRAoSVxxmYWteryeOTbep0SNo55pLQck1+tpzFSZK6H9GdoK8B7Iox/D1qk8rGw5AvV3AJ9GbRdV5ZPMH0CUWbBjzsVdRmbRmj+8LXppSAO/YFqq+nPmhpZmLrxzVYrc69zro0j8TNTLe9Fq38jdvih3R5KHd0hWEBNLh5p0fLxoAV+9vHO4kZQe73Vr/2VXVOoics/QepfvRbYqLpFUAliI62tHC6W/gI2bqiuBale3Z2HcOLM6PLz+5F7t/0dyFguqu49fV4QXflF+5iOXhwTcSfjHAqWoicJGd5nVOpTYxGfzysdZdsAvFepaf9LyeNprAvG/Gp6V0cFoydSEVFFQmg2UaRiL00oN3ppgiKfTN6/hdhuUmpSOe+xu3ue/LkxZbTOSdzzQPclGieAcvkJV3IoEW0VijzOV/KpgkIpDFqvqniPrZNwBRxBRH/EI7h6gvbgSHCbfkmeI4Ie5k3GrU2xZ0vs4DNy2P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5h4dbgMeVniklGul1WKQ/fA0oCw/jiSkrYq0ME+mYR6NnIrt/HdwaWX4fBMi?=
 =?us-ascii?Q?E5K1oS2UsJyOrV3Nast9Imz+5VU1/5dgt2pvtbXQNk3ZzXL54ZV9aSIQm5tT?=
 =?us-ascii?Q?CVrGemdQ03IHWI73uj6uO9FNsjAQpFnS8Jzpti+/vxt3Z25oFiuXkLIx1qFJ?=
 =?us-ascii?Q?4iMIPNGkgVvFL0Jc/J9xgAqCY2E6C1qjUxzZu/5PsCoDAhWNc38+jEUCkz/z?=
 =?us-ascii?Q?I4BSQJFSLKnwWf4NT6hAeFk3YVGWrjPC7n1vX1X5nxMxI6jmCYCjUfL07ABv?=
 =?us-ascii?Q?sdNcN52Uq+vgUrScPP/2jQizlX1tRpEK34BM+j5Yc1XvLuPXXs6HmpbR6obZ?=
 =?us-ascii?Q?6e+uI1+mstjThC8bM3/LbET4+1H7ANQ5s4qZBe5KdG3j8psI2Q+YYAl5UOqs?=
 =?us-ascii?Q?mJDyZ/MdxYEbGDmyY+dFzLzuWhODOAPy3mtajiSaLHyFLT+42x0/6lrrcGs2?=
 =?us-ascii?Q?PWk1aw2vnYjOo5mJWvPageMzG+l4hx/p8hOkE1FlsYBdEf5QY/6MLigx1vP3?=
 =?us-ascii?Q?318fxLFCerasu5E2HpyCJ/MWUFf/Q8iQmH1tvdRTqrH+/U0aTuHFXQNA/6rB?=
 =?us-ascii?Q?PKxIYkzEbVsL1NexIVwhs3wz1N5IRvGF+LXOr+4ZBIYrK5A5Dh3qL7+wH2EM?=
 =?us-ascii?Q?Iv0uQbPUV36xgH8sT7C8bVXccHDg7f3yat1RHxAFgR1sVv8YrCzckuHIcoOz?=
 =?us-ascii?Q?78W4REMpCF4i0XVNe5AXcMFGb6i9patKxsu1BD2RQWz6RB07tloCkhOol6xW?=
 =?us-ascii?Q?WtZIqLd4uYH1sbZvDAE/FA8qRxq1H0f7HhMWzKINpA5MgaJ3qYijz3cNmGmJ?=
 =?us-ascii?Q?Mh8TEes7dM94Vn9HT9dSK4+zEKowJDfI9u1DmGYHiprbMSu9whO12W45zmO+?=
 =?us-ascii?Q?+TUenFSfXKKqt8DIODXAY6g8Q3PIs7U2cueAHVMP8B95aGwa391uI0kAaga1?=
 =?us-ascii?Q?tkWbmzgwydSTfAto/DnOkq6lxtaHI6EqjzBBdWlJz9cq7ggP5Tp0KROzRhTV?=
 =?us-ascii?Q?m6jCxfQ8mAWELMZW715X+bHsU3OjC3shT4Y0QmLxfi/6HyiCSLe6pbOkxlCY?=
 =?us-ascii?Q?Wcb8blgMLHR0h0W3LbNiS0oMle9bs3i0MhGgw1UTP/nwLVUwFVaFQsWKS6Ka?=
 =?us-ascii?Q?Kwtbo7fcwrHXW97s5Hpuimly4ZRAuejmkxZNNPaCiDUAWBYJBnYjVskkjQ6t?=
 =?us-ascii?Q?8scrUhgqij2tTZQhvLe+vTcTDqW3Mt/Cycf0NDGkUk+hn2xPj1j/toPeYTI5?=
 =?us-ascii?Q?2tXJQiGttUjjryoCo27ul73yzDyw1caqYgJ1n0gIUorzeR9NkA2i9DbXo9ex?=
 =?us-ascii?Q?G+iyfu3Y9YlZuVvFWC73RSsZb82DMhS/t2dctI3/Cg/dG12BpP6hnN1jKow2?=
 =?us-ascii?Q?Afj8b2h3zYINxpUSjhzG7Gyrqls2/pi7l0Yj5nEzJhukk8vhB6xyb0DhQjA5?=
 =?us-ascii?Q?B6nKHluYGF5+Bp/AfnCxOk8S0jrHLdi8O6hte+p3ypmOpmO0ckAtxC+KuMsE?=
 =?us-ascii?Q?fIOiw3xzL7gmwpgkXM08g2d/bMCX7TXTPNjZ/L+hqcmOYphqBdeutKW3u6bW?=
 =?us-ascii?Q?jfdCxZb6G43nZ3QhLtnlwEV7wy/gOeHtzDuGkjb6nnQAmTCWIEBFIpehDBPW?=
 =?us-ascii?Q?Ih4UhlFawYHLRfHT2vHiES707W1NIAE3X0+TzfYZjJ/13AKu4sHJUjA3BmgK?=
 =?us-ascii?Q?IxJOfrjC1HF5E1lwEn/62bydPf28lqU9x6OjYt0wDl6WIiES?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c559449-77c4-4146-5870-08dec6c8055a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 08:12:31.8594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOjBTYsODEkSNjJCYvUcbaw3gJmZu1cJ91QAZ1Wh48+NK+SQlHFkQq5UIMrjRLRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
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

AMD General

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Wednesday, June 10, 2026 11:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord)
> <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu/ras: Implement check_bad_page_unlock for unir=
as
>
> Add check_bad_page_unlock() to ras_sys_func and racore to support uniras =
bad
> page validation
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  3 ---
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 19 ++++++++++++++
>  drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  3 +++
>  drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 ++
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 10 +++++++
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 26 +++++++++++++++----
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  1 +
>  .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  3 ++-
>  8 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> index cb6498c30834..473b387fa3db 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
> @@ -30,9 +30,6 @@
>  #include "amdgpu_ras_mgr.h"
>  #include "amdgpu_virt_ras_cmd.h"
>
> -/* inject address is 52 bits */
> -#define      RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
> -
>  #define AMDGPU_RAS_TYPE_RASCORE  0x1
>  #define AMDGPU_RAS_TYPE_AMDGPU   0x2
>  #define AMDGPU_RAS_TYPE_VF       0x3
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> index 7d728e523604..cc6d571a5479 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> @@ -266,6 +266,24 @@ static int amdgpu_ras_sys_put_gpu_mem(struct
> ras_core_context *ras_core,
>
>       return 0;
>  }
> +static int amdgpu_ras_sys_check_bad_page_unlock(struct ras_core_context
> *ras_core,
> +                                             uint64_t addr)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
> +     uint64_t pfn =3D addr >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +     if ((addr >=3D adev->gmc.mc_vram_size &&
> +         adev->gmc.mc_vram_size) ||
> +         (addr >=3D RAS_UMC_INJECT_ADDR_LIMIT))
> +             return -EINVAL;
> +
> +     if (pfn >=3D (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT)) {

[Tao] why not use addr >=3D adev->gmc.real_vram_size?

> +             RAS_DEV_WARN(ras_core->dev, "Recorded address out of range:
> 0x%llx!\n", addr);
> +             return -EINVAL;
> +     }
> +
> +     return 0;
> +}
>
>  const struct ras_sys_func amdgpu_ras_sys_fn =3D {
>       .ras_notifier =3D amdgpu_ras_sys_event_notifier, @@ -277,4 +295,5 @=
@
> const struct ras_sys_func amdgpu_ras_sys_fn =3D {
>       .detect_ras_interrupt =3D amdgpu_ras_sys_detect_ras_interrupt,
>       .get_gpu_mem =3D amdgpu_ras_sys_get_gpu_mem,
>       .put_gpu_mem =3D amdgpu_ras_sys_put_gpu_mem,
> +     .check_bad_page_unlock =3D amdgpu_ras_sys_check_bad_page_unlock,
>  };
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> index 8156531a7b63..239e56732e3e 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> @@ -30,6 +30,9 @@
>  #include <linux/mempool.h>
>  #include "amdgpu.h"
>
> +/* inject address is 52 bits */
> +#define RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
> +
>  #define RAS_DEV_ERR(device, fmt, ...)                                   =
            \
>       do {                                                               =
       \
>               if (device)                                                =
             \
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h
> b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 6449d7b8627d..6c3697de1f98 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -231,6 +231,7 @@ struct ras_sys_func {
>               enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
>       int (*put_gpu_mem)(struct ras_core_context *ras_core,
>               enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
> +     int (*check_bad_page_unlock)(struct ras_core_context *ras_core,
> +uint64_t addr);
>  };
>
>  struct ras_ecc_count {
> @@ -399,4 +400,5 @@ int ras_core_get_device_system_info(struct
> ras_core_context *ras_core,
>               struct device_system_info *dev_info);  int
> ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_cor=
e,
>               uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
> +int ras_core_check_bad_page_unlock(struct ras_core_context *ras_core,
> +uint64_t addr);
>  #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 29b1b8f0cc26..efd4023f133b 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -676,3 +676,13 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct
> ras_core_context *ras_core,
>
>       return count;
>  }
> +
> +int ras_core_check_bad_page_unlock(struct ras_core_context *ras_core,
> +             uint64_t addr)
> +{
> +     if (ras_core && ras_core->sys_fn &&
> +             ras_core->sys_fn->check_bad_page_unlock)
> +             return ras_core->sys_fn->check_bad_page_unlock(ras_core, ad=
dr);
> +
> +     return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index d4072350f48f..7ff019a8c7a8 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -373,7 +373,7 @@ static int ras_umc_update_eeprom_ram_data(struct
> ras_core_context *ras_core,
>       struct ras_umc *ras_umc =3D &ras_core->ras_umc;
>       struct eeprom_store_record *data =3D &ras_umc->umc_err_data.ram_dat=
a;
>       uint64_t page_pfn[16];
> -     int count =3D 0, j;
> +     int count =3D 0, i, j;
>
>       if (!data->space_left &&
>               ras_umc_realloc_err_data_space(ras_core, data, 256)) { @@ -=
385,6
> +385,18 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_cont=
ext
> *ras_core,
>                                       bps, bps->cur_nps, page_pfn,
> ARRAY_SIZE(page_pfn));
>       if (count > 0) {
>               for (j =3D 0; j < count; j++) {
> +                     if (ras_core_check_bad_page_unlock(ras_core,
> +                             page_pfn[j] << AMDGPU_GPU_PAGE_SHIFT)) {
> +
> +                             for (i =3D 0; i < data->count; i++)
> +                                     if (page_pfn[j] =3D=3D data-
> >bps[i].cur_nps_retired_row_pfn)
> +                                             break;
> +                             data->bps[data->count].cur_nps_retired_row_=
pfn =3D
> U64_MAX;
> +                             data->count++;
> +                             data->space_left--;
> +                             continue;
> +                     }
> +
>                       bps->cur_nps_retired_row_pfn =3D page_pfn[j];
>                       memcpy(&data->bps[data->count], bps, sizeof(*data->=
bps));
>                       data->count++;
> @@ -489,9 +501,11 @@ static int ras_umc_save_bad_pages(struct
> ras_core_context *ras_core)  {
>       struct ras_umc *ras_umc =3D &ras_core->ras_umc;
>       struct eeprom_store_record *data =3D &ras_umc->umc_err_data.rom_dat=
a;
> -     uint32_t eeprom_record_num;
> +     struct eeprom_store_record *ram_data =3D &ras_umc-
> >umc_err_data.ram_data;
> +     uint32_t eeprom_record_num, logical_count =3D 0;
> +     uint32_t retire_unit =3D ras_core->ras_umc.retire_unit;
>       int save_count;
> -     int ret =3D 0;
> +     int ret =3D 0, i;
>
>       if (!data->bps)
>               return 0;
> @@ -515,8 +529,10 @@ static int ras_umc_save_bad_pages(struct
> ras_core_context *ras_core)
>                       ret =3D -EIO;
>                       goto exit;
>               }
> -
> -             RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM
> table.\n", save_count);
> +             for (i =3D ram_data->count - retire_unit; i < ram_data->cou=
nt; i++)
> +                     if (ram_data->bps[i].cur_nps_retired_row_pfn !=3D U=
64_MAX)
> +                             logical_count++;

 [Tao] I prefer to record the count when we update bad pages instead of tra=
versing the page list for the second time.
BTW, more than one retire_unit pages can be saved in one time.

> +             RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM
> table.\n",
> +logical_count);
>       }
>
>  exit:
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> index 1d3026be509b..05edacc165ba 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
> @@ -139,6 +139,7 @@ struct ras_umc {
>       u32 pending_ecc_count;
>       /* number of entries dropped because pending_ecc_list was full */
>       u32 pending_ecc_dropped;
> +     u32 retire_unit;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> index b809a2f21d73..0064e89ac1ab 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
> @@ -110,6 +110,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_co=
ntext
> *ras_core,
>                       "Unknown HBM type, set RAS retire flip bits to the =
value in
> NPS1 mode.\n");
>               break;
>       }
> +     ras_core->ras_umc.retire_unit =3D 0x1 << flip_bits->bit_num;
>  }
>
>  static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_c=
ore, @@
> -166,7 +167,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_con=
text
> *ras_core,
>
>       idx =3D 0;
>       row =3D 0;
> -     retire_unit =3D 0x1 << flip_bits.bit_num;
> +     retire_unit =3D ras_core->ras_umc.retire_unit;
>       /* loop for all possibilities of retire bits */
>       for (column =3D 0; column < retire_unit; column++) {
>               soc_pa =3D row_pa;
> --
> 2.34.1


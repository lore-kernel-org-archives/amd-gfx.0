Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4F2CA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 19:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B60B10FB2E;
	Thu,  8 Oct 2026 19:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7IUt0Rf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6838510FB2E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 19:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tasnx4uhL6DGrDgCeGDLKa3KSkR0yWCjfShv31WGua/tNkUKR0Mgu6jHcoVxgq0JVSRzQU6wsx2+JHoFheDH2Pd4XUvnIBjLeid0X8AIPymgV229o8lXxhZrguVmwRcQ+wSm33oRx3JUcqtxFYYDPcI1ilpNu/IEUOaaEZSoTVwCifZkhjU3i5G+rWUaZ8S9+b7196dbzz1uBgSXwU72Mif55NRQhP2T/3d1fHPEUlFs+lbkWaTiASOr+IjcA79prCEikPClKoiJAPwUF596+5uTFIkxQ7F9WD1V+n1I/mMIt8b3PMc7+S8C1jVmR8heFnSiSXLBxD2OWCdHMh2R4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wydBq+5Rdnw5rE/ax0hpyZL+ySVJEC2qD1cE6/a9WnM=;
 b=hqvpJvAaEHyWAMAgTcycBVNSWRuz5rg52x3rq30z1VRyfUXiC48BnG0glxikFOU85JoiYTvRM5GJMG+uxGUOu0+CJAbRlHzG811AvMa8iAcShfY+8gIHAZrRcKF4Cdzwpd1pg1rvArPOrIAWiomZ+sj3eCde2mTeBRBPIbUevSZ18tbCnZ0LVp20IDeRtt/dP0F213t1QulYp4LqYat0EVyUqGOztN7MOEAGtRn6WhEvhEEiIIq0jIopPnE909t9tjgedZ3ISRd8tADp3aU8CJf/9kkkn1vymzyKe3/yd4SvbQxnigeO86EcizYnAizOpQXzdtgNuX/WdDAzn1S3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wydBq+5Rdnw5rE/ax0hpyZL+ySVJEC2qD1cE6/a9WnM=;
 b=R7IUt0Rf0/frUrBZniKc/mA1JFqRwXmljT64PZgWy9YEBSF0+vcrKTab/W+r1Wh71MZJH2cca8E+6wIvUHPzSzrpqdTx6FMvO8rHNIf6wmm8MI+p7gOGvLoND7HCh8Y4PANODUr8ADZyNrLvIdtr3e+HoU76FdCIZG1gVkHK94o=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 19:34:53 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b%3]) with mapi id 15.21.0472.015; Thu, 8 Oct 2026
 19:34:52 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: defer XCP DRM device free until primary
 release
Thread-Topic: [PATCH v2] drm/amdgpu: defer XCP DRM device free until primary
 release
Thread-Index: AQHdV1s0M7E+xQfILEmwtHSeQx2dnLb0CPtA
Date: Thu, 8 Oct 2026 19:34:52 +0000
Message-ID: <SA1PR12MB8599C4569765829AB467D3C0ED932@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20260922205731.254264-1-luqmaan.irshad@amd.com>
 <20261008192742.22943-1-luqmaan.irshad@amd.com>
In-Reply-To: <20261008192742.22943-1-luqmaan.irshad@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-08T19:33:22.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DM4PR12MB6397:EE_
x-ms-office365-filtering-correlation-id: 28b7e99f-d598-4846-a8cd-08df257339a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: uy18ujqw9A2Pjv5MhV7GpY6AaDrmGEvEoctn2F5oOInwEFjLRDN6+pV6WH9RJPxwvBbDLyDmBqWev6B36eKCnmIGG2YD9Uq7YrpfHhuoFA3QzWxGWLUYyUWRvZuUQPbPhoqZ8mPnAoRnXX2bK00hkMm/xQ7HMz7XL/aDHvEKJpdtWuZjqUL5/EhOjzotforSvG9IF0jK8ToWxDffQ59BPW/9Ubd2XHK0mNaZ8FtN8VGomtj4akJIJT67xYN/1gDkNYNv5B60jLlqW/jIV8+oBun0WVfD+ZtXEC4hMyrvYJwrHI+zBt+or6eoyILXrhONDTwqSgPwH89hOve3svjjmhKECHF/N566k5AD+7w393cy6ZN9G24wdwnDULtlkcqVtcRqRxlWhfbCjhC/VipzK5i7+cio7OE5c7KfdAf8vvl5rq5ZoKVFanuFHCiuN8jH8oZpXK4kQx//vfkrbIkIdhqEaPaa5rF6wcdzF8mjG1fZDclKe6uIv1fm9ivlzkB5csUNk07gU7gZcPMPNnr95BIEGqSlfdI3U+kjR6/Ar9pkwe5088I32KjufXDEHMJkkGadY1tGU+6LZ0fTG1mOjwQIq5Wc/iKP0b6LMPSADUgK+VgjzY11ejErOiP50f5HUceYu0nZjlggZtWLJ5SrJtUA4UOTwQhWnuJJhc8d7uk1DgWvLdK6GfWfaZo798ALyj1c+wc2ESzFnSZtPNiCLSwldmyXw14hdGiIHYF+yuQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bqxW96PXDA7JvVg6gkZY5+HZf7b/TohpRM/O2ZLoctpcoIa4uc+FfcvMUTaG?=
 =?us-ascii?Q?PmcaHN+5I/YcsHf5kZQEJh+lAAdYfsagHyVbGPu7C8JAAR0tsG2mpcGrO+Ya?=
 =?us-ascii?Q?vp8wIZeTi+gWzGFRF7MwzQlHPl2TJzbsg+PUubz748wUWbPdz/YgMidpRBD7?=
 =?us-ascii?Q?Tmj1L6Kfrt0nf543OivnQ0EGmSGYgHFYaVnmH2gP8T6DMYWLqqKLPsplZxWd?=
 =?us-ascii?Q?GYpEz20SvCl5z87RBqs1DIcn60InKOBETl7ENhN2tHMAwvBgDqEGUaQicymN?=
 =?us-ascii?Q?FoF2Ed4fy3uBLCkbgsf18h5aGHD9iF4DZnSstI3X919eWVNIYdTMevqTWooO?=
 =?us-ascii?Q?esJohMh6Zp3UgTO5cv0AvW22fthWGLQ4mUnWkhqsQlAMJqbaPdYoZYAU/qDX?=
 =?us-ascii?Q?k+vAYglTrtbUXDJxOigAU2I4Q2iKflaGIoiuQpWt2hSI9Vq40DMO/jNiuMmk?=
 =?us-ascii?Q?N2/4F0AgzYgXCQOppdlfFwSWKnNBr+37xuTFHYSycmvawZMvwpXlUFa/YnyF?=
 =?us-ascii?Q?SVmGfdSiNDi3WaQBRm9rimTrqNDppLr+NM0XroIpzaEnlc1oLr+rh4mjYhrQ?=
 =?us-ascii?Q?dvoS/H9Y4Tgz2d3q6WJcXDFoUmrTisjJNBCCvNPweAljCptZSyAdDaBuJnOr?=
 =?us-ascii?Q?RMP2TD5pkRBd2QwMvnC2KvjzENqH4PFuCglxxfMlas/tLYcH7zTvpAp7c1Gl?=
 =?us-ascii?Q?sPtE/RIFcAQAajMGVlhTI1xNMj00YCrkVy3mtrlXs7pbHVWpVOkf1unBZKKA?=
 =?us-ascii?Q?6gLwDUHsV05VygrNk7cO80u3Y9vSLNPb2sJWnwEplLpzTW5kXbYufRoeIip+?=
 =?us-ascii?Q?jdwFRcHvQ9Wwo04OU49fCmhbx/Npj0uAryGuK6oqqgzc7GvLNJ3Uwre+tdxp?=
 =?us-ascii?Q?FYSrFa6Wf5wHFbJmmDn4mipF5hvqhbDC1n6eU5oYTNOmhyiykTrG9rS5H8+A?=
 =?us-ascii?Q?mmGZLiGg8Jy/7iHh1nLmgOnER8jU5L97MV5DO9jJXkRbK+0AUd5ILjWsXsam?=
 =?us-ascii?Q?uGBtU3JSw58uqxrpaQCWHfFiBNQjDlZcT8Jt5WhfxQaQA0hawUqAfdGejLBV?=
 =?us-ascii?Q?EEwMC6kLFCgONECt9ZdmvicTYQ/uwToK4dUfW2sa7MRhhieAFFzhlxklJG9o?=
 =?us-ascii?Q?7kIySD4zo3SkenOQcYOUDfOESy3BQqjO/4HsNBM5x1bd62oclGQvAy9ysaqY?=
 =?us-ascii?Q?qdvviY9mtd9I0vOobyLH5AyYUu9BegcriBUmyOHXo+/x/rPUrPtXjBq9hJz4?=
 =?us-ascii?Q?uRNgN8yV27hdwS/4v5KeAQcnchz53KJhBGuV8nV/TMMcjjU0oAKfd+RsHsI/?=
 =?us-ascii?Q?f1oLHAgMlAOiarO8gqfybTJVlkk2cJHQwWuB0l0XDrbPRFZ5CBpUmHWDXn7H?=
 =?us-ascii?Q?BUUawnryuR192ddplZ90UMkgHGqX7n6HJOn2qcq6n3MHLMM7SeyN5cVe6vJZ?=
 =?us-ascii?Q?8uAD2w/q4GHHffEkGurIAr2KPOfzEJOIJ5ZNKTIXW22oTBP9coftSwXslPbd?=
 =?us-ascii?Q?5Qv662G80S5XhXhwpi41kcsHFfQgm55KGaUMRpfa4QLmOlEIP6myc2raCnBA?=
 =?us-ascii?Q?m4S8f8LHgZQhxZsitMLjvB7sjDjFUj2pBySUId8g3Y1tW2BhJ7I1ba4PIroB?=
 =?us-ascii?Q?F69poN79PuaLUiAeEYe1zOgeDFRGUgkbHD28eZFkSuzRnKiGybti4YKQ1iVU?=
 =?us-ascii?Q?ZFPA4E2zu17max0mu0suN9PQLuf9gb3LuEuvcwFdS8ecdRos?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b7e99f-d598-4846-a8cd-08df257339a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 19:34:52.8324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1d6WGQHoMF83KMmUd4OxSGYHHslRhUEj64B7Ts+DJSthP6g7M4sthQpW4s9gCFbcUJG7DjoOrrqwkRsYZmYEKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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

Public

Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>

> From: Irshad, Luqmaan <Luqmaan.Irshad@amd.com>
> Subject: [PATCH v2] drm/amdgpu: defer XCP DRM device free until primary
> release
>
> XCP unplug currently restores the partition minors' device pointers to th=
e
> synthetic p_ddev and frees that device while files opened through those
> minors may still be active. Those files acquired drm_device references on=
 the
> primary ddev because the minors were redirected at XCP allocation time. A=
fter
> unplug reverses the redirection, close paths operate on the already-freed
> p_ddev, causing a use-after-free and p_ddev refcount underflow while leak=
ing
> the matching primary-device references.
>
> Split teardown into two phases. amdgpu_xcp_dev_unplug() only calls
> drm_dev_unplug() so new opens fail, leaving minor->dev pointing at the
> primary device. amdgpu_xcp_dev_fini() restores the partition device point=
ers
> and frees p_ddev from amdgpu_driver_release_kms(), when the primary
> drm_device reaches final release and all references held by redirected fi=
les have
> been dropped.
>
> Signed-off-by: Luqmaan Irshad <luqmaan.irshad@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 40
> ++++++++++++++++++++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  1 +
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f2f179421c4d..f4bc9e6eb97b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1638,6 +1638,7 @@ void amdgpu_driver_release_kms(struct
> drm_device *dev)  {
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
>
> +     amdgpu_xcp_dev_fini(adev);
>       amdgpu_device_fini_sw(adev);
>       pci_set_drvdata(adev->pdev, NULL);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index a8c79a66df1d..c780d6794b89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -412,7 +412,6 @@ int amdgpu_xcp_dev_register(struct amdgpu_device
> *adev,
>
>  void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)  {
> -     struct drm_device *p_ddev;
>       int i;
>
>       if (!adev->xcp_mgr)
> @@ -422,12 +421,39 @@ void amdgpu_xcp_dev_unplug(struct
> amdgpu_device *adev)
>               if (!adev->xcp_mgr->xcp[i].ddev)
>                       break;
>
> -             p_ddev =3D adev->xcp_mgr->xcp[i].ddev;
> -             drm_dev_unplug(p_ddev);
> -             p_ddev->render->dev =3D adev->xcp_mgr->xcp[i].rdev;
> -             p_ddev->primary->dev =3D adev->xcp_mgr->xcp[i].pdev;
> -             p_ddev->driver =3D  adev->xcp_mgr->xcp[i].driver;
> -             p_ddev->vma_offset_manager =3D adev->xcp_mgr-
> >xcp[i].vma_offset_manager;
> +             drm_dev_unplug(adev->xcp_mgr->xcp[i].ddev);
> +     }
> +}
> +
> +void amdgpu_xcp_dev_fini(struct amdgpu_device *adev) {
> +     struct amdgpu_xcp *xcp;
> +     struct drm_device *p_ddev;
> +     int i;
> +
> +     if (!adev->xcp_mgr)
> +             return;
> +
> +     for (i =3D 1; i < MAX_XCP; i++) {
> +             xcp =3D &adev->xcp_mgr->xcp[i];
> +             if (!xcp->ddev)
> +                     break;
> +
> +             p_ddev =3D xcp->ddev;
> +
> +             /* Unregister devices on paths that did not unplug them
> earlier. */
> +             if (p_ddev->registered)
> +                     drm_dev_unplug(p_ddev);
> +
> +             /*
> +              * All XCP minor files have been released, so it is now saf=
e to
> +              * restore the partition device and free it.
> +              */
> +             p_ddev->render->dev =3D xcp->rdev;
> +             p_ddev->primary->dev =3D xcp->pdev;
> +             p_ddev->driver =3D xcp->driver;
> +             p_ddev->vma_offset_manager =3D xcp->vma_offset_manager;
> +             xcp->ddev =3D NULL;
>               amdgpu_xcp_drm_dev_free(p_ddev);
>       }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 33157409eda0..e2fd32af9932 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -181,6 +181,7 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp
> *xcp,  int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>                               const struct pci_device_id *ent);
>  void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
> +void amdgpu_xcp_dev_fini(struct amdgpu_device *adev);
>  int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>                          struct amdgpu_fpriv *fpriv,
>                          struct drm_file *file_priv);
> --
> 2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A959EC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 20:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D9B10E67C;
	Wed, 15 May 2024 20:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDH8WD/Z";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E9F10E67C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 20:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr0zMvguLuOBPjxdGpu3DJFA/RGN3w45j+eiCv8JUs57IBJM0IHk+1yHxmu0r+GmbVgSwPOE5mei//EKn33lt2cD5Yutzv55xJ/MTvqRSzXa8BmQGelv5KljU+gRkKYJyupJ0SARuzOaNEinG3VIwDKCuLohsqNxD059aV9j08EldJVGADoahoQE7+ANy8N2cKhWLI4y+SoUm8mqa2iOiuzM+gwzSvsGeCPBEy3I2XlYmBxjDFPVcMc5B0NuVfQ0cCb/IstJ1vYhIX1/79olh7Kl7eP7FQTlYPnle0BqQqc3rKGQ/qxijessNl/soub99xMCYABZnKfnDMNIfOJcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz39fH2B1z6hS4DRcn3Jb1vZiTsH15SNnjTfBGQom2M=;
 b=EVWps3nuxpLKtjx7BCSC+KHBJELUOKRoIfCzHW5vEE42FPf/fYnwcT0DHDze2mP4i8dY8cR330ZPWAqX9fvy4urXtDVy2wtrhuQgx2aIkDcW1H/cABhgFIAlXFxdlY5BZDTswOxoHR/N4W0uny8Dq0FLc6dHk5njJS/ntHYGgHfa+DdTsHSsxXbNxhLkXKCtZhM/R+T5cEbBnB51Ox0awis2HPGV+rkRt7qhWK7mRIk+3k2rCi7cvNoG6zA55pveoR47N/02OWNWx8ERLYM0YANHouOHZVz7jx4bRaSNeSO1JfEElh9aW2P6xdxlfXdEvjhgb0zkhvE6pdKul9AbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz39fH2B1z6hS4DRcn3Jb1vZiTsH15SNnjTfBGQom2M=;
 b=dDH8WD/ZPV7Sd66e4ybXEWZsieTST1dFuf5b/QYk5+JXnVQLCMmLU/6jtQOCoW6K91SsR8bmmg6Q2IiNvTIx0byVhbnDcj6kHP/qKhOczUTQCxiXd00m6f/PI6pQJWqvrStYfYRnImyh9AsjPYibvM5lLJsxe7T70/y2d8m4fto=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 20:07:11 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 20:07:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v3 1/4] drm/amdgpu: update the ip_dump to ipdump_core
Thread-Topic: [PATCH v3 1/4] drm/amdgpu: update the ip_dump to ipdump_core
Thread-Index: AQHapsJlQ2++i2CXPUeM2m6BwYkk37GYuScw
Date: Wed, 15 May 2024 20:07:10 +0000
Message-ID: <BL1PR12MB5144193323A251F3EB65E697F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240515121754.1810181-1-sunil.khatri@amd.com>
In-Reply-To: <20240515121754.1810181-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9320520c-6fef-48b5-8bea-9e1fc2a1218b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-15T20:06:21Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB9099:EE_
x-ms-office365-filtering-correlation-id: edd939c4-f5df-472e-2eb8-08dc751a9aa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?cPCUDQC6iwxGgeqkV0wnm3WVvsiTgF/V7LLqe8erIN/k8Blge/IUoFTuymBP?=
 =?us-ascii?Q?aot38oVU11VzJzAnbEXmaVqRYDF5PfVK13dpQUiHjg7/IiBjXn4Bv/Rh3jUC?=
 =?us-ascii?Q?4xV7ujn2ryw3B2LCBIB7be1mcCQpt5bxvHGPKpCBoWpWPwRyG2zHrbq2rMm+?=
 =?us-ascii?Q?TxSKK/vG8kUjO1mxil4GrH3dRZvscai0JIc9uOzop8Kp/nSQkAHWPU15uIIi?=
 =?us-ascii?Q?OGPx2PJxpBr/1NEsBk+tFWLJT6nMYLYkgXmlqftmLU2O7xFn8kvaoNj0Tunc?=
 =?us-ascii?Q?f1q2WN8D4RFQ6X4H+b/XsI9HNXJAPjGEMCZbYuMGquTRHjnWQH/0WMoYJqc6?=
 =?us-ascii?Q?cX+/iljGIHfDfkb9bc0WqOIGDseR3guxgiWm/ld6dA4LRTFT4+w3GM7pUqrA?=
 =?us-ascii?Q?4KowaGb7yeX95zmkAVI+OsQ3oVlvHb2OY0dMYgG+jeO5iIM2sd3wLiuk7kL7?=
 =?us-ascii?Q?xrglHDVOGiy2W9kMh3LSf7Cj7k1DqLGzFPkTMkAahf9b6AaLhrE1qXLCTvP6?=
 =?us-ascii?Q?kbL3CMwK13AQN0xWlZHHWir2OUYzP+eeZbhowgaESA02PoGWZxQaxu2tNyVj?=
 =?us-ascii?Q?8+sRtMrqiPJG0Kk2MqU60K0r8DLrlAd/Wc57NPt/S0Pji8E7WimhKSXMb5w1?=
 =?us-ascii?Q?urPjL5mGmkFInbtnGzBZLUiEOToIwARry+BdnqBZwxEGrpUVP6grbkIUXgRe?=
 =?us-ascii?Q?ClM4u/EpzUIASzuWy2nw2j7OateN71kIlUmt7i+3WtnSxC5yyYN2HZuOUL6d?=
 =?us-ascii?Q?YJcj3AKJQ6MPWea3GDv7aiE0oDIA5QO5b7c06l9HKl/3LTe/qf43iJGhpkQb?=
 =?us-ascii?Q?LG+B24wXxyed/4uucHF3eIwZ8iADmRMKmkrhvs2zcwgnw8YzZG4uRQw2CzRn?=
 =?us-ascii?Q?hNRqEz3551tFAy0F8aXtgcM6g7xcfnDhGlprBHA5WDLhuU6g7zeh/tZKnGMg?=
 =?us-ascii?Q?n7XfbzDrlD+pPV2UHAhEY9IAHcTrBa5+H842BIssCrXQvs2M3JgilwxaUP/Y?=
 =?us-ascii?Q?arqWpdApymtE06r93c/2AYo3dRiqcwd4utw/es37+GMJax7thxJUzPBItHEK?=
 =?us-ascii?Q?nrwaj+6QUtLoKUJEW2IhNilxgdouIY/TAmi/hGpAdpc63ksqfc0gDi33paFd?=
 =?us-ascii?Q?sAYuqEoMSOSjaxJV7Qu3LjOdp2NBxaro1KsmQH+FHNinwWyiThk1H8eV6jMN?=
 =?us-ascii?Q?TjKDEYrPqSFqddpCoxJvH7UdMtztdLdmihgUONHJfUVAi6Qd191rCaKAZpSJ?=
 =?us-ascii?Q?pFRMEbqXzbG+B/m3vITKjbnY4V3HvWEr9PKUqCrolRxI2arp/ZFTraljVuxY?=
 =?us-ascii?Q?PEq6IsmQUBkfo13JWLQC+PLK2+qZPHzC2h84vDY1gPGgvg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zTkeXvpJLzjyQgsWJiuqhyT0GmWyEwkugVzq9mVOEE3RFnROBo7XXgadiTqx?=
 =?us-ascii?Q?pyxu+F0f93ZNoYDAzzRAoMljzwKcWliacwS1lBiE5OV6MSsxuvx3DwLdTywG?=
 =?us-ascii?Q?7KFrZGKdFt3Cp2rFJb0DDKXn8kRmkPWOHseT16a9RP3lM3J5pVsikwW7iXiK?=
 =?us-ascii?Q?b1GKL3vJwKYIwlKadSYij8gw7TFpJ/GJnD8eVwKyZyvz9xGUdSjVIsTBLdBd?=
 =?us-ascii?Q?S05ZRh6BBt09KSK5LtK6B3vPQ8cytrvGze6hE8+uvI8c3zoCDH/wst2sr7UA?=
 =?us-ascii?Q?ShqvkNN2Y2B+/hGy4KXkYwR6bEHlWvNLiGEShgHiFZySQEJKWF9RTpdijF/Q?=
 =?us-ascii?Q?4l8T0oEdNbskg+Bn6hbTWYA0mb4PZcRFWkvCszWOhWc1zfbagRdumOdki3NE?=
 =?us-ascii?Q?qOhAyE/NetONMzmVZBXhDHQei7e+jz34ul1O6kmb7hjG0kszi2zKvBJ8qDhR?=
 =?us-ascii?Q?3VOofO7V+FWZ09nulpzbIwnmpRGc5mS3i3rZ32XF9643hsXZad1eh0ub2YIw?=
 =?us-ascii?Q?JhRENtTLItqjaVEkO/s9Ml5F2GB3BerRQtL2Fcyz7Nqoqhz5oOSyIpegBrN6?=
 =?us-ascii?Q?pv3RaaRJLjnd/FOojZmDtantDMm9BcS7jvKR5lzK4n5lli5OIaNF0i45mId2?=
 =?us-ascii?Q?qzNviiwu8lLG7oXMaxS2Q7RdTOhhBuronrLWDWFdoab7NzM3RH0IVp8LURyu?=
 =?us-ascii?Q?wdJ+PR/BLUtWoh7ffrP/tMX8AfGI3Qu2NPmPFB1lkCLtL2q8oHl2hYzCCM3i?=
 =?us-ascii?Q?kYaLL1jh+dOGzoh45QvX5EuUASIDOnnBcKl+7+1k8MKmYrg06HEViVPrvaIm?=
 =?us-ascii?Q?7y6ocUcwXWfbFP1zJSNCjiauKjH+ZNu+0t/vAhp7j5tz02qKUsNTVJ+JddGi?=
 =?us-ascii?Q?uUN89TSmC32PnSCdhy99Zv4VTWXuV0BiD4TK1F98P3hTySUSoBRFS82MPRlO?=
 =?us-ascii?Q?LJaGP9QWXndUmGU5nikSAk1VlewAQSAj5ga38KpilUkXkGWlhocY+AqDfkCx?=
 =?us-ascii?Q?v8ZRWNY3ULTcBMWtimEZyHovC7uRrew5w2CX27jGVzhQmFkw5guZ9OFrq5Dg?=
 =?us-ascii?Q?Y6Cp4xvJTdBqNl3oDJpa/1LUFEdwG+1qbLmaJve4nHkdYor/YBR5u++kyYRa?=
 =?us-ascii?Q?oJkQgzGuM/WG0JLc5zrl+9si8K1DyXwTviawygWl//W8nxh7nXhMmSHC0Hnd?=
 =?us-ascii?Q?3m414eOMKVgnTIO95OLgN6XUtnEPQ2o0trEtKuOWLNJTDJEESkyeQ34DJRY+?=
 =?us-ascii?Q?dV1FUsMuA+H5z9zhX4NGMhk1yypmnKKkRnOIlUXeLm1Dah+mAdDL2EaGb8VE?=
 =?us-ascii?Q?D+VWok0Bi0s9ZyfYnIxL6lZKvycO3pUeZHiwzZ5flvEZz7z+JZ7c061PPPAX?=
 =?us-ascii?Q?s3ug2OPr9mCbz+O+/9dyAiJ0QEhJvQhq9p+xQ24k5Tf82SfvtZ6ko10CzC2M?=
 =?us-ascii?Q?VULy/U7CUjqWlmVs28k9dJuBBiXcZ4czz8pihJlqqzdln8G7vo5bJSKRf45A?=
 =?us-ascii?Q?+z4xTKGCsRr+m03w7ETi28jQs5Ck9QMldo8LlLElrPISRhPIt8ayhcazTRY9?=
 =?us-ascii?Q?7G0JZpbZLZ63E2Sj+2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd939c4-f5df-472e-2eb8-08dc751a9aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 20:07:10.3843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UNEXd3ceEAWRm9E4+64ftpEc3tFV30OzWAWF/YhHG0Ypf4iAqGsQASKy4+yoP7gURAdPZ1GMvLgodHekQ9KZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

[Public]

> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Wednesday, May 15, 2024 8:18 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH v3 1/4] drm/amdgpu: update the ip_dump to ipdump_core
>
> Update the memory pointer from ip_dump to ipdump_core to make it specific
> to core registers and rest other registers to be dumped in their respecti=
ve
> memories.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 109f471ff315..30d7f9c29478 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -435,7 +435,7 @@ struct amdgpu_gfx {
>       bool                            mcbp; /* mid command buffer
> preemption */
>
>       /* IP reg dump */
> -     uint32_t                        *ip_dump;
> +     uint32_t                        *ipdump_core;

I think this looks cleaner as ip_dump_core.

Alex

>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 953df202953a..f6d6a4b9802d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4603,9 +4603,9 @@ static void gfx_v10_0_alloc_dump_mem(struct
> amdgpu_device *adev)
>       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>       if (ptr =3D=3D NULL) {
>               DRM_ERROR("Failed to allocate memory for IP Dump\n");
> -             adev->gfx.ip_dump =3D NULL;
> +             adev->gfx.ipdump_core =3D NULL;
>       } else {
> -             adev->gfx.ip_dump =3D ptr;
> +             adev->gfx.ipdump_core =3D ptr;
>       }
>  }
>
> @@ -4815,7 +4815,7 @@ static int gfx_v10_0_sw_fini(void *handle)
>
>       gfx_v10_0_free_microcode(adev);
>
> -     kfree(adev->gfx.ip_dump);
> +     kfree(adev->gfx.ipdump_core);
>
>       return 0;
>  }
> @@ -9283,13 +9283,13 @@ static void gfx_v10_ip_print(void *handle, struct
> drm_printer *p)
>       uint32_t i;
>       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
>
> -     if (!adev->gfx.ip_dump)
> +     if (!adev->gfx.ipdump_core)
>               return;
>
>       for (i =3D 0; i < reg_count; i++)
>               drm_printf(p, "%-50s \t 0x%08x\n",
>                          gc_reg_list_10_1[i].reg_name,
> -                        adev->gfx.ip_dump[i]);
> +                        adev->gfx.ipdump_core[i]);
>  }
>
>  static void gfx_v10_ip_dump(void *handle) @@ -9298,12 +9298,12 @@
> static void gfx_v10_ip_dump(void *handle)
>       uint32_t i;
>       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
>
> -     if (!adev->gfx.ip_dump)
> +     if (!adev->gfx.ipdump_core)
>               return;
>
>       amdgpu_gfx_off_ctrl(adev, false);
>       for (i =3D 0; i < reg_count; i++)
> -             adev->gfx.ip_dump[i] =3D
> RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
> +             adev->gfx.ipdump_core[i] =3D
> +RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
> --
> 2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9081C4167D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6FA10E060;
	Fri, 10 Nov 2023 14:16:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07ED010E060
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEvoDPk7SlOmNr/xYxTPbqCAh+3bbZ3X/VMvPnzTfc9oFszxu985sFmZOnhEy3pR5hMS+eZXr/I6pldatX6Znqa4UTY/TwqJo2XNJOPpMRrxsI+hdhjtGmi2UtQiPoI0nHq55bYhClBdQObSOVTkLTr8qH68iNUQTEiOAowB2bowPkNAFhIA3aAQdkJoODoUAI6HlDS7ZmFzsVSkwdWg98mwdqESKpkDCixKi7C1/AEzA+DPeh8V6kSEc5ApdcOdVNs4IViP4EMVYvIDtumDWkm+WaQeJJ0zfj6IikMyWKQ1PIMo+w6ZiErD2biMHpJ3a9uJJMGCZod9Dspe6h6ZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3An6B0irCBA7pLdw4NqgVzaz04JPl2ZG4X21j4/j+Fs=;
 b=YYRRUMx0puTlVNw2KFdsmTvMotpWOHWwhcnFm5KRcI/WRJPnFWxC1YXBSgaNWe+Qp34ldlJ1/OdkGBNsaa19jXi7PEAz5ncUACgdI0K/3L1i4J/D+YXGsfOyHEnbb7ssrYaZvZEzhpk9d002ONvLh9DhIQdU4GB//TfC9SF2pWtCzWUUn5VPL5TfTtrvP162ER+s/bS0sYoHVzKGGKA034tZTQGnEf70Ux9XIg8oVu8aXRER6ff3qffQMzc/Dr3X81fVhoKqNq6XZldUuIwhYdZWI4L3nqlp2Dk+3/96ueLcOH1jF88U0rwrkcWNxq8gWFvyzEC00L1ABRkz5EhYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3An6B0irCBA7pLdw4NqgVzaz04JPl2ZG4X21j4/j+Fs=;
 b=LkdCboMHGvsuOlBpBpDPNmSRJm/jeVJGZGQetim+jKqRtQzQ4oSY275WbACuc4PbbeYWQEfyvgouK1K9gKV+GzGPjwRIMT/g99MsKaRSXunIsOBkUUxiPmTNVtwM14Rv5Q2p2d4IwwigQ9cfeYLWPGh1OF5gWOpu7o8t7xUoDsY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 14:16:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:16:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Thread-Topic: [PATCH] drm/amdgpu: exclude domain start when calucales offset
 for AGP aperture BOs
Thread-Index: AQHaE9TLrFjJ9KGg10mrXxsBtL81lbBzmKwAgAAAV/Q=
Date: Fri, 10 Nov 2023 14:16:20 +0000
Message-ID: <BL1PR12MB51448085CD4ECFAD5D00779DF7AEA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231110125225.2512174-1-yifan1.zhang@amd.com>
 <82453041-8033-4d14-be82-ecfe7fce9f27@amd.com>
In-Reply-To: <82453041-8033-4d14-be82-ecfe7fce9f27@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-11-10T14:16:19.338Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5119:EE_
x-ms-office365-filtering-correlation-id: 410ef536-06bc-4c43-f2bc-08dbe1f79c7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmYVMMYFMT0qcYYh0jMJplb5rvvUGni/Ulb4UJh/f9Y5V4k3TM1IxHVziEsqsosiDOacWMVAaNZ7F6MPhbHZL0iHY8R2fcSeNgg4LMaHqweNMhoUJMoDXOtbT1QNk6ozQF7coIsIviPYfofiv9G6rrUyvtnDvhG2+IZBiG0Coh9tucR1a9CNQsywKg8mxKvaLpjsmiaXLjzMauVFrQhp/R+saHoVZXm/eCDPheg333kejsg0Y9scB8DIdju0lomKCRuxQTaeRTDliKNPpDNHUF/BVjkMQVtZRxhtcu8ed3YML0Gm0Vjkb/GxH5e7194MaDdf6q6WgGdiFLPFsVnyqCit2ZGFiyOV11WyBfH3Q6orVK7gM8OteyAp7Ewnxq4apshVbNfYAjwUqwdaQ4U7HdSeHchbrK3SSwrydZypC4Vyjgpefo1qIyRnLak++xBZ2m4IFAWp8sp6oSEVXlVQYPUEt9ChYeXnqbTsy93+ZxGTgMMpNH7tvdPYtVjOoqI5Xj3ySluxfMKqJOGBah/lzthSkTwfz6Lu0eNrOzkclZy1W9s65WU7DXze5difiOlsMLJ5dm2wrI8jk9W7KyaNthWLrZEskiXPr21FOLlJMysiiUmKPiHf/m/0Vn/ZlXf1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(33656002)(55016003)(4326008)(8936002)(478600001)(83380400001)(52536014)(8676002)(66446008)(316002)(110136005)(66476007)(66556008)(76116006)(66946007)(91956017)(2906002)(5660300002)(64756008)(9686003)(41300700001)(19627405001)(6506007)(71200400001)(7696005)(53546011)(122000001)(26005)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0iOswc+59wJVS/aNzuKNJkRBAhfrJHUXN02Vk4PD5zsc8ooauHv1NW025yWQ?=
 =?us-ascii?Q?A8S+RFAqdQGvFQpj02i8hc7xKAMLcbTug3zrFvNIlceFtqSFu7TtWPPHJDQV?=
 =?us-ascii?Q?sYjLqsHJSIn4DdRm80aNGsgvfQAM2v/v3h8PrUAjH5PaCkjXFbOSXgvGBJyH?=
 =?us-ascii?Q?JIF5auhh/IHPX3hlsloe4H/u4N8ltlCia/9nrJo6mTpHmea7GEAgox5niAYW?=
 =?us-ascii?Q?pwb72Yk4ppyZqXxinCukNfWBoR2CT5tnDAwn0iNk5N3n9qusK4Z92dqqTfow?=
 =?us-ascii?Q?X82+Of2NLkwHUrBSywTCizIwPRKIklznvYY6MEv77K4taXYlB4dswGQckWdv?=
 =?us-ascii?Q?kwj/5EZDkelEVX2c8pnCszs6Wn8OBH5TmjMTS1PeQ65mOPIcJfW3oJfFD31+?=
 =?us-ascii?Q?yTY4tzuFWYaLw46N2txbKbNLPlxBmJYQk6AwrPoE9l+FSv9LyjtXInBcU2Mg?=
 =?us-ascii?Q?TWByMG85VUbywb8TejAYzgnHPLyaLqr3pNwEHmn6n2DGtyJStOI5NpbdtmGT?=
 =?us-ascii?Q?gs3pNSAuxodCfhVZRxShiLXCXiZ4Q50eH2zOMGJfwXUUyWSeNq5COi55JfMd?=
 =?us-ascii?Q?zlMi14IxOoYKDYs2atRlbmODpDy9bkaPARWH+7YQShZxO2oed/kh5ILTPcKk?=
 =?us-ascii?Q?AwxpEalqEqFduTyxWH8oO4BeJaBUfLIzEKyDuC8nglB1xpEYaZDfld6JNOqh?=
 =?us-ascii?Q?Krag7Dnb7WNQm+9zP9qZNpkBwA2aIbCMAZlxG5Jvk8tse8uemb+IWMwyOyc8?=
 =?us-ascii?Q?bouBBhyZPCK53sSgfCfcfVoNTpWRi0Jb2IlGih7i91bKOCzNWwYtdyeonBlI?=
 =?us-ascii?Q?82woufG0ryPfKYNlGqaG5VuaSnnFE2yVHXHvFu0aLgdDp8XFMj55zlptUJD3?=
 =?us-ascii?Q?yYjpS9vu90Oh8lgk2hfTcpbo/DVVOfXVS0ZpBwKzbGnZ+/Zt5msnPoKpRqin?=
 =?us-ascii?Q?ufs2Dco6DEvpa2Xe/SVrALd0+NWa356vjd9uVJ4m4GEyD3Ak1q1p+jfJSRuw?=
 =?us-ascii?Q?dN4tZEWi0MegSeWI9ZDgJlS/MgGkr4qaFTuHCUAS7+y0fODS12KijelChrFI?=
 =?us-ascii?Q?FP6KZLj/tQsb0TA8ESc4i+JV99wRHM3OdzxxuEGnQei6kYcldh/hMF2V/RNo?=
 =?us-ascii?Q?+vAgJQbk7aHGkHUZwrXEhDq381VKp7FzJOGAmHyofmQb3IKZMCimDA1VqKA3?=
 =?us-ascii?Q?q2+8H5i/wR5pgP6IxBipWzxWNb4eqZKCnCwHg8VyzJxcNZrarGx61MfreorX?=
 =?us-ascii?Q?TmXUjmfsTPjglMM/yfPFDptjZj1sYPn8t31kpjOPd5YTUAog3uSmm8b+ceZP?=
 =?us-ascii?Q?gPjjvryEqKqgGMn90JjJTVH4+Re26xJLNnU9k5o5Y2bW2UnSzvKil4G+0UJQ?=
 =?us-ascii?Q?Q20askKXea+xXS0dwNucgCOkE8Lnf7LDeVC7zZHFC23xffJ5e5XOfUCGcPv3?=
 =?us-ascii?Q?OmyKHVZ42yjPiBl6yyMpSif0aNw4ryTACXAqwpZCF/6WnsuV1gjfzDMpFJV9?=
 =?us-ascii?Q?SSAD3TnM1S72Aj4pSdZlFH3Fi0AeNoc9VwuhNHQeAbO6nnIkFj1GK1epKtfl?=
 =?us-ascii?Q?66KCZXET5n4GDLspU08=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448085CD4ECFAD5D00779DF7AEABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410ef536-06bc-4c43-f2bc-08dbe1f79c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 14:16:20.1087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmTmA/YODGAiJ1o+QLAdZFzZQ+GtNyH2Ux3H6saDSB0yh4gSFNFz+yWGcxgsjk52+ifCSDp6DuzZtj1LhcMcCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
Cc: "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51448085CD4ECFAD5D00779DF7AEABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

It happens in amdgpu_gmc_agp_addr() which is called from amdgpu_ttm_alloc_g=
art().

Alex
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, November 10, 2023 9:14 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd=
-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: exclude domain start when calucales offset=
 for AGP aperture BOs

Am 10.11.23 um 13:52 schrieb Yifan Zhang:
> For BOs in AGP aperture, tbo.resource->start includes AGP aperture start.


Well big NAK to that. tbo.resource->start should never ever include the
AGP aperture start in the first place.

How did that happen?

Regards,
Christian.

> Don't add it again in amdgpu_bo_gpu_offset. This issue was mitigated due =
to
> GART aperture start was 0 until this patch ("a013c94d5aca drm/amdgpu/gmc1=
1:
> set gart placement GC11") changes GART start to a non-zero value.
>
> Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--
>   3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 5f71414190e9..00e940eb69ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *ade=
v, void *cpu_pt_addr,
>        return 0;
>   }
>
> +bool bo_in_agp_aperture(struct amdgpu_bo *bo)
> +{
> +     struct ttm_buffer_object *tbo =3D &(bo->tbo);
> +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(tbo->bdev);
> +
> +     return (tbo->resource->start << PAGE_SHIFT) > adev->gmc.agp_start;
> +}
>   /**
>    * amdgpu_gmc_agp_addr - return the address in the AGP address space
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index e699d1ca8deb..448dc08e83de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev=
, void *cpu_pt_addr,
>                                uint64_t flags);
>   uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);
>   uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo);
> +bool bo_in_agp_aperture(struct amdgpu_bo *bo);
>   void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgp=
u_gmc *mc);
>   void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu=
_gmc *mc,
>                              u64 base);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index cef920a93924..91a011d63ab4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -39,6 +39,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_gmc.h"
>
>   /**
>    * DOC: amdgpu_object
> @@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo=
 *bo)
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>        uint64_t offset;
>
> -     offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> -              amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
> +     /* tbo.resource->start includes agp_start for AGP BOs */
> +     if (bo_in_agp_aperture(bo)) {
> +             offset =3D (bo->tbo.resource->start << PAGE_SHIFT);
> +     } else {
> +             offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> +                      amdgpu_ttm_domain_start(adev, bo->tbo.resource->me=
m_type);
> +     }
>
>        return amdgpu_gmc_sign_extend(offset);
>   }


--_000_BL1PR12MB51448085CD4ECFAD5D00779DF7AEABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
It happens in amdgpu_gmc_agp_addr() which is called from amdgpu_ttm_alloc_g=
art().</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Alex</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, November 10, 2023 9:14 AM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Jes=
se(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: exclude domain start when calucales=
 offset for AGP aperture BOs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 10.11.23 um 13:52 schrieb Yifan Zhang:<br>
&gt; For BOs in AGP aperture, tbo.resource-&gt;start includes AGP aperture =
start.<br>
<br>
<br>
Well big NAK to that. tbo.resource-&gt;start should never ever include the =
<br>
AGP aperture start in the first place.<br>
<br>
How did that happen?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; Don't add it again in amdgpu_bo_gpu_offset. This issue was mitigated d=
ue to<br>
&gt; GART aperture start was 0 until this patch (&quot;a013c94d5aca drm/amd=
gpu/gmc11:<br>
&gt; set gart placement GC11&quot;) changes GART start to a non-zero value.=
<br>
&gt;<br>
&gt; Reported-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; =
|&nbsp; 7 +++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; =
|&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 ++++++++--=
<br>
&gt;&nbsp;&nbsp; 3 files changed, 16 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index 5f71414190e9..00e940eb69ab 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -169,6 +169,13 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *=
adev, void *cpu_pt_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +bool bo_in_agp_aperture(struct amdgpu_bo *bo)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo =3D &amp;(bo-&=
gt;tbo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D amdgpu_ttm_ad=
ev(tbo-&gt;bdev);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (tbo-&gt;resource-&gt;start &lt;&lt; =
PAGE_SHIFT) &gt; adev-&gt;gmc.agp_start;<br>
&gt; +}<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_gmc_agp_addr - return the address in the AG=
P address space<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index e699d1ca8deb..448dc08e83de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -393,6 +393,7 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *a=
dev, void *cpu_pt_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags);<br>
&gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo);<br>
&gt;&nbsp;&nbsp; uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo)=
;<br>
&gt; +bool bo_in_agp_aperture(struct amdgpu_bo *bo);<br>
&gt;&nbsp;&nbsp; void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev,=
 struct amdgpu_gmc *mc);<br>
&gt;&nbsp;&nbsp; void amdgpu_gmc_vram_location(struct amdgpu_device *adev, =
struct amdgpu_gmc *mc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index cef920a93924..91a011d63ab4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -39,6 +39,7 @@<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt; +#include &quot;amdgpu_gmc.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * DOC: amdgpu_object<br>
&gt; @@ -1529,8 +1530,13 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu=
_bo *bo)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; offset =3D (bo-&gt;tbo.resource-&gt;start &l=
t;&lt; PAGE_SHIFT) +<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; amdgpu_ttm_domain_start(adev, bo-&gt;tbo.resource-&gt;mem_type);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* tbo.resource-&gt;start includes agp_start=
 for AGP BOs */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bo_in_agp_aperture(bo)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D (bo-&gt;tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D (bo-&gt;tbo.resource-&gt;start &lt;&lt; PAGE_SHIFT) +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_domain=
_start(adev, bo-&gt;tbo.resource-&gt;mem_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_gmc_sign_exten=
d(offset);<br>
&gt;&nbsp;&nbsp; }<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448085CD4ECFAD5D00779DF7AEABL1PR12MB5144namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B62DD1D483
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 18:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BA410E2F4;
	Thu,  8 Jan 2026 18:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yfyv7MsU";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEA910E2F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 18:15:37 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-122008e73c7so90551c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Jan 2026 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767896137; x=1768500937; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXJp3++1ic2yg5NbXlyVvuXw+RB2PS3wYctyZxBq0VE=;
 b=Yfyv7MsUpSD22KbpQZ4lcp4uh+vfpcOuBSsD0WYtYyHyvXePOy4XZJSkiy7jHt3HFH
 2FbzYu8SsutqlT5CEEJ6PW96xceEV7Q33BUUbzswUbJ7WQ1eaWn4m7o5I05WHyxPwWux
 LeRoUfRXdT7Qcs25FaVT10GcPgOedxFoKGh9MFmtNHQPUwDeJao68uGGTbgl8D1JQ4Kj
 DW72f10s5WyZJxb3YvzqmCcf3STyeTgm5GqjPqz0jmrJp0SL4Uv3WVUj9IhqxxXhZCCN
 kj59xyhlf6HczoYGBQ3IRfxjP7N1iJlJXkNlhDZwSMx9vll3jUjCYMcgzwKsqifQI4/E
 O3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767896137; x=1768500937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aXJp3++1ic2yg5NbXlyVvuXw+RB2PS3wYctyZxBq0VE=;
 b=ZgCU2XLQl76XlqDgB73rHG+BzHDadmK45PZpkM55N6JRZqGzjr2lkX4y/UsLXpla5j
 e6qtvjWlI83TBUF2eCEQah8QXP1SG7DjSF+20Cu4MGS3lq+2r8kgfOgO2gra4YXtDcD/
 a3fKV7++i8hYjZsCxV6xx5DmysVlW2zpZIrut9zln09TtDCVYu52d/iSbGcgP+TTmlvI
 q6zWGw0ixaNUEaxJO43vXhvV+LX0RPowH70heqDRTi5NIn3VilxPlp6t3v6z47AOiztf
 FCcqubGBfx6j/rJNKGlRh3k6+rgs++TCPMCPR6QH6Ah6Wgbz0YjpwkLszyoC6ldCR2ZW
 nhvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqu63e/uAfWEYwcjjvWqG11aU8B8xs+rZZEbyjFbQsvkjAuRBGi4v3ZJJsvtoXRAaCCbIXOiL7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBr6oUULH0deWFeCefcpzoANquIezexEzCm3AixHYMIRTmUCrN
 U67a6VePdyg7ZsdOAGF1v7rEEDvOIWJ0oPl5/2ASsPgb1nOwSJro9wOM4hGrMluAUNIm0dnSIhu
 f5l1XKGsr3016txE9An8v6IfI1GZerdA=
X-Gm-Gg: AY/fxX4qLwcLdQ45qEpz8leQMi8A29/g6m7hToQ22yNdcusnR/vX3ijjQjinLLrMja6
 yapFXGo8ci/0fGYy6NJK27oesXww23a90w/RCl3m3pf7RulynYgpEG7uggGmdlMrZwf5iQ5c+pl
 +1vDTVa9XT9n4+p3AHBrEWyZgGhj8AnpKJyc1HmT9IpohTwJjepm0h85xQIm/gWZ1E9HSanOUva
 ZUt0E5RI6bqrG9/dkM+Y3qKin6mBETYVNjnypNW+lRmaMAMCRVxLCVYTzJSAKOPOmmGrxgy
X-Google-Smtp-Source: AGHT+IFt9fmeaEW3jMz5eNrPtf37Z3hrkZFMXbfbGBrlAsH84j3Rnu4L7tS2FUmI01/Ev8a+qHLnob6KWm7CptpqgtY=
X-Received: by 2002:a05:7022:b9b:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-121f8af3392mr3449899c88.2.1767896136783; Thu, 08 Jan 2026
 10:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20251223141427.36850-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251223141427.36850-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Jan 2026 13:15:25 -0500
X-Gm-Features: AQt7F2rQyadOA2CU8QraM9yL_dbiF1PNhqBZ1PmnhOyx13nlCpb0O28i4dTw_Gs
Message-ID: <CADnq5_P4=8KkmmsCBoY1dZwOuGKuUN7UM4GN87o0ooKMWvQrHg@mail.gmail.com>
Subject: Re: [v3,
 1/2] drm/amdgpu: Drop MMIO_REMAP domain bit and keep it Internal
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 David Wu <David.Wu3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jan 8, 2026 at 12:32=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>
> "AMDGPU_GEM_DOMAIN_MMIO_REMAP" - Never activated as UAPI and it turned
> out that this was to inflexible.
>
> Allocate the MMIO_REMAP buffer object as a regular GEM BO and explicitly
> move it into the fixed AMDGPU_PL_MMIO_REMAP placement at the TTM level.
>
> This avoids relying on GEM domain bits for MMIO_REMAP, keeps the
> placement purely internal, and makes the lifetime and pinning of the
> global MMIO_REMAP BO explicit. The BO is pinned in TTM so it cannot be
> migrated or evicted.
>
> The corresponding free path relies on normal DRM teardown ordering,
> where no further user ioctls can access the global BO once TTM teardown
> begins.
>
> v2 (Srini):
> - Updated patch title.
> - Drop use of AMDGPU_GEM_DOMAIN_MMIO_REMAP in amdgpu_ttm.c. The
>   MMIO_REMAP domain bit is removed from UAPI, so keep the MMIO_REMAP BO
>   allocation domain-less (bp.domain =3D 0) and rely on the TTM placement
>   (AMDGPU_PL_MMIO_REMAP) for backing/pinning.
> - Keep fdinfo/mem-stats visibility for MMIO_REMAP by classifying BOs
>   based on bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP, since =
the
>   domain bit is removed.
>
> v3: Squash patches #1 & #3
>
> Fixes: dd2bf86d1383 ("drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_R=
EMAP")
> Fixes: 2f711aebfa64 ("drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singlet=
on")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Leo Liu <leo.liu@amd.com>
> Cc: Ruijing Dong <ruijing.dong@amd.com>
> Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 21 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 77 ++++++++++++++--------
>  include/uapi/drm/amdgpu_drm.h              |  6 +-
>  5 files changed, 60 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 9b81a6677f90..b46b61297f68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -458,9 +458,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, v=
oid *data,
>         /* always clear VRAM */
>         flags |=3D AMDGPU_GEM_CREATE_VRAM_CLEARED;
>
> -       if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
> -               return -EINVAL;
> -
>         /* create a gem object to contain this object in */
>         if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>             AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index b676310ce9ac..1fb956400696 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -153,14 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_b=
o *abo, u32 domain)
>                 c++;
>         }
>
> -       if (domain & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> -               places[c].fpfn =3D 0;
> -               places[c].lpfn =3D 0;
> -               places[c].mem_type =3D AMDGPU_PL_MMIO_REMAP;
> -               places[c].flags =3D 0;
> -               c++;
> -       }
> -
>         if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>                 places[c].fpfn =3D 0;
>                 places[c].lpfn =3D 0;
> @@ -1546,8 +1538,17 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo=
 *bo)
>   */
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
>  {
> -       uint32_t domain =3D bo->preferred_domains & AMDGPU_GEM_DOMAIN_MAS=
K;
> +       u32 domain;
>
> +       /*
> +        * MMIO_REMAP is internal now, so it no longer maps from a usersp=
ace
> +        * domain bit. Keep fdinfo/mem-stats visibility by checking the a=
ctual
> +        * TTM placement.
> +        */
> +       if (bo->tbo.resource && bo->tbo.resource->mem_type =3D=3D AMDGPU_=
PL_MMIO_REMAP)
> +               return AMDGPU_PL_MMIO_REMAP;
> +
> +       domain =3D bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK;
>         if (!domain)
>                 return TTM_PL_SYSTEM;
>
> @@ -1566,8 +1567,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgp=
u_bo *bo)
>                 return AMDGPU_PL_OA;
>         case AMDGPU_GEM_DOMAIN_DOORBELL:
>                 return AMDGPU_PL_DOORBELL;
> -       case AMDGPU_GEM_DOMAIN_MMIO_REMAP:
> -               return AMDGPU_PL_MMIO_REMAP;
>         default:
>                 return TTM_PL_SYSTEM;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index 52c2d1731aab..912c9afaf9e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -168,8 +168,6 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 =
mem_type)
>                 return AMDGPU_GEM_DOMAIN_OA;
>         case AMDGPU_PL_DOORBELL:
>                 return AMDGPU_GEM_DOMAIN_DOORBELL;
> -       case AMDGPU_PL_MMIO_REMAP:
> -               return AMDGPU_GEM_DOMAIN_MMIO_REMAP;
>         default:
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index f27ffe64aafa..6d7a5bf2d0c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1909,42 +1909,45 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_d=
evice *adev)
>  }
>
>  /**
> - * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP =
BO
> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton MMIO_REMAP BO
>   * @adev: amdgpu device
>   *
> - * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when=
 the
> + * Allocates a global BO with backing AMDGPU_PL_MMIO_REMAP when the
>   * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the ho=
st
>   * PAGE_SIZE is <=3D AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a r=
egular
>   * GEM object (amdgpu_bo_create).
>   *
> - * The BO is created as a normal GEM object via amdgpu_bo_create(), then
> - * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never b=
e
> - * migrated or evicted. No CPU mapping is established here.
> - *
>   * Return:
>   *  * 0 on success or intentional skip (feature not present/unsupported)
>   *  * negative errno on allocation failure
>   */
> -static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
> +static int amdgpu_ttm_alloc_mmio_remap_bo(struct amdgpu_device *adev)
>  {
> +       struct ttm_operation_ctx ctx =3D { false, false };
> +       struct ttm_placement placement;
> +       struct ttm_buffer_object *tbo;
> +       struct ttm_place placements;
>         struct amdgpu_bo_param bp;
> +       struct ttm_resource *tmp;
>         int r;
>
>         /* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_=
PAGE_SIZE (4K). */
>         if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SI=
ZE)
>                 return 0;
>
> +       /*
> +        * Allocate a BO first and then move it to AMDGPU_PL_MMIO_REMAP.
> +        * The initial TTM resource assigned by amdgpu_bo_create() is
> +        * replaced below with a fixed MMIO_REMAP placement.
> +        */
>         memset(&bp, 0, sizeof(bp));
> -
> -       /* Create exactly one GEM BO in the MMIO_REMAP domain. */
> -       bp.type        =3D ttm_bo_type_device;          /* userspace-mapp=
able GEM */
> -       bp.size        =3D AMDGPU_GPU_PAGE_SIZE;        /* 4K */
> +       bp.type        =3D ttm_bo_type_device;
> +       bp.size        =3D AMDGPU_GPU_PAGE_SIZE;
>         bp.byte_align  =3D AMDGPU_GPU_PAGE_SIZE;
> -       bp.domain      =3D AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> +       bp.domain      =3D 0;
>         bp.flags       =3D 0;
>         bp.resv        =3D NULL;
>         bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
> -
>         r =3D amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
>         if (r)
>                 return r;
> @@ -1953,42 +1956,60 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct a=
mdgpu_device *adev)
>         if (r)
>                 goto err_unref;
>
> +       tbo =3D &adev->rmmio_remap.bo->tbo;
> +
>         /*
>          * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
> -        * Use TTM-level pin so the BO cannot be evicted/migrated,
> -        * independent of GEM domains. This
> -        * enforces the =E2=80=9Cfixed I/O window=E2=80=9D
>          */
> -       ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
> +       placement.num_placement =3D 1;
> +       placement.placement =3D &placements;
> +       placements.fpfn =3D 0;
> +       placements.lpfn =3D 0;
> +       placements.mem_type =3D AMDGPU_PL_MMIO_REMAP;
> +       placements.flags =3D 0;
> +       /* Force the BO into the fixed MMIO_REMAP placement */
> +       r =3D ttm_bo_mem_space(tbo, &placement, &tmp, &ctx);
> +       if (unlikely(r))
> +               goto err_unlock;
> +
> +       ttm_resource_free(tbo, &tbo->resource);
> +       ttm_bo_assign_mem(tbo, tmp);
> +       ttm_bo_pin(tbo);
>
>         amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>         return 0;
>
> +err_unlock:
> +       amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> +
>  err_unref:
> -       if (adev->rmmio_remap.bo)
> -               amdgpu_bo_unref(&adev->rmmio_remap.bo);
> +       amdgpu_bo_unref(&adev->rmmio_remap.bo);
>         adev->rmmio_remap.bo =3D NULL;
>         return r;
>  }
>
>  /**
> - * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
> + * amdgpu_ttm_free_mmio_remap_bo - Free the singleton MMIO_REMAP BO
>   * @adev: amdgpu device
>   *
>   * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
>   * amdgpu_ttm_mmio_remap_bo_init().
>   */
> -static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +static void amdgpu_ttm_free_mmio_remap_bo(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_bo *bo =3D adev->rmmio_remap.bo;
> -
> -       if (!bo)
> -               return;   /* <-- safest early exit */
> +       if (!adev->rmmio_remap.bo)
> +               return;
>
>         if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
>                 ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
>                 amdgpu_bo_unreserve(adev->rmmio_remap.bo);
>         }
> +
> +    /*
> +     * At this point we rely on normal DRM teardown ordering:
> +     * no new user ioctls can access the global MMIO_REMAP BO
> +     * once TTM teardown begins.
> +     */
>         amdgpu_bo_unref(&adev->rmmio_remap.bo);
>         adev->rmmio_remap.bo =3D NULL;
>  }
> @@ -2169,8 +2190,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>         }
>
> -       /* Allocate the singleton MMIO_REMAP BO (4K) if supported */
> -       r =3D amdgpu_ttm_mmio_remap_bo_init(adev);
> +       /* Allocate the singleton MMIO_REMAP BO if supported */
> +       r =3D amdgpu_ttm_alloc_mmio_remap_bo(adev);
>         if (r)
>                 return r;
>
> @@ -2238,7 +2259,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>                                         &adev->mman.sdma_access_ptr);
>
> -       amdgpu_ttm_mmio_remap_bo_fini(adev);
> +       amdgpu_ttm_free_mmio_remap_bo(adev);
>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>         amdgpu_ttm_drv_reserve_vram_fini(adev);
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 9680548ee41b..ab2bf47553e1 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -105,8 +105,6 @@ extern "C" {
>   *
>   * %AMDGPU_GEM_DOMAIN_DOORBELL Doorbell. It is an MMIO region for
>   * signalling user mode queues.
> - *
> - * %AMDGPU_GEM_DOMAIN_MMIO_REMAP       MMIO remap page (special mapping =
for HDP flushing).
>   */
>  #define AMDGPU_GEM_DOMAIN_CPU          0x1
>  #define AMDGPU_GEM_DOMAIN_GTT          0x2
> @@ -115,15 +113,13 @@ extern "C" {
>  #define AMDGPU_GEM_DOMAIN_GWS          0x10
>  #define AMDGPU_GEM_DOMAIN_OA           0x20
>  #define AMDGPU_GEM_DOMAIN_DOORBELL     0x40
> -#define AMDGPU_GEM_DOMAIN_MMIO_REMAP   0x80
>  #define AMDGPU_GEM_DOMAIN_MASK         (AMDGPU_GEM_DOMAIN_CPU | \
>                                          AMDGPU_GEM_DOMAIN_GTT | \
>                                          AMDGPU_GEM_DOMAIN_VRAM | \
>                                          AMDGPU_GEM_DOMAIN_GDS | \
>                                          AMDGPU_GEM_DOMAIN_GWS | \
>                                          AMDGPU_GEM_DOMAIN_OA | \
> -                                        AMDGPU_GEM_DOMAIN_DOORBELL | \
> -                                        AMDGPU_GEM_DOMAIN_MMIO_REMAP)
> +                                        AMDGPU_GEM_DOMAIN_DOORBELL)
>
>  /* Flag that CPU access will be required for the case of VRAM domain */
>  #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED  (1 << 0)

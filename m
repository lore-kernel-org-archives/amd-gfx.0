Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39B7CD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 18:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA641127C7;
	Mon,  8 Apr 2024 18:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UXn5DJkt";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09EF1127C7
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 18:20:57 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2a2d248a2e1so3057741a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Apr 2024 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712600457; x=1713205257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uX7sG8JWG6dFbv/M6R9CJkVPTQJ1s4LFxw13x/J0CQ0=;
 b=UXn5DJktfjcTh1NDzfMC0fN25U040LzHUo+G3lHt+E9TSmwEgLiDsHvZZVg098Kx5A
 b1lV4586dWuL3GXAGtPFSvDf5d8m4WT3SoZileM5TDSv1ZBYDXCQTtRDDi0ZftKZtFFp
 sk5w0+wzSGHsYePejKAjVNX3Xpo75PtLywzxO/VdZQAi5hqEEmN3Lu7dPn3D6I7XpGzr
 Sj3F/wFBNCLeU10rMKd2CqRoqYbybyrY4ZNQgOdg4k0P6Qn7eOpT5xKZ9F5gVdIAvqk7
 /MhYwIgdPNygDWjLn7x4oEQIglMyz3d3WOkoW55gNyMgn2Agw1A1MJfCpj1M+wwvgMKI
 feQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712600457; x=1713205257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uX7sG8JWG6dFbv/M6R9CJkVPTQJ1s4LFxw13x/J0CQ0=;
 b=wY9j45Ul1TkAZ7snd994MerzjG9uymoGiMdDhxwojzkBAz+QzrdH3/8dK4D/mYxmXy
 eMOfxryH4Tx2jr2WW/GqTz9kTjj9Z1DyJ0k7CP6K+g0xHcGLsSNxc/L5gf0Ld8uApGj/
 39UXEfbHwk5BBsRmpjt4PvBAbKT9ePyvY6pbvL6chcranw7UnnjH5o6LCUEl/skIXWxX
 ed5EXpHWFwMdjO1S9qDu5zC/z1p6yI92MIgIwJEiKS1rUZRIbPHIQt4TpFPqzaU4yfs1
 bHInCZ3b0ODwsOkvVbh1K+9EwG+wG/rIV5vb6kYabWDX8Ub4Q9zu8VxOvXBYJ++sR0Ov
 oekw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHYvfK9vl6O4plTbpG/BfgIElqzSzJFTGGpbY/81NBFysyZHPvzphJhmPnGMYcKrQQ60Tf9LvTA1TtesxQrkmm73T36DVSTUtELqCYRw==
X-Gm-Message-State: AOJu0Ywy7P1j3qIlAx0sPlR1n03ebFvZNN/NnEak6/fwle+3utvW9eH8
 asMn4HnoKugWeZYZ+ty4oeWhvH4M4rSp3hfwPp6DKFcGGk+2lx2WvrYIwB3gK0DPkNbOGgLLrXb
 VtJpIdNlx6j1s53919LXF/g35Fs8=
X-Google-Smtp-Source: AGHT+IFhE1gheJLOzDV+51urrL93ze9VwN3DQuPhahlBS6f+jB7m4+exSDFTnYXuSnL2JlmB9Bbu+D0cZd73SF6dG3I=
X-Received: by 2002:a17:90a:db02:b0:2a2:6244:32b5 with SMTP id
 g2-20020a17090adb0200b002a2624432b5mr644686pjv.11.1712600455662; Mon, 08 Apr
 2024 11:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240405075027.2252-1-christian.koenig@amd.com>
In-Reply-To: <20240405075027.2252-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Apr 2024 14:20:44 -0400
Message-ID: <CADnq5_MQ+HQmEJ6EXO0d2wh=WKNPSsZB1F2D9ecFwaRD_v6maw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix visible VRAM handling during faults
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Amaranath.Somalapuram@amd.com, xenia.ragiadakou@amd.com, 
 pierre-eric.pelloux-prayer@amd.com, amd-gfx@lists.freedesktop.org
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

On Fri, Apr 5, 2024 at 3:57=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> When we removed the hacky start code check we actually didn't took into
> account that *all* VRAM pages needs to be CPU accessible.
>
> Clean up the code and unify the handling into a single helper which
> checks if the whole resource is CPU accessible.
>
> The only place where a partial check would make sense is during
> eviction, but that is neglitible.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: aed01a68047b ("drm/amdgpu: Remove TTM resource->start visible VRAM=
 condition v2")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 22 --------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 61 ++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 ++
>  5 files changed, 53 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index bbbd8ad0171f..e9168677ef0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -819,7 +819,7 @@ static int amdgpu_cs_bo_validate(void *param, struct =
amdgpu_bo *bo)
>
>         p->bytes_moved +=3D ctx.bytes_moved;
>         if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
> -           amdgpu_bo_in_cpu_visible_vram(bo))
> +           amdgpu_res_cpu_visible(adev, bo->tbo.resource))
>                 p->bytes_moved_vis +=3D ctx.bytes_moved;
>
>         if (unlikely(r =3D=3D -ENOMEM) && domain !=3D bo->allowed_domains=
) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index eb7d824763b9..eff3f9fceada 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -620,8 +620,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>                 return r;
>
>         if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
> -           bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM &&
> -           amdgpu_bo_in_cpu_visible_vram(bo))
> +           amdgpu_res_cpu_visible(adev, bo->tbo.resource))
>                 amdgpu_cs_report_moved_bytes(adev, ctx.bytes_moved,
>                                              ctx.bytes_moved);
>         else
> @@ -1276,18 +1275,20 @@ void amdgpu_bo_move_notify(struct ttm_buffer_obje=
ct *bo,
>  void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>                           struct amdgpu_mem_stats *stats)
>  {
> +       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> +       struct ttm_resource *res =3D bo->tbo.resource;
>         uint64_t size =3D amdgpu_bo_size(bo);
>         unsigned int domain;
>
>         /* Abort if the BO doesn't currently have a backing store */
> -       if (!bo->tbo.resource)
> +       if (!res)
>                 return;
>
> -       domain =3D amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> +       domain =3D amdgpu_mem_type_to_domain(res->mem_type);
>         switch (domain) {
>         case AMDGPU_GEM_DOMAIN_VRAM:
>                 stats->vram +=3D size;
> -               if (amdgpu_bo_in_cpu_visible_vram(bo))
> +               if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
>                         stats->visible_vram +=3D size;
>                 break;
>         case AMDGPU_GEM_DOMAIN_GTT:
> @@ -1382,10 +1383,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct t=
tm_buffer_object *bo)
>         /* Remember that this BO was accessed by the CPU */
>         abo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>
> -       if (bo->resource->mem_type !=3D TTM_PL_VRAM)
> -               return 0;
> -
> -       if (amdgpu_bo_in_cpu_visible_vram(abo))
> +       if (amdgpu_res_cpu_visible(adev, bo->resource))
>                 return 0;
>
>         /* Can't move a pinned BO to visible VRAM */
> @@ -1409,7 +1407,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct tt=
m_buffer_object *bo)
>
>         /* this should never happen */
>         if (bo->resource->mem_type =3D=3D TTM_PL_VRAM &&
> -           !amdgpu_bo_in_cpu_visible_vram(abo))
> +           !amdgpu_res_cpu_visible(adev, bo->resource))
>                 return VM_FAULT_SIGBUS;
>
>         ttm_bo_move_to_lru_tail_unlocked(bo);
> @@ -1573,6 +1571,7 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdg=
pu_device *adev,
>   */
>  u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *=
m)
>  {
> +       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>         struct dma_buf_attachment *attachment;
>         struct dma_buf *dma_buf;
>         const char *placement;
> @@ -1581,10 +1580,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo=
 *bo, struct seq_file *m)
>
>         if (dma_resv_trylock(bo->tbo.base.resv)) {
>                 unsigned int domain;
> +
>                 domain =3D amdgpu_mem_type_to_domain(bo->tbo.resource->me=
m_type);
>                 switch (domain) {
>                 case AMDGPU_GEM_DOMAIN_VRAM:
> -                       if (amdgpu_bo_in_cpu_visible_vram(bo))
> +                       if (amdgpu_res_cpu_visible(adev, bo->tbo.resource=
))
>                                 placement =3D "VRAM VISIBLE";
>                         else
>                                 placement =3D "VRAM";
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index d28e21baef16..f8982404da93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -244,28 +244,6 @@ static inline u64 amdgpu_bo_mmap_offset(struct amdgp=
u_bo *bo)
>         return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
>  }
>
> -/**
> - * amdgpu_bo_in_cpu_visible_vram - check if BO is (partly) in visible VR=
AM
> - */
> -static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
> -{
> -       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> -       struct amdgpu_res_cursor cursor;
> -
> -       if (!bo->tbo.resource || bo->tbo.resource->mem_type !=3D TTM_PL_V=
RAM)
> -               return false;
> -
> -       amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor=
);
> -       while (cursor.remaining) {
> -               if (cursor.start < adev->gmc.visible_vram_size)
> -                       return true;
> -
> -               amdgpu_res_next(&cursor, cursor.size);
> -       }
> -
> -       return false;
> -}
> -
>  /**
>   * amdgpu_bo_explicit_sync - return whether the bo is explicitly synced
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 460b23918bfc..6f0cfe66613e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -137,7 +137,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_obje=
ct *bo,
>                         amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_D=
OMAIN_CPU);
>                 } else if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
>                            !(abo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_RE=
QUIRED) &&
> -                          amdgpu_bo_in_cpu_visible_vram(abo)) {
> +                          amdgpu_res_cpu_visible(adev, bo->resource)) {
>
>                         /* Try evicting to the CPU inaccessible part of V=
RAM
>                          * first, but only set GTT as busy placement, so =
this
> @@ -408,40 +408,55 @@ static int amdgpu_move_blit(struct ttm_buffer_objec=
t *bo,
>         return r;
>  }
>
> -/*
> - * amdgpu_mem_visible - Check that memory can be accessed by ttm_bo_move=
_memcpy
> +/**
> + * amdgpu_res_cpu_visible - Check that resource can be accessed by CPU
> + * @adev: amdgpu device
> + * @res: the resource to check
>   *
> - * Called by amdgpu_bo_move()
> + * Returns: true if the full resource is CPU visible, false otherwise.
>   */
> -static bool amdgpu_mem_visible(struct amdgpu_device *adev,
> -                              struct ttm_resource *mem)
> +bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
> +                           struct ttm_resource *res)
>  {
> -       u64 mem_size =3D (u64)mem->size;
>         struct amdgpu_res_cursor cursor;
> -       u64 end;
>
> -       if (mem->mem_type =3D=3D TTM_PL_SYSTEM ||
> -           mem->mem_type =3D=3D TTM_PL_TT)
> +       if (!res)
> +               return false;
> +
> +       if (res->mem_type =3D=3D TTM_PL_SYSTEM || res->mem_type =3D=3D TT=
M_PL_TT ||
> +           res->mem_type =3D=3D AMDGPU_PL_PREEMPT)
>                 return true;
> -       if (mem->mem_type !=3D TTM_PL_VRAM)
> +
> +       if (res->mem_type !=3D TTM_PL_VRAM)
>                 return false;
>
> -       amdgpu_res_first(mem, 0, mem_size, &cursor);
> -       end =3D cursor.start + cursor.size;
> +       amdgpu_res_first(res, 0, res->size, &cursor);
>         while (cursor.remaining) {
> +               if ((cursor.start + cursor.size) >=3D adev->gmc.visible_v=
ram_size)
> +                       return false;
>                 amdgpu_res_next(&cursor, cursor.size);
> +       }
>
> -               if (!cursor.remaining)
> -                       break;
> +       return true;
> +}
>
> -               /* ttm_resource_ioremap only supports contiguous memory *=
/
> -               if (end !=3D cursor.start)
> -                       return false;
> +/*
> + * amdgpu_res_copyable - Check that memory can be accessed by ttm_bo_mov=
e_memcpy
> + *
> + * Called by amdgpu_bo_move()
> + */
> +static bool amdgpu_res_copyable(struct amdgpu_device *adev,
> +                               struct ttm_resource *mem)
> +{
> +       if (!amdgpu_res_cpu_visible(adev, mem))
> +               return false;
>
> -               end =3D cursor.start + cursor.size;
> -       }
> +       /* ttm_resource_ioremap only supports contiguous memory */
> +       if (mem->mem_type =3D=3D TTM_PL_VRAM &&
> +           !(mem->placement & TTM_PL_FLAG_CONTIGUOUS))
> +               return false;
>
> -       return end <=3D adev->gmc.visible_vram_size;
> +       return true;
>  }
>
>  /*
> @@ -539,8 +554,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *b=
o, bool evict,
>
>         if (r) {
>                 /* Check that all memory is CPU accessible */
> -               if (!amdgpu_mem_visible(adev, old_mem) ||
> -                   !amdgpu_mem_visible(adev, new_mem)) {
> +               if (!amdgpu_res_copyable(adev, old_mem) ||
> +                   !amdgpu_res_copyable(adev, new_mem)) {
>                         pr_err("Move buffer fallback to memcpy unavailabl=
e\n");
>                         return r;
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index 65ec82141a8e..32cf6b6f6efd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -139,6 +139,9 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_=
mgr *mgr,
>  int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
>                                       uint64_t start);
>
> +bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
> +                           struct ttm_resource *res);
> +
>  int amdgpu_ttm_init(struct amdgpu_device *adev);
>  void amdgpu_ttm_fini(struct amdgpu_device *adev);
>  void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
> --
> 2.34.1
>

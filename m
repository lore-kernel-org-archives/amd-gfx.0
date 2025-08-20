Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B6CCA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A94C10E280;
	Wed, 20 Aug 2025 21:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BqsN4flE";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A374C10E280
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:14:17 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2447d607b70so409545ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724457; x=1756329257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98itrXBLDvyNUudHXBYTh0gJsS5TnA9NMU/84bOec8Y=;
 b=BqsN4flEoXAVNMsROnCVBaJZiHTeQBcx7bcXf2jSgZSHlke2gVQ/IortMY8TJS+8rD
 kvXJ/SYaiCoMgqYpOPevbKz8ROLJOri4/4208tDP5YXsjhpI9nEnxgD+WFS26gBlBKqw
 k/f7vRgaIls8X/cOt5jSAam5tCVILiUxPGXCsC7/RKyDp8f1fzslK3uYfnr8xFOs5n1P
 IRxb1L1zQOEW+65nhfqC4IzaB2uOXaICI03ELaKVtejBx9JVwn/K5dyJ5PJ2w1yMAkT4
 xDqdGZiDz7WmPX7heuoXdzyRfmNfUrshSRt/5tDmQF8d4e/bbl4L/gr7c9iHAAnKmEG1
 CmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724457; x=1756329257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98itrXBLDvyNUudHXBYTh0gJsS5TnA9NMU/84bOec8Y=;
 b=SLg8OIo5X37eox4y8Kw+UtbxixVxBJdd0uPP6n5ElkhSc9LmtOtIFaSN2oltzeBGZK
 Y/cQIm6JjEVrEn+23F5gnfTj3fVIL23vs6+rStymeeEyysir6v6Uh4TxMH5O1oo4Vrmt
 B/EyT2mfoJ4yVE9loL7dZHV/GB86FD7WP7MaY3DLRoZPCAzBjxHGYtPY/yY1sPiCXVYg
 4pGiMIgYuS0QglfkwncBJoTJe6d8Rr1NFGKVFHK64gDl717Yp44aYnsWSZ8mXueJZI6P
 mh6BuXUatihm/FYinFRhjLWXVMy8IyUPRCX5oFl4afSis1krFngSHHZM2mNe5oLWEMtu
 nOkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoZ1baNW1aAuVJ5kGLLuqq+Ggwk07YAVcibRdO8Frrnm2OetW8yyMP5str2HBOHgSVf+nCTJ45@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo7Ys+8XlbsZoyc+4zWWYm15QWP24WZs5SQbhYtW1nB0MxTJ+C
 C/BWj5OASguVB11nFjuiiKsVKMGFCuWOjuMbwQzQqrSCgRHJqJiBbGS349sajJhQ253v3lXJSGS
 CvUEhHB75CSsPNYcbyqZjMpkA/GDTCT4=
X-Gm-Gg: ASbGncut3431EHSNJbe8L/7fU1IKpuUhcAwHmjWY9q8gumOAsyh+LYDjTizywo2orlA
 4ysHyRT8AfgwZW2SnE05mlKJzROpSibyTTKWjcVina/quC2GPvVUWgMFOsr7ggc0bknX3H1UwH9
 aSCag/e9GMlHdqkoBmQmnc9m4p9HUldNIZ7Bm2r8ahn5VNwOjHe0DRYgtWckVz5l9yHGUwhEiV3
 GI3gx6Z/TGC+01TfQ==
X-Google-Smtp-Source: AGHT+IGgcEyRV0NF44jJSlzP9DOnzEge9h/wfRuB3BiU6KqeC92lpxppc0XDRvRHCCBkXOSNQ/meZLIZzFeC9KsZDE8=
X-Received: by 2002:a17:902:d4cf:b0:245:f771:4241 with SMTP id
 d9443c01a7336-245fed79772mr1443465ad.7.1755724456818; Wed, 20 Aug 2025
 14:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-6-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250820113254.3864753-6-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 17:14:05 -0400
X-Gm-Features: Ac12FXyrZVOz-hOA5zrmkXjC1zXDs69OonPuQKMVXcCGW-9vOLKBE1ES4r7pIgQ
Message-ID: <CADnq5_PkAew8exrxRO92X=PamCJqwBYMqaSbHueTB1c6oL-UMQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Aug 20, 2025 at 8:28=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves
> as a CPU-visible IO page:
>
> * amdgpu_evict_flags(): mark as unmovable
> * amdgpu_res_cpu_visible(): consider CPU-visible
> * amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
> * amdgpu_ttm_io_mem_reserve(): program bus.offset/is_iomem/caching using
>   the device's mmio_remap_* metadata
> * amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
> * amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 +++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 27ab4e754b2a..157a5416a826 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -123,6 +123,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_obje=
ct *bo,
>         case AMDGPU_PL_GWS:
>         case AMDGPU_PL_OA:
>         case AMDGPU_PL_DOORBELL:
> +       case AMDGPU_PL_MMIO_REMAP:
>                 placement->num_placement =3D 0;
>                 return;
>
> @@ -447,7 +448,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *ade=
v,
>                 return false;
>
>         if (res->mem_type =3D=3D TTM_PL_SYSTEM || res->mem_type =3D=3D TT=
M_PL_TT ||
> -           res->mem_type =3D=3D AMDGPU_PL_PREEMPT || res->mem_type =3D=
=3D AMDGPU_PL_DOORBELL)
> +           res->mem_type =3D=3D AMDGPU_PL_PREEMPT || res->mem_type =3D=
=3D AMDGPU_PL_DOORBELL ||
> +               res->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP)
>                 return true;
>
>         if (res->mem_type !=3D TTM_PL_VRAM)
> @@ -538,10 +540,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object =
*bo, bool evict,
>             old_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
>             old_mem->mem_type =3D=3D AMDGPU_PL_OA ||
>             old_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> +           old_mem->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP ||
>             new_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
>             new_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
>             new_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> -           new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
> +           new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> +           new_mem->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP) {
>                 /* Nothing to save here */
>                 amdgpu_bo_move_notify(bo, evict, new_mem);
>                 ttm_bo_move_null(bo, new_mem);
> @@ -629,6 +633,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_devi=
ce *bdev,
>                 mem->bus.is_iomem =3D true;
>                 mem->bus.caching =3D ttm_uncached;
>                 break;
> +       case AMDGPU_PL_MMIO_REMAP:  /* <=3D=3D=3D New HDP domain for rema=
p page */

This comment can be dropped.  It's just a remapping range.  We've only
used it for the HDP registers, but it could be used for other things
in the future.

> +               mem->bus.offset  =3D ((resource_size_t)mem->start << PAGE=
_SHIFT);
> +               mem->bus.offset +=3D adev->mmio_remap_base + adev->mmio_r=
emap_offset;

This should be the same as the doorbell handling, just replace
adev->doorbell.base with adev->mmio_remap.base

Alex

> +               mem->bus.is_iomem =3D true;
> +               mem->bus.caching =3D ttm_uncached;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -640,12 +650,20 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct t=
tm_buffer_object *bo,
>  {
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
>         struct amdgpu_res_cursor cursor;
> +       u64 pfn;
>
>         amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>                          &cursor);
>
> -       if (bo->resource->mem_type =3D=3D AMDGPU_PL_DOORBELL)
> +       if (bo->resource->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
>                 return ((uint64_t)(adev->doorbell.base + cursor.start)) >=
> PAGE_SHIFT;
> +       } else if (bo->resource->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP) {
> +               /* Return PFN for the remapped HDP page */
> +               pfn =3D (u64)adev->mmio_remap_base +
> +                       (u64)adev->mmio_remap_offset +
> +                       (u64)cursor.start;
> +               return (unsigned long)(pfn >> PAGE_SHIFT);
> +       }
>
>         return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>  }
> @@ -1355,7 +1373,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm=
, struct ttm_resource *mem)
>
>         if (mem && (mem->mem_type =3D=3D TTM_PL_TT ||
>                     mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> -                   mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)) {
> +                   mem->mem_type =3D=3D AMDGPU_PL_PREEMPT || mem->mem_ty=
pe =3D=3D AMDGPU_PL_MMIO_REMAP)) {
>                 flags |=3D AMDGPU_PTE_SYSTEM;
>
>                 if (ttm->caching =3D=3D ttm_cached)
> --
> 2.34.1
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A18C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD1110E334;
	Thu, 28 Aug 2025 15:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGS/aK1S";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD3910E334
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:09:27 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b475b63ab66so216312a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393767; x=1756998567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnxEZrl8rVQuyJNdn8I7lqijTNT2dHjG7h5n7iE0raQ=;
 b=CGS/aK1SpuvJcCrvfYd4Ddk3Vny1uk9wXMRuF6h9/N9n+kPgGRLXMzpAV+G1jxmG0a
 YLhlucBkBPLAXslQYAqAW23oldKvPyfqhIA0plrXse3Zx52kEB5XbN8e/jTDNgK4yLrq
 c3mf1/7faYsilfwpsv3XSVG3+80PL7iEPrmBr7gAmaMoBlTzJSLBci+DnMjBhAGoyr8a
 YBTqEDaEzRjvFJybA3kZRQIxLSg3JWxtBN9/dJLQQNLTvs3QqAIhWIJjQmHGkAJHCyy3
 B1wYN1W7L64LFyOwnF+CjdNWtIqeH2kpTpiv7tEzblAcv2sEPyUYCrWNvWxwE4VkPgsZ
 8+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393767; x=1756998567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnxEZrl8rVQuyJNdn8I7lqijTNT2dHjG7h5n7iE0raQ=;
 b=dh4H/w4NO33AL987zUPhnUxIZexH7wauXIliEObAf0XzkYG59TqGNKGoZ2NINEP+LL
 2ikZ3jYMbijCW1p0Iy4Z2pa1iHcIaSIwRczI6riHYbNka6wlsOh+xz/82U3waG/Cawvu
 K5MdaWPcv6H+/CCC87zLx+MCj09HKNiriwN2XGKO60A/bAZGueFFYdHRFKFSzJ8A4OoU
 e+77611nxbmXyTnHktc3Wl5RgNhQmwx0FYQB9XOO4edWh0r8c4eh6tnCeU0PUGf8d0gk
 J6laPiSnGzjk94IhWjH9kfWIiZXBz3osCoZfqR980M2svaRVMqZg6qF/SEsJu0CgJRpj
 MC6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYvKeB+5+Htuhmlk7vpLiKvlHSqbdK2o1eteWlkfZ+CmLxfH4SfRrRCHiRty5ox2oAv6j3uA4g@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxBvU4omRckoWaG+NHQDh12KaJ5ye2MgSSlJb8tF48AN+lKIal
 6IslTNmRpEXtAPWW6nEIY7YR4ylrZfUibSaZSKEwl/o/UUYILbpEC9F8XlhFiReVFiZVDRMbFlG
 G5ohj2QQcKwLb7or/fCwnRcKHQm9vCFc=
X-Gm-Gg: ASbGncuawu4DHKbCGUyy7wausQDOd5aYD1PGQvonY2vKRxpCAU1HAHOoVjQFlpbxRUM
 9CcldSTK6BVF8lhFEcbUwHZizo9yiKzufZ5tLRWKC8Vbp88Q2KEuxBznUE8gWVCX6QTKs43Za/E
 NqJDVaoS5ME5jkWDBFu8MWTIKlJ0HOMifInurAnQdHGkWKPrL+SGD6loq3NijBImgLyscN590Av
 FsMhuaEQMhiQ4ClvA==
X-Google-Smtp-Source: AGHT+IH7+GyVwu+JIYb+9numU+h1OHuERyn/gw09rsvxiRRRbDSe7pO9F6ZYUBVX0HM+aVmGLPRicoEWFSJGszB50WA=
X-Received: by 2002:a17:90b:4b0f:b0:325:8f8c:4e13 with SMTP id
 98e67ed59e1d1-3258f8c503cmr11425972a91.2.1756393766927; Thu, 28 Aug 2025
 08:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
 <20250828071335.3948819-7-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828071335.3948819-7-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:09:15 -0400
X-Gm-Features: Ac12FXwqo5Vll1_mmTzvRvHio4Nh3baH6yLE2FrOEr8rn8sqouzFdyUCAN4EA1A
Message-ID: <CADnq5_MrwnZU2RTB3wguim7iWNMDZXOOn=fGk8TtmjyNEZvgjw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/amdgpu: Implement TTM handling for MMIO_REMAP
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

On Thu, Aug 28, 2025 at 5:33=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves as a
> CPU-visible IO page:
>
> * amdgpu_evict_flags(): mark as unmovable
> * amdgpu_res_cpu_visible(): consider CPU-visible
> * amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
> * amdgpu_ttm_io_mem_reserve(): program base/is_iomem/caching using
>   the device's mmio_remap_* metadata
> * amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
> * amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type
>
> v2:
> - Drop HDP-specific comment; keep generic remap (Alex).
>
> v3:
> - Fix indentation in amdgpu_res_cpu_visible (Christian).
> - Use adev->rmmio_remap.bus_addr for MMIO_REMAP bus/PFN calculations
>   (Alex).
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 27ab4e754b2a..9211d250fcfb 100644
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
> +           res->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP)
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
> +       case AMDGPU_PL_MMIO_REMAP:
> +               mem->bus.offset =3D ((resource_size_t)mem->start << PAGE_=
SHIFT);
> +               mem->bus.offset +=3D (resource_size_t)adev->rmmio_remap.b=
us_addr;

You can drop the casts here.  With that fixed this patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               mem->bus.is_iomem =3D true;
> +               mem->bus.caching =3D ttm_uncached;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -646,6 +656,8 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm=
_buffer_object *bo,
>
>         if (bo->resource->mem_type =3D=3D AMDGPU_PL_DOORBELL)
>                 return ((uint64_t)(adev->doorbell.base + cursor.start)) >=
> PAGE_SHIFT;
> +       else if (bo->resource->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP)
> +               return ((uint64_t)(adev->rmmio_remap.bus_addr + cursor.st=
art)) >> PAGE_SHIFT;
>
>         return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>  }
> @@ -1355,7 +1367,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm=
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

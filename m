Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC0CA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49D910E4DD;
	Mon, 25 Aug 2025 14:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="klFDC2k8";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BD810E4DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:52:54 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b47174b335bso577702a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756133574; x=1756738374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eX3wTUrQZTHkoHxE1EtuwCVj1dMdHIAJzjwwGK4LYQk=;
 b=klFDC2k8hcdVnwgWeuB/mf9LUb1V+I30hBwzrNpvC1TWPH39afw0oKOX28poBKScs/
 TN9l2YTTWCM8cFKR6GXYRxvt11VKSadcNvewxy/zwbTMAM3Hcs2EPAKZ9yf4vWKHEgNS
 SguTV4aUuysCjEEhlcvgtf56+K8iYEuyETYTm7Js8wtBKCHSoOzxmRHLJkw4xOyl72KI
 vwq+teAhlgMLuD75eUok4BNGSUdde9wzIbHQGsIyMZFPRcHLnCrVUryDvoHLn2G92rDh
 n2+tmx9qfH/+c2WCsYdIikO+VoxeaVZqoyqTRgMrODX6W6tSO2y0PK4PoOSY4RCRPn4S
 vR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756133574; x=1756738374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eX3wTUrQZTHkoHxE1EtuwCVj1dMdHIAJzjwwGK4LYQk=;
 b=Xg8muAIO0r8rneuEzIGpz2jcKITVlI5DdUepebE7oEAHluOTmexQqh3GpUapMurKVb
 yNJ6dIi9/sOwRNAVyzHAuTx0x0/V3FrfYTBEalFUcM9x9gT3mQ2qzbZKDepdQIrWjPaS
 LuOkm8/S+p0vKjd62jLvBff4RVdwNCIIhRe06tiBmZpNgG33aaZDMSfwlTyp8udjWWAV
 ufoiWZwWDr2yiD2zaYfgzIlO4Sz9xER0Z3eQmSkQyJ5ATQQWcfvGqWC5pbXp086lKe5q
 9pELWcp4YoQRmF3ulN6ZtNydlI7HNrNF8VRTpi123FaVbI0y4+fBykcYMvDud5XYBICA
 l4RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX3d2h32Ve7z0fU8v8dhCQvPLE71JOVXL3GQXm02l4STY0H0vx1cRO0n9hEIQtVkL4u7xkbftE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzVUSy/DrNdVB+eqTqIVOC+GdDkRPemIa1v54kilN6NH9yuKAE
 WXaEoUqrs6LPm/QaJwtoHjL9sABvZoJkhxy4Hkpsrpq+OSfIJX/8sFkm1FGXtrkGzblf7qv9Bdi
 WMMxkOzHxyyt3x2WHulwAfrREHtaroMEL4c2O
X-Gm-Gg: ASbGncvrYD4EXPeG569J3A7Qc+BN68Hz8sdtowCSPZEElkF1mXGjW7nEN9AgLB4GIAb
 TQg/LyX9q0hSXpz0IfpwjOhIv6+ceZBnuyM564ullOWoiFPy60lR1Br4Y4ytoysHm+vs6FV1d6h
 pQbJ96HDO1o4gwWovu8O+krv9sxv1+t10opoRXMup3pdBxidqVysRnKpMAgTcIydzqualUfItf6
 nqMXks=
X-Google-Smtp-Source: AGHT+IE1uAQUuWpinmZ6t9MEd85MuBADI8LUMO4xJxGY0rEJ2O2YJ/4yB3sBf+xbeX++Eg/d0s4XkaDyyvxZpXJnvoo=
X-Received: by 2002:a17:902:e851:b0:246:7d12:fd40 with SMTP id
 d9443c01a7336-2467d12fe71mr55513945ad.3.1756133573383; Mon, 25 Aug 2025
 07:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-6-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250823072016.1272328-6-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 10:52:41 -0400
X-Gm-Features: Ac12FXxjBDrl4YqdpJEmuzojOKCmzzwoiv0-t13vTEkIKR3gjoHDy5faqkdvBzc
Message-ID: <CADnq5_MB1iBtf2Xw8swSy+WcdB66g-Qp5+vshTLO3SkBXoQQzg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] drm/amdgpu: Implement TTM handling for
 MMIO_REMAP placement
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

On Sat, Aug 23, 2025 at 3:28=E2=80=AFAM Srinivasan Shanmugam
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
> - Use adev->rmmio_base; remove base+offset math (Alex).
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
> index 27ab4e754b2a..f6027ccd9196 100644
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
> +       case AMDGPU_PL_MMIO_REMAP:
> +               mem->bus.offset =3D mem->start << PAGE_SHIFT;
> +               mem->bus.offset +=3D adev->rmmio_base;

This is wrong.  It needs to be adev->rmmio_remap.bus_addr.

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
> +               return ((uint64_t)(adev->rmmio_base + cursor.start)) >> P=
AGE_SHIFT;

Same here.

Alex

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

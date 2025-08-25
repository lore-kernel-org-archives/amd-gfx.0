Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB3CCA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B538610E4DF;
	Mon, 25 Aug 2025 14:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icGprBep";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FC010E4DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:54:49 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2462ae29714so3926235ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756133689; x=1756738489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T8ilNBrMd6lgfMfVAYjvhQDEK0Pi9s3SAiIms4mPd04=;
 b=icGprBepbCaaea9IcQnyUluu/oAc2PfND0ueC5PxkUQdFZv9RoPwhsgT4ys/jb3uFN
 mlnevaK6WMfEdVi7D3SfUaIlyaj5ZkQUk7IBJxawxxzHk50axcpdJTQYLA9Cf/OdGnYU
 4CvT6fOkiNY/4x8TGRO7tcbHEh5Hew+Tcq8oetosxI6tUGNknRA2yxUdhEaldrI3VlBZ
 ZpPB/kYQjT4lrHRuyPaomXO5UA12/ugt2EMb88y5xrT3ftlrE8jI4amI52/RuXquyL8a
 p7NhLOnqCfWIzLGrT45+bHu437pYNxx0UgAPm/NuIdOGNBUCBaz3QP1HBno29zIDqOul
 t+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756133689; x=1756738489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8ilNBrMd6lgfMfVAYjvhQDEK0Pi9s3SAiIms4mPd04=;
 b=m/6N4OjJs6WIyvTeJCAIZqlw6bOjxQZPuyLLZErAWDZ3uJHd3VcEhYhU/qiKq7l7sf
 ZZJObmIashlPEqVGBtOj5LtnMdY1Xfg+Z7c4oT+hnKERJ5h72lG2xgqkdS+DB4hzD4Al
 4FQuZwTZLWWqCgFZtomd/N6Q21CgLcWG8iYq3onBEabgd8413ykLH8WphwI31tUfuP9M
 bQ1mh0uQQFay3N7TN4hArM7RXFoSRWso2QkRegh6c7i8tKKlidzYS0/TAIpIqTR4fUN7
 spnbvuqxGv7juYRh5P8z38owR7fp34TgobHPKtDl0mGSbfJ+qfdLsUEqTCSmFI7MVcNj
 SL+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXueNgmNPn7x+YJ4PMH91I0XmTQgzoo1NCD3515xXUnuCszL9HPSNHHNOehJwndwW9+yGR5EGCh@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzk0FwCpcniH8ko3t5zxNniwd3P82idPr22gkU/kojEV9+Y8wUa
 GNsqEnuc6hzMDbOuhVGTcaHDS+dG7A4/udrnAClpvLEOd8ndr9+k7kkHrYRf7YoFfgdavDxm7tS
 cKS5BqTJulg3YanMvpz2yPuP6NMAf7GZiSvOd
X-Gm-Gg: ASbGncsIxZWSmKHb0cH+LxisgAk2YZDhoz/3IzRbAYWX4ZiX9i/04OlwLviS9zrVOgW
 bLaBTJjraHGIBmzSoCwrT2Peze2d/f469kmkVPmPUQxb/D/LFp+Kx3sf8spfDTEqplKqKTwtprr
 oB9LweCUBBiyLRIZabQuviQs2sFw6QhigDkzIH0+7lGfH+FRmqpW8xh/Eb8pRpziB/IntFwcaa3
 QyHZzA=
X-Google-Smtp-Source: AGHT+IHDY49e8zZY9yq7GAdM5sNSu0MJwPfHNWf3nYOnaynEFHm2QvBeo/lFkQc5r+HdKXEEuZMTT/Re+DTic/50qD4=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr38289885ad.4.1756133688576; Mon, 25 Aug 2025
 07:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-6-srinivasan.shanmugam@amd.com>
 <CADnq5_MB1iBtf2Xw8swSy+WcdB66g-Qp5+vshTLO3SkBXoQQzg@mail.gmail.com>
In-Reply-To: <CADnq5_MB1iBtf2Xw8swSy+WcdB66g-Qp5+vshTLO3SkBXoQQzg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 10:54:36 -0400
X-Gm-Features: Ac12FXw_GeNAt3JgWZbdbxsMab9A7IHwAgvnPwWfL_dwgjv4crLV7qsaO0ntdZY
Message-ID: <CADnq5_OByYjy2+JoxdueOeYe7EsYELXEvYxMJmCChnQv6nbVHQ@mail.gmail.com>
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

On Mon, Aug 25, 2025 at 10:52=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Sat, Aug 23, 2025 at 3:28=E2=80=AFAM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
> >
> > Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves as =
a
> > CPU-visible IO page:
> >
> > * amdgpu_evict_flags(): mark as unmovable
> > * amdgpu_res_cpu_visible(): consider CPU-visible
> > * amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
> > * amdgpu_ttm_io_mem_reserve(): program base/is_iomem/caching using
> >   the device's mmio_remap_* metadata
> > * amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
> > * amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type
> >
> > v2:
> > - Drop HDP-specific comment; keep generic remap (Alex).
> > - Use adev->rmmio_base; remove base+offset math (Alex).
> >
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 27ab4e754b2a..f6027ccd9196 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -123,6 +123,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_ob=
ject *bo,
> >         case AMDGPU_PL_GWS:
> >         case AMDGPU_PL_OA:
> >         case AMDGPU_PL_DOORBELL:
> > +       case AMDGPU_PL_MMIO_REMAP:
> >                 placement->num_placement =3D 0;
> >                 return;
> >
> > @@ -447,7 +448,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *a=
dev,
> >                 return false;
> >
> >         if (res->mem_type =3D=3D TTM_PL_SYSTEM || res->mem_type =3D=3D =
TTM_PL_TT ||
> > -           res->mem_type =3D=3D AMDGPU_PL_PREEMPT || res->mem_type =3D=
=3D AMDGPU_PL_DOORBELL)
> > +           res->mem_type =3D=3D AMDGPU_PL_PREEMPT || res->mem_type =3D=
=3D AMDGPU_PL_DOORBELL ||
> > +               res->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP)
> >                 return true;
> >
> >         if (res->mem_type !=3D TTM_PL_VRAM)
> > @@ -538,10 +540,12 @@ static int amdgpu_bo_move(struct ttm_buffer_objec=
t *bo, bool evict,
> >             old_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
> >             old_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> >             old_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> > +           old_mem->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP ||
> >             new_mem->mem_type =3D=3D AMDGPU_PL_GDS ||
> >             new_mem->mem_type =3D=3D AMDGPU_PL_GWS ||
> >             new_mem->mem_type =3D=3D AMDGPU_PL_OA ||
> > -           new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL) {
> > +           new_mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> > +           new_mem->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP) {
> >                 /* Nothing to save here */
> >                 amdgpu_bo_move_notify(bo, evict, new_mem);
> >                 ttm_bo_move_null(bo, new_mem);
> > @@ -629,6 +633,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_de=
vice *bdev,
> >                 mem->bus.is_iomem =3D true;
> >                 mem->bus.caching =3D ttm_uncached;
> >                 break;
> > +       case AMDGPU_PL_MMIO_REMAP:
> > +               mem->bus.offset =3D mem->start << PAGE_SHIFT;
> > +               mem->bus.offset +=3D adev->rmmio_base;
>
> This is wrong.  It needs to be adev->rmmio_remap.bus_addr.

mem->bus.offset +=3D adev->rmmio_remap.bus_addr;

>
> > +               mem->bus.is_iomem =3D true;
> > +               mem->bus.caching =3D ttm_uncached;
> > +               break;
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -646,6 +656,8 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct t=
tm_buffer_object *bo,
> >
> >         if (bo->resource->mem_type =3D=3D AMDGPU_PL_DOORBELL)
> >                 return ((uint64_t)(adev->doorbell.base + cursor.start))=
 >> PAGE_SHIFT;
> > +       else if (bo->resource->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP)
> > +               return ((uint64_t)(adev->rmmio_base + cursor.start)) >>=
 PAGE_SHIFT;
>
> Same here.
>

return ((uint64_t)(adev->rmmio_remap.bus_addr + cursor.start)) >> PAGE_SHIF=
T;

Alex

> Alex
>
> >
> >         return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
> >  }
> > @@ -1355,7 +1367,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *t=
tm, struct ttm_resource *mem)
> >
> >         if (mem && (mem->mem_type =3D=3D TTM_PL_TT ||
> >                     mem->mem_type =3D=3D AMDGPU_PL_DOORBELL ||
> > -                   mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)) {
> > +                   mem->mem_type =3D=3D AMDGPU_PL_PREEMPT || mem->mem_=
type =3D=3D AMDGPU_PL_MMIO_REMAP)) {
> >                 flags |=3D AMDGPU_PTE_SYSTEM;
> >
> >                 if (ttm->caching =3D=3D ttm_cached)
> > --
> > 2.34.1
> >

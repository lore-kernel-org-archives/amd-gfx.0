Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98887C2D0FA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 12:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEB120659
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 12:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SfG8FJJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEB120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB226EA28;
	Wed, 13 May 2020 12:34:42 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0120A6EA1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 12:34:39 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id s8so20691007wrt.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bEX+Dy76wk6MJ05sE+aY81SiTFw/uayHur8lf84+t6o=;
 b=SfG8FJJlHMf3v8XsRfWNfYt3BDsaM6CNEruWuFmK8Ykxbq6w/aNZ/qlH5VUhDYllv8
 YxZMy0gzplatGsVoZVH2lhpsoCnZm9yUCykfIEveZoDWQRGDX8OjeQEKPgLu+qoXApq9
 zKuxZ1ND3iGlvO7bo/LJ2Pcz5LPmt75ritTQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bEX+Dy76wk6MJ05sE+aY81SiTFw/uayHur8lf84+t6o=;
 b=Rqfqps9cKGq14fJkeu2Hv2X8ZueF2GOPZG7a3Px5ePHTlXVSCwJ76ZsKspd7qbwVGn
 Ar8qj+aTbV1LRdjm1iqZmQWhvnbgKlD6Gfy46uCHSQHrd5OGlXhage3zJMknB7v7BX3D
 t/ehzlg4p5o4Z3WKR+7abAYCYpvXA7WTaNhhDH0azwt2unrKYCMFNAusd2vfCPxGRJH8
 0UbYttU7SlqrUg8SwgQW/IU7+fZoy/sFo7UTQrS79/MwMSGfpCnhw1Bife0tcewoaqcm
 ltPUj6G2jOFB9Cu3tHqAEwoiUrWyLJ88CjkeSZDglxFxRo3XfPC4J/ZsruqNYBsnb551
 n9eQ==
X-Gm-Message-State: AGi0PuafSrBtT9xk/Ewq44LuhMdLXMJDT+TcHJH1LorU3yJw5TyZwlLi
 Xh03XDv1WCmZeaPen/mipFN3Mw==
X-Google-Smtp-Source: APiQypJg9PVNoAyzNeAU7ZIgLaEps3Qzrt2Gzg7xDthV08vUz5bjFUj4AP7mWHRz0bgW+tBkaOZtdw==
X-Received: by 2002:a5d:5490:: with SMTP id h16mr30358270wrv.250.1589373278635; 
 Wed, 13 May 2020 05:34:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id a13sm26803059wrv.67.2020.05.13.05.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 05:34:37 -0700 (PDT)
Date: Wed, 13 May 2020 14:34:35 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 2/2] drm/ttm: deprecate AGP support
Message-ID: <20200513123435.GJ206103@phenom.ffwll.local>
References: <20200513110313.12979-1-christian.koenig@amd.com>
 <20200513110313.12979-3-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513110313.12979-3-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
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
Cc: nouveau@lists.freedesktop.org, debian-powerpc@lists.debian.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 13, 2020 at 01:03:13PM +0200, Christian K=F6nig wrote:
> Even when core AGP support is compiled in Radeon and
> Nouveau can also work with the PCI GART.
> =

> The AGP support was notorious unstable and hard to
> maintain, so deprecate it for now and only enable it if
> there is a good reason to do so.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>

So a lot more work, and more risk (but hey it's agp, how busted can it
get) could be to demidlayer this. I.e. a small set of helpers to create a
TTM_PL_TT manager, backed by agp. With zero agp code remaining in ttm
itself, and all the ttm agp code moved out to a ttm-agp-helper.ko module
that drivers would call.

But again a lot of work, so really only an option if we can't sunset agp
directly.
-Daniel

> ---
>  drivers/gpu/drm/Kconfig                       |  8 ++++++++
>  drivers/gpu/drm/nouveau/nouveau_bo.c          |  8 ++++----
>  drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h |  2 +-
>  drivers/gpu/drm/radeon/radeon_agp.c           |  8 ++++----
>  drivers/gpu/drm/radeon/radeon_ttm.c           | 10 +++++-----
>  drivers/gpu/drm/ttm/Makefile                  |  2 +-
>  6 files changed, 23 insertions(+), 15 deletions(-)
> =

> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 4f4e7fa001c1..52d834303766 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -182,6 +182,14 @@ config DRM_TTM
>  	  GPU memory types. Will be enabled automatically if a device driver
>  	  uses it.
>  =

> +config DRM_TTM_AGP
> +	bool "TTM AGP GART support (deprecated)"
> +	depends on DRM_TTM && AGP
> +	default n
> +	help
> +	  Enables deprecated AGP GART support in TTM.
> +	  Less reliable than PCI GART, but faster in some cases.
> +
>  config DRM_TTM_DMA_PAGE_POOL
>  	bool
>  	depends on DRM_TTM && (SWIOTLB || INTEL_IOMMU)
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouve=
au/nouveau_bo.c
> index c40f127de3d0..c73d4ae48f5c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -635,7 +635,7 @@ nouveau_bo_wr32(struct nouveau_bo *nvbo, unsigned ind=
ex, u32 val)
>  static struct ttm_tt *
>  nouveau_ttm_tt_create(struct ttm_buffer_object *bo, uint32_t page_flags)
>  {
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	struct nouveau_drm *drm =3D nouveau_bdev(bo->bdev);
>  =

>  	if (drm->agp.bridge) {
> @@ -1448,7 +1448,7 @@ nouveau_ttm_io_mem_reserve(struct ttm_bo_device *bd=
ev, struct ttm_mem_reg *reg)
>  		/* System memory */
>  		return 0;
>  	case TTM_PL_TT:
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  		if (drm->agp.bridge) {
>  			reg->bus.offset =3D reg->start << PAGE_SHIFT;
>  			reg->bus.base =3D drm->agp.base;
> @@ -1603,7 +1603,7 @@ nouveau_ttm_tt_populate(struct ttm_tt *ttm, struct =
ttm_operation_ctx *ctx)
>  	drm =3D nouveau_bdev(ttm->bdev);
>  	dev =3D drm->dev->dev;
>  =

> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	if (drm->agp.bridge) {
>  		return ttm_agp_tt_populate(ttm, ctx);
>  	}
> @@ -1656,7 +1656,7 @@ nouveau_ttm_tt_unpopulate(struct ttm_tt *ttm)
>  	drm =3D nouveau_bdev(ttm->bdev);
>  	dev =3D drm->dev->dev;
>  =

> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	if (drm->agp.bridge) {
>  		ttm_agp_tt_unpopulate(ttm);
>  		return;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h b/drivers/gpu/=
drm/nouveau/nvkm/subdev/pci/agp.h
> index ad4d3621d02b..d572528da852 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: MIT */
>  #include "priv.h"
> -#if defined(CONFIG_AGP) || (defined(CONFIG_AGP_MODULE) && defined(MODULE=
))
> +#if defined(CONFIG_DRM_TTM_AGP)
>  #ifndef __NVKM_PCI_AGP_H__
>  #define __NVKM_PCI_AGP_H__
>  =

> diff --git a/drivers/gpu/drm/radeon/radeon_agp.c b/drivers/gpu/drm/radeon=
/radeon_agp.c
> index 0aca7bdf54c7..294d19301708 100644
> --- a/drivers/gpu/drm/radeon/radeon_agp.c
> +++ b/drivers/gpu/drm/radeon/radeon_agp.c
> @@ -33,7 +33,7 @@
>  =

>  #include "radeon.h"
>  =

> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  =

>  struct radeon_agpmode_quirk {
>  	u32 hostbridge_vendor;
> @@ -131,7 +131,7 @@ static struct radeon_agpmode_quirk radeon_agpmode_qui=
rk_list[] =3D {
>  =

>  int radeon_agp_init(struct radeon_device *rdev)
>  {
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	struct radeon_agpmode_quirk *p =3D radeon_agpmode_quirk_list;
>  	struct drm_agp_mode mode;
>  	struct drm_agp_info info;
> @@ -265,7 +265,7 @@ int radeon_agp_init(struct radeon_device *rdev)
>  =

>  void radeon_agp_resume(struct radeon_device *rdev)
>  {
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	int r;
>  	if (rdev->flags & RADEON_IS_AGP) {
>  		r =3D radeon_agp_init(rdev);
> @@ -277,7 +277,7 @@ void radeon_agp_resume(struct radeon_device *rdev)
>  =

>  void radeon_agp_fini(struct radeon_device *rdev)
>  {
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	if (rdev->ddev->agp && rdev->ddev->agp->acquired) {
>  		drm_agp_release(rdev->ddev);
>  	}
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index 5d50c9edbe80..4f9c4e5f8263 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -86,7 +86,7 @@ static int radeon_init_mem_type(struct ttm_bo_device *b=
dev, uint32_t type,
>  		man->available_caching =3D TTM_PL_MASK_CACHING;
>  		man->default_caching =3D TTM_PL_FLAG_CACHED;
>  		man->flags =3D TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEMTYPE_FLAG_CMA;
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  		if (rdev->flags & RADEON_IS_AGP) {
>  			if (!rdev->ddev->agp) {
>  				DRM_ERROR("AGP is not enabled for memory type %u\n",
> @@ -411,7 +411,7 @@ static int radeon_ttm_io_mem_reserve(struct ttm_bo_de=
vice *bdev, struct ttm_mem_
>  		/* system memory */
>  		return 0;
>  	case TTM_PL_TT:
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  		if (rdev->flags & RADEON_IS_AGP) {
>  			/* RADEON_IS_AGP is set only if AGP is active */
>  			mem->bus.offset =3D mem->start << PAGE_SHIFT;
> @@ -631,7 +631,7 @@ static struct ttm_tt *radeon_ttm_tt_create(struct ttm=
_buffer_object *bo,
>  	struct radeon_ttm_tt *gtt;
>  =

>  	rdev =3D radeon_get_rdev(bo->bdev);
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	if (rdev->flags & RADEON_IS_AGP) {
>  		return ttm_agp_tt_create(bo, rdev->ddev->agp->bridge,
>  					 page_flags);
> @@ -683,7 +683,7 @@ static int radeon_ttm_tt_populate(struct ttm_tt *ttm,
>  	}
>  =

>  	rdev =3D radeon_get_rdev(ttm->bdev);
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	if (rdev->flags & RADEON_IS_AGP) {
>  		return ttm_agp_tt_populate(ttm, ctx);
>  	}
> @@ -714,7 +714,7 @@ static void radeon_ttm_tt_unpopulate(struct ttm_tt *t=
tm)
>  		return;
>  =

>  	rdev =3D radeon_get_rdev(ttm->bdev);
> -#if IS_ENABLED(CONFIG_AGP)
> +#if IS_ENABLED(CONFIG_DRM_TTM_AGP)
>  	if (rdev->flags & RADEON_IS_AGP) {
>  		ttm_agp_tt_unpopulate(ttm);
>  		return;
> diff --git a/drivers/gpu/drm/ttm/Makefile b/drivers/gpu/drm/ttm/Makefile
> index caea2a099496..aa772b198012 100644
> --- a/drivers/gpu/drm/ttm/Makefile
> +++ b/drivers/gpu/drm/ttm/Makefile
> @@ -5,7 +5,7 @@
>  ttm-y :=3D ttm_memory.o ttm_tt.o ttm_bo.o \
>  	ttm_bo_util.o ttm_bo_vm.o ttm_module.o \
>  	ttm_execbuf_util.o ttm_page_alloc.o ttm_bo_manager.o
> -ttm-$(CONFIG_AGP) +=3D ttm_agp_backend.o
> +ttm-$(CONFIG_DRM_TTM_AGP) +=3D ttm_agp_backend.o
>  ttm-$(CONFIG_DRM_TTM_DMA_PAGE_POOL) +=3D ttm_page_alloc_dma.o
>  =

>  obj-$(CONFIG_DRM_TTM) +=3D ttm.o
> -- =

> 2.17.1
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

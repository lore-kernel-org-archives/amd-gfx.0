Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C5C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 11:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D67721D7D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 11:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Gf8367WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D67721D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930506E9AC;
	Wed, 16 Sep 2020 11:31:59 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FFE6E99D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 11:31:58 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z4so6549635wrr.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=s0lmtJr9NtSCh2ARFa6xphTVLFrbX2QsJYq/k2jzQ5U=;
 b=Gf8367WPeSeQPQPququqR9nmCFZMOfneoLHOSZNngAZR6FN2a/oYqM2srKfxMlffls
 y3lwL3nsdUYo4QYi65kWsWkPt53jlGyhlIKucwEnvyHoLGlzIkdEYE798B0fVOq9JPNb
 cBFavPvt6MU2augrp90p56CBz8CIaWxEaUJYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s0lmtJr9NtSCh2ARFa6xphTVLFrbX2QsJYq/k2jzQ5U=;
 b=fau0rzWTABCntJEDpEkzN9So4PuffQpq4eavWjcGmvWpBflOXSpJsk0RDpFxvFT0uV
 ijXCkyrp3FDHIscxJCVwMDNC0jPdXwieMxeRCk0qtoKn1yhewUa4H7Jg5xm9q0jrlXW+
 V+YnXdhRckYdKGTLUbcMIYJOix694Cs/MHwasims0uAkf728Bym7L2ZR8880gutOvHHE
 kptSRKKZpDRSQojonwAqh9fMQFXZwVDOW3qUWZqDWJ48GsB0BAR+5MCbHc4Iuqovtm0Z
 74ZU5TXUf6SZwRShr9qqm72lQpIs8ybMM7+V85urBYH5Ud5+vpZTQWLA+n2N8Ae/8xeQ
 5cgA==
X-Gm-Message-State: AOAM532howlAHPia0DsPccVbdgZ77pIU3nt4ISccva0t1yzfnrZFnVrC
 zR4ZzyndugIIXSVBiCJudEmIKA==
X-Google-Smtp-Source: ABdhPJwDUHLS9jy7ETv8dWHdpP/K//iCwwECKpW/tCNWTEIypWcTfch4omPC7wkyf4knOCNGQ9EKaQ==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr25445792wrp.286.1600255917009; 
 Wed, 16 Sep 2020 04:31:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u186sm4255475wmu.34.2020.09.16.04.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:31:55 -0700 (PDT)
Date: Wed, 16 Sep 2020 13:31:52 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 05/21] drm/gma500: Introduce GEM object functions
Message-ID: <20200916113152.GJ438822@phenom.ffwll.local>
References: <20200915145958.19993-1-tzimmermann@suse.de>
 <20200915145958.19993-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915145958.19993-6-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: hamohammed.sa@gmail.com, heiko@sntech.de, andrey.grodzovsky@amd.com,
 airlied@linux.ie, nouveau@lists.freedesktop.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 michal.simek@xilinx.com, eric@anholt.net, thierry.reding@gmail.com,
 robdclark@gmail.com, krzk@kernel.org, sam@ravnborg.org,
 sumit.semwal@linaro.org, emil.velikov@collabora.com,
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 oleksandr_andrushchenko@epam.com, tomi.valkeinen@ti.com,
 linux-tegra@vger.kernel.org, linux@armlinux.org.uk,
 patrik.r.jakobsson@gmail.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, kgene@kernel.org, bskeggs@redhat.com,
 xen-devel@lists.xenproject.org, miaoqinglang@huawei.com,
 intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
 chunkuang.hu@kernel.org, andi.shyti@intel.com, daniel@ffwll.ch,
 linux-arm-msm@vger.kernel.org, marek.olsak@amd.com, tianci.yin@amd.com,
 maarten.lankhorst@linux.intel.com, etnaviv@lists.freedesktop.org,
 jani.nikula@linux.intel.com, inki.dae@samsung.com, hdegoede@redhat.com,
 christian.gmeiner@gmail.com, linux-mediatek@lists.infradead.org,
 mripard@kernel.org, rodrigo.vivi@intel.com, matthias.bgg@gmail.com,
 evan.quan@amd.com, sean@poorly.run, linux-arm-kernel@lists.infradead.org,
 tvrtko.ursulin@linux.intel.com, amd-gfx@lists.freedesktop.org,
 laurent.pinchart@ideasonboard.com, hyun.kwon@xilinx.com,
 rodrigosiqueiramelo@gmail.com, aaron.liu@amd.com, Felix.Kuehling@amd.com,
 xinhui.pan@amd.com, sw0312.kim@samsung.com, hjc@rock-chips.com,
 chris@chris-wilson.co.uk, kyungmin.park@samsung.com, nirmoy.das@amd.com,
 p.zabel@pengutronix.de, alexander.deucher@amd.com, Hawking.Zhang@amd.com,
 freedreno@lists.freedesktop.org, christian.koenig@amd.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 15, 2020 at 04:59:42PM +0200, Thomas Zimmermann wrote:
> GEM object functions deprecate several similar callback interfaces in
> struct drm_driver. This patch replaces the per-driver callbacks with
> per-instance callbacks in gma500.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/gma500/framebuffer.c |  2 ++
>  drivers/gpu/drm/gma500/gem.c         | 18 ++++++++++++++++--
>  drivers/gpu/drm/gma500/gem.h         |  3 +++
>  drivers/gpu/drm/gma500/psb_drv.c     |  9 ---------
>  drivers/gpu/drm/gma500/psb_drv.h     |  2 --
>  5 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
> index 54d9876b5305..5ede24fb44ae 100644
> --- a/drivers/gpu/drm/gma500/framebuffer.c
> +++ b/drivers/gpu/drm/gma500/framebuffer.c
> @@ -24,6 +24,7 @@
>  #include <drm/drm_gem_framebuffer_helper.h>
>  
>  #include "framebuffer.h"
> +#include "gem.h"
>  #include "gtt.h"
>  #include "psb_drv.h"
>  #include "psb_intel_drv.h"
> @@ -285,6 +286,7 @@ static struct gtt_range *psbfb_alloc(struct drm_device *dev, int aligned_size)
>  	/* Begin by trying to use stolen memory backing */
>  	backing = psb_gtt_alloc_range(dev, aligned_size, "fb", 1, PAGE_SIZE);
>  	if (backing) {
> +		backing->gem.funcs = &psb_gem_object_funcs;
>  		drm_gem_private_object_init(dev, &backing->gem, aligned_size);
>  		return backing;
>  	}
> diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
> index f9c4b1d76f56..8f07de83b6fb 100644
> --- a/drivers/gpu/drm/gma500/gem.c
> +++ b/drivers/gpu/drm/gma500/gem.c
> @@ -18,7 +18,9 @@
>  
>  #include "psb_drv.h"
>  
> -void psb_gem_free_object(struct drm_gem_object *obj)
> +static vm_fault_t psb_gem_fault(struct vm_fault *vmf);
> +
> +static void psb_gem_free_object(struct drm_gem_object *obj)
>  {
>  	struct gtt_range *gtt = container_of(obj, struct gtt_range, gem);
>  
> @@ -36,6 +38,17 @@ int psb_gem_get_aperture(struct drm_device *dev, void *data,
>  	return -EINVAL;
>  }
>  
> +static const struct vm_operations_struct psb_gem_vm_ops = {
> +	.fault = psb_gem_fault,
> +	.open = drm_gem_vm_open,
> +	.close = drm_gem_vm_close,
> +};
> +
> +const struct drm_gem_object_funcs psb_gem_object_funcs = {
> +	.free = psb_gem_free_object,
> +	.vm_ops = &psb_gem_vm_ops,
> +};
> +
>  /**
>   *	psb_gem_create		-	create a mappable object
>   *	@file: the DRM file of the client
> @@ -63,6 +76,7 @@ int psb_gem_create(struct drm_file *file, struct drm_device *dev, u64 size,
>  		dev_err(dev->dev, "no memory for %lld byte GEM object\n", size);
>  		return -ENOSPC;
>  	}
> +	r->gem.funcs = &psb_gem_object_funcs;
>  	/* Initialize the extra goodies GEM needs to do all the hard work */
>  	if (drm_gem_object_init(dev, &r->gem, size) != 0) {
>  		psb_gtt_free_range(dev, r);
> @@ -123,7 +137,7 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>   *	vma->vm_private_data points to the GEM object that is backing this
>   *	mapping.
>   */
> -vm_fault_t psb_gem_fault(struct vm_fault *vmf)
> +static vm_fault_t psb_gem_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct drm_gem_object *obj;
> diff --git a/drivers/gpu/drm/gma500/gem.h b/drivers/gpu/drm/gma500/gem.h
> index 4a74dc623b6b..3741a711b9fd 100644
> --- a/drivers/gpu/drm/gma500/gem.h
> +++ b/drivers/gpu/drm/gma500/gem.h
> @@ -8,6 +8,9 @@
>  #ifndef _GEM_H
>  #define _GEM_H
>  
> +extern const struct drm_gem_object_funcs psb_gem_object_funcs;
> +
>  extern int psb_gem_create(struct drm_file *file, struct drm_device *dev,
>  			  u64 size, u32 *handlep, int stolen, u32 align);
> +
>  #endif
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 34b4aae9a15e..b13376a6fb91 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -480,12 +480,6 @@ static const struct dev_pm_ops psb_pm_ops = {
>  	.runtime_idle = psb_runtime_idle,
>  };
>  
> -static const struct vm_operations_struct psb_gem_vm_ops = {
> -	.fault = psb_gem_fault,
> -	.open = drm_gem_vm_open,
> -	.close = drm_gem_vm_close,
> -};
> -
>  static const struct file_operations psb_gem_fops = {
>  	.owner = THIS_MODULE,
>  	.open = drm_open,
> @@ -507,9 +501,6 @@ static struct drm_driver driver = {
>  	.irq_uninstall = psb_irq_uninstall,
>  	.irq_handler = psb_irq_handler,
>  
> -	.gem_free_object_unlocked = psb_gem_free_object,
> -	.gem_vm_ops = &psb_gem_vm_ops,
> -
>  	.dumb_create = psb_gem_dumb_create,
>  	.ioctls = psb_ioctls,
>  	.fops = &psb_gem_fops,
> diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
> index 956926341316..c71a5a4e912c 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.h
> +++ b/drivers/gpu/drm/gma500/psb_drv.h
> @@ -735,12 +735,10 @@ extern const struct drm_connector_helper_funcs
>  extern const struct drm_connector_funcs psb_intel_lvds_connector_funcs;
>  
>  /* gem.c */
> -extern void psb_gem_free_object(struct drm_gem_object *obj);
>  extern int psb_gem_get_aperture(struct drm_device *dev, void *data,
>  			struct drm_file *file);
>  extern int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>  			struct drm_mode_create_dumb *args);
> -extern vm_fault_t psb_gem_fault(struct vm_fault *vmf);
>  
>  /* psb_device.c */
>  extern const struct psb_ops psb_chip_ops;
> -- 
> 2.28.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93194C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EF8221ED
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EF8221ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275DC6E15E;
	Tue, 12 Jan 2021 09:04:29 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F036E160
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:04:28 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id a6so1199376wmc.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YPvEj8J2/AslYNyHN3mUqMeHRZQHi9j7tCjihlYckRM=;
 b=kqlQ0F50yaVF1QjoyzH1nLZ1RvUKNdASbt+dRn+QYxmbgboBcQBylWvlu8wehh3QJa
 jLjI9XRSPrGLOtU0yz/WxKTODD9wKwP6Ju+fCR1HQXx866ne6tlzV1TOg1PXtQ8ScC/I
 yKonG0HjT3ajx4Wqhz8ItAJ/ESWGMY3fVl6VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YPvEj8J2/AslYNyHN3mUqMeHRZQHi9j7tCjihlYckRM=;
 b=Gww2xQQC1bz6p8qdb932xuaw1Ijc1nJQPh4ebszdZtBxYl4AqClGpTe4bvgWQiSa6P
 pysJj/pSjGmlTlExuNQN1Gtta7WcVFkYIhGMDBABBfXoKDmuBun/iCtAJTDLOZQR3Blc
 y2iMFeWb6h1ZqPE/10e9rS1qWUTtX5GNtgaAIrHaUCl2+Ri8zRVhl8C2X+YzjgsbBFSo
 fQtu63nIjo+gRDwdp7ai+hiPtXdWEpPjGeS5542oMi9osTMaQX+3XzwhXDxngxV5oXWr
 J7oL5GFliKBMRq/Gn8wfWlR/XitrOIsC1Q4+8XQtz+G1IaaPqytF89xEygok2OnVNI8j
 UNKA==
X-Gm-Message-State: AOAM5319jVdt/wiUxyezA+XxULvrs0QHX29T3gXssktsU3D5aDhEirym
 R60L1k6AT9damL1tu/HQr11Zeg==
X-Google-Smtp-Source: ABdhPJzkb1P4k4zFnpfFRe7VCbwFDMbAMSjrsW/QYpuyu0Au8MnkNUbWZhCZBH0ZyxAqo8ZwJcFGhA==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr2489027wmg.109.1610442266894; 
 Tue, 12 Jan 2021 01:04:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id h9sm3034255wme.11.2021.01.12.01.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 01:04:26 -0800 (PST)
Date: Tue, 12 Jan 2021 10:04:24 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/6] drm: Merge CONFIG_DRM_VM into CONFIG_DRM_LEGACY
Message-ID: <X/1mGNKVqmXOT8u4@phenom.ffwll.local>
References: <20210112081035.6882-1-tzimmermann@suse.de>
 <20210112081035.6882-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112081035.6882-5-tzimmermann@suse.de>
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
Cc: amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 12, 2021 at 09:10:33AM +0100, Thomas Zimmermann wrote:
> CONFIG_DRM_VM gets selected by CONFIG_DRM_LEGACY, but nothing else. So
> remove it and build drm_vm.o as part of CONFIG_DRM_LEGACY.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/Kconfig      | 5 -----
>  drivers/gpu/drm/Makefile     | 3 +--
>  drivers/gpu/drm/drm_legacy.h | 2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 0973f408d75f..8bf103de1594 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -214,10 +214,6 @@ config DRM_GEM_SHMEM_HELPER
>  	help
>  	  Choose this if you need the GEM shmem helper functions
>  
> -config DRM_VM
> -	bool
> -	depends on DRM && MMU
> -
>  config DRM_SCHED
>  	tristate
>  	depends on DRM
> @@ -391,7 +387,6 @@ source "drivers/gpu/drm/xlnx/Kconfig"
>  menuconfig DRM_LEGACY
>  	bool "Enable legacy drivers (DANGEROUS)"
>  	depends on DRM && MMU

Ah we already depend upon MMU here, so should be all good.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> -	select DRM_VM
>  	help
>  	  Enable legacy DRI1 drivers. Those drivers expose unsafe and dangerous
>  	  APIs to user-space, which can be used to circumvent access
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index ba0ecb7756c6..926adef289db 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -21,9 +21,8 @@ drm-y       :=	drm_auth.o drm_cache.o \
>  		drm_managed.o drm_vblank_work.o
>  
>  drm-$(CONFIG_DRM_LEGACY) += drm_bufs.o drm_context.o drm_dma.o drm_legacy_misc.o drm_lock.o \
> -		drm_memory.o drm_scatter.o
> +		drm_memory.o drm_scatter.o drm_vm.o
>  drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
> -drm-$(CONFIG_DRM_VM) += drm_vm.o
>  drm-$(CONFIG_COMPAT) += drm_ioc32.o
>  drm-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
>  drm-$(CONFIG_DRM_GEM_SHMEM_HELPER) += drm_gem_shmem_helper.o
> diff --git a/drivers/gpu/drm/drm_legacy.h b/drivers/gpu/drm/drm_legacy.h
> index 1be3ea320474..f71358f9eac9 100644
> --- a/drivers/gpu/drm/drm_legacy.h
> +++ b/drivers/gpu/drm/drm_legacy.h
> @@ -127,7 +127,7 @@ static inline void drm_legacy_master_rmmaps(struct drm_device *dev,
>  static inline void drm_legacy_rmmaps(struct drm_device *dev) {}
>  #endif
>  
> -#if IS_ENABLED(CONFIG_DRM_VM) && IS_ENABLED(CONFIG_DRM_LEGACY)
> +#if IS_ENABLED(CONFIG_DRM_LEGACY)
>  void drm_legacy_vma_flush(struct drm_device *d);
>  #else
>  static inline void drm_legacy_vma_flush(struct drm_device *d)
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

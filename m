Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911FAC4741F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1344722206
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YWValxB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1344722206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244206E983;
	Wed,  4 Nov 2020 10:00:26 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A12E6E983
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 10:00:24 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w14so21321303wrs.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2020 02:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KMMYdNImcUZPw2ZGdMBwIRa3KoK+N1bEW4YQyWUg3HQ=;
 b=YWValxB5oMHVBivcMlfvG+N0EEo/OcTvjEeIAH4O24c+Hy5ABrF8PjohIZj7McKRCM
 tw20FtaGkNcDOC0JkrK75cXDeZKpT/Tz55O1A9iHM4p0hsnZV32ywC7j4qkYN9On0LHh
 Qf0YsvVTlYXAtJQSx4q+zfAvz3HH9ckQRkmJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KMMYdNImcUZPw2ZGdMBwIRa3KoK+N1bEW4YQyWUg3HQ=;
 b=n1rWGTcaD55JTZqaXxbRMfEocsnc4pm7brEbyGsVrHOTsNIO1Obt+prMma47v4eojy
 4iiaTMxhrxGJPLsQqbcmb/7L3t4kkuryKywApNx5huX0jCdqWHAbsX17vH5EWVD+B2m6
 LkB385C2ijrDVJPQWIwrAI10x09ZQ1h+YENhhkgUBvUND6ukaFB86AN0Ng0/GDICoWAm
 G2jpeRpRBsM8npgZvYvQ7j2altN77t2QtGcb38/NZJEaRFAWSBV0A+rCfV3VjRqVg8dp
 gp/hyl/iB6SiV2J3a6VIK2g3+JxxDfxm3h9WTnVcXhMQfzcX/6AbGyG0V3CBFEOP1ZhV
 UDqw==
X-Gm-Message-State: AOAM530Hz9ipVHptmM8P3DB5Hla4h94uHD38DBDF2dczm7QGpi1dxfXF
 v6EFhWmw3yV3BkQPX0e4aQ/Ybg==
X-Google-Smtp-Source: ABdhPJxs2WTrAyFF0SvXgCh3A7ap1oK5GyYy0y0t9CLoHcUZsPlI1hJ0PN3JFDuyu76lmc5ajjjX8g==
X-Received: by 2002:adf:8296:: with SMTP id 22mr31403434wrc.341.1604484023179; 
 Wed, 04 Nov 2020 02:00:23 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id x18sm1915578wrg.4.2020.11.04.02.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 02:00:22 -0800 (PST)
Date: Wed, 4 Nov 2020 11:00:20 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Make struct drm_driver const
Message-ID: <20201104100020.GN401619@phenom.ffwll.local>
References: <20201104031129.361178-1-luben.tuikov@amd.com>
 <20201104031129.361178-3-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201104031129.361178-3-luben.tuikov@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 03, 2020 at 10:11:29PM -0500, Luben Tuikov wrote:
> Make the definition of struct drm_driver
> a constant, to follow the latest developments
> in the DRM layer.
> 
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 32 +++++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 25 +------------------
>  2 files changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e5bee56e06d1..be304df7a8c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -40,6 +40,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_irq.h"
>  #include "amdgpu_dma_buf.h"
> +#include "amdgpu_sched.h"
>  
>  #include "amdgpu_amdkfd.h"
>  
> @@ -1105,7 +1106,7 @@ static const struct pci_device_id pciidlist[] = {
>  
>  MODULE_DEVICE_TABLE(pci, pciidlist);
>  
> -static struct drm_driver kms_driver;
> +static const struct drm_driver amdgpu_kms_driver;
>  
>  static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *ent)
> @@ -1183,7 +1184,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  	adev->dev  = &pdev->dev;
>  	adev->pdev = pdev;
>  	ddev = adev_to_drm(adev);
> -	ret = drm_dev_init(ddev, &kms_driver, &pdev->dev);
> +	ret = drm_dev_init(ddev, &amdgpu_kms_driver, &pdev->dev);
>  	if (ret)
>  		goto err_free;
>  
> @@ -1528,7 +1529,30 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
>  	return 0;
>  }
>  
> -static struct drm_driver kms_driver = {
> +int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
> +const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_CREATE, amdgpu_gem_create_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_CTX, amdgpu_ctx_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_VM, amdgpu_vm_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	/* KMS */
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_CS, amdgpu_cs_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_INFO, amdgpu_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_CS, amdgpu_cs_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_FENCES, amdgpu_cs_wait_fences_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_METADATA, amdgpu_gem_metadata_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_display_freesync_ioctl, DRM_MASTER)

freesync escaped from your internal tree, I dropped that when applying.
Plus I solved the conflict with drm_dev_alloc (it should be in drm-next
now sinc this morning, maybe good time to resync the internal tree to
avoid conflicts like this).

Otherwise looks a lot less work than I feared (after having wrangled
radeon to work), thanks for doing this.
-Daniel

> +};
> +
> +static const struct drm_driver amdgpu_kms_driver = {
>  	.driver_features =
>  	    DRIVER_ATOMIC |
>  	    DRIVER_GEM |
> @@ -1539,6 +1563,7 @@ static struct drm_driver kms_driver = {
>  	.lastclose = amdgpu_driver_lastclose_kms,
>  	.irq_handler = amdgpu_irq_handler,
>  	.ioctls = amdgpu_ioctls_kms,
> +	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
>  	.gem_free_object_unlocked = amdgpu_gem_object_free,
>  	.gem_open_object = amdgpu_gem_object_open,
>  	.gem_close_object = amdgpu_gem_object_close,
> @@ -1597,7 +1622,6 @@ static int __init amdgpu_init(void)
>  		goto error_fence;
>  
>  	DRM_INFO("amdgpu kernel modesetting enabled.\n");
> -	kms_driver.num_ioctls = amdgpu_max_kms_ioctl;
>  	amdgpu_register_atpx_handler();
>  
>  	/* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index bf01744a38f8..4f72c096b3c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -29,7 +29,6 @@
>  #include "amdgpu.h"
>  #include <drm/drm_debugfs.h>
>  #include <drm/amdgpu_drm.h>
> -#include "amdgpu_sched.h"
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
>  #include "atom.h"
> @@ -484,7 +483,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   * etc. (all asics).
>   * Returns 0 on success, -EINVAL on failure.
>   */
> -static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> +int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  {
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct drm_amdgpu_info *info = data;
> @@ -1247,28 +1246,6 @@ void amdgpu_disable_vblank_kms(struct drm_crtc *crtc)
>  	amdgpu_irq_put(adev, &adev->crtc_irq, idx);
>  }
>  
> -const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
> -	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_CREATE, amdgpu_gem_create_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_CTX, amdgpu_ctx_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_VM, amdgpu_vm_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	/* KMS */
> -	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_CS, amdgpu_cs_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_INFO, amdgpu_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_CS, amdgpu_cs_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_FENCES, amdgpu_cs_wait_fences_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_METADATA, amdgpu_gem_metadata_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_display_freesync_ioctl, DRM_MASTER)
> -};
> -const int amdgpu_max_kms_ioctl = ARRAY_SIZE(amdgpu_ioctls_kms);
> -
>  /*
>   * Debugfs info
>   */
> -- 
> 2.29.2.154.g7f7ebe054a
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF004C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F84B206F1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 09:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KGyFGp3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F84B206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56EEC6E15A;
	Mon, 22 Jun 2020 09:48:54 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9A96E157
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 09:48:53 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h5so15991902wrc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2020 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8Lqofcsk3EiaL1vTYLPUsPdckNQSLxhNM7di78Tz8WM=;
 b=KGyFGp3vCgjBWy83PyvGnx5e09iI9rqKsqrWO6kZhYT6d2/wBHiFN924YspndhSqPI
 jS3Fw+S9OiNhn+ihY8KcTqv8tKaJbbngMM/YlkSb5Q8NLKq8jUbCHqagdEVwKy4169sJ
 uBRk+udKRhmlT7bLmK1yLweVU6eVlbYW7/DY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8Lqofcsk3EiaL1vTYLPUsPdckNQSLxhNM7di78Tz8WM=;
 b=Od+ZlX6nNW6YS4RMN1Tm85a+eTEsi/Pn0NyDBMJhnPmv46Ga/oj9PPDOUVyZ15v30U
 qNVJ4kWEQjTFJkAKJjGaoKJAf14W6fG1ShBP3EHcE9tJlx3fxaA9mktslnwe6acbtWeb
 WYxPkE80Tq7u4KA9t8dfooBNiuZmCtY4SVC3phd3qt11Zubftb9D/XDT/sF3OBHMcP7G
 YN0QL2/0KKGJJH3XiCGl5CMc7Z9+TDjRnLTASEkOqfKnSq1SLn2ZKQ9ujHumg93h5ocy
 Sp+v/bXopYnBz0CVreYJ/w9+olOC93lf8Ghv7cwp43kB3/W3aRYKO8X3+Yka8u047+mf
 4sWg==
X-Gm-Message-State: AOAM530d3PKk25ySaEmA4EWEncOAkblEhP9fXbTspQrHvjiWsh7rNMR/
 MIAXfn9gkfI9YE12zITq9ZmEMg==
X-Google-Smtp-Source: ABdhPJz2RCZA/C2pGvUYQOWdrv+TItEaKagg4bSLWlvz0PXaF8jb8COakGPPq2tqA5Wyoep3RXc/pA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr19990620wrw.347.1592819331766; 
 Mon, 22 Jun 2020 02:48:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v4sm1964738wro.26.2020.06.22.02.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 02:48:51 -0700 (PDT)
Date: Mon, 22 Jun 2020 11:48:49 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH v2 4/8] drm/amdgpu: Split amdgpu_device_fini into early
 and late
Message-ID: <20200622094849.GD20149@phenom.ffwll.local>
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-5-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592719388-13819-5-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: daniel.vetter@ffwll.ch, michel@daenzer.net, dri-devel@lists.freedesktop.org,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org,
 ckoenig.leichtzumerken@gmail.com, alexdeucher@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 21, 2020 at 02:03:04AM -0400, Andrey Grodzovsky wrote:
> Some of the stuff in amdgpu_device_fini such as HW interrupts
> disable and pending fences finilization must be done right away on
> pci_remove while most of the stuff which relates to finilizing and releasing
> driver data structures can be kept until drm_driver.release hook is called, i.e.
> when the last device reference is dropped.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Long term I think best if as much of this code is converted over to devm
(for hw stuff) and drmm (for sw stuff and allocations). Doing this all
manually is very error prone.

I've started various such patches and others followed, but thus far only
very simple drivers tackled. But it should be doable step by step at
least, so you should have incremental benefits in code complexity right
away I hope.
-Daniel

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 24 +++++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 23 +++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  3 +++
>  7 files changed, 54 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a806cb..604a681 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1003,7 +1003,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		       struct drm_device *ddev,
>  		       struct pci_dev *pdev,
>  		       uint32_t flags);
> -void amdgpu_device_fini(struct amdgpu_device *adev);
> +void amdgpu_device_fini_early(struct amdgpu_device *adev);
> +void amdgpu_device_fini_late(struct amdgpu_device *adev);
> +
>  int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>  
>  void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> @@ -1188,6 +1190,8 @@ void amdgpu_driver_lastclose_kms(struct drm_device *dev);
>  int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
>  void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  				 struct drm_file *file_priv);
> +void amdgpu_driver_release_kms(struct drm_device *dev);
> +
>  int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>  int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>  int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cc41e8f..e7b9065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2309,6 +2309,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> +	//DRM_ERROR("adev 0x%llx", (long long unsigned int)adev);
> +
>  	amdgpu_ras_pre_fini(adev);
>  
>  	if (adev->gmc.xgmi.num_physical_nodes > 1)
> @@ -3304,10 +3306,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   * Tear down the driver info (all asics).
>   * Called at driver shutdown.
>   */
> -void amdgpu_device_fini(struct amdgpu_device *adev)
> +void amdgpu_device_fini_early(struct amdgpu_device *adev)
>  {
> -	int r;
> -
>  	DRM_INFO("amdgpu: finishing device.\n");
>  	flush_delayed_work(&adev->delayed_init_work);
>  	adev->shutdown = true;
> @@ -3330,7 +3330,13 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>  	if (adev->pm_sysfs_en)
>  		amdgpu_pm_sysfs_fini(adev);
>  	amdgpu_fbdev_fini(adev);
> -	r = amdgpu_device_ip_fini(adev);
> +
> +	amdgpu_irq_fini_early(adev);
> +}
> +
> +void amdgpu_device_fini_late(struct amdgpu_device *adev)
> +{
> +	amdgpu_device_ip_fini(adev);
>  	if (adev->firmware.gpu_info_fw) {
>  		release_firmware(adev->firmware.gpu_info_fw);
>  		adev->firmware.gpu_info_fw = NULL;
> @@ -3368,6 +3374,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>  		amdgpu_pmu_fini(adev);
>  	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
>  		amdgpu_discovery_fini(adev);
> +
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 9e5afa5..43592dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1134,12 +1134,9 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  
> -#ifdef MODULE
> -	if (THIS_MODULE->state != MODULE_STATE_GOING)
> -#endif
> -		DRM_ERROR("Hotplug removal is not supported\n");
>  	drm_dev_unplug(dev);
>  	amdgpu_driver_unload_kms(dev);
> +
>  	pci_disable_device(pdev);
>  	pci_set_drvdata(pdev, NULL);
>  	drm_dev_put(dev);
> @@ -1445,6 +1442,7 @@ static struct drm_driver kms_driver = {
>  	.dumb_create = amdgpu_mode_dumb_create,
>  	.dumb_map_offset = amdgpu_mode_dumb_mmap,
>  	.fops = &amdgpu_driver_kms_fops,
> +	.release = &amdgpu_driver_release_kms,
>  
>  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0cc4c67..1697655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -49,6 +49,7 @@
>  #include <drm/drm_irq.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>  #include "amdgpu.h"
>  #include "amdgpu_ih.h"
>  #include "atom.h"
> @@ -297,6 +298,20 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> +
> +void amdgpu_irq_fini_early(struct amdgpu_device *adev)
> +{
> +	if (adev->irq.installed) {
> +		drm_irq_uninstall(adev->ddev);
> +		adev->irq.installed = false;
> +		if (adev->irq.msi_enabled)
> +			pci_free_irq_vectors(adev->pdev);
> +
> +		if (!amdgpu_device_has_dc_support(adev))
> +			flush_work(&adev->hotplug_work);
> +	}
> +}
> +
>  /**
>   * amdgpu_irq_fini - shut down interrupt handling
>   *
> @@ -310,15 +325,6 @@ void amdgpu_irq_fini(struct amdgpu_device *adev)
>  {
>  	unsigned i, j;
>  
> -	if (adev->irq.installed) {
> -		drm_irq_uninstall(adev->ddev);
> -		adev->irq.installed = false;
> -		if (adev->irq.msi_enabled)
> -			pci_free_irq_vectors(adev->pdev);
> -		if (!amdgpu_device_has_dc_support(adev))
> -			flush_work(&adev->hotplug_work);
> -	}
> -
>  	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>  		if (!adev->irq.client[i].sources)
>  			continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index c718e94..718c70f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -104,6 +104,7 @@ irqreturn_t amdgpu_irq_handler(int irq, void *arg);
>  
>  int amdgpu_irq_init(struct amdgpu_device *adev);
>  void amdgpu_irq_fini(struct amdgpu_device *adev);
> +void amdgpu_irq_fini_early(struct amdgpu_device *adev);
>  int amdgpu_irq_add_id(struct amdgpu_device *adev,
>  		      unsigned client_id, unsigned src_id,
>  		      struct amdgpu_irq_src *source);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index c0b1904..9d0af22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -29,6 +29,7 @@
>  #include "amdgpu.h"
>  #include <drm/drm_debugfs.h>
>  #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>  #include "amdgpu_sched.h"
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
> @@ -86,7 +87,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>  	amdgpu_unregister_gpu_instance(adev);
>  
>  	if (adev->rmmio == NULL)
> -		goto done_free;
> +		return;
>  
>  	if (adev->runpm) {
>  		pm_runtime_get_sync(dev->dev);
> @@ -95,11 +96,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>  
>  	amdgpu_acpi_fini(adev);
>  
> -	amdgpu_device_fini(adev);
> -
> -done_free:
> -	kfree(adev);
> -	dev->dev_private = NULL;
> +	amdgpu_device_fini_early(adev);
>  }
>  
>  void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
> @@ -1108,6 +1105,20 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	pm_runtime_put_autosuspend(dev->dev);
>  }
>  
> +
> +void amdgpu_driver_release_kms (struct drm_device *dev)
> +{
> +	struct amdgpu_device *adev = dev->dev_private;
> +
> +	amdgpu_device_fini_late(adev);
> +
> +	kfree(adev);
> +	dev->dev_private = NULL;
> +
> +	drm_dev_fini(dev);
> +	kfree(dev);
> +}
> +
>  /*
>   * VBlank related functions.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7348619..169c2239 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2056,9 +2056,12 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  
> +	//DRM_ERROR("adev 0x%llx", (long long unsigned int)adev);
> +
>  	if (!con)
>  		return 0;
>  
> +
>  	/* Need disable ras on all IPs here before ip [hw/sw]fini */
>  	amdgpu_ras_disable_all_features(adev, 0);
>  	amdgpu_ras_recovery_fini(adev);
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

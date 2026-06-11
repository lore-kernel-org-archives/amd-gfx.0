Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E99ACD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 12:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0517510EF1E;
	Thu, 11 Jun 2026 12:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gqe/7H5T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C5810EEE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:43:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06F98417B1;
 Thu, 11 Jun 2026 12:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814E91F00893;
 Thu, 11 Jun 2026 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781181829;
 bh=NPrSrD1j2yFtK2gVaYsKcOA4lu5e5jslgPOr5aXG4kc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gqe/7H5T1y1IECnJXSak10Ck+0wj81nIqtJ3manK1BTw+LoTILGEPcid99Ee+V6I5
 yWiQWylKF2PqKT9H2dC8LeSBmhjLW+3pG6rg2zbL+6wuF91eC+ihfQ5DAlBAvLzUIQ
 y1MUbRQqWlmnmHStuT5g/RuqSeIoG0d8rJQGOskBpBFuQWrCvxMNtZamEe7McOYTBH
 L3kLAei5W1AXHybavxwpeFnQ/4Vp0aSaBWWYX7uDPxhPHz13eKopR7zrc0HgCl5ncT
 ozcV3KB5bHXb8rqCBMBS+3arU93H6LrPVso/3u9qHSIwY1UASFDQaHl+H2C0yPYTT0
 sSQ8Xg/uCc8rg==
Message-ID: <1735ff64-afe4-431f-84aa-044814328548@kernel.org>
Date: Thu, 11 Jun 2026 07:43:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: add AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU
 debug mask
Content-Language: en-US
To: Samuel Zhang <guoqing.zhang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: victor.zhao@amd.com, amd-gfx@lists.freedesktop.org
References: <20260611071907.1906171-1-guoqing.zhang@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260611071907.1906171-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 6/11/26 02:19, Samuel Zhang wrote:
> Kernel parameter `no_console_suspend` is required to capture all
> hibernation kernel log via serial console. But when the parameter
> is set, GPU will be resumed in thaw stage. This causes many issues
> on alinux3 kernel.
> 
> Fix: add new debug mask `AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU` to
> replace the check of `console_suspend_enabled` in thaw() callback.
> User can enable it using `amdgpu.debug_mask=0x800`.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5f775c6e9240..45bf05306c90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1136,6 +1136,7 @@ struct amdgpu_device {
>   	bool                            debug_vm_userptr;
>   	bool                            debug_disable_ce_logs;
>   	bool                            debug_enable_ce_cs;
> +	bool                            debug_hibernation_thaw_resume_gpu;
>   
>   	/* Protection for the following isolation structure */
>   	struct mutex                    enforce_isolation_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 503bb64c1e55..b4120207bfa0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -33,7 +33,6 @@
>   #include <drm/drm_vblank.h>
>   
>   #include <linux/cc_platform.h>
> -#include <linux/console.h>
>   #include <linux/dynamic_debug.h>
>   #include <linux/module.h>
>   #include <linux/mmu_notifier.h>
> @@ -146,7 +145,8 @@ enum AMDGPU_DEBUG_MASK {
>   	AMDGPU_DEBUG_SMU_POOL = BIT(7),
>   	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
>   	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9),
> -	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10)
> +	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10),
> +	AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),
>   };
>   
>   unsigned int amdgpu_vram_limit = UINT_MAX;
> @@ -2291,6 +2291,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
>   		pr_info("debug: allowing command submission to CE engine\n");
>   		adev->debug_enable_ce_cs = true;
>   	}
> +
> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU) {
> +		pr_info("debug: resume gpu in thaw() of hibernation\n");
> +		adev->debug_hibernation_thaw_resume_gpu = true;
> +	}
>   }
>   
>   static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
> @@ -2705,9 +2710,10 @@ static int amdgpu_pmops_freeze(struct device *dev)
>   static int amdgpu_pmops_thaw(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   
>   	/* do not resume device if it's normal hibernation */
> -	if (console_suspend_enabled &&
> +	if (!adev->debug_hibernation_thaw_resume_gpu &&
>   	    !pm_hibernate_is_recovering() &&
>   	    !pm_hibernation_mode_is_suspend())
>   		return 0;


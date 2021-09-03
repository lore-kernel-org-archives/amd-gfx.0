Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0C3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F035760F9C
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F035760F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E0B6E85C;
	Fri,  3 Sep 2021 08:36:29 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CFB6E85C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 08:36:28 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id b10so7130544wru.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Sep 2021 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=qgrF0oXILWi8zN/qYSWY8AzNVUiiJYp18TZhwrR8B7E=;
 b=GhQsOGTsnt48JurY2w2ZEVfP5plPkezpHzHso5tJw+0wK6NhUcA/THUFXuwjiNl47x
 2uR7lzOfGFAWreHbWUUD2aH7ugGj+uBnEcBA3w1JCND38YVN3KvA76KxN6miGvNh2SAM
 sjRGYtzC7YQjrINyc3Lw3okEX+2PqKQrr3589sOZvxiHLB8F8f34FQWKPOrQ8jRJvntS
 gq27qTXo4gGWjZclgZ02JVPtopiWqrqNf43FO2/pQXpee/QVLjZhWMDGiK+hlTQuSA0L
 GoJJ8Sb6e3FsAe2Ic79+VSfqTjuRUpBhvCqnpNgT+Fs7/dEoXNVNbVnjEBejqIoJxZkP
 3FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=qgrF0oXILWi8zN/qYSWY8AzNVUiiJYp18TZhwrR8B7E=;
 b=VlKiKOCjuzHZyegX729XU4BaQZAiGRaG51q2Rzo72Iog6q2KLOjyljScvPH8cz+wB5
 dDWeNhvYZKc5/XULvyxIFb1C4yUD4dJ2sYp2yBPn/v8XGlDjT3FAf0iQyMGxpRnas/B/
 8eosJ8eZN8bCd5AVAtqQYJWuRm3UOjdbV4mlVGx35J/IVY4b4gqxsqxM2vQeDADZ65XX
 uFoMBPI/1Wd9W9DjyUlKuwLpRMsoYQJadc2F7wYvxkiFpQ4QDNEa6JnXZ687AFhNsGl1
 XcMPW7ZEf12MKsJLIHEY5eq/2mKIF24MvE8swuxzk/XqKULMkfiXgISpxTaNCzuKL6un
 vdiA==
X-Gm-Message-State: AOAM530iD9fuxHieRL1X2m4SenLZXagJ2ke2Wta8ZFtl8v3qkZpKZsWG
 tBd81FIqwlTh5gPI1JBXO5zgWEQo6u81ch0/
X-Google-Smtp-Source: ABdhPJxz2+K0blrvGc13QMHIVDqZ4yyq2S8SLD4LzYY/qyN/yKgfLnzwOTWiRAWQlS2A2UCe8IHMVg==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id
 r13mr2700339wru.230.1630658186623; 
 Fri, 03 Sep 2021 01:36:26 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id f17sm4764134wrt.63.2021.09.03.01.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Sep 2021 01:36:26 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: use generic fb helpers instead of setting up
 AMD own's.
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Thomas Zimmermann <tzimmermann@suse.de>
References: <20210903063747.3606457-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8610b51c-7f60-d22d-d033-c01765dc5ce4@gmail.com>
Date: Fri, 3 Sep 2021 10:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903063747.3606457-1-evan.quan@amd.com>
Content-Type: multipart/alternative;
 boundary="------------EC0570301301BACAF916AA0A"
Content-Language: en-US
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

This is a multi-part message in MIME format.
--------------EC0570301301BACAF916AA0A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.09.21 um 08:37 schrieb Evan Quan:
> With the shadow buffer support from generic framebuffer emulation, it's
> possible now to have runpm kicked when no update for console.
>
> Change-Id: I285472c9100ee6f649d3f3f3548f402b9cd34eaf
> Signed-off-by: Evan Quan <evan.quan@amd.com>

That's a really nice cleanup, but somebody with a bit more background in 
the fb code should probably take a look as well.

So adding Thomas as well. On the other hand feel free to add an 
Acked-by: Christian König <christian.koenig@amd.com>.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  11 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  13 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      | 388 --------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  26 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  20 -
>   7 files changed, 48 insertions(+), 424 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 8d0748184a14..73a2151ee43f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -45,7 +45,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>   	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
>   	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
> -	amdgpu_fb.o amdgpu_gem.o amdgpu_ring.o \
> +	amdgpu_gem.o amdgpu_ring.o \
>   	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o amdgpu_test.o \
>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 682d459e992a..bcc308b7f826 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3695,8 +3695,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* Get a log2 for easy divisions. */
>   	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
>   
> -	amdgpu_fbdev_init(adev);
> -
>   	r = amdgpu_pm_sysfs_init(adev);
>   	if (r) {
>   		adev->pm_sysfs_en = false;
> @@ -3854,8 +3852,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		amdgpu_ucode_sysfs_fini(adev);
>   	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>   
> -	amdgpu_fbdev_fini(adev);
> -
>   	amdgpu_irq_fini_hw(adev);
>   
>   	amdgpu_device_ip_fini_early(adev);
> @@ -3931,7 +3927,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	drm_kms_helper_poll_disable(dev);
>   
>   	if (fbcon)
> -		amdgpu_fbdev_set_suspend(adev, 1);
> +		_drm_fb_helper_set_suspend_unlocked_(adev_to_drm(adev)->fb_helper, true);
>   
>   	cancel_delayed_work_sync(&adev->delayed_init_work);
>   
> @@ -4009,7 +4005,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	flush_delayed_work(&adev->delayed_init_work);
>   
>   	if (fbcon)
> -		amdgpu_fbdev_set_suspend(adev, 0);
> +		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
>   
>   	drm_kms_helper_poll_enable(dev);
>   
> @@ -4638,7 +4634,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				if (r)
>   					goto out;
>   
> -				amdgpu_fbdev_set_suspend(tmp_adev, 0);
> +				drm_fb_helper_set_suspend_unlocked(adev_to_drm(tmp_adev)->fb_helper, false);
>   
>   				/*
>   				 * The GPU enters bad state once faulty pages
> @@ -5025,7 +5021,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		 */
>   		amdgpu_unregister_gpu_instance(tmp_adev);
>   
> -		amdgpu_fbdev_set_suspend(tmp_adev, 1);
> +		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
>   
>   		/* disable ras on ALL IPs */
>   		if (!need_emergency_restart &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 7a7316731911..58bfc7f00d76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1572,13 +1572,10 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
>   			continue;
>   		}
>   		robj = gem_to_amdgpu_bo(fb->obj[0]);
> -		/* don't unpin kernel fb objects */
> -		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
> -			r = amdgpu_bo_reserve(robj, true);
> -			if (r == 0) {
> -				amdgpu_bo_unpin(robj);
> -				amdgpu_bo_unreserve(robj);
> -			}
> +		r = amdgpu_bo_reserve(robj, true);
> +		if (r == 0) {
> +			amdgpu_bo_unpin(robj);
> +			amdgpu_bo_unreserve(robj);
>   		}
>   	}
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 987482c26b1a..db21af5e84ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1348,6 +1348,19 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   		goto err_pci;
>   	}
>   
> +	/*
> +	 * 1. don't init fbdev on hw without DCE
> +	 * 2. don't init fbdev if there are no connectors
> +	 */
> +	if (adev->mode_info.mode_config_initialized &&
> +	    !list_empty(&adev_to_drm(adev)->mode_config.connector_list)) {
> +		/* select 8 bpp console on low vram cards */
> +		if (adev->gmc.real_vram_size <= (32*1024*1024))
> +			drm_fbdev_generic_setup(adev_to_drm(adev), 8);
> +		else
> +			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
> +	}
> +
>   	ret = amdgpu_debugfs_init(adev);
>   	if (ret)
>   		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> deleted file mode 100644
> index cd0acbea75da..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ /dev/null
> @@ -1,388 +0,0 @@
> -/*
> - * Copyright © 2007 David Airlie
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice (including the next
> - * paragraph) shall be included in all copies or substantial portions of the
> - * Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> - * DEALINGS IN THE SOFTWARE.
> - *
> - * Authors:
> - *     David Airlie
> - */
> -
> -#include <linux/module.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/slab.h>
> -#include <linux/vga_switcheroo.h>
> -
> -#include <drm/amdgpu_drm.h>
> -#include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>
> -#include <drm/drm_fb_helper.h>
> -#include <drm/drm_fourcc.h>
> -
> -#include "amdgpu.h"
> -#include "cikd.h"
> -#include "amdgpu_gem.h"
> -
> -#include "amdgpu_display.h"
> -
> -/* object hierarchy -
> -   this contains a helper + a amdgpu fb
> -   the helper contains a pointer to amdgpu framebuffer baseclass.
> -*/
> -
> -static int
> -amdgpufb_open(struct fb_info *info, int user)
> -{
> -	struct drm_fb_helper *fb_helper = info->par;
> -	int ret = pm_runtime_get_sync(fb_helper->dev->dev);
> -	if (ret < 0 && ret != -EACCES) {
> -		pm_runtime_mark_last_busy(fb_helper->dev->dev);
> -		pm_runtime_put_autosuspend(fb_helper->dev->dev);
> -		return ret;
> -	}
> -	return 0;
> -}
> -
> -static int
> -amdgpufb_release(struct fb_info *info, int user)
> -{
> -	struct drm_fb_helper *fb_helper = info->par;
> -
> -	pm_runtime_mark_last_busy(fb_helper->dev->dev);
> -	pm_runtime_put_autosuspend(fb_helper->dev->dev);
> -	return 0;
> -}
> -
> -static const struct fb_ops amdgpufb_ops = {
> -	.owner = THIS_MODULE,
> -	DRM_FB_HELPER_DEFAULT_OPS,
> -	.fb_open = amdgpufb_open,
> -	.fb_release = amdgpufb_release,
> -	.fb_fillrect = drm_fb_helper_cfb_fillrect,
> -	.fb_copyarea = drm_fb_helper_cfb_copyarea,
> -	.fb_imageblit = drm_fb_helper_cfb_imageblit,
> -};
> -
> -
> -int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int cpp, bool tiled)
> -{
> -	int aligned = width;
> -	int pitch_mask = 0;
> -
> -	switch (cpp) {
> -	case 1:
> -		pitch_mask = 255;
> -		break;
> -	case 2:
> -		pitch_mask = 127;
> -		break;
> -	case 3:
> -	case 4:
> -		pitch_mask = 63;
> -		break;
> -	}
> -
> -	aligned += pitch_mask;
> -	aligned &= ~pitch_mask;
> -	return aligned * cpp;
> -}
> -
> -static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
> -{
> -	struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
> -	int ret;
> -
> -	ret = amdgpu_bo_reserve(abo, true);
> -	if (likely(ret == 0)) {
> -		amdgpu_bo_kunmap(abo);
> -		amdgpu_bo_unpin(abo);
> -		amdgpu_bo_unreserve(abo);
> -	}
> -	drm_gem_object_put(gobj);
> -}
> -
> -static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
> -					 struct drm_mode_fb_cmd2 *mode_cmd,
> -					 struct drm_gem_object **gobj_p)
> -{
> -	const struct drm_format_info *info;
> -	struct amdgpu_device *adev = rfbdev->adev;
> -	struct drm_gem_object *gobj = NULL;
> -	struct amdgpu_bo *abo = NULL;
> -	bool fb_tiled = false; /* useful for testing */
> -	u32 tiling_flags = 0, domain;
> -	int ret;
> -	int aligned_size, size;
> -	int height = mode_cmd->height;
> -	u32 cpp;
> -	u64 flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -			       AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS     |
> -			       AMDGPU_GEM_CREATE_VRAM_CLEARED;
> -
> -	info = drm_get_format_info(adev_to_drm(adev), mode_cmd);
> -	cpp = info->cpp[0];
> -
> -	/* need to align pitch with crtc limits */
> -	mode_cmd->pitches[0] = amdgpu_align_pitch(adev, mode_cmd->width, cpp,
> -						  fb_tiled);
> -	domain = amdgpu_display_supported_domains(adev, flags);
> -	height = ALIGN(mode_cmd->height, 8);
> -	size = mode_cmd->pitches[0] * height;
> -	aligned_size = ALIGN(size, PAGE_SIZE);
> -	ret = amdgpu_gem_object_create(adev, aligned_size, 0, domain, flags,
> -				       ttm_bo_type_device, NULL, &gobj);
> -	if (ret) {
> -		pr_err("failed to allocate framebuffer (%d)\n", aligned_size);
> -		return -ENOMEM;
> -	}
> -	abo = gem_to_amdgpu_bo(gobj);
> -
> -	if (fb_tiled)
> -		tiling_flags = AMDGPU_TILING_SET(ARRAY_MODE, GRPH_ARRAY_2D_TILED_THIN1);
> -
> -	ret = amdgpu_bo_reserve(abo, false);
> -	if (unlikely(ret != 0))
> -		goto out_unref;
> -
> -	if (tiling_flags) {
> -		ret = amdgpu_bo_set_tiling_flags(abo,
> -						 tiling_flags);
> -		if (ret)
> -			dev_err(adev->dev, "FB failed to set tiling flags\n");
> -	}
> -
> -	ret = amdgpu_bo_pin(abo, domain);
> -	if (ret) {
> -		amdgpu_bo_unreserve(abo);
> -		goto out_unref;
> -	}
> -
> -	ret = amdgpu_ttm_alloc_gart(&abo->tbo);
> -	if (ret) {
> -		amdgpu_bo_unreserve(abo);
> -		dev_err(adev->dev, "%p bind failed\n", abo);
> -		goto out_unref;
> -	}
> -
> -	ret = amdgpu_bo_kmap(abo, NULL);
> -	amdgpu_bo_unreserve(abo);
> -	if (ret) {
> -		goto out_unref;
> -	}
> -
> -	*gobj_p = gobj;
> -	return 0;
> -out_unref:
> -	amdgpufb_destroy_pinned_object(gobj);
> -	*gobj_p = NULL;
> -	return ret;
> -}
> -
> -static int amdgpufb_create(struct drm_fb_helper *helper,
> -			   struct drm_fb_helper_surface_size *sizes)
> -{
> -	struct amdgpu_fbdev *rfbdev = (struct amdgpu_fbdev *)helper;
> -	struct amdgpu_device *adev = rfbdev->adev;
> -	struct fb_info *info;
> -	struct drm_framebuffer *fb = NULL;
> -	struct drm_mode_fb_cmd2 mode_cmd;
> -	struct drm_gem_object *gobj = NULL;
> -	struct amdgpu_bo *abo = NULL;
> -	int ret;
> -
> -	memset(&mode_cmd, 0, sizeof(mode_cmd));
> -	mode_cmd.width = sizes->surface_width;
> -	mode_cmd.height = sizes->surface_height;
> -
> -	if (sizes->surface_bpp == 24)
> -		sizes->surface_bpp = 32;
> -
> -	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
> -							  sizes->surface_depth);
> -
> -	ret = amdgpufb_create_pinned_object(rfbdev, &mode_cmd, &gobj);
> -	if (ret) {
> -		DRM_ERROR("failed to create fbcon object %d\n", ret);
> -		return ret;
> -	}
> -
> -	abo = gem_to_amdgpu_bo(gobj);
> -
> -	/* okay we have an object now allocate the framebuffer */
> -	info = drm_fb_helper_alloc_fbi(helper);
> -	if (IS_ERR(info)) {
> -		ret = PTR_ERR(info);
> -		goto out;
> -	}
> -
> -	ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &rfbdev->rfb,
> -					 &mode_cmd, gobj);
> -	if (ret) {
> -		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
> -		goto out;
> -	}
> -
> -	fb = &rfbdev->rfb.base;
> -
> -	/* setup helper */
> -	rfbdev->helper.fb = fb;
> -
> -	info->fbops = &amdgpufb_ops;
> -
> -	info->fix.smem_start = amdgpu_gmc_vram_cpu_pa(adev, abo);
> -	info->fix.smem_len = amdgpu_bo_size(abo);
> -	info->screen_base = amdgpu_bo_kptr(abo);
> -	info->screen_size = amdgpu_bo_size(abo);
> -
> -	drm_fb_helper_fill_info(info, &rfbdev->helper, sizes);
> -
> -	/* setup aperture base/size for vesafb takeover */
> -	info->apertures->ranges[0].base = adev_to_drm(adev)->mode_config.fb_base;
> -	info->apertures->ranges[0].size = adev->gmc.aper_size;
> -
> -	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
> -
> -	if (info->screen_base == NULL) {
> -		ret = -ENOSPC;
> -		goto out;
> -	}
> -
> -	DRM_INFO("fb mappable at 0x%lX\n",  info->fix.smem_start);
> -	DRM_INFO("vram apper at 0x%lX\n",  (unsigned long)adev->gmc.aper_base);
> -	DRM_INFO("size %lu\n", (unsigned long)amdgpu_bo_size(abo));
> -	DRM_INFO("fb depth is %d\n", fb->format->depth);
> -	DRM_INFO("   pitch is %d\n", fb->pitches[0]);
> -
> -	vga_switcheroo_client_fb_set(adev->pdev, info);
> -	return 0;
> -
> -out:
> -	if (fb && ret) {
> -		drm_gem_object_put(gobj);
> -		drm_framebuffer_unregister_private(fb);
> -		drm_framebuffer_cleanup(fb);
> -		kfree(fb);
> -	}
> -	return ret;
> -}
> -
> -static int amdgpu_fbdev_destroy(struct drm_device *dev, struct amdgpu_fbdev *rfbdev)
> -{
> -	struct amdgpu_framebuffer *rfb = &rfbdev->rfb;
> -	int i;
> -
> -	drm_fb_helper_unregister_fbi(&rfbdev->helper);
> -
> -	if (rfb->base.obj[0]) {
> -		for (i = 0; i < rfb->base.format->num_planes; i++)
> -			drm_gem_object_put(rfb->base.obj[0]);
> -		amdgpufb_destroy_pinned_object(rfb->base.obj[0]);
> -		rfb->base.obj[0] = NULL;
> -		drm_framebuffer_unregister_private(&rfb->base);
> -		drm_framebuffer_cleanup(&rfb->base);
> -	}
> -	drm_fb_helper_fini(&rfbdev->helper);
> -
> -	return 0;
> -}
> -
> -static const struct drm_fb_helper_funcs amdgpu_fb_helper_funcs = {
> -	.fb_probe = amdgpufb_create,
> -};
> -
> -int amdgpu_fbdev_init(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_fbdev *rfbdev;
> -	int bpp_sel = 32;
> -	int ret;
> -
> -	/* don't init fbdev on hw without DCE */
> -	if (!adev->mode_info.mode_config_initialized)
> -		return 0;
> -
> -	/* don't init fbdev if there are no connectors */
> -	if (list_empty(&adev_to_drm(adev)->mode_config.connector_list))
> -		return 0;
> -
> -	/* select 8 bpp console on low vram cards */
> -	if (adev->gmc.real_vram_size <= (32*1024*1024))
> -		bpp_sel = 8;
> -
> -	rfbdev = kzalloc(sizeof(struct amdgpu_fbdev), GFP_KERNEL);
> -	if (!rfbdev)
> -		return -ENOMEM;
> -
> -	rfbdev->adev = adev;
> -	adev->mode_info.rfbdev = rfbdev;
> -
> -	drm_fb_helper_prepare(adev_to_drm(adev), &rfbdev->helper,
> -			      &amdgpu_fb_helper_funcs);
> -
> -	ret = drm_fb_helper_init(adev_to_drm(adev), &rfbdev->helper);
> -	if (ret) {
> -		kfree(rfbdev);
> -		return ret;
> -	}
> -
> -	/* disable all the possible outputs/crtcs before entering KMS mode */
> -	if (!amdgpu_device_has_dc_support(adev) && !amdgpu_virtual_display)
> -		drm_helper_disable_unused_functions(adev_to_drm(adev));
> -
> -	drm_fb_helper_initial_config(&rfbdev->helper, bpp_sel);
> -	return 0;
> -}
> -
> -void amdgpu_fbdev_fini(struct amdgpu_device *adev)
> -{
> -	if (!adev->mode_info.rfbdev)
> -		return;
> -
> -	amdgpu_fbdev_destroy(adev_to_drm(adev), adev->mode_info.rfbdev);
> -	kfree(adev->mode_info.rfbdev);
> -	adev->mode_info.rfbdev = NULL;
> -}
> -
> -void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state)
> -{
> -	if (adev->mode_info.rfbdev)
> -		drm_fb_helper_set_suspend_unlocked(&adev->mode_info.rfbdev->helper,
> -						   state);
> -}
> -
> -int amdgpu_fbdev_total_size(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_bo *robj;
> -	int size = 0;
> -
> -	if (!adev->mode_info.rfbdev)
> -		return 0;
> -
> -	robj = gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.base.obj[0]);
> -	size += amdgpu_bo_size(robj);
> -	return size;
> -}
> -
> -bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
> -{
> -	if (!adev->mode_info.rfbdev)
> -		return false;
> -	if (robj == gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.base.obj[0]))
> -		return true;
> -	return false;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 9e2525b96d04..ec57c7365e32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -876,6 +876,32 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +static int amdgpu_align_pitch(struct amdgpu_device *adev,
> +			      int width,
> +			      int cpp,
> +			      bool tiled)
> +{
> +	int aligned = width;
> +	int pitch_mask = 0;
> +
> +	switch (cpp) {
> +	case 1:
> +		pitch_mask = 255;
> +		break;
> +	case 2:
> +		pitch_mask = 127;
> +		break;
> +	case 3:
> +	case 4:
> +		pitch_mask = 63;
> +		break;
> +	}
> +
> +	aligned += pitch_mask;
> +	aligned &= ~pitch_mask;
> +	return aligned * cpp;
> +}
> +
>   int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>   			    struct drm_device *dev,
>   			    struct drm_mode_create_dumb *args)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 89fb372ed49c..6043bf6fd414 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -232,8 +232,6 @@ struct amdgpu_i2c_chan {
>   	struct mutex mutex;
>   };
>   
> -struct amdgpu_fbdev;
> -
>   struct amdgpu_afmt {
>   	bool enabled;
>   	int offset;
> @@ -309,13 +307,6 @@ struct amdgpu_framebuffer {
>   	uint64_t address;
>   };
>   
> -struct amdgpu_fbdev {
> -	struct drm_fb_helper helper;
> -	struct amdgpu_framebuffer rfb;
> -	struct list_head fbdev_list;
> -	struct amdgpu_device *adev;
> -};
> -
>   struct amdgpu_mode_info {
>   	struct atom_context *atom_context;
>   	struct card_info *atom_card_info;
> @@ -341,8 +332,6 @@ struct amdgpu_mode_info {
>   	struct edid *bios_hardcoded_edid;
>   	int bios_hardcoded_edid_size;
>   
> -	/* pointer to fbdev info structure */
> -	struct amdgpu_fbdev *rfbdev;
>   	/* firmware flags */
>   	u32 firmware_flags;
>   	/* pointer to backlight encoder */
> @@ -631,15 +620,6 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
>   			int *hpos, ktime_t *stime, ktime_t *etime,
>   			const struct drm_display_mode *mode);
>   
> -/* fbdev layer */
> -int amdgpu_fbdev_init(struct amdgpu_device *adev);
> -void amdgpu_fbdev_fini(struct amdgpu_device *adev);
> -void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state);
> -int amdgpu_fbdev_total_size(struct amdgpu_device *adev);
> -bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj);
> -
> -int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int bpp, bool tiled);
> -
>   /* amdgpu_display.c */
>   void amdgpu_display_print_display_setup(struct drm_device *dev);
>   int amdgpu_display_modeset_create_props(struct amdgpu_device *adev);


--------------EC0570301301BACAF916AA0A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 03.09.21 um 08:37 schrieb Evan Quan:<br>
    <blockquote type="cite"
      cite="mid:20210903063747.3606457-1-evan.quan@amd.com">
      <pre class="moz-quote-pre" wrap="">With the shadow buffer support from generic framebuffer emulation, it's
possible now to have runpm kicked when no update for console.

Change-Id: I285472c9100ee6f649d3f3f3548f402b9cd34eaf
Signed-off-by: Evan Quan <a class="moz-txt-link-rfc2396E" href="mailto:evan.quan@amd.com">&lt;evan.quan@amd.com&gt;</a></pre>
    </blockquote>
    <br>
    That's a really nice cleanup, but somebody with a bit more
    background in the fb code should probably take a look as well.<br>
    <br>
    So adding Thomas as well. On the other hand feel free to add an
    Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20210903063747.3606457-1-evan.quan@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      | 388 --------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  26 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  20 -
 7 files changed, 48 insertions(+), 424 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8d0748184a14..73a2151ee43f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -45,7 +45,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
-	amdgpu_fb.o amdgpu_gem.o amdgpu_ring.o \
+	amdgpu_gem.o amdgpu_ring.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o amdgpu_test.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 682d459e992a..bcc308b7f826 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3695,8 +3695,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Get a log2 for easy divisions. */
 	adev-&gt;mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
-	amdgpu_fbdev_init(adev);
-
 	r = amdgpu_pm_sysfs_init(adev);
 	if (r) {
 		adev-&gt;pm_sysfs_en = false;
@@ -3854,8 +3852,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_ucode_sysfs_fini(adev);
 	sysfs_remove_files(&amp;adev-&gt;dev-&gt;kobj, amdgpu_dev_attributes);
 
-	amdgpu_fbdev_fini(adev);
-
 	amdgpu_irq_fini_hw(adev);
 
 	amdgpu_device_ip_fini_early(adev);
@@ -3931,7 +3927,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	drm_kms_helper_poll_disable(dev);
 
 	if (fbcon)
-		amdgpu_fbdev_set_suspend(adev, 1);
+		<u>drm_fb_helper_set_suspend_unlocked</u>(adev_to_drm(adev)-&gt;fb_helper, true);
 
 	cancel_delayed_work_sync(&amp;adev-&gt;delayed_init_work);
 
@@ -4009,7 +4005,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	flush_delayed_work(&amp;adev-&gt;delayed_init_work);
 
 	if (fbcon)
-		amdgpu_fbdev_set_suspend(adev, 0);
+		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-&gt;fb_helper, false);
 
 	drm_kms_helper_poll_enable(dev);
 
@@ -4638,7 +4634,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					goto out;
 
-				amdgpu_fbdev_set_suspend(tmp_adev, 0);
+				drm_fb_helper_set_suspend_unlocked(adev_to_drm(tmp_adev)-&gt;fb_helper, false);
 
 				/*
 				 * The GPU enters bad state once faulty pages
@@ -5025,7 +5021,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
-		amdgpu_fbdev_set_suspend(tmp_adev, 1);
+		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-&gt;fb_helper, true);
 
 		/* disable ras on ALL IPs */
 		if (!need_emergency_restart &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 7a7316731911..58bfc7f00d76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1572,13 +1572,10 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			continue;
 		}
 		robj = gem_to_amdgpu_bo(fb-&gt;obj[0]);
-		/* don't unpin kernel fb objects */
-		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
-			r = amdgpu_bo_reserve(robj, true);
-			if (r == 0) {
-				amdgpu_bo_unpin(robj);
-				amdgpu_bo_unreserve(robj);
-			}
+		r = amdgpu_bo_reserve(robj, true);
+		if (r == 0) {
+			amdgpu_bo_unpin(robj);
+			amdgpu_bo_unreserve(robj);
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 987482c26b1a..db21af5e84ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1348,6 +1348,19 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		goto err_pci;
 	}
 
+	/*
+	 * 1. don't init fbdev on hw without DCE
+	 * 2. don't init fbdev if there are no connectors
+	 */
+	if (adev-&gt;mode_info.mode_config_initialized &amp;&amp;
+	    !list_empty(&amp;adev_to_drm(adev)-&gt;mode_config.connector_list)) {
+		/* select 8 bpp console on low vram cards */
+		if (adev-&gt;gmc.real_vram_size &lt;= (32*1024*1024))
+			drm_fbdev_generic_setup(adev_to_drm(adev), 8);
+		else
+			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
+	}
+
 	ret = amdgpu_debugfs_init(adev);
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
deleted file mode 100644
index cd0acbea75da..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ /dev/null
@@ -1,388 +0,0 @@
-/*
- * Copyright © 2007 David Airlie
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
- *
- * Authors:
- *     David Airlie
- */
-
-#include &lt;linux/module.h&gt;
-#include &lt;linux/pm_runtime.h&gt;
-#include &lt;linux/slab.h&gt;
-#include &lt;linux/vga_switcheroo.h&gt;
-
-#include &lt;drm/amdgpu_drm.h&gt;
-#include &lt;drm/drm_crtc.h&gt;
-#include &lt;drm/drm_crtc_helper.h&gt;
-#include &lt;drm/drm_fb_helper.h&gt;
-#include &lt;drm/drm_fourcc.h&gt;
-
-#include "amdgpu.h"
-#include "cikd.h"
-#include "amdgpu_gem.h"
-
-#include "amdgpu_display.h"
-
-/* object hierarchy -
-   this contains a helper + a amdgpu fb
-   the helper contains a pointer to amdgpu framebuffer baseclass.
-*/
-
-static int
-amdgpufb_open(struct fb_info *info, int user)
-{
-	struct drm_fb_helper *fb_helper = info-&gt;par;
-	int ret = pm_runtime_get_sync(fb_helper-&gt;dev-&gt;dev);
-	if (ret &lt; 0 &amp;&amp; ret != -EACCES) {
-		pm_runtime_mark_last_busy(fb_helper-&gt;dev-&gt;dev);
-		pm_runtime_put_autosuspend(fb_helper-&gt;dev-&gt;dev);
-		return ret;
-	}
-	return 0;
-}
-
-static int
-amdgpufb_release(struct fb_info *info, int user)
-{
-	struct drm_fb_helper *fb_helper = info-&gt;par;
-
-	pm_runtime_mark_last_busy(fb_helper-&gt;dev-&gt;dev);
-	pm_runtime_put_autosuspend(fb_helper-&gt;dev-&gt;dev);
-	return 0;
-}
-
-static const struct fb_ops amdgpufb_ops = {
-	.owner = THIS_MODULE,
-	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_open = amdgpufb_open,
-	.fb_release = amdgpufb_release,
-	.fb_fillrect = drm_fb_helper_cfb_fillrect,
-	.fb_copyarea = drm_fb_helper_cfb_copyarea,
-	.fb_imageblit = drm_fb_helper_cfb_imageblit,
-};
-
-
-int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int cpp, bool tiled)
-{
-	int aligned = width;
-	int pitch_mask = 0;
-
-	switch (cpp) {
-	case 1:
-		pitch_mask = 255;
-		break;
-	case 2:
-		pitch_mask = 127;
-		break;
-	case 3:
-	case 4:
-		pitch_mask = 63;
-		break;
-	}
-
-	aligned += pitch_mask;
-	aligned &amp;= ~pitch_mask;
-	return aligned * cpp;
-}
-
-static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
-{
-	struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
-	int ret;
-
-	ret = amdgpu_bo_reserve(abo, true);
-	if (likely(ret == 0)) {
-		amdgpu_bo_kunmap(abo);
-		amdgpu_bo_unpin(abo);
-		amdgpu_bo_unreserve(abo);
-	}
-	drm_gem_object_put(gobj);
-}
-
-static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
-					 struct drm_mode_fb_cmd2 *mode_cmd,
-					 struct drm_gem_object **gobj_p)
-{
-	const struct drm_format_info *info;
-	struct amdgpu_device *adev = rfbdev-&gt;adev;
-	struct drm_gem_object *gobj = NULL;
-	struct amdgpu_bo *abo = NULL;
-	bool fb_tiled = false; /* useful for testing */
-	u32 tiling_flags = 0, domain;
-	int ret;
-	int aligned_size, size;
-	int height = mode_cmd-&gt;height;
-	u32 cpp;
-	u64 flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-			       AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS     |
-			       AMDGPU_GEM_CREATE_VRAM_CLEARED;
-
-	info = drm_get_format_info(adev_to_drm(adev), mode_cmd);
-	cpp = info-&gt;cpp[0];
-
-	/* need to align pitch with crtc limits */
-	mode_cmd-&gt;pitches[0] = amdgpu_align_pitch(adev, mode_cmd-&gt;width, cpp,
-						  fb_tiled);
-	domain = amdgpu_display_supported_domains(adev, flags);
-	height = ALIGN(mode_cmd-&gt;height, 8);
-	size = mode_cmd-&gt;pitches[0] * height;
-	aligned_size = ALIGN(size, PAGE_SIZE);
-	ret = amdgpu_gem_object_create(adev, aligned_size, 0, domain, flags,
-				       ttm_bo_type_device, NULL, &amp;gobj);
-	if (ret) {
-		pr_err("failed to allocate framebuffer (%d)\n", aligned_size);
-		return -ENOMEM;
-	}
-	abo = gem_to_amdgpu_bo(gobj);
-
-	if (fb_tiled)
-		tiling_flags = AMDGPU_TILING_SET(ARRAY_MODE, GRPH_ARRAY_2D_TILED_THIN1);
-
-	ret = amdgpu_bo_reserve(abo, false);
-	if (unlikely(ret != 0))
-		goto out_unref;
-
-	if (tiling_flags) {
-		ret = amdgpu_bo_set_tiling_flags(abo,
-						 tiling_flags);
-		if (ret)
-			dev_err(adev-&gt;dev, "FB failed to set tiling flags\n");
-	}
-
-	ret = amdgpu_bo_pin(abo, domain);
-	if (ret) {
-		amdgpu_bo_unreserve(abo);
-		goto out_unref;
-	}
-
-	ret = amdgpu_ttm_alloc_gart(&amp;abo-&gt;tbo);
-	if (ret) {
-		amdgpu_bo_unreserve(abo);
-		dev_err(adev-&gt;dev, "%p bind failed\n", abo);
-		goto out_unref;
-	}
-
-	ret = amdgpu_bo_kmap(abo, NULL);
-	amdgpu_bo_unreserve(abo);
-	if (ret) {
-		goto out_unref;
-	}
-
-	*gobj_p = gobj;
-	return 0;
-out_unref:
-	amdgpufb_destroy_pinned_object(gobj);
-	*gobj_p = NULL;
-	return ret;
-}
-
-static int amdgpufb_create(struct drm_fb_helper *helper,
-			   struct drm_fb_helper_surface_size *sizes)
-{
-	struct amdgpu_fbdev *rfbdev = (struct amdgpu_fbdev *)helper;
-	struct amdgpu_device *adev = rfbdev-&gt;adev;
-	struct fb_info *info;
-	struct drm_framebuffer *fb = NULL;
-	struct drm_mode_fb_cmd2 mode_cmd;
-	struct drm_gem_object *gobj = NULL;
-	struct amdgpu_bo *abo = NULL;
-	int ret;
-
-	memset(&amp;mode_cmd, 0, sizeof(mode_cmd));
-	mode_cmd.width = sizes-&gt;surface_width;
-	mode_cmd.height = sizes-&gt;surface_height;
-
-	if (sizes-&gt;surface_bpp == 24)
-		sizes-&gt;surface_bpp = 32;
-
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes-&gt;surface_bpp,
-							  sizes-&gt;surface_depth);
-
-	ret = amdgpufb_create_pinned_object(rfbdev, &amp;mode_cmd, &amp;gobj);
-	if (ret) {
-		DRM_ERROR("failed to create fbcon object %d\n", ret);
-		return ret;
-	}
-
-	abo = gem_to_amdgpu_bo(gobj);
-
-	/* okay we have an object now allocate the framebuffer */
-	info = drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info)) {
-		ret = PTR_ERR(info);
-		goto out;
-	}
-
-	ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &amp;rfbdev-&gt;rfb,
-					 &amp;mode_cmd, gobj);
-	if (ret) {
-		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
-		goto out;
-	}
-
-	fb = &amp;rfbdev-&gt;rfb.base;
-
-	/* setup helper */
-	rfbdev-&gt;helper.fb = fb;
-
-	info-&gt;fbops = &amp;amdgpufb_ops;
-
-	info-&gt;fix.smem_start = amdgpu_gmc_vram_cpu_pa(adev, abo);
-	info-&gt;fix.smem_len = amdgpu_bo_size(abo);
-	info-&gt;screen_base = amdgpu_bo_kptr(abo);
-	info-&gt;screen_size = amdgpu_bo_size(abo);
-
-	drm_fb_helper_fill_info(info, &amp;rfbdev-&gt;helper, sizes);
-
-	/* setup aperture base/size for vesafb takeover */
-	info-&gt;apertures-&gt;ranges[0].base = adev_to_drm(adev)-&gt;mode_config.fb_base;
-	info-&gt;apertures-&gt;ranges[0].size = adev-&gt;gmc.aper_size;
-
-	/* Use default scratch pixmap (info-&gt;pixmap.flags = FB_PIXMAP_SYSTEM) */
-
-	if (info-&gt;screen_base == NULL) {
-		ret = -ENOSPC;
-		goto out;
-	}
-
-	DRM_INFO("fb mappable at 0x%lX\n",  info-&gt;fix.smem_start);
-	DRM_INFO("vram apper at 0x%lX\n",  (unsigned long)adev-&gt;gmc.aper_base);
-	DRM_INFO("size %lu\n", (unsigned long)amdgpu_bo_size(abo));
-	DRM_INFO("fb depth is %d\n", fb-&gt;format-&gt;depth);
-	DRM_INFO("   pitch is %d\n", fb-&gt;pitches[0]);
-
-	vga_switcheroo_client_fb_set(adev-&gt;pdev, info);
-	return 0;
-
-out:
-	if (fb &amp;&amp; ret) {
-		drm_gem_object_put(gobj);
-		drm_framebuffer_unregister_private(fb);
-		drm_framebuffer_cleanup(fb);
-		kfree(fb);
-	}
-	return ret;
-}
-
-static int amdgpu_fbdev_destroy(struct drm_device *dev, struct amdgpu_fbdev *rfbdev)
-{
-	struct amdgpu_framebuffer *rfb = &amp;rfbdev-&gt;rfb;
-	int i;
-
-	drm_fb_helper_unregister_fbi(&amp;rfbdev-&gt;helper);
-
-	if (rfb-&gt;base.obj[0]) {
-		for (i = 0; i &lt; rfb-&gt;base.format-&gt;num_planes; i++)
-			drm_gem_object_put(rfb-&gt;base.obj[0]);
-		amdgpufb_destroy_pinned_object(rfb-&gt;base.obj[0]);
-		rfb-&gt;base.obj[0] = NULL;
-		drm_framebuffer_unregister_private(&amp;rfb-&gt;base);
-		drm_framebuffer_cleanup(&amp;rfb-&gt;base);
-	}
-	drm_fb_helper_fini(&amp;rfbdev-&gt;helper);
-
-	return 0;
-}
-
-static const struct drm_fb_helper_funcs amdgpu_fb_helper_funcs = {
-	.fb_probe = amdgpufb_create,
-};
-
-int amdgpu_fbdev_init(struct amdgpu_device *adev)
-{
-	struct amdgpu_fbdev *rfbdev;
-	int bpp_sel = 32;
-	int ret;
-
-	/* don't init fbdev on hw without DCE */
-	if (!adev-&gt;mode_info.mode_config_initialized)
-		return 0;
-
-	/* don't init fbdev if there are no connectors */
-	if (list_empty(&amp;adev_to_drm(adev)-&gt;mode_config.connector_list))
-		return 0;
-
-	/* select 8 bpp console on low vram cards */
-	if (adev-&gt;gmc.real_vram_size &lt;= (32*1024*1024))
-		bpp_sel = 8;
-
-	rfbdev = kzalloc(sizeof(struct amdgpu_fbdev), GFP_KERNEL);
-	if (!rfbdev)
-		return -ENOMEM;
-
-	rfbdev-&gt;adev = adev;
-	adev-&gt;mode_info.rfbdev = rfbdev;
-
-	drm_fb_helper_prepare(adev_to_drm(adev), &amp;rfbdev-&gt;helper,
-			      &amp;amdgpu_fb_helper_funcs);
-
-	ret = drm_fb_helper_init(adev_to_drm(adev), &amp;rfbdev-&gt;helper);
-	if (ret) {
-		kfree(rfbdev);
-		return ret;
-	}
-
-	/* disable all the possible outputs/crtcs before entering KMS mode */
-	if (!amdgpu_device_has_dc_support(adev) &amp;&amp; !amdgpu_virtual_display)
-		drm_helper_disable_unused_functions(adev_to_drm(adev));
-
-	drm_fb_helper_initial_config(&amp;rfbdev-&gt;helper, bpp_sel);
-	return 0;
-}
-
-void amdgpu_fbdev_fini(struct amdgpu_device *adev)
-{
-	if (!adev-&gt;mode_info.rfbdev)
-		return;
-
-	amdgpu_fbdev_destroy(adev_to_drm(adev), adev-&gt;mode_info.rfbdev);
-	kfree(adev-&gt;mode_info.rfbdev);
-	adev-&gt;mode_info.rfbdev = NULL;
-}
-
-void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state)
-{
-	if (adev-&gt;mode_info.rfbdev)
-		drm_fb_helper_set_suspend_unlocked(&amp;adev-&gt;mode_info.rfbdev-&gt;helper,
-						   state);
-}
-
-int amdgpu_fbdev_total_size(struct amdgpu_device *adev)
-{
-	struct amdgpu_bo *robj;
-	int size = 0;
-
-	if (!adev-&gt;mode_info.rfbdev)
-		return 0;
-
-	robj = gem_to_amdgpu_bo(adev-&gt;mode_info.rfbdev-&gt;rfb.base.obj[0]);
-	size += amdgpu_bo_size(robj);
-	return size;
-}
-
-bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
-{
-	if (!adev-&gt;mode_info.rfbdev)
-		return false;
-	if (robj == gem_to_amdgpu_bo(adev-&gt;mode_info.rfbdev-&gt;rfb.base.obj[0]))
-		return true;
-	return false;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9e2525b96d04..ec57c7365e32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -876,6 +876,32 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static int amdgpu_align_pitch(struct amdgpu_device *adev,
+			      int width,
+			      int cpp,
+			      bool tiled)
+{
+	int aligned = width;
+	int pitch_mask = 0;
+
+	switch (cpp) {
+	case 1:
+		pitch_mask = 255;
+		break;
+	case 2:
+		pitch_mask = 127;
+		break;
+	case 3:
+	case 4:
+		pitch_mask = 63;
+		break;
+	}
+
+	aligned += pitch_mask;
+	aligned &amp;= ~pitch_mask;
+	return aligned * cpp;
+}
+
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 89fb372ed49c..6043bf6fd414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -232,8 +232,6 @@ struct amdgpu_i2c_chan {
 	struct mutex mutex;
 };
 
-struct amdgpu_fbdev;
-
 struct amdgpu_afmt {
 	bool enabled;
 	int offset;
@@ -309,13 +307,6 @@ struct amdgpu_framebuffer {
 	uint64_t address;
 };
 
-struct amdgpu_fbdev {
-	struct drm_fb_helper helper;
-	struct amdgpu_framebuffer rfb;
-	struct list_head fbdev_list;
-	struct amdgpu_device *adev;
-};
-
 struct amdgpu_mode_info {
 	struct atom_context *atom_context;
 	struct card_info *atom_card_info;
@@ -341,8 +332,6 @@ struct amdgpu_mode_info {
 	struct edid *bios_hardcoded_edid;
 	int bios_hardcoded_edid_size;
 
-	/* pointer to fbdev info structure */
-	struct amdgpu_fbdev *rfbdev;
 	/* firmware flags */
 	u32 firmware_flags;
 	/* pointer to backlight encoder */
@@ -631,15 +620,6 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode);
 
-/* fbdev layer */
-int amdgpu_fbdev_init(struct amdgpu_device *adev);
-void amdgpu_fbdev_fini(struct amdgpu_device *adev);
-void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state);
-int amdgpu_fbdev_total_size(struct amdgpu_device *adev);
-bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj);
-
-int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int bpp, bool tiled);
-
 /* amdgpu_display.c */
 void amdgpu_display_print_display_setup(struct drm_device *dev);
 int amdgpu_display_modeset_create_props(struct amdgpu_device *adev);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------EC0570301301BACAF916AA0A--

Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 06:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07EE6105A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 06:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B07EE6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F006E832;
	Thu,  7 Oct 2021 06:08:42 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455186E832
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 06:08:41 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id t2so15412054wrb.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Oct 2021 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9aG5NPMvgVnJ2CewIQ+dktqlsrYmzN4N9+SI0Z7APTk=;
 b=ivLVMZXzlgGL326lYBpb9GekIU/z0E0DX0gzEtCcL/s4aBaP2DwViJdpfqkNcJjWq2
 PSbOynOZ1TYboFanu1jH45PwL7CaRCOHIssXVfUseNJf0dQAc08pHaS4ZQLAfXNBNCA/
 efZBEL/6KffJ1zwgnfMYDfDRM5qBZxtNRbXxkRp+dkRDYVxX64RNok4Bavm1YHGA5fRk
 mlqqGGA0BWmMlqcVhDQcCR7lKOSUYjAC3PJNz8s+bTd/81otzRGT69jrOoGxgNusqgeM
 gH6+YpMCzPSg/JO3BNFVC34F+ievFy0KffSYUIKdj4hxfYrkJf8D8oo3UvyHzA24QYhd
 WB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9aG5NPMvgVnJ2CewIQ+dktqlsrYmzN4N9+SI0Z7APTk=;
 b=jyurHFL/O6v0cwt7wKIXUQWLERpPfAjRpOyMxcz8J8EQXYBFrHZhAAW9rKLCaojyPT
 BdHV5XXAXfFUUSG8SqHSgYcNd5+Ck0Ctk30GS+Td+DVFMEmIhbWFz62752CW7SVFmVRx
 PcSDqKkWXtLPlLP0gAOZR7uL96KAe6GwaARiUhNmJgaTzR1LEZkUF6MqCC88SWs+qSnp
 5aHD6z/Vq37FhBNEijrDdFDh+hzCe1d0y1IdWkvKc+OptPERgnC19qG8aQtskjR7KYw5
 unQ/xFInA8G81kcTlhtWMUvEEWc5Xs16Aa+GIqxNi/Cfwi3hRQp8UUN1IzzysEBYgKpy
 lYVA==
X-Gm-Message-State: AOAM531LTq3Cm+iHZPWuEhNMwDHJ5RD8wRNRmQh8yEDntXgPmNhKPppz
 YPoViclEtTAktK55C3QjDhc=
X-Google-Smtp-Source: ABdhPJzHmBJlMngVrD6QswdladV59QqpQXwvg5KELuSspBZxN0DInyEa9ZiS8uACIxeZv/Dow8bPpQ==
X-Received: by 2002:a05:600c:1c10:: with SMTP id
 j16mr7381725wms.12.1633586919770; 
 Wed, 06 Oct 2021 23:08:39 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id u3sm6875738wmc.16.2021.10.06.23.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Oct 2021 23:08:39 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: unify BO evicting method in amdgpu_ttm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20211006160408.118395-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0cd580cb-b8ed-0694-23be-2128cafae69e@gmail.com>
Date: Thu, 7 Oct 2021 08:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006160408.118395-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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



Am 06.10.21 um 18:04 schrieb Nirmoy Das:
> Unify BO evicting functionality for possible memory
> types in amdgpu_ttm.c and remove corresponding function
> from amdgpu_object.c.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  8 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 23 ----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 30 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>   6 files changed, 36 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 5497e2d31d1a..22f3de29d783 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1328,7 +1328,7 @@ static int amdgpu_debugfs_evict_vram(void *data, u64 *val)
>   		return r;
>   	}
>   
> -	*val = amdgpu_bo_evict_vram(adev);
> +	*val = amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> @@ -1341,17 +1341,15 @@ static int amdgpu_debugfs_evict_gtt(void *data, u64 *val)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>   	struct drm_device *dev = adev_to_drm(adev);
> -	struct ttm_resource_manager *man;
>   	int r;
>   
>   	r = pm_runtime_get_sync(dev->dev);
>   	if (r < 0) {
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		pm_runtime_put_autosuspend(dev->dev);
>   		return r;
>   	}
>   
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -	*val = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
> +	*val = amdgpu_bo_evict_memory(adev, TTM_PL_TT);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57638fe9cfc2..c441ebe9da11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3921,7 +3921,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>   
>   	/* evict vram memory */
> -	amdgpu_bo_evict_vram(adev);
> +	amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
>   
>   	amdgpu_fence_driver_hw_fini(adev);
>   
> @@ -3930,7 +3930,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	 * This second call to evict vram is to evict the gart page table
>   	 * using the CPU.
>   	 */
> -	amdgpu_bo_evict_vram(adev);
> +	amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);

Those two call are now missing the "(adev->in_s3 && (adev->flags & 
AMD_IS_APU))" check.

Probably best if you move that into a amdgpu_device_evict_vram() helper.

>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4ec904f36ceb..073ba2af0b9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1004,29 +1004,6 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>   	}
>   }
>   
> -/**
> - * amdgpu_bo_evict_vram - evict VRAM buffers
> - * @adev: amdgpu device object
> - *
> - * Evicts all VRAM buffers on the lru list of the memory type.
> - * Mainly used for evicting vram at suspend time.
> - *
> - * Returns:
> - * 0 for success or a negative error code on failure.
> - */
> -int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
> -{
> -	struct ttm_resource_manager *man;
> -
> -	if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
> -		/* No need to evict vram on APUs for suspend to ram */
> -		return 0;
> -	}
> -
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
> -}
> -
>   static const char *amdgpu_vram_names[] = {
>   	"UNKNOWN",
>   	"GDDR1",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 8ff61bad4138..d787e0e89e0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -305,7 +305,6 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain);
>   int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   			     u64 min_offset, u64 max_offset);
>   void amdgpu_bo_unpin(struct amdgpu_bo *bo);
> -int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
>   int amdgpu_bo_init(struct amdgpu_device *adev);
>   void amdgpu_bo_fini(struct amdgpu_device *adev);
>   int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e2896ac2c9ce..545b4bdeae07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2034,6 +2034,36 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_bo_evict_memory - evict memory buffers
> + * @adev: amdgpu device object
> + * @mem_type: evicted BO's memory type
> + *
> + * Evicts all @mem_type buffers on the lru list of the memory type.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type)

Rather rename that to amdgpu_ttm_evict_resources().

Apart from that looks good to me now.

Christian.

> +{
> +	struct ttm_resource_manager *man;
> +
> +	switch (mem_type) {
> +	case TTM_PL_VRAM:
> +	case TTM_PL_TT:
> +	case AMDGPU_PL_GWS:
> +	case AMDGPU_PL_GDS:
> +	case AMDGPU_PL_OA:
> +		man = ttm_manager_type(&adev->mman.bdev, mem_type);
> +		break;
> +	default:
> +		DRM_ERROR("Trying to evict invalid memory type\n");
> +		return -EINVAL;
> +	}
> +
> +	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   static int amdgpu_mm_vram_table_show(struct seq_file *m, void *unused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index e69f3e8e06e5..9ec7531bf131 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -190,6 +190,7 @@ bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>   uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>   uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>   				 struct ttm_resource *mem);
> +int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type);
>   
>   void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>   


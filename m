Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F72C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FAC6101B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0FAC6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747536F3F4;
	Thu,  7 Oct 2021 10:38:24 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2B36F3F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 10:38:23 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id r18so17642672wrg.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Oct 2021 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RsnLT3mMhqEcZYmXjZfejgfvvjydvtClXson6JLpANI=;
 b=k4TWxbuw8ARibnEK9becCE0N8WrcdEEcAUqjZ/TvCobrEwPtEk5yoLQTT8gOUnzB0B
 y1xcupJqOjg/ENCo46IuzUR3JMQnJ7qjO0wcn7fvWr/7g3WHo/ljV0t8dVSGVMepNhJk
 726FgGHicV0OmXzrhWgmfkucz9oV+WlcWLEbliyk/kMlY82vFZ0OwDFCWLbK7VyMCWdQ
 9tT7Ca/wYSfWCbbOjHn+VP9zN2ZeNEZ2ehPj/i5ROssQjKMbBeMf070Fx/e3/AIKPqdn
 V9mbJ2vVgBIP1hi0un/J2aygEqW8xzMsE2nYHpoYemYenWwConAQu5A2qmpZg8RT4zVy
 virQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RsnLT3mMhqEcZYmXjZfejgfvvjydvtClXson6JLpANI=;
 b=kh+uLd2Elslgs5FT7dskZOvsGcZrqExb7BBI5YoXWsGJ4mqB1oMulkA1zrGMAGbDZ5
 wEuMH/5gqzaL/zcpzwSxwLJqdGoqw9sRrwj5vuAgFvtKz2TTih3w9pI1mW36diIaNdGb
 97xy+C1xedT4/mzs1yXJsJMVjpoYys9WVue8JWPNRKn20KVmXhmJ4t15pgDoewcG98Po
 l+XA+BP00zcSnKGtIQM9DSJwmHIihC/5s9Txj3VInID6mT++xiB0mZ95qKzLGTIrb/B2
 FH+iAVJ0bnE3c7/NBhQF9qHkzRJ+MSn4nSXswRhjP5FxuVXjbg1dfl7yRFlAlVEzt/YM
 S8aw==
X-Gm-Message-State: AOAM531fQY7ussa7/A7fz2T3Gi90EXREnRRwZ7XnJ/Wyw4E2r+eQogmT
 /3roGHNk5PKyPS6l9RJ3huw=
X-Google-Smtp-Source: ABdhPJyVctsYMxFYScWr2uqMW1HLTqfC/RVq0WDPb0vHJbQ8GmtUuKifSzE5P5CfQrsWx5yPDC60/w==
X-Received: by 2002:a05:6000:1844:: with SMTP id
 c4mr4301201wri.425.1633603101859; 
 Thu, 07 Oct 2021 03:38:21 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id n17sm16240291wrw.16.2021.10.07.03.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Oct 2021 03:38:21 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: unify BO evicting method in amdgpu_ttm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20211007100032.8140-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <722d6f33-4353-768f-1509-cc82e81654cc@gmail.com>
Date: Thu, 7 Oct 2021 12:38:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007100032.8140-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 07.10.21 um 12:00 schrieb Nirmoy Das:
> Unify BO evicting functionality for possible memory
> types in amdgpu_ttm.c.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  8 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 30 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 23 ----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 30 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>   6 files changed, 58 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 5497e2d31d1a..164d6a9e9fbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1328,7 +1328,7 @@ static int amdgpu_debugfs_evict_vram(void *data, u64 *val)
>   		return r;
>   	}
>   
> -	*val = amdgpu_bo_evict_vram(adev);
> +	*val = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
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
> +	*val = amdgpu_ttm_evict_resources(adev, TTM_PL_TT);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57638fe9cfc2..032deca4cea2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3880,6 +3880,25 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   
>   }
>   
> +/**
> + * amdgpu_device_evict_resources - evict device resources
> + * @adev: amdgpu device object
> + *
> + * Evicts all ttm device resources(vram BOs, gart table) from the lru list
> + * of the vram memory type. Mainly used for evicting device resources
> + * at suspend time.
> + *
> + */
> +void amdgpu_device_evict_resources(struct amdgpu_device *adev)

Please add static here, apart from that the patch is Reviewed-by: 
Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> +{
> +	/* No need to evict vram on APUs for suspend to ram */
> +	if (adev->in_s3 && (adev->flags & AMD_IS_APU))
> +		return;
> +
> +	if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
> +		DRM_WARN("evicting device resources failed\n");
> +
> +}
>   
>   /*
>    * Suspend & resume.
> @@ -3920,17 +3939,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (!adev->in_s0ix)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>   
> -	/* evict vram memory */
> -	amdgpu_bo_evict_vram(adev);
> +	/* First evict vram memory */
> +	amdgpu_device_evict_resources(adev);
>   
>   	amdgpu_fence_driver_hw_fini(adev);
>   
>   	amdgpu_device_ip_suspend_phase2(adev);
> -	/* evict remaining vram memory
> -	 * This second call to evict vram is to evict the gart page table
> -	 * using the CPU.
> +	/* This second call to evict device resources is to evict
> +	 * the gart page table using the CPU.
>   	 */
> -	amdgpu_bo_evict_vram(adev);
> +	amdgpu_device_evict_resources(adev);
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
> index e2896ac2c9ce..bd5dda8066fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2034,6 +2034,36 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_ttm_evict_resources - evict memory buffers
> + * @adev: amdgpu device object
> + * @mem_type: evicted BO's memory type
> + *
> + * Evicts all @mem_type buffers on the lru list of the memory type.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
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
> index e69f3e8e06e5..ba5c864b8de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -190,6 +190,7 @@ bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>   uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>   uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>   				 struct ttm_resource *mem);
> +int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
>   
>   void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>   


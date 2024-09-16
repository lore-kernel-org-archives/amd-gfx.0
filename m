Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64342C3ABA2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Sep 2024 12:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED15B10E05F;
	Mon, 16 Sep 2024 12:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zq8jNHdo";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A856010E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 12:39:06 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-42cba0dc922so33727965e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726490345; x=1727095145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J1XqJoUN++AiQhXIIjjnQLij7tPTE4j9/hAkAwyp19M=;
 b=Zq8jNHdopJTlfHZYozEz5k+b/5daCA0QRn1rxZuAHvgLpx3gANbGuUQW7+DSdrnyaS
 cn3ws9iGsl5Ivuj8mzLDKkXEshIhwVNYICFI/b9MVqCS7kFh4SkJbOBLm1yOAECk4qKH
 FKp0BKsP7tQsjfZ0IhbkVA4KBZywPiB+A6MDt3UulJ+3h7rnyZs+9F87RkaD5oRGja0A
 AhN8YS8StttvP8uKEe+7u7//lVStlcw/OD8xhHVsVX0ePksps0KV9OHuWmOSzD/Hb1SF
 Hr3LfWVTKkbIN5pYXTlNK/LuYH+xKx8wbrKza8NZlK1Riww52g9K19zbiTy0NtE9/RXO
 mXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726490345; x=1727095145;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J1XqJoUN++AiQhXIIjjnQLij7tPTE4j9/hAkAwyp19M=;
 b=YP1YsKwuj8GFkM1HDY9CkBLj1DhaSznVLvhQamB4cgNqw4/o8wF5HJWQDPz195XInx
 CuJ4QoN7d4zGhDF3gJl58eemEucYzJXh9wg/K8A5YFbTbWnRBKAnkwwfFgd2AnJ1c4No
 kMeFPBX3rVP/zHZ95DC0z8fj7pcWX6o4yYaLRrt6bvXNcfHZjZ40oG4PGUrMNHfGb06X
 zqcqk+0f0I8QUuFW7qGBUJzOu0WDtliHlR7sXDqg9eqwhOSAVBtN10CRjl8jLrnbIEHn
 /UYqByHja+OoIOxwaQMHA8DadAI9aqAy88rWGgLD77IhpSJuCmlyZYPY9j7iK4ooPhFx
 FuIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+xh9r5IVshMQHwAgZciv0E29149rJ9qc+WK7a8CLlGYqDkGx1tr8kJ9Lkw6fmSFtPLSSn44Um@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZ5L2eyUAnKLOdtj9DcjRtgUgMAurdcknM3bgpXXxTSMcJNW8/
 mqaVwvAJjPNotwDr1t0jg1Nq7TJWkgf1DkqB002/SxB7x1VtvP6i
X-Google-Smtp-Source: AGHT+IHe4clDED8fDH6vQ4TE9mdL5+sRY5ly/n/mFd0w4KpgahxDZ4Hlonvp+ktnPWixbxHKHD2rjw==
X-Received: by 2002:a05:600c:3b99:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-42cdb4fbb08mr100116325e9.4.1726490344083; 
 Mon, 16 Sep 2024 05:39:04 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e71f068esm7226909f8f.3.2024.09.16.05.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2024 05:39:03 -0700 (PDT)
Message-ID: <9c1c606f-5d5b-4dba-9dc7-96a36d2d917f@gmail.com>
Date: Mon, 16 Sep 2024 14:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/28] drm/amdgpu: map wptr BO into GART
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-9-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240909200614.481-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 09.09.24 um 22:05 schrieb Shashank Sharma:
> To support oversubscription, MES FW expects WPTR BOs to
> be mapped into GART, before they are submitted to usermode
> queues. This patch adds a function for the same.
>
> V4: fix the wptr value before mapping lookup (Bas, Christian).
>
> V5: Addressed review comments from Christian:
>      - Either pin object or allocate from GART, but not both.
>      - All the handling must be done with the VM locks held.
>
> V7: Addressed review comments from Christian:
>      - Do not take vm->eviction_lock
>      - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset
>
> V8:  Rebase
> V9:  Changed the function names from gfx_v11* to mes_v11*
> V10: Remove unused adev (Harish)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 76 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>   2 files changed, 77 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index a1bc6f488928..90511abaef05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -30,6 +30,73 @@
>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>   
> +static int
> +mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, true);
> +	if (ret) {
> +		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
> +		goto err_reserve_bo_failed;
> +	}
> +
> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	if (ret) {
> +		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> +		goto err_map_bo_gart_failed;
> +	}
> +
> +	amdgpu_bo_unreserve(bo);
> +	bo = amdgpu_bo_ref(bo);
> +
> +	return 0;
> +
> +err_map_bo_gart_failed:
> +	amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +	return ret;
> +}
> +
> +static int
> +mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
> +			      struct amdgpu_usermode_queue *queue,
> +			      uint64_t wptr)
> +{
> +	struct amdgpu_bo_va_mapping *wptr_mapping;
> +	struct amdgpu_vm *wptr_vm;
> +	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
> +	int ret;
> +
> +	wptr_vm = queue->vm;
> +	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +	if (ret)
> +		return ret;
> +
> +	wptr &= AMDGPU_GMC_HOLE_MASK;
> +	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
> +	amdgpu_bo_unreserve(wptr_vm->root.bo);
> +	if (!wptr_mapping) {
> +		DRM_ERROR("Failed to lookup wptr bo\n");
> +		return -EINVAL;
> +	}
> +
> +	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
> +	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
> +		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = mes_v11_0_map_gtt_bo_to_gart(wptr_obj->obj);
> +	if (ret) {
> +		DRM_ERROR("Failed to map wptr bo to GART\n");
> +		return ret;
> +	}
> +
> +	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
> +	return 0;
> +}
> +
>   static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   			       struct amdgpu_usermode_queue *queue,
>   			       struct amdgpu_mqd_prop *userq_props)
> @@ -61,6 +128,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	queue_input.queue_size = userq_props->queue_size >> 2;
>   	queue_input.doorbell_offset = userq_props->doorbell_index;
>   	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
> +	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>   
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> @@ -168,6 +236,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		goto free_mqd;
>   	}
>   
> +	/* FW expects WPTR BOs to be mapped into GART */
> +	r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
> +	if (r) {
> +		DRM_ERROR("Failed to create WPTR mapping\n");
> +		goto free_ctx;
> +	}
> +
>   	/* Map userqueue into FW using MES */
>   	r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
>   	if (r) {
> @@ -194,6 +269,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   			    struct amdgpu_usermode_queue *queue)
>   {
>   	mes_v11_0_userq_unmap(uq_mgr, queue);
> +	amdgpu_bo_unref(&queue->wptr_obj.obj);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>   	kfree(queue->userq_prop);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 643f31474bd8..ffe8a3d73756 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_userq_obj mqd;
>   	struct amdgpu_userq_obj fw_obj;
> +	struct amdgpu_userq_obj wptr_obj;
>   };
>   
>   struct amdgpu_userq_funcs {


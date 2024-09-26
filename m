Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44299C369DE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 12:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D6E10E033;
	Thu, 26 Sep 2024 12:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lig2GMV2";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C5210E033
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 12:28:50 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-42f56ad2afaso3383395e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727353729; x=1727958529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDmGA4Q2r0nBqUQ6raalJvmsELW3shMmqw74Xfr20PU=;
 b=lig2GMV2m7tThmkGsYDlvqx9u8gcM7u9ELeqjHl/93ViRnccsdrRYuWqOJpEHZdqyw
 PU3WiCMGh6LoGfapmtmPQD8bHmn+Or/C7fh5hXFNsmvka+4wthvwTEyDPYpp+tivYqSD
 4HdxqX2GZ1egVj/VFEPAB6Hy28OdrhglH12A3JsrYtrdI2Ymv8FCHwqQqa4eT/7OolY6
 ZNsTE3eCfU0IRTggUNTM8u3H+R8E95T7x3ZJgxKwZlIL0ljUoWxNSzNlRnw+2kOc2l7m
 +b2Akw/UZXhXvZ6fI/zrveGEyxJYZche9MYt2kjUYGL5CeRnezx0MxuOaFBHC8hFaKn5
 cNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727353729; x=1727958529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDmGA4Q2r0nBqUQ6raalJvmsELW3shMmqw74Xfr20PU=;
 b=awPjdWl0xq+opaTmiCBw8qEPGeCS3TWZBG69hry+0Gm3py6cQkhMCIIYujYjk6TFfc
 49txbkzgkUY821BCYN88I/cCCfnPHH6pyoMHJ3BYaDQQQVR1sszPL7m1QhXLZ5ng2+jl
 8AAG+xHmWTCVtLAK0AerCShuoWX4EYEahIhRumHl7yGll2twHy6r8XDWMQRNP3Hl32ho
 8i3U+3b8jRHy6Hj074Z9GnyKEqSb+PXv4v4LCeVHpwG9uXc6LtY0SmHjfWs1P7jtP29q
 mA6CxY3ubsUXAXTgXVhfcVPCdviUUqzzHxnDIl2lfh6/g7w6U9J2DJ87fOUJTvEssKOq
 7u+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYPRhiUvm+ReQSKmT7sbYJve6vDa8Ai9HeLpTcY0vZ4mIvKTuJI/cePVbtsihk5Jk1a08HNz6Y@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpL44rm+sBDMHWSdRy21zMsTLSuKXz2JpEaRRZwve0v8jxMiI3
 XlxNlovtNivqhMJD1TJF2pu/o2jvUV9Rl1Nr0zmFNxSh6xxFOaHL
X-Google-Smtp-Source: AGHT+IGVikh+tkKro6zJXkERnWuIPMbVy5PQFBnao/1NwKKWoCqpyL/4ocz7+jr5kTOeDprv453wlg==
X-Received: by 2002:a05:600c:1c0d:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-42e9610a22cmr54681375e9.8.1727353728596; 
 Thu, 26 Sep 2024 05:28:48 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a56fd1sm44985255e9.48.2024.09.26.05.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 05:28:48 -0700 (PDT)
Message-ID: <25015d29-8251-4d67-92c2-1679dec27273@gmail.com>
Date: Thu, 26 Sep 2024 14:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/08] drm/amdgpu: Add few optimizations to userq fence
 driver
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <20240925195928.142001-6-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240925195928.142001-6-Arunpravin.PaneerSelvam@amd.com>
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

Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
> Add few optimizations to userq fence driver.

"Few optimization and fixes for userq fence driver".

>
> v1:(Christian):
>    - Remove unnecessary comments.
>    - In drm_exec_init call give num_bo_handles as last parameter it would
>      making allocation of the array more efficient
>    - Handle return value of __xa_store() and improve the error handling of
>      amdgpu_userq_fence_driver_alloc().
>
> v2:(Christian):
>     - Revert userq_xa xarray init to XA_FLAGS_LOCK_IRQ.
>     - move the xa_unlock before the error check of the call xa_err(__xa_store())
>       and moved this change to a separate patch as this is adding a missing error
>       handling.
>     - Removed the unnecessary comments.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 44 ++++++++++++-------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  6 +--
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +-
>   4 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 8d2a0331cd96..f3576c31428c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -76,7 +76,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
>   	if (!fence_drv) {
>   		DRM_ERROR("Failed to allocate memory for fence driver\n");
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto free_fence_drv;
>   	}
>   
>   	/* Acquire seq64 memory */
> @@ -84,7 +85,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   			       &fence_drv->cpu_addr);
>   	if (r) {
>   		kfree(fence_drv);
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto free_seq64;
>   	}
>   
>   	memset(fence_drv->cpu_addr, 0, sizeof(u64));
> @@ -94,7 +96,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	spin_lock_init(&fence_drv->fence_list_lock);
>   
>   	fence_drv->adev = adev;
> -	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
> +	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
> @@ -106,6 +108,13 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	userq->fence_drv = fence_drv;
>   
>   	return 0;
> +
> +free_seq64:
> +	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> +free_fence_drv:
> +	kfree(fence_drv);
> +
> +	return r;
>   }
>   
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
> @@ -147,7 +156,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	struct amdgpu_device *adev = fence_drv->adev;
>   	struct amdgpu_userq_fence *fence, *tmp;
>   	struct xarray *xa = &adev->userq_xa;
> -	unsigned long index;
> +	unsigned long index, flags;
>   	struct dma_fence *f;
>   
>   	spin_lock(&fence_drv->fence_list_lock);
> @@ -164,11 +173,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	}
>   	spin_unlock(&fence_drv->fence_list_lock);
>   
> -	xa_lock(xa);
> +	xa_lock_irqsave(xa, flags);
>   	xa_for_each(xa, index, xa_fence_drv)
>   		if (xa_fence_drv == fence_drv)
>   			__xa_erase(xa, index);
> -	xa_unlock(xa);
> +	xa_unlock_irqrestore(xa, flags);
>   
>   	/* Free seq64 memory */
>   	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> @@ -212,12 +221,12 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	amdgpu_userq_fence_driver_get(fence_drv);
>   	dma_fence_get(fence);
>   
> -	if (!xa_empty(&userq->uq_fence_drv_xa)) {
> +	if (!xa_empty(&userq->fence_drv_xa)) {
>   		struct amdgpu_userq_fence_driver *stored_fence_drv;
>   		unsigned long index, count = 0;
>   		int i = 0;
>   
> -		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv)
> +		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>   			count++;
>   
>   		userq_fence->fence_drv_array =
> @@ -226,9 +235,9 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   				       GFP_KERNEL);
>   
>   		if (userq_fence->fence_drv_array) {
> -			xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
> +			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
>   				userq_fence->fence_drv_array[i] = stored_fence_drv;
> -				xa_erase(&userq->uq_fence_drv_xa, index);
> +				xa_erase(&userq->fence_drv_xa, index);
>   				i++;
>   			}
>   		}
> @@ -378,7 +387,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	struct drm_exec exec;
>   	u64 wptr;
>   
> -	/* Array of syncobj handles */
>   	num_syncobj_handles = args->num_syncobj_handles;
>   	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
>   				      sizeof(u32) * num_syncobj_handles);
> @@ -400,7 +408,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	/* Array of bo handles */
>   	num_bo_handles = args->num_bo_handles;
>   	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
>   				 sizeof(u32) * num_bo_handles);
> @@ -422,7 +429,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
> +
> +	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
>   		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
> @@ -527,7 +536,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_timeline_handles;
>   	}
>   
> -	/* Array of GEM object handles */
>   	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>   	if (!gobj) {
>   		r = -ENOMEM;
> @@ -542,7 +550,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
> +
> +	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
>   		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
>   		drm_exec_retry_on_contention(&exec);
> @@ -702,8 +712,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			 * Otherwise, we would gather those references until we don't
>   			 * have any more space left and crash.
>   			 */
> -			if (fence_drv->uq_fence_drv_xa_ref) {
> -				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
> +			if (fence_drv->fence_drv_xa_ptr) {
> +				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
>   					     xa_limit_32b, GFP_KERNEL);
>   				if (r)
>   					goto free_fences;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index f72424248cc5..89c82ba38b50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -54,7 +54,7 @@ struct amdgpu_userq_fence_driver {
>   	spinlock_t fence_list_lock;
>   	struct list_head fences;
>   	struct amdgpu_device *adev;
> -	struct xarray *uq_fence_drv_xa_ref;
> +	struct xarray *fence_drv_xa_ptr;
>   	char timeline_name[TASK_COMM_LEN];
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index e7f7354e0c0e..9b24218f7ad2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -48,8 +48,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
>   static void
>   amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>   {
> -	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
> -	xa_destroy(&userq->uq_fence_drv_xa);
> +	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
> +	xa_destroy(&userq->fence_drv_xa);
>   	/* Drop the fence_drv reference held by user queue */
>   	amdgpu_userq_fence_driver_put(userq->fence_drv);
>   }
> @@ -348,7 +348,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   	queue->doorbell_index = index;
>   
> -	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
> +	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to alloc fence driver\n");
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index d035b5c2b14b..6eb094a54f4b 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -52,7 +52,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_userq_obj	db_obj;
>   	struct amdgpu_userq_obj fw_obj;
>   	struct amdgpu_userq_obj wptr_obj;
> -	struct xarray		uq_fence_drv_xa;
> +	struct xarray		fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   	struct dma_fence	*last_fence;
>   };


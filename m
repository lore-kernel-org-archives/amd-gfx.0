Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB05BCD5BAA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 11:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1E310E865;
	Thu,  5 Sep 2024 11:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTyHJiKd";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142F510E865
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 11:30:37 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so5044995e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Sep 2024 04:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725535835; x=1726140635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7AVALPtWG7QYelRuB15MSiA8IhdX2MVRD7rmn44MiTk=;
 b=DTyHJiKdvDu5LZbfYmxENx51m3xjgw5EGAZHHYNm0J9FnvFCfLr6vGSyjYabh6dph+
 rvY41rk2wyxEaOY30u2ztElfEn3XRWtlZ51u/j4Pal/P0xTWaY20iIa3Bg1LfAx6d5Cj
 tnJcX5f2uoqwfzkg/X+hRR/NQzIvKy3gl66CRs2x+VbbpF0vQYJRUxQdqG0TASCQ9sSn
 b8fraFz/pKh070CR5NwSVsv4WuRbpaXjr3Ot3Fj+sL55mTL+yElfjO+liWcpElDLQTzk
 GXMqAEZA9f6sPix/Wu3TswvjkJ9ndiMHWg6JCc+2MCdEz9venztV1aBT6G1AvKRiTncc
 0P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535835; x=1726140635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AVALPtWG7QYelRuB15MSiA8IhdX2MVRD7rmn44MiTk=;
 b=nYYBBhxKwEQCedhIgYZqYY1Z+UB4X2IgCJbK3q5cEKiWywk22HmQhtX4oKnVu5p8pQ
 7IJAJQGmuKiHPKlTk0yER8rQnXxuUT71O8cUY3jmwpDtt988aiL0t/zmZItKQWP+2VL7
 kEWS5l+cPl3RkJQW6e1OJWWsv8QwDmrJLGRX9g00OF7AuYun45JscU64TGltWWfzHvhv
 ijAZsQJLAhE3ePUICo8zAXpVjFaYE6GYW7BWq6/hQVDe5jyfORWEeu+4n90NwH9iz6z3
 ENGVbJzlLgUDuBzloEbfVOLuueEE1rkHhbbXAibex/8cne1r2E5G/QeWE0N/so2pz+s4
 hwDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYhUWgQ+0Tlr8ymoQalGEqQgPzxH8wUKRcOlAQMc227HA98akAhvgJvdoF6f2MI/3nukOjxxAF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeTFfjOqgC/yioqIUEU7ExAaM/dOW4l/VeBNQ+cBQqueveDSW4
 LcWCFiC63kXtE8b+CZgS7Jt+7CZ5/157JDFMMOvbcK5o7pnOPc0K
X-Google-Smtp-Source: AGHT+IFaNwMGMU6S0cCy3z5lLQS30qCHEDV8KUNvzNJJAkGBXhbm4eV7K1DB/Q7a5sTJnssbwFQ3cA==
X-Received: by 2002:a5d:4acc:0:b0:374:bcc7:b9bb with SMTP id
 ffacd0b85a97d-3776fa1e62bmr3922355f8f.35.1725535834318; 
 Thu, 05 Sep 2024 04:30:34 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df92f1sm231562475e9.25.2024.09.05.04.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:30:33 -0700 (PDT)
Message-ID: <25ecc9b2-e957-444d-a0c3-3a125bcf50d2@gmail.com>
Date: Thu, 5 Sep 2024 13:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/amdgpu: Add few optimizations to userq fence
 driver
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
 <20240830184322.1238767-6-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240830184322.1238767-6-Arunpravin.PaneerSelvam@amd.com>
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

Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:
> Add few optimizations to userq fence driver.
>
> v1:(Christian):
>    - Remove unnecessary comments.
>    - In drm_exec_init call give num_bo_handles as last parameter it would
>      making allocation of the array more efficient
>    - Handle return value of __xa_store() and improve the error handling of
>      amdgpu_userq_fence_driver_alloc().
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 64 ++++++++++++-------
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  6 +-
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +-
>   5 files changed, 48 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ec6cb237c81..3c4568929d12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3967,7 +3967,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	spin_lock_init(&adev->audio_endpt_idx_lock);
>   	spin_lock_init(&adev->mm_stats.lock);
>   
> -	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> +	xa_init_flags(&adev->userq_xa, XA_FLAGS_ALLOC);

I don't think that this is correct. The XA is used from IRQ context.

>   
>   	INIT_LIST_HEAD(&adev->shadow_list);
>   	mutex_init(&adev->shadow_list_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c6d201abf5ec..a30b8abe8a2f 100644
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
> @@ -94,18 +96,30 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	spin_lock_init(&fence_drv->fence_list_lock);
>   
>   	fence_drv->adev = adev;
> -	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
> +	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
>   	xa_lock_irqsave(&adev->userq_xa, flags);
> -	__xa_store(&adev->userq_xa, userq->doorbell_index,
> -		   fence_drv, GFP_KERNEL);
> +	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
> +			      fence_drv, GFP_KERNEL));
> +	if (r)
> +		goto xa_err;
> +
>   	xa_unlock_irqrestore(&adev->userq_xa, flags);

You can move the xa_unlock before the error check here.

And that looks like adding missing error handling and not just optimization.

>   
>   	userq->fence_drv = fence_drv;
>   
>   	return 0;
> +
> +xa_err:
> +	xa_unlock_irqrestore(&adev->userq_xa, flags);
> +free_seq64:
> +	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
> +free_fence_drv:
> +	kfree(fence_drv);
> +
> +	return r;
>   }
>   
>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
> @@ -149,7 +163,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>   	struct amdgpu_device *adev = fence_drv->adev;
>   	struct amdgpu_userq_fence *fence, *tmp;
>   	struct xarray *xa = &adev->userq_xa;
> -	unsigned long index;
> +	unsigned long index, flags;
>   	struct dma_fence *f;
>   
>   	spin_lock(&fence_drv->fence_list_lock);
> @@ -166,11 +180,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
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
> @@ -214,12 +228,12 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
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
> @@ -229,9 +243,9 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   		userq_fence->fence_drv_array_count = count;
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
> @@ -377,14 +391,12 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	int r, i, entry;
>   	u64 wptr;
>   
> -	/* Array of syncobj handles */
>   	num_syncobj_handles = args->num_syncobj_handles;
>   	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
>   				      sizeof(u32) * num_syncobj_handles);
>   	if (IS_ERR(syncobj_handles))
>   		return PTR_ERR(syncobj_handles);
>   
> -	/* Array of syncobj object handles */
>   	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
>   	if (!syncobj) {
>   		r = -ENOMEM;
> @@ -399,14 +411,12 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	/* Array of bo handles */
>   	num_bo_handles = args->num_bo_handles;
>   	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
>   				 sizeof(u32) * num_bo_handles);
>   	if (IS_ERR(bo_handles))
>   		goto put_syncobj_handles;
>   
> -	/* Array of GEM object handles */
>   	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>   	if (!gobj) {
>   		r = -ENOMEM;
> @@ -421,7 +431,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> @@ -526,7 +538,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_timeline_handles;
>   	}
>   
> -	/* Array of GEM object handles */
>   	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>   	if (!gobj) {
>   		r = -ENOMEM;
> @@ -541,7 +552,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
> @@ -703,9 +716,16 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			 * Otherwise, we would gather those references until we don't
>   			 * have any more space left and crash.
>   			 */
> -			if (fence_drv->uq_fence_drv_xa_ref) {
> -				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
> -					     xa_limit_32b, GFP_KERNEL);
> +			if (fence_drv->fence_drv_xa_ptr) {
> +				/*
> +				 * Store the fence_drv reference into the corresponding
> +				 * userq fence_drv_xa.
> +				 */

That comment looks superfluous to me.

> +				r = xa_alloc(fence_drv->fence_drv_xa_ptr,
> +					     &index,
> +					     fence_drv,
> +					     xa_limit_32b,
> +					     GFP_KERNEL);

Please keep the coding style as it was, this actually matches the kernel 
coding style better.

Christian.

>   				if (r)
>   					goto free_fences;
>   
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


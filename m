Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C049CD37B0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 10:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFC210E265;
	Mon, 18 Sep 2023 10:32:41 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BB210E04E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 10:32:39 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c00c0f11b2so12673591fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695033157; x=1695637957; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bct1fdBMWCc5uNQPo/dkixoQKggctX23vc6xY0OU8dw=;
 b=XBaoR/jSTE9hfGiv5MUUAsQ+0STZRyQH0RdqIF9RMkrKJpi/cjjwbqxB/wRzEYJ0D9
 g3KzB/XAr4G6v4Nw45B+dQASx9VGMtSaFwJXkZoFgMdAQ1hViwt+bu/YJPhjQchpNwJO
 f3Md7tESO3YI+yDf637H+IjSpgQySOiRPwn0Wsv5BE23AD9Z4amo9hSzBzyj+zD42+VG
 uPkbtogrKQk0ANNBYfvl/6vO7WFzpMo/HSwJRN3TA4fiqa7c5tpqGjhBC2dcU0/4Y3Ib
 h2kPD2sDDOtkN12ylH1aQj9kg9FZ6NkZZFzYIYUftbe535Otn8sxAvP3RWZqjdTOjyGW
 MpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033157; x=1695637957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bct1fdBMWCc5uNQPo/dkixoQKggctX23vc6xY0OU8dw=;
 b=eOSgTEbSbELhaLweJJPmFIErizaeKQDdy9f//6cN7K+tMqyJKLdPGI83uE/0wmjkK3
 GEhZ+dFfP8q5m9oU2eRWYHQ8eKqV96m6uUKx+ADBUZ557CE7NvukDnw/cDFiJ9ctCurP
 hcLRnYkklObCRZvReeaHnotHtVH/4gfjEJBFYuZngmvR/Qb0mn+8dK7XKh30frrLHDfg
 07MLeUX+sLldPH/PozmPepbIEXVtZ8g3I8AZ+xpMayKQL/EI7vLAZjfEijNPjBDu5rTA
 etXbW7w/e++2ZrZEDKRtwfyYO2jtvmNQSit4k5Jwiz3qdlp+vZGxsRKsq+vb9QFtN0fR
 +uPg==
X-Gm-Message-State: AOJu0YwefV2eppXf6oUToKBmBE+J0VdrgKeetdwR2TsQAfA7U48u7FpA
 kjfJJT/iq6pHM8EGRxB5+0E=
X-Google-Smtp-Source: AGHT+IFzi6pHZdz+n9exsFsfzmOpPgDNQtY13sAqVzmXTWq/2qJDshGuT7s1MHOr1qsLVLjOSkG5iA==
X-Received: by 2002:a05:651c:215:b0:2bc:d38e:65ab with SMTP id
 y21-20020a05651c021500b002bcd38e65abmr7404394ljn.37.1695033157194; 
 Mon, 18 Sep 2023 03:32:37 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.99])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170906241500b0099b76c3041csm6262638eja.7.2023.09.18.03.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:32:36 -0700 (PDT)
Message-ID: <022fbf02-b9f6-1286-bd25-dd150384047e@gmail.com>
Date: Mon, 18 Sep 2023 12:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 7/9] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-8-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230908160446.2188-8-shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.09.23 um 18:04 schrieb Shashank Sharma:
> To support oversubscription, MES FW expects WPTR BOs to
> be mapped into GART, before they are submitted to usermode
> queues. This patch adds a function for the same.
>
> V4: fix the wptr value before mapping lookup (Bas, Christian).
> V5: Addressed review comments from Christian:
>      - Either pin object or allocate from GART, but not both.
>      - All the handling must be done with the VM locks held.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 81 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>   2 files changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index e266674e0d44..c0eb622dfc37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6427,6 +6427,79 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
>   
> +static int
> +gfx_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
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

The GART mapping can become invalid as soon as you unlock the BOs.

You need to attach an eviction fence for this to work correctly.

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
> +gfx_v11_0_create_wptr_mapping(struct amdgpu_device *adev,
> +			      struct amdgpu_usermode_queue *queue,
> +			      uint64_t wptr)
> +{
> +	struct amdgpu_bo_va_mapping *wptr_mapping;
> +	struct amdgpu_vm *wptr_vm;
> +	struct amdgpu_bo *wptr_bo = NULL;
> +	int ret;
> +
> +	mutex_lock(&queue->vm->eviction_lock);

Never ever touch the eviction lock outside of the VM code! That lock is 
completely unrelated to what you do here.

> +	wptr_vm = queue->vm;
> +	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +	if (ret)
> +		goto unlock;
> +
> +	wptr &= AMDGPU_GMC_HOLE_MASK;
> +	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
> +	amdgpu_bo_unreserve(wptr_vm->root.bo);
> +	if (!wptr_mapping) {
> +		DRM_ERROR("Failed to lookup wptr bo\n");
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	wptr_bo = wptr_mapping->bo_va->base.bo;
> +	if (wptr_bo->tbo.base.size > PAGE_SIZE) {
> +		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
> +		ret = -EINVAL;
> +		goto unlock;
> +	}

We probably also want to enforce that this BO is a per VM BO.

> +
> +	ret = gfx_v11_0_map_gtt_bo_to_gart(adev, wptr_bo);
> +	if (ret) {
> +		DRM_ERROR("Failed to map wptr bo to GART\n");
> +		goto unlock;
> +	}
> +
> +	queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;

This needs to be amdgpu_bo_gpu_offset() instead.

Regards,
Christian.

> +
> +unlock:
> +	mutex_unlock(&queue->vm->eviction_lock);
> +	return ret;
> +}
> +
>   static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>   				  struct amdgpu_usermode_queue *queue)
>   {
> @@ -6475,6 +6548,7 @@ static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	queue_input.queue_size = userq_props->queue_size >> 2;
>   	queue_input.doorbell_offset = userq_props->doorbell_index;
>   	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
> +	queue_input.wptr_mc_addr = queue->wptr_mc_addr;
>   
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> @@ -6601,6 +6675,13 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		goto free_mqd;
>   	}
>   
> +	/* FW expects WPTR BOs to be mapped into GART */
> +	r = gfx_v11_0_create_wptr_mapping(adev, queue, userq_props.wptr_gpu_addr);
> +	if (r) {
> +		DRM_ERROR("Failed to create WPTR mapping\n");
> +		goto free_ctx;
> +	}
> +
>   	/* Map userqueue into FW using MES */
>   	r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 34e20daa06c8..ae155de62560 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -39,6 +39,7 @@ struct amdgpu_usermode_queue {
>   	int			queue_type;
>   	uint64_t		doorbell_handle;
>   	uint64_t		doorbell_index;
> +	uint64_t		wptr_mc_addr;
>   	uint64_t		flags;
>   	struct amdgpu_mqd_prop	*userq_prop;
>   	struct amdgpu_userq_mgr *userq_mgr;


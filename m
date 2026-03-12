Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077B9106ACCB
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 16:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F2C10EA61;
	Thu, 12 Mar 2026 16:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="jXQQhfE0";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 592FB10EA61
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 16:34:05 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so10269985e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773333244; x=1773938044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oQMcgS/XawuS7+vU18OJ2+1FP5/PZf5Wifbizwzms18=;
 b=jXQQhfE0IRjADfUcoriLvxsIjKgiUbXtSmqyntdojt3DI+SNoZymGPwXbfM7QAjzzK
 QWBndh75H9NmlC74EEyDQON/aTtqxIZbPwAgBa5T2W524eiVayLjYxghFFni3yrP13+m
 S3Btnat2VseIQBBEef4a5iULDFE+raMxdmWsbAIMDTBRBNxC00FQ65C0hfyqMTm5e4lD
 Y8RBuZG3itd6KV4+cikK43JvkATG4fd9ovt25ZUMzgSb7FOLefuLwpWc1q18PwU6dEqa
 CSv8NpM5ajpOvoGMI1zdZpQgk+MElba2n2RJ//hjDigAFH2chtdK6KOiACT8MuBX9dHe
 Ah0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773333244; x=1773938044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQMcgS/XawuS7+vU18OJ2+1FP5/PZf5Wifbizwzms18=;
 b=fmaUxycMTMF/s3Gs7TFm0iTGaqi5lb7FYQMyzwk6SWah8IcLoCp7khshWtHMj22lpd
 QhI6mba6/r8TVFXqvieRBHtQeJKSwTsatvY9WMbYm6ExjMCRunUUN8KnmLRdrzDqnrEs
 0ZAyw1RH1epQMmHV08Uv71dT6cCsQAnxoovjvO1bBUhkjxb9nqZq9pA233PZsWINeqd5
 IMH9LKdivmn5LX5CMllFmb0tPQ9u37QPn+Hm9y4V5yWNML9VmYA36lrpHqYnWx72007f
 93DIID9IljS90PP2HFJCYl6qJE75KO+9JNYHFY240o5fTZXLuRzbSRQ7GR6QRt6mur37
 5HiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ7jzGViBZ8UT/raJGE8YeaQPnn9XOnBnT0mtFZRfy4axa/9YY7yRR8ToCOg2/WOA0wNegSY2a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YytsWpIxW4sl3X79C93Watid5rM9gnBpX3yrA5uBHZLHkPca/Ok
 NEfni7iBdH6C6s+rG1+Xvqqig4c8tKEb1ZkWwHXAYGvUvNbd+AmxTqHtbgJoNQXpcuQ=
X-Gm-Gg: ATEYQzyYR0Sspp3nHpVO0K8h7bWpEYrZjTWpaKY4BB3vRWTloaEevvN78Of9/29FZVr
 AtOEgFt/Q77eUkSS3zi51bps/B+GG1mbRSac7L4VKYYPBUSSkj91reQUaRHRBhSp9p/cQ8D0Pl6
 ZQavcx5ot95HyXF6RMV9pc1dtz2wB7BRBJPTva/nkGmKMgFxxIgkxFfi5ZcnX2ULTkp7fiaXniZ
 v2KamgfyNG4gJl6CZjhVg9R73NAylgTO78A6TiSH0UHRlyszU3sZQDeIbMIrTl/8X96gSjet8ez
 WHaUvA8fYf50Q990QXBaPYRUTKnkazuu4E5ToUlcacnzxb++iexpnv4xNVM812j+nEaTtKFjQcU
 uwx4k+c1i2lNQoPoKUuOEd8HGMmFIizuhPcAyY7hB9EJQelR8ad02cusUfv57/WX+xtwikwmb16
 oqAaUwxxNN0yrERAvchHLIZVQsI+DZ0ONwEIJ2MK2oD8uS
X-Received: by 2002:a05:600c:64cc:b0:480:4d38:7abc with SMTP id
 5b1f17b1804b1-4854b0b950bmr106431115e9.11.1773333243469; 
 Thu, 12 Mar 2026 09:34:03 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a78cesm9410106f8f.11.2026.03.12.09.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 09:34:03 -0700 (PDT)
Message-ID: <4f60cc9f-b4df-480c-9914-fa0c7f8d224c@ursulin.net>
Date: Thu, 12 Mar 2026 16:34:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu: rework amdgpu_userq_wait_ioctl v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-7-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260310191327.2279-7-christian.koenig@amd.com>
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


On 10/03/2026 19:13, Christian König wrote:
> Lockdep was complaining about a number of issues here. Especially lock
> inversion between syncobj, dma_resv and copying things into userspace.
> 
> Rework the functionality. Split it up into multiple functions,
> consistenly use memdup_array_user(), fix the lock inversions and a few

consistently

> more bugs in error handling.
> 
> v2: drop the dma_fence leak fix, turned out that was actually correct,
>      just not well documented. Apply some more cleanup suggestion from
>      Tvrtko.
> v3: rebase on already done cleanups
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 591 ++++++++++--------
>   1 file changed, 325 insertions(+), 266 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 76f32fd768fb..14a289c782ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -617,339 +617,398 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> -int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> -			    struct drm_file *filp)
> +/* Count the number of expected fences so userspace can alloc a buffer */
> +static int
> +amdgpu_userq_wait_count_fences(struct drm_file *filp,
> +			       struct drm_amdgpu_userq_wait *wait_info,
> +			       u32 *syncobj_handles, u32 *timeline_points,
> +			       u32 *timeline_handles,
> +			       struct drm_gem_object **gobj_write,
> +			       struct drm_gem_object **gobj_read)
>   {
> -	struct drm_amdgpu_userq_wait *wait_info = data;
> -	const unsigned int num_write_bo_handles = wait_info->num_bo_write_handles;
> -	const unsigned int num_read_bo_handles = wait_info->num_bo_read_handles;
> -	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct drm_gem_object **gobj_write, **gobj_read;
> -	u32 *timeline_points, *timeline_handles;
> -	struct amdgpu_usermode_queue *waitq = NULL;
> -	u32 *syncobj_handles, num_syncobj;
> -	struct dma_fence **fences = NULL;
> -	u16 num_points, num_fences = 0;
> +	int num_read_bo_handles, num_write_bo_handles;
> +	struct dma_fence_unwrap iter;
> +	struct dma_fence *fence, *f;
> +	unsigned int num_fences = 0;
>   	struct drm_exec exec;
> -	int r, i, cnt;
> -
> -	if (!amdgpu_userq_enabled(dev))
> -		return -ENOTSUPP;
> -
> -	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> -	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> -		return -EINVAL;
> -
> -	num_syncobj = wait_info->num_syncobj_handles;
> -	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
> -					    num_syncobj, sizeof(u32));
> -	if (IS_ERR(syncobj_handles))
> -		return PTR_ERR(syncobj_handles);
> -
> +	int i, r;
> +
> +	/*
> +	 * This needs to be outside of the lock provided by drm_exec for
> +	 * DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT to work correctly.
> +	 */
> +
> +	/* Count timeline fences */
> +	for (i = 0; i < wait_info->num_syncobj_timeline_handles; i++) {
> +		r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +					   timeline_points[i],
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			return r;
> +
> +		dma_fence_unwrap_for_each(f, &iter, fence)
> +			num_fences++;
>   
> -	num_points = wait_info->num_syncobj_timeline_handles;
> -	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> -					     num_points, sizeof(u32));
> -	if (IS_ERR(timeline_handles)) {
> -		r = PTR_ERR(timeline_handles);
> -		goto free_syncobj_handles;
> +		dma_fence_put(fence);
>   	}
>   
> -	timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> -					    num_points, sizeof(u32));
> +	/* Count boolean fences */
> +	for (i = 0; i < wait_info->num_syncobj_handles; i++) {
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			return r;
>   
> -	if (IS_ERR(timeline_points)) {
> -		r = PTR_ERR(timeline_points);
> -		goto free_timeline_handles;
> +		num_fences++;
> +		dma_fence_put(fence);
>   	}
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_read_handles),
> -				   num_read_bo_handles,
> -				   &gobj_read);
> -	if (r)
> -		goto free_timeline_points;
> -
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(wait_info->bo_write_handles),
> -				   num_write_bo_handles,
> -				   &gobj_write);
> -	if (r)
> -		goto put_gobj_read;
> -
> +	/* Lock all the GEM objects */
> +	/* TODO: It is actually not necessary to lock them */
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> +		      num_read_bo_handles + num_write_bo_handles);
>   
> -	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +		if (r)
> +			goto error_unlock;
>   
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +		if (r)
> +			goto error_unlock;
>   	}
>   
> -	if (!wait_info->num_fences) {
> -		if (num_points) {
> -			struct dma_fence_unwrap iter;
> -			struct dma_fence *fence;
> -			struct dma_fence *f;
> -
> -			for (i = 0; i < num_points; i++) {
> -				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> -							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -							   &fence);
> -				if (r)
> -					goto exec_fini;
> -
> -				dma_fence_unwrap_for_each(f, &iter, fence)
> -					num_fences++;
> -
> -				dma_fence_put(fence);
> -			}
> -		}
> +	/* Count read fences */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -		/* Count syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence)
> +			num_fences++;
> +	}
>   
> -			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -						   &fence);
> -			if (r)
> -				goto exec_fini;
> +	/* Count write fences */
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence)
>   			num_fences++;
> -			dma_fence_put(fence);
> -		}
> +	}
>   
> -		/* Count GEM objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +	wait_info->num_fences = num_fences;
> +	r = 0;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence)
> -				num_fences++;
> -		}
> +error_unlock:
> +	/* Unlock all the GEM objects */
> +	drm_exec_fini(&exec);
> +	return r;
> +}
>   
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +static int
> +amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> +				    struct drm_amdgpu_userq_wait *wait_info,
> +				    u32 *syncobj_handles, u32 *timeline_points,
> +				    u32 *timeline_handles,
> +				    struct drm_gem_object **gobj_write,
> +				    struct drm_gem_object **gobj_read)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_fence_info *fence_info;
> +	int num_read_bo_handles, num_write_bo_handles;
> +	struct amdgpu_usermode_queue *waitq;
> +	struct dma_fence **fences, *fence, *f;
> +	struct dma_fence_unwrap iter;
> +	int num_points, num_syncobj;
> +	unsigned int num_fences = 0;
> +	struct drm_exec exec;
> +	int i, cnt, r;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence)
> -				num_fences++;
> -		}
> +	fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
> +				   GFP_KERNEL);
> +	if (!fence_info)
> +		return -ENOMEM;
>   
> -		/*
> -		 * Passing num_fences = 0 means that userspace doesn't want to
> -		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> -		 * userq_fence_info and return the actual number of fences on
> -		 * args->num_fences.
> -		 */
> -		wait_info->num_fences = num_fences;
> -	} else {
> -		/* Array of fence info */
> -		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
> -		if (!fence_info) {
> -			r = -ENOMEM;
> -			goto exec_fini;
> -		}
> +	fences = kmalloc_array(wait_info->num_fences, sizeof(*fences),
> +			       GFP_KERNEL);
> +	if (!fences) {
> +		r = -ENOMEM;
> +		goto free_fence_info;
> +	}
> +
> +	/* Retrieve timeline fences */
> +	num_points = wait_info->num_syncobj_timeline_handles;
> +	for (i = 0; i < num_points; i++) {
> +		r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +					   timeline_points[i],
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
> +
> +		dma_fence_unwrap_for_each(f, &iter, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;

dma_fence_put(fence);

Also, maybe -EAGAIN?

Or even consider dma_fence_dedup_array() and only bail out if it 
couldn't compact it.

> +				goto free_fences;
> +			}
>   
> -		/* Array of fences */
> -		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
> -		if (!fences) {
> -			r = -ENOMEM;
> -			goto free_fence_info;
> +			fences[num_fences++] = dma_fence_get(f);
>   		}
>   
> -		/* Retrieve GEM read objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		dma_fence_put(fence);
> +	}
> +
> +	/* Retrieve boolean fences */
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	for (i = 0; i < num_syncobj; i++) {
> +		struct dma_fence *fence;
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence) {
> -				if (num_fences >= wait_info->num_fences) {
> -					r = -EINVAL;

Same as above.

> -					goto free_fences;
> -				}
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
>   
> -				fences[num_fences++] = fence;
> -				dma_fence_get(fence);
> -			}
> +		if (num_fences >= wait_info->num_fences) {
> +			dma_fence_put(fence);
> +			r = -EINVAL;
> +			goto free_fences;
>   		}
>   
> -		/* Retrieve GEM write objects fence */
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		/* Give the reference to the fence array */
> +		fences[num_fences++] = fence;
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence) {
> -				if (num_fences >= wait_info->num_fences) {
> -					r = -EINVAL;
> -					goto free_fences;
> -				}
> +	/* Lock all the GEM objects */
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      num_read_bo_handles + num_write_bo_handles);
>   
> -				fences[num_fences++] = fence;
> -				dma_fence_get(fence);
> -			}
> -		}
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
> +
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
> +	}
>   
> -		if (num_points) {
> -			struct dma_fence_unwrap iter;
> -			struct dma_fence *fence;
> -			struct dma_fence *f;
> -
> -			for (i = 0; i < num_points; i++) {
> -				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> -							   timeline_points[i],
> -							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -							   &fence);
> -				if (r)
> -					goto free_fences;
> -
> -				dma_fence_unwrap_for_each(f, &iter, fence) {
> -					if (num_fences >= wait_info->num_fences) {
> -						r = -EINVAL;
> -						dma_fence_put(fence);
> -						goto free_fences;
> -					}
> -
> -					dma_fence_get(f);
> -					fences[num_fences++] = f;
> -				}
> -
> -				dma_fence_put(fence);
> +	/* Retrieve GEM read objects fence */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
> +
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;
> +				goto error_unlock;
>   			}
> -		}
>   
> -		/* Retrieve syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> +			fences[num_fences++] = dma_fence_get(fence);
> +		}
> +	}
>   
> -			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -						   &fence);
> -			if (r)
> -				goto free_fences;
> +	/* Retrieve GEM write objects fence */
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence) {
>   			if (num_fences >= wait_info->num_fences) {
>   				r = -EINVAL;
> -				dma_fence_put(fence);
> -				goto free_fences;
> +				goto error_unlock;
>   			}
>   
> -			fences[num_fences++] = fence;
> +			fences[num_fences++] = dma_fence_get(fence);
>   		}
> +	}
>   
> -		/*
> -		 * Keep only the latest fences to reduce the number of values
> -		 * given back to userspace.
> -		 */
> -		num_fences = dma_fence_dedup_array(fences, num_fences);
> +	drm_exec_fini(&exec);
>   
> -		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
> -		if (!waitq) {
> -			r = -EINVAL;
> -			goto free_fences;
> -		}
> +	/*
> +	 * Keep only the latest fences to reduce the number of values
> +	 * given back to userspace.
> +	 */
> +	num_fences = dma_fence_dedup_array(fences, num_fences);
>   
> -		for (i = 0, cnt = 0; i < num_fences; i++) {
> -			struct amdgpu_userq_fence_driver *fence_drv;
> -			struct amdgpu_userq_fence *userq_fence;
> -			u32 index;
> -
> -			userq_fence = to_amdgpu_userq_fence(fences[i]);
> -			if (!userq_fence) {
> -				/*
> -				 * Just waiting on other driver fences should
> -				 * be good for now
> -				 */
> -				r = dma_fence_wait(fences[i], true);
> -				if (r) {
> -					dma_fence_put(fences[i]);
> -					goto free_fences;
> -				}
> -
> -				dma_fence_put(fences[i]);
> -				continue;
> -			}
> +	waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
> +	if (!waitq) {
> +		r = -EINVAL;
> +		goto free_fences;
> +	}
> +
> +	for (i = 0, cnt = 0; i < num_fences; i++) {
> +		struct amdgpu_userq_fence_driver *fence_drv;
> +		struct amdgpu_userq_fence *userq_fence;
> +		u32 index;
>   
> -			fence_drv = userq_fence->fence_drv;
> +		userq_fence = to_amdgpu_userq_fence(fences[i]);
> +		if (!userq_fence) {
>   			/*
> -			 * We need to make sure the user queue release their reference
> -			 * to the fence drivers at some point before queue destruction.
> -			 * Otherwise, we would gather those references until we don't
> -			 * have any more space left and crash.
> +			 * Just waiting on other driver fences should
> +			 * be good for now
>   			 */
> -			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
> -				     xa_limit_32b, GFP_KERNEL);

Does it need to put potentially the same fence_drv multiple times into 
the same xarray?

> +			r = dma_fence_wait(fences[i], true);
>   			if (r)
> -				goto free_fences;
> +				goto put_waitq;
> +
> +			continue;
> +		}
>   
> -			amdgpu_userq_fence_driver_get(fence_drv);
> +		fence_drv = userq_fence->fence_drv;
> +		/*
> +		 * We need to make sure the user queue release their reference
> +		 * to the fence drivers at some point before queue destruction.
> +		 * Otherwise, we would gather those references until we don't
> +		 * have any more space left and crash.
> +		 */
> +		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
> +			     xa_limit_32b, GFP_KERNEL);
> +		if (r)
> +			goto put_waitq;
>   
> -			/* Store drm syncobj's gpu va address and value */
> -			fence_info[cnt].va = fence_drv->va;
> -			fence_info[cnt].value = fences[i]->seqno;
> +		amdgpu_userq_fence_driver_get(fence_drv);
>   
> -			dma_fence_put(fences[i]);
> -			/* Increment the actual userq fence count */
> -			cnt++;
> -		}
> +		/* Store drm syncobj's gpu va address and value */
> +		fence_info[cnt].va = fence_drv->va;
> +		fence_info[cnt].value = fences[i]->seqno;
>   
> -		wait_info->num_fences = cnt;
> -		/* Copy userq fence info to user space */
> -		if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> -				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> -			r = -EFAULT;
> -			goto free_fences;
> -		}
> +		/* Increment the actual userq fence count */
> +		cnt++;
>   	}
> +	wait_info->num_fences = cnt;
> +
> +	/* Copy userq fence info to user space */
> +	if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> +			 fence_info, cnt * sizeof(*fence_info)))
> +		r = -EFAULT;
> +	else
> +		r = 0;
> +
> +put_waitq:
> +	amdgpu_userq_put(waitq);
>   
>   free_fences:
> -	if (fences) {
> -		while (num_fences-- > 0)
> -			dma_fence_put(fences[num_fences]);
> -		kfree(fences);
> -	}
> +	while (num_fences--)
> +		dma_fence_put(fences[num_fences]);
> +	kfree(fences);
> +
>   free_fence_info:
>   	kfree(fence_info);
> -exec_fini:
> +	return r;
> +
> +error_unlock:
>   	drm_exec_fini(&exec);
> -put_gobj_write:
> -	for (i = 0; i < num_write_bo_handles; i++)
> -		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +	goto free_fences;
> +}
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
> +	u32 *syncobj_handles, *timeline_points, *timeline_handles;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct drm_gem_object **gobj_write;
> +	struct drm_gem_object **gobj_read;
> +	void __user *ptr;
> +	int r;
> +
> +	if (!amdgpu_userq_enabled(dev))
> +		return -ENOTSUPP;
> +
> +	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
> +	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
> +		return -EINVAL;
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
> +	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);
> +
> +	num_points = wait_info->num_syncobj_timeline_handles;
> +	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_handles);
> +	timeline_handles = memdup_array_user(ptr, num_points, sizeof(u32));
> +	if (IS_ERR(timeline_handles)) {
> +		r = PTR_ERR(timeline_handles);
> +		goto free_syncobj_handles;
> +	}
> +
> +	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
> +	timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
> +	if (IS_ERR(timeline_points)) {
> +		r = PTR_ERR(timeline_points);
> +		goto free_timeline_handles;
> +	}
> +
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	ptr = u64_to_user_ptr(wait_info->bo_read_handles),
> +	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
> +	if (r)
> +		goto free_timeline_points;
> +
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	ptr = u64_to_user_ptr(wait_info->bo_write_handles),
> +	r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
> +				   &gobj_write);
> +	if (r)
> +		goto put_gobj_read;
> +
> +	/*
> +	 * Passing num_fences = 0 means that userspace doesn't want to
> +	 * retrieve userq_fence_info. If num_fences = 0 we skip filling
> +	 * userq_fence_info and return the actual number of fences on
> +	 * args->num_fences.
> +	 */
> +	if (!wait_info->num_fences) {
> +		r = amdgpu_userq_wait_count_fences(filp, wait_info,
> +						   syncobj_handles,
> +						   timeline_points,
> +						   timeline_handles,
> +						   gobj_write,
> +						   gobj_read);
> +	} else {
> +		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +							syncobj_handles,
> +							timeline_points,
> +							timeline_handles,
> +							gobj_write,
> +							gobj_read);
> +	}
> +
> +	while (num_write_bo_handles--)
> +		drm_gem_object_put(gobj_write[num_write_bo_handles]);
> +	kvfree(gobj_write);
> +
>   put_gobj_read:
> -	for (i = 0; i < num_read_bo_handles; i++)
> -		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +	while (num_read_bo_handles--)
> +		drm_gem_object_put(gobj_read[num_read_bo_handles]);
> +	kvfree(gobj_read);
> +
>   free_timeline_points:
>   	kfree(timeline_points);
>   free_timeline_handles:
>   	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
> -
> -	if (waitq)
> -		amdgpu_userq_put(waitq);
> -
>   	return r;
>   }

The rest looks good. In my RFC I found a way to not duplicate the 
various fence walks between the counting and waiting, but yours works as 
well.

Regards,

Tvrtko


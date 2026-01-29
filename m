Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0089AD6101A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 14:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C97D10E053;
	Thu, 29 Jan 2026 14:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="uJcJnkZT";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DB310E053
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 14:53:21 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so10996155e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1769698400; x=1770303200; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UlPd3Ad3sMPjWBAGRTmuQd3nCBtRxCGUNORxuosmhys=;
 b=uJcJnkZTSNTSkvA+kBzBLeyfzgXEp4FZF1uOHh+v1iq4tZUsZo/8zwiwekXV+zzneO
 QT9ANRv9k6HQAvvdwgYUgPkidkppatA1zkxeB1Bp+pyd5f7XbwaijbXZ+H3PcjTGtX4G
 Ni4PK8SYxP5wAsgTrtggbx8Nt817Gr5RYKtBhFCt7+FfwCBVY4re7Cue/V5/HbrQgwKi
 CqUTSEppl1eREetVytEqPng+G7GHmZ/pQcOiQB70/sAI2mK04T+kJkoBzjrrd01MIJUI
 Mltqh1XIHrGuZ+01baLkqmcxJlnrAs1H6wwjCfYmmHJXumCv1pLXPjTOutEz8OzDuzue
 ggqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698400; x=1770303200;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UlPd3Ad3sMPjWBAGRTmuQd3nCBtRxCGUNORxuosmhys=;
 b=KWHw2nfQ62GEAeN2NivRbn/ZVuYzFXGI/7vpM4stHa0E2hHQbJsn0qpkdkWHbY3jqD
 QwFthw6Iu9j5LqzjmNzUESnkEDirhgifBwQC3je1ODWTdF7lzyp2I5OZBxZreWnshmcc
 Bk5IlGjs4n1CDYNNTa+8Zu8WJv/eSTBjhKRE01Yuk/y55oODxjpXnd5EKdynIwvHMZAu
 3SLtPGXIlQXT+HtELADQVz5929JmdSGBe9rzn31GUOiOknmm5zOHrw7PfOgF0bqz3BZR
 ++se/JSm8u9akFQUcemcVg6bIHJ+o0PROOjNcizHJAJt5Qg2D29w1WkJJKqcb9L7Jg95
 WAZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSTuxEC2a6C/xWpADtWinuoUfKmvjwQkVHqYIEpEGJqrHVA1M7udu41VQOAr2Bfu4jc8jofhNR@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzz+GmHB6VfoAvjPj0PqRetVEjMGuEjUqZblu1vvGZKDEXJUXn0
 D/iKtuxAp+SU3BJVDVwqlCGwvoW5szKM9iu19BW+xcHanP8dYTIvnr7TrMHnH80dnyg=
X-Gm-Gg: AZuq6aI9ZKO5gZb6rvGFk+M0yurG+nq5Oq7qnGJ1UsPD1JW5/Vuhr4hllg1t0lOzRLQ
 QdiQa++SLrF5GYS+IaVouc+ZbGAR/0l8JlsCrhDqqMeFdwX4H3+149qbcAWVkY0WO9KM+eVL3/+
 sQoqtyg5m1s5ODRTZOU9h3lDl3HY1IJQXl/b1w7kejGEL/84hr8r83RSC274MVp21yP2+YH2qk7
 rjy1eqRPOaKrOcoVvSsVhZ9ijjnpq069QWnA8Me3Rlz+xD9rLe1tzAPjznCQ+KyhO4yt82i6dOt
 mQdT4PO++I2L91Mp1eOsEFApRy3foNsnY7LeJX8rTmDZnUUfXCgjs90+SMiwsGhSPIHg9LEQyC2
 DzQfGLC2MPp/dGXUYjgAM/0vT/iAmyECVheLRVYr7oQpRe/zNc53u6/1qpx0sQd+51EWTBRaxFA
 dy6rORDixyaK0gvKV/fQT83RJnJRxHR9/b
X-Received: by 2002:a05:600c:a44:b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-48069c2098cmr113510735e9.9.1769698398701; 
 Thu, 29 Jan 2026 06:53:18 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56068sm126907435e9.13.2026.01.29.06.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 06:53:18 -0800 (PST)
Message-ID: <30a8e0b3-f875-4fca-add6-986dca41ebe2@ursulin.net>
Date: Thu, 29 Jan 2026 14:53:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu: rework amdgpu_userq_wait_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260129125327.11786-1-christian.koenig@amd.com>
 <20260129125327.11786-6-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260129125327.11786-6-christian.koenig@amd.com>
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


On 29/01/2026 12:53, Christian König wrote:
> Lockdep was complaining about a number of issues here. Especially lock
> inversion between syncobj, dma_resv and copying things into userspace.
> 
> Rework the functionality. Split it up into multiple functions,
> consistenly use memdup_array_user(), fix the lock inversions, a few
> more bugs in error handling and a leak of dma_fence references.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 633 ++++++++++--------
>   1 file changed, 349 insertions(+), 284 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 212056d4ddf0..ee8a5fbbd53b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -645,361 +645,426 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> -	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
> -	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
> -	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> -	struct drm_amdgpu_userq_wait *wait_info = data;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct amdgpu_usermode_queue *waitq;
> -	struct drm_gem_object **gobj_write;
> -	struct drm_gem_object **gobj_read;
> -	struct dma_fence **fences = NULL;
> -	u16 num_points, num_fences = 0;
> -	int r, i, rentry, wentry, cnt;
> +	int num_read_bo_handles, num_write_bo_handles;
> +	struct dma_fence_unwrap iter;
> +	struct dma_fence *fence, *f;
> +	unsigned int num_fences = 0;
>   	struct drm_exec exec;
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
> -	if (!amdgpu_userq_enabled(dev))
> -		return -ENOTSUPP;
> +		dma_fence_put(fence);
> +	}
>   
> -	num_read_bo_handles = wait_info->num_bo_read_handles;
> -	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
> -				      size_mul(sizeof(u32), num_read_bo_handles));
> -	if (IS_ERR(bo_handles_read))
> -		return PTR_ERR(bo_handles_read);
> +	/* Count boolean fences */
> +	for (i = 0; i < wait_info->num_syncobj_handles; i++) {
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			return r;
>   
> -	num_write_bo_handles = wait_info->num_bo_write_handles;
> -	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
> -				       size_mul(sizeof(u32), num_write_bo_handles));
> -	if (IS_ERR(bo_handles_write)) {
> -		r = PTR_ERR(bo_handles_write);
> -		goto free_bo_handles_read;
> +		num_fences++;
> +		dma_fence_put(fence);
>   	}
>   
> -	num_syncobj = wait_info->num_syncobj_handles;
> -	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
> -				      size_mul(sizeof(u32), num_syncobj));
> -	if (IS_ERR(syncobj_handles)) {
> -		r = PTR_ERR(syncobj_handles);
> -		goto free_bo_handles_write;
> -	}
> +	/* Lock all the GEM objects */
> +	/* TODO: It is actually not necessary to lock them */
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> +		      num_read_bo_handles + num_write_bo_handles);
>   
> -	num_points = wait_info->num_syncobj_timeline_handles;
> -	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> -				       sizeof(u32) * num_points);
> -	if (IS_ERR(timeline_handles)) {
> -		r = PTR_ERR(timeline_handles);
> -		goto free_syncobj_handles;
> -	}
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
>   
> -	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> -				      sizeof(u32) * num_points);
> -	if (IS_ERR(timeline_points)) {
> -		r = PTR_ERR(timeline_points);
> -		goto free_timeline_handles;
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
>   	}
>   
> -	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
> -	if (!gobj_read) {
> -		r = -ENOMEM;
> -		goto free_timeline_points;
> -	}
> +	/* Count read fences */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
> -		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
> -		if (!gobj_read[rentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_read;
> -		}
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence)
> +			num_fences++;
>   	}
>   
> -	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
> -	if (!gobj_write) {
> -		r = -ENOMEM;
> -		goto put_gobj_read;
> -	}
> +	/* Count write fences */
> +	for (i = 0; i < num_write_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
> -		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
> -		if (!gobj_write[wentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_write;
> -		}
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence)
> +			num_fences++;
>   	}
>   
> -	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> -		      (num_read_bo_handles + num_write_bo_handles));
> -
> -	/* Lock all BOs with retry handling */
> -	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> +	wait_info->num_fences = num_fences;
> +	r = 0;
>   
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> -		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			drm_exec_fini(&exec);
> -			goto put_gobj_write;
> -		}
> -	}
> +error_unlock:
> +	/* Unlock all the GEM objects */
> +	drm_exec_fini(&exec);
> +	return r;
> +}
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
> -		/* Count syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> +	fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info),
> +				   GFP_KERNEL);
> +	if (!fence_info)
> +		return -ENOMEM;
>   
> -			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0,
> -						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> -						   &fence);
> -			if (r)
> -				goto exec_fini;
> +	fences = kmalloc_array(wait_info->num_fences, sizeof(*fences),
> +			       GFP_KERNEL);
> +	if (!fences) {
> +		r = -ENOMEM;
> +		goto free_fence_info;
> +	}
>   
> -			num_fences++;
> -			dma_fence_put(fence);
> -		}
> +	/* Retrieve timeline fences */
> +	num_points = wait_info->num_syncobj_timeline_handles;
> +	for (i = 0; i < num_points; i++) {
> +		r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +					   timeline_points[i],
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
>   
> -		/* Count GEM objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		dma_fence_unwrap_for_each(f, &iter, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;
> +				goto free_fences;
> +			}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence)
> -				num_fences++;
> +			fences[num_fences++] = dma_fence_get(f);
>   		}
>   
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		dma_fence_put(fence);
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence)
> -				num_fences++;
> -		}
> +	/* Retrieve boolean fences */
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	for (i = 0; i < num_syncobj; i++) {
> +		struct dma_fence *fence;
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
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0,
> +					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +					   &fence);
> +		if (r)
> +			goto free_fences;
>   
> -		/* Array of fences */
> -		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
> -		if (!fences) {
> -			r = -ENOMEM;
> -			goto free_fence_info;
> +		if (num_fences >= wait_info->num_fences) {
> +			r = -EINVAL;
> +			goto free_fences;
>   		}
>   
> -		/* Retrieve GEM read objects fence */
> -		for (i = 0; i < num_read_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		fences[num_fences++] = fence;
> +		dma_fence_put(fence);
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> -						DMA_RESV_USAGE_READ, fence) {
> -				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
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
>   
> -		/* Retrieve GEM write objects fence */
> -		for (i = 0; i < num_write_bo_handles; i++) {
> -			struct dma_resv_iter resv_cursor;
> -			struct dma_fence *fence;
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (r)
> +			goto error_unlock;
> +	}
>   
> -			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> -						DMA_RESV_USAGE_WRITE, fence) {
> -				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> -					r = -EINVAL;
> -					goto free_fences;
> -				}
> +	/* Retrieve GEM read objects fence */
> +	for (i = 0; i < num_read_bo_handles; i++) {
> +		struct dma_resv_iter resv_cursor;
> +		struct dma_fence *fence;
>   
> -				fences[num_fences++] = fence;
> -				dma_fence_get(fence);
> +		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
> +					DMA_RESV_USAGE_READ, fence) {
> +			if (num_fences >= wait_info->num_fences) {
> +				r = -EINVAL;
> +				goto error_unlock;
>   			}
> -		}
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
> -					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> -						r = -EINVAL;
> -						goto free_fences;
> -					}
> -
> -					dma_fence_get(f);
> -					fences[num_fences++] = f;
> -				}
> -
> -				dma_fence_put(fence);
> -			}
> +			fences[num_fences++] = fence;
> +			dma_fence_get(fence);
>   		}
> +	}
>   
> -		/* Retrieve syncobj's fence */
> -		for (i = 0; i < num_syncobj; i++) {
> -			struct dma_fence *fence;
> -
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
> -			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
> +					DMA_RESV_USAGE_WRITE, fence) {
> +			if (num_fences >= wait_info->num_fences) {
>   				r = -EINVAL;
> -				goto free_fences;
> +				goto error_unlock;
>   			}
>   
>   			fences[num_fences++] = fence;
> +			dma_fence_get(fence);
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
> -		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
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
> +	waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
> +	if (!waitq) {
> +		r = -EINVAL;
> +		goto free_fences;
> +	}
>   
> -				dma_fence_put(fences[i]);
> -				continue;
> -			}
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
> -			if (r)
> +			r = dma_fence_wait(fences[i], true);
> +			if (r) {
> +				dma_fence_put(fences[i]);
>   				goto free_fences;
> -
> -			amdgpu_userq_fence_driver_get(fence_drv);
> -
> -			/* Store drm syncobj's gpu va address and value */
> -			fence_info[cnt].va = fence_drv->va;
> -			fence_info[cnt].value = fences[i]->seqno;
> +			}
>   
>   			dma_fence_put(fences[i]);
> -			/* Increment the actual userq fence count */
> -			cnt++;
> +			continue;
>   		}
>   
> -		wait_info->num_fences = cnt;
> -		/* Copy userq fence info to user space */
> -		if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> -				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
> -			r = -EFAULT;
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
>   			goto free_fences;
> -		}
>   
> -		kfree(fences);
> -		kfree(fence_info);
> -	}
> +		amdgpu_userq_fence_driver_get(fence_drv);
>   
> -	drm_exec_fini(&exec);
> -	for (i = 0; i < num_read_bo_handles; i++)
> -		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +		/* Store drm syncobj's gpu va address and value */
> +		fence_info[cnt].va = fence_drv->va;
> +		fence_info[cnt].value = fences[i]->seqno;
>   
> -	for (i = 0; i < num_write_bo_handles; i++)
> -		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +		dma_fence_put(fences[i]);
> +		/* Increment the actual userq fence count */
> +		cnt++;
> +	}
> +	/* The refcount in the array is already decremented */
> +	num_fences = 0;
>   
> -	kfree(timeline_points);
> -	kfree(timeline_handles);
> -	kfree(syncobj_handles);
> -	kfree(bo_handles_write);
> -	kfree(bo_handles_read);
> +	wait_info->num_fences = cnt;
> +	r = 0;
>   
> -	return 0;
> +	/* Copy userq fence info to user space */
> +	if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
> +			 fence_info, cnt * sizeof(*fence_info))) {
> +		r = -EFAULT;
> +	}
>   
>   free_fences:
> -	while (num_fences-- > 0)
> +	while (num_fences--)
>   		dma_fence_put(fences[num_fences]);
>   	kfree(fences);
> +
>   free_fence_info:
>   	kfree(fence_info);
> -exec_fini:
> +	return r;
> +
> +error_unlock:
>   	drm_exec_fini(&exec);
> +	goto free_fences;
> +}
> +
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
> +	u32 *syncobj_handles, *timeline_points, *timeline_handles,
> +	    *bo_handles_read, *bo_handles_write;
> +	struct drm_amdgpu_userq_wait *wait_info = data;
> +	struct drm_gem_object **gobj_write;
> +	struct drm_gem_object **gobj_read;
> +	int r, rentry, wentry;
> +	void __user *ptr;
> +
> +	if (!amdgpu_userq_enabled(dev))
> +		return -ENOTSUPP;
> +
> +	ptr = u64_to_user_ptr(wait_info->bo_read_handles);
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	bo_handles_read = memdup_array_user(ptr, num_read_bo_handles,
> +					    sizeof(u32));
> +	if (IS_ERR(bo_handles_read))
> +		return PTR_ERR(bo_handles_read);
> +
> +	ptr = u64_to_user_ptr(wait_info->bo_write_handles);
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
> +	bo_handles_write = memdup_array_user(ptr, num_write_bo_handles,
> +					     sizeof(u32));
> +	if (IS_ERR(bo_handles_write)) {
> +		r = PTR_ERR(bo_handles_write);
> +		goto free_bo_handles_read;
> +	}
> +
> +	num_syncobj = wait_info->num_syncobj_handles;
> +	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
> +	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));
> +	if (IS_ERR(syncobj_handles)) {
> +		r = PTR_ERR(syncobj_handles);
> +		goto free_bo_handles_write;
> +	}
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
> +	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read),
> +				  GFP_KERNEL);
> +	if (!gobj_read) {
> +		r = -ENOMEM;
> +		goto free_timeline_points;
> +	}
> +
> +	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
> +		u32 handle = bo_handles_read[rentry];
> +
> +		gobj_read[rentry] = drm_gem_object_lookup(filp, handle);

FWIW this can likely be further compacted by using 
drm_gem_objects_lookup as I tried in:

https://lore.kernel.org/amd-gfx/20251205134035.91551-5-tvrtko.ursulin@igalia.com/

and

https://lore.kernel.org/amd-gfx/20251205134035.91551-6-tvrtko.ursulin@igalia.com/

> +		if (!gobj_read[rentry]) {
> +			r = -ENOENT;
> +			goto put_gobj_read;
> +		}
> +	}
> +
> +	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write),
> +				   GFP_KERNEL);
> +	if (!gobj_write) {
> +		r = -ENOMEM;
> +		goto put_gobj_read;
> +	}
> +
> +	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
> +		u32 handle = bo_handles_write[wentry];
> +
> +		gobj_write[wentry] = drm_gem_object_lookup(filp, handle);
> +		if (!gobj_write[wentry]) {
> +			r = -ENOENT;
> +			goto put_gobj_write;
> +		}
> +	}
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

This also is potentially doable without the two copies of all the loops 
which walk over syncobjs, syncpoints and gem handles, like in:

https://lore.kernel.org/amd-gfx/20251205134035.91551-9-tvrtko.ursulin@igalia.com/

Anyway, I see that you are fixing some deeper problems as well so now I 
understand why I got no feedback on that whole series. :)

Still, there might be some small patches there worth revisiting but I 
can do that when the dust settles.

Regards,

Tvrtko

> +	}
> +
>   put_gobj_write:
>   	while (wentry-- > 0)
>   		drm_gem_object_put(gobj_write[wentry]);


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2BCE73170
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 13:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403F510E2AA;
	Mon,  2 Feb 2026 13:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Xl6fbrmQ";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4E110E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 13:37:28 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-481188b7760so29123335e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 05:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1770039447; x=1770644247; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ihEDo1XenFjKAt0+DH40/v9p11rVh96suOJtvqDO1w=;
 b=Xl6fbrmQ5DAqiNGbHm1ImQPvk6JiP7QE/8TO2AEBhw+EYVkY75irH5zkO7yzxHk2/C
 3LTzdGjh+dUOIyLOdw4cbC35fBaFtz4jGNjFd0IJdZlC9XpmKP9lpjS1Ki1k47EzNh00
 vzkAay/hkhAH3POGzBEX4jHU0tNsTmB336JHI00f6e06yDHejGb4ND659asRgUdOYVbQ
 SkAv9IL9hosOKwmEl67ChMMVEMFKOugONGogxdszcO9kdQk3fWJpU3ylLbOUb2hy1gwN
 mMIV56rmQNQ7HEHqIjzcASOpPvTTDz3EKwwvSrL9gepJGraebkp+5Tv85Gww3KYub75V
 poUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039447; x=1770644247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ihEDo1XenFjKAt0+DH40/v9p11rVh96suOJtvqDO1w=;
 b=u7k5b6Kths+YTcCjyfRzyt44vsPVs30EkAXLfdOz29pOnYPORCz8m9LAE/T6Cms8e/
 FcUhNzZGQrUOfveKDvwFESDylQPZ42r7GRNng64itbga9sUwctL3loD3RRQpdQS21Hik
 q2YaQCSoVmQrFKN0ywJZ5Tx3RPvvmgduNcXXIzbl3cj0F6wF5m3QMIWbtGQDXvWXxtnP
 krnPVbcfGyBqsOe13F6cveH9Wxd9ForLzKMyGATwPSKRg4s4aFviXNqiyDPms7rF4Byv
 YTuFEaCjqaFzk18B6HCmjgdVrDTBGZRve31bCewpcKebfLo1WSvzGQbNPf6ySIvpHotf
 dMHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOkqknbfo9g80sQ4JbFE87K/evc+MJZJuaTvBDlm/xgb/NmV2O8Acoig63uERlb+Q4CvupG8T/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3Mn1AYiRFVqcbL0sLL8Vi7RyGObAmVVJqXGZigu/4XTmTSEtS
 4fi5J9edhNr665RM+Wqpz/6UGXZpiwv2RHXCSXoxkBJd48+5LVM/3aQO36LZJCBYizc=
X-Gm-Gg: AZuq6aJOgstoiNClKWzU12/8WeHBQd2KarNaUydbGhCuvGrxv+GouKD9MIYowKXfqvM
 GLevVlZ823BxdbgksFzYH1dqZoAyO0BcMShSXmfylsunUtb1Vd98GebUm7hQYoceaYydCqHbevv
 kXKNFzzf1x0wGihFiYiP0oagNbxxkrTZNdVOXFlA59atWMd/82TRhU3KFrM9IxJ7BW26ttY96P6
 yAQCALM3CWUpNrz9E12+NtdOFjOQDDuMI/rtEUpg42uTiiTH9uD9sL0662ZSZhJf0jsZc1gQPmn
 0Jbcq+Qi5bsB9jb8rg+VE13lsDFFVSLzlrvrhlt7dVDcCD+jOR6AuIi7D87GmlqFOJi+/mglRWd
 uxa/TwOvBa2w7KfPfv72ExLC1avFz3LXWFtf4rnpoiyI+P16KlDmJRpnKFWsV+F9vdPLiImaTCF
 dB2J/vGFCbCmDcRN1DSFEYXCxrUiXZ7bNK
X-Received: by 2002:a05:600c:c4a1:b0:479:3a89:121d with SMTP id
 5b1f17b1804b1-482db4b5c95mr152333015e9.36.1770039447174; 
 Mon, 02 Feb 2026 05:37:27 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e267aad1sm90180095e9.15.2026.02.02.05.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 05:37:26 -0800 (PST)
Message-ID: <c54dc7c0-de57-4219-a2ad-d73e84c9f49e@ursulin.net>
Date: Mon, 2 Feb 2026 13:37:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu: rework amdgpu_userq_wait_ioctl v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-7-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260202125149.2067-7-christian.koenig@amd.com>
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


On 02/02/2026 12:51, Christian König wrote:
> Lockdep was complaining about a number of issues here. Especially lock
> inversion between syncobj, dma_resv and copying things into userspace.
> 
> Rework the functionality. Split it up into multiple functions,
> consistenly use memdup_array_user(), fix the lock inversions and a few
> more bugs in error handling.
> 
> v2: drop the dma_fence leak fix, turned out that was actually correct,
>      just not well documented. Apply some more cleanup suggestion from
>      Tvrtko.

Which dma_fence leak was that? The two I thought I found in
https://lore.kernel.org/amd-gfx/20251205134035.91551-2-tvrtko.ursulin@igalia.com/, 
ie:

	/* Retrieve timeline fences */
	num_points = wait_info->num_syncobj_timeline_handles;
	for (i = 0; i < num_points; i++) {
		r = drm_syncobj_find_fence(filp, timeline_handles[i],
					   timeline_points[i],
					   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
					   &fence);
		if (r)
			goto free_fences;

		dma_fence_unwrap_for_each(f, &iter, fence) {
			r = amdgpu_userq_wait_add_fence(wait_info, fences,
							&num_fences, f);
			if (r)
				goto free_fences;

^^^ Error path leaks fence. It doesn't?

		dma_fence_put(fence);
	}

Regards,

Tvrtko

> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 614 +++++++++---------
>   1 file changed, 319 insertions(+), 295 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 212056d4ddf0..da329d00843b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -645,368 +645,397 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> +		/* Give the reference to the fence array */
> +		fences[num_fences++] = fence;
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
> +			fences[num_fences++] = dma_fence_get(fence);
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
> -put_gobj_write:
> -	while (wentry-- > 0)
> -		drm_gem_object_put(gobj_write[wentry]);
> +	goto free_fences;
> +}
> +
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
> +	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read),
> +				  GFP_KERNEL);
> +	if (!gobj_read) {
> +		r = -ENOMEM;
> +		goto free_timeline_points;
> +	}
> +
> +	ptr = u64_to_user_ptr(wait_info->bo_read_handles);
> +	num_read_bo_handles = wait_info->num_bo_read_handles;
> +	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
> +	if (r)
> +		goto free_timeline_points;
> +
> +	ptr = u64_to_user_ptr(wait_info->bo_write_handles);
> +	num_write_bo_handles = wait_info->num_bo_write_handles;
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
>   	kfree(gobj_write);
>   put_gobj_read:
> -	while (rentry-- > 0)
> -		drm_gem_object_put(gobj_read[rentry]);
> +	while (num_read_bo_handles--)
> +		drm_gem_object_put(gobj_read[num_read_bo_handles]);
>   	kfree(gobj_read);
>   free_timeline_points:
>   	kfree(timeline_points);
> @@ -1014,10 +1043,5 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
> -free_bo_handles_write:
> -	kfree(bo_handles_write);
> -free_bo_handles_read:
> -	kfree(bo_handles_read);
> -
>   	return r;
>   }


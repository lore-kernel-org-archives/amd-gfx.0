Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAAECCFA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 11:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9AA10EAF3;
	Thu, 26 Sep 2024 11:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bPhxci7U";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128FE10EAF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 11:49:06 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so7133265e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727351344; x=1727956144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GgO99B6Ivt6jNIbSgf63wgFRWduq0iNPNzfEp1e3M7c=;
 b=bPhxci7UKabG9hREE+ddPpPTA3DwejukTDBNFnLJyqb+9LdVh1DF6nGvWleie6mTua
 Ueff1JKuLj+xtFgrBfdRH2ybYdyaqHW5yNMVk8UGs1cG944quVk4qZQRjPP4VBuqwM8t
 ZoqIgyZIeT19qfMgtXOpCyFV8sFopvY9bXN6c/UCVjWRofLelE9KYfC+oRmbZoohmXgd
 9Xha+vkVXJ+OOvvjrJnQrRANnacic19wT6U2tBJWUEEVZBK8eYuZSR0OUN45vKQ21H8L
 lFYvRO83BA3qJNk5vSpD12+22qPwFmJLLWSdhVk3eZctSLbssiKIag7hkIgfKT3roNKX
 5Kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727351344; x=1727956144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GgO99B6Ivt6jNIbSgf63wgFRWduq0iNPNzfEp1e3M7c=;
 b=W22avywG9ocuCq/CZk/YT9IfASey1Bck5mk5F3n0quI3o3aciq/lYUx6L1dzFRcKqb
 UTwfCqICnvf87LdRaxVKgZHSf0sM8f6GbEhv7RSLYjKbFLlUiPvoGtCb7hb3H3eEDlgo
 U878W7jPMf/UKJ3IpVCWoL6msRUe3MOYCiDtjMkuoCrsTMBMCR+kErB1GTS8kEp+qS6d
 jgYbcJFIazqfAJrYJ6dq+Ep4QuIek8hDq/IFF/f+jLeUqFg6Am9k9dQ1TkhAla78/2zo
 ikHA/dpQWgnz5lwk3o8LsC2o1/zPa9GLN+Z/vGF9A3cQuTcWsIoLSIQvwNHO5pkmmG3W
 v5gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA5OKGTZDu7xYa4TXdR6+h5khXM7TmCGx/SWUmqsh6h5q1DXnE7+SSAWN3VJ/w0f0CioKUib//@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdtQjPdzr81hI7vV16STN9vyVrvDPAvrYRGyvtIFnY1r7uUY93
 HOXPTYwpYZDqAXuAVeIkcP4OTdyFn8FPbBjrL+Xp0VU9+TY229x6svtYMXFK
X-Google-Smtp-Source: AGHT+IHLY4mliIwA/1gf3TeJJiVXMM15KS3BkUIjAg2PdmOfQN8tVxnZEdpRaZIrNJUQ2cGulC6udQ==
X-Received: by 2002:a05:600c:3d08:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-42e9611919fmr44088545e9.20.1727351344196; 
 Thu, 26 Sep 2024 04:49:04 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2c1acasm6219979f8f.32.2024.09.26.04.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 04:49:03 -0700 (PDT)
Message-ID: <c4503a08-18c3-4ecc-a60b-3bdb8f709805@gmail.com>
Date: Thu, 26 Sep 2024 13:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/08] drm/amdgpu: Add wait IOCTL timeline syncobj
 support
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <20240925195928.142001-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240925195928.142001-3-Arunpravin.PaneerSelvam@amd.com>
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

Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
> Add user fence wait IOCTL timeline syncobj support.
>
> v2:(Christian)
>    - handle dma_fence_wait() return value.
>    - shorten the variable name syncobj_timeline_points a bit.
>    - move num_points up to avoid padding issues.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 82 +++++++++++++++++--
>   include/uapi/drm/amdgpu_drm.h                 | 16 +++-
>   2 files changed, 88 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 97b1af574407..2465ca307644 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -474,11 +474,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> +	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
> +	u32 num_syncobj, num_bo_handles, num_points;
>   	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>   	struct drm_amdgpu_userq_wait *wait_info = data;
> -	u32 *syncobj_handles, *bo_handles;
>   	struct dma_fence **fences = NULL;
> -	u32 num_syncobj, num_bo_handles;
>   	struct drm_gem_object **gobj;
>   	struct drm_exec exec;
>   	int r, i, entry, cnt;
> @@ -498,11 +498,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_bo_handles;
>   	}
>   
> +	num_points = wait_info->num_points;
> +	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> +				       sizeof(u32) * num_points);
> +	if (IS_ERR(timeline_handles)) {
> +		r = PTR_ERR(timeline_handles);
> +		goto free_syncobj_handles;
> +	}
> +
> +	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> +				      sizeof(u32) * num_points);
> +	if (IS_ERR(timeline_points)) {
> +		r = PTR_ERR(timeline_points);
> +		goto free_timeline_handles;
> +	}
> +
>   	/* Array of GEM object handles */
>   	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>   	if (!gobj) {
>   		r = -ENOMEM;
> -		goto free_syncobj_handles;
> +		goto free_timeline_points;
>   	}
>   
>   	for (entry = 0; entry < num_bo_handles; entry++) {
> @@ -524,17 +539,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	if (!wait_info->num_fences) {
> +		if (num_points) {
> +			struct dma_fence *fence;
> ++
> +			for (i = 0; i < num_points; i++) {
> +				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +							   timeline_points[i],
> +							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   &fence);
> +				if (r || !fence)

You can't simply ignore errors here. That needs some goto error handling 
and cleanup.

> +					continue;
> +
> +				dma_fence_put(fence);
> +				num_fences++;

There can be more than one fence in the timeline we need to wait for. 
You should probably use dma_fence_unwrap_for_each() here.

> +			}
> +		}
> +
>   		/* Count syncobj's fence */
>   		for (i = 0; i < num_syncobj; i++) {
>   			struct dma_fence *fence;
>   
>   			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0, 0, &fence);
> -			dma_fence_put(fence);
> -
> +						   0,
> +						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +						   &fence);
>   			if (r || !fence)
>   				continue;
>   
> +			dma_fence_put(fence);
>   			num_fences++;
>   		}
>   
> @@ -589,12 +621,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			}
>   		}
>   
> +		if (num_points) {
> +			struct dma_fence *fence;
> +
> +			for (i = 0; i < num_points; i++) {
> +				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +							   timeline_points[i],
> +							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   &fence);
> +				if (r || !fence)

Same here, just ignoring errors is a no-go.

Regards,
Christian.

> +					continue;
> +
> +				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +					r = -EINVAL;
> +					goto free_fences;
> +				}
> +
> +				fences[num_fences++] = fence;
> +			}
> +		}
> +
>   		/* Retrieve syncobj's fence */
>   		for (i = 0; i < num_syncobj; i++) {
>   			struct dma_fence *fence;
>   
>   			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0, 0, &fence);
> +						   0,
> +						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +						   &fence);
>   			if (r || !fence)
>   				continue;
>   
> @@ -617,9 +671,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   				 * Just waiting on other driver fences should
>   				 * be good for now
>   				 */
> -				dma_fence_wait(fences[i], false);
> -				dma_fence_put(fences[i]);
> +				r = dma_fence_wait(fences[i], true);
> +				if (r) {
> +					dma_fence_put(fences[i]);
> +					goto free_fences;
> +				}
>   
> +				dma_fence_put(fences[i]);
>   				continue;
>   			}
>   
> @@ -665,6 +723,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		drm_gem_object_put(gobj[i]);
>   	kfree(gobj);
>   
> +	kfree(timeline_points);
> +	kfree(timeline_handles);
>   	kfree(syncobj_handles);
>   	kfree(bo_handles);
>   
> @@ -682,6 +742,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	while (entry-- > 0)
>   		drm_gem_object_put(gobj[entry]);
>   	kfree(gobj);
> +free_timeline_points:
> +	kfree(timeline_points);
> +free_timeline_handles:
> +	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
>   free_bo_handles:
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index af42798e901d..3b24e0cb1b51 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -521,12 +521,26 @@ struct drm_amdgpu_userq_wait {
>   	 * matching fence wait info pair in @userq_fence_info.
>   	 */
>   	__u32	bo_wait_flags;
> -	__u32	pad;
> +	/**
> +	 * @num_points: A count that represents the number of timeline syncobj handles in
> +	 * syncobj_handles_array.
> +	 */
> +	__u32	num_points;
>   	/**
>   	 * @syncobj_handles_array: An array of syncobj handles defined to get the
>   	 * fence wait information of every syncobj handles in the array.
>   	 */
>   	__u64	syncobj_handles_array;
> +	/**
> +	 * @syncobj_timeline_handles: An array of timeline syncobj handles defined to get the
> +	 * fence wait information of every timeline syncobj handles in the array.
> +	 */
> +	__u64   syncobj_timeline_handles;
> +	/**
> +	 * @syncobj_timeline_points: An array of timeline syncobj points defined to get the
> +	 * fence wait points of every timeline syncobj handles in the syncobj_handles_array.
> +	 */
> +	__u64	syncobj_timeline_points;
>   	/**
>   	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
>   	 * wait information of every BO handles in the array.


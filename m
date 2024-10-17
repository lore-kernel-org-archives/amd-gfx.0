Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F21D37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA4510E801;
	Thu, 17 Oct 2024 12:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HUjPn2A3";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337DA10E801
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:47:12 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so656300f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729169230; x=1729774030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3MEEJaKuNIgnvDcAPafjyKZsVq8n4arGU3HjUnfNGvM=;
 b=HUjPn2A3QGq4rGCvlNfvJMob/6PCfjTHrsMPidPi7YMhT22GXvlXLvhJSLd1+QKzzP
 RVfldQqr810KArXJRDb6oijke0JiDrGXyApglxLIGYN44ACjRCucuSHtcaqT6oABY46C
 kmPBZdgGtcUmF18/k9o2EJeo2JV994VSPwybo2wEcB7zLy2WCFQi5DlE+upSODiiwXe6
 kf6i//KmcLbfFUCoH3MDUahHnrduOKaFJgFTvAfLkLKwQI9VYYwQhEk4Eh2dTmRm1D2J
 Yxq809PtKwUtTc9JOlJX2kocJCh6+RZSGfjkUUhBjbVI/Lrf+TxF6TbiSdATY22iy07z
 fhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729169230; x=1729774030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3MEEJaKuNIgnvDcAPafjyKZsVq8n4arGU3HjUnfNGvM=;
 b=UZhgI1Y9kiH9ZWTwRMZMUWtVmxr1RbTzMAfV09OaHgpUdWGaq+G2HG8uCYQurPcHKP
 l1/tKC+JFRP0EIZgQg1XW8B7mkNxM4bS1pG/q4pBbV8VnXTAqZmsb+ThFyQ9JrXj751X
 yXTaXa1NIY8LSo9a1eYb1jmp9+scRyy0L2S1JuIe7YdWWhRpODkNnOINSgm8MFEYyvRi
 eDteRgJu/WkKnZuPG/dWWhZILN+ZYA5oORb6NoCRs6YxETpdYM/ERdIv8XL/uXsRZD4M
 sIGtpt7QzF9lBJxdbpohWYldkR0gGWZRyw5f4ny/deYUKJ/2AhXs1VBkyCAm7eZjSeO3
 CfCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzOrxmVTtv/TPeG63m1m4VFZSVc1mevHnvuJcRosdDwcLoaNxoDYct4HF2sEtYEaAfmjzfXfYh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvbSLOT8jMkwmneS04m9FBUC1NbdMBcYPgjaXrXW2+3sGcIBU0
 p6s3fPulOfpl6GXXXr9hL6W5HOK+WhgDPonfRuegBeEsbDP4f6LxwNZOfg==
X-Google-Smtp-Source: AGHT+IGqPyQRLSCNG1pcRPi6H13hyUTBaUmZppxwJ+/28OSKUZdvlZKa0SaNMEto9ujsSMsJ7cD7XQ==
X-Received: by 2002:adf:f0d1:0:b0:37d:50e1:b3e1 with SMTP id
 ffacd0b85a97d-37d86bba588mr4510643f8f.16.1729169230067; 
 Thu, 17 Oct 2024 05:47:10 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc45d63sm7198286f8f.117.2024.10.17.05.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 05:47:09 -0700 (PDT)
Message-ID: <08f91452-096c-467a-8940-943548897f25@gmail.com>
Date: Thu, 17 Oct 2024 14:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/09] drm/amdgpu: Add wait IOCTL timeline syncobj
 support
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Cc: alexander.deucher@amd.com
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
 <20241015074309.2484264-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241015074309.2484264-3-Arunpravin.PaneerSelvam@amd.com>
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

Am 15.10.24 um 09:43 schrieb Arunpravin Paneer Selvam:
> Add user fence wait IOCTL timeline syncobj support.
>
> v2:(Christian)
>    - handle dma_fence_wait() return value.
>    - shorten the variable name syncobj_timeline_points a bit.
>    - move num_points up to avoid padding issues.
>
> v3:(Christian)
>    - Handle timeline drm_syncobj_find_fence() call error
>      handling
>    - Use dma_fence_unwrap_for_each() in timeline fence as
>      there could be more than one fence.
>
> v4:(Christian)
>    - Drop the first num_fences since fence is always included in
>      the dma_fence_unwrap_for_each() iteration, when fence != f
>      then fence is most likely just a container.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 91 +++++++++++++++++--
>   include/uapi/drm/amdgpu_drm.h                 | 16 +++-
>   2 files changed, 99 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 8f9d2427d380..1a9565b61266 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -24,6 +24,7 @@
>   
>   #include <linux/kref.h>
>   #include <linux/slab.h>
> +#include <linux/dma-fence-unwrap.h>
>   
>   #include <drm/drm_exec.h>
>   #include <drm/drm_syncobj.h>
> @@ -474,11 +475,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> @@ -498,11 +499,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
> @@ -524,12 +540,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	if (!wait_info->num_fences) {
> +		if (num_points) {

You can drop this extra if. The for loop below is just a nop when 
num_points is zero.

> +			struct dma_fence_unwrap iter;
> +			struct dma_fence *fence;
> +			struct dma_fence *f;
> +
> +			for (i = 0; i < num_points; i++) {
> +				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +							   timeline_points[i],
> +							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   &fence);
> +				if (r)
> +					goto exec_fini;
> +
> +				dma_fence_unwrap_for_each(f, &iter, fence)
> +					num_fences++;
> +
> +				dma_fence_put(fence);
> +			}
> +		}
> +
>   		/* Count syncobj's fence */
>   		for (i = 0; i < num_syncobj; i++) {
>   			struct dma_fence *fence;
>   
>   			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
> -						   0, 0, &fence);
> +						   0,
> +						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +						   &fence);
>   			if (r)
>   				goto exec_fini;
>   
> @@ -588,12 +626,41 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			}
>   		}
>   
> +		if (num_points) {

Same here.

Apart from those two nit picks the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> +			struct dma_fence_unwrap iter;
> +			struct dma_fence *fence;
> +			struct dma_fence *f;
> +
> +			for (i = 0; i < num_points; i++) {
> +				r = drm_syncobj_find_fence(filp, timeline_handles[i],
> +							   timeline_points[i],
> +							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
> +							   &fence);
> +				if (r)
> +					goto free_fences;
> +
> +				dma_fence_unwrap_for_each(f, &iter, fence) {
> +					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
> +						r = -EINVAL;
> +						goto free_fences;
> +					}
> +
> +					dma_fence_get(f);
> +					fences[num_fences++] = f;
> +				}
> +
> +				dma_fence_put(fence);
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
>   			if (r)
>   				goto free_fences;
>   
> @@ -616,9 +683,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
> @@ -664,6 +735,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		drm_gem_object_put(gobj[i]);
>   	kfree(gobj);
>   
> +	kfree(timeline_points);
> +	kfree(timeline_handles);
>   	kfree(syncobj_handles);
>   	kfree(bo_handles);
>   
> @@ -681,6 +754,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C0ED6101A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 15:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC3210E335;
	Thu, 29 Jan 2026 15:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="cijB3Rlv";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6F910E335
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 15:16:17 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so9960965e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 07:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1769699776; x=1770304576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IEAQlM5QTbWzUgEad0eRjUQ+Tcr58W/nit1O+n3QmM4=;
 b=cijB3RlvRq4kBEFRT5nkVAKHD2rnxx0IiAqIjkgHa+V46eV8/IpzrKKWZKHOfl6ZJb
 LEzBqodhLcCl1z7bkbuY1AtMwJ8PowZj0OgoKos64TTa6O3bAHnSxwO69190Myge/c7v
 fRiuiOq0EYQpYvlk5KSaQLUrFVOUPcNzl8VPk5p9cG3i5vl7qJlyVDy0/uN/4pRdMCjI
 Z3lRdD7xPiVTqZyRP8v0HqcfM5//Z0PA6FteLkpgo87UmHkTDp4SmvJhqgl5tRxnlf+d
 gcAEOOYChKtk/A0/8NAuKpi46wZs5XRVTRm74y/iBlsqNPYdqZ+TEWlRWimV0Cl1/SI8
 jqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769699776; x=1770304576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IEAQlM5QTbWzUgEad0eRjUQ+Tcr58W/nit1O+n3QmM4=;
 b=FFFYt7F1/LEXh9ZXKk4fCuYKexygMe/f8C3X5/wsJLG5vjb0kHFuhGfW6t144enUyK
 LdzsrnyE+cu3d00lrsGK8G2Jho77alY4FKdKigdc/2UJmkJRI7dab/kYrLYOjNCXejmp
 SzWxRMjaUtJsIeeuahyqbIdLDqA+SIgqu6O7vyFoSpPVdu3PkINf7VinF3Z0hO0kYfkn
 miPdqgn9Nh0DTxvf87RWx1WOtRD6PwIj2suTt0WTfl0lVlFQMP3IY0e7mOQjiR0DdP5y
 AXQzMI7RHqZvqBMUqm71eZjpNeQbrJzwRTs0G965rABxMsySDRIQ1u85hzY8z+Y+zsWl
 hvjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWntLbTTyR3WisXxB1bJNmwwc9MruWiAi0n9w0s3+M/7RtV4LvP6Tfrpf+wcVHArk1UjEFmZ62@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPKAtmyGS9343lx3wHBYcgrsu4UyB0gwcjYH7oUdyVAA7LXhZX
 UP3f9FMfW8RzzSgF1iYZmqDaFu3Oi5U7kb15nA/ttZ2DtabOGr5D91r4T/6xlNFBdh538FoPp/I
 9ZLlJQ2E=
X-Gm-Gg: AZuq6aIia00BLy35xSbR+2EnVtXk0q1Op+KxP0gLTnv1w3wSf9jl5rWbMJdDQKI34Cg
 hlNcjIR8+od1Bx8LZOwpGkV7xz2OvgtkhYiI4x1JKu3R148LlvzhY1mEmqVJ3zTzT89l67yjK1q
 6aIoysOtdGmO7Q9YrOhxKHzjrcEdL0hF9aRszZkrjdqpStqTdu2xKMN5nG0Q2qlJYUvo6KQnr7n
 2TI2gtu833XqfItz9uzAu2cgsXyPnEc+g15CiJFMlVzcxpVHDllpHWq0FaMFv+h7eRwIG0XbpMI
 RN8raAobFsCWN1VaozSdoh+h4EKDTc5aLl9ombE4g3f/I0UOmwGeN6CjIjPiu5fmqP1egM9VHjb
 hif52EV4GWrsfWRrS+55mQ4yFrkCkV+Kyctc5jU82CILnbPOkqpEZpOVynTiUUE0pNnnZv2BQK/
 NQZsvK+RZUxeeu+N2kwcIX0rO2L7B4y1qd8YQa6T9pUb8=
X-Received: by 2002:a05:600c:6994:b0:480:3230:6c9b with SMTP id
 5b1f17b1804b1-48069c16799mr128043915e9.7.1769699775593; 
 Thu, 29 Jan 2026 07:16:15 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd78d3sm139219685e9.1.2026.01.29.07.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 07:16:15 -0800 (PST)
Message-ID: <45e5c024-8d21-4d4d-85dc-66fe31c05421@ursulin.net>
Date: Thu, 29 Jan 2026 15:16:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu: make amdgpu_user_wait_ioctl more resilent
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260129125327.11786-1-christian.koenig@amd.com>
 <20260129125327.11786-7-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260129125327.11786-7-christian.koenig@amd.com>
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
> When the memory allocated by userspace isn't sufficient for all the
> fences then just wait on them instead of returning an error.

Hmm..

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 52 ++++++++++---------
>   1 file changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index ee8a5fbbd53b..d059712741fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -734,7 +734,7 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>   			num_fences++;
>   	}
>   
> -	wait_info->num_fences = num_fences;
> +	wait_info->num_fences = min(num_fences, USHRT_MAX);

Oh it is actually a weakness in the uapi with wait_info->num_fences 
being u16. I did not pick that from the commit message straight away.

De-dup the array when over the uapi limit, and retry?

Is it userq fences or other fences that cause the spill in practice? If 
the former then the patch adds a kernel wait where there wasn't one 
before so de-duping more aggressively could maybe limit that path.

Regards,

Tvrtko

>   	r = 0;
>   
>   error_unlock:
> @@ -743,6 +743,19 @@ amdgpu_userq_wait_count_fences(struct drm_file *filp,
>   	return r;
>   }
>   
> +static int
> +amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
> +			    struct dma_fence **fences, unsigned int *num_fences,
> +			    struct dma_fence *fence)
> +{
> +	/* As fallback shouldn't userspace allocate enough space */
> +	if (*num_fences >= wait_info->num_fences)
> +		return dma_fence_wait(fence, true);
> +
> +	fences[(*num_fences)++] = dma_fence_get(fence);
> +	return 0;
> +}
> +
>   static int
>   amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   				    struct drm_amdgpu_userq_wait *wait_info,
> @@ -786,12 +799,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   			goto free_fences;
>   
>   		dma_fence_unwrap_for_each(f, &iter, fence) {
> -			if (num_fences >= wait_info->num_fences) {
> -				r = -EINVAL;
> +			r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +							&num_fences, f);
> +			if (r)
>   				goto free_fences;
> -			}
> -
> -			fences[num_fences++] = dma_fence_get(f);
>   		}
>   
>   		dma_fence_put(fence);
> @@ -808,12 +819,11 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   		if (r)
>   			goto free_fences;
>   
> -		if (num_fences >= wait_info->num_fences) {
> -			r = -EINVAL;
> +		r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +						&num_fences, f);
> +		if (r)
>   			goto free_fences;
> -		}
>   
> -		fences[num_fences++] = fence;
>   		dma_fence_put(fence);
>   	}
>   
> @@ -844,13 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   
>   		dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>   					DMA_RESV_USAGE_READ, fence) {
> -			if (num_fences >= wait_info->num_fences) {
> -				r = -EINVAL;
> -				goto error_unlock;
> -			}
> -
> -			fences[num_fences++] = fence;
> -			dma_fence_get(fence);
> +			r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +							&num_fences, f);
> +			if (r)
> +				goto free_fences;
>   		}
>   	}
>   
> @@ -861,13 +868,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   
>   		dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>   					DMA_RESV_USAGE_WRITE, fence) {
> -			if (num_fences >= wait_info->num_fences) {
> -				r = -EINVAL;
> -				goto error_unlock;
> -			}
> -
> -			fences[num_fences++] = fence;
> -			dma_fence_get(fence);
> +			r = amdgpu_userq_wait_add_fence(wait_info, fences,
> +							&num_fences, f);
> +			if (r)
> +				goto free_fences;
>   		}
>   	}
>   


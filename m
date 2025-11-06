Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEEECCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9DC10E946;
	Thu,  6 Nov 2025 15:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="ouw1d/E5";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4507E10E944
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:55:52 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so685511f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762444551; x=1763049351; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XGALeVCzsF4f1DpNVJqhX7BqrS0OH0cjP7ktRCQLQRY=;
 b=ouw1d/E5+wWCvjgSrkaZqsIc23tPuyv57Y9Uwp8RVpf08rcSI7VkQOdU7C+oYJzsCX
 hS9BAEjOkkpY27z51YSWwfboVtgtsAne0RFBIrCgEb7AsWbMg3qKBmNq4rpfJ0xvYLKt
 49cPrbcYwppcY01zAkk7klEn2XoHueOV3K0EYbKrv4oifKHhXdXWMo0ygz4uL/dFI+NH
 j8IphYRtuILiTIqOIz8LmSjj2RJzUZMjEA73vIxV032XiErYSmzSSuIssGNnmMMzBA0Q
 uNQIHjHQhk10HLwUhBuxeYJKxESrfvl5eSSfb97cJu1T2AJCa1gHSu82Uc78GfrwdObz
 bbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444551; x=1763049351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGALeVCzsF4f1DpNVJqhX7BqrS0OH0cjP7ktRCQLQRY=;
 b=fsXmxQv1K/7g9CwSs1ZOfbU3fWsxas/7XI3EqIUQBZdC0kupc/66/kjgzYhHcjCbOt
 +1E3UkiOIKutmAp4oGA5vmiNMfwB6lLmGp7GoJxcHSbPJXb/CqRL1Ekma80PJ0cQ0+Tb
 5CIOrXBjerFcjCblUVIa5Hfga/qVGU/faHwBMP2/+pGn8XlSXfXpBqjxrngChaIDlkKB
 3SilTd8DNqiDYftyE7lQoQet6IMP0pILzL2/G6Go0LL410dpkaexpUQWQYw5+BaaVjNL
 3rxWyKmplvucE/HVXy3tHUxrCcK3vrTKzaqDIjsLX8SBBhIPrP7Zhm76Ri9rmfhka2TZ
 qqkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlcj3iFVqu8T2GDDhYN4gKKd+8b/RcZiz4e4FIqDv7KfNV5HNR2l3ITnSkBlPo3lsB4UdRyoJG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ46jvA8URX+PutjH3/TOGU7m0Eo7pldB1wlTHjxYwDKHgtcLc
 JWOd4RcAMSb/rKFiH+qvxzAQtrIqBCnrmGWEkrGtfPEXq8tcY9sOdr3TMyRHqsVDDRM=
X-Gm-Gg: ASbGncslsMIQb9+1T9RATSxC7Go4Lsx51YGtGtitCyh9iEY3YkHilc9uHbhiGUs9Nt9
 MDO5AETiFCfJKxPXoyPbKghJGnaZuIdr1GfVynREXaTknwv3MjvVRtEP6T4OnWzBgfI8XIvIWtm
 3B1zyC9XRfZ/9RYTnOxXbvXpCFflz9NQlJpMehaE1LLGQ5BoBsIekLiMuDOMKN2CyMmCv7/8pQ3
 n8PAc3evDjYB74p+Nt3t0j9pFEeSCk7CLrCrv3bNM/TSp3E83JouI9HmySvp06yCvpfrqYsQN2K
 Co8NnCTtmMEu7wI1EAW7IQq82gzWCJiX9QRgkXMwFX3jhTDZfGgLC7kln2fLWykz0EBbj3dBfwZ
 UmIQh0GkTP/r8oZ1EyWSpj9Ke+TmE6YGdQPLkiveQTOiAYdPzv7XIpRoiZMaivCMlnkXKPhl53D
 jhnbyUhFdrr/PSWuFM65i/peFRHZgbr2IATNsviQ==
X-Google-Smtp-Source: AGHT+IEs3aDcon/JLTOdNSN1C15M5g5lHSSzfi57ASTswJ4ZtM6j5ELAqJYi7pro8EqNlmlE6rKmhg==
X-Received: by 2002:a05:6000:2901:b0:3ec:db87:e5f4 with SMTP id
 ffacd0b85a97d-429e32c6c7emr5441412f8f.7.1762444550422; 
 Thu, 06 Nov 2025 07:55:50 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb4037c7sm5801109f8f.3.2025.11.06.07.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:55:50 -0800 (PST)
Message-ID: <b5f9eb6c-0b40-40cd-813a-09bd8442b28c@ursulin.net>
Date: Thu, 6 Nov 2025 15:55:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: avoid memory allocation in the critical
 code path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20251106130637.2187-1-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251106130637.2187-1-christian.koenig@amd.com>
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


On 06/11/2025 13:06, Christian König wrote:
> When we run out of VMIDs we need to wait for some to become available.
> Previously we were using a dma_fence_array for that, but this means that
> we have to allocate memory.
> 
> Instead just wait for the first not signaled fence from the least recently
> used VMID to signal. That is not as efficient since we end up in this
> function multiple times again, but allocating memory can easily fail or
> deadlock if we have to wait for memory to become available.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 51 ++++++-------------------
>   1 file changed, 12 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 3ef5bc95642c..5f94a66511af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -201,58 +201,31 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
>   	struct amdgpu_device *adev = ring->adev;
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -	struct dma_fence **fences;
> -	unsigned i;
>   
> +	/* If anybody is waiting for a VMID let everybody wait for fairness */
>   	if (!dma_fence_is_signaled(ring->vmid_wait)) {
>   		*fence = dma_fence_get(ring->vmid_wait);
>   		return 0;
>   	}
>   
> -	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_NOWAIT);
> -	if (!fences)
> -		return -ENOMEM;
> -
>   	/* Check if we have an idle VMID */
> -	i = 0;
> -	list_for_each_entry((*idle), &id_mgr->ids_lru, list) {
> +	list_for_each_entry_reverse((*idle), &id_mgr->ids_lru, list) {
>   		/* Don't use per engine and per process VMID at the same time */
>   		struct amdgpu_ring *r = adev->vm_manager.concurrent_flush ?
>   			NULL : ring;
>   
> -		fences[i] = amdgpu_sync_peek_fence(&(*idle)->active, r);
> -		if (!fences[i])
> -			break;
> -		++i;
> -	}
> -
> -	/* If we can't find a idle VMID to use, wait till one becomes available */
> -	if (&(*idle)->list == &id_mgr->ids_lru) {
> -		u64 fence_context = adev->vm_manager.fence_context + ring->idx;
> -		unsigned seqno = ++adev->vm_manager.seqno[ring->idx];

Maybe vm_manager.fence_context && seqno are now unused and can be removed?

Regards,

Tvrtko

> -		struct dma_fence_array *array;
> -		unsigned j;
> -
> -		*idle = NULL;
> -		for (j = 0; j < i; ++j)
> -			dma_fence_get(fences[j]);
> -
> -		array = dma_fence_array_create(i, fences, fence_context,
> -					       seqno, true);
> -		if (!array) {
> -			for (j = 0; j < i; ++j)
> -				dma_fence_put(fences[j]);
> -			kfree(fences);
> -			return -ENOMEM;
> -		}
> -
> -		*fence = dma_fence_get(&array->base);
> -		dma_fence_put(ring->vmid_wait);
> -		ring->vmid_wait = &array->base;
> -		return 0;
> +		*fence = amdgpu_sync_peek_fence(&(*idle)->active, r);
> +		if (!(*fence))
> +			return 0;
>   	}
> -	kfree(fences);
>   
> +	/*
> +	 * If we can't find a idle VMID to use, wait on a fence from the least
> +	 * recently used in the hope that it will be available soon.
> +	 */
> +	*idle = NULL;
> +	dma_fence_put(ring->vmid_wait);
> +	ring->vmid_wait = dma_fence_get(*fence);
>   	return 0;
>   }
>   


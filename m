Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CBBCF8861
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 14:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC9F10E759;
	Thu, 20 Nov 2025 14:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="VecqKQVm";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE5910E756
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 14:14:28 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so11350685e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1763648067; x=1764252867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4aXDIqbXLzQPpFmVuBKROa0mL/5b0LUIDBWeii3LLw=;
 b=VecqKQVmhTGGepnBnAqYP5HfEYGRk4yXexKMRRviWsEt7BNd8AG1d3Z5pk8vpa3bOv
 tTD8qizeDuatxJzS43MVwVhcK2cVoZ99JTKKetgzXFvVDEugLpPcAVH1Ol/oaCy9E/lh
 alzRcKgcBWKicCUyVXQTIEud7qUF+TGGueAuQibT1cgGc3fX6tosW4+YqkegWB3mKMKh
 oE3VTLAi5qKex6Wr6hIxrZQkVw5Gs2KAIORASOuS8oAvsoByTfBVwW8qI07Sseq+38qr
 vdBwdyZiCrYqbI1B7jPGMlr5VFef2eUpcCAX8+RnvPW1zWGy61y9A40fzhlKpVBQXD9u
 TRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763648067; x=1764252867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l4aXDIqbXLzQPpFmVuBKROa0mL/5b0LUIDBWeii3LLw=;
 b=HWCr8UErLnmWmW28HUTZ8Se6NLxONZUaI7eWXLY5TL/Vz0KbPGoEDXN/NsTOLR+c0i
 7W0mqY97kMOsd0BwJXy8Jh3V7QPK/KOh7VaIYcQnXsyESfAJsnnpRjA2SIBjfDxOFpZ9
 TOfXl6pGs5wEANrvuxWz2ifB7G/Yrcj4ntVxxf542nzdgt5dvGObGx3F9fLSrrSJ2OTG
 GiD4CNMySo6ovrVkg31uDVGOwGZz+Kknn8cdDOH3yPciVn37ZfAy82D4MZ6VdlXMP2G9
 K0yhMpWMd/CV5o2G+pnUdnfxyN7ZBQmIQVK+nytTcASQk/fVVI6zNcFCPf1sQcdSqHHD
 Hpsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrz9lLEGG7bnr2CJXTKOkRGZRql5TELsSl6Syi1VPZUxjIFt/cfcxKLSNW9QaejWGkLInGfbn+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwrG7kBJ1Sxpme3m4JAhJwQ7GG1UUVFDf3A+qukG1ja7N+GWUD
 YBxBQbNX3JLWiQaDZHafHhzwlqFEjzZqZaZuciYBTLnuEOQBfABxOBwqTVJWNlwK6jk=
X-Gm-Gg: ASbGncvrTOf6A0013xFgjyL4eD7yr1yax61I4mftPYZpgM4SjMqrswuVF97Kuel4wWK
 NgU9E2d5MWgvP9nkSIHAtxRihSxatWB8Q3B6w/JwujMKDGJgnqMkz95hF6hAzqgPY5XpPyDy8Pw
 VRJkthQK7AXQY1khIWbpHO9GGtL7TgPa/amUxijLQt/zyuKG5ZYYzDkmczYX2BZZXZcb7CG3Dw3
 i/JFFPLMEKNRCalORHWzqcCXGUh8TONVdnFQj3mbpyZYobnMO1GWPES5jKbUoNfpgSRulXOsjv+
 lDu7b6vuTOlefZ1ULdOZZMwb3w5mRcyHX7H/iImNwqOX59Jhcvc8F/jWukQawgE3r+1zAOCLpDc
 B4NjTp1TyR9vPrr/Xf0VV0BNf5q8/ya+SeSSiRdQ4qColqrh5ifyaf7fVLkv6DDUhsMXedYMRzx
 EKlCGC8ECBBTKYdY2y8msaG8tBowb3Wewl16xnTNfvQj0=
X-Google-Smtp-Source: AGHT+IFnJhlqTiz2wCZ5pq9bATxrBbTFVbGNJfe4zz/siDIlX2GmBiOG/I+Jy/HPMkfisN/o/4Y3WQ==
X-Received: by 2002:a05:600c:1c25:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-477b895912cmr43182905e9.10.1763648067124; 
 Thu, 20 Nov 2025 06:14:27 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e051d8sm66346425e9.5.2025.11.20.06.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 06:14:26 -0800 (PST)
Message-ID: <cb0b8f5b-11f8-4fee-8d72-396b05f9f708@ursulin.net>
Date: Thu, 20 Nov 2025 14:14:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] dma-buf: detach fence ops on signal v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 sumit.semwal@linaro.org
References: <20251113145332.16805-1-christian.koenig@amd.com>
 <20251113145332.16805-4-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251113145332.16805-4-christian.koenig@amd.com>
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


On 13/11/2025 14:51, Christian König wrote:
> When neither a release nor a wait backend ops is specified it is possible
> to let the dma_fence live on independently of the module who issued it.
> 
> This makes it possible to unload drivers and only wait for all their
> fences to signal.
> 
> v2: fix typo in comment
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 16 ++++++++++++----
>   include/linux/dma-fence.h   |  4 ++--
>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index ec21be9b089a..7074347f506d 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -374,6 +374,14 @@ int dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>   				      &fence->flags)))
>   		return -EINVAL;
>   
> +	/*
> +	 * When neither a release nor a wait operation is specified set the ops
> +	 * pointer to NULL to allow the fence structure to become independent
> +	 * from who originally issued it.
> +	 */
> +	if (!fence->ops->release && !fence->ops->wait)
> +		RCU_INIT_POINTER(fence->ops, NULL);
> +
>   	/* Stash the cb_list before replacing it with the timestamp */
>   	list_replace(&fence->cb_list, &cb_list);
>   
> @@ -513,7 +521,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
>   	trace_dma_fence_wait_start(fence);
> -	if (ops->wait) {
> +	if (ops && ops->wait) {
>   		/*
>   		 * Implementing the wait ops is deprecated and not supported for
>   		 * issuer independent fences, so it is ok to use the ops outside
> @@ -578,7 +586,7 @@ void dma_fence_release(struct kref *kref)
>   	}
>   
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->release)
> +	if (ops && ops->release)
>   		ops->release(fence);
>   	else
>   		dma_fence_free(fence);
> @@ -614,7 +622,7 @@ static bool __dma_fence_enable_signaling(struct dma_fence *fence)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (!was_set && ops->enable_signaling) {
> +	if (!was_set && ops && ops->enable_signaling) {
>   		trace_dma_fence_enable_signal(fence);
>   
>   		if (!ops->enable_signaling(fence)) {
> @@ -1000,7 +1008,7 @@ void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->set_deadline && !dma_fence_is_signaled(fence))
> +	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
>   		ops->set_deadline(fence, deadline);
>   	rcu_read_unlock();
>   }
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 77f07735f556..eb57bcc8712f 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -436,7 +436,7 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->signaled && ops->signaled(fence)) {
> +	if (ops && ops->signaled && ops->signaled(fence)) {
>   		rcu_read_unlock();
>   		dma_fence_signal_locked(fence);
>   		return true;
> @@ -472,7 +472,7 @@ dma_fence_is_signaled(struct dma_fence *fence)
>   
>   	rcu_read_lock();
>   	ops = rcu_dereference(fence->ops);
> -	if (ops->signaled && ops->signaled(fence)) {
> +	if (ops && ops->signaled && ops->signaled(fence)) {
>   		rcu_read_unlock();
>   		dma_fence_signal(fence);
>   		return true;

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


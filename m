Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9872DCF8863
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 14:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A8A10E2A7;
	Thu, 20 Nov 2025 14:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="JMRLHMwc";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF25C10E2A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 14:42:14 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b7370698a8eso122692666b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1763649733; x=1764254533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=khBR6eSNf/QmSuc9SlSCWE0udmdJHBDaQ2oPnmmJpDQ=;
 b=JMRLHMwcfCQxHdj/D1BEPG7re+H8EM5wSK6mWYILa7HrdP0CgUmAdJJKTrO6SJpEv9
 kSlJeFmYAZBkeXHYrC51bpjzO7zD6ozvQv07IYuE4FPFxQq1//T1TouPtloG8tI06GFv
 04n75TC0hLgrifEjKft/NZclv1oEWMZnZKIszxQ1BBiIYiBVUCCn1vvBnjPpFoOo8Wsg
 l/7JH5rJT/jqQy38GvP1oSUpmTGz3rXApWF56JaJvg7KkC/TrG1d8DGvsc3FslSxaDbp
 iF5u/O8TNdxC1QU1xakzWxMxf/xY9us2buWtTmjOkb1Hgkzvv/TKENNqnneJ7fhIQ6ca
 WiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763649733; x=1764254533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=khBR6eSNf/QmSuc9SlSCWE0udmdJHBDaQ2oPnmmJpDQ=;
 b=b4gohYDJfKckexa5DHZVcPjK13rKNUeoypeFJSilrsbusHWS+skRxaSG/8Bj7W7+Uu
 xWAIJ0eetRglUKYsKuwhKI8aaU5BoNQb+drHbOQ7qA8+QXaNmL+VW2BWvo0J4+Y9848E
 PE/lh7SNI8Nx2gSf1Ea61x3d/i5NH1TufV9ZeNU7Y5cfUEg/E7I/um44Qf95twXAQvBJ
 STRroUMppgXmKXrCSUq5ZVk6N6GYg0AkxuPOAnxAdmK734xBRGxzJQQltTe8eg7Hrd9g
 jOFRk0/PhnMKWBHcKaQoYAsREZGr3+CDjJb6b0xeS9UWolRn1pQl/Pp0sh1nh+IQyKLz
 0C0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR3APl9f1Wi1hmIspZBbTYF1s2A8xjQalOJQ2Ga0p2VJp88G8TJBWasCHIcIoiT4uYue6cW2pu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9FVElX+GDxa/zBWrB29I7LQSfZgfXe1twZXdWxsJp+R8OL/A7
 5qEqZHzvB/IDbcQWHIdbarHDu4DXfVrpQEtLffeZbD/IF7QH8jWiRcnCf8MLJ4Hq7hA=
X-Gm-Gg: ASbGncugXICu+TUm13qSWWl7iXQGkQ+dPUTn7HRhUU8K2FbN4+DjcUslrGy0VO/xFc3
 /zLE+Vz6CTP3Y/Ot2GShYs6VGdVbE/V1Rlx3CpUNE0aP1yOOuMnTo5fyFK1fCPS5i2/kLkyqVrE
 LMBniImZewO83PyFXSni5tNln7fb1LsTHxoZAHJ7gWyPpw0v2BiYwWipzY3eq93DyUusWGC8zg0
 O0WSJqvBC+mfNgJMxGN1CpDUboBSBt/1INefEL7zg3uqi9ZZNpJodw1kVuG9XDj3wXAveam2PBd
 /uw1glBHVwCtdedezcbjZndyWPxhthbNxx8SXhxKvPDo6yKm1A3uh+OiTSJ2xdq4ma+jif4MlDN
 wihcpBqTpUyTrMefFy35TIftkhcuQ0/tcE+9BKlo7v7EcY5ZciU6v2PEs8cfO75BTibmc5w1HXA
 oNEYVQdEEDE2i/n4sYGu2H84Pj/tahbeuvRi+la6P6ggE=
X-Google-Smtp-Source: AGHT+IGSe52x3WwscN4pPeTMXlXGa4bP0yNsZ98l/WZuYWDCuxOODGDX3LXA9XEr/HIuIeHAYgSlVw==
X-Received: by 2002:a17:907:7293:b0:b73:5acd:465e with SMTP id
 a640c23a62f3a-b7655485cc4mr313158366b.11.1763649732423; 
 Thu, 20 Nov 2025 06:42:12 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654ff3987sm222731066b.48.2025.11.20.06.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 06:42:11 -0800 (PST)
Message-ID: <a58fd870-30ca-44e0-b9f8-df5a34889fce@ursulin.net>
Date: Thu, 20 Nov 2025 14:42:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] drm/amdgpu: independence for the amdgpu_fence!
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 sumit.semwal@linaro.org
References: <20251113145332.16805-1-christian.koenig@amd.com>
 <20251113145332.16805-11-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251113145332.16805-11-christian.koenig@amd.com>
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
> This should allow amdgpu_fences to outlive the amdgpu module.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 63 +++++++----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 -
>   2 files changed, 20 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index c7843e336310..990fcbbe90a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -112,8 +112,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>   	af->ring = ring;
>   
>   	seq = ++ring->fence_drv.sync_seq;
> -	dma_fence_init(fence, &amdgpu_fence_ops,
> -		       &ring->fence_drv.lock,
> +	dma_fence_init(fence, &amdgpu_fence_ops, NULL,
>   		       adev->fence_context + ring->idx, seq);
>   
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> @@ -467,7 +466,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring)
>   	timer_setup(&ring->fence_drv.fallback_timer, amdgpu_fence_fallback, 0);
>   
>   	ring->fence_drv.num_fences_mask = ring->num_hw_submission * 2 - 1;
> -	spin_lock_init(&ring->fence_drv.lock);
>   	ring->fence_drv.fences = kcalloc(ring->num_hw_submission * 2, sizeof(void *),
>   					 GFP_KERNEL);
>   
> @@ -654,16 +652,20 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
>   	struct amdgpu_fence_driver *drv = &ring->fence_drv;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&drv->lock, flags);
> +	rcu_read_lock();
>   	for (unsigned int i = 0; i <= drv->num_fences_mask; ++i) {
>   		struct dma_fence *fence;
>   
> -		fence = rcu_dereference_protected(drv->fences[i],
> -						  lockdep_is_held(&drv->lock));
> -		if (fence && !dma_fence_is_signaled_locked(fence))
> +		fence = dma_fence_get_rcu(drv->fences[i]);
> +		if (!fence)
> +			continue;
> +
> +		dma_fence_lock_irqsave(fence, flags);
> +		if (!dma_fence_is_signaled_locked(fence))
>   			dma_fence_set_error(fence, error);
> +		dma_fence_unlock_irqrestore(fence, flags);
>   	}
> -	spin_unlock_irqrestore(&drv->lock, flags);
> +	rcu_read_unlock();
>   }
>   
>   /**
> @@ -714,16 +716,19 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>   	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>   
>   	/* mark all fences from the guilty context with an error */
> -	spin_lock_irqsave(&ring->fence_drv.lock, flags);
> +	rcu_read_lock();
>   	do {
>   		last_seq++;
>   		last_seq &= ring->fence_drv.num_fences_mask;
>   
>   		ptr = &ring->fence_drv.fences[last_seq];
> -		rcu_read_lock();
> -		unprocessed = rcu_dereference(*ptr);
> +		unprocessed = dma_fence_get_rcu(*ptr);

Both here and in amdgpu_fence_driver_set_error, the old/existing code 
makes me think the fetched fence pointer can be NULL (the "if 
(unprocesses && .. below"). If true then it needs to be checked before 
dma_fence_get_rcu and after.

Although I am a bit confused with the RCU usage here in general. For 
example struct amdgpu_fence_driver->fences is not rcu annotated so what 
is actually guarded by RCU? Pointers in the array or fence objects 
pointer to by those pointers?

Regards,

Tvrtko

> +
> +		if (!unprocessed)
> +			continue;
>   
> -		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
> +		dma_fence_lock_irqsave(unprocessed, flags);
> +		if (dma_fence_is_signaled_locked(unprocessed)) {
>   			fence = container_of(unprocessed, struct amdgpu_fence, base);
>   
>   			if (fence == af)
> @@ -731,9 +736,10 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>   			else if (fence->context == af->context)
>   				dma_fence_set_error(&fence->base, -ECANCELED);
>   		}
> -		rcu_read_unlock();
> +		dma_fence_unlock_irqrestore(unprocessed, flags);
> +		dma_fence_put(unprocessed);
>   	} while (last_seq != seq);
> -	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> +	rcu_read_unlock();
>   	/* signal the guilty fence */
>   	amdgpu_fence_write(ring, (u32)af->base.seqno);
>   	amdgpu_fence_process(ring);
> @@ -823,39 +829,10 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   	return true;
>   }
>   
> -/**
> - * amdgpu_fence_free - free up the fence memory
> - *
> - * @rcu: RCU callback head
> - *
> - * Free up the fence memory after the RCU grace period.
> - */
> -static void amdgpu_fence_free(struct rcu_head *rcu)
> -{
> -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -
> -	/* free fence_slab if it's separated fence*/
> -	kfree(to_amdgpu_fence(f));
> -}
> -
> -/**
> - * amdgpu_fence_release - callback that fence can be freed
> - *
> - * @f: fence
> - *
> - * This function is called when the reference count becomes zero.
> - * It just RCU schedules freeing up the fence.
> - */
> -static void amdgpu_fence_release(struct dma_fence *f)
> -{
> -	call_rcu(&f->rcu, amdgpu_fence_free);
> -}
> -
>   static const struct dma_fence_ops amdgpu_fence_ops = {
>   	.get_driver_name = amdgpu_fence_get_driver_name,
>   	.get_timeline_name = amdgpu_fence_get_timeline_name,
>   	.enable_signaling = amdgpu_fence_enable_signaling,
> -	.release = amdgpu_fence_release,
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7a27c6c4bb44..9cbf63454004 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -125,7 +125,6 @@ struct amdgpu_fence_driver {
>   	unsigned			irq_type;
>   	struct timer_list		fallback_timer;
>   	unsigned			num_fences_mask;
> -	spinlock_t			lock;
>   	struct dma_fence		**fences;
>   };
>   


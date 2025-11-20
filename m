Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D4FCF8862
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 14:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C094110E2A3;
	Thu, 20 Nov 2025 14:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="CcN0T9bS";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E46210E2A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 14:17:26 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so6616655e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1763648244; x=1764253044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXBH8LKXAoztnmU0gR6y1RS7gCB6+Ux7CKJn5h1WDCY=;
 b=CcN0T9bSdJu15hluKUbX3GFuvdVcLZYzsWz995msWlyhsTFeQQ9uH4hKRThEI7nh2Y
 oLcykbYuaqP1paJfDcHnCm1HoEpC6JvwCf5UPsyeDhu79HYXN9P8mh2gZCbbAlv49ROJ
 pMUIRb8rRgJ6snLEGEhVkDZDgPiPKj4WxgzcKyYlhy6oX2AsKS2Zd0TlW5KmxNVBkzhj
 baId+dVGBG6zKRF5xWZ8wfUUYTcnBAE9mC8JPRRXYtgdFAYbM0lJ5SMuLXmdsL2NDLwV
 2vzd/NkK5hYSviiWI+LzRFyWuU6eyHqC+SEhQMU+ebROlCk1/MFZ2kqJIwOG7drHBhhu
 yu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763648244; x=1764253044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CXBH8LKXAoztnmU0gR6y1RS7gCB6+Ux7CKJn5h1WDCY=;
 b=laY1zmRP7N7E4o8smLdJBonuXsFB1I6ZTeN/9PI/eNb2s0hkiySJ173aHB4NxhLxf3
 YjFe0T3dh0t/Sn6Kad42H7TrPU6wVJbnZfWaMyl5/Q+SU73B1p687QcwF+VZoX364TEI
 7y+kJgvcGcJqDeWuLD4EwhahtD101/OKCJeV50nIhAdIXoU3/UJQVcRrQnSi3hNeODMr
 coFtt4l1uz0tXNkKtl+WtI6OGIMZRkuKu/boIZnJPCCZM5OZ4dcGkw9XPbBuZ3qW91by
 Nb+YuAi14MYuFYjYRpkTwEDpbzhb9qsKSbAJcCxUMGwSl/63+RGUuN7roCbhNlIYnvfZ
 iSCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVirWh1ArtKb1OfLbtq5MQVIx8Nx2DNwiZwZEpG6dGExt5ZbGPzV6t3uDvPFt77zBdqyffYKJGc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRhvloAlnRM27T3cYKvCxu/6ErMOi3KJsOn+C6B39KgXBn//oD
 pGovjFxLP7WRWY8SVAgUh0vOZbHbWukNW3Y5y+9i2rJNTM4a/J9y0SThr6ifuRB6j3k=
X-Gm-Gg: ASbGncsOWepqo9NPhL8MAs/JhmMRUYCmBk9P6qGdp0v9YlgjJkEb5ZT2EtuSryetjPp
 t3QBUAj0wOhs8cLd48MtSmiwF+zJrYvRnOgceLnJH5NJf5nXQvusNkUMnM+wCeJ7RfwupEAGfhH
 e2qUwF54GlKpwzwOoZzmikWX5eeW1tKcauFaQTCRZOmBRbqT2MMP8J/TWtpGGiBhHomLOiGVMOx
 9/bWWZgkhM+5q/Cm6TM1PYU+TgcrLgWyISbmc83JnUWkDbk+ROmBI2Cp5hREbuXfTgRoMQR7sNl
 ru1xzm4joET128SNivKlCXKFHHJ1kOmzoycFilCpZtuPLK9AopVGNvE8w2LuKnwlhe4CDE6UnrD
 joC2z9iClOWpVzkP/iWKPQKb8wJHBnf5LwMNiSEMdEZlPYhTYnn5T8lHcgFIm5Bzb6NvSikqsiw
 W+pptM/BvKrCY2pMkQyNIdNBwzkduzDU+P
X-Google-Smtp-Source: AGHT+IHjZqvTkkmRZ8Ij302pTC794n7WQdn7xGg0iWq0ORbFykU/+7LM6vc6fC7DhyZogpe/qnQw/Q==
X-Received: by 2002:a05:600c:3553:b0:477:55ce:f3c3 with SMTP id
 5b1f17b1804b1-477babc1f61mr20645215e9.5.1763648244298; 
 Thu, 20 Nov 2025 06:17:24 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b82d8251sm49652785e9.6.2025.11.20.06.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 06:17:23 -0800 (PST)
Message-ID: <805c7537-7d75-4eb0-84ae-bad7064ff166@ursulin.net>
Date: Thu, 20 Nov 2025 14:17:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] drm/sched: use inline locks for the drm-sched-fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 sumit.semwal@linaro.org
References: <20251113145332.16805-1-christian.koenig@amd.com>
 <20251113145332.16805-9-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251113145332.16805-9-christian.koenig@amd.com>
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
> Using the inline lock is now the recommended way for dma_fence implementations.
> 
> So use this approach for the scheduler fences as well just in case if
> anybody uses this as blueprint for its own implementation.
> 
> Also saves about 4 bytes for the external spinlock.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_fence.c | 7 +++----
>   include/drm/gpu_scheduler.h             | 4 ----
>   2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index 08ccbde8b2f5..47471b9e43f9 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -161,7 +161,7 @@ static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
>   	/* If we already have an earlier deadline, keep it: */
>   	if (test_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags) &&
>   	    ktime_before(fence->deadline, deadline)) {
> -		spin_unlock_irqrestore(&fence->lock, flags);
> +		dma_fence_unlock_irqrestore(f, flags);
>   		return;
>   	}
>   
> @@ -217,7 +217,6 @@ struct drm_sched_fence *drm_sched_fence_alloc(struct drm_sched_entity *entity,
>   
>   	fence->owner = owner;
>   	fence->drm_client_id = drm_client_id;
> -	spin_lock_init(&fence->lock);
>   
>   	return fence;
>   }
> @@ -230,9 +229,9 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>   	fence->sched = entity->rq->sched;
>   	seq = atomic_inc_return(&entity->fence_seq);
>   	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
> -		       &fence->lock, entity->fence_context, seq);
> +		       NULL, entity->fence_context, seq);
>   	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
> -		       &fence->lock, entity->fence_context + 1, seq);
> +		       NULL, entity->fence_context + 1, seq);
>   }
>   
>   module_init(drm_sched_fence_slab_init);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index fb88301b3c45..b77f24a783e3 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -297,10 +297,6 @@ struct drm_sched_fence {
>            * belongs to.
>            */
>   	struct drm_gpu_scheduler	*sched;
> -        /**
> -         * @lock: the lock used by the scheduled and the finished fences.
> -         */
> -	spinlock_t			lock;
>           /**
>            * @owner: job owner for debugging
>            */

Looks good to me and the kernel test robot warnings Philipp mentions 
AFAICT are from a different patch relating to trivial selftest changes.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


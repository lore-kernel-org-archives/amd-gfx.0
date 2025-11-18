Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B879CEE328
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 16:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72B110E4EE;
	Tue, 18 Nov 2025 16:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="fUNccxNC";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC2010E4F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 16:03:52 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so25827515e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1763481831; x=1764086631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NPy7MtRGfLlvM770xBVrc8IbPL912/1L/AULTvqcMyg=;
 b=fUNccxNCDfvOexIOEQ+5uB/HfaSEOPW1K+S0LBe+aoJRYL/dmrhLA9TS68EcU3iYrg
 ocSOOByfG1PC+6Yt/CeMKZ7JjjZiOVE+2nx4e7ikTqChfzxmVtA+lynlkzR2bNVE2nvk
 vFfa0Uhd5sMgyCq4RaUNehKv2Qbu1kG6eMWmNcNfFPbfAW1yLc3dsS1HKDy377G1DoK2
 T/JfdKbT9heEwgFa5VoGWbZwQ4BQPAZz5bVA7csdf6oQ2V/YwZ5ah/nOiIHyqR8YAUvB
 Kj3MpwTnQOVq60LaWSW2KYan1Dg7c1UlH2APFgHdH09RxsEOHYceQTiMPdWII9Gh65j6
 Kp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763481831; x=1764086631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NPy7MtRGfLlvM770xBVrc8IbPL912/1L/AULTvqcMyg=;
 b=m/GjewUx3b2VUrvMFV/G4RLYZac+Tg0sdhX1AgjbsZwukPeLnqEM5Dw+SVaHZzVe6H
 n2Sfd7vpLfVmX2RPo7+f6J2xAWDVvMzEocdDJUVyLcerW0a8G6AB5vDGV+mdEAVfjxeY
 2o/Mi271XH5nUtZROMed8jpzvNHWP8etgYQoZclcIWQ6lwaFiwd78r0QUWghkbY3C4D/
 +JLrQ9sOhGBAojcF1eJYc3Pf3cfkYfMNofqWuDrCrZKJVO2rzkvWS1dqwlCCa5YQzTgV
 /+5oBFz2f6ogKucFsmRHvaQehZzESkW3LqiKF1o+L1zuxBK/tHIxuw4GpSMuWyfj3fXi
 iJyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRfD/Brt9q4N84xmjQ9zMnBYR+g3WzwltWK1CS8jN7G4dNKNPM14vTyy+vaGKR7SSKKm+V1O/x@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzq57kXS68kJ3Ts1TDopeJBhtcQbyTk0EAMxLoAXe/GG5D2GyQk
 O4cv1niHsslxCEs7/r67scdZFEIIsuI8X8RogGMh97GZYGB1jdPPpukALjEYZJXZJfs=
X-Gm-Gg: ASbGncsyM/LekEITjVk/7+Z0ky7GVGRqJ8wSL41ef161jocdhI7/Vi13rk8TiQc3ZJQ
 Pf38RMwWnOmUPamXULZYy2raNKhfM5K+rM3gsQusSczGbEEz7N0/sJKTKuZj0Qtz4CBtEnUkukG
 YhYQCQbHvAiY1ax1EZLw8oi8VfDrwNW4uBFEsGaPWKW285sGrz7k1tJuQbO1MaNMRVRXYKoy8w1
 LkZnR2WaRmV1/tRDzFCR49Ibq+5XjssL+95UtyTaF27EhEb7SFF1302MELq66ODd5Lok0MY+6Ff
 Q8C+dxmJe64Uc6l+2H/2SpX6q5TQTe78L5yt2S0CwhFNZfzKve0om1ZMWPVav8DwjRxOjZXXh4p
 C3t9jW2K7p0HVTEQ4P19xfHcv1ckx4wKm9LBSTCPCSNCEChWuW1EySZah9T7Pf7YLAUkc9MgyBO
 Z1QDo8rXOPig7FMVlxnJjNFesI7jqvY9Ai
X-Google-Smtp-Source: AGHT+IGysRbMzbECL6E+MizQEQGrtqhmQyxOI0y7D4OkZygIod9v97e1L6AKbj5saKClh+dNolGEFw==
X-Received: by 2002:a05:600c:4695:b0:477:63b4:ef7a with SMTP id
 5b1f17b1804b1-4778feaa8a1mr139503735e9.20.1763481830363; 
 Tue, 18 Nov 2025 08:03:50 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a973390csm20979025e9.4.2025.11.18.08.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 08:03:49 -0800 (PST)
Message-ID: <ed7595b4-b6e4-4a7f-ad35-e3a3cf063e72@ursulin.net>
Date: Tue, 18 Nov 2025 16:03:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] dma-buf: protected fence ops by RCU v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 sumit.semwal@linaro.org
References: <20251113145332.16805-1-christian.koenig@amd.com>
 <20251113145332.16805-3-christian.koenig@amd.com>
 <ef0f9459-6733-4e0a-9c06-c36c02e5a93c@ursulin.net>
 <35d7ab6c-bd4d-4267-8ae1-2637d6c0f1ff@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <35d7ab6c-bd4d-4267-8ae1-2637d6c0f1ff@amd.com>
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


On 18/11/2025 14:28, Christian König wrote:
> On 11/14/25 11:50, Tvrtko Ursulin wrote:
>>> @@ -569,12 +577,12 @@ void dma_fence_release(struct kref *kref)
>>>            spin_unlock_irqrestore(fence->lock, flags);
>>>        }
>>>    -    rcu_read_unlock();
>>> -
>>> -    if (fence->ops->release)
>>> -        fence->ops->release(fence);
>>> +    ops = rcu_dereference(fence->ops);
>>> +    if (ops->release)
>>> +        ops->release(fence);
>>>        else
>>>            dma_fence_free(fence);
>>> +    rcu_read_unlock();
>>
>> Risk being a spin lock in the release callback will trigger a warning on PREEMPT_RT. But at least the current code base does not have anything like that AFAICS so I guess it is okay.
> 
> I don't think that this is a problem. When PREEMPT_RT is enabled both RCU and spinlocks become preemptible.
> 
> So as far as I know it is perfectly valid to grab a spinlock under an rcu read side critical section.

Looking at the source just now, I think it is possible I mixed it up 
with preempt_disable()+spin_lock().
>>> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
>>> index 64639e104110..77f07735f556 100644
>>> --- a/include/linux/dma-fence.h
>>> +++ b/include/linux/dma-fence.h
>>> @@ -66,7 +66,7 @@ struct seq_file;
>>>     */
>>>    struct dma_fence {
>>>        spinlock_t *lock;
>>> -    const struct dma_fence_ops *ops;
>>> +    const struct dma_fence_ops __rcu *ops;
>>>        /*
>>>         * We clear the callback list on kref_put so that by the time we
>>>         * release the fence it is unused. No one should be adding to the
>>> @@ -218,6 +218,10 @@ struct dma_fence_ops {
>>>         * timed out. Can also return other error values on custom implementations,
>>>         * which should be treated as if the fence is signaled. For example a hardware
>>>         * lockup could be reported like that.
>>> +     *
>>> +     * Implementing this callback prevents the BO from detaching after
>>
>> s/BO/fence/
>>
>>> +     * signaling and so it is mandatory for the module providing the
>>> +     * dma_fence_ops to stay loaded as long as the dma_fence exists.
>>>         */
>>>        signed long (*wait)(struct dma_fence *fence,
>>>                    bool intr, signed long timeout);
>>> @@ -229,6 +233,13 @@ struct dma_fence_ops {
>>>         * Can be called from irq context.  This callback is optional. If it is
>>>         * NULL, then dma_fence_free() is instead called as the default
>>>         * implementation.
>>> +     *
>>> +     * Implementing this callback prevents the BO from detaching after
>>
>> Ditto.
> 
> Both fixed, thanks.
> 
>>
>>> +     * signaling and so it is mandatory for the module providing the
>>> +     * dma_fence_ops to stay loaded as long as the dma_fence exists.
>>> +     *
>>> +     * If the callback is implemented the memory backing the dma_fence
>>> +     * object must be freed RCU safe.
>>>         */
>>>        void (*release)(struct dma_fence *fence);
>>>    @@ -418,13 +429,19 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
>>>    static inline bool
>>>    dma_fence_is_signaled_locked(struct dma_fence *fence)
>>>    {
>>> +    const struct dma_fence_ops *ops;
>>> +
>>>        if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
>>>            return true;
>>>    -    if (fence->ops->signaled && fence->ops->signaled(fence)) {
>>> +    rcu_read_lock();
>>> +    ops = rcu_dereference(fence->ops);
>>> +    if (ops->signaled && ops->signaled(fence)) {
>>> +        rcu_read_unlock();
>>>            dma_fence_signal_locked(fence);
>>>            return true;
>>>        }
>>> +    rcu_read_unlock();
>>>          return false;
>>>    }
>>> @@ -448,13 +465,19 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
>>>    static inline bool
>>>    dma_fence_is_signaled(struct dma_fence *fence)
>>>    {
>>> +    const struct dma_fence_ops *ops;
>>> +
>>>        if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
>>>            return true;
>>>    -    if (fence->ops->signaled && fence->ops->signaled(fence)) {
>>> +    rcu_read_lock();
>>> +    ops = rcu_dereference(fence->ops);
>>> +    if (ops->signaled && ops->signaled(fence)) {
>>> +        rcu_read_unlock();
>>
>> With the unlocked version two threads could race and one could make the fence->lock go away just around here, before the dma_fence_signal below will take it. It seems it is only safe to rcu_read_unlock before signaling if using the embedded fence (later in the series). Can you think of a downside to holding the rcu read lock to after signaling? that would make it safe I think.
> 
> Well it's good to talk about it but I think that it is not necessary to protect the lock in this particular case.
> 
> See the RCU protection is only for the fence->ops pointer, but the lock can be taken way after the fence is already signaled.
> 
> That's why I came up with the patch to move the lock into the fence in the first place.

Right. And you think there is nothing to gain with the option of keeping 
the rcu_read_unlock() to after signalling? Ie. why not plug a potential 
race if we can for no negative effect.

Regards,

Tvrtko

>> Regards,
>>
>> Tvrtko
>>
>>>            dma_fence_signal(fence);
>>>            return true;
>>>        }
>>> +    rcu_read_unlock();
>>>          return false;
>>>    }
>>
> 


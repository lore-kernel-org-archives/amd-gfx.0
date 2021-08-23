Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC17C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 06:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40FC61284
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 06:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C40FC61284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651F189B9F;
	Mon, 23 Aug 2021 06:50:37 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB23689B9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 06:50:35 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 o39-20020a05600c512700b002e74638b567so2362562wms.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Aug 2021 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qghEmjDCMXfXKOSEhOstu7dPVe7sVuWyUfSxOUUtYic=;
 b=aXG+/KYIpPd8qH7NGyRV2eiwvxs5vJM15xdqPPqaIDFfQgIMTCzBcifvdwXZFrJ2Xo
 YjHLTvXKp0n1Swu1VH2dQt4gjI4/eHYFVgX78RpEdg0lex5FugjvUXgl2roCqFczdM6v
 yl1nozZZQUT6WyFrcIXFOTvQ0MuK10BVhNUxxrMYBaREj3IsqhC2Ljf/wTxWEh7ffuqw
 mW+DCdF3ajyP7KxTuA0U7+uPHSZWxHSxBqykJALr7T65MhgQpeK1CSd5LXQHlnxdDsap
 an9liI4u2gz20ns4rmGLByYkzicImOqWTF7ahGY1N0GZiX5Vr00nAiqgM0JjT2KgKGkC
 cDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qghEmjDCMXfXKOSEhOstu7dPVe7sVuWyUfSxOUUtYic=;
 b=ByF+73ti1qHBBL+aE70I/KJ+B03R3ZBXfsv1HFBBmeCY6/Us+UIMgRCCxy/V/3J02m
 FfGH69KpujYXaj+CdV/Mj6Z82uGRLVsy60LzRFo2BvYQP5gj5LfpKkf7Pysye+3Pmabv
 BSVbXu5YzSlD/TWiIjqbPBf7KeDLEqA1Nmsvyq4frCWHsJK8yZ4wgAIzgwnArUUP7T9l
 ui06XIK2dIwBsEk9wjeLESma3zSBBt3PkWkM3PMFNKfhNhuQFzRyd4gGi6E0envABCYA
 DbMe3ccOanqkzcSS8K46sMKwPpiimeWqCDvMQi/+8iFPwOr6S2QNf/m8gfzcNf3UgD8b
 uORg==
X-Gm-Message-State: AOAM531cCe5TfWPPnjiZN/iwiFBZwfaEVzs/TD+hjQaX3q6pDJh9+SI6
 PhP5IMoRfQBwH7NJlNSpalE=
X-Google-Smtp-Source: ABdhPJxlovmsWV0PjFuM+huhDkxw2iWwV/62J9wJfRJB9cGNm2eWVbazAL2kSz2WizJzHmYgXHAivg==
X-Received: by 2002:a05:600c:1c28:: with SMTP id
 j40mr14623221wms.104.1629701434292; 
 Sun, 22 Aug 2021 23:50:34 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id h11sm8333133wrx.9.2021.08.22.23.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Aug 2021 23:50:33 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, Mike Lothian <mike@fireburn.co.uk>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210802051602.23822-1-guchun.chen@amd.com>
 <9b28973f-d71c-8ca1-32f3-e7dc23563a70@amd.com>
 <CAHbf0-HNwJvmv=D6KDQrNcmaCbtqj0cCZLgE9bWnSoMNBuqS+w@mail.gmail.com>
 <CADnq5_MtY6jHG+VUuuz_Wz2Ka9Tm7p+B-C37SQvwPhhAeLvcVw@mail.gmail.com>
 <DM5PR12MB24697A60CC00D98F946F753DF1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3bc094dc-c453-4b06-23ca-4b53e427c060@gmail.com>
Date: Mon, 23 Aug 2021 08:50:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB24697A60CC00D98F946F753DF1C49@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Good mornings guys,

Andrey has a rather valid concern here, but I think we need to approach 
this from a more high level view.

When hw_fini is called we should make sure that the scheduler can't 
submit any more work to the hardware, because the hw is finalized and 
not expected to response any more.

As far as I can see the cleanest approach would be to stop the scheduler 
in hw_fini and fully clean it up in sw_fini. That would also fit quite 
nicely with how GPU reset is supposed to work I think.

Problem is that this is currently done outside of the fence code for the 
at least the reset case, so before we restructure that we need to stick 
with what we have.

Andrey do you think it would be any problem if we stop the scheduler 
manually in the hot plug case as well?

Thanks,
Christian.

Am 23.08.21 um 08:36 schrieb Chen, Guchun:
> [Public]
>
> Hi Andrey,
>
> Thanks for your notice. The cause why moving drm_sched_fini to sw_fini is it's a SW behavior and part of SW shutdown, so hw_fini should not touch it. But if the race, that scheduler on the ring possibly keeps submitting jobs which causes un-empty ring is there, possibly we still need to call drm_sched_fini first in hw_fini to stop job submission first.
>
> @Koenig, Christian what's your opinion?
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, August 20, 2021 2:13 AM
> To: Mike Lothian <mike@fireburn.co.uk>
> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3 test (v2)
>
> Please go ahead.  Thanks!
>
> Alex
>
> On Thu, Aug 19, 2021 at 8:05 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>> Hi
>>
>> Do I need to open a new bug report for this?
>>
>> Cheers
>>
>> Mike
>>
>> On Wed, 18 Aug 2021 at 06:26, Andrey Grodzovsky <andrey.grodzovsky@amd.com> wrote:
>>>
>>> On 2021-08-02 1:16 a.m., Guchun Chen wrote:
>>>> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to
>>>> stop scheduler in s3 test, otherwise, fence related failure will
>>>> arrive after resume. To fix this and for a better clean up, move
>>>> drm_sched_fini from fence_hw_fini to fence_sw_fini, as it's part of
>>>> driver shutdown, and should never be called in hw_fini.
>>>>
>>>> v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,
>>>> to keep sw_init and sw_fini paired.
>>>>
>>>> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
>>>>    3 files changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index b1d2dc39e8be..9e53ff851496 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device
>>>> *adev,
>>>>
>>>>    fence_driver_init:
>>>>        /* Fence driver */
>>>> -     r = amdgpu_fence_driver_init(adev);
>>>> +     r = amdgpu_fence_driver_sw_init(adev);
>>>>        if (r) {
>>>> -             dev_err(adev->dev, "amdgpu_fence_driver_init failed\n");
>>>> +             dev_err(adev->dev, "amdgpu_fence_driver_sw_init
>>>> + failed\n");
>>>>                amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
>>>>                goto failed;
>>>>        }
>>>> @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>>>>        }
>>>>        amdgpu_fence_driver_hw_init(adev);
>>>>
>>>> -
>>>>        r = amdgpu_device_ip_late_init(adev);
>>>>        if (r)
>>>>                return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> index 49c5c7331c53..7495911516c2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>> @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>    }
>>>>
>>>>    /**
>>>> - * amdgpu_fence_driver_init - init the fence driver
>>>> + * amdgpu_fence_driver_sw_init - init the fence driver
>>>>     * for all possible rings.
>>>>     *
>>>>     * @adev: amdgpu device pointer
>>>> @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>     * amdgpu_fence_driver_start_ring().
>>>>     * Returns 0 for success.
>>>>     */
>>>> -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>>>> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
>>>>    {
>>>>        return 0;
>>>>    }
>>>>
>>>>    /**
>>>> - * amdgpu_fence_driver_fini - tear down the fence driver
>>>> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>>>>     * for all possible rings.
>>>>     *
>>>>     * @adev: amdgpu device pointer
>>>> @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct
>>>> amdgpu_device *adev)
>>>>
>>>>                if (!ring || !ring->fence_drv.initialized)
>>>>                        continue;
>>>> -             if (!ring->no_scheduler)
>>>> -                     drm_sched_fini(&ring->sched);
>>>> +
>>>>                /* You can't wait for HW to signal if it's gone */
>>>>                if (!drm_dev_is_unplugged(&adev->ddev))
>>>>                        r = amdgpu_fence_wait_empty(ring);
>>>
>>> Sorry for late notice, missed this patch. By moving drm_sched_fini
>>> past amdgpu_fence_wait_empty a race is created as even after you
>>> waited for all fences on the ring to signal the sw scheduler will
>>> keep submitting new jobs on the ring and so the ring won't stay empty.
>>>
>>> For hot device removal also we want to prevent any access to HW past
>>> PCI removal in order to not do any MMIO accesses inside the physical
>>> MMIO range that no longer belongs to this device after it's removal
>>> by the PCI core. Stopping all the schedulers prevents any MMIO
>>> accesses done during job submissions and that why drm_sched_fini was
>>> done as part of amdgpu_fence_driver_hw_fini and not
>>> amdgpu_fence_driver_sw_fini
>>>
>>> Andrey
>>>
>>>> @@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>>>>                if (!ring || !ring->fence_drv.initialized)
>>>>                        continue;
>>>>
>>>> +             if (!ring->no_scheduler)
>>>> +                     drm_sched_fini(&ring->sched);
>>>> +
>>>>                for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>>>>                        dma_fence_put(ring->fence_drv.fences[j]);
>>>>                kfree(ring->fence_drv.fences); diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index 27adffa7658d..9c11ced4312c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
>>>>        struct dma_fence                **fences;
>>>>    };
>>>>
>>>> -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
>>>>    void amdgpu_fence_driver_force_completion(struct amdgpu_ring
>>>> *ring);
>>>>
>>>>    int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring, @@
>>>> -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>    int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>>>>                                   struct amdgpu_irq_src *irq_src,
>>>>                                   unsigned irq_type);
>>>> +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>>>    void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>>>> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>>>>    void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>>>> -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>>>    int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
>>>>                      unsigned flags);
>>>>    int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,


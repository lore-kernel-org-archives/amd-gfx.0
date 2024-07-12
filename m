Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD07C3DA4A
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jul 2024 08:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D1710E043;
	Sat, 13 Jul 2024 08:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="k3xhWeSC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796A010EC1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OgNSY01sI+W2m518AENcED8caTBgp6eaJSravSNhAcQ=; b=k3xhWeSCbylWCjgIQjqBbwl3KQ
 ebcofpAxXi/OG+xSTf0K+G4GWhT29BXOTeR+oxPWcyJIE70pRu/U+MAcZfTQeagPnkCY7WU6+g5AA
 RNCtqloT5gTIsq70UMvhZseEQGMh8uswMiAdh4t+k4BaJoZQKKsOoablLjoDBdFBe/PnGdMFLjMof
 hEeqB6lzndmTJGRY8w84yN9YEkesHkdzR0uzHsFAxHWWB73OEqzI+GIwvnJlOPJuTFMbyti+2ybmt
 prV+vs6FIT251xJWhay7+LlYWnDjOnsVXwdysS7sQh8Q37jQfWQ47NsUp+Qgr2/Zz4mnCXyOO4l6R
 fcR6DX8Q==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1sSG5P-00EHrD-1U; Fri, 12 Jul 2024 15:13:19 +0200
Message-ID: <ff38c4d2-361d-4133-a21c-2133423ffc21@igalia.com>
Date: Fri, 12 Jul 2024 14:13:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu: More efficient ring padding
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240711181746.86311-1-tursulin@igalia.com>
 <219f3419-148e-4516-8c57-ee708dc65ef2@gmail.com>
 <f423e497-3617-42bc-af7c-b31760dd2372@igalia.com>
 <8abf0355-6b85-4519-9196-91c817533ce2@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <8abf0355-6b85-4519-9196-91c817533ce2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 13 Jul 2024 08:51:00 +0000
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


On 12/07/2024 14:04, Christian König wrote:
> Am 12.07.24 um 11:14 schrieb Tvrtko Ursulin:
>> On 12/07/2024 08:33, Christian König wrote:
>>> Am 11.07.24 um 20:17 schrieb Tvrtko Ursulin:
>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>
>>>>  From the department of questionable optimisations today we have a 
>>>> minor
>>>> improvement to how padding / filling the rings with nops is done.
>>>>
>>>> Having noticed that typically 200+ nops per submission are filled 
>>>> into the
>>>> ring, using a rather verbose 
>>>> one-nop-at-a-time-plus-ring-buffer-arithmetic
>>>> as done in amdgpu_ring_write(), while right next to it there is
>>>> amdgpu_ring_write_multiple(), I thought why not pre-cache a block of 
>>>> nops
>>>> and write them out more efficiently.
>>>>
>>>> The patch is rather quick and dirty, does not deal with all insert_nops
>>>> vfuncs, and the cache should probably go one level up so it is not
>>>> replicated per amdgpu_ring instance.
>>>
>>> Why should that be more effective? We essentially use more cache 
>>> lines than before.
>>
>> Because:
>>
>>         for (i = 0; i < count; i++)
>>             amdgpu_ring_write(ring, ring->funcs->nop);
>>
>> Expands to quite a lot compared to one memcpy from 
>> amdgpu_ring_write_multiple, and only one set of ring pointer arithmetic?
> 
> Well maybe make another function, e.g. something like amdgpu_ring_fill() 
> which just fills in the same dw multiple times.

Yep, I already started working on amdgpu_ring_fill this morning.

> Or if we only use it here just inline that.
> 
>>
>>>> And performance gains are not that amazing for normal workloads. For
>>>> instance a game which results in two submissions per frame, each pads
>>>> with 222 nops, submission worker thread profile changes from:
>>>
>>> Mhm, why the heck are we using so many nops in the first place?
>>
>> If that was a question for me I cannot offer but a superficially 
>> obvious answer - because ring->funcs->align_mask is 0xff on many 
>> platforms? I mean on the face of it it is doing what it wants to do - 
>> pad to 256 dword boundary before passing the updated ring to the GPU.
> 
> ???? That would be a 1k byte alignment. I haven't looked into that in 
> the last decade, but that used to be no more than 0xf.

Don't ask me! :) There is, 0, 1, 0xf, 0x3f and 0xff as align_mask for 
various skus and engines.

>> Btw another thing could also be more efficient by avoiding the div 
>> instruction:
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 22ec9de62b06..c30206f4cd22 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -151,7 +151,7 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>>         /* We pad to match fetch size */
>>         count = ring->funcs->align_mask + 1 -
>>                 (ring->wptr & ring->funcs->align_mask);
>> -       count %= ring->funcs->align_mask + 1;
>> +       count &= ring->funcs->align_mask;
> 
> Mhm, that's what it originally used it to be (at least in the ring_write 
> function).

Ack, I will include that as a patch when I have everything ready to send 
out.

Regards,

Tvrtko

> 
> Regards,
> Christian.
> 
>> ring->funcs->insert_nop(ring, count);
>>
>>         mb();
>>
>> Regards,
>>
>> Tvrtko
>>
>>>> +   90.78%     0.67%  kworker/u32:3-e [kernel.kallsyms]  [k] 
>>>> process_one_work
>>>> +   48.92%     0.12%  kworker/u32:3-e  [kernel.kallsyms]  [k] 
>>>> commit_tail
>>>> +   41.18%     1.73%  kworker/u32:3-e  [kernel.kallsyms]  [k] 
>>>> amdgpu_dm_atomic_commit_tail
>>>> -   30.31%     0.67%  kworker/u32:3-e  [kernel.kallsyms]  [k] 
>>>> drm_sched_run_job_work
>>>>     - 29.63% drm_sched_run_job_work
>>>>        + 8.55% dma_fence_add_callback
>>>>        - 7.50% amdgpu_job_run
>>>>           - 7.43% amdgpu_ib_schedule
>>>>              - 2.46% amdgpu_ring_commit
>>>>                   1.44% amdgpu_ring_insert_nop
>>>>
>>>> To:
>>>>
>>>> +   89.83%     0.51%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>>> process_one_work
>>>> +   47.65%     0.30%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>>> commit_tail
>>>> +   39.42%     1.97%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>>> amdgpu_dm_atomic_commit_tail
>>>> -   29.57%     1.10%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>>> drm_sched_run_job_work
>>>>     - 28.47% drm_sched_run_job_work
>>>>        + 8.52% dma_fence_add_callback
>>>>        - 6.33% amdgpu_job_run
>>>>           - 6.19% amdgpu_ib_schedule
>>>>              - 1.85% amdgpu_ring_commit
>>>>                   0.53% amdgpu_ring_insert_nop
>>>>
>>>> Or if we run a more "spammy" workload, which does several orders of
>>>> magnitude more submissions second we go from:
>>>>
>>>> +   79.38%     1.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] 
>>>> process_one_work
>>>> -   63.13%     6.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] 
>>>> drm_sched_run_job_work
>>>>     - 56.47% drm_sched_run_job_work
>>>>        - 25.67% amdgpu_job_run
>>>>           - 24.40% amdgpu_ib_schedule
>>>>              - 15.29% amdgpu_ring_commit
>>>>                   12.06% amdgpu_ring_insert_nop
>>>>
>>>> To:
>>>>
>>>> +   77.76%     1.97%  kworker/u32:6-f  [kernel.kallsyms]  [k] 
>>>> process_one_work
>>>> -   60.15%     7.04%  kworker/u32:6-f  [kernel.kallsyms]  [k] 
>>>> drm_sched_run_job_work
>>>>     - 53.11% drm_sched_run_job_work
>>>>        - 19.35% amdgpu_job_run
>>>>           - 17.85% amdgpu_ib_schedule
>>>>              - 7.75% amdgpu_ring_commit
>>>>                   3.27% amdgpu_ring_insert_nop
>>>>
>>>> Not bad and "every little helps", or flame-throwers at ready?
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 20 +++++++++++++++-----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>>>>   2 files changed, 16 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index ad49cecb20b8..22ec9de62b06 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -108,10 +108,14 @@ int amdgpu_ring_alloc(struct amdgpu_ring 
>>>> *ring, unsigned int ndw)
>>>>    */
>>>>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>>>>   {
>>>> -    int i;
>>>> +    if (count > 1 && count <= ARRAY_SIZE(ring->nop_cache)) {
>>>> +        amdgpu_ring_write_multiple(ring, ring->nop_cache, count);
>>>> +    } else {
>>>> +        int i;
>>>> -    for (i = 0; i < count; i++)
>>>> -        amdgpu_ring_write(ring, ring->funcs->nop);
>>>> +        for (i = 0; i < count; i++)
>>>> +            amdgpu_ring_write(ring, ring->funcs->nop);
>>>> +    }
>>>>   }
>>>>   /**
>>>> @@ -124,8 +128,11 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring 
>>>> *ring, uint32_t count)
>>>>    */
>>>>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct 
>>>> amdgpu_ib *ib)
>>>>   {
>>>> -    while (ib->length_dw & ring->funcs->align_mask)
>>>> -        ib->ptr[ib->length_dw++] = ring->funcs->nop;
>>>> +    u32 count = ib->length_dw & ring->funcs->align_mask;
>>>> +
>>>> +    memcpy(&ib->ptr[ib->length_dw], ring->nop_cache, count * 
>>>> sizeof(u32));
>>>> +
>>>> +    ib->length_dw += count;
>>>>   }
>>>>   /**
>>>> @@ -359,6 +366,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, 
>>>> struct amdgpu_ring *ring,
>>>>               &ring->sched;
>>>>       }
>>>> +    for (r = 0; r < ARRAY_SIZE(ring->nop_cache); r++)
>>>> +        ring->nop_cache[r] = ring->funcs->nop;
>>>> +
>>>>       return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index 582053f1cd56..74ce95b4666a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -246,6 +246,7 @@ struct amdgpu_ring {
>>>>       struct amdgpu_bo    *ring_obj;
>>>>       volatile uint32_t    *ring;
>>>>       unsigned        rptr_offs;
>>>> +    u32            nop_cache[256];
>>>>       u64            rptr_gpu_addr;
>>>>       volatile u32        *rptr_cpu_addr;
>>>>       u64            wptr;
>>>
> 

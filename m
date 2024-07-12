Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF5CC3DA4B
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 13:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58BD10ECF8;
	Fri, 12 Jul 2024 13:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gtSkrwRK";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B9310ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 13:04:19 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-42797289c8bso14628275e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720789457; x=1721394257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f46thUf4l1eUUYORtc4dKAoWFh2m3Oc519GB0UKoiGM=;
 b=gtSkrwRKXAzrbLaQUuj2GbPRg6IVFFekhAe/FRkJ7saCpdyMbKCk/KqCINeuUr10Xv
 gMh90H2TOaUPXXWLPUnp7zJrDY4YOqrE4QWXO7M+XJLJHiRGOMq8SmDReLYphxF+dfgx
 38wZS0eYJoRHkWkx+4KC/9a+Z0P+Va4QOn6tGSCYYmtxrN3BSqWbhcYa+Nh9ww4RvxfS
 bfzOnuF0MSP6Txnd1q1Wt5Q2qQZZkXxh+gGWAEg4RPQmhHRKB9hvuB3Vj6034NZ+AeeU
 +J8PThlnlPDTbQM6L1mvRZTosoroviqScciGzq2XdufHnzgA+RKGNW7kGMtGRRpUBCRN
 PEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720789457; x=1721394257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f46thUf4l1eUUYORtc4dKAoWFh2m3Oc519GB0UKoiGM=;
 b=P03CBwLZv1phI4sBOhTZMe8eAg9ZQAkvUF5Zhy7vxndLHROmwEWbDZgileXXi4PxHX
 vnGdZavQu/oWHAJ4wzJK5voX6TZWwjz8hUhCkDlHC0hPw5gT7InL+1Rwr+FfLms4uyt3
 y9vgy5dScOFSc49rrpSJRNQD3+n27bdqh5hWcY567yKhWLmtSUcJkC0n+D+VJK8bbr0u
 x4f+X4QYCOSOZhA5K6CbFAXsLg5Dybury/gV4ukpyEfZclpQL75DLOwp/cpio/GuzJ+B
 Hs5vZXrj11wAalsTwlUbihdOScBswiIy5PowPHV9fOag/31blbpffMhLZmh9OIA5/HU+
 X2JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV88yMQtHuH57Lo6xLtB/LaQU+RF1WaWtssiDVJBauPib764VZ2USLmC5pK8NHvYPKguoU0uD+BLkQUVsbgJSln5wubRGLPM78BqTEJ6A==
X-Gm-Message-State: AOJu0YwHTxsZRy6yU5uSqYSb8DjzdQPhqG2Z8HRni3Rt96XIHh3WpLym
 h5yg8OY2cinXZdH1+ofI45xQG9xd5nUTM6JMm3sSRNa746a2Pbl+
X-Google-Smtp-Source: AGHT+IFAi8bD/SD3rycWLwiOCq8+IUeah2w8HWGOP4MjCE3TGRYSBRCZic69p8PYzGUWWe1Htsm33g==
X-Received: by 2002:a5d:6487:0:b0:368:64e:a7dd with SMTP id
 ffacd0b85a97d-368064ea946mr1144935f8f.53.1720789456733; 
 Fri, 12 Jul 2024 06:04:16 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa07dasm10192172f8f.87.2024.07.12.06.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 06:04:16 -0700 (PDT)
Message-ID: <8abf0355-6b85-4519-9196-91c817533ce2@gmail.com>
Date: Fri, 12 Jul 2024 15:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu: More efficient ring padding
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240711181746.86311-1-tursulin@igalia.com>
 <219f3419-148e-4516-8c57-ee708dc65ef2@gmail.com>
 <f423e497-3617-42bc-af7c-b31760dd2372@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <f423e497-3617-42bc-af7c-b31760dd2372@igalia.com>
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

Am 12.07.24 um 11:14 schrieb Tvrtko Ursulin:
> On 12/07/2024 08:33, Christian König wrote:
>> Am 11.07.24 um 20:17 schrieb Tvrtko Ursulin:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>>  From the department of questionable optimisations today we have a 
>>> minor
>>> improvement to how padding / filling the rings with nops is done.
>>>
>>> Having noticed that typically 200+ nops per submission are filled 
>>> into the
>>> ring, using a rather verbose 
>>> one-nop-at-a-time-plus-ring-buffer-arithmetic
>>> as done in amdgpu_ring_write(), while right next to it there is
>>> amdgpu_ring_write_multiple(), I thought why not pre-cache a block of 
>>> nops
>>> and write them out more efficiently.
>>>
>>> The patch is rather quick and dirty, does not deal with all insert_nops
>>> vfuncs, and the cache should probably go one level up so it is not
>>> replicated per amdgpu_ring instance.
>>
>> Why should that be more effective? We essentially use more cache 
>> lines than before.
>
> Because:
>
>         for (i = 0; i < count; i++)
>             amdgpu_ring_write(ring, ring->funcs->nop);
>
> Expands to quite a lot compared to one memcpy from 
> amdgpu_ring_write_multiple, and only one set of ring pointer arithmetic?

Well maybe make another function, e.g. something like amdgpu_ring_fill() 
which just fills in the same dw multiple times.

Or if we only use it here just inline that.

>
>>> And performance gains are not that amazing for normal workloads. For
>>> instance a game which results in two submissions per frame, each pads
>>> with 222 nops, submission worker thread profile changes from:
>>
>> Mhm, why the heck are we using so many nops in the first place?
>
> If that was a question for me I cannot offer but a superficially 
> obvious answer - because ring->funcs->align_mask is 0xff on many 
> platforms? I mean on the face of it it is doing what it wants to do - 
> pad to 256 dword boundary before passing the updated ring to the GPU.

???? That would be a 1k byte alignment. I haven't looked into that in 
the last decade, but that used to be no more than 0xf.

>
> Btw another thing could also be more efficient by avoiding the div 
> instruction:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 22ec9de62b06..c30206f4cd22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -151,7 +151,7 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>         /* We pad to match fetch size */
>         count = ring->funcs->align_mask + 1 -
>                 (ring->wptr & ring->funcs->align_mask);
> -       count %= ring->funcs->align_mask + 1;
> +       count &= ring->funcs->align_mask;

Mhm, that's what it originally used it to be (at least in the ring_write 
function).

Regards,
Christian.

> ring->funcs->insert_nop(ring, count);
>
>         mb();
>
> Regards,
>
> Tvrtko
>
>>> +   90.78%     0.67%  kworker/u32:3-e [kernel.kallsyms]  [k] 
>>> process_one_work
>>> +   48.92%     0.12%  kworker/u32:3-e  [kernel.kallsyms]  [k] 
>>> commit_tail
>>> +   41.18%     1.73%  kworker/u32:3-e  [kernel.kallsyms]  [k] 
>>> amdgpu_dm_atomic_commit_tail
>>> -   30.31%     0.67%  kworker/u32:3-e  [kernel.kallsyms]  [k] 
>>> drm_sched_run_job_work
>>>     - 29.63% drm_sched_run_job_work
>>>        + 8.55% dma_fence_add_callback
>>>        - 7.50% amdgpu_job_run
>>>           - 7.43% amdgpu_ib_schedule
>>>              - 2.46% amdgpu_ring_commit
>>>                   1.44% amdgpu_ring_insert_nop
>>>
>>> To:
>>>
>>> +   89.83%     0.51%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>> process_one_work
>>> +   47.65%     0.30%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>> commit_tail
>>> +   39.42%     1.97%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>> amdgpu_dm_atomic_commit_tail
>>> -   29.57%     1.10%  kworker/u32:6-g  [kernel.kallsyms]  [k] 
>>> drm_sched_run_job_work
>>>     - 28.47% drm_sched_run_job_work
>>>        + 8.52% dma_fence_add_callback
>>>        - 6.33% amdgpu_job_run
>>>           - 6.19% amdgpu_ib_schedule
>>>              - 1.85% amdgpu_ring_commit
>>>                   0.53% amdgpu_ring_insert_nop
>>>
>>> Or if we run a more "spammy" workload, which does several orders of
>>> magnitude more submissions second we go from:
>>>
>>> +   79.38%     1.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] 
>>> process_one_work
>>> -   63.13%     6.66%  kworker/u32:1+e  [kernel.kallsyms]  [k] 
>>> drm_sched_run_job_work
>>>     - 56.47% drm_sched_run_job_work
>>>        - 25.67% amdgpu_job_run
>>>           - 24.40% amdgpu_ib_schedule
>>>              - 15.29% amdgpu_ring_commit
>>>                   12.06% amdgpu_ring_insert_nop
>>>
>>> To:
>>>
>>> +   77.76%     1.97%  kworker/u32:6-f  [kernel.kallsyms]  [k] 
>>> process_one_work
>>> -   60.15%     7.04%  kworker/u32:6-f  [kernel.kallsyms]  [k] 
>>> drm_sched_run_job_work
>>>     - 53.11% drm_sched_run_job_work
>>>        - 19.35% amdgpu_job_run
>>>           - 17.85% amdgpu_ib_schedule
>>>              - 7.75% amdgpu_ring_commit
>>>                   3.27% amdgpu_ring_insert_nop
>>>
>>> Not bad and "every little helps", or flame-throwers at ready?
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 20 +++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>>>   2 files changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index ad49cecb20b8..22ec9de62b06 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -108,10 +108,14 @@ int amdgpu_ring_alloc(struct amdgpu_ring 
>>> *ring, unsigned int ndw)
>>>    */
>>>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>>>   {
>>> -    int i;
>>> +    if (count > 1 && count <= ARRAY_SIZE(ring->nop_cache)) {
>>> +        amdgpu_ring_write_multiple(ring, ring->nop_cache, count);
>>> +    } else {
>>> +        int i;
>>> -    for (i = 0; i < count; i++)
>>> -        amdgpu_ring_write(ring, ring->funcs->nop);
>>> +        for (i = 0; i < count; i++)
>>> +            amdgpu_ring_write(ring, ring->funcs->nop);
>>> +    }
>>>   }
>>>   /**
>>> @@ -124,8 +128,11 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring 
>>> *ring, uint32_t count)
>>>    */
>>>   void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct 
>>> amdgpu_ib *ib)
>>>   {
>>> -    while (ib->length_dw & ring->funcs->align_mask)
>>> -        ib->ptr[ib->length_dw++] = ring->funcs->nop;
>>> +    u32 count = ib->length_dw & ring->funcs->align_mask;
>>> +
>>> +    memcpy(&ib->ptr[ib->length_dw], ring->nop_cache, count * 
>>> sizeof(u32));
>>> +
>>> +    ib->length_dw += count;
>>>   }
>>>   /**
>>> @@ -359,6 +366,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, 
>>> struct amdgpu_ring *ring,
>>>               &ring->sched;
>>>       }
>>> +    for (r = 0; r < ARRAY_SIZE(ring->nop_cache); r++)
>>> +        ring->nop_cache[r] = ring->funcs->nop;
>>> +
>>>       return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 582053f1cd56..74ce95b4666a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -246,6 +246,7 @@ struct amdgpu_ring {
>>>       struct amdgpu_bo    *ring_obj;
>>>       volatile uint32_t    *ring;
>>>       unsigned        rptr_offs;
>>> +    u32            nop_cache[256];
>>>       u64            rptr_gpu_addr;
>>>       volatile u32        *rptr_cpu_addr;
>>>       u64            wptr;
>>


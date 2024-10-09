Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D54FCEDD89
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 12:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29FB10E299;
	Wed,  9 Oct 2024 12:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RakB30IL";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5536310E299
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 12:07:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-42e748f78d6so60446145e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Oct 2024 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728475647; x=1729080447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fgfsy0t6s8V3HJ3EPoyvFdB8JobAEE6K1ohLyIrALy4=;
 b=RakB30ILq/xEc1e2ejyKggwwZRtTWKXu/IkMFQonuisLNJQXuNeJW21teMUtWQdQsX
 aiart/rR9GqKjUyMhwe3vaqH5hPfbt7ynvmQ5qu4GiGYTuorPVGa285Ld81KN4WcC8Is
 Wg6nqX3Qo5583nWV0OSlgfVylfyZLAaiLOTtCR3/cI/32SxaY1/SXVg+nmrnCvV98+Ac
 PvJE6ktYV/HCrg4D//rjkumJJXeVF4y/8Zf8tLTDwLYFZFFTaMxpVid3A8ijc9ql7769
 KcCb4hiW/HKpCRTwb6yV2+p4q955H9Pxly3PIzOIs6zqYjaSGJebms7hpSkQnlPcNkp6
 fi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728475647; x=1729080447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fgfsy0t6s8V3HJ3EPoyvFdB8JobAEE6K1ohLyIrALy4=;
 b=R5ft+OK6jBuhocE8eA90PN649wlab4km9bNH3TEiA+8b61YDhe/KVhvHaq/iocnOsy
 ex4c9QvbfnQRx2PK+BU85TbELgbnLrvPLCJsS8afSBqKneYOgdM2KwqNwjZT6Z4lgA8E
 B4fT0+ObhHDalIbfnTKUZbqJlWkS0qCj6O9FyNsYS3+yvlRb5X/2crXJY+4TgXTlR1HK
 QvebIpE/nC/J0lknLdBgYjDhkZZow36DIKkZ/+NHHAwZwWhX4QJcJky1wT3DdrWNquGg
 O3Ca9nuLcvuaGb8SCRFDVW+LSUoXS9NdHZbup+vnZLea2YW4X/1tCI+0vxMNZoyGHA6l
 /NGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHQHyHDb0YSLiZRpD48dzCyv3Uaa2lAsuP5GzAK16rbOCuFFwMSUYEm4+MTYSCqH/2nvnJ6BYi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+D0eZQqIyB38oDgpuHqYlGozu8DH/q+6qFHtjf91fuW71xc+G
 7eqvypLFi0ZOkqdi306I8j2seJ33BfNlUeBfI0Ouse8fKK1EIUb7
X-Google-Smtp-Source: AGHT+IG1p9m3E+Rb5X1fhfnJPwEtTTGBwOvlN9HP7jEeGM9xmHp6bZjCzyipw6RbqLQPz2mL+wh71g==
X-Received: by 2002:a05:600c:1f0d:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-430d6faa2b6mr12950735e9.27.1728475646228; 
 Wed, 09 Oct 2024 05:07:26 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5f462sm18559435e9.23.2024.10.09.05.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 05:07:25 -0700 (PDT)
Message-ID: <61ffa4c6-ba96-4298-9578-209248bd8cae@gmail.com>
Date: Wed, 9 Oct 2024 14:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: drop volatile from ring buffer
To: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org,
 tursulin@igalia.com, sunil.khatri@amd.com
References: <20241008181134.1350-1-christian.koenig@amd.com>
 <3d3de66f-01fd-4adb-83c6-140bfc570f1f@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3d3de66f-01fd-4adb-83c6-140bfc570f1f@ursulin.net>
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

Am 09.10.24 um 09:41 schrieb Tvrtko Ursulin:
>
> On 08/10/2024 19:11, Christian König wrote:
>> Volatile only prevents the compiler from re-ordering reads and writes.
>> Since we always only modify the ring buffer from one CPU thread and have
>> an explicit barrier before signaling the HW this should have no 
>> effect at
>> all and just prevents compiler optimisations.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 +++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 ++++-------
>>   2 files changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 910293664902..a6e28fe3f8d6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -109,21 +109,17 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, 
>> unsigned int ndw)
>>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>>   {
>>       uint32_t occupied, chunk1, chunk2;
>> -    uint32_t *dst;
>>         occupied = ring->wptr & ring->buf_mask;
>> -    dst = &ring->ring[occupied];
>>       chunk1 = ring->buf_mask + 1 - occupied;
>>       chunk1 = (chunk1 >= count) ? count : chunk1;
>>       chunk2 = count - chunk1;
>>         if (chunk1)
>> -        memset32(dst, ring->funcs->nop, chunk1);
>> +        memset32(&ring->ring[occupied], ring->funcs->nop, chunk1);
>>   -    if (chunk2) {
>> -        dst = ring->ring;
>> -        memset32(dst, ring->funcs->nop, chunk2);
>> -    }
>> +    if (chunk2)
>> +        memset32(ring->ring, ring->funcs->nop, chunk2);
>>         ring->wptr += count;
>>       ring->wptr &= ring->ptr_mask;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 574336d6714a..36fc9578c53c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -246,7 +246,7 @@ struct amdgpu_ring {
>>       struct drm_gpu_scheduler    sched;
>>         struct amdgpu_bo    *ring_obj;
>> -    volatile uint32_t    *ring;
>> +    uint32_t        *ring;
>>       unsigned        rptr_offs;
>>       u64            rptr_gpu_addr;
>>       volatile u32        *rptr_cpu_addr;
>> @@ -288,7 +288,7 @@ struct amdgpu_ring {
>>       u64            cond_exe_gpu_addr;
>>       volatile u32        *cond_exe_cpu_addr;
>>       unsigned int        set_q_mode_offs;
>> -    volatile u32        *set_q_mode_ptr;
>> +    u32            *set_q_mode_ptr;
>>       u64            set_q_mode_token;
>>       unsigned        vm_hub;
>>       unsigned        vm_inv_eng;
>> @@ -386,10 +386,8 @@ static inline void 
>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>                             void *src, int count_dw)
>>   {
>>       unsigned occupied, chunk1, chunk2;
>> -    void *dst;
>>         occupied = ring->wptr & ring->buf_mask;
>> -    dst = (void *)&ring->ring[occupied];
>>       chunk1 = ring->buf_mask + 1 - occupied;
>>       chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
>>       chunk2 = count_dw - chunk1;
>> @@ -397,12 +395,11 @@ static inline void 
>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>       chunk2 <<= 2;
>>         if (chunk1)
>> -        memcpy(dst, src, chunk1);
>> +        memcpy(&ring->ring[occupied], src, chunk1);
>>         if (chunk2) {
>>           src += chunk1;
>> -        dst = (void *)ring->ring;
>> -        memcpy(dst, src, chunk2);
>> +        memcpy(ring->ring, src, chunk2);
>>       }
>>         ring->wptr += count_dw;
>
> Dropping volatile and removal of local variables in 
> amdgpu_ring_insert_nop() and amdgpu_ring_write_multiple() look 
> unrelated to me. Best practice would be if you had split those two 
> changes. Or at least add to the commit message the usual "while at it" 
> blurb.

To me it looked like the main purpose of the local variable was to add 
the void* cast to avoid the compiler warning of removing the volatile 
when giving the parameter to memcpy().

Since that isn't needed any more I've got rid of the local variable as well.

Regards,
Christian.

>
> Regards,
>
> Tvrtko


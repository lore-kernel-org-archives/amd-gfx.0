Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711C0CF11F9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 14:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529FB10E929;
	Thu, 10 Oct 2024 14:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ONeJaLY0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D279A10E731
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hvmnoVin3uwbp7DWP32ewZSv1d4i8HnsstPAvgbfLnU=; b=ONeJaLY0wINqD1Vp+xIc8Vs7xI
 +BmbaZR8NArdREPA1nZXrNw5j0wMtEA+EYFV/UzDcA0Trl29WtTORhxP+mY1c7SN7E2a2GiII2LSn
 vyT71ppjewAcxq1ov5VxPU1bhM0blfccuV5mrbxxtLtHv8bVss8yhoYpsOhNEwgBO2qICr3YUy52/
 PilvW4Ry9nfOan9uYT+W6wX5mbK3zPebwobWb3h8kKG6s7nHEdTLogJTUTnqfSoIGt7sXEx1AHYSz
 NnqYHtY2Lyyz7Z4yaIK5jMncfQLLDOngShYLeMN7clL7vzHik1W0YYUZUTmy/V0Gi53jqAcaX+Lis
 0OH/GBaw==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1syXPh-006xxr-Tv; Wed, 09 Oct 2024 16:11:41 +0200
Message-ID: <d131c822-8c9b-4952-a252-bd96d091f838@igalia.com>
Date: Wed, 9 Oct 2024 15:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: drop volatile from ring buffer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org,
 tursulin@igalia.com, sunil.khatri@amd.com
References: <20241008181134.1350-1-christian.koenig@amd.com>
 <3d3de66f-01fd-4adb-83c6-140bfc570f1f@ursulin.net>
 <61ffa4c6-ba96-4298-9578-209248bd8cae@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <61ffa4c6-ba96-4298-9578-209248bd8cae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Oct 2024 14:41:05 +0000
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


On 09/10/2024 13:07, Christian König wrote:
> Am 09.10.24 um 09:41 schrieb Tvrtko Ursulin:
>>
>> On 08/10/2024 19:11, Christian König wrote:
>>> Volatile only prevents the compiler from re-ordering reads and writes.
>>> Since we always only modify the ring buffer from one CPU thread and have
>>> an explicit barrier before signaling the HW this should have no 
>>> effect at
>>> all and just prevents compiler optimisations.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 +++-------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 ++++-------
>>>   2 files changed, 7 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 910293664902..a6e28fe3f8d6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -109,21 +109,17 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, 
>>> unsigned int ndw)
>>>   void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>>>   {
>>>       uint32_t occupied, chunk1, chunk2;
>>> -    uint32_t *dst;
>>>         occupied = ring->wptr & ring->buf_mask;
>>> -    dst = &ring->ring[occupied];
>>>       chunk1 = ring->buf_mask + 1 - occupied;
>>>       chunk1 = (chunk1 >= count) ? count : chunk1;
>>>       chunk2 = count - chunk1;
>>>         if (chunk1)
>>> -        memset32(dst, ring->funcs->nop, chunk1);
>>> +        memset32(&ring->ring[occupied], ring->funcs->nop, chunk1);
>>>   -    if (chunk2) {
>>> -        dst = ring->ring;
>>> -        memset32(dst, ring->funcs->nop, chunk2);
>>> -    }
>>> +    if (chunk2)
>>> +        memset32(ring->ring, ring->funcs->nop, chunk2);
>>>         ring->wptr += count;
>>>       ring->wptr &= ring->ptr_mask;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 574336d6714a..36fc9578c53c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -246,7 +246,7 @@ struct amdgpu_ring {
>>>       struct drm_gpu_scheduler    sched;
>>>         struct amdgpu_bo    *ring_obj;
>>> -    volatile uint32_t    *ring;
>>> +    uint32_t        *ring;
>>>       unsigned        rptr_offs;
>>>       u64            rptr_gpu_addr;
>>>       volatile u32        *rptr_cpu_addr;
>>> @@ -288,7 +288,7 @@ struct amdgpu_ring {
>>>       u64            cond_exe_gpu_addr;
>>>       volatile u32        *cond_exe_cpu_addr;
>>>       unsigned int        set_q_mode_offs;
>>> -    volatile u32        *set_q_mode_ptr;
>>> +    u32            *set_q_mode_ptr;
>>>       u64            set_q_mode_token;
>>>       unsigned        vm_hub;
>>>       unsigned        vm_inv_eng;
>>> @@ -386,10 +386,8 @@ static inline void 
>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>                             void *src, int count_dw)
>>>   {
>>>       unsigned occupied, chunk1, chunk2;
>>> -    void *dst;
>>>         occupied = ring->wptr & ring->buf_mask;
>>> -    dst = (void *)&ring->ring[occupied];
>>>       chunk1 = ring->buf_mask + 1 - occupied;
>>>       chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
>>>       chunk2 = count_dw - chunk1;
>>> @@ -397,12 +395,11 @@ static inline void 
>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>       chunk2 <<= 2;
>>>         if (chunk1)
>>> -        memcpy(dst, src, chunk1);
>>> +        memcpy(&ring->ring[occupied], src, chunk1);
>>>         if (chunk2) {
>>>           src += chunk1;
>>> -        dst = (void *)ring->ring;
>>> -        memcpy(dst, src, chunk2);
>>> +        memcpy(ring->ring, src, chunk2);
>>>       }
>>>         ring->wptr += count_dw;
>>
>> Dropping volatile and removal of local variables in 
>> amdgpu_ring_insert_nop() and amdgpu_ring_write_multiple() look 
>> unrelated to me. Best practice would be if you had split those two 
>> changes. Or at least add to the commit message the usual "while at it" 
>> blurb.
> 
> To me it looked like the main purpose of the local variable was to add 
> the void* cast to avoid the compiler warning of removing the volatile 
> when giving the parameter to memcpy().
> 
> Since that isn't needed any more I've got rid of the local variable as 
> well.

Agreed on that, but I would still add a paragraph in the commit message. 
Can add while merging too, no need to respin. Something like:

"With that removed we can also remove the local variable in two places 
which relied on it to strip the volatile property."

Regards,

Tvrtko

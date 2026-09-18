Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E515C982DF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 13:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7285D10E0E0;
	Fri, 18 Sep 2026 13:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XSXn6/AR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9329410E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=sI2HOAbcdXPtQdyPX1FxwPK/P2diMfjXizUcSJrJW1U=; b=XSXn6/ARyeMpjt2IrKSgGG7l3R
 0gNtgBXw4JqjJ2JEgnzc/jLRlr9GsX/7hT3IYFyOnM3Dt9M+5H5Up4s5eimPZe3puC7Bfw8ZX9O8X
 NbxZcbHdwDFiiQmBwZfQhFUqYMOD+iCBWpkmQhY7XgXs480xfa57okAIcAMAK4y3Z4iTMYQylzAZF
 gKfME7H42Rglnps5wvGeqZPswnM6UY1PEW9R/tk52tzW+ogFsEmVwpUF/PPS8tvZ3KAD2KhU7a5T1
 yb5n9/sJQppQk9EGq+brweOlPlY/tmCzw8OOnMcd3VW+4Fs87wW+b2hYZWqVyfSwyQ9HXLe9LEHgd
 9U+EpQvg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x7YeW-003xaU-LV; Fri, 18 Sep 2026 15:29:20 +0200
Message-ID: <052c9390-8906-4f8f-a501-30730c41f011@igalia.com>
Date: Fri, 18 Sep 2026 14:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: More compact VCN IB emission
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
 <20260918120518.96922-2-tvrtko.ursulin@igalia.com>
 <474139b2-c3c2-4d2b-81d7-e209231870f2@amd.com>
 <84ae6c9c-6ea5-4e02-9dbe-5ba855580da1@igalia.com>
 <de963600-ba53-4e34-bba1-2a838cbc2457@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <de963600-ba53-4e34-bba1-2a838cbc2457@amd.com>
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


On 18/09/2026 14:23, Lazar, Lijo wrote:
> On 18-Sep-26 6:43 PM, Tvrtko Ursulin wrote:
>>
>> On 18/09/2026 14:08, Lazar, Lijo wrote:
>>>
>>>
>>> On 18-Sep-26 5:35 PM, Tvrtko Ursulin wrote:
>>>> Avoid constant register reloads while emitting IBs by using a local 
>>>> write
>>>> pointer and only updating the size at the end of each helper.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>> v2:
>>>>   *  Fix decode buffer overwrite
>>>
>>> Overall for this series, below type of calculation  -
>>>
>>>      ib->length_dw = ptr - ib->ptr;
>>>
>>> is not anticipating a case like below.
>>>
>>>          r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>>>          if (r)
>>>                  goto error;
>>>
>>>          r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>>>          if (r)
>>>                  goto error;
>>
>> So amdgpu_vcn_enc_ring_test_ib() - are you saying there is a bug 
>> there? Help me see it please.
>>
>> ib->length_dw update is enclosed in both of those helpers, same as 
>> before the patch.
>>
> 
> What I'm saying is -
> 
> It's the same ib pointer that is passed to back to back calls.
> 
> Legacy implementation fills like -
> 
> ib->ptr[ib->length_dw++]
> 
> So no assumption that it is starting from offset 0 always. After the 
> function is filled, length gets updated based on what is filled.
> 
> I don't see the same with an assignment like
> 
>      ib->length_dw = ptr - ib->ptr;

Hm, but both of those helpers emit separate jobs with their own 
respective IB.

Regards,

Tvrtko

>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 134 ++++++++++++ 
>>>> +-----------
>>>>   1 file changed, 75 insertions(+), 59 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_vcn.c
>>>> index 17db7264269e..2c367ee6e182 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> @@ -622,9 +622,12 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>> amdgpu_ring *ring,
>>>>   {
>>>>       u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>       struct amdgpu_device *adev = ring->adev;
>>>> +    struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring- 
>>>> >me].internal;
>>>> +    uint32_t nop = PACKET0(internal->nop, 0);
>>>>       struct dma_fence *f = NULL;
>>>>       struct amdgpu_job *job;
>>>>       struct amdgpu_ib *ib;
>>>> +    uint32_t *ptr;
>>>>       int i, r;
>>>>       r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>>>> @@ -635,15 +638,16 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>> amdgpu_ring *ring,
>>>>           goto err;
>>>>       ib = &job->ibs[0];
>>>> -    ib->ptr[0] = PACKET0(adev->vcn.inst[ring->me].internal.data0, 0);
>>>> -    ib->ptr[1] = addr;
>>>> -    ib->ptr[2] = PACKET0(adev->vcn.inst[ring->me].internal.data1, 0);
>>>> -    ib->ptr[3] = addr >> 32;
>>>> -    ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
>>>> -    ib->ptr[5] = 0;
>>>> +    ptr = ib->ptr;
>>>> +    *ptr++ = PACKET0(internal->data0, 0);
>>>> +    *ptr++ = addr;
>>>> +    *ptr++ = PACKET0(internal->data1, 0);
>>>> +    *ptr++ = addr >> 32;
>>>> +    *ptr++ = PACKET0(internal->cmd, 0);
>>>> +    *ptr++ = 0;
>>>>       for (i = 6; i < 16; i += 2) {
>>>> -        ib->ptr[i] = PACKET0(adev->vcn.inst[ring->me].internal.nop, 
>>>> 0);
>>>> -        ib->ptr[i+1] = 0;
>>>> +        *ptr++ = nop;
>>>> +        *ptr++ = 0;
>>>>       }
>>>>       ib->length_dw = 16;
>>>> @@ -763,17 +767,20 @@ int amdgpu_vcn_dec_ring_test_ib(struct 
>>>> amdgpu_ring *ring, long timeout)
>>>>   static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct 
>>>> amdgpu_ib *ib,
>>>>                           uint32_t ib_pack_in_dw, bool enc)
>>>>   {
>>>> +    u32 *ptr = &ib->ptr[ib->length_dw];
>>>>       uint32_t *ib_checksum;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* single queue checksum */
>>>> -    ib->ptr[ib->length_dw++] = 0x30000002;
>>>> -    ib_checksum = &ib->ptr[ib->length_dw++];
>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw;
>>>> +    *ptr++ = 0x00000010; /* single queue checksum */
>>>> +    *ptr++ = 0x30000002;
>>>> +    ib_checksum = ptr++;
>>>> +    *ptr++ = ib_pack_in_dw;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
>>>> -    ib->ptr[ib->length_dw++] = 0x30000001;
>>>> -    ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
>>>> +    *ptr++ = 0x00000010; /* engine info */
>>>> +    *ptr++ = 0x30000001;
>>>> +    *ptr++ = enc ? 0x2 : 0x3;
>>>> +    *ptr++ = ib_pack_in_dw * sizeof(uint32_t);
>>>> +
>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>       return ib_checksum;
>>>>   }
>>>> @@ -803,7 +810,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>>>> amdgpu_ring *ring,
>>>>       uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>       uint32_t *ib_checksum;
>>>>       uint32_t ib_pack_in_dw;
>>>> -    int i, r;
>>>> +    u32 *ptr;
>>>> +    int r;
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           ib_size_dw += 8;
>>>> @@ -825,18 +833,20 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>>>> amdgpu_ring *ring,
>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>> ib_pack_in_dw, false);
>>>>       }
>>>> -    ib->ptr[ib->length_dw++] = sizeof(struct 
>>>> amdgpu_vcn_decode_buffer) + 8;
>>>> -    ib->ptr[ib->length_dw++] = 
>>>> cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>> -    decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib- 
>>>> >ptr[ib- >length_dw]);
>>>> -    ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>> +
>>>> +    *ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
>>>> +    *ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>> +    decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
>>>> +    ptr += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>       memset(decode_buffer, 0, sizeof(struct 
>>>> amdgpu_vcn_decode_buffer));
>>>>       decode_buffer->valid_buf_flag |= 
>>>> cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>>>>       decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>>>>       decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>> -        ib->ptr[i] = 0x0;
>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 
>>>> ib_pack_in_dw);
>>>> @@ -934,7 +944,8 @@ static int amdgpu_vcn_enc_get_create_msg(struct 
>>>> amdgpu_ring *ring, uint32_t hand
>>>>       struct dma_fence *f = NULL;
>>>>       uint32_t *ib_checksum = NULL;
>>>>       uint64_t addr;
>>>> -    int i, r;
>>>> +    u32 *ptr;
>>>> +    int r;
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           ib_size_dw += 8;
>>>> @@ -947,31 +958,33 @@ static int 
>>>> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>>>>           return r;
>>>>       ib = &job->ibs[0];
>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>> -
>>>>       ib->length_dw = 0;
>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, 
>>>> true);
>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>> +    *ptr++ = 0x00000018;
>>>> +    *ptr++ = 0x00000001; /* session info */
>>>> +    *ptr++ = handle;
>>>> +    *ptr++ = upper_32_bits(addr);
>>>> +    *ptr++ = addr;
>>>> +    *ptr++ = 0x00000000;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>> -    ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
>>>> +    *ptr++ = 0x00000014;
>>>> +    *ptr++ = 0x00000002; /* task info */
>>>> +    *ptr++ = 0x0000001c;
>>>> +    *ptr++ = 0x00000000;
>>>> +    *ptr++ = 0x00000000;
>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>> -        ib->ptr[i] = 0x0;
>>>> +    *ptr++ = 0x00000008;
>>>> +    *ptr++ = 0x08000001; /* op initialize */
>>>> +
>>>> +    ib->length_dw = ptr - ib->ptr;
>>>> +
>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>> @@ -1002,7 +1015,8 @@ static int 
>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>>>>       struct dma_fence *f = NULL;
>>>>       uint32_t *ib_checksum = NULL;
>>>>       uint64_t addr;
>>>> -    int i, r;
>>>> +    u32 *ptr;
>>>> +    int r;
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           ib_size_dw += 8;
>>>> @@ -1015,31 +1029,33 @@ static int 
>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>>>>           return r;
>>>>       ib = &job->ibs[0];
>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>> -
>>>>       ib->length_dw = 0;
>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, 
>>>> true);
>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000001;
>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000002;
>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>> +    *ptr++ = 0x00000018;
>>>> +    *ptr++ = 0x00000001;
>>>> +    *ptr++ = handle;
>>>> +    *ptr++ = upper_32_bits(addr);
>>>> +    *ptr++ = addr;
>>>> +    *ptr++ = 0x00000000;
>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>> -    ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
>>>> +    *ptr++ = 0x00000014;
>>>> +    *ptr++ = 0x00000002;
>>>> +    *ptr++ = 0x0000001c;
>>>> +    *ptr++ = 0x00000000;
>>>> +    *ptr++ = 0x00000000;
>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>> -        ib->ptr[i] = 0x0;
>>>> +    *ptr++ = 0x00000008;
>>>> +    *ptr++ = 0x08000002; /* op close session */
>>>> +
>>>> +    ib->length_dw = ptr - ib->ptr;
>>>> +
>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>
>>
> 


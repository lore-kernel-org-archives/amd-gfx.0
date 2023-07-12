Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D20EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 15:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E124110E563;
	Wed, 12 Jul 2023 15:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDE810E563
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=dt3ufAmJ+ePJErmbxpJx+WOygjnIlgRi3ewG/emEZGo=; b=N9k71caQOrNVb8aO1wXhpn6mLA
 mR2QR40QC2vOu9QScndM5A65KeWxE75pU3USrk8UR9gmWauxpOA6dtOvuZgLFlWPAvxGPwM5DsM8W
 SY3+4kFRjaCY+kChusQ3zKZzDcLzL/wyDoUDuRJA8YMKK7hUOggkqs2qQJoY8ElkiZBqRLnei8wor
 VaMI0KUXwaZ712MelwVRrwlkyfJDyOHuxn1nTREC3LZY+RFKLsiWCWntyXnun3zlyzC2OtX1D/MuJ
 YAEyZYA3+WLHWX9aCIKP2GWhBe7+oFy13u4RYiVJoMhSE233fwVFge5pJt0o69UB4SNZ2NsyO+Bte
 IrkaaoGg==;
Received: from [2601:1c2:980:9ec0::2764]
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qJbWc-000Iww-38; Wed, 12 Jul 2023 15:13:07 +0000
Message-ID: <64bd287c-31c5-7ff4-e525-1e2dc212c9e3@infradead.org>
Date: Wed, 12 Jul 2023 08:13:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdgpu: Rename to amdgpu_vm_tlb_seq_struct
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20230712065821.260061-1-luben.tuikov@amd.com>
 <1dc3a6fb-3973-e6a7-519a-440fcfa5ee9f@amd.com>
 <b3964f68-4655-faac-e0ce-64f597ad1837@amd.com>
 <4748ea86-aeee-fdf8-71da-caf9161ce16e@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4748ea86-aeee-fdf8-71da-caf9161ce16e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jul 2023 15:14:09 +0000
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/12/23 01:34, Christian König wrote:
> Am 12.07.23 um 10:03 schrieb Luben Tuikov:
>> On 2023-07-12 03:57, Christian König wrote:
>>> Am 12.07.23 um 08:58 schrieb Luben Tuikov:
>>>> Rename struct amdgpu_vm_tlb_seq_cb {...} to struct amdgpu_vm_tlb_seq_struct
>>>> {...}, so as to not conflict with documentation processing tools. Of course, C
>>>> has no problem with this.
>>> Hui? What exactly is duplicated here? Is the structure defined in
>>> different files with a different meaning?
>> The same name is used for the function and for the structure.
> 
> Ah, yeah that wasn't obvious.
> 
> In this case the patch is Reviewed-by: Christian König <christian.koenig@amd.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
> Thanks,
> Christian.
> 
>>
>> struct amdgpu_vm_tlb_seq_cb {...}
>>
>> and
>>
>> static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>>                  struct dma_fence_cb *cb)
>>
>> C has no problem with this, but document processing tools do,
>> and in general it doesn't seem like a good practice to have
>> the same name for both.
>>
>> Regards,
>> Luben
>>
>>> Christian.
>>>
>>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Link: https://lore.kernel.org/r/b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org
>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 92a84e7b0db85b..32adc31c093d84 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -111,9 +111,9 @@ struct amdgpu_prt_cb {
>>>>    };
>>>>       /**
>>>> - * struct amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
>>>> + * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
>>>>     */
>>>> -struct amdgpu_vm_tlb_seq_cb {
>>>> +struct amdgpu_vm_tlb_seq_struct {
>>>>        /**
>>>>         * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
>>>>         */
>>>> @@ -833,7 +833,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>>    static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>>>>                     struct dma_fence_cb *cb)
>>>>    {
>>>> -    struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>>> +    struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>>>           tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>>>>        atomic64_inc(&tlb_cb->vm->tlb_seq);
>>>> @@ -871,7 +871,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>                   struct dma_fence **fence)
>>>>    {
>>>>        struct amdgpu_vm_update_params params;
>>>> -    struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>>> +    struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>>>        struct amdgpu_res_cursor cursor;
>>>>        enum amdgpu_sync_mode sync_mode;
>>>>        int r, idx;
>>>>
>>>> base-commit: 50db2d96b49b7d6cdb12e71e4204cf7180d3bab5
> 

-- 
~Randy

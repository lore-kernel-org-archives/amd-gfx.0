Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BFFC0219B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 10:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E4810E1DE;
	Tue, 11 Feb 2025 10:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7lGWmfj";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A947010E1DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 10:34:28 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-38dd93a6f0aso1803003f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 02:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739270067; x=1739874867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VpS/8GoxuwAjy2wNgNMA0gu6AGScB9o2k/S+RfSazME=;
 b=M7lGWmfj/uvzy6g3O26424kPAps8iZfkT+Zi4kiXTjqCiuXA42rhMXqPdXISz/j8OC
 P6vyITPm3xq/cR5nZ6G619j2rAuR9tVgiF+VIFhyLLT0jxkYksTdcWJPDFHAS8Ui/JvG
 r+yQeqm5RYYTd5z+oNJMROHH2CCmB+bySXP9D8AIM5miER8NuSCKp1g5SsNpp+QKYDf/
 bmKmFEeE/2chP35ag1m9zonKyfl6i7q9cZFiQnzfolswdQPrfjtZc/T8ZZyJOgoCqnJ6
 REpUg46/2bVtL0fTye/Bnymp3up3m0hsaeump5or7Bt5dItrnjBbuDwkE7jDQ22vlz2O
 HRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739270067; x=1739874867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VpS/8GoxuwAjy2wNgNMA0gu6AGScB9o2k/S+RfSazME=;
 b=W75zV7Jyt9/UH0WyzAa6sTa1EKXYn89sBbeN6gbJJZKiSDFfECl0epBqczODdkIiHL
 asQga0mhfCifQ0D6uw67EM695xduAQJ6hSj8wqzyOSFZjwo6zdKVntBRpo24RqwWKid0
 XBVb3TKvfFTfk1Uef4kJrB0yDzT8QTh2FC2Z4Pk/xaQOXwwpUalNUYq0ZN2peWKQNOp4
 xtVoroFqiggE3BhlmSYK9JaNyKiIfuqHHlttTjpj3dfkbQeIYcdMmj6gb1ZY3QbHvXGT
 lOpfH0VYRJeYuFZ44KA+UhjBnom4XemwqOJ9/sKaDfbJybJGT/MKnWrnQi4f3vdzQXoe
 0DNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZsEr1TBuZFwhZrlLkakWYvZnonGdvfg3ip0Y848s8dJYypeLnF1KcL6wPo/jx1gLvElICOC18@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhcFdoqNOPL5jYV1IGclz5c18je41ZmWS5amf2cHFfa+CLuA6i
 Ob1c/Rwt/4Xs96XEepg1Mwk4venrDJCE8fsd6qZbdInKuDO7vM8E
X-Gm-Gg: ASbGncsoac2PPTKXEmy8GTFphV1jjZov9kjbuONhb5m8ErD5fNtcZCWBgu4neM5l132
 vwleMpV8U2DlwE63GH8oRjRaOVmu7C+6R+5ftpbIeKjhPcMKwUMfHssuPRhsGKqngj9NdAPXRPh
 p60nmB7GXHJDgIuIiqW1FtpYrIWA19Swgn36LdBoxMxSHaRDaZVjUW7U3ukPbVirD5Sku796j5n
 zzwbs868oZ4dukje4AJlSNubvgLtCNa4hzjBVP7sSjjtwg35ml2sxfeL51ePPFDW1osUhfMgMz7
 GOPI8SCl1je3Ly+QHZDL9PLnH/EhOISyBzUizm3279Tm
X-Google-Smtp-Source: AGHT+IFysNj6qT9w6ncCn6R1G8vBcHfBfW0sNtTKyx4qsGyVzl7LXSOViT4Nl90n2ioqh7NIP8wlJg==
X-Received: by 2002:a05:6000:2c1:b0:38d:d666:5448 with SMTP id
 ffacd0b85a97d-38dd66656aemr11768517f8f.40.1739270066710; 
 Tue, 11 Feb 2025 02:34:26 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394679a3a1sm49128565e9.5.2025.02.11.02.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 02:34:26 -0800 (PST)
Message-ID: <1d6c89dc-f032-4796-a038-c9e897e7bf1c@gmail.com>
Date: Tue, 11 Feb 2025 11:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Unlocked unmap only clear page table leaves
To: Philip Yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250114145314.4633-1-Philip.Yang@amd.com>
 <f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com>
 <35670d39-0f91-29ab-e369-6e45b000d486@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <35670d39-0f91-29ab-e369-6e45b000d486@amd.com>
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



Am 20.01.25 um 16:59 schrieb Philip Yang:
>
>
> On 2025-01-15 06:01, Christian König wrote:
>> Am 14.01.25 um 15:53 schrieb Philip Yang:
>>> SVM migration unmap pages from GPU and then update mapping to GPU to
>>> recover page fault. Currently unmap clears the PDE entry for range
>>> length >= huge page and free PTB bo, update mapping to alloc new PT bo.
>>> There is race bug that the freed entry bo maybe still on the pt_free
>>> list, reused when updating mapping and then freed, leave invalid PDE
>>> entry and cause GPU page fault.
>>>
>>> By setting the update to clear only one PDE entry or clear PTB, to
>>> avoid unmap to free PTE bo. This fixes the race bug and improve the
>>> unmap and map to GPU performance. Update mapping to huge page will
>>> still free the PTB bo.
>>>
>>> With this change, the vm->pt_freed list and work is not needed. Add
>>> WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap to free 
>>> the
>>> PTB.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43 
>>> +++++++----------------
>>>   3 files changed, 13 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index c9c48b782ec1..48b2c0b3b315 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm,
>>>       spin_lock_init(&vm->status_lock);
>>>       INIT_LIST_HEAD(&vm->freed);
>>>       INIT_LIST_HEAD(&vm->done);
>>> -    INIT_LIST_HEAD(&vm->pt_freed);
>>> -    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>>       INIT_KFIFO(vm->faults);
>>>         r = amdgpu_vm_init_entities(adev, vm);
>>> @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm)
>>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>>   -    flush_work(&vm->pt_free_work);
>>> -
>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>       amdgpu_bo_reserve(root, true);
>>>       amdgpu_vm_put_task_info(vm->task_info);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 5d119ac26c4f..160889e5e64d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -369,10 +369,6 @@ struct amdgpu_vm {
>>>       /* BOs which are invalidated, has been updated in the PTs */
>>>       struct list_head        done;
>>>   -    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>>> not hold */
>>> -    struct list_head    pt_freed;
>>> -    struct work_struct    pt_free_work;
>>> -
>>>       /* contains the page directory */
>>>       struct amdgpu_vm_bo_base     root;
>>>       struct dma_fence    *last_update;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index f78a0434a48f..54ae0e9bc6d7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct 
>>> amdgpu_vm_bo_base *entry)
>>>       amdgpu_bo_unref(&entry->bo);
>>>   }
>>>   -void amdgpu_vm_pt_free_work(struct work_struct *work)
>>> -{
>>> -    struct amdgpu_vm_bo_base *entry, *next;
>>> -    struct amdgpu_vm *vm;
>>> -    LIST_HEAD(pt_freed);
>>> -
>>> -    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>>> -
>>> -    spin_lock(&vm->status_lock);
>>> -    list_splice_init(&vm->pt_freed, &pt_freed);
>>> -    spin_unlock(&vm->status_lock);
>>> -
>>> -    /* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
>>> -    amdgpu_bo_reserve(vm->root.bo, true);
>>> -
>>> -    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>>> -        amdgpu_vm_pt_free(entry);
>>> -
>>> -    amdgpu_bo_unreserve(vm->root.bo);
>>> -}
>>> -
>>>   /**
>>>    * amdgpu_vm_pt_free_list - free PD/PT levels
>>>    *
>>> @@ -579,19 +558,15 @@ void amdgpu_vm_pt_free_list(struct 
>>> amdgpu_device *adev,
>>>                   struct amdgpu_vm_update_params *params)
>>>   {
>>>       struct amdgpu_vm_bo_base *entry, *next;
>>> -    struct amdgpu_vm *vm = params->vm;
>>>       bool unlocked = params->unlocked;
>>>         if (list_empty(&params->tlb_flush_waitlist))
>>>           return;
>>>   -    if (unlocked) {
>>> -        spin_lock(&vm->status_lock);
>>> -        list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
>>> -        spin_unlock(&vm->status_lock);
>>> -        schedule_work(&vm->pt_free_work);
>>> -        return;
>>> -    }
>>> +    /*
>>> +     * unlocked unmap clear page table leaves, warning to free the 
>>> page entry.
>>> +     */
>>> +    WARN_ON(unlocked);
>>>         list_for_each_entry_safe(entry, next, 
>>> &params->tlb_flush_waitlist, vm_status)
>>>           amdgpu_vm_pt_free(entry);
>>> @@ -899,7 +874,15 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>           incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
>>>           mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>>>           pe_start = ((cursor.pfn >> shift) & mask) * 8;
>>> -        entry_end = ((uint64_t)mask + 1) << shift;
>>> +
>>> +        if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
>>> +            /*
>>> +             * MMU notifier callback unlocked unmap huge page, 
>>> leave is PDE entry,
>>> +             * only clear one entry. Next entry search again for 
>>> PDE or PTE leave.
>>> +             */
>>> +            entry_end = 1ULL << shift;
>>> +        else
>>> +            entry_end = ((uint64_t)mask + 1) << shift;
>>
>> That here looks to much like a hack for my taste. entry_end basically 
>> denotes the end of the pages tables and not the updated region.
> yes, agree.

After going back and forth over the different solution we found that we 
do need this hack for now.

There is basically no other solution than to update one entry at a time 
without introducing a new function to do this.

So feel free to add Reviewed-by: Christian König 
<christian.koenig@amd.com> to this patch here, but please look into 
cleaning that up as soon as possible.

Thanks,
Christian.

>>
>> We already set frag_end to this here:
>>
>> frag_end = max(frag_end, ALIGN(frag_start + 1, 1ULL << shift));
>
> Here seems the root cause, for example, unmapping frag_start is 8MB 
> aligned address, frag_end is frag_start + 8MB, but for unlocked update 
> we want to do page walk again after unmapping 2MB.
>
> Also the max(....) seems meaningless, as frag_end is always >= 
> frag_start + 1, this can be changed to
>
> if (params->unlocked)
>
>    frag_end = frag_start + 1;
>
>
>>
>> Which basically means that we should update just one entry at the 
>> time and then walk the page tables again.
>>
>> The issue is just that we immediately calculate a new fragment after 
>> each update:
>>
>>                         if (frag_start >= frag_end) {
>>                                 /* figure out the next fragment */
>>                                 amdgpu_vm_pte_fragment(params, 
>> frag_start, end,
>>                                                        flags, &frag, 
>> &frag_end);
>>                                 if (frag < shift)
>>                                         break;
>>                         }
>> And that looks like the place we need to adjust something to allow 
>> updates of the leave nodes.
>
> yes, also we should always break here to restart page walk for 
> unlocked unmapping
>
> if (frag < shift || params->unlocked)
>
>      break;
>
>>
>> Alternatively I wouldn't mind having a complete separate function for 
>> unlocked invalidations.
>
> A complete separate function will duplicate lots of page walker code. 
> Alternatively we could change amdgpu_vm_pte_fragment, for unlocked 
> unmapping, always return frag_end to 2MB (or 1GB), not 4MB, 8MB....
>
> Regards,
>
> Philip
>
>>
>> Regards,
>> Christian.
>>
>>
>>>           entry_end += cursor.pfn & ~(entry_end - 1);
>>>           entry_end = min(entry_end, end);
>>


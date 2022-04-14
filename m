Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BC1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 07:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1075210E1FE;
	Thu, 14 Apr 2022 07:29:12 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254AF10E09A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 07:29:10 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8d7.dynamic.kabel-deutschland.de
 [95.90.232.215])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 77F7D61EA1928;
 Thu, 14 Apr 2022 09:29:08 +0200 (CEST)
Message-ID: <17b44506-93e2-0ebc-0b09-03abdca24ad8@molgen.mpg.de>
Date: Thu, 14 Apr 2022 09:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix one use-after-free of VM
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: xinhui pan <xinhui.pan@amd.com>
References: <20220414050348.8888-1-xinhui.pan@amd.com>
 <5f21babf-0a16-fff0-7685-3dfc4590bf78@molgen.mpg.de>
In-Reply-To: <5f21babf-0a16-fff0-7685-3dfc4590bf78@molgen.mpg.de>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Xinhui,


Am 14.04.22 um 07:45 schrieb Paul Menzel:

> Thank you for rerolling the patch.
> 
> Am 14.04.22 um 07:03 schrieb xinhui pan:
>> VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.
>> We see the calltrace below.
>>
>> Fix it by keeping the last flush fence around and wait for it to signal
> 
> Nit: Please add a dot/period to the end of sentences.
> 
>>
>> BUG kmalloc-4k (Not tainted): Poison overwritten
>>
>> 0xffff9c88630414e8-0xffff9c88630414e8 @offset=5352. First byte 0x6c
>> instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
>> age=44 cpu=0 pid=2343
>>   __slab_alloc.isra.0+0x4f/0x90
>>   kmem_cache_alloc_trace+0x6b8/0x7a0
>>   amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
>>   drm_file_alloc+0x222/0x3e0 [drm]
>>   drm_open+0x11d/0x410 [drm]
>> Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=22 cpu=1
>> pid=2485
>>   kfree+0x4a2/0x580
>>   amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
>>   drm_file_free+0x24e/0x3c0 [drm]
>>   drm_close_helper.isra.0+0x90/0xb0 [drm]
>>   drm_release+0x97/0x1a0 [drm]
>>   __fput+0xb6/0x280
>>   ____fput+0xe/0x10
>>   task_work_run+0x64/0xb0
> 
> The v2 annotation is missing.
> 
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
>>   2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 645ce28277c2..cd5aa7edd451 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -932,9 +932,12 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>       if (flush_tlb || params.table_freed) {
>>           tlb_cb->vm = vm;
>> -        if (!fence || !*fence ||
>> -            dma_fence_add_callback(*fence, &tlb_cb->cb,
>> -                       amdgpu_vm_tlb_seq_cb))
>> +        if (fence && *fence &&
>> +            !dma_fence_add_callback(*fence, &tlb_cb->cb,
>> +                       amdgpu_vm_tlb_seq_cb)) {
>> +            dma_fence_put(vm->last_tlb_flush);
>> +            vm->last_tlb_flush = dma_fence_get(*fence);
>> +        } else
>>               amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> 
> The Linux kernel coding style uses braces for all branches of a 
> conditional statement, if one branch uses braces. [1]

By the way `scripts/checkpatch.pl --strict …` would also have found this:

```
$ scripts/checkpatch.pl --strict 
0001-drm-amdgpu-Fix-one-use-after-free-of-VM.patch
CHECK: braces {} should be used on all arms of this statement
#53: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:935:
+               if (fence && *fence &&
[...]
+               } else
[...]

CHECK: Unbalanced braces around else statement
#58: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:940:
+               } else

total: 0 errors, 0 warnings, 2 checks, 54 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0001-drm-amdgpu-Fix-one-use-after-free-of-VM.patch has style problems, 
please review.
```


Kind regards,

Paul


>>           tlb_cb = NULL;
>>       }
>> @@ -2094,6 +2097,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>           vm->update_funcs = &amdgpu_vm_sdma_funcs;
>>       vm->last_update = NULL;
>>       vm->last_unlocked = dma_fence_get_stub();
>> +    vm->last_tlb_flush = dma_fence_get_stub();
>>       mutex_init(&vm->eviction_lock);
>>       vm->evicting = false;
>> @@ -2132,6 +2136,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>       vm->root.bo = NULL;
>>   error_free_delayed:
>> +    dma_fence_put(vm->last_tlb_flush);
>>       dma_fence_put(vm->last_unlocked);
>>       drm_sched_entity_destroy(&vm->delayed);
>> @@ -2248,6 +2253,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>       struct amdgpu_bo_va_mapping *mapping, *tmp;
>>       bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>>       struct amdgpu_bo *root;
>> +    unsigned long flags;
>>       int i;
>>       amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>> @@ -2257,6 +2263,11 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>       amdgpu_vm_set_pasid(adev, vm, 0);
>>       dma_fence_wait(vm->last_unlocked, false);
>>       dma_fence_put(vm->last_unlocked);
>> +    dma_fence_wait(vm->last_tlb_flush, false);
>> +    /* Make sure that all fence callbacks have completed */
>> +    spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
>> +    spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
>> +    dma_fence_put(vm->last_tlb_flush);
>>       list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>>           if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 1a814fbffff8..6b06a214f05f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -286,6 +286,7 @@ struct amdgpu_vm {
>>       /* Last finished delayed update */
>>       atomic64_t        tlb_seq;
>> +    struct dma_fence    *last_tlb_flush;
>>       /* Last unlocked submission to the scheduler entities */
>>       struct dma_fence    *last_unlocked;
> 
> 
> [1]: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5161CCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 06:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF4810E09D;
	Fri, 16 Oct 2026 06:47:18 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B672110E09D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:11 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-486e8faff03so2625651f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 23:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792133230; x=1792738030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=chaRSa8KgFIaGX+3vtaQnsvmm+Y/EuBzHv7YWeU0rzo=;
 b=c7yCai1yl8MhcBvaaKs4tnBeDSLQ0S5B9rjR0VtdZVqvn6GdBxZqEXSyIQ6O0FH9QO
 C1K33A40IxiQeP2OMVFc8+6tA+/NRGTibkoVGywtwvRIk6J9VVrAnBO4/UhUWe0tFMul
 pdW0Ve1fYiFSct1gNONTl549WlWC212ln7BK9zBkYM0vAwAsLmHr0F0nPIEvz/WImd2H
 LAjpFxUoeY3zACoVLRyqZ3OSZAbgJ4lx1Vvn7143OQhixWbNSLoPXTNQBFi4coYEplk3
 FfMTtt2zIa8QT8PqD1RSG/ToOlrh1trwSRl+IckC7cyym1vhIjgbJIfnor2PyOPaX0UE
 epFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792133230; x=1792738030;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chaRSa8KgFIaGX+3vtaQnsvmm+Y/EuBzHv7YWeU0rzo=;
 b=SeZ9Job63HT5KgHiRa0JbWJsFQTFzo2vSqpSTwlqTZ+oe6ci2mi8Tp/ZckIHyt68xN
 vk24tZg550qsoEuiMJznIc741RKdJtNF9odcyV43B/dZgAy0a+FjI3iXX9bJB2PNxvOm
 sEIAQpKfnYbIuC4x8ZR7f9R1FIGL9nbZbgvBggGD6ZGBnr2qTeKkv9dstFyWJmK1aNlX
 gkX7YgpughJLcYaPnTJ5guOmczJIhso7x9di5fBXfMoFNT30cE/YCSpJepZ0KfRYqpSM
 vyEpFRWZR8mgHfTb/+bz0XxFQ23Gj8C0UlJpnzma0Lf68bZur7RrUvc3WtumocbucT1p
 X1kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBza52Rl8wVI1vx9DIq//zerRs+afTU5A9BACuMRO79knUwgMvbpRjdI0jEbYnf7YoFntylzXhNA@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK2uus3bt6/JdUYg5EzFmXkbWgamDYt5LYBferFT+0HT1Mi8yjS
 1BlIwoYz/hVcKHUs5BKf50k9mCzTqjwiSJwpbGRfiaqIAlfLeUyhFb3k
X-Gm-Gg: AYBFou0yrtwLPN0+eERZVM5mlpTtKnamDbheCMrzKLQEIdcQxtb1ibIqPKi6LVzCR9D
 uVo+XH+joqQDB+cuDmjA2RHkobhrlRLU9v37OBFUKklsld4EQsm1zSsTdbuIST5Fn82hmt9Xlta
 nDZl53x5AHOgF4/NVu97AZv+ucqUtOApesqywRKa5OJBLopah+qwpeJ9e6Mp0BqX7wemwaFUYAa
 lkGzIMV/R8alvi3wtjtKCGe/Btn/tASsn2jv9IlgwpVO1yVEyO039+qTv7jM+fDSqc/zkI6NotG
 9T8cygg5qgE1Ur2F7sIKbLkdax/ZISHVEvOXgd7EpCeHujQRZeBhBUzCp8EOvwgNVKBYorh0cYB
 e91UH6E9F7zqiXcSAOzGPe2LgjR2x8pLtSR+KUBXSe/7k7GPd5uEpWHYWD7DG1THxu+6xEGmXTJ
 XuwFnMHls6oW9WsWySWbhceb9Kmiw8RSSwyjShu8P/dU5Irw67eF2UnmD0Z8gX77VSkcOs64M/G
 K2FgNvxbpb3dCLYnddlFmcjJ4Su
X-Received: by 2002:a05:600c:4f10:b0:4a0:d1f4:b1d1 with SMTP id
 5b1f17b1804b1-4a18e4bff89mr513393395e9.24.1792133229741; 
 Thu, 15 Oct 2026 23:47:09 -0700 (PDT)
Received: from [10.254.153.254] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5813sm4782946f8f.17.2026.10.15.23.47.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Oct 2026 23:47:09 -0700 (PDT)
Message-ID: <fc732112-75da-4775-8d70-a995d110ea4c@gmail.com>
Date: Fri, 16 Oct 2026 08:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix TLB invalidation fence handling
To: Benjamin Cheng <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261008124232.23825-1-christian.koenig@amd.com>
 <b225bc76-d405-4955-8a88-b82b47c7512e@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <b225bc76-d405-4955-8a88-b82b47c7512e@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Benjamin,

please CC my AMD mail address as well otherwise I don't see the reply.

On 10/15/26 15:04, Benjamin Cheng wrote:
> 
> On 2026-10-08 08:42, Christian König wrote:
>> After each unmap it might be necessary to invalidate the TLB to flush out
>> VM changes to the HW and make it visible to executing work.
>>
>> We tracked that as part of the vm->last_update fence, but as pointed out
>> by David it can be that this is overwritten by PDE updates when we have a
>> combined unmap/map operation.
>>
>> In that case userspace doesn't correctly wait for the TLB invalidation to
>> finish leading to all kind of problems (sq_int, page faults etc...).
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 20 ++++++----
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 39 +++++++++----------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 13 ++++---
>>  .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 21 +++++++---
>>  4 files changed, 55 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 374f1322c3ee4..606725d0eb155 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -843,18 +843,24 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>  		/*
>>  		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
>>  		 * bo_va->last_pt_update and vm->last_update or otherwise we
>> -		 * potentially miss the PDE updates.
>> +		 * potentially miss the PDE updates or TLB invalidation.
>>  		 */
>>  		fence = dma_fence_unwrap_merge(vm->last_update,
>> +					       vm->last_tlb_inv,
>>  					       bo_va->last_pt_update);
>> -		if (!fence) {
>> -			/* As fallback in OOM situations */
>> -			dma_fence_wait(vm->last_update, false);
>> +		if (!fence)
>>  			dma_fence_wait(bo_va->last_pt_update, false);
>> -			fence = dma_fence_get_stub();
>> -		}
>> +
>>  	} else {
>> -		fence = dma_fence_get(vm->last_update);
>> +		fence = dma_fence_unwrap_merge(vm->last_update,
>> +					       vm->last_tlb_inv);
>> +	}
>> +
>> +	if (!fence) {
>> +		/* As fallback in OOM situations */
>> +		dma_fence_wait(vm->last_update, false);
>> +		dma_fence_wait(vm->last_tlb_inv, false);
>> +		fence = dma_fence_get_stub();
>>  	}
>>  
>>  	return fence;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 7d3659ef11e53..f124320345ec4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1071,21 +1071,16 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>>   */
>>  static void
>>  amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>> -		    struct dma_fence **fence,
>> +		    struct dma_fence *fence,
>>  		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
>>  {
>>  	struct amdgpu_vm *vm = params->vm;
>>  
>>  	tlb_cb->vm = vm;
>> -	if (!fence || !*fence) {
>> -		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> -		return;
>> -	}
>> -
>> -	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
>> -				    amdgpu_vm_tlb_seq_cb)) {
>> -		dma_fence_put(vm->last_tlb_flush);
>> -		vm->last_tlb_flush = dma_fence_get(*fence);
>> +	if (!fence || !dma_fence_add_callback(fence, &tlb_cb->cb,
> 
> 
> Shouldn't this be if (fence || !dma_fence_add_callback(...))? Otherwise the tlb_seq never gets incremented.

Right, thanks that is a really good catch.

Regards,
Christian.

> 
> 
>> +					      amdgpu_vm_tlb_seq_cb)) {
>> +		dma_fence_put(vm->last_seq_flush);
>> +		vm->last_seq_flush = dma_fence_get(fence);
>>  	} else {
>>  		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>>  	}
>> @@ -1095,11 +1090,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>  	 * sort out the issues with KIQ/MES TLB invalidation timeouts.
>>  	 */
>>  	if (!params->unlocked && vm->need_tlb_fence) {
>> -		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>> +		amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
>> +					   &vm->last_tlb_inv);
>>  
>>  		/* Makes sure no PD/PT is freed before the flush */
>> -		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> -				   DMA_RESV_USAGE_BOOKKEEP);
>> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv,
>> +				   vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
>>  	}
>>  }
>>  
>> @@ -1248,7 +1244,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  		goto error_free;
>>  
>>  	if (params.needs_flush) {
>> -		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>> +		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
>>  		tlb_cb = NULL;
>>  	}
>>  
>> @@ -2647,7 +2643,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  
>>  	vm->last_update = dma_fence_get_stub();
>>  	vm->last_unlocked = dma_fence_get_stub();
>> -	vm->last_tlb_flush = dma_fence_get_stub();
>> +	vm->last_seq_flush = dma_fence_get_stub();
>> +	vm->last_tlb_inv = dma_fence_get_stub();
>>  	vm->generation = amdgpu_vm_generation(adev, NULL);
>>  
>>  	mutex_init(&vm->eviction_lock);
>> @@ -2691,7 +2688,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>  
>>  error_free_delayed:
>>  	dma_fence_put(vm->last_update);
>> -	dma_fence_put(vm->last_tlb_flush);
>> +	dma_fence_put(vm->last_seq_flush);
>> +	dma_fence_put(vm->last_tlb_inv);
>>  	dma_fence_put(vm->last_unlocked);
>>  	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>>  	amdgpu_vm_fini_entities(vm);
>> @@ -2834,11 +2832,12 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>  	amdgpu_bo_reserve(root, true);
>>  	dma_fence_wait(vm->last_unlocked, false);
>>  	dma_fence_put(vm->last_unlocked);
>> -	dma_fence_wait(vm->last_tlb_flush, false);
>> +	dma_fence_wait(vm->last_seq_flush, false);
>>  	/* Make sure that all fence callbacks have completed */
>> -	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
>> -	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
>> -	dma_fence_put(vm->last_tlb_flush);
>> +	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
>> +	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
>> +	dma_fence_put(vm->last_seq_flush);
>> +	dma_fence_put(vm->last_tlb_inv);
>>  
>>  	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>>  		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8e478d3bda1ac..713a597027bbe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -328,11 +328,12 @@ struct amdgpu_vm {
>>  	struct drm_sched_entity	immediate;
>>  	struct drm_sched_entity	delayed;
>>  
>> -	/* Last finished delayed update */
>> +	/* Last TLB seq/fence */
>>  	atomic64_t		tlb_seq;
>> -	struct dma_fence	*last_tlb_flush;
>> +	struct dma_fence	*last_seq_flush;
>>  	atomic64_t		kfd_last_flushed_seq;
>>  	uint64_t		tlb_fence_context;
>> +	struct dma_fence	*last_tlb_inv;
>>  
>>  	/* How many times we had to re-generate the page tables */
>>  	uint64_t		generation;
>> @@ -561,7 +562,7 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>>  	 * sure that the dma_fence structure isn't freed up.
>>  	 */
>>  	rcu_read_lock();
>> -	lock = dma_fence_spinlock(vm->last_tlb_flush);
>> +	lock = dma_fence_spinlock(vm->last_seq_flush);
>>  	rcu_read_unlock();
>>  
>>  	spin_lock_irqsave(lock, flags);
>> @@ -576,9 +577,9 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>>  				  uint32_t status,
>>  				  unsigned int vmhub);
>>  void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> -				 struct amdgpu_vm *vm,
>> -				 struct dma_fence **fence);
>> -
>> +				struct amdgpu_vm *vm,
>> +				struct dma_fence *dep,
>> +				struct dma_fence **fence);
>>  void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
>>  			       struct amdgpu_task_info *task_info);
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> index b0002c8983861..c91417e4df4ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -75,7 +75,19 @@ static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>>  	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>>  };
>>  
>> -void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>> +/**
>> + * amdgpu_vm_tlb_fence_create - create a TLB invalidation fence
>> + * @adev: the amdgpu device
>> + * @vm: the vm to use
>> + * @dep: the dependency to wait for
>> + * @fence: the resulting fence
>> + *
>> + * Creates a TLB invalidation fence which signals when all the VMIDs assigned to
>> + * the PASID of the VM are invalidated.
>> + */
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +				struct amdgpu_vm *vm,
>> +				struct dma_fence *dep,
>>  				struct dma_fence **fence)
>>  {
>>  	struct amdgpu_tlb_fence *f;
>> @@ -86,16 +98,15 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
>>  		 * We can't fail since the PDEs and PTEs are already updated, so
>>  		 * just block for the dependency and execute the TLB flush
>>  		 */
>> -		if (*fence)
>> -			dma_fence_wait(*fence, false);
>> +		if (dep)
>> +			dma_fence_wait(dep, false);
>>  
>>  		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> -		*fence = dma_fence_get_stub();
>>  		return;
>>  	}
>>  
>>  	f->adev = adev;
>> -	f->dependency = *fence;
>> +	f->dependency = dma_fence_get(dep);
>>  	f->pasid = vm->pasid;
>>  	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>>  	spin_lock_init(&f->lock);


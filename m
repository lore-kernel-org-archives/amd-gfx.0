Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D0BCD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 13:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C08113392;
	Mon,  1 Jun 2026 13:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="UjmcfcCR";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="Nm55V1kj";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3699113392
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1780321875; bh=0vhgPsGMrBYtw4zj/VVcgcx
 /cnuvi/VxFljV3zGx8eU=; b=UjmcfcCREcJSY0IwPJ9WVhdzWPun8z2zaBJag+LfKhhgcNNxT7
 45IfLzqTZlp38qGAuxSvjq4VMQjzvMIOTnDA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1780321875; bh=0vhgPsGMrBYtw4zj/VVcgcx
 /cnuvi/VxFljV3zGx8eU=; b=Nm55V1kj+peB010eM0nnbx7wEGgbtU94o0uykkxUyeySOYpLJ/
 z5ljmjHllXXBeQrXfCOnjUmjaIkgdemaYT6uDNXFHx6hruP/+4cjZ2Ex4NibBKPDKxRUg3I/IBn
 DX4rinPmFsHckP7PszxqWMsSgvlt41TaFGbZFSGYrVM5e2Fi15CivPfo9zKBIH7BOfNFQMM7oBg
 QwOIbU6NMMj5s/Sh21WuA/ThwTyaVoJFDa/ucFzAfMuXaBg8Nz8v0dwGvlEDVzpIL3xfLjyfAcm
 uDBxRwz0cyNoe+cwiDZHX36s9IftK2HqJTo54y4qY6vk8iNccu+yStBqB015E4U8Pkw==;
Message-ID: <e6f789e6-d5cb-485f-a8b9-8c087708f4f5@damsy.net>
Date: Mon, 1 Jun 2026 15:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
To: christian.koenig@amd.com, natalie.vock@gmx.de, honghuan@amd.com,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-9-christian.koenig@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260529114031.3714-9-christian.koenig@amd.com>
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



Le 29/05/2026 à 13:24, Christian König a écrit :
> Split amdgpu_vm_update_range into two functions.
> 
> amdgpu_vm_map_range() is for mapping PTEs into a range and updates
> which can be done while holding the VM lock.
> 
> amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
> lock in MMU notifiers.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 112 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  14 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  35 ++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  16 ++--
>   5 files changed, 120 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 44fe40f9e8df..653ffa9ca0f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
>   /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
> -#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)

Not reusing the same ID would make it easier for umr, but it's not a blocker so you can keep the 
code as is if you prefer.

Pierre-Eric

>   #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
> @@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
>   #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
>   #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
>   
>   struct amdgpu_job {
>   	struct drm_sched_job    base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index edc8b1ca2d3e..b5adfcacc55a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1080,11 +1080,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   }
>   
>   /**
> - * amdgpu_vm_update_range - update a range in the vm page table
> + * amdgpu_vm_map_range - map something to a range in the vm page tables
>    *
>    * @adev: amdgpu_device pointer to use for commands
>    * @vm: the VM to update the range
> - * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
>    * @allow_override: change MTYPE for local NUMA nodes
>    * @sync: fences we need to sync to
> @@ -1097,23 +1096,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @pages_addr: DMA addresses to use for mapping
>    * @fence: optional resulting fence
>    *
> - * Fill in the page table entries between @start and @last.
> + * Fill in the page table entries between @start and @last. Allocate and free
> + * new page tables as needed. Can only be called while holding the VM lock.
>    *
>    * Returns:
>    * 0 for success, negative erro code for failure.
>    */
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence)
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_res_cursor cursor;
>   	int r, idx;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> @@ -1138,7 +1140,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.pages_addr = pages_addr;
> -	params.unlocked = unlocked;
>   	params.needs_flush = flush_tlb;
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1149,7 +1150,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error_free;
>   	}
>   
> -	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> +	if (!dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
>   
>   		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> @@ -1158,7 +1159,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	r = vm->update_funcs->prepare(&params, sync,
> -				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
> +				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
>   	if (r)
>   		goto error_free;
>   
> @@ -1234,6 +1235,77 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
> + *
> + * @adev: amdgpu_device pointer to use for commands
> + * @vm: the VM to update the range
> + * @sync: fences we need to sync to
> + * @start: start of unmapped range
> + * @last: last unmapped entry
> + * @flags: flags for the entries
> + * @fence: optional resulting fence
> + *
> + * Fill in the page table entries between @start and @last with a fixed flags
> + * value without allocating or freeing page tables. Can be used without locking
> + * the VM.
> + *
> + * Returns:
> + * 0 for success, negative erro code for failure.
> + */
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			   struct amdgpu_sync *sync, uint64_t start,
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence)
> +{
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	struct amdgpu_vm_update_params params;
> +	int r, idx;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
> +
> +	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> +	if (!tlb_cb) {
> +		drm_dev_exit(idx);
> +		return -ENOMEM;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev = adev;
> +	params.vm = vm;
> +	params.needs_flush = true;
> +	params.unlocked = true;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> +
> +	amdgpu_vm_eviction_lock(vm);
> +	if (vm->evicting) {
> +		r = -EBUSY;
> +		goto error_free;
> +	}
> +
> +	r = vm->update_funcs->prepare(&params, sync,
> +				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_update_leaves(&params, start, last, 0, flags);
> +
> +	r = vm->update_funcs->commit(&params, fence);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +	amdgpu_vm_pt_free_list(adev, &params);
> +	tlb_cb = NULL;
> +
> +error_free:
> +	kfree(tlb_cb);
> +	amdgpu_vm_eviction_unlock(vm);
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> @@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   
>   		trace_amdgpu_vm_bo_update(mapping);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
> -					   !uncached, &sync, mapping->start,
> -					   mapping->last, update_flags,
> -					   mapping->offset, vram_base, mem,
> -					   pages_addr, last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
> +					mapping->start, mapping->last,
> +					update_flags, mapping->offset,
> +					vram_base, mem, pages_addr,
> +					last_update);
>   		if (r)
>   			goto error_free;
>   	}
> @@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, true, false,
> -					   &sync, mapping->start, mapping->last,
> -					   0, 0, 0, NULL, NULL, &f);
> +		r = amdgpu_vm_map_range(adev, vm, true, false,
> +					&sync, mapping->start, mapping->last,
> +					0, 0, 0, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 3e86a2a470f0..561f2873d2ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   				uint32_t xcc_mask);
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence);
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence);
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 6f5415d5a1bc..ac3f3e31e2e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
> -	bool unlocked = params->unlocked;
>   
>   	if (list_empty(&params->tlb_flush_waitlist))
>   		return;
> @@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   	/*
>   	 * unlocked unmap clear page table leaves, warning to free the page entry.
>   	 */
> -	WARN_ON(unlocked);
> +	WARN_ON(params->unlocked);
>   
>   	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
> @@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		uint64_t incr, entry_end, pe_start;
>   		struct amdgpu_bo *pt;
>   
> -		if (!params->unlocked) {
> -			/* make sure that the page tables covering the
> -			 * address range are actually allocated
> -			 */
> -			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
> -					       &cursor);
> -			if (r)
> -				return r;
> -		}
> +		/* make sure that the page tables covering the
> +		 * address range are actually allocated
> +		 */
> +		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
> +		if (r)
> +			return r;
>   
>   		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>   		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
> -		if (params->unlocked) {
> -			/* Unlocked updates are only allowed on the leaves */
> -			if (amdgpu_vm_pt_descendant(adev, &cursor))
> -				continue;
> -		} else if (adev->asic_type < CHIP_VEGA10 &&
> -			   (flags & AMDGPU_PTE_VALID)) {
> +		if (adev->asic_type < CHIP_VEGA10 &&
> +		    (flags & AMDGPU_PTE_VALID)) {
>   			/* No huge page support before GMC v9 */
>   			if (cursor.level != AMDGPU_VM_PTB) {
>   				if (!amdgpu_vm_pt_descendant(adev, &cursor))
> @@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
>   
> -		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> -			/*
> -			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
> -			 * only clear one entry. Next entry search again for PDE or PTE leave.
> -			 */
> -			entry_end = 1ULL << shift;
> -		else
> -			entry_end = ((uint64_t)mask + 1) << shift;
> +		entry_end = ((uint64_t)mask + 1) << shift;
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 37b5166e9a14..d0ea20dea3e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		return -EINVAL;
>   	}
>   
> -	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
> -				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +	return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
> +				     init_pte_value, fence);
>   }
>   
>   static int
> @@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>   			 pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
> -					   NULL, gpu_start, gpu_end,
> -					   pte_flags,
> -					   (last_start - prange->start) << PAGE_SHIFT,
> -					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr, &vm->last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
> +					gpu_start, gpu_end, pte_flags,
> +					(last_start - prange->start) << PAGE_SHIFT,
> +					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> +					NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;

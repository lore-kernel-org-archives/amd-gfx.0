Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E608C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 08:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7984B10E3AA;
	Tue,  3 Jan 2023 08:27:40 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9395E10E3A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 08:27:37 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id l26so20527454wme.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 00:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=55eqNEAHAn+53Kvw5z1O8+VgtevKeEnDDw4n3MCeAtc=;
 b=RMlCTA2nTOZdPfWS9abFwJH50C6DBU6EDAciw0BJeEwNDvFfu0FRvCG/TU5HfvyBBa
 o+M4102U/s4uI9KHweawcUr7hvl0kN43ubuJPGXxoqODD/6lUECgA6BekvWT1p/CAXly
 JJ+AYfQcy/Me+JkTRusaTr5K0Efs0bhHfY8cgjTSiwGII7Q5eZ/Onne+UO8mvzKO3qc2
 eQxXxpFXUfzLwCWouwEYpbFficfMb8QT5vP20AJ5D/j2LcsVH2uWdcMQz6R/88ETpG5r
 hOH6XlJXe+JbsSHWly5+IgBHbrg9cKMfg7CSUBs6mt3GqKdTDJy9aVTMpmmz+syXJlme
 SdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=55eqNEAHAn+53Kvw5z1O8+VgtevKeEnDDw4n3MCeAtc=;
 b=n9ipV53KjHNYaJEfZA+VeXDbih6etYr5BNl3GUySxWM30IAYQg4QlFuhblKGsexuTs
 gE+wxYP9qskAsIL6g9j2LTuf1qXNbw4okcfR3Ab06g6rCD1+dYOCY7cbg0dpYypn7XU1
 amgjme7+DZ3REAx2sm68nkOXjMAY3Jgi4LJ6kEWW993LOEZC6sFQ7yrMFiDrkubVplZQ
 rB+3WPb8fKq2Oa7LQYQTXZxnFPrObKIyVeGSEifObFyIuRGfZLH91rFHrhQRmjAigSer
 ExxawokOA1bWdsKLPHfUSUiy+0ahAlJDvVd9vBBP0wD3C3sD7hu617IVM54aP8rA6n10
 EXtQ==
X-Gm-Message-State: AFqh2kq7jGxUP9vOR+evwk8YuXHVx5mqtJ/0ZiAy5z4JQhzrtkBRy+Xc
 k91e9lN8fjx8uUX94XCSYBAST9L9vgM=
X-Google-Smtp-Source: AMrXdXu1FL3QsF8BsmTIeF41yoVTQ1SEZ3JKQH4/c1Ceozca/nGKCiuhAl+7pTOMYx8d9HQvSI8Sxg==
X-Received: by 2002:a05:600c:5554:b0:3cf:8e5d:7184 with SMTP id
 iz20-20020a05600c555400b003cf8e5d7184mr31020083wmb.28.1672734455881; 
 Tue, 03 Jan 2023 00:27:35 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:91f2:4ffb:eef9:7882?
 ([2a02:908:1256:79a0:91f2:4ffb:eef9:7882])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a05600c3ac900b003d973d4fb28sm35401696wms.4.2023.01.03.00.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jan 2023 00:27:35 -0800 (PST)
Message-ID: <933a599f-5cdc-7adb-07cb-efd4220d7dc5@gmail.com>
Date: Tue, 3 Jan 2023 09:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: Add range param to
 amdgpu_vm_update_range
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221220232704.3394112-1-Felix.Kuehling@amd.com>
 <20221220232704.3394112-2-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221220232704.3394112-2-Felix.Kuehling@amd.com>
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
Cc: philip.yang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.12.22 um 00:27 schrieb Felix Kuehling:
> This allows page table updates to be coordinated with interval notifiers
> to avoid writing stale page table entries to the pabe table. Moving the
> critical section inside the page table update avoids lock dependencies
> with page table allocations under the notifier lock.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 27 ++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 58 ++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  6 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  4 +-
>   4 files changed, 77 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a04f7aef4ca9..556d2e5d90e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -768,6 +768,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>    * @vram_base: base for vram mappings
>    * @res: ttm_resource to map
>    * @pages_addr: DMA addresses to use for mapping
> + * @range: optional HMM range for coordination with interval notifier
>    * @fence: optional resulting fence
>    *
>    * Fill in the page table entries between @start and @last.
> @@ -780,7 +781,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> -			   struct dma_fence **fence)
> +			   struct hmm_range *range, struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
> @@ -794,7 +795,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
>   	if (!tlb_cb) {
>   		r = -ENOMEM;
> -		goto error_unlock;
> +		goto error_dev_exit;
>   	}
>   
>   	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
> @@ -811,6 +812,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	memset(&params, 0, sizeof(params));
>   	params.adev = adev;
>   	params.vm = vm;
> +#ifdef CONFIG_MMU_NOTIFIER
> +	params.range = range;
> +#endif
>   	params.immediate = immediate;
>   	params.pages_addr = pages_addr;
>   	params.unlocked = unlocked;
> @@ -823,12 +827,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	else
>   		sync_mode = AMDGPU_SYNC_EXPLICIT;
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	if (vm->evicting) {
> -		r = -EBUSY;
> -		goto error_free;
> -	}
> -
>   	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
>   
> @@ -893,7 +891,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		start = tmp;
>   	}
>   
> +	r = amdgpu_vm_pts_lock(&params);
> +	if (r)
> +		goto error_free;
>   	r = vm->update_funcs->commit(&params, fence);
> +	amdgpu_vm_pts_unlock(&params);

This won't work. We need the lock for updates as well and not just for 
committing them.

>   
>   	if (flush_tlb || params.table_freed) {
>   		tlb_cb->vm = vm;
> @@ -911,8 +913,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   error_free:
>   	kfree(tlb_cb);
>   
> -error_unlock:
> -	amdgpu_vm_eviction_unlock(vm);
> +error_dev_exit:
>   	drm_dev_exit(idx);
>   	return r;
>   }
> @@ -1058,7 +1059,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   					   resv, mapping->start, mapping->last,
>   					   update_flags, mapping->offset,
>   					   vram_base, mem, pages_addr,
> -					   last_update);
> +					   NULL, last_update);
>   		if (r)
>   			return r;
>   	}
> @@ -1253,7 +1254,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
>   					   mapping->start, mapping->last,
>   					   init_pte_value, 0, 0, NULL, NULL,
> -					   &f);
> +					   NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> @@ -2512,7 +2513,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	}
>   
>   	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
> -				   addr, flags, value, 0, NULL, NULL, NULL);
> +				   addr, flags, value, 0, NULL, NULL, NULL, NULL);
>   	if (r)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 07af80df812b..8fad51d66bce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -31,6 +31,8 @@
>   #include <drm/drm_file.h>
>   #include <drm/ttm/ttm_bo_driver.h>
>   #include <linux/sched/mm.h>
> +#include <linux/hmm.h>
> +#include <linux/mmu_notifier.h>
>   
>   #include "amdgpu_sync.h"
>   #include "amdgpu_ring.h"
> @@ -196,6 +198,13 @@ struct amdgpu_vm_update_params {
>   	 */
>   	struct amdgpu_vm *vm;
>   
> +#ifdef CONFIG_MMU_NOTIFIER

We should make this independent of CONFIG_MMU_NOTIFIER and just forward 
declare the hmm_range structure here.

> +	/**
> +	 * @range: optional HMM range for coordination with interval notifier
> +	 */
> +	struct hmm_range *range;
> +#endif
> +
>   	/**
>   	 * @immediate: if changes should be made immediately
>   	 */
> @@ -411,7 +420,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> -			   struct dma_fence **fence);
> +			   struct hmm_range *range, struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> @@ -535,4 +544,51 @@ static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
>   	mutex_unlock(&vm->eviction_lock);
>   }
>   
> +/*
> + * Make page tables safe to access without a reservation and ensure that the
> + * ptes being written are still valid. This can fail if page tables are being
> + * evicted (-EBUSY) or an HMM range is being invalidated (-EAGAIN).
> + */
> +static inline int amdgpu_vm_pts_lock(struct amdgpu_vm_update_params *params)
> +{
> +	int r = 0;
> +
> +#ifdef CONFIG_MMU_NOTIFIER
> +	if (params->range) {
> +		mutex_lock(params->vm->notifier_lock);

I really don't think having a separate lock here is a good idea.

Christian.

> +		if (mmu_interval_read_retry(params->range->notifier,
> +					    params->range->notifier_seq)) {
> +			r = -EAGAIN;
> +			goto error_unlock_notifier;
> +		}
> +	}
> +#endif
> +	amdgpu_vm_eviction_lock(params->vm);
> +	if (params->vm->evicting) {
> +		r = -EBUSY;
> +		goto error_unlock;
> +	}
> +
> +	return 0;
> +
> +error_unlock:
> +	amdgpu_vm_eviction_unlock(params->vm);
> +#ifdef CONFIG_MMU_NOTIFIER
> +error_unlock_notifier:
> +	if (params->range)
> +		mutex_unlock(params->vm->notifier_lock);
> +#endif
> +
> +	return r;
> +}
> +
> +static inline void amdgpu_vm_pts_unlock(struct amdgpu_vm_update_params *params)
> +{
> +	amdgpu_vm_eviction_unlock(params->vm);
> +#ifdef CONFIG_MMU_NOTIFIER
> +	if (params->range)
> +		mutex_unlock(params->vm->notifier_lock);
> +#endif
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index b5f3bba851db..2891284eba1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -597,9 +597,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   	if (entry->bo)
>   		return 0;
>   
> -	amdgpu_vm_eviction_unlock(vm);
>   	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
> -	amdgpu_vm_eviction_lock(vm);
>   	if (r)
>   		return r;
>   
> @@ -960,6 +958,9 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   
> +		r = amdgpu_vm_pts_lock(params);
> +		if (r)
> +			return r;
>   		do {
>   			struct amdgpu_vm *vm = params->vm;
>   			uint64_t upd_end = min(entry_end, frag_end);
> @@ -992,6 +993,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   					break;
>   			}
>   		} while (frag_start < entry_end);
> +		amdgpu_vm_pts_unlock(params);
>   
>   		if (amdgpu_vm_pt_descendant(adev, &cursor)) {
>   			/* Free all child entries.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2dc3b04064bd..cc46878901c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1217,7 +1217,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
>   				      last, init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +				      NULL, fence);
>   }
>   
>   static int
> @@ -1323,7 +1323,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   					   pte_flags,
>   					   (last_start - prange->start) << PAGE_SHIFT,
>   					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr, &vm->last_update);
> +					   NULL, dma_addr, NULL, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;


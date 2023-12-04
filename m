Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFD3C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 08:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBC810E065;
	Mon,  4 Dec 2023 08:41:00 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3BD10E327
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 08:40:48 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c0873cf84so12838695e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Dec 2023 00:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701679247; x=1702284047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X1fdAGecdJDEGsubK5Uzh321nH3Yr08+YIcosRoO+dw=;
 b=RqCHCwc7FKiTwGltZ6BAghvgkn02N2YptXx4G9jK/1Lu36pD3L3i5XBf03KV1X02k6
 hy5tPXdiFFuJjLvSOSO7GfQHwWar1gDg9MakOC3vGtRIbcUINd4LAdqKtZYeqdvjGJ1v
 6hbd+HpN9UxDTDkzlZsJG6qfkeC9XE4DDiKB8QPj7E48SIiTg/dQLiyhkJKwSaKRLZqS
 ZkfJCJKZuXfTLMcE/2nqlUSdpMDtQWWK7uPuz+OHW6hpmoxiPpy0cdWs6EDQ+1OTh6NM
 kN0DNh3bBbOoY2D2DYu3UHHzyJp+LjJtfYs3Pmee393YwKgFX4EdLsPGOeTWpUyjzp4C
 lCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701679247; x=1702284047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X1fdAGecdJDEGsubK5Uzh321nH3Yr08+YIcosRoO+dw=;
 b=UQnJu2MwOnsqxALkpMMBRx4B1Ps6p69egMQWgAyLMw2eUdcm7vOhuuZgPZBY08fyLA
 rBBFyirY7o0qNdVeqT4VittANuGcktNXFckB0F4OBTxIG4X80JdfGZseMPLyGjjNBwKK
 6oRGAKAnIZo+Togvsah7klWCognLTc13vkDy0WvfbdykByWLwKpWCw4qXrWtugoekBfd
 PQZR/HGotKK49inHqtTyPEEbI+5/AOvRcCZ0xaRfng6zjO2oFfJjBjJ8IsW7YY3XEM6Q
 6q9I8aqgsf8VM/5/KelFkzqvDa7s4L2lszPAI/ol/7JzjjSjCR/mA1QAYaH1HT2yJrfr
 7wPQ==
X-Gm-Message-State: AOJu0Yzs06UF9Cdw2N7Ebd22J5n2U/DbTms7S36pomb7yOF9wu1eY21i
 MW8n7TtoBwvl6daUSCjMqiTTd8mFvOc=
X-Google-Smtp-Source: AGHT+IFlZE7WJsJF5mMtmHa3T6Y9naGMHBHEWkVIYgwJQlZCaJ0Sjrm3JF/xi7fNlkGGZDH33gd4ZA==
X-Received: by 2002:a7b:ce13:0:b0:40c:aab:7563 with SMTP id
 m19-20020a7bce13000000b0040c0aab7563mr679134wmc.80.1701679246040; 
 Mon, 04 Dec 2023 00:40:46 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a5d5087000000b003333cb59d69sm5382559wrt.35.2023.12.04.00.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 00:40:45 -0800 (PST)
Message-ID: <062fed7f-1304-4f59-9103-b32bfec830d4@gmail.com>
Date: Mon, 4 Dec 2023 09:40:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Auto-validate DMABuf imports in compute
 VMs
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231114233254.63139-1-Felix.Kuehling@amd.com>
 <20231114233254.63139-2-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231114233254.63139-2-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.11.23 um 00:32 schrieb Felix Kuehling:
> DMABuf imports in compute VMs are not wrapped in a kgd_mem object on the
> process_info->kfd_bo_list. There is no explicit KFD API call to validate
> them or add eviction fences to them.
>
> This patch automatically validates and fences dymanic DMABuf imports when
> they are added to a compute VM. Revalidation after evictions is handled
> in the VM code.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  45 ++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  26 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 122 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  12 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  12 +-
>   8 files changed, 196 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index fcf8a98ad15e..68d534a89942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -178,6 +178,9 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
>   struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>   				struct mm_struct *mm,
>   				struct svm_range_bo *svm_bo);
> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> +					uint32_t domain,
> +					struct dma_fence *fence);
>   #if defined(CONFIG_DEBUG_FS)
>   int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2e302956a279..bb83ab7a0256 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -423,9 +423,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>   	return ret;
>   }
>   
> -static int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> -					       uint32_t domain,
> -					       struct dma_fence *fence)
> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> +					uint32_t domain,
> +					struct dma_fence *fence)
>   {
>   	int ret = amdgpu_bo_reserve(bo, false);
>   
> @@ -461,13 +461,16 @@ static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
>    * again. Page directories are only updated after updating page
>    * tables.
>    */
> -static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
> +static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
> +				 struct ww_acquire_ctx *ticket)
>   {
>   	struct amdgpu_bo *pd = vm->root.bo;
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
>   	int ret;
>   
> -	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate_vm_bo, NULL);
> +	ret = amdgpu_vm_validate_evicted_bos(adev, vm, ticket,
> +					     amdgpu_amdkfd_validate_vm_bo,
> +					     NULL);
>   	if (ret) {
>   		pr_err("failed to validate PT BOs\n");
>   		return ret;
> @@ -1347,14 +1350,15 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   	return ret;
>   }
>   
> -static int process_validate_vms(struct amdkfd_process_info *process_info)
> +static int process_validate_vms(struct amdkfd_process_info *process_info,
> +				struct ww_acquire_ctx *ticket)
>   {
>   	struct amdgpu_vm *peer_vm;
>   	int ret;
>   
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
> -		ret = vm_validate_pt_pd_bos(peer_vm);
> +		ret = vm_validate_pt_pd_bos(peer_vm, ticket);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1440,7 +1444,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	ret = amdgpu_bo_reserve(vm->root.bo, true);
>   	if (ret)
>   		goto reserve_pd_fail;
> -	ret = vm_validate_pt_pd_bos(vm);
> +	ret = vm_validate_pt_pd_bos(vm, NULL);
>   	if (ret) {
>   		pr_err("validate_pt_pd_bos() failed\n");
>   		goto validate_pd_fail;
> @@ -2075,7 +2079,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	    bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>   		is_invalid_userptr = true;
>   
> -	ret = vm_validate_pt_pd_bos(avm);
> +	ret = vm_validate_pt_pd_bos(avm, NULL);
>   	if (unlikely(ret))
>   		goto out_unreserve;
>   
> @@ -2154,7 +2158,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		goto unreserve_out;
>   	}
>   
> -	ret = vm_validate_pt_pd_bos(avm);
> +	ret = vm_validate_pt_pd_bos(avm, NULL);
>   	if (unlikely(ret))
>   		goto unreserve_out;
>   
> @@ -2635,7 +2639,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>   
>   	amdgpu_sync_create(&sync);
>   
> -	ret = process_validate_vms(process_info);
> +	ret = process_validate_vms(process_info, NULL);
>   	if (ret)
>   		goto unreserve_out;
>   
> @@ -2887,11 +2891,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   
>   	amdgpu_sync_create(&sync_obj);
>   
> -	/* Validate PDs and PTs */
> -	ret = process_validate_vms(process_info);
> -	if (ret)
> -		goto validate_map_fail;
> -
>   	/* Validate BOs and map them to GPUVM (update VM page tables). */
>   	list_for_each_entry(mem, &process_info->kfd_bo_list,
>   			    validate_list.head) {
> @@ -2942,6 +2941,13 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   	if (failed_size)
>   		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
>   
> +	/* Validate PDs, PTs and evicted DMABuf imports last. Otherwise BO
> +	 * validations above would invalidate DMABuf imports again.
> +	 */
> +	ret = process_validate_vms(process_info, &ctx.ticket);
> +	if (ret)
> +		goto validate_map_fail;
> +
>   	/* Update mappings not managed by KFD */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			vm_list_node) {
> @@ -3001,7 +3007,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   				   &process_info->eviction_fence->base,
>   				   DMA_RESV_USAGE_BOOKKEEP);
>   	}
> -	/* Attach eviction fence to PD / PT BOs */
> +	/* Attach eviction fence to PD / PT BOs and DMABuf imports */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
>   		struct amdgpu_bo *bo = peer_vm->root.bo;
> @@ -3009,6 +3015,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   		dma_resv_add_fence(bo->tbo.base.resv,
>   				   &process_info->eviction_fence->base,
>   				   DMA_RESV_USAGE_BOOKKEEP);
> +
> +		ret = amdgpu_vm_fence_imports(peer_vm, &ctx.ticket,
> +					      &process_info->eviction_fence->base);
> +		if (ret)
> +			break;
>   	}
>   
>   validate_map_fail:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1d4e80f72573..7d78a5841db4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -968,10 +968,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	p->bytes_moved = 0;
>   	p->bytes_moved_vis = 0;
>   
> -	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
> -				      amdgpu_cs_bo_validate, p);
> +	r = amdgpu_vm_validate_evicted_bos(p->adev, &fpriv->vm, NULL,
> +					   amdgpu_cs_bo_validate, p);
>   	if (r) {
> -		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
> +		DRM_ERROR("amdgpu_vm_validate_evicted_bos() failed.\n");
>   		goto error_validate;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e7e87a3b2601..8b556669cec0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -373,6 +373,10 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
>   	struct amdgpu_vm_bo_base *bo_base;
>   	int r;
>   
> +	/* FIXME: This should be after the "if", but needs a fix to make sure
> +	 * DMABuf imports are initialized in the right VM list.
> +	 */
> +	amdgpu_vm_bo_invalidate(adev, bo, false);
>   	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>   		return;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 849fffbb367d..fd43921844ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -186,6 +186,32 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	else
>   		++bo_va->ref_count;
>   	amdgpu_bo_unreserve(abo);
> +
> +	/* Validate and add eviction fence to DMABuf imports with dynamic
> +	 * attachment in compute VMs. Re-validation will be done by
> +	 * amdgpu_vm_validate_evicted_bos and the fence will be updated by
> +	 * amdgpu_vm_fence_imports in amdgpu_amdkfd_gpuvm_restore_process_bos.
> +	 *
> +	 * Nested locking below for the case that a GEM object is opened in
> +	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
> +	 * but not for export, this is a different lock class that cannot lead to
> +	 * circular lock dependencies.
> +	 */
> +	if (!vm->is_compute_context || !vm->process_info)
> +		return 0;
> +	if (!obj->import_attach ||
> +	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
> +		return 0;
> +	mutex_lock_nested(&vm->process_info->lock, 1);
> +	if (!WARN_ON(!vm->process_info->eviction_fence)) {
> +		r = amdgpu_amdkfd_bo_validate_and_fence(abo, AMDGPU_GEM_DOMAIN_GTT,
> +							&vm->process_info->eviction_fence->base);
> +		if (r)
> +			dev_warn(adev->dev, "%d: validate_and_fence failed: %d\n",
> +				 vm->task_info.pid, r);

Why not returning the error code instead of just printing a message?

> +	}
> +	mutex_unlock(&vm->process_info->lock);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1c9397198083..9d3fb161cc0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -368,24 +368,31 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   }
>   
>   /**
> - * amdgpu_vm_validate_pt_bos - validate the page table BOs
> + * amdgpu_vm_validate_evicted_bos - validate evicted BOs tracked in the VM
>    *
>    * @adev: amdgpu device pointer
>    * @vm: vm providing the BOs
> + * @ticket: optional reservation ticket used to reserve the VM
>    * @validate: callback to do the validation
>    * @param: parameter for the validation callback
>    *
> - * Validate the page table BOs on command submission if neccessary.
> + * Validate the page table BOs and per-VM BOs on command submission if
> + * necessary. If a ticket is given, also try to validate evicted user queue
> + * BOs. They must already be reserved with the given ticket.
>    *
>    * Returns:
>    * Validation result.
>    */
> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			      int (*validate)(void *p, struct amdgpu_bo *bo),
> -			      void *param)
> +int amdgpu_vm_validate_evicted_bos(struct amdgpu_device *adev,

Maybe just use amdgpu_vm_validate() for the name here. That the 
validated BOs are evicted should be obvious.

> +				   struct amdgpu_vm *vm,
> +				   struct ww_acquire_ctx *ticket,
> +				   int (*validate)(void *p,
> +						   struct amdgpu_bo *bo),
> +				   void *param)
>   {
>   	struct amdgpu_vm_bo_base *bo_base;
>   	struct amdgpu_bo *shadow;
> +	struct dma_resv *resv;
>   	struct amdgpu_bo *bo;
>   	int r;
>   
> @@ -416,6 +423,28 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   		spin_lock(&vm->status_lock);
>   	}
> +	while (ticket && !list_empty(&vm->evicted_user)) {
> +		bo_base = list_first_entry(&vm->evicted_user,
> +					   struct amdgpu_vm_bo_base,
> +					   vm_status);
> +		spin_unlock(&vm->status_lock);
> +
> +		bo = bo_base->bo;
> +		resv = bo->tbo.base.resv;
> +
> +		if (dma_resv_locking_ctx(resv) != ticket) {
> +			pr_warn_ratelimited("Evicted user BO is not reserved in pid %d\n",
> +					    vm->task_info.pid);
> +			return -EINVAL;
> +		}
> +
> +		r = validate(param, bo);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vm_bo_invalidated(bo_base);
> +		spin_lock(&vm->status_lock);
> +	}

I see two main differences to the evicted state here:

1. We now handle BOs which don't use the shared reservation object and 
needs to be locked manually with the ticket before calling this function.

2. The BOs are then moved into a different state after validating them.

That could be handled with just an additional if if I'm not completely 
mistaken which would make the extra state superfluous.

>   	spin_unlock(&vm->status_lock);
>   
>   	amdgpu_vm_eviction_lock(vm);
> @@ -1358,11 +1387,21 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		}
>   
>   		r = amdgpu_vm_bo_update(adev, bo_va, clear);
> -		if (r)
> -			return r;
>   
>   		if (unlock)
>   			dma_resv_unlock(resv);
> +		if (r)
> +			return r;
> +
> +		/* Remember evicted DMABuf imports in compute VMs for later
> +		 * validation
> +		 */
> +		if (vm->is_compute_context && bo_va->base.bo &&
> +		    bo_va->base.bo->tbo.base.import_attach &&
> +		    (!bo_va->base.bo->tbo.resource ||
> +		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
> +			amdgpu_vm_bo_evicted_user(&bo_va->base);
> +
>   		spin_lock(&vm->status_lock);
>   	}
>   	spin_unlock(&vm->status_lock);
> @@ -1370,6 +1409,75 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_vm_fence_imports - add fence to valid DMABuf imports
> + *
> + * @vm: requested vm
> + * @ticket: optional reservation ticket used to reserve the VM
> + * @fence: fence to add
> + *
> + * Add the specified fence to all dynamic DMABuf imports that are valid.
> + *
> + * Returns:
> + * 0 for success.
> + */
> +int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
> +			    struct ww_acquire_ctx *ticket,
> +			    struct dma_fence *fence)
> +{
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +	struct dma_resv *resv;
> +	LIST_HEAD(imports);
> +	bool unlock;
> +	int ret = 0;
> +
> +	if (!vm->is_compute_context)
> +		return 0;
> +
> +	/* Move all the DMABuf imports to a private list so I can reserve
> +	 * them while not holding te status_lock.
> +	 */
> +	spin_lock(&vm->status_lock);
> +	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> +		if (bo_va->base.bo && bo_va->base.bo->tbo.base.import_attach &&
> +		    dma_buf_is_dynamic(bo_va->base.bo->tbo.base.import_attach->dmabuf))
> +			list_move(&bo_va->base.vm_status, &imports);
> +	}
> +	spin_unlock(&vm->status_lock);

That looks a lot like it won't work.

What's preventing the status of DMA-buf BOs from changing while doing this?

Regards,
Christian.

> +
> +	list_for_each_entry(bo_va, &imports, base.vm_status) {
> +		resv = bo_va->base.bo->tbo.base.resv;
> +
> +		/* Try to reserve the BO */
> +		if (dma_resv_trylock(resv)) {
> +			unlock = true;
> +		/* The caller is already holding the reservation lock */
> +		} else if (ticket && dma_resv_locking_ctx(resv) == ticket) {
> +			unlock = false;
> +		} else {
> +			WARN_ONCE(1, "Failed to reserve DMABuf import");
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		ret = dma_resv_reserve_fences(resv, 1);
> +		if (!ret)
> +			dma_resv_add_fence(resv, fence,
> +					   DMA_RESV_USAGE_BOOKKEEP);
> +
> +		if (unlock)
> +			dma_resv_unlock(resv);
> +		if (ret)
> +			break;
> +	}
> +
> +	spin_lock(&vm->status_lock);
> +	list_splice(&imports, &vm->idle);
> +	spin_unlock(&vm->status_lock);
> +
> +	return ret;
> +}
> +
>   /**
>    * amdgpu_vm_flush_compute_tlb - Flush TLB on compute VM
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 939d0c2219c0..a380c4acf8e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -432,9 +432,12 @@ void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
>   			 struct list_head *validated,
>   			 struct amdgpu_bo_list_entry *entry);
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			      int (*callback)(void *p, struct amdgpu_bo *bo),
> -			      void *param);
> +int amdgpu_vm_validate_evicted_bos(struct amdgpu_device *adev,
> +				   struct amdgpu_vm *vm,
> +				   struct ww_acquire_ctx *ticket,
> +				   int (*callback)(void *p,
> +						   struct amdgpu_bo *bo),
> +				   void *param);
>   int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
> @@ -444,6 +447,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   			   struct amdgpu_vm *vm,
>   			   struct ww_acquire_ctx *ticket);
> +int amdgpu_vm_fence_imports(struct amdgpu_vm *vm,
> +			    struct ww_acquire_ctx *ticket,
> +			    struct dma_fence *fence);
>   int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm,
>   				uint32_t flush_type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b23ba92a794c..6eec0f4ddde4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1558,9 +1558,11 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
>   			goto unreserve_out;
>   		}
>   
> -		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
> -					      drm_priv_to_vm(pdd->drm_priv),
> -					      svm_range_bo_validate, NULL);
> +		r = amdgpu_vm_validate_evicted_bos(pdd->dev->adev,
> +						   drm_priv_to_vm(pdd->drm_priv),
> +						   NULL,
> +						   svm_range_bo_validate,
> +						   NULL);
>   		if (r) {
>   			pr_debug("failed %d validate pt bos\n", r);
>   			goto unreserve_out;
> @@ -1677,7 +1679,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		goto free_ctx;
>   	}
>   
> -	svm_range_reserve_bos(ctx);
> +	r = svm_range_reserve_bos(ctx);
> +	if (r)
> +		goto free_ctx;
>   
>   	p = container_of(prange->svms, struct kfd_process, svms);
>   	owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57915C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 14:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD7810E602;
	Mon, 26 Feb 2024 14:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XIHJ5aZ+";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70C310E562
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 14:46:04 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so36173671fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 06:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708958763; x=1709563563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iiVxDPGTZHiXWVdpRb9sLfJrMsGLf9l+CUIFmUtweHE=;
 b=XIHJ5aZ+FOscEtIJSiudhEmg/a5H7HP/Gj7U5MuQdX0CJwXBzf5NMjLQ95qv77gXnP
 6si25nhzoO0CWmInvGTzoLDDepZpu9WFcycgnIAifiIm9UO0bvQQLX9vbiLgtEA4Agi9
 BtQXgu2DzUr0lJBF/PY13hCO/UGGyhUDmVkmISonakvU1R5YFIpP3xkSTbi7ePKWhOkA
 0c8sroG206tHCHeRKD00glG6x5dkWu+KQSJxOlOypNbG8TjSvF8Avf5Ymowp+hK4F99H
 jqdmRLEA6uJp2YPZbEyCpUyCSGrakBv3Spr6Viet0ovtj7rXrBF4ITvr5384ar1sATlJ
 ozZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708958763; x=1709563563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iiVxDPGTZHiXWVdpRb9sLfJrMsGLf9l+CUIFmUtweHE=;
 b=bElWJx2o25XmBaqVyWXWTv3/MOYTwGkh7qBiI3qTroG1NzKLJw2fds4kmmjtms4IsZ
 Ph0d0hkfgRUVaEDwx5fDn+rnNxiKeCEq2+Lz6KOHzdKAJUyxgGTSnd1RaC59mDwzTe5c
 c7FZ+X4Wk7idbH+vC1h+Isw4fHqMDWWQ85+4EjVjTxj1VaUglRzJVlmNcCEno9mrlLDS
 zyJnTHC41Hxsn0zSHBK8TVibMEV8Jpw7v5go7qt8LP858EsXFi/mOWph3qG+NBmE7nV3
 twPdmHNqn0JRvMP1CamVaY3Oo64S9fHbWyuYjiqEjhFwMCF32fR1lUTVIOnjL/WMMJS4
 M96w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl8z4oaDzYZd/2mYkr83U1+bPewYMJDIiNTJ0/obc5ZG3DZ4Y492xO40kDBkMtgQJHPpXo4w8kDHO6AiKzKVdi0gXUexSX1W3X0j07Pg==
X-Gm-Message-State: AOJu0YzNx7mEyFfRn79Ol47t+czpzR5yax5PBs+5BvmufWfieE8QMarf
 RYnrR/8gvyB4nF/OjRBRBzCpB4EgfvrIalJ/1yZZN/59bKjj/Thn
X-Google-Smtp-Source: AGHT+IFVBCv3ITmTOzBNCzpWvLrallhKZKEn2z/Scy/luEemFaHvUYYzbGHVwTePC4HDLfXVOgfRDg==
X-Received: by 2002:a05:651c:f:b0:2d2:45c2:3bf0 with SMTP id
 n15-20020a05651c000f00b002d245c23bf0mr4235392lja.8.1708958762344; 
 Mon, 26 Feb 2024 06:46:02 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b004125f34fd7csm12110170wmi.31.2024.02.26.06.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 06:46:01 -0800 (PST)
Message-ID: <df699975-9663-43d5-9243-3c675a6cb014@gmail.com>
Date: Mon, 26 Feb 2024 15:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: replace TLB seq callback with HW seq
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240223134206.899-1-shashank.sharma@amd.com>
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

Am 23.02.24 um 14:42 schrieb Shashank Sharma:
> From: Christian König <christian.koenig@amd.com>
>
> The callback we installed for the SDMA update were actually pretty
> horrible. since we now have seq64 use that one and HW seq writes
> instead.
>
> V2:(Shashank)
>   - rebased on amd-drm-staging-next
>   - changed amdgpu_seq64_gpu_addr
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Shashank can I get an rb on this patch here so that I can push it to 
amd-staging-drm-next?

The patch was basically just to double check if the seq64 code works as 
intended.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c   | 14 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 79 ++++-----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 27 ++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  5 ++
>   7 files changed, 42 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 3d0d56087d41..300dc79fa2b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -199,6 +199,20 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>   		__clear_bit(bit_pos, adev->seq64.used);
>   }
>   
> +/**
> + * amdgpu_seq64_gpu_addr - Calculate GPU addr from va
> + *
> + * @adev: amdgpu_device pointer
> + * @va: virtual address in client address space
> + *
> + * Calculate the GART address for a VA.
> + */
> +u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va)
> +{
> +	return va - amdgpu_seq64_get_va_base(adev) +
> +		amdgpu_bo_gpu_offset(adev->seq64.sbo);
> +}
> +
>   /**
>    * amdgpu_seq64_fini - Cleanup seq64 driver
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> index 4203b2ab318d..63e8ac0a2057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> @@ -43,6 +43,7 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_bo_va **bo_va);
>   void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv);
> +u64 amdgpu_seq64_gpu_addr(struct amdgpu_device *adev, u64 va);
>   
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ed4a8c5d26d7..0960e0a665d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -111,21 +111,6 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> -/**
> - * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
> - */
> -struct amdgpu_vm_tlb_seq_struct {
> -	/**
> -	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
> -	 */
> -	struct amdgpu_vm *vm;
> -
> -	/**
> -	 * @cb: callback
> -	 */
> -	struct dma_fence_cb cb;
> -};
> -
>   /**
>    * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>    *
> @@ -862,23 +847,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -/**
> - * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
> - * @fence: unused
> - * @cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM flush.
> - */
> -static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
> -				 struct dma_fence_cb *cb)
> -{
> -	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> -
> -	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
> -	atomic64_inc(&tlb_cb->vm->tlb_seq);
> -	kfree(tlb_cb);
> -}
> -
>   /**
>    * amdgpu_vm_update_range - update a range in the vm page table
>    *
> @@ -911,7 +879,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_res_cursor cursor;
>   	enum amdgpu_sync_mode sync_mode;
>   	int r, idx;
> @@ -919,12 +886,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> -	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> -	if (!tlb_cb) {
> -		r = -ENOMEM;
> -		goto error_unlock;
> -	}
> -
>   	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
>   	 * heavy-weight flush TLB unconditionally.
>   	 */
> @@ -942,6 +903,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.immediate = immediate;
>   	params.pages_addr = pages_addr;
>   	params.unlocked = unlocked;
> +	params.needs_flush = flush_tlb;
>   	params.allow_override = allow_override;
>   
>   	/* Implicitly sync to command submissions in the same VM before
> @@ -955,7 +917,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	amdgpu_vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
> -		goto error_free;
> +		goto error_unlock;
>   	}
>   
>   	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> @@ -968,7 +930,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = vm->update_funcs->prepare(&params, resv, sync_mode);
>   	if (r)
> -		goto error_free;
> +		goto error_unlock;
>   
>   	amdgpu_res_first(pages_addr ? NULL : res, offset,
>   			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
> @@ -1018,7 +980,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		tmp = start + num_entries;
>   		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>   		if (r)
> -			goto error_free;
> +			goto error_unlock;
>   
>   		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>   		start = tmp;
> @@ -1026,22 +988,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	r = vm->update_funcs->commit(&params, fence);
>   
> -	if (flush_tlb || params.table_freed) {
> -		tlb_cb->vm = vm;
> -		if (fence && *fence &&
> -		    !dma_fence_add_callback(*fence, &tlb_cb->cb,
> -					   amdgpu_vm_tlb_seq_cb)) {
> -			dma_fence_put(vm->last_tlb_flush);
> -			vm->last_tlb_flush = dma_fence_get(*fence);
> -		} else {
> -			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -		}
> -		tlb_cb = NULL;
> -	}
> -
> -error_free:
> -	kfree(tlb_cb);
> -
>   error_unlock:
>   	amdgpu_vm_eviction_unlock(vm);
>   	drm_dev_exit(idx);
> @@ -2260,10 +2206,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   	INIT_KFIFO(vm->faults);
>   
> -	r = amdgpu_vm_init_entities(adev, vm);
> +	r = amdgpu_seq64_alloc(adev, &vm->tlb_seq_va, &vm->tlb_seq_cpu_addr);
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_vm_init_entities(adev, vm);
> +	if (r)
> +		goto error_free_seq;
> +
>   	vm->pte_support_ats = false;
>   	vm->is_compute_context = false;
>   
> @@ -2283,7 +2233,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
> -	vm->last_tlb_flush = dma_fence_get_stub();
>   	vm->generation = 0;
>   
>   	mutex_init(&vm->eviction_lock);
> @@ -2322,10 +2271,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	amdgpu_bo_unref(&root_bo);
>   
>   error_free_delayed:
> -	dma_fence_put(vm->last_tlb_flush);
>   	dma_fence_put(vm->last_unlocked);
>   	amdgpu_vm_fini_entities(vm);
>   
> +error_free_seq:
> +	amdgpu_seq64_free(adev, vm->tlb_seq_va);
>   	return r;
>   }
>   
> @@ -2441,7 +2391,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	struct amdgpu_bo_va_mapping *mapping, *tmp;
>   	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>   	struct amdgpu_bo *root;
> -	unsigned long flags;
>   	int i;
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
> @@ -2453,11 +2402,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
> -	dma_fence_wait(vm->last_tlb_flush, false);
> -	/* Make sure that all fence callbacks have completed */
> -	spin_lock_irqsave(vm->last_tlb_flush->lock, flags);
> -	spin_unlock_irqrestore(vm->last_tlb_flush->lock, flags);
> -	dma_fence_put(vm->last_tlb_flush);
> +	amdgpu_seq64_free(adev, vm->tlb_seq_va);
>   
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>   		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 666698a57192..ac9380afcb69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -247,9 +247,9 @@ struct amdgpu_vm_update_params {
>   	unsigned int num_dw_left;
>   
>   	/**
> -	 * @table_freed: return true if page table is freed when updating
> +	 * @needs_flush: true whenever we need to invalidate the TLB
>   	 */
> -	bool table_freed;
> +	bool needs_flush;
>   
>   	/**
>   	 * @allow_override: true for memory that is not uncached: allows MTYPE
> @@ -328,9 +328,11 @@ struct amdgpu_vm {
>   	struct drm_sched_entity	immediate;
>   	struct drm_sched_entity	delayed;
>   
> -	/* Last finished delayed update */
> +	/* Sequence number indicating necessary TLB flush */
>   	atomic64_t		tlb_seq;
> -	struct dma_fence	*last_tlb_flush;
> +	uint64_t		tlb_seq_va;
> +	uint64_t		*tlb_seq_cpu_addr;
> +
>   	atomic64_t		kfd_last_flushed_seq;
>   
>   	/* How many times we had to re-generate the page tables */
> @@ -549,22 +551,7 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>    */
>   static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>   {
> -	unsigned long flags;
> -	spinlock_t *lock;
> -
> -	/*
> -	 * Workaround to stop racing between the fence signaling and handling
> -	 * the cb. The lock is static after initially setting it up, just make
> -	 * sure that the dma_fence structure isn't freed up.
> -	 */
> -	rcu_read_lock();
> -	lock = vm->last_tlb_flush->lock;
> -	rcu_read_unlock();
> -
> -	spin_lock_irqsave(lock, flags);
> -	spin_unlock_irqrestore(lock, flags);
> -
> -	return atomic64_read(&vm->tlb_seq);
> +	return READ_ONCE(*vm->tlb_seq_cpu_addr);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 6e31621452de..0f8fd0acef7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -108,7 +108,8 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>   static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>   				struct dma_fence **fence)
>   {
> -	/* Flush HDP */
> +	if (p->needs_flush)
> +		*p->vm->tlb_seq_cpu_addr = atomic64_inc_return(&p->vm->tlb_seq);
>   	mb();
>   	amdgpu_device_flush_hdp(p->adev, NULL);
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..95dc0afdaffb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -1056,7 +1056,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			while (cursor.pfn < frag_start) {
>   				/* Make sure previous mapping is freed */
>   				if (cursor.entry->bo) {
> -					params->table_freed = true;
> +					params->needs_flush = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
>   							      &cursor,
>   							      params->unlocked);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 349416e176a1..91cc3121fd4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -126,6 +126,11 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   
>   	WARN_ON(ib->length_dw == 0);
>   	amdgpu_ring_pad_ib(ring, ib);
> +	if (p->needs_flush) {
> +		p->job->uf_addr = amdgpu_seq64_gpu_addr(p->adev,
> +							p->vm->tlb_seq_va);
> +		p->job->uf_sequence = atomic64_inc_return(&p->vm->tlb_seq);
> +	}
>   	WARN_ON(ib->length_dw > p->num_dw_left);
>   	f = amdgpu_job_submit(p->job);
>   


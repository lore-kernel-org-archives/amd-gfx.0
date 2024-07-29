Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545CDC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 18:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA7510E332;
	Mon, 29 Jul 2024 18:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUjLfK2L";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2AB710E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 18:23:55 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso19475135e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722277434; x=1722882234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FrIAK9krkwFmYR/NlJQURlgZJW6YKkTAlOCDZPIw/tA=;
 b=kUjLfK2LDFMa23ONY+9NEYY49xqgvBk8HwH7Fjwp63WNkeo7sD3FOPXfPoxzFSFcJi
 w+TKKWxtpXaw1vr2JpHW6mGD/t9c6HW9mUEUpmcPjMUXHwPDqvVFzPm9YkgYjcQTGIqq
 dAeGN0+jmsIySkTEqpHsrjYvD6aYlyKfd9F7Il+AIEFMoqPFiqaAb/bJ9GmP3f/IkgZy
 UhOQ4QyQHGR/bicy6EtuAlB5SEqNkI1BwS64+JK5tjPe6xDtA/jy2casyjFvD5wkq1Fi
 0WYTn302FzKjrXojFtB8OxDwt6eRMHvlxW2h6r6t66AqS4fiiWA/rM/WLnX1BSnhbk/A
 9noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722277434; x=1722882234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FrIAK9krkwFmYR/NlJQURlgZJW6YKkTAlOCDZPIw/tA=;
 b=jFU1qAH645Qfc9r5QpNIN8VTbcd1kVXnkv3HD+dUQXwhH+qwLH7o3d6oCzkqfDQzA8
 G2Y7K9FyGG/La4cwimHveSlLrzZioFzigDPHNssLCIEQntCv0hEeqSTiFMCOjKU/sxKw
 pBxQB54IIeiN3buEd0Z/6OayKc/Tsd9h2CANqHeqYav3MNPCNhXy3MsgknShKmFTi4L9
 FZOfiqtdWF3Lp3jVvdChZ70q2/3RzdvjlLiq/9aYg8EaMOApKJSqELW0ifUZ2kxLd7+G
 oZdsM6pqOC/3+bGMmwqhVYIkzO6ZtirktO073GAnETLiI8JV0MrSA2oUazS7OjxEYn6q
 yesg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH7LNtS3rbUrQqlQuJ4FyqIMxc1F4/9M46ecwtoImo5NrgyxyTX8LrvcnVUoZK7dc5/ZOm29TqhvuEy4FhPsovfe6C8iSdXqkWLGRNqg==
X-Gm-Message-State: AOJu0Ywp5T8PSr2HfWW8O7UqftPOcNtrKTr9jyzjbPCZPMRr/r2sAFpb
 omAnsaBdOd35q7wqx7b7psaJvDFKw6cwHlDS8aDzNRB+zIlBS3WA
X-Google-Smtp-Source: AGHT+IHi9F+smVcSemYUA1/tbCGgoIxjfPgIo1EcKfXxcyeC5TbYLHbq7/5HCyvS24JFT8mb/OWriA==
X-Received: by 2002:a05:600c:1908:b0:425:7c5f:1bac with SMTP id
 5b1f17b1804b1-42811da9fc3mr64387075e9.21.1722277433514; 
 Mon, 29 Jul 2024 11:23:53 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281c785d6csm52162285e9.15.2024.07.29.11.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 11:23:53 -0700 (PDT)
Message-ID: <88c71c62-0cdf-4e64-9f83-befda8f19b4f@gmail.com>
Date: Mon, 29 Jul 2024 20:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Change kfd/svm page fault drain handling
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240725181909.8099-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240725181909.8099-1-xiaogang.chen@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.07.24 um 20:19 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
> not handle any incoming pages fault of this process until a deferred work item
> got executed by default system wq. The time period of "not handle page fault"
> can be long and is unpredicable. That is advese to kfd performance on page
> faults recovery.
>
> This patch uses time stamp of incoming page page to decide to drop or handle
> page fault. When app unmap vm ranges kfd records each gpu device's ih ring
> current time stamp. These time stamps are used at kfd page fault recovery
> routine.
>
> Any page fault happens on unmapped ranges after unmap events is app bug that
> accesses vm range after unmap. It is not driver work to cover that.

But that defers destroying the unmapped range until the IH ring is 
cleared, isn't it?

>
> By using time stamp of page fault do not need drain page faults at deferred
> work. So, the time period that kfd does not handle page faults is reduced
> and can be controlled.
>
> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 102 ++++++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
>   7 files changed, 79 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..d90b7ea3f020 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>    * shouldn't be reported any more.
>    */
>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    u32 vmid, u32 node_id, uint64_t addr,
> +			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
>   			    bool write_fault)
>   {
>   	bool is_compute_context = false;
> @@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	addr /= AMDGPU_GPU_PAGE_SIZE;
>   
>   	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
> -	    node_id, addr, write_fault)) {
> +	    node_id, addr, ts, write_fault)) {
>   		amdgpu_bo_unref(&root);
>   		return true;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 312a408b80d3..1d6a1381ede9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>   void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
>   
>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> -			    u32 vmid, u32 node_id, uint64_t addr,
> +			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
>   			    bool write_fault);
>   
>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d933e19e0cf5..3596cc2ee7e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   		/* Try to handle the recoverable page faults by filling page
>   		 * tables
>   		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr, write_fault))
> +		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
> +					   entry->timestamp, write_fault))
>   			return 1;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 350f6b6676f1..ac08d9424feb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   			cam_index = entry->src_data[2] & 0x3ff;
>   
>   			ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						     addr, write_fault);
> +						     addr, entry->timestamp, write_fault);
>   			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
>   			if (ret)
>   				return 1;
> @@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   			 * tables
>   			 */
>   			if (amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -						   addr, write_fault))
> +						   addr, entry->timestamp, write_fault))
>   				return 1;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index c51e908f6f19..771c98e104ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -850,10 +850,13 @@ struct svm_range_list {
>   	struct list_head                criu_svm_metadata_list;
>   	spinlock_t			deferred_list_lock;
>   	atomic_t			evicted_ranges;
> -	atomic_t			drain_pagefaults;
> +	/* stop page fault recovery for this process */
> +	atomic_t			stop_pf_recovery;
>   	struct delayed_work		restore_work;
>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>   	struct task_struct		*faulting_task;
> +	/* check point ts decides if page fault recovery need be dropped */
> +	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
>   };
>   
>   /* Process data */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 407636a68814..fb0e883868b4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   {
>   	struct kfd_process_device *pdd;
>   	struct kfd_process *p;
> -	int drain;
>   	uint32_t i;
>   
>   	p = container_of(svms, struct kfd_process, svms);
>   
> -restart:
> -	drain = atomic_read(&svms->drain_pagefaults);
> -	if (!drain)
> -		return;
> -
>   	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>   		pdd = p->pdds[i];
>   		if (!pdd)
> @@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}
> -	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
> -		goto restart;
>   }
>   
>   static void svm_range_deferred_list_work(struct work_struct *work)
> @@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>   			 prange->start, prange->last, prange->work_item.op);
>   
>   		mm = prange->work_item.mm;
> -retry:
> -		mmap_write_lock(mm);
>   
> -		/* Checking for the need to drain retry faults must be inside
> -		 * mmap write lock to serialize with munmap notifiers.
> -		 */
> -		if (unlikely(atomic_read(&svms->drain_pagefaults))) {
> -			mmap_write_unlock(mm);
> -			svm_range_drain_retry_fault(svms);
> -			goto retry;
> -		}
> +		mmap_write_lock(mm);
>   
>   		/* Remove from deferred_list must be inside mmap write lock, for
>   		 * two race cases:
> @@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	struct kfd_process *p;
>   	unsigned long s, l;
>   	bool unmap_parent;
> +	uint32_t i;
>   
>   	p = kfd_lookup_process_by_mm(mm);
>   	if (!p)
> @@ -2455,11 +2439,37 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
>   		 prange, prange->start, prange->last, start, last);
>   
> -	/* Make sure pending page faults are drained in the deferred worker
> -	 * before the range is freed to avoid straggler interrupts on
> -	 * unmapped memory causing "phantom faults".
> +	/* calculate time stamps that are used to decide which page faults need be
> +	 * dropped or handled before unmap pages from gpu vm
>   	 */
> -	atomic_inc(&svms->drain_pagefaults);
> +	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> +		struct kfd_process_device *pdd;
> +		struct amdgpu_device *adev;
> +		struct amdgpu_ih_ring *ih;
> +		uint32_t checkpoint_wptr;
> +
> +		pdd = p->pdds[i];
> +		if (!pdd)
> +			continue;
> +
> +		adev = pdd->dev->adev;
> +
> +		/* check if adev->irq.ih1 is not empty */
> +		ih = &adev->irq.ih1;
> +		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +		if (ih->rptr != checkpoint_wptr) {
> +			WRITE_ONCE(svms->checkpoint_ts[i], checkpoint_wptr);
> +			continue;
> +		}
> +
> +		/* check if dev->irq.ih_soft is not empty */
> +		ih = &adev->irq.ih_soft;
> +		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +		if (ih->rptr != checkpoint_wptr) {
> +			WRITE_ONCE(svms->checkpoint_ts[i], checkpoint_wptr);
> +			continue;
> +		}
> +	}
>   
>   	unmap_parent = start <= prange->start && last >= prange->last;
>   
> @@ -2900,7 +2910,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
>   int
>   svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint32_t vmid, uint32_t node_id,
> -			uint64_t addr, bool write_fault)
> +			uint64_t addr, uint64_t ts, bool write_fault)
>   {
>   	unsigned long start, last, size;
>   	struct mm_struct *mm = NULL;
> @@ -2910,7 +2920,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	ktime_t timestamp = ktime_get_boottime();
>   	struct kfd_node *node;
>   	int32_t best_loc;
> -	int32_t gpuidx = MAX_GPU_INSTANCE;
> +	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
>   	bool write_locked = false;
>   	struct vm_area_struct *vma;
>   	bool migration = false;
> @@ -2930,12 +2940,39 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
>   
> -	if (atomic_read(&svms->drain_pagefaults)) {
> -		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +	/* kfd page fault recovery is disabled */
> +	if (atomic_read(&svms->stop_pf_recovery)) {
> +		pr_debug("page fault handing disabled, drop fault 0x%llx\n", addr);
>   		r = 0;
>   		goto out;
>   	}
>   
> +	node = kfd_node_by_irq_ids(adev, node_id, vmid);
> +	if (!node) {
> +		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
> +			 vmid);
> +		r = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
> +		pr_debug("failed to get gpuid/gpuidex for node_id: %d \n", node_id);
> +		r = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
> +	if (READ_ONCE(svms->checkpoint_ts[gpuidx]) != 0 &&
> +		      amdgpu_ih_ts_after(ts,  READ_ONCE(svms->checkpoint_ts[gpuidx]))) {
> +		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +		r = 0;
> +		goto out;
> +	} else
> +		/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> +		 * to zero to avoid following ts wrap around give wrong comparing
> +		 */
> +		WRITE_ONCE(svms->checkpoint_ts[gpuidx], 0);

Pretty clear NAK to using WRITE_ONCE like this. You have exactly zero 
memory barrier here.

Regards,
Christian.

> +
>   	if (!p->xnack_enabled) {
>   		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>   		r = -EFAULT;
> @@ -2952,13 +2989,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out;
>   	}
>   
> -	node = kfd_node_by_irq_ids(adev, node_id, vmid);
> -	if (!node) {
> -		pr_debug("kfd node does not exist node_id: %d, vmid: %d\n", node_id,
> -			 vmid);
> -		r = -EFAULT;
> -		goto out;
> -	}
>   	mmap_read_lock(mm);
>   retry_write_locked:
>   	mutex_lock(&svms->lock);
> @@ -3173,9 +3203,11 @@ void svm_range_list_fini(struct kfd_process *p)
>   	/*
>   	 * Ensure no retry fault comes in afterwards, as page fault handler will
>   	 * not find kfd process and take mm lock to recover fault.
> +	 * stop kfd page fault handing, then wait pending page faults got drained
>   	 */
> -	atomic_inc(&p->svms.drain_pagefaults);
> +	atomic_set(&p->svms.stop_pf_recovery, 1);
>   	svm_range_drain_retry_fault(&p->svms);
> +	atomic_set(&p->svms.stop_pf_recovery, 0);
>   
>   	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>   		svm_range_unlink(prange);
> @@ -3197,7 +3229,7 @@ int svm_range_list_init(struct kfd_process *p)
>   	mutex_init(&svms->lock);
>   	INIT_LIST_HEAD(&svms->list);
>   	atomic_set(&svms->evicted_ranges, 0);
> -	atomic_set(&svms->drain_pagefaults, 0);
> +	atomic_set(&svms->stop_pf_recovery, 0);
>   	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
>   	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
>   	INIT_LIST_HEAD(&svms->deferred_range_list);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 70c1776611c4..5f447c3642cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   			    bool clear);
>   void svm_range_vram_node_free(struct svm_range *prange);
>   int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
> -			    uint32_t vmid, uint32_t node_id, uint64_t addr,
> +			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
>   			    bool write_fault);
>   int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
>   void svm_range_add_list_work(struct svm_range_list *svms,


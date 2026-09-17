Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB09BC982D2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 08:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD56510EB8A;
	Thu, 17 Sep 2026 08:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="lIrUxQZg";
	dkim-atps=neutral
Received: from smtpout6.mo536.mail-out.ovh.net
 (smtpout6.mo536.mail-out.ovh.net [51.210.91.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0966110EB4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 08:11:54 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hlpPg5wrtz89CG;
 Thu, 17 Sep 2026 08:11:51 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Honglei1.Huang@amd.com>; Thu, 17 Sep 2026 08:11:51 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.99])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hlpPg4vplz62JM;
 Thu, 17 Sep 2026 08:11:51 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.5])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 2817B941B5F; 
 Thu, 17 Sep 2026 08:11:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0055d837a82-0426-4257-af6f-77cd9cfdfe22,
 650D0FE7600BD4EF9823C8E076A8C250B225FC78) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <c8a06dbe-682f-47ec-94b3-63af888be3c4@pixelcluster.dev>
Date: Thu, 17 Sep 2026 10:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: rework eviction lock handling into
 critical section v2
To: christian.koenig@amd.com, Honglei1.Huang@amd.com,
 timur.kristof@gmail.com, amd-gfx@lists.freedesktop.org
References: <20260911164801.50175-1-christian.koenig@amd.com>
 <20260911164801.50175-2-christian.koenig@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <20260911164801.50175-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11585228569598779892
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFiE/6xFJy4hD9SxS4KGfNVhSfQ5pvKSuf+mWAWI8eRdmwCKWWGwhlFu+aFRErL/gT+q2jb0r+tNNnpEwvceNq7iCZ7WQ9tEv3CICpYlztVoZkndK1VaEAai2JXC8rvpNhfFHG45s6w7ro+gofckni6ELkVq2Y1y7c/Fg/EA9dXSZ++FkLkYwe9+TQfBwKOb885CM+zfYq4a+XH9kazRHoUS7SutVat6ntJxctiXnzMJTU0npFpLN1vH5bUHlaybR1EWH2dJjHK1aZf+fd7i290EjZHnU8ujYXHP8KieKvMBwMe7nnl7D7+ik+3scM/lIXLWvHU0lr2een5sG2V1FBLR+tAsfVCOq+bu76YGRI8KfjdoIi2IgcgyoplzrlZEA+I2K6XZpyZCLiyfVTPAeYWcrKPhxBF+xZcGxHlohulf9qnBDZWFMwUyL3NgSH9yETJPjqgulvDhbfrWJhBpPj76cHN5L32Htwy2/JH7vdKNPhqdRXQ+AWYSuigw30WjEbbBBaUZpCmSvWcFeE+xTJpTaZSu+M7SskSD6KF7j/FMppNdJnQ77xD5A1P/8LWhzWn2MSZfM0t4SklwbgTu0zmw+I3LB5ISVTkKh1GdP++ubJlJqUx698Y24RMA6jXdh18Si5NQJ9TUr9zqumyfr42z6rM6UpYig+TQXMpqI9gcg
DKIM-Signature: a=rsa-sha256; bh=coFvzp1VXiuZL8PPvbjADSxmSdzgZKsCrvqPsSv2Zxc=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1789632712; v=1;
 b=lIrUxQZgr/HtqOYyGx7FcYNsgSTS8Aqo73oX/KCfMK2ySC1gKjpCMIRsXBNPriTyImlPVeLy
 A2uubDm80ItVnY29fbFY7kb2NZ9Pj1hEvxexgho0SMU0uOeitrduCrX80lXlwqWmKNKJ85qIBSf
 rIasU6HAc0t9NxQ8ueIze8mxIanVhhHFlmYJnwFl3qCBS5Hy8SO5Ob63xAKt6h0AJPaNfaSGSme
 vUYHX4yjChCL8LskuJ0E5WCNOvpAnUyRKngsFnFnRwCY72AhbzfHGCK05ZIW7zjIZbMjdj+M7ZG
 jwe4x/0FF3Vpu/W1drf+/y26Mdbuu+jv/XrZhsn5qqFBw==
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

Hi,

On 9/11/26 18:48, Christian König wrote:
> Taking the eviction lock is actually just one step which we need to do
> in the critical section handling.
> 
> Rename the functions to reflect that, use the update parameters instead of the
> vm to save the GFP flags.
> 
> v2: rebased and reordered
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 21 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 41 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 35 ++++++++--------
>   4 files changed, 63 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7ced26c9c651b..67dc7da1a02fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1169,11 +1169,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	if (vm->evicting) {
> -		r = -EBUSY;
> +	r = amdgpu_vm_begin_critical(&params);
> +	if (r)
>   		goto error_free;
> -	}
>   
>   	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
> @@ -1257,7 +1255,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   error_free:
>   	kfree(tlb_cb);
> -	amdgpu_vm_eviction_unlock(vm);
> +	amdgpu_vm_end_critical(&params);
>   	drm_dev_exit(idx);
>   	return r;
>   }
> @@ -3044,6 +3042,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   			    u32 vmid, u32 node_id, uint64_t addr,
>   			    uint64_t ts, bool write_fault)
>   {
> +	struct amdgpu_vm_update_params params;
>   	bool is_compute_context = false;
>   	struct drm_exec exec;
>   	uint64_t value, flags;
> @@ -3117,6 +3116,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unlock;
>   	}
>   
> +	memset(&params, 0, sizeof(params));
> +	params.adev = adev;
> +	params.vm = vm;
> +	params.immediate = true;
> +
> +	r = amdgpu_vm_begin_critical(&params);
> +	if (r)
> +		goto error_end_critical;
> +
>   	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
>   				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
>   	if (r)
> @@ -3124,6 +3132,9 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   
>   	r = amdgpu_vm_update_pdes(adev, vm, true);
>   
> +error_end_critical:
> +	amdgpu_vm_end_critical(&params);
> +
>   error_unlock:
>   	drm_exec_fini(&exec);
>   	if (r < 0)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 0f6634b749746..98cdd7e3475fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -289,7 +289,6 @@ struct amdgpu_vm {
>   	 */
>   	struct mutex		eviction_lock;
>   	bool			evicting;
> -	unsigned int		saved_flags;
>   
>   	/* Memory statistics for this vm, protected by stats_lock */
>   	spinlock_t		stats_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index ca86eaac75235..77f3942d9533b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h

It's not shown in the diff here, but the comment above
amdgpu_vm_update_params.vm suggests that the VM is an optional
parameter, which, IIUC, isn't the case anymore. The "optional" should
probably be removed from the comment

This small nitpick aside, the series looks good to me.

Reviewed-by: Natalie Vock <nat@pixelcluster.dev>

Best,
Natalie

> @@ -93,6 +93,11 @@ struct amdgpu_vm_update_params {
>   	 */
>   	bool override_pte;
>   
> +	/**
> +	 * @saved_flags: Saved flags for GFP reduction.
> +	 */
> +	unsigned int saved_flags;
> +
>   	/**
>   	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
>   	 */
> @@ -126,21 +131,37 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params);
>   int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   
> -/*
> - * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> - * happens while holding this lock anywhere to prevent deadlocks when
> - * an MMU notifier runs in reclaim-FS context.
> +/**
> + * amdgpu_vm_begin_critical - start the critical section of the update
> + * @p: The update parameters
> + *
> + * Serialize all updates, check parameters and make sure that memory allocations
> + * don't enter the reclaim path so that we don't deadlock with MMU notifiers.
> + *
> + * Returns:
> + *
> + * 0 on success or a negative error code on failure.
> + * Even on error amdgpu_vm_end_critical() must still be called to clean up!
>    */
> -static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
>   {
> -	mutex_lock(&vm->eviction_lock);
> -	vm->saved_flags = memalloc_noreclaim_save();
> +	mutex_lock(&p->vm->eviction_lock);
> +	p->saved_flags = memalloc_noreclaim_save();
> +	if (p->vm->evicting)
> +		return -EBUSY;
> +	return 0;
>   }
>   
> -static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +/**
> + * amdgpu_vm_end_critical - end the critical section of the update
> + * @p: The update parameters
> + *
> + * Restore the GFP flags and drop the lock.
> + */
> +static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
>   {
> -	memalloc_noreclaim_restore(vm->saved_flags);
> -	mutex_unlock(&vm->eviction_lock);
> +	memalloc_noreclaim_restore(p->saved_flags);
> +	mutex_unlock(&p->vm->eviction_lock);
>   }
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 1cdf2b854f261..3f78202a60585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -505,51 +505,49 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   /**
>    * amdgpu_vm_pt_alloc - Allocate a specific page table
>    *
> - * @adev: amdgpu_device pointer
> - * @vm: VM to allocate page tables for
> + * @p: see amdgpu_vm_update_params definition
>    * @cursor: Which page table to allocate
> - * @immediate: use an immediate update
>    *
>    * Make sure a specific page table or directory is allocated.
>    *
>    * Returns:
> - * 1 if page table needed to be allocated, 0 if page table was already
> - * allocated, negative errno if an error occurred.
> + *
> + * 0 on success or a negative error code on failure.
>    */
> -static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
> -			      struct amdgpu_vm *vm,
> -			      struct amdgpu_vm_pt_cursor *cursor,
> -			      bool immediate)
> +static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
> +			      struct amdgpu_vm_pt_cursor *cursor)
>   {
>   	struct amdgpu_vm_bo_base *entry = cursor->entry;
>   	struct amdgpu_bo *pt_bo;
>   	struct amdgpu_bo_vm *pt;
> -	int r;
> +	int r, r2;
>   
>   	if (entry->bo)
>   		return 0;
>   
> -	amdgpu_vm_eviction_unlock(vm);
> -	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
> -				vm->root.bo->xcp_id);
> -	amdgpu_vm_eviction_lock(vm);
> +	amdgpu_vm_end_critical(p);
> +	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
> +				&pt, p->vm->root.bo->xcp_id);
> +	r2 = amdgpu_vm_begin_critical(p);
>   	if (r)
>   		return r;
> +	if (r2)
> +		return r2;
>   
>   	/* Keep a reference to the root directory to avoid
>   	 * freeing them up in the wrong order.
>   	 */
>   	pt_bo = &pt->bo;
>   	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
> -	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> -	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
> +	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
> +	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
>   	if (r)
>   		goto error_free_pt;
>   
>   	return 0;
>   
>   error_free_pt:
> -	if (vm->is_npa)
> +	if (p->vm->is_npa)
>   		amdgpu_bo_unpin(pt_bo);
>   	amdgpu_bo_unref(&pt_bo);
>   	return r;
> @@ -838,8 +836,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			/* make sure that the page tables covering the
>   			 * address range are actually allocated
>   			 */
> -			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
> -					       &cursor, params->immediate);
> +			r = amdgpu_vm_pt_alloc(params, &cursor);
>   			if (r)
>   				return r;
>   		}


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B5606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Efiyede6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7608B10EA1A;
	Wed, 11 Nov 2026 13:48:10 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A111810FB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=Tua4iDYtXKFEZlaKcU1t+tiFHCUIeTFJsm8r+Qdrog0=; t=1794401766; 
 x=2109761766; b=Efiyede6bqeY9F1LlIiBKhaMgKNnjOQYuSM3uui6UI4sqmTTeJhgb3b+dxFYd
 sp/PuO0b9NxL6DMwEwfP3gGR1iy+iQ4JJQXW9ntsG/HraUg8DzLti2M/6SJ0BCNx2c9G8TFdH4zKq
 51tiuCk6UCKWiwYCBzzyl71d3s8DmKJc4UeaIrOIyy55WqUr7ojsERMvzoRcLIc6QfriRCzlomsZv
 uQ+QGcyfZGPvIrUcpQZVhxYLweL/Ng5oCaK3CYzMApfmnjd/SzcWoc7k6Vif4SQ66BuvNc2w/roj0
 aihLxG3SG/3gmlHJK+Xo0oNgIOwPxPls9pfFEYQsGDvsNUWzdA==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xR7rw-008pJs-DO; Wed, 11 Nov 2026 13:56:04 +0100
Date: Wed, 11 Nov 2026 09:56:01 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: "Mu, Zihao" <Zihao.Mu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [RFC PATCH v2 5/6] drm/amdgpu: restart VM updates around
 page-table allocation
Message-ID: <avRl4ajLaCSa8AeG@quatroqueijos.cascardo.eti.br>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572521248CDB7B929017A539E712@MW3PR12MB4572.namprd12.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR12MB4572521248CDB7B929017A539E712@MW3PR12MB4572.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:48:09 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 11:55:58AM +0000, Mu, Zihao wrote:
> From: Zihao Mu <zmu@amd.com>
> 
> Page-table allocation drops the VM eviction lock and can introduce new
> move dependencies. End the current update phase before that allocation,
> then prepare a new phase after creating and clearing the table.
> 
> Preserve the original sync across each prepare. An empty SDMA phase may
> be freed before allocation, so its job cannot be relied on to carry
> those dependencies into the resumed phase.
> 
> Transfer the nested clear's internal completion to the outer context as
> well. If a subsequent prepare fails, range finalization still orders
> the TLB work after the already submitted clear, including immediate
> submissions that do not expose a public output fence.
> 
> Leave a successfully cleared table installed when prepare fails, and
> keep the existing fast return for already allocated tables. The earlier
> cleanup patches handle failed initialization and partial range work.
> No PDE iteration or output-fence policy is changed here.
> 
> Signed-off-by: Zihao Mu <zmu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 8 +++++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f76459f8312..7d85e5e74c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1206,6 +1206,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.vm = vm;
>  	params.immediate = immediate;
>  	params.pages_addr = pages_addr;
> +	params.sync = sync;
>  	params.unlocked = unlocked;
>  	params.needs_flush = flush_tlb;
>  	params.override_pte = allow_override && adev->gmc.override_pte;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 71fc1fffaa6..df1aaa00603 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -82,6 +82,11 @@ struct amdgpu_vm_update_params {
>  	 */
>  	struct dma_fence *last_update;
>  
> +	/**
> +	 * @sync: original dependencies to preserve across prepare calls
> +	 */
> +	struct amdgpu_sync *sync;
> +
>  	/**
>  	 * @num_dw_left: number of dw left for the IB
>  	 */

Similarly, we might want to use the same job ID, so here is my proposal,
whcih should go before this patch (and then prepare needs to drop its job
id parameter).


From 05a61399d6bcddb3eb75786e25e88221e70afdfd Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 10 Nov 2026 20:16:17 -0300
Subject: [PATCH] drm/amdgpu: pass job id as part of amdgpu_vm_update_params

Jobs may be allocated not only during prepare step, but also during the
update step. Also, in case we might want to call prepare again after a
commit when dropping the lock, we want to use the same original job ID.
So make it part of the update params instead of a parameter for prepare
only.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c      | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c       | 4 ++--
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e0..2e95f182db838 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1054,9 +1054,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	params.adev = adev;
 	params.vm = vm;
 	params.immediate = immediate;
+	params.k_job_id = AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES;
 
-	r = vm->update_funcs->prepare(&params, NULL,
-				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
+	r = vm->update_funcs->prepare(&params, NULL);
 	if (r)
 		goto error;
 
@@ -1207,6 +1207,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.needs_flush = flush_tlb;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
+	params.k_job_id = AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE;
 
 	r = amdgpu_vm_begin_critical(&params);
 	if (r)
@@ -1220,8 +1221,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		dma_fence_put(tmp);
 	}
 
-	r = vm->update_funcs->prepare(&params, sync,
-				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
+	r = vm->update_funcs->prepare(&params, sync);
 	if (r)
 		goto error_free;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index d03b9bbe20c7c..dd62fef0ca164 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -43,14 +43,12 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
  *
  * @p: see amdgpu_vm_update_params definition
  * @sync: sync obj with fences to wait on
- * @k_job_id: the id for tracing/debug purposes
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
-				 struct amdgpu_sync *sync,
-				 u64 k_job_id)
+				 struct amdgpu_sync *sync)
 {
 	if (!sync)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 8ebb0b033291e..c6e4469bebef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -102,12 +102,17 @@ struct amdgpu_vm_update_params {
 	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
 	 */
 	struct list_head tlb_flush_waitlist;
+
+	/**
+	 * @k_job_id: job id to use for this update.
+	 */
+	u64 k_job_id;
 };
 
 struct amdgpu_vm_update_funcs {
 	int (*map_table)(struct amdgpu_bo_vm *bo);
 	int (*prepare)(struct amdgpu_vm_update_params *p,
-		       struct amdgpu_sync *sync, u64 k_job_id);
+		       struct amdgpu_sync *sync);
 	int (*update)(struct amdgpu_vm_update_params *p,
 		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e26..856ea8bedb64b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -398,9 +398,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.adev = adev;
 	params.vm = vm;
 	params.immediate = immediate;
+	params.k_job_id = AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR;
 
-	r = vm->update_funcs->prepare(&params, NULL,
-				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
+	r = vm->update_funcs->prepare(&params, NULL);
 	if (r)
 		goto exit;
 
-- 
2.47.3


> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index bdd06b7718c..e42af004dc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -531,6 +531,11 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  	if (entry->bo)
>  		return 0;
>  
> +	/* Allocation may introduce new move dependencies. End this phase. */
> +	r = p->vm->update_funcs->commit(p, NULL);
> +	if (r)
> +		return r;
> +
>  	amdgpu_vm_end_critical(p);
>  	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
>  				&pt, p->vm->root.bo->xcp_id);
> @@ -556,7 +561,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  		return r;
>  	}
>  
> -	return 0;
> +	return p->vm->update_funcs->prepare(p, p->sync,
> +					 AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
>  
>  error_unpin:
>  	if (p->vm->is_npa)
> -- 
> 2.43.0
> 

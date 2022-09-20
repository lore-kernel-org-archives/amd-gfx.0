Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABEAC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 15:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4C410E1F2;
	Tue, 20 Sep 2022 15:43:51 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D295F10E1F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 15:43:48 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id y3so7226663ejc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=XZH3sOtxMqCbCYZLxDYqkeoTXBd3dUc3TWzs/zJdQU4=;
 b=AbHuJgKZllSd5NOUaI/rky5FdZeeDaI1P3/ddlRhPkfRUGZhr+UHduexeprtgkP/aQ
 SasxvJdzx0DmfCPqGrh2stT/POKQmrssGUhj+whSfRG/kknBrbYpnPuE/4bt/B18IVvA
 k8UEdvSe4XlP/vL/uIdyTNSR3i07YYb4Nh7jXVHANUwH6fqnFySi87jZz2vHT2XWJgl5
 ba+glZWitv39hT1Yy80JRDrshxKWiDS97TPTFRmzEZXCrDfptjxB1RXojgzB02OoIR4O
 yRxRnzU3ckzPqumd25e70E8+kkfjg8lPaXlWoWliUZLEzAhsIsTLyhdePgGPRrWY6JT+
 GpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=XZH3sOtxMqCbCYZLxDYqkeoTXBd3dUc3TWzs/zJdQU4=;
 b=RiBjuwIa7NKfBIBb51Vj9lSAaroQZN3tXU9cgziy+kHYhpbfuA3l5PoLiTzugxsCYC
 0ZD64NVksya3qkjWo5IMKt94/C7hDTLHI5IluzhhohH0gMc32/PdygWoT/OxokO0Nums
 eX5z/1raBrGw6G3NkjCguF7l31YSPOLnuFOykeR5ta67remeA5Wv0l4iFxLJo2WwLLVo
 VzFp/N8OYBN9p/m0zcsgYNMm2XAuYxOI5gV+StOOwFToxPTTcJqm7criea8NOrpEUzBm
 NhpX1mpmNxbRpt0NnfIj/573c/+rVoAFtpw6+adOVr+7p5opTKf5VZQ3VByrqbVg6/TZ
 tljg==
X-Gm-Message-State: ACrzQf0FNTz4UwOL85r4d7MHQaQX/bymRe6qGtKwMLkScPgTTC9u5RcT
 783ErScH6bkuEqd1/zsSFIq+TwGUEOc=
X-Google-Smtp-Source: AMsMyM5j0U5cVDl9JHX23dHHBNiEz4ofJzkUIKgbKpajwIxDNeuWcd2/PLWIXscKh12RI5+JZC1VfQ==
X-Received: by 2002:a17:907:6e8f:b0:77f:d1d3:2d3e with SMTP id
 sh15-20020a1709076e8f00b0077fd1d32d3emr17639958ejc.398.1663688627137; 
 Tue, 20 Sep 2022 08:43:47 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:5d7a:5aa0:dc39:535d?
 ([2a02:908:1256:79a0:5d7a:5aa0:dc39:535d])
 by smtp.gmail.com with ESMTPSA id
 14-20020a170906310e00b00773c60c2129sm19641ejx.141.2022.09.20.08.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Sep 2022 08:43:46 -0700 (PDT)
Message-ID: <11b8c39b-e710-2dfb-0ad1-4e9927421c2b@gmail.com>
Date: Tue, 20 Sep 2022 17:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 7/7] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220919171553.11286-1-Philip.Yang@amd.com>
 <20220919171553.11286-8-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220919171553.11286-8-Philip.Yang@amd.com>
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
Cc: felix.kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 19.09.22 um 19:15 schrieb Philip Yang:
> Free page table BO from vm resv unlocked context generate below
> warnings.
>
> Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
> pass vm resv unlock status from page table update caller, and add vm_bo
> entry to vm->pt_freed list and schedule the pt_free_work if calling with
> vm resv unlocked.
>
> WARNING: CPU: 12 PID: 3238 at
> drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
> Call Trace:
>   amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>   amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>   amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>   amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>   svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>   svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>   unmap_vmas+0x9d/0x140
>   unmap_region+0xa8/0x110
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

With Felix comments fixed. Reviewed-by: Christian König 
<christian.koenig@amd.com> for the entire series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 +++++++++++++++++++++--
>   3 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b2e96682b9bb..83b0c5d86e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2055,6 +2055,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> +	INIT_LIST_HEAD(&vm->pt_freed);
> +	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   
>   	/* create scheduler entities for page table updates */
>   	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
> @@ -2256,6 +2258,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> +	flush_work(&vm->pt_free_work);
> +
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index e6dd112d865c..83acb7bd80fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -278,6 +278,10 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> +	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> +	struct list_head	pt_freed;
> +	struct work_struct	pt_free_work;
> +
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> @@ -473,6 +477,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
>   int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_free_work(struct work_struct *work);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 61a4b7182d44..358b91243e37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -644,6 +644,27 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +void amdgpu_vm_pt_free_work(struct work_struct *work)
> +{
> +	struct amdgpu_vm_bo_base *entry, *next;
> +	struct amdgpu_vm *vm;
> +	LIST_HEAD(pt_freed);
> +
> +	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> +
> +	spin_lock(&vm->status_lock);
> +	list_splice_init(&vm->pt_freed, &pt_freed);
> +	spin_unlock(&vm->status_lock);
> +
> +	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
> +	amdgpu_bo_reserve(vm->root.bo, true);
> +
> +	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> +		amdgpu_vm_pt_free(entry);
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +}
> +
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -655,11 +676,24 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>    */
>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   				  struct amdgpu_vm *vm,
> -				  struct amdgpu_vm_pt_cursor *start)
> +				  struct amdgpu_vm_pt_cursor *start,
> +				  bool unlocked)
>   {
>   	struct amdgpu_vm_pt_cursor cursor;
>   	struct amdgpu_vm_bo_base *entry;
>   
> +	if (unlocked) {
> +		spin_lock(&vm->status_lock);
> +		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> +			list_move(&entry->vm_status, &vm->pt_freed);
> +
> +		if (start)
> +			list_move(&start->entry->vm_status, &vm->pt_freed);
> +		spin_unlock(&vm->status_lock);
> +		schedule_work(&vm->pt_free_work);
> +		return;
> +	}
> +
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>   		amdgpu_vm_pt_free(entry);
>   
> @@ -676,7 +710,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
>   /**
> @@ -969,7 +1003,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor);
> +							      &cursor,
> +							      params->unlocked);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}


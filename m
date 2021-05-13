Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2757CC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A066140C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A066140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8526E85B;
	Thu, 13 May 2021 08:05:56 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F516E85B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 08:05:55 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id n25so30024359edr.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=9XzHmduEOJGuA8UVlIX9D3Rz0riElb3r2Af2v8GzjCk=;
 b=l5iU89dJI0hx8B+oYQBz1/VYU76R9bMLX26sZpJeGU/xdigVvulUKxmOq5vVrxYBUk
 fD/gToiOzXknLd01mHLM+Pq68udyLtkz1jZ4erV8qbtndA7M08OpdWpXclVQ1e3TDOEU
 0Xex4n8xfANoSe6TaeZ5fh5iHNVw3emikjO64byZ9EOEu1ZvZ0IqE1cAa2Xgg2fXsmTP
 uUhoLJgPL+bZpit7boCpOMOWJoQQwFh8q+q+ktarhiXmnwNbsYLGa/5jRsp+m6AeyaKa
 Gg4LBHer1aNHxSMkjlyJruX/VjtP3eDnugpHUCG7AN7nZTcZ7y57wufTrsTlzGyXrb15
 bgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9XzHmduEOJGuA8UVlIX9D3Rz0riElb3r2Af2v8GzjCk=;
 b=owRO+nZJqvvcMYk5C0tZxuIv9LPE4qjt6v9pY2aVqBUm7XyRHYej4kJLWJBVPWHSQm
 aH+q/gyK4/EpjEdX5iyvUbKauDM6hykLPQpCrjaI9CKQ/ILl3tvCFVVmNA5FmEQia2i1
 EGds4joDOmUUdgKgJguSiGMpc3PCWMmzVL4uMEthqKPQAKEUn20NigQX+T9wZGxmMc9N
 HHT03DXTie8MIzUlF6DtSp8VmqGHywDnt51MQTRuHskZLlTEQeyJe3J4yPMmHpdhtdM5
 G8ISPpJH1ttPgn7qmQnxlIUrMhsjGT2x4YtuopGL1KqcLzhJivrdf/niBk+Y0RanSps7
 7lSQ==
X-Gm-Message-State: AOAM531jzM34iSgJdX0st/M9rolCa+A+PgiL8kfEtpIpha2kEtgSvNhU
 Rfpe+nsmEvijA3VIwcleu05jgPrQrFY=
X-Google-Smtp-Source: ABdhPJz9r+49MPq8biC+95NF8get3W+Tc49Zpz3cPFrYI8flsJCd2wFILgQbTBSUeA5YMyJBhpr5GA==
X-Received: by 2002:a05:6402:d05:: with SMTP id
 eb5mr48412788edb.6.1620893154230; 
 Thu, 13 May 2021 01:05:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc?
 ([2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc])
 by smtp.gmail.com with ESMTPSA id s4sm1821556edq.96.2021.05.13.01.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 01:05:53 -0700 (PDT)
Subject: Re: [PATCH v2] drm/amdgpu: flush TLB if valid PDE turns into PTE
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512123451.25900-1-Philip.Yang@amd.com>
 <20210512184342.13149-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e0d5b569-bf51-4656-8512-3d1cf56aeae1@gmail.com>
Date: Thu, 13 May 2021 10:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512184342.13149-1-Philip.Yang@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 12.05.21 um 20:43 schrieb Philip Yang:
> Mapping huge page, 2MB aligned address with 2MB size, uses PDE0 as PTE.
> If previously valid PDE0, PDE0.V=1 and PDE0.P=0 turns into PTE, this
> requires TLB flush, otherwise page table walker will not read updated
> PDE0.
>
> Change page table update mapping to return free_table flag to indicate
> the previously valid PDE may have turned into a PTE if page table is
> freed.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 +++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 12 ++++++++++--
>   3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3dcdcc9ff522..f9c00b451a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1583,6 +1583,8 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			while (cursor.pfn < frag_start) {
>   				amdgpu_vm_free_pts(adev, params->vm, &cursor);
>   				amdgpu_vm_pt_next(adev, &cursor);
> +				if (params->free_table)
> +					*params->free_table = true;

Make the value a bool in the params structure and copy it to the input 
variable in the upper level function and rename it to something like 
"table_freed" instead.

Apart from that looks good to me.

Christian.

>   			}
>   
>   		} else if (frag >= shift) {
> @@ -1610,6 +1612,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>    * @nodes: array of drm_mm_nodes with the MC addresses
>    * @pages_addr: DMA addresses to use for mapping
>    * @fence: optional resulting fence
> + * @free_table: return true if page table is freed
>    *
>    * Fill in the page table entries between @start and @last.
>    *
> @@ -1624,7 +1627,8 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   				uint64_t flags, uint64_t offset,
>   				struct drm_mm_node *nodes,
>   				dma_addr_t *pages_addr,
> -				struct dma_fence **fence)
> +				struct dma_fence **fence,
> +				bool *free_table)
>   {
>   	struct amdgpu_vm_update_params params;
>   	enum amdgpu_sync_mode sync_mode;
> @@ -1637,6 +1641,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	params.immediate = immediate;
>   	params.pages_addr = pages_addr;
>   	params.unlocked = unlocked;
> +	params.free_table = free_table;
>   
>   	/* Implicitly sync to command submissions in the same VM before
>   	 * unmapping. Sync to moving fences before mapping.
> @@ -1879,7 +1884,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   						resv, mapping->start,
>   						mapping->last, update_flags,
>   						mapping->offset, nodes,
> -						pages_addr, last_update);
> +						pages_addr, last_update, NULL);
>   		if (r)
>   			return r;
>   	}
> @@ -2090,7 +2095,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
>   						resv, mapping->start,
>   						mapping->last, init_pte_value,
> -						0, NULL, NULL, &f);
> +						0, NULL, NULL, &f, NULL);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> @@ -3428,7 +3433,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	}
>   
>   	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
> -					addr, flags, value, NULL, NULL,
> +					addr, flags, value, NULL, NULL, NULL,
>   					NULL);
>   	if (r)
>   		goto error_unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ea60ec122b51..41a55b035cda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -231,6 +231,11 @@ struct amdgpu_vm_update_params {
>   	 * @num_dw_left: number of dw left for the IB
>   	 */
>   	unsigned int num_dw_left;
> +
> +	/**
> +	 * @free_table: return true if page table is freed when updating
> +	 */
> +	bool *free_table;
>   };
>   
>   struct amdgpu_vm_update_funcs {
> @@ -404,7 +409,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   				uint64_t flags, uint64_t offset,
>   				struct drm_mm_node *nodes,
>   				dma_addr_t *pages_addr,
> -				struct dma_fence **fence);
> +				struct dma_fence **fence, bool *free_table);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b665e9ff77e3..4f28052d44bf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1084,7 +1084,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
>   					   start, last, init_pte_value, 0,
> -					   NULL, NULL, fence);
> +					   NULL, NULL, fence, NULL);
>   }
>   
>   static int
> @@ -1137,12 +1137,15 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
>   {
>   	struct amdgpu_bo_va bo_va;
> +	bool free_table = false;
> +	struct kfd_process *p;
>   	uint64_t pte_flags;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>   		 prange->last);
>   
> +	p = container_of(prange->svms, struct kfd_process, svms);
>   	if (prange->svm_bo && prange->ttm_res) {
>   		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
>   		prange->mapping.bo_va = &bo_va;
> @@ -1159,7 +1162,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   					prange->mapping.offset,
>   					prange->ttm_res ?
>   						prange->ttm_res->mm_node : NULL,
> -					dma_addr, &vm->last_update);
> +					dma_addr, &vm->last_update,
> +					&free_table);
>   	if (r) {
>   		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
>   		goto out;
> @@ -1175,6 +1179,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (fence)
>   		*fence = dma_fence_get(vm->last_update);
>   
> +	if (free_table)
> +		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
> +						  p->pasid);
> +
>   out:
>   	prange->mapping.bo_va = NULL;
>   	return r;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

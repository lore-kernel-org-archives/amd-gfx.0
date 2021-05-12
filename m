Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD1C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 12:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD6C6109E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 12:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD6C6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359CD6EB95;
	Wed, 12 May 2021 12:38:08 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2926EB93
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 12:38:07 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id t4so34817734ejo.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=xDsigUUFOdaJ56zT7u22wwrD572cys0nYvdmi++SHzc=;
 b=H8xYcpfg7pt1psB/onebY3kw8VOsgI0gsdy+IifOYqk3ymHfknKebY3xgE/MJEmxhU
 60VLTaQWEtPcCUZHqZFU9w/FXuMD32qRpCiw/yvDkvytGszdw/z99Mw1+Fj0RD8tARw+
 9SGQU/4pZFJCMqIOcA6pV/KjtBVNIhMcGu5x1OQmoKObeugwlOKYfyRdeGTQtynGPfZy
 bGaCjA1dyYkhFZNXGydZiuNpIA0Vbd5bayJiM+5NJZSZMtmqW+Cv6Cu4RYx7PjO9DrxD
 5IcWFrjTXwflkh5Ybuzpdg3OxCEve+EmQKvHdck6leAjnZxa9UeM0z9iDUMtIzn/OwI5
 ZbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xDsigUUFOdaJ56zT7u22wwrD572cys0nYvdmi++SHzc=;
 b=pLW9gYXsxCUN8geVKJT95pOSqIJJJb/BoG13BuQR5LPRGNeMxLZGmYu8GIQsdUK0pi
 d/Xo8/G31tZlgsRTvU3PkR8jPuv05H3tD741SFiq+FYUW/IqthcOks4IZq+Zm1Pm8GsR
 Sa/lFTAXN/poSPJBeXRYVy1m394Bf4YkPkkuu5AOC/5JvsFmYefkoGXokE2XkCH+Yjx3
 m9bfBpFvoXczGVg/KcYH9yVeC9p7LZZmeON/NheG1vGfVGDNjSOP62Tvj8hjD6lPFNhs
 66PbI6IvWBkSuaD8EHWsVZzMbnJg+c4647J4XBTU203onybGFAgD1J5dGI8kF7EiInfr
 Xd1A==
X-Gm-Message-State: AOAM532TApukalIDrSk2PfL3zT3dMytVK/vMFf8mFk90H6Y8AydzxRT4
 xQ3n+FPAO5MGHK+djgzPRjLOQ41cm10=
X-Google-Smtp-Source: ABdhPJy+lOyKjz7vlm1wnH1sKpgdxfSgTRooP68EC93VNZzOib1FGZzkegLGuzuM4dQBVAncw6b+DQ==
X-Received: by 2002:a17:906:6a93:: with SMTP id
 p19mr38003238ejr.319.1620823086321; 
 Wed, 12 May 2021 05:38:06 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c533:38e4:26b8:d73?
 ([2a02:908:1252:fb60:c533:38e4:26b8:d73])
 by smtp.gmail.com with ESMTPSA id l11sm17088056eds.75.2021.05.12.05.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 05:38:06 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: flush TLB if valid PDE turns into PTE
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512123451.25900-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6fd68338-f7b9-5ffc-70e7-45920149bfcf@gmail.com>
Date: Wed, 12 May 2021 14:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512123451.25900-1-Philip.Yang@amd.com>
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



Am 12.05.21 um 14:34 schrieb Philip Yang:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 12 ++++++++++--
>   3 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3dcdcc9ff522..27418f9407f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1457,7 +1457,7 @@ static void amdgpu_vm_fragment(struct amdgpu_vm_update_params *params,
>    */
>   static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   				 uint64_t start, uint64_t end,
> -				 uint64_t dst, uint64_t flags)
> +				 uint64_t dst, uint64_t flags, bool *free_table)

Please put that flag into the params structure instead.

Christian.

>   {
>   	struct amdgpu_device *adev = params->adev;
>   	struct amdgpu_vm_pt_cursor cursor;
> @@ -1583,6 +1583,8 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			while (cursor.pfn < frag_start) {
>   				amdgpu_vm_free_pts(adev, params->vm, &cursor);
>   				amdgpu_vm_pt_next(adev, &cursor);
> +				if (free_table)
> +					*free_table = true;
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
> @@ -1721,7 +1725,8 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   		}
>   
>   		tmp = start + num_entries;
> -		r = amdgpu_vm_update_ptes(&params, start, tmp, addr, flags);
> +		r = amdgpu_vm_update_ptes(&params, start, tmp, addr, flags,
> +					  free_table);
>   		if (r)
>   			goto error_unlock;
>   
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
> index ea60ec122b51..f61c20b70b79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -404,7 +404,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
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

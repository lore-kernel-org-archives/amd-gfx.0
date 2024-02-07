Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87A4C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 14:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7289710EDF8;
	Wed,  7 Feb 2024 14:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hmYDDt94";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3F210EDF8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 14:47:07 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-40ff28388a6so6334635e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Feb 2024 06:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707317226; x=1707922026; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G7bMSZCPksJ9wkAoSKhjByAwbRrlLP/P3we2+f+hUt0=;
 b=hmYDDt94iGRYIh97SMDkzmfF4OVZdIYTkji+2WcVRAjQGozz/HwDtVIE7Cxc0UswcB
 CcIMSBybX3fRePd2gK/CWR1fg1FDRvyICK8fO4Gfa9fsYL+4qteov8M3dwwBtEe1Uou5
 FIHPIgvfniQnKi9L4FFYPDXrJrymEv18vqug8VTaJ1IcrADE6hC4DiZmIDavYRzVxvds
 pRW8LuD2nZ43AHB9cxXectYnEoq4kVZWyR6wc7wNKpY0tW23gaQnyickhEzfuz4zQy/F
 7FL0ZM6XkgsNCVM1uywi0so7rQpTlM8E4WVmoUQC416I325s5egQlvIKhKXYgyHI4Fh2
 43zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707317226; x=1707922026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G7bMSZCPksJ9wkAoSKhjByAwbRrlLP/P3we2+f+hUt0=;
 b=LmHIeE0cjiIXLa7BEZiZCGtjx+LrB4hB4Jx2aAWohEyr7W36NTqFaW8VqFrAHKBnRd
 vP1hhfM8bk+kUvns+2VftJjKypgXOoq1M/45HWZUfzKXApPwpB5E0Y3yCmCUVklw6tdB
 oJXc6HzOYdTDW98oCtcmtO77qiMsC0UrxtbvMgZpMAuMohrTLsHQ4gh/b9ZFX7Uo4C00
 25z1hvVYrnDSE1kgBKz+9tzba2B6js4DodjKTd6zYnn82oczU7ifrOfgU1KuU2mpJ6m3
 YcZotUPbz2+jMX2iMKdkXRVReIwa83VkgiRfy9hRoqExE94Pi73F7obKMSzi99bLvR0b
 M4Ag==
X-Gm-Message-State: AOJu0Yxq6HausxJzRO2GzBhfIc2s5MBwjABIhb2f+C+PIOA6VcJ1e8kt
 Mk5EC2a4/OQbWUfRyuNubNzW9J7fbrXewCyClcBChHov1/cBmUFyOmy5ngB6
X-Google-Smtp-Source: AGHT+IGeDkGcloQh8p0biaLVrXOwGT7OUtJk/c9NfColdL4PmubnclezPmtO8BM8X/BpokijPtlIzQ==
X-Received: by 2002:adf:a1cb:0:b0:33b:1fb3:ad60 with SMTP id
 v11-20020adfa1cb000000b0033b1fb3ad60mr3599754wrv.1.1707317225555; 
 Wed, 07 Feb 2024 06:47:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUoypUm6007G7kJNmeq8s9FGWMz1OXpguCmYmFQBaVcgxSj0RTsdmEHfrAy0EoC332c7kKgzuuzQvVPN1Fd+bIg6clR11yJsc7sQUAblf9uS7wrudQaQSbBfXSrIx9kqdJu6vlt6PoU
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g2-20020adff3c2000000b00337d5cd0d8asm1655700wrp.90.2024.02.07.06.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 06:47:05 -0800 (PST)
Message-ID: <1186fa59-49a3-4dea-b19b-125543631f0c@gmail.com>
Date: Wed, 7 Feb 2024 15:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Unmap only clear the page table leaves
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20240201165017.29789-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240201165017.29789-1-Philip.Yang@amd.com>
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

Am 01.02.24 um 17:50 schrieb Philip Yang:
> SVM migration unmap pages from GPU and then update mapping to GPU to
> recover page fault. Currently unmap clears the PDE entry for range
> length >= huge page and free PTB bo, update mapping to alloc new PT bo.
> There is race bug that the freed entry bo maybe still on the pt_free
> list, reused when updating mapping and then freed, leave invalid PDE
> entry and cause GPU page fault.

Well that race here is not clear to me. Can you explain more what's 
going on and why we should change the VM code to avoid this situation?

>
> By setting the update to clear only one PDE entry or clear PTB, to
> avoid unmap to free PTE bo. This fixes the race bug and improve the
> unmap and map to GPU performance. Update mapping to huge page will
> still free the PTB bo.

I would only do this if we don't have any other way to clean this up 
since that is a really ugly workaround for this issue.

Regards,
Christian.

>
> With this change, the vm->pt_freed list and work is not needed. Add
> WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap to free the
> PTB.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43 ++++++-----------------
>   3 files changed, 10 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 82e5fd66a10d..3bde77dfc63f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2256,8 +2256,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> -	INIT_LIST_HEAD(&vm->pt_freed);
> -	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   	INIT_KFIFO(vm->faults);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
> @@ -2446,8 +2444,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> -	flush_work(&vm->pt_free_work);
> -
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_set_pasid(adev, vm, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index cdb61f1e7c35..74fe211b9ecd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -316,10 +316,6 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> -	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> -	struct list_head	pt_freed;
> -	struct work_struct	pt_free_work;
> -
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..a3d609655ce3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -657,27 +657,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> -void amdgpu_vm_pt_free_work(struct work_struct *work)
> -{
> -	struct amdgpu_vm_bo_base *entry, *next;
> -	struct amdgpu_vm *vm;
> -	LIST_HEAD(pt_freed);
> -
> -	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> -
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->pt_freed, &pt_freed);
> -	spin_unlock(&vm->status_lock);
> -
> -	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
> -	amdgpu_bo_reserve(vm->root.bo, true);
> -
> -	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> -		amdgpu_vm_pt_free(entry);
> -
> -	amdgpu_bo_unreserve(vm->root.bo);
> -}
> -
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -696,17 +675,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>   	struct amdgpu_vm_pt_cursor cursor;
>   	struct amdgpu_vm_bo_base *entry;
>   
> -	if (unlocked) {
> -		spin_lock(&vm->status_lock);
> -		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -			list_move(&entry->vm_status, &vm->pt_freed);
> -
> -		if (start)
> -			list_move(&start->entry->vm_status, &vm->pt_freed);
> -		spin_unlock(&vm->status_lock);
> -		schedule_work(&vm->pt_free_work);
> -		return;
> -	}
> +	WARN_ON(unlocked);
>   
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>   		amdgpu_vm_pt_free(entry);
> @@ -1009,7 +978,15 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
> -		entry_end = ((uint64_t)mask + 1) << shift;
> +
> +		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> +			/*
> +			 * Unmap to clear one PDE entry, to avoid unmap to free
> +			 * PTB using pt_free work which has race condition.
> +			 */
> +			entry_end = 1ULL << shift;
> +		else
> +			entry_end = ((uint64_t)mask + 1) << shift;
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   


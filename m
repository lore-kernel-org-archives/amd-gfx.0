Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477ECC6FA83
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 10:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D6B10E36B;
	Mon, 12 Sep 2022 10:22:58 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE97510E36B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 10:22:55 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id lc7so19127645ejb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=mMpGD6pBXpsqxFQ1Oas3TIn08pk0av7LahZ6TS3PWa0=;
 b=LeehE9s17bbu8qWo51Nx1EhV4kLmG+YapHpZPW88jkKbeLR8rjCPkVK8znLVbclO1B
 qXSOLbqCpKVQzLjlp8D17RqXtIMnORMNdyrxSvijWUXzcPiTZ7uMcLMcLZSVtjLOL4Vz
 ngt5O3xHA/yd4pMYrtAVINdxO5Vr7AeM5glMpUFRhdh3JIfY+6+XtrS0n2LFGY7ULbrS
 u6fuzsWZtR1QmSf5Cc/SEdz40HuPboP8UMzENKMdBo4t+y9Md0INJ2VXOWOXaF2mZadj
 T8K0ZyhjivsHHcKnivyIXJOURDM1ACbvo01jUiVyZPRjRFUjKNKsgo8dJ5His5UH16xO
 KoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=mMpGD6pBXpsqxFQ1Oas3TIn08pk0av7LahZ6TS3PWa0=;
 b=zCrcJwDPml6QjMJvmNQhzJ9v74vInVvmdLiADWgNXzcXI256ge3ngloNxOcjI11qHl
 xG8jNb7XpGQFyWbmd03xtmzPgkixvKLR7lehDJRIfLas1DLhudqZrdr1U8rAdOemhBVt
 RrOeJqXeULc/hCR48l7BfwwkmbCt4hVkRP3AFN2JAWtbuv33PhLj0hzDfk0e/A2IdBNe
 +sfTw1CjZrQskA5uyVTQ2p1+hq9YI0WPCk3dLauVVAxikdbPsbtyZiBFhhqiyHMc3Iy+
 wSGDy0qFwEvmkq2rO6NyB7rqn9ay3pbRsbw8wXuxi4xEjdFc3w0r8XbOsF+l9WqV2ZhQ
 9Ipw==
X-Gm-Message-State: ACgBeo0v9xDBOCRrfrSJjJt9nqv+DxmZc8Luf7DYXeVGbT+JMny8WjkV
 gqf1xvkG/1brFNm4O15EhJSdUbapAsA=
X-Google-Smtp-Source: AA6agR6K764f8CEpapWLw2UHQBJC7PHl5Nazwx/Ud4ikUTBsi4ghchKaFpEPDc0Ka0arhFNNOKqkLQ==
X-Received: by 2002:a17:907:16a6:b0:73d:de5f:8b22 with SMTP id
 hc38-20020a17090716a600b0073dde5f8b22mr18379761ejc.261.1662978174054; 
 Mon, 12 Sep 2022 03:22:54 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:cb75:ba2a:b78d:9ea5?
 ([2a02:908:1256:79a0:cb75:ba2a:b78d:9ea5])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a05640217c100b0044ec76521a1sm5496578edy.55.2022.09.12.03.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Sep 2022 03:22:53 -0700 (PDT)
Message-ID: <d00251a6-dae3-2b42-7c26-71fee4a06fe5@gmail.com>
Date: Mon, 12 Sep 2022 12:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220909182502.13995-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220909182502.13995-1-Philip.Yang@amd.com>
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
Cc: felix.kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.09.22 um 20:25 schrieb Philip Yang:
> Free page table BO from vm resv unlocked context generate below
> warnings.
>
> Add a free_work in vm_bo base of each page table BO, pass vm resv
> unlock status from page table update caller, and schedule the
> work if calling with vm resv unlocked.
>
>   WARNING: CPU: 12 PID: 3238 at
>   drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
>   Call Trace:
>    amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
>    amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
>    amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
>    amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
>    svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
>    svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1cd/0x230
>    unmap_vmas+0x9d/0x140
>    unmap_region+0xa8/0x110
>
>   WARNING: CPU: 0 PID: 1475 at
>   drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
>   Call Trace:
>    dma_resv_iter_first+0x43/0xa0
>    amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>    amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>    amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>    svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>    svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>    __mmu_notifier_invalidate_range_start+0x1d3/0x230
>    unmap_vmas+0x140/0x150
>    unmap_region+0xa8/0x110
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 40 +++++++++++++++++++----
>   2 files changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..ac7cd2c738e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -150,6 +150,9 @@ struct amdgpu_vm_bo_base {
>   
>   	/* protected by the BO being reserved */
>   	bool				moved;
> +
> +	/* work to free pt bo if vm resv is not hold */
> +	struct work_struct              free_work;

Oh, this is a pretty clear NAK. We can't increase the size of this struct.

Instead just come up with a single worker in the VM and a new state for 
the page tables.

Regards,
Christian.

>   };
>   
>   /* provided by hw blocks that can write ptes, e.g., sdma */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 88de9f0d4728..e6f6d7e6368f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -37,6 +37,8 @@ struct amdgpu_vm_pt_cursor {
>   	unsigned int level;
>   };
>   
> +static void amdgpu_vm_pt_free_work(struct work_struct *work);
> +
>   /**
>    * amdgpu_vm_pt_level_shift - return the addr shift for each level
>    *
> @@ -607,6 +609,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   	pt_bo = &pt->bo;
>   	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
>   	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> +	INIT_WORK(&entry->free_work, amdgpu_vm_pt_free_work);
>   	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
>   	if (r)
>   		goto error_free_pt;
> @@ -624,23 +627,46 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>    *
>    * @entry: PDE to free
>    */
> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool unlocked)
>   {
>   	struct amdgpu_bo *shadow;
>   
>   	if (!entry->bo)
>   		return;
> +
> +	if (unlocked) {
> +		schedule_work(&entry->free_work);
> +		return;
> +	}
> +
>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	if (shadow) {
>   		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>   		amdgpu_bo_unref(&shadow);
>   	}
>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
> +
>   	entry->bo->vm_bo = NULL;
>   	list_del(&entry->vm_status);
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> +static void amdgpu_vm_pt_free_work(struct work_struct *work)
> +{
> +	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_bo *root;
> +
> +	entry = container_of(work, struct amdgpu_vm_bo_base, delayed_work);
> +
> +	root = amdgpu_bo_ref(entry->vm->root.bo);
> +	amdgpu_bo_reserve(root, true);
> +
> +	amdgpu_vm_pt_free(entry, true);
> +
> +	amdgpu_bo_unreserve(root);
> +	amdgpu_bo_unref(&root);
> +}
> +
>   /**
>    * amdgpu_vm_pt_free_dfs - free PD/PT levels
>    *
> @@ -652,16 +678,17 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
>   	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
> -		amdgpu_vm_pt_free(entry);
> +		amdgpu_vm_pt_free(entry, unlocked);
>   
>   	if (start)
> -		amdgpu_vm_pt_free(start->entry);
> +		amdgpu_vm_pt_free(start->entry, unlocked);
>   }
>   
>   /**
> @@ -673,7 +700,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>    */
>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
> +	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>   }
>   
>   /**
> @@ -966,7 +993,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				if (cursor.entry->bo) {
>   					params->table_freed = true;
>   					amdgpu_vm_pt_free_dfs(adev, params->vm,
> -							      &cursor);
> +							      &cursor,
> +							      params->unlocked);
>   				}
>   				amdgpu_vm_pt_next(adev, &cursor);
>   			}


Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA61C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 12:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DF760202
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 12:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DF760202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EFD6E314;
	Wed,  3 Mar 2021 12:04:31 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893E36E314
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 12:04:30 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id d13so24553531edp.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=X2wzwnLDDvDdns01wCw2kHPnyByaYAkAdf8n+ICNWP8=;
 b=ALzbNqq2hpAFgmRbL+5ee1Y/1bpKJCtbBeZbWS1lkkP9vmQZ2oDxSiZI26GeDuKnpH
 sipQ2zUs/RXBeFgYuTXDZFO1kQxALvYct8XG4KVx3Zp8NDBX9Iq2Mn7AlFX1dPYAvN9M
 kIuFbKMd08JxC5QEs5lofrH9VN1eYo+bbXXDNXhcgfgukbhc1A8oLgjn38NSKmn5u1SF
 u9ryyL7/yMhCByK8Mu+U1is9a3RHxdt/8FgpfoJpLiFbBgiblqn+IJB9OLreXo88EGrv
 QP47OVMuXekQGx4imoLpzU/3XdsPwEeMjaEvjgVYBnPmH2s/GhIplE0Gyp3o5lbvI7Dw
 HFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=X2wzwnLDDvDdns01wCw2kHPnyByaYAkAdf8n+ICNWP8=;
 b=bIHvfY+r734fcxjKhNBdABrguxhiT2lY9jAH52BV95LeDMhCNdHbnCyQSNFSEU/TIT
 SrGlK7/9Hgv4MXld7Poas1WM8nVSeCrm+SSSpy9RPCUdN/QnS7OhSMb7Uz1CdOI87lJB
 71KHxJ4G2ZRNh6Vfu87Sh/M5ykcB1luC1XhZ/V1T8mDZ5B8FlYMjU8gkdHuqJUwTEZwq
 VmNHWKI09ccfnMCoox2DULB97Y8YKUI0ovOLsBftdmXC1YCrUkjSgIWOMMWFbUBlGweQ
 OrQU0f0+NSR65Z1MylKt9I55HyuNEYVd6d6v2WAiObPXIGWrD8kVS2uiLZUICBwF7XUv
 Tdgw==
X-Gm-Message-State: AOAM531cILVQfrDcS8PQ4vXM3Ai0xZkufG5e5KZosvyL8vw0QTT1A1W1
 q5Rupul0bwb0eSfNcadsYPT9q35WeKPEyg==
X-Google-Smtp-Source: ABdhPJw5LYetAHdQg+VEWBco8xs90iyGfWHEFbla9ZQM16Q3Xs1tFJyJ3YKGwBzURaV/VcCrcMcZzg==
X-Received: by 2002:aa7:cf17:: with SMTP id a23mr10426774edy.30.1614773069166; 
 Wed, 03 Mar 2021 04:04:29 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:fea4:8409:66bb:aad2?
 ([2a02:908:1252:fb60:fea4:8409:66bb:aad2])
 by smtp.gmail.com with ESMTPSA id sb4sm18698518ejb.71.2021.03.03.04.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Mar 2021 04:04:28 -0800 (PST)
Subject: Re: [PATCH v2 3/3] drm/amdgpu: drm/amdkfd: add amdgpu_kfd_bo struct
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com,
 Felix.Kuehling@amd.com
References: <20210303092550.110816-1-nirmoy.das@amd.com>
 <20210303092550.110816-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <93d5ce90-c0ba-09bd-dea1-e41f13c288d2@gmail.com>
Date: Wed, 3 Mar 2021 13:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303092550.110816-3-nirmoy.das@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.03.21 um 10:25 schrieb Nirmoy Das:
> Implement a new struct based on amdgpu_bo base class
> for BOs created by kfd device so that kfd related memeber
> of amdgpu_bo can be moved there.

You should probably restructure which patch has which code in it here.

The first one adds the general infrastructure and makes the necessary 
modification to allow allocating BO structures with different structure 
size.

And the second then adds the amdgpu_kfd_bo structure so that the KFD can 
use it.

You should also double check with Felix if we don't support importing 
BOs from elsewhere here and if that approach is correct.

Regards,
Christian.

>
> v2: rename AMDGPU_GEM_USER_KFD -> AMDGPU_GEM_CREATE_KFD
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 10 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 32 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  8 ++++-
>   4 files changed, 40 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 57798707cd5f..1f52ae4de609 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1152,6 +1152,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	struct sg_table *sg = NULL;
>   	uint64_t user_addr = 0;
>   	struct amdgpu_bo *bo;
> +	struct amdgpu_kfd_bo *kbo;
>   	struct amdgpu_bo_param bp;
>   	u32 domain, alloc_domain;
>   	u64 alloc_flags;
> @@ -1227,17 +1228,20 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	bp.flags = alloc_flags;
>   	bp.type = bo_type;
>   	bp.resv = NULL;
> -	ret = amdgpu_kfd_bo_create(adev, &bp, &bo);
> +	ret = amdgpu_kfd_bo_create(adev, &bp, &kbo);
>   	if (ret) {
>   		pr_debug("Failed to create BO on domain %s. ret %d\n",
>   				domain_string(alloc_domain), ret);
>   		goto err_bo_create;
>   	}
> +
> +	bo = &kbo->bo;
>   	if (bo_type == ttm_bo_type_sg) {
>   		bo->tbo.sg = sg;
>   		bo->tbo.ttm->sg = sg;
>   	}
> -	bo->kfd_bo = *mem;
> +
> +	kbo->kfd_bo = *mem;
>   	(*mem)->bo = bo;
>   	if (user_addr)
>   		bo->flags |= AMDGPU_AMDKFD_USERPTR_BO;
> @@ -1261,7 +1265,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>
>   allocate_init_user_pages_failed:
>   	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_kfd_bo_unref(&kbo);
>   	/* Don't unreserve system mem limit twice */
>   	goto err_reserve_limit;
>   err_bo_create:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index 1da67cf812b1..eaaf4940abcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -102,6 +102,7 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
>   				     unsigned long cur_seq)
>   {
>   	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
> +	struct amdgpu_kfd_bo *kbo = container_of(bo, struct amdgpu_kfd_bo, bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>
>   	if (!mmu_notifier_range_blockable(range))
> @@ -111,7 +112,7 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
>
>   	mmu_interval_set_seq(mni, cur_seq);
>
> -	amdgpu_amdkfd_evict_userptr(bo->kfd_bo, bo->notifier.mm);
> +	amdgpu_amdkfd_evict_userptr(kbo->kfd_bo, bo->notifier.mm);
>   	mutex_unlock(&adev->notifier_lock);
>
>   	return true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1b41b4870c99..787eb99119a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -551,8 +551,10 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>
>   	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
>   				       sizeof(struct amdgpu_bo));
> +	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
> +		bp->bo_ptr_size = sizeof(struct amdgpu_bo);
>
> -	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
> +	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
>   	if (bo == NULL)
>   		return -ENOMEM;
>   	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
> @@ -714,35 +716,37 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>
>   int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
>   			 struct amdgpu_bo_param *bp,
> -			 struct amdgpu_bo **bo_ptr)
> +			 struct amdgpu_kfd_bo **kfd_bo_ptr)
>   {
> +	struct amdgpu_bo *bo_ptr;
>   	u64 flags = bp->flags;
>   	int r;
>
>   	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
>   	bp->flags = bp->flags | AMDGPU_GEM_CREATE_KFD;
> -	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
> +	bp->bo_ptr_size = sizeof(struct amdgpu_kfd_bo);
> +	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
>   	if (r)
>   		return r;
>
> +	*kfd_bo_ptr = (struct amdgpu_kfd_bo *)bo_ptr;
>   	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
>   		if (!bp->resv)
> -			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
> +			WARN_ON(dma_resv_lock((*kfd_bo_ptr)->bo.tbo.base.resv,
>   							NULL));
>
> -		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
> +		r = amdgpu_bo_create_shadow(adev, bp->size, &(*kfd_bo_ptr)->bo);
>
>   		if (!bp->resv)
> -			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
> +			dma_resv_unlock((*kfd_bo_ptr)->bo.tbo.base.resv);
>
>   		if (r)
> -			amdgpu_bo_unref(bo_ptr);
> +			amdgpu_kfd_bo_unref(kfd_bo_ptr);
>   	}
>
>   	return r;
>   }
>
> -
>   /**
>    * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>    * @bo: pointer to the buffer object
> @@ -910,6 +914,18 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
>   	*bo = NULL;
>   }
>
> +void amdgpu_kfd_bo_unref(struct amdgpu_kfd_bo **kbo)
> +{
> +	struct ttm_buffer_object *tbo;
> +
> +	if ((*kbo) == NULL)
> +		return;
> +
> +	tbo = &((*kbo)->bo.tbo);
> +	ttm_bo_put(tbo);
> +	*kbo = NULL;
> +}
> +
>   /**
>    * amdgpu_bo_pin_restricted - pin an &amdgpu_bo buffer object
>    * @bo: &amdgpu_bo buffer object to be pinned
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 665ee0015f06..fa98a1fe2574 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -43,6 +43,8 @@ struct amdgpu_bo_param {
>   	u32				domain;
>   	u32				preferred_domain;
>   	u64				flags;
> +	/* size of a subclass using amdgpu_bo as base class */
> +	u32				bo_ptr_size;
>   	enum ttm_bo_type		type;
>   	bool				no_wait_gpu;
>   	struct dma_resv	*resv;
> @@ -109,7 +111,10 @@ struct amdgpu_bo {
>   #endif
>
>   	struct list_head		shadow_list;
> +};
>
> +struct amdgpu_kfd_bo {
> +	struct amdgpu_bo		bo;
>   	struct kgd_mem                  *kfd_bo;
>   };
>
> @@ -247,7 +252,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   		     struct amdgpu_bo **bo_ptr);
>   int amdgpu_kfd_bo_create(struct amdgpu_device *adev,
>   			 struct amdgpu_bo_param *bp,
> -			 struct amdgpu_bo **bo_ptr);
> +			 struct amdgpu_kfd_bo **bo_ptr);
>   int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>   			      unsigned long size, int align,
>   			      u32 domain, struct amdgpu_bo **bo_ptr,
> @@ -266,6 +271,7 @@ void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
>   void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
>   struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);
>   void amdgpu_bo_unref(struct amdgpu_bo **bo);
> +void amdgpu_kfd_bo_unref(struct amdgpu_kfd_bo **kbo);
>   int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain);
>   int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   			     u64 min_offset, u64 max_offset);
> --
> 2.30.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

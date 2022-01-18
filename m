Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 14:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAB810E5F4;
	Tue, 18 Jan 2022 14:10:21 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C9110E5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 14:10:20 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 l35-20020a05600c1d2300b0034d477271c1so4355932wms.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=QR1T8RZaPNaT+ouPcJMHCp6pX0dBFBeYBT0qKrghqJw=;
 b=q2yElCeyunwy+xUsyLkxEWY1xlanemMk0kb98/+OYm6/agyD0bhfPzTGtGqjhBnEJr
 7Nh9ED3NPHNwdYPtOwYwKFunssPX9E5P9A9RVfvPcHBWvYx2vWaxXPLruVyRyWQ5OGi/
 dM1P22IQXwDfTN28fSoQtTepemkaPACTReF/BjEz38fao9HgZy2KJhxBXmwEXRdyYtM2
 n3UZiTQZ8zPK8NqS+6Q23jOlTrz5YA6awlD8IgRlJTTWboXVjyjXQykOU+GB5hZ3HnE0
 oNIlkn/LnO1VM/9nm7ekvjbJ0VjhF9FXqW5Sgqg3kJkljkt3+/ua4QY1s490PwcI8dqe
 a0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QR1T8RZaPNaT+ouPcJMHCp6pX0dBFBeYBT0qKrghqJw=;
 b=QYeLXyGul6/Rxb+5vHAehRwu0vqJ7Elpd0ePUOwSBn7gh0+AGaqEP5Nl8Tkg0tais2
 X9eaixlxQvCKgToZu0tty7TIw8569feqLmdqtOr4EYaYMay3Y8R+gxKSDJjWqq2i3EkU
 JqpU4P4jmf1ttUzSHoQIqqw4aEqt9rmNbUXhXzesNfsohrQr8HAYpLTbeb+BgOV8vRFw
 ek+bCRGeht56b+GrJnKcw3ke9o6/l9M6AtGD+Khc2drgPwvQIVctUMUt0L/XUS9+lZlT
 ij8LN2V736Qf4RFwLEPNLyI704Hxmg55f/hhRT1vvbK2L9eFA9krDuzZLQSl3BpD2WU6
 lEHw==
X-Gm-Message-State: AOAM532FdbjaKFHj95qqxdesk0wspCUPdHiIJPViLqf4Ywno+xcrOqmI
 rdYkQkRBVA7GU1DPqoPwRPzsifn9Fns=
X-Google-Smtp-Source: ABdhPJxO7Jar+s2RbDEVy7fXScUJ+apq5UXLUuFwPjqOf78BYLt7sVVDo5QmyTJYPJwmPwBaBbfEWw==
X-Received: by 2002:a05:600c:4f0b:: with SMTP id
 l11mr9012432wmq.112.1642515019263; 
 Tue, 18 Jan 2022 06:10:19 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:6333:dba2:34ad:c3d6?
 ([2a02:908:1252:fb60:6333:dba2:34ad:c3d6])
 by smtp.gmail.com with ESMTPSA id j16sm16772963wrp.76.2022.01.18.06.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 06:10:18 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220118120157.102453-1-christian.koenig@amd.com>
 <DM5PR12MB24692C6D246264672211B712F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <99b919b4-97df-16bc-46c2-682bc03117f4@gmail.com>
Date: Tue, 18 Jan 2022 15:10:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB24692C6D246264672211B712F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.01.22 um 14:28 schrieb Chen, Guchun:
> [Public]
>
> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
> -		goto skip_pin_bo;
> -
> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> -	if (r)
> -		return r;
> -
> -skip_pin_bo:
>
> Does deleting skip_pin_bo path cause bo redundant pin in SRIOV case?

Pinning/unpinning the BO was already removed as well.

See Nirmoy's patches in the git log.

Regards,
Christian.

>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Tuesday, January 18, 2022 8:02 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: remove gart.ready flag
>
> That's just a leftover from old radeon days and was preventing CS and GART bindings before the hardware was initialized. But nowdays that is perfectly valid.
>
> The only thing we need to warn about are GART binding before the table is even allocated.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 35 +++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    | 15 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  9 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 77 ++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 11 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c       |  7 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c       |  8 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  8 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 10 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  5 +-
>   11 files changed, 52 insertions(+), 137 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 645950a653a0..53cc844346f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -150,7 +150,7 @@ void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
>    * replaces them with the dummy page (all asics).
>    * Returns 0 for success, -EINVAL for failure.
>    */
> -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   			int pages)
>   {
>   	unsigned t;
> @@ -161,13 +161,11 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   	uint64_t flags = 0;
>   	int idx;
>   
> -	if (!adev->gart.ready) {
> -		WARN(1, "trying to unbind memory from uninitialized GART !\n");
> -		return -EINVAL;
> -	}
> +	if (WARN_ON(!adev->gart.ptr))
> +		return;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> -		return 0;
> +		return;
>   
>   	t = offset / AMDGPU_GPU_PAGE_SIZE;
>   	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> @@ -188,7 +186,6 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>   
>   	drm_dev_exit(idx);
> -	return 0;
>   }
>   
>   /**
> @@ -204,7 +201,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>    * Map the dma_addresses into GART entries (all asics).
>    * Returns 0 for success, -EINVAL for failure.
>    */
> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   		    int pages, dma_addr_t *dma_addr, uint64_t flags,
>   		    void *dst)
>   {
> @@ -212,13 +209,8 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   	unsigned i, j, t;
>   	int idx;
>   
> -	if (!adev->gart.ready) {
> -		WARN(1, "trying to bind memory to uninitialized GART !\n");
> -		return -EINVAL;
> -	}
> -
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> -		return 0;
> +		return;
>   
>   	t = offset / AMDGPU_GPU_PAGE_SIZE;
>   
> @@ -230,7 +222,6 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>   		}
>   	}
>   	drm_dev_exit(idx);
> -	return 0;
>   }
>   
>   /**
> @@ -246,20 +237,14 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>    * (all asics).
>    * Returns 0 for success, -EINVAL for failure.
>    */
> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   		     int pages, dma_addr_t *dma_addr,
>   		     uint64_t flags)
>   {
> -	if (!adev->gart.ready) {
> -		WARN(1, "trying to bind memory to uninitialized GART !\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!adev->gart.ptr)
> -		return 0;
> +	if (WARN_ON(!adev->gart.ptr))
> +		return;
>   
> -	return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
> -			       adev->gart.ptr);
> +	amdgpu_gart_map(adev, offset, pages, dma_addr, flags, adev->gart.ptr);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> index 78895413cf9f..8fea3e04e411 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> @@ -46,7 +46,6 @@ struct amdgpu_gart {
>   	unsigned			num_gpu_pages;
>   	unsigned			num_cpu_pages;
>   	unsigned			table_size;
> -	bool				ready;
>   
>   	/* Asic default pte flags */
>   	uint64_t			gart_pte_flags;
> @@ -58,12 +57,12 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);  void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);  int amdgpu_gart_init(struct amdgpu_device *adev);  void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev); -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
> -		       int pages);
> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> -		    int pages, dma_addr_t *dma_addr, uint64_t flags,
> -		    void *dst);
> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
> -		     int pages, dma_addr_t *dma_addr, uint64_t flags);
> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
> +			int pages);
> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
> +		     int pages, dma_addr_t *dma_addr, uint64_t flags,
> +		     void *dst);
> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
> +		      int pages, dma_addr_t *dma_addr, uint64_t flags);
>   void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);  #endif diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 9151950e0cc3..babdd915c4c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -224,26 +224,21 @@ uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>    *
>    * Re-init the gart for each known BO in the GTT.
>    */
> -int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>   {
>   	struct amdgpu_gtt_node *node;
>   	struct drm_mm_node *mm_node;
>   	struct amdgpu_device *adev;
> -	int r = 0;
>   
>   	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>   	spin_lock(&mgr->lock);
>   	drm_mm_for_each_node(mm_node, &mgr->mm) {
>   		node = container_of(mm_node, typeof(*node), base.mm_nodes[0]);
> -		r = amdgpu_ttm_recover_gart(node->tbo);
> -		if (r)
> -			break;
> +		amdgpu_ttm_recover_gart(node->tbo);
>   	}
>   	spin_unlock(&mgr->lock);
>   
>   	amdgpu_gart_invalidate_tlb(adev);
> -
> -	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b489cd8abe31..9cdb61ec669e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -246,10 +246,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>   		dma_addr_t *dma_addr;
>   
>   		dma_addr = &bo->ttm->dma_address[mm_cur->start >> PAGE_SHIFT];
> -		r = amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags,
> -				    cpu_addr);
> -		if (r)
> -			goto error_free;
> +		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
>   	} else {
>   		dma_addr_t dma_address;
>   
> @@ -257,11 +254,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>   		dma_address += adev->vm_manager.vram_base_offset;
>   
>   		for (i = 0; i < num_pages; ++i) {
> -			r = amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
> -					    &dma_address, flags, cpu_addr);
> -			if (r)
> -				goto error_free;
> -
> +			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1, &dma_address,
> +					flags, cpu_addr);
>   			dma_address += PAGE_SIZE;
>   		}
>   	}
> @@ -826,14 +820,13 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,  #endif  }
>   
> -static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
> -				struct ttm_buffer_object *tbo,
> -				uint64_t flags)
> +static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
> +				 struct ttm_buffer_object *tbo,
> +				 uint64_t flags)
>   {
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>   	struct ttm_tt *ttm = tbo->ttm;
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -	int r;
>   
>   	if (amdgpu_bo_encrypted(abo))
>   		flags |= AMDGPU_PTE_TMZ;
> @@ -841,10 +834,8 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>   	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
>   		uint64_t page_idx = 1;
>   
> -		r = amdgpu_gart_bind(adev, gtt->offset, page_idx,
> -				gtt->ttm.dma_address, flags);
> -		if (r)
> -			goto gart_bind_fail;
> +		amdgpu_gart_bind(adev, gtt->offset, page_idx,
> +				 gtt->ttm.dma_address, flags);
>   
>   		/* The memory type of the first page defaults to UC. Now
>   		 * modify the memory type to NC from the second page of @@ -853,21 +844,13 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>   		flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
>   		flags |= AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
>   
> -		r = amdgpu_gart_bind(adev,
> -				gtt->offset + (page_idx << PAGE_SHIFT),
> -				ttm->num_pages - page_idx,
> -				&(gtt->ttm.dma_address[page_idx]), flags);
> +		amdgpu_gart_bind(adev, gtt->offset + (page_idx << PAGE_SHIFT),
> +				 ttm->num_pages - page_idx,
> +				 &(gtt->ttm.dma_address[page_idx]), flags);
>   	} else {
> -		r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
> -				     gtt->ttm.dma_address, flags);
> +		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
> +				 gtt->ttm.dma_address, flags);
>   	}
> -
> -gart_bind_fail:
> -	if (r)
> -		DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
> -			  ttm->num_pages, gtt->offset);
> -
> -	return r;
>   }
>   
>   /*
> @@ -883,7 +866,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>   	struct amdgpu_ttm_tt *gtt = (void*)ttm;
>   	uint64_t flags;
> -	int r = 0;
> +	int r;
>   
>   	if (!bo_mem)
>   		return -EINVAL;
> @@ -930,14 +913,10 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>   
>   	/* bind pages into GART page tables */
>   	gtt->offset = (u64)bo_mem->start << PAGE_SHIFT;
> -	r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
> -		gtt->ttm.dma_address, flags);
> -
> -	if (r)
> -		DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
> -			  ttm->num_pages, gtt->offset);
> +	amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
> +			 gtt->ttm.dma_address, flags);
>   	gtt->bound = true;
> -	return r;
> +	return 0;
>   }
>   
>   /*
> @@ -987,12 +966,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   
>   	/* Bind pages */
>   	gtt->offset = (u64)tmp->start << PAGE_SHIFT;
> -	r = amdgpu_ttm_gart_bind(adev, bo, flags);
> -	if (unlikely(r)) {
> -		ttm_resource_free(bo, &tmp);
> -		return r;
> -	}
> -
> +	amdgpu_ttm_gart_bind(adev, bo, flags);
>   	amdgpu_gart_invalidate_tlb(adev);
>   	ttm_resource_free(bo, &bo->resource);
>   	ttm_bo_assign_mem(bo, tmp);
> @@ -1006,19 +980,16 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>    * Called by amdgpu_gtt_mgr_recover() from amdgpu_device_reset() to
>    * rebind GTT pages during a GPU reset.
>    */
> -int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	uint64_t flags;
> -	int r;
>   
>   	if (!tbo->ttm)
> -		return 0;
> +		return;
>   
>   	flags = amdgpu_ttm_tt_pte_flags(adev, tbo->ttm, tbo->resource);
> -	r = amdgpu_ttm_gart_bind(adev, tbo, flags);
> -
> -	return r;
> +	amdgpu_ttm_gart_bind(adev, tbo, flags);
>   }
>   
>   /*
> @@ -1032,7 +1003,6 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,  {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -	int r;
>   
>   	/* if the pages have userptr pinning then clear that first */
>   	if (gtt->userptr) {
> @@ -1052,10 +1022,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>   		return;
>   
>   	/* unbind shouldn't be done for GDS/GWS/OA in ttm_bo_clean_mm */
> -	r = amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
> -	if (r)
> -		DRM_ERROR("failed to unbind %u pages at 0x%08llX\n",
> -			  gtt->ttm.num_pages, gtt->offset);
> +	amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>   	gtt->bound = false;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 084aa49e627d..d9691f262f16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -119,7 +119,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>   
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);  uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr); -int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>   
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>   
> @@ -162,7 +162,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   			struct dma_fence **fence);
>   
>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo); -int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>   
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 4f8d356f8432..867c94a1a81a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1000,14 +1000,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
> -		goto skip_pin_bo;
> -
> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> -	if (r)
> -		return r;
> -
> -skip_pin_bo:
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
>   		return r;
> @@ -1033,8 +1026,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		 (unsigned)(adev->gmc.gart_size >> 20),
>   		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
>   
> -	adev->gart.ready = true;
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index cd6c38e083d0..3baece11d74e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -469,16 +469,14 @@ static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)  {
>   	uint64_t table_addr;
> -	int r, i;
>   	u32 field;
> +	int i;
>   
>   	if (adev->gart.bo == NULL) {
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> -	if (r)
> -		return r;
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>   
> @@ -558,7 +556,6 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
>   	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
>   		 (unsigned)(adev->gmc.gart_size >> 20),
>   		 (unsigned long long)table_addr);
> -	adev->gart.ready = true;
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index ab8adbff9e2d..cf83f8c258f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -613,17 +613,14 @@ static void gmc_v7_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)  {
>   	uint64_t table_addr;
> -	int r, i;
>   	u32 tmp, field;
> +	int i;
>   
>   	if (adev->gart.bo == NULL) {
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> -	if (r)
> -		return r;
> -
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>   
>   	/* Setup TLB control */
> @@ -712,7 +709,6 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
>   	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>   		 (unsigned)(adev->gmc.gart_size >> 20),
>   		 (unsigned long long)table_addr);
> -	adev->gart.ready = true;
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 054733838292..7cc7c8001734 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -837,17 +837,14 @@ static void gmc_v8_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)  {
>   	uint64_t table_addr;
> -	int r, i;
>   	u32 tmp, field;
> +	int i;
>   
>   	if (adev->gart.bo == NULL) {
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> -	if (r)
> -		return r;
> -
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>   
>   	/* Setup TLB control */
> @@ -953,7 +950,6 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>   	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>   		 (unsigned)(adev->gmc.gart_size >> 20),
>   		 (unsigned long long)table_addr);
> -	adev->gart.ready = true;
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c76ffd1a70cd..9f71f810c2f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1783,14 +1783,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
> -		goto skip_pin_bo;
> -
> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> -	if (r)
> -		return r;
> -
> -skip_pin_bo:
> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
>   		return r;
> @@ -1807,7 +1800,6 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   	DRM_INFO("PTB located at 0x%016llX\n",
>   			(unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
>   
> -	adev->gart.ready = true;
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d5d2cf2ee788..88db82b3d443 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -86,10 +86,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t npages,
>   
>   	cpu_addr = &job->ibs[0].ptr[num_dw];
>   
> -	r = amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
> -	if (r)
> -		goto error_free;
> -
> +	amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>   	r = amdgpu_job_submit(job, &adev->mman.entity,
>   			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>   	if (r)
> --
> 2.25.1


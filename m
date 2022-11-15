Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809BAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 16:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA83310E41F;
	Tue, 15 Nov 2022 16:16:42 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C2D10E41F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 16:16:39 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id y16so25122259wrt.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 08:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gGnNt03Bpg5+5N4W27rnu08RMxJJWRfMy1/3yHG+JG8=;
 b=h+aYBTYw+d0YAQy7bgV4qRJZALmUH9qi7AS68LSAD16konkYz9lscBgyaVnqNwzAKe
 1PBYwG92GHmoy/Sg4UwB9IgLVtEm3q6YZg2Ha5FS9pWJDxCZNn97jBMaT+vsrVrU5RBD
 1CB9H7GjgWkKhft/SmCloxOSwkYqflq8t+bPsMmpcw5lzzE1jzSkBV2eNu8wt20bFX/4
 P1nEMvTTq+94EewN5dxOBNkGgcoi8/H34y6fqYSW1FUIsbUbR/19EU1qWi0CdQiLR62X
 pymtWKlJkaN2fdIU4FI6vAHLGWTnSPD0PcO6ec5H3lYtCeOLoBzXT5m4Wdbkqsk6eh+x
 gDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gGnNt03Bpg5+5N4W27rnu08RMxJJWRfMy1/3yHG+JG8=;
 b=CGUMi40R90wR4UFLlAFaGKvkLuiaKLoXGtOUIHNwaoS+qy5RCBjAXaxZGRE6cscGTh
 c21puiZpwGq+UukoG7jISpYrInVmRDud08fcI6f2FyQEBhL9TRZgTDzwUjK7kwjaxiVy
 PZ1xTmk2yXzHAnoQUFjuYATB4JcA0skvhHkze6y9BYZUiuklR1Y3Duh2PbfLeGNvbb/8
 IrIWTxMx732l2UgXnXChlLsgxz9UZRnzfYlNmbqEC/3StleTsn9LUGUb9eFqeSagAuVs
 6RtEzf94Fw++033E36w/PFoyHONrCLGQ0tHuToWEboPkiwEOzF4lCsQfG45G4Nv3rELT
 CFAw==
X-Gm-Message-State: ANoB5plf1EwWUZtOu3bygY1WHCJjWleeybiZVPQIKVbsgIrhfH/9qI6I
 TiHJxMCBoLSuv3Y2EYjJc4trg7ICRYI=
X-Google-Smtp-Source: AA0mqf7NxRJ3wXjOeyY9zQqwiBjH1FjrhxCyRW1DgKvfEB285HAtvdTFnGtXMX1t0CycPkj1blwnVw==
X-Received: by 2002:adf:fa47:0:b0:22e:38b9:5d6d with SMTP id
 y7-20020adffa47000000b0022e38b95d6dmr11470693wrr.276.1668528997746; 
 Tue, 15 Nov 2022 08:16:37 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:2207:38ee:dfc8:db04?
 ([2a02:908:1256:79a0:2207:38ee:dfc8:db04])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a7bce8a000000b003c6bd12ac27sm15641978wmj.37.2022.11.15.08.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Nov 2022 08:16:37 -0800 (PST)
Message-ID: <16df2e46-acf5-638e-5938-c8753a49ec54@gmail.com>
Date: Tue, 15 Nov 2022 17:16:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/4] drm/amdgpu: fix userptr HMM range handling v2
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: amd-gfx@lists.freedesktop.org, "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20221115133853.7950-1-christian.koenig@amd.com>
 <20221115133853.7950-2-christian.koenig@amd.com>
In-Reply-To: <20221115133853.7950-2-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

FYI

Am 15.11.22 um 14:38 schrieb Christian König:
> The basic problem here is that it's not allowed to page fault while
> holding the reservation lock.
>
> So it can happen that multiple processes try to validate an userptr
> at the same time.
>
> Work around that by putting the HMM range object into the mutex
> protected bo list for now.
>
> v2: make sure range is set to NULL in case of an error
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> CC: stable@vger.kernel.org
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 12 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c   |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  8 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  6 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 53 ++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 14 +++--
>   7 files changed, 46 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c5c9bfa2772e..83659e6419a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -940,6 +940,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   	struct amdkfd_process_info *process_info = mem->process_info;
>   	struct amdgpu_bo *bo = mem->bo;
>   	struct ttm_operation_ctx ctx = { true, false };
> +	struct hmm_range *range;
>   	int ret = 0;
>   
>   	mutex_lock(&process_info->lock);
> @@ -969,7 +970,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   		return 0;
>   	}
>   
> -	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> +	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
>   	if (ret) {
>   		pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
>   		goto unregister_out;
> @@ -987,7 +988,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   	amdgpu_bo_unreserve(bo);
>   
>   release_out:
> -	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>   unregister_out:
>   	if (ret)
>   		amdgpu_mn_unregister(bo);
> @@ -2319,6 +2320,8 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   	/* Go through userptr_inval_list and update any invalid user_pages */
>   	list_for_each_entry(mem, &process_info->userptr_inval_list,
>   			    validate_list.head) {
> +		struct hmm_range *range;
> +
>   		invalid = atomic_read(&mem->invalid);
>   		if (!invalid)
>   			/* BO hasn't been invalidated since the last
> @@ -2329,7 +2332,8 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   		bo = mem->bo;
>   
>   		/* Get updated user pages */
> -		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> +		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> +						   &range);
>   		if (ret) {
>   			pr_debug("Failed %d to get user pages\n", ret);
>   
> @@ -2348,7 +2352,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   			 * FIXME: Cannot ignore the return code, must hold
>   			 * notifier_lock
>   			 */
> -			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>   		}
>   
>   		/* Mark the BO as valid unless it was invalidated
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 2168163aad2d..252a876b0725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -209,6 +209,7 @@ void amdgpu_bo_list_get_list(struct amdgpu_bo_list *list,
>   			list_add_tail(&e->tv.head, &bucket[priority]);
>   
>   		e->user_pages = NULL;
> +		e->range = NULL;
>   	}
>   
>   	/* Connect the sorted buckets in the output list. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 9caea1688fc3..e4d78491bcc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -26,6 +26,8 @@
>   #include <drm/ttm/ttm_execbuf_util.h>
>   #include <drm/amdgpu_drm.h>
>   
> +struct hmm_range;
> +
>   struct amdgpu_device;
>   struct amdgpu_bo;
>   struct amdgpu_bo_va;
> @@ -36,6 +38,7 @@ struct amdgpu_bo_list_entry {
>   	struct amdgpu_bo_va		*bo_va;
>   	uint32_t			priority;
>   	struct page			**user_pages;
> +	struct hmm_range		*range;
>   	bool				user_invalidated;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d371000a5727..7f9cedd8e157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -910,7 +910,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   			goto out_free_user_pages;
>   		}
>   
> -		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages, &e->range);
>   		if (r) {
>   			kvfree(e->user_pages);
>   			e->user_pages = NULL;
> @@ -988,9 +988,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   
>   		if (!e->user_pages)
>   			continue;
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
>   		kvfree(e->user_pages);
>   		e->user_pages = NULL;
> +		e->range = NULL;
>   	}
>   	mutex_unlock(&p->bo_list->bo_list_mutex);
>   	return r;
> @@ -1265,7 +1266,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>   		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>   
> -		r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +		r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
> +		e->range = NULL;
>   	}
>   	if (r) {
>   		r = -EAGAIN;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 111484ceb47d..91571b1324f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -378,6 +378,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct drm_amdgpu_gem_userptr *args = data;
>   	struct drm_gem_object *gobj;
> +	struct hmm_range *range;
>   	struct amdgpu_bo *bo;
>   	uint32_t handle;
>   	int r;
> @@ -418,7 +419,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   		goto release_object;
>   
>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> +						 &range);
>   		if (r)
>   			goto release_object;
>   
> @@ -441,7 +443,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   
>   user_pages_done:
>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>   
>   release_object:
>   	drm_gem_object_put(gobj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 76a8ebfc9e71..29c22a27db80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -642,9 +642,6 @@ struct amdgpu_ttm_tt {
>   	struct task_struct	*usertask;
>   	uint32_t		userflags;
>   	bool			bound;
> -#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -	struct hmm_range	*range;
> -#endif
>   };
>   
>   #define ttm_to_amdgpu_ttm_tt(ptr)	container_of(ptr, struct amdgpu_ttm_tt, ttm)
> @@ -657,7 +654,8 @@ struct amdgpu_ttm_tt {
>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
>    * once afterwards to stop HMM tracking
>    */
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +				 struct hmm_range **range)
>   {
>   	struct ttm_tt *ttm = bo->tbo.ttm;
>   	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> @@ -667,16 +665,15 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   	bool readonly;
>   	int r = 0;
>   
> +	/* Make sure get_user_pages_done() can cleanup gracefully */
> +	*range = NULL;
> +
>   	mm = bo->notifier.mm;
>   	if (unlikely(!mm)) {
>   		DRM_DEBUG_DRIVER("BO is not registered?\n");
>   		return -EFAULT;
>   	}
>   
> -	/* Another get_user_pages is running at the same time?? */
> -	if (WARN_ON(gtt->range))
> -		return -EFAULT;
> -
>   	if (!mmget_not_zero(mm)) /* Happens during process shutdown */
>   		return -ESRCH;
>   
> @@ -694,7 +691,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   
>   	readonly = amdgpu_ttm_tt_is_readonly(ttm);
>   	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
> -				       ttm->num_pages, &gtt->range, readonly,
> +				       ttm->num_pages, range, readonly,
>   				       true, NULL);
>   out_unlock:
>   	mmap_read_unlock(mm);
> @@ -712,30 +709,24 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>    *
>    * Returns: true if pages are still valid
>    */
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
> +bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> +				       struct hmm_range *range)
>   {
>   	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> -	bool r = false;
>   
> -	if (!gtt || !gtt->userptr)
> +	if (!gtt || !gtt->userptr || !range)
>   		return false;
>   
>   	DRM_DEBUG_DRIVER("user_pages_done 0x%llx pages 0x%x\n",
>   		gtt->userptr, ttm->num_pages);
>   
> -	WARN_ONCE(!gtt->range || !gtt->range->hmm_pfns,
> -		"No user pages to check\n");
> +	WARN_ONCE(!range->hmm_pfns, "No user pages to check\n");
>   
> -	if (gtt->range) {
> -		/*
> -		 * FIXME: Must always hold notifier_lock for this, and must
> -		 * not ignore the return code.
> -		 */
> -		r = amdgpu_hmm_range_get_pages_done(gtt->range);
> -		gtt->range = NULL;
> -	}
> -
> -	return !r;
> +	/*
> +	 * FIXME: Must always hold notifier_lock for this, and must
> +	 * not ignore the return code.
> +	 */
> +	return !amdgpu_hmm_range_get_pages_done(range);
>   }
>   #endif
>   
> @@ -812,20 +803,6 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>   	/* unmap the pages mapped to the device */
>   	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
>   	sg_free_table(ttm->sg);
> -
> -#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -	if (gtt->range) {
> -		unsigned long i;
> -
> -		for (i = 0; i < ttm->num_pages; i++) {
> -			if (ttm->pages[i] !=
> -			    hmm_pfn_to_page(gtt->range->hmm_pfns[i]))
> -				break;
> -		}
> -
> -		WARN((i == ttm->num_pages), "Missing get_user_page_done\n");
> -	}
> -#endif
>   }
>   
>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6a70818039dd..a37207011a69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -39,6 +39,8 @@
>   
>   #define AMDGPU_POISON	0xd0bed0be
>   
> +struct hmm_range;
> +
>   struct amdgpu_gtt_mgr {
>   	struct ttm_resource_manager manager;
>   	struct drm_mm mm;
> @@ -149,15 +151,19 @@ void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>   
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages);
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm);
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +				 struct hmm_range **range);
> +bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> +				       struct hmm_range *range);
>   #else
>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -					       struct page **pages)
> +					       struct page **pages,
> +					       struct hmm_range **range)
>   {
>   	return -EPERM;
>   }
> -static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
> +static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> +						     struct hmm_range *range)
>   {
>   	return false;
>   }


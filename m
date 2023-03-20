Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701AEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0041810E1F4;
	Mon, 20 Mar 2023 17:02:01 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29AD10E5F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:01:57 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id v1so4959906wrv.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679331716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOfKppETmGr96ojnUkRtQ2OX3aDkkQK8qNo5AfjOUxI=;
 b=FvItMgiSJM6iXJzdu6IxlQpI5uxxO9fnnEzPGkUz4Ts8HX7oeHm4R8LwnM8TMMLHBR
 ivPfAVTq5r2YM9Xhqf7jH+tyxmFRN25rUF7EwZv/LKfRkVlZbhF9/iNr9UH2yAqFJMhb
 gLrBbRnNSs5KfsPldrSQOh5P6UGY2IFvdUgNBINnSK2TAkwSlxCcQ1dr8JgjBGt8rSvN
 JYo6f/dcIHtabsU8FNGq8lESTTQsud3R1JFsEY5AZdZ9yoYnDaAIvQ3z56244kL5ZIdi
 2aDxXp89/esDJKKk1WWurlqpTzuutujY6oXHPxvxFwUO9KSOpEP2lqzZscXUW6+NNreN
 RNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679331716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lOfKppETmGr96ojnUkRtQ2OX3aDkkQK8qNo5AfjOUxI=;
 b=mAptqKoi3Ra1nJCdooYUbbT8cKbAgUBQ4FJhExfjaYSiSFB4rO0KOegInKQnvKGYpV
 Q6OzauxJa5u/yvP5oVCvpnBIeQhSsJF7s/7r84NSO1rAG4Ebm0A71CWjma4MDTnOrtN6
 ocpWPko/Xm7idKYEfOWzOQj2wDvBJ4sKEQw6Obc5Ln00DZGXs8LK0ZKvCCVDc6yf0sjH
 5eZQqpzvoJdQBS46nk1JktoXWGL3zjOKJxWvnd+U59OeDR2L5V2xGrRxS2lbyfb4xenD
 VwnFXC2HPPlQRqm7uxk+eOKujt/F0ln2GMWqjvApa30uMyD2fAaMrlY2syHopugD63VO
 m5Rw==
X-Gm-Message-State: AO0yUKXsgjqwh7UY/1PCEM04XikqDSzjkzrlrpIULPPxu0u7y7S0Pn5E
 EGa4tl5yEPJJ2AdNpe8ezyE=
X-Google-Smtp-Source: AK7set/RMOOzWtmL8nf9hqhN8vBufi/pAX3+RK8sDU5f3ZSRczr8Odk13TSX/kCzhMt4LRmyoI0F+g==
X-Received: by 2002:adf:dd4b:0:b0:2c6:e827:21c1 with SMTP id
 u11-20020adfdd4b000000b002c6e82721c1mr21997wrm.50.1679331716134; 
 Mon, 20 Mar 2023 10:01:56 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:ac09:1b0:c451:65?
 ([2a02:908:1256:79a0:ac09:1b0:c451:65])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a5d5087000000b002c55306f6edsm9321434wrt.54.2023.03.20.10.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Mar 2023 10:01:55 -0700 (PDT)
Message-ID: <7c9ae421-8bf6-4935-0e2b-fde402f2825a@gmail.com>
Date: Mon, 20 Mar 2023 18:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: improve debug VRAM access performance using
 sdma
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220104191211.1707514-1-jonathan.kim@amd.com>
 <DM6PR12MB26197A9101DD2B16D580D12AE4809@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM6PR12MB26197A9101DD2B16D580D12AE4809@DM6PR12MB2619.namprd12.prod.outlook.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I don't think so. Have we recently re-ordered something here?

Christian.

Am 20.03.23 um 08:05 schrieb Quan, Evan:
> [AMD Official Use Only - General]
>
> I happened to find the sdma_access_bo allocation from GTT seems performing before gart is ready.
> That makes the "amdgpu_gart_map" is skipped since adev->gart.ptr is still NULL.
> Is that done intentionally ?
>
> Evan
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Jonathan Kim
>> Sent: Wednesday, January 5, 2022 3:12 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: [PATCH] drm/amdgpu: improve debug VRAM access performance
>> using sdma
>>
>> For better performance during VRAM access for debugged processes, do
>> read/write copies over SDMA.
>>
>> In order to fulfill post mortem debugging on a broken device, fallback to
>> stable MMIO access when gpu recovery is disabled or when job submission
>> time outs are set to max.  Failed SDMA access should automatically fall
>> back to MMIO access.
>>
>> Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
>> page-table updates and TLB flushes on access.
>>
>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78
>> +++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  5 +-
>>   2 files changed, 82 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 367abed1d6e6..512df4c09772 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -48,6 +48,7 @@
>>   #include <drm/ttm/ttm_range_manager.h>
>>
>>   #include <drm/amdgpu_drm.h>
>> +#include <drm/drm_drv.h>
>>
>>   #include "amdgpu.h"
>>   #include "amdgpu_object.h"
>> @@ -1429,6 +1430,70 @@ static void amdgpu_ttm_vram_mm_access(struct
>> amdgpu_device *adev, loff_t pos,
>>   	}
>>   }
>>
>> +static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object
>> *bo,
>> +					unsigned long offset, void *buf, int
>> len, int write)
>> +{
>> +	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>> +	struct amdgpu_job *job;
>> +	struct dma_fence *fence;
>> +	uint64_t src_addr, dst_addr;
>> +	unsigned int num_dw;
>> +	int r, idx;
>> +
>> +	if (len != PAGE_SIZE)
>> +		return -EINVAL;
>> +
>> +	if (!adev->mman.sdma_access_ptr)
>> +		return -EACCES;
>> +
>> +	r = drm_dev_enter(adev_to_drm(adev), &idx);
>> +	if (r)
>> +		return r;
>> +
>> +	if (write)
>> +		memcpy(adev->mman.sdma_access_ptr, buf, len);
>> +
>> +	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>> +	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4,
>> AMDGPU_IB_POOL_DELAYED, &job);
>> +	if (r)
>> +		goto out;
>> +
>> +	src_addr = write ? amdgpu_bo_gpu_offset(adev-
>>> mman.sdma_access_bo) :
>> +			amdgpu_bo_gpu_offset(abo);
>> +	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
>> +			amdgpu_bo_gpu_offset(adev-
>>> mman.sdma_access_bo);
>> +	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
>> PAGE_SIZE, false);
>> +
>> +	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>> +	WARN_ON(job->ibs[0].length_dw > num_dw);
>> +
>> +	r = amdgpu_job_submit(job, &adev->mman.entity,
>> AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>> +	if (r) {
>> +		amdgpu_job_free(job);
>> +		goto out;
>> +	}
>> +
>> +	if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
>> +		r = -ETIMEDOUT;
>> +	dma_fence_put(fence);
>> +
>> +	if (!(r || write))
>> +		memcpy(buf, adev->mman.sdma_access_ptr, len);
>> +out:
>> +	drm_dev_exit(idx);
>> +	return r;
>> +}
>> +
>> +static inline bool amdgpu_ttm_allow_post_mortem_debug(struct
>> amdgpu_device *adev)
>> +{
>> +	return amdgpu_gpu_recovery == 0 ||
>> +		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>> +		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>> +		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>> +		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
>> +}
>> +
>>   /**
>>    * amdgpu_ttm_access_memory - Read or Write memory that backs a
>> buffer object.
>>    *
>> @@ -1453,6 +1518,10 @@ static int amdgpu_ttm_access_memory(struct
>> ttm_buffer_object *bo,
>>   	if (bo->resource->mem_type != TTM_PL_VRAM)
>>   		return -EIO;
>>
>> +	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
>> +			!amdgpu_ttm_access_memory_sdma(bo, offset, buf,
>> len, write))
>> +		return len;
>> +
>>   	amdgpu_res_first(bo->resource, offset, len, &cursor);
>>   	while (cursor.remaining) {
>>   		size_t count, size = cursor.size;
>> @@ -1793,6 +1862,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>   		return r;
>>   	}
>>
>> +	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>> +				AMDGPU_GEM_DOMAIN_GTT,
>> +				&adev->mman.sdma_access_bo, NULL,
>> +				adev->mman.sdma_access_ptr))
>> +		DRM_WARN("Debug VRAM access will use slowpath MM
>> access\n");
>> +
>>   	return 0;
>>   }
>>
>> @@ -1823,6 +1898,9 @@ void amdgpu_ttm_fini(struct amdgpu_device
>> *adev)
>>   	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>>   	ttm_device_fini(&adev->mman.bdev);
>>   	adev->mman.initialized = false;
>> +	if (adev->mman.sdma_access_ptr)
>> +		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo,
>> NULL,
>> +					&adev->mman.sdma_access_ptr);
>>   	DRM_INFO("amdgpu: ttm finalized\n");
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 91a087f9dc7c..b0116c4a768f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -98,6 +98,10 @@ struct amdgpu_mman {
>>   	u64		fw_vram_usage_size;
>>   	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>>   	void		*fw_vram_usage_va;
>> +
>> +	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>> +	struct amdgpu_bo	*sdma_access_bo;
>> +	void			*sdma_access_ptr;
>>   };
>>
>>   struct amdgpu_copy_mem {
>> @@ -193,5 +197,4 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct
>> amdgpu_device *adev, struct ttm_tt *ttm,
>>   int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int
>> mem_type);
>>
>>   void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>> -
>>   #endif
>> --
>> 2.25.1


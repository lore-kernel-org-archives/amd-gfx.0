Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F8CD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 12:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF82C10F0B6;
	Thu, 28 May 2026 12:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nAX0tba5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8E710F0C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nALJ0ByNFxYeaBOlDaNMX1a2K9VYmB/xSLT/lLPUKpo=; b=nAX0tba5If2+L+FTvV+ImChAyk
 aSa4LV0G+lRnxcwYtSz4iUdRrzVZiKmm7Y036KyQLVSY8GGoR06FfB8hkTVkqwRGEFifnwVP3yniW
 y312WK9PEL3GpF4PSiCbyO8p7BXtkvyHBAHckDS3dCIT2Rh09tXC+o+bThA9j4RKwGtWSyLw57v00
 zXVbFLt0Y970jX4GLEPh12lWT3628N4/v6E8/PUJa7FxW+Co3Q5K7OBmgL9ydTphK2GJuWLMzqgaV
 Kf+zFtRahCvWWeNeNM1EJiVcZaIZBtQg5cncPA7l8w+LFsTwQbxHg/8o+7A8bCqglYZtI8L1g/h5V
 3J0q7BXw==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wSZV2-009Lzl-BP; Thu, 28 May 2026 14:06:08 +0200
Message-ID: <8e520cc3-48d7-4056-903e-ed154b97c70f@igalia.com>
Date: Thu, 28 May 2026 13:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] drm/amdgpu: Extend listing of buffer handles with the
 userptr object flag
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
 <20260526160630.35562-2-tvrtko.ursulin@igalia.com>
 <50260781-195a-4f77-bd83-9209268a4e2d@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <50260781-195a-4f77-bd83-9209268a4e2d@amd.com>
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


On 27/05/2026 09:10, Christian König wrote:
> On 5/26/26 18:06, Tvrtko Ursulin wrote:
>> Add a new flag (AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR) to the
>> DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS ioctl.
>>
>> This is required to allow for checkpoint and restore of userptr objects.
>>
>> The existing struct drm_amdgpu_gem_list_handles_entry is used with the
>> userptr creation flags places in alloc_flags, while the alignment field
>> contains the userspace address.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 18 +++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 40 +++++++++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 19 +++++++++++-
>>   include/uapi/drm/amdgpu_drm.h           |  7 +++--
>>   4 files changed, 61 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 0259d81e5157..5eb8433229b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -1186,14 +1186,20 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>>   
>>   		bo_entry = &bo_entries[bo_index];
>>   
>> -		bo_entry->size = amdgpu_bo_size(bo);
>> -		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
>> -		bo_entry->preferred_domains = bo->preferred_domains;
>>   		bo_entry->gem_handle = id;
>> -		bo_entry->alignment = bo->tbo.page_alignment;
>> +		bo_entry->size = amdgpu_bo_size(bo);
>> +		if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
>> +			bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR;
>> +			bo_entry->alloc_flags = amdgpu_ttm_tt_get_userptr_flags(bo->tbo.ttm);
>> +			bo_entry->alignment = amdgpu_ttm_tt_get_userptr_addr(bo->tbo.ttm);
>> +		} else {
>> +			bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
>> +			bo_entry->preferred_domains = bo->preferred_domains;
>> +			bo_entry->alignment = bo->tbo.page_alignment;
>>   
>> -		if (bo->tbo.base.import_attach)
>> -			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
>> +			if (bo->tbo.base.import_attach)
>> +				bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
>> +		}
>>   
>>   		bo_index += 1;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 3d2e00efc741..4023c84fe29d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -767,6 +767,33 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>   	return r;
>>   }
>>   
>> +/*
>> + * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
>> + */
>> +bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>> +{
>> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>> +
>> +	if (gtt == NULL || !gtt->userptr)
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +u32 amdgpu_ttm_tt_get_userptr_flags(struct ttm_tt *ttm)
>> +{
>> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>> +
>> +	return gtt->userflags;
>> +}
>> +
>> +u64 amdgpu_ttm_tt_get_userptr_addr(struct ttm_tt *ttm)
>> +{
>> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>> +
>> +	return gtt->userptr;
>> +}
>> +
>>   #endif
>>   
>>   /*
>> @@ -1374,19 +1401,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>>   	return true;
>>   }
>>   
>> -/*
>> - * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
>> - */
>> -bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>> -{
>> -	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>> -
>> -	if (gtt == NULL || !gtt->userptr)
>> -		return false;
>> -
>> -	return true;
>> -}
>> -
>>   /*
>>    * amdgpu_ttm_tt_is_readonly - Is the ttm_tt object read only?
>>    */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index f2f23a42b3cc..8c0424577dea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -211,12 +211,30 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>   				 struct amdgpu_hmm_range *range);
>> +bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
>> +u32 amdgpu_ttm_tt_get_userptr_flags(struct ttm_tt *ttm);
>> +u64 amdgpu_ttm_tt_get_userptr_addr(struct ttm_tt *ttm);
>>   #else
>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>   					       struct amdgpu_hmm_range *range)
>>   {
>>   	return -EPERM;
>>   }
>> +
>> +static inline bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline u32 amdgpu_ttm_tt_get_userptr_flags(struct ttm_tt *ttm)
>> +{
>> +	return -1;
>> +}
>> +
>> +static inline u64 amdgpu_ttm_tt_get_userptr_addr(struct ttm_tt *ttm)
>> +{
>> +	return 0;
>> +}
>>   #endif
>>   
>>   /**
>> @@ -251,7 +269,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>>   				  unsigned long end, unsigned long *userptr);
>>   bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
>>   				       int *last_invalidated);
>> -bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
>>   bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>>   uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>>   uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 9f3090db2f16..3069560ac26e 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -836,6 +836,7 @@ struct drm_amdgpu_gem_op {
>>   };
>>   
>>   #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
>> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR	(1 << 1)
>>   
>>   struct drm_amdgpu_gem_list_handles {
>>   	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
>> @@ -851,7 +852,7 @@ struct drm_amdgpu_gem_list_handles_entry {
>>   	/* gem handle of buffer object */
>>   	__u32 gem_handle;
>>   
>> -	/* Currently just one flag: IS_IMPORT */
>> +	/* AMDGPU_GEM_LIST_HANDLES_FLAG_* */
>>   	__u32 flags;
>>   
>>   	/* Size of bo */
>> @@ -860,10 +861,10 @@ struct drm_amdgpu_gem_list_handles_entry {
>>   	/* Preferred domains for GEM_CREATE */
>>   	__u64 preferred_domains;
>>   
>> -	/* GEM_CREATE flags for re-creation of buffer */
>> +	/* GEM_CREATE flags for re-creation of buffer or drm_amdgpu_gem_userptr.flags */
>>   	__u64 alloc_flags;
>>   
>> -	/* physical start_addr alignment in bytes for some HW requirements */
>> +	/* physical start_addr alignment in bytes for some HW requirements or drm_amdgpu_gem_userptr.addr */
>>   	__u64 alignment;
> 
> Make that an union, e.g. union { __u64 alignment; __u64 userptr; }, apart looks pretty good to me.

Ack, marking as a TODO for a future respin, thank you!

Regards,

Tvrtko


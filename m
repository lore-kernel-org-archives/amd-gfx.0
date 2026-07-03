Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F72C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 10:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876EF10F762;
	Fri,  3 Jul 2026 10:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XOjpa3aG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FECF10F762
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fNX5gor7uXQwjYcir3ssWFsWItuGhQGaZhf1MTua2J4=; b=XOjpa3aGIngkkKSo1kPNpIq4Xu
 ecNuZxaW7TSqcjlJyzLunVtoUCaihKdQDhZsq2I269UHsfwfXfOJWsOitIcondnVMRzO88UpyJSi0
 M20reV0s2OEKGb47or+xLGqr2JmROrCpJI740F66oIrTmTqMXIbZnV7suUCzTZz8R/7jpSfP5Zs+p
 unEZMi8H5RIFBvqEEOkBkLGBjCmxnDKVk1vWNOkuAoL/NXKb9Nwe/XDWauNxrIsMfchS76WLJCGB4
 CtpWZQVGngpGFbxD92aIe8hnBPo+TqzB6B9ODbgmQ68lHvfDw8KyGLMXJrqMtvtG0rlfSrLD4CiOb
 SMWjkl0w==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wfayx-008RJJ-H3; Fri, 03 Jul 2026 12:18:51 +0200
Message-ID: <d0e54338-0651-4746-8f57-115e66575b6c@igalia.com>
Date: Fri, 3 Jul 2026 11:18:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/4] drm/amdgpu: Extend listing of buffer handles with
 the userptr object flag
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
 <20260623141257.66086-2-tvrtko.ursulin@igalia.com>
 <38cf3568-cdd6-46e6-960d-03c378cb0669@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <38cf3568-cdd6-46e6-960d-03c378cb0669@amd.com>
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


On 30/06/2026 13:50, Christian König wrote:
> On 6/23/26 16:12, Tvrtko Ursulin wrote:
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
>>   include/uapi/drm/amdgpu_drm.h           | 14 ++++++---
>>   4 files changed, 67 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 862fbc2e125f..e75026aba874 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -1204,14 +1204,20 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
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
>> +			bo_entry->userptr = amdgpu_ttm_tt_get_userptr_addr(bo->tbo.ttm);
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
>> index 16c060badaee..7ce9e0e194c3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -785,6 +785,33 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
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
> 
> That should actually check for usertask and not userptr.

Ack.

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
> 
> This is identical to the existing amdgpu_ttm_tt_get_userptr() function, just without error handling.
> 
> I suggest to just extend amdgpu_ttm_tt_get_userptr() to also return the flags.

Thank you, it looks like I completely missed that one exists.

Will fix both issues in next respin.

Regards,

Tvrtko

> 
> Apart from that the patch looks good to me of hand.
> 
> Regards,
> Christian.
> 
>>   #endif
>>   
>>   /*
>> @@ -1392,19 +1419,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
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
>> index 2d72fa217274..e1b3495b902f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -209,12 +209,30 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
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
>> @@ -249,7 +267,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>>   				  unsigned long end, unsigned long *userptr);
>>   bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
>>   				       int *last_invalidated);
>> -bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
>>   bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>>   uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>>   uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 9f3090db2f16..24f2dffc0789 100644
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
>> @@ -860,11 +861,16 @@ struct drm_amdgpu_gem_list_handles_entry {
>>   	/* Preferred domains for GEM_CREATE */
>>   	__u64 preferred_domains;
>>   
>> -	/* GEM_CREATE flags for re-creation of buffer */
>> +	/* GEM_CREATE flags for re-creation of buffer or drm_amdgpu_gem_userptr.flags */
>>   	__u64 alloc_flags;
>>   
>> -	/* physical start_addr alignment in bytes for some HW requirements */
>> -	__u64 alignment;
>> +	union {
>> +		/* physical start_addr alignment in bytes for some HW requirements */
>> +		__u64 alignment;
>> +
>> +		/* drm_amdgpu_gem_userptr.addr for userptr objects */
>> +		__u64 userptr;
>> +	};
>>   };
>>   
>>   #define AMDGPU_VA_OP_MAP			1
> 


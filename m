Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D71C87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 11:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D2610E444;
	Mon, 11 Aug 2025 11:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Jjw+2vVl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC26610E444
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SfBf+A/s2qszet9tHZIIsi+spdSDi51Fd375lmhNsjk=; b=Jjw+2vVliSEYGSbIVyrd2XO4MM
 an8aVp8J6rMXcBoQQnQPNDhxELPotVaKklU3Wj815Rtag01Kd7UnmcAiWjpWh6b/rSILaM2kc3XMP
 vUIaWCxO1nQudD85MBJPq3Z6UXG9cHTBLHSD/nL4X9YFrW5FiZdgHSgEr4mc9ilfIZS8pP24J+HCd
 4YlLibY8ZmYyOB6x3dwfDHu5FzrQGj7p0q9hEfw1b4NCagxayotxnPC0D9IqVUpIO4ioL0h9DeX1I
 ulnG5eDt0vRbfQPyWeEY2ToRY1x9kcME+itEH/e6DsGU68QICWv+dl0gDLXLd6Scud/urxwRsiwLC
 8kHU58qA==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ulQTv-00Ck9O-EB; Mon, 11 Aug 2025 13:14:23 +0200
Message-ID: <cbe2cc39-d09c-4def-aae0-3c28038455f4@igalia.com>
Date: Mon, 11 Aug 2025 12:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] drm/amdgpu: Add mapping info option for GEM_OP
 ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 Christian.Koenig@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250807202245.2970262-1-David.Francis@amd.com>
 <20250807202245.2970262-3-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250807202245.2970262-3-David.Francis@amd.com>
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


On 07/08/2025 21:22, David Francis wrote:
> Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
> returns a list of mappings associated with a given bo, along with
> their positions and offsets.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 96 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
>   include/uapi/drm/amdgpu_drm.h           | 18 +++++
>   3 files changed, 119 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 7f55e3b7d8a2..29ee1df37661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -956,6 +956,98 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_gem_list_mappings - get information about a buffer's mappings
> + *
> + * @gobj: gem object
> + * @args: gem_op arguments
> + * @fpriv: drm file pointer
> + *
> + * num_entries is set as an input to the size of the user-allocated array of
> + * drm_amdgpu_gem_vm_bucket stored at args->value.
> + * num_entries is sent back as output as the number of mappings the bo has.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +static int amdgpu_gem_list_mappings(struct drm_gem_object *gobj, struct amdgpu_fpriv *fpriv,
> +					  struct drm_amdgpu_gem_op *args)
> +{
> +	struct amdgpu_vm *avm = &fpriv->vm;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(avm, bo);
> +	struct drm_amdgpu_gem_vm_bucket *vm_buckets;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct drm_exec exec;
> +	int num_mappings = 0;
> +	int ret;
> +
> +	vm_buckets = kvcalloc(args->num_entries, sizeof(*vm_buckets), GFP_KERNEL);
> +	if (!vm_buckets) {
> +		ret = -ENOMEM;
> +		goto free_vms;

return -ENOMEM would be enough.

> +	}
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +			  DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		if (gobj) {
> +			ret = drm_exec_lock_obj(&exec, gobj);
> +			drm_exec_retry_on_contention(&exec);
> +			if (ret)
> +				goto unlock_exec;
> +		}
> +
> +		ret = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);

What are the two reserved fence slots for?

> +		drm_exec_retry_on_contention(&exec);
> +		if (ret)
> +			goto unlock_exec;
> +	}
> +
> +	amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {
> +			vm_buckets[num_mappings].start = mapping->start;
> +			vm_buckets[num_mappings].last = mapping->last;
> +			vm_buckets[num_mappings].offset = mapping->offset;
> +			vm_buckets[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
> +		if (num_mappings < args->num_entries) {
> +			vm_buckets[num_mappings].start = mapping->start;
> +			vm_buckets[num_mappings].last = mapping->last;
> +			vm_buckets[num_mappings].offset = mapping->offset;
> +			vm_buckets[num_mappings].flags = mapping->flags;
> +		}
> +		num_mappings += 1;
> +	}
> +
> +	drm_exec_fini(&exec);
> +
> +	if (num_mappings > 0 && num_mappings <= args->num_entries) {
> +		ret = copy_to_user((void __user *)args->value, vm_buckets, num_mappings * sizeof(*vm_buckets));
> +		if (ret) {
> +			pr_debug("Failed to copy BO information to user\n");
> +			ret = -EFAULT;
> +		}

Same comment as in the first patch - u64_to_user_pointer and I'd 
consider dropping the pr_debug path.

> +	}
> +	args->num_entries = num_mappings;
> +
> +	kvfree(vm_buckets);
> +
> +	return ret;
> +unlock_exec:
> +	drm_exec_fini(&exec);
> +free_vms:
> +	kvfree(vm_buckets);
> +
> +	return ret;

I think the success/failure exit paths could be consolidated:

	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
		...
	}

	args->num_entries = num_mappings;

	if (num_mappings > 0 && num_mappings <= args->num_entries)
		ret = copy_to_user(...);

unlock_exec:
	drm_exec_fini(&exec);
	kvfree(vm_buckets);

	return ret;

Regards,

Tvrtko

> +}
> +
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			struct drm_file *filp)
>   {
> @@ -1022,6 +1114,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   
>   		amdgpu_bo_unreserve(robj);
>   		break;
> +	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
> +		amdgpu_bo_unreserve(robj);
> +		r = amdgpu_gem_list_mappings(gobj, filp->driver_priv, args);
> +		break;
>   	default:
>   		amdgpu_bo_unreserve(robj);
>   		r = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..5a63ae490b0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>   				 struct amdgpu_vm *vm,
>   				 struct dma_fence **fence);
>   
> +#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->valids, list)
> +#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
> +		list_for_each_entry(mapping, &bo_va->invalids, list)
> +
>   #endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 218a179818d4..6b857f528823 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
>   
>   #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
>   #define AMDGPU_GEM_OP_SET_PLACEMENT		1
> +#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
> +
> +struct drm_amdgpu_gem_vm_bucket {
> +	/* Start of mapping (in number of pages) */
> +	__u64 start;
> +
> +	/* End of mapping (in number of pages) */
> +	__u64 last;
> +
> +	/* Mapping offset */
> +	__u64 offset;
> +
> +	/* flags needed to recreate mapping */
> +	__u64 flags;
> +};
>   
>   /* Sets or returns a value associated with a buffer. */
>   struct drm_amdgpu_gem_op {
> @@ -811,6 +826,9 @@ struct drm_amdgpu_gem_op {
>   	__u32	op;
>   	/** Input or return value */
>   	__u64	value;
> +	/** For MAPPING_INFO op: number of mappings (in/out) */
> +	__u32	num_entries;
> +	__u32	padding;
>   };
>   
>   #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)


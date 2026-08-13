Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA948C5AC67
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 08:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1B110E4A1;
	Thu, 13 Aug 2026 08:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mtU3dJaL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76C910E4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=jwsM0As55Mzp7tbH9BbzEDjZBwHBm+TpiHtr00HY1bg=; b=mtU3dJaLI7CN5LDHuQqKvs8etM
 eT/Q0G1EOVIz48DSLsONxOzZI956hl/mV7+zzQ3vNGyG5HxFvFjIRlSK5SBh9KrXduzPVT4lNA/X+
 Jy/O6iIdUgLybK3SGGBkpW6wzZcFB4Ac6dPwQkqV1pNlxGGeOlRS5s7YMLE0JgLx5Yl4GGS8OSyby
 gfgG7iCNyRZfhgksKJKjjA5VTDe3bNKyxvYF+wZh4f7spuEDit8MK1Sy+fcMEDnvNEq+vvkd1DQ0C
 c5bFD1mL81qj//dCdXUl3JIxsc8sHayQsnYsCh65w7Yw0UOEbAkqoX/IByYb8UZXgvJ+xZDUfSiPs
 VCsip7TQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuR05-000lay-S3; Thu, 13 Aug 2026 10:41:21 +0200
Message-ID: <3f0403ed-0de9-45af-882d-93fc98bf135c@igalia.com>
Date: Thu, 13 Aug 2026 09:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260811141202.1633727-1-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260811141202.1633727-1-David.Francis@amd.com>
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


On 11/08/2026 15:12, David Francis wrote:
> Add a new option to ioctl USERQ which provides information
> to a process about their own user queues on the queried
> device.
> 
> The returned data is in the same format as that used to
> create the queue in the first place.
> 
> The interface uses retries; the user first sends a request with
> num_entries 0, then receives the right number of entries.
> The same is done for the mqd sizes of each entry.
> 
> This operation holds both userq_mutex and the userq_xa xa_lock for
> its entire duration (including for copy_to_user, copy_from_user,
> and kvmalloc).
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 162 +++++++++++++++++++++-
>   include/uapi/drm/amdgpu_drm.h             |  39 ++++++
>   2 files changed, 198 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3fe10d6af757..3c930425c1bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -850,6 +850,8 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>   		    args->in.mqd_size)
>   			return -EINVAL;
>   		break;
> +	case AMDGPU_USERQ_OP_LIST:
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -857,6 +859,159 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>   	return 0;
>   }
>   
> +static int
> +amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct drm_amdgpu_userq_list_entry *entries;
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long queue_id;
> +	size_t mqd_size, entry_buffer_size;
> +	uint32_t num_queues = 0;
> +	int ret;
> +	int i = 0;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	xa_lock(&uq_mgr->userq_xa);
> +
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		num_queues += 1;
> +	}
> +
> +	if (num_queues != args->list_in_out.num_entries) {
> +		/**
> +		 * If the num_entries is not the number of queues,
> +		 * return the correct number. User should
> +		 * try again with the right space allocated.
> +		 */

I suggest changing to greater than. Caller is okay to allocate an 
opportunistically size buffer and have it work in one pass. Same as 
amdgpu_gem_list_handles_ioctl().

> +		args->list_in_out.num_entries = num_queues;
> +		xa_unlock(&uq_mgr->userq_xa);
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return 0;
> +	}
> +	if (num_queues == 0) {
> +		xa_unlock(&uq_mgr->userq_xa);
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return 0;
> +	}
> +
> +	entries = kvmalloc_objs(typeof(*entries), num_queues, GFP_KERNEL);

GFP_KERNEL under xa_lock will not work.

If you look at amdgpu_gem_list_handles_ioctl() and also how I have done 
in amdgpu_gem_list_handles_ioctl(), you simply don't take the lock just 
yet. xa_for_each for counting is safe lockless and should the allocated 
array be too small during actually populating it, tough luck, caller is 
playing multi-threaded games so let it retry.

> +
> +	if (!entries) {
> +		xa_unlock(&uq_mgr->userq_xa);
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -ENOMEM;
> +	}
> +
> +	ret = check_mul_overflow(num_queues, sizeof(*entries), &entry_buffer_size);
> +
> +	if (ret) {

Nitpick here and elsewhere - I don't think a blank line between 
assignments and check is a typical pattern and for me it makes the code 
less readable but up to you.

> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	ret = copy_from_user(entries, u64_to_user_ptr(args->list_in_out.entries),
> +			     entry_buffer_size);
> +
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		/**
> +		 * Check mqd size. As with num_entries, return the right sizes
> +		 * if they are not correct. These sizes also serve as
> +		 * versioning for the mqd. Despite the names, these are the
> +		 * mqd sizes for both gfx11 and gfx12.
> +		 */
> +		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_compute_gfx11);

It's okay for now I guess but it really feels like a layering violation. 
One day this may need to be somehow queried from the queue.

> +		}
> +		else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_gfx11);
> +		}
> +		else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_sdma_gfx11);
> +		}
> +		else {

} else {

> +			ret = -EINVAL;

This is probably a drm_err_once type of situation to flag the ioctl 
implementaion fell behind the actual userqueues code. Ie. someone forgot 
to update the ioctl after new queue type has been added to the kernel. 
Userspace alone would have to way to work past this -EINVAL.

> +			goto exit;
> +		}
> +
> +		if (mqd_size != entries[i].mqd_size) {
> +			entries[i].mqd_size = mqd_size;
> +			entries[i].ip_type = queue->queue_type;
> +			i += 1;
> +			continue;

Hmm how will userspace know the order of queues to correctly 
pre-allocate the correct sizes? In other words, wouldn't it work to 
allow for larger than required and only skip if too small?

> +		}
> +
> +		entries[i].queue_id = queue_id;
> +		entries[i].ip_type = queue->queue_type;
> +		/* userq prop handling */
> +		entries[i].queue_va = queue->userq_prop->hqd_base_gpu_addr;
> +		entries[i].queue_size = queue->userq_prop->queue_size;
> +		entries[i].rptr_va = queue->userq_prop->rptr_gpu_addr;
> +		entries[i].wptr_va = queue->userq_prop->wptr_gpu_addr;
> +		/* flag handling (AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK is the only flag in use) */
> +		entries[i].flags = (queue->priority << AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT)
> +			& AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK;
> +		/* doorbell handling */
> +		entries[i].doorbell_handle = queue->doorbell_handle;
> +		/* This is the inverse of the calculation used in amdgpu_doorbell_index_on_bar
> +		 * doorbell_index = db_bo_offset / sizeof(u32)
> +		 *    + doorbell_offset * DIV_ROUND_UP(db_size, 4)
> +		 * db_size is always sizeof(u64) = 8
> +		 */
> +		entries[i].doorbell_offset =
> +			(queue->doorbell_index - amdgpu_bo_gpu_offset_no_check(queue->db_obj.obj) / 4) / 2;
> +
> +		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
> +			struct drm_amdgpu_userq_mqd_compute_gfx11 compute_mqd = {0};
> +
> +			compute_mqd.eop_va = queue->userq_prop->eop_gpu_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &compute_mqd,
> +					   entries[i].mqd_size);
> +		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
> +			struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 = {0};
> +
> +			mqd_gfx_v11.shadow_va = queue->userq_prop->shadow_addr;
> +			mqd_gfx_v11.csa_va = queue->userq_prop->csa_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &mqd_gfx_v11,
> +					   entries[i].mqd_size);
> +		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
> +			struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11 = {0};
> +
> +			mqd_sdma_v11.csa_va = queue->userq_prop->csa_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &mqd_sdma_v11,
> +					   entries[i].mqd_size);
> +		}
> +		if (ret) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +		i += 1;
> +	}
> +	ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
> +			   num_queues * sizeof(*entries));
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto exit;

Could remove this goto.

> +	}
> +exit:
> +	xa_unlock(&uq_mgr->userq_xa);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	kvfree(entries);
> +	return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -891,7 +1046,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   			drm_file_err(filp, "Failed to create usermode queue\n");
>   		break;
>   
> -	case AMDGPU_USERQ_OP_FREE: {
> +	case AMDGPU_USERQ_OP_FREE:
>   		xa_lock(&fpriv->userq_mgr.userq_xa);
>   		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>   		xa_unlock(&fpriv->userq_mgr.userq_xa);
> @@ -900,8 +1055,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   
>   		amdgpu_userq_put(queue);
>   		break;
> -	}
> -
> +	case AMDGPU_USERQ_OP_LIST:
> +		r = amdgpu_userq_list(filp, args);
> +		break;
>   	default:
>   		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
>   		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index b32c72a662b6..678f3d531df7 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -332,6 +332,7 @@ union drm_amdgpu_ctx {
>   /* user queue IOCTL operations */
>   #define AMDGPU_USERQ_OP_CREATE	1
>   #define AMDGPU_USERQ_OP_FREE	2
> +#define AMDGPU_USERQ_OP_LIST	3
>   
>   /* queue priority levels */
>   /* low < normal low < normal high < high */
> @@ -425,9 +426,47 @@ struct drm_amdgpu_userq_out {
>   	__u32 _pad;
>   };
>   
> +struct drm_amdgpu_userq_list_entry {
> +	/** Definitions same as drm_amdgpu_userq_in */
> +	__u32	queue_id;
> +	__u32   ip_type;
> +	__u32   doorbell_handle;
> +	__u32   doorbell_offset;
> +	__u32   flags;

There is a hole here so you could add a padding/mbz element here. I 
don't think it matters hugely in a write-mostly struct but in UAPI it is 
best to be 100% explicit.

> +	__u64   queue_va;
> +	__u64   queue_size;
> +	__u64   rptr_va;
> +	__u64   wptr_va;
> +	/** Userspace pointer to buffer holding mqd */
> +	__u64	mqd_data;
> +	/**
> +	 *  In: Size of mqd_data user-allocated buffer.
> +	 *  Out: If mqd_data was insufficiently large, the
> +	 * size it needs to be.
> +	 */
> +	__u64	mqd_size;

Hm, actually, you could make mqd_size __u32 and move it up as a 
different way to avoid holes and having to add explicit padding. I don't 
think mqd_size will ever need more than __u32, right?

Regards,

Tvrtko

> +};
> +
> +struct drm_amdgpu_userq_list_in_out {
> +	/**
> +	 * For operation AMDGPU_USERQ_OP_LIST: User will provide a buffer, which the
> +	 * driver will fill with information about all of that process's queues on this device.
> +	 */
> +	/** AMDGPU_USERQ_OP_LIST */
> +	__u32	op;
> +	/**
> +	 * Size of entries buffer / Number of handles in process
> +	 * (if larger than size of buffer, must retry)
> +	 */
> +	__u32   num_entries;
> +	/* User pointer to array of drm_amdgpu_userq_list_entry */
> +	__u64   entries;
> +};
> +
>   union drm_amdgpu_userq {
>   	struct drm_amdgpu_userq_in in;
>   	struct drm_amdgpu_userq_out out;
> +	struct drm_amdgpu_userq_list_in_out list_in_out;
>   };
>   
>   /* GFX V11 IP specific MQD parameters */


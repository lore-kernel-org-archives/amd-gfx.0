Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F83C79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 14:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF92110E863;
	Mon,  7 Sep 2026 14:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="G6eUz1qz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8DE110E860
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=ktEsTG+4Xgkkxw1wIPW6UY9Qbng7bcTesU1sekLTHBs=; b=G6eUz1qz/Whk9HA3w2EQXk2wkw
 aw9tzR6w6DXfFz33z15eM4LUv6odKnsvJRN9LiR2Dr3rtAmAkh4RJpgY7BMJxfnwUK/xomMVteL6B
 Ru4LTpMa9W1kG/HMB4qyI887+a31t0GR26Cvykb7kpOmnzDM52kGgzlMX2Tik2vFDZlzLnW6wrN1y
 dDAvfmiL5ywh4PzJ/AE2HtYWDEiKN6aAlZUnDFVSA9kq/r1fCKGU6vGDD63es0REls5qukWZ5G9xW
 8YfWVlu4MNvKqyJ74XXV6269pTqzSiAH86NwVU6w43+yRy7GbJ7w4totOAiVPv14slyLqQ3cfyLP4
 5d6WiTNg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x3aB1-00G4ww-Ni; Mon, 07 Sep 2026 16:18:27 +0200
Message-ID: <d8c33c5a-37e5-403a-ad1d-bb1da77d114d@igalia.com>
Date: Mon, 7 Sep 2026 15:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260827185935.89623-1-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260827185935.89623-1-David.Francis@amd.com>
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


On 27/08/2026 19:59, David Francis wrote:
> Add a new option to ioctl USERQ which provides information
> to a process about their own user queues on the queried
> device.
> 
> The returned data is in the same format as that used to
> create the queue in the first place.
> 
> The interface uses retries; the user can guess at the number
> of queues required; if insufficiently large, the correct
> value will be returned.
> The same is done for the mqd sizes of each entry.
> 
> This operation holds userq_mutex for its entire duration
> to prevent the queues from being freed or modified under it.
> 
> v3: Don't acquire xa_lock and other misc fixes
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 160 +++++++++++++++++++++-
>   include/uapi/drm/amdgpu_drm.h             |  40 ++++++
>   2 files changed, 197 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3fe10d6af757..32d1787aa7e2 100644
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
> @@ -857,6 +859,157 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
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
> +
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		num_queues += 1;
> +	}

Previously I suggested not holding the mutex here and I still don't see 
what value it brings, apart from making error handling more complicated. 
AMDGPU_USERQ_OP_FREE does not take it so the count can still change, no?

> +
> +	if (num_queues > args->list_in_out.num_entries) {
> +		/**
> +		 * If the num_entries buffer is too small,
> +		 * return the correct size. User should
> +		 * try again with the right space allocated.
> +		 */
> +		args->list_in_out.num_entries = num_queues;
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return 0;
> +	}
> +	args->list_in_out.num_entries = num_queues;

Assignment can go before the if and then you can remove the one inside 
the block.

> +
> +	if (num_queues == 0) {
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return 0;
> +	}
> +
> +	entries = kvmalloc_objs(typeof(*entries), num_queues, GFP_KERNEL);
> +
> +	if (!entries) {
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -ENOMEM;
> +	}
> +
> +	ret = check_mul_overflow(num_queues, sizeof(*entries), &entry_buffer_size);

Could move to before the allocation which would perhaps be more logical.

> +	if (ret) {
> +		ret = -EINVAL;

Maybe a different error code since userspace cannot do anything about 
it. E2BIG? Not sure which one just that EINVAL would be confusing.

> +		goto exit;
> +	}
> +
> +	ret = copy_from_user(entries, u64_to_user_ptr(args->list_in_out.entries),
> +			     entry_buffer_size);
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		/**
> +		 * The xa may have added or removed queues since we counted
> +		 * them, so break if there are now more queues than entries.
> +		 */
> +		if (i >= num_queues)
> +			break;
> +		/**
> +		 * Check mqd size. As with num_entries, return the right sizes
> +		 * if they are too small. These sizes also serve as
> +		 * versioning for the mqd. Despite the names, these are the
> +		 * mqd sizes for both gfx11 and gfx12.
> +		 */
> +		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_compute_gfx11);
> +		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_gfx11);
> +		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_sdma_gfx11);
> +		} else {
> +			drm_err_once(adev_to_drm(uq_mgr->adev), "Unrecognized mqd size in USERQ_OP_LIST");
> +			ret = -EINVAL;
> +			goto exit;
> +		}

Or with switch statements here and below. Up to you what you find more 
readable.

> +
> +		if (mqd_size > entries[i].mqd_size) {
> +			entries[i].mqd_size = mqd_size;
> +			entries[i].ip_type = queue->queue_type;
> +			i += 1;
> +			continue;
> +		}
> +		entries[i].mqd_size = mqd_size;
> +		entries[i].ip_type = queue->queue_type;

These two assignments can also be moved before the if and the ones 
inside the block removed.

> +
> +		entries[i].queue_id = queue_id;
> +		/* userq prop handling */
> +		entries[i].queue_va = queue->userq_prop->hqd_base_gpu_addr;
> +		entries[i].queue_size = queue->userq_prop->queue_size;
> +		entries[i].rptr_va = queue->userq_prop->rptr_gpu_addr;
> +		entries[i].wptr_va = queue->userq_prop->wptr_gpu_addr;
> +		/* flag handling (AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK are the only flags in use) */
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

Matter of taste but you could also write this as:

	struct drm_amdgpu_userq_mqd_compute_gfx11 compute_mqd = {
		.eop_va = queue->userq_prop->eop_gpu_addr;
	};

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

Some optional comments:

mqd_size would be more direct in all three and could save some lines.

Also maybe see if caching entries[i] and queue->userq_prop in locals 
would make it even more compact/readable.

Regards,

Tvrtko

> +		if (ret) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +		i += 1;
> +	}
> +	ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
> +			   num_queues * sizeof(*entries));
> +	if (ret)
> +		ret = -EFAULT;
> +exit:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	kvfree(entries);
> +	return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -891,7 +1044,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   			drm_file_err(filp, "Failed to create usermode queue\n");
>   		break;
>   
> -	case AMDGPU_USERQ_OP_FREE: {
> +	case AMDGPU_USERQ_OP_FREE:
>   		xa_lock(&fpriv->userq_mgr.userq_xa);
>   		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>   		xa_unlock(&fpriv->userq_mgr.userq_xa);
> @@ -900,8 +1053,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
> index b32c72a662b6..92738d630eea 100644
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
> @@ -425,9 +426,48 @@ struct drm_amdgpu_userq_out {
>   	__u32 _pad;
>   };
>   
> +struct drm_amdgpu_userq_list_entry {
> +	/** Userspace pointer to buffer holding mqd */
> +	__u64	mqd_data;
> +	/**
> +	 *  In: Size of mqd_data user-allocated buffer.
> +	 *  Out: If mqd_data was insufficiently large, the
> +	 * size it needs to be.
> +	 */
> +	__u32	mqd_size;
> +
> +	/** Definitions same as drm_amdgpu_userq_in */
> +	__u32	queue_id;
> +	__u32   ip_type;
> +	__u32   doorbell_handle;
> +	__u32   doorbell_offset;
> +	__u32   flags;
> +	__u64   queue_va;
> +	__u64   queue_size;
> +	__u64   rptr_va;
> +	__u64   wptr_va;
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


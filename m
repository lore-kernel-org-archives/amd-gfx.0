Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11227C55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 14:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8233110EEA7;
	Wed,  5 Aug 2026 14:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hVgrWadb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B77E10EEA3
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=2C4P6QxPPp+iAY/LpJi46D+1LAxJcNTgTiIao90jqP0=; b=hVgrWadbadvP/4iW4/giDqGMlF
 KD0Fd7OuoJ3GbhShthMLb9sSpWKxsNXeGallog02vYqBI7sdf2NJ/c0oo4pQ3nNiV6CxxxhOOu1ic
 1HWvbYBtl5wNi1YUgMRna8i9EulTQPKAFSh9DYQHa7SfNqh5Klh1gk/Th8BdozKeOreBsv5w4F6+f
 h32w7NfssgbOQnEEX1GEmxBywmZCT3R+1PHdU0hKY6kPrbVygLDbix0xbz3DtYwcc/T7Mk5XrCUyL
 jaiW3LVDri0GGGHOp+68NEMgfW77z2vWzNGE6c5d4otXTaHzxT+kwHxSmdfcGceOja+aUsVFxcrAK
 Yw5Vr8cg==;
Received: from [90.248.143.204] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wrcKu-00EPUz-AI; Wed, 05 Aug 2026 16:11:12 +0200
Message-ID: <2cc4d324-e9a8-4044-b462-488b2647131f@igalia.com>
Date: Wed, 5 Aug 2026 15:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Add LIST option to USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260723185046.1239011-1-David.Francis@amd.com>
 <20260723185046.1239011-3-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260723185046.1239011-3-David.Francis@amd.com>
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


On 23/07/2026 19:50, David Francis wrote:
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
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 159 ++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             |  39 ++++++
>   2 files changed, 198 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index cfee7466ef44..b13ed7f8be7f 100644
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
> @@ -857,6 +859,158 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
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
> +	bool mqd_sizes_correct = true;
> +	unsigned long queue_id;
> +	size_t mqd_size;
> +	uint32_t num_queues = 0;
> +	int ret = 0;
> +	int i = 0;

On a glance ret does not need to be initialized and i would potentially 
be better done so above the first block which uses it, in order to match 
the pattern of the second user.

> +
> +	mutex_lock(&uq_mgr->userq_mutex);

Design question is whether there is any benefit from the mutex. 
Alternative could be to simply abort the attempt if the number of queues 
changed between counting to filling the data. For CRIU that's fine since 
everything will be idled. And for non-CRIU it doesn't matter since the 
by the time the query returns the data may be stale anyway.

In which case not extending the scope of the mutex would simplify the 
previous patch and this one.

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
> +		args->list_in_out.num_entries = num_queues;
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		if (args->list_in_out.num_entries == 0)
> +			return 0;
> +		return -EINVAL;

Why -EINVAL? It differs from the established practice from 
amdgpu_gem_list_handles_ioctl for example.

> +	}
> +	if (num_queues == 0) {
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return 0;
> +	}
> +
> +	entries = kvmalloc_array(num_queues, sizeof(*entries), GFP_KERNEL);

kvmalloc_objs is preferred these days.

> +
> +	if (!entries) {
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -ENOMEM;
> +	}
> +
> +	ret = copy_from_user(entries, u64_to_user_ptr(args->list_in_out.entries),
> +			     num_queues * sizeof(*entries));

Multiplication can overflow on 32-bit so best would be to use 
check_mul_oveflow and stash the total size into a size_t local.

> +
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		mqd_size = 0;

Move to else?

> +		/**
> +		 * Check mqd size. As with num_entries, return the right sizes
> +		 * if they are not correct. These sizes also serve as
> +		 * versioning for the mqd.
> +		 */
> +		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_compute_gfx11);

Mention of gfx11 feels a bit out of place - how will this work for 
future extensions?

> +		else if (queue->queue_type == AMDGPU_HW_IP_GFX)
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_gfx11);
> +		else if (queue->queue_type == AMDGPU_HW_IP_DMA)
> +			mqd_size = sizeof(struct drm_amdgpu_userq_mqd_sdma_gfx11);

Emit a warning and fail if unknown queue type is encountered?

> +
> +		if (mqd_size != entries[i].mqd_size) {
> +			mqd_sizes_correct = false;
> +			entries[i].mqd_size = mqd_size;
> +			entries[i].ip_type = queue->queue_type;

Why not break out?

Or could you even merge this into the main xa_for_each below? Simply 
walk it and branch between good and bad mqd_sizes, each filling their 
respecive block.

> +		}
> +		i += 1;
> +	}
> +	if (!mqd_sizes_correct) {
> +		ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
> +				   num_queues * sizeof(*entries));
> +		if (ret)
> +			ret = -EFAULT;
> +		goto exit;

So userspace gets a success but entries[] has only been partially 
filled? How is userspace expected to detect and handle that? By looking 
if any entry mqd_size returned different than the one it passed in?

> +	}
> +	i = 0;
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
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
> +		/* This is the inverse of the calculation used in amdgpu_userq_get_doorbell_index */
> +		entries[i].doorbell_offset =
> +			(queue->doorbell_index - amdgpu_bo_gpu_offset_no_check(queue->db_obj.obj) / sizeof(u32))
> +			 / DIV_ROUND_UP(sizeof(u64), 4);

What is the point of DIV_ROUND_UP here?

> +
> +		if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
> +			struct drm_amdgpu_userq_mqd_compute_gfx11 compute_mqd = {0};

= {} is preferred I think, or maybe better, all initializers in this 
blow and the ones below can be made at declaration time which would be a 
bit more compact.

> +
> +			compute_mqd.eop_va = queue->userq_prop->eop_gpu_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &compute_mqd,
> +					   entries[i].mqd_size);
> +
> +			if (ret) {
> +				ret = -EFAULT;
> +				goto exit;
> +			}

if (ret) etc block could be moved to a single one after the if-elseif- 
ladder.

> +		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
> +			struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 = {0};
> +
> +			mqd_gfx_v11.shadow_va = queue->userq_prop->shadow_addr;
> +			mqd_gfx_v11.csa_va = queue->userq_prop->csa_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &mqd_gfx_v11,
> +					   entries[i].mqd_size);
> +			if (ret) {
> +				ret = -EFAULT;
> +				goto exit;
> +			}
> +		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
> +			struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11 = {0};
> +
> +			mqd_sdma_v11.csa_va = queue->userq_prop->csa_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &mqd_sdma_v11,
> +					   entries[i].mqd_size);
> +			if (ret) {
> +				ret = -EFAULT;
> +				goto exit;
> +			}
> +		}
> +		i += 1;
> +	}
> +	ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
> +			   num_queues * sizeof(*entries));
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto exit;
> +	}
> +exit:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	kvfree(entries);
> +	return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -901,6 +1055,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   
>   		amdgpu_userq_put(queue);
>   		break;
> +	case AMDGPU_USERQ_OP_LIST:
> +		r = amdgpu_userq_list(filp, args);
> +		if (r)
> +			drm_file_err(filp, "Failed to get list of usermode queues\n");

Drop this - we don't want to allow naughty userspace spam the kernel log 
at will.

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
> +};
> +
> +struct drm_amdgpu_userq_list_in_out {
> +	/**
> +	 * For operation AMDGPU_USERQ_OP_LIST: User will provide a buffer, which the
> +	 * driver will fill with information about all of that process's queues on this device.
> +	 */
> +	/** AMDGPU_USERQ_OP_LIST */
> +	__u32	op;

At first I wanted to ask what is this for, that it seems unused, but 
then I realized it is for..

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

.. the union! And that the list_in_out.op is needed to match the exact 
position of in.op. A bit evil but I guess it works.

Regards,

Tvrtko

>   };
>   
>   /* GFX V11 IP specific MQD parameters */


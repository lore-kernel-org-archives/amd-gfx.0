Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62F606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=jVQHD28V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DFD1124A9;
	Thu, 22 Oct 2026 10:09:26 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B44C10E3D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=oWIKZ4tjW48ABdpZJQLCqTxJ5z5ZhcqhW0/KLasQDfo=; b=jVQHD28VV3AGBLHcI8oKMLxTBd
 suxLXLspupCDksgvTjHtcHIM0BJg+QF3PS8AS7CrgRDha+ja3k2jpI719LWamDn3o5YoqaCvf/seg
 c6XPFBwC6vKvCw9RljyFtV0MqFW/0ZBF1VwV4IU9TJVjsVjYpDSCjjLvwntgtoYSfQUYetyHS3CSq
 8JA00cdT+loviPGoMHYoSb3JaQtcfsIlhN+YwoaDdx6ZkVXNAGhnrGtLgXa+Y0yik2tU+S/BxHeJC
 PFQR8k23fXYm/0DXeunWzcaf9Pgz+bStqTh9MsSK94iul3N9YYrN6vwGI4Jf3bMKz+6WYU2aDS5DA
 R6w8BNcw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJpjZ-006gSr-W2; Thu, 22 Oct 2026 12:09:18 +0200
Message-ID: <a084d839-9b1d-4be2-b955-c3cafdd3406c@igalia.com>
Date: Thu, 22 Oct 2026 11:09:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/amdgpu: Add LIST option to USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261020194801.506382-1-David.Francis@amd.com>
 <20261020194801.506382-2-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261020194801.506382-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 20/10/2026 20:48, David Francis wrote:
> Add a new option to ioctl USERQ which provides information
> to a process about their own user queues.
> 
> The returned data is in the same format as that used to
> create the queue in the first place.
> 
> The interface uses retries; the user can guess at the number
> of queues required; if insufficiently large, the correct
> value will be returned.
> The same is done for the mqd sizes of each entry.
> 
> v3: Don't acquire xa_lock and other misc fixes
> v4: Don't acquire mutex either and other misc fixes
> v5: Small fixes; now with accompanying igt and criu changes

LGTM!

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 145 +++++++++++++++++++++-
>   include/uapi/drm/amdgpu_drm.h             |  40 ++++++
>   2 files changed, 182 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3fe10d6af757..5aa53b2f4355 100644
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
> @@ -857,6 +859,142 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
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
> +	size_t mqd_size, entry_buffer_size;
> +	uint32_t num_queues = 0;
> +	unsigned long queue_id;
> +	int i = 0;
> +	int ret;
> +
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue)
> +		num_queues += 1;
> +
> +	/**
> +	 * If the num_entries buffer is too small, return the correct size.
> +	 * User should try again with the right space allocated.
> +	 */
> +	if (num_queues > args->list_in_out.num_entries) {
> +		args->list_in_out.num_entries = num_queues;
> +		return 0;
> +	}
> +	args->list_in_out.num_entries = num_queues;
> +
> +	if (num_queues == 0)
> +		return 0;
> +
> +	ret = check_mul_overflow(num_queues, sizeof(*entries), &entry_buffer_size);
> +	if (ret)
> +		return -E2BIG;
> +
> +	entries = kvmalloc_objs(typeof(*entries), num_queues, GFP_KERNEL);
> +	if (!entries)
> +		return -ENOMEM;
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
> +			drm_err_once(adev_to_drm(uq_mgr->adev), "Unrecognized queue type in USERQ_OP_LIST");
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +
> +		if (mqd_size > entries[i].mqd_size) {
> +			entries[i].mqd_size = mqd_size;
> +			entries[i].ip_type = queue->queue_type;
> +			i += 1;
> +			continue;
> +		}
> +		entries[i].mqd_size = mqd_size;
> +		entries[i].ip_type = queue->queue_type;
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
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &compute_mqd, mqd_size);
> +		} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
> +			struct drm_amdgpu_userq_mqd_gfx11 mqd_gfx_v11 = {0};
> +
> +			mqd_gfx_v11.shadow_va = queue->userq_prop->shadow_addr;
> +			mqd_gfx_v11.csa_va = queue->userq_prop->csa_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &mqd_gfx_v11, mqd_size);
> +		} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
> +			struct drm_amdgpu_userq_mqd_sdma_gfx11 mqd_sdma_v11 = {0};
> +
> +			mqd_sdma_v11.csa_va = queue->userq_prop->csa_addr;
> +
> +			ret = copy_to_user(u64_to_user_ptr(entries[i].mqd_data),
> +					   &mqd_sdma_v11, mqd_size);
> +		}
> +		if (ret) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +		i += 1;
> +	}
> +	ret = copy_to_user(u64_to_user_ptr(args->list_in_out.entries), entries,
> +			   entry_buffer_size);
> +	if (ret)
> +		ret = -EFAULT;
> +exit:
> +	kvfree(entries);
> +	return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -891,7 +1029,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   			drm_file_err(filp, "Failed to create usermode queue\n");
>   		break;
>   
> -	case AMDGPU_USERQ_OP_FREE: {
> +	case AMDGPU_USERQ_OP_FREE:
>   		xa_lock(&fpriv->userq_mgr.userq_xa);
>   		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>   		xa_unlock(&fpriv->userq_mgr.userq_xa);
> @@ -900,8 +1038,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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


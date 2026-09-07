Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B82C79F89
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 13:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A8E10E02B;
	Mon,  7 Sep 2026 13:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JOhZkdLH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D3010E02B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=mQu3YUGnZqnQpBWNpnwHNrMfESUGIExfjyvo9kCSobo=; b=JOhZkdLHZjlBY4oBdm+U7wPZ1w
 ErLXVmVILa10UCQEB3FTdjwILgc3D1jSFXDG0os93QhKfgYyLCxFMzwk64h34eNovROel9ITWj9cw
 FjuZp/90Qo0MZx8WK71akqSYGN5Oz3T5L868VMcVrVD4PnCCfTaHtI7oqvbatH8WpnfJReM8FwMWU
 FOv67bf6KufAi6m4ZJpg7Z8C4yjge1hsY8GOC6CiigSBr0EBptSGbgLmfe5WwRZdL4hx7OxYoQq5b
 BAzqYg1p8lG8Eb/YjQEJDdBcwVc7JWTtX14g5Tj1crOGrbYzh6VxD6dMmm6QKdeZUhTFN5PhW1Nfj
 wbGAYJvQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x3ZR9-00G3bk-31; Mon, 07 Sep 2026 15:31:03 +0200
Message-ID: <83884774-9ff7-41e9-8ea5-ea06675b6fe2@igalia.com>
Date: Mon, 7 Sep 2026 14:31:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260827185935.89623-1-David.Francis@amd.com>
 <20260827185935.89623-2-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260827185935.89623-2-David.Francis@amd.com>
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
> Add a new option to the USERQ ioctl, which is called with
> the queue_id of an existing user queue and an unused queue_id,
> and changes that queue's id to the new value.
> 
> Calling with an invalid new handle will fail. Calling with new_handle
> = handle will succeed if that queue exists but not do anything.
> 
> A poison queue object is inserted at the old handle during the
> rekey to prevent concurrent FREE from destroying the queue or the
> old id being reused mid-operation.

Looks complicated. Have you looked at how I've done the rename with no 
external lock?

https://lore.kernel.org/amd-gfx/20260806134712.91816-7-tvrtko.ursulin@igalia.com/

I'll have a read through your approach but I can't say I am a fan.

> Performing this operation on a queue with signals or waits
> outstanding is fine, as those hold not the queue_id but a
> direct reference to the queue object.
> 
> v3: Poison queue and misc fixes
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 60 +++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             | 17 +++++--
>   2 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 32d1787aa7e2..699838042bda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -35,6 +35,8 @@
>   #include "amdgpu_userq_fence.h"
>   #include "amdgpu_trace.h"
>   
> +struct amdgpu_usermode_queue poison_queue;
> +
>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -852,6 +854,11 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>   		break;
>   	case AMDGPU_USERQ_OP_LIST:
>   		break;
> +	case AMDGPU_USERQ_OP_CHANGE_ID:
> +		if (!args->change_in.new_queue_id ||
> +		    args->change_in.new_queue_id > AMDGPU_MAX_USERQ_COUNT)
> +			return -EINVAL;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1010,6 +1017,51 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	return ret;
>   }
>   
> +static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_usermode_queue *queue;
> +	int ret = 0;
> +
> +	if (args->change_in.new_queue_id == args->change_in.queue_id) {
> +		if (xa_load(&uq_mgr->userq_xa, args->change_in.queue_id))
> +			return 0;
> +		return -ENOENT;

Why is is important to allow users to query for existence of an id like 
this ie. why wouldn't be be EINVAL if new == old?

> +	}
> +
> +	/* Poison the old handle so it doesn't get freed or reused. */
> +	queue = xa_store(&uq_mgr->userq_xa, args->change_in.queue_id, &poison_queue, GFP_KERNEL);

What if userspace is silly and looks up this handle from a racing 
thread? It gets the poison queue and things explode?

> +	if (!queue) {
> +		xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +		return -ENOENT;
> +	}
> +	if (queue == &poison_queue)
> +		return -EINVAL;

Why is this EINVAL? Userspace races with itself I get it, but I think it 
shows the weakness of the poison entry multi-stage approach.

> +
> +	ret = xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id, queue, GFP_KERNEL);
> +	if (ret == -EBUSY) {
> +		queue = xa_store(&uq_mgr->userq_xa, args->change_in.queue_id, queue, GFP_KERNEL);
> +		if (queue != &poison_queue) {
> +			drm_err_once(adev_to_drm(uq_mgr->adev),
> +				     "Expected poison queue to remain untouched during userqueue change id");

Do you expect drm_err to be reachable by silly userspace or just 
unexpected internal error?

> +			return -EINVAL;
> +		}
> +	}
> +	if (ret == -ENOMEM)
> +		return -ENOMEM;

Is there another possibily from xa_insert other than EBUSY and ENOMEM?

> +
> +	/* remove the poison */
> +	queue = xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +	if (queue != &poison_queue) {
> +		drm_err_once(adev_to_drm(uq_mgr->adev),
> +			     "Expected poison queue to remain untouched during userqueue change id");

Same question as the previous drm_err_once.

Sorry I don't like this at all. I would much rather you try to punch a 
hole in my approach or confirm it works fine.

I adapted that from some existing driver.. can't remember which now 
after more than a month. But the approach sounds sane to me - do the 
rename atomically under the lock using GFP_NOWAIT first and if that 
fails drop the lock to pre-allocate space and retry.

Regards,

Tvrtko

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -1046,6 +1098,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   
>   	case AMDGPU_USERQ_OP_FREE:
>   		xa_lock(&fpriv->userq_mgr.userq_xa);
> +		queue = xa_load(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
> +		if (queue == &poison_queue) {
> +			xa_unlock(&fpriv->userq_mgr.userq_xa);
> +			return -EINVAL;
> +		}
>   		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>   		xa_unlock(&fpriv->userq_mgr.userq_xa);
>   		if (!queue)
> @@ -1056,6 +1113,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	case AMDGPU_USERQ_OP_LIST:
>   		r = amdgpu_userq_list(filp, args);
>   		break;
> +	case AMDGPU_USERQ_OP_CHANGE_ID:
> +		r = amdgpu_userq_change_id(filp, args);
> +		break;
>   	default:
>   		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
>   		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 92738d630eea..37d0efd1eda4 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,9 +330,10 @@ union drm_amdgpu_ctx {
>   };
>   
>   /* user queue IOCTL operations */
> -#define AMDGPU_USERQ_OP_CREATE	1
> -#define AMDGPU_USERQ_OP_FREE	2
> -#define AMDGPU_USERQ_OP_LIST	3
> +#define AMDGPU_USERQ_OP_CREATE		1
> +#define AMDGPU_USERQ_OP_FREE		2
> +#define AMDGPU_USERQ_OP_LIST		3
> +#define AMDGPU_USERQ_OP_CHANGE_ID	4
>   
>   /* queue priority levels */
>   /* low < normal low < normal high < high */
> @@ -464,10 +465,20 @@ struct drm_amdgpu_userq_list_in_out {
>   	__u64   entries;
>   };
>   
> +struct drm_amdgpu_userq_change_id_in {
> +	/** AMDGPU_USERQ_OP_CHANGE_ID */
> +	__u32   op;
> +	/** Queue id of some queue */
> +	__u32   queue_id;
> +	/** Queue id to change that queue to */
> +	__u32   new_queue_id;
> +};
> +
>   union drm_amdgpu_userq {
>   	struct drm_amdgpu_userq_in in;
>   	struct drm_amdgpu_userq_out out;
>   	struct drm_amdgpu_userq_list_in_out list_in_out;
> +	struct drm_amdgpu_userq_change_id_in change_in;
>   };
>   
>   /* GFX V11 IP specific MQD parameters */


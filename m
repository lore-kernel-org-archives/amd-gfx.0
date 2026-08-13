Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86EBC5CFDB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 08:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E0810E3EA;
	Thu, 13 Aug 2026 08:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NZYBBb7D";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A5610E237
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=hOJonhTUUNiYYhSWEJVmA4K//FBJ9FBYbFYfa5rnge8=; b=NZYBBb7Dj0AJBPJ5CE/LTxuKAW
 Lh8p6BTGF8dgZVElTBvoz80bmkOgYi6R/RB1tDMgVY5RZ7fK80GuoGGOa8Tt8SylgrWVKeab3TeTB
 HfAuc0/dcUtt1SuBtsBnjUwsFcU2sgWsE/lKm5kBytYkNrYagS3J8pp2aEDwGOOmEfXZ32gN/M9ja
 Fc+DPQSiUY0zt3f+Onx8l41tvAi5DBPn7uTKfwteoqGzV/ONOM6t6WOUxuPxnVpunD0uEGBhFJkF2
 hjDqeAnS1ap8RGxYchfIj5T32sz7SsT+XFkkqpSkXkySF/dM7m75UwodvpYyqbMwD/SIT/Curmhy1
 Mcq1D+aQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuR6l-000lhv-Fv; Thu, 13 Aug 2026 10:48:15 +0200
Message-ID: <5ec5f320-d8d5-444e-8ed1-1412818ffd8b@igalia.com>
Date: Thu, 13 Aug 2026 09:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260811141202.1633727-1-David.Francis@amd.com>
 <20260811141202.1633727-2-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260811141202.1633727-2-David.Francis@amd.com>
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
> Add a new option to the USERQ ioctl, which is called with
> the queue_id of an existing user queue and an unused queue_id,
> and changes that queue's id to the new value.
> 
> Calling with an invalid new handle will fail. Calling with new_handle
> =handle will succeed if that queue exists but not do anything.
> 
> This operation holds userq_mutex and the userq_xa xa_lock for its
> entire duration.
> 
> Performing this operation on a queue with signals or waits
> outstanding is fine, as those hold not the queue_id but a
> direct reference to the queue object.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 43 +++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             | 17 +++++++--
>   2 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3c930425c1bb..b532ba0f4cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -852,6 +852,11 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
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
> @@ -1012,6 +1017,41 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
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
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	xa_lock(&uq_mgr->userq_xa);
> +
> +	queue = xa_load(&uq_mgr->userq_xa, args->change_in.queue_id);
> +	if (!queue) {
> +		ret = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	if (args->change_in.new_queue_id == args->change_in.queue_id) {

I would move this outside the lock or even consider returning -EINVAL. 
Or you have a reason why returning success is handy? Probing what 
exists? Why?

> +		ret = 0;
> +		goto unlock;
> +	}
> +
> +	ret = __xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id, queue, GFP_KERNEL);

Same as for the list ioctl, GFP_KERNEL under the xa_lock will not work.

You can have a look on how I've done it in "drm/amdgpu: Add context 
handle renaming operation" and see if you can punch some holes in my 
logic there?

If that works question will be do you really need both the userq_mutext 
and xa_lock or perhaps xa_lock would be enough throughout the series.

Regards,

Tvrtko

> +	if (ret) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	__xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +
> +unlock:
> +	xa_unlock(&uq_mgr->userq_xa);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -1058,6 +1098,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
> index 678f3d531df7..de9ae1296819 100644
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
> @@ -463,10 +464,20 @@ struct drm_amdgpu_userq_list_in_out {
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


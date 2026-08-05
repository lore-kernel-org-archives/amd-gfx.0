Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED352C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 14:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826EB10E205;
	Wed,  5 Aug 2026 14:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IXNhYRlP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D717310E205
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=FeGwZTk2Y4hWe0x/Mhy43FpChB8WwIs6dEIQP2paEG0=; b=IXNhYRlPUvwEjR9k3l+J+mQ7RZ
 MnAaiAnYE/HI6U2zyzHwPL5g/ajDT6Yk13iD6GzOFhl74KzzzRn7LYvWIhI5r4CP9PqbpBMUP2sG/
 mSJbE1PbHIMEkjW/Ld7zO09QkpajMj9MR7P73ienHQR9VTd8vRbwhEGGJxEVRB1FnShz18GSxnNKd
 D7JBVIDJb/pVoEhqyXabZCjFKxPPb8vYa1G6bLv9s6RB4Dg8IWDmFVXQqKbXNz4oHTQ+cXY7lXXfu
 5VUc5vvvs0++oWHcwHcrP0WFlKM/ba+3EiaJdxcqC86vWiFHX4D7t163pGolHcvg1BHqnd5GNrSiR
 WGORWAhA==;
Received: from [90.248.143.204] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wrclO-00EQOJ-Nn; Wed, 05 Aug 2026 16:38:34 +0200
Message-ID: <ae0f7312-081d-4ae7-b3a3-bd54fc2327c6@igalia.com>
Date: Wed, 5 Aug 2026 15:38:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260723185046.1239011-1-David.Francis@amd.com>
 <20260723185046.1239011-4-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260723185046.1239011-4-David.Francis@amd.com>
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
> Add a new option to the USERQ ioctl, which is called with
> the queue_id of an existing user queue and an unused queue_id,
> and changes that queue's id to the new value.
> 
> The operation is fully protected by userq_mutex to avoid races.
> 
> Performing this operation on a queue with signals or waits
> outstanding is fine, as those hold not the queue_id but a
> direct reference to the queue object.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 +++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             | 17 +++++++++--
>   2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b13ed7f8be7f..ce084e2cfe53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -852,6 +852,11 @@ static int amdgpu_userq_input_args_validate(struct drm_device *dev,
>   		break;
>   	case AMDGPU_USERQ_OP_LIST:
>   		break;
> +	case AMDGPU_USERQ_OP_CHANGE_ID:
> +		if (!args->change_in.new_queue_id ||
> +		    args->change_in.new_queue_id > AMDGPU_MAX_USERQ_COUNT)

Maybe also check they are not the same? Currently same id will fail in 
xa_insert with -EBUSY which is maybe not what you intended.

> +			return -EINVAL;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1011,6 +1016,33 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
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
> +
> +	queue = amdgpu_userq_get(uq_mgr, args->change_in.queue_id);
> +	if (!queue) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	ret = xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id, queue, GFP_KERNEL);
> +	if (ret)
> +		goto put;
> +
> +	xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);

I guess here the mutex makes it easier although it is probably doable 
without it by preallocating and using the internal lock and advanced api.

Hmm.. I will have to implement the same thing for ctx handle rename any 
day now, I was planning to respin the render node CRIU RFC this week. 
Not that I think taking the mutex is a problem at all, just that my 
initial reaction was that in 1/3 it did not fix the race fully so maybe 
we don't even need it. But maybe it is easier with it.

I'll see there how doing it with internal lock only pans out in context 
rename.

> +put:
> +	amdgpu_userq_put(queue);
> +unlock:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -1060,6 +1092,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   		if (r)
>   			drm_file_err(filp, "Failed to get list of usermode queues\n");
>   		break;
> +	case AMDGPU_USERQ_OP_CHANGE_ID:
> +		r = amdgpu_userq_change_id(filp, args);
> +		if (r)
> +			drm_file_err(filp, "Failed to change queue id\n");

Remove the logging as in the previous patch. Or downgrade to debug if 
must be.

Regards,

Tvrtko

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


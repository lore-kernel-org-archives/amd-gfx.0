Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD4606A32C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=lLdd4+rd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A663112475;
	Thu, 22 Oct 2026 10:11:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A17112475
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=A7KIkryCb2rP1kRYOFCG4wa4giNqWJmW3oxAc7/bkqg=; b=lLdd4+rd9e6N3K24Je1RDHbmaA
 g5oE1Mi/6/NbBZ/FrXZ3xjUB4taY/p5Gz3QQhMbLMB/x/po8axrvoVmYLBpN9JWCPC3sPKd98rblN
 DIdgCtnNiv8c9xgBvdhreCpY1Iopv3pYV2B0LKl/0U6nqmnSV2leY6mtUKMI3Lo7ttxDtzbEu4S6y
 6K0xQwEF6eZ4ceB2gNJSLicWnV/8+8H9vqlnmyw3Il6kkspdyrBemCAG0N+PSxxzFZ+l2Kha0lsxl
 YWpog2I5tEAmRD0fsGQUVkSaF5rAYTbIsgyj2IeZ9tjaEg3fqyIzNCeyLcRX8cFXJQTp1yFDCj6FV
 7IYDbAYg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJplP-006gYm-56; Thu, 22 Oct 2026 12:11:11 +0200
Message-ID: <5b97b2a6-c4cf-47a9-94d5-0190f72d0d61@igalia.com>
Date: Thu, 22 Oct 2026 11:11:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261020194801.506382-1-David.Francis@amd.com>
 <20261020194801.506382-3-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261020194801.506382-3-David.Francis@amd.com>
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
> Add a new option to the USERQ ioctl, which is called with
> the queue_id of an existing user queue and an unused queue_id,
> and changes that queue's id to the new value.
> 
> Calling with an invalid new handle will fail. Calling with new_handle
> = handle will succeed if that queue exists but not do anything.
> 
> Performing this operation on a queue with signals or waits
> outstanding is fine, as those hold not the queue_id but a
> direct reference to the queue object.
> 
> v3: Poison queue and misc fixes
> v4: Using xas interface
> v5: Now with accompanying igt and criu changes

LGTM as well.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 46 +++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             | 17 +++++++--
>   2 files changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 5aa53b2f4355..1310004ec63f 100644
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
> @@ -995,6 +1000,44 @@ amdgpu_userq_list(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	return ret;
>   }
>   
> +static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	XA_STATE(xas, &uq_mgr->userq_xa, args->change_in.new_queue_id);
> +	struct amdgpu_usermode_queue *queue;
> +	int ret;
> +
> +	if (args->change_in.new_queue_id == args->change_in.queue_id)
> +		return -EINVAL;
> +
> +	do {
> +		xas_lock(&xas);
> +
> +		queue = xa_load(&uq_mgr->userq_xa, args->change_in.queue_id);
> +		if (!queue) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +
> +		if (xas_load(&xas)) {
> +			ret = -EBUSY;
> +			goto unlock;
> +		}
> +
> +		xas_store(&xas, queue);
> +		ret = xas_error(&xas);
> +		if (ret)
> +			goto unlock;
> +
> +		__xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +unlock:
> +		xas_unlock(&xas);
> +	} while (xas_nomem(&xas, GFP_KERNEL));
> +
> +	return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -1041,6 +1084,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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


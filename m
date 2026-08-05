Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545B2C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 10:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91E610E1CF;
	Wed,  5 Aug 2026 10:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sfqCs6ol";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B8010EDC2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=3A9FErrxBWoIu6NRfyzTrLKp/yR+NREuTN1DpuqIKfg=; b=sfqCs6olujaXXST4hzAV5kdULD
 bLl5J5ajscMxFvHByvVBGcoT1t8LwENjv1bKTh6MriQ99Fik2NQpVwuLTN7ka9H1gc6XWkoJsB4P4
 aRaND6SSIybabz406+YQAhi2E8Ocprli10eN258Z6uowS5dA7B5ILeVkjqNbHxSOLMGXhnEaFLltQ
 H0Qa3Qtdc/0GleuXZ6hqo619z2MZOJbp676DfVi4GUUX9r6nD/lXac4jHEEcEeI9Lvc+Hsk8r6uIw
 ayUWDDOHA48Z1Hxh1PpGBDBy2mKF91NHWijmJJMkXA/RQOMT6UDWt7C/WWo+iOBmgilrhizaqnfv5
 VWc1Xoog==;
Received: from [90.248.143.204] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wrYdx-00EK7o-Lx; Wed, 05 Aug 2026 12:14:37 +0200
Message-ID: <a8a8aaba-8992-4fb3-a80d-c4bf7a6305e9@igalia.com>
Date: Wed, 5 Aug 2026 11:14:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Protect userq create and free fully with
 mutex
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260723185046.1239011-1-David.Francis@amd.com>
 <20260723185046.1239011-2-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260723185046.1239011-2-David.Francis@amd.com>
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
> amdgpu userq has a userq_mutex meant to protect the list of userqs
> and their state.
> 
> The CREATE option of the USERQ ioctl released the lock before
> performing a last xa_alloc, relying on the xa lock to avoid
> races.
> 
> The FREE option of the same ioctl didn't use the lock at all.
> 
> Acquire and hold the lock in both these cases, to ensure
> correct serialization of these ioctl options against each other
> and against future ioctl options.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3fe10d6af757..cfee7466ef44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -748,11 +748,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   
>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> -
>   	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
>   		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
>   		     GFP_KERNEL);
> +
> +	mutex_unlock(&uq_mgr->userq_mutex);

So the bug/race is that AMDGPU_USERQ_OP_FREE can drop the reference 
before amdgpu_userq_create() fully finishes, but then I think it is 
still there after this patch. Because a bit lower down, on the success 
path, there is this:

	amdgpu_debugfs_userq_init(filp, queue, qid);
	trace_amdgpu_userq_create_end(queue, 0);
	args->out.queue_id = qid;
	return 0;

So as soon as userq_mutex is unlocked, racing thread can do the last 
amdgpu_userq_put() making the first two of above use after free.

Possibly xa_alloc needs to be truly last with the corresponding debugfs 
unwind on the failure path. That would fix the existing race without the 
need to widen the mutex scope, but perhaps wouldn't help you for the 
LIST implementation in the following patch. Question there is could you 
get away with not locking the mutex.

>   	if (r) {
>   		/*
>   		 * This drops the last reference which should take care of
> @@ -890,18 +890,17 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   		if (r)
>   			drm_file_err(filp, "Failed to create usermode queue\n");
>   		break;
> -
> -	case AMDGPU_USERQ_OP_FREE: {
> +	case AMDGPU_USERQ_OP_FREE:
> +		mutex_lock(&fpriv->userq_mgr.userq_mutex);
>   		xa_lock(&fpriv->userq_mgr.userq_xa);
>   		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>   		xa_unlock(&fpriv->userq_mgr.userq_xa);

xa_lock + __xa_erase + xa_unlock = xa_erase

Regards,

Tvrtko

> +		mutex_unlock(&fpriv->userq_mgr.userq_mutex);
>   		if (!queue)
>   			return -ENOENT;
>   
>   		amdgpu_userq_put(queue);
>   		break;
> -	}
> -
>   	default:
>   		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
>   		return -EINVAL;


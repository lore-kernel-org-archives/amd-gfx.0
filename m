Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A6BC35FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 11:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B0310E0CC;
	Tue, 17 Sep 2024 11:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PFbNoJF3";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4785210E0CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 11:58:18 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-374c7e64b60so3295770f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726574296; x=1727179096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gSs3u9lWgzBSkMEHRz3qYTCx5vgd3FfV7FxWViM0004=;
 b=PFbNoJF38ejzSo79d6M+uBDbbtdr1rpeqvuTWMhrqJ7l+0BrL4IRsXb6ANKHWwlYlz
 cZw1jYLXDxvhQmDqiYWPhmUDu6tg2OA/brEpmzL6J0P43mebuvQYWwZYOSPZa7ZVqLVg
 PQAr3Tf5wutdWIE4eP5Cn3MmG0K/OcOn4zdHyB6ZbbvkPWBwE4HUFTH+DYoWZjOWuXZa
 RA9zIkpmLe4GQQjxJ+PEsf0R5hFn4Ih96ThyiTNPQucjNiJTeJicwFl1NqSMWV1uAfIJ
 Ui8Uj+Sio5IeBhO+lM44UNPBQ6JyjMZCtX/BLBCC1bPnNOs4Jx/hkhykcozySYOe6ZR7
 LrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726574296; x=1727179096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gSs3u9lWgzBSkMEHRz3qYTCx5vgd3FfV7FxWViM0004=;
 b=SNuDlx0bUZZFwBFs/zdCtrt5WVPz1ZCOkoiTDFaWkJNeNjqyhh6UilMps1BNBd3Ml+
 QJjbsfONs2ZgkoMTny3TBuqGUVVYLfz5gkLnnjZw9MvN1fF8qPxtSr5HEDyDd5dYRnH+
 +MBjHdULobCI8xomk9FRKGFWxpwmOHMC2ag9H3srr6tBXNWpm00bhQ5P0JQaBNKKJPEt
 ScuvO+W6AyTRhQWjdqfuzu43rOpofENobDPNlkPFGLFnndIRiAgO7wYaqNprISkmOOqW
 8eyGjTZsBxUKjPA48ujn+ct6nzgtrvHJBG0APEJ2ZGgyu0UCE+YXNKdh6xg832RoZRtn
 S0rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYTKsgoZpsPpBpky5RGwbEBJ9bOZtHD2pNlrqc0DkI7dsDehzxuPUT1Y7KBYtDkSogpkJv6FV7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbXPFWNrLmQLs1pHcKWGbx1qwAG1vL8d9HsGnrqQ5feie64KlX
 hdcC75K3h9unvWgnp1vA+gWv2NK0dV49uBuM4pMh0jbmKe0lJhBG
X-Google-Smtp-Source: AGHT+IHL/E7SqRvP+wfROUaV8CMhofwCjRbbB2PpIsSbNvKuctpmTXH1AJDv52BWSy4JVwFPFdpyDA==
X-Received: by 2002:a5d:4806:0:b0:36d:2984:ef6b with SMTP id
 ffacd0b85a97d-378c2cfea88mr9612719f8f.11.1726574295974; 
 Tue, 17 Sep 2024 04:58:15 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78044dfsm9308797f8f.94.2024.09.17.04.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 04:58:15 -0700 (PDT)
Message-ID: <24e0e708-661f-4488-86be-ebb9312187e4@gmail.com>
Date: Tue, 17 Sep 2024 13:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 23/28] drm/amdgpu: suspend gfx userqueues
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-19-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240909200614.481-19-shashank.sharma@amd.com>
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

Am 09.09.24 um 22:06 schrieb Shashank Sharma:
> This patch adds suspend support for gfx userqueues. It typically does
> the following:
> - adds an enable_signaling function for the eviction fence, so that it
>    can trigger the userqueue suspend,
> - adds a delayed function for suspending the userqueues, to suspend all
>    the queues under this userq manager and signals the eviction fence,
> - adds reference of userq manager in the eviction fence container so
>    that it can be used in the suspend function.
>
> V2: Addressed Christian's review comments:
>      - schedule suspend work immediately
>
> V4: Addressed Christian's review comments:
>      - wait for pending uq fences before starting suspend, added
>        queue->last_fence for the same
>      - accommodate ev_fence_mgr into existing code
>      - some bug fixes and NULL checks
>
> V5: Addressed Christian's review comments (gitlab)
>      - Wait for eviction fence to get signaled in destroy, dont signal it
>      - Wait for eviction fence to get signaled in replace fence, dont signal it
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Change-Id: Ib60a7feda5544e3badc87bd1a991931ee726ee82
> ---
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 149 ++++++++++++++++++
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 100 ++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  10 ++
>   6 files changed, 272 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 2d474cb11cf9..3d4fc704adb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -22,8 +22,12 @@
>    *
>    */
>   #include <linux/sched.h>
> +#include <drm/drm_exec.h>
>   #include "amdgpu.h"
>   
> +#define work_to_evf_mgr(w, name) container_of(w, struct amdgpu_eviction_fence_mgr, name)
> +#define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, evf_mgr)
> +
>   static const char *
>   amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>   {
> @@ -39,10 +43,150 @@ amdgpu_eviction_fence_get_timeline_name(struct dma_fence *f)
>   	return ef->timeline_name;
>   }
>   
> +static void
> +amdgpu_eviction_fence_update_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +				   struct amdgpu_eviction_fence *new_ef)
> +{
> +	struct dma_fence *old_ef = &evf_mgr->ev_fence->base;

The spinlock is protecting evf_mgr->ev_fence so this access without 
holding the spinlock here is illegal.

I think you should just drop the local variable.

> +
> +	spin_lock(&evf_mgr->ev_fence_lock);
> +	dma_fence_put(old_ef);
> +	evf_mgr->ev_fence = new_ef;
> +	spin_unlock(&evf_mgr->ev_fence_lock);
> +}
> +
> +int
> +amdgpu_eviction_fence_replace_fence(struct amdgpu_fpriv *fpriv)
> +{
> +	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_eviction_fence *old_ef, *new_ef;
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +	int ret;
> +
> +	old_ef = evf_mgr->ev_fence;
> +	if (old_ef && !dma_fence_is_signaled(&old_ef->base)) {
> +		DRM_DEBUG_DRIVER("Old EF not signaled yet\n");
> +		dma_fence_wait(&old_ef->base, true);
> +	}

Please completely drop that.

> +
> +	new_ef = amdgpu_eviction_fence_create(evf_mgr);
> +	if (!new_ef) {
> +		DRM_ERROR("Failed to create new eviction fence\n");
> +		return ret;
> +	}
> +
> +	/* Replace fences and free old one */
> +	amdgpu_eviction_fence_update_fence(evf_mgr, new_ef);
> +
> +	/* Attach new eviction fence to BOs */
> +	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {

It's probably better to use drm_exec_for_each_locked() here.

> +		struct amdgpu_bo *bo = bo_va->base.bo;
> +
> +		if (!bo)
> +			continue;
> +
> +		/* Skip pinned BOs */
> +		if (bo->tbo.pin_count)
> +			continue;

Clearly a bad idea, even pinned BOs need the eviction fence because they 
can be unpinned at any time.

> +
> +		ret = amdgpu_eviction_fence_attach(evf_mgr, bo);
> +		if (ret) {
> +			DRM_ERROR("Failed to attch new eviction fence\n");
> +			goto free_err;
> +		}
> +	}
> +
> +	return 0;
> +
> +free_err:
> +	kfree(new_ef);
> +	return ret;
> +}
> +
> +static void
> +amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
> +{
> +	struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
> +	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +	struct drm_exec exec;
> +	struct amdgpu_bo *bo;
> +	int ret;
> +
> +	/* Signal old eviction fence */
> +	ret = amdgpu_eviction_fence_signal(evf_mgr);
> +	if (ret) {
> +		DRM_ERROR("Failed to signal eviction fence err=%d\n", ret);
> +		return;
> +	}
> +
> +	/* Cleanup old eviction fence entry */
> +	amdgpu_eviction_fence_destroy(evf_mgr);

Of hand that looks like a bad idea to me. The eviction fence should 
never become NULL unless the fd is closed.

In general we need to make sure that nothing races here, e.g. we always 
need a defensive ordering.

Something like:
1. Lock all BOs
2. Create new eviction fence,
3. Publish eviction fence in the evf_mgr.
4. Add the eviction fence to the BOs.
5. Drop locks on all BOs.

This way concurrently opening/closing BOs should always see the right 
eviction fence.

Regards,
Christian.

> +
> +	/* Do not replace eviction fence is fd is getting closed */
> +	if (evf_mgr->eviction_allowed)
> +		return;
> +
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret)) {
> +			DRM_ERROR("Failed to lock PD\n");
> +			goto unlock_drm;
> +		}
> +
> +		/* Lock the done list */
> +		list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> +			bo = bo_va->base.bo;
> +			if (!bo) continue;
> +
> +			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unlock_drm;
> +		}
> +	}
> +	/* Replace old eviction fence with new one */
> +	ret = amdgpu_eviction_fence_replace_fence(fpriv);
> +	if (ret)
> +		DRM_ERROR("Failed to replace eviction fence\n");
> +unlock_drm:
> +	drm_exec_fini(&exec);
> +}
> +
> +static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
> +{
> +	struct amdgpu_eviction_fence_mgr *evf_mgr;
> +	struct amdgpu_eviction_fence *ev_fence;
> +	struct amdgpu_userq_mgr *uq_mgr;
> +	struct amdgpu_fpriv *fpriv;
> +
> +	if (!f)
> +		return true;
> +
> +	ev_fence = to_ev_fence(f);
> +	uq_mgr = ev_fence->uq_mgr;
> +	fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	evf_mgr = &fpriv->evf_mgr;
> +
> +	if (uq_mgr->num_userqs)

I don't think you should make that decision here. At least of hand that 
looks racy.

Probably better to always trigger the suspend work in the uq manager.

> +		/* If userqueues are active, suspend userqueues */
> +		schedule_delayed_work(&uq_mgr->suspend_work, 0);
> +	else
> +		/* Else just signal and replace eviction fence */
> +		schedule_delayed_work(&evf_mgr->suspend_work, 0);
> +
> +	return true;
> +}
> +
>   static const struct dma_fence_ops amdgpu_eviction_fence_ops = {
>   	.use_64bit_seqno = true,
>   	.get_driver_name = amdgpu_eviction_fence_get_driver_name,
>   	.get_timeline_name = amdgpu_eviction_fence_get_timeline_name,
> +	.enable_signaling = amdgpu_eviction_fence_enable_signaling,
>   };
>   
>   int amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -59,11 +203,14 @@ struct amdgpu_eviction_fence *
>   amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   {
>   	struct amdgpu_eviction_fence *ev_fence;
> +	struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>   
>   	ev_fence = kzalloc(sizeof(*ev_fence), GFP_KERNEL);
>   	if (!ev_fence)
>   		return NULL;
>   
> +	ev_fence->uq_mgr = uq_mgr;
>   	get_task_comm(ev_fence->timeline_name, current);
>   	spin_lock_init(&ev_fence->lock);
>   	dma_fence_init(&ev_fence->base, &amdgpu_eviction_fence_ops,
> @@ -143,6 +290,8 @@ void amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   		goto unlock;
>   	}
>   
> +	INIT_DELAYED_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
> +
>   unlock:
>   	spin_unlock(&evf_mgr->ev_fence_lock);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index b47ab1307ec5..712fabf09fc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -37,6 +37,8 @@ struct amdgpu_eviction_fence_mgr {
>   	atomic_t		ev_fence_seq;
>   	spinlock_t 		ev_fence_lock;
>   	struct amdgpu_eviction_fence *ev_fence;
> +	struct delayed_work	suspend_work;
> +	bool eviction_allowed;
>   };
>   
>   /* Eviction fence helper functions */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index e7fb13e20197..88f3a885b1dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1434,6 +1434,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>   	struct amdgpu_bo_list *list;
>   	struct amdgpu_bo *pd;
>   	u32 pasid;
> @@ -1466,6 +1467,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   		amdgpu_bo_unreserve(pd);
>   	}
>   
> +	evf_mgr->eviction_allowed = true;
>   	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 614953b0fc19..4cf65aba9a9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -455,10 +455,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	if (r)
>   		goto exec_fini;
>   
> -	for (i = 0; i < num_bo_handles; i++)
> +	/* Save the fence to wait for during suspend */
> +	dma_fence_put(queue->last_fence);
> +	queue->last_fence = dma_fence_get(fence);
> +
> +	for (i = 0; i < num_bo_handles; i++) {
> +		if (!gobj || !gobj[i]->resv)
> +			continue;
> +
>   		dma_resv_add_fence(gobj[i]->resv, fence,
>   				   dma_resv_usage_rw(args->bo_flags &
>   				   AMDGPU_USERQ_BO_WRITE));
> +	}
>   
>   	/* Add the created fence to syncobj/BO's */
>   	for (i = 0; i < num_syncobj_handles; i++)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index ba986d55ceeb..979174f80993 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -22,6 +22,7 @@
>    *
>    */
>   #include <drm/drm_syncobj.h>
> +#include <drm/drm_exec.h>
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
>   #include "amdgpu_userqueue.h"
> @@ -282,6 +283,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>   	amdgpu_bo_unpin(queue->db_obj.obj);
>   	amdgpu_bo_unref(&queue->db_obj.obj);
>   	amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
> +	uq_mgr->num_userqs--;
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   	return 0;
>   }
> @@ -369,6 +371,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   	args->out.queue_id = qid;
> +	uq_mgr->num_userqs++;
>   
>   unlock:
>   	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -402,12 +405,109 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +static int
> +amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	int queue_id, ret;
> +
> +	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
> +
> +	/* Suspend all the queues for this process */
> +	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +		ret = userq_funcs->suspend(uq_mgr, queue);
> +		if (ret)
> +			DRM_ERROR("Failed to suspend queue\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +	int queue_id, ret;
> +
> +	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +		struct dma_fence *f;
> +		struct drm_exec exec;
> +
> +		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +		drm_exec_until_all_locked(&exec) {
> +			f = queue->last_fence;
> +			drm_exec_retry_on_contention(&exec);
> +		}
> +		drm_exec_fini(&exec);
> +
> +		if (!f || dma_fence_is_signaled(f))
> +			continue;
> +		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
> +		if ( ret <= 0) {
> +			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +amdgpu_userqueue_suspend_worker(struct work_struct *work)
> +{
> +	int ret;
> +	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, suspend_work.work);
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
> +
> +	/* Wait for any pending userqueue fence to signal */
> +	ret = amdgpu_userqueue_wait_for_signal(uq_mgr);
> +	if (ret) {
> +		DRM_ERROR("Not suspending userqueue, timeout waiting for work\n");
> +		return;
> +	}
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +	ret = amdgpu_userqueue_suspend_all(uq_mgr);
> +	if (ret) {
> +		DRM_ERROR("Failed to evict userqueue\n");
> +		goto unlock;
> +	}
> +
> +	/* Signal current eviction fence */
> +	ret = amdgpu_eviction_fence_signal(evf_mgr);
> +	if (ret) {
> +		DRM_ERROR("Can't signal eviction fence to suspend\n");
> +		goto unlock;
> +	}
> +
> +	/* Cleanup old eviction fence entry */
> +	amdgpu_eviction_fence_destroy(evf_mgr);
> +
> +unlock:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +}
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
> +	struct amdgpu_fpriv *fpriv;
> +
>   	mutex_init(&userq_mgr->userq_mutex);
>   	idr_init_base(&userq_mgr->userq_idr, 1);
>   	userq_mgr->adev = adev;
> +	userq_mgr->num_userqs = 0;
> +
> +	fpriv = uq_mgr_to_fpriv(userq_mgr);
> +	if (!fpriv->evf_mgr.ev_fence) {
> +		DRM_ERROR("Eviction fence not initialized yet\n");
> +		return -EINVAL;
> +	}
>   
> +	/* This reference is required for suspend work */
> +	fpriv->evf_mgr.ev_fence->uq_mgr = userq_mgr;
> +	INIT_DELAYED_WORK(&userq_mgr->suspend_work, amdgpu_userqueue_suspend_worker);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 37be29048f42..8b3b50fa8b5b 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -27,6 +27,10 @@
>   
>   #define AMDGPU_MAX_USERQ_COUNT 512
>   
> +#define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
> +#define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
> +#define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
> +
>   struct amdgpu_mqd_prop;
>   
>   struct amdgpu_userq_obj {
> @@ -50,6 +54,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_userq_obj wptr_obj;
>   	struct xarray		uq_fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
> +	struct dma_fence	*last_fence;
>   };
>   
>   struct amdgpu_userq_funcs {
> @@ -69,6 +74,9 @@ struct amdgpu_userq_mgr {
>   	struct idr			userq_idr;
>   	struct mutex			userq_mutex;
>   	struct amdgpu_device		*adev;
> +
> +	struct delayed_work		suspend_work;
> +	int num_userqs;
>   };
>   
>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> @@ -86,4 +94,6 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   int amdgpu_userqueue_update_bo_mapping(struct drm_file *filp, struct amdgpu_bo_va *bo_va,
>   				       uint32_t operation, uint32_t syncobj_handle,
>   				       uint64_t point);
> +
> +int amdgpu_userqueue_enable_signaling(struct dma_fence *f);
>   #endif


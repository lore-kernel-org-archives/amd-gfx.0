Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68244C35FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 12:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1804010E475;
	Tue, 17 Sep 2024 12:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EDkOVbNU";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9524910E172
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 12:31:02 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso47940305e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726576261; x=1727181061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JiAb/6TBptFpZcnQvs/BPCkuJ1NHLZmRYUQESMzHGI=;
 b=EDkOVbNU3IOuQdRG1NgcFhBHnTrf/MWheAdHoBmOIaw8l2Cj3lhOy7iknVEhxGX3yT
 6Ta20nhmaCnpxhuM/puRs+URpcQeBelqM8zMDiZGLc+3cWv6kAmRZSWwotRarB99LOyL
 cSz+vgE3MRdiTaYu0lMD8Caga5LIiLVxv13YIwioOCgIAFz/k1D2OwL4+u8OQdCig8Db
 a/aY42QxUjr56WT88y8xKVPqzUeuCX7nwsy/v+GMQrobdjbMROqRMoYLwpghoYUQSEPT
 xzodfDmWw6Hxq468ycvNXuf407sOQbnKFXUbBs+M5w7F7/H3vkl2EjWu5/kGTBlpsHy0
 gHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576261; x=1727181061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JiAb/6TBptFpZcnQvs/BPCkuJ1NHLZmRYUQESMzHGI=;
 b=DKtOoJtgW9aGcvm3V48VoHSiGQrtkWJ2/3kOFtaEr7a2bpUrFp1NrCxxQA7Z9TJDM0
 8MMGkffHdl32gEU3HAQHUX4oebDZkTAK7iWqTt+DASceJ3W58I1knllsxurfF8Xjb475
 4HHxxOw+ORwJsVZyxCd7Mplhfdekp0OAeOBgENTHL6fR5t+x7fIaQOkiH/UasT+TCAJL
 IWqMjVKVVz/rdPPXXi3VnMqQbV5cgm46ieNbjCy1JBJ9iLda4AocfAz0FKPEwpRCxYJC
 RJ4Tl4Gm9jW77tjm7XVGhu0IPtscJ5oZzMKKElOnFLrBYorLSZUzvTdJdenyO2v/AM4M
 pCkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5C+9dzH2GIgiOQTxXSAt66hUQlG3MhvlIZv9zXk2r4VdWymstv+oI0TfkQYqfHT/BpV0ZlCR2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjEVysHVXku8LwdthwekQ1afoOKn83O4qPdU7gC6pH4RXf4ur7
 IwxT1bxLWDSgocgjllAQRV2AY7B4jIQoPnIMqN1XfMkC8SvkDaFW
X-Google-Smtp-Source: AGHT+IHq4rnTlSN2/p2cjnhj1nn4oG4M+VcNgyqlQSImmqTI65pWGzPoeMnpuGu2vEMlXbI2YFkRBQ==
X-Received: by 2002:a05:600c:35c4:b0:42c:b750:19f3 with SMTP id
 5b1f17b1804b1-42cdb444697mr131053835e9.0.1726576260760; 
 Tue, 17 Sep 2024 05:31:00 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b15c1d5sm136216285e9.21.2024.09.17.05.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 05:31:00 -0700 (PDT)
Message-ID: <8a6fc562-277b-4162-ad0d-3ee0f42a55c4@gmail.com>
Date: Tue, 17 Sep 2024 14:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 24/28] drm/amdgpu: resume gfx userqueues
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-20-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240909200614.481-20-shashank.sharma@amd.com>
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
> This patch adds support for userqueue resume. What it typically does is
> this:
> - adds a new delayed work for resuming all the queues.
> - schedules this delayed work from the suspend work.
> - validates the BOs and replaces the eviction fence before resuming all
>    the queues running under this instance of userq manager.
>
> V2: Addressed Christian's review comments:
>      - declare local variables like ret at the bottom.
>      - lock all the object first, then start attaching the new fence.
>      - dont replace old eviction fence, just attach new eviction fence.
>      - no error logs for drm_exec_lock failures
>      - no need to reserve bos after drm_exec_locked
>      - schedule the resume worker immediately (not after 100 ms)
>      - check for NULL BO (Arvind)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 120 ++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>   2 files changed, 121 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 979174f80993..e7f7354e0c0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -405,6 +405,122 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +static int
> +amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	int queue_id, ret;
> +
> +	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
> +
> +	/* Resume all the queues for this process */
> +	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +		ret = userq_funcs->resume(uq_mgr, queue);
> +		if (ret)
> +			DRM_ERROR("Failed to resume queue %d\n", queue_id);
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +	struct drm_exec exec;
> +	struct amdgpu_bo *bo;
> +	int ret;
> +
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret)) {
> +			DRM_ERROR("Failed to lock PD\n");

I would drop those error messages in the low level function.

The most likely cause (except for contention) why locking a BO fails is 
because we were interrupted, and for that we actually don't want to 
print anything.

Apart from that I really need to wrap my head around the VM code once 
more, but that here should probably work for now.

Regards,
Christian.

> +			goto unlock_all;
> +		}
> +
> +		/* Lock the done list */
> +		list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> +			bo = bo_va->base.bo;
> +			if (!bo)
> +				continue;
> +
> +			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unlock_all;
> +		}
> +
> +		/* Lock the invalidated list */
> +		list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> +			bo = bo_va->base.bo;
> +			if (!bo)
> +				continue;
> +
> +			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unlock_all;
> +		}
> +	}
> +
> +	/* Now validate BOs */
> +	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> +		bo = bo_va->base.bo;
> +		if (!bo)
> +			continue;
> +
> +		ret = amdgpu_userqueue_validate_vm_bo(NULL, bo);
> +		if (ret) {
> +			DRM_ERROR("Failed to validate BO\n");
> +			goto unlock_all;
> +		}
> +	}
> +
> +	/* Handle the moved BOs */
> +	ret = amdgpu_vm_handle_moved(uq_mgr->adev, vm, &exec.ticket);
> +	if (ret) {
> +		DRM_ERROR("Failed to handle moved BOs\n");
> +		goto unlock_all;
> +	}
> +
> +	ret = amdgpu_eviction_fence_replace_fence(fpriv);
> +	if (ret)
> +		DRM_ERROR("Failed to replace eviction fence\n");
> +
> +unlock_all:
> +	drm_exec_fini(&exec);
> +	return ret;
> +}
> +
> +static void amdgpu_userqueue_resume_worker(struct work_struct *work)
> +{
> +	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
> +	int ret;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	ret = amdgpu_userqueue_validate_bos(uq_mgr);
> +	if (ret) {
> +		DRM_ERROR("Failed to validate BOs to restore\n");
> +		goto unlock;
> +	}
> +
> +	ret = amdgpu_userqueue_resume_all(uq_mgr);
> +	if (ret) {
> +		DRM_ERROR("Failed to resume all queues\n");
> +		goto unlock;
> +	}
> +
> +unlock:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +}
> +
>   static int
>   amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
>   {
> @@ -486,6 +602,9 @@ amdgpu_userqueue_suspend_worker(struct work_struct *work)
>   	/* Cleanup old eviction fence entry */
>   	amdgpu_eviction_fence_destroy(evf_mgr);
>   
> +	/* Schedule a work to restore userqueue */
> +	schedule_delayed_work(&uq_mgr->resume_work, 0);
> +
>   unlock:
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   }
> @@ -508,6 +627,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>   	/* This reference is required for suspend work */
>   	fpriv->evf_mgr.ev_fence->uq_mgr = userq_mgr;
>   	INIT_DELAYED_WORK(&userq_mgr->suspend_work, amdgpu_userqueue_suspend_worker);
> +	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userqueue_resume_worker);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 8b3b50fa8b5b..d035b5c2b14b 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -76,6 +76,7 @@ struct amdgpu_userq_mgr {
>   	struct amdgpu_device		*adev;
>   
>   	struct delayed_work		suspend_work;
> +	struct delayed_work		resume_work;
>   	int num_userqs;
>   };
>   


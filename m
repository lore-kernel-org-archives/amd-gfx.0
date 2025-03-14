Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B96C28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 07:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF1E10E037;
	Fri, 14 Mar 2025 07:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3OVViPm";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B93E10E037
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:07:21 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso11828595e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741936040; x=1742540840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xavA3HjmkUwRH2HfOgOJXU5JlvSgr85L7GjbNmmoXD0=;
 b=T3OVViPmY4b4MVHJVBGNgH5R8ATWIdn9t9iwUnThR3cKCnC4cYqpQlfs98mSEcwLdo
 covjFJt6MaU8hD1v076ROXXCETvD2occdNU5jBosX0OmAz6dHGFr7vQQv/8QM0QfokO6
 /P+LRacDIDDecx0R6+JeZEIRpi98/vX+Qv20ZA9hOngtNuAyGVu5yIC15dXzP6CxyB/B
 a/B2KtClgTHSB7kNVr4ZIfaz5BcrFe2z/oz/M98B8LyALajSX+pAcn9aLwunrgwa2WfC
 ND3Sy4g69CKGsu9wYSzGwIdunsM+gmq8kgqOAW0Ib3tt98IQVFyqDgNA0bnlyutmosyg
 3dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741936040; x=1742540840;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xavA3HjmkUwRH2HfOgOJXU5JlvSgr85L7GjbNmmoXD0=;
 b=IR4vZ2OSl+up5f5wzFXNUlsKZfFgiuRg8LLLDt7SxdOzE6ugmwVYgZH2zdBRx6t2tm
 +nsXZATbAyQsNrodqywBKkbJwYZXDJWEAXdojQCONqAPt5NyHn5pn+Km1kU2Hdi3nvrJ
 8+vDqvKpO97syPM3aGnkA6pBXgn80xRR7HMzC3278i/pfMC+V0YRz2vGMPZgDkgTWVhm
 YM2aAOQZhOtBCJDHHSzMq3UtosTnCuneWW0b1NhpFKfy/v/moAkzBClMqVMCTrU0gXIA
 fUMUrWVGa5XdmjMhn1+RMJeUQ9dLvf8B979X4LRaii378RpGsbL5xmLMuXcO1BOIBUaT
 acWQ==
X-Gm-Message-State: AOJu0Yxi3RV5c+qPas3ixq18FePmAIvAJWjunqeOK/+rofK/sk7v+tKn
 7sHC0WFAFbcQRQQLdKJ1Ev+XR1aA95Cd+oEKrOqKb856vgHHZntx
X-Gm-Gg: ASbGncvlVxDP+vv0JM8iXygtxSJyPHqnbktCKAD3GE1SRyXtd9ExatWQogZ5O+LhuTR
 CdQPRQAxFm4vsZTK3AjezLR9HWEOPSMAnvOHE+yvXHkX5ft0B//7OA3qEqflbJeucAJvMwHHZnq
 PB8GjMxzondOZaJjNrUeFmx3JNlnbsfbLgfMkS8vb5NS9azrFNJp+dkMGS/NrAkBmIE/WM7MpMt
 lyh7fYtSSjSgxdSrM11FoTtpxSLn0IrPizZuxrw2LeG68FZjcXghoLc0M+lxCfrZo+74DPN7mNd
 uI9/XoZgAyV6KWheA0dcmxyY88o5uPxkftQdIPGWdmqsMiTobg65Na/MoBJ3g7GRakUNo52TjQ=
 =
X-Google-Smtp-Source: AGHT+IHQBKgFwKGzP4gT4cE67w0UVCCA3C9+mJFikpsuOI2EJCsRC6l8ILbCrFZdafZ+qlzNaXbyqg==
X-Received: by 2002:a05:600c:468a:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-43d1ed0e03dmr14487135e9.25.1741936039194; 
 Fri, 14 Mar 2025 00:07:19 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe2a2c8sm7840915e9.23.2025.03.14.00.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 00:07:18 -0700 (PDT)
Message-ID: <081f652a-880e-4bc1-b52a-eb1bf42f8ca6@gmail.com>
Date: Fri, 14 Mar 2025 08:07:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/amdgpu: rework how isolation is enforced v2
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-4-christian.koenig@amd.com>
Content-Language: en-US
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <samuel.pitoiset@gmail.com>
In-Reply-To: <20250307134816.1422-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Siqueira,

as discussed on the call if you can wrap your head around how the amdgpu_device_enforce_isolation() function works it should be trivial to write a new function or extend the function to insert a CPU bubble whenever the ownership of one of the compute rings change.

IIRC we already do load balancing between the 8 available compute rings anyway, so the only part missing is the CPU bubble to ensure that a queue reset only affects a single application.

Regards,
Christian.

Am 07.03.25 um 14:48 schrieb Christian König:
> Limiting the number of available VMIDs to enforce isolation causes some
> issues with gang submit and applying certain HW workarounds which
> require multiple VMIDs to work correctly.
>
> So instead start to track all submissions to the relevant engines in a
> per partition data structure and use the dma_fences of the submissions
> to enforce isolation similar to what a VMID limit does.
>
> v2: use ~0l for jobs without isolation to distinct it from kernel
>     submissions which uses NULL for the owner. Add some warning when we
>     are OOM.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 98 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 43 ++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 16 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c   | 19 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h   |  1 +
>  6 files changed, 155 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 87062c1adcdf..f68a348dcec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1211,9 +1211,15 @@ struct amdgpu_device {
>  	bool                            debug_exp_resets;
>  	bool                            debug_disable_gpu_ring_reset;
>  
> -	bool				enforce_isolation[MAX_XCP];
> -	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
> +	/* Protection for the following isolation structure */
>  	struct mutex                    enforce_isolation_mutex;
> +	bool				enforce_isolation[MAX_XCP];
> +	struct amdgpu_isolation {
> +		void			*owner;
> +		struct dma_fence	*spearhead;
> +		struct amdgpu_sync	active;
> +		struct amdgpu_sync	prev;
> +	} isolation[MAX_XCP];
>  
>  	struct amdgpu_init_level *init_lvl;
>  
> @@ -1499,6 +1505,9 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
>  struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
>  struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>  					    struct dma_fence *gang);
> +struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
> +						  struct amdgpu_ring *ring,
> +						  struct amdgpu_job *job);
>  bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
>  ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
>  ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 337543ec615c..3fa7788b4e12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4272,6 +4272,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->gfx.reset_sem_mutex);
>  	/* Initialize the mutex for cleaner shader isolation between GFX and compute processes */
>  	mutex_init(&adev->enforce_isolation_mutex);
> +	for (i = 0; i < MAX_XCP; ++i) {
> +		adev->isolation[i].spearhead = dma_fence_get_stub();
> +		amdgpu_sync_create(&adev->isolation[i].active);
> +		amdgpu_sync_create(&adev->isolation[i].prev);
> +	}
>  	mutex_init(&adev->gfx.kfd_sch_mutex);
>  
>  	amdgpu_device_init_apu_flags(adev);
> @@ -4770,7 +4775,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  {
> -	int idx;
> +	int i, idx;
>  	bool px;
>  
>  	amdgpu_device_ip_fini(adev);
> @@ -4778,6 +4783,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	amdgpu_ucode_release(&adev->firmware.gpu_info_fw);
>  	adev->accel_working = false;
>  	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
> +	for (i = 0; i < MAX_XCP; ++i) {
> +		dma_fence_put(adev->isolation[i].spearhead);
> +		amdgpu_sync_free(&adev->isolation[i].active);
> +		amdgpu_sync_free(&adev->isolation[i].prev);
> +	}
>  
>  	amdgpu_reset_fini(adev);
>  
> @@ -6913,6 +6923,92 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>  	return NULL;
>  }
>  
> +/**
> + * amdgpu_device_enforce_isolation - enforce HW isolation
> + * @adev: the amdgpu device pointer
> + * @ring: the HW ring the job is supposed to run on
> + * @job: the job which is about to be pushed to the HW ring
> + *
> + * Makes sure that only one client at a time can use the GFX block.
> + * Returns: The dependency to wait on before the job can be pushed to the HW.
> + * The function is called multiple times until NULL is returned.
> + */
> +struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
> +						  struct amdgpu_ring *ring,
> +						  struct amdgpu_job *job)
> +{
> +	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
> +	struct drm_sched_fence *f = job->base.s_fence;
> +	struct dma_fence *dep;
> +	void *owner;
> +	int r;
> +
> +	/*
> +	 * For now enforce isolation only for the GFX block since we only need
> +	 * the cleaner shader on those rings.
> +	 */
> +	if (ring->funcs->type != AMDGPU_RING_TYPE_GFX &&
> +	    ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
> +		return NULL;
> +
> +	/*
> +	 * All submissions where enforce isolation is false are handled as if
> +	 * they come from a single client. Use ~0l as the owner to distinct it
> +	 * from kernel submissions where the owner is NULL.
> +	 */
> +	owner = job->enforce_isolation ? f->owner : (void*)~0l;
> +
> +	mutex_lock(&adev->enforce_isolation_mutex);
> +
> +	/*
> +	 * The "spearhead" submission is the first one which changes the
> +	 * ownership to its client. We always need to wait for it to be
> +	 * pushed to the HW before proceeding with anything.
> +	 */
> +	if (&f->scheduled != isolation->spearhead &&
> +	    !dma_fence_is_signaled(isolation->spearhead)) {
> +		dep = isolation->spearhead;
> +		goto out_grab_ref;
> +	}
> +
> +	if (isolation->owner != owner) {
> +
> +		/*
> +		 * Wait for any gang to be assembled before switching to a
> +		 * different owner or otherwise we could deadlock the
> +		 * submissions.
> +		 */
> +		if (!job->gang_submit) {
> +			dep = amdgpu_device_get_gang(adev);
> +			if (!dma_fence_is_signaled(dep))
> +				goto out_return_dep;
> +			dma_fence_put(dep);
> +		}
> +
> +		dma_fence_put(isolation->spearhead);
> +		isolation->spearhead = dma_fence_get(&f->scheduled);
> +		amdgpu_sync_move(&isolation->active, &isolation->prev);
> +		isolation->owner = owner;
> +	}
> +
> +	/*
> +	 * Specifying the ring here helps to pipeline submissions even when
> +	 * isolation is enabled. If that is not desired for testing NULL can be
> +	 * used instead of the ring to enforce a CPU round trip while switching
> +	 * between clients.
> +	 */
> +	dep = amdgpu_sync_peek_fence(&isolation->prev, ring);
> +	r = amdgpu_sync_fence(&isolation->active, &f->finished, GFP_NOWAIT);
> +	if (r)
> +		DRM_WARN("OOM tracking isolation\n");
> +
> +out_grab_ref:
> +	dma_fence_get(dep);
> +out_return_dep:
> +	mutex_unlock(&adev->enforce_isolation_mutex);
> +	return dep;
> +}
> +
>  bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev)
>  {
>  	switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 56d27cea052e..92ab821afc06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -287,40 +287,27 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>  	    (*id)->flushed_updates < updates ||
>  	    !(*id)->last_flush ||
>  	    ((*id)->last_flush->context != fence_context &&
> -	     !dma_fence_is_signaled((*id)->last_flush))) {
> +	     !dma_fence_is_signaled((*id)->last_flush)))
> +		needs_flush = true;
> +
> +	if ((*id)->owner != vm->immediate.fence_context ||
> +	    (!adev->vm_manager.concurrent_flush && needs_flush)) {
>  		struct dma_fence *tmp;
>  
> -		/* Wait for the gang to be assembled before using a
> -		 * reserved VMID or otherwise the gang could deadlock.
> +		/* Don't use per engine and per process VMID at the
> +		 * same time
>  		 */
> -		tmp = amdgpu_device_get_gang(adev);
> -		if (!dma_fence_is_signaled(tmp) && tmp != job->gang_submit) {
> +		if (adev->vm_manager.concurrent_flush)
> +			ring = NULL;
> +
> +		/* to prevent one context starved by another context */
> +		(*id)->pd_gpu_addr = 0;
> +		tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
> +		if (tmp) {
>  			*id = NULL;
> -			*fence = tmp;
> +			*fence = dma_fence_get(tmp);
>  			return 0;
>  		}
> -		dma_fence_put(tmp);
> -
> -		/* Make sure the id is owned by the gang before proceeding */
> -		if (!job->gang_submit ||
> -		    (*id)->owner != vm->immediate.fence_context) {
> -
> -			/* Don't use per engine and per process VMID at the
> -			 * same time
> -			 */
> -			if (adev->vm_manager.concurrent_flush)
> -				ring = NULL;
> -
> -			/* to prevent one context starved by another context */
> -			(*id)->pd_gpu_addr = 0;
> -			tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
> -			if (tmp) {
> -				*id = NULL;
> -				*fence = dma_fence_get(tmp);
> -				return 0;
> -			}
> -		}
> -		needs_flush = true;
>  	}
>  
>  	/* Good we can use this VMID. Remember this submission as
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 5537c8bfd227..1a6cfef4c071 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -360,17 +360,24 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
>  {
>  	struct amdgpu_ring *ring = to_amdgpu_ring(s_entity->rq->sched);
>  	struct amdgpu_job *job = to_amdgpu_job(sched_job);
> -	struct dma_fence *fence = NULL;
> +	struct dma_fence *fence;
>  	int r;
>  
>  	r = drm_sched_entity_error(s_entity);
>  	if (r)
>  		goto error;
>  
> -	if (job->gang_submit)
> +	if (job->gang_submit) {
>  		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
> +		if (fence)
> +			return fence;
> +	}
> +
> +	fence = amdgpu_device_enforce_isolation(ring->adev, ring, job);
> +	if (fence)
> +		return fence;
>  
> -	if (!fence && job->vm && !job->vmid) {
> +	if (job->vm && !job->vmid) {
>  		r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
>  		if (r) {
>  			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
> @@ -383,9 +390,10 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
>  		 */
>  		if (!fence)
>  			job->vm = NULL;
> +		return fence;
>  	}
>  
> -	return fence;
> +	return NULL;
>  
>  error:
>  	dma_fence_set_error(&job->base.s_fence->finished, r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index bfe12164d27d..c5f9db6b32a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -405,6 +405,25 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
>  	return 0;
>  }
>  
> +/**
> + * amdgpu_sync_move - move all fences from src to dst
> + *
> + * @src: source of the fences, empty after function
> + * @dst: destination for the fences
> + *
> + * Moves all fences from source to destination. All fences in destination are
> + * freed and source is empty after the function call.
> + */
> +void amdgpu_sync_move(struct amdgpu_sync *src, struct amdgpu_sync *dst)
> +{
> +	unsigned int i;
> +
> +	amdgpu_sync_free(dst);
> +
> +	for (i = 0; i < HASH_SIZE(src->fences); ++i)
> +		hlist_move_list(&src->fences[i], &dst->fences[i]);
> +}
> +
>  /**
>   * amdgpu_sync_push_to_job - push fences into job
>   * @sync: sync object to get the fences from
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> index 1504f5e7fc46..51eb4382c91e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> @@ -57,6 +57,7 @@ struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
>  				     struct amdgpu_ring *ring);
>  struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
>  int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone);
> +void amdgpu_sync_move(struct amdgpu_sync *src, struct amdgpu_sync *dst);
>  int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job);
>  int amdgpu_sync_wait(struct amdgpu_sync *sync, bool intr);
>  void amdgpu_sync_free(struct amdgpu_sync *sync);


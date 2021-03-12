Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA8CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 09:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC3064FF5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 09:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC3064FF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B8B6F512;
	Fri, 12 Mar 2021 09:21:38 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2E46F512
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 09:21:36 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id h10so6928871edt.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 01:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=fQH1DeHWLKxaBPKf+3WHZ8CP4QGx9xUv/XibynvUsJ0=;
 b=YWiyrREMoDFgj2+5pSkwZ6NiIlv8NNk7oICPV/Ak4LR0b3Ghsw3OAIs1KkceHiy8yL
 EnOFa76y9+icaw2oZN2zu7fYnLIghAR5H2uHHvYrXzZoWR7QBXdQZzMfGYtUHNep27SK
 kVMk0HzbprZYQJi4TXZoEPeinQlVongq5HwnwpRgfIA0XAERsT08BpKxzDIuRQJZzj6q
 wRZZk4WtsF8QbsaN/w7mv+PasA1V4irekeTTu+aQnL/gNErF1ugFM+NGRElNS5IqVY7l
 FLi/cwEejiymiCEX4dgWX9DLo2JGLdNDSOnKQjiQhaXeh9cg70fQORFBYQ/PYHC50Uu9
 +h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fQH1DeHWLKxaBPKf+3WHZ8CP4QGx9xUv/XibynvUsJ0=;
 b=stm2BncwyXkvLBZk37KfuLB6g7xLsrJFoFIzTW9DOBjLa7p66Fy9s5dcVtl4eYsEwE
 qu/P5wEmO+VVgz4RpGd8PhtOu9sqpCPKyChmBQaZ822rxV3lC54u2rZ2kb0dKnXT3A4I
 Qo8dO/adPoeOV4ma+O4sS/nhgg5UWMlvZassKueR9mIn/OVh0rtwKufXGsZRCXV5HK2b
 VkPxwF/txRV34drx92kdKuygksOMhFhcmUn7MTytsLT6RVmXAFsb9CE2tJlFxyjtlqKM
 LWKWXeV9gKPmdprIe8cs+DphlVCBkb9CpXX3GnV7f3l7U3NLHgmlj+gO8cj8OX91TERu
 hxkA==
X-Gm-Message-State: AOAM533fWunjYI+ClPDbKquRLe0ZyIgsmtbJ8T33+XcgF/b0nI4+A62O
 lauYDTH1gD6BRXxs97uupl/pXuDtEeA=
X-Google-Smtp-Source: ABdhPJxs20s59h77fmEpM7fIbdK7NpT9Ht38WMb9lfYt/5ATlyXrIhAitlRVp7D3RVgbds8gjccOyw==
X-Received: by 2002:a50:e80c:: with SMTP id e12mr13172776edn.229.1615540894913; 
 Fri, 12 Mar 2021 01:21:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:2108:8a72:3f15:1a1f?
 ([2a02:908:1252:fb60:2108:8a72:3f15:1a1f])
 by smtp.gmail.com with ESMTPSA id y17sm2484487ejf.116.2021.03.12.01.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 01:21:34 -0800 (PST)
Subject: Re: [PATCH v8] drm/amd/amdgpu implement tdr advanced mode
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com, Andrey.Grodzovsky@amd.com, Monk.Liu@amd.com,
 Emily.Deng@amd.com
References: <20210311153751.1065528-1-Jack.Zhang1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9e79c9f3-71f5-436d-ce46-9180586615aa@gmail.com>
Date: Fri, 12 Mar 2021 10:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311153751.1065528-1-Jack.Zhang1@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jack,

the scheduler changes become to invasive.

You should split that patch up into two. The first one to make the 
scheduler changes and the second one using them in amdgpu.

Christian.

Am 11.03.21 um 16:37 schrieb Jack Zhang:
> [Why]
> Previous tdr design treats the first job in job_timeout as the bad job.
> But sometimes a later bad compute job can block a good gfx job and
> cause an unexpected gfx job timeout because gfx and compute ring share
> internal GC HW mutually.
>
> [How]
> This patch implements an advanced tdr mode.It involves an additinal
> synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
> step in order to find the real bad job.
>
> 1. At Step0 Resubmit stage, it synchronously submits and pends for the
> first job being signaled. If it gets timeout, we identify it as guilty
> and do hw reset. After that, we would do the normal resubmit step to
> resubmit left jobs.
>
> 2. For whole gpu reset(vram lost), do resubmit as the old way.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  74 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 103 ++++++++++++++-------
>   include/drm/gpu_scheduler.h                |   3 +
>   4 files changed, 149 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..01352ed725d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4617,6 +4617,73 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +void amdgpu_device_correct_karma(struct amdgpu_device *adev,
> +			       struct amdgpu_hive_info *hive,
> +			       struct list_head *device_list_handle,
> +			       bool *need_full_reset)
> +{
> +	int i, r = 0;
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		int ret = 0;
> +		struct drm_sched_job *s_job;
> +
> +		if (!ring || !ring->sched.thread)
> +			continue;
> +
> +		s_job = list_first_entry_or_null(&ring->sched.pending_list,
> +				struct drm_sched_job, list);
> +		if (s_job == NULL)
> +			continue;
> +
> +		/* clear job's guilty and depend the folowing step to decide the real one */
> +		drm_sched_reset_karma(s_job);
> +		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
> +
> +		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> +		if (ret == 0) { /* timeout */
> +			DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
> +						ring->sched.name, s_job->id);
> +
> +			/* set guilty */
> +			drm_sched_increase_karma(s_job);
> +retry:
> +			/* do hw reset */
> +			if (amdgpu_sriov_vf(adev)) {
> +				amdgpu_virt_fini_data_exchange(adev);
> +				r = amdgpu_device_reset_sriov(adev, false);
> +				if (r)
> +					adev->asic_reset_res = r;
> +			} else {
> +				r  = amdgpu_do_asic_reset(hive, device_list_handle,
> +						need_full_reset, false);
> +				if (r && r == -EAGAIN)
> +					goto retry;
> +			}
> +
> +			/*
> +			 * add reset counter so that the following
> +			 * resubmitted job could flush vmid
> +			 */
> +			atomic_inc(&adev->gpu_reset_counter);
> +			continue;
> +		}
> +
> +		/* got the hw fence, signal finished fence */
> +		atomic_dec(&ring->sched.num_jobs);
> +		dma_fence_get(&s_job->s_fence->finished);
> +		dma_fence_signal(&s_job->s_fence->finished);
> +		dma_fence_put(&s_job->s_fence->finished);
> +
> +		/* remove node from list and free the job */
> +		spin_lock(&ring->sched.job_list_lock);
> +		list_del_init(&s_job->node);
> +		spin_unlock(&ring->sched.job_list_lock);
> +		ring->sched.ops->free_job(s_job);
> +	}
> +}
> +
>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>    *
> @@ -4639,6 +4706,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> +	int tmp_vram_lost_counter;
>   
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
> @@ -4788,6 +4856,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4874,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Post ASIC reset for all devs .*/
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>   
> +		if (amdgpu_gpu_recovery == 2 &&
> +			!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)))
> +			amdgpu_device_correct_karma(tmp_adev, hive,
> +					device_list_handle, &need_full_reset);
> +
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 865f924772b0..9c3f4edb7532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>    * DOC: gpu_recovery (int)
>    * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>    */
> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>   
>   /**
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index d82a7ebf6099..92d8de24d0a1 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -361,40 +361,16 @@ static void drm_sched_job_timedout(struct work_struct *work)
>     */
>   void drm_sched_increase_karma(struct drm_sched_job *bad)
>   {
> -	int i;
> -	struct drm_sched_entity *tmp;
> -	struct drm_sched_entity *entity;
> -	struct drm_gpu_scheduler *sched = bad->sched;
> -
> -	/* don't increase @bad's karma if it's from KERNEL RQ,
> -	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
> -	 * corrupt but keep in mind that kernel jobs always considered good.
> -	 */
> -	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> -		atomic_inc(&bad->karma);
> -		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> -		     i++) {
> -			struct drm_sched_rq *rq = &sched->sched_rq[i];
> -
> -			spin_lock(&rq->lock);
> -			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> -				if (bad->s_fence->scheduled.context ==
> -				    entity->fence_context) {
> -					if (atomic_read(&bad->karma) >
> -					    bad->sched->hang_limit)
> -						if (entity->guilty)
> -							atomic_set(entity->guilty, 1);
> -					break;
> -				}
> -			}
> -			spin_unlock(&rq->lock);
> -			if (&entity->list != &rq->entities)
> -				break;
> -		}
> -	}
> +	drm_sched_increase_karma_ext(bad, 1);
>   }
>   EXPORT_SYMBOL(drm_sched_increase_karma);
>   
> +void drm_sched_reset_karma(struct drm_sched_job *bad)
> +{
> +	drm_sched_increase_karma_ext(bad, 0);
> +}
> +EXPORT_SYMBOL(drm_sched_reset_karma);
> +
>   /**
>    * drm_sched_stop - stop the scheduler
>    *
> @@ -533,15 +509,32 @@ EXPORT_SYMBOL(drm_sched_start);
>    *
>    */
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
> +{
> +	drm_sched_resubmit_jobs_ext(sched, INT_MAX);
> +}
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> +
> +/**
> + * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
> + *
> + * @sched: scheduler instance
> + * @max: job numbers to relaunch
> + *
> + */
> +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max)
>   {
>   	struct drm_sched_job *s_job, *tmp;
>   	uint64_t guilty_context;
>   	bool found_guilty = false;
>   	struct dma_fence *fence;
> +	int i = 0;
>   
>   	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
>   		struct drm_sched_fence *s_fence = s_job->s_fence;
>   
> +		if (i >= max)
> +			break;
> +
>   		if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
>   			found_guilty = true;
>   			guilty_context = s_job->s_fence->scheduled.context;
> @@ -552,6 +545,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
>   
>   		dma_fence_put(s_job->s_fence->parent);
>   		fence = sched->ops->run_job(s_job);
> +		i++;
>   
>   		if (IS_ERR_OR_NULL(fence)) {
>   			if (IS_ERR(fence))
> @@ -563,7 +557,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
>   		}
>   	}
>   }
> -EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs_ext);
>   
>   /**
>    * drm_sched_job_init - init a scheduler job
> @@ -903,3 +897,48 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
>   	sched->ready = false;
>   }
>   EXPORT_SYMBOL(drm_sched_fini);
> +
> +/**
> + * drm_sched_increase_karma_ext - Update sched_entity guilty flag
> + *
> + * @bad: The job guilty of time out
> + * @type: type for increase/reset karma
> + *
> + */
> +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type)
> +{
> +	int i;
> +	struct drm_sched_entity *tmp;
> +	struct drm_sched_entity *entity;
> +	struct drm_gpu_scheduler *sched = bad->sched;
> +
> +	/* don't change @bad's karma if it's from KERNEL RQ,
> +	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
> +	 * corrupt but keep in mind that kernel jobs always considered good.
> +	 */
> +	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> +		if (type == 0)
> +			atomic_set(&bad->karma, 0);
> +		else if (type == 1)
> +			atomic_inc(&bad->karma);
> +
> +		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> +		     i++) {
> +			struct drm_sched_rq *rq = &sched->sched_rq[i];
> +
> +			spin_lock(&rq->lock);
> +			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> +				if (bad->s_fence->scheduled.context ==
> +				    entity->fence_context) {
> +					if (entity->guilty)
> +						atomic_set(entity->guilty, type);
> +					break;
> +				}
> +			}
> +			spin_unlock(&rq->lock);
> +			if (&entity->list != &rq->entities)
> +				break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(drm_sched_increase_karma_ext);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 1c815e0a14ed..4ea8606d91fe 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -321,7 +321,10 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
>   void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery);
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
> +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max);
>   void drm_sched_increase_karma(struct drm_sched_job *bad);
> +void drm_sched_reset_karma(struct drm_sched_job *bad);
> +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type);
>   bool drm_sched_dependency_optimized(struct dma_fence* fence,
>   				    struct drm_sched_entity *entity);
>   void drm_sched_fault(struct drm_gpu_scheduler *sched);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00214C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 12:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A264810E36D;
	Thu, 27 Apr 2023 12:05:22 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA5210E36D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 12:05:20 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-953343581a4so1283773866b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682597119; x=1685189119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y5bCqHrLVo9EjWP6cJmj4rq86gW/YmwdtcE0XB84c2M=;
 b=KIJrBfhQpIsyjsTDJEJ+6QwO4yR+02AZ55dXg7wVtPfBvk8r/R2TzaRirnjJhtf+ad
 ek5e8ukJQ20gUbhkA21xDTfqFE5xTdB5FrinDQCO6awI5g76kOw9DRq03GNj0SMLNYZN
 pGyNC5UHadJLSgwBrz+AgfLcfnzsqUn+y+CPV3QBSmlHdoN0CXbs3ifz8A6bhxQCJmTy
 cR49uFOMJ9cApotK/8X3SkgXuKM5ORu0V2Xhm+4Sa5eHL4AAFPw08jOdyRXRrmERO97P
 5FV38tvTgpkaK1zrGjFVT3q9KmJQQNpRNbqCBrk0JeVPepQPcAe9GPfpejiJey4rZguU
 vAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682597119; x=1685189119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5bCqHrLVo9EjWP6cJmj4rq86gW/YmwdtcE0XB84c2M=;
 b=ROUR3wD94vWPltPNi8RrFLPKjj/jAK8ohSgh909Nxe/Ch18Q6IXm/fy63tOTUhzchI
 t49TuDxV4Mmcew+bH8qVjpqL5mTXsOj8Igapzv0T3H7ynFwiGQcwRtCY3dXflZEmd4oS
 TM9mh+TjZDYj1fIBSUT5TEtUW6MYgdB4XeZYRkE82ojk2BURZ37Q6oGJo1nKPVwSeU2B
 81LTkmPoQP0d+CeDg+HY8WpXmRAAmqq+k0TfnsVd+K3BdFiYHMVBE1qJU15OlYw0P+cz
 vjoyLGXxr/JaN/Pj24m4p/1zHivmsJJ5EpDk9jFNykZknrsFNj/fnNSFokHfC5pFfvdq
 gtqQ==
X-Gm-Message-State: AC+VfDxYefm4mNZ+m9M7II/OeEHv4PKtG9BHgRj1SMZOUces332nB3DL
 VT1shoQn+X1xgKe3uPkJ8Tok2SQskMs=
X-Google-Smtp-Source: ACHHUZ6r60XuUhtFa048/Y4KyWNm435+R3TnnbecE/6VxdGYwwJ/0k5+IVt0z/Y3TURrni4LRUQswA==
X-Received: by 2002:a17:907:e87:b0:94a:74b8:7a79 with SMTP id
 ho7-20020a1709070e8700b0094a74b87a79mr1379580ejc.59.1682597118658; 
 Thu, 27 Apr 2023 05:05:18 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a1709065e0200b00951755d0c79sm9613615eju.104.2023.04.27.05.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Apr 2023 05:05:17 -0700 (PDT)
Message-ID: <50b0e9e2-aa8b-395e-1d01-7a5803f6d001@gmail.com>
Date: Thu, 27 Apr 2023 14:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
Content-Language: en-US
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230420115752.31470-1-christian.koenig@amd.com>
 <MN2PR12MB366335107BF4587FC0907B91E96A9@MN2PR12MB3663.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MN2PR12MB366335107BF4587FC0907B91E96A9@MN2PR12MB3663.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: "Chen, JingWen \(Wayne\)" <JingWen.Chen2@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well good point, but as part of the effort of the Intel team to move the 
scheduler over to a work item based design those two functions are 
probably about to be removed.

Since we will probably have that in the internal package for a bit 
longer I'm going to send a fix for this.

Regards,
Christian.

Am 27.04.23 um 12:35 schrieb Yin, ZhenGuo (Chris):
> [AMD Official Use Only - General]
>
> Hi, Christian
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index fcd4bfef7415..649fac2e1ccb 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>   			r = dma_fence_add_callback(fence, &s_job->cb,
>   						   drm_sched_job_done_cb);
>   			if (r == -ENOENT)
> -				drm_sched_job_done(s_job);
> +				drm_sched_job_done(s_job, fence->error);
>   			else if (r)
>   				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>   					  r);
>   		} else
> -			drm_sched_job_done(s_job);
> +			drm_sched_job_done(s_job, 0);
>   	}
>   
>   	if (full_recovery) {
>
> I believe that the finished fence of some skipped jobs during FLR HASN'T been set to -ECANCELED.
> In function drm_sched_stop, the callback has been removed from hw_fence and s_fence->parent has been set to NULL, see commit 45ecaea738830b9d521c93520c8f201359dcbd95(drm/sched: Partial revert of 'drm/sched: Keep s_fence->parent pointer').
> In functnion drm_sched_start, jobs in the pending list pretend to be done without any errors(drm_sched_job_done(s_job, 0)).
>
>
> Best,
> Zhenguo
> Cloud-GPU Core team, SRDC
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian König
> Sent: Thursday, April 20, 2023 7:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>
> Subject: [PATCH 1/8] drm/scheduler: properly forward fence errors
>
> When a hw fence is signaled with an error properly forward that to the finished fence.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c |  4 +---  drivers/gpu/drm/scheduler/sched_fence.c  |  4 +++-
>   drivers/gpu/drm/scheduler/sched_main.c   | 18 ++++++++----------
>   include/drm/gpu_scheduler.h              |  2 +-
>   4 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 15d04a0ec623..eaf71fe15ed3 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -144,7 +144,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)  {
>   	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
>   
> -	drm_sched_fence_finished(job->s_fence);
> +	drm_sched_fence_finished(job->s_fence, -ESRCH);
>   	WARN_ON(job->s_fence->parent);
>   	job->sched->ops->free_job(job);
>   }
> @@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
>   	while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
>   		struct drm_sched_fence *s_fence = job->s_fence;
>   
> -		dma_fence_set_error(&s_fence->finished, -ESRCH);
> -
>   		dma_fence_get(&s_fence->finished);
>   		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
>   					   drm_sched_entity_kill_jobs_cb)) diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index 7fd869520ef2..1a6bea98c5cc 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence)
>   	dma_fence_signal(&fence->scheduled);
>   }
>   
> -void drm_sched_fence_finished(struct drm_sched_fence *fence)
> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int
> +result)
>   {
> +	if (result)
> +		dma_fence_set_error(&fence->finished, result);
>   	dma_fence_signal(&fence->finished);
>   }
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index fcd4bfef7415..649fac2e1ccb 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
>    *
>    * Finish the job's fence and wake up the worker thread.
>    */
> -static void drm_sched_job_done(struct drm_sched_job *s_job)
> +static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
>   {
>   	struct drm_sched_fence *s_fence = s_job->s_fence;
>   	struct drm_gpu_scheduler *sched = s_fence->sched; @@ -268,7 +268,7 @@ static void drm_sched_job_done(struct drm_sched_job *s_job)
>   	trace_drm_sched_process_job(s_fence);
>   
>   	dma_fence_get(&s_fence->finished);
> -	drm_sched_fence_finished(s_fence);
> +	drm_sched_fence_finished(s_fence, result);
>   	dma_fence_put(&s_fence->finished);
>   	wake_up_interruptible(&sched->wake_up_worker);
>   }
> @@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct dma_fence *f, struct dma_fence_cb *cb)  {
>   	struct drm_sched_job *s_job = container_of(cb, struct drm_sched_job, cb);
>   
> -	drm_sched_job_done(s_job);
> +	drm_sched_job_done(s_job, f->error);
>   }
>   
>   /**
> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>   			r = dma_fence_add_callback(fence, &s_job->cb,
>   						   drm_sched_job_done_cb);
>   			if (r == -ENOENT)
> -				drm_sched_job_done(s_job);
> +				drm_sched_job_done(s_job, fence->error);
>   			else if (r)
>   				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>   					  r);
>   		} else
> -			drm_sched_job_done(s_job);
> +			drm_sched_job_done(s_job, 0);
>   	}
>   
>   	if (full_recovery) {
> @@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)
>   			r = dma_fence_add_callback(fence, &sched_job->cb,
>   						   drm_sched_job_done_cb);
>   			if (r == -ENOENT)
> -				drm_sched_job_done(sched_job);
> +				drm_sched_job_done(sched_job, fence->error);
>   			else if (r)
>   				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>   					  r);
>   		} else {
> -			if (IS_ERR(fence))
> -				dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
> -
> -			drm_sched_job_done(sched_job);
> +			drm_sched_job_done(sched_job, IS_ERR(fence) ?
> +					   PTR_ERR(fence) : 0);
>   		}
>   
>   		wake_up(&sched->job_scheduled);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h index ca857ec9e7eb..5c1df6b12ced 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -569,7 +569,7 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,  void drm_sched_fence_free(struct drm_sched_fence *fence);
>   
>   void drm_sched_fence_scheduled(struct drm_sched_fence *fence); -void drm_sched_fence_finished(struct drm_sched_fence *fence);
> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int
> +result);
>   
>   unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);  void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
> --
> 2.34.1


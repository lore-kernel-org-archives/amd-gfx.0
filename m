Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD927C33CB3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 14:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947A6214AF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 14:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+rRMgTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947A6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DBE6EA1B;
	Wed, 15 Jan 2020 14:35:40 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5266EA1B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 14:35:39 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id x66so1304553ybb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 06:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=SxZvxzdQHVz6n2yYFim2x/kz0n+8XGYux0haLatkBU4=;
 b=V+rRMgTSV1HfFNGA9PheXzVqHBGk2lEz99KUAtteK5JN7ldxjkIdkNkZpRAgUppu/5
 RzYetYz+MYo6xo8jfFgStuIHdnSjmUyZduVdxj3Unzl2F7YXewhU9YhUG8CPjFQ7jZ46
 V3IBYocQoNZKHNFIN6ioNhlV6dPrwBvWgfPFGszEhJ+4InqXWmnP/LL+WlLY9YKwPnHd
 Q8wq9/CId9zCfSRaZTmdWA/7f+V4h+xn7pvinYXQLy7ekMFYPzHn4fjYxu/md4yg00/6
 Xr5OxDQjr9UC3BJx1fpmN80o7e9kYYT6B97i4U614RdsvCsPoYRCyq+bHuWeQgfdf1Oq
 FY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=SxZvxzdQHVz6n2yYFim2x/kz0n+8XGYux0haLatkBU4=;
 b=oI+KXt7asLQfangAvbdwQOGllVU2iL1ahSqTznpj7/LVbzlvCSsR6y3v5urQvtUXkK
 ZbEENXzGhUS7gCUeH2ppk+y5te7bYVzbvJgkdWUpfiTS/g8IE0SKfp5cxzwjeHnzbo31
 nE0m8csGISbjXcDqJ6m2g7SUdTMoHj2AOjHEXnoSakKjNRpeTl+DOstMX+5Wlcv0J9Cz
 672iHGE/aXJEru+jzZ7YJ217mSzD2qizSFR2KRn54DsbqAR2GglDfh0VxZR8+zixj6iO
 bKGjgHOr+CMoD1LXnQ0Pjw8iqsgaTW6XjIgwvf4CtLJ6kEQy0uKLpGurfciihTYEN4ks
 rGHw==
X-Gm-Message-State: APjAAAVDVZTa1bXoRdjDuLpTmpEONjOGs3GIRPufW6GZbvdH3tHFShZo
 oVlSiGKOuOqVPkl0wgXkpg8=
X-Google-Smtp-Source: APXvYqyRc+EMQzIQ7LAjeFBXdwlFcS/QSC01rlnfmpvGsW1QdHfTQQsvbC+fywuq8WlioggrFEHTCA==
X-Received: by 2002:a25:868d:: with SMTP id z13mr17163779ybk.265.1579098938383; 
 Wed, 15 Jan 2020 06:35:38 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g5sm8614247ywk.46.2020.01.15.06.35.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jan 2020 06:35:38 -0800 (PST)
Subject: Re: [PATCH] drm/scheduler: improve job distribution with multiple
 queues
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200115141632.4928-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ae88cee6-9ce0-f24e-5ac3-9818f0019a35@gmail.com>
Date: Wed, 15 Jan 2020 15:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200115141632.4928-1-nirmoy.das@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.20 um 15:16 schrieb Nirmoy Das:
> This patch uses score based logic to select a new rq for better
> loadbalance between multiple rq/scheds instead of num_jobs.
>
> Below are test results after running amdgpu_test from mesa drm
>
> Before this patch:
>
> sched_name     num of many times it got scheduled
> =========      ==================================
> sdma0          314
> sdma1          32
> comp_1.0.0     56
> comp_1.0.1     0
> comp_1.1.0     0
> comp_1.1.1     0
> comp_1.2.0     0
> comp_1.2.1     0
> comp_1.3.0     0
> comp_1.3.1     0
> After this patch:
>
> sched_name     num of many times it got scheduled
> =========      ==================================
> sdma0          218
> sdma1          211
> comp_1.0.0     39
> comp_1.0.1     9
> comp_1.1.0     12
> comp_1.1.1     0
> comp_1.2.0     12
> comp_1.2.1     0
> comp_1.3.0     12
> comp_1.3.1     0
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 9 ++++-----
>   drivers/gpu/drm/scheduler/sched_main.c   | 5 +++--
>   include/drm/gpu_scheduler.h              | 6 +++---
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 2e3a058fc239..7120eeec1a9b 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -130,7 +130,7 @@ static struct drm_sched_rq *
>   drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
>   {
>   	struct drm_sched_rq *rq = NULL;
> -	unsigned int min_jobs = UINT_MAX, num_jobs;
> +	unsigned int min_score = UINT_MAX, num_score;
>   	int i;
>   
>   	for (i = 0; i < entity->num_sched_list; ++i) {
> @@ -141,9 +141,9 @@ drm_sched_entity_get_free_sched(struct drm_sched_entity *entity)
>   			continue;
>   		}
>   
> -		num_jobs = atomic_read(&sched->num_jobs);
> -		if (num_jobs < min_jobs) {
> -			min_jobs = num_jobs;
> +		num_score = atomic_read(&sched->score);
> +		if (num_score < min_score) {
> +			min_score = num_score;
>   			rq = &entity->sched_list[i]->sched_rq[entity->priority];
>   		}
>   	}
> @@ -498,7 +498,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
>   	bool first;
>   
>   	trace_drm_sched_job(sched_job, entity);
> -	atomic_inc(&entity->rq->sched->num_jobs);
>   	WRITE_ONCE(entity->last_user, current->group_leader);
>   	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 3fad5876a13f..f58a0e04ef2b 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -92,6 +92,7 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
>   	if (!list_empty(&entity->list))
>   		return;
>   	spin_lock(&rq->lock);
> +	atomic_inc(&rq->sched->score);
>   	list_add_tail(&entity->list, &rq->entities);
>   	spin_unlock(&rq->lock);
>   }
> @@ -110,6 +111,7 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>   	if (list_empty(&entity->list))
>   		return;
>   	spin_lock(&rq->lock);
> +	atomic_dec(&rq->sched->score);
>   	list_del_init(&entity->list);
>   	if (rq->current_entity == entity)
>   		rq->current_entity = NULL;
> @@ -655,7 +657,6 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
>   	struct drm_gpu_scheduler *sched = s_fence->sched;
>   
>   	atomic_dec(&sched->hw_rq_count);
> -	atomic_dec(&sched->num_jobs);

Please keep incrementing/decrementing the score when jobs are 
added/completed.

In other words we should have +1 score for each entity and +1 score for 
each job in the scheduler.

Apart form that looks good to me now.

Thanks,
Christian.

>   
>   	trace_drm_sched_process_job(s_fence);
>   
> @@ -830,7 +831,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>   	spin_lock_init(&sched->job_list_lock);
>   	atomic_set(&sched->hw_rq_count, 0);
>   	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
> -	atomic_set(&sched->num_jobs, 0);
> +	atomic_set(&sched->score, 0);
>   	atomic64_set(&sched->job_id_count, 0);
>   
>   	/* Each scheduler will run on a seperate kernel thread */
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 96a1a1b7526e..eda58b22cf76 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -261,7 +261,7 @@ struct drm_sched_backend_ops {
>    * @job_list_lock: lock to protect the ring_mirror_list.
>    * @hang_limit: once the hangs by a job crosses this limit then it is marked
>    *              guilty and it will be considered for scheduling further.
> - * @num_jobs: the number of jobs in queue in the scheduler
> + * @score: score to help loadbalancer pick a most idle sched
>    * @ready: marks if the underlying HW is ready to work
>    * @free_guilty: A hit to time out handler to free the guilty job.
>    *
> @@ -282,8 +282,8 @@ struct drm_gpu_scheduler {
>   	struct list_head		ring_mirror_list;
>   	spinlock_t			job_list_lock;
>   	int				hang_limit;
> -	atomic_t                        num_jobs;
> -	bool			ready;
> +	atomic_t                        score;
> +	bool				ready;
>   	bool				free_guilty;
>   };
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

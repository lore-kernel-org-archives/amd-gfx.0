Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AED7C77B76
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 13:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D609810E0EE;
	Fri, 21 Apr 2023 13:27:09 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5609B10E0EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 13:27:07 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-506767f97f8so2792459a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682083623; x=1684675623;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BRn4TmyiQUuR9juD1qaP+niWpKgFKsYofsLpS3FyWGk=;
 b=QWlv6++fUdqBYv0wFy+xPW/c2ymDR0a6r+VHjPr7EF9DRPzBQBr8jG0f8KwbpzeEy1
 CFhRSDRqUJQhgbTrPDgxB8TvvvGUnHENhVevvvVb2LkTXQePqK1mhBsBOESzZaogSCTA
 7vCWS1ZNV9GFeBEDYFzpkl2ACkaEeFNvIW1IIq5Czx9Zt5oj2f6FF/SEorJh9Al1K3Mz
 JThx1Py1RfHdcqS5eW/k/PPWSsMTaC6mw1G8ggtqWOWwogSJE7dYIkDbpbHqWBjaiG7J
 D3XtdIJacvE9S9QNhDs/NkqeqRrlw1yamb/xFQwn6BTqyobZIgrwLINV5mFZlVS+K6bl
 S32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682083623; x=1684675623;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BRn4TmyiQUuR9juD1qaP+niWpKgFKsYofsLpS3FyWGk=;
 b=BCB66h8ea0iHDpX3wQDIrknRlv1kvM8AoTl+YlOB1q0WCDfU4OCvxVC27j6yuG2k91
 kXFchr2dnypisxMoWs/w8WchcXaA3tWNmUJZv1wYCxkI/q8OjsO/rh8dueHWVVmS/tEv
 5roj0ZoXzQdpTKyqjahZ9kUmPSaooAoKx2MULkRLaMWiFHNInyK2gIcQByiAjq7Qm+Ef
 JZAc4w27Q9QPpAlcZ/JpEKzPYZlu9dLtAzwQyRWijRw9MpJvyvKDVcF8zOv0C4ETxeCA
 JO3HG3mLmNemeeqyKV1NbThBwxtpDztCkDZxbhQkdAiqIjfps3B9npduAv0aMWFM1Hsj
 UFoQ==
X-Gm-Message-State: AAQBX9flVJ7cIVZQ39dGF1yCnIMykbeVrALZqygkfIrll30BWZyMsrw2
 i+/Clm4/VN5bY/jqSNuvV9v3C74ZpI8=
X-Google-Smtp-Source: AKy350Ygd/9cok98cZBQTzynOSSqj9ex6C9OS80V7FNDV8uUAOMxUNUYGYCUABd/k9/48IWI5R0DyQ==
X-Received: by 2002:a05:6402:1849:b0:504:b313:5898 with SMTP id
 v9-20020a056402184900b00504b3135898mr5154482edy.27.1682083622981; 
 Fri, 21 Apr 2023 06:27:02 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:b9f1:4015:2594:f62d?
 ([2a02:908:1256:79a0:b9f1:4015:2594:f62d])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a170906bc4c00b00947ed087a2csm2060710ejv.154.2023.04.21.06.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Apr 2023 06:27:02 -0700 (PDT)
Message-ID: <99c31d32-05e2-70bc-c6fc-216eb2832d14@gmail.com>
Date: Fri, 21 Apr 2023 15:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, Alex Deucher <Alexander.Deucher@amd.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
 <3d5dc70c-982a-8d86-cab2-f205c90c869d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3d5dc70c-982a-8d86-cab2-f205c90c869d@amd.com>
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Alex can I merge that through drm-misc-next or do we really need 
amd-staging-drm-next?

Christian.

Am 21.04.23 um 07:22 schrieb Luben Tuikov:
> Hi Christian,
>
> Thanks for working on this.
>
> Series is,
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>
> Regards,
> Luben
>
> On 2023-04-20 07:57, Christian König wrote:
>> When a hw fence is signaled with an error properly forward that to the
>> finished fence.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c |  4 +---
>>   drivers/gpu/drm/scheduler/sched_fence.c  |  4 +++-
>>   drivers/gpu/drm/scheduler/sched_main.c   | 18 ++++++++----------
>>   include/drm/gpu_scheduler.h              |  2 +-
>>   4 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 15d04a0ec623..eaf71fe15ed3 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -144,7 +144,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
>>   {
>>   	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
>>   
>> -	drm_sched_fence_finished(job->s_fence);
>> +	drm_sched_fence_finished(job->s_fence, -ESRCH);
>>   	WARN_ON(job->s_fence->parent);
>>   	job->sched->ops->free_job(job);
>>   }
>> @@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>   	while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
>>   		struct drm_sched_fence *s_fence = job->s_fence;
>>   
>> -		dma_fence_set_error(&s_fence->finished, -ESRCH);
>> -
>>   		dma_fence_get(&s_fence->finished);
>>   		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
>>   					   drm_sched_entity_kill_jobs_cb))
>> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
>> index 7fd869520ef2..1a6bea98c5cc 100644
>> --- a/drivers/gpu/drm/scheduler/sched_fence.c
>> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
>> @@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence)
>>   	dma_fence_signal(&fence->scheduled);
>>   }
>>   
>> -void drm_sched_fence_finished(struct drm_sched_fence *fence)
>> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int result)
>>   {
>> +	if (result)
>> +		dma_fence_set_error(&fence->finished, result);
>>   	dma_fence_signal(&fence->finished);
>>   }
>>   
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index fcd4bfef7415..649fac2e1ccb 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
>>    *
>>    * Finish the job's fence and wake up the worker thread.
>>    */
>> -static void drm_sched_job_done(struct drm_sched_job *s_job)
>> +static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
>>   {
>>   	struct drm_sched_fence *s_fence = s_job->s_fence;
>>   	struct drm_gpu_scheduler *sched = s_fence->sched;
>> @@ -268,7 +268,7 @@ static void drm_sched_job_done(struct drm_sched_job *s_job)
>>   	trace_drm_sched_process_job(s_fence);
>>   
>>   	dma_fence_get(&s_fence->finished);
>> -	drm_sched_fence_finished(s_fence);
>> +	drm_sched_fence_finished(s_fence, result);
>>   	dma_fence_put(&s_fence->finished);
>>   	wake_up_interruptible(&sched->wake_up_worker);
>>   }
>> @@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct dma_fence *f, struct dma_fence_cb *cb)
>>   {
>>   	struct drm_sched_job *s_job = container_of(cb, struct drm_sched_job, cb);
>>   
>> -	drm_sched_job_done(s_job);
>> +	drm_sched_job_done(s_job, f->error);
>>   }
>>   
>>   /**
>> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>>   			r = dma_fence_add_callback(fence, &s_job->cb,
>>   						   drm_sched_job_done_cb);
>>   			if (r == -ENOENT)
>> -				drm_sched_job_done(s_job);
>> +				drm_sched_job_done(s_job, fence->error);
>>   			else if (r)
>>   				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>>   					  r);
>>   		} else
>> -			drm_sched_job_done(s_job);
>> +			drm_sched_job_done(s_job, 0);
>>   	}
>>   
>>   	if (full_recovery) {
>> @@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)
>>   			r = dma_fence_add_callback(fence, &sched_job->cb,
>>   						   drm_sched_job_done_cb);
>>   			if (r == -ENOENT)
>> -				drm_sched_job_done(sched_job);
>> +				drm_sched_job_done(sched_job, fence->error);
>>   			else if (r)
>>   				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>>   					  r);
>>   		} else {
>> -			if (IS_ERR(fence))
>> -				dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
>> -
>> -			drm_sched_job_done(sched_job);
>> +			drm_sched_job_done(sched_job, IS_ERR(fence) ?
>> +					   PTR_ERR(fence) : 0);
>>   		}
>>   
>>   		wake_up(&sched->job_scheduled);
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index ca857ec9e7eb..5c1df6b12ced 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -569,7 +569,7 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>>   void drm_sched_fence_free(struct drm_sched_fence *fence);
>>   
>>   void drm_sched_fence_scheduled(struct drm_sched_fence *fence);
>> -void drm_sched_fence_finished(struct drm_sched_fence *fence);
>> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int result);
>>   
>>   unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
>>   void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,


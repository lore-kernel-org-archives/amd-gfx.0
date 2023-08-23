Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FD7EE49AE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 08:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AEA10E3EF;
	Wed, 23 Aug 2023 08:26:45 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1A410E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 08:26:43 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so8519217e87.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692779201; x=1693384001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oL27Ntop31PJ0tswr79zLAtR2yk9HmK3VQn45DQMZYI=;
 b=K7A77NgCcsl+A4ysg0kz4NsLFlPIwjk3cKZb12TtE+JT4aWQTphMEpluC+89z7gecW
 BC0zV0cato40Zg5TDmp5NFWE6Wg3fm1HpmQwbB0Dcd30i2DQ5IvY4c5GOgyw/IDh/j8D
 Qwfi55UdF2Omu7VwOLgjUoUV6acCTFtE461joHjw2ikF9CxyDT+nvSegfqYiey0JKJZe
 feNNnp6/MzJ+XDYgMrrdtSeIiZRRi7yar5ELSZNY/W1kxhI40/JUDLdh67rs7ODfDLiM
 4ELckOdzEP/VXinylulQYppJZAay8uLKgxMMJYM7Na5tSTOwqRNQueAZDmWwAJEKnb0f
 TsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692779201; x=1693384001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oL27Ntop31PJ0tswr79zLAtR2yk9HmK3VQn45DQMZYI=;
 b=fXtVd7WBtvrOW5C7Klx0WPKwhj535N8erwR8egczPJ0pqUQfu4LZGvopjofYDnZ3MN
 U/RgJ80uSL9VC+sjjSshcHGPg9AZnP08/yM7ePXD8aW3ewgiPYA13mcbMnqEI2FEM4Ac
 V2LEr3pvrb/FHHGwaGyTLhEdwymkObY5qXxpNszShRzm9mjHEqyl+86e5ovB+w1jicF7
 8nwxv3YNR4FilJv1SeyLrjy0RzRQFse/V/z5NB2WJfjklsrLsH8mEANR1rBsMRvnyDJN
 e6hTcWtA1h/VLPykHeq9TvJGtbv/kxkgRqdb2sBO3hGm/jJ5Zj9QWNQQAKcr6HuoKLQA
 XQQw==
X-Gm-Message-State: AOJu0YzqWdPtxr53NB7bym1Zs/b4pwGCK6hnqlhRlLvFTIk9XZKiSBk6
 S13NccV5h78OT7BxXbakLww=
X-Google-Smtp-Source: AGHT+IEf/zzY5+154+MdfMkKwhxUmM5PMzj1Je+1MiiVg36jMVlTQDzroIr8uHiukcclnd892oOBmw==
X-Received: by 2002:a05:6512:159a:b0:4f8:6e52:68ae with SMTP id
 bp26-20020a056512159a00b004f86e5268aemr10908806lfb.31.1692779201184; 
 Wed, 23 Aug 2023 01:26:41 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.58.217])
 by smtp.gmail.com with ESMTPSA id
 r26-20020aa7d59a000000b005233609e39dsm2058767edq.30.2023.08.23.01.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 01:26:40 -0700 (PDT)
Message-ID: <035ef607-586d-2575-f4e7-18fc3441656e@gmail.com>
Date: Wed, 23 Aug 2023 10:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
Content-Language: en-US
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230420115752.31470-1-christian.koenig@amd.com>
 <MN2PR12MB366335107BF4587FC0907B91E96A9@MN2PR12MB3663.namprd12.prod.outlook.com>
 <50b0e9e2-aa8b-395e-1d01-7a5803f6d001@gmail.com>
 <MN2PR12MB366340150244829826D4E2F1E91AA@MN2PR12MB3663.namprd12.prod.outlook.com>
 <MN2PR12MB3663410CE5E153F94A865B8CE91CA@MN2PR12MB3663.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MN2PR12MB3663410CE5E153F94A865B8CE91CA@MN2PR12MB3663.namprd12.prod.outlook.com>
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
 Luben" <Luben.Tuikov@amd.com>, "cao, lin" <lin.cao@amd.com>, "Li,
 Chong\(Alan\)" <Chong.Li@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was fixed here:

commit 03877d621db082610c9b7602c6e8cd6ebcb75a8f
Author: Christian König <christian.koenig@amd.com>
Date:   Thu Apr 27 14:05:43 2023 +0200

     drm/scheduler: mark jobs without fence as canceled

     When no hw fence is provided for a job that means that the job 
didn't executed.

     Signed-off-by: Christian König <christian.koenig@amd.com>
     Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
     Link: 
https://patchwork.freedesktop.org/patch/msgid/20230427122726.1290170-1-christian.koenig@amd.com

Could be that the patch hasn't been merged into the internal branches yet.

Regards,
Christian.

Am 23.08.23 um 10:12 schrieb Yin, ZhenGuo (Chris):
> [AMD Official Use Only - General]
>
> Ping..
>
> Actually, I prepare a patch aiming to fix this issue.
> But I'm not sure whether this is proper for drm/scheduler.
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 9654e8942382..35dc0b86a18e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -463,6 +463,7 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
>                                                &s_job->cb)) {
>                          dma_fence_put(s_job->s_fence->parent);
>                          s_job->s_fence->parent = NULL;
> +                       dma_fence_set_error(&s_job->s_fence->finished, -EHWPOISON);
>                          atomic_dec(&sched->hw_rq_count);
>                  } else {
>                          /*
> Best,
> Zhenguo
> Cloud-GPU Core team, SRDC
>
> -----Original Message-----
> From: Yin, ZhenGuo (Chris)
> Sent: Thursday, August 17, 2023 4:17 PM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, JingWen (Wayne) <JingWen.Chen2@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Li, Chong(Alan) <chong.li@amd.com>; cao, lin <lin.cao@amd.com>
> Subject: RE: [PATCH 1/8] drm/scheduler: properly forward fence errors
>
> Hi, @Christian König
>
> Any updates for the fix?
> Recently we found that there will be a page fault after FLR, since an SDMA job in the pending list was dropped without forwarding fence errors.
>
>
> Best,
> Zhenguo
> Cloud-GPU Core team, SRDC
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Thursday, April 27, 2023 8:05 PM
> To: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, JingWen (Wayne) <JingWen.Chen2@amd.com>; Liu, Monk <Monk.Liu@amd.com>
> Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
>
> Well good point, but as part of the effort of the Intel team to move the scheduler over to a work item based design those two functions are probably about to be removed.
>
> Since we will probably have that in the internal package for a bit longer I'm going to send a fix for this.
>
> Regards,
> Christian.
>
> Am 27.04.23 um 12:35 schrieb Yin, ZhenGuo (Chris):
>> [AMD Official Use Only - General]
>>
>> Hi, Christian
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index fcd4bfef7415..649fac2e1ccb 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>>                        r = dma_fence_add_callback(fence, &s_job->cb,
>>                                                   drm_sched_job_done_cb);
>>                        if (r == -ENOENT)
>> -                             drm_sched_job_done(s_job);
>> +                             drm_sched_job_done(s_job, fence->error);
>>                        else if (r)
>>                                DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>>                                          r);
>>                } else
>> -                     drm_sched_job_done(s_job);
>> +                     drm_sched_job_done(s_job, 0);
>>        }
>>
>>        if (full_recovery) {
>>
>> I believe that the finished fence of some skipped jobs during FLR HASN'T been set to -ECANCELED.
>> In function drm_sched_stop, the callback has been removed from hw_fence and s_fence->parent has been set to NULL, see commit 45ecaea738830b9d521c93520c8f201359dcbd95(drm/sched: Partial revert of 'drm/sched: Keep s_fence->parent pointer').
>> In functnion drm_sched_start, jobs in the pending list pretend to be done without any errors(drm_sched_job_done(s_job, 0)).
>>
>>
>> Best,
>> Zhenguo
>> Cloud-GPU Core team, SRDC
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Christian König
>> Sent: Thursday, April 20, 2023 7:58 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Subject: [PATCH 1/8] drm/scheduler: properly forward fence errors
>>
>> When a hw fence is signaled with an error properly forward that to the finished fence.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>    drivers/gpu/drm/scheduler/sched_entity.c |  4 +---  drivers/gpu/drm/scheduler/sched_fence.c  |  4 +++-
>>    drivers/gpu/drm/scheduler/sched_main.c   | 18 ++++++++----------
>>    include/drm/gpu_scheduler.h              |  2 +-
>>    4 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
>> b/drivers/gpu/drm/scheduler/sched_entity.c
>> index 15d04a0ec623..eaf71fe15ed3 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -144,7 +144,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)  {
>>        struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
>>
>> -     drm_sched_fence_finished(job->s_fence);
>> +     drm_sched_fence_finished(job->s_fence, -ESRCH);
>>        WARN_ON(job->s_fence->parent);
>>        job->sched->ops->free_job(job);
>>    }
>> @@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
>>        while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
>>                struct drm_sched_fence *s_fence = job->s_fence;
>>
>> -             dma_fence_set_error(&s_fence->finished, -ESRCH);
>> -
>>                dma_fence_get(&s_fence->finished);
>>                if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
>>                                           drm_sched_entity_kill_jobs_cb)) diff --git
>> a/drivers/gpu/drm/scheduler/sched_fence.c
>> b/drivers/gpu/drm/scheduler/sched_fence.c
>> index 7fd869520ef2..1a6bea98c5cc 100644
>> --- a/drivers/gpu/drm/scheduler/sched_fence.c
>> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
>> @@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct drm_sched_fence *fence)
>>        dma_fence_signal(&fence->scheduled);
>>    }
>>
>> -void drm_sched_fence_finished(struct drm_sched_fence *fence)
>> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int
>> +result)
>>    {
>> +     if (result)
>> +             dma_fence_set_error(&fence->finished, result);
>>        dma_fence_signal(&fence->finished);
>>    }
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index fcd4bfef7415..649fac2e1ccb 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
>>     *
>>     * Finish the job's fence and wake up the worker thread.
>>     */
>> -static void drm_sched_job_done(struct drm_sched_job *s_job)
>> +static void drm_sched_job_done(struct drm_sched_job *s_job, int
>> +result)
>>    {
>>        struct drm_sched_fence *s_fence = s_job->s_fence;
>>        struct drm_gpu_scheduler *sched = s_fence->sched; @@ -268,7 +268,7 @@ static void drm_sched_job_done(struct drm_sched_job *s_job)
>>        trace_drm_sched_process_job(s_fence);
>>
>>        dma_fence_get(&s_fence->finished);
>> -     drm_sched_fence_finished(s_fence);
>> +     drm_sched_fence_finished(s_fence, result);
>>        dma_fence_put(&s_fence->finished);
>>        wake_up_interruptible(&sched->wake_up_worker);
>>    }
>> @@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct dma_fence *f, struct dma_fence_cb *cb)  {
>>        struct drm_sched_job *s_job = container_of(cb, struct
>> drm_sched_job, cb);
>>
>> -     drm_sched_job_done(s_job);
>> +     drm_sched_job_done(s_job, f->error);
>>    }
>>
>>    /**
>> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
>>                        r = dma_fence_add_callback(fence, &s_job->cb,
>>                                                   drm_sched_job_done_cb);
>>                        if (r == -ENOENT)
>> -                             drm_sched_job_done(s_job);
>> +                             drm_sched_job_done(s_job, fence->error);
>>                        else if (r)
>>                                DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>>                                          r);
>>                } else
>> -                     drm_sched_job_done(s_job);
>> +                     drm_sched_job_done(s_job, 0);
>>        }
>>
>>        if (full_recovery) {
>> @@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)
>>                        r = dma_fence_add_callback(fence, &sched_job->cb,
>>                                                   drm_sched_job_done_cb);
>>                        if (r == -ENOENT)
>> -                             drm_sched_job_done(sched_job);
>> +                             drm_sched_job_done(sched_job, fence->error);
>>                        else if (r)
>>                                DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
>>                                          r);
>>                } else {
>> -                     if (IS_ERR(fence))
>> -                             dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
>> -
>> -                     drm_sched_job_done(sched_job);
>> +                     drm_sched_job_done(sched_job, IS_ERR(fence) ?
>> +                                        PTR_ERR(fence) : 0);
>>                }
>>
>>                wake_up(&sched->job_scheduled);
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index ca857ec9e7eb..5c1df6b12ced 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -569,7 +569,7 @@ void drm_sched_fence_init(struct drm_sched_fence
>> *fence,  void drm_sched_fence_free(struct drm_sched_fence *fence);
>>
>>    void drm_sched_fence_scheduled(struct drm_sched_fence *fence); -void
>> drm_sched_fence_finished(struct drm_sched_fence *fence);
>> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int
>> +result);
>>
>>    unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler
>> *sched);  void drm_sched_resume_timeout(struct drm_gpu_scheduler
>> *sched,
>> --
>> 2.34.1


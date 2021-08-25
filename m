Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7DCC432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DC8610E6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0DC8610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C4E89B3C;
	Wed, 25 Aug 2021 12:11:34 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FDD89B3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 12:11:32 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id q14so1951117wrp.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=mb3sLH05zqQYNH7EzM+CKwfa5h/sgNNkMGi0P0eRii0=;
 b=tOlw4b4lQUmijFKDMK3Ym043M65axtIReqH/2yR2vCnYzj//yuxzFUXpl+EMixurnM
 j1IFVLd/peF8nxFkw1UgXRV9OxO/BdySpMnX33pgOehqwP+wBkEF5HueQdUgI5pHC0XU
 Froq6yTc7CVaf/0D7Hqxt0bUhB+DKB6Wp/qVLl5f36FhxVBOvMkKoZGvRn3ndbMtML/o
 xb46EpISkEAgrKFGD7Bt1lxrD1Eh6t7EXTEFq3jPg4bVpT+4VE+meVsGX9rMMox85gkq
 afnl4LtgPBlSqe6eZPwN9eZAmRMGmVI5UdCXXmOfdnJyhYRnhhVv60tCcfCwD+XTYSPA
 nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mb3sLH05zqQYNH7EzM+CKwfa5h/sgNNkMGi0P0eRii0=;
 b=s/HitLFbVfhXUzcMV6Eig+oQepMsLZ27vPDxdz4Yu8jdmoNit3kT5+pH+N4f/5eelI
 UEPirS3JBMn64UnV8EIA8Dhfdbb/pusxTW/G6k0knfXrk7L2NQkpYoKA+7kKyJaD22K4
 3sT7QzvbUDW3YlV9kzHOKjIGf+subeQMm4qx5K+w9WUxKV0YZtpymIGIa1tIs5uFPIuD
 D4UWc8WFS/XqfYPXYnxQUh+BPYyGmh6TVoYl1aVkP5YqlTElBx6WMPjAtLeUu5bJajYo
 qM0G/AQPBCweTk2QatxNWet2xy6poLphcizIzZ6+Cq6AKZpMoS6LfKFM4FFDGzLV4ycq
 L+NQ==
X-Gm-Message-State: AOAM532qLX4iohH0lpwJqitHcNOM/TBm0oMX4s9UlA8FJAvtkOLiKiWE
 q/QoBw7zjqg+6HSL3a7t/jBnTxGZIrAwjmnY
X-Google-Smtp-Source: ABdhPJxMSt0Soro2srHF8lY27T4rMbTAufcpEG88hxVVT5KZ8quL7bwbB+T0FUqSSq4Knp5qVMMFWA==
X-Received: by 2002:a05:6000:124f:: with SMTP id
 j15mr8310833wrx.101.1629893491483; 
 Wed, 25 Aug 2021 05:11:31 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id r1sm254549wmh.17.2021.08.25.05.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Aug 2021 05:11:30 -0700 (PDT)
Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation(v2)
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
 <1ef452fc-1f76-8dda-1c74-c540576fe6c6@gmail.com>
 <BL1PR12MB5269567906F233C0B938C32C84C69@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB5269E736907243FDF42D97F384C69@BL1PR12MB5269.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fff92742-6d09-430d-1dd6-5e0bb7f6a311@gmail.com>
Date: Wed, 25 Aug 2021 14:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BL1PR12MB5269E736907243FDF42D97F384C69@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No, this would break that logic here.

See drm_sched_start_timeout() can be called multiple times, this is 
intentional and very important!

The logic in queue_delayed_work() makes sure that the timer is only 
started once and then never again.

All we need to take care of is to cancel_delayed_work() when we know 
that the job is completed.

This here works as intended as far as I can see and if you start to use 
mod_delayed_work() you actually break it.

Regards,
Christian.

Am 25.08.21 um 14:01 schrieb Liu, Monk:
> [AMD Official Use Only]
>
> I think we should remove the cancel_delayed_work() in the beginning of the cleanup_job().
>
> Because by my patch the "mode_delayed_work" in cleanup_job is already doing its duty to retrigger the TO timer accordingly
>
> Thanks
>
> ------------------------------------------
> Monk Liu | Cloud-GPU Core team
> ------------------------------------------
>
> -----Original Message-----
> From: Liu, Monk
> Sent: Wednesday, August 25, 2021 7:55 PM
> To: 'Christian König' <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/sched: fix the bug of time out calculation(v2)
>
> [AMD Official Use Only]
>
>>> The timeout started by queue_delayed_work() in drm_sched_start_timeout() is paired with the cancel_delayed_work() in drm_sched_get_cleanup_job().
> No that's wrong, see that when we are in cleanup_job(), assume we do not have timeout on this sched (we are just keep submitting new jobs to this sched), Then the work_tdr is cancelled, and then we get the heading job, and let's assume the job is not signaled, then we run to the "queue timeout for next job" thus drm_sched_start_timeout() is called, so this heading job's TO timer is actually retriggered ... which is totally wrong.
>
> With my patch the timer is already retriggered after previous JOB really signaled.
>
> Can you be more specific on the incorrect part ?
>
> Thanks
> ------------------------------------------
> Monk Liu | Cloud-GPU Core team
> ------------------------------------------
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Wednesday, August 25, 2021 2:32 PM
> To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation(v2)
>
> Well NAK to that approach. First of all your bug analyses is incorrect.
>
> The timeout started by queue_delayed_work() in drm_sched_start_timeout() is paired with the cancel_delayed_work() in drm_sched_get_cleanup_job().
>
> So you must have something else going on here.
>
> Then please don't use mod_delayed_work(), instead always cancel it and restart it.
>
> Regards,
> Christian.
>
> Am 25.08.21 um 06:14 schrieb Monk Liu:
>> the original logic is wrong that the timeout will not be retriggerd
>> after the previous job siganled, and that lead to the scenario that
>> all jobs in the same scheduler shares the same timeout timer from the
>> very begining job in this scheduler which is wrong.
>>
>> we should modify the timer everytime a previous job signaled.
>>
>> v2:
>> further cleanup the logic, and do the TDR timer cancelling if the
>> signaled job is the last one in its scheduler.
>>
>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>> ---
>>    drivers/gpu/drm/scheduler/sched_main.c | 29 ++++++++++++++++++++---------
>>    1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index a2a9536..8c102ac 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -305,8 +305,17 @@ static void drm_sched_job_begin(struct drm_sched_job *s_job)
>>    	struct drm_gpu_scheduler *sched = s_job->sched;
>>    
>>    	spin_lock(&sched->job_list_lock);
>> -	list_add_tail(&s_job->list, &sched->pending_list);
>> -	drm_sched_start_timeout(sched);
>> +	if (list_empty(&sched->pending_list)) {
>> +		list_add_tail(&s_job->list, &sched->pending_list);
>> +		drm_sched_start_timeout(sched);
>> +	} else {
>> +		/* the old jobs in pending list are not finished yet
>> +		 * no need to restart TDR timer here, it is already
>> +		 * handled by drm_sched_get_cleanup_job
>> +		 */
>> +		list_add_tail(&s_job->list, &sched->pending_list);
>> +	}
>> +
>>    	spin_unlock(&sched->job_list_lock);
>>    }
>>    
>> @@ -693,17 +702,22 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>>    	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>>    		/* remove job from pending_list */
>>    		list_del_init(&job->list);
>> +
>>    		/* make the scheduled timestamp more accurate */
>>    		next = list_first_entry_or_null(&sched->pending_list,
>>    						typeof(*next), list);
>> -		if (next)
>> +		if (next) {
>> +			/* if we still have job in pending list we need modify the TDR timer */
>> +			mod_delayed_work(system_wq, &sched->work_tdr, sched->timeout);
>>    			next->s_fence->scheduled.timestamp =
>>    				job->s_fence->finished.timestamp;
>> +		} else {
>> +			/* cancel the TDR timer if no job in pending list */
>> +			cancel_delayed_work(&sched->work_tdr);
>> +		}
>>    
>>    	} else {
>>    		job = NULL;
>> -		/* queue timeout for next job */
>> -		drm_sched_start_timeout(sched);
>>    	}
>>    
>>    	spin_unlock(&sched->job_list_lock);
>> @@ -791,11 +805,8 @@ static int drm_sched_main(void *param)
>>    					  (entity = drm_sched_select_entity(sched))) ||
>>    					 kthread_should_stop());
>>    
>> -		if (cleanup_job) {
>> +		if (cleanup_job)
>>    			sched->ops->free_job(cleanup_job);
>> -			/* queue timeout for next job */
>> -			drm_sched_start_timeout(sched);
>> -		}
>>    
>>    		if (!entity)
>>    			continue;


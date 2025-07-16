Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1501C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 20:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D2210E3C8;
	Wed, 16 Jul 2025 20:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iFuHGNnz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BA910E2BB;
 Wed, 16 Jul 2025 20:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RLK6FEnm0hvLnrj85LWZZ8JQjRffonZXKM+V8Caxf+8=; b=iFuHGNnzseuJbuCL+IRM1UoQS/
 EPxG0hry/mCJhO1rZKEjqv3bIBgbALivq8sPmQPboUuz7pCqi21/vb3j+2U6OOP30VeN6yD/Dbiup
 xepYemoqffnKFylUQ1UXQWVyye7bzsMM5AWlV7Jvz6r9wmG6Mlb5Yi+q8VrTHLUKJinw351G6r4qv
 FKLUU/+G0RXo7HU3c93wLMi8Biq3CTSKcZ4ggAhDO2WbIqaYswoFkgC/XhkzSC1LPBH5LWDM0hoSg
 7ZR4XoopA/no0mNS4eP65lC3+Oy2jFp7xdf1WSoFBN0rHTCWE4nAyc64CZk0I3/RPDO4zkB4JKYef
 ceoGxjbA==;
Received: from [187.36.210.68] (helo=[192.168.1.103])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1uc8zD-00HTyk-KI; Wed, 16 Jul 2025 22:44:20 +0200
Message-ID: <c1c9bb53-399d-4f1a-a6de-8cf354c2e903@igalia.com>
Date: Wed, 16 Jul 2025 17:44:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Avoid double re-lock on the job free path
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
References: <20250716085117.56864-1-tvrtko.ursulin@igalia.com>
 <8e527b62-d968-4bc3-a0dc-491d193c02ce@igalia.com>
 <52d32846-0286-4979-ab2f-c1aa1aa02e20@igalia.com>
 <f535c0bf-225a-40c9-b6a1-5bfbb5ebec0d@igalia.com>
 <b5ff1fba-0e2c-4d02-8b9d-49c3c313e65d@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <b5ff1fba-0e2c-4d02-8b9d-49c3c313e65d@igalia.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Tvrtko,

On 16/07/25 11:46, Tvrtko Ursulin wrote:
> 
> On 16/07/2025 15:30, Maíra Canal wrote:
>> Hi Tvrtko,
>>
>> On 16/07/25 10:49, Tvrtko Ursulin wrote:
>>>
>>> On 16/07/2025 14:31, Maíra Canal wrote:
>>>> Hi Tvrtko,
>>>>
>>>> On 16/07/25 05:51, Tvrtko Ursulin wrote:
>>>>> Currently the job free work item will lock sched->job_list_lock 
>>>>> first time
>>>>> to see if there are any jobs, free a single job, and then lock 
>>>>> again to
>>>>> decide whether to re-queue itself if there are more finished jobs.
>>>>>
>>>>> Since drm_sched_get_finished_job() already looks at the second job 
>>>>> in the
>>>>> queue we can simply add the signaled check and have it return the 
>>>>> presence
>>>>> of more jobs to be freed to the caller. That way the work item does 
>>>>> not
>>>>> have to lock the list again and repeat the signaled check.
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>> Cc: Maíra Canal <mcanal@igalia.com>
>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>>> ---
>>>>> v2:
>>>>>   * Improve commit text and kerneldoc. (Philipp)
>>>>>   * Rename run free work helper. (Philipp)
>>>>>
>>>>> v3:
>>>>>   * Rebase on top of Maira's changes.
>>>>> ---
>>>>>   drivers/gpu/drm/scheduler/sched_main.c | 53 +++++++++ 
>>>>> +----------------
>>>>>   1 file changed, 21 insertions(+), 32 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/ 
>>>>> drm/ scheduler/sched_main.c
>>>>> index e2cda28a1af4..5a550fd76bf0 100644
>>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>>> @@ -349,34 +349,13 @@ static void drm_sched_run_job_queue(struct 
>>>>> drm_gpu_scheduler *sched)
>>>>>   }
>>>>>   /**
>>>>> - * __drm_sched_run_free_queue - enqueue free-job work
>>>>> - * @sched: scheduler instance
>>>>> - */
>>>>> -static void __drm_sched_run_free_queue(struct drm_gpu_scheduler 
>>>>> *sched)
>>>>> -{
>>>>> -    if (!READ_ONCE(sched->pause_submit))
>>>>> -        queue_work(sched->submit_wq, &sched->work_free_job);
>>>>> -}
>>>>> -
>>>>> -/**
>>>>> - * drm_sched_run_free_queue - enqueue free-job work if ready
>>>>> + * drm_sched_run_free_queue - enqueue free-job work
>>>>>    * @sched: scheduler instance
>>>>>    */
>>>>>   static void drm_sched_run_free_queue(struct drm_gpu_scheduler 
>>>>> *sched)
>>>>>   {
>>>>> -    struct drm_sched_job *job;
>>>>> -
>>>>> -    job = list_first_entry_or_null(&sched->pending_list,
>>>>> -                       struct drm_sched_job, list);
>>>>> -    if (job && dma_fence_is_signaled(&job->s_fence->finished))
>>>>> -        __drm_sched_run_free_queue(sched);
>>>>
>>>> I believe we'd still need this chunk for DRM_GPU_SCHED_STAT_NO_HANG
>>>> (check the comment in drm_sched_job_reinsert_on_false_timeout()). How
>>>
>>> You mean the "is there a signaled job in the list check" is needed 
>>> for drm_sched_job_reinsert_on_false_timeout()? Hmm why? Worst case is 
>>> a false positive wakeup on the free worker, no?
>>
>> Correct me if I'm mistaken, we would also have a false positive wake-up
>> on the run_job worker, which I believe it could be problematic in the
>> cases that we skipped the reset because the job is still running.
> 
> Run job worker exits when it sees no free credits so I don't think there 
> is a problem. What am I missing?
> 

I was the one missing the code in `drm_sched_can_queue()`. Sorry for the
misleading comments. This is:

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra




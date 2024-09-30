Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C0DCE8349
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 13:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A235010E4F6;
	Mon, 30 Sep 2024 13:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hxzHkpfc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010CA10E4A0;
 Mon, 30 Sep 2024 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xy8Ha5b/dO5/HqKI95anmi16BefC7jwgdT9CNwJ8M9Q=; b=hxzHkpfcDQnN8mlJq/XrfhGG53
 M97kza/e+Nx5uyz58sqzHnbJJiCu9JwkhT/tRqMxIMe/WtNsIm5Rr+xD2ZhpdKVOCPRkC9Ps0OEoM
 JJuSN0TPiLfvnfUNe5O3raNFqj4v4Ut38wX0AMoKMyUU7+DoynupVqxGX6bIAviVORgUMgonDxioz
 bxReESWF8GTQHdYT5VWZ9W8GCumJ+rs+FWxDhKKaf5pznIkgXQHjjKfwMrQpwIVN4P/mP9yBixDnf
 u7zHM8DQx4fv4Sb443fzijen0imamX2OrtFj6D7dnclvPjhCnd7nFl2jdLT/QtF0wJ22CvZft3a82
 pX9+EUew==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1svGM9-002rgQ-J9; Mon, 30 Sep 2024 15:22:29 +0200
Message-ID: <2b0860a2-5ef0-496f-9283-d5056433af58@igalia.com>
Date: Mon, 30 Sep 2024 14:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/sched: Always increment correct scheduler score
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org,
 Nirmoy Das <nirmoy.das@intel.com>
References: <20240913160559.49054-1-tursulin@igalia.com>
 <20240913160559.49054-4-tursulin@igalia.com>
 <8392475d-489e-4aa3-b6c2-7cd15b86dab2@igalia.com>
 <cf135523-92ca-4d41-9acf-e979c9769ad9@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <cf135523-92ca-4d41-9acf-e979c9769ad9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Sep 2024 13:31:10 +0000
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


On 30/09/2024 14:07, Christian König wrote:
> Am 30.09.24 um 15:01 schrieb Tvrtko Ursulin:
>>
>> On 13/09/2024 17:05, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> Entities run queue can change during drm_sched_entity_push_job() so make
>>> sure to update the score consistently.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Fixes: d41a39dda140 ("drm/scheduler: improve job distribution with 
>>> multiple queues")
>>> Cc: Nirmoy Das <nirmoy.das@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Luben Tuikov <ltuikov89@gmail.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: <stable@vger.kernel.org> # v5.9+
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
>>> b/drivers/gpu/drm/scheduler/sched_entity.c
>>> index 76e422548d40..6645a8524699 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -586,7 +586,6 @@ void drm_sched_entity_push_job(struct 
>>> drm_sched_job *sched_job)
>>>       ktime_t submit_ts;
>>>         trace_drm_sched_job(sched_job, entity);
>>> -    atomic_inc(entity->rq->sched->score);
>>>       WRITE_ONCE(entity->last_user, current->group_leader);
>>>         /*
>>> @@ -614,6 +613,7 @@ void drm_sched_entity_push_job(struct 
>>> drm_sched_job *sched_job)
>>>           rq = entity->rq;
>>>           sched = rq->sched;
>>>   +        atomic_inc(sched->score);
>>
>> Ugh this is wrong. :(
>>
>> I was working on some further consolidation and realised this.
>>
>> It will create an imbalance in score since score is currently supposed 
>> to be accounted twice:
>>
>>  1. +/- 1 for each entity (de-)queued
>>  2. +/- 1 for each job queued/completed
>>
>> By moving it into the "if (first) branch" it unbalances it.
>>
>> But it is still true the original placement is racy. It looks like 
>> what is required is an unconditional entity->lock section after 
>> spsc_queue_push. AFAICT that's the only way to be sure entity->rq is 
>> set for the submission at hand.
>>
>> Question also is, why +/- score in entity add/remove and not just for 
>> jobs?
>>
>> In the meantime patch will need to get reverted.
> 
> Ok going to revert that.

Thank you, and sorry for the trouble!

> I also just realized that we don't need to change anything. The rq can't 
> change as soon as there is a job armed for it.
> 
> So having the increment right before pushing the armed job to the entity 
> was actually correct in the first place.

Are you sure? Two threads racing to arm and push on the same entity?

	
	T1		T2

	arm job
	rq1 selected
	..
	push job	arm job
	inc score rq1
			spsc_queue_count check passes
	 ---  just before T1 spsc_queue_push ---
			changed to rq2
	spsc_queue_push
	if (first)
	  resamples entity->rq
	  queues rq2

Where rq1 and rq2 belong to different schedulers.	

Regards,

Tvrtko


> Regards,
> Christian.
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>           drm_sched_rq_add_entity(rq, entity);
>>>           spin_unlock(&entity->rq_lock);
> 

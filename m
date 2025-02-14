Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644EAC021AC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 14:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851C710EC9E;
	Fri, 14 Feb 2025 14:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CYqOea7S";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B12C10EC36
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0+Vnj26Mjrr1EmBvCiFzH6/SReegIATHZWbPXD6LNGw=; b=CYqOea7S1LmvtoMz4G5QDEHk9m
 ZjyrJ4JQueof97Nz56inOXI5/Xv44pK5Fhz44sTDcliL5A6APn95g6201pstvsRUJSr3PdV7n2tSq
 Bomswh6AqNF+/JS1S+9olioASytdV6XOJ6qy+2wG0EmNwf0aqHYsjJWz3H6Dq/Lmn8CjxsceHe69W
 Y8vgoKwvs+ACZ4779t0rnVqcXurtkftrYytVFVKXyaYfNfeOU6ASEIZsNitXxeGMC3Buz8qEqYjgk
 LXbD9vrOILEp1nqVLYHOlAbaiw9lFsCfs6HCwZ9H6tcy+9w0mez3ag9/nBPfgFqu/DgH2RkSQv3Sz
 jcbJt3aw==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tispO-00HZkw-4K; Fri, 14 Feb 2025 11:21:52 +0100
Message-ID: <19b8713f-8563-4a5b-bd05-e3d507538acd@igalia.com>
Date: Fri, 14 Feb 2025 10:21:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Pop jobs from the queue more robustly
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
 <949a5a2f-dbf3-497e-a50a-92adb48aa31f@amd.com>
 <3f6de080ac75fc0988d371e71072cba5d60e269e.camel@mailbox.org>
 <e0a3e8de-2e90-420d-86c1-844f86ebe319@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <e0a3e8de-2e90-420d-86c1-844f86ebe319@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Feb 2025 14:06:00 +0000
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


Hi Christian,

On 11/02/2025 10:21, Christian König wrote:
> Am 11.02.25 um 11:08 schrieb Philipp Stanner:
>> On Tue, 2025-02-11 at 09:22 +0100, Christian König wrote:
>>> Am 06.02.25 um 17:40 schrieb Tvrtko Ursulin:
>>>> Replace a copy of DRM scheduler's to_drm_sched_job with a copy of a
>>>> newly
>>>> added __drm_sched_entity_queue_pop.
>>>>
>>>> This allows breaking the hidden dependency that queue_node has to
>>>> be the
>>>> first element in struct drm_sched_job.
>>>>
>>>> A comment is also added with a reference to the mailing list
>>>> discussion
>>>> explaining the copied helper will be removed when the whole broken
>>>> amdgpu_job_stop_all_jobs_on_sched is removed.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Philipp Stanner <phasta@kernel.org>
>>>> Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> I think this v3 has been supplanted by a v4 by now.
> 
> I've seen the larger v4 series as well, but at least that patch here 
> looks identical on first glance. So my rb still counts.

Is it okay for you to merge the whole series (including this single 
amdgpu patch) via drm-misc?

Regards,

Tvrtko

>> @Tvrtko: btw, do you create patches with
>> git format-patch -v4 ?
>>
>> That way the v4 label will be included in all patch titles, too, not
>> just the cover letter. That makes searching etc. easier in large
>> inboxes
>>
>> P.
>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 22 +++++++++++++++++++-
>>>> -- 
>>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> index 100f04475943..22cb48bab24d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> @@ -411,8 +411,24 @@ static struct dma_fence *amdgpu_job_run(struct
>>>> drm_sched_job *sched_job)
>>>>        return fence;
>>>>    }
>>>> -#define to_drm_sched_job(sched_job)        \
>>>> -        container_of((sched_job), struct drm_sched_job,
>>>> queue_node)
>>>> +/*
>>>> + * This is a duplicate function from DRM scheduler
>>>> sched_internal.h.
>>>> + * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is
>>>> removed, due
>>>> + * latter being incorrect and racy.
>>>> + *
>>>> + * See
>>>> https://lore.kernel.org/amd-gfx/44edde63-7181-44fb- 
>>>> a4f7-94e50514f539@amd.com/
>>>> + */
>>>> +static struct drm_sched_job *
>>>> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>>>> +{
>>>> +    struct spsc_node *node;
>>>> +
>>>> +    node = spsc_queue_pop(&entity->job_queue);
>>>> +    if (!node)
>>>> +        return NULL;
>>>> +
>>>> +    return container_of(node, struct drm_sched_job,
>>>> queue_node);
>>>> +}
>>>>    void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler
>>>> *sched)
>>>>    {
>>>> @@ -425,7 +441,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct
>>>> drm_gpu_scheduler *sched)
>>>>            struct drm_sched_rq *rq = sched->sched_rq[i];
>>>>            spin_lock(&rq->lock);
>>>>            list_for_each_entry(s_entity, &rq->entities, list)
>>>> {
>>>> -            while ((s_job =
>>>> to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
>>>> +            while ((s_job =
>>>> __drm_sched_entity_queue_pop(s_entity))) {
>>>>                    struct drm_sched_fence *s_fence =
>>>> s_job->s_fence;
>>>>                    dma_fence_signal(&s_fence-
>>>>> scheduled);
> 


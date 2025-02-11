Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0DEC021A4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 16:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFD810E71A;
	Tue, 11 Feb 2025 16:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hLS8st5j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C595510E21D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtV379SyHBLioD2I4aaOOfWgfvE7CJqQun8AZHLNibY=; b=hLS8st5jGFZfxCjpGEpPaQ0QD5
 1DXsji9kNF0K/dsmYNJYHGqKGoeh+k4dD6ank7DvbUQhSAYX2bND6u7D8z7HKN3IoeBzsIGQiukGS
 SqdZqlIK1HMDUja/j+JLmoXhw8xkP7SkHWoBPcv5As3gNzOA+9UhHlGXXNnzh5zAxbcScdRpeC3IT
 HJhO9z8K4Fcm85uC4teLwt2F41ywKhcqO6TO3rXzuyjGzuq1MbtTfXvoDlpzC1IUQfyQCDfdERsWv
 DshlzLc917FyvUewut4ExfSKnTY+4QjFCZEJJwNtdixE2yPXvA7dJ0yL9BNGnKVcBzh4hY08VI6ck
 /otQdRWQ==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1thncR-007gQx-2s; Tue, 11 Feb 2025 11:36:00 +0100
Message-ID: <fbdb3020-8270-405e-a2ca-71e7687dfba1@igalia.com>
Date: Tue, 11 Feb 2025 10:35:59 +0000
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
X-Mailman-Approved-At: Tue, 11 Feb 2025 16:57:59 +0000
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

Effectively identical - I only removed the double underscore in v4 on a 
(good) suggestion from Danilo.

>> @Tvrtko: btw, do you create patches with
>> git format-patch -v4 ?
>>
>> That way the v4 label will be included in all patch titles, too, not
>> just the cover letter. That makes searching etc. easier in large
>> inboxes

I don't typically use -vN for the whole series since not all patches in 
the series change equally and I assume people use threaded views so vN 
in the root is sufficient.

Regards,

Tvrtko

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


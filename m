Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9A7C02199
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 15:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE6210EB52;
	Fri,  7 Feb 2025 15:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gRuEbU71";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8B210E318
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 08:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJgIrlxF/OJCLSKgXi38QFUeanSbNqO+lvGppHfwpeQ=; b=gRuEbU71SWBTatpPvDjDcpkafi
 kU/YHx8EQI+VGv1VbGdq39n4kcjQXy7TszKSAKNgMpgVQyKU5Wy34BXka2dgSx0mgCdvdeyKAWcNt
 WCbdPHfJijGmFcD+3zYQNiXpdfCCefQi5pg0rBfhgrNPHDkP/8Cw75bCDYWEICtpgjyiVEgcLAT8U
 MQr2k9+gw5OXlkeKrMJVbPbpzL1NHYiYxcdbfAfGEkuBeSy+MzgAqb9VAe0Xlgjv+HN/yEc7TpxrL
 RfERrbm25jkYLSmyYwAU95nN/2ZWlYibzJH/eakIJglawNZiUlea69JoSq6qyUmV/GnxVqB6QVIni
 QKpA3Q0g==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tgJvH-005iTL-FM; Fri, 07 Feb 2025 09:41:21 +0100
Message-ID: <0a1a27e2-e01e-4cd8-8a85-629a8f7697cc@igalia.com>
Date: Fri, 7 Feb 2025 08:41:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/sched: Add internal job peek/pop API
To: Danilo Krummrich <dakr@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-2-tvrtko.ursulin@igalia.com>
 <Z6TpNo_MgnXcNSsH@cassiopeiae>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <Z6TpNo_MgnXcNSsH@cassiopeiae>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:29:43 +0000
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


On 06/02/2025 16:54, Danilo Krummrich wrote:
> On Thu, Feb 06, 2025 at 04:40:29PM +0000, Tvrtko Ursulin wrote:
>> Idea is to add helpers for peeking and popping jobs from entities with
>> the goal of decoupling the hidden assumption in the code that queue_node
>> is the first element in struct drm_sched_job.
>>
>> That assumption usually comes in the form of:
>>
>>    while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue))))
>>
>> Which breaks if the queue_node is re-positioned due to_drm_sched_job
>> being implemented with a container_of.
>>
>> This also allows us to remove duplicate definitions of to_drm_sched_job.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c   | 11 +++---
>>   drivers/gpu/drm/scheduler/sched_internal.h | 43 ++++++++++++++++++++++
>>   drivers/gpu/drm/scheduler/sched_main.c     |  7 ++--
>>   3 files changed, 51 insertions(+), 10 deletions(-)
>>   create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
>> new file mode 100644
>> index 000000000000..565c83e32371
>> --- /dev/null
>> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
>> @@ -0,0 +1,43 @@
>> +
>> +
>> +/**
>> + * __drm_sched_entity_queue_pop - Low level helper for popping queued jobs
> 
> Why the '__' prefix?

True, it is a remnant from v1 when I had it in gpu_scheduler.h because 
then double underscores were supposed to signal this is "special" 
(internal) API. After adding sched_internal.h it makes no more sense. I 
will drop them.

Speaking of sched_internal.h, as a follow up we could also move a bunch 
of other prototypes from gpu_scheduler.h in there.

> Could also use this to replace spsc_queue_pop() in drm_sched_entity_pop_job().

We could but as that caller does not want/need the job returned maybe 
okay not to. Open to change if you insist.

>> + *
>> + * @entity: scheduler entity
>> + *
>> + * Low level helper for popping queued jobs.
>> + *
>> + * Returns the job dequeued or NULL.
>> + */
>> +static inline struct drm_sched_job *
>> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>> +{
>> +	struct spsc_node *node;
>> +
>> +	node = spsc_queue_pop(&entity->job_queue);
>> +	if (!node)
>> +		return NULL;
>> +
>> +	return container_of(node, struct drm_sched_job, queue_node);
>> +}
>> +
>> +/**
>> + * __drm_sched_entity_queue_peek - Low level helper for peeking at the job queue
> 
> Same here.
> 
> Could also use this for drm_sched_entity_is_ready().

Again we could but that one does not want a job but just a does a "queue 
not empty" check. Could replace also with spsc_queue_count() to make 
that clearer.

Regards,

Tvrtko

>> + *
>> + * @entity: scheduler entity
>> + *
>> + * Low level helper for peeking at the job queue
>> + *
>> + * Returns the job at the head of the queue or NULL.
>> + */
>> +static inline struct drm_sched_job *
>> +__drm_sched_entity_queue_peek(struct drm_sched_entity *entity)
>> +{
>> +	struct spsc_node *node;
>> +
>> +	node = spsc_queue_peek(&entity->job_queue);
>> +	if (!node)
>> +		return NULL;
>> +
>> +	return container_of(node, struct drm_sched_job, queue_node);
>> +}
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index a48be16ab84f..43ca98e8db5f 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -78,6 +78,8 @@
>>   #include <drm/gpu_scheduler.h>
>>   #include <drm/spsc_queue.h>
>>   
>> +#include "sched_internal.h"
>> +
>>   #define CREATE_TRACE_POINTS
>>   #include "gpu_scheduler_trace.h"
>>   
>> @@ -87,9 +89,6 @@ static struct lockdep_map drm_sched_lockdep_map = {
>>   };
>>   #endif
>>   
>> -#define to_drm_sched_job(sched_job)		\
>> -		container_of((sched_job), struct drm_sched_job, queue_node)
>> -
>>   int drm_sched_policy = DRM_SCHED_POLICY_FIFO;
>>   
>>   /**
>> @@ -123,7 +122,7 @@ static bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
>>   {
>>   	struct drm_sched_job *s_job;
>>   
>> -	s_job = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
>> +	s_job = __drm_sched_entity_queue_peek(entity);
>>   	if (!s_job)
>>   		return false;
>>   
>> -- 
>> 2.48.0
>>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163A2C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 10:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBEB10E5DE;
	Thu, 20 Mar 2025 10:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="egoouV7y";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E986110E5DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 10:55:06 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso6550075e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1742468105; x=1743072905;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tqvYuPveixTIa7Mc/61jInJl2Tv6IsJXRJwFjRxAyv4=;
 b=egoouV7yjB+vfQQMXG3ER229D7sjgfh92Amuj/VKTnJ5bXAwWEx/RcpSKA0UNbd64e
 D/7+atZWo0Uvd7Q7MRZcVUZeUUNwqCek0HukNvIq+RDTrfYeTiIhzOIg8onMIC8/v863
 ejaddxoc88IRs9N4bAlhamNsO0xIubxZSv8l83If5N+mzA8+qAUE8ScF5hgpAmbr9W52
 XyW9T0eOitwYDipnPG4hiXRZOV7I6kgxK3GekBrzzL70yYaZBWYF473/InJnYN/+IXI0
 mBU5tcJWZn0ktkgwaKotNLYZuPjnazKu2n1g30enp6K9yN5gK0HbP81CLmMXeimTdY5n
 oTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742468105; x=1743072905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tqvYuPveixTIa7Mc/61jInJl2Tv6IsJXRJwFjRxAyv4=;
 b=En8QYq+OH5Ptort+zrMzrSeirRAjkwPDXsh6+QRI+LR0GyybTVfvyY6Ci5PXjg0iwP
 NHfqIhRqrMpRrLKh+IVDQpCA69kYZsRfYgCs+1U4S3a4jcpCB1QeGGP8S4zqWT7hL46G
 gYOmJz1SFMweypV33uBXbRey8f/l8ZzRgpGN+9GQhyCHaSJUCsZxlNV7P84VijUY1M73
 5cLRMUGq3IRVy2rq1nUaJBbC5J0klAy+Ytrgxis9WQvTPJltr/7FHGLUuJugeRRzEhR9
 9VyD7wYFR1PH9CSS9vUcCPksLq74X8j2HSySa4czTbb0zkesgSm+hZFFZ21FhG/FNDlF
 P4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL+CH9iLQbV87zQ90c1HKvWu+BlNz1QzCyqS9d9vruYj/wVEwaSiugnfhfGv2PET+U+d6hCD4L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJwgqXKTGC4JfyzgYhMq4EwMf9O0TABnPkw7nGO/x8H/ZbpJVx
 zRptKUYR2bIw6x+f5Ov9JHz0ccuKisik0AaUYEidbI/gGFb4qtwwEU5j8v1KX+A=
X-Gm-Gg: ASbGncv6m1wyGw5BfPD/sEHUfzlILnKUqSXGoQcRzjMgY52KEF4CMacrjIzbF/QohrV
 GDRSuw+ZOJVAffFiWv2J2NNrObDFMMqyvsAUBYnsSmgF4d9jpqMX+Yr06LQfbANK9+W0iuozcoO
 bU+cBllcp5oXb3+iuZZYNl78a5CU8Q8fy0YzMJ4ebq3O/U+0z6qSjuovOn+M7iXwDJgU+Iwd7vF
 dHdkSvkow4kyreZJ2UvUHoaWaLi/IHHlgcujxbM8uzXNJRvSWBouN7uJV4sYxuaEFl6/3HrBWIS
 7qRwS5nw/0Q15YIJNHV7BREXN1ZEOmmrvTpFWj0FD3ReKVzTc9KESzTVi14M
X-Google-Smtp-Source: AGHT+IG2azrJs8WibAf9eloXv01LZZg39dzbr3gZdWduFqbzEvQ1pfo/Z+f6c6/FqCh/fHysDRwipA==
X-Received: by 2002:a05:600c:1c19:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-43d4378219bmr57196425e9.3.1742468105243; 
 Thu, 20 Mar 2025 03:55:05 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f58ab6sm44756905e9.23.2025.03.20.03.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 03:55:04 -0700 (PDT)
Message-ID: <2967c6b6-4f90-4ed6-9751-df4846602d5e@ursulin.net>
Date: Thu, 20 Mar 2025 10:55:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] drm: get rid of drm_sched_job::id
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tvrtko Ursulin <tursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250320095818.40622-1-pierre-eric.pelloux-prayer@amd.com>
 <20250320095818.40622-10-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250320095818.40622-10-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 20/03/2025 09:58, Pierre-Eric Pelloux-Prayer wrote:
> Its only purpose was for trace events, but jobs can already be
> uniquely identified using their fence.
> 
> The downside of using the fence is that it's only available
> after 'drm_sched_job_arm' was called which is true for all trace
> events that used job.id so they can safely switch to using it.

Perhaps it would make more sense to pull in this patch to before the one 
declaring tracpoints stable ABI.

Also note that patched declared job->id as stable and this one forgot to 
remove that.

The rest LGTM.

Regards,

Tvrtko

> 
> Suggested-by: Tvrtko Ursulin <tursulin@igalia.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h      | 18 ++++++------------
>   .../gpu/drm/scheduler/gpu_scheduler_trace.h    | 18 ++++++------------
>   drivers/gpu/drm/scheduler/sched_main.c         |  1 -
>   include/drm/gpu_scheduler.h                    |  3 ---
>   4 files changed, 12 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 383fce40d4dd..a4f394d827bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -167,7 +167,6 @@ TRACE_EVENT(amdgpu_cs_ioctl,
>   	    TP_PROTO(struct amdgpu_job *job),
>   	    TP_ARGS(job),
>   	    TP_STRUCT__entry(
> -			     __field(uint64_t, sched_job_id)
>   			     __string(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))
>   			     __field(unsigned int, context)
>   			     __field(unsigned int, seqno)
> @@ -177,15 +176,14 @@ TRACE_EVENT(amdgpu_cs_ioctl,
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __entry->sched_job_id = job->base.id;
>   			   __assign_str(timeline);
>   			   __entry->context = job->base.s_fence->finished.context;
>   			   __entry->seqno = job->base.s_fence->finished.seqno;
>   			   __assign_str(ring);
>   			   __entry->num_ibs = job->num_ibs;
>   			   ),
> -	    TP_printk("sched_job=%llu, timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> -		      __entry->sched_job_id, __get_str(timeline), __entry->context,
> +	    TP_printk("timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> +		      __get_str(timeline), __entry->context,
>   		      __entry->seqno, __get_str(ring), __entry->num_ibs)
>   );
>   
> @@ -193,7 +191,6 @@ TRACE_EVENT(amdgpu_sched_run_job,
>   	    TP_PROTO(struct amdgpu_job *job),
>   	    TP_ARGS(job),
>   	    TP_STRUCT__entry(
> -			     __field(uint64_t, sched_job_id)
>   			     __string(timeline, AMDGPU_JOB_GET_TIMELINE_NAME(job))
>   			     __field(unsigned int, context)
>   			     __field(unsigned int, seqno)
> @@ -202,15 +199,14 @@ TRACE_EVENT(amdgpu_sched_run_job,
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __entry->sched_job_id = job->base.id;
>   			   __assign_str(timeline);
>   			   __entry->context = job->base.s_fence->finished.context;
>   			   __entry->seqno = job->base.s_fence->finished.seqno;
>   			   __assign_str(ring);
>   			   __entry->num_ibs = job->num_ibs;
>   			   ),
> -	    TP_printk("sched_job=%llu, timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> -		      __entry->sched_job_id, __get_str(timeline), __entry->context,
> +	    TP_printk("timeline=%s, context=%u, seqno=%u, ring_name=%s, num_ibs=%u",
> +		      __get_str(timeline), __entry->context,
>   		      __entry->seqno, __get_str(ring), __entry->num_ibs)
>   );
>   
> @@ -519,7 +515,6 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>   	    TP_ARGS(sched_job, fence),
>   	    TP_STRUCT__entry(
>   			     __string(ring, sched_job->base.sched->name)
> -			     __field(uint64_t, id)
>   			     __field(struct dma_fence *, fence)
>   			     __field(uint64_t, ctx)
>   			     __field(unsigned, seqno)
> @@ -527,13 +522,12 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>   
>   	    TP_fast_assign(
>   			   __assign_str(ring);
> -			   __entry->id = sched_job->base.id;
>   			   __entry->fence = fence;
>   			   __entry->ctx = fence->context;
>   			   __entry->seqno = fence->seqno;
>   			   ),
> -	    TP_printk("job ring=%s, id=%llu, need pipe sync to fence=%p, context=%llu, seq=%u",
> -		      __get_str(ring), __entry->id,
> +	    TP_printk("job ring=%s need pipe sync to fence=%p, context=%llu, seq=%u",
> +		      __get_str(ring),
>   		      __entry->fence, __entry->ctx,
>   		      __entry->seqno)
>   );
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> index 3c7f6a39cf91..ad03240b2f03 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -58,7 +58,6 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   	    TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
>   	    TP_ARGS(sched_job, entity),
>   	    TP_STRUCT__entry(
> -			     __field(uint64_t, id)
>   			     __string(name, sched_job->sched->name)
>   			     __field(u32, job_count)
>   			     __field(int, hw_job_count)
> @@ -69,7 +68,6 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   			     ),
>   
>   	    TP_fast_assign(
> -			   __entry->id = sched_job->id;
>   			   __assign_str(name);
>   			   __entry->job_count = spsc_queue_count(&entity->job_queue);
>   			   __entry->hw_job_count = atomic_read(
> @@ -79,8 +77,8 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>   			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
>   			   __entry->client_id = sched_job->s_fence->drm_client_id;
>   			   ),
> -	    TP_printk("dev=%s, id=%llu, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d, client_id:%llu",
> -		      __get_str(dev), __entry->id,
> +	    TP_printk("dev=%s, fence=%llu:%llu, ring=%s, job count:%u, hw job count:%d, client_id:%llu",
> +		      __get_str(dev),
>   		      __entry->fence_context, __entry->fence_seqno, __get_str(name),
>   		      __entry->job_count, __entry->hw_job_count, __entry->client_id)
>   );
> @@ -117,7 +115,6 @@ TRACE_EVENT(drm_sched_job_add_dep,
>   	TP_STRUCT__entry(
>   		    __field(u64, fence_context)
>   		    __field(u64, fence_seqno)
> -		    __field(u64, id)
>   		    __field(u64, ctx)
>   		    __field(u64, seqno)
>   		    ),
> @@ -125,12 +122,11 @@ TRACE_EVENT(drm_sched_job_add_dep,
>   	TP_fast_assign(
>   		    __entry->fence_context = sched_job->s_fence->finished.context;
>   		    __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> -		    __entry->id = sched_job->id;
>   		    __entry->ctx = fence->context;
>   		    __entry->seqno = fence->seqno;
>   		    ),
> -	TP_printk("fence=%llu:%llu, id=%llu depends on fence=%llu:%llu",
> -		  __entry->fence_context, __entry->fence_seqno, __entry->id,
> +	TP_printk("fence=%llu:%llu depends on fence=%llu:%llu",
> +		  __entry->fence_context, __entry->fence_seqno,
>   		  __entry->ctx, __entry->seqno)
>   );
>   
> @@ -140,7 +136,6 @@ TRACE_EVENT(drm_sched_job_unschedulable,
>   	    TP_STRUCT__entry(
>   			     __field(u64, fence_context)
>   			     __field(u64, fence_seqno)
> -			     __field(uint64_t, id)
>   			     __field(u64, ctx)
>   			     __field(u64, seqno)
>   			     ),
> @@ -148,12 +143,11 @@ TRACE_EVENT(drm_sched_job_unschedulable,
>   	    TP_fast_assign(
>   			   __entry->fence_context = sched_job->s_fence->finished.context;
>   			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> -			   __entry->id = sched_job->id;
>   			   __entry->ctx = fence->context;
>   			   __entry->seqno = fence->seqno;
>   			   ),
> -	    TP_printk("fence=%llu:%llu, id=%llu depends on unsignalled fence=%llu:%llu",
> -		      __entry->fence_context, __entry->fence_seqno, __entry->id,
> +	    TP_printk("fence=%llu:%llu depends on unsignalled fence=%llu:%llu",
> +		      __entry->fence_context, __entry->fence_seqno,
>   		      __entry->ctx, __entry->seqno)
>   );
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 85c2111e5500..85e0ba850746 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -848,7 +848,6 @@ void drm_sched_job_arm(struct drm_sched_job *job)
>   
>   	job->sched = sched;
>   	job->s_priority = entity->priority;
> -	job->id = atomic64_inc_return(&sched->job_id_count);
>   
>   	drm_sched_fence_init(job->s_fence, job->entity);
>   }
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 032214a49138..ddc24512c281 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -326,7 +326,6 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>    * @finish_cb: the callback for the finished fence.
>    * @credits: the number of credits this job contributes to the scheduler
>    * @work: Helper to reschedule job kill to different context.
> - * @id: a unique id assigned to each job scheduled on the scheduler.
>    * @karma: increment on every hang caused by this job. If this exceeds the hang
>    *         limit of the scheduler then the job is marked guilty and will not
>    *         be scheduled further.
> @@ -339,8 +338,6 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>    * to schedule the job.
>    */
>   struct drm_sched_job {
> -	u64				id;
> -
>   	/**
>   	 * @submit_ts:
>   	 *


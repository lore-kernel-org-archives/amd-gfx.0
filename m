Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB0CC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6126F10E8D6;
	Thu,  6 Feb 2025 16:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oXbXaFDJ";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C4410E8DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 16:54:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9A0EBA4423F;
 Thu,  6 Feb 2025 16:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7227C4CEDD;
 Thu,  6 Feb 2025 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738860858;
 bh=WZrwLQxpcFzmzBUJHgiRDEOlpABS3jWGVmEq7Me4EJY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oXbXaFDJeisTkbFrLgoeDslwH7MPBc5Vnl7H6hlJ0Mwc4e9eVtdeHJcQL1/4oN3Xc
 9lWbH9J6MxO4zlaTEsyBpzL8KS74rJnPT7v8OM5+knprNMucOWVLn3O7UgrnpcfhSn
 F4qeYhDwgAsLVRHab2jmhhczy8mjywkpJSJXBZ6y7zda2DQS0WeE8ELPpTZr2OKOAJ
 xeA3XX+bI8HxA10K6x/pzwtfUT1a1f5kNsK9QyEkDuIqObggKKU7wNoVqu1u8XABI7
 m2iNogQarMYYf8AyHiaWxkis/kGq8zPt9qjO5M5GWJmSfbJ/okEoiAi96+CiumvV7O
 OSppAeRh7OQiA==
Date: Thu, 6 Feb 2025 17:54:14 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH 1/3] drm/sched: Add internal job peek/pop API
Message-ID: <Z6TpNo_MgnXcNSsH@cassiopeiae>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-2-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206164031.43413-2-tvrtko.ursulin@igalia.com>
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

On Thu, Feb 06, 2025 at 04:40:29PM +0000, Tvrtko Ursulin wrote:
> Idea is to add helpers for peeking and popping jobs from entities with
> the goal of decoupling the hidden assumption in the code that queue_node
> is the first element in struct drm_sched_job.
> 
> That assumption usually comes in the form of:
> 
>   while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue))))
> 
> Which breaks if the queue_node is re-positioned due to_drm_sched_job
> being implemented with a container_of.
> 
> This also allows us to remove duplicate definitions of to_drm_sched_job.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c   | 11 +++---
>  drivers/gpu/drm/scheduler/sched_internal.h | 43 ++++++++++++++++++++++
>  drivers/gpu/drm/scheduler/sched_main.c     |  7 ++--
>  3 files changed, 51 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
> new file mode 100644
> index 000000000000..565c83e32371
> --- /dev/null
> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
> @@ -0,0 +1,43 @@
> +
> +
> +/**
> + * __drm_sched_entity_queue_pop - Low level helper for popping queued jobs

Why the '__' prefix?

Could also use this to replace spsc_queue_pop() in drm_sched_entity_pop_job().

> + *
> + * @entity: scheduler entity
> + *
> + * Low level helper for popping queued jobs.
> + *
> + * Returns the job dequeued or NULL.
> + */
> +static inline struct drm_sched_job *
> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
> +{
> +	struct spsc_node *node;
> +
> +	node = spsc_queue_pop(&entity->job_queue);
> +	if (!node)
> +		return NULL;
> +
> +	return container_of(node, struct drm_sched_job, queue_node);
> +}
> +
> +/**
> + * __drm_sched_entity_queue_peek - Low level helper for peeking at the job queue

Same here.

Could also use this for drm_sched_entity_is_ready().

> + *
> + * @entity: scheduler entity
> + *
> + * Low level helper for peeking at the job queue
> + *
> + * Returns the job at the head of the queue or NULL.
> + */
> +static inline struct drm_sched_job *
> +__drm_sched_entity_queue_peek(struct drm_sched_entity *entity)
> +{
> +	struct spsc_node *node;
> +
> +	node = spsc_queue_peek(&entity->job_queue);
> +	if (!node)
> +		return NULL;
> +
> +	return container_of(node, struct drm_sched_job, queue_node);
> +}
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index a48be16ab84f..43ca98e8db5f 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -78,6 +78,8 @@
>  #include <drm/gpu_scheduler.h>
>  #include <drm/spsc_queue.h>
>  
> +#include "sched_internal.h"
> +
>  #define CREATE_TRACE_POINTS
>  #include "gpu_scheduler_trace.h"
>  
> @@ -87,9 +89,6 @@ static struct lockdep_map drm_sched_lockdep_map = {
>  };
>  #endif
>  
> -#define to_drm_sched_job(sched_job)		\
> -		container_of((sched_job), struct drm_sched_job, queue_node)
> -
>  int drm_sched_policy = DRM_SCHED_POLICY_FIFO;
>  
>  /**
> @@ -123,7 +122,7 @@ static bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
>  {
>  	struct drm_sched_job *s_job;
>  
> -	s_job = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
> +	s_job = __drm_sched_entity_queue_peek(entity);
>  	if (!s_job)
>  		return false;
>  
> -- 
> 2.48.0
> 

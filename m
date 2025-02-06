Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CD2C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 17:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A9A10E8E1;
	Thu,  6 Feb 2025 17:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aJ49EGMZ";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68A510E8E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 17:04:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0CB53A44279;
 Thu,  6 Feb 2025 17:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F01C4CEDD;
 Thu,  6 Feb 2025 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738861470;
 bh=Xu44CXMwSS5s477J2lsOYk/x1S1SVaDxOdpdSIp2SKo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aJ49EGMZE+cTACquPpmkSOJMB/gOnTW3TsC9a0KesMhgUB7t2vvbPx+pd6dOT4bNO
 N689I/npCveq5Xq0nipENaDHt9oeENq1dbAyUJJdCLyeP0koI3otf7DnCXtK50oN0v
 Z1UrxGc4WSe7wt+0h/ATOKMDjxyABAFUnsd5fCVWKdy2vAdWHdL4kEOviyRv4ENRlP
 ir0NId7GzDJGTUZNI0qI5554Q7BKptXNbRqzaBiYVip9j35KVl6sYh3/ARGNMBXOV5
 X9cBZDv02AR57my4rHAcbo5FLhax1xF13HX9Adopkx4YMIZJSmi8yJOvZ1mkXEY3+H
 v2SC91bfXN37w==
Date: Thu, 6 Feb 2025 18:04:26 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH 3/3] drm/sched: Remove a hole from struct drm_sched_job
Message-ID: <Z6Trmm0s2oTP-mDd@cassiopeiae>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-4-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206164031.43413-4-tvrtko.ursulin@igalia.com>
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

On Thu, Feb 06, 2025 at 04:40:31PM +0000, Tvrtko Ursulin wrote:
> We can re-order some struct members and take u32 credits outside of the
> pointer sandwich and also for the last_dependency member we can get away
> with an unsigned int since for dependency we use xa_limit_32b.
> 
> Pahole report before:
>         /* size: 160, cachelines: 3, members: 14 */
>         /* sum members: 156, holes: 1, sum holes: 4 */
>         /* last cacheline: 32 bytes */
> 
> And after:
>         /* size: 152, cachelines: 3, members: 14 */
>         /* last cacheline: 24 bytes */
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
>  include/drm/gpu_scheduler.h | 38 +++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index a0ff08123f07..68da3dec8dba 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -338,8 +338,14 @@ struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>   * to schedule the job.
>   */
>  struct drm_sched_job {
> -	struct spsc_node		queue_node;
> -	struct list_head		list;
> +	u64				id;
> +
> +	/**
> +	 * @submit_ts:
> +	 *
> +	 * When the job was pushed into the entity queue.
> +	 */
> +	ktime_t                         submit_ts;
>  
>  	/**
>  	 * @sched:
> @@ -349,24 +355,30 @@ struct drm_sched_job {
>  	 * has finished.
>  	 */
>  	struct drm_gpu_scheduler	*sched;
> +
>  	struct drm_sched_fence		*s_fence;
> +	struct drm_sched_entity         *entity;
>  
> +	enum drm_sched_priority		s_priority;
>  	u32				credits;
> +	/** @last_dependency: tracks @dependencies as they signal */
> +	unsigned int			last_dependency;
> +	atomic_t			karma;
> +
> +	struct spsc_node		queue_node;
> +	struct list_head		list;
>  
>  	/*
>  	 * work is used only after finish_cb has been used and will not be
>  	 * accessed anymore.
>  	 */
>  	union {
> -		struct dma_fence_cb		finish_cb;
> -		struct work_struct		work;
> +		struct dma_fence_cb	finish_cb;
> +		struct work_struct	work;

I usually prefer to leave those things alone, but since you change most of this
struct anyways...

With or without this diff:

Acked-by: Danilo Krummrich <dakr@kernel.org>

>  	};
>  
> -	uint64_t			id;
> -	atomic_t			karma;
> -	enum drm_sched_priority		s_priority;
> -	struct drm_sched_entity         *entity;
>  	struct dma_fence_cb		cb;
> +
>  	/**
>  	 * @dependencies:
>  	 *
> @@ -375,16 +387,6 @@ struct drm_sched_job {
>  	 * drm_sched_job_add_implicit_dependencies().
>  	 */
>  	struct xarray			dependencies;
> -
> -	/** @last_dependency: tracks @dependencies as they signal */
> -	unsigned long			last_dependency;
> -
> -	/**
> -	 * @submit_ts:
> -	 *
> -	 * When the job was pushed into the entity queue.
> -	 */
> -	ktime_t                         submit_ts;
>  };
>  
>  static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
> -- 
> 2.48.0
> 

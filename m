Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647FCCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 10:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C26910EBB0;
	Fri, 10 Oct 2025 10:02:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A515A10EBA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 10:02:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4751595
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 03:02:09 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BD233F66E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 03:02:17 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:02:15 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 24/28] drm/panthor: Remove drm_sched_init_args->num_rqs
 usage
Message-ID: <aOjZp6ssCEqfACwJ@e110455-lin.cambridge.arm.com>
References: <20251008085359.52404-1-tvrtko.ursulin@igalia.com>
 <20251008085359.52404-25-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008085359.52404-25-tvrtko.ursulin@igalia.com>
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

On Wed, Oct 08, 2025 at 09:53:55AM +0100, Tvrtko Ursulin wrote:
> Remove member no longer used by the scheduler core.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c   | 1 -
>  drivers/gpu/drm/panthor/panthor_sched.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 6dec4354e378..048a61d9fad6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2327,7 +2327,6 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
>  	const struct drm_sched_init_args sched_args = {
>  		.ops = &panthor_vm_bind_ops,
>  		.submit_wq = ptdev->mmu->vm.wq,
> -		.num_rqs = 1,
>  		.credit_limit = 1,
>  		/* Bind operations are synchronous for now, no timeout needed. */
>  		.timeout = MAX_SCHEDULE_TIMEOUT,
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index f5e01cb16cfc..5b95868169ac 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3318,7 +3318,6 @@ group_create_queue(struct panthor_group *group,
>  	struct drm_sched_init_args sched_args = {
>  		.ops = &panthor_queue_sched_ops,
>  		.submit_wq = group->ptdev->scheduler->wq,
> -		.num_rqs = 1,
>  		/*
>  		 * The credit limit argument tells us the total number of
>  		 * instructions across all CS slots in the ringbuffer, with
> -- 
> 2.48.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

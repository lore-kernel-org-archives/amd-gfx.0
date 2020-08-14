Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71159C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B52C20771
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNeRMhRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046A66EC03;
	Fri, 14 Aug 2020 19:33:59 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568956EC03
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 19:33:57 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 3so8827817wmi.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=790RrEUSCfySllPctSqNAbReKxXN/NRGtL5x4zhHdbc=;
 b=eNeRMhRQM4FHQT17SLYCkoOGxoGsM5DDII+Y9qjQzKHj9gWJBCzgBiZ5i2aNYrt3bD
 avx8KBZ5n7YImH3ATDOoRM1zQFLV+82iPJITMhOZqd/Dtu0Gl4IUXD9gg9cJmg1vF80R
 MCnyUx4tZKN/IdBIDIjQn1Bqjc4bBmSJhjxIxskis8uDPMsKrcVE8kawzZPnOGwOb5/c
 rX8G3ftd/ZaqnmDlo73XpAihR7fm2FABef7TydCa7zRyyX0YgRHB2Bc/0jcJwYfChxwD
 nwVETKwGs6celA8OoGueakaAKgAeNfA6lTlGEHAy/qfgHlNHR5urBvSdGMqqxk2MSqWT
 mVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=790RrEUSCfySllPctSqNAbReKxXN/NRGtL5x4zhHdbc=;
 b=axu9yfmmUPZFhKXgPM8997+OpR33bzOmkiQN6FSI0ZzzOUYJkGUe3yS2peaj89dZFL
 6oHhrqbkgsfB45SuRMfvCzFaraXUzz7XRqFJ+aym35IDTVCJJmGypvIYy4ZTkgaRBro3
 ZR1+HC7rH5Inyz5Q5dVr5RJ/f4xWanY0tKQw5YShWiF55iO8OELvYvNeL/9qvbTiXjoV
 E8vtgIHU4mwn8njjcQ2iGjf5Pku5hu5Wnk51J3st4WcmhafRpMK939G9cnM7CMi7rJsC
 9HoSebP+nAiqCYxevLgh34f5d+YLS+SYDSyf2ydNeH24p+1q5T5ZAmvU7oXDOIJlMGPt
 rKrw==
X-Gm-Message-State: AOAM530bTICTGMCKqFXJWqXpAdwvmbiizo/CdT6o34/SKgsvtn4DYqXL
 CtndaTzC/hJL39AHN4Z4KrCYxCGClxzIyQT7R7nhBd+L
X-Google-Smtp-Source: ABdhPJxMmBwSdauWraVJkXMnp6yu0GyOcuakaCaPxUu/kEpCjJCMFKduE9xtXgcxBikJj+3nKh9lH9aHwe1fsgQ0GFU=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr3737088wml.73.1597433635879;
 Fri, 14 Aug 2020 12:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200814191401.25606-1-luben.tuikov@amd.com>
 <20200814191401.25606-2-luben.tuikov@amd.com>
In-Reply-To: <20200814191401.25606-2-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2020 15:33:44 -0400
Message-ID: <CADnq5_PnSNNZjyHt_hEq1Sb_g9TpAnYL3fo_L57oaM79HM90Jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Scheduler priority fixes
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ dri-devel

On Fri, Aug 14, 2020 at 3:14 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Remove DRM_SCHED_PRIORITY_LOW, as it was used
> in only one place.
>
> Rename and separate by a line
> DRM_SCHED_PRIORITY_MAX to DRM_SCHED_PRIORITY_COUNT
> as it represents a (total) count of said
> priorities and it is used as such in loops
> throughout the code. (0-based indexing is the
> the count number.)
>
> Remove redundant word HIGH in priority names,
> and rename *KERNEL* to *HIGH*, as it really
> means that, high.
>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   |  2 +-
>  drivers/gpu/drm/scheduler/sched_main.c    |  8 ++++----
>  include/drm/gpu_scheduler.h               | 15 +++++++++------
>  8 files changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index d85d13f7a043..fd97ac34277b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -46,7 +46,7 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>  static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>                                       enum drm_sched_priority priority)
>  {
> -       if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> +       if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
>                 return -EINVAL;
>
>         /* NORMAL and below are accessible by everyone */
> @@ -65,8 +65,8 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>  static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
>  {
>         switch (prio) {
> -       case DRM_SCHED_PRIORITY_HIGH_HW:
> -       case DRM_SCHED_PRIORITY_KERNEL:
> +       case DRM_SCHED_PRIORITY_HW:
> +       case DRM_SCHED_PRIORITY_HIGH:
>                 return AMDGPU_GFX_PIPE_PRIO_HIGH;
>         default:
>                 return AMDGPU_GFX_PIPE_PRIO_NORMAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 75d37dfb51aa..bb9e5481ff3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -251,7 +251,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>         int i;
>
>         /* Signal all jobs not yet scheduled */
> -       for (i = DRM_SCHED_PRIORITY_MAX - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
> +       for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
>                 struct drm_sched_rq *rq = &sched->sched_rq[i];
>
>                 if (!rq)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13ea8ebc421c..6d4fc79bf84a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -267,7 +267,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>                         &ring->sched;
>         }
>
> -       for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
> +       for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; ++i)
>                 atomic_set(&ring->num_jobs[i], 0);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index da871d84b742..7112137689db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -243,7 +243,7 @@ struct amdgpu_ring {
>         bool                    has_compute_vm_bug;
>         bool                    no_scheduler;
>
> -       atomic_t                num_jobs[DRM_SCHED_PRIORITY_MAX];
> +       atomic_t                num_jobs[DRM_SCHED_PRIORITY_COUNT];
>         struct mutex            priority_mutex;
>         /* protected by priority_mutex */
>         int                     priority;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index c799691dfa84..e05bc22a0a49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -36,14 +36,14 @@ enum drm_sched_priority amdgpu_to_sched_priority(int amdgpu_priority)
>  {
>         switch (amdgpu_priority) {
>         case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> -               return DRM_SCHED_PRIORITY_HIGH_HW;
> +               return DRM_SCHED_PRIORITY_HW;
>         case AMDGPU_CTX_PRIORITY_HIGH:
> -               return DRM_SCHED_PRIORITY_HIGH_SW;
> +               return DRM_SCHED_PRIORITY_SW;
>         case AMDGPU_CTX_PRIORITY_NORMAL:
>                 return DRM_SCHED_PRIORITY_NORMAL;
>         case AMDGPU_CTX_PRIORITY_LOW:
>         case AMDGPU_CTX_PRIORITY_VERY_LOW:
> -               return DRM_SCHED_PRIORITY_LOW;
> +               return DRM_SCHED_PRIORITY_MIN;
>         case AMDGPU_CTX_PRIORITY_UNSET:
>                 return DRM_SCHED_PRIORITY_UNSET;
>         default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 20fa0497aaa4..bc4bdb90d8f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2114,7 +2114,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>                 ring = adev->mman.buffer_funcs_ring;
>                 sched = &ring->sched;
>                 r = drm_sched_entity_init(&adev->mman.entity,
> -                                         DRM_SCHED_PRIORITY_KERNEL, &sched,
> +                                         DRM_SCHED_PRIORITY_HIGH, &sched,
>                                           1, NULL);
>                 if (r) {
>                         DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 2f319102ae9f..c2947e73d1b6 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -335,9 +335,9 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
>          * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
>          * corrupt but keep in mind that kernel jobs always considered good.
>          */
> -       if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> +       if (bad->s_priority != DRM_SCHED_PRIORITY_HIGH) {
>                 atomic_inc(&bad->karma);
> -               for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> +               for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_HIGH;
>                      i++) {
>                         struct drm_sched_rq *rq = &sched->sched_rq[i];
>
> @@ -623,7 +623,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
>                 return NULL;
>
>         /* Kernel run queue has higher priority than normal run queue*/
> -       for (i = DRM_SCHED_PRIORITY_MAX - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
> +       for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
>                 entity = drm_sched_rq_select_entity(&sched->sched_rq[i]);
>                 if (entity)
>                         break;
> @@ -851,7 +851,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>         sched->name = name;
>         sched->timeout = timeout;
>         sched->hang_limit = hang_limit;
> -       for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_MAX; i++)
> +       for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
>                 drm_sched_rq_init(sched, &sched->sched_rq[i]);
>
>         init_waitqueue_head(&sched->wake_up_worker);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 26b04ff62676..8ae9b8f73bf9 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -33,14 +33,17 @@
>  struct drm_gpu_scheduler;
>  struct drm_sched_rq;
>
> +/* These are often used as an (initial) index
> + * to an array, and as such should start at 0.
> + */
>  enum drm_sched_priority {
>         DRM_SCHED_PRIORITY_MIN,
> -       DRM_SCHED_PRIORITY_LOW = DRM_SCHED_PRIORITY_MIN,
>         DRM_SCHED_PRIORITY_NORMAL,
> -       DRM_SCHED_PRIORITY_HIGH_SW,
> -       DRM_SCHED_PRIORITY_HIGH_HW,

We originally added HIGH_SW and HIGH_HW to differentiate between two
different high priority modes; e.g., HIGH_SW meant that the gpu
scheduler would schedule with high priority, HIGH_HW meant that the
hardware would schedule with high priority. You can set different
queue priorities in the hardware and work from the high priority queue
will get scheduled on the hw sooner than lower priority queues.  Not
all engines support HW queue priorities however.

Alex

> -       DRM_SCHED_PRIORITY_KERNEL,
> -       DRM_SCHED_PRIORITY_MAX,
> +       DRM_SCHED_PRIORITY_SW,
> +       DRM_SCHED_PRIORITY_HW,
> +       DRM_SCHED_PRIORITY_HIGH,
> +
> +       DRM_SCHED_PRIORITY_COUNT,
>         DRM_SCHED_PRIORITY_INVALID = -1,
>         DRM_SCHED_PRIORITY_UNSET = -2
>  };
> @@ -273,7 +276,7 @@ struct drm_gpu_scheduler {
>         uint32_t                        hw_submission_limit;
>         long                            timeout;
>         const char                      *name;
> -       struct drm_sched_rq             sched_rq[DRM_SCHED_PRIORITY_MAX];
> +       struct drm_sched_rq             sched_rq[DRM_SCHED_PRIORITY_COUNT];
>         wait_queue_head_t               wake_up_worker;
>         wait_queue_head_t               job_scheduled;
>         atomic_t                        hw_rq_count;
> --
> 2.28.0.215.g878e727637
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

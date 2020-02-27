Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D2C3F2C2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D183024692
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Ma66Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D183024692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2493F6E0B7;
	Thu, 27 Feb 2020 21:50:50 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EEEF6E0B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:50:48 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id c84so1062498wme.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NCN5Rm0CUNpsndgVvW3gfvNDA6VaXTQ6SGf6E1KF3AQ=;
 b=H3Ma66KtDxrbg8JKSaFhip5eaO5qvQdjoFTl1OKN5IfoUBzN0Z/p9VascEIXG2KK5j
 bTpj+RZuSxgG1EJvP3aLiFDExfKJ4rKqREh0bh6/5VftB2Wqu7e9JYikq5qj/JDhOUe9
 kBHkuVo71xMcnU6mE255RDvPsGFyjR7H9beUoxNPgQeenSsh4y7Y/YINcWJZkuTjwfKZ
 ZqvL+xm/seEdX7hOVwwQEdG7eG4OWxMxd1hhyld8/ock1HauUkATIzUK3ovRZ713iaqj
 oVzug8afetFjqG61CR+6IESinhJMgYAJC70izTbgvSl8b76sfbsFGO33/jvy5/ukwvdq
 s4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NCN5Rm0CUNpsndgVvW3gfvNDA6VaXTQ6SGf6E1KF3AQ=;
 b=i7zb8rKRrdyHJg5VFOLftNVaCyey/1/n6bEKk1U4S/7AFrmdeFEfDI+6zpUqqBJiun
 46oyAQCfENQtp7YslixlzR3hrQw1qDk0l9ZvYLqnxrjk68kgqtZ+DIjwuifls+6oWEsx
 qvuPXGY0AidEpV4fZUjjnlAj/x8fO2Yl1m0XLm7m7ay+O42fcjnRx/bRFTMRzSeGvVaW
 GM12nZP0zw9nX5k7Xc3/SaPPFnOtaVA3oFLsOKGeY3f4vYc6+UcAxGiw78V3TzCgIJTF
 6bsZFl4ZjC+xoSH2xOtd4LvC86psOzbfO4CH6RCb9cpuH1DiYPIMt73PCANclGlPqi+F
 G6Rw==
X-Gm-Message-State: APjAAAVIqFBVugfb3/AUm+JuPr1zb93eC1SoVZA3a2DgWRZm2vs+MLw7
 arEuTEd3GMsioY9akCj+mFj2M/ssV6zbJJOCwGU=
X-Google-Smtp-Source: APXvYqyswlgFOikZtL7ViZd3ZUQbDX8AkltlrM9iCxwJgPeon1OfANhPDGOJOfiR3dIIXGarROPEhoYNOTE2Fxai3Dg=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr815241wmj.70.1582840246918;
 Thu, 27 Feb 2020 13:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <CADnq5_M160ircPyE7WQJ+64bQr1kMJNt0d7OAjNdu--kzOj8-Q@mail.gmail.com>
In-Reply-To: <CADnq5_M160ircPyE7WQJ+64bQr1kMJNt0d7OAjNdu--kzOj8-Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2020 16:50:35 -0500
Message-ID: <CADnq5_PmmnKKNbHJa-ZqUGuaUZtDvdASMAuZ0X-wMNssKuA7pw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] drm/amdgpu: set compute queue priority at mqd_init
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 4:48 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 4:37 PM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
> >
> > We were changing compute ring priority while rings were being used
> > before every job submission which is not recommended. This patch
> > sets compute queue priority at mqd initialization for gfx8 and gfx9.
> >
> > Policy: Enable high priority compute queues only if gpu has >1 MEC, if
> > so PIPE0 and PIPE1 will be in high priority.
>
> I think we still want high priority queues on even when there is only
> one MEC.  It might work better on multi-MEC chips, but it should still
> work on single MEC chips.
>
> >
> > high/normal priority compute sched list are generated from set of high/normal
> > priority compute queues. At context creation, entity of compute queue
> > get a sched list from high or normal priority depending on ctx->priority
> >
> > Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 19 +++++++++++++++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 14 ++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 12 ++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 23 ++++++++++++++++++++---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++++++++++++++++

Also, can you add a patch for gfx_v10_0.c?

Alex

> >  8 files changed, 82 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index f397ff97b4e4..8304d0c87899 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1205,7 +1205,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
> >         struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> >         struct drm_sched_entity *entity = p->entity;
> >         enum drm_sched_priority priority;
> > -       struct amdgpu_ring *ring;
> >         struct amdgpu_bo_list_entry *e;
> >         struct amdgpu_job *job;
> >         uint64_t seq;
> > @@ -1258,9 +1257,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
> >         priority = job->base.s_priority;
> >         drm_sched_entity_push_job(&job->base, entity);
> >
> > -       ring = to_amdgpu_ring(entity->rq->sched);
> > -       amdgpu_ring_priority_get(ring, priority);
> > -
> >         amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
> >
> >         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > index 94a6c42f29ea..a1742b1d4f9c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -85,8 +85,14 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
> >                         num_scheds = 1;
> >                         break;
> >                 case AMDGPU_HW_IP_COMPUTE:
> > -                       scheds = adev->gfx.compute_sched;
> > -                       num_scheds = adev->gfx.num_compute_sched;
> > +                       if (priority > DRM_SCHED_PRIORITY_NORMAL &&
> > +                           adev->gfx.num_compute_sched_high) {
> > +                               scheds = adev->gfx.compute_sched_high;
> > +                               num_scheds = adev->gfx.num_compute_sched_high;
> > +                       } else {
> > +                               scheds = adev->gfx.compute_sched;
> > +                               num_scheds = adev->gfx.num_compute_sched;
> > +                       }
> >                         break;
> >                 case AMDGPU_HW_IP_DMA:
> >                         scheds = adev->sdma.sdma_sched;
> > @@ -638,8 +644,13 @@ void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
> >         }
> >
> >         for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> > -               adev->gfx.compute_sched[i] = &adev->gfx.compute_ring[i].sched;
> > -               adev->gfx.num_compute_sched++;
> > +               if (!adev->gfx.compute_ring[i].high_priority) {
> > +                       adev->gfx.compute_sched[adev->gfx.num_compute_sched++] =
> > +                               &adev->gfx.compute_ring[i].sched;
> > +               } else {
> > +                       adev->gfx.compute_sched_high[adev->gfx.num_compute_sched_high++] =
> > +                               &adev->gfx.compute_ring[i].sched;
> > +               }
> >         }
> >
> >         for (i = 0; i < adev->sdma.num_instances; i++) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 7403588684b3..bdea5d44edf4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -192,6 +192,20 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
> >         return adev->gfx.mec.num_mec > 1;
> >  }
> >
> > +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> > +                                              int queue)
> > +{
> > +       bool multipipe_policy = amdgpu_gfx_is_multipipe_capable(adev);
> > +
> > +       /* only enable high priority queue if more than 1 MEC.
> > +        * When multipipe_policy is true amdgpu gets queue 0,1 from each pipe of
> > +        * 1st MEC. Policy: make queue 0 of each pipe as high priority compute queue */
> > +       if (multipipe_policy && queue == 0)
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
> >  {
> >         int i, queue, pipe, mec;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index 37ba05b63b2a..13ee0ea66c6f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -41,6 +41,14 @@
> >  #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
> >  #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
> >
> > +#define AMDGPU_GFX_PIPE_PRIO_LOW    0
> > +#define AMDGPU_GFX_PIPE_PRIO_NORMAL 1
> > +#define AMDGPU_GFX_PIPE_PRIO_HIGH   2
> > +
> > +#define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
> > +#define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> > +
> > +
> >  struct amdgpu_mec {
> >         struct amdgpu_bo        *hpd_eop_obj;
> >         u64                     hpd_eop_gpu_addr;
> > @@ -281,7 +289,9 @@ struct amdgpu_gfx {
> >         unsigned                        num_gfx_rings;
> >         struct amdgpu_ring              compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
> >         struct drm_gpu_scheduler        *compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> > +       struct drm_gpu_scheduler        *compute_sched_high[AMDGPU_MAX_COMPUTE_RINGS];
> >         uint32_t                        num_compute_sched;
> > +       uint32_t                        num_compute_sched_high;
> >         unsigned                        num_compute_rings;
> >         struct amdgpu_irq_src           eop_irq;
> >         struct amdgpu_irq_src           priv_reg_irq;
> > @@ -363,6 +373,8 @@ void amdgpu_gfx_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
> >                                  int *mec, int *pipe, int *queue);
> >  bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
> >                                      int pipe, int queue);
> > +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> > +                                              int queue);
> >  int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
> >                                int pipe, int queue);
> >  void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > index d42be880a236..4981e443a884 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -117,12 +117,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
> >
> >  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
> >  {
> > -       struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
> >         struct amdgpu_job *job = to_amdgpu_job(s_job);
> >
> >         drm_sched_job_cleanup(s_job);
> >
> > -       amdgpu_ring_priority_put(ring, s_job->s_priority);
> >         dma_fence_put(job->fence);
> >         amdgpu_sync_free(&job->sync);
> >         amdgpu_sync_free(&job->sched_sync);
> > @@ -143,7 +141,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
> >                       void *owner, struct dma_fence **f)
> >  {
> >         enum drm_sched_priority priority;
> > -       struct amdgpu_ring *ring;
> >         int r;
> >
> >         if (!f)
> > @@ -158,9 +155,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
> >         priority = job->base.s_priority;
> >         drm_sched_entity_push_job(&job->base, entity);
> >
> > -       ring = to_amdgpu_ring(entity->rq->sched);
> > -       amdgpu_ring_priority_get(ring, priority);
> > -
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 24caff085d00..34fcd467f18d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -222,6 +222,7 @@ struct amdgpu_ring {
> >         struct mutex            priority_mutex;
> >         /* protected by priority_mutex */
> >         int                     priority;
> > +       bool                    high_priority;
> >
> >  #if defined(CONFIG_DEBUG_FS)
> >         struct dentry *ent;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index e63f98b2d389..4260becd569b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -4426,6 +4426,23 @@ static int gfx_v8_0_deactivate_hqd(struct amdgpu_device *adev, u32 req)
> >         return r;
> >  }
> >
> > +static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *mqd)
> > +{
> > +       struct amdgpu_device *adev = ring->adev;
> > +
> > +       if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> > +               if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> > +                       mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> > +                       ring->high_priority = true;
> > +                       mqd->cp_hqd_queue_priority =
> > +                               AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> > +                       mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
>
> I think we can move this back to mqd_init().  It needs to be set up
> for both low and high priority queues.
>
> > +               }
> > +               else
> > +                       ring->high_priority = false;
> > +       }
> > +}
> > +
> >  static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
> >  {
> >         struct amdgpu_device *adev = ring->adev;
> > @@ -4549,9 +4566,6 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
> >         /* defaults */
> >         mqd->cp_hqd_eop_rptr = RREG32(mmCP_HQD_EOP_RPTR);
> >         mqd->cp_hqd_eop_wptr = RREG32(mmCP_HQD_EOP_WPTR);
> > -       mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
> > -       mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
> > -       mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
> >         mqd->cp_hqd_ctx_save_base_addr_lo = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO);
> >         mqd->cp_hqd_ctx_save_base_addr_hi = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI);
> >         mqd->cp_hqd_cntl_stack_offset = RREG32(mmCP_HQD_CNTL_STACK_OFFSET);
> > @@ -4563,6 +4577,9 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
> >         mqd->cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
> >         mqd->cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);
> >
> > +       /* set static priority for a queue/ring */
> > +       gfx_v8_0_mqd_set_priority(ring, mqd);
> > +
> >         /* map_queues packet doesn't need activate the queue,
> >          * so only kiq need set this field.
> >          */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 4135e4126e82..85a54849abd1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3310,6 +3310,23 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
> >         WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
> >  }
> >
> > +static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
> > +{
> > +       struct amdgpu_device *adev = ring->adev;
> > +
> > +       if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> > +               if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> > +                       mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> > +                       ring->high_priority = true;
> > +                       mqd->cp_hqd_queue_priority =
> > +                               AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> > +                       mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
>
> Same comment here.
>
> Alex
>
> > +               }
> > +               else
> > +                       ring->high_priority = false;
> > +       }
> > +}
> > +
> >  static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
> >  {
> >         struct amdgpu_device *adev = ring->adev;
> > @@ -3446,6 +3463,9 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
> >         tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
> >         mqd->cp_hqd_ib_control = tmp;
> >
> > +       /* set static priority for a queue/ring */
> > +       gfx_v9_0_mqd_set_priority(ring, mqd);
> > +
> >         /* map_queues packet doesn't need activate the queue,
> >          * so only kiq need set this field.
> >          */
> > --
> > 2.25.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

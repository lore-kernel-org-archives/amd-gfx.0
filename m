Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDFAC3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDECA246AC
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiMx1m5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDECA246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3216E061;
	Fri, 28 Feb 2020 15:56:42 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047236E061
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 15:56:41 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r7so3541082wro.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oqeXEjbKMG9LB4IR2QLWkhxiXv7jHjUczvsKPOn+yu4=;
 b=SiMx1m5+UyqIKDw/TfHTdSpAfkfBLyF0z6kJLdO2a1ohRUQw2lXE4pmnNdJ2cxqPxY
 FRmT69gy82SRdw/eBpSnvk8b+Zpzw0aTRUP9Fohz+/gd2usdWNZAT9zhDlslB4/UHe/p
 kG7d1CgA7ryDaYd32VgHbnVIucuhF1cngnBDCdguznhcFSIA5iJ3/Cr14jqMl7RLfOT9
 +2kLCdK5agTKcQ1xWubyred2G/OhX8RP+01/gBPrz6ZZC4a7JxGlKFTImWbuC0C9fLFG
 YqFWbLLyihsb0adjoeisJ2+qnEgRODLOA/HfZcvCtyn+VRa3cJG2h9BVkBa1dWXc7jGl
 8Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oqeXEjbKMG9LB4IR2QLWkhxiXv7jHjUczvsKPOn+yu4=;
 b=LeLgHJMC9ke+FYdjlOMkWZTCk+rPcBRFZQVl7OFj8kJ3tVSBjViDIzKHB8ooBvAwwa
 1+fQIA4SkG9MZQWMJEv8GNqNtCtAFVWnnY2f5rmNsTpiVmte4AcV27osIyHnFRqmqj/L
 ZSlOixETk5w0LmlYQ2zlddebvHxWeTs9gC3mVgtSSw2ncmxTd+dNhcOA3+U13o05Ug3D
 34x4vL4bojc2kaSFpY9Xya8uawuwGM10aTXY9lSy7+knHfhv4eB3zMxDpHLkOOWBYlcd
 BMJEUla9D3H1nm/eyx/EoQGftKLk4CNNSNc9onnNNXpKSgUFZfgh5f0Lqo3lbnI27Vmn
 eugA==
X-Gm-Message-State: APjAAAVJ6bqup71LvY3avShpaeUMCU76IFcKROT2tUynvWlm1RppCFwe
 9KDYVlgSvqi1uyrEOL/GoZ46c6Txc1lJzAx0JtU=
X-Google-Smtp-Source: APXvYqyH1jk5KCymHuXpEGseKH5srwI1xrqQWwhrANOxhoQvfMTJERDyO3tdhFf2jEjurYCkAVEeNpf0xWf7eQjzC1Q=
X-Received: by 2002:a05:6000:4b:: with SMTP id
 k11mr5372760wrx.362.1582905399519; 
 Fri, 28 Feb 2020 07:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20200228143941.4919-1-nirmoy.das@amd.com>
In-Reply-To: <20200228143941.4919-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Feb 2020 10:56:28 -0500
Message-ID: <CADnq5_M_+RRZrNXyp0s=sCyujrPHBwPPKe3oLt7FvHeiRxiVYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu: set compute queue priority at mqd_init
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

On Fri, Feb 28, 2020 at 9:36 AM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>
> We were changing compute ring priority while rings were being used
> before every job submission which is not recommended. This patch
> sets compute queue priority at mqd initialization for gfx8, gfx9 and
> gfx10.
>
> Policy: make queue 0 of each pipe as high priority compute queue
>
> High/normal priority compute sched lists are generated from set of high/normal
> priority compute queues. At context creation, entity of compute queue
> get a sched list from high or normal priority depending on ctx->priority
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 40 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  8 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 13 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 19 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 23 ++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++++++++
>  9 files changed, 113 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f397ff97b4e4..8304d0c87899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1205,7 +1205,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>         struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>         struct drm_sched_entity *entity = p->entity;
>         enum drm_sched_priority priority;
> -       struct amdgpu_ring *ring;
>         struct amdgpu_bo_list_entry *e;
>         struct amdgpu_job *job;
>         uint64_t seq;
> @@ -1258,9 +1257,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>         priority = job->base.s_priority;
>         drm_sched_entity_push_job(&job->base, entity);
>
> -       ring = to_amdgpu_ring(entity->rq->sched);
> -       amdgpu_ring_priority_get(ring, priority);
> -
>         amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>
>         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 94a6c42f29ea..b21771b37300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -85,8 +85,8 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>                         num_scheds = 1;
>                         break;
>                 case AMDGPU_HW_IP_COMPUTE:
> -                       scheds = adev->gfx.compute_sched;
> -                       num_scheds = adev->gfx.num_compute_sched;
> +                       scheds = adev->gfx.compute_prio_sched[priority];
> +                       num_scheds = adev->gfx.num_compute_sched[priority];
>                         break;
>                 case AMDGPU_HW_IP_DMA:
>                         scheds = adev->sdma.sdma_sched;
> @@ -628,20 +628,46 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>         mutex_destroy(&mgr->lock);
>  }
>
> +
> +static void amdgpu_ctx_init_compute_sched(struct amdgpu_device *adev)
> +{
> +       int num_compute_sched_normal = 0;
> +       int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
> +       int i;
> +
> +
> +       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +               if (adev->gfx.compute_ring[i].high_priority)
> +                       adev->gfx.compute_sched[num_compute_sched_normal++] =
> +                               &adev->gfx.compute_ring[i].sched;
> +               else
> +                       adev->gfx.compute_sched[num_compute_sched_high--] =
> +                               &adev->gfx.compute_ring[i].sched;
> +       }
> +
> +       for (i = DRM_SCHED_PRIORITY_MIN; i <= DRM_SCHED_PRIORITY_NORMAL; i++) {
> +               adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> +               adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> +       }
> +
> +       for (i = DRM_SCHED_PRIORITY_NORMAL + 1; i < DRM_SCHED_PRIORITY_MAX; i++) {
> +               adev->gfx.compute_prio_sched[i] =
> +                       &adev->gfx.compute_sched[num_compute_sched_high - 1];
> +               adev->gfx.num_compute_sched[i] =
> +                       adev->gfx.num_compute_rings - num_compute_sched_normal;
> +       }
> +}
> +
>  void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
>  {
>         int i, j;
>
> +       amdgpu_ctx_init_compute_sched(adev);
>         for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>                 adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
>                 adev->gfx.num_gfx_sched++;
>         }
>
> -       for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -               adev->gfx.compute_sched[i] = &adev->gfx.compute_ring[i].sched;
> -               adev->gfx.num_compute_sched++;
> -       }
> -
>         for (i = 0; i < adev->sdma.num_instances; i++) {
>                 adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
>                 adev->sdma.num_sdma_sched++;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 7403588684b3..952725e7243c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -192,6 +192,14 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
>         return adev->gfx.mec.num_mec > 1;
>  }
>
> +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> +                                              int queue)
> +{
> +       /* Policy: make queue 0 of each pipe as high priority compute queue */
> +       return (queue == 0);
> +
> +}
> +
>  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
>  {
>         int i, queue, pipe, mec;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 37ba05b63b2a..f87b6df67694 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -41,6 +41,14 @@
>  #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
>  #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>
> +#define AMDGPU_GFX_PIPE_PRIO_LOW    0
> +#define AMDGPU_GFX_PIPE_PRIO_NORMAL 1
> +#define AMDGPU_GFX_PIPE_PRIO_HIGH   2
> +
> +#define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
> +#define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> +
> +
>  struct amdgpu_mec {
>         struct amdgpu_bo        *hpd_eop_obj;
>         u64                     hpd_eop_gpu_addr;
> @@ -280,8 +288,9 @@ struct amdgpu_gfx {
>         uint32_t                        num_gfx_sched;
>         unsigned                        num_gfx_rings;
>         struct amdgpu_ring              compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
> +       struct drm_gpu_scheduler        **compute_prio_sched[DRM_SCHED_PRIORITY_MAX];
>         struct drm_gpu_scheduler        *compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> -       uint32_t                        num_compute_sched;
> +       uint32_t                        num_compute_sched[DRM_SCHED_PRIORITY_MAX];
>         unsigned                        num_compute_rings;
>         struct amdgpu_irq_src           eop_irq;
>         struct amdgpu_irq_src           priv_reg_irq;
> @@ -363,6 +372,8 @@ void amdgpu_gfx_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
>                                  int *mec, int *pipe, int *queue);
>  bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int mec,
>                                      int pipe, int queue);
> +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
> +                                              int queue);
>  int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
>                                int pipe, int queue);
>  void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index d42be880a236..4981e443a884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -117,12 +117,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>
>  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  {
> -       struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>         struct amdgpu_job *job = to_amdgpu_job(s_job);
>
>         drm_sched_job_cleanup(s_job);
>
> -       amdgpu_ring_priority_put(ring, s_job->s_priority);
>         dma_fence_put(job->fence);
>         amdgpu_sync_free(&job->sync);
>         amdgpu_sync_free(&job->sched_sync);
> @@ -143,7 +141,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>                       void *owner, struct dma_fence **f)
>  {
>         enum drm_sched_priority priority;
> -       struct amdgpu_ring *ring;
>         int r;
>
>         if (!f)
> @@ -158,9 +155,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>         priority = job->base.s_priority;
>         drm_sched_entity_push_job(&job->base, entity);
>
> -       ring = to_amdgpu_ring(entity->rq->sched);
> -       amdgpu_ring_priority_get(ring, priority);
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 24caff085d00..34fcd467f18d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -222,6 +222,7 @@ struct amdgpu_ring {
>         struct mutex            priority_mutex;
>         /* protected by priority_mutex */
>         int                     priority;
> +       bool                    high_priority;
>
>  #if defined(CONFIG_DEBUG_FS)
>         struct dentry *ent;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 94ca9ffa0ccb..0e6ce65e1e54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3211,6 +3211,22 @@ static int gfx_v10_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
>         return r;
>  }
>
> +static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct v10_compute_mqd *mqd)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +
> +       if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +               if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +                       mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +                       ring->high_priority = true;
> +                       mqd->cp_hqd_queue_priority =
> +                               AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> +               }
> +               else
> +                       ring->high_priority = false;

Coding style.  If any clause has parens, the whole thing should have
them.  Also conditions should be on the same line as the parens.
E.g.,

if () {
    ...
} else {
    ...
}

Same comment on the other gfx* functions below.

Alex

> +       }
> +}
> +
>  static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev = ring->adev;
> @@ -3336,6 +3352,9 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_ring *ring)
>         tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
>         mqd->cp_hqd_ib_control = tmp;
>
> +       /* set static priority for a queue/ring */
> +       gfx_v10_0_compute_mqd_set_priority(ring, mqd);
> +
>         /* map_queues packet doesn't need activate the queue,
>          * so only kiq need set this field.
>          */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 393a1324daa9..6c4b7e49f97f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4430,6 +4430,22 @@ static int gfx_v8_0_deactivate_hqd(struct amdgpu_device *adev, u32 req)
>         return r;
>  }
>
> +static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *mqd)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +
> +       if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +               if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +                       mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +                       ring->high_priority = true;
> +                       mqd->cp_hqd_queue_priority =
> +                               AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> +               }
> +               else
> +                       ring->high_priority = false;
> +       }
> +}
> +
>  static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev = ring->adev;
> @@ -4553,9 +4569,6 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>         /* defaults */
>         mqd->cp_hqd_eop_rptr = RREG32(mmCP_HQD_EOP_RPTR);
>         mqd->cp_hqd_eop_wptr = RREG32(mmCP_HQD_EOP_WPTR);
> -       mqd->cp_hqd_pipe_priority = RREG32(mmCP_HQD_PIPE_PRIORITY);
> -       mqd->cp_hqd_queue_priority = RREG32(mmCP_HQD_QUEUE_PRIORITY);
> -       mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
>         mqd->cp_hqd_ctx_save_base_addr_lo = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO);
>         mqd->cp_hqd_ctx_save_base_addr_hi = RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI);
>         mqd->cp_hqd_cntl_stack_offset = RREG32(mmCP_HQD_CNTL_STACK_OFFSET);
> @@ -4567,6 +4580,10 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
>         mqd->cp_hqd_eop_wptr_mem = RREG32(mmCP_HQD_EOP_WPTR_MEM);
>         mqd->cp_hqd_eop_dones = RREG32(mmCP_HQD_EOP_DONES);
>
> +       /* set static priority for a queue/ring */
> +       gfx_v8_0_mqd_set_priority(ring, mqd);
> +       mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
> +
>         /* map_queues packet doesn't need activate the queue,
>          * so only kiq need set this field.
>          */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 015647959d69..ff5e913f244d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3314,6 +3314,22 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
>         WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
>  }
>
> +static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *mqd)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +
> +       if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +               if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
> +                       mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +                       ring->high_priority = true;
> +                       mqd->cp_hqd_queue_priority =
> +                               AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> +               }
> +               else
> +                       ring->high_priority = false;
> +       }
> +}
> +
>  static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev = ring->adev;
> @@ -3450,6 +3466,10 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
>         tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
>         mqd->cp_hqd_ib_control = tmp;
>
> +       /* set static priority for a queue/ring */
> +       gfx_v9_0_mqd_set_priority(ring, mqd);
> +       mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
> +
>         /* map_queues packet doesn't need activate the queue,
>          * so only kiq need set this field.
>          */
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

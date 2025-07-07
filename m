Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C604C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 14:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C3310E4B2;
	Mon,  7 Jul 2025 14:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H22M5qnU";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476F410E4BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 14:46:19 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-313dc7be67aso462365a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jul 2025 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751899579; x=1752504379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaJoDrcCrGfcXM7t0WibI4NEyQ2zo4kdU9217dIyRNs=;
 b=H22M5qnUe9qE7GZuy6Wwn/N1mmxAkOdHB64xFOl7EsE4N2ALlr4YIz5oZlW2Mk4+Bk
 gmP2FJqKo8mPrWO7PfboblcMUAR1wPO+rh+JVGyS1rld7A+nzUDXpJ99pYyB5Nnq6Bcc
 2JLl1vYx32bNTfP+Ms2U+x9yBNnZH4RdmIvB7+/ZfmFoCe1o1lB+Yy+lB716ClIPxVsk
 DrO38x8IAhpS4KQSRSIBgSS/zrYWABlpr6p/1XIB+8Y6pUGhPQru+iAWmPwebr8y3oT5
 buK7Z6mau6b1l9SNfRaajX1VBWBYQfWfisRBpewnEFt80pz7yg4b458uRAt+DdmrlC7f
 E9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751899579; x=1752504379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaJoDrcCrGfcXM7t0WibI4NEyQ2zo4kdU9217dIyRNs=;
 b=WTQc2mclxfgWcAt2nbUnLA2JwjzlTw/+TaD9Rf3BGtacJlfAbbgGybROGQs2lGZK4M
 a1I424pZo5dl94ZGZVxxLhKP08HsmVOoBT++DDcFy+yNAx0zlEiQX2fnNvwBUAX55WZn
 6192jqT2j3hYxQdHkqZAQ552LsCLmSdBmRl2CXDengrKqzkSKQdBrnE7MEza9cdqMCZ5
 stbmtR5+Pvw0Iq8yVtr91b94A71dUuQafrLDYBXwK88eB1NSqtAZUXpjZqRhhSuV50QW
 2hb9a39R2ZzybJe3lh0FE5qYK3bUkKLm9Ci5P1sEibSATuVMbh7I+5dk5c1B13T9txh6
 Ih+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6alt7676D12I2w5Y/NkHA4rWAtHoTlD7dGPI0ekQ6tHBxBB8UhCXljqsIAbOQ0c+95ismHfGF@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5d3O/ZwC0wgRxWKqWcPS6sJkc7hs6sLcMytpNCjHBwov+IZ9C
 puTUCXVq2bzipCo2oQBT7oozWbLPida1ncZnFPEvJVggQ3prEKabH6eAJuynFPIdou24yfYHEp6
 ZJY71ikxqPeX8sgZKcSEp3+FLd7gWaVWZhr8C
X-Gm-Gg: ASbGncvW9DsQV38BxtOrZauBPKf8nG7NNS0y4auGm19Xa/SmXDLwHfXzsJht9J3/zoa
 mJQGYuc7cw9zxfPqf0GGl2/dr7AdT1deQIGQbowMUhSs5m5HEDdhuXdptQjTVNDQ2tm/WpVlTwH
 9Wtosp6HmD+uumhRtxFfebBjk+YulQCwHPNl3mpxPC7rD2
X-Google-Smtp-Source: AGHT+IFq8b9aHPszoSFAytIHC+jG7G+HfHaEGXu2bIR9vLGQxv5+h8495XBrZgtqP4wR9dzmmw8v9er5X/3YTL48P7Y=
X-Received: by 2002:a17:90b:5744:b0:314:2d38:3e4d with SMTP id
 98e67ed59e1d1-31aacc1286dmr6925992a91.3.1751899578342; Mon, 07 Jul 2025
 07:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-4-alexander.deucher@amd.com>
 <at3gplc4kikoavr4rkduknc6fkqij45bx5pduf3znbdzxxejae@xkqulazbt65a>
In-Reply-To: <at3gplc4kikoavr4rkduknc6fkqij45bx5pduf3znbdzxxejae@xkqulazbt65a>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jul 2025 10:46:05 -0400
X-Gm-Features: Ac12FXzRnCNF673PgVETFp6Zdjg5knSZ2iRHv3uovnv5xrn6ImY_oLcFfFFojCU
Message-ID: <CADnq5_NQOPpgQ-SBbBqWAgB4ODd3oLeDuegAoz9A5DxDN9kJEA@mail.gmail.com>
Subject: Re: [PATCH 03/28] drm/amdgpu: track ring state associated with a fence
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jul 6, 2025 at 10:41=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 07/01, Alex Deucher wrote:
> > We need to know the wptr and sequence number associated
> > with a fence so that we can re-emit the unprocessed state
> > after a ring reset.  Pre-allocate storage space for
> > the ring buffer contents and add helpers to save off
> > and re-emit the unprocessed state so that it can be
> > re-emitted after the queue is reset.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 90 +++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 67 +++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 18 +++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +
> >  6 files changed, 195 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 2d6b2b486baf7..3f2080aecd5a3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -120,6 +120,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, str=
uct dma_fence **f,
> >               am_fence =3D kzalloc(sizeof(*am_fence), GFP_KERNEL);
> >               if (!am_fence)
> >                       return -ENOMEM;
> > +             am_fence->context =3D 0;
> >       } else {
> >               am_fence =3D af;
> >       }
> > @@ -127,6 +128,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, str=
uct dma_fence **f,
> >       am_fence->ring =3D ring;
> >
> >       seq =3D ++ring->fence_drv.sync_seq;
> > +     am_fence->seq =3D seq;
> >       if (af) {
> >               dma_fence_init(fence, &amdgpu_job_fence_ops,
> >                              &ring->fence_drv.lock,
> > @@ -141,6 +143,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, str=
uct dma_fence **f,
> >
> >       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> >                              seq, flags | AMDGPU_FENCE_FLAG_INT);
> > +     amdgpu_fence_save_wptr(fence);
> >       pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> >       ptr =3D &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_=
mask];
> >       if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> > @@ -253,6 +256,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
> >
> >       do {
> >               struct dma_fence *fence, **ptr;
> > +             struct amdgpu_fence *am_fence;
> >
> >               ++last_seq;
> >               last_seq &=3D drv->num_fences_mask;
> > @@ -265,6 +269,12 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring=
)
> >               if (!fence)
> >                       continue;
> >
> > +             /* Save the wptr in the fence driver so we know what the =
last processed
> > +              * wptr was.  This is required for re-emitting the ring s=
tate for
> > +              * queues that are reset but are not guilty and thus have=
 no guilty fence.
> > +              */
> > +             am_fence =3D container_of(fence, struct amdgpu_fence, bas=
e);
> > +             drv->signalled_wptr =3D am_fence->wptr;
> >               dma_fence_signal(fence);
> >               dma_fence_put(fence);
> >               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> > @@ -727,6 +737,86 @@ void amdgpu_fence_driver_force_completion(struct a=
mdgpu_ring *ring)
> >       amdgpu_fence_process(ring);
> >  }
> >
> > +
> > +/**
> > + * Kernel queue reset handling
> > + *
> > + * The driver can reset individual queues for most engines, but those =
queues
> > + * may contain work from multiple contexts.  Resetting the queue will =
reset
> > + * lose all of that state.  In order to minimize the collateral damage=
, the
> > + * driver will save the ring contents which are not associated with th=
e guilty
> > + * context prior to resetting the queue.  After resetting the queue th=
e queue
> > + * contents from the other contexts is re-emitted to the rings so that=
 it can
> > + * be processed by the engine.  To handle this, we save the queue's wr=
ite
> > + * pointer (wptr) in the fences associated with each context.  If we g=
et a
> > + * queue timeout, we can then use the wptrs from the fences to determi=
ne
> > + * which data needs to be saved out of the queue's ring buffer.
> > + */
> > +
> > +/**
> > + * amdgpu_fence_driver_guilty_force_completion - force signal of speci=
fied sequence
> > + *
> > + * @fence: fence of the ring to signal
> > + *
> > + */
> > +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *=
fence)
> > +{
> > +     dma_fence_set_error(&fence->base, -ETIME);
> > +     amdgpu_fence_write(fence->ring, fence->seq);
> > +     amdgpu_fence_process(fence->ring);
> > +}
> > +
> > +void amdgpu_fence_save_wptr(struct dma_fence *fence)
> > +{
> > +     struct amdgpu_fence *am_fence =3D container_of(fence, struct amdg=
pu_fence, base);
> > +
> > +     am_fence->wptr =3D am_fence->ring->wptr;
> > +}
> > +
> > +static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring =
*ring,
> > +                                                u64 start_wptr, u32 en=
d_wptr)
>
> Perhaps you could call this function something like amdgpu_ring_backup()
> or a similar name? I suggest this change because you also have the same
> function name for the exported function.

The names are different:
amdgpu_ring_backup_unprocessed_command()
vs.
amdgpu_ring_backup_unprocessed_commands()
the latter calls the former in a loop to back up all of the necessary
commands in the ring.

>
> > +{
> > +     unsigned int first_idx =3D start_wptr & ring->buf_mask;
> > +     unsigned int last_idx =3D end_wptr & ring->buf_mask;
> > +     unsigned int i;
> > +
> > +     /* Backup the contents of the ring buffer. */
> > +     for (i =3D first_idx; i !=3D last_idx; ++i, i &=3D ring->buf_mask=
)
> > +             ring->ring_backup[ring->ring_backup_entries_to_copy++] =
=3D ring->ring[i];
>
> After the backup is done, don't you need to set
> ring_backup_entries_to_copy to 0?

No.  This function is called in a loop so we back up multiple commands
from the ring so we need to make sure we keep the index up to date.

>
> > +}
> > +
> > +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> > +                                          struct amdgpu_fence *guilty_=
fence)
> > +{
> > +     struct dma_fence *unprocessed;
> > +     struct dma_fence __rcu **ptr;
> > +     struct amdgpu_fence *fence;
> > +     u64 wptr, i, seqno;
> > +
> > +     seqno =3D amdgpu_fence_read(ring);
> > +     wptr =3D ring->fence_drv.signalled_wptr;
> > +     ring->ring_backup_entries_to_copy =3D 0;
> > +
> > +     for (i =3D seqno + 1; i <=3D ring->fence_drv.sync_seq; ++i) {
> > +             ptr =3D &ring->fence_drv.fences[i & ring->fence_drv.num_f=
ences_mask];
> > +             rcu_read_lock();
> > +             unprocessed =3D rcu_dereference(*ptr);
> > +
> > +             if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> > +                     fence =3D container_of(unprocessed, struct amdgpu=
_fence, base);
> > +
> > +                     /* save everything if the ring is not guilty, oth=
erwise
> > +                      * just save the content from other contexts.
> > +                      */
> > +                     if (!guilty_fence || (fence->context !=3D guilty_=
fence->context))
>
> Why do you need these two checks? Why is guilty_fence not enough here?

There are two cases:
1. The fence innocent, in which case, we can back up all of the
unprocessed ring contents.
2. The fence is guilty, in which case, we want to skip ring content
associated with all fences associated with the guilty context.

>
> > +                             amdgpu_ring_backup_unprocessed_command(ri=
ng, wptr,
> > +                                                                    fe=
nce->wptr);
> > +                     wptr =3D fence->wptr;
> > +             }
> > +             rcu_read_unlock();
> > +     }
> > +}
> > +
> >  /*
> >   * Common fence implementation
> >   */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index 206b70acb29a0..7d9bcb72e8dd3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -139,7 +139,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >       int vmid =3D AMDGPU_JOB_GET_VMID(job);
> >       bool need_pipe_sync =3D false;
> >       unsigned int cond_exec;
> > -
> >       unsigned int i;
> >       int r =3D 0;
> >
> > @@ -156,6 +155,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >               gds_va =3D job->gds_va;
> >               init_shadow =3D job->init_shadow;
> >               af =3D &job->hw_fence;
> > +             /* Save the context of the job for reset handling.
> > +              * The driver needs this so it can skip the ring
> > +              * contents for guilty contexts.
> > +              */
> > +             af->context =3D job->base.s_fence ? job->base.s_fence->fi=
nished.context : 0;
> >       } else {
> >               vm =3D NULL;
> >               fence_ctx =3D 0;
> > @@ -307,8 +311,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >           ring->hw_prio =3D=3D AMDGPU_GFX_PIPE_PRIO_HIGH)
> >               ring->funcs->emit_wave_limit(ring, false);
> >
> > +     /* Save the wptr associated with this fence.
> > +      * This must be last for resets to work properly
> > +      * as we need to save the wptr associated with this
> > +      * fence so we know what rings contents to backup
> > +      * after we reset the queue.
> > +      */
> > +     amdgpu_fence_save_wptr(*f);
> > +
> >       amdgpu_ring_ib_end(ring);
> >       amdgpu_ring_commit(ring);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index f0b7080dccb8d..45febdc2f3493 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -89,8 +89,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
> >  {
> >       struct amdgpu_ring *ring =3D to_amdgpu_ring(s_job->sched);
> >       struct amdgpu_job *job =3D to_amdgpu_job(s_job);
> > -     struct amdgpu_task_info *ti;
> >       struct amdgpu_device *adev =3D ring->adev;
> > +     struct amdgpu_task_info *ti;
> >       int idx, r;
> >
> >       if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> > @@ -135,7 +135,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >       } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> >               dev_err(adev->dev, "Starting %s ring reset\n",
> >                       s_job->sched->name);
> > -             r =3D amdgpu_ring_reset(ring, job->vmid, NULL);
> > +             r =3D amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> >               if (!r) {
> >                       atomic_inc(&ring->adev->gpu_reset_counter);
> >                       dev_err(adev->dev, "Ring %s reset succeeded\n",
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index 426834806fbf2..09d7681b7a754 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -99,6 +99,29 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsi=
gned int ndw)
> >       return 0;
> >  }
> >
> > +/**
> > + * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for re=
emit
> > + *
> > + * @ring: amdgpu_ring structure holding ring information
> > + * @ndw: number of dwords to allocate in the ring buffer
> > + *
> > + * Allocate @ndw dwords in the ring buffer (all asics).
> > + * doesn't check the max_dw limit as we may be reemitting
> > + * several submissions.
> > + */
> > +static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigne=
d int ndw)
> > +{
> > +     /* Align requested size with padding so unlock_commit can
> > +      * pad safely */
> > +     ndw =3D (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mas=
k;
> > +
> > +     ring->count_dw =3D ndw;
> > +     ring->wptr_old =3D ring->wptr;
> > +
> > +     if (ring->funcs->begin_use)
> > +             ring->funcs->begin_use(ring);
> > +}
> > +
> >  /** amdgpu_ring_insert_nop - insert NOP packets
> >   *
> >   * @ring: amdgpu_ring structure holding ring information
> > @@ -333,6 +356,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, s=
truct amdgpu_ring *ring,
> >       /*  Initialize cached_rptr to 0 */
> >       ring->cached_rptr =3D 0;
> >
> > +     if (!ring->ring_backup) {
> > +             ring->ring_backup =3D kvzalloc(ring->ring_size, GFP_KERNE=
L);
> > +             if (!ring->ring_backup)
> > +                     return -ENOMEM;
> > +     }
> > +
> >       /* Allocate ring buffer */
> >       if (ring->ring_obj =3D=3D NULL) {
> >               r =3D amdgpu_bo_create_kernel(adev, ring->ring_size + rin=
g->funcs->extra_dw, PAGE_SIZE,
> > @@ -342,6 +371,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, st=
ruct amdgpu_ring *ring,
> >                                           (void **)&ring->ring);
> >               if (r) {
> >                       dev_err(adev->dev, "(%d) ring create failed\n", r=
);
> > +                     kvfree(ring->ring_backup);
> >                       return r;
> >               }
> >               amdgpu_ring_clear_ring(ring);
> > @@ -385,6 +415,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
> >       amdgpu_bo_free_kernel(&ring->ring_obj,
> >                             &ring->gpu_addr,
> >                             (void **)&ring->ring);
> > +     kvfree(ring->ring_backup);
> > +     ring->ring_backup =3D NULL;
> >
> >       dma_fence_put(ring->vmid_wait);
> >       ring->vmid_wait =3D NULL;
> > @@ -753,3 +785,38 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *r=
ing)
> >
> >       return true;
> >  }
> > +
> > +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> > +                                 struct amdgpu_fence *guilty_fence)
> > +{
> > +     /* Stop the scheduler to prevent anybody else from touching the r=
ing buffer. */
> > +     drm_sched_wqueue_stop(&ring->sched);
> > +     /* back up the non-guilty commands */
> > +     amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> > +}
> > +
> > +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> > +                              struct amdgpu_fence *guilty_fence)
> > +{
> > +     unsigned int i;
> > +     int r;
> > +
> > +     /* verify that the ring is functional */
> > +     r =3D amdgpu_ring_test_ring(ring);
> > +     if (r)
> > +             return r;
> > +
> > +     /* signal the fence of the bad job */
> > +     if (guilty_fence)
> > +             amdgpu_fence_driver_guilty_force_completion(guilty_fence)=
;
> > +     /* Re-emit the non-guilty commands */
> > +     if (ring->ring_backup_entries_to_copy) {
> > +             amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_=
to_copy);
> > +             for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> > +                     amdgpu_ring_write(ring, ring->ring_backup[i]);
> > +             amdgpu_ring_commit(ring);
> > +     }
> > +     /* Start the scheduler again */
> > +     drm_sched_wqueue_start(&ring->sched);
> > +     return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 784ba2ec354c7..309e7bb6001bd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
> >       /* sync_seq is protected by ring emission lock */
> >       uint32_t                        sync_seq;
> >       atomic_t                        last_seq;
> > +     u64                             signalled_wptr;
> >       bool                            initialized;
> >       struct amdgpu_irq_src           *irq_src;
> >       unsigned                        irq_type;
> > @@ -141,6 +142,12 @@ struct amdgpu_fence {
> >       /* RB, DMA, etc. */
> >       struct amdgpu_ring              *ring;
> >       ktime_t                         start_timestamp;
> > +
> > +     /* wptr for the fence for resets */
> > +     u64                             wptr;
> > +     /* fence context for resets */
> > +     u64                             context;
> > +     uint32_t                        seq;
>
> All of these new fields are associated with reset, and their names are
> also common in the code (we see wptr, context, and seq everywhere). What
> do you think of adding a suffix/prefix to identify their purpose in the
> code clearly? For example, wptr_reset instead of wptr or context_reset
> instead of context. It does not need to be _reset, but something that
> helps to identify these field purpose in the code.

They are used to facilitate the resets, but at a more general level,
they are just tagging the fence with additional metadata.
The wptr marks the wptr value associated with the work associated with
the fence.  seq is the sequence number
associated with the fence (i.e., the value that will get written when
the work on the engine completes). The context is the
context of the job whose work is associated with the fence.

Alex

>
> Thanks
>
> >  };
> >
> >  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> > @@ -148,6 +155,8 @@ extern const struct drm_sched_backend_ops amdgpu_sc=
hed_ops;
> >  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
> >  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error=
);
> >  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> > +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *=
fence);
> > +void amdgpu_fence_save_wptr(struct dma_fence *fence);
> >
> >  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
> >  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> > @@ -284,6 +293,9 @@ struct amdgpu_ring {
> >
> >       struct amdgpu_bo        *ring_obj;
> >       uint32_t                *ring;
> > +     /* backups for resets */
> > +     uint32_t                *ring_backup;
> > +     unsigned int            ring_backup_entries_to_copy;
> >       unsigned                rptr_offs;
> >       u64                     rptr_gpu_addr;
> >       volatile u32            *rptr_cpu_addr;
> > @@ -550,4 +562,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev=
);
> >  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> >  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> >  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> > +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> > +                                          struct amdgpu_fence *guilty_=
fence);
> > +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> > +                                 struct amdgpu_fence *guilty_fence);
> > +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> > +                              struct amdgpu_fence *guilty_fence);
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index f042372d9f2e6..ea9b0f050f799 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -765,6 +765,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
> >       bool cleaner_shader_needed =3D false;
> >       bool pasid_mapping_needed =3D false;
> >       struct dma_fence *fence =3D NULL;
> > +     struct amdgpu_fence *af;
> >       unsigned int patch;
> >       int r;
> >
> > @@ -830,6 +831,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
> >               r =3D amdgpu_fence_emit(ring, &fence, NULL, 0);
> >               if (r)
> >                       return r;
> > +             /* this is part of the job's context */
> > +             af =3D container_of(fence, struct amdgpu_fence, base);
> > +             af->context =3D job->base.s_fence ? job->base.s_fence->fi=
nished.context : 0;
> >       }
> >
> >       if (vm_flush_needed) {
> > --
> > 2.50.0
> >
>
> --
> Rodrigo Siqueira

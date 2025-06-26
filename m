Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845DDC7EE31
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 17:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D0B10E2E1;
	Thu, 26 Jun 2025 17:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSSSyf7F";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85BF10E2E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 17:25:14 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-31305ee3281so145976a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750958714; x=1751563514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+G/On2FEOkBGoAAO1kFO8q74HR3EXaetGU8Oll0Y0M=;
 b=mSSSyf7Fh9NnKW6LCC3T47hBjIXSrMpEiuARAfojmbP/cJqs0fAjNxXkhyWs8p92eJ
 raUDcwJExm0xljxd8gZi0bsnW97QPmVvXnVGWMt6URu+eG0A1AXXB/3+qGn73iDG31kl
 vvmIqLlIJ8pQd2SfqWpM8lbp2mBQXwUpuzF+DnNBATagqwmg2xHQ2wpS524JW67C9sNk
 p5FeO843IySe9UVXj1CnCXoFPgD1wrbt3bpyvMvBseq/VO3kPZrHADrkra/CncNhtcIz
 bV4gvv7UDzDVmvAwvOuSYway+ra8ooONJ7RiK55poJBoj8IbInAqgX5ak3hoMl6Gm/bu
 /CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750958714; x=1751563514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+G/On2FEOkBGoAAO1kFO8q74HR3EXaetGU8Oll0Y0M=;
 b=DRQgDJKnqaHJ5DjogAZ0zgZ3F3XuxaBjC4BaX913iLuwYsczhM77XSZJr1ZwIrvilt
 284leaLwZxg7U7nXNlCxz00tEzko/H3N0psrnnrx5j882elEF4Xr6RTV5yRCPaGazbkN
 N84nt32mj+h5sDwsZag3YqDl1CukHUooAOQgH5eZ9wPeOHBtwGXTqU5lz70gmYXQsOxX
 QksgA03kO8kW1VxBe1QgtVDaxwXtC3lxrWEBGRMq6AG/0y28yaApgIBShRWCV3FYcWEs
 I1rf7jmf6fMR8XJ1S5wdz7cW553U2csVNIelfvV475MFhhv70Fywzz+ms5c4jm75+qPk
 zZKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHaoLZUuSktS5rX4y5OTX55Fi7xyeruJaozU2SpvWAa4jMRA3lgHSaorY18qznBJEdHG9lPGIH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiP5keFgGGS8MpFuw82GCrdtZaxS2JgtHa90/QjGtIqPVMNRNk
 LZrzo/MC2iTFknLVC/WISIxcKb9ixQBNSUZStpi2GRgplGUZZwPQkzhOTGv7mIKnUyR05nNX+95
 CcQteSNKToHQLcLqa2hrADREOj6Hhj2Ahfw==
X-Gm-Gg: ASbGncsAOllEQSSCwyxMSYAeAcVsfTwM8mE0iIckAMZBKL+RZiNsfVBlN+vCNbLPZ3V
 sq4VLieLgipPIanKEry5xpuXvqf1gwtDfy0+aMU0VFzvw4V9hkt5g0WmOiXpnSF6WvacWoKhU+i
 y7jkVW19SkOOD83hA7BpZgnf+zC4H7rPU4O486onOvhwlF
X-Google-Smtp-Source: AGHT+IE+fzH0BhzFPYq5nlsYYSKS/j7fV8xE9+StSKldsFEhTyo6stRLoB2lwwrKW4TCSEy0ux/6xxBxiFZb6AphZX4=
X-Received: by 2002:a17:90b:1645:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-315f2680018mr3827684a91.3.1750958714099; Thu, 26 Jun 2025
 10:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250625210638.422479-1-alexander.deucher@amd.com>
 <20250625210638.422479-8-alexander.deucher@amd.com>
 <6165855e-2e3e-4f32-9946-e81cff2353ce@amd.com>
In-Reply-To: <6165855e-2e3e-4f32-9946-e81cff2353ce@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Jun 2025 13:25:01 -0400
X-Gm-Features: Ac12FXxn8ulFXsaIdZDLmCx_gd3NnICrOOqBMl9g94NAAdkohKQOU4uxlAI1vCY
Message-ID: <CADnq5_O0u6w9tfj5vgcoWjjWNiG6qAhHX7=1k76SYS6js1cU=Q@mail.gmail.com>
Subject: Re: [PATCH 07/30] drm/amdgpu: track ring state associated with a fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 sasundar@amd.com
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

On Thu, Jun 26, 2025 at 7:03=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 25.06.25 23:06, Alex Deucher wrote:
> > We need to know the wptr and sequence number associated
> > with a fence so that we can re-emit the unprocessed state
> > after a ring reset.  Pre-allocate storage space for
> > the ring buffer contents and add helpers to save off
> > and re-emit the unprocessed state so that it can be
> > re-emitted after the queue is reset.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 99 +++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 15 +++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 59 ++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 17 ++++
> >  5 files changed, 191 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 2d6b2b486baf7..db14bdc7053ca 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -120,11 +120,13 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, s=
truct dma_fence **f,
> >               am_fence =3D kzalloc(sizeof(*am_fence), GFP_KERNEL);
> >               if (!am_fence)
> >                       return -ENOMEM;
> > +             am_fence->context =3D 0;
> >       } else {
> >               am_fence =3D af;
> >       }
> >       fence =3D &am_fence->base;
> >       am_fence->ring =3D ring;
> > +     am_fence->wptr =3D 0;
> >
> >       seq =3D ++ring->fence_drv.sync_seq;
> >       if (af) {
> > @@ -253,6 +255,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
> >
> >       do {
> >               struct dma_fence *fence, **ptr;
> > +             struct amdgpu_fence *am_fence;
> >
> >               ++last_seq;
> >               last_seq &=3D drv->num_fences_mask;
> > @@ -265,6 +268,13 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring=
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
> > +             if (am_fence->wptr)
> > +                     drv->last_wptr =3D am_fence->wptr;
>
> That looks fishy. We don't need the last wptr, but the first processed on=
e.

I will rename it to signalled_wptr, but I think it is correct.  This
is the wptr associated with the last fence that signalled.  That is
the starting point for saving the ring contents.

Alex

>
> >               dma_fence_signal(fence);
> >               dma_fence_put(fence);
> >               pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> > @@ -727,6 +737,95 @@ void amdgpu_fence_driver_force_completion(struct a=
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
> > + * lose all of that state.  In order to minimize the collatoral damage=
, the
>
> Typo "collateral".
>
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
> > +     amdgpu_fence_write(fence->ring, fence->base.seqno);
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
> > +                                                unsigned int idx,
>
> idx is unused.
>
> > +                                                u64 start_wptr, u32 en=
d_wptr)
> > +{
> > +     unsigned int first_idx =3D start_wptr & ring->buf_mask;
> > +     unsigned int last_idx =3D end_wptr & ring->buf_mask;
> > +     unsigned int i, count;
> > +
> > +     /* Backup the contents of the ring buffer. */
> > +     for (i =3D first_idx, count =3D 0; i !=3D last_idx; ++i, i &=3D r=
ing->buf_mask, ++count)
>
> count should start at ring->ring_backup_entries_to_copy.
>
> > +             ring->ring_backup[count] =3D ring->ring[i];
> > +     ring->ring_backup_entries_to_copy =3D count;
> > +}
> > +
> > +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> > +                                          struct amdgpu_fence *guilty_=
fence)
> > +{
> > +     struct amdgpu_fence *fence;
> > +     struct dma_fence *unprocessed, **ptr;
>
> ptr need an __rcu annotation or otherwise the automated tools will start =
complaining.
>
> > +     u64 wptr, i, seqno;
> > +
> > +     if (guilty_fence) {
> > +             seqno =3D guilty_fence->base.seqno;
> > +             wptr =3D guilty_fence->wptr;
>
> I think we can just always go over the whole ring buffer here. E.g. dropp=
ing this if branch.
>
>
> > +     } else {
> > +             seqno =3D amdgpu_fence_read(ring);
> > +             wptr =3D ring->fence_drv.last_wptr;
>
> Again that looks fishy. We shouldn't start at the last wptr, but the firs=
t.
>
> > +     }
> > +     ring->ring_backup_entries_to_copy =3D 0;
> > +     for (i =3D seqno + 1; i <=3D ring->fence_drv.sync_seq; ++i) {
> > +             ptr =3D &ring->fence_drv.fences[i & ring->fence_drv.num_f=
ences_mask];
> > +             rcu_read_lock();
> > +             unprocessed =3D rcu_dereference(*ptr);
> > +
> > +             if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> > +                     fence =3D container_of(unprocessed, struct amdgpu=
_fence, base);
>
> We should probably make ring->fence_drv.fences an array of amdgpu_fences.
>
> > +
> > +                     /* save everything if the ring is not guilty, oth=
erwise
> > +                      * just save the content from other contexts.
> > +                      */
> > +                     if (fence->wptr &&
> > +                         (!guilty_fence || (fence->context !=3D guilty=
_fence->context))) {
> > +                             amdgpu_ring_backup_unprocessed_command(ri=
ng,
> > +                                                                    ri=
ng->ring_backup_entries_to_copy,
> > +                                                                    wp=
tr,
> > +                                                                    fe=
nce->wptr);
> > +                             wptr =3D fence->wptr;
>
> Wptr also needs to be updated for already signaled fences and fences whic=
h are skipped because they belong to the guilty context.
>
> Christian.
>
> > +                     }
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
> > index 206b70acb29a0..d0f838fde2ae5 100644
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
> > @@ -309,6 +313,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >
> >       amdgpu_ring_ib_end(ring);
> >       amdgpu_ring_commit(ring);
> > +
> > +     /* Save the wptr associated with this fence.
> > +      * This must be last for resets to work properly
> > +      * as we need to save the wptr associated with this
> > +      * fence so we know what rings contents to backup
> > +      * after we reset the queue.
> > +      */
> > +     amdgpu_fence_save_wptr(*f);
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
> > index 426834806fbf2..0985eba010e17 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, s=
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
> > @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, st=
ruct amdgpu_ring *ring,
> >                                           (void **)&ring->ring);
> >               if (r) {
> >                       dev_err(adev->dev, "(%d) ring create failed\n", r=
);
> > +                     kvfree(ring->ring_backup);
> >                       return r;
> >               }
> >               amdgpu_ring_clear_ring(ring);
> > @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
> >       amdgpu_bo_free_kernel(&ring->ring_obj,
> >                             &ring->gpu_addr,
> >                             (void **)&ring->ring);
> > +     kvfree(ring->ring_backup);
> > +     ring->ring_backup =3D NULL;
> >
> >       dma_fence_put(ring->vmid_wait);
> >       ring->vmid_wait =3D NULL;
> > @@ -753,3 +762,53 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *r=
ing)
> >
> >       return true;
> >  }
> > +
> > +static int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring =
*ring)
> > +{
> > +     unsigned int i;
> > +     int r;
> > +
> > +     /* re-emit the unprocessed ring contents */
> > +     if (ring->ring_backup_entries_to_copy) {
> > +             r =3D amdgpu_ring_alloc(ring, ring->ring_backup_entries_t=
o_copy);
> > +             if (r)
> > +                     return r;
> > +             for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> > +                     amdgpu_ring_write(ring, ring->ring_backup[i]);
> > +             amdgpu_ring_commit(ring);
> > +     }
> > +
> > +     return 0;
> > +}
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
> > +     r =3D amdgpu_ring_reemit_unprocessed_commands(ring);
> > +     if (r)
> > +             /* if we fail to reemit, force complete all fences */
> > +             amdgpu_fence_driver_force_completion(ring);
> > +     /* Start the scheduler again */
> > +     drm_sched_wqueue_start(&ring->sched);
> > +     return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 784ba2ec354c7..2b5546d15a6be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
> >       /* sync_seq is protected by ring emission lock */
> >       uint32_t                        sync_seq;
> >       atomic_t                        last_seq;
> > +     u64                             last_wptr;
> >       bool                            initialized;
> >       struct amdgpu_irq_src           *irq_src;
> >       unsigned                        irq_type;
> > @@ -141,6 +142,11 @@ struct amdgpu_fence {
> >       /* RB, DMA, etc. */
> >       struct amdgpu_ring              *ring;
> >       ktime_t                         start_timestamp;
> > +
> > +     /* wptr for the fence for resets */
> > +     u64                             wptr;
> > +     /* fence context for resets */
> > +     u64                             context;
> >  };
> >
> >  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> > @@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sc=
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
> > @@ -284,6 +292,9 @@ struct amdgpu_ring {
> >
> >       struct amdgpu_bo        *ring_obj;
> >       uint32_t                *ring;
> > +     /* backups for resets */
> > +     uint32_t                *ring_backup;
> > +     unsigned int            ring_backup_entries_to_copy;
> >       unsigned                rptr_offs;
> >       u64                     rptr_gpu_addr;
> >       volatile u32            *rptr_cpu_addr;
> > @@ -550,4 +561,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev=
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
>

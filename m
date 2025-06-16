Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B933C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 13:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23ACA10E3B0;
	Mon, 16 Jun 2025 13:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SdKY5dTM";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CE910E3B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 13:47:19 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-313067339e9so782878a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750081639; x=1750686439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tnvohrjpNM2UUd1XY+XcyqtXhu4Gi0kouda7RRZFKU=;
 b=SdKY5dTMZ/zFwIHCtF49Zh49leKIi1S2TrT7cZmLQDb0Izh+C/SjI58kN3m8Ya17nV
 8pgFtpfulHS6O+WyJg7g7DDLGWSws2haY7pDhYSfTj8WsOk7jgjjxCTVxHyXLGAa7ahi
 6CqU/fUp0lc4ImoQiG+2GPrWZY04K88qKGW4KeKxFL3kgCUaao/pgl6utm62dgqOxF9Y
 0WRuTNrMA2YrUQE49ut6dkbRifhJVfAm+AaNibXEvoGICjxc3jg2IiPkb4/9/8najK0c
 TFrIb12Idn9zVeGz7dMZHAAfdoi5fponHmKz/eJSTxY7V2wNZDS5JRmfb40+o05nfuwj
 9PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750081639; x=1750686439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tnvohrjpNM2UUd1XY+XcyqtXhu4Gi0kouda7RRZFKU=;
 b=gce2db5QZvyMXucZ0up/HYbyv6Hmwu050dWzy3SJvgDxGwsdKmZYoBKrOG8OQL4gzN
 iAiyX41Rg/CrLsscFAp+yrhhIB3wYBKHIeLc/GuZCURXHsmt6clEz7O6kDFB8DAYtUd9
 bfwZGGEM9bGKFkmJY6k5xGuSGv68rZaBYkPzwu1rQlsyB5zHmqoZvToJKjDdIE/7Iu3k
 NeW4khUcKyszVW1aBqVX+qgGXVJoI9BJR/AtHC7GmFlgYW1ma2LMaJgrzUPieVgRN1Zi
 MJdUagcVlagoOPsUMG8Z0IfccRaqtcu8NgOKsV00Fq3EOsNEYtfZpU6y5M5ippXqJUyk
 3gNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeh517LTyLw1W2DnTMdVVuvXXpta/usHrfCHAe6DW63aqyQQNyxXgJPJMNLRJgKsjwZARa/2Af@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyATKwtGF1oZ3TeXthgtHay2tjChTJjkW+JvDUkR9eeuDyeF+Oo
 wFaDkD0USr40qFFbYEUprF+D4m9LRIfmMEEuKRHeDRqJC7a0lYPTyx/JeNKWSt/YSn4cGidNw0n
 iDGzu8rWolk+UtJLNkUAYy80P89vRT5M=
X-Gm-Gg: ASbGncvDSIOqPItGRTuJc113LcOluaBKO69N5Yg8kK70X6QQp9/4VR/sHDPS1nNwC16
 dwKjqDKP5cA4Aj/wz96rebmJTWz/saqHayIDq3nGFBA/8c6vMx5O+9noN/6PgmLfT/CM4QLFBLv
 CKpA8nCkCnlzvD5R4QdFSTFL4THCTRWIxpXqrwy1T8sQb2DivhZpe0ay8=
X-Google-Smtp-Source: AGHT+IHwbI7/KZHL4c+W41xMn2qS0TmqrCErEGmtdcEHOXBqFacA5Ezga3xwfLqEJhXx04hcET739o8AHVVVy3rofDA=
X-Received: by 2002:a17:90b:57c3:b0:311:b0d3:851 with SMTP id
 98e67ed59e1d1-313f1d564e0mr5466136a91.4.1750081639189; Mon, 16 Jun 2025
 06:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250613214748.5889-1-alexander.deucher@amd.com>
 <20250613214748.5889-2-alexander.deucher@amd.com>
 <29965831-bf4c-4a00-b619-9782b8c6afae@amd.com>
In-Reply-To: <29965831-bf4c-4a00-b619-9782b8c6afae@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 09:47:06 -0400
X-Gm-Features: AX0GCFsQ4t60E7VjOoCIEVcvOsPCSYgPuJWX-2DKm6A8SWauKTWekuolHKxN_qs
Message-ID: <CADnq5_PVLAVejzPLbYmpDKYt3qdA_BPb_fhMHXp4hr7WX+m=uQ@mail.gmail.com>
Subject: Re: [PATCH 01/27] drm/amdgpu: switch job hw_fence to amdgpu_fence
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

On Mon, Jun 16, 2025 at 8:16=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/13/25 23:47, Alex Deucher wrote:
> > Use the amdgpu fence container so we can store additional
> > data in the fence.  This also fixes the start_time handling
> > for MCBP since we were casting the fence to an amdgpu_fence
> > and it wasn't.
> >
> > Fixes: 3f4c175d62d8 ("drm/amdgpu: MCBP based on DRM scheduler (v9)")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++----------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
> >  6 files changed, 32 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index 8e626f50b362e..f81608330a3d0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(st=
ruct amdgpu_ring *ring)
> >                       continue;
> >               }
> >               job =3D to_amdgpu_job(s_job);
> > -             if (preempted && (&job->hw_fence) =3D=3D fence)
> > +             if (preempted && (&job->hw_fence.base) =3D=3D fence)
> >                       /* mark the job as preempted */
> >                       job->preemption_status |=3D AMDGPU_IB_PREEMPTED;
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 00174437b01ec..4893f834f4fd4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6397,7 +6397,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
> >        *
> >        * job->base holds a reference to parent fence
> >        */
> > -     if (job && dma_fence_is_signaled(&job->hw_fence)) {
> > +     if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> >               job_signaled =3D true;
> >               dev_info(adev->dev, "Guilty job already signaled, skippin=
g HW reset");
> >               goto skip_hw_reset;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 2f24a6aa13bf6..569e0e5373927 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -41,22 +41,6 @@
> >  #include "amdgpu_trace.h"
> >  #include "amdgpu_reset.h"
> >
> > -/*
> > - * Fences mark an event in the GPUs pipeline and are used
> > - * for GPU/CPU synchronization.  When the fence is written,
> > - * it is expected that all buffers associated with that fence
> > - * are no longer in use by the associated ring on the GPU and
> > - * that the relevant GPU caches have been flushed.
> > - */
> > -
> > -struct amdgpu_fence {
> > -     struct dma_fence base;
> > -
> > -     /* RB, DMA, etc. */
> > -     struct amdgpu_ring              *ring;
> > -     ktime_t                         start_timestamp;
> > -};
> > -
> >  static struct kmem_cache *amdgpu_fence_slab;
> >
> >  int amdgpu_fence_slab_init(void)
> > @@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, s=
truct dma_fence **f, struct amd
> >               am_fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOM=
IC);
> >               if (am_fence =3D=3D NULL)
> >                       return -ENOMEM;
> > -             fence =3D &am_fence->base;
> > -             am_fence->ring =3D ring;
> >       } else {
> >               /* take use of job-embedded fence */
> > -             fence =3D &job->hw_fence;
> > +             am_fence =3D &job->hw_fence;
> >       }
> > +     fence =3D &am_fence->base;
> > +     am_fence->ring =3D ring;
>
> I would rather completely drop the job from the parameters and the genera=
l fence allocation here.
>
> Instead we should just provide afence as input parameter and submit that =
one.
>
> This should make sure that we don't run into such issues again.

How about doing that as a follow on patch?  It looks like that will be
a much bigger patch for a stable bug fix.  I think we can clean up a
lot of stuff in amdgpu_fence.c with that change.

Alex

>
> Apart from that looks good to me,
> Christian.
>
> >
> >       seq =3D ++ring->fence_drv.sync_seq;
> >       if (job && job->job_run_counter) {
> > @@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct am=
dgpu_ring *ring)
> >                        * it right here or we won't be able to track the=
m in fence_drv
> >                        * and they will remain unsignaled during sa_bo f=
ree.
> >                        */
> > -                     job =3D container_of(old, struct amdgpu_job, hw_f=
ence);
> > +                     job =3D container_of(old, struct amdgpu_job, hw_f=
ence.base);
> >                       if (!job->base.s_fence && !dma_fence_is_signaled(=
old))
> >                               dma_fence_signal(old);
> >                       RCU_INIT_POINTER(*ptr, NULL);
> > @@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(s=
truct dma_fence *f)
> >
> >  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence=
 *f)
> >  {
> > -     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_=
fence);
> > +     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_=
fence.base);
> >
> >       return (const char *)to_amdgpu_ring(job->base.sched)->name;
> >  }
> > @@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dm=
a_fence *f)
> >   */
> >  static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
> >  {
> > -     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_=
fence);
> > +     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_=
fence.base);
> >
> >       if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fa=
llback_timer))
> >               amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.s=
ched));
> > @@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *=
rcu)
> >       struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
> >
> >       /* free job if fence has a parent job */
> > -     kfree(container_of(f, struct amdgpu_job, hw_fence));
> > +     kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> >  }
> >
> >  /**
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index acb21fc8b3ce5..ddb9d3269357c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *j=
ob)
> >       /* Check if any fences where initialized */
> >       if (job->base.s_fence && job->base.s_fence->finished.ops)
> >               f =3D &job->base.s_fence->finished;
> > -     else if (job->hw_fence.ops)
> > -             f =3D &job->hw_fence;
> > +     else if (job->hw_fence.base.ops)
> > +             f =3D &job->hw_fence.base;
> >       else
> >               f =3D NULL;
> >
> > @@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched_j=
ob *s_job)
> >       amdgpu_sync_free(&job->explicit_sync);
> >
> >       /* only put the hw fence if has embedded fence */
> > -     if (!job->hw_fence.ops)
> > +     if (!job->hw_fence.base.ops)
> >               kfree(job);
> >       else
> > -             dma_fence_put(&job->hw_fence);
> > +             dma_fence_put(&job->hw_fence.base);
> >  }
> >
> >  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> > @@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
> >       if (job->gang_submit !=3D &job->base.s_fence->scheduled)
> >               dma_fence_put(job->gang_submit);
> >
> > -     if (!job->hw_fence.ops)
> > +     if (!job->hw_fence.base.ops)
> >               kfree(job);
> >       else
> > -             dma_fence_put(&job->hw_fence);
> > +             dma_fence_put(&job->hw_fence.base);
> >  }
> >
> >  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.h
> > index f2c049129661f..931fed8892cc1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -48,7 +48,7 @@ struct amdgpu_job {
> >       struct drm_sched_job    base;
> >       struct amdgpu_vm        *vm;
> >       struct amdgpu_sync      explicit_sync;
> > -     struct dma_fence        hw_fence;
> > +     struct amdgpu_fence     hw_fence;
> >       struct dma_fence        *gang_submit;
> >       uint32_t                preamble_status;
> >       uint32_t                preemption_status;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index b95b471107692..e1f25218943a4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
> >       struct dma_fence                **fences;
> >  };
> >
> > +/*
> > + * Fences mark an event in the GPUs pipeline and are used
> > + * for GPU/CPU synchronization.  When the fence is written,
> > + * it is expected that all buffers associated with that fence
> > + * are no longer in use by the associated ring on the GPU and
> > + * that the relevant GPU caches have been flushed.
> > + */
> > +
> > +struct amdgpu_fence {
> > +     struct dma_fence base;
> > +
> > +     /* RB, DMA, etc. */
> > +     struct amdgpu_ring              *ring;
> > +     ktime_t                         start_timestamp;
> > +};
> > +
> >  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> >
> >  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>

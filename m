Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB472C61CE7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 16:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862EA10EAEF;
	Fri,  6 Jun 2025 16:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SiFVAHfN";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B1410EAEC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 16:08:36 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b26fabda6d9so193769a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jun 2025 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749226116; x=1749830916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sF7rh69sgPbUL9BsTBXJsVBwiZyhd+AeiPTeKTooONA=;
 b=SiFVAHfNGMN828IpQUe/eGKk1+jRM+J6RCLJ7Z/8UQ8etMnkZZ+7qmHfg/S5o/Pu4S
 Di+5PsPM409iZiTOP0eoBcdopWKk4573R98qUAuOkxW7B9Mpncaq26OeuCz9D/YzfJc+
 ulcW2lafH5+2eNrnREsbkUJzHhrbmCWSiqMWvZ9uYToB67D5Nt+w6D+r8xtK5/1Dtjde
 xdaThydu8UgqX02nGOxdM1i1bTi7+V+vMegHfLScqi0JWRnKzzsGIgjYk84V5eMzsFHD
 sHjSq7XzcZGVz3rJWa8Unfh7ABe0U3Ta/W2dMz3GoRcyi4nAp25wQi+iIotpRDOfSulH
 1zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749226116; x=1749830916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sF7rh69sgPbUL9BsTBXJsVBwiZyhd+AeiPTeKTooONA=;
 b=Y8NIqehxSBv2BxJJ/s/iXvl9WkJ3lqrXE+gmtscArFwGdWeECejZBPOoeB9a1x2Q9F
 b4wiEYyBAbQz4VjZ39E3YEKBeqpe93j6kcT6hyk8JFB/sdKkZIx0DKurcOoyuQ0EsDtd
 5dXsPqJmykPk1ku3X0l3NVQ3wn1T/US/OgB2QflBFe0Le21EM6kTL624G2q88nlq/hfq
 aAiOVrhvAhYrvxtl4+FBXmJeOLugRLfr2atcTVUKYZrsQVGgSG3j44UewF0yXDLVYOLq
 Xy1XTjaX7UjdgX8y/u7jbs7dBbZq0ogSbXqvjco6J8Fm3Qw9yQk6Cro0TbQnBBIk+q5X
 CXLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZnAlp4FMA3rSK3ZqBAwFNjvahymFwmn/6nAtI3+MPo0xBWetIKYyUzKyB0AFRyflVoIhlDyZ2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7D9kXz86ORGpbfJ5h4llOl0rpx1aOaSJH/EJf9TeV7xT0WTXU
 dFA9jZIMvMt7su4plBYa4I/3jFb2d6ekXtbuYz+oVO+2OZOgYUb18aC9QK8pQjFuGRw8PVviZcv
 VO3HSN6idH8A6QPYzDoWhNB5YL8vZ1uXnHg==
X-Gm-Gg: ASbGncveElKKj2nM9EpS6R09999OvFaHVSVww6UmB8UHgc951seUq7pcDvLsewYtL5m
 lHVL38ofuB88J3mZAgoO3Dq2WnOMsuqhMVlyS8CCdmzz1h1Cr8YMEY1owdqzJhid0AgDBPuGIeH
 oUt2KiYsM8JIcKjnvL3BXBfyUucnzhVb0tkg==
X-Google-Smtp-Source: AGHT+IEG0pj1mHysdb+2/YDUeJ/HSpsYUFvAZfv/4NIu34AUXQ+IYpbZJv7EFytmKuoaBUy1vjsdF7FRJGx7SkfU8PI=
X-Received: by 2002:a17:90b:3c89:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31347506b75mr2228054a91.3.1749226115990; Fri, 06 Jun 2025
 09:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-6-alexander.deucher@amd.com>
 <ac6a8a10-fbee-445b-8031-8b5c42f02695@amd.com>
In-Reply-To: <ac6a8a10-fbee-445b-8031-8b5c42f02695@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Jun 2025 12:08:24 -0400
X-Gm-Features: AX0GCFtZsPikDc381HzOECIZl_87SOFz_KI9OXEi77A7_iSH3lnRJZ95kwFeBa8
Message-ID: <CADnq5_PpRemT+dkzBegFWDE7TQTCr-x0NEEys99MDGv_X2KOsA@mail.gmail.com>
Subject: Re: [PATCH 05/29] drm/amdgpu: switch job hw_fence to amdgpu_fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Jun 6, 2025 at 7:39=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 6/6/25 08:43, Alex Deucher wrote:
> > Use the amdgpu fence container so we can store additional
> > data in the fence.
> >
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
> > index ea565651f7459..8298e95e4543e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6375,7 +6375,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
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
>
> Oh, that handling here is completely broken.
>
> The MCBP muxer overwrites fields in the job because of this ^^.
>
> I think that patch needs to be a bug fix we even backport.

What is broken in the muxer code?

Alex

>
> Regards,
> CFhristian.
>
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

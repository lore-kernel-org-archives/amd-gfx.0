Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CC9C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 18:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEF310E418;
	Mon, 16 Jun 2025 18:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3IEgmvY";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C368810E438
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 18:36:52 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3138e64fc73so780345a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750099012; x=1750703812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJLwxmC4HTWXhftWF+d9b0oVxKTCkOQyFbai1fwvKoA=;
 b=T3IEgmvY+i8Rs1eD7ifuY8FFxrxSOR2OmutCCtuue1F6HQdnl/Pj8utdyU3LvjfJ+m
 FLhZmtZGWUtCw3zpTgdD9YJxFr8oN3xhsSKLQOR1OeEsVnB+63A9bLeN0z3uOC6ZH9ji
 AJpyFJaNdurwWNVll5sYLCTUbsijkWfLcVmeZLCK7K6FkN5WzmHzFCwg4a0k5YJRwTNs
 RerDpLU4axATrmDE4AJ3MHE4Sh4QTlf4Dzpp2ePsSVKYjx+8W2qQnsr1Y4pzKn28GnFP
 plm/JP8x8KeqpmWpwTKsfpZA9G+/I1jX43zM+4/gbnGUM6Vfjm159jwTiahENhWiq/W8
 tD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750099012; x=1750703812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJLwxmC4HTWXhftWF+d9b0oVxKTCkOQyFbai1fwvKoA=;
 b=PeP5ho/48ZIYvSdLEAwB+l5cdVHmMVBegBso4DU2GzlE2fGXB+rtoMv/Kjwsec6gDk
 ixS5b+ZfYiyDNJUlYUaCZMIz+KL7/YUqNpQYFbXwy7QebTqfzmsVmhjQwCt7poRCT+OH
 CxO79scKgyWhIKEwiJmUTnN8L3uCXZ8YNA6sW5rPScc7gpK2zPOlN4vw16/lJyAHH4XG
 tT24n1g3LYkhvQ/CLiEgZ/2QxTZuuSxA7U9fiQbiJrnKAwKHot9B0TrZZZk3OkPe+0Uj
 hWhQf1YcyHWc7yB85VuUO5poqtct/ebBXdqzu1V90tjYaBXISGEnNwPmBVHR5EIGMWXY
 HT5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxEMPq1Sc0GEGojPMqj37uh0mGhmsxTVF+doM5JZ+Zk2ek96L5jy7bi0Serc3gR4WSAAESkf3Z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYZWxaMliN9MFnMcncsYlyKPmJKjK/mUuXny36XnAR+1Z4yl2L
 4plYnkx/bm52Bs53TgNuxSJT6oTeRzXlFoESbh03XVekpsIMJm3hwBAzLH9Sqm+dM9uGvnu8ktS
 ZbF4c9lzXPtuyljLlFC5JJ8MnA4m0VehGpDE9
X-Gm-Gg: ASbGncvxADprU3SrO6QNi8Z4V6lnYu8a0v2yu0DmV7KnI47rzGqCEudpAlfZh08fHIv
 dmJiiJXHcwPZV23oJOQbcT8dClc7O3Sr94zahqtt3njEtj3dAYxZS/Oc78/VhiOU4LIURXQPF+8
 mRGrVyP/8xWZgQl+WQA2Fpfk+i6tgibx6zlG4xyrltNhw7
X-Google-Smtp-Source: AGHT+IESzbvOiZevZiutgayak6uDHm2AyWOBHEXlOfQ+si0MFhs6qnHI9zpfgbbEgl8EN0LkHQZx5huni3s+BM9vdmU=
X-Received: by 2002:a17:90b:39c5:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-313f1deb5b8mr5995964a91.8.1750099012107; Mon, 16 Jun 2025
 11:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250613214748.5889-1-alexander.deucher@amd.com>
 <20250613214748.5889-2-alexander.deucher@amd.com>
 <29965831-bf4c-4a00-b619-9782b8c6afae@amd.com>
 <CADnq5_PVLAVejzPLbYmpDKYt3qdA_BPb_fhMHXp4hr7WX+m=uQ@mail.gmail.com>
 <70adb9ab-52fa-4877-a0de-e6399e8aee8f@amd.com>
In-Reply-To: <70adb9ab-52fa-4877-a0de-e6399e8aee8f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 14:36:40 -0400
X-Gm-Features: AX0GCFtmffbnjB9tmewbi3PFt4hOtWSXtDIV57WGvPPRnPeddpB8pTgTf1CdpAE
Message-ID: <CADnq5_NeVqkYvUVU8_vw=f+MMqF-hstDHz+t3S0UbWe9_5u30w@mail.gmail.com>
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

On Mon, Jun 16, 2025 at 1:45=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/16/25 15:47, Alex Deucher wrote:
> > On Mon, Jun 16, 2025 at 8:16=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 6/13/25 23:47, Alex Deucher wrote:
> >>> Use the amdgpu fence container so we can store additional
> >>> data in the fence.  This also fixes the start_time handling
> >>> for MCBP since we were casting the fence to an amdgpu_fence
> >>> and it wasn't.
> >>>
> >>> Fixes: 3f4c175d62d8 ("drm/amdgpu: MCBP based on DRM scheduler (v9)")
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++--------------=
--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
> >>>  6 files changed, 32 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_debugfs.c
> >>> index 8e626f50b362e..f81608330a3d0 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >>> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(=
struct amdgpu_ring *ring)
> >>>                       continue;
> >>>               }
> >>>               job =3D to_amdgpu_job(s_job);
> >>> -             if (preempted && (&job->hw_fence) =3D=3D fence)
> >>> +             if (preempted && (&job->hw_fence.base) =3D=3D fence)
> >>>                       /* mark the job as preempted */
> >>>                       job->preemption_status |=3D AMDGPU_IB_PREEMPTED=
;
> >>>       }
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index 00174437b01ec..4893f834f4fd4 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -6397,7 +6397,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,
> >>>        *
> >>>        * job->base holds a reference to parent fence
> >>>        */
> >>> -     if (job && dma_fence_is_signaled(&job->hw_fence)) {
> >>> +     if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> >>>               job_signaled =3D true;
> >>>               dev_info(adev->dev, "Guilty job already signaled, skipp=
ing HW reset");
> >>>               goto skip_hw_reset;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_fence.c
> >>> index 2f24a6aa13bf6..569e0e5373927 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >>> @@ -41,22 +41,6 @@
> >>>  #include "amdgpu_trace.h"
> >>>  #include "amdgpu_reset.h"
> >>>
> >>> -/*
> >>> - * Fences mark an event in the GPUs pipeline and are used
> >>> - * for GPU/CPU synchronization.  When the fence is written,
> >>> - * it is expected that all buffers associated with that fence
> >>> - * are no longer in use by the associated ring on the GPU and
> >>> - * that the relevant GPU caches have been flushed.
> >>> - */
> >>> -
> >>> -struct amdgpu_fence {
> >>> -     struct dma_fence base;
> >>> -
> >>> -     /* RB, DMA, etc. */
> >>> -     struct amdgpu_ring              *ring;
> >>> -     ktime_t                         start_timestamp;
> >>> -};
> >>> -
> >>>  static struct kmem_cache *amdgpu_fence_slab;
> >>>
> >>>  int amdgpu_fence_slab_init(void)
> >>> @@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,=
 struct dma_fence **f, struct amd
> >>>               am_fence =3D kmem_cache_alloc(amdgpu_fence_slab, GFP_AT=
OMIC);
> >>>               if (am_fence =3D=3D NULL)
> >>>                       return -ENOMEM;
> >>> -             fence =3D &am_fence->base;
> >>> -             am_fence->ring =3D ring;
> >>>       } else {
> >>>               /* take use of job-embedded fence */
> >>> -             fence =3D &job->hw_fence;
> >>> +             am_fence =3D &job->hw_fence;
> >>>       }
> >>> +     fence =3D &am_fence->base;
> >>> +     am_fence->ring =3D ring;
> >>
> >> I would rather completely drop the job from the parameters and the gen=
eral fence allocation here.
> >>
> >> Instead we should just provide afence as input parameter and submit th=
at one.
> >>
> >> This should make sure that we don't run into such issues again.
> >
> > How about doing that as a follow on patch?  It looks like that will be
> > a much bigger patch for a stable bug fix.  I think we can clean up a
> > lot of stuff in amdgpu_fence.c with that change.
>
> Works for me. I would also suggest to remove the kmem_cache_alloc() and j=
ust use kmalloc for the rare cases where we need an independent fence.
>
> Additional to that the ring and start_time member looks suspicious. We sh=
ould not have that inside the fence in the first place.

The ring member is used in a number of places to get from the fence to
get to the fence_drv and the ring name.  The start_time is from MCBP.
I don't remember the details.  While we are here, I think we can
remove job->job_run_counter as well?  We don't support resubmission
anymore.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> Apart from that looks good to me,
> >> Christian.
> >>
> >>>
> >>>       seq =3D ++ring->fence_drv.sync_seq;
> >>>       if (job && job->job_run_counter) {
> >>> @@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct =
amdgpu_ring *ring)
> >>>                        * it right here or we won't be able to track t=
hem in fence_drv
> >>>                        * and they will remain unsignaled during sa_bo=
 free.
> >>>                        */
> >>> -                     job =3D container_of(old, struct amdgpu_job, hw=
_fence);
> >>> +                     job =3D container_of(old, struct amdgpu_job, hw=
_fence.base);
> >>>                       if (!job->base.s_fence && !dma_fence_is_signale=
d(old))
> >>>                               dma_fence_signal(old);
> >>>                       RCU_INIT_POINTER(*ptr, NULL);
> >>> @@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name=
(struct dma_fence *f)
> >>>
> >>>  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fen=
ce *f)
> >>>  {
> >>> -     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, h=
w_fence);
> >>> +     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, h=
w_fence.base);
> >>>
> >>>       return (const char *)to_amdgpu_ring(job->base.sched)->name;
> >>>  }
> >>> @@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct =
dma_fence *f)
> >>>   */
> >>>  static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
> >>>  {
> >>> -     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, h=
w_fence);
> >>> +     struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, h=
w_fence.base);
> >>>
> >>>       if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.=
fallback_timer))
> >>>               amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base=
.sched));
> >>> @@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head=
 *rcu)
> >>>       struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu=
);
> >>>
> >>>       /* free job if fence has a parent job */
> >>> -     kfree(container_of(f, struct amdgpu_job, hw_fence));
> >>> +     kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> >>>  }
> >>>
> >>>  /**
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_job.c
> >>> index acb21fc8b3ce5..ddb9d3269357c 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> @@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job =
*job)
> >>>       /* Check if any fences where initialized */
> >>>       if (job->base.s_fence && job->base.s_fence->finished.ops)
> >>>               f =3D &job->base.s_fence->finished;
> >>> -     else if (job->hw_fence.ops)
> >>> -             f =3D &job->hw_fence;
> >>> +     else if (job->hw_fence.base.ops)
> >>> +             f =3D &job->hw_fence.base;
> >>>       else
> >>>               f =3D NULL;
> >>>
> >>> @@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched=
_job *s_job)
> >>>       amdgpu_sync_free(&job->explicit_sync);
> >>>
> >>>       /* only put the hw fence if has embedded fence */
> >>> -     if (!job->hw_fence.ops)
> >>> +     if (!job->hw_fence.base.ops)
> >>>               kfree(job);
> >>>       else
> >>> -             dma_fence_put(&job->hw_fence);
> >>> +             dma_fence_put(&job->hw_fence.base);
> >>>  }
> >>>
> >>>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> >>> @@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
> >>>       if (job->gang_submit !=3D &job->base.s_fence->scheduled)
> >>>               dma_fence_put(job->gang_submit);
> >>>
> >>> -     if (!job->hw_fence.ops)
> >>> +     if (!job->hw_fence.base.ops)
> >>>               kfree(job);
> >>>       else
> >>> -             dma_fence_put(&job->hw_fence);
> >>> +             dma_fence_put(&job->hw_fence.base);
> >>>  }
> >>>
> >>>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_job.h
> >>> index f2c049129661f..931fed8892cc1 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> >>> @@ -48,7 +48,7 @@ struct amdgpu_job {
> >>>       struct drm_sched_job    base;
> >>>       struct amdgpu_vm        *vm;
> >>>       struct amdgpu_sync      explicit_sync;
> >>> -     struct dma_fence        hw_fence;
> >>> +     struct amdgpu_fence     hw_fence;
> >>>       struct dma_fence        *gang_submit;
> >>>       uint32_t                preamble_status;
> >>>       uint32_t                preemption_status;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.h
> >>> index b95b471107692..e1f25218943a4 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> @@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
> >>>       struct dma_fence                **fences;
> >>>  };
> >>>
> >>> +/*
> >>> + * Fences mark an event in the GPUs pipeline and are used
> >>> + * for GPU/CPU synchronization.  When the fence is written,
> >>> + * it is expected that all buffers associated with that fence
> >>> + * are no longer in use by the associated ring on the GPU and
> >>> + * that the relevant GPU caches have been flushed.
> >>> + */
> >>> +
> >>> +struct amdgpu_fence {
> >>> +     struct dma_fence base;
> >>> +
> >>> +     /* RB, DMA, etc. */
> >>> +     struct amdgpu_ring              *ring;
> >>> +     ktime_t                         start_timestamp;
> >>> +};
> >>> +
> >>>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> >>>
> >>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
> >>
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836FDCA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 13:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D38510E89B;
	Wed,  3 Sep 2025 13:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RiL1OHul";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665B810E89B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 13:47:33 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-24498e93b8fso10647295ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756907253; x=1757512053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/09AWafty4v3tGzshcegIt1IcYwTLlVT+3Puo/ILHA=;
 b=RiL1OHulunrfv6E0zgvbQJJ4ekcdg4zPsrdlM9DhuH4wfZGuVZJAbuTX/2BAxbOR4b
 8zyoXjcBZHeHYdiVUE9xppHc4WAMVLWTZtHAYBgtHTSsn5oLRIn/HQd7/Nuo00bckO01
 drUf7wXDJ2wzgbbHsHGiyYnGSvmkw2TfcKbz+UMLvkcBd0Frqcm4PeYzYMzI9DA+h8jM
 ESbv97UtSa9Gr66NwaYqahNOJg/UyxN1HZliiJtSDjC1GjP/+CYxGlNMdbhfMJkxlGix
 U70B3MosWhupEBmP6p7iTA9b/yH2CghIpwTKIovwuLTGcIRwUL5YJ3GZ1OjIu8m+doby
 9lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756907253; x=1757512053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/09AWafty4v3tGzshcegIt1IcYwTLlVT+3Puo/ILHA=;
 b=chNEd2NazB1622ZP0GL7JoHMblnNjbzs4XLdHGc2Hx8k+PfA/iWLvyFmP74kBPnTkn
 olJgqJOcrZNQa76CUArWUcZhOrA25nD2qUV+J/pUYNG3MVDCYev7bs4w4okXRGRIwBpI
 kAcCJkC/3auzL7UE1eAKpdE5eGTR2WFghRl9hzebOtACl2m18NUuCp+QX0DnSJ/n6v8z
 FaxPO4eO+jG7BdERCEsn3kVmsEwJhS+n7MOHNmO/EGCoHVW04DVWcy2uVaWntzPNjm/w
 dRT823oY92U0Dh4XlxB20iwkgea222BsC5xPY3WUlhBbqZTTnxgLPl+s3uSEqJtdAK1m
 xt5w==
X-Gm-Message-State: AOJu0YyydPqb8Fd6nTukmX1ud6okGFOQ9AUaN6kJgEYKGjGfAD/YSazH
 YZ1ID8Vz2OtbcJsA64f3r1/ulQoo5YygWoF/9bXf0lkZTLheR8Ne3yKpa2ziyyC9WiEXMtV8di0
 cR1EcC1GDmsy/vXBVWhE5pmmcxCN9eRB4kg==
X-Gm-Gg: ASbGncsTAnMzayC60fM5qYsRJiyEO9/q0Ld1b8goo9Wm28iusR9HmA0bntnRnK4VwBy
 vU/eYAxc0RcB6CT+cJZ8CABLwRzTAfp8TMXpEKwiS8/wKHgf/xqlpfWZKyrG/4HYfSYCIZwTeha
 7f4+pR5IRSBrYUJKlug8sJwDnCq492UtEw/c3ewkilOYCDABTUgm8ChZF2lyxLLVXeQ1MpAkiOf
 ruKCC684nNaGY8yzw==
X-Google-Smtp-Source: AGHT+IFEJwQbJdhx878CCtNGMFrE3qLTtUxScYAG/DH4d99fgvySn0qvc/ypMPVUMs0CH0NWgSUJl6MrPxoxtkAsRPk=
X-Received: by 2002:a17:902:da8d:b0:24c:3f42:c154 with SMTP id
 d9443c01a7336-24c3f42c654mr34028405ad.10.1756907252507; Wed, 03 Sep 2025
 06:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250828201924.5812-1-alexander.deucher@amd.com>
In-Reply-To: <20250828201924.5812-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 09:47:20 -0400
X-Gm-Features: Ac12FXx_9HThdONRvQzfBFnN30kRW9uH_LOZB3AFVxy6cLIOkMijV_eNWNTCn_I
Message-ID: <CADnq5_NJPsfNU2Hh8J3i3DyUuLzAhG8qk_kFBhuUtQSzYXeZAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, David.Wu3@amd.com, christian.koenig@amd.com
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

Ping?

On Thu, Aug 28, 2025 at 4:19=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Decouple the amdgpu fence from the amdgpu_job structure.
> This lets us clean up the separate fence ops for the embedded
> fence and other fences.  This also allows us to allocate the
> vm fence up front when we allocate the job.
>
> v2: Additional cleanup suggested by Christian
> v3: Additional cleanups suggested by Christian
> v4: Additional cleanups and suggested by David and
>     vm fence fix
>
> Cc: David.Wu3@amd.com
> Cc: christian.koenig@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 149 +++-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>  8 files changed, 66 insertions(+), 170 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index f81608330a3d0..7ea3cb6491b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(stru=
ct amdgpu_ring *ring)
>                         continue;
>                 }
>                 job =3D to_amdgpu_job(s_job);
> -               if (preempted && (&job->hw_fence.base) =3D=3D fence)
> +               if (preempted && (&job->hw_fence->base) =3D=3D fence)
>                         /* mark the job as preempted */
>                         job->preemption_status |=3D AMDGPU_IB_PREEMPTED;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7783272a79302..add272fa31288 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_dev=
ice *adev,
>                 if (!amdgpu_ring_sched_ready(ring))
>                         continue;
>
> -               /* Clear job fence from fence drv to avoid force_completi=
on
> -                * leave NULL and vm flush fence in fence drv
> -                */
> -               amdgpu_fence_driver_clear_job_fences(ring);
> -
>                 /* after all hw jobs are reset, hw fence is meaningless, =
so force_completion */
>                 amdgpu_fence_driver_force_completion(ring);
>         }
> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>          *
>          * job->base holds a reference to parent fence
>          */
> -       if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> +       if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>                 job_signaled =3D true;
>                 dev_info(adev->dev, "Guilty job already signaled, skippin=
g HW reset");
>                 goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 2d58aefbd68a7..00ae1ef540815 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -45,16 +45,11 @@
>   * Cast helper
>   */
>  static const struct dma_fence_ops amdgpu_fence_ops;
> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>  static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>  {
>         struct amdgpu_fence *__f =3D container_of(f, struct amdgpu_fence,=
 base);
>
> -       if (__f->base.ops =3D=3D &amdgpu_fence_ops ||
> -           __f->base.ops =3D=3D &amdgpu_job_fence_ops)
> -               return __f;
> -
> -       return NULL;
> +       return __f;
>  }
>
>  /**
> @@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring=
)
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
>   * @ring: ring the fence is associated with
> - * @f: resulting fence object
>   * @af: amdgpu fence input
>   * @flags: flags to pass into the subordinate .emit_fence() call
>   *
>   * Emits a fence command on the requested ring (all asics).
>   * Returns 0 on success, -ENOMEM on failure.
>   */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -                     struct amdgpu_fence *af, unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +                     unsigned int flags)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct dma_fence *fence;
> -       struct amdgpu_fence *am_fence;
>         struct dma_fence __rcu **ptr;
>         uint32_t seq;
>         int r;
>
> -       if (!af) {
> -               /* create a separate hw fence */
> -               am_fence =3D kzalloc(sizeof(*am_fence), GFP_KERNEL);
> -               if (!am_fence)
> -                       return -ENOMEM;
> -       } else {
> -               am_fence =3D af;
> -       }
> -       fence =3D &am_fence->base;
> -       am_fence->ring =3D ring;
> +       fence =3D &af->base;
> +       af->ring =3D ring;
>
>         seq =3D ++ring->fence_drv.sync_seq;
> -       am_fence->seq =3D seq;
> -       if (af) {
> -               dma_fence_init(fence, &amdgpu_job_fence_ops,
> -                              &ring->fence_drv.lock,
> -                              adev->fence_context + ring->idx, seq);
> -               /* Against remove in amdgpu_job_{free, free_cb} */
> -               dma_fence_get(fence);
> -       } else {
> -               dma_fence_init(fence, &amdgpu_fence_ops,
> -                              &ring->fence_drv.lock,
> -                              adev->fence_context + ring->idx, seq);
> -       }
> +       dma_fence_init(fence, &amdgpu_fence_ops,
> +                      &ring->fence_drv.lock,
> +                      adev->fence_context + ring->idx, seq);
>
>         amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>                                seq, flags | AMDGPU_FENCE_FLAG_INT);
> -       amdgpu_fence_save_wptr(fence);
> +       amdgpu_fence_save_wptr(af);
>         pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>         ptr =3D &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_=
mask];
>         if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struc=
t dma_fence **f,
>          */
>         rcu_assign_pointer(*ptr, dma_fence_get(fence));
>
> -       *f =3D fence;
> -
>         return 0;
>  }
>
> @@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_devic=
e *adev)
>         }
>  }
>
> -/**
> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of r=
ing
> - *
> - * @ring: fence of the ring to be cleared
> - *
> - */
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
> -{
> -       int i;
> -       struct dma_fence *old, **ptr;
> -
> -       for (i =3D 0; i <=3D ring->fence_drv.num_fences_mask; i++) {
> -               ptr =3D &ring->fence_drv.fences[i];
> -               old =3D rcu_dereference_protected(*ptr, 1);
> -               if (old && old->ops =3D=3D &amdgpu_job_fence_ops) {
> -                       struct amdgpu_job *job;
> -
> -                       /* For non-scheduler bad job, i.e. failed ib test=
, we need to signal
> -                        * it right here or we won't be able to track the=
m in fence_drv
> -                        * and they will remain unsignaled during sa_bo f=
ree.
> -                        */
> -                       job =3D container_of(old, struct amdgpu_job, hw_f=
ence.base);
> -                       if (!job->base.s_fence && !dma_fence_is_signaled(=
old))
> -                               dma_fence_signal(old);
> -                       RCU_INIT_POINTER(*ptr, NULL);
> -                       dma_fence_put(old);
> -               }
> -       }
> -}
> -
>  /**
>   * amdgpu_fence_driver_set_error - set error code on fences
>   * @ring: the ring which contains the fences
> @@ -755,21 +699,19 @@ void amdgpu_fence_driver_force_completion(struct am=
dgpu_ring *ring)
>  /**
>   * amdgpu_fence_driver_guilty_force_completion - force signal of specifi=
ed sequence
>   *
> - * @fence: fence of the ring to signal
> + * @af: fence of the ring to signal
>   *
>   */
> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fe=
nce)
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af=
)
>  {
> -       dma_fence_set_error(&fence->base, -ETIME);
> -       amdgpu_fence_write(fence->ring, fence->seq);
> -       amdgpu_fence_process(fence->ring);
> +       dma_fence_set_error(&af->base, -ETIME);
> +       amdgpu_fence_write(af->ring, af->base.seqno);
> +       amdgpu_fence_process(af->ring);
>  }
>
> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>  {
> -       struct amdgpu_fence *am_fence =3D container_of(fence, struct amdg=
pu_fence, base);
> -
> -       am_fence->wptr =3D am_fence->ring->wptr;
> +       af->wptr =3D af->ring->wptr;
>  }
>
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *r=
ing,
> @@ -830,13 +772,6 @@ static const char *amdgpu_fence_get_timeline_name(st=
ruct dma_fence *f)
>         return (const char *)to_amdgpu_fence(f)->ring->name;
>  }
>
> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *=
f)
> -{
> -       struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_=
fence.base);
> -
> -       return (const char *)to_amdgpu_ring(job->base.sched)->name;
> -}
> -
>  /**
>   * amdgpu_fence_enable_signaling - enable signalling on fence
>   * @f: fence
> @@ -853,23 +788,6 @@ static bool amdgpu_fence_enable_signaling(struct dma=
_fence *f)
>         return true;
>  }
>
> -/**
> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_enable_signaling above=
, it
> - * only handles the job embedded fence.
> - */
> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
> -{
> -       struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_=
fence.base);
> -
> -       if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fa=
llback_timer))
> -               amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.s=
ched));
> -
> -       return true;
> -}
> -
>  /**
>   * amdgpu_fence_free - free up the fence memory
>   *
> @@ -885,21 +803,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>         kfree(to_amdgpu_fence(f));
>  }
>
> -/**
> - * amdgpu_job_fence_free - free up the job with embedded fence
> - *
> - * @rcu: RCU callback head
> - *
> - * Free up the job with embedded fence after the RCU grace period.
> - */
> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
> -{
> -       struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
> -
> -       /* free job if fence has a parent job */
> -       kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> -}
> -
>  /**
>   * amdgpu_fence_release - callback that fence can be freed
>   *
> @@ -913,19 +816,6 @@ static void amdgpu_fence_release(struct dma_fence *f=
)
>         call_rcu(&f->rcu, amdgpu_fence_free);
>  }
>
> -/**
> - * amdgpu_job_fence_release - callback that job embedded fence can be fr=
eed
> - *
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_release above, it
> - * only handles the job embedded fence.
> - */
> -static void amdgpu_job_fence_release(struct dma_fence *f)
> -{
> -       call_rcu(&f->rcu, amdgpu_job_fence_free);
> -}
> -
>  static const struct dma_fence_ops amdgpu_fence_ops =3D {
>         .get_driver_name =3D amdgpu_fence_get_driver_name,
>         .get_timeline_name =3D amdgpu_fence_get_timeline_name,
> @@ -933,13 +823,6 @@ static const struct dma_fence_ops amdgpu_fence_ops =
=3D {
>         .release =3D amdgpu_fence_release,
>  };
>
> -static const struct dma_fence_ops amdgpu_job_fence_ops =3D {
> -       .get_driver_name =3D amdgpu_fence_get_driver_name,
> -       .get_timeline_name =3D amdgpu_job_fence_get_timeline_name,
> -       .enable_signaling =3D amdgpu_job_fence_enable_signaling,
> -       .release =3D amdgpu_job_fence_release,
> -};
> -
>  /*
>   * Fence debugfs
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 7d9bcb72e8dd3..39229ece83f83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -149,17 +149,19 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
>         if (job) {
>                 vm =3D job->vm;
>                 fence_ctx =3D job->base.s_fence ?
> -                       job->base.s_fence->scheduled.context : 0;
> +                       job->base.s_fence->finished.context : 0;
>                 shadow_va =3D job->shadow_va;
>                 csa_va =3D job->csa_va;
>                 gds_va =3D job->gds_va;
>                 init_shadow =3D job->init_shadow;
> -               af =3D &job->hw_fence;
> +               af =3D job->hw_fence;
>                 /* Save the context of the job for reset handling.
>                  * The driver needs this so it can skip the ring
>                  * contents for guilty contexts.
>                  */
> -               af->context =3D job->base.s_fence ? job->base.s_fence->fi=
nished.context : 0;
> +               af->context =3D fence_ctx;
> +               /* the vm fence is also part of the job's context */
> +               job->hw_vm_fence->context =3D fence_ctx;
>         } else {
>                 vm =3D NULL;
>                 fence_ctx =3D 0;
> @@ -167,7 +169,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 csa_va =3D 0;
>                 gds_va =3D 0;
>                 init_shadow =3D false;
> -               af =3D NULL;
> +               af =3D kzalloc(sizeof(*af), GFP_ATOMIC);
> +               if (!af)
> +                       return -ENOMEM;
>         }
>
>         if (!ring->sched.ready) {
> @@ -289,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr)=
;
>         }
>
> -       r =3D amdgpu_fence_emit(ring, f, af, fence_flags);
> +       r =3D amdgpu_fence_emit(ring, af, fence_flags);
>         if (r) {
>                 dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>                 if (job && job->vmid)
> @@ -297,6 +301,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 amdgpu_ring_undo(ring);
>                 return r;
>         }
> +       *f =3D &af->base;
>
>         if (ring->funcs->insert_end)
>                 ring->funcs->insert_end(ring);
> @@ -317,7 +322,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>          * fence so we know what rings contents to backup
>          * after we reset the queue.
>          */
> -       amdgpu_fence_save_wptr(*f);
> +       amdgpu_fence_save_wptr(af);
>
>         amdgpu_ring_ib_end(ring);
>         amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 311e97c96c4e0..e86439867e2c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>                    ring->funcs->reset) {
>                 dev_err(adev->dev, "Starting %s ring reset\n",
>                         s_job->sched->name);
> -               r =3D amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> +               r =3D amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>                 if (!r) {
>                         atomic_inc(&ring->adev->gpu_reset_counter);
>                         dev_err(adev->dev, "Ring %s reset succeeded\n",
> @@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
>                      struct drm_sched_entity *entity, void *owner,
>                      unsigned int num_ibs, struct amdgpu_job **job)
>  {
> +       struct amdgpu_fence *af;
> +       int r;
> +
>         if (num_ibs =3D=3D 0)
>                 return -EINVAL;
>
> @@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>         if (!*job)
>                 return -ENOMEM;
>
> +       af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +       if (!af) {
> +               r =3D -ENOMEM;
> +               goto err_job;
> +       }
> +       (*job)->hw_fence =3D af;
> +
> +       af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +       if (!af) {
> +               r =3D -ENOMEM;
> +               goto err_fence;
> +       }
> +       (*job)->hw_vm_fence =3D af;
> +
>         (*job)->vm =3D vm;
>
>         amdgpu_sync_create(&(*job)->explicit_sync);
> @@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>                 return 0;
>
>         return drm_sched_job_init(&(*job)->base, entity, 1, owner);
> +
> +err_fence:
> +       kfree((*job)->hw_fence);
> +err_job:
> +       kfree(*job);
> +
> +       return r;
>  }
>
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
> @@ -248,11 +272,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *j=
ob)
>         struct dma_fence *f;
>         unsigned i;
>
> -       /* Check if any fences where initialized */
> +       /* Check if any fences were initialized */
>         if (job->base.s_fence && job->base.s_fence->finished.ops)
>                 f =3D &job->base.s_fence->finished;
> -       else if (job->hw_fence.base.ops)
> -               f =3D &job->hw_fence.base;
> +       else if (job->hw_fence && job->hw_fence->base.ops)
> +               f =3D &job->hw_fence->base;
>         else
>                 f =3D NULL;
>
> @@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job =
*s_job)
>
>         amdgpu_sync_free(&job->explicit_sync);
>
> -       /* only put the hw fence if has embedded fence */
> -       if (!job->hw_fence.base.ops)
> -               kfree(job);
> -       else
> -               dma_fence_put(&job->hw_fence.base);
> +       kfree(job);
>  }
>
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>         if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>                 dma_fence_put(job->gang_submit);
>
> -       if (!job->hw_fence.base.ops)
> -               kfree(job);
> -       else
> -               dma_fence_put(&job->hw_fence.base);
> +       kfree(job);
>  }
>
>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.h
> index 931fed8892cc1..077b2414a24b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,8 @@ struct amdgpu_job {
>         struct drm_sched_job    base;
>         struct amdgpu_vm        *vm;
>         struct amdgpu_sync      explicit_sync;
> -       struct amdgpu_fence     hw_fence;
> +       struct amdgpu_fence     *hw_fence;
> +       struct amdgpu_fence     *hw_vm_fence;
>         struct dma_fence        *gang_submit;
>         uint32_t                preamble_status;
>         uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e4..77ddddadc25fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -147,16 +147,14 @@ struct amdgpu_fence {
>         u64                             wptr;
>         /* fence context for resets */
>         u64                             context;
> -       uint32_t                        seq;
>  };
>
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fe=
nce);
> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device=
 *adev);
>  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -                     struct amdgpu_fence *af, unsigned int flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +                     unsigned int flags);
>  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>                               uint32_t timeout);
>  bool amdgpu_fence_process(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index bf42246a3db2f..9cf1744a4b319 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,
>         bool cleaner_shader_needed =3D false;
>         bool pasid_mapping_needed =3D false;
>         struct dma_fence *fence =3D NULL;
> -       struct amdgpu_fence *af;
>         unsigned int patch;
>         int r;
>
> @@ -835,12 +834,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
>         }
>
>         if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_nee=
ded) {
> -               r =3D amdgpu_fence_emit(ring, &fence, NULL, 0);
> +               r =3D amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>                 if (r)
>                         return r;
> -               /* this is part of the job's context */
> -               af =3D container_of(fence, struct amdgpu_fence, base);
> -               af->context =3D job->base.s_fence ? job->base.s_fence->fi=
nished.context : 0;
> +               fence =3D &job->hw_vm_fence->base;
>         }
>
>         if (vm_flush_needed) {
> --
> 2.51.0
>

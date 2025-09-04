Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC579CA1013
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 17:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF4910E038;
	Thu,  4 Sep 2025 17:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YLyYszy0";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF50F10EA9C
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 17:47:10 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-248f2da72edso2159885ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Sep 2025 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757008030; x=1757612830; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YN/I7IEEaBpSz2KtA3ZWXaDIjVGO3xpSpDJ2W95Txzg=;
 b=YLyYszy0NYd7quIpYqR2uQlV7t712Kn/8/G3CHUtgwDhLmVlQZrX4Z2yxIDrMbOCif
 Zv4IwL+DKd1yd5lF8pRaWzc3k83UvaOf3jeqK9qOflGAypJDEahOnP6wGKAoy+XFFIU3
 QWSenM7f4ECKWFfTNn+Y5KmJnltm84cIqzKe9VwSt4fIAJewH04aO6TOnns/SqnrPteh
 SErcWPk/mILBPtABfBQ2XYSPHbzhg5oGmXUHQP/NxeWUFCZD5QLFkY3tN/vxTqZbm16K
 34rp2Vfy7gR1RdFkFTfkLsZmv64+u7oJwJHRF1CAE8HG5owotXutitq9zPGhF7BHilxk
 cGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757008030; x=1757612830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YN/I7IEEaBpSz2KtA3ZWXaDIjVGO3xpSpDJ2W95Txzg=;
 b=j/m5nxuvoAwmHIQM7sm3mZr+12EyVKbBfHfeECgWFyQT3sQ4TIacERAjq8a532tvtY
 9H+N4uYr2CEHULRRc7ndJftuRBQW54FGoHoYWrKTDJw3uVtetlRfCgyMYd3WB3hDUM5V
 S9ED1bM2EFaEUeN74zglUDla7zwhIaOH+OlDS9RTTbHAzmsnWK9QTiRA26e6OYOM8Ki8
 r0tqh7D3u51XxKMuGK9umA2ySe8qneXlDqIKlenqza198SxtCLzsh9GoyE6TriwB+QzQ
 DIrywI1bbKE8eO6SuTJMpO2p0YuoyV3Fm5fT+8yLGXJGcthZotaB2eBGI7OYpi0aICI6
 Nqrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMTUVpOcKP/L+SBXOH/dz9SXHx1H2FwCF28L7ZexERVK9ZoN0t7yW6KM9sC8vNsDuGd5013fij@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbZ5/F96IrqIu2I9k+YiTxPlEGa4k6lWh6tuJYMfhebn/jjBOH
 adphBDueasq4yDygpBJMP/mIH70KQ77po4+H9htS1ErPXgE0+cX2kQWUy2iEb5NXLO05+6pxw4Y
 OWI3cBVzRdPXrxwRXqgUFK0uHCDbI1Cs=
X-Gm-Gg: ASbGncuC2wqfd9wlSN+aJhDxMX2OmkPJ5ak9VLuMt9o+0L4Zpty3y5a5vUEA+ZNYhtr
 12man0ulW2/TSPazlnTZteOk9/tuqeGG6GhU0xA4Hk3+gumf5rc1aT17Po7GntHnlJr4oFTuqay
 dwA2JAf7AtP31acaW8E05pyQmIuYZlFa3VFowbJ4loEtSGdH6Y4aKc3BCZsDldF3NiQ0Jn83hIU
 K2pvVs=
X-Google-Smtp-Source: AGHT+IFyILjNsoenSs0rMaviFhSNrqc+0aTupl9BevoOD3wgjl0XmCOR6TlTgW70pWIrqUVcmf/DF+u9ua48WivI87U=
X-Received: by 2002:a17:902:cf47:b0:24b:2310:9824 with SMTP id
 d9443c01a7336-24b23109e7fmr47073645ad.9.1757008029775; Thu, 04 Sep 2025
 10:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250904144546.59539-1-alexander.deucher@amd.com>
 <20250904144546.59539-2-alexander.deucher@amd.com>
 <4ec67fdc-af10-46fb-aca3-b5933b306f54@amd.com>
In-Reply-To: <4ec67fdc-af10-46fb-aca3-b5933b306f54@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 13:46:56 -0400
X-Gm-Features: Ac12FXwxcviQVafAjlKh08jYDWcikYzNIjBhTIAT_Bq0dF7DPd_NoiZrA0WWJSM
Message-ID: <CADnq5_NCJfv=+e29b=cCaPVdJOo_9WEXcqtZh7PGkwhtnkKUSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: clean up and unify hw fence handling
To: David Wu <davidwu2@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 David.Wu3@amd.com, christian.koenig@amd.com
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

On Thu, Sep 4, 2025 at 1:34=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> On 2025-09-04 10:45, Alex Deucher wrote:
>
> > Decouple the amdgpu fence from the amdgpu_job structure.
> > This lets us clean up the separate fence ops for the embedded
> > fence and other fences.  This also allows us to allocate the
> > vm fence up front when we allocate the job.
> >
> > v2: Additional cleanup suggested by Christian
> > v3: Additional cleanups suggested by Christian
> > v4: Additional cleanups suggested by David and
> >      vm fence fix
> >
> > Cc: David.Wu3@amd.com
> > Cc: christian.koenig@amd.com
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 143 ++-----------------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  17 ++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  43 ++++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   8 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
> >   8 files changed, 63 insertions(+), 167 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index 0e6e2e2acf5b5..7119cf658de8d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(st=
ruct amdgpu_ring *ring)
> >                       continue;
> >               }
> >               job =3D to_amdgpu_job(s_job);
> > -             if (preempted && (&job->hw_fence.base) =3D=3D fence)
> > +             if (preempted && (&job->hw_fence->base) =3D=3D fence)
> >                       /* mark the job as preempted */
> >                       job->preemption_status |=3D AMDGPU_IB_PREEMPTED;
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index b9e2f0293d617..79af75032d0e6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_d=
evice *adev,
> >               if (!amdgpu_ring_sched_ready(ring))
> >                       continue;
> >
> > -             /* Clear job fence from fence drv to avoid force_completi=
on
> > -              * leave NULL and vm flush fence in fence drv
> > -              */
> > -             amdgpu_fence_driver_clear_job_fences(ring);
> > -
> >               /* after all hw jobs are reset, hw fence is meaningless, =
so force_completion */
> >               amdgpu_fence_driver_force_completion(ring);
> >       }
> > @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devic=
e *adev,
> >        *
> >        * job->base holds a reference to parent fence
> >        */
> > -     if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> > +     if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
> >               job_signaled =3D true;
> >               dev_info(adev->dev, "Guilty job already signaled, skippin=
g HW reset");
> >               goto skip_hw_reset;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_fence.c
> > index 1a2710f453551..85cefbe40aef8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -45,16 +45,11 @@
> >    * Cast helper
> >    */
> >   static const struct dma_fence_ops amdgpu_fence_ops;
> > -static const struct dma_fence_ops amdgpu_job_fence_ops;
> >   static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *=
f)
> >   {
> >       struct amdgpu_fence *__f =3D container_of(f, struct amdgpu_fence,=
 base);
> >
> > -     if (__f->base.ops =3D=3D &amdgpu_fence_ops ||
> > -         __f->base.ops =3D=3D &amdgpu_job_fence_ops)
> > -             return __f;
> > -
> > -     return NULL;
> > +     return __f;
> >   }
> >
> >   /**
> > @@ -98,51 +93,32 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ri=
ng)
> >    * amdgpu_fence_emit - emit a fence on the requested ring
> >    *
> >    * @ring: ring the fence is associated with
> > - * @f: resulting fence object
> >    * @af: amdgpu fence input
> >    * @flags: flags to pass into the subordinate .emit_fence() call
> >    *
> >    * Emits a fence command on the requested ring (all asics).
> >    * Returns 0 on success, -ENOMEM on failure.
> >    */
> > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> > -                   struct amdgpu_fence *af, unsigned int flags)
> > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *a=
f,
> > +                   unsigned int flags)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct dma_fence *fence;
> > -     struct amdgpu_fence *am_fence;
> >       struct dma_fence __rcu **ptr;
> >       uint32_t seq;
> >       int r;
> >
> > -     if (!af) {
> > -             /* create a separate hw fence */
> > -             am_fence =3D kzalloc(sizeof(*am_fence), GFP_KERNEL);
> > -             if (!am_fence)
> > -                     return -ENOMEM;
> > -     } else {
> > -             am_fence =3D af;
> > -     }
> > -     fence =3D &am_fence->base;
> > -     am_fence->ring =3D ring;
> > +     fence =3D &af->base;
> > +     af->ring =3D ring;
> >
> >       seq =3D ++ring->fence_drv.sync_seq;
> > -     am_fence->seq =3D seq;
> > -     if (af) {
> > -             dma_fence_init(fence, &amdgpu_job_fence_ops,
> > -                            &ring->fence_drv.lock,
> > -                            adev->fence_context + ring->idx, seq);
> > -             /* Against remove in amdgpu_job_{free, free_cb} */
> > -             dma_fence_get(fence);
> > -     } else {
> > -             dma_fence_init(fence, &amdgpu_fence_ops,
> > -                            &ring->fence_drv.lock,
> > -                            adev->fence_context + ring->idx, seq);
> > -     }
> > +     dma_fence_init(fence, &amdgpu_fence_ops,
> > +                    &ring->fence_drv.lock,
> > +                    adev->fence_context + ring->idx, seq);
> >
> >       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> >                              seq, flags | AMDGPU_FENCE_FLAG_INT);
> > -     amdgpu_fence_save_wptr(fence);
> > +     amdgpu_fence_save_wptr(af);
> >       pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> >       ptr =3D &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_=
mask];
> >       if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> > @@ -167,8 +143,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, str=
uct dma_fence **f,
> >        */
> >       rcu_assign_pointer(*ptr, dma_fence_get(fence));
> >
> > -     *f =3D fence;
> > -
> >       return 0;
> >   }
> >
> > @@ -669,36 +643,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_dev=
ice *adev)
> >       }
> >   }
> >
> > -/**
> > - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of=
 ring
> > - *
> > - * @ring: fence of the ring to be cleared
> > - *
> > - */
> > -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
> > -{
> > -     int i;
> > -     struct dma_fence *old, **ptr;
> > -
> > -     for (i =3D 0; i <=3D ring->fence_drv.num_fences_mask; i++) {
> > -             ptr =3D &ring->fence_drv.fences[i];
> > -             old =3D rcu_dereference_protected(*ptr, 1);
> > -             if (old && old->ops =3D=3D &amdgpu_job_fence_ops) {
> > -                     struct amdgpu_job *job;
> > -
> > -                     /* For non-scheduler bad job, i.e. failed ib test=
, we need to signal
> > -                      * it right here or we won't be able to track the=
m in fence_drv
> > -                      * and they will remain unsignaled during sa_bo f=
ree.
> > -                      */
> > -                     job =3D container_of(old, struct amdgpu_job, hw_f=
ence.base);
> > -                     if (!job->base.s_fence && !dma_fence_is_signaled(=
old))
> > -                             dma_fence_signal(old);
> > -                     RCU_INIT_POINTER(*ptr, NULL);
> > -                     dma_fence_put(old);
> > -             }
> > -     }
> > -}
> > -
> >   /**
> >    * amdgpu_fence_driver_set_error - set error code on fences
> >    * @ring: the ring which contains the fences
> > @@ -755,7 +699,7 @@ void amdgpu_fence_driver_force_completion(struct am=
dgpu_ring *ring)
> >   /**
> >    * amdgpu_fence_driver_guilty_force_completion - force signal of spec=
ified sequence
> >    *
> > - * @fence: fence of the ring to signal
> > + * @af: fence of the ring to signal
> >    *
> >    */
> >   void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence =
*af)
> > @@ -781,15 +725,13 @@ void amdgpu_fence_driver_guilty_force_completion(=
struct amdgpu_fence *af)
> >               }
> >               rcu_read_unlock();
> >       }
> > -     amdgpu_fence_write(ring, af->seq);
> > +     amdgpu_fence_write(ring, af->base.seqno);
>
> af->base.seqno is a type of u64 - but the amdgpu_fence_write takes a u32 =
argument. Should we
> cast it? (assume seqno never overflows a u32)

The seq number will always be 32 bits.  dma_fences have a 64 bit
sequence number but we use a 32 bit one for the hw fences.  See
amdgpu_fence_emit().  We pass the hw sequence number to
dma_fence_init().  No need to cast it.

Alex

>
> David
>         amdgpu_fence_process(ring);
>   }
>
> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>   {
> -       struct amdgpu_fence *am_fence =3D container_of(fence, struct amdg=
pu_fence, base);
> -
> -       am_fence->wptr =3D am_fence->ring->wptr;
> +       af->wptr =3D af->ring->wptr;
>   }
>
>   static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *=
ring,
> @@ -850,13 +792,6 @@ static const char *amdgpu_fence_get_timeline_name(st=
ruct dma_fence *f)
>         return (const char *)to_amdgpu_fence(f)->ring->name;
>   }
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
>   /**
>    * amdgpu_fence_enable_signaling - enable signalling on fence
>    * @f: fence
> @@ -873,23 +808,6 @@ static bool amdgpu_fence_enable_signaling(struct dma=
_fence *f)
>         return true;
>   }
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
>   /**
>    * amdgpu_fence_free - free up the fence memory
>    *
> @@ -905,21 +823,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>         kfree(to_amdgpu_fence(f));
>   }
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
>   /**
>    * amdgpu_fence_release - callback that fence can be freed
>    *
> @@ -933,19 +836,6 @@ static void amdgpu_fence_release(struct dma_fence *f=
)
>         call_rcu(&f->rcu, amdgpu_fence_free);
>   }
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
>   static const struct dma_fence_ops amdgpu_fence_ops =3D {
>         .get_driver_name =3D amdgpu_fence_get_driver_name,
>         .get_timeline_name =3D amdgpu_fence_get_timeline_name,
> @@ -953,13 +843,6 @@ static const struct dma_fence_ops amdgpu_fence_ops =
=3D {
>         .release =3D amdgpu_fence_release,
>   };
>
> -static const struct dma_fence_ops amdgpu_job_fence_ops =3D {
> -       .get_driver_name =3D amdgpu_fence_get_driver_name,
> -       .get_timeline_name =3D amdgpu_job_fence_get_timeline_name,
> -       .enable_signaling =3D amdgpu_job_fence_enable_signaling,
> -       .release =3D amdgpu_job_fence_release,
> -};
> -
>   /*
>    * Fence debugfs
>    */
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
> index 172620880cada..55c7e104d5ca0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -137,7 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>                    ring->funcs->reset) {
>                 dev_err(adev->dev, "Starting %s ring reset\n",
>                         s_job->sched->name);
> -               r =3D amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> +               r =3D amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>                 if (!r) {
>                         atomic_inc(&ring->adev->gpu_reset_counter);
>                         dev_err(adev->dev, "Ring %s reset succeeded\n",
> @@ -187,6 +187,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
>                      unsigned int num_ibs, struct amdgpu_job **job,
>                      u64 drm_client_id)
>   {
> +       struct amdgpu_fence *af;
> +       int r;
> +
>         if (num_ibs =3D=3D 0)
>                 return -EINVAL;
>
> @@ -194,6 +197,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
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
> @@ -205,6 +222,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>
>         return drm_sched_job_init(&(*job)->base, entity, 1, owner,
>                                   drm_client_id);
> +
> +err_fence:
> +       kfree((*job)->hw_fence);
> +err_job:
> +       kfree(*job);
> +
> +       return r;
>   }
>
>   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
> @@ -251,11 +275,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *j=
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
> @@ -271,11 +295,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job =
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
>   }
>
>   void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -304,10 +324,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>         if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>                 dma_fence_put(job->gang_submit);
>
> -       if (!job->hw_fence.base.ops)
> -               kfree(job);
> -       else
> -               dma_fence_put(&job->hw_fence.base);
> +       kfree(job);
>   }
>
>   struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.h
> index 2f302266662bc..d25f1fcf0242e 100644
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
> index 0704fd9b85fdb..5d44f1354c8d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -147,16 +147,14 @@ struct amdgpu_fence {
>         u64                             wptr;
>         /* fence context for resets */
>         u64                             context;
> -       uint32_t                        seq;
>   };
>
>   extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>   void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)=
;
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>   void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *a=
f);
> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>
>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -166,8 +164,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device=
 *adev);
>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -                     struct amdgpu_fence *af, unsigned int flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +                     unsigned int flags);
>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>                               uint32_t timeout);
>   bool amdgpu_fence_process(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index bd12d8ff15a42..76bae546df11c 100644
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
>

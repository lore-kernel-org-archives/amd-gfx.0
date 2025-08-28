Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A16DCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 20:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825C710EAC0;
	Thu, 28 Aug 2025 20:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TTckw+ms";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F37210EAC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 20:27:10 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-32557063cd5so104713a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756412830; x=1757017630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xym8UlMbqivrILujw3XuYR7zoSx4OQQeHhYK97+hAKA=;
 b=TTckw+ms6IjgEt7GWA8TyBvSD8jvDyGAzWdc/QjhOngNCKc5MJmZHXuNu7RQ4mpyLN
 OGrX3QfKo0CEMRy8342Mly0toyrg/A2o+0K7dsL9drKmYk5+ncwK6cpOKCWrZmFvyBQ8
 aHOawohaA1w4KzpBcwsA9S/YXhYbEk1Ib8cI5migNPzsN06n6S7ucFY+RBZBNCCV2Url
 eq/QnC8F3ovZvcPg1CcdrksSNT1qfa42wy6l1eCki1TfDhjq4s7JKeI4SXQRc82ee6Cm
 OIiLTadIE4Nt6EbQrEdUKbZUATxjOxccHrOtcBIHbZOE5tkSeUVSD1KPc/N7UQeBIwOI
 IjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756412830; x=1757017630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xym8UlMbqivrILujw3XuYR7zoSx4OQQeHhYK97+hAKA=;
 b=DqOZuJD81UILkUZKQxyj9SS139AoJYFQrGRclerV9icwOpUirmADop+IG+JBI5zvBc
 zlSghlnbJxrTgoXa4KgZomjziS0RI/9WSqB4LIG/sv7VOo6vNRnTqyy3ifkRtSeYEw1Z
 D/X1VGN7DL46cv+JcBIJ3JcMID+Ze189zxqIA8EGbcpGGFHDwYW0NTiyA1dmwgZn87BN
 7Avnh1kISfWoHKCXYXifuvllTziv0YMLp+LfR5Tx87d5p9+r5APsbFOEL7+v39cOMvxr
 f5vpKHMLnJ/01+AntufmcQPFoq2oMPQ3e7yCn0urbZD2bgH0Q8ot4tfk2JDYpgZDgoXQ
 eYwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRU6YCdXcRidPV+o1Ti6aZIqFvKF9ZCZPpTdrlrwHTnlW4oKMyC2W8QEh6ow1Y1B1e1s1y1Mq0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1sXOOA6N/JQNr1al3LCtg0MQJ6hkVHethTrvpAgpAr6SDOZkg
 wlwXfOgcepiLxCl1BqHPrf7/GVho0VKKm0NVkMe1Zt11vSM44A555Gfzb43ct3v7+j/Iow1TCH4
 J+mOZJMhZbTJe+SlQ9xEjhavHHgI9AMqvjTIS
X-Gm-Gg: ASbGnctXT5GsF5sbxz1hiejkbsxp80O1Sp1DVseBqInLL3u+A1mYGayP/z1bcQHid+f
 2mjY4XAPWmZpSv0tYS8CXFXmvJvdVboNbOJ6sMhHn7exVcBqOaU1HVO656GauObkGYFYepA+qpI
 dqddB25Ruux7dB4HsG5A7HmUhlnjlitJrSJk5Unp6gC6bZKN8tykQg0bXfiLq7bdSubh229xOXy
 09sMR4=
X-Google-Smtp-Source: AGHT+IEJbYa6gocweqkvyWAg+5xmRFuYrwEKjmXikr0z9ug+JpEEHEzXSXvVRmgE7xNKkFxcDfRzad6VkTq3KFLLkT8=
X-Received: by 2002:a17:90b:270c:b0:327:bc1b:ffdf with SMTP id
 98e67ed59e1d1-327bc1c00dcmr2177193a91.8.1756412829362; Thu, 28 Aug 2025
 13:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250828140548.5792-1-alexander.deucher@amd.com>
 <c3386a43-a7fa-4ebe-bb37-3145cad47a52@amd.com>
In-Reply-To: <c3386a43-a7fa-4ebe-bb37-3145cad47a52@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 16:26:56 -0400
X-Gm-Features: Ac12FXxI7y8oEkYlolZAIKdRhTf0HGi7-zL3jKqKeUkd25ChDMZ9XTrcCufV8UM
Message-ID: <CADnq5_O9QBP5Qye+3AUwLHJYwnf4gTzw1y_VQzFPVa+1Krdidg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up and unify hw fence handling
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

On Thu, Aug 28, 2025 at 1:38=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> On 2025-08-28 10:05, Alex Deucher wrote:
>
> Decouple the amdgpu fence from the amdgpu_job structure.
> This lets us clean up the separate fence ops for the embedded
> fence and other fences.  This also allows us to allocate the
> vm fence up front when we allocate the job.
>
> Cc: David.Wu3@amd.com
> Cc: christian.koenig@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>
> v2: Additional cleanup suggested by Christian
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 140 ++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  22 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  41 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>  8 files changed, 64 insertions(+), 165 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index f81608330a3d0..7ea3cb6491b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(stru=
ct amdgpu_ring *ring)
>   continue;
>   }
>   job =3D to_amdgpu_job(s_job);
> - if (preempted && (&job->hw_fence.base) =3D=3D fence)
> + if (preempted && (&job->hw_fence->base) =3D=3D fence)
>   /* mark the job as preempted */
>   job->preemption_status |=3D AMDGPU_IB_PREEMPTED;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7783272a79302..add272fa31288 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_dev=
ice *adev,
>   if (!amdgpu_ring_sched_ready(ring))
>   continue;
>
> - /* Clear job fence from fence drv to avoid force_completion
> - * leave NULL and vm flush fence in fence drv
> - */
> - amdgpu_fence_driver_clear_job_fences(ring);
> -
>   /* after all hw jobs are reset, hw fence is meaningless, so force_compl=
etion */
>   amdgpu_fence_driver_force_completion(ring);
>   }
> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>   *
>   * job->base holds a reference to parent fence
>   */
> - if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> + if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>   job_signaled =3D true;
>   dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>   goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 2d58aefbd68a7..1355fee0e978d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -45,16 +45,11 @@
>   * Cast helper
>   */
>  static const struct dma_fence_ops amdgpu_fence_ops;
> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>  static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>  {
>   struct amdgpu_fence *__f =3D container_of(f, struct amdgpu_fence, base)=
;
>
> - if (__f->base.ops =3D=3D &amdgpu_fence_ops ||
> -    __f->base.ops =3D=3D &amdgpu_job_fence_ops)
> - return __f;
> -
> - return NULL;
> + return __f;
>  }
>
>  /**
> @@ -98,51 +93,33 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring=
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
> -      struct amdgpu_fence *af, unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +      unsigned int flags)
>  {
>   struct amdgpu_device *adev =3D ring->adev;
>   struct dma_fence *fence;
> - struct amdgpu_fence *am_fence;
>   struct dma_fence __rcu **ptr;
>   uint32_t seq;
>   int r;
>
> - if (!af) {
> - /* create a separate hw fence */
> - am_fence =3D kzalloc(sizeof(*am_fence), GFP_KERNEL);
> - if (!am_fence)
> - return -ENOMEM;
> - } else {
> - am_fence =3D af;
> - }
> - fence =3D &am_fence->base;
> - am_fence->ring =3D ring;
> + fence =3D &af->base;
> + af->ring =3D ring;
>
>   seq =3D ++ring->fence_drv.sync_seq;
> - am_fence->seq =3D seq;
> - if (af) {
> - dma_fence_init(fence, &amdgpu_job_fence_ops,
> -       &ring->fence_drv.lock,
> -       adev->fence_context + ring->idx, seq);
> - /* Against remove in amdgpu_job_{free, free_cb} */
> - dma_fence_get(fence);
> - } else {
> - dma_fence_init(fence, &amdgpu_fence_ops,
> -       &ring->fence_drv.lock,
> -       adev->fence_context + ring->idx, seq);
> - }
> + af->seq =3D seq;
> + dma_fence_init(fence, &amdgpu_fence_ops,
> +       &ring->fence_drv.lock,
> +       adev->fence_context + ring->idx, seq);
>
>
> seems we are missing a dma_fence_get(fence) somewhere as I got the follow=
ing error
>
> [    8.317720] ------------[ cut here ]------------
> [    8.317723] refcount_t: underflow; use-after-free.
> [    8.317734] WARNING: CPU: 18 PID: 752 at lib/refcount.c:28 refcount_wa=
rn_saturate+0xf7/0x150
> [    8.317743] Modules linked in: amdgpu(E) amdxcp drm_ttm_helper ttm drm=
_exec gpu_sched drm_suballoc_helper video drm_panel_backlight_quirks cec rc=
_core drm_buddy drm_display_helper drm_client_lib drm_kms_helper nvme drm i=
gb ahci nvme_core dca i2c_algo_bit libahci wmi hid_generic usbhid hid
> [    8.317786] CPU: 18 UID: 0 PID: 752 Comm: kworker/u256:2 Tainted: G   =
         E      6.14.0+ #61
> [    8.317790] Tainted: [E]=3DUNSIGNED_MODULE
> [    8.317792] Hardware name: Gigabyte Technology Co., Ltd. X399 DESIGNAR=
E EX/X399 DESIGNARE EX-CF, BIOS F11 10/04/2018
> [    8.317795] Workqueue: sdma1 drm_sched_run_job_work [gpu_sched]
> [    8.317804] RIP: 0010:refcount_warn_saturate+0xf7/0x150
> [    8.317808] Code: eb 9e 0f b6 1d 92 c1 ba 01 80 fb 01 0f 87 32 6e 7c f=
f 83 e3 01 75 89 48 c7 c7 f0 c7 1e a2 c6 05 76 c1 ba 01 01 e8 69 93 8f ff <=
0f> 0b e9 6f ff ff ff 0f b6 1d 64 c1 ba 01 80 fb 01 0f 87 ef 6d 7c
> ...

For posterity, the problem is here:
-       else if (job->hw_fence.base.ops)
-               f =3D &job->hw_fence.base;
+       else if (job->hw_fence)
+               f =3D &job->hw_fence->base;

We need to check if the fence is initialized (ops is present), not
just whether the fence is allocated.

Alex

>
>   amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>         seq, flags | AMDGPU_FENCE_FLAG_INT);
> - amdgpu_fence_save_wptr(fence);
> + amdgpu_fence_save_wptr(af);
>   pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>   ptr =3D &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>   if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -167,8 +144,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struc=
t dma_fence **f,
>   */
>   rcu_assign_pointer(*ptr, dma_fence_get(fence));
>
> - *f =3D fence;
> -
>   return 0;
>  }
>
> @@ -669,36 +644,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_devic=
e *adev)
>   }
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
> - int i;
> - struct dma_fence *old, **ptr;
> -
> - for (i =3D 0; i <=3D ring->fence_drv.num_fences_mask; i++) {
> - ptr =3D &ring->fence_drv.fences[i];
> - old =3D rcu_dereference_protected(*ptr, 1);
> - if (old && old->ops =3D=3D &amdgpu_job_fence_ops) {
> - struct amdgpu_job *job;
> -
> - /* For non-scheduler bad job, i.e. failed ib test, we need to signal
> - * it right here or we won't be able to track them in fence_drv
> - * and they will remain unsignaled during sa_bo free.
> - */
> - job =3D container_of(old, struct amdgpu_job, hw_fence.base);
> - if (!job->base.s_fence && !dma_fence_is_signaled(old))
> - dma_fence_signal(old);
> - RCU_INIT_POINTER(*ptr, NULL);
> - dma_fence_put(old);
> - }
> - }
> -}
> -
>  /**
>   * amdgpu_fence_driver_set_error - set error code on fences
>   * @ring: the ring which contains the fences
> @@ -765,11 +710,9 @@ void amdgpu_fence_driver_guilty_force_completion(str=
uct amdgpu_fence *fence)
>   amdgpu_fence_process(fence->ring);
>  }
>
> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>  {
> - struct amdgpu_fence *am_fence =3D container_of(fence, struct amdgpu_fen=
ce, base);
> -
> - am_fence->wptr =3D am_fence->ring->wptr;
> + af->wptr =3D af->ring->wptr;
>  }
>
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *r=
ing,
> @@ -830,13 +773,6 @@ static const char *amdgpu_fence_get_timeline_name(st=
ruct dma_fence *f)
>   return (const char *)to_amdgpu_fence(f)->ring->name;
>  }
>
> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *=
f)
> -{
> - struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_fence.=
base);
> -
> - return (const char *)to_amdgpu_ring(job->base.sched)->name;
> -}
> -
>  /**
>   * amdgpu_fence_enable_signaling - enable signalling on fence
>   * @f: fence
> @@ -853,23 +789,6 @@ static bool amdgpu_fence_enable_signaling(struct dma=
_fence *f)
>   return true;
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
> - struct amdgpu_job *job =3D container_of(f, struct amdgpu_job, hw_fence.=
base);
> -
> - if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback=
_timer))
> - amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> -
> - return true;
> -}
> -
>  /**
>   * amdgpu_fence_free - free up the fence memory
>   *
> @@ -885,21 +804,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>   kfree(to_amdgpu_fence(f));
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
> - struct dma_fence *f =3D container_of(rcu, struct dma_fence, rcu);
> -
> - /* free job if fence has a parent job */
> - kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> -}
> -
>  /**
>   * amdgpu_fence_release - callback that fence can be freed
>   *
> @@ -913,19 +817,6 @@ static void amdgpu_fence_release(struct dma_fence *f=
)
>   call_rcu(&f->rcu, amdgpu_fence_free);
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
> - call_rcu(&f->rcu, amdgpu_job_fence_free);
> -}
> -
>  static const struct dma_fence_ops amdgpu_fence_ops =3D {
>   .get_driver_name =3D amdgpu_fence_get_driver_name,
>   .get_timeline_name =3D amdgpu_fence_get_timeline_name,
> @@ -933,13 +824,6 @@ static const struct dma_fence_ops amdgpu_fence_ops =
=3D {
>   .release =3D amdgpu_fence_release,
>  };
>
> -static const struct dma_fence_ops amdgpu_job_fence_ops =3D {
> - .get_driver_name =3D amdgpu_fence_get_driver_name,
> - .get_timeline_name =3D amdgpu_job_fence_get_timeline_name,
> - .enable_signaling =3D amdgpu_job_fence_enable_signaling,
> - .release =3D amdgpu_job_fence_release,
> -};
> -
>  /*
>   * Fence debugfs
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 7d9bcb72e8dd3..71215aeb1b6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>   struct amdgpu_device *adev =3D ring->adev;
>   struct amdgpu_ib *ib =3D &ibs[0];
>   struct dma_fence *tmp =3D NULL;
> - struct amdgpu_fence *af;
> + struct amdgpu_fence *af, *vm_af;
>   bool need_ctx_switch;
>   struct amdgpu_vm *vm;
>   uint64_t fence_ctx;
> @@ -148,18 +148,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
>   /* ring tests don't use a job */
>   if (job) {
>   vm =3D job->vm;
> - fence_ctx =3D job->base.s_fence ?
> - job->base.s_fence->scheduled.context : 0;
> + fence_ctx =3D job->base.s_fence ? job->base.s_fence->finished.context :=
 0;
>   shadow_va =3D job->shadow_va;
>   csa_va =3D job->csa_va;
>   gds_va =3D job->gds_va;
>   init_shadow =3D job->init_shadow;
> - af =3D &job->hw_fence;
> + af =3D job->hw_fence;
>   /* Save the context of the job for reset handling.
>   * The driver needs this so it can skip the ring
>   * contents for guilty contexts.
>   */
> - af->context =3D job->base.s_fence ? job->base.s_fence->finished.context=
 : 0;
> + af->context =3D fence_ctx;
> + vm_af =3D job->hw_vm_fence;
> + /* the vm fence is also part of the job's context */
> + vm_af->context =3D fence_ctx;
>
> I think vm_af is not needed - above code can be
>
> job->hw_vm_fence->context =3D fence_ctx;
>
>   } else {
>   vm =3D NULL;
>   fence_ctx =3D 0;
> @@ -167,7 +169,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned int num_ibs,
>   csa_va =3D 0;
>   gds_va =3D 0;
>   init_shadow =3D false;
> - af =3D NULL;
> + af =3D kzalloc(sizeof(*af), GFP_NOWAIT);
> + if (!af)
> + return -ENOMEM;
> + vm_af =3D NULL;
>
> vm_af can be removed.
>
>   }
>
>   if (!ring->sched.ready) {
> @@ -289,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>   amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>   }
>
> - r =3D amdgpu_fence_emit(ring, f, af, fence_flags);
> + r =3D amdgpu_fence_emit(ring, af, fence_flags);
>   if (r) {
>   dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>   if (job && job->vmid)
> @@ -297,6 +302,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>   amdgpu_ring_undo(ring);
>   return r;
>   }
> + *f =3D &af->base;
>
>   if (ring->funcs->insert_end)
>   ring->funcs->insert_end(ring);
> @@ -317,7 +323,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>   * fence so we know what rings contents to backup
>   * after we reset the queue.
>   */
> - amdgpu_fence_save_wptr(*f);
> + amdgpu_fence_save_wptr(af);
>
>   amdgpu_ring_ib_end(ring);
>   amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 311e97c96c4e0..9a78fe01efa3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>     ring->funcs->reset) {
>   dev_err(adev->dev, "Starting %s ring reset\n",
>   s_job->sched->name);
> - r =3D amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> + r =3D amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>   if (!r) {
>   atomic_inc(&ring->adev->gpu_reset_counter);
>   dev_err(adev->dev, "Ring %s reset succeeded\n",
> @@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
>       struct drm_sched_entity *entity, void *owner,
>       unsigned int num_ibs, struct amdgpu_job **job)
>  {
> + struct amdgpu_fence *af;
> + int r;
> +
>   if (num_ibs =3D=3D 0)
>   return -EINVAL;
>
> @@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>   if (!*job)
>   return -ENOMEM;
>
> + af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> + if (!af) {
> + r =3D -ENOMEM;
> + goto err_job;
> + }
> + (*job)->hw_fence =3D af;
> +
> + af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> + if (!af) {
> + r =3D -ENOMEM;
> + goto err_fence;
> + }
> + (*job)->hw_vm_fence =3D af;
> +
>   (*job)->vm =3D vm;
>
>   amdgpu_sync_create(&(*job)->explicit_sync);
> @@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
>   return 0;
>
>   return drm_sched_job_init(&(*job)->base, entity, 1, owner);
> +
> +err_fence:
> + kfree((*job)->hw_fence);
> +err_job:
> + kfree(*job);
> +
> + return r;
>  }
>
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
> @@ -251,8 +275,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job=
)
>   /* Check if any fences where initialized */
>   if (job->base.s_fence && job->base.s_fence->finished.ops)
>   f =3D &job->base.s_fence->finished;
> - else if (job->hw_fence.base.ops)
> - f =3D &job->hw_fence.base;
> + else if (job->hw_fence)
> + f =3D &job->hw_fence->base;
>   else
>   f =3D NULL;
>
> @@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job =
*s_job)
>
>   amdgpu_sync_free(&job->explicit_sync);
>
> - /* only put the hw fence if has embedded fence */
> - if (!job->hw_fence.base.ops)
> - kfree(job);
> - else
> - dma_fence_put(&job->hw_fence.base);
> + kfree(job);
>  }
>
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>   dma_fence_put(job->gang_submit);
>
> - if (!job->hw_fence.base.ops)
> - kfree(job);
> - else
> - dma_fence_put(&job->hw_fence.base);
> + kfree(job);
>  }
>
>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.h
> index 931fed8892cc1..077b2414a24b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,8 @@ struct amdgpu_job {
>   struct drm_sched_job    base;
>   struct amdgpu_vm *vm;
>   struct amdgpu_sync explicit_sync;
> - struct amdgpu_fence hw_fence;
> + struct amdgpu_fence *hw_fence;
> + struct amdgpu_fence *hw_vm_fence;
>   struct dma_fence *gang_submit;
>   uint32_t preamble_status;
>   uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e4..901f8bd375212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -152,11 +152,10 @@ struct amdgpu_fence {
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
> @@ -166,8 +165,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device=
 *adev);
>  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -      struct amdgpu_fence *af, unsigned int flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +      unsigned int flags);
>  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>        uint32_t timeout);
>  bool amdgpu_fence_process(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index bf42246a3db2f..7d1a363ad6878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,
>   bool cleaner_shader_needed =3D false;
>   bool pasid_mapping_needed =3D false;
>   struct dma_fence *fence =3D NULL;
> - struct amdgpu_fence *af;
>   unsigned int patch;
>   int r;
>
> @@ -835,13 +834,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
>   }
>
>   if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
> - r =3D amdgpu_fence_emit(ring, &fence, NULL, 0);
> + r =3D amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>   if (r)
>   return r;
> - /* this is part of the job's context */
> - af =3D container_of(fence, struct amdgpu_fence, base);
> - af->context =3D job->base.s_fence ? job->base.s_fence->finished.context=
 : 0;
>   }
> + fence =3D &job->hw_vm_fence->base;
>
>   if (vm_flush_needed) {
>   mutex_lock(&id_mgr->lock);

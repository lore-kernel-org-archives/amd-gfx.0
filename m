Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A67CCA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 14:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A0D10EC4A;
	Fri, 12 Sep 2025 14:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ewRi/0IM";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2964C10EC4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 14:08:52 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-24aacdf40a2so3690255ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757686132; x=1758290932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O44G1EvaFYlmm0l0qMVXdP4X4HbACtCMcF4XUaO5dFM=;
 b=ewRi/0IM3Y6HclIJMMhNaR3fhtiVH7ckgi+9l7jdQGVf35HE4pJNU6DOHzMIicHMzo
 GrVhCj9hWQdPdWbwAGI3oTs4hcxid2MCkhC+TILCTTb2WbbJYBBLyRE1i5iBQ0VqhQUJ
 Rom7Xxj/SurFf76UxJz79VJa7mO1Oqfq+9GFArBCs2iYdKXFxR130OX0WuSXwoH6L55f
 h3Y1aTeZI2JVa4nsiauTlPPBC2Tby7M8FKkaSFMqeSoShP4F/d6ZjXIMOT8N0sC4dFMy
 mVZbSU6e9aOSczCqBJFcc79KxhAeAwvD9xgmgLcnp2r74MSuO9NJNbLxveEVTs1StmLh
 13Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757686132; x=1758290932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O44G1EvaFYlmm0l0qMVXdP4X4HbACtCMcF4XUaO5dFM=;
 b=uLrdg7sojosw+ytma4XbzGylZay5pSN3kGRNE7cE26GfEvBmlyAc6RMOT0Vt0YB8ok
 yPCYijMM0Elxum1Xkw8OO69uQ8M+B2Lu9OxvwwtFra4o/twU2Ze/XgkPh2FnRKHBhSDf
 EMPjJaxszgExjuHRXZoyxw3xnvVtdpWf4uFLt2XyFwUEOM8qsRjB0CiA4I2OvXItceXB
 K5LyOpHmiKzm6tR2h3f3zG6uTMDDhB3xveuX3isNDIQxT0KNeyfR1LSsDTtYiQS4TcYX
 9rVbuHZGJWVTe1MAqs9TuLDPQtWhewrIFTv+n5MXsEMDZSsqauzAp62MOCJFZSDRKLDS
 Ehaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8zfFJy0VmkQVT/PxvnUvBHXNXElM1uWJDyNjAfrRLQATmf6pyTKJbm+jVsgsjaFZG6NNB08k0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVrEP9ZsFb91A5WAnTIJBq21b5JTMiuqoMOgzIZyyPQfLNBr2o
 2v2QzAoE10MbcRHIwqZh8NQk2WPkBnrdU/2OcvLiytsL1uoQMQN95xXLYnXnCOF0aHkCqdY+nDP
 m1v9xZj2kSjmEEoQItEJ0BZsfbWNO9Tc=
X-Gm-Gg: ASbGncsyOhHdv/rORHewd7hwRNludVM2M1VT+jpdVVq6h0nzWTdjR0KqwqLAFOQhYNa
 lVfYApr7GPpu8WAkf92KJi5X/xsyRRqcQYnsFWDH3AMqj300wtQK/0vKgrtcL55LOYL/GoEnN/g
 pxQ6rBhgxXvEiS7vkfNHBF0oksVuFm4d4rSbcM1wqrCVEEsN+nU96MhLw///2X5Xd2kDD2p8i+/
 FlS8bE=
X-Google-Smtp-Source: AGHT+IHi2tsnTnEyiG5k6WNK60QEXly/EiBJqQMf3WgtAPD8bcD1ovZe700PCCKyWXQvhFgRPgN2lbnhzem10s285Kk=
X-Received: by 2002:a17:903:1a8b:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-25d25e85badmr18843315ad.4.1757686131330; Fri, 12 Sep 2025
 07:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250912093202.4905-1-Jesse.Zhang@amd.com>
 <5a04607d-0d50-4543-8498-52122045048d@amd.com>
 <CADnq5_MoPA7hMc1ffM992pxzU=UeAMaTC2AZBzpC+4Y8uP37gw@mail.gmail.com>
 <45c496ec-d8c7-43c4-b1e4-33453e285bb2@amd.com>
In-Reply-To: <45c496ec-d8c7-43c4-b1e4-33453e285bb2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Sep 2025 10:08:39 -0400
X-Gm-Features: Ac12FXyUsuXxXrKrLL-rcA-GrWMkL9t0ZHqHAAXhnb4m_hAAHBerM-ZITLFTcSY
Message-ID: <CADnq5_ONz2NmSDjTRPV_juM1X-k91wzZG-65jBZ45tvK6bBixw@mail.gmail.com>
Subject: Re: [v2 1/2] drm/amdgpu: Simplify user queue locking with global
 device mutex
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com
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

On Fri, Sep 12, 2025 at 10:06=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 12.09.25 15:02, Alex Deucher wrote:
> > On Fri, Sep 12, 2025 at 7:17=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 12.09.25 11:31, Jesse.Zhang wrote:
> >>> The current user queue implementation uses a dual-mutex scheme with
> >>> both per-device (adev->userq_mutex) and per-process (uq_mgr->userq_mu=
tex)
> >>> locking. This overcomplicated design creates potential deadlock scena=
rios
> >>> and makes the code harder to maintain.
> >>>
> >>> Simplify the locking by switching entirely to the global adev->userq_=
mutex
> >>> for all user queue operations. This approach:
> >>> - Eliminates potential deadlocks between the two mutexes
> >>> - Serializes all user queue handling at the kernel level
> >>> - Provides adequate protection since user queue operations aren't
> >>>   performance-critical paths
> >>> - Makes the code more maintainable with a single locking scheme
> >>>
> >>> Key changes:
> >>> 1. Remove uq_mgr->userq_mutex entirely from amdgpu_userq_mgr
> >>> 2. Consistently use adev->userq_mutex across all user queue operation=
s
> >>> 3. Add proper work flushing in amdgpu_userq_ensure_ev_fence() to
> >>>    prevent races when ensuring eviction fence availability
> >>> 4. Maintain proper locking order throughout all user queue functions
> >>>
> >>> The serialization of all user queue operations is acceptable since
> >>> these are management operations that don't need high parallelism.
> >>>
> >>
> >> Absolutely clear NAK to that.
> >>
> >> This also serialized eviction handling making it completely useless.
> >>
> >> The global mutex should only be used when new clients open up their co=
nnection for the first time or closes the last reference and never otherwis=
e.
> >
> > The problem is that the firmware reset code can affect multiple queues
> > so we need some way to lock all queues during resets so we can
> > properly update their status.
>
> That shouldn't be necessary.
>
> When all queues are affected we should use a sequence number to indicate =
the queue generation.
>
> When only a subset of queues are affected then we would need to identify =
the queues and then set exactly those to an error.
>
> So what exactly do we get on information from the FW?

FW gives us a list of doorbells for queues that were hung and reset.

Alex

>
> Christian.
>
>
> >
> > Alex
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> >>> ---
> >>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 ++--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 32 ++++++-----------=
--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
> >>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +--
> >>>  4 files changed, 16 insertions(+), 29 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> >>> index 23d7d0b0d625..d6a07fac7df2 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> >>> @@ -105,9 +105,10 @@ amdgpu_eviction_fence_suspend_worker(struct work=
_struct *work)
> >>>       struct amdgpu_eviction_fence_mgr *evf_mgr =3D work_to_evf_mgr(w=
ork, suspend_work.work);
> >>>       struct amdgpu_fpriv *fpriv =3D evf_mgr_to_fpriv(evf_mgr);
> >>>       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> >>> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> >>>       struct amdgpu_eviction_fence *ev_fence;
> >>>
> >>> -     mutex_lock(&uq_mgr->userq_mutex);
> >>> +     mutex_lock(&adev->userq_mutex);
> >>>       spin_lock(&evf_mgr->ev_fence_lock);
> >>>       ev_fence =3D evf_mgr->ev_fence;
> >>>       if (ev_fence)
> >>> @@ -118,13 +119,13 @@ amdgpu_eviction_fence_suspend_worker(struct wor=
k_struct *work)
> >>>
> >>>       amdgpu_userq_evict(uq_mgr, ev_fence);
> >>>
> >>> -     mutex_unlock(&uq_mgr->userq_mutex);
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>>       dma_fence_put(&ev_fence->base);
> >>>       return;
> >>>
> >>>  unlock:
> >>>       spin_unlock(&evf_mgr->ev_fence_lock);
> >>> -     mutex_unlock(&uq_mgr->userq_mutex);
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>>  }
> >>>
> >>>  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence =
*f)
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userq.c
> >>> index b649ac0cedff..af92450ea6eb 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>> @@ -198,17 +198,18 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_user=
q_mgr *uq_mgr,
> >>>                            struct amdgpu_eviction_fence_mgr *evf_mgr)
> >>>  {
> >>>       struct amdgpu_eviction_fence *ev_fence;
> >>> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> >>>
> >>>  retry:
> >>>       /* Flush any pending resume work to create ev_fence */
> >>>       flush_delayed_work(&uq_mgr->resume_work);
> >>>
> >>> -     mutex_lock(&uq_mgr->userq_mutex);
> >>> +     mutex_lock(&adev->userq_mutex);
> >>>       spin_lock(&evf_mgr->ev_fence_lock);
> >>>       ev_fence =3D evf_mgr->ev_fence;
> >>>       spin_unlock(&evf_mgr->ev_fence_lock);
> >>>       if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
> >>> -             mutex_unlock(&uq_mgr->userq_mutex);
> >>> +             mutex_unlock(&adev->userq_mutex);
> >>>               /*
> >>>                * Looks like there was no pending resume work,
> >>>                * add one now to create a valid eviction fence
> >>> @@ -362,12 +363,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int=
 queue_id)
> >>>       int r =3D 0;
> >>>
> >>>       cancel_delayed_work_sync(&uq_mgr->resume_work);
> >>> -     mutex_lock(&uq_mgr->userq_mutex);
> >>> +     mutex_lock(&adev->userq_mutex);
> >>>
> >>>       queue =3D amdgpu_userq_find(uq_mgr, queue_id);
> >>>       if (!queue) {
> >>>               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queu=
e id to destroy\n");
> >>> -             mutex_unlock(&uq_mgr->userq_mutex);
> >>> +             mutex_unlock(&adev->userq_mutex);
> >>>               return -EINVAL;
> >>>       }
> >>>       amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> >>> @@ -388,7 +389,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int q=
ueue_id)
> >>>               queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >>>       }
> >>>       amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
> >>> -     mutex_unlock(&uq_mgr->userq_mutex);
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>>
> >>>       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >>>       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >>> @@ -478,7 +479,6 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >>>               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >>>               return r;
> >>>       }
> >>> -
> >>>       /*
> >>>        * There could be a situation that we are creating a new queue =
while
> >>>        * the other queues under this UQ_mgr are suspended. So if ther=
e is any
> >>> @@ -486,7 +486,6 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >>>        *
> >>>        * This will also make sure we have a valid eviction fence read=
y to be used.
> >>>        */
> >>> -     mutex_lock(&adev->userq_mutex);
> >>>       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr=
);
> >>>
> >>>       uq_funcs =3D adev->userq_funcs[args->in.ip_type];
> >>> @@ -588,9 +587,7 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >>>       kfree(queue_name);
> >>>
> >>>       args->out.queue_id =3D qid;
> >>> -
> >>>  unlock:
> >>> -     mutex_unlock(&uq_mgr->userq_mutex);
> >>>       mutex_unlock(&adev->userq_mutex);
> >>>
> >>>       return r;
> >>> @@ -820,11 +817,12 @@ static void amdgpu_userq_restore_worker(struct =
work_struct *work)
> >>>  {
> >>>       struct amdgpu_userq_mgr *uq_mgr =3D work_to_uq_mgr(work, resume=
_work.work);
> >>>       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> >>> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> >>>       int ret;
> >>>
> >>>       flush_delayed_work(&fpriv->evf_mgr.suspend_work);
> >>>
> >>> -     mutex_lock(&uq_mgr->userq_mutex);
> >>> +     mutex_lock(&adev->userq_mutex);
> >>>
> >>>       ret =3D amdgpu_userq_validate_bos(uq_mgr);
> >>>       if (ret) {
> >>> @@ -839,7 +837,7 @@ static void amdgpu_userq_restore_worker(struct wo=
rk_struct *work)
> >>>       }
> >>>
> >>>  unlock:
> >>> -     mutex_unlock(&uq_mgr->userq_mutex);
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>>  }
> >>>
> >>>  static int
> >>> @@ -919,7 +917,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mg=
r,
> >>>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct=
 drm_file *file_priv,
> >>>                         struct amdgpu_device *adev)
> >>>  {
> >>> -     mutex_init(&userq_mgr->userq_mutex);
> >>>       idr_init_base(&userq_mgr->userq_idr, 1);
> >>>       userq_mgr->adev =3D adev;
> >>>       userq_mgr->file =3D file_priv;
> >>> @@ -942,7 +939,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mg=
r *userq_mgr)
> >>>       cancel_delayed_work_sync(&userq_mgr->resume_work);
> >>>
> >>>       mutex_lock(&adev->userq_mutex);
> >>> -     mutex_lock(&userq_mgr->userq_mutex);
> >>>       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> >>>               amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
> >>>               amdgpu_userq_unmap_helper(userq_mgr, queue);
> >>> @@ -956,9 +952,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mg=
r *userq_mgr)
> >>>               }
> >>>       }
> >>>       idr_destroy(&userq_mgr->userq_idr);
> >>> -     mutex_unlock(&userq_mgr->userq_mutex);
> >>>       mutex_unlock(&adev->userq_mutex);
> >>> -     mutex_destroy(&userq_mgr->userq_mutex);
> >>>  }
> >>>
> >>>  int amdgpu_userq_suspend(struct amdgpu_device *adev)
> >>> @@ -975,13 +969,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *=
adev)
> >>>       mutex_lock(&adev->userq_mutex);
> >>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >>>               cancel_delayed_work_sync(&uqm->resume_work);
> >>> -             mutex_lock(&uqm->userq_mutex);
> >>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >>>                       r =3D amdgpu_userq_unmap_helper(uqm, queue);
> >>>                       if (r)
> >>>                               ret =3D r;
> >>>               }
> >>> -             mutex_unlock(&uqm->userq_mutex);
> >>>       }
> >>>       mutex_unlock(&adev->userq_mutex);
> >>>       return ret;
> >>> @@ -1000,13 +992,11 @@ int amdgpu_userq_resume(struct amdgpu_device *=
adev)
> >>>
> >>>       mutex_lock(&adev->userq_mutex);
> >>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >>> -             mutex_lock(&uqm->userq_mutex);
> >>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >>>                       r =3D amdgpu_userq_map_helper(uqm, queue);
> >>>                       if (r)
> >>>                               ret =3D r;
> >>>               }
> >>> -             mutex_unlock(&uqm->userq_mutex);
> >>>       }
> >>>       mutex_unlock(&adev->userq_mutex);
> >>>       return ret;
> >>> @@ -1031,7 +1021,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolati=
on(struct amdgpu_device *adev,
> >>>       adev->userq_halt_for_enforce_isolation =3D true;
> >>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >>>               cancel_delayed_work_sync(&uqm->resume_work);
> >>> -             mutex_lock(&uqm->userq_mutex);
> >>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >>>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX=
) ||
> >>>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COM=
PUTE)) &&
> >>> @@ -1041,7 +1030,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolati=
on(struct amdgpu_device *adev,
> >>>                                       ret =3D r;
> >>>                       }
> >>>               }
> >>> -             mutex_unlock(&uqm->userq_mutex);
> >>>       }
> >>>       mutex_unlock(&adev->userq_mutex);
> >>>       return ret;
> >>> @@ -1065,7 +1053,6 @@ int amdgpu_userq_start_sched_for_enforce_isolat=
ion(struct amdgpu_device *adev,
> >>>               dev_warn(adev->dev, "userq scheduling already started!\=
n");
> >>>       adev->userq_halt_for_enforce_isolation =3D false;
> >>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >>> -             mutex_lock(&uqm->userq_mutex);
> >>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >>>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX=
) ||
> >>>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COM=
PUTE)) &&
> >>> @@ -1075,7 +1062,6 @@ int amdgpu_userq_start_sched_for_enforce_isolat=
ion(struct amdgpu_device *adev,
> >>>                                       ret =3D r;
> >>>                       }
> >>>               }
> >>> -             mutex_unlock(&uqm->userq_mutex);
> >>>       }
> >>>       mutex_unlock(&adev->userq_mutex);
> >>>       return ret;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userq.h
> >>> index c027dd916672..2d63308d55c3 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> >>> @@ -89,7 +89,6 @@ struct amdgpu_userq_funcs {
> >>>  /* Usermode queues for gfx */
> >>>  struct amdgpu_userq_mgr {
> >>>       struct idr                      userq_idr;
> >>> -     struct mutex                    userq_mutex;
> >>>       struct amdgpu_device            *adev;
> >>>       struct delayed_work             resume_work;
> >>>       struct list_head                list;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>> index 95e91d1dc58a..daf3be92a39c 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >>> @@ -464,6 +464,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *=
dev, void *data,
> >>>       u32 *bo_handles_write, num_write_bo_handles;
> >>>       u32 *syncobj_handles, num_syncobj_handles;
> >>>       u32 *bo_handles_read, num_read_bo_handles;
> >>> +     struct amdgpu_device *adev =3D userq_mgr->adev;
> >>>       int r, i, entry, rentry, wentry;
> >>>       struct dma_fence *fence;
> >>>       struct drm_exec exec;
> >>> @@ -557,14 +558,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device=
 *dev, void *data,
> >>>       /* Create a new fence */
> >>>       r =3D amdgpu_userq_fence_create(queue, userq_fence, wptr, &fenc=
e);
> >>>       if (r) {
> >>> -             mutex_unlock(&userq_mgr->userq_mutex);
> >>> +             mutex_unlock(&adev->userq_mutex);
> >>>               kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
> >>>               goto put_gobj_write;
> >>>       }
> >>>
> >>>       dma_fence_put(queue->last_fence);
> >>>       queue->last_fence =3D dma_fence_get(fence);
> >>> -     mutex_unlock(&userq_mgr->userq_mutex);
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>>
> >>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> >>>                     (num_read_bo_handles + num_write_bo_handles));
> >>
>

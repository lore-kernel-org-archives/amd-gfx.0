Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A238CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 13:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104D110E1CE;
	Fri, 12 Sep 2025 13:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ll9SAPBC";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D598710E1CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 13:02:46 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-25f897894bfso66335ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757682166; x=1758286966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXA66EIX3wVCeyGMBgGaQFZaD+Nstako+/dJrUIrAyQ=;
 b=Ll9SAPBCheJ4gwGfe/RADRC5qnlX1AaELU1txDx0TUWruR6yAxxt0eJ8+eokFbC4Xt
 r1A/t6FXQm4hsPCzyx5iUyKweZeR4x66IfK+zWmD4Mk+nJw78hUjnS30BdNPkmJQNYIO
 tDQ8IxiO41z12IWUSjbNS+e0bbi56fYLKaKH8Zn5eW4b68JQ/WqUFjq07QQMNAo+opt0
 p4Gp91booLrWFcnPddt1Z6cA5wXOFumzlELEH61Fvht2vSsZU5RbRYcq7HdCAqlz6VHV
 5kDzXni7teMDf6mM+XDxTWgE8UgrHceNA/M1gvLxhMDjHBy8Wl8/qLDnZMFbHgj7/WSM
 t4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757682166; x=1758286966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXA66EIX3wVCeyGMBgGaQFZaD+Nstako+/dJrUIrAyQ=;
 b=wsiIWLAD2XOjM9Aio+mPd/zVvFxmNIaVGNBOVjODG4dk08fKhIHUcoJ4NUZ4x/9vwT
 8IzYWQJgixrZvJI9iE2Nh3ilkq0yP0pRF1//5g9Ojg103hOH9BbnklRG6Z0QrxesA3/0
 VAAeYx46xJBa0VgxZ7X5RzOBs6nTJRY7VUzSLPK/hlH+zr1N66aL1qH065GY6Nn+OrSD
 3Ub4Q7n9u+G4ukXOsEmKHfI1RkoQQCKlf/s0qNzQaLP3LHVbuZd4Dm8kCymOuftpPqJD
 75FdbNBN+7NMWe0CPpaAfIryMAXMay9Otlc0S1h7sdxxGpwZyMcvqH+Hhbr+zk9kptqw
 oOBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjnLxR3zjZQnjNWvi08H2+EOpmw6WfCnFGWemAV1U9DBOKOm9wup2rCjj+4Su/8DCuucu5tOe9@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz9Fw0HSLUo9wlnWP7SpSv5S+kj0QT/b+5sVC6xTX3CVuzaHy/
 naYykcmDHCjkIS66I/tuoMRZuUpb/w8LOHjbCvsZEKasBwldGSCS+tfVJxQCM4hM9htr7BHtVbM
 VPG/9SUVB0kC49GMKpi5vRBNLR/0AI6E=
X-Gm-Gg: ASbGnctiPHDCidZImDnL11NZBtwoNdN7khdxZz6yIUGFuN/C0XVX8k1w7Oot4F11PUJ
 QZVNrz0xBcnsEW0zihX5qFMM7DtNtWOkm4GBdX4UPD1g0udYKPD5HIoRnfq2xBSv1deJkjQD2lo
 sKTUcHmqCIz5C3iUSAGnR+fRGc5+8BVFNHdG776Dz6MUHrhhg1Uy6caDHMnsBrwEfvqjX9yVXt9
 dWy1J2UrMQrJNbfsA==
X-Google-Smtp-Source: AGHT+IHr0rGqrDzl4jmjQs8BZuTct0HAbns7KPKiS03lifOUkF+epyQfRyBW6y8+OJyLGECreKzwkRpCRxGoONyBlHU=
X-Received: by 2002:a17:903:3dec:b0:24c:ac4d:d84b with SMTP id
 d9443c01a7336-25d2665fe5emr14322275ad.7.1757682165992; Fri, 12 Sep 2025
 06:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250912093202.4905-1-Jesse.Zhang@amd.com>
 <5a04607d-0d50-4543-8498-52122045048d@amd.com>
In-Reply-To: <5a04607d-0d50-4543-8498-52122045048d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Sep 2025 09:02:34 -0400
X-Gm-Features: Ac12FXwVujhzJpoi4-_HF-701j67DcofHqNMoD-eTdejA9mUOh9laM_XhgmgNpU
Message-ID: <CADnq5_MoPA7hMc1ffM992pxzU=UeAMaTC2AZBzpC+4Y8uP37gw@mail.gmail.com>
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

On Fri, Sep 12, 2025 at 7:17=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 12.09.25 11:31, Jesse.Zhang wrote:
> > The current user queue implementation uses a dual-mutex scheme with
> > both per-device (adev->userq_mutex) and per-process (uq_mgr->userq_mute=
x)
> > locking. This overcomplicated design creates potential deadlock scenari=
os
> > and makes the code harder to maintain.
> >
> > Simplify the locking by switching entirely to the global adev->userq_mu=
tex
> > for all user queue operations. This approach:
> > - Eliminates potential deadlocks between the two mutexes
> > - Serializes all user queue handling at the kernel level
> > - Provides adequate protection since user queue operations aren't
> >   performance-critical paths
> > - Makes the code more maintainable with a single locking scheme
> >
> > Key changes:
> > 1. Remove uq_mgr->userq_mutex entirely from amdgpu_userq_mgr
> > 2. Consistently use adev->userq_mutex across all user queue operations
> > 3. Add proper work flushing in amdgpu_userq_ensure_ev_fence() to
> >    prevent races when ensuring eviction fence availability
> > 4. Maintain proper locking order throughout all user queue functions
> >
> > The serialization of all user queue operations is acceptable since
> > these are management operations that don't need high parallelism.
> >
>
> Absolutely clear NAK to that.
>
> This also serialized eviction handling making it completely useless.
>
> The global mutex should only be used when new clients open up their conne=
ction for the first time or closes the last reference and never otherwise.

The problem is that the firmware reset code can affect multiple queues
so we need some way to lock all queues during resets so we can
properly update their status.

Alex

>
> Regards,
> Christian.
>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 32 ++++++-------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
> >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +--
> >  4 files changed, 16 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> > index 23d7d0b0d625..d6a07fac7df2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> > @@ -105,9 +105,10 @@ amdgpu_eviction_fence_suspend_worker(struct work_s=
truct *work)
> >       struct amdgpu_eviction_fence_mgr *evf_mgr =3D work_to_evf_mgr(wor=
k, suspend_work.work);
> >       struct amdgpu_fpriv *fpriv =3D evf_mgr_to_fpriv(evf_mgr);
> >       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> > +     struct amdgpu_device *adev =3D uq_mgr->adev;
> >       struct amdgpu_eviction_fence *ev_fence;
> >
> > -     mutex_lock(&uq_mgr->userq_mutex);
> > +     mutex_lock(&adev->userq_mutex);
> >       spin_lock(&evf_mgr->ev_fence_lock);
> >       ev_fence =3D evf_mgr->ev_fence;
> >       if (ev_fence)
> > @@ -118,13 +119,13 @@ amdgpu_eviction_fence_suspend_worker(struct work_=
struct *work)
> >
> >       amdgpu_userq_evict(uq_mgr, ev_fence);
> >
> > -     mutex_unlock(&uq_mgr->userq_mutex);
> > +     mutex_unlock(&adev->userq_mutex);
> >       dma_fence_put(&ev_fence->base);
> >       return;
> >
> >  unlock:
> >       spin_unlock(&evf_mgr->ev_fence_lock);
> > -     mutex_unlock(&uq_mgr->userq_mutex);
> > +     mutex_unlock(&adev->userq_mutex);
> >  }
> >
> >  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f=
)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> > index b649ac0cedff..af92450ea6eb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -198,17 +198,18 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_=
mgr *uq_mgr,
> >                            struct amdgpu_eviction_fence_mgr *evf_mgr)
> >  {
> >       struct amdgpu_eviction_fence *ev_fence;
> > +     struct amdgpu_device *adev =3D uq_mgr->adev;
> >
> >  retry:
> >       /* Flush any pending resume work to create ev_fence */
> >       flush_delayed_work(&uq_mgr->resume_work);
> >
> > -     mutex_lock(&uq_mgr->userq_mutex);
> > +     mutex_lock(&adev->userq_mutex);
> >       spin_lock(&evf_mgr->ev_fence_lock);
> >       ev_fence =3D evf_mgr->ev_fence;
> >       spin_unlock(&evf_mgr->ev_fence_lock);
> >       if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
> > -             mutex_unlock(&uq_mgr->userq_mutex);
> > +             mutex_unlock(&adev->userq_mutex);
> >               /*
> >                * Looks like there was no pending resume work,
> >                * add one now to create a valid eviction fence
> > @@ -362,12 +363,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int q=
ueue_id)
> >       int r =3D 0;
> >
> >       cancel_delayed_work_sync(&uq_mgr->resume_work);
> > -     mutex_lock(&uq_mgr->userq_mutex);
> > +     mutex_lock(&adev->userq_mutex);
> >
> >       queue =3D amdgpu_userq_find(uq_mgr, queue_id);
> >       if (!queue) {
> >               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue =
id to destroy\n");
> > -             mutex_unlock(&uq_mgr->userq_mutex);
> > +             mutex_unlock(&adev->userq_mutex);
> >               return -EINVAL;
> >       }
> >       amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> > @@ -388,7 +389,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int que=
ue_id)
> >               queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >       }
> >       amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
> > -     mutex_unlock(&uq_mgr->userq_mutex);
> > +     mutex_unlock(&adev->userq_mutex);
> >
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > @@ -478,7 +479,6 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
> >               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >               return r;
> >       }
> > -
> >       /*
> >        * There could be a situation that we are creating a new queue wh=
ile
> >        * the other queues under this UQ_mgr are suspended. So if there =
is any
> > @@ -486,7 +486,6 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
> >        *
> >        * This will also make sure we have a valid eviction fence ready =
to be used.
> >        */
> > -     mutex_lock(&adev->userq_mutex);
> >       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> >
> >       uq_funcs =3D adev->userq_funcs[args->in.ip_type];
> > @@ -588,9 +587,7 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
> >       kfree(queue_name);
> >
> >       args->out.queue_id =3D qid;
> > -
> >  unlock:
> > -     mutex_unlock(&uq_mgr->userq_mutex);
> >       mutex_unlock(&adev->userq_mutex);
> >
> >       return r;
> > @@ -820,11 +817,12 @@ static void amdgpu_userq_restore_worker(struct wo=
rk_struct *work)
> >  {
> >       struct amdgpu_userq_mgr *uq_mgr =3D work_to_uq_mgr(work, resume_w=
ork.work);
> >       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> > +     struct amdgpu_device *adev =3D uq_mgr->adev;
> >       int ret;
> >
> >       flush_delayed_work(&fpriv->evf_mgr.suspend_work);
> >
> > -     mutex_lock(&uq_mgr->userq_mutex);
> > +     mutex_lock(&adev->userq_mutex);
> >
> >       ret =3D amdgpu_userq_validate_bos(uq_mgr);
> >       if (ret) {
> > @@ -839,7 +837,7 @@ static void amdgpu_userq_restore_worker(struct work=
_struct *work)
> >       }
> >
> >  unlock:
> > -     mutex_unlock(&uq_mgr->userq_mutex);
> > +     mutex_unlock(&adev->userq_mutex);
> >  }
> >
> >  static int
> > @@ -919,7 +917,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> >  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct d=
rm_file *file_priv,
> >                         struct amdgpu_device *adev)
> >  {
> > -     mutex_init(&userq_mgr->userq_mutex);
> >       idr_init_base(&userq_mgr->userq_idr, 1);
> >       userq_mgr->adev =3D adev;
> >       userq_mgr->file =3D file_priv;
> > @@ -942,7 +939,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr =
*userq_mgr)
> >       cancel_delayed_work_sync(&userq_mgr->resume_work);
> >
> >       mutex_lock(&adev->userq_mutex);
> > -     mutex_lock(&userq_mgr->userq_mutex);
> >       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> >               amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
> >               amdgpu_userq_unmap_helper(userq_mgr, queue);
> > @@ -956,9 +952,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr =
*userq_mgr)
> >               }
> >       }
> >       idr_destroy(&userq_mgr->userq_idr);
> > -     mutex_unlock(&userq_mgr->userq_mutex);
> >       mutex_unlock(&adev->userq_mutex);
> > -     mutex_destroy(&userq_mgr->userq_mutex);
> >  }
> >
> >  int amdgpu_userq_suspend(struct amdgpu_device *adev)
> > @@ -975,13 +969,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *ad=
ev)
> >       mutex_lock(&adev->userq_mutex);
> >       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> >               cancel_delayed_work_sync(&uqm->resume_work);
> > -             mutex_lock(&uqm->userq_mutex);
> >               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >                       r =3D amdgpu_userq_unmap_helper(uqm, queue);
> >                       if (r)
> >                               ret =3D r;
> >               }
> > -             mutex_unlock(&uqm->userq_mutex);
> >       }
> >       mutex_unlock(&adev->userq_mutex);
> >       return ret;
> > @@ -1000,13 +992,11 @@ int amdgpu_userq_resume(struct amdgpu_device *ad=
ev)
> >
> >       mutex_lock(&adev->userq_mutex);
> >       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> > -             mutex_lock(&uqm->userq_mutex);
> >               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >                       r =3D amdgpu_userq_map_helper(uqm, queue);
> >                       if (r)
> >                               ret =3D r;
> >               }
> > -             mutex_unlock(&uqm->userq_mutex);
> >       }
> >       mutex_unlock(&adev->userq_mutex);
> >       return ret;
> > @@ -1031,7 +1021,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation=
(struct amdgpu_device *adev,
> >       adev->userq_halt_for_enforce_isolation =3D true;
> >       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> >               cancel_delayed_work_sync(&uqm->resume_work);
> > -             mutex_lock(&uqm->userq_mutex);
> >               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
> >                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
> > @@ -1041,7 +1030,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation=
(struct amdgpu_device *adev,
> >                                       ret =3D r;
> >                       }
> >               }
> > -             mutex_unlock(&uqm->userq_mutex);
> >       }
> >       mutex_unlock(&adev->userq_mutex);
> >       return ret;
> > @@ -1065,7 +1053,6 @@ int amdgpu_userq_start_sched_for_enforce_isolatio=
n(struct amdgpu_device *adev,
> >               dev_warn(adev->dev, "userq scheduling already started!\n"=
);
> >       adev->userq_halt_for_enforce_isolation =3D false;
> >       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> > -             mutex_lock(&uqm->userq_mutex);
> >               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
> >                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
> > @@ -1075,7 +1062,6 @@ int amdgpu_userq_start_sched_for_enforce_isolatio=
n(struct amdgpu_device *adev,
> >                                       ret =3D r;
> >                       }
> >               }
> > -             mutex_unlock(&uqm->userq_mutex);
> >       }
> >       mutex_unlock(&adev->userq_mutex);
> >       return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.h
> > index c027dd916672..2d63308d55c3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > @@ -89,7 +89,6 @@ struct amdgpu_userq_funcs {
> >  /* Usermode queues for gfx */
> >  struct amdgpu_userq_mgr {
> >       struct idr                      userq_idr;
> > -     struct mutex                    userq_mutex;
> >       struct amdgpu_device            *adev;
> >       struct delayed_work             resume_work;
> >       struct list_head                list;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > index 95e91d1dc58a..daf3be92a39c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > @@ -464,6 +464,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *de=
v, void *data,
> >       u32 *bo_handles_write, num_write_bo_handles;
> >       u32 *syncobj_handles, num_syncobj_handles;
> >       u32 *bo_handles_read, num_read_bo_handles;
> > +     struct amdgpu_device *adev =3D userq_mgr->adev;
> >       int r, i, entry, rentry, wentry;
> >       struct dma_fence *fence;
> >       struct drm_exec exec;
> > @@ -557,14 +558,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *=
dev, void *data,
> >       /* Create a new fence */
> >       r =3D amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence)=
;
> >       if (r) {
> > -             mutex_unlock(&userq_mgr->userq_mutex);
> > +             mutex_unlock(&adev->userq_mutex);
> >               kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
> >               goto put_gobj_write;
> >       }
> >
> >       dma_fence_put(queue->last_fence);
> >       queue->last_fence =3D dma_fence_get(fence);
> > -     mutex_unlock(&userq_mgr->userq_mutex);
> > +     mutex_unlock(&adev->userq_mutex);
> >
> >       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> >                     (num_read_bo_handles + num_write_bo_handles));
>

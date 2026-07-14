Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D5C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F27010E06D;
	Tue, 14 Jul 2026 15:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLAAyfig";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD9110E06D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:52:00 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c8612812170so605909a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784044320; cv=none;
 d=google.com; s=arc-20260327;
 b=FU8edgihjHHymCJnBBZSVRuMtf7HbC0WFMjPX8AF9uYJ5i/Xo37IJ9/BIc1aOHqlq7
 FLfUA9PaRbHS9tlM68WjM79qPwRL0C9iGAS93snVyiZJkeHRoCJkX8Ev/5pp13/ESF3O
 dSZ4U/QaJy2uA3LAaN6+78TqdLlVoPuTUzTNRpOu7D1H0BlokuNYuOdTVnYxE1TX6zOt
 dZD1s7/JKqK5JfaaP8TwyMgtNIh+3DPkTeSMV8XU/cBgohwBmi2T6fqjV8WNFVOssU2r
 bD2ywOr4ZsS6eOYboJYzJ8AZFL9RFWDf0KuuZJR80DQThdBbnrmid1wxbwC11Aoxf0IV
 u2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t53sl9wwp6xbNnV5IpEuMPWZ/vHYemLyviQqs1IKJ1c=;
 fh=G/DKVfBmoRW5yQ4cOQMlIFLX8ggET+32rA1vet4+vmg=;
 b=UuUOWsZjh0rIJ1I59HbUSdJvnpE2HEQNUxmgicW4ss6jW4topoCgSElVYUTWw1QFWE
 NQNCo2fWUk/26OXd2CNZG513XWNERn+o7GkcWY2fS1xYNEj3oJt9TZeFXi9IJgVKix8A
 RYSoXXuzz/srT0rLk1pZgck/wh+LI5HPYIITX7KkOIHvDN9ZDxFdQeZCy1eSJX6t4KqT
 01hSGZbDs7N+jgJWk4Lk7i9gICELmIVe10pbfP/CSIi8KXfsUeCAJR9PnTkzdLISeUcK
 r7RZKV1tPTE6bf2bvzHr/OG+BRvKCTOC6egWSxUDCUSzmGtdaTA0979gbdW4Q9PxM9YS
 qIdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784044320; x=1784649120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t53sl9wwp6xbNnV5IpEuMPWZ/vHYemLyviQqs1IKJ1c=;
 b=hLAAyfigTwhj5PNsKnLhCtDnG7lfKDvV1j0ksEo4MWBjxVFf363I1lx59lnDvp3lRs
 XnhOJ0QIaAxS2jUxhyWC8o7EZvLM3AD5zcqrbXcZ4HbvPlVguqHI2JZ57gQablW4FXL/
 +v/qHdOtirOttPhnFUXQ5YD811Wml7uBIJ2C2IOqeZ5oQE1fsxBryAkPj2dzOI+LQBxe
 ZtdmH6dNBZmQLKMIDFodEB3/GIOy3yM0QAJGx/Q0nxGRZbJeyY+vMx15qFiSXETwZJes
 aN+gqg0mkphwqeblRRKRnaF0HJKy7Srxdq8CvnuqpLe4gHWS5ffVSPZ9/o/ZgYPP+/Rl
 k2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784044320; x=1784649120;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t53sl9wwp6xbNnV5IpEuMPWZ/vHYemLyviQqs1IKJ1c=;
 b=PtQngWBKRRGAj9YKik0NQEGuqs6QNgVu2OblW4Zy894ElkvaAV2rEwHfUYzEQJpn8v
 IUjf3cG/50gf2Gce6l0LcIrXwaf4U1AYJFvgBp/ABEG5sShvv8hpYic0YPghwdt5AWCy
 cTukOGXlOVEugdOlBPpLES6Bisrg07WGuxm4vZp9XO3iPjUz0K9ezk7dG1+rVf32KB6M
 /6koA1ooKBHvlkgI3H8glPOG1ccICyl6b8ImNx2Usm5hL6qIswhiKTQmAajakoLmbA2J
 +TR0ksv33aUUpbxIRZjWTkZfikmV2Ld8SZi3W0H7dimUbp8igpyD/4/C/HKVWTvBc1PB
 xWYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGEK6bGJ+tphdGSDLIruHaL6E2Rgwwa7JBJU+uiikNcD0YZ8zpfk8qLsyFO1ZaJkMdCiu/liXW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzscdRdLePYAX5fwDDlszCfdZoc0bgTIZOooBPHwW/x4ZlrEx/
 KbmyKustg7bhIvbOPkmhS0HflQRmDiPSJksYYwHyS7A7Rqm2BnaMbYljm7ZxnAqvVjXtBugeeXn
 yT9/OfnMo4b+a6scodBWOXTa25cwdYi8=
X-Gm-Gg: AfdE7cnAMufVNTOG8D2ZgbCdKClnVAPeDof8uv1ycOxwQcf/3vOjjPhaXfRMkxMGRCn
 5jfK/Cpijvi8et2FV81ipTQc29SWuQ3exDFfYjrRrp+ejk2rCUrZYWGUtCylobLMebHRzFDsHQo
 tWMM3VjDEAXJdJGYTwpCZGh391aJHrYxF1Jgfekymp4QKJZSqkX8/IBZVLEVLYqHkYPls5G3FhF
 HbJtaRFqMvP7WUXo/bqreJXSTYOtLfU+rWE7MlKiAXZAoKsDlKJu3vxzFxwHxwQnTNtwAfnUzHi
 s9xx3yswtTj/JWH9ZNXOmUQ9dNtFqbrs0LgfI7x8hJYpmqTdm70EcWFgXjI=
X-Received: by 2002:a05:6a21:32a2:b0:3bf:d1f9:b1e5 with SMTP id
 adf61e73a8af0-3c110b6c280mr11266341637.8.1784044319633; Tue, 14 Jul 2026
 08:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260714143939.680824-1-alexander.deucher@amd.com>
 <IA0PR12MB820835A0622B2BDB9DE560B890F92@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB820835A0622B2BDB9DE560B890F92@IA0PR12MB8208.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 11:51:48 -0400
X-Gm-Features: AUfX_mwyU3vuC_oWf1v7_GMlKNLXBI1wfYfAEBwQiIOIMkea4Z15MTK6hZytqyE
Message-ID: <CADnq5_MNLK2pyvUMQn=xupXp3L5SVajU==hiGbQXNdrjTUBZSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: properly account for resets with user queues
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang,
 Prike" <Prike.Liang@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
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

On Tue, Jul 14, 2026 at 11:19=E2=80=AFAM SHANMUGAM, SRINIVASAN
<SRINIVASAN.SHANMUGAM@amd.com> wrote:
>
> AMD General
>
> Hi Alex,
>
> > -----Original Message-----
> > From: Alex Deucher <alexander.deucher@amd.com>
> > Sent: Tuesday, July 14, 2026 8:10 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lij=
o
> > <Lijo.Lazar@amd.com>
> > Subject: [PATCH] drm/amdgpu: properly account for resets with user queu=
es
> >
> > We need to increment the reset counter, force fence completion, and set=
 the
> > wedged event when a user queue is reset, but only for the guilty queue.=
  We don't
> > want additional events for collateral damage.
> >
> > Only increment the reset counter and set the wedged event in the top le=
vel userq
> > reset callers (both KGD and KFD).
> > This aligns with how this is managed for kernel queue resets.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > Cc: Lazar, Lijo <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 17 ++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      |  2 --
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 14 ++++++++++++++
> >  3 files changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index 6aa75da27f912..0a0ebcdc271f8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -123,6 +123,8 @@ static void amdgpu_userq_hang_detect_work(struct
> > work_struct *work)
> >       struct amdgpu_device *adev =3D uq_mgr->adev;
> >       const struct amdgpu_userq_funcs *userq_funcs =3D
> >               adev->userq_funcs[queue->queue_type];
> > +     struct drm_wedge_task_info *info =3D NULL;
> > +     struct amdgpu_task_info *ti =3D NULL;
> >       bool gpu_reset =3D false;
> >
> >       if (unlikely(adev->debug_disable_gpu_ring_reset)) { @@ -137,6 +13=
9,14
> > @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
> >       if (!amdgpu_gpu_recovery)
> >               return;
> >
> > +     if (queue->vm && queue->vm->pasid) {
> > +             ti =3D amdgpu_vm_get_task_info_pasid(adev, queue->vm->pas=
id);
> > +             if (ti) {
> > +                     amdgpu_vm_print_task_info(adev, ti);
> > +                     info =3D &ti->task;
> > +             }
> > +     }
> > +
>
> `amdgpu_vm_get_task_info_pasid()` returns a referenced
> `amdgpu_task_info`, and the existing `amdgpu_job_timedout()` path pairs
> it with `amdgpu_vm_put_task_info(ti)` on the exit path.
>
> Since `info` points into `ti`, should we keep the reference until after
> `drm_dev_wedged_event()` and then add the matching
> `amdgpu_vm_put_task_info(ti)` on the common exit path here?

Good catch.  Fixed.

>
>
> >       if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
> >
> > AMDGPU_RESET_TYPE_PER_QUEUE)) {
> >               int r;
> > @@ -146,8 +156,13 @@ static void amdgpu_userq_hang_detect_work(struct
> > work_struct *work)
> >                                                        queue, NULL, NUL=
L);
> >               else
> >                       r =3D userq_funcs->reset(queue);
> > -             if (r)
> > +             if (r) {
> >                       gpu_reset =3D true;
> > +             } else {
> > +                     atomic_inc(&adev->gpu_reset_counter);
> > +                     amdgpu_userq_fence_driver_force_completion(queue)=
;
> > +                     drm_dev_wedged_event(adev_to_drm(adev),
> > DRM_WEDGE_RECOVERY_NONE, info);
> > +             }
> >       } else {
> >               gpu_reset =3D true;
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > index d3d79bbaf9eb7..a1371a9f961d1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -234,9 +234,7 @@ int mes_userq_reset_queue(struct amdgpu_device *ade=
v,
> >                               r =3D mes_userq_unmap(uq);
> >                               if (r)
> >                                       return r;
> > -                             atomic_inc(&adev->gpu_reset_counter);
> >                               amdgpu_userq_fence_driver_force_completio=
n(uq);
> > -                             drm_dev_wedged_event(adev_to_drm(adev),
> > DRM_WEDGE_RECOVERY_NONE, NULL);
> >                               break;
> >                       }
> >               }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 0419fe869d4b0..0ae2d951bd21e 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -448,6 +448,9 @@ int kfd_reset_queue_mes(struct device_queue_manager
> > *dqm, int queue_type,  static int reset_queues_mes(struct device_queue_=
manager
> > *dqm, struct queue *q)  {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> > +     struct drm_wedge_task_info *info =3D NULL;
> > +     struct amdgpu_task_info *ti =3D NULL;
> > +     struct kfd_process_device *pdd;
> >       unsigned int num_hung =3D 0;
> >       int r =3D 0;
> >       struct mes_remove_queue_input queue_input; @@ -476,6 +479,17 @@
> > static int reset_queues_mes(struct device_queue_manager *dqm, struct qu=
eue *q)
> >       r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL,
> > &num_hung, &queue_input);
> >       if (r)
> >               goto fail;
> > +     pdd =3D kfd_get_process_device_data(q->device, q->process);
> > +     if (pdd) {
> > +             ti =3D amdgpu_vm_get_task_info_pasid(adev, pdd->pasid);
> > +             if (ti) {
> > +                     amdgpu_vm_print_task_info(adev, ti);
> > +                     info =3D &ti->task;
> > +             }
> > +     }
>
> Same here: the task-info reference appears to need a matching
> `amdgpu_vm_put_task_info(ti)` after the last use of `info`.

Fixed.

>
> > +
> > +     atomic_inc(&adev->gpu_reset_counter);
> > +     drm_dev_wedged_event(adev_to_drm(adev),
> > DRM_WEDGE_RECOVERY_NONE,
> > +info);
>
> The existing KFD reset event is conditioned on num_hung, while amdgpu_gfx=
_reset_mes_compute() can also handle the known bad queue through queue_inpu=
t when num_hung =3D=3D 0.
>
> Could you pls clarify what condition should determine whether the reset c=
ounter and wedged event are emitted in this path? Should successful removal=
 of the known bad queue also count as the recovery event?

Yes, we should align on whether a bad queue was found or not.  Fixed.

Thanks!

Alex

>
> Thanks,
> Srini

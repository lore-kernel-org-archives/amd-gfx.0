Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B72EC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0C910E0F2;
	Fri, 11 Apr 2025 16:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkkYKm6E";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F42A10E0F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:52:38 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so348596a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744390358; x=1744995158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sj9333H7CUt0ozes5Zug3PAfSpZc6VEEgL3qEkYVvXc=;
 b=dkkYKm6EEDJEgzDn0QyNvAYXRSsJ2M/R9Ct5obCNEJNX1etu1PMktStkUysP9h7Td9
 wXvY8urDrko93t4aIApiU4NClYSyMMRauUml5fNxqr9OnrUAXZeJVlG80+2fcSERxphr
 FKmytZiabo0m7hG07FVVzoIl1rRRuiuJIpszwK9mw/UsRK5bA10Y63/HpaILHx7B7zbT
 SZ75sHb8oIhfueLe/9NZNDKjPLb1sa/Bgz67R0LNH92oKy62EuLaEAZWJC0lKbwlfXEr
 aEhOFHB8BYr7oAjZogiGtoOtAhwvZsjp/tXvwUryPEf7J0rcsXwNXpd8fzglvjcqOko4
 /uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744390358; x=1744995158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sj9333H7CUt0ozes5Zug3PAfSpZc6VEEgL3qEkYVvXc=;
 b=aRnDI8QwTAScowt84tvou4n0JTHaFwBJ5i7DNEn4Aotpf+rqP8u0cXW1pmhfdJ0AaR
 GMWhSQt8+Fp4nRg12CN9qvfYno+GAt0B335UkCcQKrznz8hHfOtU+2xnqxeSjZq6mtTC
 WvPByUUnFeTquiWEDtk7Gw8W7GjVfLoKq4vCwWsf8y24udxx0dwcwgXQ+RRByM4ye5QC
 87GZr0j0jEClRV9CBAib9r2ceA65ebTdFJbtqGi6Xoo/gtT8Eqr6IwWy7bxl4WJUJykz
 IKT+glqD0eJnFmjKJhDBrLbA5od84Bx+CKuxxkJV7X7iRjvK2lC+WkFv/zU27pX3gO7n
 RBKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKVPWiYiUHvShpu62aDyXyLEmz06WxPwvhCLNHFOnRCwBXFOxA7kWACBVCXPMtQhKToTACOXVv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9L1KmM4fhiifOw+ShPfBtVVfHcaErxSdXNaFyWhNFynJ+fs7U
 scmdgTC/iRowCjNWveQE0ENykNzQcOuHW0UX4SLu5KejIourv0EOiOqmb4LPy/Dah+bAKiisH1T
 +6+uaDySDYiuoYhtdwhrbZZPCPSYwXQ==
X-Gm-Gg: ASbGncsQqJH0001QUDSQz57w3sZHrc8cIeljYNby4/BgX8tHlKh/KzmFxlPLguF/1RW
 6Be7n9FGVkShxYIOqTVd5Ln30pTgF5A8XkSHsFnMipXJZo1Xx+uX8aT/SZcj/SPzo8x7akzjOBV
 UkPd5Sb4ZSCbkLw0rgMcS8cg==
X-Google-Smtp-Source: AGHT+IFdjRP3OPS+EVqEQbwJG690tZmBlxUhI5RKwDguppl+GJI8ixu+RAuqayU0/Spmrc8RXPzLuH76hWurIHVJQx8=
X-Received: by 2002:a17:90b:4a4d:b0:305:5f25:59ad with SMTP id
 98e67ed59e1d1-3082379fc4cmr1912843a91.7.1744390358055; Fri, 11 Apr 2025
 09:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-8-alexander.deucher@amd.com>
 <837e1e3c-cbce-4d55-aa47-b6a35fdc104f@amd.com>
In-Reply-To: <837e1e3c-cbce-4d55-aa47-b6a35fdc104f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 12:52:25 -0400
X-Gm-Features: ATxdqUHS-Zfkt5YSC1HOqP8axMlef_v8BjoPFSdwtT5Y0nMsG2upjgYDbRAa6LY
Message-ID: <CADnq5_PTJTv9H5hwMEnBFAq68o-qKEqFiDdT6WbjbMCZMJKQcg@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/amdgpu/userq: add helpers to start/stop scheduling
To: "Khatri, Sunil" <sukhatri@amd.com>
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

On Fri, Apr 11, 2025 at 12:17=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> w=
rote:
>
>
> On 4/11/2025 7:42 PM, Alex Deucher wrote:
> > This will be used to stop/start user queue scheduling for
> > example when switching between kernel and user queues when
> > enforce isolation is enabled.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 68 ++++++++++++++++--=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
> >   3 files changed, 64 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index b156e31ac86ac..30c485f529d17 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1249,6 +1249,7 @@ struct amdgpu_device {
> >
> >       struct list_head                userq_mgr_list;
> >       struct mutex                    userq_mutex;
> > +     bool                            userq_halt;
> >   };
> >
> >   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *=
adev,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userqueue.c
> > index aa7222137c31d..e93e390f4e301 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > @@ -335,6 +335,7 @@ amdgpu_userqueue_create(struct drm_file *filp, unio=
n drm_amdgpu_userq *args)
> >               goto unlock;
> >       }
> >
> > +
> >       qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_=
COUNT, GFP_KERNEL);
> >       if (qid < 0) {
> >               DRM_ERROR("Failed to allocate a queue id\n");
> > @@ -345,15 +346,21 @@ amdgpu_userqueue_create(struct drm_file *filp, un=
ion drm_amdgpu_userq *args)
> >               goto unlock;
> >       }
> >
> > -     r =3D uq_funcs->map(uq_mgr, queue);
> > -     if (r) {
> > -             DRM_ERROR("Failed to map Queue\n");
> > -             idr_remove(&uq_mgr->userq_idr, qid);
> > -             amdgpu_userq_fence_driver_free(queue);
> > -             uq_funcs->mqd_destroy(uq_mgr, queue);
> > -             kfree(queue);
> > -             goto unlock;
> > +     /* don't map the queue if scheduling is halted */
> > +     mutex_lock(&adev->userq_mutex);
> > +     if (!adev->userq_halt) {
> > +             r =3D uq_funcs->map(uq_mgr, queue);
> > +             if (r) {
> > +                     DRM_ERROR("Failed to map Queue\n");
> > +                     mutex_unlock(&adev->userq_mutex);
> > +                     idr_remove(&uq_mgr->userq_idr, qid);
> > +                     amdgpu_userq_fence_driver_free(queue);
> > +                     uq_funcs->mqd_destroy(uq_mgr, queue);
> > +                     kfree(queue);
> > +                     goto unlock;
> > +             }
> >       }
> > +     mutex_unlock(&adev->userq_mutex);
> >
> >       args->out.queue_id =3D qid;
> >
> > @@ -720,3 +727,48 @@ int amdgpu_userq_resume(struct amdgpu_device *adev=
)
> >       mutex_unlock(&adev->userq_mutex);
> >       return ret;
> >   }
> > +
> > +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
> Did i miss something of the param "idx" isnt being used in this function
> ? Same is applicable for start shed .

It's only applicable for chips with multiple XCDs,  gfx11 and 12 are
only single XCDs so it's unused for now.

Alex

> Regards
> Sunil
> > +{
> > +     const struct amdgpu_userq_funcs *userq_funcs;
> > +     struct amdgpu_usermode_queue *queue;
> > +     struct amdgpu_userq_mgr *uqm, *tmp;
> > +     int queue_id;
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&adev->userq_mutex);
> > +     if (adev->userq_halt)
> > +             dev_warn(adev->dev, "userq scheduling already stopped!\n"=
);
> > +     adev->userq_halt =3D true;
> > +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> > +             cancel_delayed_work_sync(&uqm->resume_work);
> > +             idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> > +                     userq_funcs =3D adev->userq_funcs[queue->queue_ty=
pe];
> > +                     ret |=3D userq_funcs->unmap(uqm, queue);
> > +             }
> > +     }
> > +     mutex_unlock(&adev->userq_mutex);
> > +     return ret;
> > +}
> > +
> > +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
> > +{
> > +     const struct amdgpu_userq_funcs *userq_funcs;
> > +     struct amdgpu_usermode_queue *queue;
> > +     struct amdgpu_userq_mgr *uqm, *tmp;
> > +     int queue_id;
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&adev->userq_mutex);
> > +     if (!adev->userq_halt)
> > +             dev_warn(adev->dev, "userq scheduling already started!\n"=
);
> > +     adev->userq_halt =3D false;
> > +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> > +             idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> > +                     userq_funcs =3D adev->userq_funcs[queue->queue_ty=
pe];
> > +                     ret |=3D userq_funcs->map(uqm, queue);
> > +             }
> > +     }
> > +     mutex_unlock(&adev->userq_mutex);
> > +     return ret;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userqueue.h
> > index 381b9c6f0573d..fd0542f60433b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> > @@ -114,4 +114,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct=
 amdgpu_userq_mgr *uq_mgr,
> >   int amdgpu_userq_suspend(struct amdgpu_device *adev);
> >   int amdgpu_userq_resume(struct amdgpu_device *adev);
> >
> > +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
> > +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
> > +
> >   #endif

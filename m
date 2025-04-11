Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033ECC369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC5810EC48;
	Fri, 11 Apr 2025 17:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OL+255BU";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564C510EC48
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:43:51 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-af9b16eca8eso199310a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 10:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744393431; x=1744998231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvCETWupT4L+rkTuwdk0wB05wBbSIITK6YD4j9eVLEU=;
 b=OL+255BU1hCKhuWiFsx73n3IroIgLnQMFcaGhwS5EZEl30339mPdhyZz6Cbxo71eGQ
 Ot9e+E/32NWwwrQ2VnP/N9GEdokh0G7tNFNz4ArVvQ5OAldy3P+mw1up0USp6SEIF0jg
 1SqGIld1RIsL9MOk8NNmtc1kuXRDp2PMJH9N57fQmywgOfLbTX5/1qM3kHv7MZHWBUEQ
 4gXFp9JoNR0oVkG/PQqj4NXqII41L/5+MibdS23VcISX+At7m5cDybSsux5vlbcj/j4z
 tx609loZ1sVtr/DlK5DTpbPFqmqfE4zeyQ1UKERyefpf04QiDNmX4jHp8bCj2zx5HpQT
 spNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744393431; x=1744998231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvCETWupT4L+rkTuwdk0wB05wBbSIITK6YD4j9eVLEU=;
 b=c5pkCjRQbK1QIrULj9nEL9ZEZN8PvNfRTcIgM/BUVaHyp8Yj2upOn/mOQHbvmgVqzN
 2QFri5VXAqokkkwJBIeafnaMwykcREKBCZ6tOYReci1wr9N8ItoXEdLdpQQcD0YvJRqa
 E7wDxk1dZgj6rUHW9qdLFRQydjK++Q2fwhKoGK/S3E7GCkoy5NyOJsuVlTqkKVOseG/3
 YZ62pIInh97gi6MParPTJl01DRAda6JSnApaYP0iAFvKSLya8Zfj5mNzCa+FQm33sbNS
 +TaosAxKndhocWnY9vT1SqslTUu8hyBBU+jcimrPczuVzp89/ko/FqBPN9hqSPzk+L04
 aTpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN42K9lsFYVhA7shIZXQ0EUn/kDIm/duhfwcCQzxTAB1k5Ty0+4RkbDdeQaIJTIrUQ2LsbDcP0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmZfSoScnk3R0aYb++ULQzKNdaTwdhbhISVbVRofR9nifQyhvI
 KLTed5K6bhi7cftEFQMxkUEPIoWwJ7HFCoNrDM69bf1ahEiyW+63EmwfFU8RSgf9qH4TRqSmxsK
 Menn7rCgQ+OLsc+pDTWbXg0Mmasw=
X-Gm-Gg: ASbGncuusMdsoHC0+Xiu9j1Yo7Y0Ujxy5xfT4U4ErwpUh93rhxFHg6W/v2C7tDTMJgi
 0PACeNc/elmWguP8BrQqafar6olHsyWc9jfrrMnyeo6+di5doFSbH3Yb+ia5DP0fSJZB3rXcieH
 9bKqW2SRE80VwP9BLDw1Ei8Q==
X-Google-Smtp-Source: AGHT+IFgM+ffNonKWAQZxuaBGhktOkEX8/G3BYKvstJl3ash7pDbrLqDMGo0jcYEIuHcw2b6w7Uenq9/KsoRUxgWGT0=
X-Received: by 2002:a17:90b:4ac9:b0:305:5f2c:c580 with SMTP id
 98e67ed59e1d1-308272536dcmr1538684a91.2.1744393430603; Fri, 11 Apr 2025
 10:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-8-alexander.deucher@amd.com>
 <837e1e3c-cbce-4d55-aa47-b6a35fdc104f@amd.com>
 <CADnq5_PTJTv9H5hwMEnBFAq68o-qKEqFiDdT6WbjbMCZMJKQcg@mail.gmail.com>
 <7031b353-22ee-4784-a7d4-ce224e9423d5@amd.com>
In-Reply-To: <7031b353-22ee-4784-a7d4-ce224e9423d5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 13:43:39 -0400
X-Gm-Features: ATxdqUFo2qxXbodr514BajDqpXQY88gJslQpq_sJwD_PL60b4hLRQuLNbBWWPP8
Message-ID: <CADnq5_Oiy8xp0FfFEjwKRKtcWReZd0YGnOovdumA0Pc4O=ihEQ@mail.gmail.com>
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

On Fri, Apr 11, 2025 at 1:26=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 4/11/2025 10:22 PM, Alex Deucher wrote:
> > On Fri, Apr 11, 2025 at 12:17=E2=80=AFPM Khatri, Sunil <sukhatri@amd.co=
m> wrote:
> >>
> >> On 4/11/2025 7:42 PM, Alex Deucher wrote:
> >>> This will be used to stop/start user queue scheduling for
> >>> example when switching between kernel and user queues when
> >>> enforce isolation is enabled.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 68 +++++++++++++++=
+---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
> >>>    3 files changed, 64 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu.h
> >>> index b156e31ac86ac..30c485f529d17 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> @@ -1249,6 +1249,7 @@ struct amdgpu_device {
> >>>
> >>>        struct list_head                userq_mgr_list;
> >>>        struct mutex                    userq_mutex;
> >>> +     bool                            userq_halt;
> >>>    };
> >>>
> >>>    static inline uint32_t amdgpu_ip_version(const struct amdgpu_devic=
e *adev,
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>> index aa7222137c31d..e93e390f4e301 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>> @@ -335,6 +335,7 @@ amdgpu_userqueue_create(struct drm_file *filp, un=
ion drm_amdgpu_userq *args)
> >>>                goto unlock;
> >>>        }
> >>>
> >>> +
> >>>        qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USE=
RQ_COUNT, GFP_KERNEL);
> >>>        if (qid < 0) {
> >>>                DRM_ERROR("Failed to allocate a queue id\n");
> >>> @@ -345,15 +346,21 @@ amdgpu_userqueue_create(struct drm_file *filp, =
union drm_amdgpu_userq *args)
> >>>                goto unlock;
> >>>        }
> >>>
> >>> -     r =3D uq_funcs->map(uq_mgr, queue);
> >>> -     if (r) {
> >>> -             DRM_ERROR("Failed to map Queue\n");
> >>> -             idr_remove(&uq_mgr->userq_idr, qid);
> >>> -             amdgpu_userq_fence_driver_free(queue);
> >>> -             uq_funcs->mqd_destroy(uq_mgr, queue);
> >>> -             kfree(queue);
> >>> -             goto unlock;
> >>> +     /* don't map the queue if scheduling is halted */
> >>> +     mutex_lock(&adev->userq_mutex);
> >>> +     if (!adev->userq_halt) {
> >>> +             r =3D uq_funcs->map(uq_mgr, queue);
> >>> +             if (r) {
> >>> +                     DRM_ERROR("Failed to map Queue\n");
> >>> +                     mutex_unlock(&adev->userq_mutex);
> >>> +                     idr_remove(&uq_mgr->userq_idr, qid);
> >>> +                     amdgpu_userq_fence_driver_free(queue);
> >>> +                     uq_funcs->mqd_destroy(uq_mgr, queue);
> >>> +                     kfree(queue);
> >>> +                     goto unlock;
> >>> +             }
> >>>        }
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>>
> >>>        args->out.queue_id =3D qid;
> >>>
> >>> @@ -720,3 +727,48 @@ int amdgpu_userq_resume(struct amdgpu_device *ad=
ev)
> >>>        mutex_unlock(&adev->userq_mutex);
> >>>        return ret;
> >>>    }
> >>> +
> >>> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
> >> Did i miss something of the param "idx" isnt being used in this functi=
on
> >> ? Same is applicable for start shed .
> > It's only applicable for chips with multiple XCDs,  gfx11 and 12 are
> > only single XCDs so it's unused for now.
> >
> > I dont see a way to handle multiple XCDs with this function and might n=
eed redesign. I am assuming that with an IP with multiple XCDs we will have=
 multiple MES hw too and we need to choose which MES unmap we have to call =
isnt it?  Also unused variable might be a warning too.
> >
> > So you want to use idx later when we have a target which needed that su=
pport and till then keep a version without idx ?? Anyways it looks function=
ally working Reviewed-by:
> > Sunil Khatri <sunil.khatri@amd.com>
> >
> > But some explanation in commit message for idx or may be just here is g=
ood to have.

The KFD equivalent of this function uses the idx because it supports
MI parts which have multiple XCDs. We already track the xcd idx
throughout the rest of the stack.  I'll add the idx handling for
userqs and respin the patch with that included.

Alex

> >
> > Regards
> > Sunil Khatri
> >
> > Alex
> >
> >> Regards
> >> Sunil
> >>> +{
> >>> +     const struct amdgpu_userq_funcs *userq_funcs;
> >>> +     struct amdgpu_usermode_queue *queue;
> >>> +     struct amdgpu_userq_mgr *uqm, *tmp;
> >>> +     int queue_id;
> >>> +     int ret =3D 0;
> >>> +
> >>> +     mutex_lock(&adev->userq_mutex);
> >>> +     if (adev->userq_halt)
> >>> +             dev_warn(adev->dev, "userq scheduling already stopped!\=
n");
> >>> +     adev->userq_halt =3D true;
> >>> +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >>> +             cancel_delayed_work_sync(&uqm->resume_work);
> >>> +             idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >>> +                     userq_funcs =3D adev->userq_funcs[queue->queue_=
type];
> >>> +                     ret |=3D userq_funcs->unmap(uqm, queue);
> >>> +             }
> >>> +     }
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
> >>> +{
> >>> +     const struct amdgpu_userq_funcs *userq_funcs;
> >>> +     struct amdgpu_usermode_queue *queue;
> >>> +     struct amdgpu_userq_mgr *uqm, *tmp;
> >>> +     int queue_id;
> >>> +     int ret =3D 0;
> >>> +
> >>> +     mutex_lock(&adev->userq_mutex);
> >>> +     if (!adev->userq_halt)
> >>> +             dev_warn(adev->dev, "userq scheduling already started!\=
n");
> >>> +     adev->userq_halt =3D false;
> >>> +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >>> +             idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >>> +                     userq_funcs =3D adev->userq_funcs[queue->queue_=
type];
> >>> +                     ret |=3D userq_funcs->map(uqm, queue);
> >>> +             }
> >>> +     }
> >>> +     mutex_unlock(&adev->userq_mutex);
> >>> +     return ret;
> >>> +}
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> >>> index 381b9c6f0573d..fd0542f60433b 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> >>> @@ -114,4 +114,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(stru=
ct amdgpu_userq_mgr *uq_mgr,
> >>>    int amdgpu_userq_suspend(struct amdgpu_device *adev);
> >>>    int amdgpu_userq_resume(struct amdgpu_device *adev);
> >>>
> >>> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
> >>> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
> >>> +
> >>>    #endif

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22752C369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0A310E083;
	Fri, 11 Apr 2025 17:50:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XD/+pNyR";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC5810E083
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:50:21 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2241c95619eso4206775ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744393821; x=1744998621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1vzUN/fRTgXrYyrCoFwAtKdtPvR3wPDtAkGqYABgKE=;
 b=XD/+pNyRaQgzjqgiDBKzpOYCwsOdSyWmJDDAvaGkYt9Bi1q7k52ko2J1UnZ/PjHvxt
 bXzTqvbw1iJOJXgxPgCSbYYhYaqCQzkmOgGB2XS1FDBTlMplzPD1iz0fDuTYFSko4Dv+
 aqZTfmoNXeNjXjpIF29p5E9eXXGYk5WHK7SODzs/kIaYVRBLiq3G2P9jH+yx/j4xO9ur
 WHbVIzJDTP9iaaMKQxRX42Ohb0kG2e+GiVjI0rRHeP/V/950xs+rwiaVfIJPYB+galjZ
 mqBWYlDP4FvCW2l/+WzmzJ4dXFmHxH0AO1txjwfhrzc6/+F0uJbLHGv6gChqypoYm1WZ
 PtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744393821; x=1744998621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1vzUN/fRTgXrYyrCoFwAtKdtPvR3wPDtAkGqYABgKE=;
 b=Dp2DwdpGDWWv1BG4fbpmef91xB5zDA9hNv1H9xV59BhAbgrhD4hI+1srBmwDey4ePj
 4MhosoN45IgktS2QaxjKx93H6Y6/G6NemK5SwagPKMXADKMp06UDCi7W5DipYwYz4ghG
 u/o5KB9I/9F2+X5bnP+FwtD/pYHspdQMggK8FZ8evg2C81X27sljAwe6XJ/xuQTT3IyA
 Tl8Mj/zZsrLqR4JE51s3mAfcN5sYz1DZBOKZPHLXrCk87+BOVjblIsetVV8+7Pvbz7vt
 AZ2mpTPOQf4uZle7LbnGr9V+zbM+wnarribxnDuXtA6X8lRUIK0x9ZFfzsisi4U5vKNk
 Y+9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAw9K6QGeSFRRpSll/22XEXxkhzplZMMnEWP+woKD0yNKn74BheJO8BO9HdM+7lAW90E5jz5yn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmnWWroNTFrjdKIrGyuNUW2djcfOZo1bK7hr2wSvVKxT7Oo/7V
 z2qXpy9IUfzMDJ0pBnHiuvCNiKgFDoOqvu8CTLnRwONVOhmFvn6HfFuGV+MY2RfjX+v5KrR7CbE
 3JvPSsGEOHNjiX+2TInszm2z0vHE=
X-Gm-Gg: ASbGncv0TCr+8PNfStZDLWDAOb4/XXGagl9Gfm9w6Dk3zfsq9QmGU67LbMFp0yrq7ca
 PfrGg62z/dStsUtDZzpVm1DQOS0ZQqmKAtt+eU7sAI4vTdh4fHS/o0BLWSvNOisgLB0f4SVx8hA
 vbVapfOgRljmhXZTMktAG+89pQsfaJFCR/
X-Google-Smtp-Source: AGHT+IFYpjElriO+Lpf34VCwX52fUb0FuZwmcJF4lw/KnUUd5hMnFoS9TWpgLW4yjUZtyVSeW6l5ospDvJSHvR7fFzI=
X-Received: by 2002:a17:902:cec7:b0:215:a96d:ec36 with SMTP id
 d9443c01a7336-22bea4b3c13mr19785375ad.5.1744393820650; Fri, 11 Apr 2025
 10:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
 <20250410181138.2287932-9-alexander.deucher@amd.com>
 <83f7155a-7ca2-4feb-a6ca-b59be96fe644@amd.com>
In-Reply-To: <83f7155a-7ca2-4feb-a6ca-b59be96fe644@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 13:50:08 -0400
X-Gm-Features: ATxdqUEwm4ONAULkzwY9LaUpsQUpfvPrycYiyFFQK01bhyArjY1pfEoPDCLu6No
Message-ID: <CADnq5_MZY+Ff0iEk=o6ryu7TxzmWFcCPCdMCopA=VNrmKFd_uQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amdgpu/userq: integrate with enforce isolation
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

On Fri, Apr 11, 2025 at 12:38=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> w=
rote:
>
> Are we replacing the kfx user queue with KGD userqueue names here?
> Also this looks like KFD user queue and KGD userqueue are both treated
> at par ?

Yeah, I could split this into two patches, one to rename the variables
because they are no longer KFD specific and then the change to add the
new function calls for userqs.

Alex

>
> Looks good in general if the above understanding is correct. Some one
> with better understanding of isolation should review.
> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
>
> On 4/10/2025 11:41 PM, Alex Deucher wrote:
> > Enforce isolation serializes access to the GFX IP.  User
> > queues are isolated in the MES scheduler, but we still
> > need to serialize between kernel queues and user queues.
> > For enforce isolation, group KGD user queues with KFD user
> > queues.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 34 ++++++++++++---------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  6 ++--
> >   3 files changed, 22 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 4e1c97a919cec..3c6679fce7c20 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4344,7 +4344,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >               amdgpu_sync_create(&adev->isolation[i].active);
> >               amdgpu_sync_create(&adev->isolation[i].prev);
> >       }
> > -     mutex_init(&adev->gfx.kfd_sch_mutex);
> > +     mutex_init(&adev->gfx.userq_sch_mutex);
> >       mutex_init(&adev->gfx.workload_profile_mutex);
> >       mutex_init(&adev->vcn.workload_profile_mutex);
> >       mutex_init(&adev->userq_mutex);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index a42ac1060fa92..e08323f601535 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -1928,39 +1928,41 @@ void amdgpu_gfx_cleaner_shader_init(struct amdg=
pu_device *adev,
> >   static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 i=
dx,
> >                                   bool enable)
> >   {
> > -     mutex_lock(&adev->gfx.kfd_sch_mutex);
> > +     mutex_lock(&adev->gfx.userq_sch_mutex);
> >
> >       if (enable) {
> >               /* If the count is already 0, it means there's an imbalan=
ce bug somewhere.
> >                * Note that the bug may be in a different caller than th=
e one which triggers the
> >                * WARN_ON_ONCE.
> >                */
> > -             if (WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx] =3D=3D =
0)) {
> > +             if (WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx] =3D=
=3D 0)) {
> >                       dev_err(adev->dev, "Attempted to enable KFD sched=
uler when reference count is already zero\n");
> >                       goto unlock;
> >               }
> >
> > -             adev->gfx.kfd_sch_req_count[idx]--;
> > +             adev->gfx.userq_sch_req_count[idx]--;
> >
> > -             if (adev->gfx.kfd_sch_req_count[idx] =3D=3D 0 &&
> > -                 adev->gfx.kfd_sch_inactive[idx]) {
> > +             if (adev->gfx.userq_sch_req_count[idx] =3D=3D 0 &&
> > +                 adev->gfx.userq_sch_inactive[idx]) {
> >                       schedule_delayed_work(&adev->gfx.enforce_isolatio=
n[idx].work,
> >                                             msecs_to_jiffies(adev->gfx.=
enforce_isolation_time[idx]));
> >               }
> >       } else {
> > -             if (adev->gfx.kfd_sch_req_count[idx] =3D=3D 0) {
> > +             if (adev->gfx.userq_sch_req_count[idx] =3D=3D 0) {
> >                       cancel_delayed_work_sync(&adev->gfx.enforce_isola=
tion[idx].work);
> > -                     if (!adev->gfx.kfd_sch_inactive[idx]) {
> > -                             amdgpu_amdkfd_stop_sched(adev, idx);
> > -                             adev->gfx.kfd_sch_inactive[idx] =3D true;
> > +                     if (!adev->gfx.userq_sch_inactive[idx]) {
> > +                             amdgpu_userq_stop_sched(adev, idx);
> > +                             if (adev->kfd.init_complete)
> > +                                     amdgpu_amdkfd_stop_sched(adev, id=
x);
> > +                             adev->gfx.userq_sch_inactive[idx] =3D tru=
e;
> >                       }
> >               }
> >
> > -             adev->gfx.kfd_sch_req_count[idx]++;
> > +             adev->gfx.userq_sch_req_count[idx]++;
> >       }
> >
> >   unlock:
> > -     mutex_unlock(&adev->gfx.kfd_sch_mutex);
> > +     mutex_unlock(&adev->gfx.userq_sch_mutex);
> >   }
> >
> >   /**
> > @@ -2005,12 +2007,12 @@ void amdgpu_gfx_enforce_isolation_handler(struc=
t work_struct *work)
> >                                     msecs_to_jiffies(1));
> >       } else {
> >               /* Tell KFD to resume the runqueue */
> > -             if (adev->kfd.init_complete) {
> > -                     WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
> > -                     WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
> > +             WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
> > +             WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> > +             amdgpu_userq_start_sched(adev, idx);
> > +             if (adev->kfd.init_complete)
> >                       amdgpu_amdkfd_start_sched(adev, idx);
> > -                     adev->gfx.kfd_sch_inactive[idx] =3D false;
> > -             }
> > +             adev->gfx.userq_sch_inactive[idx] =3D false;
> >       }
> >       mutex_unlock(&adev->enforce_isolation_mutex);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index caaddab31023f..70b64bb1847c9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -475,9 +475,9 @@ struct amdgpu_gfx {
> >       bool                            enable_cleaner_shader;
> >       struct amdgpu_isolation_work    enforce_isolation[MAX_XCP];
> >       /* Mutex for synchronizing KFD scheduler operations */
> > -     struct mutex                    kfd_sch_mutex;
> > -     u64                             kfd_sch_req_count[MAX_XCP];
> > -     bool                            kfd_sch_inactive[MAX_XCP];
> > +     struct mutex                    userq_sch_mutex;
> > +     u64                             userq_sch_req_count[MAX_XCP];
> > +     bool                            userq_sch_inactive[MAX_XCP];
> >       unsigned long                   enforce_isolation_jiffies[MAX_XCP=
];
> >       unsigned long                   enforce_isolation_time[MAX_XCP];
> >

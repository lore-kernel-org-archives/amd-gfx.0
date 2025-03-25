Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0542CC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 15:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2C510E591;
	Tue, 25 Mar 2025 15:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q9klyJHP";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D281810E591
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 15:34:47 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so1509260a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742916887; x=1743521687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRh4DPA/zMy0YV/n/GtNyfXmXCzSazeEJWj6zkugpIk=;
 b=Q9klyJHP7GOGCic+9NL8nJcEramLvIjCyad3lAwcG/lEG24yJd0Ip50NlCewuw/t+C
 ekE8kxJ9oyZioChKzvzBkDO+gA7vfK+SZh7vLZs+qzn171AwGPjX/W8FIiEeFSyMDbUV
 wxc5hZfyEnugYKEHhh2c9FScFjMWWaCkgClwQbOb5w/kLVWdGSUrwLw13Mpc5ANYGnOK
 bNzSCxkM9qfefvzYNk3LO6E2fEgZJD5jr7sSQmtuGFM+MyDSttGUc8t6xB/bLruGOXX9
 XyN3LxgIMGVcuqEBuuWYRkrsDkZ6VCceH32x+bDp/7vM3JhXJOit3CObs5Mtj10IhdI0
 Qt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742916887; x=1743521687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRh4DPA/zMy0YV/n/GtNyfXmXCzSazeEJWj6zkugpIk=;
 b=qy+/jhwZtxYtYZwSMGbfTEOUNgEnsqF0uB+t5BJ5x6deWBFFPYffY+iaXB1BETdRve
 uoyDJlOKyc7UMk5uor7eH9se4GkbLTKIa42/mwTHiNshBOFFENCdbey0oAzBdzgulJTF
 HPOxviseMVxvDyqmzJ56kjPBjDV71Gn7BbouEd1na6zB74suyAKGNtKQvKmeJMOrcxcF
 WCV/cmD0sA3h/SO0WPlPEDwSpx7dXimBW4VycjF2ylzrc3gr3g5k6BnMY1VdYoR3lj3Q
 1K3Rf/8TPBr+rf5h2T6RYZHLU/KTXvo65IgxOwrH0f/ZEFgmRncwqizAoLuYOYsKRM+h
 pgcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjndM0HHoxXyZ6CiqiHV7xLQ+aqV1VlhoHLAocI8sPHSaU070YYrJgBMR4hTznmgPsGaNNxgqf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSNcLzAtbERu0VwlTzNzVz1NXci5IXdSb08RTRUMYLFDeUfX06
 rN0tsSePEs/nQeSzyEgZM2wfpxCrlLn6+n2ol4oLAqlYlfmcDB94i1xrK0T3UCfo4pSvStxWQ5/
 VooFg3dO2IjiXGj7pd07fkXvwjnk7/Q==
X-Gm-Gg: ASbGncvE/A6qdqGjxB1h5thlJYdHTkqEb7ds9NFhGEQIbR718YTcpSQmPmAbNsfWrpP
 roAJh6v6EApT9TlSGzYTCoi76NR664FiNtpeSk4KIewEQDcxKhisJOK6DlPXCMk83Cx3lmS1Oas
 1FbJJ8UhKAW+7QD7pJFqIWZuzo9w==
X-Google-Smtp-Source: AGHT+IH1RZ6ck3AZ967KQxK/nkaCJZaH+fRoALHawzD72qLvqWCxmLppQ5A1ypBYXO30TdBEXr94vKOTj/bFdo8wL0Y=
X-Received: by 2002:a17:90b:3a8d:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3036b4abf73mr2118616a91.5.1742916887049; Tue, 25 Mar 2025
 08:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250320165249.1238463-1-alexander.deucher@amd.com>
 <DS7PR12MB600558F9AE6AFA491D593C2CFBA72@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600558F9AE6AFA491D593C2CFBA72@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Mar 2025 11:34:35 -0400
X-Gm-Features: AQ5f1Jq2OljvaySqc2K-xWA4L7UlANMQZHpqEJKnao50HNeSzmO8wERq3f310yE
Message-ID: <CADnq5_PRU6_+qkc9v90hrEoJQ=r6wmeQ=Z=jueRh5Z-3cCRi_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: store userq_managers in a list in adev
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
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

On Tue, Mar 25, 2025 at 4:23=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> Here it may need to test the uq_mgr list to see whether it is a fresh lis=
t before adding it to the userq_mgr_list; otherwise, it may add a duplicate=
d uq_mgr list. I have sent a patch for that check.

Good catch.  We should just add the mgr once in userq_mgr_init.  Will
send out a new patch set.

Alex


>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Friday, March 21, 2025 12:53 AM
> > To: amd-gfx@lists.freedesktop.org; Paneer Selvam, Arunpravin
> > <Arunpravin.PaneerSelvam@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: store userq_managers in a list in adev
> >
> > So we can iterate across them when we need to manage all user queues.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 15 ++++++++++++++-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  1 +
> >  4 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 4f770a362048a..28cfa600b798f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1228,6 +1228,9 @@ struct amdgpu_device {
> >        * in KFD: VRAM or GTT.
> >        */
> >       bool                            apu_prefer_gtt;
> > +
> > +     struct list_head                userq_mgr_list;
> > +     struct mutex                    userq_mutex;
> >  };
> >
> >  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *a=
dev, diff --
> > git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 0396ac30c2a4f..526c5aa32825a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4299,6 +4299,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >       mutex_init(&adev->gfx.kfd_sch_mutex);
> >       mutex_init(&adev->gfx.workload_profile_mutex);
> >       mutex_init(&adev->vcn.workload_profile_mutex);
> > +     mutex_init(&adev->userq_mutex);
> >
> >       amdgpu_device_init_apu_flags(adev);
> >
> > @@ -4326,6 +4327,8 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >
> >       INIT_LIST_HEAD(&adev->pm.od_kobj_list);
> >
> > +     INIT_LIST_HEAD(&adev->userq_mgr_list);
> > +
> >       INIT_DELAYED_WORK(&adev->delayed_init_work,
> >                         amdgpu_device_delayed_init_work_handler);
> >       INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > index a02614cbda36e..b89bfad52abd5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > @@ -365,6 +365,9 @@ amdgpu_userqueue_create(struct drm_file *filp, unio=
n
> > drm_amdgpu_userq *args)
> >               goto unlock;
> >       }
> >       args->out.queue_id =3D qid;
> > +     mutex_lock(&adev->userq_mutex);
> > +     list_add(&uq_mgr->list, &adev->userq_mgr_list);
> > +     mutex_unlock(&adev->userq_mutex);
> >
> >  unlock:
> >       mutex_unlock(&uq_mgr->userq_mutex);
> > @@ -661,14 +664,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr
> > *userq_mgr, struct amdgpu_devi
> >
> >  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)  {
> > -     uint32_t queue_id;
> > +     struct amdgpu_device *adev =3D userq_mgr->adev;
> >       struct amdgpu_usermode_queue *queue;
> > +     struct amdgpu_userq_mgr *uqm, *tmp;
> > +     uint32_t queue_id;
> >
> >       cancel_delayed_work(&userq_mgr->resume_work);
> >
> >       mutex_lock(&userq_mgr->userq_mutex);
> >       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
> >               amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
> > +     mutex_lock(&adev->userq_mutex);
> > +     list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> > +             if (uqm =3D=3D userq_mgr) {
> > +                     list_del(&uqm->list);
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&adev->userq_mutex);
> >       idr_destroy(&userq_mgr->userq_idr);
> >       mutex_unlock(&userq_mgr->userq_mutex);
> >       mutex_destroy(&userq_mgr->userq_mutex);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> > index 0f358f77f2d9b..ec1a4ca6f6321 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> > @@ -76,6 +76,7 @@ struct amdgpu_userq_mgr {
> >       struct mutex                    userq_mutex;
> >       struct amdgpu_device            *adev;
> >       struct delayed_work             resume_work;
> > +     struct list_head                list;
> >  };
> >
> >  struct amdgpu_db_info {
> > --
> > 2.49.0
>

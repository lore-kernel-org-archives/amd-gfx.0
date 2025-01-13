Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FADC02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 16:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C856910E726;
	Mon, 13 Jan 2025 16:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RPt+Tue0";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441A310E731
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 16:55:23 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2f2f5e91393so991325a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736787263; x=1737392063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1T5aywAiH7ptt7VdlA4aHoOt/53ne29fLPVJVqCrh0=;
 b=RPt+Tue0a29+SVQ1gW/vdbyAYjCfWiOJY8u/aPwO9iC986FXvm0Dq85wkN4N1cKkCT
 74uav3jK6TdU2vdJvaaQ/LT+Jw+5CDD1qwT4mM4bwjL/3cRUoDI6Mn8q2ULSw7oepThk
 bGVkRWETCIEhi+IL6jv5iLT1rvZqHxfblOdH8DoyeQrXRnbrcGZS9m2LkbKYWhICCuJ3
 a0AyCK6WxmKzYKCiQHn7t/DfGYW/Fy+zRG3/XxbdWwErSXw5Emzsd+BUTFxxvyh0c54W
 Nc5kJAoYuxrRPGmESrMbIZB3q1GAE953VxTxwXq9Ei3HnesOt7EbWnrnf6zVDeU4Ve1Q
 vypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736787263; x=1737392063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1T5aywAiH7ptt7VdlA4aHoOt/53ne29fLPVJVqCrh0=;
 b=OizFwHI6g/OP5pDAduKsDuflrvRvA7xZ8lxD/JMXyXXMmYnMPJHbr7pvPuIL6QzFfq
 uLoQjl7Qmpw/cQlL5kyB4qj28q0W7XlH6RJ0mM/S+XNDc5Yo8ZaYuVewpMtR2FY1+fJk
 yBtD4wgRsUYAicPZ+y8iGQ9X8Ty9cuCyPxddGW9iYbHnzzU3h1Nf6lsSs/fAiGxQhjHE
 ThRMgBl3KTlURdeUYWzFtPHYHFNHNUJ1Qw0NeSMzcARiQtV4ji9rhYjSfA3YpnMLWYNg
 TKnGtmMdyCM74ZvmxnrGpAbmgf9iMb8i9u9b3FMn45dNAVAZreXtX6NU8PQwUdmW7HkM
 /i9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWefM60I3Dem05RCWh2yrUkfUUsXvN4ZpQpsXX2a86y19ZGh9Bp1/naEZCv+mEqJLnK935Zu+JY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyncVWO6B+g5o6Ygnlh/WuA5BzC32pMsBgPIdNBt2Mh01cXZTdV
 cPn0u+JCjnhYMlzas08gD/UtbTronqgblF0k/2guSeuS7pPrHZ9OC8Cev8SjOsMAec+3l44SEls
 wpt/OdxN+2ZsEY+UtrzlilRQ/81I=
X-Gm-Gg: ASbGncsu7fKR78ENkHlrGzjQYx59FxDv3Cy5HTHSCkGKwuU03ROEc9ZaHbpCH1jdKGP
 3gZ45yz8ki1bhh9CQfARmiNbsaCEQ1hFNDA8RAg==
X-Google-Smtp-Source: AGHT+IExc7j/Q4qoN5XrPwTBxzJpWvA6Ch7oEuA1AVObKQgMvJKMfp/8Qu1qL92+C1oKJQ94C1b6ej0kEUpzCfc9CyM=
X-Received: by 2002:a17:90a:c88c:b0:2ee:c059:7de6 with SMTP id
 98e67ed59e1d1-2f548ea2dc2mr10880757a91.2.1736787262758; Mon, 13 Jan 2025
 08:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20250108225627.14063-1-alexander.deucher@amd.com>
 <589ecdc0-9f5d-4b79-b11d-01b6d22fbf15@amd.com>
 <CADnq5_NrJ7xqkxk-ccYnQeuVRoWuN95Wyq59UVYtdRUMVVqCvw@mail.gmail.com>
 <7bf342e7-72ad-4ed0-a45d-ad933db28753@amd.com>
 <CADnq5_N_S6Cv57zAgroHJ2e7KbvmQ_8QcPHrryEtatpaAWR87w@mail.gmail.com>
 <27163712-891c-4708-96f4-90bd1b2bbf7f@amd.com>
In-Reply-To: <27163712-891c-4708-96f4-90bd1b2bbf7f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jan 2025 11:54:11 -0500
X-Gm-Features: AbW1kvZF20HgkUcBNvYj1CRKVIlzhk2erVlbqtODebiv2iLkGlMOCFAHHNVHyj0
Message-ID: <CADnq5_MhEg9T1ksaNka=ra7KhszCV1JW72bw1A-aDX7CRprkmg@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 aurabindo.pillai@amd.com, kenneth.feng@amd.com
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

On Fri, Jan 10, 2025 at 10:40=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 1/10/2025 8:33 PM, Alex Deucher wrote:
> > On Thu, Jan 9, 2025 at 10:30=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com=
> wrote:
> >>
> >>
> >>
> >> On 1/9/2025 10:36 PM, Alex Deucher wrote:
> >>> On Thu, Jan 9, 2025 at 12:59=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.c=
om> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 1/9/2025 4:26 AM, Alex Deucher wrote:
> >>>>> Add helpers to switch the workload profile dynamically when
> >>>>> commands are submitted.  This allows us to switch to
> >>>>> the FULLSCREEN3D or COMPUTE profile when work is submitted.
> >>>>> Add a delayed work handler to delay switching out of the
> >>>>> selected profile if additional work comes in.  This works
> >>>>> the same as the VIDEO profile for VCN.  This lets dynamically
> >>>>> enable workload profiles on the fly and then move back
> >>>>> to the default when there is no work.
> >>>>>
> >>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>> ---
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++=
++++
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
> >>>>>  2 files changed, 68 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_gfx.c
> >>>>> index 6d5d81f0dc4e7..c542617121393 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>>>> @@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_u=
se(struct amdgpu_ring *ring)
> >>>>>       mutex_unlock(&adev->enforce_isolation_mutex);
> >>>>>  }
> >>>>>
> >>>>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work=
)
> >>>>> +{
> >>>>> +     struct amdgpu_device *adev =3D
> >>>>> +             container_of(work, struct amdgpu_device, gfx.idle_wor=
k.work);
> >>>>> +     enum PP_SMC_POWER_PROFILE profile;
> >>>>> +     u32 i, fences =3D 0;
> >>>>> +     int r;
> >>>>> +
> >>>>> +     if (adev->gfx.num_gfx_rings)
> >>>>> +             profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> >>>>> +     else
> >>>>> +             profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> >>>>
> >>>> Since profile selection is in generic code, it makes sense to first
> >>>> check if the profile is supported for the family. Otherwise, this ne=
eds
> >>>> to be passed by the respective GFX family.
> >>>
> >>> The generic code already handles this.  If you select an unsupported
> >>> profile, it's ignored when the mask is updated.
> >>>
> >>
> >> That is strange. Does that mean user never gets an error if user
> >> attempts to set an unsupported profile?
> >
> > If you use sysfs, you can only select from the available options
> > supported by the chip so there is no way to select a non-supported
> > profile.  For the internal driver API, we just silently ignore it.
> >
> >>
> >> Another problem is this could override the user set profile now. Is th=
at
> >> intended? In the current logic, whenever user sets a profile, the
> >> current profile is removed. With this one, another profile gets added
> >> and the user preference could be ignored depending on the priority.
> >
> > Yes, I think.  For VCN we already select the video profile in a
> > similar manner and for ROCm we already select the compute profile,
> > this just extends that to gfx.  This doesn't really change the
> > behavior compared to the current state of the driver.  At the moment
> > we default to fullscreen3d on navi chips and on MI chips we always
> > enable compute when ROCm is active.  The change here is that we
> > eventually fall back to the bootup profile by default when the GPU is
> > idle.  This allows PMFW to enable additional power saving features
> > while still providing a boost when applications are running.
> >
>
> Sounds good. Only concern is if user intentionally wants to use power
> saving profile all the time. Not sure if 3D has a lower priority than tha=
t.

Yes, power save is higher priority than fullscreen 3d.

Alex

>
> That aside, series is -
>         Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> Alex
> >>>
> >>>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>> +
> >>>>> +     for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> >>>>> +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx=
_ring[i]);
> >>>>> +     for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_I=
NSTANCES); ++i)
> >>>>> +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.com=
pute_ring[i]);
> >>>>> +     if (!fences && !atomic_read(&adev->gfx.total_submission_cnt))=
 {
> >>>>> +             r =3D amdgpu_dpm_switch_power_profile(adev, profile, =
false);
> >>>>> +             if (r)
> >>>>> +                     dev_warn(adev->dev, "(%d) failed to disable %=
s power profile mode\n", r,
> >>>>> +                              profile =3D=3D PP_SMC_POWER_PROFILE_=
FULLSCREEN3D ?
> >>>>> +                              "fullscreen 3D" : "compute");
> >>>>> +     } else {
> >>>>> +             schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFI=
LE_IDLE_TIMEOUT);
> >>>>> +     }
> >>>>> +}
> >>>>> +
> >>>>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
> >>>>> +{
> >>>>> +     struct amdgpu_device *adev =3D ring->adev;
> >>>>> +     enum PP_SMC_POWER_PROFILE profile;
> >>>>> +     int r;
> >>>>> +
> >>>>> +     if (adev->gfx.num_gfx_rings)
> >>>>> +             profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> >>>>> +     else
> >>>>> +             profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> >>>>> +
> >>>>> +     atomic_inc(&adev->gfx.total_submission_cnt);
> >>>>> +
> >>>>> +     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> >>>>> +             r =3D amdgpu_dpm_switch_power_profile(adev, profile, =
true);
> >>>>> +             if (r)
> >>>>> +                     dev_warn(adev->dev, "(%d) failed to disable %=
s power profile mode\n", r,
> >>>>> +                              profile =3D=3D PP_SMC_POWER_PROFILE_=
FULLSCREEN3D ?
> >>>>> +                              "fullscreen 3D" : "compute");
> >>>>> +     }
> >>>>> +}
> >>>>> +
> >>>>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
> >>>>> +{
> >>>>> +     atomic_dec(&ring->adev->gfx.total_submission_cnt);
> >>>>> +
> >>>>> +     schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE=
_IDLE_TIMEOUT);
> >>>>> +}
> >>>>> +
> >>>>>  /*
> >>>>>   * debugfs for to enable/disable gfx job submission to specific co=
re.
> >>>>>   */
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_gfx.h
> >>>>> index 7f9e261f47f11..6c84598caec21 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>> @@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {
> >>>>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
> >>>>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> >>>>>
> >>>>> +/* 1 second timeout */
> >>>>> +#define GFX_PROFILE_IDLE_TIMEOUT     msecs_to_jiffies(1000)
> >>>>> +
> >>>>>  enum amdgpu_gfx_partition {
> >>>>>       AMDGPU_SPX_PARTITION_MODE =3D 0,
> >>>>>       AMDGPU_DPX_PARTITION_MODE =3D 1,
> >>>>> @@ -477,6 +480,9 @@ struct amdgpu_gfx {
> >>>>>       bool                            kfd_sch_inactive[MAX_XCP];
> >>>>>       unsigned long                   enforce_isolation_jiffies[MAX=
_XCP];
> >>>>>       unsigned long                   enforce_isolation_time[MAX_XC=
P];
> >>>>> +
> >>>>> +     atomic_t                        total_submission_cnt;
> >>>>> +     struct delayed_work             idle_work;
> >>>>>  };
> >>>>>
> >>>>>  struct amdgpu_gfx_ras_reg_entry {
> >>>>> @@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amd=
gpu_device *adev,
> >>>>>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work=
);
> >>>>>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_rin=
g *ring);
> >>>>>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring =
*ring);
> >>>>> +
> >>>>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work=
);
> >>>>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
> >>>>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
> >>>>> +
> >>>>>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev=
);
> >>>>>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *=
adev);
> >>>>>
> >>>>
> >>
>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C71AC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 08:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA3310E507;
	Tue, 25 Mar 2025 08:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BV9OTUgz";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F200D89336
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:34:38 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5e6194e9d2cso8019956a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742826877; x=1743431677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owsRpyWqd3e1hv0FjS6GC7sWE+UID2AGEd7TXelf1nE=;
 b=BV9OTUgztLWSfDme9NNcJDzbTwwHGO6HHy5TP9LQttpBSLihafg/M6Sq2r6u1XIeZs
 9FGZ5HIZUEKbgJOPZVrvIW4Rl8R6SbvxEJ8VK4D6SrDg52zvLdNkixl053zlHyO5QnTf
 N1YL0Gjnsv9f1+UJrI8XklkgvkF4d6dIfuKpMbKLPRIzZCc87Wouaj1HWyRe/1j85haF
 bCOKS35kM/NcUqLKyARvD+GGwb73CCKkmDSpSVJAy+1pOnesJmyFJOeD0EavEG7Z41p9
 VZTEbtm/qpJ0vMnAG8lcli3zW4dA2Y80gDATKYlX2PSJZK5mtJ3XjLC1arWzXa2IsLl2
 s3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742826877; x=1743431677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owsRpyWqd3e1hv0FjS6GC7sWE+UID2AGEd7TXelf1nE=;
 b=RUq7u0o3MrnRo/XBBM2Mp94YE4V4UcMIIDOmprCZ5ywvHkAVfHIzLZ9vcMdNs2lj5Q
 Y8CqTA8Oi8Hdi/60WDtYyCiu7e+n6Dhas5ZH1O3GL/cYLgZ+wKkyqFo3SDYCtwGaJ7Dk
 8O1WrnqVF5ZPxLak5AHl+rt1rKBxP/ll8Anv6R3PUxx3rqxJELfoH+BK0AYxHFw0lEIK
 OKjCEe7YwLW8mObygBHldszyZKMwhqc7ykZV/CFQkigcbEppo+wNRGDKm9N7KVwfmeOY
 wtxqdduu6sPSYOFnI2dRcD9LVh5Yn5DoUxeSOWyZh1JvD4CM8uRMmaS14ZEnW84QRJi4
 G+nQ==
X-Gm-Message-State: AOJu0YzxkHc7jDDygeTqg5mPZ/GqZ9HZ9UGDYbCNxDI0s0Dshgz+3fN8
 dqn7gl9dOKJXxDXmSm1W3RSimCKiRvlPJFNlIJvRmU/KEqx41gpu9/htyzI1V49MzIu8ECqge3G
 wypVqdjtgK6KLnYTpDctkPp8Q6RE=
X-Gm-Gg: ASbGncs9+Ru2P22gp4K7bUqGno6jcqgy8Nm6PhQro9yeMn1AWjKy3T16EHob0qmCnA3
 CUHA4uvNkxI8WQUmJGmxHnFmtt1lVx5rxYYDw7KMpIZpWolaS9BheLgj7RomQh+kP2uLTenEU6B
 PXGz8R4SJUi86Xrqd3iteqwr7Oz18=
X-Google-Smtp-Source: AGHT+IGKXbwQisoyaJSMPXPGg1RN4eijzi0VcnaTq1GgBmePrd7DqyGyCwujdqbjexRe7hm/NgaaBMpcfI12PQGT+Cg=
X-Received: by 2002:a05:6402:2547:b0:5dc:7f96:6263 with SMTP id
 4fb4d7f45d1cf-5ebcd45c370mr10882628a12.15.1742826877063; Mon, 24 Mar 2025
 07:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <0b7e373b-ef2d-4243-a5a0-5ffd9d97cf74@gmail.com>
 <CADnq5_PgeZtepU-emKHQKdSh2H-kiLu4KpK0LxVgKks35NTf6w@mail.gmail.com>
In-Reply-To: <CADnq5_PgeZtepU-emKHQKdSh2H-kiLu4KpK0LxVgKks35NTf6w@mail.gmail.com>
From: Sergey Kovalenko <seryoga.engineering@gmail.com>
Date: Mon, 24 Mar 2025 16:34:26 +0200
X-Gm-Features: AQ5f1JrgVv-imutRTDZHqmp3LDztsLp5gHaAgNB9BV-aPX9oGMWeEaA-0minwxc
Message-ID: <CAAQb4tapVTvteA7b13+sLSxHVPKNUbaEtEhw_of8RqVjibgesg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add GFXOFF auto-tunning algorithm
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Mar 2025 08:21:39 +0000
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

Hello Alex!

"If there are a lot of requests to toggle gfxoff, the worker thread to
allow it again gets
cancelled and scheduled again, extending the time it's disallowed." -
That's true except one thing:
cancelling and scheduling also take CPU cycles, and the pause between
submissions can exceed
100ms interval, which leads to GFXOFF being enabled even if the GPU is load=
ed.
This simple prediction algorithm eliminates such cases.
GFXOFF is enabled immediately when there are only a few submissions
ongoing, which
means the system is idling. And when the number of compute submissions
exceeds the
range, the algorithm chooses a longer delay. Finally it simply ignores
GFXOFF ON requests
to prevent performance drops under high load.
This allows keeping idle power consumption low and using stable GPU
performance under load.

Regards,
Sergey

On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Mar 24, 2025 at 5:06=E2=80=AFAM Sergey Kovalenko
> <seryoga.engineering@gmail.com> wrote:
> >
> > Predict an optimal delay to enable GFXOFF for the next interval
> > based on the request count:
> > - less than 15 requests per second - zero delay
> > - less than 25 requests per second - default delay
> > - 25 and more requests per second - don't enable GFXOFF
> >
> > The algorithm allows maintaining low power consumption in idle,
> > as well as using the full GPU power under load by eliminating
> > hundreds of extra GFXOFF ON/OFF switches.
>
> I still don't understand what problem this is solving.  This already
> happens with the way the code works now.  If there are a lot of
> requests to toggle gfxoff, the worker thread to allow it again gets
> cancelled and scheduled again, extending the time it's disallowed.
>
> Alex
>
>
> Alex
>
> >
> > Test configuration:
> > - Ryzen 5 2500U
> > - Ryzen 5 3400G
> > - Chromium 134.0.6998.88 Arch Linux
> > - Mesa 1:24.3.4-1
> > - KDE Plasma 6.3.2
> >
> > GFXOFF enable requests per second:
> > | Test                                                | min | max |
> > |-----------------------------------------------------|-----|-----|
> > | System idle                                         |   0 |  64 |
> > | Web browsing                                        |   0 | 127 |
> > | WebGL aquarium                                      |  10 | 236 |
> > | Heavy load: glxgears + vkcube + resizing + flipping |  39 | 677 |
> >
> > Test results, Ryzen 5 2500U:
> > | Test                        | patched-6.13.7.arch1 |   6.13.7.arch1-1=
 |
> > |-----------------------------|----------------------|-----------------=
-|
> > | System idle (PkgWatt)       |               ~0.74W |          ~1.25W =
 |
> > | glxgears (vblank_mode=3D0)    |     ~7300 fps, ~7.3W | ~7300 fps, ~7.=
3W |
> > | WebGL aquarium 15.000 fish  |     56-60 fps, ~9.8W | 55-60 fps, ~9.8W=
 |
> >
> > Test results, Ryzen 5 3400G:
> > | Test                        | patched-6.13.7.arch1 |   6.13.7.arch1-1=
 |
> > |-----------------------------|----------------------|-----------------=
-|
> > | System idle (PkgWatt)       |                ~3.8W |           ~4.3W =
 |
> > | glxgears (vblank_mode=3D0)    |            ~7200 fps |        ~7200 f=
ps |
> > | WebGL aquarium 30.000 fish  |          37 fps, 47W |      38 fps, 47W=
 |
> >
> > Signed-off-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
> > Tested-by: Liam Fleming <fleming.squared@proton.me>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 94 +++++++++++++++++-------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 +
> >   2 files changed, 67 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index c1f35ded684e..5e23b956e0bf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -781,55 +781,89 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device
> > *adev, int xcc_id)
> >    * 3. other client can cancel their request of disable gfx off featur=
e
> >    * 4. other client should not send request to enable gfx off feature
> > before disable gfx off feature.
> >    */
> > -
> >   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
> >   {
> > -       unsigned long delay =3D GFX_OFF_DELAY_ENABLE;
> > -
> >         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> >                 return;
> >
> >         mutex_lock(&adev->gfx.gfx_off_mutex);
> >
> >         if (enable) {
> > -               /* If the count is already 0, it means there's an imbal=
ance bug
> > somewhere.
> > -                * Note that the bug may be in a different caller than =
the one which
> > triggers the
> > -                * WARN_ON_ONCE.
> > -                */
> > -               if (WARN_ON_ONCE(adev->gfx.gfx_off_req_count =3D=3D 0))
> > +               /* This case covers multiple calls from parallel thread=
s */
> > +               if (!adev->gfx.gfx_off_req_count)
> >                         goto unlock;
> >
> > -               adev->gfx.gfx_off_req_count--;
> > +               /* Process only if req_count =3D=3D 0 and GFXOFF is dis=
abled */
> > +               if (--adev->gfx.gfx_off_req_count || adev->gfx.gfx_off_=
state)
> > +                       goto unlock;
> > +
> > +               /* If going to s2idle, no need to wait */
> > +               if (adev->in_s0ix) {
> > +                       if (!amdgpu_dpm_set_powergating_by_smu(
> > +                                   adev, AMD_IP_BLOCK_TYPE_GFX, true, =
0))
> > +                               adev->gfx.gfx_off_state =3D true;
> > +
> > +                       /* Reset delay flag */
> > +                       adev->gfx.gfx_off_use_delay =3D 0;
> > +                       goto unlock;
> > +               }
> >
> > -               if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
> > -                   !adev->gfx.gfx_off_state) {
> > -                       /* If going to s2idle, no need to wait */
> > -                       if (adev->in_s0ix) {
> > -                               if (!amdgpu_dpm_set_powergating_by_smu(=
adev,
> > -                                               AMD_IP_BLOCK_TYPE_GFX, =
true, 0))
> > -                                       adev->gfx.gfx_off_state =3D tru=
e;
> > +               ++adev->gfx.gfx_off_counter;
> > +
> > +               uint64_t now =3D get_jiffies_64();
> > +               uint64_t delta =3D
> > +                       jiffies_to_msecs(now - adev->gfx.gfx_off_timest=
amp);
> > +
> > +               if (delta >=3D 1000u) {
> > +                       /*
> > +                        * Predict the optimal delay for the next inter=
val
> > +                        * based on the current number of requests:
> > +                        * <15 - idle, no delay
> > +                        * <25 - light/medium load, default delay
> > +                        * 25 and more - high load, GFXOFF disabled
> > +                        */
> > +                       if (adev->gfx.gfx_off_counter < 15u) {
> > +                               adev->gfx.gfx_off_use_delay =3D 0;
> > +                       } else if (adev->gfx.gfx_off_counter < 25u) {
> > +                               adev->gfx.gfx_off_use_delay =3D 1;
> >                         } else {
> > -                               schedule_delayed_work(&adev->gfx.gfx_of=
f_delay_work,
> > -                                             delay);
> > +                               adev->gfx.gfx_off_use_delay =3D 2;
> >                         }
> > +
> > +                       adev->gfx.gfx_off_counter =3D 0;
> > +                       adev->gfx.gfx_off_timestamp =3D now;
> >                 }
> > +
> > +               /* Don't schedule gfxoff under heavy load */
> > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > +                       goto unlock;
> > +
> > +               schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
> > +                                     adev->gfx.gfx_off_use_delay ?
> > +                                             GFX_OFF_DELAY_ENABLE :
> > +                                             GFX_OFF_NO_DELAY);
> >         } else {
> > -               if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> > -                       cancel_delayed_work_sync(&adev->gfx.gfx_off_del=
ay_work);
> > +               /* GFXOFF was enabled when req_count =3D=3D 0 */
> > +               if (++adev->gfx.gfx_off_req_count !=3D 1)
> > +                       goto unlock;
> >
> > -                       if (adev->gfx.gfx_off_state &&
> > -                           !amdgpu_dpm_set_powergating_by_smu(adev, AM=
D_IP_BLOCK_TYPE_GFX,
> > false, 0)) {
> > -                               adev->gfx.gfx_off_state =3D false;
> > +               /* Nothing to do if the work wasn't scheduled */
> > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > +                       goto unlock;
> >
> > -                               if (adev->gfx.funcs->init_spm_golden) {
> > -                                       dev_dbg(adev->dev,
> > -                                               "GFXOFF is disabled, re=
-init SPM golden settings\n");
> > -                                       amdgpu_gfx_init_spm_golden(adev=
);
> > -                               }
> > +               cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work)=
;
> > +
> > +               if (adev->gfx.gfx_off_state &&
> > +                   !amdgpu_dpm_set_powergating_by_smu(
> > +                           adev, AMD_IP_BLOCK_TYPE_GFX, false, 0)) {
> > +                       adev->gfx.gfx_off_state =3D false;
> > +
> > +                       if (adev->gfx.funcs->init_spm_golden) {
> > +                               dev_dbg(adev->dev,
> > +                                       "GFXOFF is disabled, re-init SP=
M golden settings\n");
> > +                               amdgpu_gfx_init_spm_golden(adev);
> >                         }
> >                 }
> > -
> > -               adev->gfx.gfx_off_req_count++;
> >         }
> >
> >   unlock:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index 8b5bd63b5773..38fd445a353b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -430,7 +430,10 @@ struct amdgpu_gfx {
> >         /* gfx off */
> >         bool                            gfx_off_state;      /* true: en=
abled,
> > false: disabled */
> >         struct mutex                    gfx_off_mutex;      /* mutex to
> > change gfxoff state */
> > +       uint64_t                        gfx_off_timestamp;  /* gfxoff e=
nable call timestamp */
> > +       uint32_t                        gfx_off_use_delay;  /* flag to =
choose the delay range */
> >         uint32_t                        gfx_off_req_count;  /* default =
1,
> > enable gfx off: dec 1, disable gfx off: add 1 */
> > +       uint32_t                        gfx_off_counter;    /* count of=
 gfxoff enable calls */
> >         struct delayed_work             gfx_off_delay_work; /* async wo=
rk to
> > set gfx block off */
> >         uint32_t                        gfx_off_residency;  /* last log=
ged
> > residency */
> >         uint64_t                        gfx_off_entrycount; /* count of=
 times
> > GPU has get into GFXOFF state */
> > --
> > 2.49.0

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58054C36010
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 08:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65AE10E511;
	Tue, 25 Mar 2025 08:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JId1yB7f";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3260310E309
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:46:39 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5e686d39ba2so8798468a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742827598; x=1743432398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oq2ReTm5hcdEEl0rwoJS/DYaRgAaNR2D5EW3hjAvQfc=;
 b=JId1yB7fjJU0h1L3t7dWzilPBRKm32uuyKyPmKuyL1cv+oOr/RKW80FM3FiKs26Lp6
 c9DuIDK3KT/4/bBjWni06+4n4mC/MV6WUJbOXOwAxb/2ErlI0f3tiPdy4Dmr8zRlceFV
 zxqwe14QgOxsdTXF3hraEpsTQN7se58Y7Wei12OYPZ+dxZVQmOjUZcz2xFlkI5skWT22
 VlkwbTHPzwrsR0Bx5kC+DpsSXC7lp8T6KtV/X/tBi+FWOOrptxIo6mtb3Y85zoWuDc4B
 Hsb6vc4xS7fL5CxAYfco77dHxbx4b3RGVW2Zmi15ZhgyIpJSPGXVKcv1JnUuCsTGglOk
 qyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742827598; x=1743432398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oq2ReTm5hcdEEl0rwoJS/DYaRgAaNR2D5EW3hjAvQfc=;
 b=GtNPO3RggX9HR0Kaae0v7ZfmCZm1J7odfsy71ct2E6m/bQ5J0CU4MHN11W1niVFibH
 7Yr3fF4+kAnSuqtKVgiMgamOfTBt5T/LQ3ml2itpAPmYY4RDZBX2kKEmiy6GxsHhAHC8
 ddVKSnRg99gOPG4KlxKax75r4IEobugMbiXP9LJ6cBWgcP2tbSYu2RcG65jAsyZDZPj/
 nXKoZbTlSGuep2w5lI9sMPirmfEk3W5bg/Cg1YljVymnPZICFVwuYBUpcaX76wTUZ3ax
 DS9v1J7Xa7LHXEJX3EodLBNxA6A2ApC2CybBuGbxrAXpRDvhiACCpt1NxKGqHUVJabbW
 ualQ==
X-Gm-Message-State: AOJu0Yw93QkT3QS7lQZBgWD26s4RadkSAKXWMnlEgaD1pEELgjnET0xA
 0rasH6lq8kRri59pDo6mfG2AI7EfwnVYPMz5qka9nvHCFbMQjePDAB9zP7RSgAOQDJlZnfpYKUE
 OwARS+mPjWar3BU44S8Yy/5R05fw=
X-Gm-Gg: ASbGncuiBQcHI2D7xGJq2a92qgyxo6a8fL/VTSgDyZhWkX7g+idMl7ygEQNIJVn6ywP
 wHUrrXJDaUbbsKHrN76mXmWkND72bCVX+bDhDy2AjtIgsGdWWGojKlKvBOUgFMKz4i2V5Rj+8pe
 mRgIEnZBimhmTV5w6CAJADjGRJApY=
X-Google-Smtp-Source: AGHT+IFMQ3wbpZ9lbabb6grlipPCVGhqm/1330m/MCmki0opito1EIVnJQ4/43KWo8tDAk5m4KkUhkql1EOfKVRCQDo=
X-Received: by 2002:a05:6402:2688:b0:5e7:c782:ba94 with SMTP id
 4fb4d7f45d1cf-5ebcd433849mr13944645a12.13.1742827597457; Mon, 24 Mar 2025
 07:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <0b7e373b-ef2d-4243-a5a0-5ffd9d97cf74@gmail.com>
 <CADnq5_PgeZtepU-emKHQKdSh2H-kiLu4KpK0LxVgKks35NTf6w@mail.gmail.com>
 <CAAQb4tapVTvteA7b13+sLSxHVPKNUbaEtEhw_of8RqVjibgesg@mail.gmail.com>
In-Reply-To: <CAAQb4tapVTvteA7b13+sLSxHVPKNUbaEtEhw_of8RqVjibgesg@mail.gmail.com>
From: Sergey Kovalenko <seryoga.engineering@gmail.com>
Date: Mon, 24 Mar 2025 16:46:26 +0200
X-Gm-Features: AQ5f1Jq4fAof568OhU5Gs3a3nl87XzoYtLTDtOqWKbVqJnRLKhXkmA82vPdSHA4
Message-ID: <CAAQb4tbsvvatQt_qZpXEzqQySubYeLLFi-M6KvHvmp-fytMEjA@mail.gmail.com>
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

Since there are several GPU series that require additional GFXOFF
ON/OFF switches
to ensure stability, this algorithm can be seen as a way to mitigate
the negative effects
of workarounds.

Simple and efficient.
Regards,
Sergey

On Mon, Mar 24, 2025 at 4:34=E2=80=AFPM Sergey Kovalenko
<seryoga.engineering@gmail.com> wrote:
>
> Hello Alex!
>
> "If there are a lot of requests to toggle gfxoff, the worker thread to
> allow it again gets
> cancelled and scheduled again, extending the time it's disallowed." -
> That's true except one thing:
> cancelling and scheduling also take CPU cycles, and the pause between
> submissions can exceed
> 100ms interval, which leads to GFXOFF being enabled even if the GPU is lo=
aded.
> This simple prediction algorithm eliminates such cases.
> GFXOFF is enabled immediately when there are only a few submissions
> ongoing, which
> means the system is idling. And when the number of compute submissions
> exceeds the
> range, the algorithm chooses a longer delay. Finally it simply ignores
> GFXOFF ON requests
> to prevent performance drops under high load.
> This allows keeping idle power consumption low and using stable GPU
> performance under load.
>
> Regards,
> Sergey
>
> On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Mon, Mar 24, 2025 at 5:06=E2=80=AFAM Sergey Kovalenko
> > <seryoga.engineering@gmail.com> wrote:
> > >
> > > Predict an optimal delay to enable GFXOFF for the next interval
> > > based on the request count:
> > > - less than 15 requests per second - zero delay
> > > - less than 25 requests per second - default delay
> > > - 25 and more requests per second - don't enable GFXOFF
> > >
> > > The algorithm allows maintaining low power consumption in idle,
> > > as well as using the full GPU power under load by eliminating
> > > hundreds of extra GFXOFF ON/OFF switches.
> >
> > I still don't understand what problem this is solving.  This already
> > happens with the way the code works now.  If there are a lot of
> > requests to toggle gfxoff, the worker thread to allow it again gets
> > cancelled and scheduled again, extending the time it's disallowed.
> >
> > Alex
> >
> >
> > Alex
> >
> > >
> > > Test configuration:
> > > - Ryzen 5 2500U
> > > - Ryzen 5 3400G
> > > - Chromium 134.0.6998.88 Arch Linux
> > > - Mesa 1:24.3.4-1
> > > - KDE Plasma 6.3.2
> > >
> > > GFXOFF enable requests per second:
> > > | Test                                                | min | max |
> > > |-----------------------------------------------------|-----|-----|
> > > | System idle                                         |   0 |  64 |
> > > | Web browsing                                        |   0 | 127 |
> > > | WebGL aquarium                                      |  10 | 236 |
> > > | Heavy load: glxgears + vkcube + resizing + flipping |  39 | 677 |
> > >
> > > Test results, Ryzen 5 2500U:
> > > | Test                        | patched-6.13.7.arch1 |   6.13.7.arch1=
-1 |
> > > |-----------------------------|----------------------|---------------=
---|
> > > | System idle (PkgWatt)       |               ~0.74W |          ~1.25=
W  |
> > > | glxgears (vblank_mode=3D0)    |     ~7300 fps, ~7.3W | ~7300 fps, ~=
7.3W |
> > > | WebGL aquarium 15.000 fish  |     56-60 fps, ~9.8W | 55-60 fps, ~9.=
8W |
> > >
> > > Test results, Ryzen 5 3400G:
> > > | Test                        | patched-6.13.7.arch1 |   6.13.7.arch1=
-1 |
> > > |-----------------------------|----------------------|---------------=
---|
> > > | System idle (PkgWatt)       |                ~3.8W |           ~4.3=
W  |
> > > | glxgears (vblank_mode=3D0)    |            ~7200 fps |        ~7200=
 fps |
> > > | WebGL aquarium 30.000 fish  |          37 fps, 47W |      38 fps, 4=
7W |
> > >
> > > Signed-off-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
> > > Tested-by: Liam Fleming <fleming.squared@proton.me>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 94 +++++++++++++++++-----=
---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 +
> > >   2 files changed, 67 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > index c1f35ded684e..5e23b956e0bf 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > @@ -781,55 +781,89 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device
> > > *adev, int xcc_id)
> > >    * 3. other client can cancel their request of disable gfx off feat=
ure
> > >    * 4. other client should not send request to enable gfx off featur=
e
> > > before disable gfx off feature.
> > >    */
> > > -
> > >   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
> > >   {
> > > -       unsigned long delay =3D GFX_OFF_DELAY_ENABLE;
> > > -
> > >         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> > >                 return;
> > >
> > >         mutex_lock(&adev->gfx.gfx_off_mutex);
> > >
> > >         if (enable) {
> > > -               /* If the count is already 0, it means there's an imb=
alance bug
> > > somewhere.
> > > -                * Note that the bug may be in a different caller tha=
n the one which
> > > triggers the
> > > -                * WARN_ON_ONCE.
> > > -                */
> > > -               if (WARN_ON_ONCE(adev->gfx.gfx_off_req_count =3D=3D 0=
))
> > > +               /* This case covers multiple calls from parallel thre=
ads */
> > > +               if (!adev->gfx.gfx_off_req_count)
> > >                         goto unlock;
> > >
> > > -               adev->gfx.gfx_off_req_count--;
> > > +               /* Process only if req_count =3D=3D 0 and GFXOFF is d=
isabled */
> > > +               if (--adev->gfx.gfx_off_req_count || adev->gfx.gfx_of=
f_state)
> > > +                       goto unlock;
> > > +
> > > +               /* If going to s2idle, no need to wait */
> > > +               if (adev->in_s0ix) {
> > > +                       if (!amdgpu_dpm_set_powergating_by_smu(
> > > +                                   adev, AMD_IP_BLOCK_TYPE_GFX, true=
, 0))
> > > +                               adev->gfx.gfx_off_state =3D true;
> > > +
> > > +                       /* Reset delay flag */
> > > +                       adev->gfx.gfx_off_use_delay =3D 0;
> > > +                       goto unlock;
> > > +               }
> > >
> > > -               if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
> > > -                   !adev->gfx.gfx_off_state) {
> > > -                       /* If going to s2idle, no need to wait */
> > > -                       if (adev->in_s0ix) {
> > > -                               if (!amdgpu_dpm_set_powergating_by_sm=
u(adev,
> > > -                                               AMD_IP_BLOCK_TYPE_GFX=
, true, 0))
> > > -                                       adev->gfx.gfx_off_state =3D t=
rue;
> > > +               ++adev->gfx.gfx_off_counter;
> > > +
> > > +               uint64_t now =3D get_jiffies_64();
> > > +               uint64_t delta =3D
> > > +                       jiffies_to_msecs(now - adev->gfx.gfx_off_time=
stamp);
> > > +
> > > +               if (delta >=3D 1000u) {
> > > +                       /*
> > > +                        * Predict the optimal delay for the next int=
erval
> > > +                        * based on the current number of requests:
> > > +                        * <15 - idle, no delay
> > > +                        * <25 - light/medium load, default delay
> > > +                        * 25 and more - high load, GFXOFF disabled
> > > +                        */
> > > +                       if (adev->gfx.gfx_off_counter < 15u) {
> > > +                               adev->gfx.gfx_off_use_delay =3D 0;
> > > +                       } else if (adev->gfx.gfx_off_counter < 25u) {
> > > +                               adev->gfx.gfx_off_use_delay =3D 1;
> > >                         } else {
> > > -                               schedule_delayed_work(&adev->gfx.gfx_=
off_delay_work,
> > > -                                             delay);
> > > +                               adev->gfx.gfx_off_use_delay =3D 2;
> > >                         }
> > > +
> > > +                       adev->gfx.gfx_off_counter =3D 0;
> > > +                       adev->gfx.gfx_off_timestamp =3D now;
> > >                 }
> > > +
> > > +               /* Don't schedule gfxoff under heavy load */
> > > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > > +                       goto unlock;
> > > +
> > > +               schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
> > > +                                     adev->gfx.gfx_off_use_delay ?
> > > +                                             GFX_OFF_DELAY_ENABLE :
> > > +                                             GFX_OFF_NO_DELAY);
> > >         } else {
> > > -               if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> > > -                       cancel_delayed_work_sync(&adev->gfx.gfx_off_d=
elay_work);
> > > +               /* GFXOFF was enabled when req_count =3D=3D 0 */
> > > +               if (++adev->gfx.gfx_off_req_count !=3D 1)
> > > +                       goto unlock;
> > >
> > > -                       if (adev->gfx.gfx_off_state &&
> > > -                           !amdgpu_dpm_set_powergating_by_smu(adev, =
AMD_IP_BLOCK_TYPE_GFX,
> > > false, 0)) {
> > > -                               adev->gfx.gfx_off_state =3D false;
> > > +               /* Nothing to do if the work wasn't scheduled */
> > > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > > +                       goto unlock;
> > >
> > > -                               if (adev->gfx.funcs->init_spm_golden)=
 {
> > > -                                       dev_dbg(adev->dev,
> > > -                                               "GFXOFF is disabled, =
re-init SPM golden settings\n");
> > > -                                       amdgpu_gfx_init_spm_golden(ad=
ev);
> > > -                               }
> > > +               cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_wor=
k);
> > > +
> > > +               if (adev->gfx.gfx_off_state &&
> > > +                   !amdgpu_dpm_set_powergating_by_smu(
> > > +                           adev, AMD_IP_BLOCK_TYPE_GFX, false, 0)) {
> > > +                       adev->gfx.gfx_off_state =3D false;
> > > +
> > > +                       if (adev->gfx.funcs->init_spm_golden) {
> > > +                               dev_dbg(adev->dev,
> > > +                                       "GFXOFF is disabled, re-init =
SPM golden settings\n");
> > > +                               amdgpu_gfx_init_spm_golden(adev);
> > >                         }
> > >                 }
> > > -
> > > -               adev->gfx.gfx_off_req_count++;
> > >         }
> > >
> > >   unlock:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > index 8b5bd63b5773..38fd445a353b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > @@ -430,7 +430,10 @@ struct amdgpu_gfx {
> > >         /* gfx off */
> > >         bool                            gfx_off_state;      /* true: =
enabled,
> > > false: disabled */
> > >         struct mutex                    gfx_off_mutex;      /* mutex =
to
> > > change gfxoff state */
> > > +       uint64_t                        gfx_off_timestamp;  /* gfxoff=
 enable call timestamp */
> > > +       uint32_t                        gfx_off_use_delay;  /* flag t=
o choose the delay range */
> > >         uint32_t                        gfx_off_req_count;  /* defaul=
t 1,
> > > enable gfx off: dec 1, disable gfx off: add 1 */
> > > +       uint32_t                        gfx_off_counter;    /* count =
of gfxoff enable calls */
> > >         struct delayed_work             gfx_off_delay_work; /* async =
work to
> > > set gfx block off */
> > >         uint32_t                        gfx_off_residency;  /* last l=
ogged
> > > residency */
> > >         uint64_t                        gfx_off_entrycount; /* count =
of times
> > > GPU has get into GFXOFF state */
> > > --
> > > 2.49.0

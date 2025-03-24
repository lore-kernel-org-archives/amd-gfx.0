Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07360C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 15:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E35310E440;
	Mon, 24 Mar 2025 15:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ub+6W3VG";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A63D10E440
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 15:18:09 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so903364a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742829489; x=1743434289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vx4Mu3yoTfZW4a/Sx7NotQ0Zff95FeRUyQem59XUTE=;
 b=Ub+6W3VGdRZX2+JE+GUa/7dpK1yy26OLz0SCr97Fraw0/z3vkO9/WO52Wsq+uBfNB4
 1CUTt/rd1IasTavJGuCVBMif0yIi9DsgCGqX8aaXn+ngIa0qHdnhZg4bmtehDBe1C7hR
 sZGYONn4Zr4tb4nEhiKBOmFiaRDpR2JJOAOlC1yG2NmSzwwPt4zfx5n7ZIczmXD4IqP0
 wAPXCvV7A+qQmsJTSx/syhfmUiwjEGJTuRlznvH/WVzJKhl/hZ0f/cGclGsEeQhzyHuM
 HSrHXZrTOZjrePT2XzBRbPTL5vEE+fycGbr+DGUpSNVQxLXXoZpaZT035YsLqog7sKDA
 Z2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742829489; x=1743434289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8vx4Mu3yoTfZW4a/Sx7NotQ0Zff95FeRUyQem59XUTE=;
 b=UpawW87T9t30gzFNyx2JO9U4YENtirFiY1LSdZwJkDjZCUThdE++swPD808OJDVIg3
 dOUPqrRftcGnhnGHCrKnbxs2NCZRMBTde3wj43ma84Wqg6nkFjsP331NiArVSHtcQLm9
 Jn1N+feNfVRkVPXpkPwTbMc/k1qelnC8X7Z+8itEfH5hMF+3J5ZdzmZgxC78E9oFhUkl
 iTigRo7KsJOkqGv/0NwPBSyPYQWj35eTnNlP3Hu4YrBUH/Jd8xg4TjBfXkU+v6VlDNAz
 ZQa7SJlGJTszMcQgtH/qY7l0/FlVv5eC0N4lpiX4etZUbURTcneQDwpVGAfEqCn2gJUD
 fSYg==
X-Gm-Message-State: AOJu0YzWWzs+khpynDKGco5SOt56sNpAwLSOME7ta6k9fUmhu5MLBzP4
 4ZHxlnNLHp4M6q1GL+HvMuwju7uHLsiqnbyWw0PFOLvGWLqCuMehhot/0B0NUEeVbHnZcEapNXt
 YXdfpjuVUgN1p75YMIKMGYZcDMonK6A==
X-Gm-Gg: ASbGncsjCqqDu7FBK/4OgRuMJmA4tRTANmQ/mmyMg79Tprm6W1KPHk3sUDS6zWeStgx
 xrgKBlTKX72T10pygdMnsPkHpl4c/Lggn2rALkXNfU4nTDjgN4anCrGC9qkUUJ208pxH1CDleRt
 NaJ5S5wdmEPZmv51YoWjo2bowX9A==
X-Google-Smtp-Source: AGHT+IHdcQCAhu0Wd07TWhmM1rAT2sjfQOj6efmkvO47OjyHjKqvCVZrWCQ8G4o80NVtax/caak0HSMC/akwZE9EeoI=
X-Received: by 2002:a17:90b:2250:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-3030fd37008mr8114596a91.0.1742829488526; Mon, 24 Mar 2025
 08:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <0b7e373b-ef2d-4243-a5a0-5ffd9d97cf74@gmail.com>
 <CADnq5_PgeZtepU-emKHQKdSh2H-kiLu4KpK0LxVgKks35NTf6w@mail.gmail.com>
 <CAAQb4tapVTvteA7b13+sLSxHVPKNUbaEtEhw_of8RqVjibgesg@mail.gmail.com>
 <CADnq5_OxuUhK4Hvit757HCnJ-wJi8VLvczXYRU6qGfo2VOZ2Yg@mail.gmail.com>
 <CAAQb4tZ_qmwmRxWbzzunJKRFVrWoB5iWbDbnOwDZufo-ng8qDA@mail.gmail.com>
In-Reply-To: <CAAQb4tZ_qmwmRxWbzzunJKRFVrWoB5iWbDbnOwDZufo-ng8qDA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 11:17:56 -0400
X-Gm-Features: AQ5f1JqVznf0kD-YEH0IYGa-gLxZQBYStJpG7x6aNupn8hqDdONHn8xzCGWeUco
Message-ID: <CADnq5_OTm+xCh0=R=PNa5jf15Cy=f4uezo7jM3qQBO7p7EQ=iQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add GFXOFF auto-tunning algorithm
To: Sergey Kovalenko <seryoga.engineering@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Mar 24, 2025 at 11:14=E2=80=AFAM Sergey Kovalenko
<seryoga.engineering@gmail.com> wrote:
>
> "Moreover the work only gets scheduled/cancelled
>  around a ref count of 0" - and this happens more than 600 times
> per second under load, as you can see from the table.
> Moreover these 600 GFXOFF requests are executed with a very
> little interval between them. If we set GFXOFF delay to 0 by
> default, it will be enabled and disabled 600 times with pretty
> significant performance drop in any test.

Can you show me the impact?

> Keeping 100ms GFXOFF delay leads to 2 times higher
> power consumption in idle, nicely noticeable for laptops.

That will be fixed in kernel 6.15 which adds the
gfx_off_ctrl_immediate() patches.

Alex

>
> I don't think this is the behavior the users want to see.
> Workarounds introduced a significant overhead, and
> to mitigate it there is a simple solution to limit the amount
> of those calls.
>
> Regards,
> Sergey
>
> On Mon, Mar 24, 2025 at 4:50=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Mon, Mar 24, 2025 at 10:34=E2=80=AFAM Sergey Kovalenko
> > <seryoga.engineering@gmail.com> wrote:
> > >
> > > Hello Alex!
> > >
> > > "If there are a lot of requests to toggle gfxoff, the worker thread t=
o
> > > allow it again gets
> > > cancelled and scheduled again, extending the time it's disallowed." -
> > > That's true except one thing:
> > > cancelling and scheduling also take CPU cycles, and the pause between
> > > submissions can exceed
> > > 100ms interval, which leads to GFXOFF being enabled even if the GPU i=
s loaded.
> > > This simple prediction algorithm eliminates such cases.
> > > GFXOFF is enabled immediately when there are only a few submissions
> > > ongoing, which
> > > means the system is idling. And when the number of compute submission=
s
> > > exceeds the
> > > range, the algorithm chooses a longer delay. Finally it simply ignore=
s
> > > GFXOFF ON requests
> > > to prevent performance drops under high load.
> > > This allows keeping idle power consumption low and using stable GPU
> > > performance under load.
> >
> > What performance drops?  Your data doesn't show any.  Moreover the
> > work only gets scheduled/cancelled around a ref count of 0. Plus, your
> > change introduces a bunch of additional calculations for this function
> > which add overhead which you are concerned about.
> >
> > Alex
> >
> > >
> > > Regards,
> > > Sergey
> > >
> > > On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Mon, Mar 24, 2025 at 5:06=E2=80=AFAM Sergey Kovalenko
> > > > <seryoga.engineering@gmail.com> wrote:
> > > > >
> > > > > Predict an optimal delay to enable GFXOFF for the next interval
> > > > > based on the request count:
> > > > > - less than 15 requests per second - zero delay
> > > > > - less than 25 requests per second - default delay
> > > > > - 25 and more requests per second - don't enable GFXOFF
> > > > >
> > > > > The algorithm allows maintaining low power consumption in idle,
> > > > > as well as using the full GPU power under load by eliminating
> > > > > hundreds of extra GFXOFF ON/OFF switches.
> > > >
> > > > I still don't understand what problem this is solving.  This alread=
y
> > > > happens with the way the code works now.  If there are a lot of
> > > > requests to toggle gfxoff, the worker thread to allow it again gets
> > > > cancelled and scheduled again, extending the time it's disallowed.
> > > >
> > > > Alex
> > > >
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > Test configuration:
> > > > > - Ryzen 5 2500U
> > > > > - Ryzen 5 3400G
> > > > > - Chromium 134.0.6998.88 Arch Linux
> > > > > - Mesa 1:24.3.4-1
> > > > > - KDE Plasma 6.3.2
> > > > >
> > > > > GFXOFF enable requests per second:
> > > > > | Test                                                | min | max=
 |
> > > > > |-----------------------------------------------------|-----|----=
-|
> > > > > | System idle                                         |   0 |  64=
 |
> > > > > | Web browsing                                        |   0 | 127=
 |
> > > > > | WebGL aquarium                                      |  10 | 236=
 |
> > > > > | Heavy load: glxgears + vkcube + resizing + flipping |  39 | 677=
 |
> > > > >
> > > > > Test results, Ryzen 5 2500U:
> > > > > | Test                        | patched-6.13.7.arch1 |   6.13.7.a=
rch1-1 |
> > > > > |-----------------------------|----------------------|-----------=
-------|
> > > > > | System idle (PkgWatt)       |               ~0.74W |          ~=
1.25W  |
> > > > > | glxgears (vblank_mode=3D0)    |     ~7300 fps, ~7.3W | ~7300 fp=
s, ~7.3W |
> > > > > | WebGL aquarium 15.000 fish  |     56-60 fps, ~9.8W | 55-60 fps,=
 ~9.8W |
> > > > >
> > > > > Test results, Ryzen 5 3400G:
> > > > > | Test                        | patched-6.13.7.arch1 |   6.13.7.a=
rch1-1 |
> > > > > |-----------------------------|----------------------|-----------=
-------|
> > > > > | System idle (PkgWatt)       |                ~3.8W |           =
~4.3W  |
> > > > > | glxgears (vblank_mode=3D0)    |            ~7200 fps |        ~=
7200 fps |
> > > > > | WebGL aquarium 30.000 fish  |          37 fps, 47W |      38 fp=
s, 47W |
> > > > >
> > > > > Signed-off-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
> > > > > Tested-by: Liam Fleming <fleming.squared@proton.me>
> > > > > ---
> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 94 +++++++++++++++++-=
-------
> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 +
> > > > >   2 files changed, 67 insertions(+), 30 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > index c1f35ded684e..5e23b956e0bf 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > @@ -781,55 +781,89 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_dev=
ice
> > > > > *adev, int xcc_id)
> > > > >    * 3. other client can cancel their request of disable gfx off =
feature
> > > > >    * 4. other client should not send request to enable gfx off fe=
ature
> > > > > before disable gfx off feature.
> > > > >    */
> > > > > -
> > > > >   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enabl=
e)
> > > > >   {
> > > > > -       unsigned long delay =3D GFX_OFF_DELAY_ENABLE;
> > > > > -
> > > > >         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> > > > >                 return;
> > > > >
> > > > >         mutex_lock(&adev->gfx.gfx_off_mutex);
> > > > >
> > > > >         if (enable) {
> > > > > -               /* If the count is already 0, it means there's an=
 imbalance bug
> > > > > somewhere.
> > > > > -                * Note that the bug may be in a different caller=
 than the one which
> > > > > triggers the
> > > > > -                * WARN_ON_ONCE.
> > > > > -                */
> > > > > -               if (WARN_ON_ONCE(adev->gfx.gfx_off_req_count =3D=
=3D 0))
> > > > > +               /* This case covers multiple calls from parallel =
threads */
> > > > > +               if (!adev->gfx.gfx_off_req_count)
> > > > >                         goto unlock;
> > > > >
> > > > > -               adev->gfx.gfx_off_req_count--;
> > > > > +               /* Process only if req_count =3D=3D 0 and GFXOFF =
is disabled */
> > > > > +               if (--adev->gfx.gfx_off_req_count || adev->gfx.gf=
x_off_state)
> > > > > +                       goto unlock;
> > > > > +
> > > > > +               /* If going to s2idle, no need to wait */
> > > > > +               if (adev->in_s0ix) {
> > > > > +                       if (!amdgpu_dpm_set_powergating_by_smu(
> > > > > +                                   adev, AMD_IP_BLOCK_TYPE_GFX, =
true, 0))
> > > > > +                               adev->gfx.gfx_off_state =3D true;
> > > > > +
> > > > > +                       /* Reset delay flag */
> > > > > +                       adev->gfx.gfx_off_use_delay =3D 0;
> > > > > +                       goto unlock;
> > > > > +               }
> > > > >
> > > > > -               if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
> > > > > -                   !adev->gfx.gfx_off_state) {
> > > > > -                       /* If going to s2idle, no need to wait */
> > > > > -                       if (adev->in_s0ix) {
> > > > > -                               if (!amdgpu_dpm_set_powergating_b=
y_smu(adev,
> > > > > -                                               AMD_IP_BLOCK_TYPE=
_GFX, true, 0))
> > > > > -                                       adev->gfx.gfx_off_state =
=3D true;
> > > > > +               ++adev->gfx.gfx_off_counter;
> > > > > +
> > > > > +               uint64_t now =3D get_jiffies_64();
> > > > > +               uint64_t delta =3D
> > > > > +                       jiffies_to_msecs(now - adev->gfx.gfx_off_=
timestamp);
> > > > > +
> > > > > +               if (delta >=3D 1000u) {
> > > > > +                       /*
> > > > > +                        * Predict the optimal delay for the next=
 interval
> > > > > +                        * based on the current number of request=
s:
> > > > > +                        * <15 - idle, no delay
> > > > > +                        * <25 - light/medium load, default delay
> > > > > +                        * 25 and more - high load, GFXOFF disabl=
ed
> > > > > +                        */
> > > > > +                       if (adev->gfx.gfx_off_counter < 15u) {
> > > > > +                               adev->gfx.gfx_off_use_delay =3D 0=
;
> > > > > +                       } else if (adev->gfx.gfx_off_counter < 25=
u) {
> > > > > +                               adev->gfx.gfx_off_use_delay =3D 1=
;
> > > > >                         } else {
> > > > > -                               schedule_delayed_work(&adev->gfx.=
gfx_off_delay_work,
> > > > > -                                             delay);
> > > > > +                               adev->gfx.gfx_off_use_delay =3D 2=
;
> > > > >                         }
> > > > > +
> > > > > +                       adev->gfx.gfx_off_counter =3D 0;
> > > > > +                       adev->gfx.gfx_off_timestamp =3D now;
> > > > >                 }
> > > > > +
> > > > > +               /* Don't schedule gfxoff under heavy load */
> > > > > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > > > > +                       goto unlock;
> > > > > +
> > > > > +               schedule_delayed_work(&adev->gfx.gfx_off_delay_wo=
rk,
> > > > > +                                     adev->gfx.gfx_off_use_delay=
 ?
> > > > > +                                             GFX_OFF_DELAY_ENABL=
E :
> > > > > +                                             GFX_OFF_NO_DELAY);
> > > > >         } else {
> > > > > -               if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> > > > > -                       cancel_delayed_work_sync(&adev->gfx.gfx_o=
ff_delay_work);
> > > > > +               /* GFXOFF was enabled when req_count =3D=3D 0 */
> > > > > +               if (++adev->gfx.gfx_off_req_count !=3D 1)
> > > > > +                       goto unlock;
> > > > >
> > > > > -                       if (adev->gfx.gfx_off_state &&
> > > > > -                           !amdgpu_dpm_set_powergating_by_smu(ad=
ev, AMD_IP_BLOCK_TYPE_GFX,
> > > > > false, 0)) {
> > > > > -                               adev->gfx.gfx_off_state =3D false=
;
> > > > > +               /* Nothing to do if the work wasn't scheduled */
> > > > > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > > > > +                       goto unlock;
> > > > >
> > > > > -                               if (adev->gfx.funcs->init_spm_gol=
den) {
> > > > > -                                       dev_dbg(adev->dev,
> > > > > -                                               "GFXOFF is disabl=
ed, re-init SPM golden settings\n");
> > > > > -                                       amdgpu_gfx_init_spm_golde=
n(adev);
> > > > > -                               }
> > > > > +               cancel_delayed_work_sync(&adev->gfx.gfx_off_delay=
_work);
> > > > > +
> > > > > +               if (adev->gfx.gfx_off_state &&
> > > > > +                   !amdgpu_dpm_set_powergating_by_smu(
> > > > > +                           adev, AMD_IP_BLOCK_TYPE_GFX, false, 0=
)) {
> > > > > +                       adev->gfx.gfx_off_state =3D false;
> > > > > +
> > > > > +                       if (adev->gfx.funcs->init_spm_golden) {
> > > > > +                               dev_dbg(adev->dev,
> > > > > +                                       "GFXOFF is disabled, re-i=
nit SPM golden settings\n");
> > > > > +                               amdgpu_gfx_init_spm_golden(adev);
> > > > >                         }
> > > > >                 }
> > > > > -
> > > > > -               adev->gfx.gfx_off_req_count++;
> > > > >         }
> > > > >
> > > > >   unlock:
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > index 8b5bd63b5773..38fd445a353b 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > @@ -430,7 +430,10 @@ struct amdgpu_gfx {
> > > > >         /* gfx off */
> > > > >         bool                            gfx_off_state;      /* tr=
ue: enabled,
> > > > > false: disabled */
> > > > >         struct mutex                    gfx_off_mutex;      /* mu=
tex to
> > > > > change gfxoff state */
> > > > > +       uint64_t                        gfx_off_timestamp;  /* gf=
xoff enable call timestamp */
> > > > > +       uint32_t                        gfx_off_use_delay;  /* fl=
ag to choose the delay range */
> > > > >         uint32_t                        gfx_off_req_count;  /* de=
fault 1,
> > > > > enable gfx off: dec 1, disable gfx off: add 1 */
> > > > > +       uint32_t                        gfx_off_counter;    /* co=
unt of gfxoff enable calls */
> > > > >         struct delayed_work             gfx_off_delay_work; /* as=
ync work to
> > > > > set gfx block off */
> > > > >         uint32_t                        gfx_off_residency;  /* la=
st logged
> > > > > residency */
> > > > >         uint64_t                        gfx_off_entrycount; /* co=
unt of times
> > > > > GPU has get into GFXOFF state */
> > > > > --
> > > > > 2.49.0

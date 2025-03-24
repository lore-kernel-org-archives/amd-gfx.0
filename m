Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4433DC3600E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 08:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CA910E50B;
	Tue, 25 Mar 2025 08:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HGQLjwMt";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F5810E49B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 16:39:29 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso717760766b.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742834368; x=1743439168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXExNVYkAjfBM6MY19AibJzuUNyrOCDz/XQnHi5j674=;
 b=HGQLjwMtpXSk0zI1fluYaHBloIiREFd+hA5FSocqXOqbmKq6BpLuA+RNDJ/VjSNRk5
 eOlMlZ6DxfVy6GpSXfg+hs/iDAYlOttXUdvwjRxTIMlb+hMdMUxJGwHppSJjDX3/ngof
 gZH9tXunlsW/YvdQqA4gKDoDYRGb6R0oX1iTp8eAcDxri5h1Du+SNKPp+VqgSjO3N9dm
 aWwLl3xYUSHRxqOhoT7C08rWx79L11eTWKTjc/HCf3WM9DpjmxUWafSqFtt1qcrxy6cR
 M5XaK0N8UNPEZfNRBO8yYFYLnJDiTye9wq7K/V+EA59kuSKGYMMXNNz3ydT4bVWkAWKA
 EpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742834368; x=1743439168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXExNVYkAjfBM6MY19AibJzuUNyrOCDz/XQnHi5j674=;
 b=ZSmGxKxQH7lz/GLF1auJ3z126+gY9L6sohXFxUYVtc+kG+V5RuDZ1PN95lbPB3+oBl
 fDYmVTSNPbveS79IEuKoy2IIqLOmFCpqjt3E9ule2f6dWPKagxGRqYsAFX56khPiCo2d
 iUZa8qynp2TeiT8BtJsJ+bnLS2ipVB5JA4kXAqDA3qOp0QY64FAOuNpoTN6/yjtwzz1g
 IzZpCvvpSsT0Cc2/v9dzTuESzj4Yj9HGrCd57AqC4zik9aldKBSBJqpEd8pWNOV5qWHQ
 EZjjKLuH+1pF/Mihqeqrs2i1xTB9OeSwCx/ZB5kq4J1IOz7aCZqEzfbc3NXWg9bzCXiS
 e0+A==
X-Gm-Message-State: AOJu0YwMFWlJHrYOQX+6j32+aoBkZMiS/hO9QnPx0/4hbe2dJO8qwmDV
 IKBGTa4lY0aouGrAJM66kqZtBpT7ZMAFExp/q1lU29586wlj4+UQ5hQHQw/Jzyz09mWVqh9IQt7
 ymR+QiYvqN0dncvXuUq9QqLLZ4C0=
X-Gm-Gg: ASbGncv1KNdt0JfRieoST/kLnHVGpR/n2WAa/n6wLIYOTr/xz+dKLJCGPqYOdZorwej
 9t3gE8XRyBOg8gwDjaionb2oYDDs8LtmPQfxY6/RiY9kvqpkiMSzCATEPzfCwwt7VbIyQ2VOV3H
 geHSWu2yYR7jeoTzGHNs9Fv3I+Zww=
X-Google-Smtp-Source: AGHT+IF5Ld1hSRz9xSvVc6W7lK886ualJAhT8X+JvD2Mnq4l7LzVhhyDRCySXCt4TS2iO/Cmo/yAEO6JhA5jZDiohsY=
X-Received: by 2002:a17:907:ec0d:b0:ac2:972c:f732 with SMTP id
 a640c23a62f3a-ac3f22b13eemr1467203666b.33.1742834368056; Mon, 24 Mar 2025
 09:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <0b7e373b-ef2d-4243-a5a0-5ffd9d97cf74@gmail.com>
 <CADnq5_PgeZtepU-emKHQKdSh2H-kiLu4KpK0LxVgKks35NTf6w@mail.gmail.com>
 <CAAQb4tapVTvteA7b13+sLSxHVPKNUbaEtEhw_of8RqVjibgesg@mail.gmail.com>
 <CADnq5_OxuUhK4Hvit757HCnJ-wJi8VLvczXYRU6qGfo2VOZ2Yg@mail.gmail.com>
 <CAAQb4tZ_qmwmRxWbzzunJKRFVrWoB5iWbDbnOwDZufo-ng8qDA@mail.gmail.com>
 <CADnq5_OTm+xCh0=R=PNa5jf15Cy=f4uezo7jM3qQBO7p7EQ=iQ@mail.gmail.com>
In-Reply-To: <CADnq5_OTm+xCh0=R=PNa5jf15Cy=f4uezo7jM3qQBO7p7EQ=iQ@mail.gmail.com>
From: Sergey Kovalenko <seryoga.engineering@gmail.com>
Date: Mon, 24 Mar 2025 18:39:16 +0200
X-Gm-Features: AQ5f1JoAh3hzD0mKPF6ET_jnEv2yW1MOpFHWgxPuwd2FK1i972R6u6xz09JhB-s
Message-ID: <CAAQb4tZnm+cAvU0RSBZqiRB+Wt7U8HREr1MNDPb79V1RUaSWzg@mail.gmail.com>
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

Here is the impact:
Ryzen 5 2500U
Idle PkgWatt: 1.3W -> 0.75W
glxgears fps: 7200 -> 4500
aquarium 15,000 fish: 56-60 -> 45-50

These results are for gfx_off_ctrl_immediate()
https://github.com/pacoandres/laikm/issues/56
https://github.com/pacoandres/laikm/issues/47

Same results are for default zero GFXOFF delay:
https://github.com/pacoandres/laikm/issues/74

On Mon, Mar 24, 2025 at 5:18=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Mar 24, 2025 at 11:14=E2=80=AFAM Sergey Kovalenko
> <seryoga.engineering@gmail.com> wrote:
> >
> > "Moreover the work only gets scheduled/cancelled
> >  around a ref count of 0" - and this happens more than 600 times
> > per second under load, as you can see from the table.
> > Moreover these 600 GFXOFF requests are executed with a very
> > little interval between them. If we set GFXOFF delay to 0 by
> > default, it will be enabled and disabled 600 times with pretty
> > significant performance drop in any test.
>
> Can you show me the impact?
>
> > Keeping 100ms GFXOFF delay leads to 2 times higher
> > power consumption in idle, nicely noticeable for laptops.
>
> That will be fixed in kernel 6.15 which adds the
> gfx_off_ctrl_immediate() patches.
>
> Alex
>
> >
> > I don't think this is the behavior the users want to see.
> > Workarounds introduced a significant overhead, and
> > to mitigate it there is a simple solution to limit the amount
> > of those calls.
> >
> > Regards,
> > Sergey
> >
> > On Mon, Mar 24, 2025 at 4:50=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Mon, Mar 24, 2025 at 10:34=E2=80=AFAM Sergey Kovalenko
> > > <seryoga.engineering@gmail.com> wrote:
> > > >
> > > > Hello Alex!
> > > >
> > > > "If there are a lot of requests to toggle gfxoff, the worker thread=
 to
> > > > allow it again gets
> > > > cancelled and scheduled again, extending the time it's disallowed."=
 -
> > > > That's true except one thing:
> > > > cancelling and scheduling also take CPU cycles, and the pause betwe=
en
> > > > submissions can exceed
> > > > 100ms interval, which leads to GFXOFF being enabled even if the GPU=
 is loaded.
> > > > This simple prediction algorithm eliminates such cases.
> > > > GFXOFF is enabled immediately when there are only a few submissions
> > > > ongoing, which
> > > > means the system is idling. And when the number of compute submissi=
ons
> > > > exceeds the
> > > > range, the algorithm chooses a longer delay. Finally it simply igno=
res
> > > > GFXOFF ON requests
> > > > to prevent performance drops under high load.
> > > > This allows keeping idle power consumption low and using stable GPU
> > > > performance under load.
> > >
> > > What performance drops?  Your data doesn't show any.  Moreover the
> > > work only gets scheduled/cancelled around a ref count of 0. Plus, you=
r
> > > change introduces a bunch of additional calculations for this functio=
n
> > > which add overhead which you are concerned about.
> > >
> > > Alex
> > >
> > > >
> > > > Regards,
> > > > Sergey
> > > >
> > > > On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> > > > >
> > > > > On Mon, Mar 24, 2025 at 5:06=E2=80=AFAM Sergey Kovalenko
> > > > > <seryoga.engineering@gmail.com> wrote:
> > > > > >
> > > > > > Predict an optimal delay to enable GFXOFF for the next interval
> > > > > > based on the request count:
> > > > > > - less than 15 requests per second - zero delay
> > > > > > - less than 25 requests per second - default delay
> > > > > > - 25 and more requests per second - don't enable GFXOFF
> > > > > >
> > > > > > The algorithm allows maintaining low power consumption in idle,
> > > > > > as well as using the full GPU power under load by eliminating
> > > > > > hundreds of extra GFXOFF ON/OFF switches.
> > > > >
> > > > > I still don't understand what problem this is solving.  This alre=
ady
> > > > > happens with the way the code works now.  If there are a lot of
> > > > > requests to toggle gfxoff, the worker thread to allow it again ge=
ts
> > > > > cancelled and scheduled again, extending the time it's disallowed=
.
> > > > >
> > > > > Alex
> > > > >
> > > > >
> > > > > Alex
> > > > >
> > > > > >
> > > > > > Test configuration:
> > > > > > - Ryzen 5 2500U
> > > > > > - Ryzen 5 3400G
> > > > > > - Chromium 134.0.6998.88 Arch Linux
> > > > > > - Mesa 1:24.3.4-1
> > > > > > - KDE Plasma 6.3.2
> > > > > >
> > > > > > GFXOFF enable requests per second:
> > > > > > | Test                                                | min | m=
ax |
> > > > > > |-----------------------------------------------------|-----|--=
---|
> > > > > > | System idle                                         |   0 |  =
64 |
> > > > > > | Web browsing                                        |   0 | 1=
27 |
> > > > > > | WebGL aquarium                                      |  10 | 2=
36 |
> > > > > > | Heavy load: glxgears + vkcube + resizing + flipping |  39 | 6=
77 |
> > > > > >
> > > > > > Test results, Ryzen 5 2500U:
> > > > > > | Test                        | patched-6.13.7.arch1 |   6.13.7=
.arch1-1 |
> > > > > > |-----------------------------|----------------------|---------=
---------|
> > > > > > | System idle (PkgWatt)       |               ~0.74W |         =
 ~1.25W  |
> > > > > > | glxgears (vblank_mode=3D0)    |     ~7300 fps, ~7.3W | ~7300 =
fps, ~7.3W |
> > > > > > | WebGL aquarium 15.000 fish  |     56-60 fps, ~9.8W | 55-60 fp=
s, ~9.8W |
> > > > > >
> > > > > > Test results, Ryzen 5 3400G:
> > > > > > | Test                        | patched-6.13.7.arch1 |   6.13.7=
.arch1-1 |
> > > > > > |-----------------------------|----------------------|---------=
---------|
> > > > > > | System idle (PkgWatt)       |                ~3.8W |         =
  ~4.3W  |
> > > > > > | glxgears (vblank_mode=3D0)    |            ~7200 fps |       =
 ~7200 fps |
> > > > > > | WebGL aquarium 30.000 fish  |          37 fps, 47W |      38 =
fps, 47W |
> > > > > >
> > > > > > Signed-off-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
> > > > > > Tested-by: Liam Fleming <fleming.squared@proton.me>
> > > > > > ---
> > > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 94 ++++++++++++++++=
+--------
> > > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 +
> > > > > >   2 files changed, 67 insertions(+), 30 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > index c1f35ded684e..5e23b956e0bf 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > > > > @@ -781,55 +781,89 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_d=
evice
> > > > > > *adev, int xcc_id)
> > > > > >    * 3. other client can cancel their request of disable gfx of=
f feature
> > > > > >    * 4. other client should not send request to enable gfx off =
feature
> > > > > > before disable gfx off feature.
> > > > > >    */
> > > > > > -
> > > > > >   void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool ena=
ble)
> > > > > >   {
> > > > > > -       unsigned long delay =3D GFX_OFF_DELAY_ENABLE;
> > > > > > -
> > > > > >         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> > > > > >                 return;
> > > > > >
> > > > > >         mutex_lock(&adev->gfx.gfx_off_mutex);
> > > > > >
> > > > > >         if (enable) {
> > > > > > -               /* If the count is already 0, it means there's =
an imbalance bug
> > > > > > somewhere.
> > > > > > -                * Note that the bug may be in a different call=
er than the one which
> > > > > > triggers the
> > > > > > -                * WARN_ON_ONCE.
> > > > > > -                */
> > > > > > -               if (WARN_ON_ONCE(adev->gfx.gfx_off_req_count =
=3D=3D 0))
> > > > > > +               /* This case covers multiple calls from paralle=
l threads */
> > > > > > +               if (!adev->gfx.gfx_off_req_count)
> > > > > >                         goto unlock;
> > > > > >
> > > > > > -               adev->gfx.gfx_off_req_count--;
> > > > > > +               /* Process only if req_count =3D=3D 0 and GFXOF=
F is disabled */
> > > > > > +               if (--adev->gfx.gfx_off_req_count || adev->gfx.=
gfx_off_state)
> > > > > > +                       goto unlock;
> > > > > > +
> > > > > > +               /* If going to s2idle, no need to wait */
> > > > > > +               if (adev->in_s0ix) {
> > > > > > +                       if (!amdgpu_dpm_set_powergating_by_smu(
> > > > > > +                                   adev, AMD_IP_BLOCK_TYPE_GFX=
, true, 0))
> > > > > > +                               adev->gfx.gfx_off_state =3D tru=
e;
> > > > > > +
> > > > > > +                       /* Reset delay flag */
> > > > > > +                       adev->gfx.gfx_off_use_delay =3D 0;
> > > > > > +                       goto unlock;
> > > > > > +               }
> > > > > >
> > > > > > -               if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
> > > > > > -                   !adev->gfx.gfx_off_state) {
> > > > > > -                       /* If going to s2idle, no need to wait =
*/
> > > > > > -                       if (adev->in_s0ix) {
> > > > > > -                               if (!amdgpu_dpm_set_powergating=
_by_smu(adev,
> > > > > > -                                               AMD_IP_BLOCK_TY=
PE_GFX, true, 0))
> > > > > > -                                       adev->gfx.gfx_off_state=
 =3D true;
> > > > > > +               ++adev->gfx.gfx_off_counter;
> > > > > > +
> > > > > > +               uint64_t now =3D get_jiffies_64();
> > > > > > +               uint64_t delta =3D
> > > > > > +                       jiffies_to_msecs(now - adev->gfx.gfx_of=
f_timestamp);
> > > > > > +
> > > > > > +               if (delta >=3D 1000u) {
> > > > > > +                       /*
> > > > > > +                        * Predict the optimal delay for the ne=
xt interval
> > > > > > +                        * based on the current number of reque=
sts:
> > > > > > +                        * <15 - idle, no delay
> > > > > > +                        * <25 - light/medium load, default del=
ay
> > > > > > +                        * 25 and more - high load, GFXOFF disa=
bled
> > > > > > +                        */
> > > > > > +                       if (adev->gfx.gfx_off_counter < 15u) {
> > > > > > +                               adev->gfx.gfx_off_use_delay =3D=
 0;
> > > > > > +                       } else if (adev->gfx.gfx_off_counter < =
25u) {
> > > > > > +                               adev->gfx.gfx_off_use_delay =3D=
 1;
> > > > > >                         } else {
> > > > > > -                               schedule_delayed_work(&adev->gf=
x.gfx_off_delay_work,
> > > > > > -                                             delay);
> > > > > > +                               adev->gfx.gfx_off_use_delay =3D=
 2;
> > > > > >                         }
> > > > > > +
> > > > > > +                       adev->gfx.gfx_off_counter =3D 0;
> > > > > > +                       adev->gfx.gfx_off_timestamp =3D now;
> > > > > >                 }
> > > > > > +
> > > > > > +               /* Don't schedule gfxoff under heavy load */
> > > > > > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > > > > > +                       goto unlock;
> > > > > > +
> > > > > > +               schedule_delayed_work(&adev->gfx.gfx_off_delay_=
work,
> > > > > > +                                     adev->gfx.gfx_off_use_del=
ay ?
> > > > > > +                                             GFX_OFF_DELAY_ENA=
BLE :
> > > > > > +                                             GFX_OFF_NO_DELAY)=
;
> > > > > >         } else {
> > > > > > -               if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> > > > > > -                       cancel_delayed_work_sync(&adev->gfx.gfx=
_off_delay_work);
> > > > > > +               /* GFXOFF was enabled when req_count =3D=3D 0 *=
/
> > > > > > +               if (++adev->gfx.gfx_off_req_count !=3D 1)
> > > > > > +                       goto unlock;
> > > > > >
> > > > > > -                       if (adev->gfx.gfx_off_state &&
> > > > > > -                           !amdgpu_dpm_set_powergating_by_smu(=
adev, AMD_IP_BLOCK_TYPE_GFX,
> > > > > > false, 0)) {
> > > > > > -                               adev->gfx.gfx_off_state =3D fal=
se;
> > > > > > +               /* Nothing to do if the work wasn't scheduled *=
/
> > > > > > +               if (adev->gfx.gfx_off_use_delay =3D=3D 2)
> > > > > > +                       goto unlock;
> > > > > >
> > > > > > -                               if (adev->gfx.funcs->init_spm_g=
olden) {
> > > > > > -                                       dev_dbg(adev->dev,
> > > > > > -                                               "GFXOFF is disa=
bled, re-init SPM golden settings\n");
> > > > > > -                                       amdgpu_gfx_init_spm_gol=
den(adev);
> > > > > > -                               }
> > > > > > +               cancel_delayed_work_sync(&adev->gfx.gfx_off_del=
ay_work);
> > > > > > +
> > > > > > +               if (adev->gfx.gfx_off_state &&
> > > > > > +                   !amdgpu_dpm_set_powergating_by_smu(
> > > > > > +                           adev, AMD_IP_BLOCK_TYPE_GFX, false,=
 0)) {
> > > > > > +                       adev->gfx.gfx_off_state =3D false;
> > > > > > +
> > > > > > +                       if (adev->gfx.funcs->init_spm_golden) {
> > > > > > +                               dev_dbg(adev->dev,
> > > > > > +                                       "GFXOFF is disabled, re=
-init SPM golden settings\n");
> > > > > > +                               amdgpu_gfx_init_spm_golden(adev=
);
> > > > > >                         }
> > > > > >                 }
> > > > > > -
> > > > > > -               adev->gfx.gfx_off_req_count++;
> > > > > >         }
> > > > > >
> > > > > >   unlock:
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > > index 8b5bd63b5773..38fd445a353b 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > > > @@ -430,7 +430,10 @@ struct amdgpu_gfx {
> > > > > >         /* gfx off */
> > > > > >         bool                            gfx_off_state;      /* =
true: enabled,
> > > > > > false: disabled */
> > > > > >         struct mutex                    gfx_off_mutex;      /* =
mutex to
> > > > > > change gfxoff state */
> > > > > > +       uint64_t                        gfx_off_timestamp;  /* =
gfxoff enable call timestamp */
> > > > > > +       uint32_t                        gfx_off_use_delay;  /* =
flag to choose the delay range */
> > > > > >         uint32_t                        gfx_off_req_count;  /* =
default 1,
> > > > > > enable gfx off: dec 1, disable gfx off: add 1 */
> > > > > > +       uint32_t                        gfx_off_counter;    /* =
count of gfxoff enable calls */
> > > > > >         struct delayed_work             gfx_off_delay_work; /* =
async work to
> > > > > > set gfx block off */
> > > > > >         uint32_t                        gfx_off_residency;  /* =
last logged
> > > > > > residency */
> > > > > >         uint64_t                        gfx_off_entrycount; /* =
count of times
> > > > > > GPU has get into GFXOFF state */
> > > > > > --
> > > > > > 2.49.0

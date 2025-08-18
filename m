Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB50CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 22:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF8110E4D1;
	Mon, 18 Aug 2025 22:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crV+YVIu";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D2910E08E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 22:02:01 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-30ccec2515dso3488110fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755554520; x=1756159320; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MOu3S1Oy7dG3jCmTPWbqqeoZiILF4s/CQ022qQm/D4o=;
 b=crV+YVIu8p6M/ixCYcuG1bujFEI6FUFmLCsWb7JozOi5Vkyo6VJZHqLO95wLp6z4DJ
 TDkdveXpCu7r8xc9SqFKMcg93GGxpCj0exM/4xpwmuY4AT6elbM0OXRD9ghwvU2uuL+v
 PVvIwKful0i2/XXl3MZ0LjvbRexoQwf2Rsd+Jm4TcP8Ft07XncneJbxbmtVEzF627sou
 wU/ATmSnGpMG0ybbrL5sTR3/27UhBRaM4WnU8Ax6RMec+Ctv8xTEabQh3kBuNq7xzVvw
 /PNUV8shGutrynb35AAWwkzSbQ9XGARsN0GYdvOk4njFgZJRCFxoVIpbdDyYhK05Jg3A
 H16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755554520; x=1756159320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MOu3S1Oy7dG3jCmTPWbqqeoZiILF4s/CQ022qQm/D4o=;
 b=FULDhOnND6B6TFOs2hBe59KEcqisLKsCH5NHa1COF2ln9mE7+wFHva8Sxoui57fqL9
 f/pvvA3KPR4tb4jc8S8IGhJC/WOV3YzabV+mpR/nrJdCSrhybngdeH2KeKD4hww9iHbF
 k8n/a2+QrMtwkd6w1H73T6ZGymjh+JWMDNlX95FhIqUXU9iTseBrkwX7KerzjQGpupsQ
 +CIlRHFkCZEThGyDXkR1sy6xeG5l/V/SRppZTIcbLHKkAqyQUiEYswutywCbunB3WZ4h
 UbtN5UiZ1bOBDVANDwa0kWgablIRU46B1GPiShkcB8pwMZfjmEU2HZcdYxZW7hCkJ/zj
 zbJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwesEC204453UvQuIoA4WZyHZAcVIJuMAcyrYwkkgWpx+sv8zbsrtX9vlToGZFVld1JVwShu9x@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyi20ktmvrpq8dqfkDamT0+3i2wgdOtaWsuS8VtTsWXKnHXSZ7x
 Chd/pYNpWD/WRHnEtKxnPw9BAoCAPwCrCoKiQ5SBirXyBvYDmBf8yCvf4JD70H+4CtpVVRUNed7
 xXfuqlRy/DcXoJuq6mddEdxvql3/DDiM=
X-Gm-Gg: ASbGncuiSNtMIiUc88OOXdJCHVNBSxQcHz76um81nsgm/NQElkINQLP7Bd+RWZbd4II
 ftmhyI8TaXLpb0F3gcErt0U+5QT+Wl4guCwfSuy4r6ykFjxV+tGtau+aBiEcgv7kPwleWes6ZOg
 PxHf7FZJHyMDakbieksIbWed4AbZk1NcJXRHsCBJ6sbaNCRqtQyMnbRYzoGQmFCswjRvG3stffJ
 8JtUZo9K9ImPJdtnNWGdQWzUoxrvQYDAukCfmTO
X-Google-Smtp-Source: AGHT+IFFZoFD+rjiZZCETjHV/62sX6KE6v9TaWJEhQ43AmK7fp381+PlF+xfzoP+J2gmaXYk6Frtp1Chzf+A7Hc+NFE=
X-Received: by 2002:a05:6870:4cc2:b0:30c:2b9:6bb6 with SMTP id
 586e51a60fabf-3110bddbe72mr368328fac.0.1755554520479; Mon, 18 Aug 2025
 15:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-4-timur.kristof@gmail.com>
 <bb9c7df3-5175-4e13-b519-19d6db465a67@amd.com>
 <CADnq5_MnTaM4U+UgnpEmFf6i1eyavgh9XAT20BajxJ0S2t_7Gw@mail.gmail.com>
In-Reply-To: <CADnq5_MnTaM4U+UgnpEmFf6i1eyavgh9XAT20BajxJ0S2t_7Gw@mail.gmail.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Tue, 19 Aug 2025 00:01:45 +0200
X-Gm-Features: Ac12FXzrh9FHv2gwLeCO8cixYzsjPyYq4DNaFolcET8ReAPKx7w5cI6238ihuKM
Message-ID: <CAFF-SiVS9NY2MSd-ZmTnjwrOnC=amJrK2gh1CEOCgwiZOgjL4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Don't use non-registered VUPDATE on
 DCE 6
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="00000000000093b9e2063caae35c"
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

--00000000000093b9e2063caae35c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex Deucher <alexdeucher@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2025. aug=
. 18., H=C3=A9t
22:30):

> On Mon, Aug 18, 2025 at 4:11=E2=80=AFPM Alex Hung <alex.hung@amd.com> wro=
te:
> >
> >
> >
> > On 8/2/25 10:06, Timur Krist=C3=B3f wrote:
> > > The VUPDATE interrupt isn't registered on DCE 6, so don't try
> > > to use that.
> > >
> > > This fixes a page flip timeout after sleep/resume on DCE 6.
> > >
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22
> ++++++++++++-------
> > >   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 ++++++++------
> > >   2 files changed, 23 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 470f831a17f7..e8d2ba58cbfa 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -2981,14 +2981,20 @@ static void
> dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
> > >                               drm_warn(adev_to_drm(adev), "Failed to
> %s pflip interrupts\n",
> > >                                        enable ? "enable" : "disable")=
;
> > >
> > > -                     if (enable) {
> > > -                             if
> (amdgpu_dm_crtc_vrr_active(to_dm_crtc_state(acrtc->base.state)))
> > > -                                     rc =3D
> amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true);
> > > -                     } else
> > > -                             rc =3D
> amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
> > > -
> > > -                     if (rc)
> > > -                             drm_warn(adev_to_drm(adev), "Failed to
> %sable vupdate interrupt\n", enable ? "en" : "dis");
> > > +                     if
> (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
> > > +                             if (enable) {
> > > +                                     if (amdgpu_dm_crtc_vrr_active(
> > > +
>  to_dm_crtc_state(acrtc->base.state)))
> > > +                                             rc =3D
> amdgpu_dm_crtc_set_vupdate_irq(
> > > +                                                     &acrtc->base,
> true);
> > > +                             } else
> > > +                                     rc =3D
> amdgpu_dm_crtc_set_vupdate_irq(
> > > +                                                     &acrtc->base,
> false);
> > > +
> > > +                             if (rc)
> > > +                                     drm_warn(adev_to_drm(adev),
> "Failed to %sable vupdate interrupt\n",
> > > +                                             enable ? "en" : "dis");
> > > +                     }
> >
> > Hi Timur,
> >
> > There seem to be conflicts to amd-staging-drm-next. Could you please
> > rebase and resend? This helps make sure new change fix the problem you
> > observed.
> >
> > Really appreciate it. Thanks.
>
> If it's just the first patch, you can skip that one as the conflict
> solves the issue with DSC.
>
> Alex
>

Hi Alex,

This is a different series, not the same one that had the patch for the DSC
crash. I can send a rebased version tomorrow.

Additionally, I have one more patch that solves another case of page flip
timeout on DCE 6, I will add that to the next version of the series too if
that's okay.

Thanks,
Timur



> >
> > >
> > >                       irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_ins=
t;
> > >                       /* During gpu-reset we disable and then enable
> vblank irq, so
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > index 2551823382f8..f2208e4224f9 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > > @@ -298,13 +298,15 @@ static inline int
> amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
> > >
> > >       irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev,
> acrtc->crtc_id);
> > >
> > > -     if (enable) {
> > > -             /* vblank irq on -> Only need vupdate irq in vrr mode *=
/
> > > -             if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> > > -                     rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, tru=
e);
> > > -     } else {
> > > -             /* vblank irq off -> vupdate irq off */
> > > -             rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
> > > +     if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> > > +             if (enable) {
> > > +                     /* vblank irq on -> Only need vupdate irq in vr=
r
> mode */
> > > +                     if (amdgpu_dm_crtc_vrr_active(acrtc_state))
> > > +                             rc =3D
> amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
> > > +             } else {
> > > +                     /* vblank irq off -> vupdate irq off */
> > > +                     rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, fal=
se);
> > > +             }
> > >       }
> > >
> > >       if (rc)
> >
>

--00000000000093b9e2063caae35c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e gmail_quote_container" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr"=
>Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmai=
l.com</a>&gt; ezt =C3=ADrta (id=C5=91pont: 2025. aug. 18., H=C3=A9t 22:30):=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">On Mon, Aug 18, 2025 at 4:11=E2=80=
=AFPM Alex Hung &lt;<a href=3D"mailto:alex.hung@amd.com" target=3D"_blank" =
rel=3D"noreferrer">alex.hung@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 8/2/25 10:06, Timur Krist=C3=B3f wrote:<br>
&gt; &gt; The VUPDATE interrupt isn&#39;t registered on DCE 6, so don&#39;t=
 try<br>
&gt; &gt; to use that.<br>
&gt; &gt;<br>
&gt; &gt; This fixes a page flip timeout after sleep/resume on DCE 6.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kri=
stof@gmail.com" target=3D"_blank" rel=3D"noreferrer">timur.kristof@gmail.co=
m</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++=
++++++++++-------<br>
&gt; &gt;=C2=A0 =C2=A0.../amd/display/amdgpu_dm/amdgpu_dm_crtc.c=C2=A0 =C2=
=A0 | 16 ++++++++------<br>
&gt; &gt;=C2=A0 =C2=A02 files changed, 23 insertions(+), 15 deletions(-)<br=
>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; &gt; index 470f831a17f7..e8d2ba58cbfa 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; &gt; @@ -2981,14 +2981,20 @@ static void dm_gpureset_toggle_interrupts=
(struct amdgpu_device *adev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_warn(adev_to_drm(adev), &q=
uot;Failed to %s pflip interrupts\n&quot;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
nable ? &quot;enable&quot; : &quot;disable&quot;);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (enable) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_dm_crtc_vrr_active(to_d=
m_crtc_state(acrtc-&gt;base.state)))<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D=
 amdgpu_dm_crtc_set_vupdate_irq(&amp;acrtc-&gt;base, true);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D amdgpu_dm_crtc_set_vupdate_=
irq(&amp;acrtc-&gt;base, false);<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (rc)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_warn(adev_to_drm(adev), &quot;=
Failed to %sable vupdate interrupt\n&quot;, enable ? &quot;en&quot; : &quot=
;dis&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (dc_supports_vrr(adev-&gt;dm.dc-&gt;ctx-&gt;dce_version)) {=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (am=
dgpu_dm_crtc_vrr_active(<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to_dm_crtc_state(acrtc-=
&gt;base.state)))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0rc =3D amdgpu_dm_crtc_set_vupdate_irq(<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;acrtc-&gt;base, tr=
ue);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D=
 amdgpu_dm_crtc_set_vupdate_irq(<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;acrtc-&gt;base, fa=
lse);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_wa=
rn(adev_to_drm(adev), &quot;Failed to %sable vupdate interrupt\n&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0enable ? &quot;en&quot; : &quot;dis&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; Hi Timur,<br>
&gt;<br>
&gt; There seem to be conflicts to amd-staging-drm-next. Could you please<b=
r>
&gt; rebase and resend? This helps make sure new change fix the problem you=
<br>
&gt; observed.<br>
&gt;<br>
&gt; Really appreciate it. Thanks.<br>
<br>
If it&#39;s just the first patch, you can skip that one as the conflict<br>
solves the issue with DSC.<br>
<br>
Alex<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Hi Alex,</div><div dir=3D"auto"><br></div><div dir=3D"auto">This is a d=
ifferent series, not the same one that had the patch for the DSC crash. I c=
an send a rebased version tomorrow.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Additionally, I have one more patch that solves another case of=
 page flip timeout on DCE 6, I will add that to the next version of the ser=
ies too if that&#39;s okay.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Thanks,</div><div dir=3D"auto">Timur</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmai=
l_quote_container" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0irq_source =3D IRQ_TYPE_VBLANK + acrtc-&gt;otg_inst;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* During gpu-reset we disable and then enable vblank irq,=
 so<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc=
.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt; &gt; index 2551823382f8..f2208e4224f9 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
&gt; &gt; @@ -298,13 +298,15 @@ static inline int amdgpu_dm_crtc_set_vblank=
(struct drm_crtc *crtc, bool enable)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_type =3D amdgpu_display_crtc_idx_to=
_irq_type(adev, acrtc-&gt;crtc_id);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (enable) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* vblank irq on=
 -&gt; Only need vupdate irq in vrr mode */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_dm_cr=
tc_vrr_active(acrtc_state))<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, true);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* vblank irq of=
f -&gt; vupdate irq off */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D amdgpu_dm=
_crtc_set_vupdate_irq(crtc, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (dc_supports_vrr(dm-&gt;dc-&gt;ctx-&gt;dc=
e_version)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (enable) {<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* vblank irq on -&gt; Only need vupdate irq in vrr mode */<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (amdgpu_dm_crtc_vrr_active(acrtc_state))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D amdgpu_dm_crtc_set_vupdate_=
irq(crtc, true);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* vblank irq off -&gt; vupdate irq off */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt;<br>
</blockquote></div></div></div>

--00000000000093b9e2063caae35c--

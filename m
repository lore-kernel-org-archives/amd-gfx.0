Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89046CAC5B5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 21:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E8210E2A4;
	Thu, 25 Sep 2025 21:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M4kzYJuK";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAB610E2A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 21:33:35 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-30cce892b7dso988822fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758836014; x=1759440814; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F+31gr4auEjmu+7XKH4NlwmXPtnCJ+pwcSZ29yHlOfY=;
 b=M4kzYJuKykP4kSVgpzknsnHox2QUQE/ug2FfePS+6wMpgTUkkyrdFD3FNt5ITKPmRX
 5SFDl7PlpdQUxlb7kiWQZuGGrLvJpi9ERc1i2NwOw1JvWw44t1+npPbsBLhcoAizqy5O
 mdPh1Jks75zk2S7rvzHAZ/fZyeH5Iz3ZFF1VRCKF929Z3FyJu1/9ha4OKeLPeD0wBed6
 KjQfk88h0yV1e3Qlmelyro9kP5bxj2CeAiiVeJmDkP52C1gQjjsd0EyNZNruTvvDXFIe
 C59nxkisWuHRqSogOC6fHwr1BTo/mH5nh+pfvfgj5+RuzDSIEmu+x2ny8hp5jbMe86MP
 RAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758836014; x=1759440814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F+31gr4auEjmu+7XKH4NlwmXPtnCJ+pwcSZ29yHlOfY=;
 b=dW1J39olMtw8mnfPQwsQzIDXFPs9kTE/WVkCXoLPdlnDU9pSSd5U1YWGWjiW2r9it5
 u9fQqzkQl38wLwpCekg3C8anLtdORguv/o7UqXwvtkGex/Yr392yKTBT/tjKNGnORCI0
 1ZzP7EufTnGA9xi7ePz7Mx8VoJhL/GILX6dt0VUPN1wsQoR7wib3BYk9D0k+gKttpSDm
 712fm222FobBYJnlYd/ljaUhVafq0peM755CXDLhVFAxk4aWsjEJV+2wkWHCpY1WUD2l
 Jk4k/hysVMN1B1HSHYoXFSSL3GREyBQzrpAYG2hSODTjZTKjNH+P55LElnASGJ2Hahp8
 fqlQ==
X-Gm-Message-State: AOJu0YxQvR7kNs370+qx9kYjjpStvt3oiHGn+0VrH08zYx7n8EI90p1b
 JXSoX59nu7IukOlYc61DDqzXR4ic6y0wvKfmZNg9OTcTwcZY6M5MN88cK6wEBwbtWPxX+fUO5Uc
 6hGDGx/8u38a6uR/za2Jx0Wtkgi4MkyM=
X-Gm-Gg: ASbGncuCz4fF4xZdDLh+T5UVOELcnlfFxplxs17v0Cp9um9bs2N3GUKVsoLBlTK9DVR
 jclt7A2x/vbOhjfiOcsmVRgfnJVhC1Hw3IeeLlPInJGJwlUGtc/TE18O7xoUZdkjbPVa5/yGudt
 0T2JIlv8tIkk0lHpkXcUC8jniqd6dtz2wExX56rGzsdSAyFFwGUD6ac8o3g0HhLIxbrePPYzLVY
 tDczpUbKMA0rrRJKnIRY/3RXtkf+awXiiaO8qwCbg==
X-Google-Smtp-Source: AGHT+IHFSN3TiK2/JKdpXijOXevgvnZ007WKhgIGv0obukJ0GB+gthfaTSomWmVc52Dv2zn7FsbS2gcKMbMTZ4ajPFo=
X-Received: by 2002:a05:6871:3589:b0:322:52d5:bbf6 with SMTP id
 586e51a60fabf-35ee8f14a95mr2516459fac.25.1758836014104; Thu, 25 Sep 2025
 14:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250925184525.43290-1-timur.kristof@gmail.com>
 <20250925184525.43290-3-timur.kristof@gmail.com>
 <CADnq5_Pq2Tm4qW56QrY7DTr0_8h40gn3SdNeMyz=zqj8=D4UNw@mail.gmail.com>
In-Reply-To: <CADnq5_Pq2Tm4qW56QrY7DTr0_8h40gn3SdNeMyz=zqj8=D4UNw@mail.gmail.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Thu, 25 Sep 2025 23:33:22 +0200
X-Gm-Features: AS18NWBbktaVyFWvRJf0nXqtfZsmygPtokQK1t86ssBr3wNsLuE9p7xJQsiKQJw
Message-ID: <CAFF-SiU6eenb39GdZUuPK=4Jf53UqWU05Lt3oTMtie0EtYkbRQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amd/display: Add missing DCE6
 SCL_HORZ_FILTER_INIT* SRIs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Content-Type: multipart/alternative; boundary="000000000000d6c3bd063fa6eb5d"
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

--000000000000d6c3bd063fa6eb5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex Deucher <alexdeucher@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2025. sze=
pt. 25.,
Cs=C3=BC 23:28):

> On Thu, Sep 25, 2025 at 2:45=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com>
> wrote:
> >
> > Without these, it's impossible to program these registers.
> >
> > Fixes: 102b2f587ac8 ("drm/amd/display: dce_transform: DCE6 Scaling
> Horizontal Filter Init (v2)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> I think it would make sense to just squash patches 2-4 together.
> Other than that, these look good to me.
>
> Alex
>

They make more sense to me individually but we can squash them too. Do you
prefer that I send another series with these squashed or will you squash
them when applying them?



> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> > index cbce194ec7b8..ff746fba850b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
> > @@ -155,6 +155,8 @@
> >         SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
> >         SRI(VIEWPORT_START, SCL, id), \
> >         SRI(VIEWPORT_SIZE, SCL, id), \
> > +       SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id), \
> > +       SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id), \
> >         SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
> >         SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL, id), \
> >         SRI(SCL_VERT_FILTER_INIT, SCL, id), \
> > --
> > 2.51.0
> >
>

--000000000000d6c3bd063fa6eb5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Alex Deucher &lt;<a href=3D"mail=
to:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; ezt =C3=ADrta (id=
=C5=91pont: 2025. szept. 25., Cs=C3=BC 23:28):<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Thu, Sep 25, 2025 at 2:45=E2=80=AFPM Timur Krist=C3=B3f &l=
t;<a href=3D"mailto:timur.kristof@gmail.com" target=3D"_blank" rel=3D"noref=
errer">timur.kristof@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Without these, it&#39;s impossible to program these registers.<br>
&gt;<br>
&gt; Fixes: 102b2f587ac8 (&quot;drm/amd/display: dce_transform: DCE6 Scalin=
g Horizontal Filter Init (v2)&quot;)<br>
&gt; Signed-off-by: Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@=
gmail.com" target=3D"_blank" rel=3D"noreferrer">timur.kristof@gmail.com</a>=
&gt;<br>
<br>
I think it would make sense to just squash patches 2-4 together.<br>
Other than that, these look good to me.<br>
<br>
Alex<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">They make more sense to me individually but we can squash them too. Do =
you prefer that I send another series with these squashed or will you squas=
h them when applying them?</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_transform.h<br>
&gt; index cbce194ec7b8..ff746fba850b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h<br>
&gt; @@ -155,6 +155,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(VIEWPORT_START, SCL, id), \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(VIEWPORT_SIZE, SCL, id), \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL, id=
), \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(SCL_HORZ_FILTER_INIT_CHROMA, SCL, id),=
 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL,=
 id), \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL,=
 id), \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SRI(SCL_VERT_FILTER_INIT, SCL, id), \=
<br>
&gt; --<br>
&gt; 2.51.0<br>
&gt;<br>
</blockquote></div></div></div>

--000000000000d6c3bd063fa6eb5d--

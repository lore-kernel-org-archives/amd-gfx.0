Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98609C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 00:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FCC64DDC
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 00:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FCC64DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEC989F92;
	Tue, 23 Feb 2021 00:26:11 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FD189F97
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 00:26:10 +0000 (UTC)
Received: by mail-io1-xd2e.google.com with SMTP id f6so15282510iop.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 16:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jzRtbCl5Ig4uAvDMrC6pwV2zzQ3A5kDBGhuZrN+504I=;
 b=UMMDONkhdKq6QWIJFdpeF9Y2ty9to5LbR/qmgzAQ14q2/7Y49dzV2+jCnT110Tsqnv
 aDcAiy/GfTmetK+Fy1T6L88OT28mUEHbRjOUxGa9FdZpkqG/iSdZJ8PzISFCUp/hlPz2
 we9WNCE71GDtwyEd640vs0xtJydflgMMnfoNxta01gmsn9Sqbk12Hv65deQo+OnzUO7C
 Pjj0yCpumTUaN+Mp/fKI0ROQlsCl2ELjVYTvzwXDY3nzWQebyn2w5G5L3T+vRduuuob/
 CX6jcmjX6OiVLkMR/J1LHI2q3vfnmcZvkQds/BN1RKGwRdrumqJKqLBB/G+TSdn6cb6l
 wCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jzRtbCl5Ig4uAvDMrC6pwV2zzQ3A5kDBGhuZrN+504I=;
 b=BL5qoqxfwbJX3i3rCDjITfw0nL0YuU4rGV9KYNJ8EE6rQmujN7vui9oYCvxzH/x8tP
 dWZ3sPUcZAHe3tmIYzpuqdEgHmD3OROgqKBdTWUrkZ3jMrg+/Vox4I6N4Ezlq1yefHDB
 7mXTh42Nqec6Ii4+Zdahjn4CllFY2wp2ghXM7JzZu6C4kwyemf4PpxEN4q9cKNXCvtjP
 SMOvw4kWFZccYue3bVn7l2wFvs3+sXpcXoXhWSkWM60fOkRjhC7xIHDfDrDtKsqTokjT
 z7eOiv7EXuTV+eHWvMbkIICflz9APqPLwxnTNpkDQmAtPu8nzA4fb7FI0jqimwqkghMw
 lhRA==
X-Gm-Message-State: AOAM530An9k3ctqIfctHOr6QWxJtNcmZ8yvnYer6S7TRNW7vUtnuVNo1
 YBuYob31QGBkGvjJJJgEaj2HFyZyKFmq3xTcZ/k8ug==
X-Google-Smtp-Source: ABdhPJxGfcoL03kZgdPNPcVj2HgB4NkjrnAsM1gy991MEVFpjebg60Wdm64yNorqMzQk1vo7pclH13UM+IeLx5hGVD8=
X-Received: by 2002:a5d:89c5:: with SMTP id a5mr18406556iot.98.1614039969596; 
 Mon, 22 Feb 2021 16:26:09 -0800 (PST)
MIME-Version: 1.0
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
 <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
 <20210222234457.GA36153@24bbad8f3778>
 <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr>
In-Reply-To: <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Tue, 23 Feb 2021 01:25:59 +0100
Message-ID: <CAP+8YyGdr0jkf5_K8ofKMzZn5Koy_vkxyKKHkyVDqDz2sWvL_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
To: Simon Ser <contact@emersion.fr>
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
Cc: stylon.wang@amd.com, sunpeng.li@amd.com, Bhawanpreet.Lakha@amd.com,
 dri-devel@lists.freedesktop.org, Rodrigo.Siqueira@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, Nathan Chancellor <nathan@kernel.org>,
 airlied@linux.ie, aurabindo.pillai@amd.com,
 Souptick Joarder <jrdr.linux@gmail.com>, daniel@ffwll.ch,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============0375002181=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0375002181==
Content-Type: multipart/alternative; boundary="0000000000000a998005bbf5f75f"

--0000000000000a998005bbf5f75f
Content-Type: text/plain; charset="UTF-8"

I think Alex moved to gitlab for his branches

On Tue, Feb 23, 2021, 12:50 AM Simon Ser <contact@emersion.fr> wrote:

> On Tuesday, February 23rd, 2021 at 12:44 AM, Nathan Chancellor <
> nathan@kernel.org> wrote:
>
> > On Mon, Feb 22, 2021 at 11:05:17PM +0000, Simon Ser wrote:
> > > On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder <
> jrdr.linux@gmail.com> wrote:
> > >
> > > > >>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
> > > > >> warning: variable 'i' is uninitialized when used here
> > > > >> [-Wuninitialized]
> > > >                            timing  = &edid->detailed_timings[i];
> > > >                                                              ^
> > > >
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
> > > > note: initialize the variable 'i' to silence this warning
> > > >            int i;
> > > >                 ^
> > > >                  = 0
> > > >    1 warning generated.
> > > >
> > > > Initialize the variable 'i'.
> > >
> > > Hm, I see this variable already initialized in the loop:
> > >
> > >     for (i = 0; i < 4; i++) {
> > >
> > > This is the branch agd5f/drm-next.
> >
> > That is in the
> >
> >       if (amdgpu_dm_connector->dc_sink->sink_signal ==
> SIGNAL_TYPE_DISPLAY_PORT
> >               || amdgpu_dm_connector->dc_sink->sink_signal ==
> SIGNAL_TYPE_EDP) {
> >
> > branch not the
> >
> >       } else if (edid && amdgpu_dm_connector->dc_sink->sink_signal ==
> SIGNAL_TYPE_HDMI_TYPE_A) {
> >
> > branch, where i is indeed used uninitialized like clang complains about.
> >
> > I am not at all familiar with the code so I cannot say if this fix is
> > the proper one but it is definitely a legitimate issue.
>
> I think you have an outdated branch. In my checkout, i is not used in the
> first
> branch, and is initialized in the second one.
>
>
> https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c?h=drm-next#n9700
>

--0000000000000a998005bbf5f75f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I think Alex moved to gitlab for his branches</div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb =
23, 2021, 12:50 AM Simon Ser &lt;<a href=3D"mailto:contact@emersion.fr">con=
tact@emersion.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On =
Tuesday, February 23rd, 2021 at 12:44 AM, Nathan Chancellor &lt;<a href=3D"=
mailto:nathan@kernel.org" target=3D"_blank" rel=3D"noreferrer">nathan@kerne=
l.org</a>&gt; wrote:<br>
<br>
&gt; On Mon, Feb 22, 2021 at 11:05:17PM +0000, Simon Ser wrote:<br>
&gt; &gt; On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder &lt;<=
a href=3D"mailto:jrdr.linux@gmail.com" target=3D"_blank" rel=3D"noreferrer"=
>jrdr.linux@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amd=
gpu_dm.c:9804:38:<br>
&gt; &gt; &gt; &gt;&gt; warning: variable &#39;i&#39; is uninitialized when=
 used here<br>
&gt; &gt; &gt; &gt;&gt; [-Wuninitialized]<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timing=C2=A0 =3D &amp;edid-&gt;detai=
led_timings[i];<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm=
/amdgpu_dm.c:9714:7:<br>
&gt; &gt; &gt; note: initialize the variable &#39;i&#39; to silence this wa=
rning<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 0<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 1 warning generated.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Initialize the variable &#39;i&#39;.<br>
&gt; &gt;<br>
&gt; &gt; Hm, I see this variable already initialized in the loop:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 4; i++) {<br>
&gt; &gt;<br>
&gt; &gt; This is the branch agd5f/drm-next.<br>
&gt;<br>
&gt; That is in the<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_dm_connector-&gt;dc_sink-&gt;sink=
_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| amdgpu_dm_con=
nector-&gt;dc_sink-&gt;sink_signal =3D=3D SIGNAL_TYPE_EDP) {<br>
&gt;<br>
&gt; branch not the<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (edid &amp;&amp; amdgpu_dm_connect=
or-&gt;dc_sink-&gt;sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A) {<br>
&gt;<br>
&gt; branch, where i is indeed used uninitialized like clang complains abou=
t.<br>
&gt;<br>
&gt; I am not at all familiar with the code so I cannot say if this fix is<=
br>
&gt; the proper one but it is definitely a legitimate issue.<br>
<br>
I think you have an outdated branch. In my checkout, i is not used in the f=
irst<br>
branch, and is initialized in the second one.<br>
<br>
<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/a=
md/display/amdgpu_dm/amdgpu_dm.c?h=3Ddrm-next#n9700" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://cgit.freedesktop.org/~agd5f/linux/tree/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c?h=3Ddrm-next#n9700</a><br>
</blockquote></div>

--0000000000000a998005bbf5f75f--

--===============0375002181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0375002181==--

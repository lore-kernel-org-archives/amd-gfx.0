Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B3C2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 10:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2774710E3ED;
	Mon, 24 Jun 2024 10:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="T9xh5psc";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BFE10E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 10:23:52 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-25989f87e20so362142fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1719224631; x=1719829431; darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0GteOntHqAyQJZ3im4tcSJT5cszOK/zzJhA9yxiS0HM=;
 b=T9xh5psc/qMr7hMIa9l8O3PBoMWP/2iMy2ihR3QK3xuLxbaU1A1d9z6m4oyGK9eiLv
 QdY0NuoZSd/cXNHV6jeCvD+aM0RdUdA2l7PrEpapwe1xcLYp0gTfgA7I5I4KWhS/HJZa
 yxHDDbnXEmAw4JBagXKVxXQj0Lr3lGRvdy8/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224631; x=1719829431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0GteOntHqAyQJZ3im4tcSJT5cszOK/zzJhA9yxiS0HM=;
 b=mbGd0Z4mTlKejKF2wULlKNaEqWCDxgMNJqXK527wiF3ICr9MSCby88sO3Xun6FN4VE
 ScRf6a7qLy9lRSfJ1yHtpauTgNxJhKZJDmdAby+TOLsiGdjlXwRSpJEoBWQdxz/c3D7Y
 bQjbgvnBMAkfFkso0szHe0Z5pTg70+Wype+/a48hytok62A5vQgyU+9TVyWAjyLQIFgo
 T7Hx0pRTvxiR+6UKyJF7x2U7l+JVKj/ATeQ0O/sNrpZPaKmDW1V0LB50QIb7RUiCtnVG
 YPd1sTCir+E6vrEWvG8syDq2ugXtNdFsMEANB0ylILeurHV9WMsmkF1qvkxV7QAnrFQJ
 jSow==
X-Gm-Message-State: AOJu0YzYubyaARj4QPt8i8AoiS9IJeXo1BYoxU5E/BlGhLHeso9coi+n
 XymDjlDkFlToCwJ5HAXo/q7F0MQiN52JQqE7QwsZifggD00OgwDT5S6klCCSdIX9T7ytD/Iz3FF
 XTs4ooA8f/DE4tjtZbx8i+zMrBt7GITxrToDwbA==
X-Google-Smtp-Source: AGHT+IHzjUDZ/tdRR05O9z0/82wl2s3yAUz1n5Zg4Dl2o6FzWoFqkvt1efTgwvxn7iCLbeW82H8Bqj60Rk7u//vq5+Y=
X-Received: by 2002:a05:6871:3324:b0:259:862f:b898 with SMTP id
 586e51a60fabf-25cf03e224fmr6452231fac.5.1719224631205; Mon, 24 Jun 2024
 03:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240622082219.1876200-1-make24@iscas.ac.cn>
 <C5F9411A-0396-4B7F-B6D8-38F2C067283E@froggi.es>
 <a0a3169e-77f6-43e9-bb87-f25c73bf4af9@froggi.es>
In-Reply-To: <a0a3169e-77f6-43e9-bb87-f25c73bf4af9@froggi.es>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 24 Jun 2024 12:23:40 +0200
Message-ID: <CAKMK7uFgmxWYJ+XN8ZdhRgkP7wL1k_tyjxXH6=9FZBpcTPhTsg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix a possible null pointer dereference
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx@lists.freedesktop.org, Ma Ke <make24@iscas.ac.cn>, 
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
 airlied@gmail.com, srinivasan.shanmugam@amd.com, aurabindo.pillai@amd.com, 
 guchun.chen@amd.com, chenjiahao16@huawei.com
Content-Type: multipart/alternative; boundary="0000000000006ebc42061ba02d28"
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

--0000000000006ebc42061ba02d28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Jun 2024 at 14:22, Joshua Ashton <joshua@froggi.es> wrote:

> Maybe that wasn't you or whatever, but your last patch that did this got
> some CVE assigned to it that didn't really make any sense, given this is
> just a null deref that'd end up as an oops?
>
> It can only happen if the kzalloc in drm_mode_create fails.
>
> I imagine that the `continue` is not the best cause of action anyway,
> it's probably not worth adding some broken connector with a bunch of
> missing modes.
> It's just going to make things appear more broken and be unexpected to
> userspace.
>
> Maybe this is some new thing that we do now I am out of the loop on...
>

Kernel CVE handling changed a lot, for background:

 https://lwn.net/Articles/978711/

No one needs to ask for CVEs, you'll all get them pretty much automatically
for everything now.

Cheers, Sima


> - Joshie =F0=9F=90=B8=E2=9C=A8
>
> On 6/23/24 10:20 AM, Joshua Ashton wrote:
> > Are you planning on submitting a bogus CVE for this patch too?
> >
> > - Joshie =F0=9F=90=B8=E2=9C=A8
> >
> > On June 22, 2024 9:22:19 AM GMT+01:00, Ma Ke <make24@iscas.ac.cn> wrote=
:
> >> In amdgpu_connector_add_common_modes(), the return value of
> drm_cvt_mode()
> >> is assigned to mode, which will lead to a NULL pointer dereference on
> >> failure of drm_cvt_mode(). Add a check to avoid npd.
> >>
> >> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> >> ---
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> >> index 9caba10315a8..6cf946adb6fe 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> >> @@ -458,6 +458,8 @@ static void
> amdgpu_connector_add_common_modes(struct drm_encoder *encoder,
> >>                      continue;
> >>
> >>              mode =3D drm_cvt_mode(dev, common_modes[i].w,
> common_modes[i].h, 60, false, false, false);
> >> +            if (!mode)
> >> +                    continue;
> >>              drm_mode_probed_add(connector, mode);
> >>      }
> >> }
>
>

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

--0000000000006ebc42061ba02d28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Sun, 23 Jun 2024 at 14:22, Joshua Ashton &lt;<a href=3D"mailto:jo=
shua@froggi.es">joshua@froggi.es</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Maybe that wasn&#39;t you or whatever, but=
 your last patch that did this got <br>
some CVE assigned to it that didn&#39;t really make any sense, given this i=
s <br>
just a null deref that&#39;d end up as an oops?<br>
<br>
It can only happen if the kzalloc in drm_mode_create fails.<br>
<br>
I imagine that the `continue` is not the best cause of action anyway, <br>
it&#39;s probably not worth adding some broken connector with a bunch of <b=
r>
missing modes.<br>
It&#39;s just going to make things appear more broken and be unexpected to =
<br>
userspace.<br>
<br>
Maybe this is some new thing that we do now I am out of the loop on...<br><=
/blockquote><div><br></div><div>Kernel CVE handling changed a lot, for back=
ground:</div><div><br></div><div>=C2=A0<a href=3D"https://lwn.net/Articles/=
978711/">https://lwn.net/Articles/978711/</a></div><div><br></div><div>No o=
ne needs to ask for CVEs, you&#39;ll all get them pretty much automatically=
 for everything now.</div><div><br></div><div>Cheers, Sima</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
- Joshie =F0=9F=90=B8=E2=9C=A8<br>
<br>
On 6/23/24 10:20 AM, Joshua Ashton wrote:<br>
&gt; Are you planning on submitting a bogus CVE for this patch too?<br>
&gt; <br>
&gt; - Joshie =F0=9F=90=B8=E2=9C=A8<br>
&gt; <br>
&gt; On June 22, 2024 9:22:19 AM GMT+01:00, Ma Ke &lt;<a href=3D"mailto:mak=
e24@iscas.ac.cn" target=3D"_blank">make24@iscas.ac.cn</a>&gt; wrote:<br>
&gt;&gt; In amdgpu_connector_add_common_modes(), the return value of drm_cv=
t_mode()<br>
&gt;&gt; is assigned to mode, which will lead to a NULL pointer dereference=
 on<br>
&gt;&gt; failure of drm_cvt_mode(). Add a check to avoid npd.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Ma Ke &lt;<a href=3D"mailto:make24@iscas.ac.cn" tar=
get=3D"_blank">make24@iscas.ac.cn</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 ++<br>
&gt;&gt; 1 file changed, 2 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt;&gt; index 9caba10315a8..6cf946adb6fe 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c<br>
&gt;&gt; @@ -458,6 +458,8 @@ static void amdgpu_connector_add_common_modes(=
struct drm_encoder *encoder,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D drm_cvt_m=
ode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mode)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 continue;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_mode_probed_ad=
d(connector, mode);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; }<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr">Daniel Vetter<br>Software Engineer, Intel Corporation<br><a href=3D"htt=
p://blog.ffwll.ch" target=3D"_blank">http://blog.ffwll.ch</a></div></div></=
div>

--0000000000006ebc42061ba02d28--

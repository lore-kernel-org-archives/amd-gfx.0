Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127C1C7115F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 13:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D99910E3A4;
	Mon, 16 Jun 2025 13:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TOIkFy/s";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87A110E3C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 22:09:17 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-55350d0eedeso2469382e87.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749852556; x=1750457356; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/u0ZWPSj54fO1LPwsRtPsBzAv0bNs4kDvAcQ63XNs0c=;
 b=TOIkFy/sflHhcAUo8SE5CxRSyiO/DWhITJY2JTqNyWvEFkwy8DfhyuC/cU1rr1PT5G
 p0KdsJXcMzyEG/OltqfWD1HAIkzpToYd6zy6qjZw1BDmmdBeGV24lc8QjXQnO/qV2zzd
 2ncIuKtJkD+lJWxOQLtphJeaQf1p7vqXEKGfAp0LDXCmf6kBoFEClmXsgDZx/3jij+6M
 Pp+lTGNUvKz62kq5frAfXTkW1AulaJo/SHFs/oZ1v4EC9FJscqNJXopKSzn7sZNkSeRM
 9PJ61ByifP1IlXA+73i24w33iMKJJBOocxp66Q6UAW10VB/HZxWiDlegGlFjhNiWdjVE
 UBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749852556; x=1750457356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/u0ZWPSj54fO1LPwsRtPsBzAv0bNs4kDvAcQ63XNs0c=;
 b=Q7kthB8lOvUszAU95r6bn3RtXjNmL2BxTxjsy31vI/UZw0cnylZIdPBLlwCuFrHcQD
 LKFOLE006DMJHJWfhFBAkhjiPJZleseZGm0JiQ8iaH175XJmieedP36IYW+Rv6SKa/Uj
 wtF8t5Z4bKIfGslUWC2ddYCqujo3C+MR8A/vJW4nOzVMA88PhZm+EC1OUmYiEUNITpkP
 2dJ+XVOUmChIUmnZqpqfAzRnMXX6aDouqXZJdl1iTFK8eXNcTYffEl21KT/GeMohOzgZ
 lfUX/SRdPbd/0JawQRmR9z35jzutoEZUgXhia3hgtdhWkh7mqJlXdgToKGkMuRcfxhAa
 VV8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvhnr4+a/sMMVTfJT4YQ9Vhe0s9H8TNPgKVVDBL6wxFraKbg68ovrYGnExEMRQVouWnIiT8GPH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXUxtZMOvgbDW7saKZac8seS1MM8/KQzRKd+J/nMhLjHaOumJk
 QOrgOYWRaJkTk7LQOuDjzrxcOKc47bKmlLpeHmadNqEmWu/vM4IAZKLlqzbICgBJWnI4fgpJmhs
 ppOO4tGySZlGJwZ/tHVCUFZ3fO5TZ8i8=
X-Gm-Gg: ASbGncsUFx5WcpW0q7R03z3AQvzfDNjYjjY6jyRlRVImGmhzpmIrMkkc9J0ZXeu65em
 TO6mGnCJ7d6jyj8Cb5rkirTysvrh2hlbjodCEoqMUfi2xsJITLDBiO6DRIQ7I0PsbsAtZjnM7sr
 aqQMkO4B/46jhnY1YZd2EN/3NIT8dXiTTDWp2Xtqtw+9O91Bohw+Njzjk+ThGY54uv+s6ZSFmd2
 TnI
X-Google-Smtp-Source: AGHT+IGkpKIf5qdK4N/MvTV6cv41VEAat6/gwe+bBQCYNueB+b4IOpxLbGkBjDEeJckPJqOrlTnSwgeFkb2flzixecs=
X-Received: by 2002:a05:6512:3d03:b0:553:35f5:7aac with SMTP id
 2adb3069b0e04-553b6f4cd1amr197453e87.48.1749852555489; Fri, 13 Jun 2025
 15:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250613214101.4117000-1-superm1@kernel.org>
 <1240341a-d19b-4a54-b18a-a4cec00c606e@amd.com>
In-Reply-To: <1240341a-d19b-4a54-b18a-a4cec00c606e@amd.com>
From: Marcus Seyfarth <m.seyfarth@gmail.com>
Date: Sat, 14 Jun 2025 00:09:03 +0200
X-Gm-Features: AX0GCFtmOVmVcSJQicdfz1fchzKb6EJwjEfs11wzW-saJsi_sEooDtY1OFXyH5Q
Message-ID: <CA+FbhJPSoPS+uv6XAoL6gSYVB6K1TU+ToD++mUruji0px=AR1w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Adjust output for discovery error handling
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000fab7e606377b4bd9"
X-Mailman-Approved-At: Mon, 16 Jun 2025 13:10:04 +0000
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

--000000000000fab7e606377b4bd9
Content-Type: text/plain; charset="UTF-8"

Thanks for fixing this, Mario! If this optional firmware file could be made
available so that Linux distros could pick it up, this would be great.

Am Fr., 13. Juni 2025 um 23:56 Uhr schrieb Mario Limonciello <
mario.limonciello@amd.com>:

> On 6/13/2025 4:41 PM, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
> > available") added support for reading an amdgpu IP discovery bin file
> > for some specific products. If it's not found then it will fallback to
> > hardcoded values. However if it's not found there is also a lot of noise
> > about missing files and errors.
> >
> > Adjust the error handling to decrease most messages to DEBUG and to show
> > at most one message to a user about the missing file at INFO level.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
> Reported-and-tested-by Marcus Seyfarth <m.seyfarth@gmail.com>?
> > Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
> available")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
> >   1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index a0e9bf9b27108..8e4526a8c2600 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -321,10 +321,9 @@ static int
> amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
> >       const struct firmware *fw;
> >       int r;
> >
> > -     r = request_firmware(&fw, fw_name, adev->dev);
> > +     r = firmware_request_nowarn(&fw, fw_name, adev->dev);
> >       if (r) {
> > -             dev_err(adev->dev, "can't load firmware \"%s\"\n",
> > -                     fw_name);
> > +             drm_info(&adev->ddev, "Optional firmware \"%s\" was not
> found\n", fw_name);
> >               return r;
> >       }
> >
> > @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct
> amdgpu_device *adev)
> >       /* Read from file if it is the preferred option */
> >       fw_name = amdgpu_discovery_get_fw_name(adev);
> >       if (fw_name != NULL) {
> > -             dev_info(adev->dev, "use ip discovery information from
> file");
> > +             drm_dbg(&adev->ddev, "use ip discovery information from
> file");
> >               r = amdgpu_discovery_read_binary_from_file(adev,
> adev->mman.discovery_bin, fw_name);
> > -
> > -             if (r) {
> > -                     dev_err(adev->dev, "failed to read ip discovery
> binary from file\n");
> > -                     r = -EINVAL;
> > +             if (r)
> >                       goto out;
> > -             }
> > -
> >       } else {
> > +             drm_dbg(&adev->ddev, "use ip discovery information from
> memory");
> >               r = amdgpu_discovery_read_binary_from_mem(
> >                       adev, adev->mman.discovery_bin);
> >               if (r)
> > @@ -1339,7 +1334,7 @@ static int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
> >
> >       r = amdgpu_discovery_init(adev);
> >       if (r) {
> > -             DRM_ERROR("amdgpu_discovery_init failed\n");
> > +             drm_warn(&adev->ddev, "%s failed: %d\n", __func__, r);
> >               return r;
> >       }
> >
>
>

--000000000000fab7e606377b4bd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for fixing this, Mario! If this optional firmware f=
ile could be made available so that Linux distros could pick it up, this wo=
uld be great.</div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">Am Fr., 13. Juni 2025 um 23:56=C2=A0Uhr =
schrieb Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">=
mario.limonciello@amd.com</a>&gt;:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 6/13/2025 4:41 PM, Mario Limonciello wrote:<br>
&gt; From: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.co=
m" target=3D"_blank">mario.limonciello@amd.com</a>&gt;<br>
&gt; <br>
&gt; commit 017fbb6690c22 (&quot;drm/amdgpu/discovery: check ip_discovery f=
w file<br>
&gt; available&quot;) added support for reading an amdgpu IP discovery bin =
file<br>
&gt; for some specific products. If it&#39;s not found then it will fallbac=
k to<br>
&gt; hardcoded values. However if it&#39;s not found there is also a lot of=
 noise<br>
&gt; about missing files and errors.<br>
&gt; <br>
&gt; Adjust the error handling to decrease most messages to DEBUG and to sh=
ow<br>
&gt; at most one message to a user about the missing file at INFO level.<br=
>
&gt; <br>
&gt; Closes: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/431=
2" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/=
amd/-/issues/4312</a><br>
Reported-and-tested-by Marcus Seyfarth &lt;<a href=3D"mailto:m.seyfarth@gma=
il.com" target=3D"_blank">m.seyfarth@gmail.com</a>&gt;?<br>
&gt; Fixes: 017fbb6690c22 (&quot;drm/amdgpu/discovery: check ip_discovery f=
w file available&quot;)<br>
&gt; Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciel=
lo@amd.com" target=3D"_blank">mario.limonciello@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-=
----------<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index a0e9bf9b27108..8e4526a8c2600 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -321,10 +321,9 @@ static int amdgpu_discovery_read_binary_from_file=
(struct amdgpu_device *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct firmware *fw;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0r =3D request_firmware(&amp;fw, fw_name, adev-&gt=
;dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0r =3D firmware_request_nowarn(&amp;fw, fw_name, a=
dev-&gt;dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(adev-&gt;dev,=
 &quot;can&#39;t load firmware \&quot;%s\&quot;\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fw_name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_info(&amp;adev-&g=
t;ddev, &quot;Optional firmware \&quot;%s\&quot; was not found\n&quot;, fw_=
name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct amdgpu_d=
evice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Read from file if it is the preferred opt=
ion */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fw_name =3D amdgpu_discovery_get_fw_name(ade=
v);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fw_name !=3D NULL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(adev-&gt;dev=
, &quot;use ip discovery information from file&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_dbg(&amp;adev-&gt=
;ddev, &quot;use ip discovery information from file&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_dis=
covery_read_binary_from_file(adev, adev-&gt;mman.discovery_bin, fw_name);<b=
r>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(adev-&gt;dev, &quot;failed to read ip discovery binary from =
file\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0r =3D -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto out;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_dbg(&amp;adev-&gt=
;ddev, &quot;use ip discovery information from memory&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_dis=
covery_read_binary_from_mem(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0adev, adev-&gt;mman.discovery_bin);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; @@ -1339,7 +1334,7 @@ static int amdgpu_discovery_reg_base_init(struct=
 amdgpu_device *adev)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_discovery_init(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;amdgp=
u_discovery_init failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_warn(&amp;adev-&g=
t;ddev, &quot;%s failed: %d\n&quot;, __func__, r);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--000000000000fab7e606377b4bd9--

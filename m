Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9212C5DF6D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 07:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9879C10F32C;
	Fri, 14 Aug 2026 07:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VsU6j6SB";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8A910F56E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 22:22:56 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-52d7ef16f91so2714211cf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786659775; cv=none;
 d=google.com; s=arc-20260327;
 b=nEzbKMTS9KgSnXIcu2RP8MUaERKNLaxMBTy8Pjs1LZWczFTpadrhUuNXDTy1NZ/x9e
 KCrx3xQSR0FoEIcIZQ2sAlK5y+xPy5bFbPLjeuTaKca+JB/6PIgJXg5ArYJUsfdNBcNA
 PtJhm7jTwhs1g5j2dolyRyUPUYx3HAXhBqtxAtRKWvBFUubRi1mLZez+TPSHZWJQkSt6
 iBd/gbXHJVSgcaIDqZoNEr+vu04BWGjug64lu7BWdmAgwGT6NRZWLkoW5Jwukax0lYom
 9LtRlITA9duXPgXrjvVRYVbYPCue10Ghme/+5cSDyjc0noHYE5YnA53NLmLQG+a7og+D
 SkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vOLkwe+xNfoXlrGW86TL37K6WnMlRd2vLbo3lDIVQVE=;
 fh=Q4ROU+SjalM++BbKMHvlmHQA4Samr9NC2MWy+wQmGcs=;
 b=BG1ZNhlc2ug8AM+dJjZW+aSTaKZgUW/3afuIRJbx8+uLjeTmgP9DsxkN01tFtprEgO
 1nZHcOqscEpzAz3gFtOgG40WbdBZFTw99g2iSnfPE4wfj5IWjhJ2ScOWGtQEWuNabW4b
 rS3P5Rp2s/lypUtChm4IGb+6Ns9fdKGAn4s+NO3Le2fSZROsfeoKQxZBKfcmTgqENPW6
 RJeHtDBXCt2eSJ63gb+U/b56r8WW870rDvP5DevrMziJzREYCl36cqnvXDyuTWp4Rtx9
 EAm/YlD/UjbFZvRcjT0rxyYMcRTcQebDEU3VH0Klx4+vLl8s1/9KpEImMWHscSf5zSms
 QmFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786659775; x=1787264575; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vOLkwe+xNfoXlrGW86TL37K6WnMlRd2vLbo3lDIVQVE=;
 b=VsU6j6SBv7LHHIlSm9E0GEmI3MqeDnMjCRwvxGnrIuhU+hIfnf59jFYkHL0f1hNRIU
 Ctg874xDGRndYnRXmnSImrMTy8OWC7T4SGPP7JlNptawWOhqINgtfGj471ba1EuFNhQU
 RczstHuB9MXQO+06Fu8tQDYLcV5YCJKwvVCBuJTMD2+iR0KNXx2gFoGUjc6jTrUdd0Mk
 vROq4CamBPR2sZ6O85e54I2F5NB+9ibDgGeMa8stD/WWCVWGDXEEuZLnzUaJvz6CIdFf
 l9XE9cwclI9nKqHhbxX5cu2PvdmW8EZVRk8Reohsb8vAQTl8nOT6LmtQSUrx5tECxqGR
 iZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786659775; x=1787264575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vOLkwe+xNfoXlrGW86TL37K6WnMlRd2vLbo3lDIVQVE=;
 b=jvfChUvbsG6jAhlwEX15rQ3Jq6XVL6QDGmMA8hbfWTQhTiVk0TgiGSijN7IW++dTdk
 zz79PxM65c7e5b2/3bwdMrmUyfOQzAjJ/2IlonmHiTqdvL/OnQcmpkUlbw3ythAh/K4R
 lFWPNJCOtvcEINY6Fr+HLF7L37SVscfJ1wcrN3RJed642YuljSJ3n6vR7EHxQbcRQoSz
 AhJa4+TEJ7udt/h04ZVXIUq7rK1eI15ihiW2ArIbKQQk8ECpIpnDpi+su+kjAaQKUCuh
 HOMJCuaExBTG3IauecO0ZvhkEHPUW2IMDVEHkiKT/44f3US48ZmAk8Z7h31iJYtOaBgg
 cA6Q==
X-Gm-Message-State: AOJu0Yyd/iv4BCKVb4my/RKsqiVpwHfuk55xhOOb2LvIuP1VIqEA2VNz
 Rfwc4mu/IDfzk15+NGN6D9uHyxcREGUUNPrIg8RsEWZ3Ss+lQIKUMaFut0nIDnxPu7T7xxJnkzD
 nCTFH5NNIiLNz8n8dnIs6Cbj1dw2VxQGih4Bj2tm+fatsgd0Or4mzv4Xw44yf62Cy8YdOnjM=
X-Gm-Gg: AR+sD10LT+7FBhCJSVaviX7AZJgOCVlT1RbPWUT9BwpGw2p242Jkdc5d0/0IE1ECHbK
 DXOltBXxNLK17Ff5NsSpPDOJS68+cWFZBsQbJL/qx5FrK7SouozmAjXqEFozNfCf458dRwtf71+
 FoM7+Hoiump4bSvsvTQVeW4laYe9LU7b7VU/OgL9Uv8r4G+LZP5WalyyYlt9O9kLjfVf+OB8uQk
 ib5kwY1RlMnanSMkjuJ3T5BXvCfNfcs82tpdC47Pc95hOb9XU/2fE7pdl5DzpI1jIS5QJdTG2G2
 hrk4rb7L03oQjckmQgIIE1yRoRf6JaSlBoXC9Kxjh+hI+rH/GQMnFm047YaBEElJK9h/A/+GtQk
 =
X-Received: by 2002:a05:622a:3cb:b0:516:d781:589a with SMTP id
 d75a77b69052e-52d8543a302mr16945671cf.22.1786659774835; Thu, 13 Aug 2026
 15:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260813170959.22073-1-zhitaevakh@gmail.com>
 <7bb4075c-4186-4f20-8006-2e414429463a@kernel.org>
In-Reply-To: <7bb4075c-4186-4f20-8006-2e414429463a@kernel.org>
From: =?UTF-8?B?0JDRhdC80LXQtCDQltC40YLQsNC10LI=?= <zhitaevakh@gmail.com>
Date: Fri, 14 Aug 2026 03:22:44 +0500
X-Gm-Features: AUfX_mwNaT31Tyn14j8uhifzKB87BMpEx6Ply_2JIIS0-KQf4l-09O94ZXcFRRM
Message-ID: <CAGJKGUyUwJYv8=QcdSDegT3K-73Oj_U+8yOrcHHT3Mv9K0g=UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full
 range
To: superm1@kernel.org
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000036b0680658f525aa"
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:13:01 +0000
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

--00000000000036b0680658f525aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=8E=89

=D0=A0=D0=B5=D0=B0=D0=BA=D1=86=D0=B8=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8F =D0=90=D1=85=D0=BC=D0=B5=D0=B4 =
=D1=87=D0=B5=D1=80=D0=B5=D0=B7 Gmail
<https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&utm_medi=
um=3Det&utm_campaign=3Demojireactionemail#app>

=D0=BF=D1=82, 14 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3., 00:38 Mario Limo=
nciello <superm1@kernel.org>:

>
>
> On 8/13/26 12:09, Akhmed Zhitaev wrote:
> > Custom brightness curves use an 8-bit input signal.  After exporting th=
e
> > full PWM range to userspace, the curve normalizer still divides request=
s
> > by the physical PWM span.  On panels with a nonzero minimum PWM level,
> > this can produce a curve input greater than 255 and send an invalid
> > backlight level to DC.
> >
> > Scale the userspace [0..max] range to the curve's [0..255] range
> > instead.  This retains the full advertised range and keeps the reverse
> > readback conversion unchanged.
> >
> > Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to
> userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
>
> Thanks for this.
>
> We have moved the code in amd-staging-drm-next
>
>
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/6c2b46e9774f13e45985f=
6da9f7d5f8458767b98
>
> As your changes are trivial, I'll adjust while commiting.
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 40d82a3ee..533c69f0b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct
> amdgpu_dm_backlight_caps *caps,
> >       return 1;
> >   }
> >
> > -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> > -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> > +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> > +static inline u32 scale_input_to_fw(int max, u64 input)
> >   {
> > -     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max -
> min);
> > +     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
> >   }
> >
> >   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> > @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struc=
t
> amdgpu_dm_backlight_caps *cap
> >                                     unsigned int min, unsigned int max,
> >                                     uint32_t *user_brightness)
> >   {
> > -     u32 brightness =3D scale_input_to_fw(min, max, *user_brightness);
> > +     u32 brightness =3D scale_input_to_fw(max, *user_brightness);
> >       u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> >       int left, right;
> >
>
>

--00000000000036b0680658f525aa
Content-Type: text/vnd.google.email-reaction+json; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

{
  "emoji": "=F0=9F=8E=89",
  "version": 1
}
--00000000000036b0680658f525aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><p style=3D"font-size:50px;margin-top:0;margin-bottom:0">=F0=9F=8E=89<=
/p><p style=3D"margin-top:10px;margin-bottom:0">=D0=A0=D0=B5=D0=B0=D0=BA=D1=
=86=D0=B8=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=
=B5=D0=BB=D1=8F =D0=90=D1=85=D0=BC=D0=B5=D0=B4 =D1=87=D0=B5=D1=80=D0=B5=D0=
=B7 <a style=3D"color:unset;text-decoration:underline" href=3D"https://www.=
google.com/gmail/about/?utm_source=3Dgmail-in-product&amp;utm_medium=3Det&a=
mp;utm_campaign=3Demojireactionemail#app">Gmail</a></p></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">=D0=BF=D1=82, 14 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3., 00:38 Mario Li=
monciello &lt;<a href=3D"mailto:superm1@kernel.org">superm1@kernel.org</a>&=
gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 8/13/26 12:09, Akhmed Zhitaev wrote:<br>
&gt; Custom brightness curves use an 8-bit input signal.=C2=A0 After export=
ing the<br>
&gt; full PWM range to userspace, the curve normalizer still divides reques=
ts<br>
&gt; by the physical PWM span.=C2=A0 On panels with a nonzero minimum PWM l=
evel,<br>
&gt; this can produce a curve input greater than 255 and send an invalid<br=
>
&gt; backlight level to DC.<br>
&gt; <br>
&gt; Scale the userspace [0..max] range to the curve&#39;s [0..255] range<b=
r>
&gt; instead.=C2=A0 This retains the full advertised range and keeps the re=
verse<br>
&gt; readback conversion unchanged.<br>
&gt; <br>
&gt; Fixes: 8dbd72cb7900 (&quot;drm/amd/display: Export full brightness ran=
ge to userspace&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D=
"noreferrer">stable@vger.kernel.org</a><br>
&gt; Signed-off-by: Akhmed Zhitaev &lt;<a href=3D"mailto:zhitaevakh@gmail.c=
om" target=3D"_blank" rel=3D"noreferrer">zhitaevakh@gmail.com</a>&gt;<br>
<br>
Thanks for this.<br>
<br>
We have moved the code in amd-staging-drm-next<br>
<br>
<a href=3D"https://gitlab.freedesktop.org/agd5f/linux/-/commit/6c2b46e9774f=
13e45985f6da9f7d5f8458767b98" rel=3D"noreferrer noreferrer" target=3D"_blan=
k">https://gitlab.freedesktop.org/agd5f/linux/-/commit/6c2b46e9774f13e45985=
f6da9f7d5f8458767b98</a><br>
<br>
As your changes are trivial, I&#39;ll adjust while commiting.<br>
<br>
Reviewed-by: Mario Limonciello (AMD) &lt;<a href=3D"mailto:superm1@kernel.o=
rg" target=3D"_blank" rel=3D"noreferrer">superm1@kernel.org</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++=
----<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 40d82a3ee..533c69f0b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct a=
mdgpu_dm_backlight_caps *caps,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */<br>
&gt; -static inline u32 scale_input_to_fw(int min, int max, u64 input)<br>
&gt; +/* Rescale userspace [0..max] to the firmware curve&#39;s [0..255]. *=
/<br>
&gt; +static inline u32 scale_input_to_fw(int max, u64 input)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_B=
L_LEVEL, max - min);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_B=
L_LEVEL, max);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */<=
br>
&gt; @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const stru=
ct amdgpu_dm_backlight_caps *cap<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =
min, unsigned int max,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *use=
r_brightness)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u32 brightness =3D scale_input_to_fw(min, max, *u=
ser_brightness);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 brightness =3D scale_input_to_fw(max, *user_b=
rightness);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 lower_signal, upper_signal, upper_lum, lo=
wer_lum, lum;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int left, right;<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--00000000000036b0680658f525aa--

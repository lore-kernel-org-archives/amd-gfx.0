Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1060FC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 17:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DB710E2FF;
	Wed,  6 Aug 2025 17:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z2xziE19";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5489910E2FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 17:45:43 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-306ab1b63fdso118143fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Aug 2025 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754502342; x=1755107142; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ycQFpaHcUmGQjJt1IpRHlQ/10922H1d5xbA1tGDK6w=;
 b=Z2xziE19TkYsMOpckfCg+tA3z/bi9wutfUBvNl9J0GO54FClvj5N6cCG37Y/Wp4qiU
 pom1biqZ8oLeuWVzeEfunnstcFXdXwKJKIU9DpF2/4QFghnvEeCqXSDfzS9Pdnyri37W
 hYBcBA6WQQdi14Gzm4fqhDDih29zsZe6an3FOSglsjunLws82KrSm31VBFGB/CEMbBEq
 VLWcBBKXDiM1rp7GAAIQA92ybRcpS7o+u3gvKok6vI3v3n2V/JPPhhr2ybnyS40imhJp
 YfxfM6RqMDWeiApoB8HL4tl52A8OgTJ5vA0wDmGamlt0/y/DwKCgYuEFRDrOUZP4BdqH
 oysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754502342; x=1755107142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ycQFpaHcUmGQjJt1IpRHlQ/10922H1d5xbA1tGDK6w=;
 b=RBm//RzhqjY6wxeQPy8kP1zZzbdloa9nIbwQLAS6nqFvkQxEuJ3SNZGFvIvUjQYAQh
 gtmd4iB3piTnxjOnxL3TlGEtOnjgO5ygsc8L64tWhdcEaYvIe3n6GHVdo9gC6Awu4aQQ
 CQn50SmDhC0hkaixExRXxVyZ9iB3wA7CAdS7+pTJlTkolnYqYMI2EZsDV7N+fwodXB0X
 GJhvRiiqxChTvFjAurux8Ka0ZiZ62gVZnLXeBfEjzOhMT3bf3MHFYTGKyBp3unWvnd+y
 bxzALrFIQsc3kCPujaPp2RO5CZrBTTlmwjj1YjUXqs40P2zUBYm4m5vqJhV50+ln8svT
 2Brg==
X-Gm-Message-State: AOJu0YxKYaBHKl+stz5f9Zg3S4voPaQGSfm2NMfYXBkLwymQ3PHIYyMr
 YibdlDjEeJhEuXi4MZgTGDoalIdbJ2oOn4xL2sFV9LR20Q/X4r5FzfTwt4oZNZwM7pT5WczR8ac
 2l/7h8dGfsUMyY3NLsABiH3/9rs7kax8=
X-Gm-Gg: ASbGncvY8Fc1s0d7ozkT1Nm15xZ0CT4Je8SFfwkFtDpvBaoK6cGQYPJqYkSRyYDpnDX
 n/dAOvY2yWCuWaoqYw1TCUyVTZYKf4PIQw4p5tZWqIuoENmIgTPMAnwzfKpcs54KIZdnDruaCHF
 5rnZ4eJb3K2BJbG2oWNVKu9BH9N5ucwHNSwoeYq/7sxfkK8RiOMyEccJWlX9kJBKErxYs0cHSL0
 Bjq3ONuxAxD32AxNXMPGkoSOrVBXA==
X-Google-Smtp-Source: AGHT+IH7+D+9lH71eaOpF50keyz8kTFi5azdPwoTTgwPkFWXjD2ngNF9XCx601TRK6Rcx2EQfUKd2ss3pXiQVp0NVUc=
X-Received: by 2002:a05:6870:2046:b0:30b:dc26:41c4 with SMTP id
 586e51a60fabf-30be60c9b9dmr1910771fac.40.1754502342359; Wed, 06 Aug 2025
 10:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <fba517c2-2626-41f7-a09d-31fd028e1aa9@amd.com>
In-Reply-To: <fba517c2-2626-41f7-a09d-31fd028e1aa9@amd.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Wed, 6 Aug 2025 19:45:31 +0200
X-Gm-Features: Ac12FXzhUwoMm8pLof5XwAvu4HzqI9Z95Lihu9basbUFaq_xoXXSwcRWhcdjpBE
Message-ID: <CAFF-SiUuwwz09Vz90HOTuCcdUt5DXgFLR5EkxWUO1V7uDEOnbA@mail.gmail.com>
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type more
 accurately
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000dfbdd2063bb5e844"
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

--000000000000dfbdd2063bb5e844
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Harry Wentland <harry.wentland@amd.com> ezt =C3=ADrta (id=C5=91pont: 2025. =
aug. 6.,
Sze 16:56):

> On 2025-07-23 11:57, Timur Krist=C3=B3f wrote:
> > Previously, DC determined the DRM connector type based on the
> > signal type, which becomes problematic when a connector may
> > support different signal types, such as DVI-I.
> >
> > With this patch, it is now determined according to the actual
> > connector type in DC, meaning it can now distinguish between
> > DVI-D and DVI-I connectors.
> >
> > A subsequent commit will enable polling for these connectors.
> >
>
> Hi Timur,
>
> this patch regresses the kms_bw IGT test with Navi 31 and 48
> with a single 4k60 DP display connected. These subtests fail
> when they should pass:
>
> linear-tiling-2-displays-1920x1080p
> linear-tiling-2-displays-2160x1440p
> linear-tiling-2-displays-2560x1440p
> linear-tiling-2-displays-3840x2160p
> linear-tiling-3-displays-1920x1080p
> linear-tiling-3-displays-2160x1440p
> linear-tiling-3-displays-2560x1440p
> linear-tiling-3-displays-3840x2160p
> linear-tiling-4-displays-1920x1080p
> linear-tiling-4-displays-2160x1440p
> linear-tiling-4-displays-2560x1440p
> linear-tiling-4-displays-3840x2160p
>
> We confirmed with a revert of this patch.
>
> Harry
>

Hi Harry,

Also, can you please help me figure out how do I reproduce this on my own?

At the moment I don't see what is there that would make a difference to
Navi 31 or 48.

Thanks,
Timur



> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 096b23ad4845..c347b232ae06 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -8038,24 +8038,26 @@ static int
> dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
> >       return 0;
> >  }
> >
> > -static int to_drm_connector_type(enum signal_type st)
> > +static int to_drm_connector_type(uint32_t connector_id)
> >  {
> > -     switch (st) {
> > -     case SIGNAL_TYPE_HDMI_TYPE_A:
> > +     switch (connector_id) {
> > +     case CONNECTOR_ID_HDMI_TYPE_A:
> >               return DRM_MODE_CONNECTOR_HDMIA;
> > -     case SIGNAL_TYPE_EDP:
> > +     case CONNECTOR_ID_EDP:
> >               return DRM_MODE_CONNECTOR_eDP;
> > -     case SIGNAL_TYPE_LVDS:
> > +     case CONNECTOR_ID_LVDS:
> >               return DRM_MODE_CONNECTOR_LVDS;
> > -     case SIGNAL_TYPE_RGB:
> > +     case CONNECTOR_ID_VGA:
> >               return DRM_MODE_CONNECTOR_VGA;
> > -     case SIGNAL_TYPE_DISPLAY_PORT:
> > -     case SIGNAL_TYPE_DISPLAY_PORT_MST:
> > +     case CONNECTOR_ID_DISPLAY_PORT:
> >               return DRM_MODE_CONNECTOR_DisplayPort;
> > -     case SIGNAL_TYPE_DVI_DUAL_LINK:
> > -     case SIGNAL_TYPE_DVI_SINGLE_LINK:
> > +     case CONNECTOR_ID_SINGLE_LINK_DVID:
> > +     case CONNECTOR_ID_DUAL_LINK_DVID:
> >               return DRM_MODE_CONNECTOR_DVID;
> > -     case SIGNAL_TYPE_VIRTUAL:
> > +     case CONNECTOR_ID_SINGLE_LINK_DVII:
> > +     case CONNECTOR_ID_DUAL_LINK_DVII:
> > +             return DRM_MODE_CONNECTOR_DVII;
> > +     case CONNECTOR_ID_VIRTUAL:
> >               return DRM_MODE_CONNECTOR_VIRTUAL;
> >
> >       default:
> > @@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct
> amdgpu_display_manager *dm,
> >                       link->link_enc->features.dp_ycbcr420_supported ?
> true : false;
> >               break;
> >       case DRM_MODE_CONNECTOR_DVID:
> > +     case DRM_MODE_CONNECTOR_DVII:
> > +     case DRM_MODE_CONNECTOR_VGA:
> >               aconnector->base.polled =3D DRM_CONNECTOR_POLL_HPD;
> >               break;
> >       default:
> > @@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct
> amdgpu_display_manager *dm,
> >               goto out_free;
> >       }
> >
> > -     connector_type =3D to_drm_connector_type(link->connector_signal);
> > +     connector_type =3D to_drm_connector_type(link->link_id.id);
> >
> >       res =3D drm_connector_init_with_ddc(
> >                       dm->ddev,
>
>

--000000000000dfbdd2063bb5e844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote gmail_quote_container"=
><div dir=3D"ltr" class=3D"gmail_attr">Harry Wentland &lt;<a href=3D"mailto=
:harry.wentland@amd.com">harry.wentland@amd.com</a>&gt; ezt =C3=ADrta (id=
=C5=91pont: 2025. aug. 6., Sze 16:56):<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">On 2025-07-23 11:57, Timur Krist=C3=B3f wrote:<br>
&gt; Previously, DC determined the DRM connector type based on the<br>
&gt; signal type, which becomes problematic when a connector may<br>
&gt; support different signal types, such as DVI-I.<br>
&gt; <br>
&gt; With this patch, it is now determined according to the actual<br>
&gt; connector type in DC, meaning it can now distinguish between<br>
&gt; DVI-D and DVI-I connectors.<br>
&gt; <br>
&gt; A subsequent commit will enable polling for these connectors.<br>
&gt; <br>
<br>
Hi Timur,<br>
<br>
this patch regresses the kms_bw IGT test with Navi 31 and 48<br>
with a single 4k60 DP display connected. These subtests fail<br>
when they should pass:<br>
<br>
linear-tiling-2-displays-1920x1080p<br>
linear-tiling-2-displays-2160x1440p<br>
linear-tiling-2-displays-2560x1440p<br>
linear-tiling-2-displays-3840x2160p<br>
linear-tiling-3-displays-1920x1080p<br>
linear-tiling-3-displays-2160x1440p<br>
linear-tiling-3-displays-2560x1440p<br>
linear-tiling-3-displays-3840x2160p<br>
linear-tiling-4-displays-1920x1080p<br>
linear-tiling-4-displays-2160x1440p<br>
linear-tiling-4-displays-2560x1440p<br>
linear-tiling-4-displays-3840x2160p<br>
<br>
We confirmed with a revert of this patch.<br>
<br>
Harry<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Hi Harry,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Also, can=
 you please help me figure out how do I reproduce this on my own?</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">At the moment I don&#39;t see wha=
t is there that would make a difference to Navi 31 or 48.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Timur</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
&gt; Signed-off-by: Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@=
gmail.com" target=3D"_blank" rel=3D"noreferrer">timur.kristof@gmail.com</a>=
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--=
------<br>
&gt;=C2=A0 1 file changed, 16 insertions(+), 12 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 096b23ad4845..c347b232ae06 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -8038,24 +8038,26 @@ static int dm_update_mst_vcpi_slots_for_dsc(st=
ruct drm_atomic_state *state,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static int to_drm_connector_type(enum signal_type st)<br>
&gt; +static int to_drm_connector_type(uint32_t connector_id)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0switch (st) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_HDMI_TYPE_A:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (connector_id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_HDMI_TYPE_A:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_=
CONNECTOR_HDMIA;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_EDP:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_EDP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_=
CONNECTOR_eDP;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_LVDS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_LVDS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_=
CONNECTOR_LVDS;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_RGB:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_VGA:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_=
CONNECTOR_VGA;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_DISPLAY_PORT:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_DISPLAY_PORT_MST:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_DISPLAY_PORT:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_=
CONNECTOR_DisplayPort;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_DVI_DUAL_LINK:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_DVI_SINGLE_LINK:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_SINGLE_LINK_DVID:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_DUAL_LINK_DVID:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_=
CONNECTOR_DVID;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0case SIGNAL_TYPE_VIRTUAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_SINGLE_LINK_DVII:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_DUAL_LINK_DVII:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_CONNE=
CTOR_DVII;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case CONNECTOR_ID_VIRTUAL:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DRM_MODE_=
CONNECTOR_VIRTUAL;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; @@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct amdg=
pu_display_manager *dm,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0link-&gt;link_enc-&gt;features.dp_ycbcr420_supported ? true : =
false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_MODE_CONNECTOR_DVID:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case DRM_MODE_CONNECTOR_DVII:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case DRM_MODE_CONNECTOR_VGA:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aconnector-&gt;b=
ase.polled =3D DRM_CONNECTOR_POLL_HPD;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; @@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct amdgp=
u_display_manager *dm,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0connector_type =3D to_drm_connector_type(link-&gt=
;connector_signal);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0connector_type =3D to_drm_connector_type(link-&gt=
;<a href=3D"http://link_id.id" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">link_id.id</a>);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D drm_connector_init_with_ddc(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0dm-&gt;ddev,<br>
<br>
</blockquote></div></div></div>

--000000000000dfbdd2063bb5e844--

Return-Path: <SRS0=6ugq=JI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB1FC433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Apr 2021 22:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDF0601FB
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Apr 2021 22:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDF0601FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B55489FCC;
	Sun, 11 Apr 2021 22:20:59 +0000 (UTC)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8281889FCC
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Apr 2021 22:20:58 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id n4so9359351ili.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Apr 2021 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hY6EDpg4Xx51gU0CCi9s8gkcqaMXnATRd0DghVhDyHY=;
 b=eXpqYWu2tvfyL8/ZwikOAgI73T08oePXYWDnMOcTyc9VuBmwWsnmBa3Lv4FzD7OYcS
 UOWMqiAYi0CoCIN8WUCFFQPop13tX1zrf37XPyoKQwZ2q+i4CXtjGuB2r5KcsumcPaOq
 3SrGyS4EtghTLWqD1JKRhSuPsohK0BlZcGq3ztLCVteMiiC7PtRvh0JTHdbEt6zf9RWt
 Tb6VX0LPq8u25CuM3KqTl87NAzM+yFxxIqGVrcFm6ojpnjMgXMVufL5Y13aitMkzTuRs
 HFaGyQnKX6C0Z0ZEXzg5MD+4EtpycyIqqXTLYS9/IRQUyyR+syfCYQe8uRXET40r2bOh
 4KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hY6EDpg4Xx51gU0CCi9s8gkcqaMXnATRd0DghVhDyHY=;
 b=sQV8IKl2CvfOt/WCjG65tmAELVzPV02EyyWQX39cJNuH8C3hwS+1GUUOVscq85Ss9A
 Nmf14fOO3Cjp5vStVDVeboUakGD4z4o4M3bLRauDABXTsOAIIi7PruMJu+f4SsPU6gNc
 G9HSAxePzjHU+rHiNioeFyAXKUsuG8wSYbl/OV+zlidFve2ictmuNMvF1CuRyvyR4DQ6
 yNkutCL+atZtecJvgqz518mMDrv5XGco+SCLDxEYaTWJOTuD/bwg5ouq+sVwQZcJcuEW
 o1wKT7MFMzuITh19jnvW7hSN6oFv5i6EWKgSdVXG/SHiqINaAzTxI12TK2S9dw+F4KyG
 YxVw==
X-Gm-Message-State: AOAM532aCFp4cULddiFgmeS5ZPN8NK4iYwDtvl3TyTZG2Z1JEaPDAeGQ
 cAwhsejzuUmYnqa94hcawcKJHJX7jTbtsQqpJK1Chw==
X-Google-Smtp-Source: ABdhPJxKdxtdT+4GxlzJzkVb3robbKbklWCuO5S9YWy7Zucj1r2RnhPla2Yp6gonrVaXpzqxJPWv7sohtRqLAouSfSo=
X-Received: by 2002:a92:d68a:: with SMTP id p10mr4059956iln.40.1618179657960; 
 Sun, 11 Apr 2021 15:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210326165944.1310-1-contact@emersion.fr>
 <YsPGje8t2-fY1GTI6waUph1jQzm5WtagjUUi0lFy3Q7_I20gG8Ln1bIBqi00nj5RMzdkFhrftPbUrpqwrV2bSvEJbDD8IG9dPHAaZNTLQM8=@emersion.fr>
In-Reply-To: <YsPGje8t2-fY1GTI6waUph1jQzm5WtagjUUi0lFy3Q7_I20gG8Ln1bIBqi00nj5RMzdkFhrftPbUrpqwrV2bSvEJbDD8IG9dPHAaZNTLQM8=@emersion.fr>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 12 Apr 2021 00:20:41 +0200
Message-ID: <CAP+8YyHeiB5OyTgQkTAuFv1MhP7ZpeLqmZe9oHBj5f0ez6Pa3Q@mail.gmail.com>
Subject: Re: amd/display: allow non-linear multi-planar formats
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1694092029=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1694092029==
Content-Type: multipart/alternative; boundary="000000000000b2279405bfb9cf86"

--000000000000b2279405bfb9cf86
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

On Fri, Apr 9, 2021 at 3:19 PM Simon Ser <contact@emersion.fr> wrote:

> Hi,
>
> Can you have a look at this patch?
>
> Thanks,
>
> Simon
>
> On Friday, March 26th, 2021 at 5:59 PM, Simon Ser <contact@emersion.fr>
> wrote:
>
> > Accept non-linear buffers which use a multi-planar format, as long
> > as they don't use DCC.
> >
> > Tested on GFX9 with NV12.
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 36ee52104007..66e3ecf123d1 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4216,13 +4216,6 @@ static bool dm_plane_format_mod_supported(struct
> drm_plane *plane,
> >       if (modifier == DRM_FORMAT_MOD_LINEAR)
> >               return true;
> >
> > -     /*
> > -      * The arbitrary tiling support for multiplane formats has not
> been hooked
> > -      * up.
> > -      */
> > -     if (info->num_planes > 1)
> > -             return false;
> > -
> >       /*
> >        * For D swizzle the canonical modifier depends on the bpp, so
> check
> >        * it here.
> > @@ -4241,6 +4234,10 @@ static bool dm_plane_format_mod_supported(struct
> drm_plane *plane,
> >               /* Per radeonsi comments 16/64 bpp are more complicated. */
> >               if (info->cpp[0] != 4)
> >                       return false;
> > +             /* We support multi-planar formats, but not when combined
> with
> > +              * additional DCC metadata planes. */
> > +             if (info->num_planes > 1)
> > +                     return false;
> >       }
> >
> >       return true;
>

--000000000000b2279405bfb9cf86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@b=
asnieuwenhuizen.nl">bas@basnieuwenhuizen.nl</a>&gt;<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 9, 2021 =
at 3:19 PM Simon Ser &lt;<a href=3D"mailto:contact@emersion.fr">contact@eme=
rsion.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi,<br>
<br>
Can you have a look at this patch?<br>
<br>
Thanks,<br>
<br>
Simon<br>
<br>
On Friday, March 26th, 2021 at 5:59 PM, Simon Ser &lt;<a href=3D"mailto:con=
tact@emersion.fr" target=3D"_blank">contact@emersion.fr</a>&gt; wrote:<br>
<br>
&gt; Accept non-linear buffers which use a multi-planar format, as long<br>
&gt; as they don&#39;t use DCC.<br>
&gt;<br>
&gt; Tested on GFX9 with NV12.<br>
&gt;<br>
&gt; Signed-off-by: Simon Ser &lt;<a href=3D"mailto:contact@emersion.fr" ta=
rget=3D"_blank">contact@emersion.fr</a>&gt;<br>
&gt; Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" targ=
et=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; Cc: Harry Wentland &lt;<a href=3D"mailto:hwentlan@amd.com" target=3D"_=
blank">hwentlan@amd.com</a>&gt;<br>
&gt; Cc: Nicholas Kazlauskas &lt;<a href=3D"mailto:nicholas.kazlauskas@amd.=
com" target=3D"_blank">nicholas.kazlauskas@amd.com</a>&gt;<br>
&gt; Cc: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen.nl" t=
arget=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-----=
--<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 36ee52104007..66e3ecf123d1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -4216,13 +4216,6 @@ static bool dm_plane_format_mod_supported(struc=
t drm_plane *plane,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 * The arbitrary tiling support for multiplane fo=
rmats has not been hooked<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 * up.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (info-&gt;num_planes &gt; 1)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * For D swizzle the canonical modifier depe=
nds on the bpp, so check<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it here.<br>
&gt; @@ -4241,6 +4234,10 @@ static bool dm_plane_format_mod_supported(struc=
t drm_plane *plane,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Per radeonsi =
comments 16/64 bpp are more complicated. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info-&gt;cpp=
[0] !=3D 4)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We support multi-p=
lanar formats, but not when combined with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * additional DCC met=
adata planes. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info-&gt;num_plan=
es &gt; 1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
</blockquote></div>

--000000000000b2279405bfb9cf86--

--===============1694092029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1694092029==--

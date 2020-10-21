Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2AFC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 20:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7572324180
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 20:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhyyYsOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572324180
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABEB6F4D1;
	Wed, 21 Oct 2020 20:11:06 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064286F4D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 20:11:06 +0000 (UTC)
Received: by mail-pl1-x642.google.com with SMTP id w11so1788323pll.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Ut+9my+pGC+jQOYwhLzNC+K3MaYWx/namoyXGu2sHM=;
 b=lhyyYsOdw611sFxYRvGTbjCJjyWn+/rl63Zy8ubrAP7raR3YkMHn8VdkKoDvsiM7pe
 mOs4vu3t8cCC8466KyqHRPXmN9hNj7luhmi/VQyIGP4wesTp577WluSS/437la4bFqjm
 qQlKL/EfruW5NIRT2b5+lmjI/uE1VVzDOGzjAUlzZuzHYh2/9H2ZO9Y2ArD0Rm4/K/Fw
 JixGO1E/YZqsfQyMhDPoo7KhPLhmwaaOEIawn4EEyTxkSKJ+Uz+QNhRM6tG2kN6uiEK5
 ol4t1/BfPKGi9ZDT9iAAGEzZh5wByUHeoMPsi/kQm01y/3wHDEj301c/JKeQWk3cZlin
 ifdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Ut+9my+pGC+jQOYwhLzNC+K3MaYWx/namoyXGu2sHM=;
 b=FecyA0XjPLaPR07cRRRv/t+S7g5R/rhaZwppwNbZpXJwmklNap464o6wHs4uZlMwfF
 AUm9s7YuiTAVHnAl/HAqwEYPKi0T7Be5Q1WKdn4dyxsa4VZvfm8MwUXRKWqh7FKdfVtC
 MlMueMXgJ3u55fEaWm/Zs/asPNZrnz5E8K5mvSbBbF8UR6p1y2l6momGNGAnc8ajEYmg
 F9Zq76BU89Ufitn8cz5QdIr3ilboSSf5gRA0VHBGMw2nhBKWLhi+ObklND/qtgo5d577
 LiZJV3UBYjodWWh5Du9w0+HoNNfRdeFO1ZmwIV4KPTFMTfBISih9RPtW8h2u0sIb87In
 YZzA==
X-Gm-Message-State: AOAM532ypAbfHrfHl+7p5kEPAv4y53HupwNi9RWAQU4mu7t/al2+im5N
 Rffhl24CyCDx01/3lGxM/RcF9/TpDYMYXIvFdWGxD9Z1QGY=
X-Google-Smtp-Source: ABdhPJyXyFwjx+leRvPrQhd4ypwOUPRb/cxTsr5KB/9aJxPgCupuIfOlWKoO3bZQkAth6GJP3GkcFUCmCyTYBR4094o=
X-Received: by 2002:a17:90a:348e:: with SMTP id
 p14mr4896428pjb.75.1603311065642; 
 Wed, 21 Oct 2020 13:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201020223113.310402-1-bas@basnieuwenhuizen.nl>
 <20201021160922.210403-1-harry.wentland@amd.com>
 <CAP+8YyEqPkA6TPTuZG5+jWYppcuYX9yXyk_RAAw_FCeZEZ6U0A@mail.gmail.com>
In-Reply-To: <CAP+8YyEqPkA6TPTuZG5+jWYppcuYX9yXyk_RAAw_FCeZEZ6U0A@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 21 Oct 2020 16:10:29 -0400
Message-ID: <CAAxE2A4fj69=2rg9f-PvuJdAdeJHTQ8DPztQ-aUT1v9dj+UtSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Interpret log_2(0) as 0
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Roman.Li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0655257433=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0655257433==
Content-Type: multipart/alternative; boundary="00000000000088399e05b233f217"

--00000000000088399e05b233f217
Content-Type: text/plain; charset="UTF-8"

num_pkrs is a hardware config parameter like the number of shader engines.
It's constant for each chip.

Marek

On Wed, Oct 21, 2020 at 12:39 PM Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
wrote:

> On Wed, Oct 21, 2020 at 6:09 PM Harry Wentland <harry.wentland@amd.com>
> wrote:
> >
> > Even though log(0) is technically undefined our code assumes that
> > log_2(0) is 0. This mirrors the current behavior of our log_2
> > implementation on non-Linux platforms.
> >
> > Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> > ---
> >
> > What's num_pkrs value is upstream Mesa providing for CHIP_VANGOGH?
>
> So mesa isn't quite providing a num_pkrs value to the HW as the render
> HW doesn't require you to set one, it assumes something.
>
> In practice mesa still uses num_pkrs, which is provided by a readback
> of the GB_ADDR_CFG(CONFIG?) register info provided by the kernel. This
> can be used for e.g. determining texture coordinates (like we do for
> the displayable DCC transform) but otherwise isn't really needed,
> since the tile size for texture allocation is not dependent on
> num_pkrs.
>
> so outside of displayable DCC I think you'd be able to get far in mesa
> with a wrong num_pkrs.
>
> >
> > I saw that problem at bringup with an internal Mesa and had this fix
> > for it.
> >
> > Harry
> >
> >  drivers/gpu/drm/amd/display/dc/basics/conversion.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.h
> b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
> > index ade785c4fdc7..da9883ec7b1c 100644
> > --- a/drivers/gpu/drm/amd/display/dc/basics/conversion.h
> > +++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.h
> > @@ -40,7 +40,11 @@ void convert_float_matrix(
> >
> >  static inline unsigned int log_2(unsigned int num)
> >  {
> > -       return ilog2(num);
> > +       /*
> > +        * Technically log(0) is undefined, but our code is structured
> > +        * in a way that assumes log(0) = 0
> > +        */
> > +       return num ? ilog2(num) : num;
> >  }
> >
> >  #endif
> > --
> > 2.28.0
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000088399e05b233f217
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>num_pkrs is a hardware config parameter like the numb=
er of shader engines. It&#39;s constant for each chip.<br></div><div><br></=
div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Oct 21, 2020 at 12:39 PM Bas Nieuwenhuizen =
&lt;<a href=3D"mailto:bas@basnieuwenhuizen.nl">bas@basnieuwenhuizen.nl</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On We=
d, Oct 21, 2020 at 6:09 PM Harry Wentland &lt;<a href=3D"mailto:harry.wentl=
and@amd.com" target=3D"_blank">harry.wentland@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Even though log(0) is technically undefined our code assumes that<br>
&gt; log_2(0) is 0. This mirrors the current behavior of our log_2<br>
&gt; implementation on non-Linux platforms.<br>
&gt;<br>
&gt; Signed-off-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland@amd=
.com" target=3D"_blank">harry.wentland@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;<br>
&gt; What&#39;s num_pkrs value is upstream Mesa providing for CHIP_VANGOGH?=
<br>
<br>
So mesa isn&#39;t quite providing a num_pkrs value to the HW as the render<=
br>
HW doesn&#39;t require you to set one, it assumes something.<br>
<br>
In practice mesa still uses num_pkrs, which is provided by a readback<br>
of the GB_ADDR_CFG(CONFIG?) register info provided by the kernel. This<br>
can be used for e.g. determining texture coordinates (like we do for<br>
the displayable DCC transform) but otherwise isn&#39;t really needed,<br>
since the tile size for texture allocation is not dependent on<br>
num_pkrs.<br>
<br>
so outside of displayable DCC I think you&#39;d be able to get far in mesa<=
br>
with a wrong num_pkrs.<br>
<br>
&gt;<br>
&gt; I saw that problem at bringup with an internal Mesa and had this fix<b=
r>
&gt; for it.<br>
&gt;<br>
&gt; Harry<br>
&gt;<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/dc/basics/conversion.h | 6 +++++-<br=
>
&gt;=C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.h b/driv=
ers/gpu/drm/amd/display/dc/basics/conversion.h<br>
&gt; index ade785c4fdc7..da9883ec7b1c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/basics/conversion.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.h<br>
&gt; @@ -40,7 +40,11 @@ void convert_float_matrix(<br>
&gt;<br>
&gt;=C2=A0 static inline unsigned int log_2(unsigned int num)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return ilog2(num);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Technically log(0) is undefined, but ou=
r code is structured<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * in a way that assumes log(0) =3D 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return num ? ilog2(num) : num;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 #endif<br>
&gt; --<br>
&gt; 2.28.0<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--00000000000088399e05b233f217--

--===============0655257433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0655257433==--

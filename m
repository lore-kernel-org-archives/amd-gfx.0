Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9DCC46CD3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 02:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B4EC10E205;
	Wed, 27 Dec 2023 02:49:24 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F4A10E204
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 02:49:23 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d2e5e8d1dso60058505e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 18:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703645361; x=1704250161; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZA5+ft5q+NJAnLwYpRj+gGbX8eYwNRf0hXdKI0vEkU=;
 b=Nc26LteroSnnQvAWzbv7Kv+ptKfQyfuBgtxSTpOcO8xqTW0t2sXU7mtp5Z9PTo4XJm
 Yfk5ykf3sOluk20yZkBXbS9vOHzCl8NJ5ddd9afZndR4WrDMWYRaOrCj7AWQ305YtFXg
 l7btYCuxk0fHM9Xo+xdhHXBjiqNpqnyzpaZtfm7NMtECIPg2UlpOGEw9xHoXeA3qh/PL
 pTXOKxzvgNxT5xugyazyOsMOYmMwkf9EsLCxllaUmt53r01/praFFuaBQXcLeSkfYByb
 hW/2q3QVwNXxKH2IG640n5ZFHilk7g7oglcWqXVRGg6KU0tx1v32CZzdvXHh1Vi/zpGS
 ZAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703645361; x=1704250161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ZA5+ft5q+NJAnLwYpRj+gGbX8eYwNRf0hXdKI0vEkU=;
 b=B0q8jG9j2DSF92YxVCXuI6bYCMaJOQ9W/IZEOUekY1ZA3xAPTPdik8fDmYYBCn8nP1
 vb3V2nCkcbYvqtpiN3gUkq1+eJ9iP//IWsl9bC+sCbGkV66iivTRmB5+vk0AQyYUMf+O
 cSpVvDEXzr11QbqyWRbJTZ0TYKR9oGrXbfKB17bbdakDrYlV/Zqv7+OwtnU+RDHuDjQ1
 ru/C5SvkDjU88msGEebiMhosmiqOu8RqoOdtS2j6aq/evHO7QCiqf3L1BxKPjuaSVBl4
 +PzZsR2z1oFE8AfBWa1QJ1qRg6TFYU99vAb5GpYs/y5GSzvJ0Oq7ZuuLF3MIXaku3i4C
 OXhw==
X-Gm-Message-State: AOJu0YxQRQ0zf6J6zfFMa6HZV+QPRj9In9JAS/tnSBQoV3frHydxyxOt
 Xd374xOcGXGfNZ8jWnyOWdHzyylK5AbTIIl5yLHp9zBpk2c=
X-Google-Smtp-Source: AGHT+IGN6Pz0nzwxSyE53iFFTNVu6bH8SMifWCmXb0xo6Q9SuOJRFM1le30Uw9GP5ibLYCs1HX581bmbWQ+kNZ1ngIA=
X-Received: by 2002:a05:600c:a004:b0:40d:2fad:2c53 with SMTP id
 jg4-20020a05600ca00400b0040d2fad2c53mr3039383wmb.253.1703645361227; Tue, 26
 Dec 2023 18:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20231226235741.4376-1-marcelomspessoto@gmail.com>
 <ZYuMRZU85plJiVWO@archie.me>
In-Reply-To: <ZYuMRZU85plJiVWO@archie.me>
From: Marcelo Mendes <marcelomspessoto@gmail.com>
Date: Tue, 26 Dec 2023 23:49:09 -0300
Message-ID: <CAB4W1t5GsDUEUT6m_qHeEBC=gnQxyebY8W0n5uF1GGAh5yLgtw@mail.gmail.com>
Subject: Re: [PATCH] Removing duplicate copyright text
To: Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000944b5c060d74d869"
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000944b5c060d74d869
Content-Type: text/plain; charset="UTF-8"

Hello Bagas,

I'm sorry for that. I will send another mail of this patch with your
recommendations.


Em ter., 26 de dez. de 2023 23:30, Bagas Sanjaya <bagasdotme@gmail.com>
escreveu:

> On Tue, Dec 26, 2023 at 08:57:41PM -0300, Marcelo Mendes Spessoto Junior
> wrote:
> > Signed-off-by: Marcelo Mendes Spessoto Junior <
> marcelomspessoto@gmail.com>
> >
> > The file display/modules/inc/mod_freesync.h has two identical AMD
> > Copyright texts. This simple patch aims to remove the duplicate one.
>
> Hi Marcelo,
>
> The patch subject should have a subsystem prefix (e.g. the full subject
> should have been "[PATCH] drm/amdgpu: mod_freesync: Remove duplicate
> copyright boilerplate").
>
> For patch description, I'd like to write it as "mod_freesync header file
> has duplicated copyright boilerplate. Drop the duplicate". And make
> sure that your Signed-off-by: trailer is on the bottom of description,
> before triple dashes (`git commit -s` does it for you).
>
> >
> > ---
> >  .../amd/display/modules/inc/mod_freesync.h    | 28 -------------------
> >  1 file changed, 28 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > index afe1f6cce..cc3dc9b58 100644
> > --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> > @@ -1,31 +1,3 @@
> > -/*
> > - * Copyright 2016 Advanced Micro Devices, Inc.
> > - *
> > - * Permission is hereby granted, free of charge, to any person
> obtaining a
> > - * copy of this software and associated documentation files (the
> "Software"),
> > - * to deal in the Software without restriction, including without
> limitation
> > - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> > - * and/or sell copies of the Software, and to permit persons to whom the
> > - * Software is furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice shall be
> included in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> > - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> > - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > - * OTHER DEALINGS IN THE SOFTWARE.
> > - *
> > - * Authors: AMD
> > - *
> > - */
> > -
> > -
> > -
> > -
> >  /*
> >   * Copyright 2016 Advanced Micro Devices, Inc.
> >   *
>
> The diff itself LGTM.
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
>

--000000000000944b5c060d74d869
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Bagas,<div dir=3D"auto"><br></div><div dir=3D"auto"=
>I&#39;m sorry for that. I will send another mail of this patch with your r=
ecommendations.</div><div dir=3D"auto"><br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Em ter., 26 de dez. de 202=
3 23:30, Bagas Sanjaya &lt;<a href=3D"mailto:bagasdotme@gmail.com">bagasdot=
me@gmail.com</a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On T=
ue, Dec 26, 2023 at 08:57:41PM -0300, Marcelo Mendes Spessoto Junior wrote:=
<br>
&gt; Signed-off-by: Marcelo Mendes Spessoto Junior &lt;<a href=3D"mailto:ma=
rcelomspessoto@gmail.com" target=3D"_blank" rel=3D"noreferrer">marcelomspes=
soto@gmail.com</a>&gt;<br>
&gt; <br>
&gt; The file display/modules/inc/mod_freesync.h has two identical AMD<br>
&gt; Copyright texts. This simple patch aims to remove the duplicate one.<b=
r>
<br>
Hi Marcelo,<br>
<br>
The patch subject should have a subsystem prefix (e.g. the full subject<br>
should have been &quot;[PATCH] drm/amdgpu: mod_freesync: Remove duplicate<b=
r>
copyright boilerplate&quot;).<br>
<br>
For patch description, I&#39;d like to write it as &quot;mod_freesync heade=
r file<br>
has duplicated copyright boilerplate. Drop the duplicate&quot;. And make<br=
>
sure that your Signed-off-by: trailer is on the bottom of description,<br>
before triple dashes (`git commit -s` does it for you).<br>
<br>
&gt; <br>
&gt; ---<br>
&gt;=C2=A0 .../amd/display/modules/inc/mod_freesync.h=C2=A0 =C2=A0 | 28 ---=
----------------<br>
&gt;=C2=A0 1 file changed, 28 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/=
drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h<br>
&gt; index afe1f6cce..cc3dc9b58 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h<br>
&gt; @@ -1,31 +1,3 @@<br>
&gt; -/*<br>
&gt; - * Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt; - *<br>
&gt; - * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; - * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; - * to deal in the Software without restriction, including without lim=
itation<br>
&gt; - * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; - * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; - * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; - *<br>
&gt; - * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; - * all copies or substantial portions of the Software.<br>
&gt; - *<br>
&gt; - * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO =
EVENT SHALL<br>
&gt; - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; - * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; - *<br>
&gt; - * Authors: AMD<br>
&gt; - *<br>
&gt; - */<br>
&gt; -<br>
&gt; -<br>
&gt; -<br>
&gt; -<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Copyright 2016 Advanced Micro Devices, Inc.<br>
&gt;=C2=A0 =C2=A0*<br>
<br>
The diff itself LGTM.<br>
<br>
Thanks.<br>
<br>
-- <br>
An old man doll... just what I always wanted! - Clara<br>
</blockquote></div>

--000000000000944b5c060d74d869--

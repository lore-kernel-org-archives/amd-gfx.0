Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB05CDE006
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 14:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5A810E045;
	Thu, 26 Sep 2024 14:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="geD0Vw/o";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F6310E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 14:00:34 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a90deec0f8bso15348166b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727359232; x=1727964032; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CDG+F54BkzIB/jhl/b8N7zECStIhwiMpbxFboHPT1D4=;
 b=geD0Vw/oNukoaZCDgGTOKS/U1xNu4VK5DZ3/88/vdVLEkIHkiWAIPF5a8JNgGSqqlF
 VTUPsKFoMbDvfGuiw6x4ADoYTXKH8B/d3k72/dqxuLvoJbjPpezCi6YqcN90yBwDwuA3
 4qf5EjWdydhxb3/w9PLLluXie1KPmC2O3UR86phJ+QOreScCBIQAEmLp0TlWKswPXqKe
 vKcOCyxH8LbP7AhWf1qITwUQKFhfViHPTSJ9lRe5vU3eEdNh3m9/gWcKWJXMLUinMpmG
 JJeruXd0HZmwOam4j+/jdu17CMvFtkapXCi7mVTQ4NewMoYQuDvTYv9qZrUZfV296XV/
 F7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727359232; x=1727964032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDG+F54BkzIB/jhl/b8N7zECStIhwiMpbxFboHPT1D4=;
 b=aAGcmJBX9mo5e13N7O1Hz/ygHIDCcMc8q9Xd41l6SBMeXW5S54pgau/Oy5rOjd3hOC
 stLVAcUP8B6TQkakASsJScVBP9pMAlBcn7LdeWaPQR0RzMv/YZVZGAcnokzlFJHnT4ww
 Nnva+WjE3UYvuGL9yiJEoRMmH0XiIo2gqiu+Dc0ElGlBXTg7UkbH9Wo+koKXcm8Jx5H0
 hKo98TfQUyU6cjS8Ahv+7B16t5hBO84qEWbb1XRKtUZ760xQgcxTIFFIbXxCWFLK+wvE
 PsgpaBmWrq7JI+r3kF3LYIa6jl8/RjBFTBXnaagMrINiQz5wygOqsWthxvieN4wegZMm
 6Nzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqcmx29hiQR9zGq4u8r317J75DU86elzr4AKb0hOBEGh1O79VlhLS7v9xnGa8bSkUNcqAic49+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGw1UzqXX+JkPv7Zyuee2lugVHJzmDY/0IGSqtKz0sav5tBIQ/
 LzH75uMLVndLgQm0isLrCDigdvWUrpRfty/RLuFzs8BL1aram9//Inq4xuxumNbRGKwLrDRe24V
 xRTRZa5hXx9bZzYuQpuQum83OfoGmzA==
X-Google-Smtp-Source: AGHT+IGdoEEfyZfoxj163//rnyHDPSxaVeTH0De11U0rCBVerbPjmnLkOD50klesnUPXCpbRdZFR33T6v8SmEUhta7c=
X-Received: by 2002:a17:906:dc90:b0:a86:7179:849e with SMTP id
 a640c23a62f3a-a93a00ffa87mr254164866b.0.1727359232378; Thu, 26 Sep 2024
 07:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240906180345.2557849-1-alexander.deucher@amd.com>
 <CADnq5_PT=6Y_+Bbo7gGMgnd0TLq0B9NfvGTuP=PHP7_xUrAT-A@mail.gmail.com>
In-Reply-To: <CADnq5_PT=6Y_+Bbo7gGMgnd0TLq0B9NfvGTuP=PHP7_xUrAT-A@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 26 Sep 2024 10:00:20 -0400
Message-ID: <CAAxE2A75nA6=2C2nsg1BNf+5xeB_V0ybtjz6KKWS8=pQOR5XRA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bump driver version for cleared VRAM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000007211130623062969"
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

--0000000000007211130623062969
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is GTT cleared too?

Marek

On Thu, Sep 26, 2024, 09:53 Alex Deucher <alexdeucher@gmail.com> wrote:

> Ping?
>
> On Fri, Sep 6, 2024 at 2:04=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com>
> wrote:
> >
> > Driver now clears VRAM on allocation.  Bump the
> > driver version so mesa knows when it will get
> > cleared vram by default.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index d90473aec942..fad556be840b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -117,9 +117,10 @@
> >   * - 3.56.0 - Update IB start address and size alignment for decode an=
d
> encode
> >   * - 3.57.0 - Compute tunneling on GFX10+
> >   * - 3.58.0 - Add GFX12 DCC support
> > + * - 3.59.0 - Cleared VRAM
> >   */
> >  #define KMS_DRIVER_MAJOR       3
> > -#define KMS_DRIVER_MINOR       58
> > +#define KMS_DRIVER_MINOR       59
> >  #define KMS_DRIVER_PATCHLEVEL  0
> >
> >  /*
> > --
> > 2.46.0
> >
>

--0000000000007211130623062969
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Is GTT cleared too?<div dir=3D"auto"><br></div><div dir=
=3D"auto">Marek</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Sep 26, 2024, 09:53 Alex Deucher &lt;<a href=
=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Ping?<br>
<br>
On Fri, Sep 6, 2024 at 2:04=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:a=
lexander.deucher@amd.com" target=3D"_blank" rel=3D"noreferrer">alexander.de=
ucher@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Driver now clears VRAM on allocation.=C2=A0 Bump the<br>
&gt; driver version so mesa knows when it will get<br>
&gt; cleared vram by default.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com" target=3D"_blank" rel=3D"noreferrer">alexander.deucher@amd.com</a>&g=
t;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index d90473aec942..fad556be840b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -117,9 +117,10 @@<br>
&gt;=C2=A0 =C2=A0* - 3.56.0 - Update IB start address and size alignment fo=
r decode and encode<br>
&gt;=C2=A0 =C2=A0* - 3.57.0 - Compute tunneling on GFX10+<br>
&gt;=C2=A0 =C2=A0* - 3.58.0 - Add GFX12 DCC support<br>
&gt; + * - 3.59.0 - Cleared VRAM<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define KMS_DRIVER_MAJOR=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt; -#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A058<br>
&gt; +#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A059<br>
&gt;=C2=A0 #define KMS_DRIVER_PATCHLEVEL=C2=A0 0<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt; --<br>
&gt; 2.46.0<br>
&gt;<br>
</blockquote></div>

--0000000000007211130623062969--

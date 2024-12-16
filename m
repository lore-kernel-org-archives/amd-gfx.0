Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99204E77180
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 05:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274CB10E107;
	Mon, 16 Dec 2024 05:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLsj16kN";
	dkim-atps=neutral
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3607610E107
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 05:41:32 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d0d6087ca3so527327a12.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Dec 2024 21:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734327691; x=1734932491; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v1KA3mniVZASDobJP0Ww+4FpItw3DAyqeeTFnmTD9Bg=;
 b=NLsj16kNF/ErTD4esifpdMCcO85yk20XIsDkeZi4LPombUf49JIIqEx/QABe0nVTPP
 3hzBM3m9g2vaWA42ZLVchGKHnsqhzvKH3pqmqMLaLlbgF8JC791JJ5THP1ym18SyUi8Z
 rOdymbDBAXRYbf2hpwwGZEpSx3jGtbCWKKN11m/Sd8oQST5HZLAtdHkZRy39J9OmFA7w
 Lkez8E4gN5m+kpx43OjLicj17+WDSAO2QiYJD+V9UvS33ksXqOwTGEp2INmvHKqchyRT
 zyCguJnSA0aEdYI80ezWtQc8bSVBS/1aSyu8fjQR509BLKxTCS7TW/64PSWap1D7bfAI
 GRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734327691; x=1734932491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1KA3mniVZASDobJP0Ww+4FpItw3DAyqeeTFnmTD9Bg=;
 b=Wd47KMtc+kqZxbM9HHpEJT56xCz8Oh1tTU9ODZFp78tyaBf2G/3IA8G6KDJqGJjXoy
 Puib7Kj+KUesb9EQve8reMqxr+dG2f78UQx/5kyX80Sm1tr1AKU6OuChMhLrwUgV+vEy
 V4SdKX1Id1yYuhMlEbyXbFqsEC19O1vcxdFRuCpJE4jxoDKY4ujh+Wn+r0aikhm2GoZy
 BlT/b7VHv0LGc4v2IPt95pBturVKEzm8/m6SK/VSMgAHmp8tW3i8EBlRs3ZmjsA/XMy+
 uvD3Q//306+psTQPxt9kvG2AfVx1bY0MJGBD+1Ozzcxw8lW18HLbCW3yHovPb5PtyC0L
 QMmA==
X-Gm-Message-State: AOJu0YwfSEs1XPWE988o5bAL1Sk0QImNk4uD45/ZoplIKKyMY20Bu6gl
 samfxtoE6cDY2Uebces7YGrlgkhPnLBwSE4PYYv0711mt9SMBIFMA0Gewi/GejuflwUk0KLCV0o
 zXJKSH9VhxVUWOqFyP2Q8kMylu79LjYIA
X-Gm-Gg: ASbGncurz71lbnyRwKnlhBh5PUuKiJBvJPIXFe2Vvb1LZiW8ieTdAC5/aPZ0iXQ0Uvn
 B+/Pb2yAzoNDX1qpm26DcR7Zvbzr6UROjMKEAx/s=
X-Google-Smtp-Source: AGHT+IEZzW1C+M+CJqARKKSMbk9Q7O6kFpN9untzHBpu7XTltMMYSwzuTPcYI3POZdwJFtAdYacjnMG5SY9tVArbLX8=
X-Received: by 2002:a05:6402:3489:b0:5d2:d72a:77f2 with SMTP id
 4fb4d7f45d1cf-5d63c3ed525mr4222107a12.7.1734327690416; Sun, 15 Dec 2024
 21:41:30 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <CAAxE2A77j94VNp33VhO97n3db_fZz1zUpM_VUPfkt96_Dzu9Bg@mail.gmail.com>
 <972c14f7-bf6f-450f-92c5-3f2b8390eac8@froggi.es>
 <CAAxE2A6popiaVF=u5B1swqXLGwnPxFTrqJKSEJJZ4tjVeWDpsA@mail.gmail.com>
 <893fedef-1592-487d-abd7-18f9d9ff79c8@froggi.es>
In-Reply-To: <893fedef-1592-487d-abd7-18f9d9ff79c8@froggi.es>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 16 Dec 2024 00:40:54 -0500
Message-ID: <CAAxE2A79pOgZV9iK4fnbG0m8+vhrWej1J0jdMKwsxMSYEq3Chw@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000e95f9006295ca149"
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

--000000000000e95f9006295ca149
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

git send-email (or rather the way it sends email) has been banned by gmail
due to being considered unsecure. I don't plan to find a way to make it
work and I don't plan to use a different email provider. It doesn't matter
because I'll be the committer of this patch in our amd-staging-drm-next
branch.

Let's talk about the concept and brokenness of DRM_FORMAT_MOD_LINEAR, not
send-email.

Marek

On Sun, Dec 15, 2024 at 9:08=E2=80=AFPM Joshua Ashton <joshua@froggi.es> wr=
ote:

> Not really for my benefit, more that it's the proper thing to do if you
> want anyone to apply your patch.
>
> You should really just be using git send-email.
>
> On 12/15/24 11:57 PM, Marek Ol=C5=A1=C3=A1k wrote:
> > Only for you: Attached.
> >
> > Marek
> >
> > On Sun, Dec 15, 2024 at 6:37=E2=80=AFPM Joshua Ashton <joshua@froggi.es
> > <mailto:joshua@froggi.es>> wrote:
> >
> >     You should just re-send the whole patch, probably.
> >
> >     On 12/15/24 8:54 PM, Marek Ol=C5=A1=C3=A1k wrote:
> >      > Missed 2 lines from the diff:
> >      >
> >      > +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_128B
> >     fourcc_mod_code(NONE, 2)
> >      > +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_256B
> >     fourcc_mod_code(NONE, 3)
> >      >
> >      > Marek
> >      >
> >      > On Sun, Dec 15, 2024 at 3:53=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <m=
araeo@gmail.com
> >     <mailto:maraeo@gmail.com>
> >      > <mailto:maraeo@gmail.com <mailto:maraeo@gmail.com>>> wrote:
> >      >
> >      >     The comment explains the problem with DRM_FORMAT_MOD_LINEAR.
> >      >
> >      >     Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com
> >     <mailto:marek.olsak@amd.com>
> >      >     <mailto:marek.olsak@amd.com <mailto:marek.olsak@amd.com>>>
> >      >
> >      >     diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/dr=
m/
> >      >     drm_fourcc.h
> >      >     index 78abd819fd62e..8ec4163429014 100644
> >      >     --- a/include/uapi/drm/drm_fourcc.h
> >      >     +++ b/include/uapi/drm/drm_fourcc.h
> >      >     @@ -484,9 +484,27 @@ extern "C" {
> >      >        * modifier (e.g. not setting DRM_MODE_FB_MODIFIERS in the
> >      >     DRM_ADDFB2 ioctl),
> >      >        * which tells the driver to also take driver-internal
> >     information
> >      >     into account
> >      >        * and so might actually result in a tiled framebuffer.
> >      >     + *
> >      >     + * WARNING:
> >      >     + * There are drivers out there that expose
> >     DRM_FORMAT_MOD_LINEAR,
> >      >     but only
> >      >     + * support a certain pitch alignment and can't import image=
s
> >     with
> >      >     this modifier
> >      >     + * if the pitch alignment isn't exactly the one supported.
> >     They can
> >      >     however
> >      >     + * allocate images with this modifier and other drivers can
> >     import
> >      >     them only
> >      >     + * if they support the same pitch alignment. Thus,
> >      >     DRM_FORMAT_MOD_LINEAR is
> >      >     + * fundamentically incompatible across devices and is the
> only
> >      >     modifier that
> >      >     + * has a chance of not working. The PITCH_ALIGN modifiers
> >     should be
> >      >     used
> >      >     + * instead.
> >      >        */
> >      >       #define DRM_FORMAT_MOD_LINEAR  fourcc_mod_code(NONE, 0)
> >      >
> >      >     +/* Linear layout modifiers with an explicit pitch alignment
> >     in bytes.
> >      >     + * Exposing this modifier requires that the pitch alignment
> >     is exactly
> >      >     + * the number in the definition.
> >      >     + */
> >      >     +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_64B
> >     fourcc_mod_code(NONE, 1)
> >      >
> >
> >     - Joshie =F0=9F=90=B8=E2=9C=A8
> >
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
>

--000000000000e95f9006295ca149
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>git send-email (or rather the way it sends email) has=
 been banned by gmail due to being considered unsecure. I don&#39;t plan to=
 find a way to make it work and I don&#39;t plan to use a different email p=
rovider. It doesn&#39;t matter because I&#39;ll be the committer of this pa=
tch in our amd-staging-drm-next branch.<br></div><div><br></div><div>Let&#3=
9;s talk about the concept and brokenness of DRM_FORMAT_MOD_LINEAR, not sen=
d-email.</div><div><br></div><div>Marek<br></div></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On S=
un, Dec 15, 2024 at 9:08=E2=80=AFPM Joshua Ashton &lt;<a href=3D"mailto:jos=
hua@froggi.es">joshua@froggi.es</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Not really for my benefit, more that it&#3=
9;s the proper thing to do if you <br>
want anyone to apply your patch.<br>
<br>
You should really just be using git send-email.<br>
<br>
On 12/15/24 11:57 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Only for you: Attached.<br>
&gt; <br>
&gt; Marek<br>
&gt; <br>
&gt; On Sun, Dec 15, 2024 at 6:37=E2=80=AFPM Joshua Ashton &lt;<a href=3D"m=
ailto:joshua@froggi.es" target=3D"_blank">joshua@froggi.es</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:joshua@froggi.es" target=3D"_blank">joshu=
a@froggi.es</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You should just re-send the whole patch, probably.<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/15/24 8:54 PM, Marek Ol=C5=A1=C3=A1k wrote:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Missed 2 lines from the diff:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_12=
8B<br>
&gt;=C2=A0 =C2=A0 =C2=A0fourcc_mod_code(NONE, 2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_25=
6B<br>
&gt;=C2=A0 =C2=A0 =C2=A0fourcc_mod_code(NONE, 3)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Marek<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Sun, Dec 15, 2024 at 3:53=E2=80=AFPM Marek=
 Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">=
maraeo@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:maraeo@gmail.com" targ=
et=3D"_blank">maraeo@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:maraeo@gmail.com=
" target=3D"_blank">maraeo@gmail.com</a> &lt;mailto:<a href=3D"mailto:marae=
o@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0The comment explains the p=
roblem with DRM_FORMAT_MOD_LINEAR.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Marek Ol=C5=
=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.com" target=3D"_blank">mar=
ek.olsak@amd.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:marek.olsak@amd.com" t=
arget=3D"_blank">marek.olsak@amd.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mail=
to:marek.olsak@amd.com" target=3D"_blank">marek.olsak@amd.com</a> &lt;mailt=
o:<a href=3D"mailto:marek.olsak@amd.com" target=3D"_blank">marek.olsak@amd.=
com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0diff --git a/include/uapi/=
drm/drm_fourcc.h b/include/uapi/drm/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0drm_fourcc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0index 78abd819fd62e..8ec41=
63429014 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0--- a/include/uapi/drm/drm=
_fourcc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+++ b/include/uapi/drm/drm=
_fourcc.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0@@ -484,9 +484,27 @@ exter=
n &quot;C&quot; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * modifier (e.g. n=
ot setting DRM_MODE_FB_MODIFIERS in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0DRM_ADDFB2 ioctl),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * which tells the =
driver to also take driver-internal<br>
&gt;=C2=A0 =C2=A0 =C2=A0information<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0into account<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and so might act=
ually result in a tiled framebuffer.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * WARNING:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * There are drivers out =
there that expose<br>
&gt;=C2=A0 =C2=A0 =C2=A0DRM_FORMAT_MOD_LINEAR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0but only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * support a certain pitc=
h alignment and can&#39;t import images<br>
&gt;=C2=A0 =C2=A0 =C2=A0with<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0this modifier<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * if the pitch alignment=
 isn&#39;t exactly the one supported.<br>
&gt;=C2=A0 =C2=A0 =C2=A0They can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0however<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * allocate images with t=
his modifier and other drivers can<br>
&gt;=C2=A0 =C2=A0 =C2=A0import<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0them only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * if they support the sa=
me pitch alignment. Thus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0DRM_FORMAT_MOD_LINEAR is<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * fundamentically incomp=
atible across devices and is the only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0modifier that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * has a chance of not wo=
rking. The PITCH_ALIGN modifiers<br>
&gt;=C2=A0 =C2=A0 =C2=A0should be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0used<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * instead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#define DRM_FORMAT_=
MOD_LINEAR =C2=A0fourcc_mod_code(NONE, 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+/* Linear layout modifier=
s with an explicit pitch alignment<br>
&gt;=C2=A0 =C2=A0 =C2=A0in bytes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * Exposing this modifier=
 requires that the pitch alignment<br>
&gt;=C2=A0 =C2=A0 =C2=A0is exactly<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ * the number in the defi=
nition.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0+#define DRM_FORMAT_MOD_LI=
NEAR_PITCH_ALIGN_64B<br>
&gt;=C2=A0 =C2=A0 =C2=A0fourcc_mod_code(NONE, 1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0- Joshie =F0=9F=90=B8=E2=9C=A8<br>
&gt; <br>
<br>
- Joshie =F0=9F=90=B8=E2=9C=A8<br>
<br>
</blockquote></div>

--000000000000e95f9006295ca149--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FFCCF9E3
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Nov 2025 09:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3CC10E05D;
	Sun,  2 Nov 2025 09:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dksYxdpv";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFFE10E05D
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Nov 2025 09:28:10 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-93516cbe2bbso668475241.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 02 Nov 2025 01:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762075689; x=1762680489; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FD9xDvssjzVBPML49kAzttrJKM9EYRI+EGQcxwiKXKQ=;
 b=dksYxdpvJxuVUV32icWaY/CGt2iYUdbbbuMsM8ureiWGXcpAIZjreOTR9n2yTo4FLr
 mw0P3nfN08lJK+IuCGHksprrapOOH7uM5QEckQuNGefxdBFbbF34CQ7XRpI2V54UADGE
 l80bN7mgyBP1uhNJw2xhyfPVhy4y+Xb17fCK/mX1kIWRcKHpBFaIqvsFvCQlAW9ljH3Q
 PGvjdReFY+Va4Peyix0tGMM755ODBLzK+3D2udscmzkx1zNX5WmhuK0l4+URH+xvUgR0
 inMI63dNPUSX5VOsw3NwK5yZBzZT0KCfV6ChXRkDLBgyNR3L8v1xIMI6BKpvS5vmQh0h
 2CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762075689; x=1762680489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FD9xDvssjzVBPML49kAzttrJKM9EYRI+EGQcxwiKXKQ=;
 b=pYC308trKqQKkwCgHU+XnYrCe8RBd8QZGhhwT1bksRJBm8S2hWlpckTccIxpH+QzpB
 EhBU9adVaFkrn7liQi1QLdRIMf7bWw9lvLqk53TSzuNn81CzGiCJIyRu9LKPjZPyolcF
 CBV7QSJoMi/3cyKvnPAhFoe9ag8G5jdAOKicF7LtGBVeDfM1/vb8LR5kgRujKuNDOmqd
 sQqOeZMQBtRY3wbm8Tr5ZTolUCxWLGUCyIdC982W689icev98Qe/p/jxjJFeDUBHxFDU
 hFPq5/x4rCTiTOK0JlZk9GvNmd9HEIviR9SqGgDA5KkI04GvEpOncFGpHrYwnb0yDjvs
 60MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJGBL4d+XgBC7BxCaTOylL7mS1rR3iCTKpL0bW9bvYgzZ9Ahw4t2yr78g6m10fyFainPeQuZ2R@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+9nSQjwX1vFzqhzq2gdDkrRPNeWDqKavqqo0LC6ojntvF90DG
 xDOtzr6BZU4fbAaYEJM0bLvHl42bx9VYILMW4vRbz2EZVnKjcuPjcFhM0lWaMUCWwrT4bMXDgIj
 RFvGlyvZMQA3S+POQ9s5M9Bzs12lJNbY=
X-Gm-Gg: ASbGncsteKz+zHYXR73D5JkUkCy3SufrO8OShLQD9r1P1ABdL4DwmLaLrtEzjwnM5/R
 ZypDa21SEqsYlS0ZxG8m9bP7dXJLWnD3FhWwX2dmzNDQi8F7dwsG+5EUnAoCfSzmEdKzoH8Ez0i
 Q3IHVLUJcgrt9PPSjVBVIOH/N9mHNSeIJpcdeifLKvoCP7m/3eONQierLGbfIqt1Ls93tgYBhZr
 q5gnF6HT7AtnM8d9iMlrlWP3J+zJ6CsQ1sBb3VI+Qyk0WArBOTmE3ol+r1SM0KslgDmoIO2vUnP
 lWohx8mim7gFJ+wxAKk=
X-Google-Smtp-Source: AGHT+IHxc3zPuTYwZUI724Vsi0NozZ2WEXr0k3nxeAvnZf/T+liPSxekEHB9GMCjmHrI87ninqDnXcAGJzIDHaWgyXE=
X-Received: by 2002:a05:6102:3a0c:b0:5db:d91a:ff4f with SMTP id
 ada2fe7eead31-5dbd91b0798mr223857137.28.1762075689415; Sun, 02 Nov 2025
 01:28:09 -0800 (PST)
MIME-Version: 1.0
References: <1043551.1761844832@turing-police>
 <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police>
In-Reply-To: <1296761.1762045181@turing-police>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Sun, 2 Nov 2025 10:27:54 +0100
X-Gm-Features: AWmQ_bnzbmuLls5PGeFmTvPuXuD55fdLdPAugDkJXyG6xMHZuv-ohFSBcMEuhQY
Message-ID: <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
To: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 David Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000088f7e006429937d9"
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

--00000000000088f7e006429937d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Valdis,

I use Fedora and I developed that patch on Fedora, using the same GCC
version. It did not give me an error or warning when I wrote the patch. It
is still not giving me an error or warning about that code now.

I am working with the amd-staging-drm-next branch.

What do I need to do to trigger the warning?

Thanks & best regards,
Timur

Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=C5=91pont=
: 2025. nov.
2., Vas 1:59):

> On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
>
> > Can you say how to reproduce that?
> > I use the same version of GCC but it hasn't given me any warning or
> > error for that patch.
>
> Upon further testing,
>
> [/usr/src/linux-next] make
>
> is sufficient on my system. Turns out that it errors out even without W=
=3D1.
> My
> next guess was that it had to do with -Werror, which would cause warnings
> to
> be treated as errors, but my .config has
>
> # CONFIG_WERROR is not set
> # CONFIG_DRM_WERROR is not set
> # CONFIG_DRM_AMDGPU_WERROR is not set
>
> Do you perhaps have patches in your tree that aren't in next-20251029?
>
> I wonder if Fedora's build of gcc 15.2.1 is different somehow from the
> build you're using....
>
>
>
>

--00000000000088f7e006429937d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Valdis,<div dir=3D"auto"><br></div><div dir=3D"auto=
">I use Fedora and I developed that patch on Fedora, using the same GCC ver=
sion. It did not give me an error or warning when I wrote the patch. It is =
still not giving me an error or warning about that code now.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I am working with the amd-staging-drm=
-next branch.</div><div dir=3D"auto"><br></div><div dir=3D"auto">What do I =
need to do to trigger the warning?</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Thanks &amp; best regards,</div><div dir=3D"auto">Timur</div></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">Valdis Kl=C4=93tnieks &lt;<a href=3D"mailto:valdis.kletn=
ieks@vt.edu">valdis.kletnieks@vt.edu</a>&gt; ezt =C3=ADrta (id=C5=91pont: 2=
025. nov. 2., Vas 1:59):<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, =
30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:<br>
<br>
&gt; Can you say how to reproduce that?<br>
&gt; I use the same version of GCC but it hasn&#39;t given me any warning o=
r<br>
&gt; error for that patch.<br>
<br>
Upon further testing, <br>
<br>
[/usr/src/linux-next] make <br>
<br>
is sufficient on my system. Turns out that it errors out even without W=3D1=
. My<br>
next guess was that it had to do with -Werror, which would cause warnings t=
o<br>
be treated as errors, but my .config has<br>
<br>
# CONFIG_WERROR is not set<br>
# CONFIG_DRM_WERROR is not set<br>
# CONFIG_DRM_AMDGPU_WERROR is not set<br>
<br>
Do you perhaps have patches in your tree that aren&#39;t in next-20251029?<=
br>
<br>
I wonder if Fedora&#39;s build of gcc 15.2.1 is different somehow from the<=
br>
build you&#39;re using....<br>
<br>
<br>
<br>
</blockquote></div>

--00000000000088f7e006429937d9--

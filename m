Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D722DE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 11:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862B710ED6D;
	Thu,  9 Jan 2025 11:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NUKh7Cnh";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A393F10ED6D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 11:08:47 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso138638666b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2025 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736420866; x=1737025666; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=slUMgRYNfpRqB2e5Ihdjw7BL/NRcwhefq2MBxdyzxCY=;
 b=NUKh7CnhV/yoei4sM44MPtq5ALgqsajXVPiD1L2UY0krt1h5qiGjajaHUNUCWF6mQu
 8s8tMMlIOrRQxoSrnviuqDWB85J8mogD29A4htx7jfxtvw3lxyBTUhWh4DVRfGJSnzq7
 DuxljvhoDANGOyTJNLLR/tMwIoqzsQ5I/dgsiVUJhL0Ew0DkiT/+xk/RZDMK1Iy1Z2oH
 taIHTnRFZp8Ha8IofEgX2dwtsk9C+1AaxDvxBkX9fAmASvf6r4L9/ab5RN/QzJb01zGV
 t09YE4zAtLqyw1uOP0kzJNMEnqTkNcVI0Mhnd/wCT03vpjWbpSWd3ZYxvPrxEP7ks2Gn
 K6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420866; x=1737025666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=slUMgRYNfpRqB2e5Ihdjw7BL/NRcwhefq2MBxdyzxCY=;
 b=nOt6nh1HL1kT548Dioojt5CMMbz/SLVCJJ9sdtCPed03Lm3Nme1zvGI9UKkF3QCcw7
 bgZT2Qc3XOQ1O08L1SpS2OI/Q44q1UiBoWESQqFx2IZkLLBs3u3tKHC2dZGwtQO6Cv6d
 jFqESNj0aX4jrthHmmEfdKk7JbYsklQbdQdl7AsJTcodCGSxzb8xNqJNye5uoKEQVg1S
 d2/jQsBOsAJwaLNKfEofnMmvpYMYT7swFZaJf4yxu97fSi4tSY5uu7Wlv1dOBWSct46S
 SQGbdCE3mINukAeYnI3NbSDd4JEgVhHt9DV/1LjDq7iRDKdrfpO9LGIRHdBwKUf0b5ev
 oi1A==
X-Gm-Message-State: AOJu0Yy9ne5alkSWs2irV9q38FklypxL2UzjpFf9bsFg5K6dGGt3ZKar
 E2F2+wXO/wDFmWCQuuzzGfajeMaDsPFmLsdmBcG1C7d9U+QA47mrrHSaIJUbS0DOM5qTkK+17SR
 9eZBKOF4rJQu1SHQf7Y+aW7JyZOSF5X30KCo=
X-Gm-Gg: ASbGncsLRHzNgnuGF6LhU+1Q6/5DPn2JnYGpbEK4QbuonHbLXl2iev3oaHwUY9tr3wf
 uSNG2NboG5UE1k73CoI1tHookOP9deaTOeEV+fSs=
X-Google-Smtp-Source: AGHT+IFnHdANmApZhyeSrLzGdKUe+eMTvjR/+M5rFC3aV8iGtzEf3OoQPEATNXQOX1TuG1kLtRTDGcGIgTxNAy03vO0=
X-Received: by 2002:a5d:64eb:0:b0:385:f349:fffb with SMTP id
 ffacd0b85a97d-38a8732c439mr5901669f8f.45.1736420467294; Thu, 09 Jan 2025
 03:01:07 -0800 (PST)
MIME-Version: 1.0
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
 <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
 <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
In-Reply-To: <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
From: Mischa Baars <mjbaars1977.backup@gmail.com>
Date: Thu, 9 Jan 2025 12:00:56 +0100
X-Gm-Features: AbW1kvZcRffnp2eyKJcADUSgTat57FlqLowiHC0amuDWsfztan8SU2tuvhWoMdk
Message-ID: <CA+b5WFEjG1DE1+_gG0qwmEf4nQZFg=9O+rHDJZmiADL5Hi7fbA@mail.gmail.com>
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000224c5b062b43e559"
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

--000000000000224c5b062b43e559
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 4:41=E2=80=AFPM Michel D=C3=A4nzer <michel.daenzer@m=
ailbox.org>
wrote:

> Yeah, that's not how double-buffering works in GL. The draw buffer is
always GL_BACK, SwapBuffers doesn't affect that (it just may internally
change which actual buffer GL_BACK refers to).
>
> I don't see more context about the issue you're investigating, any
pointers?

I'm sort of a fan of Michael Abrash, as he inspired me to learn programming
assembly language a long time ago, but in his Graphics Programming Black
Book, Chapter 23
<https://www.phatcode.net/res/224/files/html/ch23/23-03.html#Heading6> he
shows how the CRTC Index Register is used to change what is shown on the
screen by alternating between two memory pages at PAGE0_OFFSET and
PAGE1_OFFSET. I was under the impression that OpenGL used a similar
approach with GL_FRONT and GL_BACK, hence I was expecting GL_DRAW_BUFFER to
alternate between the two. On closer inspection of the glXSwapBuffers()
<https://registry.khronos.org/OpenGL-Refpages/gl2.1/xhtml/glXSwapBuffers.xm=
l>
reference page, it indeed does not say anything about alternating
GL_DRAW_BUFFERs. I must have misread, with the above concept in mind. The
glDrawBuffer()
<https://registry.khronos.org/OpenGL-Refpages/gl4/html/glDrawBuffer.xhtml>
reference page however does speak of initial values for double buffered
contexts and the use of both front and back buffers.

Can you explain to me why we are only drawing in GL_BACK and how that
relates to what portion of memory is shown on the screen?

--000000000000224c5b062b43e559
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, Jan 6, 2025 at 4:41=E2=80=AFPM Michel D=C3=A4nzer =
&lt;<a href=3D"mailto:michel.daenzer@mailbox.org">michel.daenzer@mailbox.or=
g</a>&gt; wrote:<br><br>&gt; Yeah, that&#39;s not how double-buffering work=
s in GL. The draw buffer is always GL_BACK, SwapBuffers doesn&#39;t affect =
that (it just may internally change which actual buffer GL_BACK refers to).=
<br>&gt;<br>&gt; I don&#39;t see more context about the issue you&#39;re in=
vestigating, any pointers?<br><br><div>I&#39;m sort of a fan of Michael Abr=
ash, as he inspired me to learn programming assembly language a long time a=
go, but in his Graphics Programming Black Book, <a href=3D"https://www.phat=
code.net/res/224/files/html/ch23/23-03.html#Heading6">Chapter 23</a> he sho=
ws how the CRTC Index Register is used to change what is shown on the scree=
n by alternating between two memory pages at PAGE0_OFFSET and PAGE1_OFFSET.=
 I was under the impression that OpenGL used a similar approach with GL_FRO=
NT and GL_BACK, hence I was expecting GL_DRAW_BUFFER to alternate between t=
he two. On closer inspection of the <a href=3D"https://registry.khronos.org=
/OpenGL-Refpages/gl2.1/xhtml/glXSwapBuffers.xml">glXSwapBuffers()</a> refer=
ence page, it indeed does not say anything about alternating GL_DRAW_BUFFER=
s. I must have misread, with the above concept in mind. The <a href=3D"http=
s://registry.khronos.org/OpenGL-Refpages/gl4/html/glDrawBuffer.xhtml">glDra=
wBuffer()</a> reference page however does speak of initial values for doubl=
e buffered contexts and the use of both front and back buffers.</div><div><=
br></div><div>Can you explain to me why we are only drawing in GL_BACK and =
how that relates to what portion of memory is shown on the screen?</div><di=
v><br></div></div>

--000000000000224c5b062b43e559--

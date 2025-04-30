Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB0BC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 13:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3385610E2AB;
	Wed, 30 Apr 2025 13:55:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NyIR5ou2";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54F010E2AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 13:55:32 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so819819a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746021332; x=1746626132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPmNwDKaVtx2w4oamxvrAFal/WRspovv5yKiTJ6HuZ0=;
 b=NyIR5ou2/5QTsJdc2I7moUIEPVllmpnKxGreU4sHVdyf8EAOWqRGRklV5CZolHOZCX
 kHWA50wuojWIBXBy+81UgjIdgsArQ7/dr2LyHF4VGK+ihHohjDQNapfG9AfCMMwpVk9v
 R8fpkA6qzh6oD13xP4ViSOZzumlHNW6WbBQXF9lZSPRAqiKLnwQyQLKWNyrnbjTWk7mT
 I3oCCznZCW4qIBEh+XzpjigEspxQMrr63sGuzKg6Jdxl91symstchGUQzB8NAlFu8zZV
 6QLHXjRImt+MJpXNFd82UH364RFbvp5obToPs5ZmuaWIULRqlnR6pwuYZt2w6PxO5jxQ
 5KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021332; x=1746626132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPmNwDKaVtx2w4oamxvrAFal/WRspovv5yKiTJ6HuZ0=;
 b=oLCewHjYef/+8qFiECXe2TGqU9kfwikiZrrN97eVURB3ZilcRi+xqFvCkiqy95SS9L
 i9mCDPL2xicajCHDnWt75vQRQs2KYfMo4hdZEXm67u2K5LjSFCffrqbw5OCJkGD7Nq1P
 omvJ5CDMJs1NWj6Im9WzuxxAO18IHzxnXSfkPkbnrw6Kz+sXaCLAy4dNlUTcdb3a5AB1
 pe7tiA73gAKRYOdTYezrp3j8TTjb5xKmAitCLPZSMgJGB6sRqqlk7aHGCxIOkNdSWRMd
 AYaA+zxncY3MEbgqCcXuHg5vvp+h6GxnkrWsJb1UgcEQ6WxFj3j6LhQ4J2fZbCm6GkzQ
 idXQ==
X-Gm-Message-State: AOJu0Yzm9hZmcWKZ64yLDfC1UK9jtO431x5UNO+9xZrw+KSV4tYMdzvp
 tMmgEVYmbZVIwWhHvwIxQ7Bu3WaaW9NI1kSi6rOlLNYC5H7dkzthUreu4id8HevD1GaOj9XOwb5
 jmt8wpZ9jCHF/s8VUqpFtZn4USAA=
X-Gm-Gg: ASbGncs02NT7BoK/FPnwBYbbM3FGO7isS81CeZ3Rw5mnqpMGA+ydQrCizrZFLLkN65+
 vNqxD6krtyPIvDpj2psw/FYr4whrYBbkgNQiZ4GwIlvmdWJkM0UqGqhsKq9F1+L0nXUBWgNRvgG
 h1B3edBXtXUdDG/QCYPeW/Hw==
X-Google-Smtp-Source: AGHT+IG3SrdkWTu1yRuvKsmO+uEu8f+liVdH6iPFHps4qYGVtAZMURX4UJnj65qcbZozkbFmW7HW9b9HMI+0DY7RFdo=
X-Received: by 2002:a17:90b:4a8b:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-30a349d0db6mr1515511a91.2.1746021331958; Wed, 30 Apr 2025
 06:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
 <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
In-Reply-To: <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 09:55:20 -0400
X-Gm-Features: ATxdqUGaCl69YcPBpKwDFKR1KWxt6fTVe1d_7bpIt2rS-BROcRLyhA1ix5kbaLE
Message-ID: <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
Subject: Re: amdgpu: Reproducible soft lockups when playing games
To: Borislav Petkov <bp@alien8.de>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Marcus_R=C3=BCckert?= <amd@nordisch.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 30, 2025 at 3:55=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> + amdgpu folks
>
> On Tue, Apr 29, 2025 at 02:51:56PM +0200, Marcus R=C3=BCckert wrote:
> > Hardware:
> > - ASUS ROG Swift OLED PG27AQDP @ 480 Hz
> > - LG 27GL850-B @ 144Hz
> > - XFX Mercury Radeon RX 9070 XT OC Gaming Edition with RGB, 16GB GDDR6,=
 HDMI, 3x DP RX-97TRGBBB9
> > - Ryzen 9 9950X3D on ASUS ProArt X870E-Creator WiFi
> > - be quiet! Dark Power 13 850W ATX 3.0
> >
> > Software:
> > - kernel-default-6.15~rc4-1.1.g62ec7c7.x86_64 from https://build.opensu=
se.org/project/show/Kernel:HEAD
> > - Mesa-25.1+git442.5841d44f9-1747.1.x86_64 from https://build.opensuse.=
org/package/show/home:darix:playground/Mesa
> > - GE-Proton 9-27 https://github.com/GloriousEggroll/proton-ge-custom/re=
leases/tag/GE-Proton9-27
> > - Overwatch via steam
> >
> > ```
> > [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State
> > [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State Completed
> > [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] AMDGPU device coredump file has been created
> > [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] Check your /sys/class/drm/card1/device/devcoredump/data
> > [Mon Apr 28 23:10:56 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: ring=
 gfx_0.0.0 timeout, but soft recovered
> > [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State
> > [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: Dump=
ing IP State Completed
> > [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] AMDGPU device coredump file has been created
> > [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: [drm=
] Check your /sys/class/drm/card1/device/devcoredump/data
> > [Mon Apr 28 23:11:07 2025] [  T10460] amdgpu 0000:03:00.0: amdgpu: ring=
 gfx_0.0.0 timeout, but soft recovered
> > ```
> >
> > Usually I have that like once a day or so. But yesterday it was especia=
lly bad:
> >
> > ```
> > Apr 28 21:46:57 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 21:47:08 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 21:47:18 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 21:47:28 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 21:54:34 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 22:00:40 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 22:00:50 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 22:01:00 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 23:10:56 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > Apr 28 23:11:07 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 tim=
eout, but soft recovered
> > ```
> >
> > Together with my coworker Patrik Jakobsson and Takashi Iwai we already =
chased down a few other issues (like the dreaded flip_done).
> > But this last issue remains. We first backported some fixes to our 6.14=
.x kernel for flip_done. To get even more fixes I switched to the 6.15~rc k=
ernels.
> >
> > Then also went with Mesa 25.1~rc which didnt fix it. so now it is a sna=
pshot package of main.
> >
> > Some observations. While gaming I started run https://github.com/Umio-Y=
asuno/amdgpu_top on the 2nd monitor to see if overheating might be an issue=
.
> >
> > but the memory temps are at around 82 and the GPU core itself is usuall=
y lower.
> > One observation is that the card is supposed to have a boost clock of 3=
100MHz but amdgpu_top sees it boost over 3200. I tried both onboard bios an=
d the behavior is the same.
> >
> > currently I run both my wayland session as well as my game with RADV_DE=
BUG=3Dnohiz but that didnt provide more details adding nodcc drop the perfo=
rmance from 480-500Hz ( the card could go faster but I limit the game to 50=
0)
> > to 330-360.
> >
> > Please let me know, if I can provide more details

please make sure your kernel has these three patches:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4408b59eeacfea777aae397177f49748cadde5ce
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dafcdf51d97cd58dd7a2e0aa8acbaea5108fa6826
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D366e77cd4923c3aa45341e15dcaf3377af9b042f

soft recover kills stuck shaders, so I'd suggest trying a newer
version of mesa and LLVM.  If that doesn't help, please file a ticket
here:
https://gitlab.freedesktop.org/drm/amd/-/issues/

Alex


Alex

> >
> >    darix
> >
> >
> > ```
> > --
> > Always remember:
> >   Never accept the world as it appears to be.
> >     Dare to see it for what it could be.
> >       The world can always use more heroes.
> >
> >
> >
> >
> > ```
> >
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

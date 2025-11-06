Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB1FCCFA18
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 03:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428C310E119;
	Thu,  6 Nov 2025 03:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbNksnmp";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEF310E0AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 03:29:11 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-9354847e338so322069241.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 19:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762399750; x=1763004550; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n4CaiNtBzk+J1ksip0bh0eyQEO10boIF1xJKJ7rk94I=;
 b=CbNksnmpt9WJz5dzLjh3JgM10H1AjvbkDC6nA9swDiaA3xnabW7vGkkMpYoe+Dl6I6
 BW5JqU8UMUv4fSTjCfkOOy2IdVSQs0TRiapfBlX8fFMofzWLln9RkSvQ7owVb49T7YG3
 FbrkhSm3UAKd/NOx5RjlTjYFT4EUzWnqA2bEj6keSD+C9+LPHgTb1ztoXcmYVyQ2SS59
 toRA1Oczxsm7N8fKgTr18drsSbD9VJwpuKXbjr1EzYs5cgsPwserVQZgdaomJpeQhEtQ
 +yH1BrLHOgrXnEIJReERYY5SAnonBAepUEnlkIwTEw8me3F6cGHIUZbQTrCun4DikHcx
 R+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762399750; x=1763004550;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4CaiNtBzk+J1ksip0bh0eyQEO10boIF1xJKJ7rk94I=;
 b=fxcdG94zuGHGrJDIltGTRnfPHDaRafgQpoATiBIMzs5XyNKVWnLRdti0vFM7pR+lD4
 6ix9uQ7DH4+UIX2rvCpyFycXtx/ny8x1HF11eDE+Mp6JlxeahPqvawYeFsxdXyB2mHwr
 jaWmON4/rHdUUDAbg3XwgsTO/RtL1m9uznOqKJaTIx5lsN+9b7Vqcvq/dFXTx1Fmczmc
 p7OjIt3Ke2OqmUalkUCE7rfYf4Xtcn/1d7EsVhXsKXTLyameblmLgPi5FO+qC5EXG+I+
 BdsQ1Mmy1R5Gqn5AbwZRWawmVuhbQie8BtI1RiMt38GSyrDI10XcDn6BfISyFhjJUygF
 ecyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUesuuV4Y+ypHWXKwyhFP+i+QcPyW7P2t249CSoZyfDQqGIDRxfvDTbkZr+TIsobMTdmIVnCc+i@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVUZwyA/PVRTbJlb5RlS12PCk6Evt+gXj0ySgh+0VEnb3diMmC
 eK8D6eAdd2hHijpJ+TixWzdvYWHDdQuoa7LJ7Fkr3ezy7cRXIfLiMP74
X-Gm-Gg: ASbGnctGlVBxFuRPDo1bN9uniy9utZDgRR8nGz+CwCzq4tEc0yB7rgWrlfRd/XSj49G
 nFy8CoHd4hvMs2fmYMSkdQ+qXctuNB3Owwu0frMw2nghANvu77IxbMhUZDY1R++aTWrqAtLnCDe
 X5r6eZiRbT6wcZVx7su+NK3y2x239o5VuUW3Gauzut9FJiTiPzE1AT5q+jfH0QliEgon0KJNr4+
 CqaatTgTnO+9aB/zrshDt3TRHlEM3wdH2TqZNuAQT/YPUxsi4Qy4a2xI5hv97awdsG1/+piEvUy
 JpQPV3swJ/WvR75SDqABHaq36l78Rvcnq50j329w1uZKIMmnJTDK1TMdtYAjlrKnOF4YXdSbd59
 WefXqFXuq+9YywojSopgFR1gPcYCwGtkDtqXVeVWCn1AVWHIz2cvogTBWs9furo7T4i5SdCxAMQ
 oZ3WHipzFLVbZRRAZPHklGy3vpTqQDpR8JwxfFz8fjip+w5C+eTw5jCT2CWfDpnPMd8Q==
X-Google-Smtp-Source: AGHT+IFz8CjtY22nY8CSkSNf3qcSwgBcNz2TUbUcHnHKwWyMgld/sbQ3g787kvjrkj/fsGZMF1TvTw==
X-Received: by 2002:a05:6102:f12:b0:5db:aee2:9964 with SMTP id
 ada2fe7eead31-5dd9fcfa31bmr711345137.9.1762399749959; 
 Wed, 05 Nov 2025 19:29:09 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3?
 ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-937089699dcsm550066241.10.2025.11.05.19.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 19:29:09 -0800 (PST)
Message-ID: <867953df79b54037ce91cf1886b09ec5c30f7442.camel@gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, Alex
 Deucher	 <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, David
 Airlie	 <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel	 <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Date: Thu, 06 Nov 2025 04:29:05 +0100
In-Reply-To: <CAO=gReERBacxH6SjLrcCNcStiAzMosR=aW5D4W925CJ_yjzbhA@mail.gmail.com>
References: <1043551.1761844832@turing-police>
 <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police>
 <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
 <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
 <CAO=gReERBacxH6SjLrcCNcStiAzMosR=aW5D4W925CJ_yjzbhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-11-05 at 19:24 -0800, Amit Dhingra wrote:
> On Thu, Nov 06, 2025 at 03:40:52AM +0100, Timur Krist=C3=B3f wrote:
> > On Wed, 2025-11-05 at 18:34 -0800, Amit Dhingra wrote:
> > >=20
> > > >=20
> > > > What do I need to do to trigger the warning?
> > > >=20
> > > I have the same problem.
> > >=20
> > > linux-next on Arch Linux
> > > GCC : 15.2.1 20250813
> > >=20
> > >=20
> > > Steps to reproduce the error
> > > - make mrproper
> > > - make allmodconfig
> > > - make drivers/gpu/drm/amd/amdgpu/
> > >=20
> > > Turns out its due to randconfig, See [1]
> > >=20
> > > Setting RANDSTRUCT_NONE=3Dy seems to stop the error.
> >=20
> > Can you please try and see if this fixes the warning?
> > https://pastebin.com/raw/b8j3UABj
>=20
> The patch above defining all fields seems to fix the error.
>=20
> >=20
> > Alternatively, if anyone has other recommendations on how to fix
> > it,
> > I'm also open to suggestions.
> >=20
>=20
> What seemed to also work for me is to defining the struct as below
> without an initialization.
>=20
> static const struct stream_encoder_funcs dce110_an_str_enc_funcs;
>=20
> Its static so should be initialized zeroed out. objdump shows correct
> size
> allocation.
>=20
> objdump -x dce_stream_encoder.o
>=20
> =C2=A0 0000000000000b60 l=C2=A0=C2=A0=C2=A0=C2=A0 O .rodata	0000000000000=
130
> dce110_str_enc_funcs
> =C2=A0 0000000000000a00 l=C2=A0=C2=A0=C2=A0=C2=A0 O .rodata	0000000000000=
130
> dce110_an_str_enc_funcs
>=20

Thanks! This looks even cleaner.

I will submit a patch to fix the warning next week.
Can I add your name and email to the Suggested-by tag?

Thanks,
Timur



>=20
> > Thanks,
> > Timur
> >=20
> >=20
> > > >=20
> > > > Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=
=C5=91pont:
> > > > 2025.
> > > > nov.
> > > > 2., Vas 1:59):
> > > >=20
> > > > > On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
> > > > >=20
> > > > > > Can you say how to reproduce that?
> > > > > > I use the same version of GCC but it hasn't given me any
> > > > > > warning or
> > > > > > error for that patch.
> > > > >=20
> > > > > Upon further testing,
> > > > >=20
> > > > > [/usr/src/linux-next] make
> > > > >=20
> > > > > is sufficient on my system. Turns out that it errors out even
> > > > > without W=3D1.
> > > > > My
> > > > > next guess was that it had to do with -Werror, which would
> > > > > cause
> > > > > warnings
> > > > > to
> > > > > be treated as errors, but my .config has
> > > > >=20
> > > > > # CONFIG_WERROR is not set
> > > > > # CONFIG_DRM_WERROR is not set
> > > > > # CONFIG_DRM_AMDGPU_WERROR is not set
> > > > >=20
> > > > > Do you perhaps have patches in your tree that aren't in next-
> > > > > 20251029?
> > > > >=20
> > > > > I wonder if Fedora's build of gcc 15.2.1 is different somehow
> > > > > from the
> > > > > build you're using....
> > > > >=20
> > > > >=20
> > > > >=20
> > > > >=20

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C64FC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 23:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CF810E0B8;
	Fri, 14 Feb 2025 23:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QR+ihrPS";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767F710E03B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 23:55:42 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2f9f90103bbso567353a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739577342; x=1740182142; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RZWssaGK2NTJr+wteejyHIurAC825/BAeqVhi3Ct24=;
 b=QR+ihrPS5YODLG5IQWvf11i6DxEU/pfNIbgvii2Ce+UDkh0J5MK2Of+xO94IzJL4Nc
 oYsCDbtrgOIPvTd3LiBBIhU+3aFXnr+l47VqZmrAm39XEcFOrkaY5XuIfucziaL+PqnE
 lHxOdyz46Ytg2uARokHMCLIp/tnJRuWGcqHHziLeowngFlHPwWu7rny0SWPJgn+sYqmh
 eVk8gJE8zjxN6BTa/A45H9TFAijXpQBraq93u67FSJNy6WdWAoW2B9FQ523os0NmcZgu
 FpLyc+FfGjonRp5bLQixCdqlg4w6Xl/p6ZcvE/AYbPcmPSxTrTSkmPwrR+eC0wfLfp6X
 w83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739577342; x=1740182142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RZWssaGK2NTJr+wteejyHIurAC825/BAeqVhi3Ct24=;
 b=duA7sTuqkT8ze66kEpG4t7ODLCdOaMJSOQCXAoEPlWm2/Wbf6cdakN6kyeLXyfNmHT
 JLkVYnnpbwO3h2RfVC3hnx3Im8wJ2IqilDKfDq7n5k/cW03IJeEvWMzvPvKGlH47WG+a
 dJqHDXKIpMFh9qq7BVoZgh3HxQNdS7ITbTu3badhnb2vHscha8yvDeoX6uJqyv1E7Clb
 q0aXP4DytimNNH+vC12Fj4en47jsjvqVTY+9rwQhh6oQk5WFzHAjxrTS5frLqYD8AZ55
 8qr5qv7R5BRyvBnm0TJt1OagDWtm0zdBKf1X1TUezsJrF+QSbUJ7Ya2n9ovp4jUELTEu
 Movw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuGTJg5kq4zf2YncU7VHfTk9qaRqyDXEX9acf2tWC8kiNLlFBPSU6eCrRHS8lndlff9f79+Uw3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz+v8NtSNYxgLcXqBdiuDMO87HUuf1b8u0W2ccjBSamRWNfHrT
 l4cqbA7m9a87Op3D+bQG+24zIJO+crPHsnPQ6KUEaAnuW/o/xbmCBxSzP4d35qjpHC5CRpt4F3H
 oxFHyko81oU5KlGQFCuRFtb6D2kt4aHNW
X-Gm-Gg: ASbGncuJPIE5PKc2FoHN8b6XupAfGruuVx4fPj/6FthvHq9B7qsSMUv1MpCcusspeyY
 PyUica9+jjhiXX63WXbG3DpYN7IFzvsyHWSommek/DIRPH63NVQa4sBcBD01Ei+5/CTmryU0+
X-Google-Smtp-Source: AGHT+IEfXX+QP9LC2AyfnxCgNnxhiEAkU8HrJ3XkmL+aMTqt8JI2i1PjVmvfaIQWrYpE2vJub6jKHPXsgjMgL1Er49U=
X-Received: by 2002:a17:90b:2250:b0:2fc:1370:9c2f with SMTP id
 98e67ed59e1d1-2fc4103cd0dmr593982a91.4.1739577341868; Fri, 14 Feb 2025
 15:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20250214230011.439163-1-siqueira@igalia.com>
 <CADnq5_P0BX1VT6F1Bo6Zip+9fsV98Y=XVQDpv-B3NeOKNnDX7w@mail.gmail.com>
 <4rkulwzkqzje6c6yky34fi6jobgpc7ehrktavpswndhfqpjvxt@ivpb2tg5bgbf>
In-Reply-To: <4rkulwzkqzje6c6yky34fi6jobgpc7ehrktavpswndhfqpjvxt@ivpb2tg5bgbf>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Feb 2025 18:55:29 -0500
X-Gm-Features: AWEUYZnPSiTiOl0BMujHcCu06padZuUXzozlxnUKBKIOXfjg3_OafBr09OHAbog
Message-ID: <CADnq5_M3zs+fOsXUxeAc=pcBVpQAw=e0aoNdEQ_Rv1uQXWcXxg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/gpu: Add acronyms for some firmware
 components
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 kernel-dev@igalia.com, Mario Limonciello <mario.limonciello@amd.com>
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

On Fri, Feb 14, 2025 at 6:38=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 02/14, Alex Deucher wrote:
> > On Fri, Feb 14, 2025 at 6:00=E2=80=AFPM Rodrigo Siqueira <siqueira@igal=
ia.com> wrote:
> > >
> > > Users can check the file "/sys/kernel/debug/dri/0/amdgpu_firmware_inf=
o"
> > > to get information on the firmware loaded in the system. This file ha=
s
> > > multiple acronyms that are not documented in the glossary. This commi=
t
> > > introduces some missing acronyms to the AMD glossary documentation. T=
he
> > > meaning of each acronym in this commit was extracted from code
> > > documentation available in the following files:
> > >
> > > - drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > > - drivers/gpu/drm/amd/include/amd_shared.h
> > >
> > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > >  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++=
++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documenta=
tion/gpu/amdgpu/amdgpu-glossary.rst
> > > index 00a47ebb0b0f..3242db32b020 100644
> > > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > @@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
> > >        The number of CUs that are active on the system.  The number o=
f active
> > >        CUs may be less than SE * SH * CU depending on the board confi=
guration.
> > >
> > > +    CE
> > > +      Constant Engine
> > > +
> > >      CP
> > >        Command Processor
> > >
> > > @@ -80,6 +83,9 @@ we have a dedicated glossary for Display Core at
> > >      KIQ
> > >        Kernel Interface Queue
> > >
> > > +    ME
> > > +      Micro Engine
> >
> > This is part of Graphics so maybe something like:
> >
> > ME
> >     MicroEngine (Graphics)
> >
> > > +
> > >      MEC
> > >        MicroEngine Compute
> > >
> > > @@ -92,6 +98,9 @@ we have a dedicated glossary for Display Core at
> > >      MQD
> > >        Memory Queue Descriptor
> > >
> > > +    PFP
> > > +      Pre-Fetch Parser
> >
> > This is also part of GFX.
> >
> > PFP
> > Pre-Fetch Parser (Graphics)
> >
> > > +
> > >      PPLib
> > >        PowerPlay Library - PowerPlay is the power management componen=
t.
> > >
> > > @@ -110,14 +119,26 @@ we have a dedicated glossary for Display Core a=
t
> > >      SH
> > >        SHader array
> > >
> > > +    SMC
> > > +      System Management Controller
> > > +
> > >      SMU
> > >        System Management Unit
> >
> > These two are synonyms.
> >
> > How about
> > SMU / SMC
> > System Management Unit / System Management Controller
> >
> > Other than that, looks good.
> >
>
> Thanks a lot for all the suggestions; I'll make those changes for the
> V2.
>
> btw, from the amdgpu_firmware_info, I did not find the meaning of the
> below acronyms, could you help me with that?
>
> MC

Memory Controller

> SRL(C|G|S)

RLC =3D RunList Controller
The name is a remnant of ages past and doesn't really have much
meaning today.  It's a group of general purpose helper engines for the
GFX block.  It's involved in GFX power management and SR-IOV among
other things.

SRLC =3D SAVE/RESTORE LIST CNTL
SRLG =3D SAVE/RESTORE LIST GPM_MEM
SRLS =3D SAVE/RESTORE LIST SRM_MEM


> IMU

Integrated Management Unit

Another engine which helps with power management tasks.

> ASD

I can't remember what this stands for off hand.  Will need to look it up.

> TOC

Table of Contents

>
> Thanks
> Siqueira
>
> > Alex
> >
> > >
> > >      SS
> > >        Spread Spectrum
> > >
> > > +    TA
> > > +      Trusted Application
> > > +
> > > +    UVD
> > > +      Unified Video Decoder
> > > +
> > >      VCE
> > >        Video Compression Engine
> > >
> > >      VCN
> > >        Video Codec Next
> > > +
> > > +    VPE
> > > +      Video Processing Engine
> > > --
> > > 2.48.1
> > >

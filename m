Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC64CA0EE6
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 20:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B95E10E0C0;
	Tue, 19 Aug 2025 20:14:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5xJTJdd";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5C010E0C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 20:14:23 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2445806ca1aso9381495ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755634463; x=1756239263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1bQ51pMwwuI8atU5VSkXL9QpqwDPTpy3QvzjaQcgBA=;
 b=N5xJTJdd5yO0UIRggS4sOsuHSswHWd+sWQqsZvX+BmoFu574nitIX17ANlLqrFwRtk
 lh5h4VicCseSnTwH4xQQ1gLRa3YoDrhOv6D4VQLM2pkadUJfqFrX3oL01Y3rv6GVI8KW
 nwY0UdZmkjVlgBSVoKmdjBRGtwO1ES3qrCnJmtFUkK0Ox/6au+p5JzSrrkhw9Kiz59lc
 J4siBIYZu/CpHISWxk401vdX+IUKd2PK8koirklUURTTWI5u6FSODfcQrOV3Ct5VbOa8
 8W6hL+NCneGZSDwMd2jmbN3YFlJfYKfRUiiibUp+LKu3HVilN0lhQtilEs5i+43OcZWc
 uo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755634463; x=1756239263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1bQ51pMwwuI8atU5VSkXL9QpqwDPTpy3QvzjaQcgBA=;
 b=q29SyDVZ8rJDKGHhkGS/jy1VIUNQR5SZzMr09MHHXVPjDxi/izov/TIQvqSj8lbawJ
 P0TIMB5rO2asOZ7992euYXjY1i+up6/TvbSZSnSmGkPUl4Es77GWUoOtLwGZ0+UwYXwc
 N3li6N3Bj443AyAf2Ng50yuZqkk4GvOff5WlZ+IDlCXwekmE2YHVzoVRujDVp70CDA7r
 Yp+VIMSCJvV+7NhTDUW7Rt72+PN0KL26ffbQkNoy6O8ZHtnI5hiEs96iQ9UNMFsKMzJC
 Z5xaLlDiGMaoD5ivKN4yoOYxFftIXuZRJ9IUlsJZiCJLyDaFRck9GpBw1Cx/cfnMouC0
 zwHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR/11jNtDRx55MqCqHet6GrucnM1TlewbifJysZ6J9DKWufY21/pdHcv+F6fN1JoY0h1SKBqKO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2jJuspSzYC3zXYgM67hQk18TlbQeo2WSSJ91+vdo1N4AE1YwU
 AVv4+Z8sZB9OH9MkmKyeGBS2QqncUQZAjh8kDv+kXMrUkQM/SSSE1tHuE8CnzfLLBjGsK1WMsGo
 sMmvF6dTAJJVGpWOV9tyoNBnIESGtYIU=
X-Gm-Gg: ASbGncsAAGmCaIs0rxryX/dxcYdWKP7inQ7IWdSjLRa9KiRicl8zgeeTQeN99faWDLW
 xzvEZufwGEJPwp61NX+CtfJ+vxkLT5uKr27Mhg0+DDyH91pqj7d5ByG3KSX9k4DXJE+AwNyyM9F
 /QxMafz1L5sWGgzJwcLSaHBbpxu1kz5VV2cyu3+Ko3eSFOiuAMkOQIafmPsHc2m9FhaooDwhV3a
 jqphlw=
X-Google-Smtp-Source: AGHT+IGfA3OipzexqZpXKf5pOVpQB2TWrV7jbfSvwetd4WO+FYlpUm0/rpxwUN30+gzXErCa4UKhHpIci6dqMJAwPk8=
X-Received: by 2002:a17:903:187:b0:242:d237:e20b with SMTP id
 d9443c01a7336-245ef153b90mr1644195ad.4.1755634463105; Tue, 19 Aug 2025
 13:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250816153315.1285182-1-siqueira@igalia.com>
 <20250816153315.1285182-3-siqueira@igalia.com>
 <ddd650e7d6887103c6c91ff89d81411bdf4d0a8e.camel@gmail.com>
In-Reply-To: <ddd650e7d6887103c6c91ff89d81411bdf4d0a8e.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Aug 2025 16:14:09 -0400
X-Gm-Features: Ac12FXx4noN2jNkeEf6tilmDfQBMYSzFblrWWcmeDLgbUiiATRheqJ-7v14yOj8
Message-ID: <CADnq5_M8nEKSVu_2w6P34GBxYHfNzjL_7Ff1GW_Sy6KT-7FmmQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] Documentation/gpu: Add new glossary entries from UMR
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Tue, Aug 19, 2025 at 3:28=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Hi,
>
> On Sat, 2025-08-16 at 09:31 -0600, Rodrigo Siqueira wrote:
> > When using UMR, a dashboard is available that displays the CPC, CPF,
> > CPG, TCP, and UTCL utilization. This commit introduces the meanings
> > of
> > those acronyms (and others) to the glossary to improve the
> > comprehension
> > of the UMR dashboard.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21
> > ++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > index 30812d9d53c6..eb72e6f6d4f1 100644
> > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
> >      CP
> >        Command Processor
> >
> > +    CPC
> > +      Command Processor Compute
> > +
> > +    CPF
> > +      Command Processor Fetch
> > +
> > +    CPG
> > +      Command Processor Graphics
> > +
>
> I would apprectiate a few more details here to connect these to other
> glossary items. Here are a few questions:
>
> - Is CPC the same as MEC?
> - Is CPF the same as PFP?
> - Is CPG the same as ME?

CPC, CPF, and CPG are hardware blocks, MEC/PFP/ME are
microcontrollers.  CPG contains the PFP and ME (and CE on chips which
support it).  CPC contains MEC.  CPF is another hardware block which
provides services to CPG and CPC.

Alex

>
> >      CPLIB
> >        Content Protection Library
> >
> > @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
> >      GMC
> >        Graphic Memory Controller
> >
> > +    GPR
> > +      General Purpose Register
> > +
>
> Does this refer to registers in shaders or registers in the various IP
> blocks? If this is about shaders, it would be useful to mention that in
> the context of shaders, a GPR is either SGPR or VGPR. (Those two are
> already in the glossary.)
>
> >      GPUVM
> >        GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports
> > multiple
> >        virtual address spaces that can be in flight at any given
> > time.  These
> > @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
> >        table for use by the kernel driver or into per process GPUVM
> > page tables
> >        for application usage.
> >
> > +    GWS
> > +      Global Wave Syncs
> > +
> >      IH
> >        Interrupt Handler
> >
> > @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core
> > at
> >      TC
> >        Texture Cache
> >
> > +    TCP (AMDGPU)
> > +      Texture Cache Processing
> > +
> >      TOC
> >        Table of Contents
> >
> >      UMSCH
> >        User Mode Scheduler
> >
> > +    UTCL
> > +      Universal Texture Cache Line
> > +
> >      UVD
> >        Unified Video Decoder
> >

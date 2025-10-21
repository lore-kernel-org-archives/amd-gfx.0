Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B37CCD1AA
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 21:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAA210E315;
	Tue, 21 Oct 2025 21:34:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBavZ8ub";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B596410E315
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 21:34:47 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-290aaff26c1so14727425ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761082487; x=1761687287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QV5grHzHUUovHLc7UGRX6J4NeyCV6y2nFCW/ZV/EPc=;
 b=IBavZ8ubnM8nc1cR2mhJt3SZgR9MuIqkgPGCA08Q59KS+7DgH8nA21Ewq5CWT5KRaO
 IfnwspBml6YW8LFnzT0UxQUyVKnnFg2I+BRE9lGHYYchj6cu3odZrP7lT4SqpjBi3dkl
 LwhOd0+oaapu2cH0ZpUcjTbqj0r/KDtBQ/WMeVZDVt+Of4MpBRoCU4NnArqImi9tBTBi
 gjkIfrrE3LIlBZKE8AuhWGNS81KI1ZsbjVjp8YMXRKZXSZpioUh8pij/N5No/dNJq82g
 m1+4hajT5Lw70RSDQl/KckXt6LJINQZfinWz8ZNU2eAJlstvGAne5mOWg2IuGg8feH2w
 8VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761082487; x=1761687287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QV5grHzHUUovHLc7UGRX6J4NeyCV6y2nFCW/ZV/EPc=;
 b=RXDpsC0atx9MtMLJi7NtPbfrSSvGb6EKdp7LgYsMX50j9rnsw3eLDMnHzVqTi+EZec
 pLmQf+kdC0gEvMzpYq/G8NL8VXprGHlSqRashJmZOB58RibcbIDYA26JgcUq2czJCfhu
 gX2KkDPvNjjotA3fEM+sM/YxzVtUPavM1DSzvPhhnE+vgR8MejtFSFJsr+PaQyiEy5/U
 MmJoRvYkEBsutDPWE//zqDRHBuGHrC6yE1/jApklSuOfzf4sdcDbpSQPPdvcaKd1Szux
 JYUh+04MPyXrBTCT2b8knuKlxfys8RBYmwQT0UNS4oXfmxKyvgYZhrLMAp534/EtU1md
 nDVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxzE3gZ0fSHxXdlvIb6HS+4bZsCPBYzkWakD9onE1JfjEPSQ6PF7vyNITo35+AU6xXuv5qz9X1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQm7ywbElWY0eEwRJHaqFMYaq+zLhcO2Hm0MoPjRMS2nroddlY
 wr205QfJWrdTyhoxPQZAv3IgMD4AjPpNwC7MwsnwkpSmW//llKweiyhwkU9A43o2CNO8kH2Wcte
 M7nD7C0Kzth/1fJ5nbo5MIPmyBfuOKk0=
X-Gm-Gg: ASbGncttShYiBOi9b4GfrivQlJP1txcQZVpowGHBiy+pB67x2D/wUktsT8bdnhrnJ9M
 YAy+qVuTJ8wtI/CLzrtas7Wecmfl8yszs7BpSBSz0qbDZa0VG+TP8QBrC/wPWjQezudPdb2ShQ0
 74cyHwZO+kbbywsq8pTsaeoxFWhQq3A/BtXn/PMWAalSKoJIKp2PpHbM+WuJYIrsFQwIF41UxsY
 w3OhqIw30mWjypBKo2ynF4pNLTEMMwg5WfeKDd/xmNifzleO3h1z9C2P2yr
X-Google-Smtp-Source: AGHT+IE6dLPDRLwOGSddufB9G3mxeAiCdlRygJcTpdN0xQIdbpdtCA40JAfRI9Se6mI8kjvcW+xALzRMPLn66KsITdo=
X-Received: by 2002:a17:903:1746:b0:25c:9c28:b425 with SMTP id
 d9443c01a7336-292d3fe2f79mr28462965ad.11.1761082487192; Tue, 21 Oct 2025
 14:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-4-siqueira@igalia.com>
 <CADnq5_N--t-WbwRC9fuo55cfP8p4Cc-MsdYG11rt0zqaXnkSFQ@mail.gmail.com>
 <mife2uojni66cei4hdxfjofhz5wbc275cxar5ycigy3xgqp2ra@idwfztr7z777>
In-Reply-To: <mife2uojni66cei4hdxfjofhz5wbc275cxar5ycigy3xgqp2ra@idwfztr7z777>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Oct 2025 17:34:34 -0400
X-Gm-Features: AS18NWDd2Ewu993iHcFMO90vzRZx25gjjXsdOFy6Bb1AAGwjYEgT0N6iJSJOQ1Y
Message-ID: <CADnq5_M=aCBuGWwzyW8G3c3EzOeLEnuJsWdqJjASCdtEfUJNAg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Documentation/gpu: Expand generic block information
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
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

On Tue, Oct 21, 2025 at 10:55=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> Hi Alex/Lijo,
>
> On 10/20, Alex Deucher wrote:
> > On Mon, Oct 20, 2025 at 3:56=E2=80=AFPM Rodrigo Siqueira <siqueira@igal=
ia.com> wrote:
> > >
> > > This commit expands the overall explanation about AMD GPU IPs by addi=
ng
> > > more details about their interconnection. Note that this commit inclu=
des
> > > a diagram that provides additional information.
> > >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > >  .../gpu/amdgpu/amd_overview_block.svg         | 674 ++++++++++++++++=
++
> > >  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
> > >  Documentation/gpu/amdgpu/driver-core.rst      |  25 +
> > >  3 files changed, 702 insertions(+)
> > >  create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
> > >
> > > diff --git a/Documentation/gpu/amdgpu/amd_overview_block.svg b/Docume=
ntation/gpu/amdgpu/amd_overview_block.svg
> > > new file mode 100644
> > > index 000000000000..8d9ae95bd9a5
> > > --- /dev/null
> > > +++ b/Documentation/gpu/amdgpu/amd_overview_block.svg
> >
> > Got a link to the diagram anywhere?  These looked good at XDC.
>
> After reading your comment in the cover-letter about this diagram, I
> made the following modifications:
>
> 1. Connect PSP to UMC.
> 2. Connect PSP to GC.
> 3. Connect GC to UMC.
> 4. To avoid confusion, I moved the green block outside each specific IP.
> I also changed the explanation about these parts in the text, see it
> below.
>
> Here is the new version:
>
> https://people.igalia.com/siqueira/kernel-doc-imgs/v4/amd_overview_block.=
svg
>
> What do you think?

Looks good!

>
> >
> > > @@ -0,0 +1,674 @@
> > > +<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
> > > +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> > > +
> > > +<svg
>
> <snip>
>
> > > +</svg>
> > > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documenta=
tion/gpu/amdgpu/amdgpu-glossary.rst
> > > index eb72e6f6d4f1..a3f9565d655b 100644
> > > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > @@ -227,6 +227,9 @@ we have a dedicated glossary for Display Core at
> > >      TOC
> > >        Table of Contents
> > >
> > > +    UMC
> > > +      Unified Memory Controller
> > > +
> > >      UMSCH
> > >        User Mode Scheduler
> > >
> > > diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation=
/gpu/amdgpu/driver-core.rst
> > > index 3ce276272171..13f13e2e5497 100644
> > > --- a/Documentation/gpu/amdgpu/driver-core.rst
> > > +++ b/Documentation/gpu/amdgpu/driver-core.rst
> > > @@ -77,6 +77,31 @@ VCN (Video Core Next)
> > >      decode.  It's exposed to userspace for user mode drivers (VA-API=
,
> > >      OpenMAX, etc.)
> > >
> > > +It is important to note that these blocks can interact with each oth=
er. The
> > > +picture below illustrates some of the components and their interconn=
ection:
> > > +
> > > +.. kernel-figure:: amd_overview_block.svg
> > > +
> > > +In the diagram, memory-related blocks are represented by a green col=
or. Notice
> > > +that specific IPs have a green block that represents a small hardwar=
e block
> > > +named 'hub', which is responsible for interfacing with memory (pre-v=
ega devices
> > > +have a dedicated block for that, named GMC). In the driver code, you=
 can
> > > +identify this component by looking for the suffix hub, for example: =
gfxhub,
> > > +dchub, mmhub, vmhub, etc. All memory hubs are connected in the UMC, =
which in
> >
> > All memory hubs are connected to the UMCs, which in
>
> Based on Lijo's comment and Alex's comment in the cover-latter, I
> rewrote this paragraph to:
>
> In the diagram, memory-related blocks are shown in green. Notice that
> specific IPs have a green square that represents a small hardware block
> named 'hub', which is responsible for interfacing with memory. All
> memory hubs are connected in the UMCs, which in turn are connected to
> memory blocks. As a note, pre-vega devices have a dedicated block for
> the Graphic Memory Controller (GMC), which was replaced by UMC in new
> architectures. In the driver code, you can identify this component by

GMC was replaced by UMC + hubs.

> looking for the suffix hub, for example: gfxhub, dchub, mmhub, vmhub,
> etc. Keep in mind that the component's interaction with the memory block
> may vary across architectures. For example, on Navi and newer, GC and
> SDMA are both attached to GCHUB; on pre-Navi, SDMA goes through MMHUB;
> VCN, JPEG, and VPE go through MMHUB; DCN goes through DCHUB.
>
> What do you think?

Looks good to me.

>
> Also, keep in mind that this text is part of the below page that already
> have some comments about GMC.
>
> https://origin.kernel.org/doc/html/latest/gpu/amdgpu/driver-core.html
>
> >
> > > +turn is connected to memory blocks.
> > > +
> > > +There is some level of protection for certain elements in memory, an=
d the PSP
> > > +plays an essential role in this area. For example, when a specific f=
irmware is
> > > +loaded into the memory, PSP takes an action to ensure that the firmw=
are has a
> > > +valid signature.
> >
> > It also stores the firmware images in a protected memory area (TMR =3D
> > Trusted Memory Area) so the OS or driver can't corrupt it at runtime
> > after it's been validated.
> >
> > > Another use of PSP is to support the TA (e.g., HDCP) and
> >
> > TA =3D Trusted Application
> > Basically small application that runs on the trusted processor and
> > handles a trusted operation.
> >
> > > +encrypted memory via TMZ.
> >
> > TMZ (Trusted Memory Zone -- encrypted memory for content protection).
> >
>
> I also rewrote this paragraph to address both of your comments:
>
> There is some protection for certain memory elements, and the PSP plays
> an essential role in this area. When a specific firmware is loaded into
> memory, the PSP takes steps to ensure it has a valid signature. It also
> stores firmware images in a protected memory area named Trusted
> Memory Area (TMR), so the OS or driver can't corrupt them at runtime. Ano=
ther
> use of PSP is to support the Trusted Application (TA), which is
> basically a small application that runs on the trusted processor and

use of PSP is to support Trusted Applications (TA), which are
basically small applications that run on the trusted processor and

> handles a trusted operation (e.g., HDCP). PSP is also used for encrypted
> memory for content protection via Trusted Memory Zone (TMZ).
>
> Does it looks good for a v4?
>
> > > +
> > > +Another IP that deserves attention is the SMU, as it is connected to=
 all the
> > > +other IPs. SMU will help put the GPU in optimal utilization by takin=
g into
> > > +account performance and power consumption. SMU helps other blocks to=
 set up a
> > > +proper clock configuration. Another feature of SMU is the support fo=
r resetting
> > > +every component.
> >
> > How about something like:
> >
> > Another important IP is the SMU.  It handles reset distribution as
> > well as clock and power management for all of the IPs on the SoC.
>
> Ok, how about this paragraph for the v4:
>
> Another critical IP is the SMU. It handles reset distribution as well as
> clock and power management for all of the IPs on the SoC. SMU also helps
> to optimize GPU utilization by balancing performance and power
> consumption. Finally, SMU also supports thermal management.

I would include thermal in the first sentence.  E.g., "clock, thermal,
and power management"

Also, the use of "utilization" seems weird.  I think of utilization as
the resources used on the GPU.  Use of the GPU resources is managed by
the scheduler and the driver.  The SMU tries to align performance with
demand.

Thanks,

Alex

>
> Thanks
> Siqueira
>
> >
> > Alex
> >
> > > +
> > >  .. _pipes-and-queues-description:
> > >
> > >  GFX, Compute, and SDMA Overall Behavior
> > > --
> > > 2.51.0
> > >
>
> --
> Rodrigo Siqueira

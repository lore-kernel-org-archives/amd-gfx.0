Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A768CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 14:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E2210E612;
	Tue, 21 Oct 2025 14:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iBqT1kPl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227EC10E610
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hBGIyDaNH8rCNOreCCBw8n92x0AO0JZSrd4T0q8q8Dw=; b=iBqT1kPlWEpC5vm0K4UQ19AOLE
 V53SJ98MsFp0SyO5e4tFPx1NdylDic71RtUx3w9BHggmBBeZs7Blhp/7HYvaiV1BDFIAV9v9qg/xU
 L2/N+BKLrrwkQKytZSz31wSw+BXMg4idGs2VLL1sDJCWZusGO9EAbQb86csWw7xzJF6OSW4KQ4ens
 zai7M2fGEtIEao29GJNKt91l2AOlmwn8IQpiQ1I58w4zcnvDHcBnMZe7rGk4brYNmKyCBnmuAqgTJ
 E/j6ubcIX0o5z/Z1QSS1sHCa4yVal9euTRvqwcrcVyUeH28a/1AwZ7EEg9XsL0YxOE4yLtSvneqDj
 IJL9UKJA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vBDlu-00CaX9-RF; Tue, 21 Oct 2025 16:55:35 +0200
Date: Tue, 21 Oct 2025 08:55:30 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 3/5] Documentation/gpu: Expand generic block information
Message-ID: <mife2uojni66cei4hdxfjofhz5wbc275cxar5ycigy3xgqp2ra@idwfztr7z777>
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-4-siqueira@igalia.com>
 <CADnq5_N--t-WbwRC9fuo55cfP8p4Cc-MsdYG11rt0zqaXnkSFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_N--t-WbwRC9fuo55cfP8p4Cc-MsdYG11rt0zqaXnkSFQ@mail.gmail.com>
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

Hi Alex/Lijo,

On 10/20, Alex Deucher wrote:
> On Mon, Oct 20, 2025 at 3:56 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > This commit expands the overall explanation about AMD GPU IPs by adding
> > more details about their interconnection. Note that this commit includes
> > a diagram that provides additional information.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Timur Kristóf <timur.kristof@gmail.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  .../gpu/amdgpu/amd_overview_block.svg         | 674 ++++++++++++++++++
> >  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
> >  Documentation/gpu/amdgpu/driver-core.rst      |  25 +
> >  3 files changed, 702 insertions(+)
> >  create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg
> >
> > diff --git a/Documentation/gpu/amdgpu/amd_overview_block.svg b/Documentation/gpu/amdgpu/amd_overview_block.svg
> > new file mode 100644
> > index 000000000000..8d9ae95bd9a5
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/amd_overview_block.svg
> 
> Got a link to the diagram anywhere?  These looked good at XDC.

After reading your comment in the cover-letter about this diagram, I
made the following modifications:

1. Connect PSP to UMC.
2. Connect PSP to GC.
3. Connect GC to UMC.
4. To avoid confusion, I moved the green block outside each specific IP.
I also changed the explanation about these parts in the text, see it
below.

Here is the new version:

https://people.igalia.com/siqueira/kernel-doc-imgs/v4/amd_overview_block.svg

What do you think?

> 
> > @@ -0,0 +1,674 @@
> > +<?xml version="1.0" encoding="UTF-8" standalone="no"?>
> > +<!-- Created with Inkscape (http://www.inkscape.org/) -->
> > +
> > +<svg

<snip>

> > +</svg>
> > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > index eb72e6f6d4f1..a3f9565d655b 100644
> > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > @@ -227,6 +227,9 @@ we have a dedicated glossary for Display Core at
> >      TOC
> >        Table of Contents
> >
> > +    UMC
> > +      Unified Memory Controller
> > +
> >      UMSCH
> >        User Mode Scheduler
> >
> > diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> > index 3ce276272171..13f13e2e5497 100644
> > --- a/Documentation/gpu/amdgpu/driver-core.rst
> > +++ b/Documentation/gpu/amdgpu/driver-core.rst
> > @@ -77,6 +77,31 @@ VCN (Video Core Next)
> >      decode.  It's exposed to userspace for user mode drivers (VA-API,
> >      OpenMAX, etc.)
> >
> > +It is important to note that these blocks can interact with each other. The
> > +picture below illustrates some of the components and their interconnection:
> > +
> > +.. kernel-figure:: amd_overview_block.svg
> > +
> > +In the diagram, memory-related blocks are represented by a green color. Notice
> > +that specific IPs have a green block that represents a small hardware block
> > +named 'hub', which is responsible for interfacing with memory (pre-vega devices
> > +have a dedicated block for that, named GMC). In the driver code, you can
> > +identify this component by looking for the suffix hub, for example: gfxhub,
> > +dchub, mmhub, vmhub, etc. All memory hubs are connected in the UMC, which in
> 
> All memory hubs are connected to the UMCs, which in

Based on Lijo's comment and Alex's comment in the cover-latter, I
rewrote this paragraph to:

In the diagram, memory-related blocks are shown in green. Notice that
specific IPs have a green square that represents a small hardware block
named 'hub', which is responsible for interfacing with memory. All
memory hubs are connected in the UMCs, which in turn are connected to
memory blocks. As a note, pre-vega devices have a dedicated block for
the Graphic Memory Controller (GMC), which was replaced by UMC in new
architectures. In the driver code, you can identify this component by
looking for the suffix hub, for example: gfxhub, dchub, mmhub, vmhub,
etc. Keep in mind that the component's interaction with the memory block
may vary across architectures. For example, on Navi and newer, GC and
SDMA are both attached to GCHUB; on pre-Navi, SDMA goes through MMHUB;
VCN, JPEG, and VPE go through MMHUB; DCN goes through DCHUB.

What do you think?

Also, keep in mind that this text is part of the below page that already
have some comments about GMC.

https://origin.kernel.org/doc/html/latest/gpu/amdgpu/driver-core.html

> 
> > +turn is connected to memory blocks.
> > +
> > +There is some level of protection for certain elements in memory, and the PSP
> > +plays an essential role in this area. For example, when a specific firmware is
> > +loaded into the memory, PSP takes an action to ensure that the firmware has a
> > +valid signature.
> 
> It also stores the firmware images in a protected memory area (TMR =
> Trusted Memory Area) so the OS or driver can't corrupt it at runtime
> after it's been validated.
> 
> > Another use of PSP is to support the TA (e.g., HDCP) and
> 
> TA = Trusted Application
> Basically small application that runs on the trusted processor and
> handles a trusted operation.
> 
> > +encrypted memory via TMZ.
> 
> TMZ (Trusted Memory Zone -- encrypted memory for content protection).
> 

I also rewrote this paragraph to address both of your comments:

There is some protection for certain memory elements, and the PSP plays
an essential role in this area. When a specific firmware is loaded into
memory, the PSP takes steps to ensure it has a valid signature. It also
stores firmware images in a protected memory area named Trusted
Memory Area (TMR), so the OS or driver can't corrupt them at runtime. Another
use of PSP is to support the Trusted Application (TA), which is
basically a small application that runs on the trusted processor and
handles a trusted operation (e.g., HDCP). PSP is also used for encrypted
memory for content protection via Trusted Memory Zone (TMZ).

Does it looks good for a v4?

> > +
> > +Another IP that deserves attention is the SMU, as it is connected to all the
> > +other IPs. SMU will help put the GPU in optimal utilization by taking into
> > +account performance and power consumption. SMU helps other blocks to set up a
> > +proper clock configuration. Another feature of SMU is the support for resetting
> > +every component.
> 
> How about something like:
> 
> Another important IP is the SMU.  It handles reset distribution as
> well as clock and power management for all of the IPs on the SoC.

Ok, how about this paragraph for the v4:

Another critical IP is the SMU. It handles reset distribution as well as
clock and power management for all of the IPs on the SoC. SMU also helps
to optimize GPU utilization by balancing performance and power
consumption. Finally, SMU also supports thermal management.

Thanks
Siqueira

> 
> Alex
> 
> > +
> >  .. _pipes-and-queues-description:
> >
> >  GFX, Compute, and SDMA Overall Behavior
> > --
> > 2.51.0
> >

-- 
Rodrigo Siqueira

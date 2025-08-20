Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E49DCA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 22:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BE710E805;
	Wed, 20 Aug 2025 22:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TiOugyW1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CFB10E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pxSfegwcZZGb+rbECdt5zQ9YVmXO2b1dzcnpJUGArX4=; b=TiOugyW1Qr49jnnZsaNzC1eoYV
 za33nvq6WgNDA5Q7cGnJKzaWm0B+0H6cY/3zV+DVSALSrc482FPdP0tcS6rXTh/EalwOKY/QFIB5V
 Ofar+CHPntQCd8YXpxX70XawAzjfbhdSyeITPoRdTnRqsxUastscJ1h6yrKXLE2wgd4nuhnyx5vcN
 o6EnG17S1d6Hgvrxn09RXbtydmifqTC/lt0RlXsb+WSIeIFWghi4mPH5w8f47RPH3vjgBEx5rDuU7
 7Ws4Xb2qmB0Cbos+nrYVFZXOaJ73G01sjtOrJtDh1eXp5AYo8ZwscedJGG9jvUV0MuU8+B5mghqAG
 BjdmUmzA==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uorFL-00GyMw-Kl; Thu, 21 Aug 2025 00:25:32 +0200
Date: Wed, 20 Aug 2025 16:25:27 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH 2/5] Documentation/gpu: Add new glossary entries from UMR
Message-ID: <bh2mepgarolrg3ahpjp54f7mfebe25imj7h3mmm5i5qxv4awxi@6r364jf3d6mq>
References: <20250816153315.1285182-1-siqueira@igalia.com>
 <20250816153315.1285182-3-siqueira@igalia.com>
 <ddd650e7d6887103c6c91ff89d81411bdf4d0a8e.camel@gmail.com>
 <CADnq5_M8nEKSVu_2w6P34GBxYHfNzjL_7Ff1GW_Sy6KT-7FmmQ@mail.gmail.com>
 <498ab5568b1050cc629fb28101370430ec1c14f3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <498ab5568b1050cc629fb28101370430ec1c14f3.camel@gmail.com>
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

On 08/20, Timur Kristóf wrote:
> On Tue, 2025-08-19 at 16:14 -0400, Alex Deucher wrote:
> > On Tue, Aug 19, 2025 at 3:28 PM Timur Kristóf
> > <timur.kristof@gmail.com> wrote:
> > > 
> > > Hi,
> > > 
> > > On Sat, 2025-08-16 at 09:31 -0600, Rodrigo Siqueira wrote:
> > > > When using UMR, a dashboard is available that displays the CPC,
> > > > CPF,
> > > > CPG, TCP, and UTCL utilization. This commit introduces the
> > > > meanings
> > > > of
> > > > those acronyms (and others) to the glossary to improve the
> > > > comprehension
> > > > of the UMR dashboard.
> > > > 
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Christian König <christian.koenig@amd.com>
> > > > Cc: Timur Kristóf <timur.kristof@gmail.com>
> > > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > > ---
> > > >  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21
> > > > ++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > > 
> > > > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > > b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > > index 30812d9d53c6..eb72e6f6d4f1 100644
> > > > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > > > @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core
> > > > at
> > > >      CP
> > > >        Command Processor
> > > > 
> > > > +    CPC
> > > > +      Command Processor Compute
> > > > +
> > > > +    CPF
> > > > +      Command Processor Fetch
> > > > +
> > > > +    CPG
> > > > +      Command Processor Graphics
> > > > +
> > > 
> > > I would apprectiate a few more details here to connect these to
> > > other
> > > glossary items. Here are a few questions:
> > > 
> > > - Is CPC the same as MEC?
> > > - Is CPF the same as PFP?
> > > - Is CPG the same as ME?
> > 
> > CPC, CPF, and CPG are hardware blocks, MEC/PFP/ME are
> > microcontrollers.  CPG contains the PFP and ME (and CE on chips which
> > support it).  CPC contains MEC.  CPF is another hardware block which
> > provides services to CPG and CPC.
> 
> Thanks for the clarification.
> 
> Siquiera - could we add that also to the glossary?

Hi Timur,

All of the acronyms mentioned are already part of the glossary, and this
commit introduces the missing ones. For more details about the
relationship between the different hardware blocks, patch number 4
provides additional information. I can add Alex's comments to patch 4 in
V2. I'll wait a little bit to see if anyone else has any comments on
patches 3, 4 and 5, before I send a V2.

Thanks

> 
> Thanks,
> Timur
> 
> > 
> > 
> > > 
> > > >      CPLIB
> > > >        Content Protection Library
> > > > 
> > > > @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core
> > > > at
> > > >      GMC
> > > >        Graphic Memory Controller
> > > > 
> > > > +    GPR
> > > > +      General Purpose Register
> > > > +
> > > 
> > > Does this refer to registers in shaders or registers in the various
> > > IP
> > > blocks? If this is about shaders, it would be useful to mention
> > > that in
> > > the context of shaders, a GPR is either SGPR or VGPR. (Those two
> > > are
> > > already in the glossary.)
> > > 
> > > >      GPUVM
> > > >        GPU Virtual Memory.  This is the GPU's MMU.  The GPU
> > > > supports
> > > > multiple
> > > >        virtual address spaces that can be in flight at any given
> > > > time.  These
> > > > @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core
> > > > at
> > > >        table for use by the kernel driver or into per process
> > > > GPUVM
> > > > page tables
> > > >        for application usage.
> > > > 
> > > > +    GWS
> > > > +      Global Wave Syncs
> > > > +
> > > >      IH
> > > >        Interrupt Handler
> > > > 
> > > > @@ -206,12 +221,18 @@ we have a dedicated glossary for Display
> > > > Core
> > > > at
> > > >      TC
> > > >        Texture Cache
> > > > 
> > > > +    TCP (AMDGPU)
> > > > +      Texture Cache Processing
> > > > +
> > > >      TOC
> > > >        Table of Contents
> > > > 
> > > >      UMSCH
> > > >        User Mode Scheduler
> > > > 
> > > > +    UTCL
> > > > +      Universal Texture Cache Line
> > > > +
> > > >      UVD
> > > >        Unified Video Decoder
> > > > 

-- 
Rodrigo Siqueira

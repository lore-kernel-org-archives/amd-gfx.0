Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2C7C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 23:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD91610E0DE;
	Fri, 14 Feb 2025 23:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pFrb4o7F";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111C110E0DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 23:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hArMmSF3X2IQOmSFxXB7EEuPOrlcE0tFNLe2BJiR8Uw=; b=pFrb4o7FTl6XoGdGTqjh2baUii
 W7HB6/AsV6wL7GeHRluueWlDm6L+RsaqiGszBgs8yz7XNNUOMVqkx0tp+Gd2oPTxmRu391pdySy2X
 hqNN0Cei527XxbiURk4TliNAadYo5O/4qDq1Laue+FUEgOE4lPlNMcEwqqJo9i6KFQYl2nZwwzqGS
 vxB4H3uXLN61IF/lKeayX2zO9q91jIFc0v9cjSI7maZt2yLmWeFfzFGjVlYC/4RX//ZKtsDYcR9sw
 HxzNBzlBNL2XAyPMEXkCNLydSl1o0MwPIjSSCwjYGNGVTWcreGu0OMqlq+dZmctnOoxtpbnlmIEVN
 BdciHVOA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tj5GF-002Ump-FI; Sat, 15 Feb 2025 00:38:25 +0100
Date: Fri, 14 Feb 2025 16:38:21 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 kernel-dev@igalia.com, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] Documentation/gpu: Add acronyms for some firmware
 components
Message-ID: <4rkulwzkqzje6c6yky34fi6jobgpc7ehrktavpswndhfqpjvxt@ivpb2tg5bgbf>
References: <20250214230011.439163-1-siqueira@igalia.com>
 <CADnq5_P0BX1VT6F1Bo6Zip+9fsV98Y=XVQDpv-B3NeOKNnDX7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_P0BX1VT6F1Bo6Zip+9fsV98Y=XVQDpv-B3NeOKNnDX7w@mail.gmail.com>
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

On 02/14, Alex Deucher wrote:
> On Fri, Feb 14, 2025 at 6:00 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > Users can check the file "/sys/kernel/debug/dri/0/amdgpu_firmware_info"
> > to get information on the firmware loaded in the system. This file has
> > multiple acronyms that are not documented in the glossary. This commit
> > introduces some missing acronyms to the AMD glossary documentation. The
> > meaning of each acronym in this commit was extracted from code
> > documentation available in the following files:
> >
> > - drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > - drivers/gpu/drm/amd/include/amd_shared.h
> >
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > index 00a47ebb0b0f..3242db32b020 100644
> > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > @@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
> >        The number of CUs that are active on the system.  The number of active
> >        CUs may be less than SE * SH * CU depending on the board configuration.
> >
> > +    CE
> > +      Constant Engine
> > +
> >      CP
> >        Command Processor
> >
> > @@ -80,6 +83,9 @@ we have a dedicated glossary for Display Core at
> >      KIQ
> >        Kernel Interface Queue
> >
> > +    ME
> > +      Micro Engine
> 
> This is part of Graphics so maybe something like:
> 
> ME
>     MicroEngine (Graphics)
> 
> > +
> >      MEC
> >        MicroEngine Compute
> >
> > @@ -92,6 +98,9 @@ we have a dedicated glossary for Display Core at
> >      MQD
> >        Memory Queue Descriptor
> >
> > +    PFP
> > +      Pre-Fetch Parser
> 
> This is also part of GFX.
> 
> PFP
> Pre-Fetch Parser (Graphics)
> 
> > +
> >      PPLib
> >        PowerPlay Library - PowerPlay is the power management component.
> >
> > @@ -110,14 +119,26 @@ we have a dedicated glossary for Display Core at
> >      SH
> >        SHader array
> >
> > +    SMC
> > +      System Management Controller
> > +
> >      SMU
> >        System Management Unit
> 
> These two are synonyms.
> 
> How about
> SMU / SMC
> System Management Unit / System Management Controller
> 
> Other than that, looks good.
>

Thanks a lot for all the suggestions; I'll make those changes for the
V2.

btw, from the amdgpu_firmware_info, I did not find the meaning of the
below acronyms, could you help me with that?

MC
SRL(C|G|S)
IMU
ASD
TOC

Thanks
Siqueira
 
> Alex
> 
> >
> >      SS
> >        Spread Spectrum
> >
> > +    TA
> > +      Trusted Application
> > +
> > +    UVD
> > +      Unified Video Decoder
> > +
> >      VCE
> >        Video Compression Engine
> >
> >      VCN
> >        Video Codec Next
> > +
> > +    VPE
> > +      Video Processing Engine
> > --
> > 2.48.1
> >

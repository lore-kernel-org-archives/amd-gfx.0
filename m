Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA37ECCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 14:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E2C10E0FC;
	Tue, 28 Oct 2025 14:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UnZJQuqw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3131710E0FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hWyZVs0lVnCCk3Q2Wpl8XHmPbmm4uBEsMkZ50AJJI7w=; b=UnZJQuqwa0I80ykvMY74/D6x5g
 lHweRyJJVRgxi76rfkPGLiQmUcMrhZmB2cc3KNEmJ0oIFSRSadZqcSrSU23B47Bn2VWxOV4Bo/cai
 To79YquqSYOiz+cDBzYpUGcf5lGP0SnkL+dpmxnSS6WNiyZMfiz4KSMDNrsP8I6GxnwJjjVedT5OJ
 Aun4pEsxT2f9CoNSRq5UlKYto3OxFxvXANuoxYWC/VuZJdMCr1pmHrGtP3tSlRiRz7azYVCWXbVEo
 3of0CC2sTsApIz0ZCrNlEaStsCb/d6FHbj/+O17h7g01GF6eOEfN3QSNYZKcoEQsMVxMH/eMgPZiE
 W5Y7vPRg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vDkon-00GDOW-34; Tue, 28 Oct 2025 15:37:01 +0100
Date: Tue, 28 Oct 2025 08:36:57 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 2/5] Documentation/gpu: Add new glossary entries from
 UMR
Message-ID: <s3g7ba6quaf5nfiatc3bsx4siedicvxfbd4ih5uxvszpwmfxvr@5kqshwgvarrq>
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-3-siqueira@igalia.com>
 <724fa441-28a5-4dcd-b967-3054eb6ab3b2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <724fa441-28a5-4dcd-b967-3054eb6ab3b2@amd.com>
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

On 10/28, Christian König wrote:
> On 10/20/25 21:38, Rodrigo Siqueira wrote:
> > When using UMR, a dashboard is available that displays the CPC, CPF,
> > CPG, TCP, and UTCL utilization. This commit introduces the meanings of
> > those acronyms (and others) to the glossary to improve the comprehension
> > of the UMR dashboard.
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Timur Kristóf <timur.kristof@gmail.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
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
> >      GPUVM
> >        GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
> >        virtual address spaces that can be in flight at any given time.  These
> > @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
> >        table for use by the kernel driver or into per process GPUVM page tables
> >        for application usage.
> >  
> > +    GWS
> > +      Global Wave Syncs
> > +
> >      IH
> >        Interrupt Handler
> >  
> 
> BTW we are missing an entry for "IV Interrupt Vector (the bytes written by the GPU into IH ring buffer)".
> 
> > @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core at
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
> 
> Mhm, UTCL0 UTCL1 and UTCL2 are usually Universal Translation Cache Layer 0-2.
> 
> That is not even remotely related to texturing (well UTC requests also go through the TC on some HW generations, but that's basically it).

Hi Christian,

I addressed this issue in the V4 version of this series:

https://patchwork.freedesktop.org/patch/683171/?series=153014&rev=4

Thanks

> 
> Regards,
> Christian.
> 
> >      UVD
> >        Unified Video Decoder
> >  
> 

-- 
Rodrigo Siqueira

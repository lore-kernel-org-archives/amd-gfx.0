Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4384CCD1A7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 13:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8EC10E5E8;
	Tue, 21 Oct 2025 13:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="C6MMNwWA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3915F10E5E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pegrX0FQxQUYF2NGB9tEMAwJgPUD4/tDmAySonDQsb4=; b=C6MMNwWA50yWj+TA9h5fuPP4NY
 D9e6DEmHHu/ZMCd+xCxDwRZvKrRHr7uc+9pTJTh75K9vjac7CMIRtBg9d7J43dZPStHVNuRpUXRBM
 ltOyjFXWimRMj2wGNeKmwV4Z7ZuWgbZrEcDlq2vyJUyYQjdp7LFyXytoW1dcHWvsGy4r2vQGJuR7+
 9wURb3wstBNQ/Jfs0Yh1V5FS9/pA86YD9A9nam7KnT6ZMWNzzV2db4ye1KVR7orY97pbMxnuY6ikO
 d4BuzcTeJEuCAH8P2Zk/sKrH1yeFjFrdm24SaeQ3y3JiwfHGo9pKWDCInvSbc/EqBFIS28KZQ3Jzz
 T8W9MQwQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vBCMU-00CXbZ-14; Tue, 21 Oct 2025 15:25:14 +0200
Date: Tue, 21 Oct 2025 07:25:09 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 2/5] Documentation/gpu: Add new glossary entries from
 UMR
Message-ID: <4neu3psu5mpeb2umbptkg2xo3aptojao6jqaxjq4pcfc6ruwsk@mlcszrb5upi5>
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-3-siqueira@igalia.com>
 <26d69e19-a6dc-4506-b19a-7803323b5178@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26d69e19-a6dc-4506-b19a-7803323b5178@amd.com>
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

On 10/21, Lazar, Lijo wrote:
> 
> 
> On 10/21/2025 1:08 AM, Rodrigo Siqueira wrote:
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
> >   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > index 30812d9d53c6..eb72e6f6d4f1 100644
> > --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> > @@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
> >       CP
> >         Command Processor
> > +    CPC
> > +      Command Processor Compute
> > +
> > +    CPF
> > +      Command Processor Fetch
> > +
> > +    CPG
> > +      Command Processor Graphics
> > +
> >       CPLIB
> >         Content Protection Library
> > @@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
> >       GMC
> >         Graphic Memory Controller
> > +    GPR
> > +      General Purpose Register
> > +
> >       GPUVM
> >         GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
> >         virtual address spaces that can be in flight at any given time.  These
> > @@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
> >         table for use by the kernel driver or into per process GPUVM page tables
> >         for application usage.
> > +    GWS
> > +      Global Wave Syncs
> 
> Sync (s is not there).

I'll fix it in the V4.

> > +
> >       IH
> >         Interrupt Handler
> > @@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core at
> >       TC
> >         Texture Cache
> > +    TCP (AMDGPU)
> > +      Texture Cache Processing
> 
> Texture Cache per Pipe - terminology used for L1 cache in old architecture.

Alex, Lijo,

How about the following modification for the V4:

TCP (AMDGPU)
  Texture Cache per Pipe. Even though the name "Texture" is part of this
  acronym, the TCP represents the path to memory shaders; i.e., it is not
  related to texture. The name is a leftover from older designs where
  shader stages had different cache designs; it refers to the L1 cache in
  older architectures.

> 
> > +
> >       TOC
> >         Table of Contents
> >       UMSCH
> >         User Mode Scheduler
> > +    UTCL
> > +      Universal Texture Cache Line
> 
> Unified Translation Cache - equivalent of TLB. Has multiple levels, hence L
> may be dropped.

How about the following modification for the V4:

UTC (AMDGPU)
  Unified Translation Cache. UTC is equivalent to TLB. You might see a
  variation of this acronym with L at the end, i.e., UTCL followed by a
  number; L means the cache level (e.g., UTCL1 and UTCL2).

The reason that I kept the L explanation is that UTCL appears in some
parts of the code and also in the UMR gui. Keeping this acronym here can
facilitate code searches and also provide some extra background on the L
part. Is it ok for you?

Thanks Alex/Lijo.

> 
> Thanks,
> Lijo
> 
> > +
> >       UVD
> >         Unified Video Decoder
> 

-- 
Rodrigo Siqueira

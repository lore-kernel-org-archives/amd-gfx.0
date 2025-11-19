Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F69CF2561
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 00:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B4310E546;
	Wed, 19 Nov 2025 00:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LClxi+IM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3057D10E545
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 00:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fw23php0pKX3qR9281EDPZ3KUNe5ZzeeoOgWK8R8VJU=; b=LClxi+IMlS3p1km91IkE9nj2b7
 W7jxcXaTYy5LHxgDb+dh08lFpxGOBCbpupOWlnDu8LA3hQsE99v0XfP4/7PbpRCEsEXVM9oe4XpdY
 g/cz6Yh/TnYRZLH4/RUcPbZkrED55vTXhutjuyxhjE29tJToabo2EiRjDlPi0jSdA92iJmqY4+YdP
 oCiQ2f/jKCH6akp/xRU9ocU48Jl87o57AtzGCVLC+Jah24hzkurCRcPtDM8YPG5m3TvsryBDc0Cb3
 8TT+k594+PrvrLkFXEDAV/mhR3NbHdaXSR1XCzUzauBxrceKnmNiprA2bB5FTvORZYin10suyRTrn
 kbx42ulg==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vLWNK-002Mxr-Uk; Wed, 19 Nov 2025 01:48:46 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v5 2/5] Documentation/gpu: Add new glossary entries from UMR
Date: Tue, 18 Nov 2025 17:45:51 -0700
Message-ID: <20251119004818.4126460-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119004818.4126460-1-siqueira@igalia.com>
References: <20251119004818.4126460-1-siqueira@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When using UMR, a dashboard is available that displays the CPC, CPF,
CPG, TCP, and UTCL utilization. This commit introduces the meanings of
those acronyms (and others) to the glossary to improve the comprehension
of the UMR dashboard.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 30812d9d53c6..3a34b7d181ff 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -30,6 +30,15 @@ we have a dedicated glossary for Display Core at
     CP
       Command Processor
 
+    CPC
+      Command Processor Compute
+
+    CPF
+      Command Processor Fetch
+
+    CPG
+      Command Processor Graphics
+
     CPLIB
       Content Protection Library
 
@@ -78,6 +87,9 @@ we have a dedicated glossary for Display Core at
     GMC
       Graphic Memory Controller
 
+    GPR
+      General Purpose Register
+
     GPUVM
       GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
       virtual address spaces that can be in flight at any given time.  These
@@ -92,9 +104,15 @@ we have a dedicated glossary for Display Core at
       table for use by the kernel driver or into per process GPUVM page tables
       for application usage.
 
+    GWS
+      Global Wave Sync
+
     IH
       Interrupt Handler
 
+    IV
+      Interrupt Vector
+
     HQD
       Hardware Queue Descriptor
 
@@ -206,12 +224,24 @@ we have a dedicated glossary for Display Core at
     TC
       Texture Cache
 
+    TCP (AMDGPU)
+      Texture Cache per Pipe. Even though the name "Texture" is part of this
+      acronym, the TCP represents the path to memory shaders; i.e., it is not
+      related to texture. The name is a leftover from older designs where shader
+      stages had different cache designs; it refers to the L1 cache in older
+      architectures.
+
     TOC
       Table of Contents
 
     UMSCH
       User Mode Scheduler
 
+    UTC (AMDGPU)
+      Unified Translation Cache. UTC is equivalent to TLB. You might see a
+      variation of this acronym with L at the end, i.e., UTCL followed by a
+      number; L means the cache level (e.g., UTCL1 and UTCL2).
+
     UVD
       Unified Video Decoder
 
-- 
2.51.0


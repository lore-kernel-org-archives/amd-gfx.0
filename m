Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269FCCCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 22:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C7310E972;
	Thu, 23 Oct 2025 22:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Fuci2zMb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6203A10E96B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 22:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kOnRyOUveAL+m8WtpiA/eFL1HEPuLromPLGaInU7CDE=; b=Fuci2zMboPRHrk98sxwaeR5JJ8
 u2GZ2jnycu94BBtskutbFXxXYJC2trPYjsF4LHxhlbxQ7tCMvC+2+udZB83DbmAT1tR3t+6bCWxLW
 2JdLEwFtFbCV6l9Y/vtYDNOE+sOAm73Y7xlktK6nzJo0u0gScwCE8pYVF+hs2TVtOpeu0vF2Oh987
 NqB3EXRXDfgGZsE7Fum4lPpJgyyidUniFV5inE4ZY7cYMe7pZDyoL999AY+6yfJF3Mm+l3jUuIdan
 zr3YIUO1oYWBDvhobBKu8lLmz02vzL0cLv/3kvRMFvzgBOL0AkBkPj88gRncM3WWx7a7Oc72ab1/t
 ps7PI1Lw==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vC3y4-00DpJV-Lg; Fri, 24 Oct 2025 00:39:37 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v4 2/5] Documentation/gpu: Add new glossary entries from UMR
Date: Thu, 23 Oct 2025 16:38:45 -0600
Message-ID: <20251023223918.601594-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023223918.601594-1-siqueira@igalia.com>
References: <20251023223918.601594-1-siqueira@igalia.com>
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
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 30812d9d53c6..2fc2a1cbd77d 100644
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
@@ -92,6 +104,9 @@ we have a dedicated glossary for Display Core at
       table for use by the kernel driver or into per process GPUVM page tables
       for application usage.
 
+    GWS
+      Global Wave Sync
+
     IH
       Interrupt Handler
 
@@ -206,12 +221,24 @@ we have a dedicated glossary for Display Core at
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


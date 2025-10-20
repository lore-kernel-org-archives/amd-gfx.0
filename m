Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC1CCD1A7
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 19:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A6F10E4D1;
	Mon, 20 Oct 2025 19:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aFKh1iS/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AF410E4D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 19:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dz2wcENkzj7cy4Vc8TmdGAYI8DdPZg9aWW9uBqunImM=; b=aFKh1iS/4Kwl58mf6qUlIiLSsN
 RtxfgJdjdMBznW1vnW2QaG+roAklDdHW7d/2InS3tHYIppCt43njeDvu4qv+d7wUBH1kEUi24V8+x
 YsILrwMXNFpi11RA+PkaW1Sa+ynk5rMF/qkOJBUBrcC0VXvhR/hbX5dKTXp4A37tVxb6YJ9KH4/nd
 hkuDAkZ4R2X4o5P7Xp728Uem5Ee1GMcaJXH/V6pY/S3MhyrAvq4roF9Jp7dYQGJYdi9IX02KePZS2
 Gj2j/g4+iQAZuSyVzvPfh/I3qVjLtHjzRdwCcqT6wFKQb4/RoDqhDmeIbBMtD9/07gYnag/fA+d4c
 DVbL6WCQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.home.app) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vAvqf-00CEgQ-Ja; Mon, 20 Oct 2025 21:47:18 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 2/5] Documentation/gpu: Add new glossary entries from UMR
Date: Mon, 20 Oct 2025 13:38:33 -0600
Message-ID: <20251020194631.102260-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020194631.102260-1-siqueira@igalia.com>
References: <20251020194631.102260-1-siqueira@igalia.com>
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
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 30812d9d53c6..eb72e6f6d4f1 100644
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
+      Global Wave Syncs
+
     IH
       Interrupt Handler
 
@@ -206,12 +221,18 @@ we have a dedicated glossary for Display Core at
     TC
       Texture Cache
 
+    TCP (AMDGPU)
+      Texture Cache Processing
+
     TOC
       Table of Contents
 
     UMSCH
       User Mode Scheduler
 
+    UTCL
+      Universal Texture Cache Line
+
     UVD
       Unified Video Decoder
 
-- 
2.51.0


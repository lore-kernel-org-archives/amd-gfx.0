Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB55EC3ABB0
	for <amd-gfx@archiver.kernel.org>; Sat,  3 May 2025 20:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31C9710E21E;
	Sat,  3 May 2025 20:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g74FYqQj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F42D10E03C
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 May 2025 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OfRskOe2zsu2q+61vGkLhT5wiHVUhOiqBnire9yymKM=; b=g74FYqQjnNovX/J3wwlefnVocT
 mUwkfq/zAOERElqp2Ft3nJYOdJaB5GrjH1CudZ6MdhVFTLUflyXpodEesyyYF6uRHjrlMZqk3hqRX
 ZTdBJeelv7SMcjA8xczZuDWYVVD9y/rXakocU8gPZnpCpwIlHbkpaMJwqHELcVaNaSgeCN1o5HvSy
 Yp0NPK2ruvsETqPCwzxiIvwLdVR49Frcdb7OJ3bvm85P6LQEnKsEC1qNrDZ2sCA4ioTelnclIoL+h
 QoHM7nGyqCWr0HrtWHhV8xxDJ/tg7lrN0ccve4n7zdowovfh6/P1k0iYHLF71e+Aa0wiUOl7U4o+0
 aTE/BSvQ==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBJbU-002dFw-KF; Sat, 03 May 2025 22:39:25 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 2/2] Documentation/gpu: Add new entries to amdgpu glossary
Date: Sat,  3 May 2025 14:38:43 -0600
Message-ID: <20250503203905.346049-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250503203905.346049-1-siqueira@igalia.com>
References: <20250503203905.346049-1-siqueira@igalia.com>
MIME-Version: 1.0
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

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 8e6af7cc76c2..70aceff4bdc6 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -24,6 +24,9 @@ we have a dedicated glossary for Display Core at
     CIK
       Sea Islands
 
+    CB
+      Color Buffer
+
     CP
       Command Processor
 
@@ -39,6 +42,9 @@ we have a dedicated glossary for Display Core at
     CU
       Compute Unit
 
+    DB
+      Depth Buffer
+
     DFS
       Digital Frequency Synthesizer
 
@@ -63,6 +69,12 @@ we have a dedicated glossary for Display Core at
     GC
       Graphics and Compute
 
+    GDS
+      Global Data Share
+
+    GE
+      Geometry Engine
+
     GMC
       Graphic Memory Controller
 
@@ -128,6 +140,9 @@ we have a dedicated glossary for Display Core at
     MQD
       Memory Queue Descriptor
 
+    PA
+      Primitive Assembler / Physical Address
+
     PFP
       Pre-Fetch Parser (Graphics)
 
@@ -146,6 +161,9 @@ we have a dedicated glossary for Display Core at
       the GFX block. It's involved in GFX power management and SR-IOV, among
       other things.
 
+    SC
+      Scan Converter
+
     SDMA
       System DMA
 
@@ -164,6 +182,9 @@ we have a dedicated glossary for Display Core at
     SMU/SMC
       System Management Unit / System Management Controller
 
+    SPI
+      Shader Processor Input
+
     SRLC
       Save/Restore List Control
 
@@ -176,6 +197,9 @@ we have a dedicated glossary for Display Core at
     SS
       Spread Spectrum
 
+    SX
+      Shader Execution / Shader Export
+
     TA
       Trusted Application
 
@@ -185,6 +209,9 @@ we have a dedicated glossary for Display Core at
     TOC
       Table of Contents
 
+    UMSCH
+      User Mode Scheduler
+
     UVD
       Unified Video Decoder
 
@@ -202,3 +229,9 @@ we have a dedicated glossary for Display Core at
 
     VPE
       Video Processing Engine
+
+    XCC
+      Accelerator Core Complex
+
+    XCP
+      Accelerator Core Partition
-- 
2.47.2


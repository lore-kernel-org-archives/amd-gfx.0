Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58624C36008
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 17:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7853110E5D1;
	Tue, 25 Mar 2025 17:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hWxAnGTg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DAD810E5BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Nw3B19pitYU98/3dVe/smy1yTn/FgrrC1c8pbKjUZU=; b=hWxAnGTgA/xFAWnOMCEFT9uEUX
 Z8GBsLO6iFBOaE35J0mxJUSphyWgQeAyXo5YReOl6sOPtcInE9lXRYsza6rkyurPV//pwqOPf2J3D
 9mSgiS8196oo6ju8OEn7Fas084pH9aiZDSyUNoAq16Fzi267lBghlEdNsdM53yL8msjxv7c9S/3ZM
 j1XFwzb5+YOGAh9mDz0YXVsHukZ5RuW6f7Ve3lw52sPfuSZk/hKh9Lx5T0oYE8h7I7juDzef9A0Ln
 jRSdMnnHeF83VZwscgHWrk9IhWicJHTZsdGv9+NRtEGhbV0Sa7PYeoW8rf1JqcvoDQNmFWxajPAya
 1nt6kgAA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tx82z-006FdA-Jy; Tue, 25 Mar 2025 18:26:41 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?=27Andr=C3=A9=20Almeida=27?= <andrealmeid@igalia.com>,
 =?UTF-8?q?=27Timur=20Krist=C3=B3f=27?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/6] Documentation/gpu: Add new acronyms
Date: Tue, 25 Mar 2025 11:18:42 -0600
Message-ID: <20250325172623.225901-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325172623.225901-1-siqueira@igalia.com>
References: <20250325172623.225901-1-siqueira@igalia.com>
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

This commit introduces some new acronyms extracted from the source code
and found on some web pages around the internet (most of them came from
ArchLinux, Gentoo, and Wikipedia links).

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 1e9283e076ba..080c3f2250d1 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -12,15 +12,27 @@ we have a dedicated glossary for Display Core at
       The number of CUs that are active on the system.  The number of active
       CUs may be less than SE * SH * CU depending on the board configuration.
 
+    BACO
+      Bus Alive, Chip Off
+
+    BOCO
+      Bus Off, Chip Off
+
     CE
       Constant Engine
 
+    CIK
+      Sea Islands
+
     CP
       Command Processor
 
     CPLIB
       Content Protection Library
 
+    CS
+      Command Submission
+
     CU
       Compute Unit
 
@@ -33,6 +45,9 @@ we have a dedicated glossary for Display Core at
     EOP
       End Of Pipe/Pipeline
 
+    FLR
+      Function Level Reset
+
     GART
       Graphics Address Remapping Table.  This is the name we use for the GPUVM
       page table used by the GPU kernel driver.  It remaps system resources
@@ -80,6 +95,9 @@ we have a dedicated glossary for Display Core at
     KCQ
       Kernel Compute Queue
 
+    KFD
+      Kernel Fusion Driver
+
     KGQ
       Kernel Graphics Queue
 
@@ -89,6 +107,9 @@ we have a dedicated glossary for Display Core at
     MC
       Memory Controller
 
+    MCBP
+      Mid Command Buffer Preemption
+
     ME
       MicroEngine (Graphics)
 
@@ -125,9 +146,15 @@ we have a dedicated glossary for Display Core at
     SE
       Shader Engine
 
+    SGPR
+      Scalar General-Purpose Registers
+
     SH
       SHader array
 
+    SI
+      Southern Islands
+
     SMU/SMC
       System Management Unit / System Management Controller
 
@@ -146,6 +173,9 @@ we have a dedicated glossary for Display Core at
     TA
       Trusted Application
 
+    TC
+      Texture Cache
+
     TOC
       Table of Contents
 
@@ -158,5 +188,11 @@ we have a dedicated glossary for Display Core at
     VCN
       Video Codec Next
 
+    VGPR
+      Vector General-Purpose Registers
+
+    VMID
+      Virtual Memory ID
+
     VPE
       Video Processing Engine
-- 
2.49.0


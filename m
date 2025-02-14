Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3E7C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 23:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9F510E09F;
	Fri, 14 Feb 2025 23:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EaTIaIIq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE9610E09F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eVEaBGIQlTqnU3vHo305GyXFideXHuyIQxW5KwoF+7E=; b=EaTIaIIqgyfnNu0OOdXFrqNVZv
 /FBXv6A44el9okzJ8NoVDfiMZxQffHtuJgxdl0TlqkH3pvAQTjYHil71XRys46KIOrz0z2LrWAqN2
 l3FL25lX/JAcxIGp8Z4NL4KpF0qV87jE+hPCpIl1m6BE2i94vIUEUjZVSlqp3ebIun/vkQCPjGxb3
 Sm6azXh54VL0FxuK14dxtlVY+WPHk9Fe25ddOhBqJ1lIv2x+0In1eXPwbIlNYXNvcsgJZtH4JTJqK
 b3BL+C+Mu7oe/gbCAt8w/vNB9Ep/FHktRKZuDFIwvuWxakZBz0F5BGibDrshjWMZXLiZhZBHI74Xv
 F9hu5Tzw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tj4fg-002QaF-9c; Sat, 15 Feb 2025 00:00:38 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] Documentation/gpu: Add acronyms for some firmware components
Date: Fri, 14 Feb 2025 15:59:45 -0700
Message-ID: <20250214230011.439163-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.48.1
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

Users can check the file "/sys/kernel/debug/dri/0/amdgpu_firmware_info"
to get information on the firmware loaded in the system. This file has
multiple acronyms that are not documented in the glossary. This commit
introduces some missing acronyms to the AMD glossary documentation. The
meaning of each acronym in this commit was extracted from code
documentation available in the following files:

- drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
- drivers/gpu/drm/amd/include/amd_shared.h

Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 00a47ebb0b0f..3242db32b020 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
       The number of CUs that are active on the system.  The number of active
       CUs may be less than SE * SH * CU depending on the board configuration.
 
+    CE
+      Constant Engine
+
     CP
       Command Processor
 
@@ -80,6 +83,9 @@ we have a dedicated glossary for Display Core at
     KIQ
       Kernel Interface Queue
 
+    ME
+      Micro Engine
+
     MEC
       MicroEngine Compute
 
@@ -92,6 +98,9 @@ we have a dedicated glossary for Display Core at
     MQD
       Memory Queue Descriptor
 
+    PFP
+      Pre-Fetch Parser
+
     PPLib
       PowerPlay Library - PowerPlay is the power management component.
 
@@ -110,14 +119,26 @@ we have a dedicated glossary for Display Core at
     SH
       SHader array
 
+    SMC
+      System Management Controller
+
     SMU
       System Management Unit
 
     SS
       Spread Spectrum
 
+    TA
+      Trusted Application
+
+    UVD
+      Unified Video Decoder
+
     VCE
       Video Compression Engine
 
     VCN
       Video Codec Next
+
+    VPE
+      Video Processing Engine
-- 
2.48.1


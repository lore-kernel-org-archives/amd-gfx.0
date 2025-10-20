Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176F3CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 19:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C1210E4E4;
	Mon, 20 Oct 2025 19:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ETO/oLtg";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8000510E4E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=499ttY0zxS9arcAwsIFMia3Wo/ZNyUltKuSCdQD2KrU=; b=ETO/oLtgzvaQf9v3xMu5wtiZYG
 Petb4a2LDxlcNF3dayC3YCyosXtVWMffqKRQ8Pw4ejiVfeoL3piILSAg8KwyfTpmmb1DGyDyevDRh
 apYjkym/yOX/q4KBrcJ0ZVF+ctuyQ7im5ydnh6W/xqelOh+BvudYrsx+4SiwRmYe1iCJA7EQZuGcN
 H7gL6RxUWkugOLyVYSKnPkB7/c6HiAdyk3A0gb8KwsQ0h3EKAVlEVeoemMHuasE3t+E6OOcuUWtSX
 g7Ec5sfKetXBW6aAqqAtCwmk0/6xt5P0WNt948EVk2WG2ddph9Xl1kHqk9Zt3cKkRPnMmKuZfQJUM
 h3ZcUQWA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.home.app) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vAvqj-00CEgQ-P8; Mon, 20 Oct 2025 21:47:22 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 4/5] Documentation/gpu: Add more information about GC
Date: Mon, 20 Oct 2025 13:38:35 -0600
Message-ID: <20251020194631.102260-5-siqueira@igalia.com>
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

This commit introduces a diagram and a set of information that details
the different sets of schedulers available in the SE.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/gc/index.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/gpu/amdgpu/gc/index.rst b/Documentation/gpu/amdgpu/gc/index.rst
index ff6e9ef5cbee..b6b583c9dc6a 100644
--- a/Documentation/gpu/amdgpu/gc/index.rst
+++ b/Documentation/gpu/amdgpu/gc/index.rst
@@ -7,19 +7,21 @@
 The relationship between the CPU and GPU can be described as the
 producer-consumer problem, where the CPU fills out a buffer with operations
 (producer) to be executed by the GPU (consumer). The requested operations in
-the buffer are called Command Packets, which can be summarized as a compressed
-way of transmitting command information to the graphics controller.
+the buffer are called **Command Packets**, which can be summarized as a
+compressed way of transmitting command information to the graphics controller.
 
 The component that acts as the front end between the CPU and the GPU is called
-the Command Processor (CP). This component is responsible for providing greater
-flexibility to the GC since CP makes it possible to program various aspects of
-the GPU pipeline. CP also coordinates the communication between the CPU and GPU
-via a mechanism named **Ring Buffers**, where the CPU appends information to
-the buffer while the GPU removes operations. It is relevant to highlight that a
-CPU can add a pointer to the Ring Buffer that points to another region of
-memory outside the Ring Buffer, and CP can handle it; this mechanism is called
-**Indirect Buffer (IB)**. CP receives and parses the Command Streams (CS), and
-writes the operations to the correct hardware blocks.
+**Command Processor (CP)**. This component is responsible for providing greater
+flexibility to the **Graphics and Compute (GC)** since CP makes it possible to
+program various aspects of the GPU pipeline. CP also coordinates the
+communication between the CPU and GPU via a mechanism named **Ring Buffers**,
+where the CPU appends information to the buffer while the GPU removes
+operations. CP is also responsible for handling **Indirect Buffers (IB)**.
+
+For reference, internally the CP consists of several sub-blocks (CPC - CP
+compute, CPG - CP graphics, and CPF - CP fetcher). Some of these acronyms
+appear in register names, but this is more of an implementation detail and not
+something that directly impacts driver programming or debugging.
 
 Graphics (GFX) and Compute Microcontrollers
 -------------------------------------------
-- 
2.51.0


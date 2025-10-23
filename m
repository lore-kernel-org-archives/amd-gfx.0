Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81279CCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 22:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CFA10E977;
	Thu, 23 Oct 2025 22:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="pvoG9dDi";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB2710E974
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jLcCy5aK1xXnLyXaJpKi9fFPuBVpbHTzan+uN1ZjfAM=; b=pvoG9dDij5GgwADHNn9aWectcK
 3euRzd6HwbMV3X7GcQEmwm0PhXtuzk9ojkUpXQfuKKK6nDrgffQB+NVd63zgt5BC4ypewUfOOreVA
 h3I2CDsvfjM286Bmfar/3slL+LsOFvnpVQXSChgke/FNiHkaC0lM2r5nyr4Ni4kWXk4rWjbd3/fpP
 mmRmmqgX41whChbnpRWD5RaCfXvQD7pelTnZrx3Ynq8ywQ0aA1UwL4ISlnzbdcJjQ1+ccHfOpyPbY
 C1pJB9zkRDglIk2/+g9Ki1EMpmYXacgi3okeOUe4O0P0NhekwrJ1KfAOp1Tbtt7e4IQieIMKbJprD
 rzki+ATw==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vC3y9-00DpJV-3b; Fri, 24 Oct 2025 00:39:41 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v4 4/5] Documentation/gpu: Add more information about GC
Date: Thu, 23 Oct 2025 16:38:47 -0600
Message-ID: <20251023223918.601594-5-siqueira@igalia.com>
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

This commit introduces set of information that details the different
sets of schedulers available in the SE.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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


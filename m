Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9098AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 23:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4EAF10E147;
	Thu,  9 Dec 2021 23:48:06 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BC310E14A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 by smtp5-g21.free.fr (Postfix) with ESMTP id 87DC35FF96;
 Fri, 10 Dec 2021 00:48:04 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] Documentation/gpu: include description of some of the GC
 microcontrollers
Date: Fri, 10 Dec 2021 00:47:17 +0100
Message-Id: <20211209234717.8897-4-ydirson@free.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209234717.8897-1-ydirson@free.fr>
References: <20211209234717.8897-1-ydirson@free.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yann Dirson <ydirson@free.fr>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is Alex' description from the "Looking for clarifications around gfx/kcq/kiq"
thread, edited to fit as ReST.

Originally-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 Documentation/gpu/amdgpu/driver-core.rst | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index 909b13fad6a8..453566c280c5 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -75,6 +75,28 @@ VCN (Video Core Next)
     decode.  It's exposed to userspace for user mode drivers (VA-API,
     OpenMAX, etc.)
 
+Graphics and Compute microcontrollers
+-------------------------------------
+
+CP (Command Processor)
+    The name for the hardware block that encompasses the front end of the
+    GFX/Compute pipeline.  Consists mainly of a bunch of microcontrollers
+    (PFP, ME, CE, MEC).  The firmware that runs on these microcontrollers
+    provides the driver interface to interact with the GFX/Compute engine.
+
+    MEC (MicroEngine Compute)
+        The is the microcontroller that controls the compute queues on the
+        GFX/compute engine.
+
+    MES (MicroEngine Scheduler)
+        This is a new engine for managing queues.  This is currently unused.
+
+RLC (RunList Controller)
+    This is another microcontroller in the GFX/Compute engine.  It handles
+    power management related functionality within the GFX/Compute engine.
+    The name is a vestige of old hardware where it was originally added
+    and doesn't really have much relation to what the engine does now.
+
 Driver structure
 ================
 
@@ -82,6 +104,19 @@ In general, the driver has a list of all of the IPs on a particular
 SoC and for things like init/fini/suspend/resume, more or less just
 walks the list and handles each IP.
 
+Some useful constructs:
+
+KIQ (Kernel Interface Queue)
+    This is a control queue used by the kernel driver to manage other gfx
+    and compute queues on the GFX/compute engine.  You can use it to
+    map/unmap additional queues, etc.
+
+IB (Indirect Buffer)
+    A command buffer for a particular engine.  Rather than writing
+    commands directly to the queue, you can write the commands into a
+    piece of memory and then put a pointer to the memory into the queue.
+    The hardware will then follow the pointer and execute the commands in
+    the memory, then returning to the rest of the commands in the ring.
 
 .. _amdgpu_memory_domains:
 
-- 
2.31.1


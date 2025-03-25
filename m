Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92746C3600D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 17:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388E010E5D8;
	Tue, 25 Mar 2025 17:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fGEGSKT6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877E310E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZVmZkjekO9+uWiqt3jqrwTn6BAkroCefAs+ZztmYJ8A=; b=fGEGSKT6NH1kMmIfRGTCrgKRzb
 2qC/TUDIjf0lVDGkTJ4liSvbH4ZE3LcWnSQ+g4CEs8WcIE9KdHVy+lfG3RDiGJv5/o8+8+Jlm5JnQ
 xrIY3MUlqaCLonwV2XDAQXjvpAFJgVUfGOK1huOplyUhrZdGpU3rMtJ1KeoZ2XV8vXb0wBysdeIyc
 H5FfpJCzURx4UGHYcbgZn7AWkDBWw+thBpgPZXjDTuybmkpcATRg9aIDOjKyQ1h6yuA4slL+LENF6
 uagbH2t8x9iv4ub1qqpePctvQuW8Ag48sUz4gERSejHjZaGfC8y8WvVTXptJNsd/aE/YJS8gPD/CF
 AuVmNNEA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tx83B-006FdA-GG; Tue, 25 Mar 2025 18:26:53 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?=27Andr=C3=A9=20Almeida=27?= <andrealmeid@igalia.com>,
 =?UTF-8?q?=27Timur=20Krist=C3=B3f=27?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6/6] Documentation/gpu: Add an intro about MES
Date: Tue, 25 Mar 2025 11:18:47 -0600
Message-ID: <20250325172623.225901-7-siqueira@igalia.com>
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

MES is an important firmware that lacks some essential documentation.
This commit introduces an overview of it and how it works.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/driver-core.rst |  2 ++
 Documentation/gpu/amdgpu/gc/index.rst    |  7 ++++-
 Documentation/gpu/amdgpu/gc/mes.rst      | 38 ++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/gpu/amdgpu/gc/mes.rst

diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index 2af1e919d76a..f39077c44799 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -77,6 +77,8 @@ VCN (Video Core Next)
     decode.  It's exposed to userspace for user mode drivers (VA-API,
     OpenMAX, etc.)
 
+.. _pipes-and-queues-description:
+
 GFX, Compute, and SDMA Overall Behavior
 =======================================
 
diff --git a/Documentation/gpu/amdgpu/gc/index.rst b/Documentation/gpu/amdgpu/gc/index.rst
index f8128cca7028..b115d5883959 100644
--- a/Documentation/gpu/amdgpu/gc/index.rst
+++ b/Documentation/gpu/amdgpu/gc/index.rst
@@ -39,10 +39,15 @@ CP (Command Processor)
         GFX/compute engine.
 
     MES (MicroEngine Scheduler)
-        This is the engine for managing queues.
+        This is the engine for managing queues. For more details check
+        :ref:`MicroEngine Scheduler (MES) <amdgpu-mes>`.
 
 RLC (RunList Controller)
     This is another microcontroller in the GFX/Compute engine. It handles
     power management related functionality within the GFX/Compute engine.
     The name is a vestige of old hardware where it was originally added
     and doesn't really have much relation to what the engine does now.
+
+.. toctree::
+
+   mes.rst
diff --git a/Documentation/gpu/amdgpu/gc/mes.rst b/Documentation/gpu/amdgpu/gc/mes.rst
new file mode 100644
index 000000000000..b99eb211b179
--- /dev/null
+++ b/Documentation/gpu/amdgpu/gc/mes.rst
@@ -0,0 +1,38 @@
+.. _amdgpu-mes:
+
+=============================
+ MicroEngine Scheduler (MES)
+=============================
+
+.. note::
+   Queue and ring buffer are used as a synonymous.
+
+.. note::
+   This section assumes that you are familiar with the concept of Pipes, Queues, and GC.
+   If not, check :ref:`GFX, Compute, and SDMA Overall Behavior<pipes-and-queues-description>`
+   and :ref:`drm/amdgpu - Graphics and Compute (GC) <amdgpu-gc>`.
+
+Every GFX has a pipe component with one or more hardware queues. Pipes can
+switch between queues depending on certain conditions, and one of the
+components that can request a queue switch to a pipe is the MicroEngine
+Scheduler (MES). Whenever the driver is initialized, it creates one MQD per
+hardware queue, and then the MQDs are handed to the MES firmware for mapping
+to:
+
+1. Kernel Queues (legacy): This queue is statically mapped to HQDs and never
+   preempted. Even though this is a legacy feature, it is the current default, and
+   most existing hardware supports it. When an application submits work to the
+   kernel driver, it submits all of the application command buffers to the kernel
+   queues. The CS IOCTL takes the command buffer from the applications and
+   schedules them on the kernel queue.
+
+2. User Queues: These queues are dynamically mapped to the HQDs. Regarding the
+   utilization of User Queues, the userspace application will create its user
+   queues and submit work directly to its user queues with no need to IOCTL for
+   each submission and no need to share a single kernel queue.
+
+In terms of User Queues, MES can dynamically map them to the HQD. If there are
+more MQDs than HQDs, the MES firmware will preempt other user queues to make
+sure each queues get a time slice; in other words, MES is a microcontroller
+that handles the mapping and unmapping of MQDs into HQDs, as well as the
+priorities and oversubscription of MQDs.
-- 
2.49.0


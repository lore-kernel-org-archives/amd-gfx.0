Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3595C36008
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 17:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E2410E5BF;
	Tue, 25 Mar 2025 17:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RCfGLW7F";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6D510E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M1owNA9LTalVJORCl+yeCvwoBz1nTBHdJqePTwwU49Y=; b=RCfGLW7FHu3crkTbw17OEwduYQ
 OLHWoccMMqPhvveUlHsQnYGy15nagjkYC5l6l1oW5wpQcCwS3PspRrnNGL0/LPAZKYimOX+G5RM+k
 2qGlal9grjIMFamlBuTgbni/VHDMyj4mXqn40aLhTNuMhkySAI03al1tCma4JatnT+zSO6ll0RtKD
 J16H74sv36lnhDv1sg+uT/xhS90r/OUQB99N9HwbFVuuovPSXdTYmz7b8AiHtLTQdDh7zpiPanvuj
 XQGX+UEBGcH4tTYMweZnzXiYA+xFuVL9iLJHq714qGLXDc52e/Xd/UsS9qqDlLwY/pIoHhxxZQuFF
 jAIlLzaw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tx834-006FdA-7g; Tue, 25 Mar 2025 18:26:46 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?=27Andr=C3=A9=20Almeida=27?= <andrealmeid@igalia.com>,
 =?UTF-8?q?=27Timur=20Krist=C3=B3f=27?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/6] Documentation/gpu: Create a documentation entry just for
 hardware info
Date: Tue, 25 Mar 2025 11:18:44 -0600
Message-ID: <20250325172623.225901-4-siqueira@igalia.com>
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

The APU and dGPU tables are hidden in the driver misc info, which makes
it hard to find specific hardware info when users need it. This commit
creates a single page for this information and adds it to the top of the
amdgpu list to improve searchability.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../gpu/amdgpu/amd-hardware-list-info.rst     | 23 +++++++++++++++++++
 Documentation/gpu/amdgpu/driver-misc.rst      | 17 --------------
 Documentation/gpu/amdgpu/index.rst            |  1 +
 3 files changed, 24 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/amd-hardware-list-info.rst

diff --git a/Documentation/gpu/amdgpu/amd-hardware-list-info.rst b/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
new file mode 100644
index 000000000000..1786544fe7c1
--- /dev/null
+++ b/Documentation/gpu/amdgpu/amd-hardware-list-info.rst
@@ -0,0 +1,23 @@
+=================================================
+ AMD Hardware Components Information per Product
+=================================================
+
+On this page, you can find the AMD product name and which component version is
+part of it.
+
+Accelerated Processing Units (APU) Info
+---------------------------------------
+
+.. csv-table::
+   :header-rows: 1
+   :widths: 3, 2, 2, 1, 1, 1, 1
+   :file: ./apu-asic-info-table.csv
+
+Discrete GPU Info
+-----------------
+
+.. csv-table::
+   :header-rows: 1
+   :widths: 3, 2, 2, 1, 1, 1
+   :file: ./dgpu-asic-info-table.csv
+
diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index e40e15f89fd3..25b0c857816e 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -50,23 +50,6 @@ board_info
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    :doc: board_info
 
-Accelerated Processing Units (APU) Info
----------------------------------------
-
-.. csv-table::
-   :header-rows: 1
-   :widths: 3, 2, 2, 1, 1, 1, 1
-   :file: ./apu-asic-info-table.csv
-
-Discrete GPU Info
------------------
-
-.. csv-table::
-   :header-rows: 1
-   :widths: 3, 2, 2, 1, 1, 1
-   :file: ./dgpu-asic-info-table.csv
-
-
 GPU Memory Usage Information
 ============================
 
diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 3832aa764c72..7e9d60754287 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -8,6 +8,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
 .. toctree::
 
    driver-core
+   amd-hardware-list-info
    module-parameters
    display/index
    flashing
-- 
2.49.0


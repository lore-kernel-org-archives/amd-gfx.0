Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9929C3600C
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 23:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0C410E15F;
	Sun,  6 Apr 2025 23:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mAGNbooQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E51410E150
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7+pN2ZyDuGxf+9uiiXYtfShWeJ9aS4yQfrjGD3ygsso=; b=mAGNbooQgwkC1co3vIW2G9D40n
 KpSadcNH1eTYlGT1FkOtXHYB+NY104BBA5UTR0dGnZ5GeRmIvoMNmwLSXTVRsZcsLaxVXK/zbJuBM
 SXcNM6TC59m3qKK7/q4A+dF3/5amAHyGXpBU21JRcPzB2pYhR4tRzqBIPGtyZ9HFM1lLj6axyed3v
 5GEcHV5Obl+SihbmaCiphnulZfka7ItJHJcfBvhAa5iya+SUjLmcihAWqfh1AC95pfmCUBGBz7DeZ
 4M7gtzI/mqM6Cb3GslTCYjRKACwsNwHixVxBVZVRLm4MtS+iYLKB/ztU3Wau70hZ8aGutLppZqetW
 7AeaO+cg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u1Z5J-00CfEV-Rh; Mon, 07 Apr 2025 01:07:26 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/6] drm/amd/amdgpu: Create a headears to keep some common GC
 registers
Date: Sun,  6 Apr 2025 17:02:56 -0600
Message-ID: <20250406230703.2128148-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406230703.2128148-1-siqueira@igalia.com>
References: <20250406230703.2128148-1-siqueira@igalia.com>
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

Some GC registers are duplicated across multiple instances of GC offset
files. This commit creates a new file named gc_common_offset.h that
centralizes some common registers in a single file. Aside from
eliminating multiple duplications, this approach also avoids including
specific registers in generic files (e.g., amdgpu_gfx) and reduces the
number of includes.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                   | 4 +++-
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h   | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h   | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h   | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h   | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h   | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h   | 2 --
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h  | 2 --
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h  | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h    | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_offset.h    | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_offset.h    | 2 --
 .../gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h   | 9 +++++++++
 14 files changed, 13 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a1e3bb43babc..9f92acfdf00c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -32,6 +32,7 @@
 #include "nv.h"
 #include "nvd.h"
 
+#include "gc/gc_common_offset.h"
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
 #include "smuio/smuio_11_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 58b10a72c0c9..2aea229ac4bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -33,6 +33,8 @@
 #include "soc21.h"
 #include "nvd.h"
 
+#include "gc/gc_common_offset.h"
+
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 #include "smuio/smuio_13_0_6_offset.h"
@@ -3565,7 +3567,7 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 	}
 
 	ctx_reg_offset =
-		SOC15_REG_OFFSET(GC, 0, regPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
+		SOC15_REG_OFFSET(GC, 0, mmPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONTEXT_REG, 1));
 	amdgpu_ring_write(ring, ctx_reg_offset);
 	amdgpu_ring_write(ring, adev->gfx.config.pa_sc_tile_steering_override);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 4c8e7fdb6976..1e92f71f12b8 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -5974,8 +5974,6 @@
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define mmPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define mmPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define mmPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define mmCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define mmCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define mmCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 5e15ac14b63c..555a3bc26614 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -5603,8 +5603,6 @@
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define mmPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define mmPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define mmPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define mmCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define mmCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define mmCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
index a3bcdf632066..b82c72d27cf9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
@@ -5393,8 +5393,6 @@
 #define regPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define regPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define regPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define regPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define regPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define regCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define regCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define regCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h
index 56e00252bff8..82a795135f87 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_3_offset.h
@@ -5673,8 +5673,6 @@
 #define regPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define regPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define regPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define regPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define regPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define regCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define regCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define regCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
index d6c02cf815be..bf61fc0d3edd 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_5_0_offset.h
@@ -4204,8 +4204,6 @@
 #define regPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define regPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define regPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define regPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define regPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define regCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define regCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define regCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h
index 645d10bfbc79..d0df8d0df4e3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h
@@ -8404,8 +8404,6 @@
 #define regPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define regPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define regPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define regPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define regPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define regCB_CP_PIPEID                                                                                 0x00d9
 #define regCB_CP_PIPEID_BASE_IDX                                                                        1
 #define regCB_CP_VMID                                                                                   0x00da
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
index 12d451e5475b..d5c31df4cea7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
@@ -3584,8 +3584,6 @@
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define mmPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define mmPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define mmPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define mmCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define mmCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define mmCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
index d17d1e622e4f..a7d476b6c8e3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
@@ -3814,8 +3814,6 @@
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define mmPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define mmPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define mmPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define mmCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define mmCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define mmCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
index c30720277912..fc5c7abb35e7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
@@ -3764,8 +3764,6 @@
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define mmPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define mmPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define mmPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define mmCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define mmCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define mmCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_offset.h
index 1a8a6a350789..e13fb8137820 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_offset.h
@@ -1755,8 +1755,6 @@
 #define regPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define regPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define regPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define regPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define regPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define regCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define regCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define regCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_offset.h
index 393963502b7a..845dbbbfd567 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_3_offset.h
@@ -3995,8 +3995,6 @@
 #define regPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
 #define regPA_SC_SCREEN_EXTENT_CONTROL                                                                  0x00d6
 #define regPA_SC_SCREEN_EXTENT_CONTROL_BASE_IDX                                                         1
-#define regPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
-#define regPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 #define regCP_PERFMON_CNTX_CNTL                                                                         0x00d8
 #define regCP_PERFMON_CNTX_CNTL_BASE_IDX                                                                1
 #define regCP_PIPEID                                                                                    0x00d9
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h
new file mode 100644
index 000000000000..1f7c5f597c05
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef _gc_gc_common_offset
+#define _gc_gc_common_offset
+
+#define mmPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
+#define mmPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
+
+#endif
-- 
2.49.0


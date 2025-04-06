Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F54DC369A2
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 23:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9A210E144;
	Sun,  6 Apr 2025 23:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TayBUGf+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2458C10E154
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0/kQKCfm5i/nnlcddEyVkH4lsBTdDV5BwVwR2+eO9FI=; b=TayBUGf+YgM/HG0dZskzB2JlAP
 1B0HhuTpDaOqeDqf57HSzuHBAEvm03MuzQ/HYBxolnJ3E1SBqc0/fuDSr1eAZps+16hU1oMgfRIGt
 VyhPoMsMUvrp2sYeoIXQldkOtAG5Ie5mPPnfAvwmaZU8V+6FPxJ4nGNcx1IU/FWlQ2frGNwKb7Ob9
 pghwKN64eU3aSZuUDGKFLQFfxZr3jHcBf87xsTw2cVOQ+xD6IX/h6tzfHAoOWi6SU9KijbTyEeO6W
 hTdHpB3YrRBnGQGo+jX005wUhfeUav4teeN0jL1TJnoygO/syzgNwzaahgQylGKee9RnW2viLBcSZ
 O09M8Gcg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u1Z5O-00CfEV-VD; Mon, 07 Apr 2025 01:07:31 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 4/6] drm/amdgpu/gfx: Absorb gfx_v8_0_get_csb_buffer into
 gfx_get_csb_buffer
Date: Sun,  6 Apr 2025 17:02:59 -0600
Message-ID: <20250406230703.2128148-5-siqueira@igalia.com>
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

The gfx_v8_0_get_csb_buffer only differs from gfx_get_csb_buffer in a
sequence where some specific registers must be used. To assimilate
gfx_v8_0_get_csb_buffer into gfx_get_csb_buffer, it was necessary two
modifications:

1. In gfx_get_csb_buffer, check for GFX8 and, based on that, execute the
   specific operation.
2. Move mmPA_SC_RASTER_CONFIG registers to the common register list.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 12 ++++-
 drivers/gpu/drm/amd/amdgpu/cik.c              |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 51 ++-----------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/si.c               |  2 +
 drivers/gpu/drm/amd/amdgpu/vi.c               |  2 +
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |  1 -
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |  1 -
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |  1 -
 .../amd/include/asic_reg/gc/gc_9_1_offset.h   |  1 -
 .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |  1 -
 .../include/asic_reg/gc/gc_common_offset.h    |  2 +
 .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |  1 -
 .../drm/amd/include/asic_reg/gca/gfx_7_0_d.h  |  1 -
 .../drm/amd/include/asic_reg/gca/gfx_7_2_d.h  |  1 -
 .../drm/amd/include/asic_reg/gca/gfx_8_0_d.h  |  1 -
 .../drm/amd/include/asic_reg/gca/gfx_8_1_d.h  |  1 -
 19 files changed, 27 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b26f9f053670..71a25f626fee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2254,8 +2254,16 @@ void gfx_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer)
 		}
 	}
 
-	// GFX10 and GFX11 requires the below operation, but GFX9 should skip
-	// it.
+	// GFX8 specific operation
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(8, 0, 0) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) <  IP_VERSION(9, 0, 0)) {
+		buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 2));
+		buffer[count++] = cpu_to_le32(mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START);
+		buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
+		buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);
+	}
+
+	// GFX10 and GFX11 specific operation.
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0) &&
 	    amdgpu_ip_version(adev, GC_HWIP, 0) <  IP_VERSION(12, 0, 0)) {
 		ctx_reg_offset = SOC15_REG_OFFSET(GC, 0, mmPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 9cd63b4177bf..a83549273de3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -58,6 +58,8 @@
 #include "bif/bif_4_1_d.h"
 #include "bif/bif_4_1_sh_mask.h"
 
+#include "gc/gc_common_offset.h"
+
 #include "gca/gfx_7_2_d.h"
 #include "gca/gfx_7_2_enum.h"
 #include "gca/gfx_7_2_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index d86620f38855..ff794410794d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -37,6 +37,8 @@
 #include "oss/oss_1_0_d.h"
 #include "oss/oss_1_0_sh_mask.h"
 
+#include "gc/gc_common_offset.h"
+
 #include "gca/gfx_6_0_d.h"
 #include "gca/gfx_6_0_sh_mask.h"
 #include "gca/gfx_7_2_enum.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0fdc4362bbc0..6423b7a31e84 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -40,6 +40,8 @@
 #include "bif/bif_4_1_d.h"
 #include "bif/bif_4_1_sh_mask.h"
 
+#include "gc/gc_common_offset.h"
+
 #include "gca/gfx_7_0_d.h"
 #include "gca/gfx_7_2_enum.h"
 #include "gca/gfx_7_2_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fc73be4ab068..c781edc7f001 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -38,6 +38,8 @@
 #include "atombios_i2c.h"
 #include "clearstate_vi.h"
 
+#include "gc/gc_common_offset.h"
+
 #include "gmc/gmc_8_2_d.h"
 #include "gmc/gmc_8_2_sh_mask.h"
 
@@ -1220,51 +1222,6 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	return err;
 }
 
-static void gfx_v8_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
-{
-	u32 count = 0, i;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-
-	if (adev->gfx.rlc.cs_data == NULL)
-		return;
-	if (buffer == NULL)
-		return;
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	buffer[count++] = cpu_to_le32(0x80000000);
-	buffer[count++] = cpu_to_le32(0x80000000);
-
-	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT) {
-				buffer[count++] =
-					cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
-				buffer[count++] = cpu_to_le32(ext->reg_index -
-						PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			}
-		}
-	}
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 2));
-	buffer[count++] = cpu_to_le32(mmPA_SC_RASTER_CONFIG -
-			PACKET3_SET_CONTEXT_REG_START);
-	buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
-	buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
-}
-
 static int gfx_v8_0_cp_jump_table_num(struct amdgpu_device *adev)
 {
 	if (adev->asic_type == CHIP_CARRIZO)
@@ -3875,7 +3832,8 @@ static void gfx_v8_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 
 static void gfx_v8_0_init_csb(struct amdgpu_device *adev)
 {
-	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+	gfx_get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+
 	/* csib */
 	WREG32(mmRLC_CSIB_ADDR_HI,
 			adev->gfx.rlc.clear_state_gpu_addr >> 32);
@@ -5588,7 +5546,6 @@ static const struct amdgpu_rlc_funcs iceland_rlc_funcs = {
 	.unset_safe_mode = gfx_v8_0_unset_safe_mode,
 	.init = gfx_v8_0_rlc_init,
 	.get_csb_size = gfx_v8_0_get_csb_size,
-	.get_csb_buffer = gfx_v8_0_get_csb_buffer,
 	.get_cp_table_num = gfx_v8_0_cp_jump_table_num,
 	.resume = gfx_v8_0_rlc_resume,
 	.stop = gfx_v8_0_rlc_stop,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index e1d63bed84bf..72a35b108135 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -33,6 +33,7 @@
 #include "gfx_v8_0.h"
 #include "sdma_v3_0.h"
 #include "tonga_ih.h"
+#include "gc/gc_common_offset.h"
 #include "gmc/gmc_8_2_d.h"
 #include "gmc/gmc_8_2_sh_mask.h"
 #include "oss/oss_3_0_d.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 94a6ec162640..be8d73419c23 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -51,6 +51,8 @@
 #include "smu/smu_6_0_d.h"
 #include "smu/smu_6_0_sh_mask.h"
 
+#include "gc/gc_common_offset.h"
+
 #include "gca/gfx_6_0_d.h"
 #include "gca/gfx_6_0_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 86d8bc10d90a..910984c27480 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -44,6 +44,8 @@
 #include "bif/bif_5_0_d.h"
 #include "bif/bif_5_0_sh_mask.h"
 
+#include "gc/gc_common_offset.h"
+
 #include "gca/gfx_8_0_d.h"
 #include "gca/gfx_8_0_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 1e92f71f12b8..96bb71a7d4df 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -5968,7 +5968,6 @@
 #define mmPA_SC_VPORT_ZMIN_15_BASE_IDX                                                                 1
 #define mmPA_SC_VPORT_ZMAX_15                                                                          0x00d3
 #define mmPA_SC_VPORT_ZMAX_15_BASE_IDX                                                                 1
-#define mmPA_SC_RASTER_CONFIG                                                                          0x00d4
 #define mmPA_SC_RASTER_CONFIG_BASE_IDX                                                                 1
 #define mmPA_SC_RASTER_CONFIG_1                                                                        0x00d5
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 555a3bc26614..56f9233aa034 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -5597,7 +5597,6 @@
 #define mmPA_SC_VPORT_ZMIN_15_BASE_IDX                                                                 1
 #define mmPA_SC_VPORT_ZMAX_15                                                                          0x00d3
 #define mmPA_SC_VPORT_ZMAX_15_BASE_IDX                                                                 1
-#define mmPA_SC_RASTER_CONFIG                                                                          0x00d4
 #define mmPA_SC_RASTER_CONFIG_BASE_IDX                                                                 1
 #define mmPA_SC_RASTER_CONFIG_1                                                                        0x00d5
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
index d5c31df4cea7..e9357cab9cfb 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
@@ -3578,7 +3578,6 @@
 #define mmPA_SC_VPORT_ZMIN_15_BASE_IDX                                                                 1
 #define mmPA_SC_VPORT_ZMAX_15                                                                          0x00d3
 #define mmPA_SC_VPORT_ZMAX_15_BASE_IDX                                                                 1
-#define mmPA_SC_RASTER_CONFIG                                                                          0x00d4
 #define mmPA_SC_RASTER_CONFIG_BASE_IDX                                                                 1
 #define mmPA_SC_RASTER_CONFIG_1                                                                        0x00d5
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
index a7d476b6c8e3..21b43f102486 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
@@ -3808,7 +3808,6 @@
 #define mmPA_SC_VPORT_ZMIN_15_BASE_IDX                                                                 1
 #define mmPA_SC_VPORT_ZMAX_15                                                                          0x00d3
 #define mmPA_SC_VPORT_ZMAX_15_BASE_IDX                                                                 1
-#define mmPA_SC_RASTER_CONFIG                                                                          0x00d4
 #define mmPA_SC_RASTER_CONFIG_BASE_IDX                                                                 1
 #define mmPA_SC_RASTER_CONFIG_1                                                                        0x00d5
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
index fc5c7abb35e7..4ba0e8ccfa12 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
@@ -3758,7 +3758,6 @@
 #define mmPA_SC_VPORT_ZMIN_15_BASE_IDX                                                                 1
 #define mmPA_SC_VPORT_ZMAX_15                                                                          0x00d3
 #define mmPA_SC_VPORT_ZMAX_15_BASE_IDX                                                                 1
-#define mmPA_SC_RASTER_CONFIG                                                                          0x00d4
 #define mmPA_SC_RASTER_CONFIG_BASE_IDX                                                                 1
 #define mmPA_SC_RASTER_CONFIG_1                                                                        0x00d5
 #define mmPA_SC_RASTER_CONFIG_1_BASE_IDX                                                               1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h
index 1f7c5f597c05..5fe3a031e379 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_offset.h
@@ -6,4 +6,6 @@
 #define mmPA_SC_TILE_STEERING_OVERRIDE                                                                 0x00d7
 #define mmPA_SC_TILE_STEERING_OVERRIDE_BASE_IDX                                                        1
 
+#define mmPA_SC_RASTER_CONFIG                                                   0xa0d4
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
index 6f44345277af..1dba803b8bab 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_d.h
@@ -1000,7 +1000,6 @@
 #define mmPA_SC_PERFCOUNTER7_HI 0x22B7
 #define mmPA_SC_PERFCOUNTER7_LO 0x22B6
 #define mmPA_SC_PERFCOUNTER7_SELECT 0x22A7
-#define mmPA_SC_RASTER_CONFIG 0xA0D4
 #define mmPA_SC_SCREEN_SCISSOR_BR 0xA00D
 #define mmPA_SC_SCREEN_SCISSOR_TL 0xA00C
 #define mmPA_SC_VPORT_SCISSOR_0_BR 0xA095
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_0_d.h
index b1d7cefb4bd1..d7fc5acb5ec7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_0_d.h
@@ -1016,7 +1016,6 @@
 #define mmPA_SC_LINE_STIPPLE                                                    0xa283
 #define mmPA_SC_MODE_CNTL_0                                                     0xa292
 #define mmPA_SC_MODE_CNTL_1                                                     0xa293
-#define mmPA_SC_RASTER_CONFIG                                                   0xa0d4
 #define mmPA_SC_RASTER_CONFIG_1                                                 0xa0d5
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                           0xa0d6
 #define mmPA_SC_GENERIC_SCISSOR_TL                                              0xa090
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_2_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_2_d.h
index 290ce6aa4b71..c189bff59969 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_2_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_7_2_d.h
@@ -1029,7 +1029,6 @@
 #define mmPA_SC_LINE_STIPPLE                                                    0xa283
 #define mmPA_SC_MODE_CNTL_0                                                     0xa292
 #define mmPA_SC_MODE_CNTL_1                                                     0xa293
-#define mmPA_SC_RASTER_CONFIG                                                   0xa0d4
 #define mmPA_SC_RASTER_CONFIG_1                                                 0xa0d5
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                           0xa0d6
 #define mmPA_SC_GENERIC_SCISSOR_TL                                              0xa090
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_0_d.h
index 90ff7c8a6011..7c4b43d324e6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_0_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_0_d.h
@@ -1111,7 +1111,6 @@
 #define mmPA_SC_LINE_STIPPLE                                                    0xa283
 #define mmPA_SC_MODE_CNTL_0                                                     0xa292
 #define mmPA_SC_MODE_CNTL_1                                                     0xa293
-#define mmPA_SC_RASTER_CONFIG                                                   0xa0d4
 #define mmPA_SC_RASTER_CONFIG_1                                                 0xa0d5
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                           0xa0d6
 #define mmPA_SC_GENERIC_SCISSOR_TL                                              0xa090
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
index 2d672b3d2fed..eba388df8674 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
@@ -1112,7 +1112,6 @@
 #define mmPA_SC_LINE_STIPPLE                                                    0xa283
 #define mmPA_SC_MODE_CNTL_0                                                     0xa292
 #define mmPA_SC_MODE_CNTL_1                                                     0xa293
-#define mmPA_SC_RASTER_CONFIG                                                   0xa0d4
 #define mmPA_SC_RASTER_CONFIG_1                                                 0xa0d5
 #define mmPA_SC_SCREEN_EXTENT_CONTROL                                           0xa0d6
 #define mmPA_SC_GENERIC_SCISSOR_TL                                              0xa090
-- 
2.49.0


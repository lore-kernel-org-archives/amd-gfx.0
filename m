Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD56C3601E
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 23:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6784910E150;
	Sun,  6 Apr 2025 23:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fOKlYc6A";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1E910E144
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 23:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=78x8B2Zb1t3+ds2/iZdgI86d1C3Clx0mj0PdpVEVsSQ=; b=fOKlYc6Ar8vxK+beyCiYonapHL
 CnftKDcOPEo/sMDGawmT/PnZSbInQZPLvGfDxaWJ8+MFkGkqes6lkxqcu/KE/7jQd0kfb07xlkCQx
 p35ccXsB1fDauqVQIguni1j+gD/p5VCzSyrdx++Bid5wMbUhikqii93WMAp3sIxdkkqRVxJ1shy9V
 /Io1rHheZ2JTMkxR1awDsqmA+lSuit02xJyLlrzWwYUP0R2EC0fEElJ1hAlxdnGLKSFjxoKNUaAkc
 u1KhCjnv/UsecuaYGK1JoNmcWTfOctYJ6C8KiSqBClJiPJbNH3p0nSKP0ZPs3GdgTDsSEl2mQfzJT
 iAerUWEw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u1Z5L-00CfEV-Lk; Mon, 07 Apr 2025 01:07:28 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/6] drm/amdgpu/gfx: Introduce generic gfx_get_csb_buffer
Date: Sun,  6 Apr 2025 17:02:57 -0600
Message-ID: <20250406230703.2128148-3-siqueira@igalia.com>
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

When inspecting gfx_v11_0_get_csb_buffer and gfx_v10_0_get_csb_buffer,
it becomes clear that both functions are very similar (only the function
name change). Since those operations are common between gfx11 and gfx10,
this commit creates a dedicated function named gfx_get_csb_buffer and
uses it for gfx11 and gfx10.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      | 57 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c       | 50 +----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       | 49 +----------------
 5 files changed, 63 insertions(+), 97 deletions(-)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 1e9283e076ba..497fbc08a3fd 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -12,6 +12,9 @@ we have a dedicated glossary for Display Core at
       The number of CUs that are active on the system.  The number of active
       CUs may be less than SE * SH * CU depending on the board configuration.
 
+    CSB
+      Clear State Indirect Buffer
+
     CE
       Constant Engine
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 72af5e5a894a..24acb229367c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -33,6 +33,8 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
+#include "nvd.h"
+#include "gc/gc_common_offset.h"
 
 /* delay 0.1 second to enable gfx off feature */
 #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
@@ -2209,6 +2211,61 @@ void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
 }
 
+/**
+ * gfx_get_csb_buffer - Get the clear state to be put into the hardware.
+ *
+ * @adev: amdgpu_device pointer used to get the CS data and other gfx info.
+ * @buffer: RLC CS pointer
+ *
+ * Sometimes, the user space puts a request to clear the state in the command
+ * buffer; this function provides the clear state that gets put into the
+ * hardware. Note that the driver programs Clear State Indirect Buffer (CSB)
+ * explicitly when it sets up the kernel rings, and it also provides a pointer
+ * to it which is used by the firmware to load the clear state in some cases.
+ */
+void gfx_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer)
+{
+	u32 count = 0, i;
+	const struct cs_section_def *sect = NULL;
+	const struct cs_extent_def *ext = NULL;
+	int ctx_reg_offset;
+
+	if (adev->gfx.rlc.cs_data == NULL)
+		return;
+	if (buffer == NULL)
+		return;
+
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
+	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
+	buffer[count++] = cpu_to_le32(0x80000000);
+	buffer[count++] = cpu_to_le32(0x80000000);
+
+	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
+		for (ext = sect->section; ext->extent != NULL; ++ext) {
+			if (sect->id == SECT_CONTEXT) {
+				buffer[count++] =
+					cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
+				buffer[count++] = cpu_to_le32(ext->reg_index -
+						PACKET3_SET_CONTEXT_REG_START);
+				for (i = 0; i < ext->reg_count; i++)
+					buffer[count++] = cpu_to_le32(ext->extent[i]);
+			}
+		}
+	}
+
+	ctx_reg_offset = SOC15_REG_OFFSET(GC, 0, mmPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
+	buffer[count++] = cpu_to_le32(ctx_reg_offset);
+	buffer[count++] = cpu_to_le32(adev->gfx.config.pa_sc_tile_steering_override);
+
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
+	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
+
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
+	buffer[count++] = cpu_to_le32(0);
+}
+
 /*
  * debugfs for to enable/disable gfx job submission to specific core.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 75af4f25a133..fe7dd5fd8b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -594,6 +594,7 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
+void gfx_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer);
 
 void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
 void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9f92acfdf00c..b08215bf0836 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4294,52 +4294,6 @@ static u32 gfx_v10_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v10_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
-{
-	u32 count = 0, i;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-	int ctx_reg_offset;
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
-	ctx_reg_offset =
-		SOC15_REG_OFFSET(GC, 0, mmPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
-	buffer[count++] = cpu_to_le32(ctx_reg_offset);
-	buffer[count++] = cpu_to_le32(adev->gfx.config.pa_sc_tile_steering_override);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
-}
-
 static void gfx_v10_0_rlc_fini(struct amdgpu_device *adev)
 {
 	/* clear state block */
@@ -5407,7 +5361,7 @@ static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 
 static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 {
-	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+	gfx_get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	/* csib */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 1, 2)) {
@@ -8368,7 +8322,6 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.unset_safe_mode = gfx_v10_0_unset_safe_mode,
 	.init = gfx_v10_0_rlc_init,
 	.get_csb_size = gfx_v10_0_get_csb_size,
-	.get_csb_buffer = gfx_v10_0_get_csb_buffer,
 	.resume = gfx_v10_0_rlc_resume,
 	.stop = gfx_v10_0_rlc_stop,
 	.reset = gfx_v10_0_rlc_reset,
@@ -8382,7 +8335,6 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.unset_safe_mode = gfx_v10_0_unset_safe_mode,
 	.init = gfx_v10_0_rlc_init,
 	.get_csb_size = gfx_v10_0_get_csb_size,
-	.get_csb_buffer = gfx_v10_0_get_csb_buffer,
 	.resume = gfx_v10_0_rlc_resume,
 	.stop = gfx_v10_0_rlc_stop,
 	.reset = gfx_v10_0_rlc_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2aea229ac4bb..b71fd6d7434e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -817,52 +817,6 @@ static u32 gfx_v11_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v11_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
-{
-	u32 count = 0, i;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-	int ctx_reg_offset;
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
-	ctx_reg_offset =
-		SOC15_REG_OFFSET(GC, 0, regPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
-	buffer[count++] = cpu_to_le32(ctx_reg_offset);
-	buffer[count++] = cpu_to_le32(adev->gfx.config.pa_sc_tile_steering_override);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
-}
-
 static void gfx_v11_0_rlc_fini(struct amdgpu_device *adev)
 {
 	/* clear state block */
@@ -2157,7 +2111,7 @@ static void gfx_v11_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 
 static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
 {
-	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+	gfx_get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	WREG32_SOC15(GC, 0, regRLC_CSIB_ADDR_HI,
 			adev->gfx.rlc.clear_state_gpu_addr >> 32);
@@ -5435,7 +5389,6 @@ static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
 	.unset_safe_mode = gfx_v11_0_unset_safe_mode,
 	.init = gfx_v11_0_rlc_init,
 	.get_csb_size = gfx_v11_0_get_csb_size,
-	.get_csb_buffer = gfx_v11_0_get_csb_buffer,
 	.resume = gfx_v11_0_rlc_resume,
 	.stop = gfx_v11_0_rlc_stop,
 	.reset = gfx_v11_0_rlc_reset,
-- 
2.49.0


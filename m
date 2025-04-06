Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BEAC3600C
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 23:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8C210E152;
	Sun,  6 Apr 2025 23:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="U4HGgNRq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5399C10E152
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Fqn1YIgLC7vblCVbFB1A+MtFazaAnEgcz0CR2fq3mCQ=; b=U4HGgNRqvivpvE2WeMobtolHbO
 4cZ0tSCjrMXu8FMMriatOwcsj0IV6VIaJbuJrnvysKPZ9lKYn4xkG1NBqqeloukL8YBSiQ1by1OHv
 VOVDwNd0aAA+HXlXk8yqM/8s2YXiY3BcQhBCzi1JsuSfMfyWl3ILEqn8B+Uanf0cYHkHVBZPNory0
 T32HmFs3Aoi6yRWjVqxEBBqey2qSlB2SXC/XTLS9/kB7/qmLD6auG5jVw40LnAwrgfoms/AuA235d
 cewJ0yvsF3kuNtfIcKG6s0lmIr3Kktq++YqBjAOz75nVkxvYOwO+6f4zr/oOWS3zaGdIP16ifgIbX
 xR7G4fWQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u1Z5N-00CfEV-AM; Mon, 07 Apr 2025 01:07:29 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/6] drm/amdgpu/gfx: Integrate gfx_v9_0_get_csb_buffer into
 gfx_get_csb_buffer
Date: Sun,  6 Apr 2025 17:02:58 -0600
Message-ID: <20250406230703.2128148-4-siqueira@igalia.com>
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

The code implementation in gfx_get_csb_buffer is very similar to the
gfx_v9_0_get_csb_buffer; the main difference is the fact that GFX9 does
not have some of the specific operations for GFX11 and GFX10. This
commit adds a check in the particular part of gfx_get_csb_buffer that
should be skipped in the GFX9 code path. Finally, this commit eliminates
the unnecessary gfx_v9_0_get_csb_buffer function in favor of
gfx_get_csb_buffer.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 13 +++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 43 ++-----------------------
 2 files changed, 11 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 24acb229367c..b26f9f053670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2254,10 +2254,15 @@ void gfx_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer)
 		}
 	}
 
-	ctx_reg_offset = SOC15_REG_OFFSET(GC, 0, mmPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
-	buffer[count++] = cpu_to_le32(ctx_reg_offset);
-	buffer[count++] = cpu_to_le32(adev->gfx.config.pa_sc_tile_steering_override);
+	// GFX10 and GFX11 requires the below operation, but GFX9 should skip
+	// it.
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) <  IP_VERSION(12, 0, 0)) {
+		ctx_reg_offset = SOC15_REG_OFFSET(GC, 0, mmPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
+		buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
+		buffer[count++] = cpu_to_le32(ctx_reg_offset);
+		buffer[count++] = cpu_to_le32(adev->gfx.config.pa_sc_tile_steering_override);
+	}
 
 	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
 	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 99f541207980..1fa13f3d098a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1621,45 +1621,6 @@ static u32 gfx_v9_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v9_0_get_csb_buffer(struct amdgpu_device *adev,
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
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
-}
-
 static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
 {
 	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
@@ -2741,7 +2702,8 @@ static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 
 static void gfx_v9_0_init_csb(struct amdgpu_device *adev)
 {
-	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+	gfx_get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+	
 	/* csib */
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),
 			adev->gfx.rlc.clear_state_gpu_addr >> 32);
@@ -5191,7 +5153,6 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.unset_safe_mode = gfx_v9_0_unset_safe_mode,
 	.init = gfx_v9_0_rlc_init,
 	.get_csb_size = gfx_v9_0_get_csb_size,
-	.get_csb_buffer = gfx_v9_0_get_csb_buffer,
 	.get_cp_table_num = gfx_v9_0_cp_jump_table_num,
 	.resume = gfx_v9_0_rlc_resume,
 	.stop = gfx_v9_0_rlc_stop,
-- 
2.49.0


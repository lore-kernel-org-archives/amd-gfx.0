Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28CDC02196
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF1D10E663;
	Tue,  4 Feb 2025 14:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L29NtXNz";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9839410E662
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:31:18 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-38dae70f5d9so358553f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738679477; x=1739284277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jgn4P/5Z0gnzgbZiFED9wh2eJLxk5PjLwPv3S5z6Nds=;
 b=L29NtXNzqGMiPAAayUiV+yszL1IIsouh7dPtlzbawP+vXxE65UOTzUrF5pi2n0PWz/
 +Ai+SgjiMg9DKAA+saxdOlwz9CVBUinwbqY/YSEUwCAMo4LdmzaK3icdvvlBee2qBWOv
 oPDQlks6qte3J2KeGUO98POUWb3mCdyjR+xRlp4Rl+L8eofC1XAfSZiKWeRbNMTvVfoS
 UDOq6f4KXyIYWCI1fY1opvUVpbyV6rqTpgO9avadmX0UEx5h/oxGvKTGC0o7cDxkhgJF
 USp3uVifGghRAV9F9fZl6XiBuD7U2sBvwK8q8Nr2SVSfpDyqyiy2KZGLdvQI6NcuH3si
 NHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679477; x=1739284277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgn4P/5Z0gnzgbZiFED9wh2eJLxk5PjLwPv3S5z6Nds=;
 b=w2bNFc0yUJbIvT3Hp9kS5zGhKWLletktsZySV+bFYLXKNZmHw+ox4+1jpK1mmcQkoj
 yMPSh3VP2+fEHtORPYojuHRMB8cpVvGdfpPKa4enQie+DVJnFXFSBlULcSmKmwOk3wRN
 LPZP8bEtH16A/6DvwR8l4WDwBysX0l0Ov/EKBI37YFo2Jz1u8y8UTDcncRtfsYPy6fQl
 3Ll+0Uk4YuqOqED+MLdtZLcyiPaC6q8MY1DdQcIydMP7HH2YXOMvFOvDw+tnGnjlfHqN
 h8miyH1S4mzJuu304Tv9qIVt+2Af1Um10JUYseqsm+IovQWoPTV+UyhHa7gi6DrSP2Ca
 0jXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpLWjfp9epvnx+5zZbIZrsZLUVxn9g/uDZHNL2oynR3fl0JV7+QmPhwgldZb+oJhY/3sCWGCtd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxItVN/NSHIAeLNpLdz5D4ZxwdcMuiUR0m8N3Sp0ZnwGjKDRA5Q
 ygy/p7IkR0kVZJwppm6LT1OiA5y8kxmTP6T8mpOY9+vNV7nrN1mF
X-Gm-Gg: ASbGncstc+8sa+J4xGHNmXXvspNADE92U7pk3owLEjLN0wVtQqykLRRihD+2Ebf87Se
 4ES/qm9gAtxdwWfgm4fXkcwVs+Mi6wuHEncOWK9dFK732IjVK/sjqY0Z+jNq0R52JUFYuW8L4Ri
 r5J/hPnN79zcv+MMu7SrnZTwwPIbbYAltdzxt9GWyl3eWMIv7O6+X0McNtY8B4CFntlULvOfJ14
 8PJerVd4cYXoaFKqYnymZ9xR317Rkw5TZTv+1JCCp2v5YLdbsi2Y9oLM8Ql9RPqLT5dg9QxaaY6
 TM2iNH5cXhRuJeSmols0QGLWAEmY
X-Google-Smtp-Source: AGHT+IHmAAJzI31yr76Mx2b9UiNQVnx4orOo6RAYMS22w7+CUfv8RGgk+kCdPpbsVRBPyjmLimcWBw==
X-Received: by 2002:a05:6000:1862:b0:38d:a945:66ea with SMTP id
 ffacd0b85a97d-38da945673emr1794818f8f.50.1738679476604; 
 Tue, 04 Feb 2025 06:31:16 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15d3:1100:15c3:7ea2:8ff1:462c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244eb0dsm194169135e9.27.2025.02.04.06.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:31:16 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: timur.kristof@gmail.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: rework gfx9 queue reset
Date: Tue,  4 Feb 2025 15:31:10 +0100
Message-Id: <20250204143113.6320-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204143113.6320-1-christian.koenig@amd.com>
References: <20250204143113.6320-1-christian.koenig@amd.com>
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

Testing this feature turned out that it was a bit unstable. The
CP_VMID_RESET register takes the VMID which all submissions from should
be canceled.

Unlike Windows Linux uses per process VMIDs instead of per engine VMIDs
for the simple reason that we don't have enough. So resetting one VMID
only killed the submissions of one specific process.

Fortunately that turned out to be exactly what we want to have.

So clear the CP_VMID_RESET register between every context switch between
applications when we do the pipeline sync to avoid trouble if multiple
VMIDs are used on the ring right behind each other.

Use the same pipeline sync function in the reset handler and issue an IB
test instead of a ring test after the queue reset to provide a longer
timeout and additional fence value should there be additional work on
the ring after the one aborted.

Also drop the soft recovery since that pretty much does the same thing as
CP_VMID_RESET, just on a lower level and with less chance of succeeding.

This now survives a stress test running over night sending a broken
submission ever 45 seconds and recovering fine from each of them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 ++++++++++-----------------
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8902fafbcf8d..1eee2a1bca5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -275,6 +275,7 @@ extern int amdgpu_wbrf;
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
 #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
+#define AMDGPU_QUEUE_RESET_TIMEOUT		(HZ / 10)
 #define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fa572b40989e..705f5a9c11a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5607,7 +5607,17 @@ static void gfx_v9_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
+	struct amdgpu_device *adev = ring->adev;
 
+	amdgpu_ring_emit_reg_wait(ring,
+				  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+				  0, 0xffff);
+	amdgpu_ring_emit_wreg(ring,
+			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+			      0);
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq,
+			       AMDGPU_FENCE_FLAG_EXEC);
 	gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
 			      lower_32_bits(addr), upper_32_bits(addr),
 			      seq, 0xffffffff, 4);
@@ -5963,20 +5973,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 						 enum amdgpu_interrupt_state state)
 {
@@ -7252,16 +7248,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
 		return -ENOMEM;
-	gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-				 ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v9_0_ring_emit_reg_wait(ring,
-				    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffff);
-	gfx_v9_0_ring_emit_wreg(ring,
-				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
+	gfx_v9_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
@@ -7468,7 +7460,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7506,7 +7498,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.reset = gfx_v9_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
@@ -7525,7 +7516,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 +  /* COND_EXEC */
-		7 +  /* PIPELINE_SYNC */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* VM_FLUSH */
@@ -7564,7 +7555,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.patch_cntl = gfx_v9_0_ring_patch_cntl,
 	.patch_de = gfx_v9_0_ring_patch_de_meta,
@@ -7586,7 +7576,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
@@ -7608,7 +7598,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
@@ -7629,7 +7618,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
+		7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
-- 
2.34.1


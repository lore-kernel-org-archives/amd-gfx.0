Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A586AC0219A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A93F10E668;
	Tue,  4 Feb 2025 14:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aW3FHk9a";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9067410E664
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:31:19 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4368a293339so65477235e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738679478; x=1739284278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8085Xzsrwmu62SXr/mJaceXrUb3qOF7bA4O/z4ZetrQ=;
 b=aW3FHk9a4RBtvxYYonkNDLFzYWl1F7ex3XzTAOGFBCkljBORMtd33pBUiUYUrdqGql
 SV/eGtmvBVmXZXWXRDA9wMGPTkG8aha7nbX2TKFx4SO10+6eFsgMjkk7aNx/ffRuW44M
 fKRxdXG/jqmy5CTB+SCszOCxFirAI93fuhsBOccqN7F9bYb6A8FpY/e9iw1D9gE52Jbj
 V1h2FCyi48hP+xnQ9SKJCrUJOK7e/y3q0xixWqLJS+ah9Hl7TAiZdfLYrunZ7zXa5qnh
 M2C3n6kgWv/8imasOrGAd4yCexQ+DduYLuDuABRbNzu3N9ktF2rVTYXeq9JV7So6uj11
 ZRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679478; x=1739284278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8085Xzsrwmu62SXr/mJaceXrUb3qOF7bA4O/z4ZetrQ=;
 b=VL0KkJ7CFS311gUNHIzFzHZ5zaMiFDqdPr5Yb2Elsx1wvuBRsKmgA2I3GZ6E7JkyX6
 ZOINzFbf90WNGEEqbjrcTfG3CRktusdrN9kQJYm415UVMSmF0oW6+ZaknGq7UApFTyg+
 5NuqETPx4QhZ3aZ9dI7EEfZK1UW6uAkubuHIxQlaXeMApXmb+e3nvBYr3c8Kw3qfUjUo
 tTZeSsODvGwliaQUhhc/CwjEiiUNZ0CqyrhbPAMc91dSR3NESe8rA/vTyIFR/rkC9LqF
 qrszIw1wtj7RE2FPbPAOrWlCDGCmxoQdykpvapPdKb7QDvj/BJhVKCuXq5qtR4J70T3G
 UchA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHn7/SI9mNQM3kPGUY0utJY2HhtJ/30YmPzMPugL/X+KD1WahdmNcRXNsjaXM9UAtVTVMDKZgy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTD0+a3N4NR3c/n5G2dhYOGY8gfCuVREUbDBeJW4NLBOyTskbt
 qI2aETEYMIvp/qVb1zXfuMPno5Ii5RrrnhtqusEUb3bWBraEjMmL
X-Gm-Gg: ASbGncv/Xt9XUgw31DDlyZ9n6WhPrlK378fanrdbe7dr1/61/UQtywGpPfoGZIE9oUr
 jmmYSheygdw5RPCHJmSWRH3TzPUTiQjskADthCwYFhyTD4+ZObpGWXN0d5wyWSVZR6FuBCRrTBQ
 sx+kbsAi9doW9vMEthrpjiAwUxDFCux2FDUEoeekcmU9JV7hTc/ZPrMa3mPRhonBSfLjhEkHiEt
 GAshtZQOfJKkYDE5JSAl/Cc7fIG+TY72eozL/CHeLQH3hexknFXGbqqC4cvah9Gi8DJPlY8QnMT
 lUIBGBsAnoo1I+cOe+t28xzEE7My
X-Google-Smtp-Source: AGHT+IHv+qfmkGi0arrLsNldLMfIaIp2OiXkDL/R4D30oLFx+CxPcs5yFprJlvhafZQOkoGyt+/1rg==
X-Received: by 2002:a05:600c:3488:b0:436:ed38:5c85 with SMTP id
 5b1f17b1804b1-438dc3cbc24mr247579185e9.14.1738679477803; 
 Tue, 04 Feb 2025 06:31:17 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15d3:1100:15c3:7ea2:8ff1:462c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244eb0dsm194169135e9.27.2025.02.04.06.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:31:17 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: timur.kristof@gmail.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: rework gfx8 queue reset
Date: Tue,  4 Feb 2025 15:31:12 +0100
Message-Id: <20250204143113.6320-5-christian.koenig@amd.com>
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

Apply the same changes to gfx8 as done to gfx9.

Untested and probably needs some more work.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 86 ++++++++++++---------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 6a025438f9d0..f57301ebbd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6201,12 +6201,45 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 
 }
 
+static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
+				  int mem_space, int opt, uint32_t addr0,
+				  uint32_t addr1, uint32_t ref, uint32_t mask,
+				  uint32_t inv)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
+	amdgpu_ring_write(ring,
+			  /* memory (1) or register (0) */
+			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
+			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
+			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
+			   WAIT_REG_MEM_ENGINE(eng_sel)));
+
+	WARN_ON(mem_space && addr0 & 0x3); /* Dword align */
+	amdgpu_ring_write(ring, addr0);
+	amdgpu_ring_write(ring, addr1);
+	amdgpu_ring_write(ring, ref);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, inv); /* poll interval */
+}
+
+static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					uint32_t val, uint32_t mask)
+{
+	gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
+}
+
 static void gfx_v8_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 {
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
+	amdgpu_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq,
+			       AMDGPU_FENCE_FLAG_EXEC);
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
 				 WAIT_REG_MEM_FUNCTION(3) | /* equal */
@@ -6400,46 +6433,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 	amdgpu_ring_write(ring, val);
 }
 
-static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
-				  int mem_space, int opt, uint32_t addr0,
-				  uint32_t addr1, uint32_t ref, uint32_t mask,
-				  uint32_t inv)
-{
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
-	amdgpu_ring_write(ring,
-			  /* memory (1) or register (0) */
-			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
-			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
-
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
-	amdgpu_ring_write(ring, addr0);
-	amdgpu_ring_write(ring, addr1);
-	amdgpu_ring_write(ring, ref);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, inv); /* poll interval */
-}
-
-static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
-static void gfx_v8_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	WREG32(mmSQ_CMD, value);
-}
-
 static void gfx_v8_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 						 enum amdgpu_interrupt_state state)
 {
@@ -6936,14 +6929,13 @@ static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
+	if (amdgpu_ring_alloc(ring, 7 + 12 + 5 + 7))
 		return -ENOMEM;
-	gfx_v8_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
 
-	return amdgpu_ring_test_ring(ring);
+	gfx_v8_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v8_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
@@ -7009,7 +7001,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v8_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v8_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
-	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
 	.reset = gfx_v8_0_reset_kgq,
 };
@@ -7044,7 +7035,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
-	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
 	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };
-- 
2.34.1


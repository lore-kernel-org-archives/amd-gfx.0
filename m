Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE67C02198
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D0110E664;
	Tue,  4 Feb 2025 14:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDLcUgNm";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDB210E663
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:31:19 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so57967045e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738679477; x=1739284277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kr5/RaYJSiAxNqMg6z7fzc/gu7BWkEeNitm/Lohqp8s=;
 b=VDLcUgNm33fWNVgr1Sh1jVduRCfg9Vhskyh+sin+zOrksgYV+hIld9QAFKHwSIc08D
 kSq/eAi8W98vE9VNuXNqbeha1DwYTfXoyT/Nxmj5yF5b630wBbfjXbyfX9T1dlxfDyxe
 n9omcQwkJ6vZUfc/Qb1kVxe6K6DmTcOWJ0Tyi3hzDBS2sFXOo90AO3prsLmRmj/cscV8
 7uC9K4DzuwJYLt0WXKM+HQ++3e8O3nb3tpqb1+x38h+g1DUm+uCc/bhL5zijrlnOYNQr
 LGMz0Notwc5IbSsTlDYQzKXfF7GnlpBwrRf9jAqts1wn9bAD5saJyv1GthN4QF2qF+49
 npOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679477; x=1739284277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr5/RaYJSiAxNqMg6z7fzc/gu7BWkEeNitm/Lohqp8s=;
 b=NctYx7mZvg7YliF2EknRYnBtGI+WhyKS/6xkUKXNsYKvZyv8BacyIRjerwQyCvkwcP
 e0LMAUO3i44E9sow7assneW0GwMLF60oX+YvZJLUsX9jJxM4r5QDpkFRGvYZNooBhJYs
 AMc5kIBf0NTFRiMeMePxHzHfqczMAGLxyKnT0sqP9mxmtSdV5SuxzM4Oxe8f241he6td
 +MAyqv7u5qd+zLPJyhIzZ8GiLoz315nyyrMGAGlFJID51Zg78YQ2+kHLzW9bCV/oeKMQ
 otKGWuq3t/xXbIRkZn1IeRGYhuTl3BLKkxe9ylqBUzdqZCW+Fc8FjDyVIicLVijNMDFH
 mjDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHLDGy/4K2fmqbYUMXfbErl6kQays176NyextUyh06RFR2QEU6kZPOeXTxv0CYRKC4n3CSqMjB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyXHDZ3xzQP3dSEwMM0pqLRM3I9L2s68kBLG1+aGEI3dMtSFH1
 hx5zethy8LvFAZk2m8610Tm8r1c4JybhjKIpdnXYjeUkG07nwTNl
X-Gm-Gg: ASbGncuwunZ8Tp7RUCDHWxUKnHmuuSxnde82mW1m1eywp/HtXZ8/vTR8ebJxWHLReK0
 avrv1CFwmaopx3TwnMnTTKoYX2SC5wPmMtU3hy7kt0bHQIi/qaeaDamr/+7/yeeAUe0vWP1xft7
 1QWU+MC170HcRmSUfGGBhQHT3IEtrLrDZ5OAksXHrvKNZ6sS9YVBA8FpXl4Ijo0zNSynyR+1nGJ
 /GTzD0ICtX/hQ0Z3o1bWx6OFPG2WEkM2gJe7sHiDRvUGFHuqZtxmv24KzJ6qD/ERgw0tH7n5UPs
 0g6qWQyjUTonBman2H/IvUA1g/0Z
X-Google-Smtp-Source: AGHT+IHkfa3geq+j5eVeDOMqIpeUWBSK4uK48NXkpmBZrnbyTkZtoEs1BZlwJW4Szfp5ZmhPA5TuQg==
X-Received: by 2002:a05:600c:468c:b0:434:a815:2b57 with SMTP id
 5b1f17b1804b1-438dc40d759mr202189115e9.20.1738679477165; 
 Tue, 04 Feb 2025 06:31:17 -0800 (PST)
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
Subject: [PATCH 3/5] drm/amdgpu: rework gfx7 queue reset
Date: Tue,  4 Feb 2025 15:31:11 +0100
Message-Id: <20250204143113.6320-4-christian.koenig@amd.com>
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

Apply the same changes to gfx7 as done to gfx9.

Untested and probably needs some more work.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 89 ++++++++++++---------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 84745b2453ab..9f91c99725aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3092,6 +3092,33 @@ static int gfx_v7_0_cp_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
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
+static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					uint32_t val, uint32_t mask)
+{
+	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
+}
+
 /**
  * gfx_v7_0_ring_emit_pipeline_sync - cik vm flush using the CP
  *
@@ -3106,6 +3133,11 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
+	amdgpu_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq,
+			       AMDGPU_FENCE_FLAG_EXEC);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
 				 WAIT_REG_MEM_FUNCTION(3) | /* equal */
@@ -4040,18 +4072,6 @@ static void gfx_v7_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
-static void gfx_v7_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
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
 static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
 {
 	WREG32(mmSQ_IND_INDEX,
@@ -4926,34 +4946,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0x0000000A);	/* poll interval */
 }
 
-static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
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
-static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
 static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -4986,14 +4978,13 @@ static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
+	if (amdgpu_ring_alloc(ring, 7 + 12 + 5 + 7 + 4))
 		return -ENOMEM;
-	gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
 
-	return amdgpu_ring_test_ring(ring);
+	gfx_v7_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v7_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static const struct amd_ip_funcs gfx_v7_0_ip_funcs = {
@@ -5026,7 +5017,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
 		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for user fence, vm fence */
-		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
+		7 + 12 + 5 + 7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
 		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring_emit_vm_flush */
 		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
 		5, /* SURFACE_SYNC */
@@ -5043,7 +5034,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
-	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
 	.reset = gfx_v7_0_reset_kgq,
 };
@@ -5060,7 +5050,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 		20 + /* gfx_v7_0_ring_emit_gds_switch */
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
+		7 + 12 + 5 + 7 + /* gfx_v7_0_ring_emit_pipeline_sync */
 		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v7_0_ring_emit_vm_flush */
 		7 + 7 + 7 + /* gfx_v7_0_ring_emit_fence_compute x3 for user fence, vm fence */
 		7, /* gfx_v7_0_emit_mem_sync_compute */
@@ -5076,7 +5066,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
-	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,
 };
 
-- 
2.34.1


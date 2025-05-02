Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10178C3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754E610E94E;
	Fri,  2 May 2025 16:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="heCrcz4y";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E4910E923
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:17:24 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso341651466b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746202643; x=1746807443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mf59Z+V45+D8TaANSHepipO+Ih9h6LLIgOKuaPy3UhY=;
 b=heCrcz4yh+wuLFao7LCY7SHKXa8X7qnMIwQZbew10IoU+Fz9imlk/4d07ijxkw5i0y
 obvBnXyefRgbkQAuM7CSnMQ4lL3G2MhLgPcVuDL4YAwvwPnDQMbQC/jhTpenDV2BW9uA
 67zUB1gYpEC1LJhDgRCaCPxzJLalKBlHlRZpQfRQcoMmZEHPe9Z2pGNj/9nWsl/yxuDj
 sYlRSpHuPC/RM83qtB8WAk/Q/NoUgO29h4R9VgDAsQAKiP/zlSO4pL4xQgzy2SBJRYat
 FpgJpl0AeQ/1Hd85hEekrtotKM7m54nifc2D+ygWih0Yg/r4e+4q7BSOqjCAePDGfRWh
 SEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202643; x=1746807443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mf59Z+V45+D8TaANSHepipO+Ih9h6LLIgOKuaPy3UhY=;
 b=dizVEQOqpbJhiBfS0nG73H8FswIZkKh9SVrpBBCmQwVkWASkcNVwmEEcKCIcp6W5x5
 4jHDj0je2dyAUPkCadjLtYqzRswhIjhrOFjJoMgBLz0eNB8wm2/SuZUeITzpkF05pUyY
 kpY/jOpvQgXvqyBhdXX7z0S/ZSPIZTYMNHcSSD02k+Dsz1new3Rj6D0jDyegANnI/U7T
 RUzfAhzOOj3LdhmaLgQu7zezWhBgIq464QlHVgFVk3EN13CE7h94W4EYCSJsvWbaMhFb
 1/tzrkX+gj0IRs1gi0compWDh38mQ5JhMIzM1IxjSYaG6yRDd8kJ6xnSGSWZk9GOSlVz
 MU/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Aa7Wzkj5rBrACTqbPsSBO6zq2C5xdGFm9oUenAKRvrajdjKbPVj6gHGThSd1inJ2Xr6KopZl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZt/v+9QMfI7uQTGuXuppqq+AayKplwfcjtr7fhI1yhx+KE/dv
 bodvJeCq5GysFyMMbJ7QK0HfT22CcThb7uL/sWBa2ufPK0PNVG2Y
X-Gm-Gg: ASbGncvMFVte4SXWMA4Z1YF6qoSfBW/tdmmWn3Bl9WSyLOp2yOZvrTmNNBwCnrFuwho
 lWv9lRfvbbzfZesmb/ao35WLkfeGc0VIyv1ulqjZc8O6rZpbvPR/4voYAQcYwbZKC9NpgD19Xjh
 l0W4pqQw8gaq9uivt8SzRROEVLIW/WqyRJyXplbL+oZZRT1suV07znyFLuiu2nwM62J43BeGRqz
 n+7eo7fXyF01CXxwUGX94O0i+/WCZxZzxkrxJABFTC8Vp/zD3X638wMaiQS9RWDPPx8eYb0RJbm
 N1hHUsfKNW+DluN1vSXHn1s/wIAN4zOkfNXBioC0IFlHuARjTUmb1+DtX2akobf/
X-Google-Smtp-Source: AGHT+IFbsfUi4jjJlqmwdzdLp5ddRQKyjkgFXHGqCsaFy5KKDdI4XxGynZvnGExV/iMxWMHaQDb+wQ==
X-Received: by 2002:a17:907:96a7:b0:ace:cf44:28c7 with SMTP id
 a640c23a62f3a-ad17b86882dmr342514866b.57.1746202642986; 
 Fri, 02 May 2025 09:17:22 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b1:4a00:5585:4c76:3645:c6fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189509088sm68748766b.146.2025.05.02.09.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:17:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: rework gfx7 queue reset
Date: Fri,  2 May 2025 18:17:18 +0200
Message-Id: <20250502161720.1704-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502161720.1704-1-christian.koenig@amd.com>
References: <20250502161720.1704-1-christian.koenig@amd.com>
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
index da0534ff1271..3634f54ed5a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3095,6 +3095,33 @@ static int gfx_v7_0_cp_resume(struct amdgpu_device *adev)
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
@@ -3109,6 +3136,11 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
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
@@ -3998,18 +4030,6 @@ static void gfx_v7_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
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
@@ -4884,34 +4904,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct amdgpu_ring *ring)
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
@@ -4944,14 +4936,13 @@ static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
@@ -4984,7 +4975,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
 		12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for user fence, vm fence */
-		7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
+		7 + 12 + 5 + 7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
 		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring_emit_vm_flush */
 		3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*/
 		5, /* SURFACE_SYNC */
@@ -5001,7 +4992,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_gfx = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v7_ring_emit_cntxcntl,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
-	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync,
 	.reset = gfx_v7_0_reset_kgq,
 };
@@ -5018,7 +5008,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 		20 + /* gfx_v7_0_ring_emit_gds_switch */
 		7 + /* gfx_v7_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
-		7 + /* gfx_v7_0_ring_emit_pipeline_sync */
+		7 + 12 + 5 + 7 + /* gfx_v7_0_ring_emit_pipeline_sync */
 		CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v7_0_ring_emit_vm_flush */
 		7 + 7 + 7 + /* gfx_v7_0_ring_emit_fence_compute x3 for user fence, vm fence */
 		7, /* gfx_v7_0_emit_mem_sync_compute */
@@ -5034,7 +5024,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v7_0_ring_emit_wreg,
-	.soft_recovery = gfx_v7_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,
 };
 
-- 
2.34.1


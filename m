Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC9C3ABB8
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C4D10E923;
	Fri,  2 May 2025 16:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKvo4ICu";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D77810E951
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:17:25 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so393163966b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746202644; x=1746807444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hp/INaGdeIbsNHymOzZ3YEWDLRpWD7uUdZorTJbSbEQ=;
 b=EKvo4ICuXslSgaEZquSrYyn0mpeN0aIbAcWzaScoE4A55R6oE+5amv3nzGICrvskEP
 ZczgGXJRNWv/UrhPhPonI8vep52YH749+YtvsVz4RzCSIpRGcb+80H/hT3AyqJTDXMRJ
 ZLfHOZWiVvtXt4qB+ohHCHDHFTz+UFAVW8RjFyyY/RbzpUOcq3fmGfG3sHu86Y6Fsv/9
 p/1lkBWbi24z+F7vF86W0zYqb3qrp8zWgMhG6xc2vQDI5GBuFEd2kPAGHzcS+pIAGKCT
 dItClqV2j6FNfYZM0Bwvv4xcgWOhE81QKllEKWF2gowZXXKtwri3+8hs2OGMEaIPjF/m
 r/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202644; x=1746807444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hp/INaGdeIbsNHymOzZ3YEWDLRpWD7uUdZorTJbSbEQ=;
 b=GTpN5QH5LVXCmMHF7XIblY5f+Gb1n7d13PLhnym8VdSmnz6WaPIIW+zdXOzLiIhORu
 o/nkKReakrMCXL+DpFUJ3UBfi943TiZNAHhc3NSBXNcR5fea4hxz2ZQIIXM5v8PIhMKw
 9WDdqWv3liLPC+PXjaBVflUbS1zNR57YYK9LbhLxdbOk8sNKxKHH+UNb+BOarqWoFMO7
 eQ+t+jkC5vMTb4T3oqsfvpzTd6BX4STnx+vZusXKdOPuZRfJ5LwH2AVjdJeCA6vpxOKG
 3TbUqm6R9js0FI5ShswP5s5a7tESLXhbD3ABqqXh9atE9M1PamTtb3v6zLZTuQb+se5X
 94yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR9AWYQxL68SV/vfWfu6C0kh0aU/SZUoAmzzx6ydTbC1HtBTSGOuKIOHpAdl0zNUBkkPuPOXMO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyakPo7hIsIUsw/9rd41W0G+hYjDqjc3caTlFiGee9o7ogkkD99
 eB2ov2wJUYICGHc4L794W1yNoWTzV9bU4gm6SCyM/C235gZ4uwFIaJezmFBf3o4=
X-Gm-Gg: ASbGncuAjodWILFD3V2RRdwKNeCIdGzSp6xAQ3d1RR4ZVleIxXHkGvhNsy0kuS/tL6f
 VHVZH6Y2+NIizelaMybwLf8wUNfB3Q/me/dMervW+BvFvlX1AS1lJ5TYj6t4v5co8BjJ9qjA5NC
 CgQZLoYJ51leYi6nav776DemvG+f0KyaARkiCIs0VEro2Ma4vNiEMmyw1Ts+lCwNyIb730T9IoW
 7Jv+OuyHernEFCBuIqhYTEDUS/otaVTwIC3nMeDj6d8IxGs0Arwa9oXBU3i7n1jVzT0FAU4aqZz
 hXKl4a7zt2LijhHJEiKAt9u2caUeyRW+XgRysCum+YwQajceWUTfSuvThHxDLCph
X-Google-Smtp-Source: AGHT+IFvH1AcM6JoqMmsMW9VJeo/qenk8bY4D5BX+z3xOgrv/UI5RFPG7axV1QCOx2D7YSfuOTiumA==
X-Received: by 2002:a17:907:803:b0:ac7:66fb:6a07 with SMTP id
 a640c23a62f3a-ad17ad1aca4mr365579666b.6.1746202643617; 
 Fri, 02 May 2025 09:17:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b1:4a00:5585:4c76:3645:c6fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189509088sm68748766b.146.2025.05.02.09.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:17:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: rework gfx8 queue reset
Date: Fri,  2 May 2025 18:17:19 +0200
Message-Id: <20250502161720.1704-4-christian.koenig@amd.com>
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

Apply the same changes to gfx8 as done to gfx9.

Untested and probably needs some more work.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 86 ++++++++++++---------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5ee2237d8ee8..8dd1ffecfa81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6140,12 +6140,45 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 
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
@@ -6339,46 +6372,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
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
@@ -6875,14 +6868,13 @@ static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
@@ -6948,7 +6940,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v8_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v8_0_ring_emit_init_cond_exec,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
-	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
 	.reset = gfx_v8_0_reset_kgq,
 };
@@ -6983,7 +6974,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
-	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
 	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3322C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7040F10E951;
	Fri,  2 May 2025 16:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZC+3Uj5V";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B4C10E951
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:17:25 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so313609466b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746202644; x=1746807444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XCQbHIy2jWvAYrJI0+hadYu8+75NvtGT4UUM9b/XC0w=;
 b=ZC+3Uj5V0/UbW9GuRSVAnYSw8ooJ2mFd12jclb6JcL+qcwhy6W8LFb2LMOoc0K6zLA
 6es9/e2jLxeab5i+odmwzXp6TfbfMBrGqwjgwHEqh5nMWw6m2vaLaJlhv2Rc5+1SegGx
 phBJ2NXsfxEH4sJ8WM/iECNiDxt4oswPOWL6j+oTEn/p43v5Wu4Yd2fDHUrEL5buNh+9
 NHpvFuk45Y8Lq7kbsmkSIFKJy+onmhhTmGCPo7qzvJ3UMYOVTwZjT2o3ebEaVk9JqgJH
 zucYOdm4Du9yTENBnWbnNeuoEOIskT8oXL0P+Vsl0n/1gQu4bNGl+cV2QXArXAM7ufMl
 fVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202644; x=1746807444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCQbHIy2jWvAYrJI0+hadYu8+75NvtGT4UUM9b/XC0w=;
 b=q6lYO8AODmgc9sm7H3KI6vBZEs6DuqiT6uPejPW4fQ24AKoqLyH9vezbWw9FFFQ/xq
 A8cQRlDecTAC0OC/MPHZO42GdXve4mgRSZ/yfbPAzjS5ZNxxwdl+jl6S93/En0X4FkhW
 BwPNzXegiv2gpFbgNeWEpZHOTNDMJgkgPlERlVoYAYAgyXtZhQopYbrzC1ee2W9dj+G4
 5Zv5hpQVY0zIS9+xBscFNB3BzMgdD7+Q+BQWndVmVLjswqVuXK0dtnvbET/xYBvdAcvv
 OYSw2QBGz6MncZAdlHdHKn6gutl2h1HZTtIkxGzn9lB6GUkKuCWaAEG+fVJQaoqIvyF5
 Nbpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvZbQtuTavoNdygEopNr0clG/aoDyBGIzNwgUT9fCTs2+68m0gIj+91KqzMPcvXC/TNhqs/shm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCeJSCZ2Mt0LPcLcaskhyzhWulEVyyLhXa2M6vPqxBa8RkAV8r
 9Wfdy0VHAQqAXG/qa4ILAhqMcKXtF3brV+3Qe2IJKE+YR/VB10ad
X-Gm-Gg: ASbGnctF7eY2+mbZViidUlgwUu6ZebEVRE1ooLlDQxK70NZRvW46neXdp2q09OO6Xs/
 0wPV6ykGZPpW6DdzSU92tN7o+I8mfiPu7n+g8hStyOjlosMNbm8bJu2c3LsznWkxIlIrDUyTbB5
 NAow4CE8vjgeMPfxD2mrl8zOF1Bk/sybH7Nmo8wqJD0R7S4GQdP20jbo/pYJL+wup8cdPrGuX4v
 N8sLkFRE80Mq4xCVXmBu27K0MUQt8bzuSko/QUvy8eHHCGsBQvKi4rrbUIjawvWIiuRD4KMxq3s
 kTjvXTs5WSL0mcN6jvpNqNFipKDvbI/3pDhmJiGJdf18MWFcq5HsxjeZFtRMaxjn
X-Google-Smtp-Source: AGHT+IG9oTSnEydizAUCzQPziK2mvb2DjOjdk84MgY5XVqn0X2KE/7YnpGftd0pgvU7G3nZjAGmq4A==
X-Received: by 2002:a17:907:7da4:b0:ace:c43a:63e9 with SMTP id
 a640c23a62f3a-ad17aeff6c5mr340784666b.42.1746202644254; 
 Fri, 02 May 2025 09:17:24 -0700 (PDT)
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
Subject: [PATCH 5/5] drm/amdgpu: rework gfx10 queue reset
Date: Fri,  2 May 2025 18:17:20 +0200
Message-Id: <20250502161720.1704-5-christian.koenig@amd.com>
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

Apply the same changes to gfx10 as done to gfx9.

The general idea to reset the whole kernel queue and then asking the kiq
to map it again didn't worked at all. Background is that we don't use per
application kernel queues for gfx10 on Linux for performance reasons.

So instead use the gfx9 approach here as well and only reset all
submissions from a specific VMID instead of the whole queue.

Navi 10 seems to be stable, but Navi 2x still shows hangs during over
night testing. This needs more investigation, but the result is clearly
better than before.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 57 ++++++++------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb..41cc0d6db15b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8746,7 +8746,17 @@ static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
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
 	gfx_v10_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
 			       upper_32_bits(addr), seq, 0xffffffff, 4);
 }
@@ -9046,21 +9056,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
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
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9529,38 +9524,21 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 	u32 tmp;
-	u64 addr;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
-	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
+	if (amdgpu_ring_alloc(kiq_ring, 5)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		return -ENOMEM;
 	}
 
-	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
-		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
 	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	if (ring->pipe == 0)
-		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
-	else
-		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1 << ring->queue);
-
 	gfx_v10_0_ring_emit_wreg(kiq_ring,
 				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
-	gfx_v10_0_wait_reg_mem(kiq_ring, 0, 1, 0,
-			       lower_32_bits(addr), upper_32_bits(addr),
-			       0, 1, 0x20);
-	gfx_v10_0_ring_emit_reg_wait(kiq_ring,
-				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
-	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
 
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
@@ -9569,13 +9547,12 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	r = gfx_v10_0_kgq_init_queue(ring, true);
-	if (r) {
-		DRM_ERROR("fail to init kgq\n");
-		return r;
-	}
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
+		return -ENOMEM;
+	gfx_v10_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9882,7 +9859,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9923,7 +9899,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.34.1


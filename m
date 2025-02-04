Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723C1C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFDE10E665;
	Tue,  4 Feb 2025 14:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YD9C/7Iv";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3473910E665
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:31:20 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso57914105e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738679478; x=1739284278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ppt24CxnPbTtH036mWHYGao27RPQh/2Am3FjSd8CaI=;
 b=YD9C/7IvEYddzvGP1c5d3dITb+AzXrn1UfUzxsxVEvSrhiA+/r4H/nckOVN+D2FEtB
 uEShDn76q1/ZCv1bGquD/AVDL3aVxgzaCYVKiH4kG53l8+AEocn5zB477ys4DQJpbrtk
 y2krWThmzJ3T1VKy3GfubtxkqLLc4EE8fZGw2Sp7M3X+n40c2WE6xYV+jT3UzBCuR3XH
 JPM6pHngAYXdmsBYVHD1Hws0ihl1AEvRThVwKiE5nMbTz4zOwEw5JIM2Lm7wPuNgDi/c
 E9jrhkQ3ABvbZ5bzxSJh+zu2M1cTo+VSs88zyi0oGqkL+TqjkYw7nri9oPeoYgGbTFj/
 CVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679478; x=1739284278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ppt24CxnPbTtH036mWHYGao27RPQh/2Am3FjSd8CaI=;
 b=a+gD9ZtViYjFiHIMEQufeA1m8yVPM2bJTIJK5A6G5fjIdv4y6vpIOQPVEWyFjd6TjX
 ZSmpk+WcuFxh8nykuWVf9OEe2lZh6cWzEF0tJV2LHZ1t8lJkc1ruLjW2YFewwiaTs0qP
 1e9cSr65JM1xD91md45QR6hnRHtOnTQ3LdHxImTJK32RuAfC2ZYimO62z1fNZnC2Avk/
 1Ewod1w0qGvF1E9voYfabV+JTFkQHRvwUD94OI4MBFedf7Uauy/98309nyGXR5dCa6I9
 gWxdYvjAUgCrOEEs5yYMsaqmkCqytOULBtIzvIZJ1PiGTDGccEghBAaTEs0aq8orBsDf
 fxwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWKIgQWQkQfcBWEdCxQ7SEpt3U50dExiFhab6sKcIfiRFbHpL0IlWMpEmHqilctROIuNftH88S@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxINBS/kspoQ3fX2Zyo5EUk8za6R+LztzOuC0h7vjkMEWzzj/MS
 AVUAoobs6elKf+hhEUOpf16alZtTt6F3zoFj0klUA6dOJzoxVN02
X-Gm-Gg: ASbGncuOIVRuVqCFcyDOdgsh4NobK3bATGHBHgynz/Sf8xCgAw5CBP1ctN+shLlG3tx
 Xchl/m+sVyMhbn/wpSBwTtaXneQZp6RO4xyias9/4bZubz3kCFJ4aflj/T1I+xNPHnxoZKlehJM
 kuoV4g9oC1S3TyvD71nGpYNZhnZvPFiNeZQGft3d/S8KsuyeMfvrtTUvF0fWmyYtNI7vQVTPDvC
 JhehYwbdql1WnJFBhNAVl1D+PBXqLQ4bB9b1YqnQjuXkUEiRm7XTMu9tmSHxA2pzNBLEO1Ry083
 luaz1/LfHZWbuK8ivWCOEpEAZvrB
X-Google-Smtp-Source: AGHT+IGxxPI0FGbUAct++ef37LxNNPU5mytHDzANFpLJ1fQT+qUyFXoiJ3r53lYr3bbv8oSXaNM1lw==
X-Received: by 2002:a05:600c:22d9:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-438dc48a91amr228807265e9.15.1738679478462; 
 Tue, 04 Feb 2025 06:31:18 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15d3:1100:15c3:7ea2:8ff1:462c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244eb0dsm194169135e9.27.2025.02.04.06.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:31:18 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: timur.kristof@gmail.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: rework gfx10 queue reset
Date: Tue,  4 Feb 2025 15:31:13 +0100
Message-Id: <20250204143113.6320-6-christian.koenig@amd.com>
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

Apply the same changes to gfx10 as done to gfx9.

The general idea to reset the whole kernel queue and then asking the kiq
to map it again didn't worked at all. Background is that we don't use per
application kernel queues for gfx10 on Linux for performance reasons.

So instead use the gfx9 approach here as well and only reset all
submissions from a specific VMID instead of the whole queue.

This also avoids reserving and kmap the MQD which are operations
generally not allowed in the reset handler.

This approach seems to work for at least some time, but not as reliable
as it is on gfx9. It will probably need some more work until it survives
a whole night of reset stress testing.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 65 +++++++-------------------
 1 file changed, 16 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5ba263fe5512..7ffdba974f87 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8684,7 +8684,17 @@ static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
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
@@ -8984,21 +8994,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
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
@@ -9467,7 +9462,6 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 	u32 tmp;
-	u64 addr;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -9478,27 +9472,14 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 
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
@@ -9507,24 +9488,12 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-	if (unlikely(r != 0)) {
-		DRM_ERROR("fail to resv mqd_obj\n");
-		return r;
-	}
-	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (!r) {
-		r = gfx_v10_0_kgq_init_queue(ring, true);
-		amdgpu_bo_kunmap(ring->mqd_obj);
-		ring->mqd_ptr = NULL;
-	}
-	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r) {
-		DRM_ERROR("fail to unresv mqd_obj\n");
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
@@ -9819,7 +9788,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9860,7 +9828,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.34.1


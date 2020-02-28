Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EF0C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4765D2468E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK9yZJXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4765D2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091FB6F465;
	Fri, 28 Feb 2020 14:36:51 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D356F465
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 14:36:47 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e10so1755372wrr.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 06:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hn3CeNLkpM8jmNqvU0NjdphEuHprrV8BLXh7S3zalYM=;
 b=IK9yZJXqJshHHUZdidywBTJr4Xz9u6atRWN19NsaJDKKUVn7Vm60yW3/8xLofsMBqA
 n66w4qXBpdd0wcfo9Go3n8zAsMLpOKjeUWQbxZfB9S4iyK1ecjaqjo7cUHDFtTPaGSyy
 DVeNfpfek6TP5ko8OPGfSwIYLE5gu90oGygQbsBSXH6e6PQM9b9S0T2I/k7dGBFhTHrY
 mqNfpucFVseoYhmiy/JbR/XNYeNlqLqBF2INBCYUTrpIah7yAtfeIdMFGyd+sMxTX9/A
 erw0KLwCxOh/Ij3QbdK9EMHVCL/SgMzUh5nBghXVSLl4wbVLwAc6ZQ+c3q2ckWh0BafP
 1heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hn3CeNLkpM8jmNqvU0NjdphEuHprrV8BLXh7S3zalYM=;
 b=KwZEKdpQMVyoHvqw2qwH63ZW8GMgn8qgFQ1lb6sL/LeP9Y1BG6rJReM1HVcsR/ufpc
 BK3BeplSs+HFdHPPsZnjkuEotPFWuLSV0058ix3Hn3aoy0BIdAuIeaHH3IMdmB/RpnRf
 3YO2lv4c0qHHjwD/+VD8+8B1gkVFbEsylHSHONJlu7Fn9gLUCP8M2lRxLbQB8HDf3Huk
 ojW5rt/xoUWkPDUQUgzkanXpuPYaoXcmno5jKEztcUquVEkTswf7Q/jaQDO0p3r4X7sg
 cZPI692IhfgWUL5d8swftQ2r4xsgOZs6UZSRJ6w8HDW7FAx+maMacc+yqPJiM+auLMwX
 lndQ==
X-Gm-Message-State: APjAAAUxILtQMEPjli9dTyXJ3GLWnMfvFa8Ru9x3UeM2qQiV4OOgAZc6
 bX76HME8L9Oj74VqEeGPTMJ14TsPUdmn5g==
X-Google-Smtp-Source: APXvYqz/1hl+DqFw+uC/AU0f2kEGeRN61r9PZqeULw+GZyCSNOA6GULFyyZ8QKBX1ufUg0Vkv8yk0g==
X-Received: by 2002:adf:fac9:: with SMTP id a9mr4900086wrs.232.1582900605569; 
 Fri, 28 Feb 2020 06:36:45 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F28EF00805E149DBFE09C45.dip0.t-ipconnect.de.
 [2003:c5:8f28:ef00:805e:149d:bfe0:9c45])
 by smtp.gmail.com with ESMTPSA id m125sm2445471wmf.8.2020.02.28.06.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:36:44 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: remove unused functions
Date: Fri, 28 Feb 2020 15:39:41 +0100
Message-Id: <20200228143941.4919-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200228143941.4919-1-nirmoy.das@amd.com>
References: <20200228143941.4919-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu statically set priority for compute queues
at initialization so remove all the functions
responsible changing compute queue priority dynamically

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  70 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   7 --
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  99 ----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 100 -----------------------
 4 files changed, 276 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ca6b52054b4b..a7e1d0425ed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -150,76 +150,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
 		ring->funcs->end_use(ring);
 }
 
-/**
- * amdgpu_ring_priority_put - restore a ring's priority
- *
- * @ring: amdgpu_ring structure holding the information
- * @priority: target priority
- *
- * Release a request for executing at @priority
- */
-void amdgpu_ring_priority_put(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority)
-{
-	int i;
-
-	if (!ring->funcs->set_priority)
-		return;
-
-	if (atomic_dec_return(&ring->num_jobs[priority]) > 0)
-		return;
-
-	/* no need to restore if the job is already at the lowest priority */
-	if (priority == DRM_SCHED_PRIORITY_NORMAL)
-		return;
-
-	mutex_lock(&ring->priority_mutex);
-	/* something higher prio is executing, no need to decay */
-	if (ring->priority > priority)
-		goto out_unlock;
-
-	/* decay priority to the next level with a job available */
-	for (i = priority; i >= DRM_SCHED_PRIORITY_MIN; i--) {
-		if (i == DRM_SCHED_PRIORITY_NORMAL
-				|| atomic_read(&ring->num_jobs[i])) {
-			ring->priority = i;
-			ring->funcs->set_priority(ring, i);
-			break;
-		}
-	}
-
-out_unlock:
-	mutex_unlock(&ring->priority_mutex);
-}
-
-/**
- * amdgpu_ring_priority_get - change the ring's priority
- *
- * @ring: amdgpu_ring structure holding the information
- * @priority: target priority
- *
- * Request a ring's priority to be raised to @priority (refcounted).
- */
-void amdgpu_ring_priority_get(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority)
-{
-	if (!ring->funcs->set_priority)
-		return;
-
-	if (atomic_inc_return(&ring->num_jobs[priority]) <= 0)
-		return;
-
-	mutex_lock(&ring->priority_mutex);
-	if (priority <= ring->priority)
-		goto out_unlock;
-
-	ring->priority = priority;
-	ring->funcs->set_priority(ring, priority);
-
-out_unlock:
-	mutex_unlock(&ring->priority_mutex);
-}
-
 /**
  * amdgpu_ring_init - init driver ring struct.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 34fcd467f18d..87ec35b68bfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -167,9 +167,6 @@ struct amdgpu_ring_funcs {
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask);
 	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
-	/* priority functions */
-	void (*set_priority) (struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority);
 	/* Try to soft recover the ring to make the fence signal */
 	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
 	int (*preempt_ib)(struct amdgpu_ring *ring);
@@ -259,10 +256,6 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
 void amdgpu_ring_undo(struct amdgpu_ring *ring);
-void amdgpu_ring_priority_get(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority);
-void amdgpu_ring_priority_put(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority);
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		     unsigned ring_size, struct amdgpu_irq_src *irq_src,
 		     unsigned irq_type);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 6c4b7e49f97f..ed9aff72350d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6275,104 +6275,6 @@ static void gfx_v8_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 }
 
-static void gfx_v8_0_ring_set_pipe_percent(struct amdgpu_ring *ring,
-					   bool acquire)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int pipe_num, tmp, reg;
-	int pipe_percent = acquire ? SPI_WCL_PIPE_PERCENT_GFX__VALUE_MASK : 0x1;
-
-	pipe_num = ring->me * adev->gfx.mec.num_pipe_per_mec + ring->pipe;
-
-	/* first me only has 2 entries, GFX and HP3D */
-	if (ring->me > 0)
-		pipe_num -= 2;
-
-	reg = mmSPI_WCL_PIPE_PERCENT_GFX + pipe_num;
-	tmp = RREG32(reg);
-	tmp = REG_SET_FIELD(tmp, SPI_WCL_PIPE_PERCENT_GFX, VALUE, pipe_percent);
-	WREG32(reg, tmp);
-}
-
-static void gfx_v8_0_pipe_reserve_resources(struct amdgpu_device *adev,
-					    struct amdgpu_ring *ring,
-					    bool acquire)
-{
-	int i, pipe;
-	bool reserve;
-	struct amdgpu_ring *iring;
-
-	mutex_lock(&adev->gfx.pipe_reserve_mutex);
-	pipe = amdgpu_gfx_mec_queue_to_bit(adev, ring->me, ring->pipe, 0);
-	if (acquire)
-		set_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-	else
-		clear_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-
-	if (!bitmap_weight(adev->gfx.pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES)) {
-		/* Clear all reservations - everyone reacquires all resources */
-		for (i = 0; i < adev->gfx.num_gfx_rings; ++i)
-			gfx_v8_0_ring_set_pipe_percent(&adev->gfx.gfx_ring[i],
-						       true);
-
-		for (i = 0; i < adev->gfx.num_compute_rings; ++i)
-			gfx_v8_0_ring_set_pipe_percent(&adev->gfx.compute_ring[i],
-						       true);
-	} else {
-		/* Lower all pipes without a current reservation */
-		for (i = 0; i < adev->gfx.num_gfx_rings; ++i) {
-			iring = &adev->gfx.gfx_ring[i];
-			pipe = amdgpu_gfx_mec_queue_to_bit(adev,
-							   iring->me,
-							   iring->pipe,
-							   0);
-			reserve = test_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-			gfx_v8_0_ring_set_pipe_percent(iring, reserve);
-		}
-
-		for (i = 0; i < adev->gfx.num_compute_rings; ++i) {
-			iring = &adev->gfx.compute_ring[i];
-			pipe = amdgpu_gfx_mec_queue_to_bit(adev,
-							   iring->me,
-							   iring->pipe,
-							   0);
-			reserve = test_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-			gfx_v8_0_ring_set_pipe_percent(iring, reserve);
-		}
-	}
-
-	mutex_unlock(&adev->gfx.pipe_reserve_mutex);
-}
-
-static void gfx_v8_0_hqd_set_priority(struct amdgpu_device *adev,
-				      struct amdgpu_ring *ring,
-				      bool acquire)
-{
-	uint32_t pipe_priority = acquire ? 0x2 : 0x0;
-	uint32_t queue_priority = acquire ? 0xf : 0x0;
-
-	mutex_lock(&adev->srbm_mutex);
-	vi_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	WREG32(mmCP_HQD_PIPE_PRIORITY, pipe_priority);
-	WREG32(mmCP_HQD_QUEUE_PRIORITY, queue_priority);
-
-	vi_srbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-}
-static void gfx_v8_0_ring_set_priority_compute(struct amdgpu_ring *ring,
-					       enum drm_sched_priority priority)
-{
-	struct amdgpu_device *adev = ring->adev;
-	bool acquire = priority == DRM_SCHED_PRIORITY_HIGH_HW;
-
-	if (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
-		return;
-
-	gfx_v8_0_hqd_set_priority(adev, ring, acquire);
-	gfx_v8_0_pipe_reserve_resources(adev, ring, acquire);
-}
-
 static void gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
 					     u64 addr, u64 seq,
 					     unsigned flags)
@@ -7005,7 +6907,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.test_ib = gfx_v8_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.set_priority = gfx_v8_0_ring_set_priority_compute,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ff5e913f244d..a662c4712b1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5130,105 +5130,6 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 	return wptr;
 }
 
-static void gfx_v9_0_ring_set_pipe_percent(struct amdgpu_ring *ring,
-					   bool acquire)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int pipe_num, tmp, reg;
-	int pipe_percent = acquire ? SPI_WCL_PIPE_PERCENT_GFX__VALUE_MASK : 0x1;
-
-	pipe_num = ring->me * adev->gfx.mec.num_pipe_per_mec + ring->pipe;
-
-	/* first me only has 2 entries, GFX and HP3D */
-	if (ring->me > 0)
-		pipe_num -= 2;
-
-	reg = SOC15_REG_OFFSET(GC, 0, mmSPI_WCL_PIPE_PERCENT_GFX) + pipe_num;
-	tmp = RREG32(reg);
-	tmp = REG_SET_FIELD(tmp, SPI_WCL_PIPE_PERCENT_GFX, VALUE, pipe_percent);
-	WREG32(reg, tmp);
-}
-
-static void gfx_v9_0_pipe_reserve_resources(struct amdgpu_device *adev,
-					    struct amdgpu_ring *ring,
-					    bool acquire)
-{
-	int i, pipe;
-	bool reserve;
-	struct amdgpu_ring *iring;
-
-	mutex_lock(&adev->gfx.pipe_reserve_mutex);
-	pipe = amdgpu_gfx_mec_queue_to_bit(adev, ring->me, ring->pipe, 0);
-	if (acquire)
-		set_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-	else
-		clear_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-
-	if (!bitmap_weight(adev->gfx.pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES)) {
-		/* Clear all reservations - everyone reacquires all resources */
-		for (i = 0; i < adev->gfx.num_gfx_rings; ++i)
-			gfx_v9_0_ring_set_pipe_percent(&adev->gfx.gfx_ring[i],
-						       true);
-
-		for (i = 0; i < adev->gfx.num_compute_rings; ++i)
-			gfx_v9_0_ring_set_pipe_percent(&adev->gfx.compute_ring[i],
-						       true);
-	} else {
-		/* Lower all pipes without a current reservation */
-		for (i = 0; i < adev->gfx.num_gfx_rings; ++i) {
-			iring = &adev->gfx.gfx_ring[i];
-			pipe = amdgpu_gfx_mec_queue_to_bit(adev,
-							   iring->me,
-							   iring->pipe,
-							   0);
-			reserve = test_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-			gfx_v9_0_ring_set_pipe_percent(iring, reserve);
-		}
-
-		for (i = 0; i < adev->gfx.num_compute_rings; ++i) {
-			iring = &adev->gfx.compute_ring[i];
-			pipe = amdgpu_gfx_mec_queue_to_bit(adev,
-							   iring->me,
-							   iring->pipe,
-							   0);
-			reserve = test_bit(pipe, adev->gfx.pipe_reserve_bitmap);
-			gfx_v9_0_ring_set_pipe_percent(iring, reserve);
-		}
-	}
-
-	mutex_unlock(&adev->gfx.pipe_reserve_mutex);
-}
-
-static void gfx_v9_0_hqd_set_priority(struct amdgpu_device *adev,
-				      struct amdgpu_ring *ring,
-				      bool acquire)
-{
-	uint32_t pipe_priority = acquire ? 0x2 : 0x0;
-	uint32_t queue_priority = acquire ? 0xf : 0x0;
-
-	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PIPE_PRIORITY, pipe_priority);
-	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_QUEUE_PRIORITY, queue_priority);
-
-	soc15_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-}
-
-static void gfx_v9_0_ring_set_priority_compute(struct amdgpu_ring *ring,
-					       enum drm_sched_priority priority)
-{
-	struct amdgpu_device *adev = ring->adev;
-	bool acquire = priority == DRM_SCHED_PRIORITY_HIGH_HW;
-
-	if (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
-		return;
-
-	gfx_v9_0_hqd_set_priority(adev, ring, acquire);
-	gfx_v9_0_pipe_reserve_resources(adev, ring, acquire);
-}
-
 static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6599,7 +6500,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.test_ib = gfx_v9_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.set_priority = gfx_v9_0_ring_set_priority_compute,
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

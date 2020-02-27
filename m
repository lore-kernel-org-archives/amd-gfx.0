Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A487C3F2C2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEE724690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chd3fQYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEE724690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DE06ED5D;
	Thu, 27 Feb 2020 21:37:19 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C85B6ED59
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:37:17 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t23so1087041wmi.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wODm3MWzymNg0pOi8E+UQtBJDdParD+zhlvYN51BQ1M=;
 b=Chd3fQYDSuUfXIRkQ7DxFZsdAbMdqCW5yo6N9Tm48yjDVu9xgokgf+gIsltobFvt4N
 M+vmzrxWIoqk4Y/WTicZ6AD+MRC6U+pUflReEioMzfxOcdYzPkiDzC4bnZYqXqo9wNvh
 7aXU7qtJJ772kkhBY+2nEBpI7Gwp4DYH8Bj+S1HGKlQs19n4Wko/oxhepTyBv7XDZREN
 g9gTuqlckbUZZERvo1ocsk6DQ98RWZKks+gGmtE/D2cd3k3U0jvbL/VGBNY+ci0QLslr
 CUrHM6CWUiaVigcu+z1xKWsNYk50OsDTLKzKffE5zOTvB2yDmSR4v2Ll+dSaKnAVVaab
 Z1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wODm3MWzymNg0pOi8E+UQtBJDdParD+zhlvYN51BQ1M=;
 b=p7dPyLlmzQnF3Pht+P9q6z8kAi5esjXzpiHqsTPQjk7tEASkHyUN9ap1EuuI0pNPQO
 o3njBdRNLYjRj79RhJZ3dK+IwGwLMX4tcP7DAxodvu8xYOQpxVLjaCd4kz/gw/lfBQuw
 iHqdkHH1AycXNCu8TlsPxamCHiXuv5g39KnmrBndmaj02vtxGExALB1+JS+5FN928rji
 aCmhNZjOuPg7bEBsG0dX2Gu6LnoR4Pf70/dkGCyQ7iKJDYPNgym52HL4Z97X9DdWWDl+
 C5P+F2Z7PlnpdZUQjuPPUlAIHJvgtL5FF64QDBET8DiG9bJaR5mFOI9WSjmaccVKT8E+
 afJQ==
X-Gm-Message-State: APjAAAUpCWmkhfF+Jgdz4rFY+5kG7G+rOOEf5jM6/rwPN7lZOkIEXw4F
 3LzIJq7vuJDayXiWDcXApCCFvFl77qu7lw==
X-Google-Smtp-Source: APXvYqz2cjTR5M8MHwaj98tGrGCkUz+lBOfulgvL3iIo/xbA6C4ul7dfraGqbgt01PNwEmbdEZj1gw==
X-Received: by 2002:a05:600c:294a:: with SMTP id
 n10mr776926wmd.11.1582839435402; 
 Thu, 27 Feb 2020 13:37:15 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2AB800008CB0F3CB6E896B.dip0.t-ipconnect.de.
 [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b])
 by smtp.gmail.com with ESMTPSA id a22sm9281341wmd.20.2020.02.27.13.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 13:37:14 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 4/4] drm/amdgpu: remove unused functions
Date: Thu, 27 Feb 2020 22:40:12 +0100
Message-Id: <20200227214012.3383-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227214012.3383-1-nirmoy.das@amd.com>
References: <20200227214012.3383-1-nirmoy.das@amd.com>
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
index 18e11b0fdc3e..4d603ee72b8c 100644
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
index 4260becd569b..3cd9e77c66eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6258,104 +6258,6 @@ static void gfx_v8_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
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
@@ -6988,7 +6890,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.test_ib = gfx_v8_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.set_priority = gfx_v8_0_ring_set_priority_compute,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 85a54849abd1..3522e170adad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5112,105 +5112,6 @@ static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
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
@@ -6581,7 +6482,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
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

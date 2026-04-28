Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6223CCFA1E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914DE10EF75;
	Wed, 29 Apr 2026 10:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="SWMyYraZ";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55BFC10E107
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 23:20:20 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-650140d4886so1414559d50.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1777418419; x=1778023219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+rH+HukFVVKTSyLtA3CLcCCBO3teYBV/5ae/ix8Fdr0=;
 b=SWMyYraZAkATDKFrE+NrQ1T7Kpf5JkfWkL+IU7a6WrfrtXNR/7wMOb5wb8QEeM/sHp
 ek+SsVeOVNAMginqToLMAOxCLobexREmXqC6cNwkvsQlgxXDNWLmuAQ2vNLTds3+14Ki
 Oky4vdFhZgLV8/q+njYNiAtmLxshll6TASasCzDrXoFERea+ds/mG9bk/y4KUXVn/P7O
 6Jg85BGNFQaoAXdusGnT9UBh4PGt80jDOCahq7yHKqz72eNeCrQyAiJxIjhRy8mxeiQl
 3L//gBFmA+AxNpskcdspwDQlYRKg0z0fH57gbO5kDn56ygoItaY6pm1Ok1/YVcm1RDuy
 yUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777418419; x=1778023219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rH+HukFVVKTSyLtA3CLcCCBO3teYBV/5ae/ix8Fdr0=;
 b=Ost2bs5QCjLN8wXR3V54gFuzGId1nUJ/ZwPwIEv+QbTU2O+SsdPt2Cn5TP6Av/2BPL
 hJxXUGB8Y0JeDOTYhP09oZ52pUL5javI6b0lMXtm1PMqTS21mpeLLO0OBlXWcyUl1PME
 +2dA6voMaQwZwkQXMZMpi21VPf2ljxRrX3+qYihloVzPm3cJplnk+1tUa3dNrngskJop
 8mHoqlnBnnuTSUZsvWQkiWbk3MsW0Pb6zq3wBuOciSeHYSJ4JVi9It+Z5AkKjaLxBQ7M
 Olc6ZY2dC4Y6XRY77HljGqN1pB1OcLpiFhgLMX6xqT7YNSLBZvSnYAxC3uqbltPzb6G1
 gYWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GYXbJlBlnxYQK/9rdvr/udVkOMPBNCojeDemUm0ZQwPfzfdjitigFHt93xes+fKR18cZRrWFc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznp42m84YIGAxfqqJn1n5TUw0am4STvIOH90nRceeQRA62bgvR
 PHhtl8nLx5wfKqjdx4ajliAJdQ33sgGCsKi62m0EQZfZpEh6LOAJQXN4XlJX9TIIJrw=
X-Gm-Gg: AeBDieseKoVdhnJikI3Whh7VJq90IEc9e1FwkgGuXlRkJzvr4pNTZRt45vXhyGEG0jD
 yCeJqZ5nRxoHyArAHq1T97Nhr68fZHO24ACiD0h0rJpxPISBXQ9VuBiN9ojFLS3G9O78aPulOf0
 zWykGnRxGCyWS/jDleaHvIUbXSRqDn1z7uTPULP542NjbtTRj4GNSf09UDfILbVnPGKbVnHLs2y
 PgN996B7L8lr+579kL9kF5YDyA6g+dqykW0/Tpn+vEGqk38CQlAK5dm6VgWgc0H2t4iwYE91no4
 Dzobo1q0SG49ngA/tZEG6DD+F+h+J9z40WXuPIJw71ibCi3I2RqeomwXbIH7higlhXsfz2LsUB2
 lPVPBOq8tXMdwrhAsjYcRXloFqJhzN81ZyIA50g1dVlOFLyobrnuJjBFkY0z3x5yTHcs9pwJJxo
 5xKwaJkJ8DGKeucEjv4bojb85GUl40Z0K6hKIWlGfrYt2uSbom+9h9Tzuo9G4=
X-Received: by 2002:a05:690c:1d:b0:7a0:5979:8d9c with SMTP id
 00721157ae682-7bceddd9463mr39695897b3.6.1777418418990; 
 Tue, 28 Apr 2026 16:20:18 -0700 (PDT)
Received: from Haru.. ([2804:1b1:f983:86f3:700:20fe:a71d:1f36])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd252a5a9esm5299417b3.14.2026.04.28.16.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:20:18 -0700 (PDT)
From: Leonardo Cesar <leonardocesar@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Leonardo Cesar <leonardocesar@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4] drm/amdgpu: deduplicate ring preempt ib function
Date: Tue, 28 Apr 2026 20:19:44 -0300
Message-ID: <20260428232009.10737-1-leonardocesar@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:25:59 +0000
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

The ring preemption function is identical for both gfx_v11_0 and
gfx_v12_0. This patch refactors the code by moving the core logic
into a generic function inside amdgpu_gfx.c to reduce code
duplication and simplify future maintenance.

Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>

---
v3 -> v4:
- Dropped 'r' variable by reordering the return logic

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 52 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +------------------------
 4 files changed, 56 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9..f7ebead09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2684,3 +2684,55 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	int i;
+
+	if (adev->enable_mes)
+		return -EINVAL;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* assert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+	/* assert IB preemption, emit the trailing fence */
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
+					ring->trail_fence_gpu_addr,
+					++ring->trail_seq);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	/* poll the trailing fence */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->trail_seq ==
+			le32_to_cpu(*(ring->trail_fence_cpu_addr)))
+			break;
+		udelay(1);
+	}
+
+	/* deassert preemption condition */
+    amdgpu_ring_set_preempt_cond_exec(ring, true);
+
+	if (i >= adev->usec_timeout) {
+		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..77050f988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -664,6 +664,8 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
+int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
+
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
 	switch (mode) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5097de940..1ba848bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6206,56 +6206,6 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 	ring->set_q_mode_offs = offs;
 }
 
-static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
-{
-	int i, r = 0;
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-
-	if (adev->enable_mes)
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	/* assert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, false);
-
-	/* assert IB preemption, emit the trailing fence */
-	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
-				   ring->trail_fence_gpu_addr,
-				   ++ring->trail_seq);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	/* poll the trailing fence */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (ring->trail_seq ==
-		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
-			break;
-		udelay(1);
-	}
-
-	if (i >= adev->usec_timeout) {
-		r = -EINVAL;
-		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
-	}
-
-	/* deassert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, true);
-	return r;
-}
-
 static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7295,7 +7245,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
 	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
 	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
-	.preempt_ib = gfx_v11_0_ring_preempt_ib,
+	.preempt_ib = amdgpu_gfx_ring_preempt_ib,
 	.emit_frame_cntl = gfx_v11_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 65c33823a..6cf244349 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4611,56 +4611,6 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 	return ret;
 }
 
-static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
-{
-	int i, r = 0;
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-
-	if (adev->enable_mes)
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	/* assert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, false);
-
-	/* assert IB preemption, emit the trailing fence */
-	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
-				   ring->trail_fence_gpu_addr,
-				   ++ring->trail_seq);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	/* poll the trailing fence */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (ring->trail_seq ==
-		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
-			break;
-		udelay(1);
-	}
-
-	if (i >= adev->usec_timeout) {
-		r = -EINVAL;
-		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
-	}
-
-	/* deassert preemption condition */
-	amdgpu_ring_set_preempt_cond_exec(ring, true);
-	return r;
-}
-
 static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				     uint32_t reg_val_offs)
 {
@@ -5539,7 +5489,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v12_0_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v12_0_ring_emit_init_cond_exec,
-	.preempt_ib = gfx_v12_0_ring_preempt_ib,
+	.preempt_ib = amdgpu_gfx_ring_preempt_ib,
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-- 
2.43.0


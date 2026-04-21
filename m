Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF8F9B5E2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF4610E981;
	Wed, 22 Apr 2026 08:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="UoD+yE3n";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74EB10E16B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 20:03:24 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12c87f1f8c8so211935c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776801804; x=1777406604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ctfYCUwnq+ND/BK2YrW6WN95Q5+5Z1z7I8KH/f9G8o4=;
 b=UoD+yE3nq0R9oZkiN9Ly2w+Kr/YhyUyIAy15h4ItRKImnW8JU7P+NqdxoQPAQiq2oS
 wPnBtWYtv4O0txogxnVZRj7pQy5wcmQTzSR3AMtTaNsdZV0Qm1IGQGnBEM6XVCjrb5qX
 856OD9rhIUblU40aRGaMbIZrfIU8+7VcmjOr6yBivGrHDXDNSmBL+nUDkKd5P0BJ0M1w
 6HksAmiOiOlbPRnQqpKlv1iNcR6AHb+RgGHxLu/6+wuAi9eZLXVfWI0QHqIhLZBlxuxY
 uHfNVp+1xIgewJnipFzWB/T2Q/2Ye8wVh6wRisOrvCdWu6+NorhMIJtfxVO312AUjCm2
 eZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776801804; x=1777406604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctfYCUwnq+ND/BK2YrW6WN95Q5+5Z1z7I8KH/f9G8o4=;
 b=ZHdiykRrqVKYZWDFS0rF9Z1fEste3bo4NIo7wugAkuL61oxtlAp7NhjaVr3UvlXRMy
 b6Isr+xc8xe2fxvjHOEuMXBfLbPoEo7Tne/42mdIvbSSQK7C47v33inTlzpYmGc1oHnd
 HgtYLZXpplpYpfZ5dwMhlULpjyp3B0inDh73buOD3sTEFve6ivMPJwRgsQULw42CAhoR
 rQ6WKG4jmetEpc2hn92yTSwMVggUwJPte90mre+5EHj3jDvG7ja4hnoqRbZjToazJMjZ
 +uFYXSD0Z0ME/bVLAhjAVWH+Vc0oxMBEDNTbpAzwB2dkhqgNYmC+FIHcMkTCYvEQq+gP
 ZAmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mJ5azIsQT9uHSEfHEEquMXsxLE4avQjoOv2eKlcitg2CWPwgPkDY99bpngThXZHvOtyChIeHi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxzyhww2GxYumEv7/bgcKeDOcrAThsm4tJUEr8fWXIqgAxzEdqw
 9IqNBPtMR2+SHGC53iRGMU0aYl8mJHHverzGJN2iArSX39M0UxaUKAcl0ugSSmNR7y0=
X-Gm-Gg: AeBDietuqoDaqeeCWOw8BYux71HD+p+KENvl/VgQffzl5rn3hKgWcxkrsm6Mx3fdsMG
 5FzeuCWC0fwqIZZdJQ0wHhY9aQSH15Vd+2XkhcmvSRTZV5sdElxEYxBGMPj3g+vEPmztFVTmu14
 MlbSfyk59QofYlsYF5TGK3YBF9QtTkGYOmf4UQPth4wmTn0YV567iqKP5VtRtpIPB5nr9ekMY3Q
 N1GPUueSAFuZARb2gK9ynTzqAriLGCf7YFBhl040gK3RSTy336peYtrqIRXOZj2d0ATC7SosL3F
 HAK56qk1/PW/iIEpg1CKSsQ2EU3rzTLag4arbqJjH+QQmmTLKS0lIart2wUcTO6tCOIETzGVVzu
 b/qBeJZnAXebjdR9q8jjY2N+YgFvImJP9FC+Zj0YFLBJPgTznpVgr7r00Ie+gzOa6+76g+pg+n8
 VPF+Q8WZ5XRsxjFwKrY5EVyt+tpZ35jFe9jitWTcoqQknoJP9fDlbJ1drHpUs=
X-Received: by 2002:a05:7022:90d:b0:12c:900b:9dee with SMTP id
 a92af1059eb24-12c900ba4bamr2072612c88.1.1776801803528; 
 Tue, 21 Apr 2026 13:03:23 -0700 (PDT)
Received: from Haru.. ([2804:1b1:f983:1702:ed2:736c:4e1d:a8a8])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c74a185a8sm20830097c88.9.2026.04.21.13.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:03:23 -0700 (PDT)
From: Leonardo Cesar <leonardocesar@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Leonardo Cesar <leonardocesar@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: deduplicate ring preempt ib function
Date: Tue, 21 Apr 2026 17:03:00 -0300
Message-ID: <20260421200311.15624-1-leonardocesar@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:27:32 +0000
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
v1 -> v2:
- Removed wrapper functions for gfx_v11 and gfx_v12 and updated call sites directly.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | ...
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 52 +------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 52 +------------------------
 4 files changed, 55 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9..a157cbd8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2684,3 +2684,54 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	int i, r = 0;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
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
+	if (i >= adev->usec_timeout) {
+		r = -EINVAL;
+		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+	}
+
+	/* deassert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
+	return r;
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


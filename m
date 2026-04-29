Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA61DCD3423
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B63FD10F26B;
	Thu, 30 Apr 2026 07:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hhC/g2v5";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73DB10E125
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 21:31:39 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-4670464029eso161022b6e.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 14:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777498298; x=1778103098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2IPgbTOPZpwRo/kCSObN2KGrGrefkasNwYZ5DgDYCDA=;
 b=hhC/g2v55b9HWahtRrsFnJYBdgqkjBT92kYq1+dk1S6gxNA10bCe4vU85zuCJyk4Dr
 Jd4aO+n1iTP0vhpEQps/P1+eJpi/itDC148lDZ7Fmfl4yQQ+0/PC8mFDKLTY61r7MViI
 5fq4c4+ttlMnwtexkqEJ54yUzgaCnLGs8AGmcKYws49ioJhRUfr6/8jcZ4Rgv17GiyEo
 drZ22A/ZLVL0tfEDqLUPyZb+vQR6LL1yi4AsZQucnJvc3NAVmMM1d25g9EiG1mQNosjM
 CbKQhYzvXlIngI5uD7R2h/2GBlnNKnys3O7RaWDeW6S11F1ZRupYoT8cFhzM+HvDcCMe
 G1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777498298; x=1778103098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IPgbTOPZpwRo/kCSObN2KGrGrefkasNwYZ5DgDYCDA=;
 b=rHIrYCrTpc9lbDc+OiAxiuuCY9yNGIjtvEYSdug7GxFlWlZijBX6L2jMYEO+U9GK+m
 QRq4ntfJrSOsrLQqfmfGdaKjuKC8UKimLWO6Fq5Fz7qklnDoob/zov7NMU1yyjq5+rpS
 EcTAX1d/sdgZzkVThTD5xLjrFBDHKMoGaM2BnnmXBJ6LZXHR7DJVcfn41k0e9r3Jrbap
 R7je52+2PJ8UEKsVH0IrGezPPojwXdJRZlRzxIfEi3fyitQ0rKSjRi0V7KbU2k/eW3js
 JxSaFC5t+JZE7295S8DPA+pLu3+QNz8Okj91JLJY6Ryrk2DSGHpW+jiuxxUvk1Gh3m0L
 HWWw==
X-Gm-Message-State: AOJu0YwoZeQXSMvUq9X4BTMYkYO/UgOSKNfvMS5pDFyomnuttpJzPPxX
 86HS2WmP/X4+mZVaWa9r+gusK+GazAJyhFm3/6zyJCJWCwSrkpUbWdM=
X-Gm-Gg: AeBDies9Mi4EXBw7lZdrwkOUyrTmZE7j+FrNWUGf3RozHMCY1EKK7lwjJpFJyQfSU84
 DUxP2bpUTOVSpGktRw4a00wib0F3Y3Chu0z1gSmTPWx5Ct646b5g/KhdrRxkJkVKTEcd05eaALY
 X4q0B7LmHqGhwpubXksSeEBNyZhyabaQOJC7Nplpe1k/+Akq92jBhcJ/mxZvPg4UgV/8g2fkg7+
 yPE6K2KAYphJ261Kl6dWv+kiwgsMKt9UePnaoRWvyqlwCMKgOZw7JkqQOJNnGR8pi3fdVtkiSTL
 3aAwNBZaKjCxqafD73EBpCTUQuDm3WXXyLIhjxyioFZAlJAMHaHN0pkWIWm0RD+7dmxnRWbwhWs
 u2oMLzqr/vQ0JM4coVayMD/AXr7MZMfDXSDGqA/kBBDy0g0JiiMkpVPYh159v2VoBfKuV4GqI67
 /2N7SJyShefB2Mw3RkjX88B/Sekv3H1nWiTSh9oyI6lDuphjbf6xVw3jq/7ac9vsCTpwp6du5Vd
 A4AMEuXVdBWgDPEes3rdh2sdEiWM7TGEzs=
X-Received: by 2002:a05:6808:2f0e:b0:479:d4b5:c1a2 with SMTP id
 5614622812f47-47c5fb7c752mr271838b6e.4.1777498298150; 
 Wed, 29 Apr 2026 14:31:38 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43e6aeb2sm1733690b6e.4.2026.04.29.14.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:31:37 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: Alexander Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	John Moore <jbmoore61@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx: extract common doorbell wptr helpers to
 amdgpu_gfx.c
Date: Wed, 29 Apr 2026 16:31:36 -0500
Message-ID: <20260429213136.21274-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:38:12 +0000
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

From: John Moore <jbmoore61@gmail.com>

The get_wptr and set_wptr implementations for doorbell-based compute
rings are duplicated identically across gfx_v9_0, gfx_v10_0,
gfx_v11_0, gfx_v12_0, and gfx_v12_1.  Extract them into common
helpers amdgpu_gfx_get_wptr_doorbell() and
amdgpu_gfx_set_wptr_doorbell() in amdgpu_gfx.c.

The helpers are named _doorbell rather than _compute because
there is nothing compute-specific about the implementation --
they read/write the wptr via the doorbell-mapped writeback
address.

Also replaces BUG() in the non-doorbell fallback path with
WARN_ON_ONCE(), since crashing the kernel is not an appropriate
response to a programming error.

gfx_v9_4_3 is intentionally left unconverted because it uses a
different memory access pattern (wb.wb[wptr_offs] instead of
wptr_cpu_addr).

Signed-off-by: John Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 32 +++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 33 +++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 33 +++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 33 +++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 32 +++-----------------
 7 files changed, 62 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca87669..a4ffb8156 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2686,3 +2686,42 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+/**
+ * amdgpu_gfx_get_wptr_doorbell - common get_wptr for rings using doorbells
+ * @ring: amdgpu_ring pointer
+ *
+ * Read the write pointer from the doorbell-mapped writeback address.
+ * This is HW-agnostic and shared across GFX generations that use
+ * doorbell-based queue management.
+ */
+u64 amdgpu_gfx_get_wptr_doorbell(struct amdgpu_ring *ring)
+{
+	/* XXX check if swapping is necessary on BE */
+	if (ring->use_doorbell)
+		return atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+/**
+ * amdgpu_gfx_set_wptr_doorbell - common set_wptr for rings using doorbells
+ * @ring: amdgpu_ring pointer
+ *
+ * Write the write pointer to the doorbell-mapped writeback address and
+ * ring the doorbell.  This is HW-agnostic and shared across GFX
+ * generations that use doorbell-based queue management.
+ */
+void amdgpu_gfx_set_wptr_doorbell(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* XXX check if swapping is necessary on BE */
+	if (ring->use_doorbell) {
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
+		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	} else {
+		WARN_ON_ONCE(1);
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b4..64578241c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -661,6 +661,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
 u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, u32 count);
 void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
 
+u64 amdgpu_gfx_get_wptr_doorbell(struct amdgpu_ring *ring);
+void amdgpu_gfx_set_wptr_doorbell(struct amdgpu_ring *ring);
+
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 58c69dcb5..070b89179 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8591,30 +8591,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 	return *(uint32_t *)ring->rptr_cpu_addr;
 }
 
-static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
-{
-	u64 wptr;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
-	return wptr;
-}
-
-static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else {
-		BUG(); /* only DOORBELL method supported on gfx10 now */
-	}
-}
 
 static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
@@ -9886,8 +9862,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		20 + /* gfx_v10_0_ring_emit_gds_switch */
 		7 + /* gfx_v10_0_ring_emit_hdp_flush */
@@ -9926,8 +9902,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		20 + /* gfx_v10_0_ring_emit_gds_switch */
 		7 + /* gfx_v10_0_ring_emit_hdp_flush */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c6f1e25c..8aa425b15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5891,31 +5891,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 	return *(uint32_t *)ring->rptr_cpu_addr;
 }
 
-static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
-{
-	u64 wptr;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
-	return wptr;
-}
-
-static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else {
-		BUG(); /* only DOORBELL method supported on gfx11 now */
-	}
-}
 
 static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
@@ -7331,8 +7306,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		5 + /* update_spm_vmid */
 		20 + /* gfx_v11_0_ring_emit_gds_switch */
@@ -7372,8 +7347,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		20 + /* gfx_v11_0_ring_emit_gds_switch */
 		7 + /* gfx_v11_0_ring_emit_hdp_flush */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6baac533a..7e1ec4e3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4401,31 +4401,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 	return *(uint32_t *)ring->rptr_cpu_addr;
 }
 
-static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
-{
-	u64 wptr;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
-	return wptr;
-}
-
-static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else {
-		BUG(); /* only DOORBELL method supported on gfx12 now */
-	}
-}
 
 static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
@@ -5553,8 +5528,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v12_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		7 + /* gfx_v12_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
@@ -5591,8 +5566,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v12_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		7 + /* gfx_v12_0_ring_emit_hdp_flush */
 		5 + /*hdp invalidate */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 033f15e21..47fae6c33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3368,31 +3368,6 @@ static u64 gfx_v12_1_ring_get_rptr_compute(struct amdgpu_ring *ring)
 	return *(uint32_t *)ring->rptr_cpu_addr;
 }
 
-static u64 gfx_v12_1_ring_get_wptr_compute(struct amdgpu_ring *ring)
-{
-	u64 wptr;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
-	return wptr;
-}
-
-static void gfx_v12_1_ring_set_wptr_compute(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else {
-		BUG(); /* only DOORBELL method supported on gfx12 now */
-	}
-}
 
 static void gfx_v12_1_ring_emit_ib_compute(struct amdgpu_ring *ring,
 					   struct amdgpu_job *job,
@@ -3896,8 +3871,8 @@ static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v12_1_ring_get_rptr_compute,
-	.get_wptr = gfx_v12_1_ring_get_wptr_compute,
-	.set_wptr = gfx_v12_1_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		7 + /* gfx_v12_1_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
@@ -3926,8 +3901,8 @@ static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v12_1_ring_get_rptr_compute,
-	.get_wptr = gfx_v12_1_ring_get_wptr_compute,
-	.set_wptr = gfx_v12_1_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		7 + /* gfx_v12_1_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2eb32f92a..657aff0b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5634,30 +5634,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 	return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
 }
 
-static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
-{
-	u64 wptr;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
-	return wptr;
-}
-
-static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
-		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else{
-		BUG(); /* only DOORBELL method supported on gfx9 now */
-	}
-}
 
 static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 					 u64 seq, unsigned int flags)
@@ -7614,8 +7590,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
@@ -7656,8 +7632,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_doorbell,
+	.set_wptr = amdgpu_gfx_set_wptr_doorbell,
 	.emit_frame_size =
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
-- 
2.43.0


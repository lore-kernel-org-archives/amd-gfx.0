Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92376CD13DA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F0410F25C;
	Thu, 30 Apr 2026 07:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NqMn4T3n";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F017C10E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:25:20 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7dcdca9aa0bso984084a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777494320; x=1778099120; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yqdk1NEyBCeP/PcYVGyqaha34rUdTHZrUuqNel/MUXE=;
 b=NqMn4T3n7s92ren4uY1aNg54fLhDSCkHmsEgAFej5v/TiS4/4sSRUXV97q3NPT5V11
 zS7qY394WUrRxUHgbFXUqY5AoK7Pda7Bo7mah2wezbkdka/937juacJnhRJ9WcOzYvtL
 8q9mC3fHNRyhBTWeWIk2haVwmqtVVsuiIMWr2qJDx0fVRWwN6Ek1r/zSlwOZlr9XlQuJ
 awsFyVUcigYnvN4C75E2JvkvDV/Q+kPCyQYXAJEJH7QFriubiwXwCfmqzYVx/TH3bGQ0
 yYdJMDFTrLsliEUgN8mQAxsuphdWx1O1I9CXpOgWJ7sgz43NH7M6i/Hj4a3rJcXQuti/
 XtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777494320; x=1778099120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yqdk1NEyBCeP/PcYVGyqaha34rUdTHZrUuqNel/MUXE=;
 b=KJ28WuqsiFR3c1wV5H2vndRtmnPX4itNkveyLhGz5NzEwhujKQkv2fq9QWYFkC35f3
 Tg3iMrEus6G+Op/Vii/tWJPFJQjV7ET9vNwI0OEfOaYJ5jMZ1t/u1ZCOR490pl2JhPUj
 byqNj89gzJy6IB8uLKJ3bKJLT87EsHtBAxQnHsm0wi9q0/b7VmzpYnu6YoHpHjLRrtCN
 rn3sA+wPhv31eXp6b8qxy9SwRCGylNY6y+7r9EF2p769bFmacDK7fZdADXjYTvl+NISk
 COKPQxslyJTWPDyJpu4Cdc6rUcQtvV3mL0jDjv2dqduNcqNHHFwgdBhV12xAc7KDh8M7
 S11w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5zQKsv/wjR/e/LFCEw1ghbnd5sTRQ9HcOeM38WLD2P/yGSKH2RCOFW1FzRdeAR35dL3hxcZjs@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7ae3PCfIZcIQSYOgc+pazV5XAhdvXCN25fEmUoHqu39pEg9os
 uaaaaLwzv/0zNHAWUVucKJ3LZoBLoEe5iUTMBH4CY+ubamZVMkKtZew=
X-Gm-Gg: AeBDievjR0KYZOdB91K3h9praSvjLLGPKO2Tq5JNiJApHqgTDWMvQoY5W41OpqZKIcb
 eCKmHGW18NE1tFDcyRHl5KRsAKo3UkYQRzX7d6er7iGLLPE4qE1230xGiVGNO6eZn2SDKo9QlGi
 10bVG3qO2TMeR++/Ffm/p679NkvfTbuBMQhOsdFEki1s4EwibTpmqWG6D/i3Ti/Locw+uPIipWT
 vz1RMH+w8m7MeRYSJIt9ncs/dNpk5Z4czF8Z0hwVSCP0E1AuU4voznk/8/5b8ZLLQKjUXaVw2+n
 psUEbH85WRhafBtiZRyhV5zfwzBGjUcCNUkBVLTLqGfIrOKK+R3jcz0SIOO2WwY8GB8EY81Qv2W
 9vGK8KBvvynSH2vYQY5VA0OOcz4Hx8H/zwOJwkGJdhjEdoKOoRiPu1NWg2DnAFnz7LczPb4D0Vp
 +4QcQ80z15Hhzz57l9fYPBDqZOHLF0OrdcM2Mq3lnBzKp00MxdLDvH+64UbFfMvCISaCUPHEtk7
 VKEEUh2Ey65Z/5GyXVcvx4aY0gOrQvjpns=
X-Received: by 2002:a05:6820:4dfb:b0:696:1b32:f14 with SMTP id
 006d021491bc7-696699b7086mr1961693eaf.14.1777494319728; 
 Wed, 29 Apr 2026 13:25:19 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966bb9bfa2sm1755716eaf.2.2026.04.29.13.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 13:25:19 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexdeucher@gmail.com
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, "John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
Date: Wed, 29 Apr 2026 15:25:18 -0500
Message-ID: <20260429202518.21956-1-jbmoore61@gmail.com>
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

Move the duplicated doorbell-based get_wptr/set_wptr functions from
gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common
helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_compute()
in amdgpu_gfx.c.

These functions are not HW generation dependent -- the doorbell path is
identical across all four GFX versions:

  get: atomic64_read(ring->wptr_cpu_addr)
  set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()

The non-doorbell fallback is replaced with WARN_ON_ONCE instead of BUG()
since doorbell is the only supported method on gfx9+ compute rings.

Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have different
wptr access patterns (MMIO registers or wb.wb[] offsets).

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: John Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34 +++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34 +++------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +++----------------------
 6 files changed, 58 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 77578ecc6..9e9c5cb81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2596,3 +2596,42 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+/**
+ * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rings using doorbells
+ * @ring: amdgpu_ring pointer
+ *
+ * Read the write pointer from the doorbell-mapped writeback address.
+ * This is HW-agnostic and shared across GFX generations that use
+ * doorbell-based compute queue management.
+ */
+u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)
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
+ * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rings using doorbells
+ * @ring: amdgpu_ring pointer
+ *
+ * Write the write pointer to the doorbell-mapped writeback address and
+ * ring the doorbell.  This is HW-agnostic and shared across GFX
+ * generations that use doorbell-based compute queue management.
+ */
+void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)
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
index 585cc8e81..27f6beafb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
 u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, u32 count);
 void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
 
+u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
+void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
+
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1893ceeeb..4c0272cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
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
-
 static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		20 + /* gfx_v10_0_ring_emit_gds_switch */
 		7 + /* gfx_v10_0_ring_emit_hdp_flush */
@@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		20 + /* gfx_v10_0_ring_emit_gds_switch */
 		7 + /* gfx_v10_0_ring_emit_hdp_flush */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 427975b5a..404604f2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
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
-
 static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		5 + /* update_spm_vmid */
 		20 + /* gfx_v11_0_ring_emit_gds_switch */
@@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		20 + /* gfx_v11_0_ring_emit_gds_switch */
 		7 + /* gfx_v11_0_ring_emit_hdp_flush */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 79ea1af36..7ba436444 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
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
-
 static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v12_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		7 + /* gfx_v12_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
@@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v12_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		7 + /* gfx_v12_0_ring_emit_hdp_flush */
 		5 + /*hdp invalidate */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8249135d7..798f94bca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 	return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
 }
 
-static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
-{
-	u64 wptr;
-
-	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell) {
-		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	} else {
-		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s, "
-			  "only doorbell method supported on gfx9\n",
-			  ring->name);
-		wptr = 0;
-	}
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
-	} else {
-		WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %s, "
-			  "only doorbell method supported on gfx9\n",
-			  ring->name);
-	}
-}
-
 static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 					 u64 seq, unsigned int flags)
 {
@@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
@@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
-	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
-	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
+	.get_wptr = amdgpu_gfx_get_wptr_compute,
+	.set_wptr = amdgpu_gfx_set_wptr_compute,
 	.emit_frame_size =
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
-- 
2.43.0


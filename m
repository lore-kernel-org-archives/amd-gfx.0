Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E744E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED1A10E3A7;
	Fri, 27 Dec 2024 11:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ggHiYoqJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A4710E3A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yPSJ2qf/Z60YU4N5eQg4ffSv4cjl61IHHBuR5RPAZSQ=; b=ggHiYoqJJ7wfLAh5izUm1OdOQw
 82shu5Y3urGb15KxrJT5orp/C7FMks04F0ih/MlYu+tv+q/zf3ur9sJCdg5pTtmJu7U9vi375d/Dq
 OiAq7cCAsxWAqU2LMV0grqbNMMGqU3u0dMHzZMA5ckYN/s0O2Qb8nnGrnMr7v5mIGnbu493cPACAC
 SyHOGT6u4/4KWxaOLtmEaENZFlmfddY/NNXnlWrL0rOH9Yw9JQC3pJStjRxvZNSGvm0DTpPEQCVYt
 8kqevqthRnObjsAPuq4UmJMpvpHEgWWZZUBivB1Qk51yo0c2sHh+8I+SooVExWgUf4tFpGl4QdJfJ
 sr2O5G9g==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nm-008EGv-KE; Fri, 27 Dec 2024 12:19:54 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 07/12] drm/amdgpu: Convert JPEG,
 VCE and UVD to more efficient ring padding
Date: Fri, 27 Dec 2024 11:19:33 +0000
Message-ID: <20241227111938.22974-8-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227111938.22974-1-tursulin@igalia.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Similarly as in the previous patch, but now we add a new
amdgpu_ring_fill2x32() helper which can write out the nops more
efficiently using memset64().

This should have a lesser effect than the previous patch, given how the
affected rings have at most 64 dword alignment restriction (in contrast to
many with 256 with GFX). Nevertheless, it sounds plausible to utilise the
identical approach and still achieve that little bit more efficiency.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  8 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  8 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  8 ++---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  7 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  7 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  7 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  7 +---
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  9 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  8 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  7 ++--
 11 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 0a59738fa1d4..158238f8c06a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -441,6 +441,47 @@ static inline void amdgpu_ring_fill(struct amdgpu_ring *ring,
 	ring->count_dw -= count;
 }
 
+static inline void amdgpu_ring_fill2x32(struct amdgpu_ring *ring,
+					u32 v1, u32 v2, u32 count)
+{
+	const u32 buf_mask = ring->buf_mask;
+	u32 occupied, chunk1, chunk2;
+	u64 wptr = ring->wptr;
+	u64 v;
+
+	if (count == 0)
+		return;
+
+	occupied = wptr & buf_mask;
+	chunk1 = buf_mask + 1 - occupied;
+	count *= 2; /* To dwords */
+	chunk1 = (chunk1 >= count) ? count : chunk1;
+	chunk2 = count - chunk1;
+
+	if (WARN_ON_ONCE((chunk1 | chunk2) & 1))
+		return;
+
+	/* To qwords */
+	chunk1 >>= 1;
+	chunk2 >>= 1;
+
+#ifdef __BIG_ENDIAN
+	v = (u64)v1 << 32 | v2;
+#else
+	v = (u64)v2 << 32 | v1;
+#endif
+
+	if (chunk1)
+		memset64((u64 *)&ring->ring[occupied], v, chunk1);
+
+	if (chunk2)
+		memset64((u64 *)&ring->ring[0], v, chunk2);
+
+	wptr += count;
+	ring->wptr = wptr & ring->ptr_mask;
+	ring->count_dw -= count;
+}
+
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 03b8b7cd5229..1c4ec0330391 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -418,14 +418,10 @@ static void jpeg_v1_0_decode_ring_emit_wreg(struct amdgpu_ring *ring,
 
 static void jpeg_v1_0_decode_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6), 0,
+			     count / 2);
 }
 
 static int jpeg_v1_0_set_interrupt_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 7c9251c03815..4b39898aacc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -645,14 +645,10 @@ void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32
 
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6), 0,
+			     count / 2);
 }
 
 static bool jpeg_v2_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 88f9771c1686..5e503a5c1926 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -897,14 +897,10 @@ void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint
 
 void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6), 0,
+			     count / 2);
 }
 
 static bool jpeg_v4_0_3_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5830e799c0a3..4faf8ca2773d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -166,14 +166,9 @@ static int uvd_v3_1_ring_test_ring(struct amdgpu_ring *ring)
 
 static void uvd_v3_1_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(mmUVD_NO_OP, 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKET0(mmUVD_NO_OP, 0), 0, count / 2);
 }
 
 static const struct amdgpu_ring_funcs uvd_v3_1_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index f93079e09215..05ac019e00b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -553,14 +553,9 @@ static void uvd_v4_2_ring_emit_ib(struct amdgpu_ring *ring,
 
 static void uvd_v4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(mmUVD_NO_OP, 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKET0(mmUVD_NO_OP, 0), 0, count / 2);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 050a0f309390..dde0d7d508ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -570,14 +570,9 @@ static void uvd_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
 
 static void uvd_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(mmUVD_NO_OP, 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKET0(mmUVD_NO_OP, 0), 0, count / 2);
 }
 
 static bool uvd_v5_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index d9d036ee51fb..095e71d509dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1106,14 +1106,9 @@ static void uvd_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 
 static void uvd_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(mmUVD_NO_OP, 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKET0(mmUVD_NO_OP, 0), 0, count / 2);
 }
 
 static void uvd_v6_0_enc_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 9d237b5937fb..31005dbde8a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1416,14 +1416,13 @@ static void uvd_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 static void uvd_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i;
 
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(SOC15_REG_OFFSET(UVD, ring->me, mmUVD_NO_OP), 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring,
+			   PACKET0(SOC15_REG_OFFSET(UVD, ring->me, mmUVD_NO_OP), 0),
+			   0,
+			   count / 2);
 }
 
 static void uvd_v7_0_enc_ring_insert_end(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 5ea96c983517..2f848f302069 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1790,14 +1790,12 @@ static int vcn_v1_0_process_interrupt(struct amdgpu_device *adev,
 static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i;
 
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP), 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring,
+			   PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP), 0), 0,
+			   count / 2);
 }
 
 static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e42cfc731ad8..9d24ba173f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1453,14 +1453,11 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
 void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i;
 
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.nop, 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill2x32(ring, PACKET0(adev->vcn.internal.nop, 0), 0,
+			     count / 2);
 }
 
 /**
-- 
2.47.1


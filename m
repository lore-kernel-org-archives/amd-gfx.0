Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD69CEFC21
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9CF10E576;
	Tue,  8 Oct 2024 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hj4pt3Xy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D64610E578
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NVkXoKmo5t+vruYeze4LW0Ty3CJu4alt92RISTkBBU4=; b=hj4pt3XynzLwRmxk3/puWYqIiQ
 89EmVKG0HSGKfa2LajpN/wCXfee8riMzsK+gZHnD04+758SkHkU9OKpgWADVNFk3yuH7PMAVx7z+F
 Csr7TTOD20RlhPNy2cYqAao/vFl69BBQt0y1iqwAQRQ+xDsrjFCHI6WST65Jy382x+NTFjV3n3mLW
 kfGLUACCA7zlzvRqn6kECxpNcacw/6URwU06nhgzZPe7gsP7hM9H7zHj9wLJskO99rYuWHLwd2qdE
 cOcGV1CzFe/1cIxPdcbvMtWkgTF5u0NXN9KVi4a1pxBn8ddQ8oddnKhIH8QRNKHk2jc6kJdmAxUZK
 alhteESw==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1syBmV-006bku-Pn; Tue, 08 Oct 2024 17:05:47 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: More more efficient ring padding
Date: Tue,  8 Oct 2024 16:05:30 +0100
Message-ID: <20241008150532.23661-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008150532.23661-1-tursulin@igalia.com>
References: <20241008150532.23661-1-tursulin@igalia.com>
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

Similarly as in the previous patch, we add a new amdgpu_ring_fill2x32()
helper which can write out the nops more efficiently using memset64().

This should have a lesser effect than the previous patch, given how the
affected rings have at most 64 dword alignment restriction, in contrast to
many with 256 dwords back there. Nevertheless, it sounds plausible to
utilise the identical approach and still achieve that little bit more
efficiency.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 39 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  8 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  8 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  8 ++---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  7 +----
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  7 +----
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  7 +----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  7 +----
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  9 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  8 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  7 ++---
 11 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 36c4bae448e0..91ab32157210 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -442,6 +442,45 @@ static inline void amdgpu_ring_fill(struct amdgpu_ring *ring, u32 v,
 	ring->count_dw -= count_dw;
 }
 
+static inline void amdgpu_ring_fill2x32(struct amdgpu_ring *ring,
+					u32 v1, u32 v2,
+					unsigned int count_qw)
+{
+	unsigned int occupied, chunk1, chunk2;
+	unsigned int count_dw = count_qw * 2;
+	u64 v;
+
+	if (unlikely(ring->count_dw < count_dw))
+		DRM_ERROR("amdgpu: writing more qwords to the ring than expected!\n");
+
+	occupied = ring->wptr & ring->buf_mask;
+	chunk1 = ring->buf_mask + 1 - occupied;
+	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
+	chunk2 = count_dw - chunk1;
+
+	if (WARN_ON_ONCE((chunk1 | chunk2) & 1))
+		return;
+
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
+	ring->wptr += count_dw;
+	ring->wptr &= ring->ptr_mask;
+	ring->count_dw -= count_dw;
+}
+
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 6e0e88076224..eba118563acd 100644
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
index 41c0f8750dc1..3ae3dabb73a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -647,14 +647,10 @@ void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32
 
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
index 86958cb2c2ab..366d71aa54b5 100644
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
index 805d6662c88b..b8460389fbde 100644
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
index 3f19c606f4de..fa8b2a9f41b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -554,14 +554,9 @@ static void uvd_v4_2_ring_emit_ib(struct amdgpu_ring *ring,
 
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
index efd903c21d48..af97c6b5b479 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -571,14 +571,9 @@ static void uvd_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
 
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
index 495de5068455..3551cdbe5393 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -1107,14 +1107,9 @@ static void uvd_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 
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
index 6068b784dc69..76e6f02e7de6 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1417,14 +1417,13 @@ static void uvd_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
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
index ecdfbfefd66a..1d79ed275df3 100644
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
 
 static int vcn_v1_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index bfd067e2d2f1..9ff879b56c12 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1455,14 +1455,11 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
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
2.46.0


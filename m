Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9E0C3DA4D
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 15:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E525D10ED35;
	Fri, 12 Jul 2024 15:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nvsa5Du1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5250F10ED2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uv7AKZndORsemcXIKjb//TVHA78+MFLk32FlGPj8GB8=; b=nvsa5Du1iyoaR5tv6QDwlJOMwF
 gVR3H7YIiQXZSmmuMWhUds58twtYV0mLbZXguDvyLScqDv8NQGTQGJlPVOxvJw7Qr8yiHK+cJ5OEr
 Pu0Yss/JnWQ0bYNK92sVEVklcL1gJwFg6XKv+L0Sm/ZXpUppbYsKfDkwEwSgjtZevTOR6aJ6v+Qmj
 n5S8mlliV83D9ZOtWSu19UCUly3k6TQBkZussvrDfPAYX9Uzw7/LzrZzBcPRBxFvXVZPGBnGWPy6T
 rOgWj9B2CwrVmyCztF45Xo3cLNOnoQLIJcPQsQsRvSDq3bxdhdWHVR6Wgu6675YNR0/Y0PcJMzyp7
 ayN4s7Yg==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sSICh-00ENJ2-JI; Fri, 12 Jul 2024 17:28:59 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 3/3] drm/amdpug: More more efficient ring padding
Date: Fri, 12 Jul 2024 16:28:55 +0100
Message-ID: <20240712152855.45284-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240712152855.45284-1-tursulin@igalia.com>
References: <20240712152855.45284-1-tursulin@igalia.com>
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

Similarly as in the previous patch, we add a new amdgpu_ring_fill64()
helper which can write out the nops more efficiently using memset64().

This should have a lesser effect than the previous patch, given how the
affected rings have at most 64 dword alignment restriction, in contrast to
many with 256 dwords back there. Nevertheless, it sounds plausible to
utilise the identical approach and still achieve that little bit more
efficiency.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 31 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  7 +-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  7 +-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  7 +-----
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  7 +-----
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  7 +-----
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  7 +-----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  7 +-----
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  8 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  8 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  6 +----
 11 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 2264d7502eb6..4757bc56df0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -439,6 +439,37 @@ static inline void amdgpu_ring_fill(struct amdgpu_ring *ring, u32 v,
 	ring->count_dw -= count_dw;
 }
 
+static inline void amdgpu_ring_fill64(struct amdgpu_ring *ring, u64 v,
+				      unsigned int count_qw)
+{
+	unsigned int occupied, chunk1, chunk2;
+	unsigned int count_dw = count_qw * 2;
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
index 71f43a5c7f72..9aba7002cac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -411,14 +411,9 @@ static void jpeg_v1_0_decode_ring_emit_wreg(struct amdgpu_ring *ring,
 
 static void jpeg_v1_0_decode_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill64(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6), count / 2);
 }
 
 static int jpeg_v1_0_set_interrupt_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 99adf3625657..83a10968a4a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -642,14 +642,9 @@ void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32
 
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill64(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6), count / 2);
 }
 
 static bool jpeg_v2_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 04d8966423de..62e19b1c918b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -876,14 +876,9 @@ void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint
 
 void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
-
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill64(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6), count / 2);
 }
 
 static bool jpeg_v4_0_3_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 805d6662c88b..8e3ac9aa9209 100644
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
+	amdgpu_ring_fill64(ring, PACKET0(mmUVD_NO_OP, 0), count / 2);
 }
 
 static const struct amdgpu_ring_funcs uvd_v3_1_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 3f19c606f4de..cbd495a92afe 100644
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
+	amdgpu_ring_fill64(ring, PACKET0(mmUVD_NO_OP, 0), count / 2);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index efd903c21d48..18ce4cece85e 100644
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
+	amdgpu_ring_fill64(ring, PACKET0(mmUVD_NO_OP, 0), count / 2);
 }
 
 static bool uvd_v5_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 495de5068455..a65696b58488 100644
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
+	amdgpu_ring_fill64(ring, PACKET0(mmUVD_NO_OP, 0), count / 2);
 }
 
 static void uvd_v6_0_enc_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 6068b784dc69..75a3a4a38a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1417,14 +1417,12 @@ static void uvd_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 static void uvd_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i;
 
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(SOC15_REG_OFFSET(UVD, ring->me, mmUVD_NO_OP), 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill64(ring,
+			   PACKET0(SOC15_REG_OFFSET(UVD, ring->me, mmUVD_NO_OP), 0),
+			   count / 2);
 }
 
 static void uvd_v7_0_enc_ring_insert_end(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index a280b9fecb77..f0ba65639e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1742,14 +1742,12 @@ static int vcn_v1_0_process_interrupt(struct amdgpu_device *adev,
 static void vcn_v1_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i;
 
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP), 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill64(ring,
+			   PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP), 0),
+			   count / 2);
 }
 
 static int vcn_v1_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d3d096909a7f..f5af5ceecc50 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1406,14 +1406,10 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
 void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i;
 
 	WARN_ON(ring->wptr % 2 || count % 2);
 
-	for (i = 0; i < count / 2; i++) {
-		amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.nop, 0));
-		amdgpu_ring_write(ring, 0);
-	}
+	amdgpu_ring_fill64(ring, PACKET0(adev->vcn.internal.nop, 0), count / 2);
 }
 
 /**
-- 
2.44.0


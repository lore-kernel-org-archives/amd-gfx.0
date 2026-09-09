Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C11C79FAD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 10:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7662710F0AE;
	Wed,  9 Sep 2026 10:52:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Z37dXjy0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6BF10EE4D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=AuioiJl0Of24XkDEBk6Tdc9TYLPWcW2vG9nRY31btlI=; b=Z37dXjy0I2pZvO4bqMt5yZlx94
 R0Uujg06MV6+0CiuxWdxMTKDdBAryugJjd+DTUP+Vtp9jx75nAxFVMjfPRXko2rtzQFbUNFnF+HWf
 W/WM4FfBCVD7diTc2oJkiXAJVi+JPnqd/FnGJg4EOQ76lj2AyJ/DvVDc2vKWxGo7/hzixb0uMLfA9
 JWJiaWCedlh1FvODV8E8qDdbvFhDO/JOgBoI80JNJprYgRSLbuZGLpWiH2SbreHS1PE/69wK05RTl
 Czke5iBx8R4ZZ7JLF2bAeUHp1/H/KA4KbaGAc+M+XXT3t6JUIjwZUxkFk4kjEIkZUbsI/jr/SMa0A
 fFITovZw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x4Fui-00GykW-9d; Wed, 09 Sep 2026 12:52:24 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/6] drm/amdgpu: Use memset32 for SDMA padding
Date: Wed,  9 Sep 2026 11:52:15 +0100
Message-ID: <20260909105215.88242-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
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

Instead of open coding it via the inefficient amdgpu_ring_write(), which
which the compiler is not able to optimise much, we can add a new
amdgpu_ring_fill() helper which pads using memset32.

We convert the amdgpu_ring_insert_nop() used by the GFX rings and also
the SDMA ones. Although with SDMA this should have much less benefit than
with GFX (only SDMA v4.0 uses the 256 byte ring padding while the rest use
16), but on the other hand it should not harm and is at least more
consistent.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 17 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 26 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 15 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 15 +++++++-------
 11 files changed, 90 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 686c92e96025..38434a4c3566 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -117,22 +117,7 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
  */
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	uint32_t occupied, chunk1, chunk2;
-
-	occupied = ring->wptr & ring->buf_mask;
-	chunk1 = ring->buf_mask + 1 - occupied;
-	chunk1 = (chunk1 >= count) ? count : chunk1;
-	chunk2 = count - chunk1;
-
-	if (chunk1)
-		memset32(&ring->ring[occupied], ring->funcs->nop, chunk1);
-
-	if (chunk2)
-		memset32(ring->ring, ring->funcs->nop, chunk2);
-
-	ring->wptr += count;
-	ring->wptr &= ring->ptr_mask;
-	ring->count_dw -= count;
+	amdgpu_ring_fill(ring, ring->funcs->nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 6b6ee4083c8d..2b1d3956cdd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -522,6 +522,32 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+static inline void amdgpu_ring_fill(struct amdgpu_ring *ring,
+				    u32 val, u32 count)
+{
+	const u32 buf_mask = ring->buf_mask;
+	u32 occupied, chunk1, chunk2;
+	u64 wptr = ring->wptr;
+
+	if (count == 0)
+		return;
+
+	occupied = wptr & buf_mask;
+	chunk1 = buf_mask + 1 - occupied;
+	chunk1 = (chunk1 >= count) ? count : chunk1;
+	chunk2 = count - chunk1;
+
+	if (chunk1)
+		memset32(&ring->ring[occupied], val, chunk1);
+
+	if (chunk2)
+		memset32(ring->ring, val, chunk2);
+
+	wptr += count;
+	ring->wptr = wptr & ring->ptr_mask;
+	ring->count_dw -= count;
+}
+
 static inline unsigned int amdgpu_ring_get_dw_distance(struct amdgpu_ring *ring,
 						       u64 start_wptr, u64 end_wptr)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 006f3fd3464a..e461e0236b5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -224,15 +224,14 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3fb15032e1ef..5cca7f715c6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -401,15 +401,14 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index dfb0ea709bad..63bdf8d4e8d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -784,15 +784,14 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index f2e6abe44a43..145f862cbcc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -350,15 +350,14 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index cb36b38582c5..124bc5768983 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -407,15 +407,14 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 2858820bb864..242586ea951a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -255,15 +255,14 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d3504606bee7..ae063ac3bd74 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -243,15 +243,14 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 1760f03db9e7..fd92830d3324 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -245,15 +245,14 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index b9f11f2f7e5c..c0824c83ace9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -239,15 +239,14 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v7_1_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
-	const bool burst_nop = sdma->burst_nop;
-	int i;
+	const u32 nop = ring->funcs->nop;
 
-	for (i = 0; i < count; i++)
-		if (i == 0 && burst_nop)
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
+	if (sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
-- 
2.55.0


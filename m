Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D766C88E7B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 11:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E4010FC05;
	Tue, 15 Sep 2026 11:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KOb9iTGJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B2D10FC05
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=XyHzWOK1Elxj/Ymysa8hCYl/7zmdyYjvT0edZhuRi6k=; b=KOb9iTGJbm0W3hIcLNykzzIKFS
 u/ImLH9Mg+FiuOsrkavIj5cSfP1h8LprKsYvqVLLZPwNt3uqE4F2lzpOM/mlDSP72fBT75H6R0Isn
 CRC7hOEyp+nn6KzOgpgMzDuCVtfhQP7M9bcTLBzIf/vCbd/1umBpKR1SZwHkxC4MaQBP9cmW9R/jn
 29ml577mWYbQ8h9fwBJC8IQINZd1kYK4HZZI4JeR28sVOu1xmqoA3PPqJjwWN8LUhHhhJXdiMHR8M
 sGdf+4A+TZhaOMeERvs4nKHLa8JAcO/YXhMopBnm2PDsvGfA+OJwPPQp6odsFavKNC9I8asPa8mxu
 Fqq5R4UA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6RfR-002Q3L-Lc; Tue, 15 Sep 2026 13:49:41 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v4 6/6] drm/amdgpu: Use memset32 for SDMA padding
Date: Tue, 15 Sep 2026 12:49:34 +0100
Message-ID: <20260915114934.60326-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915114934.60326-1-tvrtko.ursulin@igalia.com>
References: <20260915114934.60326-1-tvrtko.ursulin@igalia.com>
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
amdgpu_ring_fill() helper which pads using memset32. We do this by moving
the existing implementation from amdgpu_ring_insert_nop(), which is used
by the GFX rings, and then individually convert all the SDMA insert_nop
implementations.

For SDMA this should have a lesser benefit than for GFX (only SDMA v4.0
uses the 256 byte ring padding while the rest use 16), but it does not
harm to be consistent.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
 * Unconfused commit message.

v3:
 * Handle zero padding.
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
index 5da75852e5bf..790d8eba1b3c 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 380967852e78..d658e512f5d5 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fe0966ab92ac..f2a358084468 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 332536454aee..585c8816d67a 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 33a7ce87cc3a..e41956c663c1 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0b2da12acf23..94b6ed9c0819 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 800fd9370229..5d0c0c5ebb7d 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index da21791fc585..0b4791424749 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 934e84cb81e2..321c67e01443 100644
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
+	if (count && sdma->burst_nop) {
+		--count;
+		amdgpu_ring_write(ring, nop | SDMA_PKT_NOP_HEADER_COUNT(count));
+	}
+
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 /**
-- 
2.55.0


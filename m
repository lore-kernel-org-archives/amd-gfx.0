Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528C5E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01FDC10E07E;
	Fri, 27 Dec 2024 11:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BViRdYYo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10DCF10E07E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lak4yLeKB8+zbxTRvRT0MN8nnd3ESzzSi1BtKeldVpo=; b=BViRdYYooGNK3n8++64+X+NrUb
 R/hnM7E4e0M8FmyEufShnaK5F5Ol+x4o9nPq7MEUYzgCx5JtRa5newkEk8ceh5qgv9paecR/ljdVh
 huQqCCmvtIwZrp99x+K2wGizdB7WSYVtAyJOqsOYYebjQrQFlJFfPubBoRHCP2xTdUbKnMf9gRL54
 ut43kcdwR9R7emwUPcLocSIMh/zsYOyvwOaxgBVCg0WapSHsTCnZRyuJMKor0QUSaEwzuL73xOc8h
 RbqFerIDga9EYOiTa/t6a5+PeBlMGNvYm6zA76Ii9rVi52FVtaK5D564SX9GhcV/D3x3Oe/8fcxOw
 jUL+L0oQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nl-008EGe-7i; Fri, 27 Dec 2024 12:19:53 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 05/12] drm/amdgpu: Use memset32 for sdma insert nops
Date: Fri, 27 Dec 2024 11:19:31 +0000
Message-ID: <20241227111938.22974-6-tursulin@igalia.com>
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

Instead of open coding it via the inefficient amdgpu_ring_write() helper
which the compiler is not able to optimise much, we can use the new
amdgpu_ring_fill() helper which pads using memset32.

With SDMA this should have much less benefit than what was measured with
GFX (only SDMA v4.0 uses the 256 byte ring padding while the rest use 16),
but on the other hand it should not harm and is at least more consistent.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 17 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 26 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  4 +---
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 8e4e9ec68262..a4ae09fed5c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -108,22 +108,7 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
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
index 4c0861ebc77a..0a59738fa1d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -415,6 +415,32 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
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
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 148413f01875..2d07fcbd21b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -38,7 +38,6 @@ void amdgpu_sdma_ring_insert_nop(struct amdgpu_ring *ring, u32 count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
-	u32 i;
 
 	if (!count)
 		return;
@@ -48,8 +47,7 @@ void amdgpu_sdma_ring_insert_nop(struct amdgpu_ring *ring, u32 count)
 					(--count & ring->sdma.nop_pkt.mask) <<
 					ring->sdma.nop_pkt.shift);
 
-	for (i = 0; i < count; i++)
-		amdgpu_ring_write(ring, nop);
+	amdgpu_ring_fill(ring, nop, count);
 }
 
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
-- 
2.47.1


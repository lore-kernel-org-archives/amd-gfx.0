Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0BAC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 12:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E40210EA3F;
	Fri, 11 Jul 2025 12:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AbbK8NKM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159BC10EA3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZEdu/cyF/gymA/Aw1jb8ybg8YFqJEoqcRlZvl0v/swQ=; b=AbbK8NKMGf8WkROWbddjBw8d+Y
 8A8H2J6r7GBb96CwFEuTz77qFIe8UVAhzkcQZKrXydCwAt2xYBAIIdNfYlZKYzw5ky2PjZQKTMRnp
 miFNcn2UtFC1YKHuLsBLH3sEeqh0tTO6rvqSm8ur/H2SzALbD2RpYNxm1sc2GaGr9wG1P/RTnmZ2o
 is3M+LLcKR1fUJZNPzVqbMlMKR+WrQA95vMoZMVpcUVD+SUtDS+dh4yH6IAwi2j8GPpJWrjccds4p
 Cafo7THobFbwKFKWCJXwhMwR06NEH3xC+h3kPxxqcszsqLWxsWWIiBBketfOF9QNg/PlgHb3DiFL1
 YoxG30oA==;
Received: from [84.65.48.237] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uaCzY-00FNA4-Bt; Fri, 11 Jul 2025 14:36:40 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH] drm/amdgpu: Cache some values in ring emission helpers
Date: Fri, 11 Jul 2025 13:36:38 +0100
Message-ID: <20250711123638.45129-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
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

By caching some values in local variables we can allow the compiler to
emit more compact code because it does not have to reload those values
constantly.

Before and after size comparisons:

     text	   data	    bss	     dec	    hex	filename
  10708384	 547307	 213512	11469203	 af0193	amdgpu.ko.0
  10688632	 547307	 213512	11449451	 aeb46b	amdgpu.ko.1

 add/remove: 0/0 grow/shrink: 3/340 up/down: 29/-20025 (-19996)
  Function                                     old     new   delta
   amdgpu_ring_write_multiple                   600     612     +12
   amdgpu_umsch_mm_submit_pkt                   196     207     +11
   amdgpu_ring_write_multiple.constprop         453     459      +6
   vcn_v2_0_enc_ring_insert_end                  69      64      -5
 ...
   jpeg_v4_0_3_dec_ring_emit_ib                1281    1045    -236
   jpeg_v2_0_dec_ring_emit_ib                  1402    1147    -255
   jpeg_v1_0_decode_ring_emit_fence            1788    1507    -281
 Total: Before=8949691, After=8929695, chg -0.22%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index afaf951b0b78..d37e822ff46e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -467,8 +467,10 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
 
 static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
 {
-	ring->ring[ring->wptr++ & ring->buf_mask] = v;
-	ring->wptr &= ring->ptr_mask;
+	u64 wptr = ring->wptr;
+
+	ring->ring[wptr++ & ring->buf_mask] = v;
+	ring->wptr = wptr & ring->ptr_mask;
 	ring->count_dw--;
 }
 
@@ -476,9 +478,11 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 					      void *src, int count_dw)
 {
 	unsigned occupied, chunk1, chunk2;
+	u32 buf_mask = ring->buf_mask;
+	u64 wptr = ring->wptr;
 
-	occupied = ring->wptr & ring->buf_mask;
-	chunk1 = ring->buf_mask + 1 - occupied;
+	occupied = wptr & buf_mask;
+	chunk1 = buf_mask + 1 - occupied;
 	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
 	chunk2 = count_dw - chunk1;
 	chunk1 <<= 2;
@@ -492,8 +496,8 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 		memcpy(ring->ring, src, chunk2);
 	}
 
-	ring->wptr += count_dw;
-	ring->wptr &= ring->ptr_mask;
+	wptr += count_dw;
+	ring->wptr = wptr & ring->ptr_mask;
 	ring->count_dw -= count_dw;
 }
 
-- 
2.48.0


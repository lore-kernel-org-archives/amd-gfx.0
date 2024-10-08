Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB3DCEFC25
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 15:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF02110E57E;
	Tue,  8 Oct 2024 15:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qDyGscjZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0B110E579
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8gqvw8nwdRJ/ZjmnLEewigiELabI4YK3WobRJklRxVk=; b=qDyGscjZeQhvXGEjnU4V4bnEYV
 Kjd7SG9gam0WFyshBwwv7XwxutugvdY7oUIwK4imHHTryrQGN9qvoT6QI9gUslJNHWqMrvBwqxmkl
 hYVpTbOQRAG8kkljpkJwlfQkhNKnzmxD/FxyMq02zDOJ8gMEjOkrTY2jTtKCjl7km02qH6v9qpw87
 dQJ2ZG4pVt9JmIOP0CPZhOK0ymJHTaEUr/zOEX+Res3bmfBgQB+521syP9mXGV0Z1E++6u2K06k0c
 FyuvCPc7Sn8p6G7ctA//H590+Zb07F4Zw5iYuTD8J/g68e9gjBORHshImR/qFjUtJxLELfBoX6Up+
 nPH1KNiQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1syBmW-006bky-Gp; Tue, 08 Oct 2024 17:05:48 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [RFC 3/4] drm/amdgpu: Add and use amdgpu_ring_write_addr() helper
Date: Tue,  8 Oct 2024 16:05:31 +0100
Message-ID: <20241008150532.23661-4-tursulin@igalia.com>
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

I've noticed there is really a lot of places which write addresses into
the ring as two writes of lower_32_bits() followed by upper_32_bits().

Is it worth adding a helper to do those in one go?

It shrinks the source and binary a bit but is the readability better, or
worse?

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 22 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  | 12 ++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 12 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 45 ++++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 53 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 38 +++++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 56 +++++++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 41 +++++------------
 9 files changed, 103 insertions(+), 182 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 91ab32157210..aeab6fe21db6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -384,6 +384,16 @@ static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
 	ring->count_dw--;
 }
 
+static inline void amdgpu_ring_write64(struct amdgpu_ring *ring, u64 v)
+{
+	if (ring->count_dw <= 0)
+		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
+	*((u64 *)&ring->ring[ring->wptr & ring->buf_mask]) = v;
+	ring->wptr += 2;
+	ring->wptr &= ring->ptr_mask;
+	ring->count_dw -= 2;
+}
+
 static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 					      void *src, int count_dw)
 {
@@ -481,6 +491,18 @@ static inline void amdgpu_ring_fill2x32(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+static inline void amdgpu_ring_write_addr(struct amdgpu_ring *ring, u64 addr)
+{
+	u64 v;
+
+#ifdef __BIG_ENDIAN
+	v = (u64)lower_32_bits(addr) << 32 | upper_32_bits(addr);
+#else
+	v = addr;
+#endif
+	amdgpu_ring_write64(ring, v);
+}
+
 /**
  * amdgpu_ring_patch_cond_exec - patch dw count of conditional execute
  * @ring: amdgpu_ring structure
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 74fdbf71d95b..f24ca34f8062 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1070,8 +1070,7 @@ void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring,
 				uint32_t flags)
 {
 	amdgpu_ring_write(ring, VCE_CMD_IB);
-	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write_addr(ring, ib->gpu_addr);
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
@@ -1090,8 +1089,7 @@ void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
 
 	amdgpu_ring_write(ring, VCE_CMD_FENCE);
-	amdgpu_ring_write(ring, addr);
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, seq);
 	amdgpu_ring_write(ring, VCE_CMD_TRAP);
 	amdgpu_ring_write(ring, VCE_CMD_END);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 01be9036fb91..aecda0fa72c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -503,8 +503,7 @@ static void vpe_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, ib->gpu_addr & 0xffffffe0);
 	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
 	amdgpu_ring_write(ring, ib->length_dw);
-	amdgpu_ring_write(ring, lower_32_bits(csa_mc_addr));
-	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
+	amdgpu_ring_write_addr(ring, csa_mc_addr);
 }
 
 static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
@@ -517,8 +516,7 @@ static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
 		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0));
 		/* zero in first two bits */
 		WARN_ON_ONCE(addr & 0x3);
-		amdgpu_ring_write(ring, lower_32_bits(addr));
-		amdgpu_ring_write(ring, upper_32_bits(addr));
+		amdgpu_ring_write_addr(ring, addr);
 		amdgpu_ring_write(ring, i == 0 ? lower_32_bits(seq) : upper_32_bits(seq));
 		addr += 4;
 	} while ((flags & AMDGPU_FENCE_FLAG_64BIT) && (i++ < 1));
@@ -589,8 +587,7 @@ static unsigned int vpe_ring_init_cond_exec(struct amdgpu_ring *ring,
 	unsigned int ret;
 
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COND_EXE, 0));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, 1);
 	ret = ring->wptr & ring->buf_mask;
 	amdgpu_ring_write(ring, 0);
@@ -762,8 +759,7 @@ static int vpe_ring_test_ring(struct amdgpu_ring *ring)
 	}
 
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0));
-	amdgpu_ring_write(ring, lower_32_bits(wb_addr));
-	amdgpu_ring_write(ring, upper_32_bits(wb_addr));
+	amdgpu_ring_write_addr(ring, wb_addr);
 	amdgpu_ring_write(ring, test_pattern);
 	amdgpu_ring_commit(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 1056a35fb19c..4c99ccd684f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -231,8 +231,7 @@ static void cik_sdma_ring_emit_ib(struct amdgpu_ring *ring,
 	cik_sdma_ring_insert_nop(ring, (4 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PACKET(SDMA_OPCODE_INDIRECT_BUFFER, 0, extra_bits));
-	amdgpu_ring_write(ring, ib->gpu_addr & 0xffffffe0); /* base must be 32 byte aligned */
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr) & 0xffffffff);
+	amdgpu_ring_write_addr(ring, ib->gpu_addr & 0xffffffffffffffe0ULL); /* base must be 32 byte aligned */
 	amdgpu_ring_write(ring, ib->length_dw);
 
 }
@@ -281,16 +280,14 @@ static void cik_sdma_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PACKET(SDMA_OPCODE_FENCE, 0, 0));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 
 	/* optionally write high bits as well */
 	if (write64bit) {
 		addr += 4;
 		amdgpu_ring_write(ring, SDMA_PACKET(SDMA_OPCODE_FENCE, 0, 0));
-		amdgpu_ring_write(ring, lower_32_bits(addr));
-		amdgpu_ring_write(ring, upper_32_bits(addr));
+		amdgpu_ring_write_addr(ring, addr);
 		amdgpu_ring_write(ring, upper_32_bits(seq));
 	}
 
@@ -619,8 +616,7 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
 		goto error_free_wb;
 
 	amdgpu_ring_write(ring, SDMA_PACKET(SDMA_OPCODE_WRITE, SDMA_WRITE_SUB_OPCODE_LINEAR, 0));
-	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
+	amdgpu_ring_write_addr(ring, gpu_addr);
 	amdgpu_ring_write(ring, 1); /* number of DWs to follow */
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e37a2ac1f03c..24fb58543041 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3680,8 +3680,7 @@ static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
+	amdgpu_ring_write_addr(kiq_ring, queue_mask);	/* queue mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
 	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
@@ -3722,10 +3721,8 @@ static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
 			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
 	amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+	amdgpu_ring_write_addr(kiq_ring, mqd_addr);
+	amdgpu_ring_write_addr(kiq_ring, wptr_addr);
 }
 
 static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
@@ -3745,13 +3742,10 @@ static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 		  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
 
 	if (action == PREEMPT_QUEUES_NO_UNMAP) {
-		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
+		amdgpu_ring_write_addr(kiq_ring, gpu_addr);
 		amdgpu_ring_write(kiq_ring, seq);
 	} else {
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_fill(kiq_ring, 0, 3);
 	}
 }
 
@@ -3770,10 +3764,8 @@ static void gfx10_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
 			  PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
 			  PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(kiq_ring, addr);
+	amdgpu_ring_write_addr(kiq_ring, seq); /* Not an address but same semantics */
 }
 
 static void gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
@@ -8627,10 +8619,8 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 		BUG_ON(addr & 0x7);
 	else
 		BUG_ON(addr & 0x3);
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
-	amdgpu_ring_write(ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(ring, addr);
+	amdgpu_ring_write_addr(ring, seq); /* Not an address but same semantics */
 	amdgpu_ring_write(ring, 0);
 }
 
@@ -8681,8 +8671,7 @@ static void gfx_v10_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
 				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
@@ -8742,8 +8731,7 @@ static unsigned int gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 	unsigned int ret;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	/* discard following DWs if *cond_exec_gpu_addr==0 */
 	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
@@ -8819,8 +8807,7 @@ static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
+	amdgpu_ring_write_addr(ring, ce_payload_gpu_addr);
 
 	if (resume)
 		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
@@ -8855,8 +8842,7 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
+	amdgpu_ring_write_addr(ring, de_payload_gpu_addr);
 
 	if (resume)
 		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
@@ -8886,10 +8872,7 @@ static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
+	amdgpu_ring_write_addr(ring, adev->wb.gpu_addr + reg_val_offs * 4);
 }
 
 static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d67f2a2bcc81..0db6a9600f8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -297,8 +297,7 @@ static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
 			  PACKET3_SET_RESOURCES_UNMAP_LATENTY(0xa) | /* unmap_latency: 0xa (~ 1s) */
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
+	amdgpu_ring_write_addr(kiq_ring, queue_mask);	/* queue mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
 	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
@@ -342,10 +341,8 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
 			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
 	amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+	amdgpu_ring_write_addr(kiq_ring, mqd_addr);
+	amdgpu_ring_write_addr(kiq_ring, wptr_addr);
 }
 
 static void gfx11_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
@@ -371,13 +368,11 @@ static void gfx11_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 		  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
 
 	if (action == PREEMPT_QUEUES_NO_UNMAP) {
-		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
+		amdgpu_ring_write_addr(kiq_ring, gpu_addr);
 		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
 		amdgpu_ring_write(kiq_ring, seq);
 	} else {
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_fill(kiq_ring, 0, 3);
 	}
 }
 
@@ -396,10 +391,8 @@ static void gfx11_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
 			  PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
 			  PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(kiq_ring, addr);
+	amdgpu_ring_write_addr(kiq_ring, seq); /* Not and addr but same semantics */
 }
 
 static void gfx11_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
@@ -5707,10 +5700,8 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 		BUG_ON(addr & 0x7);
 	else
 		BUG_ON(addr & 0x3);
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
-	amdgpu_ring_write(ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(ring, addr);
+	amdgpu_ring_write_addr(ring, seq); /* Not an addr but same semantics */
 	amdgpu_ring_write(ring, ring->is_mes_queue ?
 			 (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0);
 }
@@ -5771,8 +5762,7 @@ static void gfx_v11_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
 				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
@@ -5812,8 +5802,7 @@ static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 	unsigned ret;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	/* discard following DWs if *cond_exec_gpu_addr==0 */
 	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
@@ -5876,18 +5865,14 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
 		addr += offs << 2;
 		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 		amdgpu_ring_write(ring, WRITE_DATA_DST_SEL(5) | WR_CONFIRM);
-		amdgpu_ring_write(ring, lower_32_bits(addr));
-		amdgpu_ring_write(ring, upper_32_bits(addr));
+		amdgpu_ring_write_addr(ring, addr);
 		amdgpu_ring_write(ring, 0x1);
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
-	amdgpu_ring_write(ring, lower_32_bits(shadow_va));
-	amdgpu_ring_write(ring, upper_32_bits(shadow_va));
-	amdgpu_ring_write(ring, lower_32_bits(gds_va));
-	amdgpu_ring_write(ring, upper_32_bits(gds_va));
-	amdgpu_ring_write(ring, lower_32_bits(csa_va));
-	amdgpu_ring_write(ring, upper_32_bits(csa_va));
+	amdgpu_ring_write_addr(ring, shadow_va);
+	amdgpu_ring_write_addr(ring, gds_va);
+	amdgpu_ring_write_addr(ring, csa_va);
 	amdgpu_ring_write(ring, shadow_va ?
 			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0);
 	amdgpu_ring_write(ring, init_shadow ?
@@ -6004,8 +5989,7 @@ static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
+	amdgpu_ring_write_addr(ring, de_payload_gpu_addr);
 
 	if (resume)
 		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
@@ -6035,10 +6019,7 @@ static void gfx_v11_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
+	amdgpu_ring_write_addr(ring, adev->wb.gpu_addr + reg_val_offs * 4);
 }
 
 static void gfx_v11_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8ce6b89315b1..6105bd4ed6f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -248,7 +248,7 @@ static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
+	amdgpu_ring_write_addr(kiq_ring, queue_mask);	/* queue mask */
 	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
 	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
@@ -293,10 +293,8 @@ static void gfx_v12_0_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
 			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
 	amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+	amdgpu_ring_write_addr(kiq_ring, mqd_addr);
+	amdgpu_ring_write_addr(kiq_ring, wptr_addr);
 }
 
 static void gfx_v12_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
@@ -322,13 +320,10 @@ static void gfx_v12_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 		  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
 
 	if (action == PREEMPT_QUEUES_NO_UNMAP) {
-		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
+		amdgpu_ring_write_addr(kiq_ring, gpu_addr);
 		amdgpu_ring_write(kiq_ring, seq);
 	} else {
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_fill(kiq_ring, 0, 3);
 	}
 }
 
@@ -346,10 +341,8 @@ static void gfx_v12_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
 			  PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
 			  PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(kiq_ring, addr);
+	amdgpu_ring_write_addr(kiq_ring, seq); /* Not an address but same semantics */
 }
 
 static void gfx_v12_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
@@ -4391,10 +4384,8 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 		BUG_ON(addr & 0x7);
 	else
 		BUG_ON(addr & 0x3);
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
-	amdgpu_ring_write(ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(ring, addr);
+	amdgpu_ring_write_addr(ring, seq); /* Not an address but same semantics */
 	amdgpu_ring_write(ring, ring->is_mes_queue ?
 			 (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0);
 }
@@ -4449,8 +4440,7 @@ static void gfx_v12_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
 				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
@@ -4490,8 +4480,7 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 	unsigned ret;
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	/* discard following DWs if *cond_exec_gpu_addr==0 */
 	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
@@ -4572,10 +4561,7 @@ static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
+	amdgpu_ring_write_addr(ring, adev->wb.gpu_addr + reg_val_offs * 4);
 }
 
 static void gfx_v12_0_ring_emit_wreg(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e2c2c9f54a9e..2c45897b3108 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -911,12 +911,8 @@ static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 		PACKET3_SET_RESOURCES_VMID_MASK(0) |
 		/* vmid_mask:0* queue_type:0 (KIQ) */
 		PACKET3_SET_RESOURCES_QUEUE_TYPE(0));
-	amdgpu_ring_write(kiq_ring,
-			lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring,
-			upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
+	amdgpu_ring_write_addr(kiq_ring, queue_mask);	/* queue mask */
+	amdgpu_ring_write_addr(kiq_ring, shader_mc_addr); /* cleaner shader addr  */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -945,10 +941,8 @@ static void gfx_v9_0_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			 PACKET3_MAP_QUEUES_NUM_QUEUES(1));
 	amdgpu_ring_write(kiq_ring,
 			PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+	amdgpu_ring_write_addr(kiq_ring, mqd_addr);
+	amdgpu_ring_write_addr(kiq_ring, wptr_addr);
 }
 
 static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
@@ -969,13 +963,9 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 
 	if (action == PREEMPT_QUEUES_NO_UNMAP) {
 		amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring->buf_mask));
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-
+		amdgpu_ring_write64(kiq_ring, 0);
 	} else {
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_fill(kiq_ring, 0, 3);
 	}
 }
 
@@ -995,10 +985,8 @@ static void gfx_v9_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring,
 			PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
 			PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(kiq_ring, addr);
+	amdgpu_ring_write_addr(kiq_ring, seq);
 }
 
 static void gfx_v9_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
@@ -4172,10 +4160,7 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
+	amdgpu_ring_write_addr(ring, adev->wb.gpu_addr + reg_val_offs * 4);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
 		goto failed_undo;
@@ -5556,10 +5541,8 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 		BUG_ON(addr & 0x7);
 	else
 		BUG_ON(addr & 0x3);
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
-	amdgpu_ring_write(ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(ring, addr);
+	amdgpu_ring_write_addr(ring, seq);
 	amdgpu_ring_write(ring, 0);
 }
 
@@ -5629,8 +5612,7 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
 				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
@@ -5679,8 +5661,7 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
+	amdgpu_ring_write_addr(ring, ce_payload_gpu_addr);
 
 	amdgpu_ring_ib_on_emit_ce(ring);
 
@@ -5792,8 +5773,7 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bo
 				 WRITE_DATA_DST_SEL(8) |
 				 WR_CONFIRM) |
 				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
+	amdgpu_ring_write_addr(ring, de_payload_gpu_addr);
 
 	amdgpu_ring_ib_on_emit_de(ring);
 	if (resume)
@@ -5851,8 +5831,7 @@ static unsigned gfx_v9_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 {
 	unsigned ret;
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	/* discard following DWs if *cond_exec_gpu_addr==0 */
 	amdgpu_ring_write(ring, 0);
 	ret = ring->wptr & ring->buf_mask;
@@ -5872,10 +5851,7 @@ static void gfx_v9_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
+	amdgpu_ring_write_addr(ring, adev->wb.gpu_addr + reg_val_offs * 4);
 }
 
 static void gfx_v9_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 793828ac0eee..b4d83c94472b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -181,12 +181,8 @@ static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 		PACKET3_SET_RESOURCES_VMID_MASK(0) |
 		/* vmid_mask:0* queue_type:0 (KIQ) */
 		PACKET3_SET_RESOURCES_QUEUE_TYPE(0));
-	amdgpu_ring_write(kiq_ring,
-			lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring,
-			upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
+	amdgpu_ring_write_addr(kiq_ring, queue_mask);	/* queue mask */
+	amdgpu_ring_write_addr(kiq_ring, shader_mc_addr); /* cleaner shader addr */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -216,10 +212,8 @@ static void gfx_v9_4_3_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			 PACKET3_MAP_QUEUES_NUM_QUEUES(1));
 	amdgpu_ring_write(kiq_ring,
 			PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+	amdgpu_ring_write_addr(kiq_ring, mqd_addr);
+	amdgpu_ring_write_addr(kiq_ring, wptr_addr);
 }
 
 static void gfx_v9_4_3_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
@@ -239,13 +233,10 @@ static void gfx_v9_4_3_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
 
 	if (action == PREEMPT_QUEUES_NO_UNMAP) {
-		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
+		amdgpu_ring_write_addr(kiq_ring, gpu_addr);
 		amdgpu_ring_write(kiq_ring, seq);
 	} else {
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_fill(kiq_ring, 0, 3);
 	}
 }
 
@@ -265,10 +256,8 @@ static void gfx_v9_4_3_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring,
 			PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
 			PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(kiq_ring, addr);
+	amdgpu_ring_write_addr(kiq_ring, seq);
 }
 
 static void gfx_v9_4_3_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
@@ -2911,10 +2900,8 @@ static void gfx_v9_4_3_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 		BUG_ON(addr & 0x7);
 	else
 		BUG_ON(addr & 0x3);
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
-	amdgpu_ring_write(ring, upper_32_bits(seq));
+	amdgpu_ring_write_addr(ring, addr);
+	amdgpu_ring_write_addr(ring, seq);
 	amdgpu_ring_write(ring, 0);
 }
 
@@ -2977,8 +2964,7 @@ static void gfx_v9_4_3_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
 				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write_addr(ring, addr);
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
@@ -3005,10 +2991,7 @@ static void gfx_v9_4_3_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				(1 << 20));	/* write confirm */
 	amdgpu_ring_write(ring, reg);
 	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
+	amdgpu_ring_write_addr(ring, adev->wb.gpu_addr + reg_val_offs * 4);
 }
 
 static void gfx_v9_4_3_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-- 
2.46.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEAFE7718F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C9610E3AC;
	Fri, 27 Dec 2024 11:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ra39C8gl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C662810E3AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q24ZaGCgpoUtCqnmSLgx7Lh8+ezEmfaIWKIV8V4Dyd4=; b=Ra39C8glHgwcyJZORjfW/ROlna
 qAEU3Y97Dn8r9W9xLWyQgvklp41uVE/loSe6xAYbca4p8tZiidnl97X/D+ZJ0UYkFUdUfqv6KRe8o
 sBtnF4+RZ913Ih5LjUdO43YktJEknqpc3kUyXoVjVnJF9TOnSaf2yMnPzFsYVzerrd8YwHhxw+0Tn
 mLNyMDCa+1rkbI+pkWEBwkVie6BeyNLtRVoa16F/o1WEM2JFpSZTED275Ij4HY9lNj9kUoX4MhWIT
 +n8GfoDgm8Wnrxjxkql2azzCMY/s14RdbTkELZcsJlMEcOYcZBToQ2bxmL2D9+4wJTP7fs1uGQVMM
 Z5Bz2h+Q==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nq-008EHc-2J; Fri, 27 Dec 2024 12:19:58 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 12/12] drm/amdgpu: Convert SDMA v5.2 to variadic
 amdgpu_ring_write()
Date: Fri, 27 Dec 2024 11:19:38 +0000
Message-ID: <20241227111938.22974-13-tursulin@igalia.com>
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

Converting the SDMA v5.2 ring helpers to use the variadic
amdgpu_ring_write().

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 151 +++++++++++++------------
 1 file changed, 80 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 69b88db32117..55c1cc0e03b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -143,10 +143,11 @@ static unsigned sdma_v5_2_ring_init_cond_exec(struct amdgpu_ring *ring,
 {
 	unsigned ret;
 
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_COND_EXE));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, 1);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_COND_EXE),
+			  lower_32_bits(addr),
+			  upper_32_bits(addr),
+			  1);
 	/* this is the offset we need patch later */
 	ret = ring->wptr & ring->buf_mask;
 	/* insert dummy here and patch it later */
@@ -278,14 +279,15 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
 	 */
 	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
-			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
-	/* base must be 32 byte aligned */
-	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr) & 0xffffffe0);
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, ib->length_dw);
-	amdgpu_ring_write(ring, lower_32_bits(csa_mc_addr));
-	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
+			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf),
+			  /* base must be 32 byte aligned */
+			  lower_32_bits(ib->gpu_addr) & 0xffffffe0,
+			  upper_32_bits(ib->gpu_addr),
+			  ib->length_dw,
+			  lower_32_bits(csa_mc_addr),
+			  upper_32_bits(csa_mc_addr));
 }
 
 /**
@@ -303,14 +305,15 @@ static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)
 			    SDMA_GCR_GLI_INV(1);
 
 	/* flush entire cache L0/L1/L2, this can be optimized by performance requirement */
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
-	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0));
-	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |
-			SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0));
-	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) |
-			SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl >> 16));
-	amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0) |
-			SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ),
+			  SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0),
+			  SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |
+			  SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0),
+			  SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) |
+			  SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl >> 16),
+			  SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0) |
+			  SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
 }
 
 /**
@@ -331,14 +334,15 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	} else {
 		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
 
-		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+		amdgpu_ring_write(ring,
+				  SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 				  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
-				  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
-		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
-		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
-		amdgpu_ring_write(ring, ref_and_mask); /* reference */
-		amdgpu_ring_write(ring, ref_and_mask); /* mask */
-		amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+				  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3), /* == */
+				  adev->nbio.funcs->get_hdp_flush_done_offset(adev) << 2,
+				  adev->nbio.funcs->get_hdp_flush_req_offset(adev) << 2,
+				  ref_and_mask, /* reference */
+				  ref_and_mask, /* mask */
+				  SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 				  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
 	}
 }
@@ -359,33 +363,35 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 				      unsigned flags)
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
-	/* write the fence */
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
-			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
-	/* zero in first two bits */
+
 	BUG_ON(addr & 0x3);
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
+
+	/* write the fence */
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
+			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3), /* Ucached(UC) */
+			  lower_32_bits(addr),
+			  upper_32_bits(addr),
+			  lower_32_bits(seq));
 
 	/* optionally write high bits as well */
 	if (write64bit) {
 		addr += 4;
-		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
-				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
-		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
-		amdgpu_ring_write(ring, lower_32_bits(addr));
-		amdgpu_ring_write(ring, upper_32_bits(addr));
-		amdgpu_ring_write(ring, upper_32_bits(seq));
+		amdgpu_ring_write(ring,
+				  SDMA_PKT_HEADER_OP(SDMA_OP_FENCE) |
+				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3),
+				  lower_32_bits(addr),
+				  upper_32_bits(addr),
+				  upper_32_bits(seq));
 	}
 
 	if ((flags & AMDGPU_FENCE_FLAG_INT)) {
 		uint32_t ctx = ring->is_mes_queue ?
 			(ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0;
 		/* generate an interrupt */
-		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
-		amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
+		amdgpu_ring_write(ring,
+				  SDMA_PKT_HEADER_OP(SDMA_OP_TRAP),
+				  SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
 	}
 }
 
@@ -920,12 +926,13 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 		return r;
 	}
 
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
-			  SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR));
-	amdgpu_ring_write(ring, lower_32_bits(gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
-	amdgpu_ring_write(ring, SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0));
-	amdgpu_ring_write(ring, 0xDEADBEEF);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+			  SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR),
+			  lower_32_bits(gpu_addr),
+			  upper_32_bits(gpu_addr),
+			  SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0),
+			  0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -1171,15 +1178,16 @@ static void sdma_v5_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
 	/* wait for idle */
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3) | /* equal */
-			  SDMA_PKT_POLL_REGMEM_HEADER_MEM_POLL(1));
-	amdgpu_ring_write(ring, addr & 0xfffffffc);
-	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
-	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xffffffff); /* mask */
-	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_MEM_POLL(1),
+			  addr & 0xfffffffc,
+			  upper_32_bits(addr) & 0xffffffff,
+			  seq, /* reference */
+			  0xffffffff, /* mask */
+			  SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
 
@@ -1213,10 +1221,9 @@ static void sdma_v5_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
 			  SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
 			  SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng) |
-			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
-	amdgpu_ring_write(ring, req);
-	amdgpu_ring_write(ring, 0xFFFFFFFF);
-	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f),
+			  req,
+			  0xFFFFFFFF,
 			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
 			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
 }
@@ -1224,23 +1231,25 @@ static void sdma_v5_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
 static void sdma_v5_2_ring_emit_wreg(struct amdgpu_ring *ring,
 				     uint32_t reg, uint32_t val)
 {
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_SRBM_WRITE) |
-			  SDMA_PKT_SRBM_WRITE_HEADER_BYTE_EN(0xf));
-	amdgpu_ring_write(ring, reg);
-	amdgpu_ring_write(ring, val);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_SRBM_WRITE) |
+			  SDMA_PKT_SRBM_WRITE_HEADER_BYTE_EN(0xf),
+			  reg,
+			  val);
 }
 
 static void sdma_v5_2_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 					 uint32_t val, uint32_t mask)
 {
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* equal */
-	amdgpu_ring_write(ring, reg << 2);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, val); /* reference */
-	amdgpu_ring_write(ring, mask); /* mask */
-	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3), /* equal */
+			  reg << 2,
+			  0,
+			  val, /* reference */
+			  mask, /* mask */
+			  SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10));
 }
 
-- 
2.47.1


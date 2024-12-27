Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B24AE77194
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F3210E3A6;
	Fri, 27 Dec 2024 11:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gablIPeR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5649D10E3A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DUBBPvyJaGGi8SbMpJCC7SRGQVImHFAuCAKMQ8ffLRI=; b=gablIPeRwEMA+WoeySQ7whqAxG
 J+zmCAOb12lpIoj7WJJVUVU7NYPlRwAdvEtBK9A+DkodZbCXh8oSBYePNEa1KRkf+2Us/Wr7lqt64
 oxoW12RmJlq45LHG1qG/kjUVQFhAf6AxRGL7u+zQEpccMK1GbFy3nH6IsCrAba5pVnzoy45NmkF2o
 6to9rsxlAMEu40CAMTpbFe+A0/sOTYcioz5Pw+UFUWEJ6/MHRnOtOfisrnbDoN79RIUFCoO3I8POm
 3tV8aWbzG3zS8kmPAAi6jRK55y5r3QF0uyfSCYuEV14vxRq4TQv8XDBb/iLza+8uogXFLqaB9CKXl
 d9Qx1E3Q==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nk-008EGW-HV; Fri, 27 Dec 2024 12:19:52 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: Consolidate a bunch of similar sdma insert
 nop vfuncs
Date: Fri, 27 Dec 2024 11:19:30 +0000
Message-ID: <20241227111938.22974-5-tursulin@igalia.com>
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

A lot of the hardware generations apparently uses the same nop insertion
logic, just with different masks and shifts.

We can consolidate if we store those shifts and mask in the ring and
shrink both the source and binary.

Though it appears a bit of a departure from the existing "duplicate
everything" state so we will see how this is received.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 19 ++++---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 19 ++++---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 23 +++++++----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 23 +++++++----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 19 ++++---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 19 ++++---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 19 ++++---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 19 ++++---------------
 11 files changed, 62 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 429c77db920f..4c0861ebc77a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -303,6 +303,11 @@ struct amdgpu_ring {
 	struct {
 		struct amdgpu_sdma_instance *instance;
 		int			     index;
+
+		struct {
+			u32		mask;
+			unsigned int	shift;
+		} nop_pkt;
 	} sdma;
 
 	/* used for mes */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index d43dfec82624..148413f01875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -34,6 +34,24 @@
  * GPU SDMA IP block helpers function.
  */
 
+void amdgpu_sdma_ring_insert_nop(struct amdgpu_ring *ring, u32 count)
+{
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const u32 nop = ring->funcs->nop;
+	u32 i;
+
+	if (!count)
+		return;
+
+	if (sdma && sdma->burst_nop)
+		amdgpu_ring_write(ring, nop |
+					(--count & ring->sdma.nop_pkt.mask) <<
+					ring->sdma.nop_pkt.shift);
+
+	for (i = 0; i < count; i++)
+		amdgpu_ring_write(ring, nop);
+}
+
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 				     unsigned int vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 7debf3ed0b46..d2642a9113ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -159,6 +159,7 @@ struct amdgpu_buffer_funcs {
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
+void amdgpu_sdma_ring_insert_nop(struct amdgpu_ring *ring, u32 count);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 2e844dba4ad5..e0ed65eca431 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -221,19 +221,6 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 	WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me], ring->wptr << 2);
 }
 
-static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /**
  * sdma_v2_4_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -252,7 +239,7 @@ static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
 	/* IB packet must end on a 8 DW boundary */
-	sdma_v2_4_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -866,6 +853,8 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 	}
 
 	return r;
@@ -1137,7 +1126,7 @@ static const struct amdgpu_ring_funcs sdma_v2_4_ring_funcs = {
 	.emit_hdp_flush = sdma_v2_4_ring_emit_hdp_flush,
 	.test_ring = sdma_v2_4_ring_test_ring,
 	.test_ib = sdma_v2_4_ring_test_ib,
-	.insert_nop = sdma_v2_4_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v2_4_ring_pad_ib,
 	.emit_wreg = sdma_v2_4_ring_emit_wreg,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 104fd1214c4c..8a644ea28589 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -397,19 +397,6 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /**
  * sdma_v3_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -428,7 +415,7 @@ static void sdma_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
 	/* IB packet must end on a 8 DW boundary */
-	sdma_v3_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1152,6 +1139,8 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 	}
 
 	return r;
@@ -1579,7 +1568,7 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
 	.emit_hdp_flush = sdma_v3_0_ring_emit_hdp_flush,
 	.test_ring = sdma_v3_0_ring_test_ring,
 	.test_ib = sdma_v3_0_ring_test_ib,
-	.insert_nop = sdma_v3_0_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v3_0_ring_pad_ib,
 	.emit_wreg = sdma_v3_0_ring_emit_wreg,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index c91d05a4593e..0f0f05a03cd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -781,19 +781,6 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /**
  * sdma_v4_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -812,7 +799,7 @@ static void sdma_v4_0_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
 	/* IB packet must end on a 8 DW boundary */
-	sdma_v4_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1876,6 +1863,8 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
@@ -1917,6 +1906,8 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 			ring->sdma.instance = &adev->sdma.instance[i];
 			ring->sdma.index = i;
+			ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+			ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 		}
 	}
 
@@ -2443,7 +2434,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.emit_hdp_flush = sdma_v4_0_ring_emit_hdp_flush,
 	.test_ring = sdma_v4_0_ring_test_ring,
 	.test_ib = sdma_v4_0_ring_test_ib,
-	.insert_nop = sdma_v4_0_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v4_0_ring_pad_ib,
 	.emit_wreg = sdma_v4_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_0_ring_emit_reg_wait,
@@ -2475,7 +2466,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.emit_hdp_flush = sdma_v4_0_ring_emit_hdp_flush,
 	.test_ring = sdma_v4_0_ring_test_ring,
 	.test_ib = sdma_v4_0_ring_test_ib,
-	.insert_nop = sdma_v4_0_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v4_0_ring_pad_ib,
 	.emit_wreg = sdma_v4_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index d1d21a3951f8..f68b7f2e0a40 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -341,19 +341,6 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /**
  * sdma_v4_4_2_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -372,7 +359,7 @@ static void sdma_v4_4_2_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
 	/* IB packet must end on a 8 DW boundary */
-	sdma_v4_4_2_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1431,6 +1418,8 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
@@ -1455,6 +1444,8 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 			ring->sdma.instance = &adev->sdma.instance[i];
 			ring->sdma.index = i;
+			ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+			ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 		}
 	}
 
@@ -2013,7 +2004,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_hdp_flush = sdma_v4_4_2_ring_emit_hdp_flush,
 	.test_ring = sdma_v4_4_2_ring_test_ring,
 	.test_ib = sdma_v4_4_2_ring_test_ib,
-	.insert_nop = sdma_v4_4_2_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v4_4_2_ring_pad_ib,
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
@@ -2045,7 +2036,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_hdp_flush = sdma_v4_4_2_ring_emit_hdp_flush,
 	.test_ring = sdma_v4_4_2_ring_test_ring,
 	.test_ib = sdma_v4_4_2_ring_test_ib,
-	.insert_nop = sdma_v4_4_2_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v4_4_2_ring_pad_ib,
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 97536f82dfcd..bbf60bfa4b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -433,19 +433,6 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /**
  * sdma_v5_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -472,7 +459,7 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
 	 * (wptr + 6 + x) % 8 = 0.
 	 * The expression below, is a solution of x.
 	 */
-	sdma_v5_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1453,6 +1440,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 	}
 
 	adev->sdma.supported_reset =
@@ -1991,7 +1980,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_hdp_flush = sdma_v5_0_ring_emit_hdp_flush,
 	.test_ring = sdma_v5_0_ring_test_ring,
 	.test_ib = sdma_v5_0_ring_test_ib,
-	.insert_nop = sdma_v5_0_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v5_0_ring_pad_ib,
 	.emit_wreg = sdma_v5_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v5_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 8eaddee1d97d..69b88db32117 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -250,19 +250,6 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /**
  * sdma_v5_2_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -289,7 +276,7 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
 	 * (wptr + 6 + x) % 8 = 0.
 	 * The expression below, is a solution of x.
 	 */
-	sdma_v5_2_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1358,6 +1345,8 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 	}
 
 	adev->sdma.supported_reset =
@@ -1986,7 +1975,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.emit_hdp_flush = sdma_v5_2_ring_emit_hdp_flush,
 	.test_ring = sdma_v5_2_ring_test_ring,
 	.test_ib = sdma_v5_2_ring_test_ib,
-	.insert_nop = sdma_v5_2_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v5_2_ring_pad_ib,
 	.begin_use = sdma_v5_2_ring_begin_use,
 	.end_use = sdma_v5_2_ring_end_use,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3ead269eccdc..aa3992fd5313 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -235,19 +235,6 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /*
  * sdma_v6_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -274,7 +261,7 @@ static void sdma_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
 	 * (wptr + 6 + x) % 8 = 0.
 	 * The expression below, is a solution of x.
 	 */
-	sdma_v6_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1351,6 +1338,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 	}
 
 	adev->sdma.supported_reset =
@@ -1707,7 +1696,7 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.emit_hdp_flush = sdma_v6_0_ring_emit_hdp_flush,
 	.test_ring = sdma_v6_0_ring_test_ring,
 	.test_ib = sdma_v6_0_ring_test_ib,
-	.insert_nop = sdma_v6_0_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v6_0_ring_pad_ib,
 	.emit_wreg = sdma_v6_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v6_0_ring_emit_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 5fadaf35a03a..4ccc00248a09 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -267,19 +267,6 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
-{
-	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
-	int i;
-
-	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
-			amdgpu_ring_write(ring, ring->funcs->nop |
-				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
-		else
-			amdgpu_ring_write(ring, ring->funcs->nop);
-}
-
 /**
  * sdma_v7_0_ring_emit_ib - Schedule an IB on the DMA engine
  *
@@ -306,7 +293,7 @@ static void sdma_v7_0_ring_emit_ib(struct amdgpu_ring *ring,
 	 * (wptr + 6 + x) % 8 = 0.
 	 * The expression below, is a solution of x.
 	 */
-	sdma_v7_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
+	amdgpu_sdma_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1365,6 +1352,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->sdma.instance = &adev->sdma.instance[i];
 		ring->sdma.index = i;
+		ring->sdma.nop_pkt.mask = SDMA_PKT_NOP_HEADER_count_mask;
+		ring->sdma.nop_pkt.shift = SDMA_PKT_NOP_HEADER_count_shift;
 	}
 
 	adev->sdma.supported_reset =
@@ -1687,7 +1676,7 @@ static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
 	.emit_hdp_flush = sdma_v7_0_ring_emit_hdp_flush,
 	.test_ring = sdma_v7_0_ring_test_ring,
 	.test_ib = sdma_v7_0_ring_test_ib,
-	.insert_nop = sdma_v7_0_ring_insert_nop,
+	.insert_nop = amdgpu_sdma_ring_insert_nop,
 	.pad_ib = sdma_v7_0_ring_pad_ib,
 	.emit_wreg = sdma_v7_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v7_0_ring_emit_reg_wait,
-- 
2.47.1


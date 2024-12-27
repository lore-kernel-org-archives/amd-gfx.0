Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DBFE77193
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DC210E3AF;
	Fri, 27 Dec 2024 11:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JK3aqG0Y";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF5910E3AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fzH6t6yYYw8LjKO+VtCpO4FDiu5JqfEO8HRgn5tRrV0=; b=JK3aqG0Yc4kCSvs1UYZqMydCgU
 AS1PaAUja2K0qFozVcHnpkIE9dmL4LW/Y91F3E0xJoRViIcn/02bP0Yo5BhqFZrqWctkFB8G1Cax+
 yx6GFTko+R6HkvaH3qt4pCh6vLTgZUr9xGI3GCOMYa1xRsnrgd/en6oUdJVKcdcTzAxNiNtu+feAw
 sNs7UIJE/8d0cF+qAG/mKlnsS/QNDGi4Zf5fQQ3OJYqNqZyhpevKY6Uqu0ObeSRYsW3i7kAINIY0X
 zFvdtrKCabpC2GgfKqH/gbCu4kL9buJ4gZoI3oa07B5bpYWPdsvR+E5p+82kFl7Ygm0+SY9n48wfu
 kRVHRZvg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Np-008EHW-BK; Fri, 27 Dec 2024 12:19:57 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 11/12] drm/amdgpu: Convert GFX v10.0 to variadic
 amdgpu_ring_write()
Date: Fri, 27 Dec 2024 11:19:37 +0000
Message-ID: <20241227111938.22974-12-tursulin@igalia.com>
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

Converting the GFX v10.0 ring helpers to use the variadic
amdgpu_ring_write().

Also small cleanups in gfx_v10_0_cp_gfx_start(),
gfx_v10_0_ring_emit_ce_meta() and
gfx_v10_0_ring_emit_de_meta.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 399 ++++++++++++-----------
 2 files changed, 204 insertions(+), 197 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 4f467864ed09..1b428dda706a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -611,7 +611,7 @@ amdgpu_ring_write11(struct amdgpu_ring *ring,
 			  NULL)(__VA_ARGS__)
 
 static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
-					      void *src, int count_dw)
+					      const void *src, int count_dw)
 {
 	unsigned occupied, chunk1, chunk2;
 	u32 buf_mask = ring->buf_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 003522c2d902..63fc94c5d989 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3683,15 +3683,16 @@ static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue
 	/* Cleaner shader MC address */
 	shader_mc_addr = adev->gfx.cleaner_shader_gpu_addr >> 8;
 
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
-	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
-			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
-	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3(PACKET3_SET_RESOURCES, 6),
+			  PACKET3_SET_RESOURCES_VMID_MASK(0) |
+			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0),	/* vmid_mask:0 queue_type:0 (KIQ) */
+			  lower_32_bits(queue_mask),	/* queue mask lo */
+			  upper_32_bits(queue_mask),	/* queue mask hi */
+			  lower_32_bits(shader_mc_addr), /* cleaner shader addr lo */
+			  upper_32_bits(shader_mc_addr), /* cleaner shader addr hi */
+			  0,	/* oac mask */
+			  0);	/* gds heap base:0, gds heap size:0 */
 }
 
 static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
@@ -3715,10 +3716,9 @@ static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 		WARN_ON(1);
 	}
 
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
-	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
-	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
-			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3(PACKET3_MAP_QUEUES, 5),
+			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
 			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
 			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
 			  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
@@ -3726,12 +3726,12 @@ static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
 			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
 			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
-			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
-	amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+			  PACKET3_MAP_QUEUES_NUM_QUEUES(1), /* num_queues: must be 1 */
+			  PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index),
+			  lower_32_bits(mqd_addr),
+			  upper_32_bits(mqd_addr),
+			  lower_32_bits(wptr_addr),
+			  upper_32_bits(wptr_addr));
 }
 
 static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
@@ -3741,23 +3741,21 @@ static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 {
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
-	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3(PACKET3_UNMAP_QUEUES, 4),
 			  PACKET3_UNMAP_QUEUES_ACTION(action) |
 			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
 			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
-			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
-	amdgpu_ring_write(kiq_ring,
-		  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
+			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1) /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */,
+			  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
 
 	if (action == PREEMPT_QUEUES_NO_UNMAP) {
-		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
-		amdgpu_ring_write(kiq_ring, seq);
+		amdgpu_ring_write(kiq_ring,
+				  lower_32_bits(gpu_addr),
+				  upper_32_bits(gpu_addr),
+				  seq);
 	} else {
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
-		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_fill(kiq_ring, 0, 3);
 	}
 }
 
@@ -3768,18 +3766,17 @@ static void gfx10_kiq_query_status(struct amdgpu_ring *kiq_ring,
 {
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_QUERY_STATUS, 5));
 	amdgpu_ring_write(kiq_ring,
+			  PACKET3(PACKET3_QUERY_STATUS, 5),
 			  PACKET3_QUERY_STATUS_CONTEXT_ID(0) |
 			  PACKET3_QUERY_STATUS_INTERRUPT_SEL(0) |
-			  PACKET3_QUERY_STATUS_COMMAND(2));
-	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_QUERY_STATUS_COMMAND(2), /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
 			  PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
-			  PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
-	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
-	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+			  PACKET3_QUERY_STATUS_ENG_SEL(eng_sel),
+			  lower_32_bits(addr),
+			  upper_32_bits(addr),
+			  lower_32_bits(seq),
+			  upper_32_bits(seq));
 }
 
 static void gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
@@ -3918,12 +3915,13 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 static void gfx_v10_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
 				       bool wc, uint32_t reg, uint32_t val)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
-			  WRITE_DATA_DST_SEL(0) | (wc ? WR_CONFIRM : 0));
-	amdgpu_ring_write(ring, reg);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, val);
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_WRITE_DATA, 3),
+			  WRITE_DATA_ENGINE_SEL(eng_sel) |
+			  WRITE_DATA_DST_SEL(0) | (wc ? WR_CONFIRM : 0),
+			  reg,
+			  0,
+			  val);
 }
 
 static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
@@ -3931,21 +3929,21 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				  uint32_t addr1, uint32_t ref, uint32_t mask,
 				  uint32_t inv)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
+	if (mem_space)
+		BUG_ON(addr0 & 0x3); /* Dword align */
+
 	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_WAIT_REG_MEM, 5),
 			  /* memory (1) or register (0) */
 			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
 			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
 			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
-
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
-	amdgpu_ring_write(ring, addr0);
-	amdgpu_ring_write(ring, addr1);
-	amdgpu_ring_write(ring, ref);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, inv); /* poll interval */
+			   WAIT_REG_MEM_ENGINE(eng_sel)),
+			  addr0,
+			  addr1,
+			  ref,
+			  mask,
+			  inv); /* poll interval */
 }
 
 static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
@@ -3964,10 +3962,11 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 		return r;
 	}
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
-	amdgpu_ring_write(ring, scratch -
-			  PACKET3_SET_UCONFIG_REG_START);
-	amdgpu_ring_write(ring, 0xDEADBEEF);
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_SET_UCONFIG_REG, 1),
+			  scratch - PACKET3_SET_UCONFIG_REG_START,
+			  0xDEADBEEF);
+
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -6239,8 +6238,8 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	struct amdgpu_ring *ring;
 	const struct cs_section_def *sect = NULL;
 	const struct cs_extent_def *ext = NULL;
-	int r, i;
 	int ctx_reg_offset;
+	int r;
 
 	/* init the CP */
 	WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT,
@@ -6256,43 +6255,46 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 		return r;
 	}
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	amdgpu_ring_write(ring, PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_PREAMBLE_CNTL, 0),
+			  PACKET3_PREAMBLE_BEGIN_CLEAR_STATE,
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	amdgpu_ring_write(ring, 0x80000000);
-	amdgpu_ring_write(ring, 0x80000000);
+			  PACKET3(PACKET3_CONTEXT_CONTROL, 1),
+			  0x80000000,
+			  0x80000000);
 
 	for (sect = gfx10_cs_data; sect->section != NULL; ++sect) {
 		for (ext = sect->section; ext->extent != NULL; ++ext) {
 			if (sect->id == SECT_CONTEXT) {
 				amdgpu_ring_write(ring,
 						  PACKET3(PACKET3_SET_CONTEXT_REG,
-							  ext->reg_count));
-				amdgpu_ring_write(ring, ext->reg_index -
+							  ext->reg_count),
+						  ext->reg_index -
 						  PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					amdgpu_ring_write(ring, ext->extent[i]);
+				amdgpu_ring_write_multiple(ring, ext->extent,
+							   ext->reg_count);
 			}
 		}
 	}
 
 	ctx_reg_offset =
 		SOC15_REG_OFFSET(GC, 0, mmPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
-	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONTEXT_REG, 1));
-	amdgpu_ring_write(ring, ctx_reg_offset);
-	amdgpu_ring_write(ring, adev->gfx.config.pa_sc_tile_steering_override);
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	amdgpu_ring_write(ring, PACKET3_PREAMBLE_END_CLEAR_STATE);
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_SET_CONTEXT_REG, 1),
+			   ctx_reg_offset,
+			   adev->gfx.config.pa_sc_tile_steering_override,
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
-	amdgpu_ring_write(ring, 0);
+			   PACKET3(PACKET3_PREAMBLE_CNTL, 0),
+			   PACKET3_PREAMBLE_END_CLEAR_STATE,
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_BASE, 2));
-	amdgpu_ring_write(ring, PACKET3_BASE_INDEX(CE_PARTITION_BASE));
-	amdgpu_ring_write(ring, 0x8000);
-	amdgpu_ring_write(ring, 0x8000);
+			   PACKET3(PACKET3_CLEAR_STATE, 0),
+			   0,
+
+			   PACKET3(PACKET3_SET_BASE, 2),
+			   PACKET3_BASE_INDEX(CE_PARTITION_BASE),
+			   0x8000,
+			   0x8000);
 
 	amdgpu_ring_commit(ring);
 
@@ -6306,9 +6308,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 			return r;
 		}
 
-		amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
-		amdgpu_ring_write(ring, 0);
-
+		amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0), 0);
 		amdgpu_ring_commit(ring);
 	}
 	return 0;
@@ -8564,6 +8564,8 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 header, control = 0;
 
+	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+
 	if (ib->flags & AMDGPU_IB_FLAG_CE)
 		header = PACKET3(PACKET3_INDIRECT_BUFFER_CNST, 2);
 	else
@@ -8582,15 +8584,14 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 	}
 
-	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
+			  header,
 #ifdef __BIG_ENDIAN
-		(2 << 0) |
+			  (2 << 0) |
 #endif
-		lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, control);
+			  lower_32_bits(ib->gpu_addr),
+			  upper_32_bits(ib->gpu_addr),
+			  control);
 }
 
 static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
@@ -8601,6 +8602,8 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
 	u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
 
+	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+
 	/* Currently, there is a high possibility to get wave ID mismatch
 	 * between ME and GDS, leading to a hw deadlock, because ME generates
 	 * different wave IDs than the GDS expects. This situation happens
@@ -8612,20 +8615,20 @@ static void gfx_v10_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	 * GDS to 0 for this ring (me/pipe).
 	 */
 	if (ib->flags & AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONFIG_REG, 1));
-		amdgpu_ring_write(ring, mmGDS_COMPUTE_MAX_WAVE_ID);
-		amdgpu_ring_write(ring, ring->adev->gds.gds_compute_max_wave_id);
+		amdgpu_ring_write(ring,
+				  PACKET3(PACKET3_SET_CONFIG_REG, 1),
+				  mmGDS_COMPUTE_MAX_WAVE_ID,
+				  ring->adev->gds.gds_compute_max_wave_id);
 	}
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_INDIRECT_BUFFER, 2),
 #ifdef __BIG_ENDIAN
-				(2 << 0) |
+			  (2 << 0) |
 #endif
-				lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, control);
+			  lower_32_bits(ib->gpu_addr),
+			  upper_32_bits(ib->gpu_addr),
+			  control);
 }
 
 static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
@@ -8634,18 +8637,6 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 
-	/* RELEASE_MEM - flush caches, send int */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
-	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
-				 PACKET3_RELEASE_MEM_GCR_GL2_WB |
-				 PACKET3_RELEASE_MEM_GCR_GLM_INV | /* must be set with GLM_WB */
-				 PACKET3_RELEASE_MEM_GCR_GLM_WB |
-				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
-				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
-	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
-				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
-
 	/*
 	 * the address should be Qword aligned if 64bit write, Dword
 	 * aligned if only send 32bit data low (discard data high)
@@ -8654,11 +8645,24 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 		BUG_ON(addr & 0x7);
 	else
 		BUG_ON(addr & 0x3);
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
-	amdgpu_ring_write(ring, upper_32_bits(seq));
-	amdgpu_ring_write(ring, 0);
+
+	amdgpu_ring_write(ring,
+			  /* RELEASE_MEM - flush caches, send int */
+			  PACKET3(PACKET3_RELEASE_MEM, 6),
+			  (PACKET3_RELEASE_MEM_GCR_SEQ |
+			   PACKET3_RELEASE_MEM_GCR_GL2_WB |
+			   PACKET3_RELEASE_MEM_GCR_GLM_INV | /* must be set with GLM_WB */
+			   PACKET3_RELEASE_MEM_GCR_GLM_WB |
+			   PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
+			   PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
+			   PACKET3_RELEASE_MEM_EVENT_INDEX(5)),
+			  (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
+			   PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)),
+			  lower_32_bits(addr),
+			  upper_32_bits(addr),
+			  lower_32_bits(seq),
+			  upper_32_bits(seq),
+			  0);
 }
 
 static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -8675,8 +8679,8 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 				   uint16_t pasid, uint32_t flush_type,
 				   bool all_hub, uint8_t dst_sel)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
 	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_INVALIDATE_TLBS, 0),
 			  PACKET3_INVALIDATE_TLBS_DST_SEL(dst_sel) |
 			  PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
 			  PACKET3_INVALIDATE_TLBS_PASID(pasid) |
@@ -8691,8 +8695,7 @@ static void gfx_v10_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	/* compute doesn't have PFP */
 	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
 		/* sync PFP to ME, otherwise we might get invalid PFP reads */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
-		amdgpu_ring_write(ring, 0x0);
+		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0), 0);
 	}
 }
 
@@ -8705,40 +8708,42 @@ static void gfx_v10_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
 
 	/* write fence seq to the "addr" */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, lower_32_bits(seq));
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_WRITE_DATA, 3),
+			  (WRITE_DATA_ENGINE_SEL(0) | WRITE_DATA_DST_SEL(5) |
+			   WR_CONFIRM),
+			  lower_32_bits(addr),
+			  upper_32_bits(addr),
+			  lower_32_bits(seq));
 
 	if (flags & AMDGPU_FENCE_FLAG_INT) {
 		/* set register to trigger INT */
-		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-		amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-					 WRITE_DATA_DST_SEL(0) | WR_CONFIRM));
-		amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmCPC_INT_STATUS));
-		amdgpu_ring_write(ring, 0);
-		amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
+		amdgpu_ring_write(ring,
+				  PACKET3(PACKET3_WRITE_DATA, 3),
+				  (WRITE_DATA_ENGINE_SEL(0) |
+				   WRITE_DATA_DST_SEL(0) |
+				   WR_CONFIRM),
+				  SOC15_REG_OFFSET(GC, 0, mmCPC_INT_STATUS),
+				  0,
+				  0x20000000); /* src_id is 178 */
 	}
 }
 
 static void gfx_v10_0_ring_emit_sb(struct amdgpu_ring *ring)
 {
-	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0));
-	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0), 0);
 }
 
 static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 					 uint32_t flags)
 {
-	uint32_t dw2 = 0;
+	uint32_t dw2;
 
 	if (ring->adev->gfx.mcbp)
 		gfx_v10_0_ring_emit_ce_meta(ring,
 				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 
-	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
+	dw2 = 0x80000000; /* set load_enable otherwise this package is just NOPs */
 	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
 		/* set load_global_config & load_global_uconfig */
 		dw2 |= 0x8001;
@@ -8758,9 +8763,7 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 			dw2 |= 0x10000000;
 	}
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	amdgpu_ring_write(ring, dw2);
-	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1), dw2, 0);
 }
 
 static unsigned int gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
@@ -8768,11 +8771,12 @@ static unsigned int gfx_v10_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
 {
 	unsigned int ret;
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
-	amdgpu_ring_write(ring, lower_32_bits(addr));
-	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_COND_EXEC, 3),
+			  lower_32_bits(addr),
+			  upper_32_bits(addr),
 	/* discard following DWs if *cond_exec_gpu_addr==0 */
-	amdgpu_ring_write(ring, 0);
+			  0);
 	ret = ring->wptr & ring->buf_mask;
 	/* patch dummy value later */
 	amdgpu_ring_write(ring, 0);
@@ -8839,22 +8843,21 @@ static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 
 	offset = offsetof(struct v10_gfx_meta_data, ce_payload);
 	ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
-	ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
-
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
-				 WRITE_DATA_DST_SEL(8) |
-				 WR_CONFIRM) |
-				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
 
 	if (resume)
-		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
-					   sizeof(ce_payload) >> 2);
+		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
 	else
-		amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
-					   sizeof(ce_payload) >> 2);
+		ce_payload_cpu_addr = (void *)&ce_payload;
+
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_WRITE_DATA, cnt),
+			  (WRITE_DATA_ENGINE_SEL(2) | WRITE_DATA_DST_SEL(8) |
+			   WR_CONFIRM) | WRITE_DATA_CACHE_POLICY(0),
+			  lower_32_bits(ce_payload_gpu_addr),
+			  upper_32_bits(ce_payload_gpu_addr));
+
+	amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
+				   sizeof(ce_payload) >> 2);
 }
 
 static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
@@ -8867,7 +8870,10 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 
 	offset = offsetof(struct v10_gfx_meta_data, de_payload);
 	de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
-	de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	if (resume)
+		de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
+	else
+		de_payload_cpu_addr = (void *)&de_payload;
 
 	gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
 			 AMDGPU_CSA_SIZE - adev->gds.gds_size,
@@ -8877,20 +8883,15 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
 
 	cnt = (sizeof(de_payload) >> 2) + 4 - 2;
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
-	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(1) |
-				 WRITE_DATA_DST_SEL(8) |
-				 WR_CONFIRM) |
-				 WRITE_DATA_CACHE_POLICY(0));
-	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_WRITE_DATA, cnt),
+			  (WRITE_DATA_ENGINE_SEL(1) | WRITE_DATA_DST_SEL(8) |
+			   WR_CONFIRM) | WRITE_DATA_CACHE_POLICY(0),
+			  lower_32_bits(de_payload_gpu_addr),
+			  upper_32_bits(de_payload_gpu_addr));
 
-	if (resume)
-		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
-					   sizeof(de_payload) >> 2);
-	else
-		amdgpu_ring_write_multiple(ring, (void *)&de_payload,
-					   sizeof(de_payload) >> 2);
+	amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
+				   sizeof(de_payload) >> 2);
 }
 
 static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
@@ -8898,31 +8899,32 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
 {
 	uint32_t v = secure ? FRAME_TMZ : 0;
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_FRAME_CONTROL, 0),
+			  v | FRAME_CMD(start ? 0 : 1));
 }
 
 static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 				     uint32_t reg_val_offs)
 {
 	struct amdgpu_device *adev = ring->adev;
+	u64 gpu_addr = adev->wb.gpu_addr + reg_val_offs * 4;
 
-	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
-	amdgpu_ring_write(ring, 0 |	/* src: register*/
-				(5 << 8) |	/* dst: memory */
-				(1 << 20));	/* write confirm */
-	amdgpu_ring_write(ring, reg);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
-	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
-				reg_val_offs * 4));
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_COPY_DATA, 4),
+			  0 |		/* src: register*/
+			  (5 << 8) |	/* dst: memory */
+			  (1 << 20),	/* write confirm */
+			  reg,
+			  0,
+			  lower_32_bits(gpu_addr),
+			  upper_32_bits(gpu_addr));
 }
 
 static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 				   uint32_t val)
 {
-	uint32_t cmd = 0;
+	uint32_t cmd;
 
 	switch (ring->funcs->type) {
 	case AMDGPU_RING_TYPE_GFX:
@@ -8935,11 +8937,13 @@ static void gfx_v10_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 		cmd = WR_CONFIRM;
 		break;
 	}
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
-	amdgpu_ring_write(ring, cmd);
-	amdgpu_ring_write(ring, reg);
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, val);
+
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_WRITE_DATA, 3),
+			  cmd,
+			  reg,
+			  0,
+			  val);
 }
 
 static void gfx_v10_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
@@ -9416,15 +9420,17 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(1) |
 			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(1);
 
-	/* ACQUIRE_MEM - make one or more surfaces valid for use by the subsequent operations */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_ACQUIRE_MEM, 6));
-	amdgpu_ring_write(ring, 0); /* CP_COHER_CNTL */
-	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
-	amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
-	amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
-	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
-	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
-	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
+
+	amdgpu_ring_write(ring,
+			  /* ACQUIRE_MEM - make one or more surfaces valid for use by the subsequent operations */
+			  PACKET3(PACKET3_ACQUIRE_MEM, 6),
+			  0, /* CP_COHER_CNTL */
+			  0xffffffff,  /* CP_COHER_SIZE */
+			  0xffffff,  /* CP_COHER_SIZE_HI */
+			  0, /* CP_COHER_BASE */
+			  0,  /* CP_COHER_BASE_HI */
+			  0x0000000A, /* POLL_INTERVAL */
+			  gcr_cntl); /* GCR_CNTL */
 }
 
 static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
@@ -9726,8 +9732,9 @@ static void gfx_v10_ip_dump(struct amdgpu_ip_block *ip_block)
 static void gfx_v10_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 {
 	/* Emit the cleaner shader */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
-	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+	amdgpu_ring_write(ring,
+			  PACKET3(PACKET3_RUN_CLEANER_SHADER, 0),
+			  0);  /* RESERVED field, programmed to zero */
 }
 
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
-- 
2.47.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D4FCCFA11
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B674C10E5F5;
	Tue,  4 Nov 2025 14:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="StwqOq3I";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA7010E5F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YnYU4vhsa+64NpxgB7sJZeMLyEhdBvvzZrC+43K89SU=; b=StwqOq3I9AFt/Le5l2YhAil7kj
 1nHXChrZSpiM+Go/InhFQBZvYo+bXhVOlXHhXgTxpfkN/EJIYn05T2rrSpq9JP78pPoh4FWG+8koi
 FfHmrioqmtRb6OcYkpO4whJq3+hqTYkg5MUGRBIWRiBkRLdT9CG7R5psg3yRsQAmMyCIj9gp6GgQT
 ElDBSVFq/gMKCbxeogj0RjtxxqxyU7yn6jD73u7G6ylBW6LHug4a3ufZsLUrpvKI07WP7uQfSIj5v
 xD24q6k/q3AbQgTRUAngxq9zbL+3mNwW800+iOW2dKdO1Gdj+DECay/f+Depo2rJeIcN+P5daFhjB
 IeU2TiXg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgB-001OEm-3Y; Tue, 04 Nov 2025 15:06:35 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 07/25] drm/amdgpu/sdma5.2: Use local variables more
Date: Tue,  4 Nov 2025 14:04:03 +0000
Message-ID: <20251104140421.88520-8-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
References: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
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

Lets apply a few simple strategies to make the code a bit more readable
and compact. For example we cache some verbose register offset
calculations, static values from repeatedly dereferenced pointers, where
some of the latter are sometimes already being used but not consistently
so.

It is not a huge saving but if the principle would be applied to all of
the hwip families and version would be more interesting:

add/remove: 0/0 grow/shrink: 2/8 up/down: 42/-1454 (-1412)
Function                                     old     new   delta
sdma_v5_2_ring_get_wptr                      280     321     +41
sdma_v5_2_ring_emit_vm_flush                 381     382      +1
sdma_v5_2_mqd_init                           196     195      -1
sdma_v5_2_ring_emit_ib                       446     439      -7
sdma_v5_2_ring_set_wptr                      518     428     -90
sdma_v5_2_restore_queue                      243     149     -94
sdma_v5_2_enable                             303     199    -104
sdma_v5_2_gfx_stop                           695     505    -190
sdma_v5_2_stop_queue                         988     676    -312
sdma_v5_2_set_clockgating_state             1299     643    -656
Total: Before=8979017, After=8977605, chg -0.02%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 185 +++++++++++++------------
 1 file changed, 100 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 3bd44c24f692..65ff04a72df0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -185,6 +185,7 @@ static uint64_t sdma_v5_2_ring_get_rptr(struct amdgpu_ring *ring)
 static uint64_t sdma_v5_2_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int inst_id = ring->me;
 	u64 wptr;
 
 	if (ring->use_doorbell) {
@@ -192,10 +193,10 @@ static uint64_t sdma_v5_2_ring_get_wptr(struct amdgpu_ring *ring)
 		wptr = READ_ONCE(*((u64 *)ring->wptr_cpu_addr));
 		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
-		wptr = RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
+		wptr = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_RB_WPTR_HI));
 		wptr = wptr << 32;
-		wptr |= RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
-		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", ring->me, wptr);
+		wptr |= RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_RB_WPTR));
+		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", inst_id, wptr);
 	}
 
 	return wptr >> 2;
@@ -211,6 +212,8 @@ static uint64_t sdma_v5_2_ring_get_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	unsigned int inst_id = ring->me;
+	u64 wptr = ring->wptr;
 
 	DRM_DEBUG("Setting write pointer\n");
 	if (ring->use_doorbell) {
@@ -219,36 +222,35 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 				"lower_32_bits(ring->wptr << 2) == 0x%08x "
 				"upper_32_bits(ring->wptr << 2) == 0x%08x\n",
 				ring->wptr_offs,
-				lower_32_bits(ring->wptr << 2),
-				upper_32_bits(ring->wptr << 2));
+				lower_32_bits(wptr << 2),
+				upper_32_bits(wptr << 2));
 		/* XXX check if swapping is necessary on BE */
-		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
-			     ring->wptr << 2);
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr << 2);
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
-				ring->doorbell_index, ring->wptr << 2);
-		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+				ring->doorbell_index, wptr << 2);
+		WDOORBELL64(ring->doorbell_index, wptr << 2);
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(5, 2, 1)) {
 			/* SDMA seems to miss doorbells sometimes when powergating kicks in.
 			 * Updating the wptr directly will wake it. This is only safe because
 			 * we disallow gfxoff in begin_use() and then allow it again in end_use().
 			 */
-			WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
-			       lower_32_bits(ring->wptr << 2));
-			WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
-			       upper_32_bits(ring->wptr << 2));
+			WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_RB_WPTR),
+			       lower_32_bits(wptr << 2));
+			WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_RB_WPTR_HI),
+			       upper_32_bits(wptr << 2));
 		}
 	} else {
 		DRM_DEBUG("Not using doorbell -- "
 				"mmSDMA%i_GFX_RB_WPTR == 0x%08x "
 				"mmSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
-				ring->me,
-				lower_32_bits(ring->wptr << 2),
-				ring->me,
-				upper_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
-			lower_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
-			upper_32_bits(ring->wptr << 2));
+				inst_id,
+				lower_32_bits(wptr << 2),
+				inst_id,
+				upper_32_bits(wptr << 2));
+		WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_RB_WPTR),
+		       lower_32_bits(wptr << 2));
+		WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_RB_WPTR_HI),
+		       upper_32_bits(wptr << 2));
 	}
 }
 
@@ -281,7 +283,8 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
 				   uint32_t flags)
 {
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
-	uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring, vmid);
+	u64 csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring, vmid);
+	u64 gpu_addr = ib->gpu_addr;
 
 	/* An IB packet must end on a 8 DW boundary--the next dword
 	 * must be on a 8-dword boundary. Our IB packet below is 6
@@ -296,8 +299,8 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
 	/* base must be 32 byte aligned */
-	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr) & 0xffffffe0);
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, lower_32_bits(gpu_addr) & 0xffffffe0);
+	amdgpu_ring_write(ring, upper_32_bits(gpu_addr));
 	amdgpu_ring_write(ring, ib->length_dw);
 	amdgpu_ring_write(ring, lower_32_bits(csa_mc_addr));
 	amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));
@@ -338,13 +341,14 @@ static void sdma_v5_2_ring_emit_mem_sync(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 ref_and_mask = 0;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+	unsigned int inst_id = ring->me;
+	u32 ref_and_mask = 0;
 
-	if (ring->me > 1) {
+	if (inst_id > 1) {
 		amdgpu_asic_flush_hdp(adev, ring);
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
+		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << inst_id;
 
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 				  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
@@ -412,16 +416,20 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
  */
 static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev,  uint32_t inst_mask)
 {
-	u32 rb_cntl, ib_cntl;
 	int i;
 
 	for_each_inst(i, inst_mask) {
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+		u32 reg, cntl;
+
+		reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL);
+		cntl = RREG32_SOC15_IP(GC, reg);
+		cntl = REG_SET_FIELD(cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
+		WREG32_SOC15_IP(GC, reg, cntl);
+
+		reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL);
+		cntl = RREG32_SOC15_IP(GC, reg);
+		cntl = REG_SET_FIELD(cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
+		WREG32_SOC15_IP(GC, reg, cntl);
 	}
 }
 
@@ -504,21 +512,22 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
  */
 static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 {
-	u32 f32_cntl;
-	int i;
-	uint32_t inst_mask;
-
-	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!enable) {
-		sdma_v5_2_gfx_stop(adev, inst_mask);
+		sdma_v5_2_gfx_stop(adev,
+				   GENMASK(adev->sdma.num_instances - 1, 0));
 		sdma_v5_2_rlc_stop(adev);
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
+		int i;
+
 		for (i = 0; i < adev->sdma.num_instances; i++) {
-			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+			u32 f32_reg, f32_cntl;
+
+			f32_reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL);
+			f32_cntl = RREG32(f32_reg);
 			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+			WREG32(f32_reg, f32_cntl);
 		}
 	}
 }
@@ -861,7 +870,7 @@ static int sdma_v5_2_mqd_init(struct amdgpu_device *adev, void *mqd,
 			      struct amdgpu_mqd_prop *prop)
 {
 	struct v10_sdma_mqd *m = mqd;
-	uint64_t wb_gpu_addr;
+	u64 gpu_addr;
 
 	m->sdmax_rlcx_rb_cntl =
 		order_base_2(prop->queue_size / 4) << SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
@@ -869,19 +878,20 @@ static int sdma_v5_2_mqd_init(struct amdgpu_device *adev, void *mqd,
 		6 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
 		1 << SDMA0_RLC0_RB_CNTL__RB_PRIV__SHIFT;
 
-	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
-	m->sdmax_rlcx_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+	gpu_addr = prop->hqd_base_gpu_addr;
+	m->sdmax_rlcx_rb_base = lower_32_bits(gpu_addr >> 8);
+	m->sdmax_rlcx_rb_base_hi = upper_32_bits(gpu_addr >> 8);
 
 	m->sdmax_rlcx_rb_wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, 0,
 						  mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
 
-	wb_gpu_addr = prop->wptr_gpu_addr;
-	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits(wb_gpu_addr);
-	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr);
+	gpu_addr = prop->wptr_gpu_addr;
+	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits(gpu_addr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits(gpu_addr);
 
-	wb_gpu_addr = prop->rptr_gpu_addr;
-	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
-	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
+	gpu_addr = prop->rptr_gpu_addr;
+	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(gpu_addr);
+	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(gpu_addr);
 
 	m->sdmax_rlcx_ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, 0,
 							mmSDMA0_GFX_IB_CNTL));
@@ -1193,13 +1203,14 @@ static void sdma_v5_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
 {
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+	uint32_t ctx_addr_distance = hub->ctx_addr_distance;
 
 	/* Update the PD address for this VMID. */
 	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
+			      ctx_addr_distance * vmid,
 			      lower_32_bits(pd_addr));
 	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
+			      ctx_addr_distance * vmid,
 			      upper_32_bits(pd_addr));
 
 	/* Trigger invalidation. */
@@ -1479,9 +1490,9 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
 {
-	u32 f32_cntl, freeze, cntl, stat1_reg;
 	struct amdgpu_device *adev = ring->adev;
 	int i, j, r = 0;
+	u32 reg, cntl;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1493,35 +1504,39 @@ static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
 	sdma_v5_2_gfx_stop(adev, 1 << i);
 
 	/*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
-	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
-	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE);
+	cntl = RREG32(reg);
+	cntl = REG_SET_FIELD(cntl, SDMA0_FREEZE, FREEZE, 1);
+	WREG32(reg, cntl);
 
 	for (j = 0; j < adev->usec_timeout; j++) {
-		freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+		cntl = RREG32(reg);
 
-		if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
+		if (REG_GET_FIELD(cntl, SDMA0_FREEZE, FROZEN) & 1)
 			break;
 		udelay(1);
 	}
 
 
 	if (j == adev->usec_timeout) {
-		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
-		if ((stat1_reg & 0x3FF) != 0x3FF) {
+		reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG);
+		cntl = RREG32(reg);
+		if ((cntl & 0x3FF) != 0x3FF) {
 			DRM_ERROR("cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
 			goto err0;
 		}
 	}
 
-	f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+	reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL);
+	cntl = RREG32(reg);
+	cntl = REG_SET_FIELD(cntl, SDMA0_F32_CNTL, HALT, 1);
+	WREG32(reg, cntl);
 
-	cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+	reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL);
+	cntl = RREG32(reg);
 	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+	WREG32(reg, cntl);
 
 err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
@@ -1532,14 +1547,15 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
-	u32 freeze;
+	u32 reg, freeze;
 	int r;
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze and unhalt */
-	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
+	reg = sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE);
+	freeze = RREG32(reg);
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
+	WREG32(reg, freeze);
 
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
@@ -1737,67 +1753,66 @@ static bool sdma_v5_2_firmware_mgcg_support(struct amdgpu_device *adev,
 static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 						       bool enable)
 {
-	uint32_t data, def;
+	u32 reg, data, def;
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CLK_CTRL);
 
 		if (!sdma_v5_2_firmware_mgcg_support(adev, i))
 			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
 
+		def = data = RREG32(reg);
+
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
 			/* Enable sdma clock gating */
-			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CLK_CTRL));
 			data &= ~(SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
 				  SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
 				  SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
 				  SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
 				  SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK |
 				  SDMA0_CLK_CTRL__SOFT_OVERRIDER_REG_MASK);
-			if (def != data)
-				WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CLK_CTRL), data);
 		} else {
 			/* Disable sdma clock gating */
-			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CLK_CTRL));
 			data |= (SDMA0_CLK_CTRL__SOFT_OVERRIDE4_MASK |
 				 SDMA0_CLK_CTRL__SOFT_OVERRIDE3_MASK |
 				 SDMA0_CLK_CTRL__SOFT_OVERRIDE2_MASK |
 				 SDMA0_CLK_CTRL__SOFT_OVERRIDE1_MASK |
 				 SDMA0_CLK_CTRL__SOFT_OVERRIDE0_MASK |
 				 SDMA0_CLK_CTRL__SOFT_OVERRIDER_REG_MASK);
-			if (def != data)
-				WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CLK_CTRL), data);
 		}
+
+		if (def != data)
+			WREG32(reg, data);
 	}
 }
 
 static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 						      bool enable)
 {
-	uint32_t data, def;
+	u32 reg, data, def;
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		reg = sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_POWER_CNTL);
+
 		if (adev->sdma.instance[i].fw_version < 70 &&
 		    amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
 			    IP_VERSION(5, 2, 1))
 			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_LS;
 
+		def = data = RREG32(reg);
+
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
 			/* Enable sdma mem light sleep */
-			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_POWER_CNTL));
 			data |= SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (def != data)
-				WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_POWER_CNTL), data);
-
 		} else {
 			/* Disable sdma mem light sleep */
-			def = data = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_POWER_CNTL));
 			data &= ~SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (def != data)
-				WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_POWER_CNTL), data);
-
 		}
+
+		if (def != data)
+			WREG32(reg, data);
 	}
 }
 
-- 
2.48.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007EFCDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 14:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB9510E703;
	Mon, 22 Jun 2026 14:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DrCDZmkO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DFA710E703
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=85WfAZEljk31Matnkz1AWpAgpxvLys0VIysVCCab1C8=; b=DrCDZmkOPJAmrjxx3UvDSPLIUg
 hvyPItRXKhTMPgYQ5o8wkuwqphN2P6OL9jpYfAzed1of9r+37jj1rMRPkN5xIuGGAlML8ygclBHxH
 5ZTGEBZwmGDUL3G/AmGvm11PskOH2A9mup63ZtkX626Dl0HfO6kvIAkNx/tgcEMvQAOVWSODHeOPb
 4c8M8H6NIRQlNH0Poo1yfbvy/0KMBByLL5Mj17DdwArd9io+yiDnwdOvgzVNA3lCQKZWqxGLz5Kt4
 umivXrJJtjfeVcmsn+QqCoCHUZ6e1kK7FEJ4FEyTylehPy8rg/IKcpa0DGCSA2WTqp25JlnDlErOE
 GvWxY9NA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbfld-003mJv-EP; Mon, 22 Jun 2026 16:36:53 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [RFC 1/2] drm/amdgpu: Store SDMA instance and index in the ring
Date: Mon, 22 Jun 2026 15:36:48 +0100
Message-ID: <20260622143649.54632-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622143649.54632-1-tvrtko.ursulin@igalia.com>
References: <20260622143649.54632-1-tvrtko.ursulin@igalia.com>
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

Instead of searching for the matching SDMA instance inside many of the
SDMA ring vfuncs, lets just cache the instance and index in the new SDMA
specific section of struct amdgpu_ring. This converts a function call plus
array walks to a direct lookup.

While at it, we also consolidate the initialization side with a new
amdgpu_sdma_ring_init() helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 51 +++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  6 +--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 11 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 11 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 17 ++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 23 ++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 15 ++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 16 +++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 18 +++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 17 +++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 23 +++++------
 13 files changed, 76 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 71cd9bb12f75..a8900dc50a14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -423,6 +423,12 @@ struct amdgpu_ring {
 	unsigned 		num_hw_submission;
 	atomic_t		*sched_score;
 
+	/* for sdma rings */
+	struct {
+		struct amdgpu_sdma_instance *instance;
+		unsigned int 		    index;
+	} sdma;
+
 	bool            is_sw_ring;
 	unsigned int    entry_index;
 	/* store the cached rptr to restore after reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..1a9f7bd4edc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -37,57 +37,42 @@
  * GPU SDMA IP block helpers function.
  */
 
-struct amdgpu_sdma_instance *amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring)
+int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
+			  const char *prefix, unsigned int index)
 {
-	struct amdgpu_device *adev = ring->adev;
-	int i;
+	int r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++)
-		if (ring == &adev->sdma.instance[i].ring ||
-		    ring == &adev->sdma.instance[i].page)
-			return &adev->sdma.instance[i];
+	ring->ring_obj = NULL;
 
-	return NULL;
-}
+	if (prefix)
+		sprintf(ring->name, "sdma%u", index);
 
-int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int i;
+	r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
+			     AMDGPU_SDMA_IRQ_INSTANCE0 + index,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring ||
-			ring == &adev->sdma.instance[i].page) {
-			*index = i;
-			return 0;
-		}
-	}
+	ring->sdma.instance = &adev->sdma.instance[index];
+	ring->sdma.index = index;
 
-	return -EINVAL;
+	return 0;
 }
 
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 				     unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	uint64_t csa_mc_addr;
-	uint32_t index = 0;
-	int r;
 
 	/* don't enable OS preemption on SDMA under SRIOV */
 	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
 		return 0;
 
-	r = amdgpu_sdma_get_index_from_ring(ring, &index);
+	if (ring->sdma.index < 0 || ring->sdma.index > 31)
+		return 0;
 
-	if (r || index > 31)
-		csa_mc_addr = 0;
-	else
-		csa_mc_addr = amdgpu_csa_vaddr(adev) +
-			AMDGPU_CSA_SDMA_OFFSET +
-			index * AMDGPU_CSA_SDMA_SIZE;
-
-	return csa_mc_addr;
+	return amdgpu_csa_vaddr(adev) + AMDGPU_CSA_SDMA_OFFSET +
+	       ring->sdma.index * AMDGPU_CSA_SDMA_SIZE;
 }
 
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2bf365609775..38b6fd2e20eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -185,15 +185,15 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
+int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
+			  const char *prefix, unsigned int index);
+
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
-struct amdgpu_sdma_instance *
-amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
-int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 120da838ac28..73e534fe3b62 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -197,7 +197,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -796,7 +796,7 @@ static void cik_sdma_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 93ec52c1f367..63adcb49cfad 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -222,7 +222,7 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -732,7 +732,7 @@ static void sdma_v2_4_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -860,13 +860,8 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = false;
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 3fde9be74690..a7a3e13bdddf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -398,7 +398,7 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1005,7 +1005,7 @@ static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1140,7 +1140,6 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		if (!amdgpu_sriov_vf(adev)) {
 			ring->use_doorbell = true;
 			ring->doorbell_index = adev->doorbell_index.sdma_engine[i];
@@ -1148,11 +1147,7 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 			ring->use_pollmem = true;
 		}
 
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index cb64d17000df..2db4e1dbd5c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -782,7 +782,7 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1666,7 +1666,7 @@ static void sdma_v4_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1853,7 +1853,6 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
@@ -1873,16 +1872,12 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
-			ring->ring_obj = NULL;
 			ring->use_doorbell = true;
 
 			/* paging queue use same doorbell index/routing as gfx queue
@@ -1910,11 +1905,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 			else
 				ring->vm_hub = AMDGPU_MMHUB0(0);
 
-			sprintf(ring->name, "page%d", i);
-			r = amdgpu_ring_init(adev, ring, 1024,
-					     &adev->sdma.trap_irq,
-					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-					     AMDGPU_RING_PRIO_DEFAULT, NULL);
+			r = amdgpu_sdma_ring_init(adev, ring, "page", i);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 777a70852883..42ed9ef6fb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -349,7 +349,7 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1262,7 +1262,7 @@ static void sdma_v4_4_2_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v4_4_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1481,7 +1481,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->sdma.instance[i].funcs = &sdma_v4_4_2_sdma_funcs;
 
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		aid_id = adev->sdma.instance[i].aid_id;
 
@@ -1492,18 +1491,15 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 		ring->vm_hub = AMDGPU_MMHUB0(aid_id);
 		ring->no_user_submission = adev->sdma.no_user_submission;
+		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
+		if (r)
+			return r;
 
 		sprintf(ring->name, "sdma%d.%d", aid_id,
 				i % adev->sdma.num_inst_per_aid);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
-		if (r)
-			return r;
 
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
-			ring->ring_obj = NULL;
 			ring->use_doorbell = true;
 
 			/* doorbell index of page queue is assigned right after
@@ -1512,15 +1508,12 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 			ring->doorbell_index =
 				(adev->doorbell_index.sdma_engine[i] + 1) << 1;
 			ring->vm_hub = AMDGPU_MMHUB0(aid_id);
+			r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
+			if (r)
+				return r;
 
 			sprintf(ring->name, "page%d.%d", aid_id,
 					i % adev->sdma.num_inst_per_aid);
-			r = amdgpu_ring_init(adev, ring, 1024,
-					     &adev->sdma.trap_irq,
-					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-					     AMDGPU_RING_PRIO_DEFAULT, NULL);
-			if (r)
-				return r;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index fa02907217e0..670b34a76326 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -405,7 +405,7 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1235,7 +1235,7 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1407,7 +1407,6 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
 		adev->sdma.instance[i].funcs = &sdma_v5_0_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
@@ -1418,11 +1417,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 			: (adev->doorbell_index.sdma_engine[1] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
-				     AMDGPU_SDMA_IRQ_INSTANCE1,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
@@ -1635,11 +1630,9 @@ static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	if (index == 0)
+	if (ring->sdma.index == 0)
 		sdma_gfx_preempt = mmSDMA0_GFX_PREEMPT;
 	else
 		sdma_gfx_preempt = mmSDMA1_GFX_PREEMPT;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f6ecbc524c9b..a307c5a45e09 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -253,7 +253,7 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1135,7 +1135,7 @@ static void sdma_v5_2_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v5_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1326,7 +1326,6 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
 		adev->sdma.instance[i].funcs = &sdma_v5_2_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 
@@ -1337,10 +1336,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); //get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
@@ -1549,12 +1545,10 @@ static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v5_2_get_reg_offset(adev, index, mmSDMA0_GFX_PREEMPT);
+	sdma_gfx_preempt = sdma_v5_2_get_reg_offset(adev, ring->sdma.index,
+						    mmSDMA0_GFX_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d894b7599c18..9aefc4f9b6e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -241,7 +241,7 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1142,7 +1142,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v6_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1347,7 +1347,6 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 		ring->no_user_submission = adev->sdma.no_user_submission;
@@ -1359,11 +1358,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
@@ -1542,12 +1538,10 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v6_0_get_reg_offset(adev, index, regSDMA0_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v6_0_get_reg_offset(adev, ring->sdma.index,
+						    regSDMA0_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index f154b68dda70..fad5b51596ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -243,7 +243,7 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1161,7 +1161,7 @@ static void sdma_v7_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v7_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1331,7 +1331,6 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 		ring->no_user_submission = adev->sdma.no_user_submission;
@@ -1343,11 +1342,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(0);
-		sprintf(ring->name, "sdma%d", i);
-		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
+		r = amdgpu_sdma_ring_init(adev, ring, "sdma", i);
 		if (r)
 			return r;
 	}
@@ -1496,12 +1491,10 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v7_0_get_reg_offset(adev, index, regSDMA0_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v7_0_get_reg_offset(adev, ring->sdma.index,
+						    regSDMA0_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index cd9668605a50..9319d1c00e0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -237,7 +237,7 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v7_1_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1167,7 +1167,7 @@ static void sdma_v7_1_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v7_1_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1312,7 +1312,6 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
 		ring->no_user_submission = adev->sdma.no_user_submission;
@@ -1330,14 +1329,12 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block *ip_block)
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
 		ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
+		r = amdgpu_sdma_ring_init(adev, ring, NULL, i);
+		if (r)
+			return r;
+
 		sprintf(ring->name, "sdma%d.%d", xcc_id,
-				GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc);
-		r = amdgpu_ring_init(adev, ring, 1024,
-				     &adev->sdma.trap_irq,
-				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
-				     AMDGPU_RING_PRIO_DEFAULT, NULL);
-		if (r)
-			return r;
+			GET_INST(SDMA0, i) % adev->sdma.num_inst_per_xcc);
 	}
 
 	adev->sdma.supported_reset =
@@ -1460,12 +1457,10 @@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v7_1_get_reg_offset(adev, index, regSDMA0_SDMA_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v7_1_get_reg_offset(adev, ring->sdma.index,
+						    regSDMA0_SDMA_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
-- 
2.54.0


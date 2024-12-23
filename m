Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68617E7718D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 16:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F6C10E584;
	Mon, 23 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PPSDKvLT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE9F10E583
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7GCdTkE1JcjGUGnCJgGIwDP70kZ18ZvSZvY6jqbdgcw=; b=PPSDKvLTJBQ8h3XsbCz9mEZ+rA
 /G/u97S91xM8lkPo8YskDBQlHJh6VNXeFo+N/KzfVDmeDWNRHH8JGucnQunXRN8h7GgtrkMs8u9oj
 XcNkUi0IeE4oxNpWffuDinxrOIRUuvBKOtnT7pGl7CnH48OK3XnFWYtnyTqIgJgeAOiZTs4je+Wxw
 OuSbziD3RCVYBqwltHl0KK6oEGFRrsW8ctXzQFVLx35KU/ZgkJ3jMvvv7L031eu75NqNTxvDAEfKy
 6OPNi1vD8qjuLvTk75npNExVzpgv9n/knDRID4X1xteufIZxV1GMemKHrGwW+jR/zkeJNmX1c6qi8
 V+ZXXkQQ==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tPlSq-006ttC-LY; Mon, 23 Dec 2024 17:39:28 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Cache SDMA instance and index in the ring
Date: Mon, 23 Dec 2024 16:39:13 +0000
Message-ID: <20241223163913.38767-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223163913.38767-1-tursulin@igalia.com>
References: <20241223163913.38767-1-tursulin@igalia.com>
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

A bunch of SDMA ring vfuncs seem to have a little bit of an identity
crisis not knowing to what SDMA instance they belong and have to
walk the list of instances on every invocation. We can improve that
by simply storing the relevant into in the ring itself.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 39 ++----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 --
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  8 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 11 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 11 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 11 +++----
 13 files changed, 52 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index c3a68eae1c9a..c9bf8849acba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -399,6 +399,21 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			&ring->sched;
 	}
 
+	ring->sdma.instance = NULL;
+	ring->sdma.index = -ENODEV;
+	if (ring->funcs->type == AMDGPU_RING_TYPE_SDMA) {
+		int i;
+
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			if (ring == &adev->sdma.instance[i].ring ||
+			    ring == &adev->sdma.instance[i].page) {
+				ring->sdma.index = i;
+				ring->sdma.instance = &adev->sdma.instance[i];
+				break;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 4a8134b682f7..0fe7ecc3acc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -299,6 +299,12 @@ struct amdgpu_ring {
 	unsigned 		num_hw_submission;
 	atomic_t		*sched_score;
 
+	/* used for sdma */
+	struct {
+		struct amdgpu_sdma_instance *instance;
+		int			     index;
+	} sdma;
+
 	/* used for mes */
 	bool			is_mes_queue;
 	uint32_t		hw_queue_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 632295bf3875..d43dfec82624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -34,42 +34,11 @@
  * GPU SDMA IP block helpers function.
  */
 
-struct amdgpu_sdma_instance *amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++)
-		if (ring == &adev->sdma.instance[i].ring ||
-		    ring == &adev->sdma.instance[i].page)
-			return &adev->sdma.instance[i];
-
-	return NULL;
-}
-
-int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index)
-{
-	struct amdgpu_device *adev = ring->adev;
-	int i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring ||
-			ring == &adev->sdma.instance[i].page) {
-			*index = i;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 				     unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint64_t csa_mc_addr;
-	uint32_t index = 0;
-	int r;
 
 	/* don't enable OS preemption on SDMA under SRIOV */
 	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
@@ -82,14 +51,12 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 				  sdma[ring->idx].sdma_meta_data);
 		csa_mc_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
 	} else {
-		r = amdgpu_sdma_get_index_from_ring(ring, &index);
-
-		if (r || index > 31)
+		if (ring->sdma.index < 0 || ring->sdma.index > 31)
 			csa_mc_addr = 0;
 		else
 			csa_mc_addr = amdgpu_csa_vaddr(adev) +
-				AMDGPU_CSA_SDMA_OFFSET +
-				index * AMDGPU_CSA_SDMA_SIZE;
+				      AMDGPU_CSA_SDMA_OFFSET +
+				      ring->sdma.index * AMDGPU_CSA_SDMA_SIZE;
 	}
 
 	return csa_mc_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2db58b5812a8..7debf3ed0b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -159,9 +159,6 @@ struct amdgpu_buffer_funcs {
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
-struct amdgpu_sdma_instance *
-amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
-int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 275494e6cc8e..0d80dd8bfd18 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -199,7 +199,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -799,7 +799,7 @@ static void cik_sdma_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 7e1498a60f01..ca46674a3481 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -735,7 +735,7 @@ static void sdma_v2_4_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index eae8310407eb..aa9ddb628534 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -399,7 +399,7 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -1008,7 +1008,7 @@ static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 68120baafbbd..e1680fd8b17e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -783,7 +783,7 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -1669,7 +1669,7 @@ static void sdma_v4_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 076a07400db6..452c6f31f702 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -343,7 +343,7 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -1236,7 +1236,7 @@ static void sdma_v4_4_2_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v4_4_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 97079c63e462..359acd1d7334 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -435,7 +435,7 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -1300,7 +1300,7 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1662,11 +1662,9 @@ static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
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
index 8913f3ed4e2f..fdbaedc6c2ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -252,7 +252,7 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -1157,7 +1157,7 @@ static void sdma_v5_2_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v5_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1565,12 +1565,11 @@ static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v5_2_get_reg_offset(adev, index, mmSDMA0_GFX_PREEMPT);
+	sdma_gfx_preempt = sdma_v5_2_get_reg_offset(adev,
+						    ring->sdma.index,
+						    mmSDMA0_GFX_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index f2b04adfebdc..7ab4d62255e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -237,7 +237,7 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -1169,7 +1169,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v6_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1466,12 +1466,11 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v6_0_get_reg_offset(adev, index, regSDMA0_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v6_0_get_reg_offset(adev,
+						    ring->sdma.index,
+						    regSDMA0_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ce2af42a9289..80485d5c8051 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -269,7 +269,7 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	const u32 nop = ring->funcs->nop;
 
 	if (count && sdma && sdma->burst_nop)
@@ -1218,7 +1218,7 @@ static void sdma_v7_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v7_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1468,12 +1468,11 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v7_0_get_reg_offset(adev, index, regSDMA0_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v7_0_get_reg_offset(adev,
+						    ring->sdma.index,
+						    regSDMA0_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
-- 
2.47.1


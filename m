Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2246E77195
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C451310E3AB;
	Fri, 27 Dec 2024 11:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZoocBhK5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A9110E3A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dgsylOcCR86EuT17fnBauBw3xKnuZLW+0EYx1Gckd/4=; b=ZoocBhK5T2ojI6TdXAZh9jfCBZ
 xiid0tTD1JYEUidd8C4AK5KUZfvIy0ysz0XlLNk/Q0tUMW6XL6E2FIIeHflZLzy2D4bgqMZL3FLWb
 KT4fShC0VKxVZm7w3hdWtCm2Qr52QYk0gANqVxqnWp3p4r2gOUR/pxITObrgqf1sz1i8DRqC2HBS1
 trEfPg9s7Zx0kx4CVMbQASM6aedRF9w/eyK0EMbs7evpdyWR2661yDCEdr/sqjVw4WMqGGV2Arvjk
 VkISyQBJPTvhVBnWfMcFlPHGHpbW1q2e1rjhKj8Pd01dAr8P/8BnJI7PaaBOrvlefV2SSNPtfeeJZ
 fLHW+1Ag==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nj-008EGP-Qk; Fri, 27 Dec 2024 12:19:51 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 03/12] drm/amdgpu: Cache SDMA instance and index in the ring
Date: Fri, 27 Dec 2024 11:19:29 +0000
Message-ID: <20241227111938.22974-4-tursulin@igalia.com>
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

A bunch of SDMA ring vfuncs seem to have a little bit of an identity
crisis not knowing to what SDMA instance they belong and have to
walk the list of instances on every invocation. We can improve that
by simply storing the relevant into in the ring itself.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 39 ++----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 --
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  7 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  7 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 10 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 11 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 14 +++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 14 +++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 14 +++++----
 13 files changed, 70 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a27e32f48f99..8e4e9ec68262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -386,6 +386,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			&ring->sched;
 	}
 
+	/* SDMA "sub-class" will override */
+	ring->sdma.index = -ENODEV;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 96bfc0c23413..429c77db920f 100644
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
index d9bd8f3f17e2..b8d9a32b07f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -199,7 +199,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -798,7 +798,7 @@ static void cik_sdma_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 135c5099bfb8..2e844dba4ad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -223,7 +223,7 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -733,7 +733,7 @@ static void sdma_v2_4_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -863,6 +863,9 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
 			return r;
+
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c611328671ed..104fd1214c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -399,7 +399,7 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1006,7 +1006,7 @@ static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
  */
 static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1149,6 +1149,9 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
 			return r;
+
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b48d9c0b2e1c..c91d05a4593e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -783,7 +783,7 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1667,7 +1667,7 @@ static void sdma_v4_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1874,6 +1874,9 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
+
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
 			ring->ring_obj = NULL;
@@ -1911,6 +1914,9 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 					     AMDGPU_RING_PRIO_DEFAULT, NULL);
 			if (r)
 				return r;
+
+			ring->sdma.instance = &adev->sdma.instance[i];
+			ring->sdma.index = i;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 56507ae919b0..d1d21a3951f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -343,7 +343,7 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1234,7 +1234,7 @@ static void sdma_v4_4_2_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v4_4_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1429,6 +1429,9 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
+
 		if (adev->sdma.has_page_queue) {
 			ring = &adev->sdma.instance[i].page;
 			ring->ring_obj = NULL;
@@ -1449,6 +1452,9 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 					     AMDGPU_RING_PRIO_DEFAULT, NULL);
 			if (r)
 				return r;
+
+			ring->sdma.instance = &adev->sdma.instance[i];
+			ring->sdma.index = i;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b764550834a0..97536f82dfcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -435,7 +435,7 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1298,7 +1298,7 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1450,6 +1450,9 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
 			return r;
+
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
 	}
 
 	adev->sdma.supported_reset =
@@ -1660,11 +1663,9 @@ static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
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
index b1818e87889a..8eaddee1d97d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -252,7 +252,7 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1155,7 +1155,7 @@ static void sdma_v5_2_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v5_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1355,6 +1355,9 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
 			return r;
+
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
 	}
 
 	adev->sdma.supported_reset =
@@ -1563,12 +1566,11 @@ static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
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
index 1a023b45f0be..3ead269eccdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -237,7 +237,7 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1167,7 +1167,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v6_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1348,6 +1348,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
 			return r;
+
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
 	}
 
 	adev->sdma.supported_reset =
@@ -1464,12 +1467,11 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
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
index 9c17df2cf37b..5fadaf35a03a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -269,7 +269,7 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 
 static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -1216,7 +1216,7 @@ static void sdma_v7_0_vm_set_pte_pde(struct amdgpu_ib *ib,
  */
 static void sdma_v7_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
 	u32 pad_count;
 	int i;
 
@@ -1362,6 +1362,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
 			return r;
+
+		ring->sdma.instance = &adev->sdma.instance[i];
+		ring->sdma.index = i;
 	}
 
 	adev->sdma.supported_reset =
@@ -1466,12 +1469,11 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
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


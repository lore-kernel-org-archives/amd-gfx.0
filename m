Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CC1C88E65
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 11:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135A610ED57;
	Mon, 14 Sep 2026 11:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aauaUqeH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43B610ED56
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=oiDeYea2OgLrhb8SDHbgTzNgZIaqbu91CGt4nPAOGlw=; b=aauaUqeHKjIVjbsodsbUAyia6R
 IPd5/4Al0bLoVFgxjGoVBR0FXfEK4q//WaS20Iz06SipenMJyymfIR2kRVORuboy0fOT+XaQklAws
 NJ8pItBhZxRVKiEWmYQM4UOucmGmfCavuxyv2luir2sZ+Gj54v62yUfhOEXBi2hpovkzRp9NETsDE
 r1K/6DZYodCEdYdTwYOvHWRvJTL0Pmx0N6yqF9lvlpwy/0dq1wftYJTClpYEVT9s6ZNqtsyZFvTTZ
 g5oqXuhBvSNVq2fAbrN0Km/MqzfJenuS9T4X5RNfxajJh5IYqhQ7rWAxKQCqGQiKsZ+2c8MBKrLoo
 8QD5XNmg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x64Tm-001qMU-0n; Mon, 14 Sep 2026 13:04:05 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v2 3/6] drm/amdgpu: Convert SDMA instance and index to direct
 lookup
Date: Mon, 14 Sep 2026 12:03:58 +0100
Message-ID: <20260914110401.48209-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914110401.48209-1-tvrtko.ursulin@igalia.com>
References: <20260914110401.48209-1-tvrtko.ursulin@igalia.com>
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

Instead of searching for the matching SDMA instance inside many of the
SDMA ring vfuncs lets just use the instance number already stored in the
ring and replace the function calls and array walks with direct lookups.

As these helpers are used only from SDMA vfuncs we can remove safely
remove the "is this a SDMA ring" checks as well.

We could add an assert that ring->type queried is AMDGPU_RING_TYPE_SDMA
but as currently there are no debug build only assert macros in this
driver for now I opted not to so the helper can stay a trivial static
inline without polluting the callers with out of line logging.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 45 +++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  9 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  6 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 10 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 12 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 12 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 12 +++----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 12 +++----
 11 files changed, 55 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 7d975c1680a1..d2fee2480154 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -55,57 +55,20 @@ amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 				AMDGPU_RING_PRIO_DEFAULT, NULL);
 }
 
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
-	uint64_t csa_mc_addr;
-	uint32_t index = 0;
-	int r;
 
 	/* don't enable OS preemption on SDMA under SRIOV */
 	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
 		return 0;
 
-	r = amdgpu_sdma_get_index_from_ring(ring, &index);
+	if (ring->me > 31)
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
+	       ring->me * AMDGPU_CSA_SDMA_SIZE;
 }
 
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index e77ea4ade8ef..60f7faace0d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -49,9 +49,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
 
-struct amdgpu_sdma_instance *
-amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
-int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index);
+static inline struct amdgpu_sdma_instance *
+amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring)
+{
+	return &ring->adev->sdma.instance[ring->me];
+}
+
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring, unsigned vmid);
 int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 			      struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index cf2ae307933f..5da75852e5bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -224,10 +224,11 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -739,12 +740,13 @@ static void sdma_v2_4_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
 static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 287c1796370f..380967852e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -401,10 +401,11 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1013,12 +1014,13 @@ static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
 static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index dc260fa3caa9..fe0966ab92ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -784,10 +784,11 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1673,12 +1674,13 @@ static void sdma_v4_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 2412ed9a9376..dd0fe773456b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -349,10 +349,11 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1267,12 +1268,13 @@ static void sdma_v4_4_2_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v4_4_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index fdbb5195b354..33a7ce87cc3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -407,10 +407,11 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1241,12 +1242,13 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 0x7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
@@ -1620,11 +1622,9 @@ static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	if (index == 0)
+	if (ring->me == 0)
 		sdma_gfx_preempt = mmSDMA0_GFX_PREEMPT;
 	else
 		sdma_gfx_preempt = mmSDMA1_GFX_PREEMPT;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 13addc71ae17..0b2da12acf23 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -255,10 +255,11 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1142,12 +1143,13 @@ static void sdma_v5_2_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v5_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 0x7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
@@ -1536,12 +1538,10 @@ static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v5_2_get_reg_offset(adev, index, mmSDMA0_GFX_PREEMPT);
+	sdma_gfx_preempt = sdma_v5_2_get_reg_offset(adev, ring->me,
+						    mmSDMA0_GFX_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 11a0d87e56e8..800fd9370229 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -243,10 +243,11 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1132,12 +1133,13 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v6_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 0x7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
@@ -1512,12 +1514,10 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v6_0_get_reg_offset(adev, index, regSDMA0_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v6_0_get_reg_offset(adev, ring->me,
+						    regSDMA0_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index c1ba1777f915..da21791fc585 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -245,10 +245,11 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1151,12 +1152,13 @@ static void sdma_v7_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v7_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 0x7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
@@ -1465,12 +1467,10 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v7_0_get_reg_offset(adev, index, regSDMA0_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v7_0_get_reg_offset(adev, ring->me,
+						    regSDMA0_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 916e92bae535..934e84cb81e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -239,10 +239,11 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v7_1_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1162,12 +1163,13 @@ static void sdma_v7_1_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v7_1_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = amdgpu_sdma_get_instance_from_ring(ring);
+	const bool burst_nop = sdma->burst_nop;
 	u32 pad_count;
 	int i;
 
 	pad_count = (-ib->length_dw) & 0x7;
 	for (i = 0; i < pad_count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			ib->ptr[ib->length_dw++] =
 				SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_NOP) |
 				SDMA_PKT_NOP_HEADER_COUNT(pad_count - 1);
@@ -1453,12 +1455,10 @@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
 	struct amdgpu_device *adev = ring->adev;
-	u32 index = 0;
 	u64 sdma_gfx_preempt;
 
-	amdgpu_sdma_get_index_from_ring(ring, &index);
-	sdma_gfx_preempt =
-		sdma_v7_1_get_reg_offset(adev, index, regSDMA0_SDMA_QUEUE0_PREEMPT);
+	sdma_gfx_preempt = sdma_v7_1_get_reg_offset(adev, ring->me,
+						    regSDMA0_SDMA_QUEUE0_PREEMPT);
 
 	/* assert preemption condition */
 	amdgpu_ring_set_preempt_cond_exec(ring, false);
-- 
2.55.0


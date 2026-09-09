Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89750C79FAD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 10:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E9210E552;
	Wed,  9 Sep 2026 10:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mJdUsuJ5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F032410F0B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 10:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=raB4Lpk5TkrjsLvAg3s0BGv4ZEMB1aG9Ig/6l1pe4no=; b=mJdUsuJ5kKDBna/xeT/gVG1tm1
 1XJQ6ldO4BfzqizHs1pUii+4rrYVXs0ajJq6msoKsTqXaeXRQberj7vvNs04i+0qooGKTwDN+8lUF
 N4b2unuB2FPvpgHR20mKbG6LnFPeIsuP5TWuHW1xD6qKLTlP5rjenjXAjdShrIoWv7Lra0c2qFh4N
 ZZ3k5VDFYrB8nYIJ7P50CroxYmZxVKQXTiVPyUqm3BBiZa+sFfUIVUKk3FxvFBdPZJRnTrV2SvTMi
 nKHpaqjXHc2o2csPF3BB2Hvq9DB5xbbdINXckjiG/J1VqUZG/lCo6Z/pkZ4b7yq9Lm8l58L/1l0HL
 XT9Fms6g==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x4Fug-00Gyk3-2S; Wed, 09 Sep 2026 12:52:22 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/6] drm/amdgpu: Convert SDMA instance and index to direct
 lookup
Date: Wed,  9 Sep 2026 11:52:12 +0100
Message-ID: <20260909105215.88242-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
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
index cca8b3a98f6a..68a92ce49ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -56,57 +56,20 @@ int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	return 0;
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
index 526ea305a7de..14c67e46515f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -48,9 +48,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
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
index 1f9fd8b23ac7..006f3fd3464a 100644
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
index 6577306311a3..3fb15032e1ef 100644
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
index 5ab191806b22..dfb0ea709bad 100644
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
index 365085a15a34..da8206b834e5 100644
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
index b803d74fc40f..cb36b38582c5 100644
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
index 213fa9ac883f..2858820bb864 100644
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
index 2f5de866b248..d3504606bee7 100644
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
index d5cad2cede98..1760f03db9e7 100644
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
index bf26cc515b9a..b9f11f2f7e5c 100644
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
@@ -1454,12 +1456,10 @@ static int sdma_v7_1_ring_preempt_ib(struct amdgpu_ring *ring)
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


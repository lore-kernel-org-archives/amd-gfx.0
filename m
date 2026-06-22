Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32EFCDB471
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 14:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF6510E719;
	Mon, 22 Jun 2026 14:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Cu3ba+Pq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F29D10E711
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ymqiNUdo9DmPrIuWTZugprs8AovKN9/CBrwuLPoZdMU=; b=Cu3ba+PqD44TIekj1to6nll5Ig
 ospdQpAXkQcRN751W7fQ6DY0tdusXay1gZ1aurpd2erA1vIUaA/VQUXee2clwVhvLHMa/B1yxumok
 LuKnMNDNppkXoHPEr7bq13kOW/XRV29aezMnd87t9CRydO3vdcHG21L3Swpu1RjDhKf5rDRlNFh+3
 0LlhdzzQCxGWSeH4JkJFXzcM+c9/BGA9q6a5lYxMWJCPjmzV0Tv+YsUupus/QuintlI0yJsq22dTy
 iBTFhuL0gIgIkeGY6kyLjaqlCjQuZKaWfPeWvNJ5avU9mZplBwWxz7/3mE6o1HUAUGIyoYWLpZtkl
 JCAmqW8w==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbfle-003mJz-9R; Mon, 22 Jun 2026 16:36:54 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [RFC 2/2] drm/amdgpu: Drop null SDMA instance checks from SDMA vfuncs
Date: Mon, 22 Jun 2026 15:36:49 +0100
Message-ID: <20260622143649.54632-3-tvrtko.ursulin@igalia.com>
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

Commit message TBD - Can these be NULL?

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 6 ++++--
 9 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 63adcb49cfad..81c78f7be6aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -223,10 +223,11 @@ static void sdma_v2_4_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v2_4_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -733,12 +734,13 @@ static void sdma_v2_4_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
 static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
index a7a3e13bdddf..b6a9ce2f66a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -399,10 +399,11 @@ static void sdma_v3_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v3_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1006,12 +1007,13 @@ static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
 static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
index 2db4e1dbd5c1..0dadd3aaf511 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -783,10 +783,11 @@ static void sdma_v4_0_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1667,12 +1668,13 @@ static void sdma_v4_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
index 42ed9ef6fb20..8f9c0916b7ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -350,10 +350,11 @@ static void sdma_v4_4_2_page_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v4_4_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1263,12 +1264,13 @@ static void sdma_v4_4_2_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v4_4_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
index 670b34a76326..dd45b0d63e37 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -406,10 +406,11 @@ static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1236,12 +1237,13 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a307c5a45e09..8879abe2b116 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -254,10 +254,11 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v5_2_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1136,12 +1137,13 @@ static void sdma_v5_2_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v5_2_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 9aefc4f9b6e5..b4b1f159bc89 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -242,10 +242,11 @@ static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1143,12 +1144,13 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v6_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index fad5b51596ed..55da6db4344b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -244,10 +244,11 @@ static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v7_0_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1162,12 +1163,13 @@ static void sdma_v7_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v7_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 9319d1c00e0c..c7d361e1072c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -238,10 +238,11 @@ static void sdma_v7_1_ring_set_wptr(struct amdgpu_ring *ring)
 static void sdma_v7_1_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
+	const bool burst_nop = sdma->burst_nop;
 	int i;
 
 	for (i = 0; i < count; i++)
-		if (sdma && sdma->burst_nop && (i == 0))
+		if (i == 0 && burst_nop)
 			amdgpu_ring_write(ring, ring->funcs->nop |
 				SDMA_PKT_NOP_HEADER_COUNT(count - 1));
 		else
@@ -1168,12 +1169,13 @@ static void sdma_v7_1_vm_set_pte_pde(struct amdgpu_ib *ib,
 static void sdma_v7_1_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
 	struct amdgpu_sdma_instance *sdma = ring->sdma.instance;
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
-- 
2.54.0


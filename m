Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42336C3DA7E
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 12:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0D610E1A5;
	Tue, 30 Jul 2024 12:43:53 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8110610E1A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 12:43:52 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46UChYoL038062; Tue, 30 Jul 2024 18:13:34 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46UChXDn038055;
 Tue, 30 Jul 2024 18:13:33 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH] drm/amdgpu: optimize the padding with hw optimization
Date: Tue, 30 Jul 2024 18:13:32 +0530
Message-Id: <20240730124332.38030-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Adding NOP packets one by one in the ring
does not use the CP efficiently.

Solution:
Use CP optimization while adding NOP packet's so PFP
can discard NOP packets based on information of count
from the Header instead of fetching all NOP packets
one by one.

Cc: Christian König <christian.koenig@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tvrtko Ursulin <tursulin@igalia.com>
Cc: Marek Olšák <marek.olsak@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 853084a2ce7f..edf5b5c4d185 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
+{
+	int i;
+
+	/* Header itself is a NOP packet */
+	if (num_nop == 1) {
+		amdgpu_ring_write(ring, ring->funcs->nop);
+		return;
+	}
+
+	/* Max HW optimization till 0x3ffe, followed by remaining one NOP at a time*/
+	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
+
+	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
+	for (i = 1; i < num_nop; i++)
+		amdgpu_ring_write(ring, ring->funcs->nop);
+}
+
 static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v10_0_ring_test_ring,
 	.test_ib = gfx_v10_0_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = amdgpu_gfx10_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_switch_buffer = gfx_v10_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
@@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v10_0_ring_test_ring,
 	.test_ib = gfx_v10_0_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = amdgpu_gfx10_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
@@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_fence = gfx_v10_0_ring_emit_fence_kiq,
 	.test_ring = gfx_v10_0_ring_test_ring,
 	.test_ib = gfx_v10_0_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = amdgpu_gfx10_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_rreg = gfx_v10_0_ring_emit_rreg,
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
-- 
2.34.1


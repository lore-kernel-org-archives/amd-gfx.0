Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048D3C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 05:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D3710E085;
	Tue, 30 Jul 2024 05:22:06 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A7210E33E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 05:22:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46U5LwMF4135169; Tue, 30 Jul 2024 10:51:58 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46U5LwXo4135168;
 Tue, 30 Jul 2024 10:51:58 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Pelloux-Prayer@rtg-sunil-navi33.amd.com,
 Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: add support of burst nop for gfx10
Date: Tue, 30 Jul 2024 10:51:56 +0530
Message-Id: <20240730052156.4135143-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Problem:
Till now we are adding NOP packet one by one
i.e if we need N nop packets for padding we are adding
N NOP packets in the ring which does not use the HW
efficiently.

Solution:
Use the data block of the NOP packet for NOP packets
up to the max no of NOPS HW support. Using this HW would
skip passing the information to CP and it skips over
N packets assuming NOP packets.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 853084a2ce7f..01f98e2401ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9397,6 +9397,22 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
+{
+	int i;
+
+	if (count == 0 || count > 0x3fff) {
+		DRM_ERROR("Invalid NOP's pkt count\n");
+		return;
+	}
+
+	for (i = 0; i < count; i++)
+		if (count == 1)
+			amdgpu_ring_write(ring, ring->funcs->nop | PACKET3(PACKET3_NOP, count - 1));
+		else
+			amdgpu_ring_write(ring, ring->funcs->nop);
+}
+
 static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -9588,7 +9604,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v10_0_ring_test_ring,
 	.test_ib = gfx_v10_0_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = amdgpu_gfx10_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_switch_buffer = gfx_v10_0_ring_emit_sb,
 	.emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
@@ -9629,7 +9645,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v10_0_ring_test_ring,
 	.test_ib = gfx_v10_0_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = amdgpu_gfx10_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
@@ -9659,7 +9675,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
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


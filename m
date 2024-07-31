Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F107C3DA64
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 13:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2815E10E622;
	Wed, 31 Jul 2024 13:13:24 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5998610E622
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 13:13:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46VDD3Hf354435; Wed, 31 Jul 2024 18:43:03 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46VDD1nM354412;
 Wed, 31 Jul 2024 18:43:01 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH v1 1/3] drm/amdgpu: optimize the padding for gfx12
Date: Wed, 31 Jul 2024 18:42:50 +0530
Message-Id: <20240731131252.354336-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731131252.354336-1-sunil.khatri@amd.com>
References: <20240731131252.354336-1-sunil.khatri@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f932c7ff85e3..29b3bf1b29b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5005,6 +5005,24 @@ static void gfx_v12_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static void gfx_v12_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
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
 static void gfx_v12_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -5186,7 +5204,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v12_0_ring_test_ring,
 	.test_ib = gfx_v12_0_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = gfx_v12_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v12_0_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v12_0_ring_emit_init_cond_exec,
@@ -5224,7 +5242,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v12_0_ring_test_ring,
 	.test_ib = gfx_v12_0_ring_test_ib,
-	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_nop = gfx_v12_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
-- 
2.34.1


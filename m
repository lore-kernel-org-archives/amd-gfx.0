Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B935CEF176
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF1B10E535;
	Tue,  8 Oct 2024 13:35:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1309C10E148
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 13:35:02 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 498DYwg1710108; Tue, 8 Oct 2024 19:04:58 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 498DYwhC710107;
 Tue, 8 Oct 2024 19:04:58 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 1/6] drm/amdgpu: optimize insert_nop using multi dwords
Date: Tue,  8 Oct 2024 19:04:51 +0530
Message-Id: <20241008133456.710083-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008133456.710083-1-sunil.khatri@amd.com>
References: <20241008133456.710083-1-sunil.khatri@amd.com>
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

Optimize the ring_insert_nop fn for n dwords in one
step rather then call to amdgpu_ring_write for each
nop packet. This avoid function call for each nop
packet and also wptr is updated once only.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 03bce2fa866a..910293664902 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -108,10 +108,26 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
  */
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 {
-	int i;
+	uint32_t occupied, chunk1, chunk2;
+	uint32_t *dst;
 
-	for (i = 0; i < count; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+	occupied = ring->wptr & ring->buf_mask;
+	dst = &ring->ring[occupied];
+	chunk1 = ring->buf_mask + 1 - occupied;
+	chunk1 = (chunk1 >= count) ? count : chunk1;
+	chunk2 = count - chunk1;
+
+	if (chunk1)
+		memset32(dst, ring->funcs->nop, chunk1);
+
+	if (chunk2) {
+		dst = ring->ring;
+		memset32(dst, ring->funcs->nop, chunk2);
+	}
+
+	ring->wptr += count;
+	ring->wptr &= ring->ptr_mask;
+	ring->count_dw -= count;
 }
 
 /**
-- 
2.34.1


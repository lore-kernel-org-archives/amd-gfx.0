Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC51CEF172
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A42310E530;
	Tue,  8 Oct 2024 13:28:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743CE10E530
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 13:28:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 498DSdne709554; Tue, 8 Oct 2024 18:58:39 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 498DSd9x709553;
 Tue, 8 Oct 2024 18:58:39 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 5/6] drm/amdgpu: optimize fn gfx_v11_ring_insert_nop
Date: Tue,  8 Oct 2024 18:58:32 +0530
Message-Id: <20241008132833.709515-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008132833.709515-1-sunil.khatri@amd.com>
References: <20241008132833.709515-1-sunil.khatri@amd.com>
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

Optimize gfx_v11_ring_insert_nop() to call
optimized version of amdgpu_ring_insert_nop
instead of calling amdgpu_ring_write for number
of nop times.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1d5c873876f5..5aff8f72de9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -490,8 +490,6 @@ static void gfx_v11_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 
 static void gfx_v11_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 {
-	int i;
-
 	/* Header itself is a NOP packet */
 	if (num_nop == 1) {
 		amdgpu_ring_write(ring, ring->funcs->nop);
@@ -502,8 +500,7 @@ static void gfx_v11_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
 
 	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
-	for (i = 1; i < num_nop; i++)
-		amdgpu_ring_write(ring, ring->funcs->nop);
+	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
 static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
-- 
2.34.1


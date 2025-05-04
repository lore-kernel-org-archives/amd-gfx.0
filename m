Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F69DC369DC
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 21:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B380B10E04D;
	Sun,  4 May 2025 21:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="h7P/+PWc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B7B10E04D
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 21:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sg39utf2c1ql4amw9qa2S45jKi6lfkEbW7vvwyilMG8=; b=h7P/+PWcxLHXETSqgRZgmuo9He
 Kl6VhpSCGTkmUy5UucMjGc8o027zPgQRUtKHZwjYrSR3I8PcRi2vyVfaenGVG022P/SJ/eHgHnnd0
 Y9wL4Oaf4XOgS1wsrC9GLpTRUQImGC9zVRn70OC+AvREFfSU9VChNiqL/PIGNLzRqDpOr7niY5ivw
 nfynX7i+xIWORGnPZ+VvMygHBqz32YR+dhvZ96BUcyebNscYSSUXLh+EeiD5czw3nxW22craM1KeE
 DzEI3wvjDqTRyxyAz0BB0fXGdSA4pFsYKdxXU90LTYBQXa9zRZLJB21iSbcm88hbXJchK/uQWEGn7
 jOru0cDA==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBh9G-003PPH-E2; Sun, 04 May 2025 23:48:17 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/6] drm/amd/amdgpu: Avoid re-parser CSB in
 gfx_v7_0_cp_gfx_start
Date: Sun,  4 May 2025 15:47:35 -0600
Message-ID: <20250504214801.406245-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504214801.406245-1-siqueira@igalia.com>
References: <20250504214801.406245-1-siqueira@igalia.com>
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

Remove the unnecessary parser of the CSB buffer in the GFX7, and
directly use the result from "adev->gfx.rlc.cs_ptr".

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index da0534ff1271..35938090fbae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2460,9 +2460,8 @@ static int gfx_v7_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 static int gfx_v7_0_cp_gfx_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &adev->gfx.gfx_ring[0];
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-	int r, i;
+	u32 csb_size;
+	int r;
 
 	/* init the CP */
 	WREG32(mmCP_MAX_CONTEXT, adev->gfx.config.max_hw_contexts - 1);
@@ -2471,7 +2470,8 @@ static int gfx_v7_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	gfx_v7_0_cp_gfx_enable(adev, true);
 
-	r = amdgpu_ring_alloc(ring, gfx_v7_0_get_csb_size(adev) + 8);
+	csb_size = gfx_v7_0_get_csb_size(adev);
+	r = amdgpu_ring_alloc(ring, csb_size + 8);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
@@ -2491,17 +2491,7 @@ static int gfx_v7_0_cp_gfx_start(struct amdgpu_device *adev)
 	amdgpu_ring_write(ring, 0x80000000);
 	amdgpu_ring_write(ring, 0x80000000);
 
-	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT) {
-				amdgpu_ring_write(ring,
-						  PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
-				amdgpu_ring_write(ring, ext->reg_index - PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					amdgpu_ring_write(ring, ext->extent[i]);
-			}
-		}
-	}
+	amdgpu_gfx_write_csb_to_ring(ring, adev->gfx.rlc.cs_ptr, csb_size);
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONTEXT_REG, 2));
 	amdgpu_ring_write(ring, mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START);
-- 
2.47.2


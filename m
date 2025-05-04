Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC12C3ABBA
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 21:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452F610E05C;
	Sun,  4 May 2025 21:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DRbOaBY+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE52210E05C
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VBB6U51ifI9jFgbad4Jt8wl+vjRjgB/VhaXyb1Ufxug=; b=DRbOaBY+12z2idw9M5K6ZFjFts
 0RUdYkuIb+JesMECqkUpNzOsLLecXd9aWE4OZ4nh0AU3KNqGsiRi3JkE3hVI8EVPwOGYJ6UkL/l7e
 0FrxslXj2SOPpQeF1vwrtRzdYN+rDVinOV9zpWQzitEbwa+7QIBAurAg91RwiM9HrvpDT/jkLImyh
 uMmR2DyfjoZuSHCdzSqvO2O2l1TVSoy9m6OEM5QJ7ZKN5K3o0RH68ReKBE55feYb31tRLB4FbPcm8
 NSoXdReDY/vD30zu2R85o/i7JdN3AGolIYtaRGdzOc8DJLhKRAcr0O7nJNW9koFXbXMgYrldj3KNB
 qGZyTWsA==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBh9L-003PPH-0e; Sun, 04 May 2025 23:48:22 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 4/6] drm/amd/amdgpu: Avoid re-parser CSB in
 gfx_v9_0_cp_gfx_start
Date: Sun,  4 May 2025 15:47:37 -0600
Message-ID: <20250504214801.406245-5-siqueira@igalia.com>
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

Use amdgpu_gfx_write_csb_to_ring() to replace duplicated CSB parse in
gfx_v9_0_cp_gfx_start().

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d377a7c57d5e..be38650a2b9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3295,9 +3295,8 @@ static int gfx_v9_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &adev->gfx.gfx_ring[0];
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-	int r, i, tmp;
+	u32 csb_size;
+	int r, tmp;
 
 	/* init the CP */
 	WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT, adev->gfx.config.max_hw_contexts - 1);
@@ -3313,7 +3312,9 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 		DRM_INFO("Will skip the CSB packet resubmit\n");
 		return 0;
 	}
-	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
+
+	csb_size = gfx_v9_0_get_csb_size(adev);
+	r = amdgpu_ring_alloc(ring, csb_size + 4 + 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
@@ -3326,19 +3327,7 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 	amdgpu_ring_write(ring, 0x80000000);
 	amdgpu_ring_write(ring, 0x80000000);
 
-	for (sect = gfx9_cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT) {
-				amdgpu_ring_write(ring,
-				       PACKET3(PACKET3_SET_CONTEXT_REG,
-					       ext->reg_count));
-				amdgpu_ring_write(ring,
-				       ext->reg_index - PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					amdgpu_ring_write(ring, ext->extent[i]);
-			}
-		}
-	}
+	amdgpu_gfx_write_csb_to_ring(ring, adev->gfx.rlc.cs_ptr, csb_size);
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_PREAMBLE_CNTL, 0));
 	amdgpu_ring_write(ring, PACKET3_PREAMBLE_END_CLEAR_STATE);
-- 
2.47.2


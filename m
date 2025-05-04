Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B42C369DC
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 21:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7695910E06E;
	Sun,  4 May 2025 21:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RjnfvsiP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA0510E06E
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zK1MfK6N06ECL4gaKTzmcp3Zq4sojbsZC7cjbNl+CWQ=; b=RjnfvsiPI8WPzyT7+4eGBUv3j+
 sEBXaabYlC8ZmnChhT5bQibLSvxCRaSh5iOIzj6GJQ+d+jWR7kYSgSl9jVCAMnx4O7Q4QoqtUKKtO
 SeEuScy29QOLbvaKgBWPi3Pgr07C+sjb7m8+maePEfNBG0UyGh9jEmQs3UAHp2Hqigh+G5siW8VFz
 hk8VtPIWDqlR4bVyGFqQqUg4rsFQizCEkdMHQoooBqyIggwGXVCwed1LfCmrZCsuY3zqJKyI7tN7W
 VJgsyMpHKrYPjpeUxbsn7qHgjTtmM6ailX90S6NKeLc0Tk1PCVFrBDHxjpsW/4jZpjW1ogNWlGWgh
 7YJyLznA==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBh9P-003PPH-J2; Sun, 04 May 2025 23:48:27 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6/6] drm/amd/amdgpu: Avoid re-parser CSB in
 gfx_v11_0_cp_gfx_start
Date: Sun,  4 May 2025 15:47:39 -0600
Message-ID: <20250504214801.406245-7-siqueira@igalia.com>
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

Remove the unnecessary parser of the CSB buffer in the GFX11, and
directly use the result from "adev->gfx.rlc.cs_ptr".

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3f4ee4b3b0a4..a9ff66525ce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3575,10 +3575,8 @@ static int gfx_v11_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-	int r, i;
-	int ctx_reg_offset;
+	u32 csb_size;
+	int r, ctx_reg_offset;
 
 	/* init the CP */
 	WREG32_SOC15(GC, 0, regCP_MAX_CONTEXT,
@@ -3589,7 +3587,8 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 		gfx_v11_0_cp_gfx_enable(adev, true);
 
 	ring = &adev->gfx.gfx_ring[0];
-	r = amdgpu_ring_alloc(ring, gfx_v11_0_get_csb_size(adev));
+	csb_size = gfx_v11_0_get_csb_size(adev);
+	r = amdgpu_ring_alloc(ring, csb_size);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
@@ -3602,19 +3601,7 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 	amdgpu_ring_write(ring, 0x80000000);
 	amdgpu_ring_write(ring, 0x80000000);
 
-	for (sect = gfx11_cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT) {
-				amdgpu_ring_write(ring,
-						  PACKET3(PACKET3_SET_CONTEXT_REG,
-							  ext->reg_count));
-				amdgpu_ring_write(ring, ext->reg_index -
-						  PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					amdgpu_ring_write(ring, ext->extent[i]);
-			}
-		}
-	}
+	amdgpu_gfx_write_csb_to_ring(ring, adev->gfx.rlc.cs_ptr, csb_size);
 
 	ctx_reg_offset =
 		SOC15_REG_OFFSET(GC, 0, regPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
-- 
2.47.2


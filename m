Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B821C369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 22:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1AF710E0BE;
	Mon, 21 Apr 2025 22:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Cr6F3ou2";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41BFB10E0A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 22:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MaD7EVKMaAVIPiCjVpWk3YeCOaQla5DPoU9rjk3A0x8=; b=Cr6F3ou2M38zGA4bekcNNrUiUn
 kcKzmQ9/z065HPqH5HEgyWM+7ciTba4p8D54pTJTrqr83/i30+1RKq2xQHo1cX+uCvlr2OdRBAPlg
 t73GgY8FZB+3TzY7bQZgXvZgAvAtY6b6QoVNzaWtydRtKmbsfbuI+ix67pzARHUcGM2MTQzioJRbW
 6JrdtYWSqg+LUu0CiFM8el5tjiFDH7bA2jIa2MCwsVbyn/oQX5ubk4vGlsRVh4U0yiHElIX7lU9tc
 271WwbqAOFoyeTZrgcCzA+yvS6UxA+yVHzguisujSq6dwHPxOQY36bZykcVyBXv54vrIPFsoBN0e1
 TO5PWyvg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u6zTH-006CMY-0r; Tue, 22 Apr 2025 00:18:35 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 2/9] drm/amdgpu/gfx: Use CSB helpers in
 gfx_v11_0_get_csb_buffer
Date: Mon, 21 Apr 2025 16:12:19 -0600
Message-ID: <20250421221616.387927-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421221616.387927-1-siqueira@igalia.com>
References: <20250421221616.387927-1-siqueira@igalia.com>
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

Part of the code in gfx_v11_0_get_csb_buffer can be removed in favor of
some GFX CSB helpers. This commit removes the duplicated part for the
GFX 11 CSB function.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 34 ++++----------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ac7ac58e25a6..2df11f4127cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -848,9 +848,7 @@ static u32 gfx_v11_0_get_csb_size(struct amdgpu_device *adev)
 static void gfx_v11_0_get_csb_buffer(struct amdgpu_device *adev,
 				    volatile u32 *buffer)
 {
-	u32 count = 0, i;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
+	u32 count = 0;
 	int ctx_reg_offset;
 
 	if (adev->gfx.rlc.cs_data == NULL)
@@ -858,37 +856,15 @@ static void gfx_v11_0_get_csb_buffer(struct amdgpu_device *adev,
 	if (buffer == NULL)
 		return;
 
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	buffer[count++] = cpu_to_le32(0x80000000);
-	buffer[count++] = cpu_to_le32(0x80000000);
-
-	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT) {
-				buffer[count++] =
-					cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
-				buffer[count++] = cpu_to_le32(ext->reg_index -
-						PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			}
-		}
-	}
+	count = amdgpu_gfx_csb_preamble_start(buffer);
+	count = amdgpu_gfx_csb_data_parser(adev, buffer, count);
 
-	ctx_reg_offset =
-		SOC15_REG_OFFSET(GC, 0, regPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
+	ctx_reg_offset = SOC15_REG_OFFSET(GC, 0, regPA_SC_TILE_STEERING_OVERRIDE) - PACKET3_SET_CONTEXT_REG_START;
 	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
 	buffer[count++] = cpu_to_le32(ctx_reg_offset);
 	buffer[count++] = cpu_to_le32(adev->gfx.config.pa_sc_tile_steering_override);
 
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
+	amdgpu_gfx_csb_preamble_end(buffer, count);
 }
 
 static void gfx_v11_0_rlc_fini(struct amdgpu_device *adev)
-- 
2.49.0


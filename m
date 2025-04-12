Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE55AC369B6
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 20:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEC610E3E9;
	Sat, 12 Apr 2025 20:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YaRloFuy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E02810E062
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2XE89Othe5plp3nGLDQZj2weKSROT0bUbceqDcNzKw4=; b=YaRloFuyS97C3C27l4Iok/FrFB
 m/0WzxqeEZIEwz4bxYL9nCSMgOj3lbUC7uok0QqR8mBVhiZE8f0J2RE/G0KeUu0oLbv+wXYD2cCWG
 wu97tI38CGI0gCbDaaWK6CWVGtwo0z1YFwi/YPAc7E8QsE9EwcV18gIt7PUuJD/D0jEMZHDXHglsC
 kNfdCuCr6VxOvvQ66VLvBPRzJvRMsj6rsXqUNVj0tQko4ADexZYTZ/w9DGUThdcxPESSoVKpF4BLI
 8sT95/RniefaahmqmYH4F2o5x3x1uxIYg/Y3UzPc0XX2F3irE4n/5zxIkra372lyNhka1hLlgdkVr
 618yeGrw==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u3hML-00Fepq-EE; Sat, 12 Apr 2025 22:21:49 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 2/9] drm/amdgpu/gfx: Use CSB helpers in
 gfx_v11_0_get_csb_buffer
Date: Sat, 12 Apr 2025 14:21:07 -0600
Message-ID: <20250412202134.3025051-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412202134.3025051-1-siqueira@igalia.com>
References: <20250412202134.3025051-1-siqueira@igalia.com>
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
index ac90f823e596..b943b3069160 100644
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


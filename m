Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCA0C369C2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 22:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08A110E4B9;
	Mon, 21 Apr 2025 22:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DdruRX5U";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD84210E4B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 22:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X2/UsaO4RYSFlPo3ZzKYgAvIF17h4gPJiqwCIVCVjKw=; b=DdruRX5UnI8hsHAUbbh3SAnLds
 U5tonQnuW7mgAkztmnXD/Crbgx7rVEdKOoT4F7fhcVRFd8WmHC8ZWRZ+O6o/cX53X9C69WWr3N3zY
 jsPDtKzbBxp+Q/0WV/giDySGCB2FFE+kDlcFSLXamj0FfGUN2l93bbrkIixhjrUwtfjuFYGVEy/p+
 dz7LaylwO785+u5Btmw3QYgaS/49PgM/tTcvaOHcdLW/W3LEbKoXm+2GkP5aDFWtWqZGhxxtw772Q
 AS1W0lK/WkBWe8FxzyR2+od1EnkJN/7YdGXZky6TNqf5SAT8rlSVkQkbdhX5ha33hq88Bm6TZLRZ0
 hmsLu/EA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u6zTO-006CMY-PB; Tue, 22 Apr 2025 00:18:43 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 7/9] drm/amdgpu/gfx: Fix gfx_v7_0_get_csb_buffer to use
 rb_config
Date: Mon, 21 Apr 2025 16:12:24 -0600
Message-ID: <20250421221616.387927-8-siqueira@igalia.com>
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

Instead of having the hardcoded values for the CSB buffer in
gfx_v7_0_get_csb_buffer, use the values calculated in previous steps by
accessing raster_config and raster_config_1.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 16b94ff5a959..da0534ff1271 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3897,29 +3897,8 @@ static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev,
 
 	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 2));
 	buffer[count++] = cpu_to_le32(mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START);
-	switch (adev->asic_type) {
-	case CHIP_BONAIRE:
-		buffer[count++] = cpu_to_le32(0x16000012);
-		buffer[count++] = cpu_to_le32(0x00000000);
-		break;
-	case CHIP_KAVERI:
-		buffer[count++] = cpu_to_le32(0x00000000); /* XXX */
-		buffer[count++] = cpu_to_le32(0x00000000);
-		break;
-	case CHIP_KABINI:
-	case CHIP_MULLINS:
-		buffer[count++] = cpu_to_le32(0x00000000); /* XXX */
-		buffer[count++] = cpu_to_le32(0x00000000);
-		break;
-	case CHIP_HAWAII:
-		buffer[count++] = cpu_to_le32(0x3a00161a);
-		buffer[count++] = cpu_to_le32(0x0000002e);
-		break;
-	default:
-		buffer[count++] = cpu_to_le32(0x00000000);
-		buffer[count++] = cpu_to_le32(0x00000000);
-		break;
-	}
+	buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
+	buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);
 
 	amdgpu_gfx_csb_preamble_end(buffer, count);
 }
-- 
2.49.0


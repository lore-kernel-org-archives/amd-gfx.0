Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F09C36002
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 23:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDFA10E044;
	Sun,  6 Apr 2025 23:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iRcY6zOG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B6A10E15B
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zPXSDMf5gwPk64ZO15b55ds7SZyqhwSZS5C8JZpE4NU=; b=iRcY6zOG5uNj34jMr441uOqEAI
 El2p4hZqgtpkR7PMaEseWFodX1ep5WIjZ9QGeyUylvanmylqGQP2xXiwi5cccbNTYGhMBTPCw8Pcf
 Lp2FOozN4QwnLMQYPvu8QlTGYrSNXL9E7WDtybZcnMnaOK/1yzKWgQE+dRhHPqWQx3mDpiNR0brC6
 aJugNGYK9bBBQj23zg4hBkzsK9Kk3f/254m1oha7cXwLyW4pFTukqOXnHQ0eeJzIhtDoQsii05j3y
 GxCyvrNtL4bectKXmWRgIjTT6RMeY638NVzixftTPyK+7YvBQGX7KjDQJ7yJpLMC7aRk2oDUDI/4v
 AP8R5iUg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u1Z5Q-00CfEV-P7; Mon, 07 Apr 2025 01:07:33 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx: Assimilate gfx_v7_0_get_csb_buffer into
 gfx_get_csb_buffer
Date: Sun,  6 Apr 2025 17:03:00 -0600
Message-ID: <20250406230703.2128148-6-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406230703.2128148-1-siqueira@igalia.com>
References: <20250406230703.2128148-1-siqueira@igalia.com>
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

The gfx_v7_0_get_csb_buffer function is incorporated into
gfx_get_csb_buffer, but it required to port some specific ASIC
operations to the function. Additionally, this transition also
eliminates some unnecessary code from gfx_v7_0_get_csb_buffer.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 31 +++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 68 +------------------------
 2 files changed, 28 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 71a25f626fee..57bf3282e797 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2254,13 +2254,36 @@ void gfx_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer)
 		}
 	}
 
-	// GFX8 specific operation
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(8, 0, 0) &&
+	// GFX7 and GFX8
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(7, 0, 0) &&
 	    amdgpu_ip_version(adev, GC_HWIP, 0) <  IP_VERSION(9, 0, 0)) {
 		buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 2));
 		buffer[count++] = cpu_to_le32(mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START);
-		buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
-		buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);
+
+		// GFX8
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(8, 0, 0)) {
+			buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
+			buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config_1);
+		}
+
+		// GFX7 Specific ASICs
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(7, 0, 0) &&
+		    amdgpu_ip_version(adev, GC_HWIP, 0) <  IP_VERSION(8, 0, 0)) {
+			switch (adev->asic_type) {
+			case CHIP_BONAIRE:
+				buffer[count++] = cpu_to_le32(0x16000012);
+				buffer[count++] = cpu_to_le32(0x00000000);
+				break;
+			case CHIP_HAWAII:
+				buffer[count++] = cpu_to_le32(0x3a00161a);
+				buffer[count++] = cpu_to_le32(0x0000002e);
+				break;
+			default:
+				buffer[count++] = cpu_to_le32(0x00000000);
+				buffer[count++] = cpu_to_le32(0x00000000);
+				break;
+			}
+		}
 	}
 
 	// GFX10 and GFX11 specific operation.
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 6423b7a31e84..759d52932842 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -885,7 +885,6 @@ static const u32 kalindi_rlc_save_restore_register_list[] = {
 };
 
 static u32 gfx_v7_0_get_csb_size(struct amdgpu_device *adev);
-static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer);
 static void gfx_v7_0_init_pg(struct amdgpu_device *adev);
 static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev);
 
@@ -3884,70 +3883,6 @@ static u32 gfx_v7_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v7_0_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
-{
-	u32 count = 0, i;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-
-	if (adev->gfx.rlc.cs_data == NULL)
-		return;
-	if (buffer == NULL)
-		return;
-
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
-				buffer[count++] = cpu_to_le32(ext->reg_index - PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			}
-		}
-	}
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 2));
-	buffer[count++] = cpu_to_le32(mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START);
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
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
-}
-
 static void gfx_v7_0_init_pg(struct amdgpu_device *adev)
 {
 	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
@@ -4134,7 +4069,6 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
 	.unset_safe_mode = gfx_v7_0_unset_safe_mode,
 	.init = gfx_v7_0_rlc_init,
 	.get_csb_size = gfx_v7_0_get_csb_size,
-	.get_csb_buffer = gfx_v7_0_get_csb_buffer,
 	.get_cp_table_num = gfx_v7_0_cp_pg_table_num,
 	.resume = gfx_v7_0_rlc_resume,
 	.stop = gfx_v7_0_rlc_stop,
@@ -4482,7 +4416,7 @@ static int gfx_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 	gfx_v7_0_constants_init(adev);
 
 	/* init CSB */
-	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+	gfx_get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 	/* init rlc */
 	r = adev->gfx.rlc.funcs->resume(adev);
 	if (r)
-- 
2.49.0


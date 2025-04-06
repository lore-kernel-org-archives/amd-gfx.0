Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4179FC369A3
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 23:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA5A10E169;
	Sun,  6 Apr 2025 23:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iVdcGPb0";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62ED310E144
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 23:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6B3UkjtVcz/AbeCtOf4LgdpKDD1HhKIhiyVNnoSq4tw=; b=iVdcGPb0xcKfdIvB3/foNpQ1bp
 FUcYyeJlxpOf6I1nAoGXGZKskiv+tgIHZIYx0+m6sAPXXWxFdWedcHNiObf4ywzeoCcpsfMeu6qRg
 abtwfFpJDXczpPxuXyOT1g43Ems/SgSNGb5baIwxOP6EDEWrqrifFayepKwOaUnjQFV7FotQWKK+Q
 XqDrKCcPr5bEhquoKmD44rbvWrzX3qtvdUVMz2YZpqHRIiv5h5AYaK01jFB3X5cDaQyF1KgU0/rrD
 Dr8royewsuqmYXfwZ7dQ+UYUsvznP9nlkXtRgDc0ymdUSFqI/wjVuW8/sh/h+kZiBmK5J9syENV0N
 aOrYnFUg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u1Z5S-00CfEV-Di; Mon, 07 Apr 2025 01:07:34 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx: Merge gfx_v6_0_get_csb_buffer into
 gfx_get_csb_buffer
Date: Sun,  6 Apr 2025 17:03:01 -0600
Message-ID: <20250406230703.2128148-7-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406230703.2128148-1-siqueira@igalia.com>
References: <20250406230703.2128148-1-siqueira@igalia.com>
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

Move the only specific GFX6 part from gfx_v6_0_get_csb_buffer to
gfx_get_csb_buffer and remove the gfx6 version.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  8 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 44 +------------------------
 2 files changed, 9 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 57bf3282e797..2c77408b7f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2254,6 +2254,14 @@ void gfx_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer)
 		}
 	}
 
+	// GFX6
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(6, 0, 0) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) <  IP_VERSION(7, 0, 0)) {
+		buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
+		buffer[count++] = cpu_to_le32(mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START);
+		buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
+	}
+
 	// GFX7 and GFX8
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(7, 0, 0) &&
 	    amdgpu_ip_version(adev, GC_HWIP, 0) <  IP_VERSION(9, 0, 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ff794410794d..737ce600c7d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -88,7 +88,6 @@ MODULE_FIRMWARE("amdgpu/hainan_ce.bin");
 MODULE_FIRMWARE("amdgpu/hainan_rlc.bin");
 
 static u32 gfx_v6_0_get_csb_size(struct amdgpu_device *adev);
-static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev, volatile u32 *buffer);
 //static void gfx_v6_0_init_cp_pg_table(struct amdgpu_device *adev);
 static void gfx_v6_0_init_pg(struct amdgpu_device *adev);
 
@@ -2401,7 +2400,7 @@ static int gfx_v6_0_rlc_init(struct amdgpu_device *adev)
 		dst_ptr[0] = cpu_to_le32(upper_32_bits(reg_list_mc_addr));
 		dst_ptr[1] = cpu_to_le32(lower_32_bits(reg_list_mc_addr));
 		dst_ptr[2] = cpu_to_le32(adev->gfx.rlc.clear_state_size);
-		gfx_v6_0_get_csb_buffer(adev, &dst_ptr[(256/4)]);
+		gfx_get_csb_buffer(adev, &dst_ptr[(256/4)]);
 		amdgpu_bo_kunmap(adev->gfx.rlc.clear_state_obj);
 		amdgpu_bo_unreserve(adev->gfx.rlc.clear_state_obj);
 	}
@@ -2857,47 +2856,6 @@ static u32 gfx_v6_0_get_csb_size(struct amdgpu_device *adev)
 	return count;
 }
 
-static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
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
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	buffer[count++] = cpu_to_le32(0x80000000);
-	buffer[count++] = cpu_to_le32(0x80000000);
-
-	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT) {
-				buffer[count++] =
-					cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
-				buffer[count++] = cpu_to_le32(ext->reg_index - 0xa000);
-				for (i = 0; i < ext->reg_count; i++)
-					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			}
-		}
-	}
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, 1));
-	buffer[count++] = cpu_to_le32(mmPA_SC_RASTER_CONFIG - PACKET3_SET_CONTEXT_REG_START);
-	buffer[count++] = cpu_to_le32(adev->gfx.config.rb_config[0][0].raster_config);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
-}
-
 static void gfx_v6_0_init_pg(struct amdgpu_device *adev)
 {
 	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
-- 
2.49.0


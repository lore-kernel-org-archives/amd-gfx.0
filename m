Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1595C3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 21:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847A610E0DC;
	Tue, 13 May 2025 21:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iUIYploe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E10010E0DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CD4dSNEeVVLQ5thqpeB76tcDp9ahynS+1fO+Vu/dHZA=; b=iUIYploee+wky6CgMZES8+yZIW
 u1RhmdiZP19MZSsGomFDfcA4+XgCVBDIvg1zVcZrD3r1oW+lRPotK3J/e/1SiK6ZUckb9gdmraXHc
 2d62Nw8hr+fyye9WfstO5PkJv9fYSAwFiKIme+2paylbr75U1afINw/JCByeavuXc+OBHUWaXK9ko
 uz5LzUCWCuVtp+Rgvjg0Zaa6WHbmyq/JZpDjm88CzIIQDdWGsIoa3N1YOsnFHSRi+qTesHWoyMOFu
 PqUsYt5ikcPIUQaA93Unv6AMLfTys0MN0t5/TX45iNiCn0qmxZpalfD8iY6ZNlafMvHhLtR4lIkWA
 Nv0hflQA==;
Received: from [189.6.16.79] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uExFr-007pb8-Ix; Tue, 13 May 2025 23:39:17 +0200
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [PATCH v2] drm/amd/display: only collect data if debug gamut_remap is
 available
Date: Tue, 13 May 2025 18:38:17 -0300
Message-ID: <20250513213912.179079-1-mwen@igalia.com>
X-Mailer: git-send-email 2.47.2
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

Color gamut_remap state log may be not avaiable for some hw versions, so
prevent null pointer dereference by checking if there is a function to
collect data for this hw version.

v2:
- initialize is_gamut_remap_available (Alex H)

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 26 +++++++++++++------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 24 ++++++++++++-----
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 858288c3b1ac..c277df12c817 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -76,6 +76,7 @@ void dcn20_log_color_state(struct dc *dc,
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
+	bool is_gamut_remap_available = false;
 	int i;
 
 	DTN_INFO("DPP:  DGAM mode  SHAPER mode  3DLUT mode  3DLUT bit depth"
@@ -89,15 +90,15 @@ void dcn20_log_color_state(struct dc *dc,
 		struct dcn_dpp_state s = {0};
 
 		dpp->funcs->dpp_read_state(dpp, &s);
-		dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
+		if (dpp->funcs->dpp_get_gamut_remap) {
+			dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
+			is_gamut_remap_available = true;
+		}
 
 		if (!s.is_enabled)
 			continue;
 
-		DTN_INFO("[%2d]:  %8s  %11s  %10s  %15s  %10s  %9s  %12s  "
-			 "%010lld %010lld %010lld %010lld "
-			 "%010lld %010lld %010lld %010lld "
-			 "%010lld %010lld %010lld %010lld",
+		DTN_INFO("[%2d]:  %8s  %11s  %10s  %15s  %10s  %9s",
 			dpp->inst,
 			(s.dgam_lut_mode == 0) ? "Bypass" :
 			 ((s.dgam_lut_mode == 1) ? "sRGB" :
@@ -114,10 +115,17 @@ void dcn20_log_color_state(struct dc *dc,
 			(s.lut3d_bit_depth <= 0) ? "12-bit" : "10-bit",
 			(s.lut3d_size == 0) ? "17x17x17" : "9x9x9",
 			(s.rgam_lut_mode == 1) ? "RAM A" :
-			 ((s.rgam_lut_mode == 1) ? "RAM B" : "Bypass"),
+			 ((s.rgam_lut_mode == 1) ? "RAM B" : "Bypass"));
+
+		if (is_gamut_remap_available) {
+			DTN_INFO("  %12s  "
+				 "%010lld %010lld %010lld %010lld "
+				 "%010lld %010lld %010lld %010lld "
+				 "%010lld %010lld %010lld %010lld",
+
 			(s.gamut_remap.gamut_adjust_type == 0) ? "Bypass" :
-			 ((s.gamut_remap.gamut_adjust_type == 1) ? "HW" :
-								   "SW"),
+				((s.gamut_remap.gamut_adjust_type == 1) ? "HW" :
+									  "SW"),
 			s.gamut_remap.temperature_matrix[0].value,
 			s.gamut_remap.temperature_matrix[1].value,
 			s.gamut_remap.temperature_matrix[2].value,
@@ -130,6 +138,8 @@ void dcn20_log_color_state(struct dc *dc,
 			s.gamut_remap.temperature_matrix[9].value,
 			s.gamut_remap.temperature_matrix[10].value,
 			s.gamut_remap.temperature_matrix[11].value);
+		}
+
 		DTN_INFO("\n");
 	}
 	DTN_INFO("\n");
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index e89ebfda4873..37a239219dfe 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -74,6 +74,7 @@ void dcn30_log_color_state(struct dc *dc,
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
+	bool is_gamut_remap_available = false;
 	int i;
 
 	DTN_INFO("DPP:  DGAM ROM  DGAM ROM type  DGAM LUT  SHAPER mode"
@@ -88,16 +89,16 @@ void dcn30_log_color_state(struct dc *dc,
 		struct dcn_dpp_state s = {0};
 
 		dpp->funcs->dpp_read_state(dpp, &s);
-		dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
+
+		if (dpp->funcs->dpp_get_gamut_remap) {
+			dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
+			is_gamut_remap_available = true;
+		}
 
 		if (!s.is_enabled)
 			continue;
 
-		DTN_INFO("[%2d]:  %7x  %13s  %8s  %11s  %10s  %15s  %10s  %9s"
-			 "  %12s  "
-			 "%010lld %010lld %010lld %010lld "
-			 "%010lld %010lld %010lld %010lld "
-			 "%010lld %010lld %010lld %010lld",
+		DTN_INFO("[%2d]:  %7x  %13s  %8s  %11s  %10s  %15s  %10s  %9s",
 			dpp->inst,
 			s.pre_dgam_mode,
 			(s.pre_dgam_select == 0) ? "sRGB" :
@@ -121,7 +122,14 @@ void dcn30_log_color_state(struct dc *dc,
 			(s.lut3d_size == 0) ? "17x17x17" : "9x9x9",
 			(s.rgam_lut_mode == 0) ? "Bypass" :
 			 ((s.rgam_lut_mode == 1) ? "RAM A" :
-						   "RAM B"),
+						   "RAM B"));
+
+		if (is_gamut_remap_available) {
+			DTN_INFO("  %12s  "
+				 "%010lld %010lld %010lld %010lld "
+				 "%010lld %010lld %010lld %010lld "
+				 "%010lld %010lld %010lld %010lld",
+
 			(s.gamut_remap.gamut_adjust_type == 0) ? "Bypass" :
 				((s.gamut_remap.gamut_adjust_type == 1) ? "HW" :
 									  "SW"),
@@ -137,6 +145,8 @@ void dcn30_log_color_state(struct dc *dc,
 			s.gamut_remap.temperature_matrix[9].value,
 			s.gamut_remap.temperature_matrix[10].value,
 			s.gamut_remap.temperature_matrix[11].value);
+		}
+
 		DTN_INFO("\n");
 	}
 	DTN_INFO("\n");
-- 
2.47.2


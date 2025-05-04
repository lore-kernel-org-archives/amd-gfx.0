Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E05DC369DC
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 22:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D9810E093;
	Sun,  4 May 2025 22:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FBhKKfSw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DB210E093
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 22:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dR4sjK7lVxpJjOiIb0PkhTAbo8yEiIJqFYyRfES0CqY=; b=FBhKKfSwkKpUReRlgmkGRgiXEA
 Dvp+A5p5PA4HvigF/gplM/XKAAGxcqq5FEfdhMCJjdOmaAWWvqajX5EmNcsqpXehVLvfsF5iqElz5
 S2jUSX3xhlRc+p6CLeeENWH98v2jQq1pTIizlo0xnH3Zq5bfqR/wtFQ0S6yyow6w+vyqdkhouSU0Z
 tngusEadI7U9I/Ah9kMdEB3EFW8OuXA2F1B/g3aVdegKPIroObrFFXQZYU3497m6IRepjnDK1yQDj
 QVOZR9l/BZsGLGiN844Vzq9AFwx7EaJ6y1i0hrHhQPM7wJYOZBpmPvbbbRip+LJ2+6eZYTJ8dOkO7
 THQmxLyg==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBhWV-003Pr1-T0; Mon, 05 May 2025 00:12:19 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/4] drm/amd/display: Use optc31_disable_crtc for DCN 31 and
 401
Date: Sun,  4 May 2025 16:11:29 -0600
Message-ID: <20250504221154.409695-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504221154.409695-1-siqueira@igalia.com>
References: <20250504221154.409695-1-siqueira@igalia.com>
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

DCN401 and DCN31 share the same implementation for disabling CRTC. This
commit makes DCN401 use the DCN31 implementation and removes the code
duplication in the DCN401.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  2 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  2 ++
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 34 +------------------
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 -
 4 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 13c1f95b5ced..e6246e5ba86f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -125,7 +125,7 @@ bool optc31_enable_crtc(struct timing_generator *optc)
 }
 
 /* disable_crtc - call ASIC Control Object to disable Timing generator. */
-static bool optc31_disable_crtc(struct timing_generator *optc)
+bool optc31_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index af67eeaf8505..db7e51fc787e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -267,6 +267,8 @@ void dcn31_timing_generator_init(struct optc *optc1);
 
 bool optc31_immediate_disable_crtc(struct timing_generator *optc);
 
+bool optc31_disable_crtc(struct timing_generator *optc);
+
 bool optc31_enable_crtc(struct timing_generator *optc);
 
 void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 6eba48de58ff..f472d2efe026 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -170,38 +170,6 @@ void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc, bool ma
 			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
 }
 
-/* disable_crtc */
-bool optc401_disable_crtc(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-
-	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
-			OPTC_SEG0_SRC_SEL, 0xf,
-			OPTC_SEG1_SRC_SEL, 0xf,
-			OPTC_SEG2_SRC_SEL, 0xf,
-			OPTC_SEG3_SRC_SEL, 0xf,
-			OPTC_NUM_OF_INPUT_SEGMENT, 0);
-
-	REG_UPDATE(OPTC_MEMORY_CONFIG,
-			OPTC_MEM_SEL, 0);
-
-	/* disable otg request until end of the first line
-	 * in the vertical blank region
-	 */
-	REG_UPDATE(OTG_CONTROL,
-			OTG_MASTER_EN, 0);
-
-	REG_UPDATE(CONTROL,
-			VTG0_ENABLE, 0);
-
-	/* CRTC disabled, so disable  clock. */
-	REG_WAIT(OTG_CLOCK_CONTROL,
-			OTG_BUSY, 0,
-			1, 150000);
-
-	return true;
-}
-
 void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -435,7 +403,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
 		.program_global_sync = optc401_program_global_sync,
 		.enable_crtc = optc31_enable_crtc,
-		.disable_crtc = optc401_disable_crtc,
+		.disable_crtc = optc31_disable_crtc,
 		.phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
 		.disable_phantom_crtc = optc401_disable_phantom_otg,
 		/* used by enable_timing_synchronization. Not need for FPGA */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index 8e795e06e615..be74fd709d43 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -180,7 +180,6 @@ void optc401_program_global_sync(
 		int vupdate_offset,
 		int vupdate_width,
 		int pstate_keepout);
-bool optc401_disable_crtc(struct timing_generator *optc);
 void optc401_phantom_crtc_post_enable(struct timing_generator *optc);
 void optc401_disable_phantom_otg(struct timing_generator *optc);
 void optc401_set_odm_bypass(struct timing_generator *optc,
-- 
2.47.2


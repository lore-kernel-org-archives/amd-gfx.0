Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06E0C369DC
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 22:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFF910E092;
	Sun,  4 May 2025 22:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HUQVCfCM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3E910E092
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NlzcakCLCvMlZahM5MvNfBqWp+AEokgvIO0RDq/4ndk=; b=HUQVCfCMQYlLM8Fuwebta47Pp1
 C+d42bO0V/QRqHPGRzxXID3Jn0ZUm95l4Wk8IWOerp12euLqcnx//E4E4Ws9ZfqwiGR9ifQ0pb38k
 tJvWx0hnQa40CeATC034YnkTvUjh23stDo1j/gJhxE3YwWlQSk5rPmzO0eU6l7JNVwF4mMVouGg7S
 G3j4XV9eHJWi5fjqCdtdvR49nh5Gw2lfj9F7zERpmwPz51COewILCmjMKznDJ9iiEbewD+MU1Pzn4
 MxDVAzmA4DuXvB/ceZXV2zRMbQ+aaGdYgPU1EhTqwUQh6gQkGtsCB8YzIUVpqN9IIi/qe5Q0V2mI1
 vUkzO8VQ==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBhWS-003Pr1-Ty; Mon, 05 May 2025 00:12:16 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/4] drm/amd/display: Use optc31_enable_crtc implementation
 for new DCNs
Date: Sun,  4 May 2025 16:11:28 -0600
Message-ID: <20250504221154.409695-2-siqueira@igalia.com>
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

The *_enable_crtc function from DCN31 to the latest DCNs has the same
implementation. This commit removes all the duplications in favor of
using the optc31_enable_crtc implementation instead of duplicating the
code across different DCNs.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 13 +++++--
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  2 ++
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  | 27 +--------------
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 33 +-----------------
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 27 +--------------
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 34 +------------------
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 -
 7 files changed, 16 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index ef536f37b4ed..13c1f95b5ced 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -89,10 +89,17 @@ static void optc31_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	optc1->opp_count = opp_cnt;
 }
 
-/*
- * Enable CRTC - call ASIC Control Object to enable Timing generator.
+/**
+ * optc31_enable_crtc() - Enable CRTC
+ *
+ * @optc: Pointer to the timing generator structure
+ *
+ * This function calls ASIC Control Object to enable Timing generator.
+ *
+ * Return:
+ * Always returns true
  */
-static bool optc31_enable_crtc(struct timing_generator *optc)
+bool optc31_enable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index 0f72c274f40b..af67eeaf8505 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -267,6 +267,8 @@ void dcn31_timing_generator_init(struct optc *optc1);
 
 bool optc31_immediate_disable_crtc(struct timing_generator *optc);
 
+bool optc31_enable_crtc(struct timing_generator *optc);
+
 void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
 
 void optc3_init_odm(struct timing_generator *optc);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index 0e603bad0d12..7b5478b09a97 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -102,31 +102,6 @@ static void optc314_set_odm_combine(struct timing_generator *optc, int *opp_id,
 	optc1->opp_count = opp_cnt;
 }
 
-static bool optc314_enable_crtc(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-
-	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
-	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
-			OPTC_SEG0_SRC_SEL, optc->inst);
-
-	/* VTG enable first is for HW workaround */
-	REG_UPDATE(CONTROL,
-			VTG0_ENABLE, 1);
-
-	REG_SEQ_START();
-
-	/* Enable CRTC */
-	REG_UPDATE_2(OTG_CONTROL,
-			OTG_DISABLE_POINT_CNTL, 2,
-			OTG_MASTER_EN, 1);
-
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
-	return true;
-}
-
 /* disable_crtc */
 static bool optc314_disable_crtc(struct timing_generator *optc)
 {
@@ -199,7 +174,7 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.setup_vertical_interrupt1 = optc1_setup_vertical_interrupt1,
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
 		.program_global_sync = optc1_program_global_sync,
-		.enable_crtc = optc314_enable_crtc,
+		.enable_crtc = optc31_enable_crtc,
 		.disable_crtc = optc314_disable_crtc,
 		.immediate_disable_crtc = optc31_immediate_disable_crtc,
 		.phantom_crtc_post_enable = optc314_phantom_crtc_post_enable,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 2cdd19ba634b..5a626b23ea6b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -135,37 +135,6 @@ void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool man
 	REG_UPDATE(OTG_H_TIMING_CNTL,
 			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
 }
-/**
- * optc32_enable_crtc() - Enable CRTC - call ASIC Control Object to enable Timing generator.
- *
- * @optc: timing_generator instance.
- *
- * Return: If CRTC is enabled, return true.
- */
-static bool optc32_enable_crtc(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-
-	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
-	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
-			OPTC_SEG0_SRC_SEL, optc->inst);
-
-	/* VTG enable first is for HW workaround */
-	REG_UPDATE(CONTROL,
-			VTG0_ENABLE, 1);
-
-	REG_SEQ_START();
-
-	/* Enable CRTC */
-	REG_UPDATE_2(OTG_CONTROL,
-			OTG_DISABLE_POINT_CNTL, 2,
-			OTG_MASTER_EN, 1);
-
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
-	return true;
-}
 
 /* disable_crtc */
 static bool optc32_disable_crtc(struct timing_generator *optc)
@@ -304,7 +273,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.setup_vertical_interrupt1 = optc1_setup_vertical_interrupt1,
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
 		.program_global_sync = optc1_program_global_sync,
-		.enable_crtc = optc32_enable_crtc,
+		.enable_crtc = optc31_enable_crtc,
 		.disable_crtc = optc32_disable_crtc,
 		.phantom_crtc_post_enable = optc32_phantom_crtc_post_enable,
 		.disable_phantom_crtc = optc32_disable_phantom_otg,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 4cfc6c0fa147..5835aa6c3c18 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -109,31 +109,6 @@ static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	optc1->opp_count = opp_cnt;
 }
 
-static bool optc35_enable_crtc(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-
-	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
-	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
-			OPTC_SEG0_SRC_SEL, optc->inst);
-
-	/* VTG enable first is for HW workaround */
-	REG_UPDATE(CONTROL,
-			VTG0_ENABLE, 1);
-
-	REG_SEQ_START();
-
-	/* Enable CRTC */
-	REG_UPDATE_2(OTG_CONTROL,
-			OTG_DISABLE_POINT_CNTL, 2,
-			OTG_MASTER_EN, 1);
-
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
-	return true;
-}
-
 /* disable_crtc */
 static bool optc35_disable_crtc(struct timing_generator *optc)
 {
@@ -435,7 +410,7 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.setup_vertical_interrupt1 = optc1_setup_vertical_interrupt1,
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
 		.program_global_sync = optc1_program_global_sync,
-		.enable_crtc = optc35_enable_crtc,
+		.enable_crtc = optc31_enable_crtc,
 		.disable_crtc = optc35_disable_crtc,
 		.immediate_disable_crtc = optc31_immediate_disable_crtc,
 		.phantom_crtc_post_enable = optc35_phantom_crtc_post_enable,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 382ac18e7854..6eba48de58ff 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -169,38 +169,6 @@ void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc, bool ma
 	REG_UPDATE(OTG_H_TIMING_CNTL,
 			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
 }
-/**
- * optc401_enable_crtc() - Enable CRTC
- * @optc: Pointer to the timing generator structure
- *
- * This function calls ASIC Control Object to enable Timing generator.
- *
- * Return: Always returns true
- */
-bool optc401_enable_crtc(struct timing_generator *optc)
-{
-	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-
-	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
-	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
-			OPTC_SEG0_SRC_SEL, optc->inst);
-
-	/* VTG enable first is for HW workaround */
-	REG_UPDATE(CONTROL,
-			VTG0_ENABLE, 1);
-
-	REG_SEQ_START();
-
-	/* Enable CRTC */
-	REG_UPDATE_2(OTG_CONTROL,
-			OTG_DISABLE_POINT_CNTL, 2,
-			OTG_MASTER_EN, 1);
-
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
-	return true;
-}
 
 /* disable_crtc */
 bool optc401_disable_crtc(struct timing_generator *optc)
@@ -466,7 +434,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.setup_vertical_interrupt1 = optc1_setup_vertical_interrupt1,
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
 		.program_global_sync = optc401_program_global_sync,
-		.enable_crtc = optc401_enable_crtc,
+		.enable_crtc = optc31_enable_crtc,
 		.disable_crtc = optc401_disable_crtc,
 		.phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
 		.disable_phantom_crtc = optc401_disable_phantom_otg,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
index fa62737b5b1b..8e795e06e615 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
@@ -180,7 +180,6 @@ void optc401_program_global_sync(
 		int vupdate_offset,
 		int vupdate_width,
 		int pstate_keepout);
-bool optc401_enable_crtc(struct timing_generator *optc);
 bool optc401_disable_crtc(struct timing_generator *optc);
 void optc401_phantom_crtc_post_enable(struct timing_generator *optc);
 void optc401_disable_phantom_otg(struct timing_generator *optc);
-- 
2.47.2


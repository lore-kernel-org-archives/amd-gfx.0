Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F30C369DC
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 22:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C35510E096;
	Sun,  4 May 2025 22:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Fu+es2FT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0456810E096
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IU/vzOPQz+J3QqjLrISXm2dlZT7vfLS+7j4aMLTE+OI=; b=Fu+es2FTyp/qZtMYh5TlzkvjWw
 k2g8cgMXoD54KoQMFURl/nl1S11AzkvcGA89dkO/qqABDElB+7AWGkQaMyTPHbKRO5zgn7yB9k+n2
 DJsZVIYqxJvzz3sLga3GYS+pvdIlzT3Cu/rLIza3L7jzJPLk03lmUJObkBFMnNyfpkGSTUZTfmzXn
 AV3fy2QVK2jCbzfdZNcS5xGppnEk9tkIwr+ugjlbh0tQMwCQRC54E6vNE5+fNfPdXRhi3/pnryY8T
 gDQa20caJrEypXrpyj2YnS+G0g5IhdsF4f+Xi0Nm1FG1HKQm1FbVmQGsnNeMX6eX1ayHZ07zrRfpe
 s7oLaHnA==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBhWY-003Pr1-SW; Mon, 05 May 2025 00:12:22 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/4] drm/amd/display: Uses optc31_disable_crtc for DCN35
Date: Sun,  4 May 2025 16:11:30 -0600
Message-ID: <20250504221154.409695-4-siqueira@igalia.com>
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

The optc35_disable_crtc() function is a copy & paste from
optc31_disable_crtc. This commit removes the duplication in favor of
using optc31_disable_crtc.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 35 +------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 5835aa6c3c18..ec12aead3ced 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -109,39 +109,6 @@ static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	optc1->opp_count = opp_cnt;
 }
 
-/* disable_crtc */
-static bool optc35_disable_crtc(struct timing_generator *optc)
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
-			1, 100000);
-	optc1_clear_optc_underflow(optc);
-
-	return true;
-}
-
 static void optc35_phantom_crtc_post_enable(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -411,7 +378,7 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
 		.program_global_sync = optc1_program_global_sync,
 		.enable_crtc = optc31_enable_crtc,
-		.disable_crtc = optc35_disable_crtc,
+		.disable_crtc = optc31_disable_crtc,
 		.immediate_disable_crtc = optc31_immediate_disable_crtc,
 		.phantom_crtc_post_enable = optc35_phantom_crtc_post_enable,
 		/* used by enable_timing_synchronization. Not need for FPGA */
-- 
2.47.2


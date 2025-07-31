Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D8EC87FD3
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4229D10E746;
	Thu, 31 Jul 2025 09:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l8Hlom8/";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D22510E746
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:20 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so13532515e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955059; x=1754559859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/L2CHZtISYhoCoVaKCnfEJPiTLkvbSzrIhfeLdZlZ4=;
 b=l8Hlom8/nkMnEh9+HMxSIKxbe0JVgsVd5sT914z+ebweS0sYilNbxVH4nbFIYffEs6
 SDTALhrMQRIGXiZHkkdcDh1U8NwqDCp/AfMXNuQFWL0KufFolrzRO1/mwcPEVNGF1ZVM
 l6MwspJfGKsPJZ4E8HhiuZM/QZeSG5oKgFw2JCIdrwSugXmw6yWrX03wUTmLIMFcrYFp
 ZhilEq7R5srG4d2s/YvosDifhfqxw5rHl1ZrQH8A33oxpJL8eJxJgKBsjUZ1QGnEpdLM
 xh0FAhygXBALYG7/dqmLL9S7qPQBBOgE9WclaMNgLa9lqNlxCD4+HCanWhKUPArw+6AM
 aAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955059; x=1754559859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/L2CHZtISYhoCoVaKCnfEJPiTLkvbSzrIhfeLdZlZ4=;
 b=a8CDwnlR7qYVxLu1KgDddLfyLI9dcyMLUILQ6JFhB2Utr0l7dlhY32fBrfGaHVNv1H
 v8HgZyrSYy5kS5/G+Wi6EYeGSJdQDUTVeWMjzPMTCl7kbewGEGXPwYIMafmRKkWFaD98
 Gqwt8+xlvX+RKXHRi5tOn6ckHGUbPLgqjvmMohS6XkP2JpmW/wtFoEi8C8Brv4RKXdwI
 cmatQSvKGMzl9kIjhSRZfX+Tn4MncVXhmuUAFheMwic6/Dxn7PAWbM/hCspV8dF9axne
 EbCKWjuHYs15xcXxky7HcJCX1IgyykVvXMlhvpebLlCDRHV3I19H4t+REVVfPmQhY4wm
 dP1w==
X-Gm-Message-State: AOJu0YwoquNFF8ERBR5ScFM8Pi3wij7oVhP3E20Vfl28jDDIl7lxvc1K
 Rd070C5b1ujxXOpuIxUx0oBwb+JcgVDPgYlU/S580zLlWZpEZZAHsMUXP/FCLQ==
X-Gm-Gg: ASbGncvr6pN+HpYx0eQaiImcBc4vZTMcB1aulWi9WixWV+zCrNyxSuNLknUpc2un+g/
 zX8Mb+sIMZqih2NBgKVnApsj4WXNYt2FBU50ST9dl7HbEAdk6X6ogPsAt95vZOO4e2XEpK6Is4Y
 +snxPmc6wEOM2jrs93H18m8Q1ExCeRbhG+HN9unfTrr2dQKpbrlzY9YtwUmGOHQ6Tqi4CAotXyv
 T5BJvY8R2jw1Idkp0AOx7leSm3EpZTeDBNxROFR6pNF2NL6/Mw+Gu6x1FJyz5jNUp3+dNbKWC7Q
 KowZz/SkhQLfijd2J30dqVUmUQ1Vu/CLL1xnyNfr6gLlMhJZ1A8wpcn6/owiAgf80N5y+SYne9t
 2MeRL6UyLwZXR9o/QJeFS/sUasAmeZFdcLrKmbNdlcNldqrMbLomDOo39iquiKOvhByAyfJKz28
 sEtT1O448wrZ7BqhmrE+U=
X-Google-Smtp-Source: AGHT+IFMzqCkhVfn8Y1K20YG2ZHKVBfD4fWsVSIJeGQ/eA3phy3DP4chZwDJbAlM1Ew/HTgZ0k5Jpw==
X-Received: by 2002:a05:600c:1907:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-458a22153bemr15904235e9.6.1753955058472; 
 Thu, 31 Jul 2025 02:44:18 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:17 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/7] drm/amd/display: Find first CRTC and its line time in
 dce110_fill_display_configs
Date: Thu, 31 Jul 2025 11:43:48 +0200
Message-ID: <20250731094352.29528-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
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

dce110_fill_display_configs is shared between DCE 6-11, and
finding the first CRTC and its line time is relevant to DCE 6 too.
Move the code to find it from DCE 11 specific code.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index f8409453434c..baeac8f1c04f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -120,9 +120,12 @@ void dce110_fill_display_configs(
 	const struct dc_state *context,
 	struct dm_pp_display_configuration *pp_display_cfg)
 {
+	struct dc *dc = context->clk_mgr->ctx->dc;
 	int j;
 	int num_cfgs = 0;
 
+	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
+
 	for (j = 0; j < context->stream_count; j++) {
 		int k;
 
@@ -164,6 +167,23 @@ void dce110_fill_display_configs(
 		cfg->v_refresh /= stream->timing.h_total;
 		cfg->v_refresh = (cfg->v_refresh + stream->timing.v_total / 2)
 							/ stream->timing.v_total;
+
+		/* Find first CRTC index and calculate its line time.
+		 * This is necessary for DPM on SI GPUs.
+		 */
+		if (cfg->pipe_idx < pp_display_cfg->crtc_index) {
+			const struct dc_crtc_timing *timing =
+				&context->streams[0]->timing;
+
+			pp_display_cfg->crtc_index = cfg->pipe_idx;
+			pp_display_cfg->line_time_in_us =
+				timing->h_total * 10000 / timing->pix_clk_100hz;
+		}
+	}
+
+	if (!num_cfgs) {
+		pp_display_cfg->crtc_index = 0;
+		pp_display_cfg->line_time_in_us = 0;
 	}
 
 	pp_display_cfg->display_count = num_cfgs;
@@ -232,16 +252,6 @@ void dce11_pplib_apply_display_requirements(
 
 	dce110_fill_display_configs(context, pp_display_cfg);
 
-	/* TODO: is this still applicable?*/
-	if (pp_display_cfg->display_count == 1) {
-		const struct dc_crtc_timing *timing =
-			&context->streams[0]->timing;
-
-		pp_display_cfg->crtc_index =
-			pp_display_cfg->disp_configs[0].pipe_idx;
-		pp_display_cfg->line_time_in_us = timing->h_total * 10000 / timing->pix_clk_100hz;
-	}
-
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
 		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
 }
-- 
2.50.1


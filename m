Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BB3C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B9B60FD9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2B9B60FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7299897E8;
	Wed, 11 Aug 2021 13:46:17 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83AB6E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 04:10:10 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id q2so960283plr.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/wJfRZLEp+ItaTTKtybUVmvtpffSN0Nq150cjRjLrEQ=;
 b=Yt29gfp+B7nTWKlA5BBiyzBSgLpJ/zduU+YJZkiQa3yBpCB3/Ffth3ub10wahvqlUN
 ce5bwXsSO5BHGm68qvaERm8CwcGwI/TkPf557y7zeU8wbE8V01MQ4ASHnuLlHxHchqpP
 AYDbTwgNmsYNsdcf55k+EISVJ8wvPXmOj6W+4xTquEBfdXNwPfNqfpiAl9gpAeyUbc3u
 3zt0GVCLD5aFtWTSngNece1HV0Ic66PDZvA6b/WgkNOjE+7CZvA5rtL8hmQTDXqnT1z6
 prE1B1iCLW2g0NHSqU7OlOnH/EGaKKZDwhOAERScj2S3yYxqhnbNi0ODaLftEL5fbe3z
 p3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/wJfRZLEp+ItaTTKtybUVmvtpffSN0Nq150cjRjLrEQ=;
 b=GVa1icmdw5ftiHXHClEcJO7cKGQeS0z/aDG7Al4PJGpsp2I2cA0R0SscWmAn2loa8L
 y7X29yCRX+2OQt5rgkrm7sA/u6l8d6ovboE/RKxFLMBqcYWcS7KhfBA26O/33TybsD1X
 EOHF+58Yljhcu1Np6iNndTrG+1WMFMEsdEcZmt882py7Rcpp26YrkRsOHy6ReF4AWPwG
 aLbjkI3MkDHXf616OH70VX4YNnhhZRl5YxYMf3e0LkiK/YZ9k3NKJ3oQM1Ol4K6CxvLC
 sS6rIcl1H9ezZtf6mwE2+ShZN2BuUHhiYNThFNiH/0mboc8TQULjlLmeFz4lJswjFD6g
 9cSg==
X-Gm-Message-State: AOAM533inDZ/K/Gl0rlq/xOy+UkgbpiUh6XZWb+/BjpsqT9mgTdfC3uM
 oQqfzN22pTTcUWns0wAt1D4=
X-Google-Smtp-Source: ABdhPJxHF2JTfMzbFZ6ciYU2zB1hy3ZcG4eci0A8afkG/3n+hAR1K2/VkWJ4VKFqg4/Bmd8/EG8i2g==
X-Received: by 2002:a17:90a:d251:: with SMTP id
 o17mr35125391pjw.200.1628655010203; 
 Tue, 10 Aug 2021 21:10:10 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.103])
 by smtp.gmail.com with ESMTPSA id w11sm30636011pgk.34.2021.08.10.21.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 21:10:09 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, Jun.Lei@amd.com, Rodrigo.Siqueira@amd.com,
 eryk.brol@amd.com, aric.cyr@amd.com, vladimir.stempen@amd.com,
 alvin.lee2@amd.com, qingqing.zhuo@amd.com, isabel.zhang@amd.com,
 sung.lee@amd.com, Samson.Tam@amd.com, paul.hsieh@amd.com,
 wyatt.wood@amd.com
Cc: amd-gfx@lists.freedesktop.org, baijiaju1990@gmail.com,
 Tuo Li <islituo@gmail.com>, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH v2] drm/display: fix possible null-pointer dereference in
 dcn10_set_clock()
Date: Tue, 10 Aug 2021 21:07:03 -0700
Message-Id: <20210811040703.4770-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Aug 2021 13:46:15 +0000
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

The variable dc->clk_mgr is checked in:
  if (dc->clk_mgr && dc->clk_mgr->funcs->get_clock)

This indicates dc->clk_mgr can be NULL.
However, it is dereferenced in:
    if (!dc->clk_mgr->funcs->get_clock)

To fix this null-pointer dereference, check dc->clk_mgr and the function
pointer dc->clk_mgr->funcs->get_clock earlier, and return if one of them
is NULL.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
v2:
* Move the check of function pointer dc->clk_mgr->funcs->get_clock earlier
and return if it is NULL.
  Thank Chen, Guchun for helpful advice.
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c545eddabdcc..03e1c643502e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3631,13 +3631,12 @@ enum dc_status dcn10_set_clock(struct dc *dc,
 	struct dc_clock_config clock_cfg = {0};
 	struct dc_clocks *current_clocks = &context->bw_ctx.bw.dcn.clk;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->get_clock)
-				dc->clk_mgr->funcs->get_clock(dc->clk_mgr,
-						context, clock_type, &clock_cfg);
-
-	if (!dc->clk_mgr->funcs->get_clock)
+	if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_clock)
 		return DC_FAIL_UNSUPPORTED_1;
 
+	dc->clk_mgr->funcs->get_clock(dc->clk_mgr,
+		context, clock_type, &clock_cfg);
+
 	if (clk_khz > clock_cfg.max_clock_khz)
 		return DC_FAIL_CLK_EXCEED_MAX;
 
@@ -3655,7 +3654,7 @@ enum dc_status dcn10_set_clock(struct dc *dc,
 	else
 		return DC_ERROR_UNEXPECTED;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->update_clocks)
+	if (dc->clk_mgr->funcs->update_clocks)
 				dc->clk_mgr->funcs->update_clocks(dc->clk_mgr,
 				context, true);
 	return DC_OK;
-- 
2.25.1


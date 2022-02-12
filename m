Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09329C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Feb 2022 15:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411F010E139;
	Sat, 12 Feb 2022 15:39:59 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB3F10E139
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Feb 2022 15:39:57 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id n8so2294082wms.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Feb 2022 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcKAkqRgnJE6gU8aYaV6EzLMt4npUnlP+3SMFtcLqUk=;
 b=MMyuNd05g0s5Zo8Pj5qwJou46f4mkZvKZ4Lz4Q7CgwtiSXfiq7JnOwYvjNFdlej2PK
 u9sJ7pwbQ9zwVDLrCMOnTO/e41ZQ1rwQBkzAxLn0VlM+eGk86ohbAeAYg3+Sjfhsb2qx
 qFUf7G3QFeSnN5O995Hus7G5Fikt5fnRdkkMIWPo821aLYYclprncLnxwQfAB8vj/2HY
 u/jWDg+/1jiKOiUgNWbF8LL9+AnCnljEK1SUneuZy4IyLREhZQJ5quZfILCQwYn74ur9
 ZiE0OosiE8pb4jd2iYYtAtW43W49P8VjPzBiDBJ2FNt/kUC9F63gHOitpvR0zlf3VnQk
 +WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcKAkqRgnJE6gU8aYaV6EzLMt4npUnlP+3SMFtcLqUk=;
 b=5/YbJj2HafJ5Lcc7oWJN1B1/dxQD1SJk4WDB8/YpR37EPqZNf6sFAXWom5P/7MnETK
 +uRfTOlA8zZhCzw4AoywTssPSm4LK/UHVpV3iHFVfkmU6+r+VrvZYzBjmVlOCyHCQLpZ
 zwDg5pq85Q10gbtIPqcEc2OFQMpwb5uLS4hrdW1g+4D/Aq3zg7vvjCTL40arTdIjx+3g
 9ME5OKkDI3mkCIauD9/MsazNDtAd/zoYgzBnBi6g1kctXNQglJLN9/WOuz68NrFLTJvc
 XQ4Mca1jBnhFR9FNX4/K0ZTuTGzBt9Bp++4xWP/E7GIjlgrmLrLta7OSSTA9xuPsSdwt
 0YCA==
X-Gm-Message-State: AOAM532DcvTMKArY07wh+abzATeXlr7JLSWjDtX+8eAanz2QyqHfdMl+
 vhTEer15SLXyCeFl2mGLw+hcQYNygAoUVSWX
X-Google-Smtp-Source: ABdhPJxBhyl+qvIKPaMPtY3G7VBlDBSv31XcsBCcl/hhU5UmbeClFTgOaKUDguLOQuMAsj6l6SYqWQ==
X-Received: by 2002:a05:600c:4fcf:: with SMTP id
 o15mr4493717wmq.145.1644680396138; 
 Sat, 12 Feb 2022 07:39:56 -0800 (PST)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id b15sm19506435wri.96.2022.02.12.07.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Feb 2022 07:39:55 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Protect update_bw_bounding_box FPU code.
Date: Sat, 12 Feb 2022 16:40:00 +0100
Message-Id: <20220212154000.2102141-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.35.1
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
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For DCN3/3.01/3.02 at least these use the fpu.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c                     | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 589131d415fd..220682e45b8d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -474,8 +474,10 @@ static void dcn3_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	clk_mgr_base->bw_params->dc_mode_softmax_memclk = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
 
 	/* Refresh bounding box */
+	DC_FP_START();
 	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
 			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
+	DC_FP_END();
 }
 
 static bool dcn3_is_smu_present(struct clk_mgr *clk_mgr_base)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 467f606ba2c7..e46ec8cc2d0a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -987,8 +987,11 @@ static bool dc_construct(struct dc *dc,
 	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
 #endif
 
-	if (dc->res_pool->funcs->update_bw_bounding_box)
+	if (dc->res_pool->funcs->update_bw_bounding_box) {
+		DC_FP_START();
 		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+		DC_FP_END();
+	}
 
 	/* Creation of current_state must occur after dc->dml
 	 * is initialized in dc_create_resource_pool because
-- 
2.35.1


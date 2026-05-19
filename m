Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB93CCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A55D10EBF4;
	Tue, 19 May 2026 10:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r3Wv+aJL";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DF110EBF4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:27 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-452169ae568so2154906f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186086; x=1779790886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4vaAc09SxlbGgADT+w++6lfHiaqt3MjzGScWORc/xg=;
 b=r3Wv+aJLgBljSQNmFG866IC1DFqQEhB5m9ygSXzys1DarAS1bSmVK6eLo+LaznTDst
 lnAVDAghHIDY2wMOhif+U6qOI3+K9irF8c8IP+SNku86HPQ6P6emLubQAnrVagJD50qA
 cZcSgPaJScyemHTal691GiNmxCEtpkXLz1Ha49PegwWMEPwslPRqe7HuDb6RXeg5yleB
 z9OMAD01WLD+M1AIkEbl5SzNP1uVMf2xEpYw9JtlrjjhBID7A90X5ls1mi3zKDKCNFto
 Pi2+T++1PKjXCVn07apJw2rEz2fkFSgxHr4ewyGNQNXPn33D42FpxBCFrSDCZ9pFaVob
 UWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186086; x=1779790886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o4vaAc09SxlbGgADT+w++6lfHiaqt3MjzGScWORc/xg=;
 b=HsOkeOIJD9B+mfBxzWWKmKMyjM3FGPpH2aibUn83DMijUHaUegBQ9dkXh3CbVqhTQx
 6CX7UPcDz22Wwg/PlMPiO6amHQr92lKotweLQcyBxGDF4shMKPS9RMieTZp049FSpjT3
 jN+gKoLbIp5VsJbnqGK89xHFQ5hnHSj702vcxbZHjmQT6hI03RZ2t7BW+/lF7+iSGmgO
 74/nD8g8vfHax90J8tIyKa1sOxEwdFhvgoj91yxIxHAQNdWWv3QD4I89Jc0eXXHQjwpf
 ujPjBYtsZ6rPYLj7xnZ1w6CUkhoXA02BYxoYPR8Y0NgdbLiehxpERUaT8ADoLosIbN7t
 oITw==
X-Gm-Message-State: AOJu0YxcSoFeNomc6kjvVaFi553kRITm+a5CaWSvoOr4dp86zBKpNCRf
 lsFcmlwFdpVNAegd7/9Ji/2884IArWihiOw79AoBLiKZmUWqt8dSt7klEOF5WYv2
X-Gm-Gg: Acq92OF2QBKP/lNsfcLDNcwrFqgGtRa8c7NCDeiSbSyTtFaYKIjF3yAex5eqkadjYYU
 YnAXYIpvvnRyhpSPNRXuqNqrt5yn9dTiAtbAWTfaPPqwqKeWmUnu0bVV/zx3sHPoZMI5fhsIA8N
 SMWvYhUTqW8BgbIN6IsgpsvKIMiXpd+Oxf2BOsCfGOH6dDp+ZNZeH/YDFNJXrltInhPHN87YebN
 cgjprv2+fthLiJkV7i21ad1qMs5uS7anDDEH1qA7U/O5PFzw9DFvkAcZ3IUdlsTUQ+3VToPY3XR
 tVm9p7ZDTx8IIQxcvgL24LuEXW0rnKYUDWnSnbZurIyMRWFEt6Nk5mOGAfRAkpF+Khmdq/tWIWm
 RDjPQtEekSizuoY2WVgZ7d9qMNo8vKwIoVWxD3J0MXmd+BIkBJAOXbme8eXAJdsUv8lLsBVUzAI
 a7N3kwMNYBgwHIfA0H3sMfrrnocEoGpC6pK11/mES3hFWAWuC7DBcbwXUUMt8dPjEd
X-Received: by 2002:a05:6000:4021:b0:453:e3a1:6580 with SMTP id
 ffacd0b85a97d-45e5c5fd95dmr31867041f8f.25.1779186086352; 
 Tue, 19 May 2026 03:21:26 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/14] drm/amd/display: Set max supported display clock
 without max_clks_by_state (v2)
Date: Tue, 19 May 2026 12:21:09 +0200
Message-ID: <20260519102118.246466-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
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

The max_clks_by_state was based on hardcoded values, which are
not really used anywhere, only to know the maximum clock.
Just hardcode the same maximum clock for each DCE version.

v2:
- Use previous max display clock for DCE 11.2

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index b7b72af9570a..978bbc307991 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -391,9 +391,7 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
 {
-	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	const int max_disp_clk =
-		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	const int max_disp_clk = clk_mgr_base->clks.max_supported_dispclk_khz;
 	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
@@ -445,8 +443,16 @@ void dce_clk_mgr_construct(
 	clk_mgr->dprefclk_ss_divider = 1000;
 	clk_mgr->ss_on_dprefclk = false;
 
-	base->clks.max_supported_dispclk_khz =
-		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	if (ctx->dce_version >= DCE_VERSION_12_0)
+		base->clks.max_supported_dispclk_khz = 1133000;
+	else if (ctx->dce_version >= DCE_VERSION_11_2)
+		base->clks.max_supported_dispclk_khz = 1132000;
+	else if (ctx->dce_version >= DCE_VERSION_11_0)
+		base->clks.max_supported_dispclk_khz = 643000;
+	else if (ctx->dce_version >= DCE_VERSION_8_0)
+		base->clks.max_supported_dispclk_khz = 625000;
+	else
+		base->clks.max_supported_dispclk_khz = 600000;
 
 	dce_clock_read_integrated_info(clk_mgr);
 	dce_clock_read_ss_info(clk_mgr);
-- 
2.54.0


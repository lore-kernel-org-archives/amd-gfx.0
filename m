Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01376C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 12:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F9310FC07;
	Wed, 27 Mar 2024 12:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YpOECZV5";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C3410FC07;
 Wed, 27 Mar 2024 12:21:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4C8F0CE2635;
 Wed, 27 Mar 2024 12:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4526C43394;
 Wed, 27 Mar 2024 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711542061;
 bh=dsF2VZi3KNpgQhW3ZP/ZFTARJxILj1BvvaNu2RAW/Sc=;
 h=From:To:Cc:Subject:Date:From;
 b=YpOECZV5NYfx4SEx8/avqb87/2tJKpfZL79tUIzhnf0GD5oWPjE6E8L3yx0VIExgE
 9oZwb5zBl+gRUdRHg6JK8cwFxs3iIKlRlEfrrziLwRBuJqurKi9f/cfsdiKbkO94k/
 sNSUAFXGjVhnaOQMGQDQgHFV9FEORXBpXSLDVZTmKvcsybJeJ/CQsO9CQlvHF+Zrxd
 Q7ewruEiMa0hEbSnNVl3xiw67Wp3MuaGlNx7gBYd2I17TB+DWEed17xcRQ1wl/t7nc
 5m+ytQC8CoASm36gvDmvcPiKWe6k/9b3uvTcuFNEta8ezvJSgrYcQWkiZPuR2w53Lg
 I8CF3+gSTE1ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gabe.teeger@amd.com
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: FAILED: Patch "Revert "drm/amd/display: Send DTBCLK disable message
 on first commit"" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:20:59 -0400
Message-ID: <20240327122100.2836491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3a6a32b31a111f6e66526fb2d3cb13a876465076 Mon Sep 17 00:00:00 2001
From: Gabe Teeger <gabe.teeger@amd.com>
Date: Mon, 29 Jan 2024 13:31:44 -0500
Subject: [PATCH] Revert "drm/amd/display: Send DTBCLK disable message on first
 commit"

This reverts commit f341055b10bd8be55c3c995dff5f770b236b8ca9.

System hang observed, this commit is thought to be the
regression point.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 06edca50a8fa1..36e5bb611fb10 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -414,7 +414,6 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 
-	clk_mgr->clks.dtbclk_en = true;
 	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
 	clk_mgr->clks.p_state_change_support = true;
 	clk_mgr->clks.prev_p_state_change_support = true;
-- 
2.43.0





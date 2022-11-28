Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646FBC4321E
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Nov 2022 17:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD7610E313;
	Mon, 28 Nov 2022 17:40:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DAF10E311;
 Mon, 28 Nov 2022 17:40:20 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9633C612F3;
 Mon, 28 Nov 2022 17:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A471FC433D6;
 Mon, 28 Nov 2022 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669657219;
 bh=9u5TaViKnyQ/NGo9JoowSSVSG3Gh3W9jFt6MUomJw7Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jVrh1Yd3LzMwJaKaModYbyFbuWTMAwd8znkIrXoLmlkGB+pjHeV4i8kD2jjJ7Ctvb
 oSvL8V1rItoYpTmwTuRo8TcRDf18SHdWF7gN+mjxPIii5Mxi2LXWW6eCPa5v5wv8uJ
 Qz9lJKx4Eg+AkZSGdpslXkBGYSQ1bilhsztrZ/XTKhG5o4DyASvhu6TXf/TRJAS/zi
 jwuyBRkIRKEV3pfI1tZ2x9M3qMbIZ2N/CBHzMj7BfLYWAzSpkXF4enaY/7hf5CvzBi
 zj3tVv1A/1WtuJizJqfrU86Kjnw3tblOVnl0SLitRzshN8h5t+gW8iznBhjj0USPpC
 50JHLV92qqCPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 38/39] drm/amd/display: Use new num clk levels
 struct for max mclk index
Date: Mon, 28 Nov 2022 12:36:18 -0500
Message-Id: <20221128173642.1441232-38-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128173642.1441232-1-sashal@kernel.org>
References: <20221128173642.1441232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Brian Chang <Brian.Chang@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, David.Galiffi@amd.com,
 sunpeng.li@amd.com, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alvin.Lee2@amd.com, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[ Upstream commit e667ee3b0c049bf0c69426879586a2572bb28d26 ]

[WHY?]
When calculating watermark and dlg values, the max mclk level index and
associated speed are needed to find the correlated dummy latency value.
Currently the incorrect index is given due to a clock manager refactor.

[HOW?]
Use num_memclk_level from num_entries_per_clk struct for getting the correct max
mem speed.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b9d3a4000c3d..221253638b4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1797,7 +1797,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] ==
 			dm_dram_clock_change_unsupported) {
-			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries - 1;
+			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1;
 
 			min_dram_speed_mts =
 				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
-- 
2.35.1


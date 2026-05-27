Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8481CD6E50
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C4810ED20;
	Thu, 28 May 2026 07:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="ZcyIFdby";
	dkim-atps=neutral
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486F510E0E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1779893109;
 bh=Ri1tO8GMn6WbyO3R2aVVNaEbwovcSe6KpbCI36dIv1k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZcyIFdbyy/iHcklv8cEpjbajtkIf9uI55oL+1PLWlCOJyHcYDDbbB+2+6DTx05IoT
 qXxqdgz3Q8dSsqCidw5GR72R6OPqzk618X/N/aTqhuSSZ/qKLJaF7xLL6Px9USW0ng
 CoPobWO6gVa6UcwqZhkDoY8tzHsEdok3nL80JwcM=
Received: from stargazer (unknown
 [IPv6:2409:8a4c:e1b:e231:5a6e:b99e:242d:222b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id E134965988;
 Wed, 27 May 2026 10:45:05 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, Ovidiu Bunea <ovidiu.bunea@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Alex Hung <alex.hung@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y 1/8] drm/amd/display: Add min clock init for DML21 mode
 programming
Date: Wed, 27 May 2026 22:44:21 +0800
Message-ID: <20260527144428.1095001-2-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144428.1095001-1-xry111@xry111.site>
References: <20260527144428.1095001-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:41 +0000
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[ Upstream commit 23dee18f6503d67b195f1513e404c78653ed0d40 ]

[WHY & HOW]
0 stream cases do not go through any DML validation which leaves DCN
clocks in unoptimized states.

If requesting DML validation or programming with 0 streams, program
DCN clocks to lowest DPM state.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 25 +++++++++++++++++++
 .../dml2_0/dml21/dml21_translation_helper.h   |  1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index bf5e7f4e0416..5bf3008a71c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -927,3 +927,28 @@ void dml21_set_dc_p_state_type(
 	}
 }
 
+void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_state *context)
+{
+	unsigned int lowest_dpm_state_index = 0;
+	struct dc_clocks *min_clocks = &context->bw_ctx.bw.dcn.clk;
+
+	min_clocks->dispclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dispclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dcfclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dcfclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->dramclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.uclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->fclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.fclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->idle_dramclk_khz = 0;
+	min_clocks->idle_fclk_khz = 0;
+	min_clocks->dcfclk_deep_sleep_khz = 0;
+	min_clocks->fclk_p_state_change_support = true;
+	min_clocks->p_state_change_support = true;
+	min_clocks->dtbclk_en = false;
+	min_clocks->ref_dtbclk_khz = 0;
+	min_clocks->socclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.socclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->subvp_prefetch_dramclk_khz = 0;
+	min_clocks->subvp_prefetch_fclk_khz = 0;
+	min_clocks->phyclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.phyclk.clk_values_khz[lowest_dpm_state_index];
+	min_clocks->stutter_efficiency.base_efficiency = 1;
+	min_clocks->stutter_efficiency.low_power_efficiency = 1;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
index 9880d3e0398e..f51d3d8a52c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.h
@@ -25,4 +25,5 @@ void dml21_map_hw_resources(struct dml2_context *dml_ctx);
 void dml21_get_pipe_mcache_config(struct dc_state *context, struct pipe_ctx *pipe_ctx, struct dml2_per_plane_programming *pln_prog, struct dml2_pipe_configuration_descriptor *mcache_pipe_config);
 void dml21_set_dc_p_state_type(struct pipe_ctx *pipe_ctx, struct dml2_per_stream_programming *stream_programming, bool sub_vp_enabled);
 unsigned int map_plane_to_dml21_display_cfg(const struct dml2_context *dml_ctx, unsigned int stream_id, const struct dc_plane_state *plane, const struct dc_state *context);
+void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_state *context);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 798abb2b2e67..96c62bd6a37b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -215,6 +215,7 @@ static bool dml21_mode_check_and_programming(const struct dc *in_dc, struct dc_s
 		return true;
 
 	if (context->stream_count == 0) {
+		dml21_init_min_clocks_for_dc_state(dml_ctx, context);
 		dml21_build_fams2_programming(in_dc, context, dml_ctx);
 		return true;
 	}
-- 
2.54.0


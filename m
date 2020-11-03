Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6005AC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0594620773
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAkbk5Os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0594620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8102F6E8E3;
	Tue,  3 Nov 2020 17:39:55 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE0E6E8DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 17:39:54 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id o205so8725033qke.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 09:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QjKbioGrLYPWczqpY52S+b4WfarkCzGy8iZTGIyQgVw=;
 b=YAkbk5Os7WCOjfyFfiSY/7BBc2me2j2j9GCkoa4V9MiIYI795O4ht7g6DU+GP86JPY
 TUKcgxjvTUhwlITGWljWX33UNCDNeV2y9Yt0Z9AoTLOehuJL5T+a3tCnI7Qfm7odLExB
 zgiZsoI4tc6jv7pvAXlxjpcNaYFmbcW6C9BslR3uqa0G4nQIa9oHycGfy3uJO/Df5aoD
 905L5r8taR/kdsLLBK4SdfbsEUgRZeUKaIBr/y7hzXzOnq+9+zPpQ+H+FbODfA7s49jb
 Q58Wct2U8yB+s4EhcacvWLEiJUPy7n/hb5v6RY5YFta5/0pZN4idsDlc+Vv5K0N6y0/s
 phcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QjKbioGrLYPWczqpY52S+b4WfarkCzGy8iZTGIyQgVw=;
 b=MQVGEgH7VN6dNaz+yd7jrpiAKDj/aMEK7WCHFp0fUtP8D10kAEG9A0OF2SvJtLImtz
 cqbeA7kJIbc0YpzKYV/3R2Dk1B4w3ml3qiV1a442dpPvC88Qmpi8BoVkCQhMkdqK61Um
 d8eb1+DgaWoIrVTXWKOtOOVN0YKke0jbi+Rj5S2M1zutnOVo2Jl3STt1/eq1RA0wXe50
 jNPHs9x/2LhTMWQC9Ut087q1dxhMvGmWTRIBijApvQb6Maf5uoOglF4Q3n3RoEG9Dsrr
 V0Nx6SGeezKk1ebqRQtWpmVIIxpTsf0yar8uH/tw2Q8JUs5/TVeFZg4tcIQ6Q7GA9aih
 HwBw==
X-Gm-Message-State: AOAM533NVvhkmb4X8uy/G803om4y6L0lklkqJLuDdLzA7gfA+m825XPa
 301tXrjLVJjw2WwxMuwsBR8dCs8Tru8=
X-Google-Smtp-Source: ABdhPJxIp6fuyfJbMcpzh1WXI7hOF+LE06h3EkDWhXoYC+W2/1Jlo9yXv4hiGqmY9Gm+IWNxg5/pmw==
X-Received: by 2002:a37:e20a:: with SMTP id g10mr20110203qki.274.1604425192899; 
 Tue, 03 Nov 2020 09:39:52 -0800 (PST)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id 22sm11060663qkg.15.2020.11.03.09.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:39:52 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: FP fixes for DCN3.x (v2)
Date: Tue,  3 Nov 2020 12:39:44 -0500
Message-Id: <20201103173944.717710-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add proper FP_START/END handling and adjust Makefiles per
previous asics.

v2: fix up harder.

Reviewed-by: Harry Wentland <harry.wentland@amd.com> (v1)
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   | 13 ++++
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 71 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  8 ++-
 4 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index facc8b970300..9f9137562cab 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -127,6 +127,19 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN30)
 ###############################################################################
 CLK_MGR_DCN301 = vg_clk_mgr.o dcn301_smu.o
 
+# prevent build errors regarding soft-float vs hard-float FP ABI tags
+# this code is currently unused on ppc64, as it applies to VanGogh APUs only
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn301/vg_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
+endif
+
+# prevent build errors:
+# ...: '-mgeneral-regs-only' is incompatible with the use of floating-point types
+# this file is unused on arm64, just like on ppc64
+ifdef CONFIG_ARM64
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/clk_mgr/dcn301/vg_clk_mgr.o := -mgeneral-regs-only
+endif
+
 AMD_DAL_CLK_MGR_DCN301 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn301/,$(CLK_MGR_DCN301))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN301)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 7bad73b2d146..82cb688ba5e0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -104,7 +104,7 @@ static void dcn3_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e clk
 	}
 }
 
-static void dcn3_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
+static noinline void dcn3_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
 {
 	/* defaults */
 	double pstate_latency_us = clk_mgr->base.ctx->dc->dml.soc.dram_clock_change_latency_us;
@@ -211,7 +211,9 @@ void dcn3_init_clocks(struct clk_mgr *clk_mgr_base)
 	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
 
 	/* WM range table */
+	DC_FP_START();
 	dcn3_build_wm_range_table(clk_mgr);
+	DC_FP_END();
 }
 
 static int dcn30_get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index d65496917e93..01ac8b2921c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1469,7 +1469,19 @@ int dcn30_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-void dcn30_populate_dml_writeback_from_context(
+/*
+ * This must be noinline to ensure anything that deals with FP registers
+ * is contained within this call; previously our compiling with hard-float
+ * would result in fp instructions being emitted outside of the boundaries
+ * of the DC_FP_START/END macros, which makes sense as the compiler has no
+ * idea about what is wrapped and what is not
+ *
+ * This is largely just a workaround to avoid breakage introduced with 5.6,
+ * ideally all fp-using code should be moved into its own file, only that
+ * should be compiled with hard-float, and all code exported from there
+ * should be strictly wrapped with DC_FP_START/END
+ */
+static noinline void dcn30_populate_dml_writeback_from_context_fp(
 		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
 {
 	int pipe_cnt, i, j;
@@ -1558,6 +1570,14 @@ void dcn30_populate_dml_writeback_from_context(
 
 }
 
+void dcn30_populate_dml_writeback_from_context(
+		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
+{
+	DC_FP_START();
+	dcn30_populate_dml_writeback_from_context_fp(dc, res_ctx, pipes);
+	DC_FP_END();
+}
+
 unsigned int dcn30_calc_max_scaled_time(
 		unsigned int time_per_pixel,
 		enum mmhubbub_wbif_mode mode,
@@ -2204,7 +2224,19 @@ static bool dcn30_internal_validate_bw(
 	return out;
 }
 
-void dcn30_calculate_wm_and_dlg(
+/*
+ * This must be noinline to ensure anything that deals with FP registers
+ * is contained within this call; previously our compiling with hard-float
+ * would result in fp instructions being emitted outside of the boundaries
+ * of the DC_FP_START/END macros, which makes sense as the compiler has no
+ * idea about what is wrapped and what is not
+ *
+ * This is largely just a workaround to avoid breakage introduced with 5.6,
+ * ideally all fp-using code should be moved into its own file, only that
+ * should be compiled with hard-float, and all code exported from there
+ * should be strictly wrapped with DC_FP_START/END
+ */
+static noinline void dcn30_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
@@ -2360,7 +2392,18 @@ void dcn30_calculate_wm_and_dlg(
 				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 }
 
-bool dcn30_validate_bandwidth(struct dc *dc,
+void dcn30_calculate_wm_and_dlg(
+		struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel)
+{
+	DC_FP_START();
+	dcn30_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
+	DC_FP_END();
+}
+
+static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -2411,7 +2454,20 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
-static void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+bool dcn30_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate)
+{
+	bool out;
+
+	DC_FP_START();
+	out = dcn30_validate_bandwidth_fp(dc, context, fast_validate);
+	DC_FP_END();
+
+	return out;
+}
+
+static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
                                                        unsigned int *optimal_dcfclk,
                                                        unsigned int *optimal_fclk)
 {
@@ -2478,8 +2534,10 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 
 		// Calculate optimal dcfclk for each uclk
 		for (i = 0; i < num_uclk_states; i++) {
+			DC_FP_START();
 			get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
 					&optimal_dcfclk_for_uclk[i], NULL);
+			DC_FP_END();
 			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
 				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
 			}
@@ -2583,6 +2641,8 @@ static bool dcn30_resource_construct(
 	struct irq_service_init_data init_data;
 	struct ddc_service_init_data ddc_init_data;
 
+	DC_FP_START();
+
 	ctx->dc_bios->regs = &bios_regs;
 
 	pool->base.res_cap = &res_cap_dcn3;
@@ -2860,10 +2920,13 @@ static bool dcn30_resource_construct(
 		pool->base.oem_device = NULL;
 	}
 
+	DC_FP_END();
+
 	return true;
 
 create_fail:
 
+	DC_FP_END();
 	dcn30_resource_destruct(pool);
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 879a930358a5..a02a33dcd70b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -64,6 +64,9 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
@@ -71,8 +74,9 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflag
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_rcflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

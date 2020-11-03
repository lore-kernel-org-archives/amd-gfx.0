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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65384C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 21:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B0B21534
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 21:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgVDpVkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B0B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B6D6E904;
	Tue,  3 Nov 2020 21:30:27 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA706E904
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 21:30:26 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id e5so5064960qvr.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LEhPiV0HxtfmE7Rg7+bWVtfT1UR0Y5VhNzsbV61zO0I=;
 b=ZgVDpVkUHdG7e1JZNCDIB+ESEYKQO7CvOHK1Q7s2vXRvDoFhy5xv+w95/y0TR6lvuC
 cvYyS1v8kWHiffyCZj9AsL/bhe2ElFdXSUc3iBVZeSmauTpneZcWvTKRs0R7eScdQByo
 5HjyaR3GVKihLUI9xN5d3CZDn1uJbVTdlzJ2fAFkh6AH7tjxQ9t4LmdCFLV5deSmP1Rh
 Tc/JVx4Wv4f3+rHbbAF48TDKg+VfcnITfw5VkooBNHiDBMYMfmtekTuBbheF53XLVDlu
 jC2B+sMSqkQH/bfWVpBmrOLSpMp/U5BnAsawJxDM46LrDfs/QCzZqKtCpsbBSuQeXk3c
 dltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LEhPiV0HxtfmE7Rg7+bWVtfT1UR0Y5VhNzsbV61zO0I=;
 b=dpNSX+Co0j2Mc+9mpF3GCANHUPMfw0Z6WZRr5utzlRC6wLCQ2EzgRsP2xHfnMe8OHl
 3dtqw4PfeZZgp4HFy1qZvYXgWUFEw+NXMlnTt67UjI7O7xGUJuq1IKfFN+MO6wxIR2wo
 5ZFqWP4d28wIGXusB5FiTtQ+rDUO5fAFqallVnScnlzHPyBJVtz/uJx6vWpTqTznYLHr
 Z8aCVqWGfQg07w7cav4U42wcTW2/MPZO7BTA87vI5incGrr0ohNCSfn5iAoNK150r4LF
 A+HpqDj8U1bTOKnvurR8e2m7XyOzIbTwUy+XQy030Az7DTkx7UOfrtiX7Q8m+0xEajdb
 HbOQ==
X-Gm-Message-State: AOAM531OKtlYk05Vgps0N3M3/WEHobq4Rw1Lr9vN6WWTBw+qvPMNkiUR
 ZHCR/U450CB5nnavvRXFeXZROAH6Flk=
X-Google-Smtp-Source: ABdhPJzpOdmO1x0tkHGdu20vVmYge1IOPi4k4AtgduF0qWSYtnbysA/XEqwD5kOZlbM74wqo4PrYsw==
X-Received: by 2002:a0c:a8e0:: with SMTP id h32mr28539314qvc.39.1604439025269; 
 Tue, 03 Nov 2020 13:30:25 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 8sm10217930qkk.90.2020.11.03.13.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 13:30:24 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: FP fixes for DCN3.x (v3)
Date: Tue,  3 Nov 2020 16:30:16 -0500
Message-Id: <20201103213017.801082-1-alexander.deucher@amd.com>
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
v3: fix clkmgr Makefile for dcn30

Reviewed-by: Harry Wentland <harry.wentland@amd.com> (v1)
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   | 26 +++++++
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 71 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  8 ++-
 4 files changed, 102 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index facc8b970300..d59b380e7b7f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -119,6 +119,19 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN21)
 ###############################################################################
 CLK_MGR_DCN30 = dcn30_clk_mgr.o dcn30_clk_mgr_smu_msg.o
 
+# prevent build errors regarding soft-float vs hard-float FP ABI tags
+# this code is currently unused on ppc64, as it applies to VanGogh APUs only
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn30/dcn30_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
+endif
+
+# prevent build errors:
+# ...: '-mgeneral-regs-only' is incompatible with the use of floating-point types
+# this file is unused on arm64, just like on ppc64
+ifdef CONFIG_ARM64
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/clk_mgr/dcn30/dcn30_clk_mgr.o := -mgeneral-regs-only
+endif
+
 AMD_DAL_CLK_MGR_DCN30 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn30/,$(CLK_MGR_DCN30))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN30)
@@ -127,6 +140,19 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN30)
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

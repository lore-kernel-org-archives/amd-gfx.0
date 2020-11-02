Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3FEC00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 22:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AA220786
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 22:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfWbv/M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AA220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E5B6E40C;
	Mon,  2 Nov 2020 22:28:14 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1C26E40C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 22:28:13 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id m65so10340182qte.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 14:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tLzjo6rFFvNnM3eGuGZ3NZWynitEnrxtJp97LUX+NFM=;
 b=pfWbv/M9RbiIhW/5F6UQcgintnEmDbLDipzs1fdP1aBVhG6utyy1q7oU1obcqi1q9z
 XUSgGeLn0XNBoBAw9yeV9D0zXYX/ZIfkZsNn3t/mInyrF9edTBfSH0is2Ce5hUA2fb/R
 IsSQKbzFzGB+kw6Xo5ZJphIUCovDNQ4WQkNSvXqZ0g4zQvXmv/3hQAjvxD0MvALeO4vf
 gAMz9t3KXWawMdL1pNdq8/C2JWFaZyPaEXF/NZaUmgQLDPcuej6/caBx51otCTWkjFzt
 gRmhWfPKLSLCkQ7ELro73bu6e11ZEK6I3FQDqoCpKBXAETZmtnJxLYMqfN1EZnK4pC7/
 rkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tLzjo6rFFvNnM3eGuGZ3NZWynitEnrxtJp97LUX+NFM=;
 b=l9J3XwtKUlG26ldccrbqhFp09HHy5EWRY8lToWXv9diMJQo5oXdF+yBmDXe97EfZQ7
 HgrqlcrYvxmraBV6dKjiBkrHXQBtExJVjYTfQjwqYDtaSEAoyJylP+JLeio8+sWlna1/
 6OiNGie3P4Uty7Z7g8gX/vSFFgzgd35Ql83fTrZU+iyaOdvpr5yg/oLdhKi4uAo8Wi+l
 vq0TNc695EhdF9+ICB8PFkAHwgrsl/TXlQmRX7ms8+LAWlZzbKIiPHW9UJJnSERbWnVY
 1xg/09BEznmoAJNS27cqbx2ALt/rnmK7CcXpGmNEpxUbJIPs0eosRVGf61Ynm2yx5E1E
 3dIQ==
X-Gm-Message-State: AOAM531F1B4Kqj3Bflo2NnV146ijPXF8ZF+phKYRLH+2AURIiuZzX6wi
 UnIRO0V7Ijn2NlGOO7zn/iPazWsrXqo=
X-Google-Smtp-Source: ABdhPJxaNm901R3P/nc/diOgcsY8Y/cy6Fe7+wZK3lBkAH4tuLwNmEFoQWV94uhHfAK0LP4ddihj2Q==
X-Received: by 2002:ac8:3805:: with SMTP id q5mr7131847qtb.53.1604356092427;
 Mon, 02 Nov 2020 14:28:12 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id v204sm9196961qka.4.2020.11.02.14.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 14:28:11 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: FP fixes for DCN3.x
Date: Mon,  2 Nov 2020 17:28:00 -0500
Message-Id: <20201102222800.334556-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add proper FP_START/END handling and adjust Makefiles per
previous asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   | 13 ++++
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 71 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |  6 +-
 3 files changed, 84 insertions(+), 6 deletions(-)

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
index 879a930358a5..8866e1348b65 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -64,6 +64,8 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
@@ -71,8 +73,8 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflag
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_rcflags)
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags)
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

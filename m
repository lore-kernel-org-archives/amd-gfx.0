Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732AEC433EC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A9020787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sESeBYx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A9020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5016ECF3;
	Thu, 16 Jul 2020 21:23:22 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2B46ECF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:19 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f7so8664494wrw.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n+faQQWPp7WuRLDcpQav51hKcF8Aztl7i75TdLrBG6w=;
 b=sESeBYx7liD/VWCr9y51Tj5HtSZ7ON/5nTSqmodSjk5wcMPrnm0nZ2pdu7SoHaCseT
 zem5Zk0TE6FLmJlWVSA+RIAodaNCtq7ZNdWL42UIG7dvDTgC6UnWHCvhY881Xszkk7kG
 PrAH0qx1B1e9kj5uzab/KlXhgmKAoAdaqfKy5kNmxV+Ybz5nC26e+HAmoht6TDxGe9O1
 SYxm7dmDDgVoB4oT4Doa0CAucpB+NuMNmsz2SVXKfz9X5w7Fzi3ikPRSghy6Snp21N9i
 jbvMqkPsBmO/Am5N5jlUXQHU4+fCFAp0eSsjI3Iin5kc4Bt7AoXVk9gIVbzzmWvCwwIO
 k5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n+faQQWPp7WuRLDcpQav51hKcF8Aztl7i75TdLrBG6w=;
 b=efjkyukE+L7ZeRikJ17wVz79A4i/YQ5SurM1E0TspCIK2Qv8vAxYO4oKm3NPHAJcj9
 2JwqU9MyrLl4X3yaIt35s95bA3cn4b3+WvmbrbuvnPhaFNs2IJPXm2outGw4hcJeRx7f
 OQnGo7zONL8/rV+oUqXAj/lahtq1G8XtrYTxCopYU/DaVlRsyBu9o6uiOdbRqsoC9tL0
 tdWLN4DjjYE+/TFxj160wHmYT5mw1RPc8EsccrlKuQX+dd2MhqeXcQ1kQN83WKxISw6a
 FqCGAL3m+KwrmnkZg4yCsaGW4YIqxsoqWK4+faaLSyUrRlQ1WWFdPfLz+EsGVEWbFYMi
 GKLA==
X-Gm-Message-State: AOAM532TIRZ2oPq43ZCa1E1t7XjluWC5gr4qpgo0R6cBaHOeaeVWWnHE
 VaviOpqfX1kY4LCqexQssNbxdt7mui4=
X-Google-Smtp-Source: ABdhPJynl8E/2qz321CAvuPUAPq+TbyeCDy5KPxnfMerk+BUWPMCDDWuDmgmoTtW4JYy9xbHDrCFOw==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr6715709wrw.284.1594934597608; 
 Thu, 16 Jul 2020 14:23:17 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:17 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 09/27] drm/amd/display: dc/clk_mgr: add support for SI
 parts (v2)
Date: Thu, 16 Jul 2020 23:22:33 +0200
Message-Id: <20200716212251.1539094-10-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(v1) Changelog

[Why]
After commit c69dd2d "drm/amd/display: Refactor clk_mgr functions"
dc/clk_mgr requires these changes to add SI parts support
Necessary to avoid hitting default: ASSERT(0); /* Unknown Asic */
that would cause kernel freeze

[How]
Add case statement for FAMILY_SI chipsets

(v2) Changelog

[Why]
DCE6 has no DPREFCLK_CNTL register

[How]
Add DCE6 specific macros definitions for CLK registers and masks
Add DCE6 specific dce60/dce60_clk_mgr.c for DCE6 customization
Code style: reuse all the public functions in dce100/dce_clk_mgr.h header
Code style: use dce60_* static functions as per other DCE implementations
Add dce60_get_dp_ref_freq_khz() w/o using DPREFCLK_CNTL register
Use dce60_get_dp_ref_freq_khz() function in dce60_funcs
Add DCE6 specific dce60_clk_mgr_construct
dc/clk_mgr/dce_clk_mgr.c: use dce60_clk_mgr_construct for FAMILY_SI chipsets
Add Makefile rules for dce60_clk_mgr.o target conditional to CONFIG_DRM_AMD_DC_SI

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |  11 ++
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   6 +
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 174 ++++++++++++++++++
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 ++++
 4 files changed, 227 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 6874276bb2a1..52b1ce775a1e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -30,6 +30,17 @@ AMD_DAL_CLK_MGR = $(addprefix $(AMDDALPATH)/dc/clk_mgr/,$(CLK_MGR))
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR)
 
 
+ifdef CONFIG_DRM_AMD_DC_SI
+###############################################################################
+# DCE 60
+###############################################################################
+CLK_MGR_DCE60 = dce60_clk_mgr.o
+
+AMD_DAL_CLK_MGR_DCE60 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dce60/,$(CLK_MGR_DCE60))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCE60)
+endif
+
 ###############################################################################
 # DCE 100 and DCE8x
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 6a345d43028c..efb909ef7a0f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -34,6 +34,7 @@
 #include "dce110/dce110_clk_mgr.h"
 #include "dce112/dce112_clk_mgr.h"
 #include "dce120/dce120_clk_mgr.h"
+#include "dce60/dce60_clk_mgr.h"
 #include "dcn10/rv1_clk_mgr.h"
 #include "dcn10/rv2_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
@@ -123,6 +124,11 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	}
 
 	switch (asic_id.chip_family) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case FAMILY_SI:
+		dce60_clk_mgr_construct(ctx, clk_mgr);
+		break;
+#endif
 	case FAMILY_CI:
 	case FAMILY_KV:
 		dce_clk_mgr_construct(ctx, clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
new file mode 100644
index 000000000000..c11c6b3a787d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+
+#include "dccg.h"
+#include "clk_mgr_internal.h"
+#include "dce100/dce_clk_mgr.h"
+#include "dce110/dce110_clk_mgr.h"
+#include "dce60_clk_mgr.h"
+#include "reg_helper.h"
+#include "dmcu.h"
+#include "core_types.h"
+#include "dal_asic_id.h"
+
+/*
+ * Currently the register shifts and masks in this file are used for dce60
+ * which has no DPREFCLK_CNTL register
+ * TODO: remove this when DENTIST_DISPCLK_CNTL
+ * is moved to dccg, where it belongs
+ */
+#include "dce/dce_6_0_d.h"
+#include "dce/dce_6_0_sh_mask.h"
+
+#define REG(reg) \
+	(clk_mgr->regs->reg)
+
+#undef FN
+#define FN(reg_name, field_name) \
+	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
+
+/* set register offset */
+#define SR(reg_name)\
+	.reg_name = mm ## reg_name
+
+static const struct clk_mgr_registers disp_clk_regs = {
+		CLK_COMMON_REG_LIST_DCE60_BASE()
+};
+
+static const struct clk_mgr_shift disp_clk_shift = {
+		CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(__SHIFT)
+};
+
+static const struct clk_mgr_mask disp_clk_mask = {
+		CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(_MASK)
+};
+
+
+/* Max clock values for each state indexed by "enum clocks_state": */
+static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
+/* ClocksStateInvalid - should not be used */
+{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
+/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
+{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
+/* ClocksStateLow */
+{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
+/* ClocksStateNominal */
+{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
+/* ClocksStatePerformance */
+{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
+
+int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	int dprefclk_wdivider;
+	int dp_ref_clk_khz;
+	int target_div;
+
+	/* DCE6 has no DPREFCLK_CNTL to read DP Reference Clock source */
+
+	/* Read the mmDENTIST_DISPCLK_CNTL to get the currently
+	 * programmed DID DENTIST_DPREFCLK_WDIVIDER*/
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, &dprefclk_wdivider);
+
+	/* Convert DENTIST_DPREFCLK_WDIVIDERto actual divider*/
+	target_div = dentist_get_divider_from_did(dprefclk_wdivider);
+
+	/* Calculate the current DFS clock, in kHz.*/
+	dp_ref_clk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+		* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+
+	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
+}
+
+static void dce60_pplib_apply_display_requirements(
+	struct dc *dc,
+	struct dc_state *context)
+{
+	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
+
+	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
+
+	dce110_fill_display_configs(context, pp_display_cfg);
+
+	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
+		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
+}
+
+static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
+			struct dc_state *context,
+			bool safe_to_lower)
+{
+	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dm_pp_power_level_change_request level_change_req;
+	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
+
+	/*TODO: W/A for dal3 linux, investigate why this works */
+	if (!clk_mgr_dce->dfs_bypass_active)
+		patched_disp_clk = patched_disp_clk * 115 / 100;
+
+	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
+	/* get max clock state from PPLIB */
+	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
+			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
+		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
+			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
+	}
+
+	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
+		patched_disp_clk = dce_set_clock(clk_mgr_base, patched_disp_clk);
+		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
+	}
+	dce60_pplib_apply_display_requirements(clk_mgr_base->ctx->dc, context);
+}
+
+
+
+
+
+
+
+
+static struct clk_mgr_funcs dce60_funcs = {
+	.get_dp_ref_clk_frequency = dce60_get_dp_ref_freq_khz,
+	.update_clocks = dce60_update_clocks
+};
+
+void dce60_clk_mgr_construct(
+		struct dc_context *ctx,
+		struct clk_mgr_internal *clk_mgr)
+{
+	dce_clk_mgr_construct(ctx, clk_mgr);
+
+	memcpy(clk_mgr->max_clks_by_state,
+		dce60_max_clks_by_state,
+		sizeof(dce60_max_clks_by_state));
+
+	clk_mgr->regs = &disp_clk_regs;
+	clk_mgr->clk_mgr_shift = &disp_clk_shift;
+	clk_mgr->clk_mgr_mask = &disp_clk_mask;
+	clk_mgr->base.funcs = &dce60_funcs;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
new file mode 100644
index 000000000000..eca3e5168089
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+
+#ifndef DAL_DC_DCE_DCE60_CLK_MGR_H_
+#define DAL_DC_DCE_DCE60_CLK_MGR_H_
+
+#include "dc.h"
+
+void dce60_clk_mgr_construct(
+		struct dc_context *ctx,
+		struct clk_mgr_internal *clk_mgr_dce);
+
+#endif /* DAL_DC_DCE_DCE60_CLK_MGR_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E6DC43217
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F32910E5FE;
	Fri, 21 Oct 2022 07:32:43 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DF910E474
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 00:33:03 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id l32so1188979wms.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 17:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjJCQhdTXgJ2pFJtLYeurqN5W6QFWtUCD+sYZdvlySM=;
 b=U1Bjj0O7I/VHnScgEoHxNFLAmsJVXQ8iMV10RTIzAkeAoQR91I7DfTjTt0mxQpSbgQ
 5CREaXgHibh9ZigHLYUy/LO4QJCa/vbXhp5CBsCDOgtV5vKSrm10LDoqsDKNDo1LHdDw
 cnyTPHnZQ2UsUUEHGf5iL+ylEUqmAfM8e3XqJKg/GKDX9gFMvqecyE3oWbeUoefZj/TR
 /yOan4VBSX02uRikjSe0HgPzIw2eyJ4E0RT1KttUv1Hbb6e0hrDAQCZXxW6ohA6Oba5/
 wXEg9E7mhVrpxAwJRYJFnBbwUnX2hR5bljvCI72bxq8Q+auln9KVnZbPYS5Ykv3wMATw
 LqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjJCQhdTXgJ2pFJtLYeurqN5W6QFWtUCD+sYZdvlySM=;
 b=IIgkQbsRO0tua9ZW3aSiFY1w987TiVZoXIK00sjhdK2M3zhUQipc/F2dAaLdw7rVKd
 J48GnoH6EzEQy95dBIi7RNQKoqMpk6p6nAZxRq91QSeRfowNP+BQOf/w09nrTLFO7yVu
 zIMOw+Fh2sP8u4jsIOgo9ot8HlgS0HDJz8BsCHblwQoo5Xu34BikoTdznT6bsJbrRfCd
 goUpSt6QD6JhcG0GfBPtgVFgmEc3hFmt/G0zpkKTwMxCgKlEVS9t60c6Yzv6OLV3nDD/
 QzN3rKnAJWuNc5lcxg9W3EisAYDlx35sZZRvicPHmuONIeZ9ybQwk/8O2sMmWzEG8fg1
 sdhg==
X-Gm-Message-State: ACrzQf2RFYKTpv7jlmhsnjr4kr0jE0rP3Jjo4SsB5zPLYnoutVdXpUZj
 daQwgfYP9a4SGsz9iWDstXoon+NrPyGLfpCp
X-Google-Smtp-Source: AMsMyM5ZOMCDuBdSulZ9ciyFBn6DVVBiL6lOe6lQx53qexL7zaPNpNjDmdmXfGe4jKchjEyP1BCvHQ==
X-Received: by 2002:a05:600c:35c4:b0:3c7:1831:6d8f with SMTP id
 r4-20020a05600c35c400b003c718316d8fmr1269094wmq.48.1666312382032; 
 Thu, 20 Oct 2022 17:33:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a05600c4b0900b003b47b80cec3sm1044180wmp.42.2022.10.20.17.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 17:33:01 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH RESEND] drm/amd/display: move remaining FPU code to dml folder
Date: Fri, 21 Oct 2022 02:31:16 +0200
Message-Id: <20221021003114.25881-1-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <0115eee0-1384-cd9d-22c8-7dfcc9d754e3@gmail.com>
References: <0115eee0-1384-cd9d-22c8-7dfcc9d754e3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Oct 2022 07:30:36 +0000
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
Cc: Ao Zhong <hacc1225@gmail.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move remaining FPU code to dml folder
in preparation for enabling aarch64 support.

Signed-off-by: Ao Zhong <hacc1225@gmail.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 44 +------------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  5 ++-
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 40 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  3 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 ++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  3 ++
 6 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 56d30baf12df..6bfac8088ab0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1295,47 +1295,6 @@ static uint32_t read_pipe_fuses(struct dc_context *ctx)
 	return value;
 }
 
-/*
- * Some architectures don't support soft-float (e.g. aarch64), on those
- * this function has to be called with hardfloat enabled, make sure not
- * to inline it so whatever fp stuff is done stays inside
- */
-static noinline void dcn10_resource_construct_fp(
-	struct dc *dc)
-{
-	if (dc->ctx->dce_version == DCN_VERSION_1_01) {
-		struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
-		struct dcn_ip_params *dcn_ip = dc->dcn_ip;
-		struct display_mode_lib *dml = &dc->dml;
-
-		dml->ip.max_num_dpp = 3;
-		/* TODO how to handle 23.84? */
-		dcn_soc->dram_clock_change_latency = 23;
-		dcn_ip->max_num_dpp = 3;
-	}
-	if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
-		dc->dcn_soc->urgent_latency = 3;
-		dc->debug.disable_dmcu = true;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
-	}
-
-
-	dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / ddr4_dram_width;
-	ASSERT(dc->dcn_soc->number_of_channels < 3);
-	if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
-		dc->dcn_soc->number_of_channels = 2;
-
-	if (dc->dcn_soc->number_of_channels == 1) {
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
-		if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
-			dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
-		}
-	}
-}
-
 static bool verify_clock_values(struct dm_pp_clock_levels_with_voltage *clks)
 {
 	int i;
@@ -1510,8 +1469,9 @@ static bool dcn10_resource_construct(
 	memcpy(dc->dcn_ip, &dcn10_ip_defaults, sizeof(dcn10_ip_defaults));
 	memcpy(dc->dcn_soc, &dcn10_soc_defaults, sizeof(dcn10_soc_defaults));
 
-	/* Other architectures we build for build this with soft-float */
+	DC_FP_START();
 	dcn10_resource_construct_fp(dc);
+	DC_FP_END();
 
 	if (!dc->config.is_vmin_only_asic)
 		if (ASICREV_IS_RAVEN2(dc->ctx->asic_id.hw_internal_rev))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a88dd7b3d1c1..287b7fa9bf41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.src.gpuvm = true;
-		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
-		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
+		DC_FP_START();
+		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
+		DC_FP_END();
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
 		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
index 99644d896222..0495cecaf1df 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
@@ -27,6 +27,8 @@
 #include "dcn10/dcn10_resource.h"
 
 #include "dcn10_fpu.h"
+#include "resource.h"
+#include "amdgpu_dm/dc_fpu.h"
 
 /**
  * DOC: DCN10 FPU manipulation Overview
@@ -121,3 +123,41 @@ struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc = {
 	.writeback_dram_clock_change_latency_us = 23.0,
 	.return_bus_width_bytes = 64,
 };
+
+void dcn10_resource_construct_fp(
+	struct dc *dc)
+{
+	dc_assert_fp_enabled();
+	
+	if (dc->ctx->dce_version == DCN_VERSION_1_01) {
+		struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
+		struct dcn_ip_params *dcn_ip = dc->dcn_ip;
+		struct display_mode_lib *dml = &dc->dml;
+
+		dml->ip.max_num_dpp = 3;
+		/* TODO how to handle 23.84? */
+		dcn_soc->dram_clock_change_latency = 23;
+		dcn_ip->max_num_dpp = 3;
+	}
+	if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
+		dc->dcn_soc->urgent_latency = 3;
+		dc->debug.disable_dmcu = true;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
+	}
+
+
+	dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / ddr4_dram_width;
+	ASSERT(dc->dcn_soc->number_of_channels < 3);
+	if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
+		dc->dcn_soc->number_of_channels = 2;
+
+	if (dc->dcn_soc->number_of_channels == 1) {
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
+		if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
+			dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
index e74ed4b4ce5b..dcbfb73b0afd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
@@ -27,4 +27,7 @@
 #ifndef __DCN10_FPU_H__
 #define __DCN10_FPU_H__
 
+void dcn10_resource_construct_fp(
+	struct dc *dc);
+
 #endif /* __DCN20_FPU_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 819de0f11012..58772fce6437 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 	}
 }
 
+void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
+				  int pipe_cnt)
+{
+	dc_assert_fp_enabled();
+
+	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
+	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 3a3dc2ce4c73..ab010e7e840b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -73,4 +73,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 
 void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
 
+void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
+				  int pipe_cnt);
+
 #endif
-- 
2.37.4


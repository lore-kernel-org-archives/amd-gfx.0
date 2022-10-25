Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CCFC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 07:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D55F10E482;
	Wed, 26 Oct 2022 07:14:53 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68CFA10E042
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 21:20:23 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id a14so20445600wru.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlhtoQ5ksxzE11itSjbh1jhWWzyLP1JiRj5gn1Oz5WE=;
 b=HlkAMUnuAs6feBX8LU/jhNVGt8P5hEATStGpsyYyJH5pzfACUDmdwwdIw5KDgppctE
 SxAcpGJ3/Nk0lt7N7HRdEM44u7DM0FWJIlk+tdSv2b6RR3btKMXMdISYPMilq2Q2atmK
 8goyFan9fIWBdA54wqb2s4ogdI220/8ua0YvjFt6pU4F80w8QSw/2LLm9aVBx2VYcNYK
 nh0qqxucKXHejQHT0ycA9blhtpiSup7Fxr8Jq0cVoW83gCt0ce++z8XLJvEzVpkhTuAZ
 +Sp69usSWRzQdrsYLSvk8RPeziaXERerwXaarghacqJ96b2cJ2GTyHn4QkL/P42rBSWt
 5flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dlhtoQ5ksxzE11itSjbh1jhWWzyLP1JiRj5gn1Oz5WE=;
 b=BK956HYMqBqKHYwk+ssihx1v9svXv5sl1L8kVp59cTzEXWUMOpK6KBcChXuacuPZ2D
 MbWrEP1nEcA+Rxq6cGvKlN+HBi83LeFhtHkuuTjXnR4wzqY5sCRs9neUYk4NPsR1JvZx
 bgH7ubCpILwAXI89Go5OqyB1ecKYE9tiZh+rl1ggQoRcvqKjKLrjIcXXHNnX8yn1nLyr
 KojFi7dkI/Dl5qM1XMPs6ZWNxzwXUBEk9rhMXJNwE81n53BHEffcLiPImOYKqDQPSNsF
 +RR4MmjLQBzYan07JvrJTBePiGZTHOF54gwxCKilJWmGDpW43HWWqDzQHE1YDShplMh1
 fKLQ==
X-Gm-Message-State: ACrzQf2NwMN5Ot8f/lnV3f2AzBQXeGVUu4RAhJR8Y5PYXJhceMqeFykr
 ckBiZBJme5apR5cy2YzZK5I=
X-Google-Smtp-Source: AMsMyM61DG5ea5c1HhOipfPvX5vJsmi7aXlHGUkml2SR3m3QgJLPOLNfrmvJ8pbOqAgs1xm9XqPZ8Q==
X-Received: by 2002:adf:e38a:0:b0:236:60c4:d1d2 with SMTP id
 e10-20020adfe38a000000b0023660c4d1d2mr13141579wrm.653.1666732821213; 
 Tue, 25 Oct 2022 14:20:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c190800b003b47e8a5d22sm88174wmq.23.2022.10.25.14.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Oct 2022 14:20:20 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: move remaining FPU code to dml folder
Date: Tue, 25 Oct 2022 23:17:47 +0200
Message-Id: <20221025211746.16276-1-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <8055465a-4a0e-722b-c436-f39d6818ec73@amd.com>
References: <8055465a-4a0e-722b-c436-f39d6818ec73@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Oct 2022 07:14:45 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Ao Zhong <hacc1225@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the process of enabling DCN support for arm64, I found that the
dcn10_resource_construct_fp function in dcn10/dcn10_resource.c still
needs to use FPU. This will cause compilation to fail on ARM64 platforms
because -mgeneral-regs-only is enabled by default to disable the
hardware FPU. So move dcn10_resource_construct_fp from dcn10 folder to
dml/dcn10 folder to enable hardware FPU for that function.

Signed-off-by: Ao Zhong <hacc1225@gmail.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 44 +------------------
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 38 ++++++++++++++++
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  2 +
 3 files changed, 42 insertions(+), 42 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
index 99644d896222..8b5e6fff5444 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
@@ -27,6 +27,8 @@
 #include "dcn10/dcn10_resource.h"
 
 #include "dcn10_fpu.h"
+#include "resource.h"
+#include "amdgpu_dm/dc_fpu.h"
 
 /**
  * DOC: DCN10 FPU manipulation Overview
@@ -121,3 +123,39 @@ struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc = {
 	.writeback_dram_clock_change_latency_us = 23.0,
 	.return_bus_width_bytes = 64,
 };
+
+void dcn10_resource_construct_fp(struct dc *dc)
+{
+	dc_assert_fp_enabled();
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
index e74ed4b4ce5b..63219ecd8478 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
@@ -27,4 +27,6 @@
 #ifndef __DCN10_FPU_H__
 #define __DCN10_FPU_H__
 
+void dcn10_resource_construct_fp(struct dc *dc);
+
 #endif /* __DCN20_FPU_H__ */
-- 
2.37.4


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F02C38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 14:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A37C10E2D5;
	Wed, 26 Oct 2022 14:20:48 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2373810E4B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 11:05:59 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id bp11so25151436wrb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=867nFffFbpnvQ+dsph9/Ya7aex68THvHDW5CNfkDZBI=;
 b=cssd9rN8mDjjwmTjmyYS6e0/mRNkeg+H9QFAavDdfrJ7ZOKWS0XmnVIJp/ECzmjzOZ
 YHxYyCqtr9Co4mG1yACTNxsaQpJPjYT4YfvGv71e6RgLH2FJMtGdWEnRVVYU9BlOo62O
 lYwkIqEguvar/kQq8RGKKK00Nq/A16DL21st23VU2aFOuSQBNRjF4T37GvAA8joKFgjm
 1KjgbUsCxYpFlhwPdpueYyQGLxxoXG7dv3iJhg+fq7UqFbhjH8GtsmJM24R4GFhvogWP
 3O9Ib61zVknwRD4DK/EhALgFO3ZF8AOHBOgl0PyBcgAxat/wCfOOsrgr/Z+lQAvpTIO7
 jC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=867nFffFbpnvQ+dsph9/Ya7aex68THvHDW5CNfkDZBI=;
 b=rb5XpV+yfWafIOSjMkDxrp96MZLZ8N+bxqINWLhIwP9ocQspwsNQgYTjTlfKLlTc9O
 ypdR+AONAEewMJVBZRmJdPSjWFKzyWjudtbd1YEH1I1rq/wHE03IzQMcy+kcFaxaeNYj
 Nj8QzsQ2OWR3f90PARKooUGjZXfsi3BwMMfc9Ov61/VpqmD4vI8OJQblvXKFfcbdidQr
 2qUz1QrHurKqQ285Dysk2UuXVe0SzvxB4dpDCQkKSdz2nHYAv7wW0WoDB0sdaUR79sTA
 xmI5KDXB5U6H/nhWxAIttbdg67yy1qW+yCJuIJwlMrOTjWqSEWkGTUDHcXzI/P8usSsW
 FYzw==
X-Gm-Message-State: ACrzQf1GAIPYvaxtirelVhac7sTA3upKMJJgALjHxspn8gc3JOd5de5H
 QQjfwBNWKXHqlShZAomTcu0=
X-Google-Smtp-Source: AMsMyM67pidVT6pcLNMx34ronSkebBpN22GyVNgwtqLK70JWQEEvJp2IMUdYaCCzI5QL6NCul6y2ow==
X-Received: by 2002:a5d:5983:0:b0:236:7a7e:e62e with SMTP id
 n3-20020a5d5983000000b002367a7ee62emr7762821wri.38.1666782357457; 
 Wed, 26 Oct 2022 04:05:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 bs14-20020a056000070e00b002366553eca7sm4646921wrb.83.2022.10.26.04.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 04:05:57 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: move remaining FPU code to dml folder
Date: Wed, 26 Oct 2022 13:02:19 +0200
Message-Id: <20221026110218.24599-1-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
References: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Oct 2022 14:20:40 +0000
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
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the process of enabling DCN support for arm64, I found that the
dcn10_resource_construct_fp function in dcn10/dcn10_resource.c still
needs to use FPU. This will cause compilation to fail on ARM64 platforms
because -mgeneral-regs-only is enabled by default to disable the
hardware FPU. So move dcn10_resource_construct_fp from dcn10 folder to
dml/dcn10 folder to enable hardware FPU for that function.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Ao Zhong <hacc1225@gmail.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 44 +------------------
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 37 ++++++++++++++++
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  2 +
 3 files changed, 41 insertions(+), 42 deletions(-)

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
index 99644d896222..340636f1de9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
@@ -27,6 +27,8 @@
 #include "dcn10/dcn10_resource.h"
 
 #include "dcn10_fpu.h"
+#include "resource.h"
+#include "amdgpu_dm/dc_fpu.h"
 
 /**
  * DOC: DCN10 FPU manipulation Overview
@@ -121,3 +123,38 @@ struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc = {
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
+		if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev))
+			dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
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


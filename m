Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73072C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B7D10E60B;
	Fri, 21 Oct 2022 07:32:11 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342CE10E232
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 00:05:47 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id bk15so2073176wrb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI9wnb+rLPnb4SEdDKmsnyaiJWwQv5sPefJtBQZaE1E=;
 b=akwnLT9aOj/VQuVo+4rsVjH+K+uS8+65SFlubUtnPnWobuYyCE4tjkV01s3xZq14rw
 q02TbbtQ9s7pZuLSeSP4wgxZIBEZ4NjcNDcmOaudzOI1r8cFy8E+eTIe2lhdKz0ipe/a
 NAOgFGwJUDquBN8Sz97cs/bCDixCzAGI9raxW3g+XHoOFNQAXpllkyyJT6XCMnXtfRr/
 LrrIXP8+X92A7d9kPQJLmS/qyGIoiGBcbP9jv/cB6/1p/o0WbuKBQmt0QuXV7gDmXVcy
 QNQDlcAjru5Cnlq+8TYb/6FAdr0Gdu8b2FAsyJy5S0Y5lxbwj0GO2wvDzh5mOYvEj1Sa
 mjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZI9wnb+rLPnb4SEdDKmsnyaiJWwQv5sPefJtBQZaE1E=;
 b=rl+KgmE5H4E59P8n4RaR/F46Cpk2PasjrFGGgIMMjoeSe89/yro6vCET0HHNUQ04/L
 GdJiQu6vqPFkMstOEbD7v3sUp8GPp9DKtUrMYKEYkPos7kT3piLsVqqL3o2oG+20HL+o
 4JwZHpJ6n9yzSjuHe0/6dd15F1Cs3GvZG5UGQF7KYtLfu/Dx49jGnun8c2QgpB5dW5qv
 EcZkWTK2ySQPZmNuy4i4Ihq7IoqJFDmwdfwP2u65DbH/mXdrl0cu8jFOKDyIwvs+xrIs
 Yap1ASr6bM/tuFXD2+cmdIbaRGGoH9YsKBvSIaoheEbW+ndNgcla+G+oYdcQC36LO0nr
 PHsA==
X-Gm-Message-State: ACrzQf1twgMc7YT3XD1Hzybh1cnPi01p9Tw5EdJVhHUV7Pcm2LM9AtWv
 4neKHdX51C49xp4RUkJUdcNMt5k9tASNTw==
X-Google-Smtp-Source: AMsMyM4b9Vouzpq3wgNeP2l8v99S0PmLuLhqFZZE2YJj3qmWoJujd/NIPU/m8WrjEtf/gduFw2OPDg==
X-Received: by 2002:a05:6000:607:b0:235:d82c:ccea with SMTP id
 bn7-20020a056000060700b00235d82ccceamr3796400wrb.135.1666310745445; 
 Thu, 20 Oct 2022 17:05:45 -0700 (PDT)
Received: from ?IPV6:2a02:908:4f6:d280::9a6? ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a05600c4e1500b003a83ca67f73sm980400wmq.3.2022.10.20.17.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Oct 2022 17:05:45 -0700 (PDT)
Message-ID: <0115eee0-1384-cd9d-22c8-7dfcc9d754e3@gmail.com>
Date: Fri, 21 Oct 2022 02:05:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com
From: Ao Zhong <hacc1225@gmail.com>
Subject: [PATCH] drm/amd/display: move remaining FPU code to dml folder
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Subject: [PATCH] drm/amd/display: move remaining FPU code to dml folder

Move remaining FPU code to dml folder
in preparation for enabling aarch64 support.

Signed-off-by: Ao Zhong <hacc1225@gmail.com>
---
  .../drm/amd/display/dc/dcn10/dcn10_resource.c | 44 +------------------
  .../drm/amd/display/dc/dcn32/dcn32_resource.c |  5 ++-
  .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 40 +++++++++++++++++
  .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  3 ++
  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 ++++
  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  3 ++
  6 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c 
b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 56d30baf12df..6bfac8088ab0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1295,47 +1295,6 @@ static uint32_t read_pipe_fuses(struct dc_context 
*ctx)
      return value;
  }

-/*
- * Some architectures don't support soft-float (e.g. aarch64), on those
- * this function has to be called with hardfloat enabled, make sure not
- * to inline it so whatever fp stuff is done stays inside
- */
-static noinline void dcn10_resource_construct_fp(
-    struct dc *dc)
-{
-    if (dc->ctx->dce_version == DCN_VERSION_1_01) {
-        struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
-        struct dcn_ip_params *dcn_ip = dc->dcn_ip;
-        struct display_mode_lib *dml = &dc->dml;
-
-        dml->ip.max_num_dpp = 3;
-        /* TODO how to handle 23.84? */
-        dcn_soc->dram_clock_change_latency = 23;
-        dcn_ip->max_num_dpp = 3;
-    }
-    if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
-        dc->dcn_soc->urgent_latency = 3;
-        dc->debug.disable_dmcu = true;
-        dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
-    }
-
-
-    dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / 
ddr4_dram_width;
-    ASSERT(dc->dcn_soc->number_of_channels < 3);
-    if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
-        dc->dcn_soc->number_of_channels = 2;
-
-    if (dc->dcn_soc->number_of_channels == 1) {
-        dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
-        dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
-        dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
-        dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
-        if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
-            dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
-        }
-    }
-}
-
  static bool verify_clock_values(struct dm_pp_clock_levels_with_voltage 
*clks)
  {
      int i;
@@ -1510,8 +1469,9 @@ static bool dcn10_resource_construct(
      memcpy(dc->dcn_ip, &dcn10_ip_defaults, sizeof(dcn10_ip_defaults));
      memcpy(dc->dcn_soc, &dcn10_soc_defaults, sizeof(dcn10_soc_defaults));

-    /* Other architectures we build for build this with soft-float */
+    DC_FP_START();
      dcn10_resource_construct_fp(dc);
+    DC_FP_END();

      if (!dc->config.is_vmin_only_asic)
          if (ASICREV_IS_RAVEN2(dc->ctx->asic_id.hw_internal_rev))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c 
b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a88dd7b3d1c1..287b7fa9bf41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
          timing = &pipe->stream->timing;

          pipes[pipe_cnt].pipe.src.gpuvm = true;
-        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
-        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
+        DC_FP_START();
+        dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
+        DC_FP_END();
          pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
          pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // 
according to spreadsheet
          pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c 
b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
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
+    struct dc *dc)
+{
+    dc_assert_fp_enabled();
+
+    if (dc->ctx->dce_version == DCN_VERSION_1_01) {
+        struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
+        struct dcn_ip_params *dcn_ip = dc->dcn_ip;
+        struct display_mode_lib *dml = &dc->dml;
+
+        dml->ip.max_num_dpp = 3;
+        /* TODO how to handle 23.84? */
+        dcn_soc->dram_clock_change_latency = 23;
+        dcn_ip->max_num_dpp = 3;
+    }
+    if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
+        dc->dcn_soc->urgent_latency = 3;
+        dc->debug.disable_dmcu = true;
+        dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
+    }
+
+
+    dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / 
ddr4_dram_width;
+    ASSERT(dc->dcn_soc->number_of_channels < 3);
+    if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
+        dc->dcn_soc->number_of_channels = 2;
+
+    if (dc->dcn_soc->number_of_channels == 1) {
+        dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
+        dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
+        dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
+        dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
+        if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
+            dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
+        }
+    }
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h 
b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
index e74ed4b4ce5b..dcbfb73b0afd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
@@ -27,4 +27,7 @@
  #ifndef __DCN10_FPU_H__
  #define __DCN10_FPU_H__

+void dcn10_resource_construct_fp(
+    struct dc *dc);
+
  #endif /* __DCN20_FPU_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c 
b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 819de0f11012..58772fce6437 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc 
*dc, struct clk_bw_params *bw_pa
      }
  }

+void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
+                  int pipe_cnt)
+{
+    dc_assert_fp_enabled();
+
+    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
+    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h 
b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 3a3dc2ce4c73..ab010e7e840b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -73,4 +73,7 @@ int 
dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,

  void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);

+void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
+                  int pipe_cnt);
+
  #endif
-- 
2.37.4


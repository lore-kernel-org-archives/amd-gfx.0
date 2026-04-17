Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D9F8E497
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 00:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC13A10E0A7;
	Fri, 17 Apr 2026 00:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/2ICTXH";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7B210E24F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 00:15:14 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a402dea4a5so99786e87.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776384913; x=1776989713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYFo5pjfQWejx/RnAQZuantyr8hBTxOsgdc4wrhteOo=;
 b=c/2ICTXHqkWQldo1KVQ52X+4VVBEpjiUTWg0MUSWKvRj1andoFbwblrxoSUZbkcVxs
 guScbIv0GCl8HfJX26AzWE22yRmWiXu2Zx0INgzmnQB7fJJw8kSXB9s762m1qQ8424Ui
 dzOeaJy2SUdeFskLQrO+XTQVW8hxY0HMNv1BnIDQbAmURZp/61sFY2adtwHSlNeaHBkV
 sykqU37QiQxcaCDUYGOMv0Ef6tdUbP9R/eZ5E71moXkinQtGgQD3qG8yM4NrWCIAIEfN
 lRb4fFSVa9xRjHSGTSc4QxJtkrH9CjlkK6xVDRFb4CsHXk8vekFTeCxlYk++RaCWDfUp
 1Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776384913; x=1776989713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYFo5pjfQWejx/RnAQZuantyr8hBTxOsgdc4wrhteOo=;
 b=EaF9sPKj2CeOIrykgd598M/8tQdjvOIVv57JjGsoVmUedKnlV6lLpcFIxGwNlNrjq2
 brqeDp3ro7gOhySbA0DHnng+zx57m8yjy7pzEFvJEEmVysBbKk6r43puCZ/VY3qorESq
 neRIPuZDCWe6SxONpKSnH+TPivH2CD90ImqK8hO+VaCTJfj7U+eMhGUEuGhnXdBnPUEM
 u+SEYpqBoSJqkcF+4Q44ylykGvMhx9QJP3B1B53yoHH1LNcLVBMWn8qz/HI+Scc6gFRp
 Ul/esUCBn0K8jBzwFY4KK9vrVb3afBCExRGwrlwu6Cf8Czr+2pzDTgv1Ky36m5cLHU64
 ETqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JxedQQYylgc5Tw8S9aAa9nphk5iqF/TwsLOc2gqmcqmt4u4/UHn7dtNtyYk24r5xcsGl1v3xk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQri2ERmTZEFFq6mrmb/gmyXfvaC97HCRHZgl82EMZs7YyAsJJ
 VYCqJLbukpSW2Y5HrHyaCUtAfG8YbkX/zUUlXPIji+WlTQaKZ87NVGlx
X-Gm-Gg: AeBDievHNEYhKOApk2702+KFWcSiy50ht3uo6mGmV5XsxjqHmqvaYYIkNjT2qXSxCwa
 bkKCjDil4Hr0BO/Wza6BcNJXYaIXMmwzVdll0ZLKs8zMJkMKBMWc7+6WT8dt5B+XVcOHn/TS0rM
 id+5UHQYnpkKTr1ZTxAQvC4Cu3uMLJI8f7sdB4KmnX7YSavu3GaTHXcY0uCH4VST4jE35BM2J0S
 kR+5bHddGUHwXr6hWMebhxlK+1arnSgtdjgMJxfdhi74378WzgVp7r3EeW8f0mLBxec9xmcQq7w
 cGXzEqEPJdW0jSCPu13BBjtQ+Ip8oGx/9BihQAUD8eoxOgPNGhRL0F0K8aw4qvomLDiNK34arBc
 eeNaN5Zyu9fq5ddfKtyVA63bbgYXnmZE1nP7HIiw74ovUlLaFcQdvK5V7FXVpbqWGBp2tboptan
 z5crZJYFoQx/pUdXIqnz2kjKCfCKloa21N/V8LmQvvNK5i
X-Received: by 2002:a05:6512:b86:b0:5a4:11e:5c70 with SMTP id
 2adb3069b0e04-5a4172d0312mr116683e87.14.1776384912616; 
 Thu, 16 Apr 2026 17:15:12 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4178dc9a2sm66200e87.56.2026.04.16.17.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 17:15:10 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: Add FPU guards around dcn31/315/316
 update_bw_bounding_box
Date: Fri, 17 Apr 2026 05:15:03 +0500
Message-ID: <20260417001503.26147-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC -
Part 1") moved DC_FP_START/DC_FP_END out of the DML FPU units into the
DC resource layer for dcn35, dcn351, dcn36, dcn401 and dcn42, but missed
the dcn31 family: the dcn31, dcn315 and dcn316 resource pools still wire
their .update_bw_bounding_box callback directly to the FPU-unit
functions dcn31_update_bw_bounding_box(), dcn315_update_bw_bounding_box()
and dcn316_update_bw_bounding_box() defined in dml/dcn31/dcn31_fpu.c.
Those functions call dc_assert_fp_enabled() on entry, which now fires
on every amdgpu probe on affected parts because no caller wraps them in
DC_FP_START/DC_FP_END anymore.

Triggered on amdgpu probe on a Ryzen 7000 (Raphael) iGPU, which uses
dcn315:

 WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58
          at dc_assert_fp_enabled+0x14/0x20 [amdgpu]
 RIP: 0010:dc_assert_fp_enabled+0x14/0x20 [amdgpu]
 Call Trace:
  dcn315_update_bw_bounding_box+0x1c/0x17a0 [amdgpu]
  dc_create_resource_pool+0x4a0/0x770 [amdgpu]
  dc_construct+0xa0a/0x13b0 [amdgpu]
  dc_create+0x6f/0x8b0 [amdgpu]
  amdgpu_dm_init+0x740/0xc80 [amdgpu]
  dm_hw_init+0x45/0x150 [amdgpu]
  amdgpu_device_ip_init+0xe21/0x11e1 [amdgpu]
  amdgpu_device_init.cold+0xc03/0x1819 [amdgpu]
  amdgpu_driver_load_kms+0x19/0xa0 [amdgpu]
  amdgpu_pci_probe+0x371/0xbc0 [amdgpu]

Apply the same pattern the offending commit used for dcn35 (and that
dcn314 already followed before the commit): rename the FPU-unit entry
points with an _fpu suffix and add non-FPU static wrappers in the
resource files which provide DC_FP_START/DC_FP_END around the call.

Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

Tested on Ryzen 7000 (Raphael) with RX 7900 XTX discrete GPU, debug
kernel (KASAN + LOCKDEP + PREEMPT_FULL). Without the patch, the WARN
fires on every boot during amdgpu probe for the iGPU (dcn315). With
the patch applied, amdgpu probes cleanly and no dc_assert_fp_enabled
warnings occur.

 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c       | 6 +++---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h       | 6 +++---
 .../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 7 +++++++
 .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c   | 7 +++++++
 .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c   | 7 +++++++
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 1a28061bb9ff..ad23215da9f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -587,7 +587,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - total_det;
 }
 
-void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct _vcs_dpi_voltage_scaling_st *s = dc->scratch.update_bw_bounding_box.clock_limits;
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
@@ -665,7 +665,7 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31);
 }
 
-void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	int i, max_dispclk_mhz = 0, max_dppclk_mhz = 0;
@@ -726,7 +726,7 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN315);
 }
 
-void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct _vcs_dpi_voltage_scaling_st *s = dc->scratch.update_bw_bounding_box.clock_limits;
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index dfcc5d50071e..0b7fcbbfd17b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -44,9 +44,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel);
 
-void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
-void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
-void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
 int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st *soc);
 int dcn_get_approx_det_segs_required_for_pstate(
 		struct _vcs_dpi_soc_bounding_box_st *soc,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ee4bc2c2e73a..d5215a028626 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1854,6 +1854,13 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
+static void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn31_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
 static struct resource_funcs dcn31_res_pool_funcs = {
 	.destroy = dcn31_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 2ca673114841..c48ac609ce7c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1849,6 +1849,13 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
+static void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn315_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
 static struct resource_funcs dcn315_res_pool_funcs = {
 	.destroy = dcn315_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 2242df112a3f..914d91df174c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1725,6 +1725,13 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
+static void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn316_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
 static struct resource_funcs dcn316_res_pool_funcs = {
 	.destroy = dcn316_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
-- 
2.53.0


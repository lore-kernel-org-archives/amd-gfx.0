Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B68610ED679
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D395A10EE3A;
	Fri, 27 Mar 2026 12:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dxrzDWT0";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D81010EB2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:44 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-82a7539851fso739382b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568864; x=1775173664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYskpQzDXhxM4+9VM9RgZDo2+o/dM3+zNnNFKoGgds4=;
 b=dxrzDWT0QTbJtWTYJVpNAwRD4kJW5Vqyb7j6xGC0cgwZ0bxUsDrLt0+jWgCET45iPy
 qkJ0YPnRDPPcygNQ7N8/Y812dVEqbpav4qAg5Slu1iKswfBahKm7eWrYhhRG+KEx3BaB
 UoYgSao4f/dyKZxEeVWIrtwihiIFpsQhZeNkd4Wskal4GBjdqerg2g8ur5KdAiqBclw0
 VXr8wQBDcr9nhdWs7tLLR1ypqH48V6QKLWL5Dfhb+WzzjhS0dUwpFGewNvj22gQxN3zU
 mAWdmvBSjr/G/EXI8+FUSUtqGFJGXVXTVTha+i4WToW2ffk4ntInImw3mAPECLTfA0sT
 IPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568864; x=1775173664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fYskpQzDXhxM4+9VM9RgZDo2+o/dM3+zNnNFKoGgds4=;
 b=eYJOtd8Jt/1PaFic3uOrgTMd7pgoFiCW38nOm1uQCDfppj1vwPISkmYFKceu8zmZE4
 Z7iTLcsRKOQl3yjtJ9sWrCgeRn9Qn3Wt1HNDxieadQ1nyiH9IRQTiLwK2J8F5i2kXUm4
 o7nEk2Kn67gLRF2hIGVsMNhAtu/6DJ/Z8iroe7J5m9c+izuwRdBF/oXPjIXbDvCnZ13J
 K9C4zjfS6pYLiQhkmpR9Uy/LatM1VBSjh/bdgZ7REUckMNPkJsi+63p7DYP67uxO+Pjz
 77JfBbtAyec4uza6hBvWjjEpvLQfBI3GujY8OSvGTQuYgIM7DEMJxVu6AU8Zf+WaO+Uw
 bGpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUewdR+CCp7QsSzV6TEMeo1XQjvIlhZsWL9ny8IvCLIjeDIGO9Dk5puS8byEzU9ieu3GrDix3LZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoU8CKtnZKUDLKutgo0dBE1WAWVpYeN7C01otomO2nUls+d6zm
 S+fdD3nKv615rgAIG3KPYlJQh/t2lnS6KvDbOf6zdC9kEddSgtODfNfI
X-Gm-Gg: ATEYQzz/BqtZX//ejYP2L6eCylKIT0HPHKhUcTUbSFCEcLn/TJCe5vUyPqKzyhSW+3p
 HFhphEbBNXOwwkXWq2D8msrePKvBPvzv0lOlkaDKvX2DM60yGGdUDBUi7sBPGF0YE8+5FCcYiW/
 D0ynLIb3VP8fm6SwiXGz2+a0Z733/J8p96fEM1ZvhZF8vjW6j6pV6OjNGYgnpG9ZJYBWiiAyEYS
 u/VZGMY35mfUmAeUwWUsdTH18X3SOLtNxVvwpKftRCPJIR+NrRFeOYzRILgDIbGtpWxy9SIs/pH
 lYQj+Fxe/dcKgKg+RDdFr+96Gu9IuXs6pZnvRppvzb/Kbx0WXQW9mrj3j8TJjJai/Nj5Rez/oUJ
 k0/SeOvEtgYjy1WlfVpmoh5orXRD8iPl+26BQntIKmnxsFSxcColad1HwDUvbmGAXV0VcV6NCGu
 E8VLzzX7VoWjLh1pnP+aydb38Ml5EmjKZiTh3qfof37fBzde4Mp6aIY/s=
X-Received: by 2002:a05:6a20:3d1d:b0:39b:d9f1:6d05 with SMTP id
 adf61e73a8af0-39c87b30111mr483902637.53.1774568864031; 
 Thu, 26 Mar 2026 16:47:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 4/9] drm/amd/display: Reject modes with too high
 pixel clock on DCE6-10
Date: Thu, 26 Mar 2026 16:47:11 -0700
Message-ID: <20260326234716.16723-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 118800b0797a046adaa2a8e9dee9b971b78802a7 ]

Reject modes with a pixel clock higher than the maximum display
clock. Use 400 MHz as a fallback value when the maximum display
clock is not known. Pixel clocks that are higher than the display
clock just won't work and are not supported.

With the addition of the YUV422	fallback, DC can now accidentally
select a mode requiring higher pixel clock than actually supported
when the DP version supports the required bandwidth but the clock
is otherwise too high for the display engine. DCE 6-10 don't
support these modes but they don't have a bandwidth calculation
to reject them properly.

Fixes: db291ed1732e ("drm/amd/display: Add fallback path for YCBCR422")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  3 +++
 .../drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  5 +++++
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c  | 10 +++++++++-
 .../amd/display/dc/resource/dce100/dce100_resource.c   | 10 +++++++++-
 .../drm/amd/display/dc/resource/dce80/dce80_resource.c | 10 +++++++++-
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index b268c367c27c..a2e100aa3cba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -460,6 +460,9 @@ void dce_clk_mgr_construct(
 		clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
 	clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
 
+	base->clks.max_supported_dispclk_khz =
+		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+
 	dce_clock_read_integrated_info(clk_mgr);
 	dce_clock_read_ss_info(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index a39641a0ff09..69dd80d9f738 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -147,6 +147,8 @@ void dce60_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_internal *clk_mgr)
 {
+	struct clk_mgr *base = &clk_mgr->base;
+
 	dce_clk_mgr_construct(ctx, clk_mgr);
 
 	memcpy(clk_mgr->max_clks_by_state,
@@ -157,5 +159,8 @@ void dce60_clk_mgr_construct(
 	clk_mgr->clk_mgr_shift = &disp_clk_shift;
 	clk_mgr->clk_mgr_mask = &disp_clk_mask;
 	clk_mgr->base.funcs = &dce60_funcs;
+
+	base->clks.max_supported_dispclk_khz =
+		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 8db9f7514466..7886a2a55caf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -34,6 +34,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce60/irq_service_dce60.h"
 #include "dce110/dce110_timing_generator.h"
@@ -870,10 +871,17 @@ static bool dce60_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 53a5f4cb648c..6717ed84a032 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -29,6 +29,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
@@ -843,10 +844,17 @@ static bool dce100_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index a73d3c6ef425..af4a45718c7c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -32,6 +32,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce80/irq_service_dce80.h"
 #include "dce110/dce110_timing_generator.h"
@@ -876,10 +877,17 @@ static bool dce80_validate_bandwidth(
 {
 	int i;
 	bool at_least_one_pipe = false;
+	struct dc_stream_state *stream = NULL;
+	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
+		stream = context->res_ctx.pipe_ctx[i].stream;
+		if (stream) {
 			at_least_one_pipe = true;
+
+			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
+				return DC_FAIL_BANDWIDTH_VALIDATE;
+		}
 	}
 
 	if (at_least_one_pipe) {
-- 
2.53.0


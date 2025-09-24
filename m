Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED0ACAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 11:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750A310E70A;
	Wed, 24 Sep 2025 11:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRR3gDwJ";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3811810E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 11:38:52 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b55562f3130so2039739a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758713932; x=1759318732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7Hyt5Fk3hnR4u/x4K5q9ptwiTnge30Q1SfAMU5ynic=;
 b=XRR3gDwJb3INZYZ/DIZKZKxCLzDsbtj2xj5EzFkoXZY05eKDii8LgkGn2ee+ORskv1
 CfpQ6biQuHtYLMHD/OC299SfEclNtzni4iYgWOGtxB0jkxJQTbFkP3BrA872MutjReYj
 +rIv+/auO9YnoPmTY3S4rtvXfQXVlQVflyMlosYcqev/MlIoc5I97YI6XU7vspj4fpZ1
 2m9qRCYXH5C6DDgGsPb02d6kXxf7MBs+6pEUoh7yIhNB5h+mxOOr24gQEvX7cS1RhVVM
 EQFyQmFvr1r8PBnHsUsgNMppW467emzwzseV6X3VkFe0mFKr1V5H8NsHXz3FEFN219YM
 1p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713932; x=1759318732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7Hyt5Fk3hnR4u/x4K5q9ptwiTnge30Q1SfAMU5ynic=;
 b=CPXhGTskjpwgocnC1BPCM7CYu+SSoD56TPJybkW5FFEfrVGFn2b9eTyWLLRaGTAlMe
 9+o4uMIarvujE3BslPX2RQGRIDpWxOZndrcipMLtwzT2DLnGbJJlqLVu5BgGaxuM0iz0
 +k7sNJgReAQJSOS/xokulqvbfCTB/RzRVVxPmnv2hnFtNkNuZJRdmbFUXN2gpLIj0Xke
 mPA3b+ZMvRKg5XCbe8vzyxeYt5083qfQ4TQ0zicFZi5nuJ3myM0UKyvMj7JRcDecdf3E
 M6fYt4wAS7Ejn1JKK5Ix+gN5qH10HB/agshDMisPJdhMovgxM/+YyMKJ7WfW65ogZioq
 PI2g==
X-Gm-Message-State: AOJu0YzBbMvFT9YOfZt6itw6yoVNmOGPcQoJltPUSkhHxV7/X0NsBuXQ
 iibiXWXzrHRbHbfHwlKaxS59Da9e8HKR/eNUNubU+kevTIiJKnQyWcsLy6MqnHKJ
X-Gm-Gg: ASbGncsEPj7z2zymUUUPNwWDeF51LpUwQgf93IpFGFS1gv7fnZGpGYEYi6OxkbN1M4x
 RZrNwWyeLJBPdijphrfKGTgt2S1QV52opXULSMv/itdvRdbcFHttN524pPqs99S5cT4ZypxrB1a
 hBPBXIdSkLxKetICNJXj68//IfqLHVgmsT47MCDMSzHHNX9KaqREk8UqzInfS2iNw70ZMZYrsx4
 /P+snRczucmvuNTBWME7Fm2B97cb9uqQX+nhWb5tJtgAIFHpCCK5d5/VSJWxWHpX2CZ7OTvueJZ
 Az60aUhVrn3SuTtlTdk/Rh5z1105uIbXW55gX4OD5UkpUUeY1cYrae8b/fkmLb1z34wQIFZhnlH
 RupIQcSK2ZhGwdL3BwKT9vfn7vAK4lTdUglwwZ+JGojzx8S9xsUaPm0y/5kC6UHcvF7Vf3Blh2p
 zl9KBfQmcpUmCA4Wtl5TJwqpDlTQ==
X-Google-Smtp-Source: AGHT+IGT6l6LDN6mCZ56hNHoZepbNlCstYpvSZybgAXRy/8ouKCD9HbjbPGJM0KXU+fWpbVg/0h1hg==
X-Received: by 2002:a17:903:22c1:b0:275:2aac:fef8 with SMTP id
 d9443c01a7336-27cc499752cmr67006335ad.38.1758713931715; 
 Wed, 24 Sep 2025 04:38:51 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be38382sm2142548a91.25.2025.09.24.04.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:38:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amd/display: Reject modes with too high pixel clock
 on DCE6-10
Date: Wed, 24 Sep 2025 13:38:34 +0200
Message-ID: <20250924113836.57013-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924113836.57013-1-timur.kristof@gmail.com>
References: <20250924113836.57013-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fixes: 5d53fdc0971f ("drm/amd/display: Add fallback path for YCBCR422")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  3 +++
 .../drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  5 +++++
 .../amd/display/dc/resource/dce100/dce100_resource.c   | 10 +++++++++-
 .../drm/amd/display/dc/resource/dce60/dce60_resource.c | 10 +++++++++-
 .../drm/amd/display/dc/resource/dce80/dce80_resource.c | 10 +++++++++-
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index dbd6ef1b60a0..6131ede2db7a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -463,6 +463,9 @@ void dce_clk_mgr_construct(
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
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 3a51be63f020..f36ec4edf0ae 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -29,6 +29,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
@@ -843,10 +844,17 @@ static enum dc_status dce100_validate_bandwidth(
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
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index c164d2500c2a..b5433349fc7a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -34,6 +34,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce60/irq_service_dce60.h"
 #include "dce110/dce110_timing_generator.h"
@@ -870,10 +871,17 @@ static enum dc_status dce60_validate_bandwidth(
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
index 3e8b0ac11d90..538eafea82d5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -32,6 +32,7 @@
 #include "stream_encoder.h"
 
 #include "resource.h"
+#include "clk_mgr.h"
 #include "include/irq_service_interface.h"
 #include "irq/dce80/irq_service_dce80.h"
 #include "dce110/dce110_timing_generator.h"
@@ -876,10 +877,17 @@ static enum dc_status dce80_validate_bandwidth(
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
2.51.0


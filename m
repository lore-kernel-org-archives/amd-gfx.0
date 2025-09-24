Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39F1CAC5B3
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 11:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8333D10E70F;
	Wed, 24 Sep 2025 11:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCSA0WXD";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB50810E70E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 11:38:57 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so745028a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758713937; x=1759318737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LaC9n8y3GfjUxcsvyAFOjya+jVZJRkVbyyw3bhCQwN4=;
 b=CCSA0WXDbXIPHy9CIX/mXwo8fhYAUN6mqdOoVJrk5tQPUhBX9AqQn14FdnWd4Xcncr
 CzDuMon9GeKPqhk3FVHY3G8VZCqFXRy2rYpEKSkvn6tGRQ2J+34/v6Am0xkspBnrrH+k
 8sMZaPMIDm+CSxxQWjIkj6vswmxrsUMG7pXv2q8XvGKaJKsDkY4mfMYfj76DgnAuwErK
 wFiZWYZS8dew5vG25cL2Ol8YAUYzpwG8HVoKhGdecomOmcMEbg/phQhA+EkiP3yQZV87
 +BI7uZ7EcyalID9DseyrhdJ+lHlGDRyNNWW2Sq8/WTUNoQlreDUdNawVxL2MHJbRy/v/
 gRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713937; x=1759318737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LaC9n8y3GfjUxcsvyAFOjya+jVZJRkVbyyw3bhCQwN4=;
 b=R/Qa7ay2AZzriPZFYbm5aN91W95TFUPPsKM4Q9t3XBONNWBc3ssCoJc5PBrjbvbiRO
 HzgCIn70dnybnFD5+U53BCOQVb0F1xQhhUziefrvEnfpPfTQgZx88UwzLBLDg2eBVg4R
 W7Tp4zPyJ73oDysGcnUWGDNtCUnM2yykA1D0+QUTf16uMl/eW+0aA00BYMose0Pu92fT
 GVEETTOd7G+r4e9YLNuAmnWOpIQgZcggio6gqscOkxqyCZZIQ3qhLraTfGS+HB1OFu5k
 tiwdEz3TggM7qTG+tat11wXuIdEfSG80jRIuBtn7FrS/wb0q6vQeBUMpBNFO0FZZD9Ix
 Jjdg==
X-Gm-Message-State: AOJu0YyTpCkfXJ+EOwE3Zm6DXmi7IzHMj1dlFeXzz96bm89wKkQY4v1Q
 tyhFRsh/5rt0fiFZOCFuikkee/gmlc0XzYnqPfl43x0T1fzn0yZOmIEd/2QkOYKz
X-Gm-Gg: ASbGncuk/VaU5kAX/yCN8kqIEUfG8ESq3X4A4P6njgUB1jgkdmNn9xVmMn/t/jqM2JX
 gIbPh06E4WgS7SUAfJ+O8P/eI47txa1DMsrLEtP95lZ8XWk7cYzmfuOe3Q+kuyJJjft26P1J+35
 UFZGEEk3U1VXd5ApHIpHADZDtgPsiMIdtwef8gsNUp7MW1H8SZmjtgCVdwqQwtrl9VmR/1F2T3a
 oYAFK5FuR1pOay1/ssvWD02NSTnQnH9HUjJH811RNwDg3KhxCDRftprhYJgBd4mwNoa4ZltZbWj
 V7C/a9MqL8rQMcH/B7TsNROjWDao9TrOO5qtJ2hE043GW0SdDgNb5mUhTUas3dsPuIbUZ2NzE9T
 56Wk2BJR30mcjeDE17XjijojZF3tCaZ3psp0FoFG55pmYje1LKq438mSP9ZZaAs6Kst0UK6/ThE
 VTCd4Mz0wq/29VslX29FUOVm7w6g==
X-Google-Smtp-Source: AGHT+IHuKClQdmhFcgpQ2O7pVFZ5uQzUVj4PL3PwgUi5OyS2Kvol1MegSDLgKig8a4xFGQeuHlKCkQ==
X-Received: by 2002:a17:902:f786:b0:271:6af4:17c with SMTP id
 d9443c01a7336-27ec10423admr25207365ad.1.1758713937115; 
 Wed, 24 Sep 2025 04:38:57 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be38382sm2142548a91.25.2025.09.24.04.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:38:56 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amd/display: Share dce100_validate_bandwidth with
 DCE6-8
Date: Wed, 24 Sep 2025 13:38:35 +0200
Message-ID: <20250924113836.57013-3-timur.kristof@gmail.com>
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

DCE6-8 have very similar capabilities to DCE10, they support the
same DP and HDMI versions and work similarly.

Share dce100_validate_bandwidth between DCE6-10 to reduce code
duplication in the DC driver.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../dc/resource/dce100/dce100_resource.c      | 13 +++++-
 .../dc/resource/dce100/dce100_resource.h      |  5 +++
 .../dc/resource/dce60/dce60_resource.c        | 43 +------------------
 .../dc/resource/dce80/dce80_resource.c        | 34 +--------------
 4 files changed, 18 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index f36ec4edf0ae..6421a56ffd23 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -837,7 +837,7 @@ static enum dc_status build_mapped_resource(
 	return DC_OK;
 }
 
-static enum dc_status dce100_validate_bandwidth(
+enum dc_status dce100_validate_bandwidth(
 	struct dc  *dc,
 	struct dc_state *context,
 	enum dc_validate_mode validate_mode)
@@ -862,7 +862,16 @@ static enum dc_status dce100_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
index fecab7c560f5..08e045601a77 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.h
@@ -41,6 +41,11 @@ struct resource_pool *dce100_create_resource_pool(
 
 enum dc_status dce100_validate_plane(const struct dc_plane_state *plane_state, struct dc_caps *caps);
 
+enum dc_status dce100_validate_bandwidth(
+		struct dc  *dc,
+		struct dc_state *context,
+		enum dc_validate_mode validate_mode);
+
 enum dc_status dce100_add_stream_to_ctx(
 		struct dc *dc,
 		struct dc_state *new_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index b5433349fc7a..61ad3703461e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -864,47 +864,6 @@ static void dce60_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-static enum dc_status dce60_validate_bandwidth(
-	struct dc *dc,
-	struct dc_state *context,
-	enum dc_validate_mode validate_mode)
-{
-	int i;
-	bool at_least_one_pipe = false;
-	struct dc_stream_state *stream = NULL;
-	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		stream = context->res_ctx.pipe_ctx[i].stream;
-		if (stream) {
-			at_least_one_pipe = true;
-
-			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
-				return DC_FAIL_BANDWIDTH_VALIDATE;
-		}
-	}
-
-	if (at_least_one_pipe) {
-		/* TODO implement when needed but for now hardcode max value*/
-		context->bw_ctx.bw.dce.dispclk_khz = 681000;
-		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
-	} else {
-		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
-		 * the DP clock, and shouldn't be turned off. Just select the display
-		 * clock value from its low power mode.
-		 */
-		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
-			dc->ctx->dce_version == DCE_VERSION_6_4)
-			context->bw_ctx.bw.dce.dispclk_khz = 352000;
-		else
-			context->bw_ctx.bw.dce.dispclk_khz = 0;
-
-		context->bw_ctx.bw.dce.yclk_khz = 0;
-	}
-
-	return DC_OK;
-}
-
 static bool dce60_validate_surface_sets(
 		struct dc_state *context)
 {
@@ -948,7 +907,7 @@ static const struct resource_funcs dce60_res_pool_funcs = {
 	.destroy = dce60_destroy_resource_pool,
 	.link_enc_create = dce60_link_encoder_create,
 	.panel_cntl_create = dce60_panel_cntl_create,
-	.validate_bandwidth = dce60_validate_bandwidth,
+	.validate_bandwidth = dce100_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce100_add_stream_to_ctx,
 	.validate_global = dce60_validate_global,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 538eafea82d5..0c9a39bf7ff4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -870,38 +870,6 @@ static void dce80_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-static enum dc_status dce80_validate_bandwidth(
-	struct dc *dc,
-	struct dc_state *context,
-	enum dc_validate_mode validate_mode)
-{
-	int i;
-	bool at_least_one_pipe = false;
-	struct dc_stream_state *stream = NULL;
-	const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		stream = context->res_ctx.pipe_ctx[i].stream;
-		if (stream) {
-			at_least_one_pipe = true;
-
-			if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
-				return DC_FAIL_BANDWIDTH_VALIDATE;
-		}
-	}
-
-	if (at_least_one_pipe) {
-		/* TODO implement when needed but for now hardcode max value*/
-		context->bw_ctx.bw.dce.dispclk_khz = 681000;
-		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
-	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
-		context->bw_ctx.bw.dce.yclk_khz = 0;
-	}
-
-	return DC_OK;
-}
-
 static bool dce80_validate_surface_sets(
 		struct dc_state *context)
 {
@@ -945,7 +913,7 @@ static const struct resource_funcs dce80_res_pool_funcs = {
 	.destroy = dce80_destroy_resource_pool,
 	.link_enc_create = dce80_link_encoder_create,
 	.panel_cntl_create = dce80_panel_cntl_create,
-	.validate_bandwidth = dce80_validate_bandwidth,
+	.validate_bandwidth = dce100_validate_bandwidth,
 	.validate_plane = dce100_validate_plane,
 	.add_stream_to_ctx = dce100_add_stream_to_ctx,
 	.validate_global = dce80_validate_global,
-- 
2.51.0


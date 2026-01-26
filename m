Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B914D1951A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BEA10E4AF;
	Mon, 26 Jan 2026 21:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EASQbyxR";
	dkim-atps=neutral
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8EA10E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:50 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4253432f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461729; x=1770066529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hevqQtoPuwGKoLwEph8m2SKFnpaXkidbgymfG5NiKk=;
 b=EASQbyxRYNfEyDP1xyNuc9H4tCBCStGQw1+tHU6UIr2R+7uWWY9SneHM8PT82+89kp
 UC/pvDkOdW3KV4Qa+kV007KW0Hz9Ln+Hler62gojAKZ4UpKKVScWkMoXboeUcbX3ZWHN
 WZtxT9P8ANBMy1ipFRxesCHU4++GNGBdVh9xG+4AsjA2MjnmMtrKsp5TFhWNW4sUXOnT
 xzDOwK0un7isKzTSnbkjX5JaWHw74m2eAkN8ajkmimHo6HdrY5LgtlEjfYx581okJeON
 REQsbvTT72qEpmHjOrdYYuwCE/A1GQSe9U2WKPLMGPEjFkhrToXLIn1x548J2QAvB2dW
 gtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461729; x=1770066529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/hevqQtoPuwGKoLwEph8m2SKFnpaXkidbgymfG5NiKk=;
 b=A+Sf7IRxNqJmrleNsM8GmL1jbJnwk017sqGq+J/1QM+E9XK6IhDahZIBjYt+DVOTv1
 7KO9D2BxlcgO7jloym/3pe9AACD/QOqhPFwW3ZPTgHX4FBNmd90J9mdFrxeiqioUS4ps
 fNFqiafmRFb3BktoovsdXSkCnuT2qUeze7nJf+i4l7fZxDNWGyPe2GqNVgPUk/5gVP0Z
 ziopq9IJq0dnItiYBulhpaAuznxBYBjtLNswJczfGxW9/6QCwaJ+hzRzDfxSgcmR2B1o
 4eERH0Vf+gmqQse+JXdOML5BOYc/5zWycgPgUpXiJw/t77hhUlgfbnPxw9COeaf4M1ZO
 Pz3w==
X-Gm-Message-State: AOJu0YyRLiMJ/oOR+iDsrYQYgDyGSFCihUSREbL8gfIpao8j4WJOO0M1
 WrCXSAdjrReRgR5o+t+xBY2sWbQY4T3sZr41xMxpmTPWoCEfE5c9/+BJU0uZSO21
X-Gm-Gg: AZuq6aKXfqwVKdYWnUep65uyvmp0kCmw2rY6F0I5CyDFsvbtVcCL9jDeDJdhHIseOB6
 VL+dkAtZyhZ939+KW+/aQgi1zzeBQIvGVhj5exjXWFe+DOJ6cyYKiiH67c+odRMpny49tzjLTWi
 Aj0+UZXJY5UaxxvSLhT5PB19Q1trQQ/sRMJtW/madhKKvncnf+r953rnlfQAmPCGcIS9EGWp7aB
 Vmv+Ed1yy1QP/yHo1+CX3t2AzQLyo8XP6672viUPRgmTws3j4+dHV223mloU6dTil4325Ky4Gf6
 CE4ZKeizC9sEFU5GRnuzRvLvhtGZ8gxg0hPpkH9IOmNks1xdQuPvbmRvFCDh6RNthLMrWSAi+xH
 41UqJ3QLREdWQB3jzKuoNyASCMX5jqyTkvbROjK+PJhPotrhL0ELm7ikw1Kf22ZM/lCh+vrDyRB
 UU/lj8zzggyzN+r5NKHSfATMJYQ5lFSmFyUl3W6owgNW/sT6oCSr9u
X-Received: by 2002:a05:6000:186a:b0:435:97ab:1288 with SMTP id
 ffacd0b85a97d-435ca3a5b0emr9912712f8f.58.1769461729115; 
 Mon, 26 Jan 2026 13:08:49 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:48 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/14] drm/amd/display: Add DCE HWSS support for external DP
 bridge encoders
Date: Mon, 26 Jan 2026 22:08:33 +0100
Message-ID: <20260126210837.21885-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
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

Some GPUs use external DP bridge encoders NUTMEG and TRAVIS
to implement analog and/or LVDS connections. Typically found in
CIK APU based laptops or on FM2 motherboards that have analog
connectors. These were necessary at the time because Kaveri
didn't have a built-in DAC nor LVDS support.

These devices sadly don't work transparently and need to be
controlled by the driver. Implement the necessary control for
the NUTMEG and TRAVIS encoders in the DCE HWSS.

For reference, see the legacy non-DC amdgpu display code:
amdgpu_atombios_encoder_setup_external_encoder()
amdgpu_atombios_encoder_setup_dig()
amdgpu_atombios_encoder_setup_ext_encoder_ddc()

- Prepare DDC before using it:
  Call the EXTERNAL_ENCODER_CONTROL_DDC_SETUP action so that
  the encoder knows to set up DDC over the AUX channel.

- When a stream is enabled or disabled:
  Call the EXTERNAL_ENCODER_CONTROL_ENABLE/DISABLE actions.

- Before enabling the DP link:
  Call the EXTERNAL_ENCODER_CONTROL_SETUP action.

This commit just hooks up the HWSS support.
Detecting the external DP bridge encoders will be done in
a subsequent commit.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 54 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ff15e5990ec0..11c0fa317f88 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1681,6 +1681,10 @@ struct dc_scratch_space {
 	struct panel_cntl *panel_cntl;
 	struct link_encoder *link_enc;
 	struct graphics_object_id link_id;
+
+	/* External encoder eg. NUTMEG or TRAVIS used on CIK APUs. */
+	struct graphics_object_id ext_enc_id;
+
 	/* Endpoint type distinguishes display endpoints which do not have entries
 	 * in the BIOS connector table from those that do. Helps when tracking link
 	 * encoder to display endpoint assignments.
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4e820020252b..3f5c833ce18a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -660,6 +660,48 @@ void dce110_update_info_frame(struct pipe_ctx *pipe_ctx)
 	}
 }
 
+static void
+dce110_external_encoder_control(enum bp_external_encoder_control_action action,
+				struct dc_link *link,
+				struct dc_crtc_timing *timing)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dc_bios *bios = link->ctx->dc_bios;
+	const struct dc_link_settings *link_settings = &link->cur_link_settings;
+	enum bp_result bp_result = BP_RESULT_OK;
+	struct bp_external_encoder_control ext_cntl = {
+		.action = action,
+		.connector_obj_id = link->link_enc->connector,
+		.encoder_id = link->ext_enc_id,
+		.lanes_number = link_settings->lane_count,
+		.link_rate = link_settings->link_rate,
+
+		/* Use signal type of the real link encoder, ie. DP */
+		.signal = link->connector_signal,
+
+		/* We don't know the timing yet when executing the SETUP action,
+		 * so use a reasonably high default value. It seems that ENABLE
+		 * can change the actual pixel clock but doesn't work with higher
+		 * pixel clocks than what SETUP was called with.
+		 */
+		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
+		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
+	};
+	DC_LOGGER_INIT();
+
+	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
+
+	if (bp_result != BP_RESULT_OK)
+		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
+}
+
+static void
+dce110_prepare_ddc(struct dc_link *link)
+{
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link, NULL);
+}
+
 static void
 dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
 {
@@ -717,6 +759,9 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
 		dce110_dac_encoder_control(pipe_ctx, true);
+
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_ENABLE, link, timing);
 }
 
 static enum bp_result link_transmitter_control(
@@ -1213,6 +1258,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 
 	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
 		dce110_dac_encoder_control(pipe_ctx, false);
+
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DISABLE, link, NULL);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -3362,6 +3410,11 @@ void dce110_enable_dp_link_output(
 		}
 	}
 
+	if (link->ext_enc_id.id) {
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_INIT, link, NULL);
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_SETUP, link, NULL);
+	}
+
 	if (dc->link_srv->dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
 		if (dc->clk_mgr->funcs->notify_link_rate_change)
 			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
@@ -3454,6 +3507,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_dp_link_output = dce110_enable_dp_link_output,
 	.disable_link_output = dce110_disable_link_output,
 	.dac_load_detect = dce110_dac_load_detect,
+	.prepare_ddc = dce110_prepare_ddc,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
-- 
2.52.0


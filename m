Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEE8E73156
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5B510E443;
	Mon,  2 Feb 2026 11:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VUEnb4Sl";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E6910E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:16 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43591b55727so3765489f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031515; x=1770636315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rF5YDmX6zwoPeWklVRFubm1RmIvMt4U6Cw5SIv4BFSc=;
 b=VUEnb4SlIZxG2VGzXMrIxrQ7qjBZLNuXl+LwCrq3csDsZBP0WCbYO1zwe0F6Nd60MN
 Fn8peqXMRczmUO6emnurVgUzaW1Wao7mXIf1jB3w110WZYrwP8vRVnpvfWnJuomjlMru
 MxxvuBi0P37ozGPOzUtig6LMvZtg1DwNGLyMCEY2FiZOJQOgCEQ1/txFl9EDJOiqqdIs
 t96p/D/p4pNlblkoWhWZbOKOY8kJ/z/oQfNLpSHKmb4ZiS/2ACRIdkMY9aROgD19aSDB
 LsHbx4eEPMxPq8GqsHlb6dhDnfjb86HGYYeiMrAgE4os4sSkxp/rE6kWThPDQJQssEkR
 xZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031515; x=1770636315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rF5YDmX6zwoPeWklVRFubm1RmIvMt4U6Cw5SIv4BFSc=;
 b=cvExnA2jPjl52OH7enCSBaQ5LfKlifJzq0wyu1AaI56Bc5OURBigi9yLAG/kHg4pXd
 vI1TeQ0TF6sPkvf8QahwJ4KCHXXzBb04a1GHnbrog8exJ33hNljAU8urcYPTXVU68dBJ
 GFlsehamtzdJhJGgbhZAt0RvpVCIVz8sevu51e24o00H2AoCo8+UIOEKaofYz5NKppCB
 LduISZMM0pvt97dTudSNnGWzZ6YFwLOkg3PWX6lHriM1BEvLRlQaMjezG4qJL+btyi1W
 XybKMxAzv1MDb9GLW8++fGZW/60/s6uTw9c1uU/VpcnzPT6WqsK8FsUSWKHq5EQzpkxs
 vTuQ==
X-Gm-Message-State: AOJu0YzBNHshxuH36DH6vGqlQj+do3KaZCgOj/1F/kMPS6sSNoWNLcoh
 y08GRYzuSKUccV07ZgfMYbHJZTTGFXJknSQZ6l8ficS1lr2N0vTzoSlTwq/5Nva9
X-Gm-Gg: AZuq6aLalFlhYqLihgr2LqDWC042ZWj25a5tSL/GEvYJ1spOcx/q3+WHuHp44pTlVqV
 cX8SQES52qR1LyPgLtWh7FORRBGBCjKdZFEWCXRD3Q/dUim+THOVbOe2/XcgGepR3nKJ6NvSYLp
 oJ5AC6TRLXjugd09tlDeDDwrnotUfm8IENJv9catXjTvwFlLBCmungT+salWFO0IZ0hMOEwYIkj
 8HWPn7oOmpoJZk6gR6fQK5TON6fYcXh0Nxb/VypLDbfeKpLnPf4tNlyQjf4Y0117YWhvd1NVaJt
 sniFGxtLGkZMFqUXCxljkW+vdewOqV3INlgDBvwIA9/GwNWDvqYoFeh9AcpzyB/nA5utwyzxam0
 6+l0JYNISPdUmmqALd+rwJNhpg2dKDXYs1JwCPkUXwZEIudqfSy1ftYcyezOlFf5WNH0TD4oGXb
 EoBtMEvujXKyJo
X-Received: by 2002:a05:6000:238a:b0:430:ff0c:35f9 with SMTP id
 ffacd0b85a97d-435f3ab0115mr14282910f8f.48.1770031514796; 
 Mon, 02 Feb 2026 03:25:14 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:14 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amd/display: Turn off DAC in DCE link encoder using
 VBIOS
Date: Mon,  2 Feb 2026 12:25:04 +0100
Message-ID: <20260202112508.43000-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202112508.43000-1-timur.kristof@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
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

Apparently, the VBIOS DAC1EncoderControl function is much more
graceful about turning off the DAC. It writes various DAC
registers in a specific sequence. Use that instead of just
clearing the DAC_ENABLE register.

Do this in just the dce110_link_encoder_disable_output
function and remove it from the HWSS.

Fixes: 0fbe321a93ce ("drm/amd/display: Implement DCE analog link encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 30 +++++++++++--------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  3 --
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 7f0766b5fa3d..f8fcf8d1a4dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -133,6 +133,21 @@ static enum bp_result link_transmitter_control(
 	return result;
 }
 
+static enum bp_result link_dac_encoder_control(
+	struct dce110_link_encoder *link_enc,
+	enum bp_encoder_control_action action,
+	uint32_t pix_clk_100hz)
+{
+	struct dc_bios *bios = link_enc->base.ctx->dc_bios;
+	struct bp_encoder_control encoder_control = {0};
+
+	encoder_control.action = action;
+	encoder_control.engine_id = link_enc->base.analog_engine;
+	encoder_control.pixel_clock = pix_clk_100hz / 10;
+
+	return bios->funcs->encoder_control(bios, &encoder_control);
+}
+
 static void enable_phy_bypass_mode(
 	struct dce110_link_encoder *enc110,
 	bool enable)
@@ -1345,19 +1360,8 @@ void dce110_link_encoder_disable_output(
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result result;
 
-	switch (enc->analog_engine) {
-	case ENGINE_ID_DACA:
-		REG_UPDATE(DAC_ENABLE, DAC_ENABLE, 0);
-		break;
-	case ENGINE_ID_DACB:
-		/* DACB doesn't seem to be present on DCE6+,
-		 * although there are references to it in the register file.
-		 */
-		DC_LOG_ERROR("%s DACB is unsupported\n", __func__);
-		break;
-	default:
-		break;
-	}
+	if (enc->analog_engine != ENGINE_ID_UNKNOWN)
+		link_dac_encoder_control(enc110, ENCODER_CONTROL_DISABLE, 0);
 
 	/* The code below only applies to connectors that support digital signals. */
 	if (enc->transmitter == TRANSMITTER_UNKNOWN)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index bd3a9f008699..c53c61a4cb5e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1199,9 +1199,6 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
-
-	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
-		dce110_dac_encoder_control(pipe_ctx, false);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
-- 
2.52.0


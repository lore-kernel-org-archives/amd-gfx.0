Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1A3D3ABE4
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 02:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B6710EBDA;
	Sat,  6 Dec 2025 02:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lG77GiUg";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F7B10EB2A
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Dec 2025 02:31:12 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42b47f662a0so1947896f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Dec 2025 18:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764988271; x=1765593071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yzxch6Pg/EctJtTc5i17wQYzE8K7IXDVorO0u5PHgsc=;
 b=lG77GiUgBZGvF3PHg9LX9zkR/65FlHkJdBzZvahst0d7sWE+d+6+A/+yGxthQX5ZgF
 POgrrGYwa/GsElnDnhRL79PWjJ8J7Io9aJDA7BFFHwaYqK8D6UPG1khwWf7u8dQUXMGj
 3GmzyCnJpxN+ag+6QLYjPJjV21HpmQhhIhU93vyikeRNxST1maDQrCR0gO8an/bQoMyC
 PBMsofXAV+zdy1ssaBgXJ+63RpB/ddDDDnltnbRc6KeO45gtwu/iy16n+TwaJWPPunIl
 6hw9/8Qm2LswCHe+KpuPgrOEJN74QAmgKrLiMfDWN8awwIgQxtKcV4L0xVwc+nXz9QJ3
 +CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764988271; x=1765593071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yzxch6Pg/EctJtTc5i17wQYzE8K7IXDVorO0u5PHgsc=;
 b=kCiyix8kPzpM51bzVAJOl01/h82xdFVfiXg3CQ22Kpn0OI4aUWTKtWJ8pPYmuRl1QF
 0XA2b2azpATsu0FwdpSyC5c/yLVSgRRKvRJsms423GTmTwJo7oAPltiMhfQlnQmkCEJd
 fE+S0lQQg4LjkO8HwRLtcteguwWo1E1dSruI8wcaUbL4j+eqlTD3JDrAzBI2WIKJi8O7
 PNVDQsvMv5aWUFmVShLQn0wlD3eU8a+kaOLFxhFmuJrJjMy6TbYjYVGLRp2MF050Fkm4
 JLlrRZ9ZwQC2H4q6k6GSwqcBOKmO1p9FXYWLsxSuViobGDDAVkfAImQ2lSdqH+NceRqJ
 8vGg==
X-Gm-Message-State: AOJu0YwW+QAGHe8dKKsR+YVPGaKAbC8Ix6vQaPhEgD7m/BEPgW3jZ72g
 jLx+IvtILaAB6TdLtzJ2HxJjSfEkN1Xdp75mGyeylkP1DPxCrkVZfGcFPzmG9Q==
X-Gm-Gg: ASbGncv6BKTdnfQs8fL9OSZwjgio3utL4MJSRl+Ni6EVqekJXTXiGbAv02yoGcKdYiP
 QFzmnKl1GCYe0lu02nUvXXA/K3gXb1o648Umwm08/DkWUI80LZ3JZR1589Cd0m8Dcbn3+EsFXQ6
 K1YobBuqHhljaFCVXf9L8JJgkUfZ1a4DGkR3a5IIRLjRcXQ3vi2JAnzajb0YRKVVed7B64JmoQO
 epG1kV+DNHbw88mTNOF9sKJAdd0vlN8z7fhmGIfu4TECs6vsu1Q1RNMiPJeCY1Gng5deX4Llo1p
 S2nIzvxJgYrFdJD4Dw7epX7z4vEUYGNoqUiSyZyVxbd4kEayWrajClkuxKHUuuuvUrrJWiHS9Jp
 BVzjqLzOfnYXXPC2rNGD5kspv0XecGRW4Am2NSR/FIFVzTf/One6BSpRZGDL/GGRaJZzy6ME3Uy
 pDIUxWoj3yGoZo5YUIUaEzU89MmlYcNO5+0Sv2bALWpr86ucEpZ0fqq9ufa4z0EQxr82fddsY8u
 DTnelVkJNZgd9+Qbgw=
X-Google-Smtp-Source: AGHT+IEU+3Aij1PNwqlootpwkCFDRQz3nH7KDb5TatLTons/CId7AM962WvAZu3lGcx5LDXVgkFKrw==
X-Received: by 2002:a05:6000:2404:b0:42f:8816:ee6c with SMTP id
 ffacd0b85a97d-42f89ef90c7mr1362212f8f.30.1764988270702; 
 Fri, 05 Dec 2025 18:31:10 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E095001DEDB2C8B6514266.dsl.pool.telekom.hu.
 [2001:4c4e:24e0:9500:1ded:b2c8:b651:4266])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff320sm12133689f8f.18.2025.12.05.18.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 18:31:09 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amd/display: Pass proper DAC encoder ID to VBIOS
Date: Sat,  6 Dec 2025 03:31:02 +0100
Message-ID: <20251206023106.8875-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206023106.8875-1-timur.kristof@gmail.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
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

Similarly to the analog_engine field, add a new	analog_id field
which contains the encoder ID of the analog encoder that
corresponds to the link encoder.

Previously, the default encoder ID of the link encoder was used,
which meant that we passed the wrong ID in case of DVI-I.

Fixes: 7d63519cd9ca ("drm/amd/display: Add concept of analog encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |  2 ++
 drivers/gpu/drm/amd/display/dc/link/link_factory.c     | 10 +++++-----
 .../amd/display/dc/resource/dce110/dce110_resource.c   |  2 ++
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 87dbb8d7ed27..5c1a10f77733 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -850,6 +850,7 @@ void dce110_link_encoder_construct(
 	enc110->base.funcs = &dce110_lnk_enc_funcs;
 	enc110->base.ctx = init_data->ctx;
 	enc110->base.id = init_data->encoder;
+	enc110->base.analog_id = init_data->analog_encoder;
 
 	enc110->base.hpd_source = init_data->hpd_source;
 	enc110->base.connector = init_data->connector;
@@ -1793,6 +1794,7 @@ void dce60_link_encoder_construct(
 	enc110->base.funcs = &dce60_lnk_enc_funcs;
 	enc110->base.ctx = init_data->ctx;
 	enc110->base.id = init_data->encoder;
+	enc110->base.analog_id = init_data->analog_encoder;
 
 	enc110->base.hpd_source = init_data->hpd_source;
 	enc110->base.connector = init_data->connector;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index df512920a9fa..e638325e35ec 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -47,6 +47,7 @@ struct encoder_init_data {
 	enum hpd_source_id hpd_source;
 	/* TODO: in DAL2, here was pointer to EventManagerInterface */
 	struct graphics_object_id encoder;
+	struct graphics_object_id analog_encoder;
 	enum engine_id analog_engine;
 	struct dc_context *ctx;
 	enum transmitter transmitter;
@@ -81,6 +82,7 @@ struct link_encoder {
 	int32_t aux_channel_offset;
 	struct dc_context *ctx;
 	struct graphics_object_id id;
+	struct graphics_object_id analog_id;
 	struct graphics_object_id connector;
 	uint32_t output_signals;
 	enum engine_id preferred_engine;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index a6e2b0821969..23a302d7fbc8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -451,20 +451,19 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 	return channel;
 }
 
-static enum engine_id find_analog_engine(struct dc_link *link)
+static enum engine_id find_analog_engine(struct dc_link *link, struct graphics_object_id *enc)
 {
 	struct dc_bios *bp = link->ctx->dc_bios;
-	struct graphics_object_id encoder = {0};
 	enum bp_result bp_result = BP_RESULT_OK;
 	int i;
 
 	for (i = 0; i < 3; i++) {
-		bp_result = bp->funcs->get_src_obj(bp, link->link_id, i, &encoder);
+		bp_result = bp->funcs->get_src_obj(bp, link->link_id, i, enc);
 
 		if (bp_result != BP_RESULT_OK)
 			return ENGINE_ID_UNKNOWN;
 
-		switch (encoder.id) {
+		switch (enc->id) {
 		case ENCODER_ID_INTERNAL_DAC1:
 		case ENCODER_ID_INTERNAL_KLDSCP_DAC1:
 			return ENGINE_ID_DACA;
@@ -474,6 +473,7 @@ static enum engine_id find_analog_engine(struct dc_link *link)
 		}
 	}
 
+	memset(enc, 0, sizeof(*enc));
 	return ENGINE_ID_UNKNOWN;
 }
 
@@ -527,7 +527,7 @@ static bool construct_phy(struct dc_link *link,
 	 */
 	bp_funcs->get_src_obj(bios, link->link_id, 0, &enc_init_data.encoder);
 	enc_init_data.transmitter = translate_encoder_to_transmitter(enc_init_data.encoder);
-	enc_init_data.analog_engine = find_analog_engine(link);
+	enc_init_data.analog_engine = find_analog_engine(link, &enc_init_data.analog_encoder);
 
 	link->ep_type = DISPLAY_ENDPOINT_PHY;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
index cd54382c0af3..7c09825cd9bd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
@@ -895,6 +895,8 @@ static void get_pixel_clock_parameters(
 	 */
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
 	pixel_clk_params->encoder_object_id = stream->link->link_enc->id;
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		pixel_clk_params->encoder_object_id = stream->link->link_enc->analog_id;
 	pixel_clk_params->signal_type = pipe_ctx->stream->signal;
 	pixel_clk_params->controller_id = pipe_ctx->stream_res.tg->inst + 1;
 	/* TODO: un-hardcode*/
-- 
2.52.0


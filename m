Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9A4C83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E08210E7FB;
	Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BzldgAVe";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01E010E806
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:30 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so77453365e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286309; x=1753891109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBY5T30Ht/9tNMDwpsynh6MJwlLeIdTcyks8iR3XOBU=;
 b=BzldgAVeG9ZS9teyosD628riBygY/uaxqjxe29NPdruC8OqBRxvJ+SieeEPHyCK4nz
 69sEAucIAYQimfx1ge+4puuUbVxmj0YJtdEsgsv0F2iy5ISANI5XGxUQg8M6OcPDEgdi
 zso08wjH8IxPxdT3kHVpUrvnXIrogQoh0EBvLfXZw+2QB5WGPpbZ8V40HjM8L+5915I8
 jcQs73DEUiUXiTVkJGoIX0L2gB97MIbEYtgmTQB5VxnGOcSxOfpQGyGqTdwLCwVFByYs
 fJ6JonQVjPDYLEYOQW3+tXWhLUyw2bcm6SkmaBYmymbImAIVjSh0mMbc8PMxkd/cedtw
 1upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286309; x=1753891109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBY5T30Ht/9tNMDwpsynh6MJwlLeIdTcyks8iR3XOBU=;
 b=RP/8XpkeNYEAsH1gllfYMfZIOFnlatavtXf+r+1Z+9o8VN86v1FR96bIkF8DL6Xh2E
 Ecq6hMQYqP6EJ6SAF90dq/CdzIotxnVNe0DGDIrmaOzgCz6XLrF1H4fIggWdquYQl0f9
 GAbU8Bei80s79BYR9OkcORUC+nGpvIZ2gSYtmUzBQRIEjVB6Zq4Rnjz3s6nH6Kx4IZBf
 /YeUYrPI74NarHOqCWz78Rulc6GflFzswmcqx/9jCHMG0ovNNEic5izCUnm+I/p50zAI
 e85XeHwCN6ZPhc6XwWrn7ZVbmNIp50CLVcUj96I7BAZzZ73w4KB4ch9LNAzYig2YkEan
 w8ug==
X-Gm-Message-State: AOJu0YxVtX+2COojPt1sYBodeDLFGdIUgEKF+QSd5I3UR5aZ0ejaD1tl
 Mt7CEo8IqnnE55fP/yi/I0MVcaEz90WXxRkV0dHw36vCCs9qftY1MTOWhRe2JA==
X-Gm-Gg: ASbGncu5dZ2iiqBeMQ2TRbKeTlYI1rJDcde/t9ttghfUsmul2MdiX1eP8qGga941AG5
 57BkdcBJQw7/NFl+L4PKwPKGWE2iNWRfJ6LpyieGQG9pTCzsZvA4N3DyygySs9C2rs/MtKW8Yt8
 DHLoycw4PFxbbpgpjKKN7BaIf9oAznFEeOpVJnaXDaMK54Fpi8q3IXXqBjvGhXMjLUPSm4gvU7a
 BbHFy81SXjw+36+rju2R44lscosEVnUMt1CadhIdm0m4rixaa6qUk+O7tfbduBsFU2uWr+PbR1Y
 OE+Rs5I89APb2CTJ6MNaGfG/BFzytlUwdnzH6ufNSsAWNLr7Jwgv3UY16duLZ4qB6xAzhuolEY6
 S8ck+Qqw7ofwaNub+ldFeJeZQ1M7UCOnOm4uCvlTuM6qtKPoSG/+2h2Di66znOUtls1HILXv3qM
 6fMSRId6doKah/oSdH3750oR1YCg==
X-Google-Smtp-Source: AGHT+IGYOJL/rOJP6IQ5xN8gemVyLR5HPqZiCONXd63cvPlq+0NBU4baYe4jcQNOX9Wq4n+LNIJCAQ==
X-Received: by 2002:a05:600d:f:b0:453:59c2:e4f8 with SMTP id
 5b1f17b1804b1-458695e0cb3mr19082205e9.1.1753286308913; 
 Wed, 23 Jul 2025 08:58:28 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/20] drm/amd/display: Implement DCE analog link encoders
Date: Wed, 23 Jul 2025 17:58:04 +0200
Message-ID: <20250723155813.9101-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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

We support two kinds of analog connections:

1. VGA, which only supports analog signals:
For VGA, we need to create a link encoder that only works with the
DAC without perturbing any digital transmitter functionality.
This is achieved by the new dce110_analog_link_encoder_construct.

2. DVI-I, which allows both digital and analog signals:
The DC code base only allows 1 encoder per connector, and the
preferred engine type is still going to be digital. So, for DVI-I
to work, we need to make sure the pre-existing link encoder can
also work with analog signals.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 100 ++++++++++++++++++
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  21 ++--
 .../dc/resource/dce100/dce100_resource.c      |  13 ++-
 .../dc/resource/dce60/dce60_resource.c        |  16 ++-
 .../dc/resource/dce80/dce80_resource.c        |  13 ++-
 5 files changed, 152 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 4a9d07c31bc5..0d5069773f57 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -804,6 +804,24 @@ bool dce110_link_encoder_validate_dp_output(
 	return true;
 }
 
+static bool dce110_link_encoder_validate_rgb_output(
+	const struct dce110_link_encoder *enc110,
+	const struct dc_crtc_timing *crtc_timing)
+{
+	uint32_t max_pixel_clock_khz = 400000;
+
+	if (enc110->base.ctx->dc_bios->fw_info_valid &&
+	    enc110->base.ctx->dc_bios->fw_info.max_pixel_clock) {
+		max_pixel_clock_khz =
+			enc110->base.ctx->dc_bios->fw_info.max_pixel_clock;
+	}
+
+	if (crtc_timing->pix_clk_100hz > max_pixel_clock_khz * 10)
+		return false;
+
+	return true;
+}
+
 void dce110_link_encoder_construct(
 	struct dce110_link_encoder *enc110,
 	const struct encoder_init_data *init_data,
@@ -824,6 +842,7 @@ void dce110_link_encoder_construct(
 	enc110->base.connector = init_data->connector;
 
 	enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
+	enc110->base.analog_engine = init_data->analog_engine;
 
 	enc110->base.features = *enc_features;
 
@@ -847,6 +866,11 @@ void dce110_link_encoder_construct(
 		SIGNAL_TYPE_EDP |
 		SIGNAL_TYPE_HDMI_TYPE_A;
 
+	if ((enc110->base.connector.id == CONNECTOR_ID_DUAL_LINK_DVII ||
+	     enc110->base.connector.id == CONNECTOR_ID_SINGLE_LINK_DVII) &&
+		enc110->base.analog_engine != ENGINE_ID_UNKNOWN)
+		enc110->base.output_signals |= SIGNAL_TYPE_RGB;
+
 	/* For DCE 8.0 and 8.1, by design, UNIPHY is hardwired to DIG_BE.
 	 * SW always assign DIG_FE 1:1 mapped to DIG_FE for non-MST UNIPHY.
 	 * SW assign DIG_FE to non-MST UNIPHY first and MST last. So prefer
@@ -939,6 +963,10 @@ bool dce110_link_encoder_validate_output_with_stream(
 		is_valid = dce110_link_encoder_validate_dp_output(
 					enc110, &stream->timing);
 	break;
+	case SIGNAL_TYPE_RGB:
+		is_valid = dce110_link_encoder_validate_rgb_output(
+					enc110, &stream->timing);
+	break;
 	case SIGNAL_TYPE_EDP:
 	case SIGNAL_TYPE_LVDS:
 		is_valid = stream->timing.pixel_encoding == PIXEL_ENCODING_RGB;
@@ -1034,6 +1062,8 @@ void dce110_link_encoder_setup(
 		/* DP MST */
 		REG_UPDATE(DIG_BE_CNTL, DIG_MODE, 5);
 		break;
+	case SIGNAL_TYPE_RGB:
+		break;
 	default:
 		ASSERT_CRITICAL(false);
 		/* invalid mode ! */
@@ -1282,6 +1312,23 @@ void dce110_link_encoder_disable_output(
 	struct bp_transmitter_control cntl = { 0 };
 	enum bp_result result;
 
+	switch (enc->analog_engine) {
+	case ENGINE_ID_DACA:
+		REG_UPDATE(DAC_ENABLE, DAC_ENABLE, 0);
+		break;
+	case ENGINE_ID_DACB:
+		/* DACB doesn't seem to be present on DCE6+,
+		 * although there are references to it in the register file.
+		 */
+		DC_LOG_ERROR("%s DACB is unsupported\n", __func__);
+		break;
+	default:
+		break;
+	}
+
+	if (enc->preferred_engine == enc->analog_engine)
+		return;
+
 	if (!dce110_is_dig_enabled(enc)) {
 		/* OF_SKIP_POWER_DOWN_INACTIVE_ENCODER */
 		return;
@@ -1726,6 +1773,7 @@ void dce60_link_encoder_construct(
 	enc110->base.connector = init_data->connector;
 
 	enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
+	enc110->base.analog_engine = init_data->analog_engine;
 
 	enc110->base.features = *enc_features;
 
@@ -1749,6 +1797,11 @@ void dce60_link_encoder_construct(
 		SIGNAL_TYPE_EDP |
 		SIGNAL_TYPE_HDMI_TYPE_A;
 
+	if ((enc110->base.connector.id == CONNECTOR_ID_DUAL_LINK_DVII ||
+	     enc110->base.connector.id == CONNECTOR_ID_SINGLE_LINK_DVII) &&
+		enc110->base.analog_engine != ENGINE_ID_UNKNOWN)
+		enc110->base.output_signals |= SIGNAL_TYPE_RGB;
+
 	/* For DCE 8.0 and 8.1, by design, UNIPHY is hardwired to DIG_BE.
 	 * SW always assign DIG_FE 1:1 mapped to DIG_FE for non-MST UNIPHY.
 	 * SW assign DIG_FE to non-MST UNIPHY first and MST last. So prefer
@@ -1814,3 +1867,50 @@ void dce60_link_encoder_construct(
 	}
 }
 #endif
+
+static void dce110_analog_link_encoder_hw_init(
+	struct link_encoder *enc)
+{
+}
+
+static void dce110_analog_link_encoder_setup(
+	struct link_encoder *enc,
+	enum signal_type signal)
+{
+}
+
+static void dce110_analog_link_encoder_get_max_link_cap(
+	struct link_encoder *enc,
+	struct dc_link_settings *link_settings)
+{
+	memset(link_settings, 0, sizeof(struct dc_link_settings));
+}
+
+static const struct link_encoder_funcs dce110_an_lnk_enc_funcs = {
+	.validate_output_with_stream =
+		dce110_link_encoder_validate_output_with_stream,
+	.hw_init = dce110_analog_link_encoder_hw_init,
+	.setup = dce110_analog_link_encoder_setup,
+	.disable_output = dce110_link_encoder_disable_output,
+	.destroy = dce110_link_encoder_destroy,
+	.get_max_link_cap = dce110_analog_link_encoder_get_max_link_cap,
+};
+
+void dce110_analog_link_encoder_construct(
+	struct dce110_link_encoder *enc110,
+	const struct encoder_init_data *init_data,
+	const struct dce110_link_enc_registers *link_regs)
+{
+	enc110->base.funcs = &dce110_an_lnk_enc_funcs;
+	enc110->base.ctx = init_data->ctx;
+	enc110->base.id = init_data->encoder;
+
+	enc110->base.hpd_source = init_data->hpd_source;
+	enc110->base.connector = init_data->connector;
+	enc110->base.preferred_engine = init_data->analog_engine;
+	enc110->base.analog_engine = init_data->analog_engine;
+	enc110->base.transmitter = init_data->transmitter;
+	enc110->base.output_signals = SIGNAL_TYPE_RGB;
+
+	enc110->link_regs = link_regs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 261c70e01e33..1eda1a1a539c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -101,18 +101,21 @@
 	SRI(DP_SEC_CNTL, DP, id), \
 	SRI(DP_VID_STREAM_CNTL, DP, id), \
 	SRI(DP_DPHY_FAST_TRAINING, DP, id), \
-	SRI(DP_SEC_CNTL1, DP, id)
+	SRI(DP_SEC_CNTL1, DP, id), \
+	SR(DAC_ENABLE)
 #endif
 
 #define LE_DCE80_REG_LIST(id)\
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
-	LE_COMMON_REG_LIST_BASE(id)
+	LE_COMMON_REG_LIST_BASE(id), \
+	SR(DAC_ENABLE)
 
 #define LE_DCE100_REG_LIST(id)\
 	LE_COMMON_REG_LIST_BASE(id), \
 	SRI(DP_DPHY_BS_SR_SWAP_CNTL, DP, id), \
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
-	SR(DCI_MEM_PWR_STATUS)
+	SR(DCI_MEM_PWR_STATUS), \
+	SR(DAC_ENABLE)
 
 #define LE_DCE110_REG_LIST(id)\
 	LE_COMMON_REG_LIST_BASE(id), \
@@ -181,6 +184,9 @@ struct dce110_link_enc_registers {
 	uint32_t DP_DPHY_BS_SR_SWAP_CNTL;
 	uint32_t DP_DPHY_HBR2_PATTERN_CONTROL;
 	uint32_t DP_SEC_CNTL1;
+
+	/* DAC registers */
+	uint32_t DAC_ENABLE;
 };
 
 struct dce110_link_encoder {
@@ -199,6 +205,11 @@ void dce110_link_encoder_construct(
 	const struct dce110_link_enc_aux_registers *aux_regs,
 	const struct dce110_link_enc_hpd_registers *hpd_regs);
 
+void dce110_analog_link_encoder_construct(
+	struct dce110_link_encoder *enc110,
+	const struct encoder_init_data *init_data,
+	const struct dce110_link_enc_registers *link_regs);
+
 #if defined(CONFIG_DRM_AMD_DC_SI)
 void dce60_link_encoder_construct(
 	struct dce110_link_encoder *enc110,
@@ -215,10 +226,6 @@ bool dce110_link_encoder_validate_dvi_output(
 	enum signal_type signal,
 	const struct dc_crtc_timing *crtc_timing);
 
-bool dce110_link_encoder_validate_rgb_output(
-	const struct dce110_link_encoder *enc110,
-	const struct dc_crtc_timing *crtc_timing);
-
 bool dce110_link_encoder_validate_dp_output(
 	const struct dce110_link_encoder *enc110,
 	const struct dc_crtc_timing *crtc_timing);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index 9e70e920eb69..6a4c1b47f80d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -224,6 +224,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(4),
 	link_regs(5),
 	link_regs(6),
+	{ .DAC_ENABLE = mmDAC_ENABLE },
 };
 
 #define stream_enc_regs(id)\
@@ -629,7 +630,17 @@ static struct link_encoder *dce100_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
+		return NULL;
+
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+		dce110_analog_link_encoder_construct(enc110,
+						enc_init_data,
+						&link_enc_regs[ENGINE_ID_DACA]);
+		return &enc110->base;
+	}
+
+	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 29ccfbddb492..98775e5ef0bf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -239,7 +239,9 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(2),
 	link_regs(3),
 	link_regs(4),
-	link_regs(5)
+	link_regs(5),
+	{0},
+	{ .DAC_ENABLE = mmDAC_ENABLE },
 };
 
 #define stream_enc_regs(id)\
@@ -725,7 +727,17 @@ static struct link_encoder *dce60_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
+		return NULL;
+
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+		dce110_analog_link_encoder_construct(enc110,
+						enc_init_data,
+						&link_enc_regs[ENGINE_ID_DACA]);
+		return &enc110->base;
+	}
+
+	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index f90e51696bda..7fde2b8719c7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -240,6 +240,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(4),
 	link_regs(5),
 	link_regs(6),
+	{ .DAC_ENABLE = mmDAC_ENABLE },
 };
 
 #define stream_enc_regs(id)\
@@ -731,7 +732,17 @@ static struct link_encoder *dce80_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
+		return NULL;
+
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+		dce110_analog_link_encoder_construct(enc110,
+						enc_init_data,
+						&link_enc_regs[ENGINE_ID_DACA]);
+		return &enc110->base;
+	}
+
+	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.50.1


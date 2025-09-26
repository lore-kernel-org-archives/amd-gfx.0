Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E0CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8790110EACA;
	Fri, 26 Sep 2025 18:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="frx6GdXl";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD6A10EAC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:18 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so29742575ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909798; x=1759514598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oU20Bo9+u6bwiR6MInJDeKNcuICrhXem81CKsrm5IIY=;
 b=frx6GdXlKGc/Ejl1gktqjUXldizaU8EPVvUoUu0+8QyJiB7TavbvF/PBrpbqL65kIN
 MaLNGEp8ZZ5SYoa67G9jqYfJmB8LRuwXS8WpjcLcJCZ2w2GSR+701F/a9/9dfIDA+UDy
 9aFgQc8zOcdGGuWqZfUD8mFXUAVjwgFeSKyTALOfG3k6rfJ6PHjTKD+f2JD+Q8VKzz4W
 HFUbWIdcnGKF2/VCRq0DcBadBF15VvqlNSaxjIq1fF33NlAHwq1t2LZ0+bcqvt6/rSeu
 6v+m03Kj4P6iZGv8JTQOct/d+LqQLLpN1bTPAjmZXlEnBqv8dV6dQwbynoSQaIzOyvFc
 Hb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909798; x=1759514598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oU20Bo9+u6bwiR6MInJDeKNcuICrhXem81CKsrm5IIY=;
 b=xGNN9IqLvs0leFD2Pmkl37XOxdApnUar3LoheUQ7CZBq0d5PQlLg7suAiu4magsLrp
 1xqQm5v9QFka4OCRgDeVSR5spztosoQxVz+Oc/XTlPo3jSZpGrabbg8YOx5OFIFQESoh
 JGGkr63eOzpZMB62hLDUpXohT//QEspeOrQo0OzOyzm9n5cMTH0WHT4e8qQ4OoBPJra5
 B+dgm5PSP4nlXYmNIY+gTNyUhBa2g4CWTL5j3+YdJAjMlf9EBXo0gM+fKqdihoTWbiCq
 OKpYbnn9c+5FpNPdz16U64ab5Za/z6DTcQ4nsWAwUIe6qPtxVL3EGbyJc2fQBFWUj8H5
 YOjA==
X-Gm-Message-State: AOJu0YxDTAUfCc3qyegorxBnGQb/ATQ+b+Wbgx3aLrkrqtKnhOgbh3Q/
 y2Ma13Dw+fPmitmu7q63xh3DldnOffXkZzI6svPJdinT+itWdYmTJGtzIFiH7Q==
X-Gm-Gg: ASbGncufuNRzdF2CSZ29hEO503LYt9QswUWjD5kP6y7nXVBXFiNBIH97i4chCOnvpU2
 syHqyGjk7QTe8fGdMGY4drNpi9kYd2rahe9PHU0ZpZTYeC4nrpb5DyzTxmguO2/1Ng+zUm2g/Gt
 xPzoiwCvtG4CGT0ZvlbYxZ7Qn2tvMm/pSn7IIC6iuD9f14laoqMROhKG8CY2UwFBewe4mfpRlYN
 WYkIlB7otatsSsjYVJ+lYqhXgdJnPkzt7tMo6kBKum336tQ9ucZOmg6+f9bKsd5CV3bvSGyGcGR
 RFhHGotUAM4G0peJ9mW/QuJkyU2DY4S1REllki9G7axyeAlcmfWvtuaQc++65Lo6QCoGc16uqA9
 FtFwhSNDV1h4KA2a+SHwrpHuz0PCXowHoFcVzdQ+v9DMLv8UB6IqLcfH0/DJkW/hrS6QXnoqmcI
 qMDYA10i7/IEL9WstNlKl9dktijyASw4qFttms4GrK
X-Google-Smtp-Source: AGHT+IGEjKRL0TFBdrynvf9vVmZ2RhRXMUzsz5bW8owzwoxIQRhMYJ9XdHsW0UnawtzsGrzleGRb4A==
X-Received: by 2002:a17:903:3503:b0:272:d27d:48e1 with SMTP id
 d9443c01a7336-27ed4adb725mr97772855ad.57.1758909798106; 
 Fri, 26 Sep 2025 11:03:18 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:17 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/23] drm/amd/display: Implement DCE analog link encoders (v2)
Date: Fri, 26 Sep 2025 20:01:52 +0200
Message-ID: <20250926180203.16690-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

1. DVI-I, which allows both digital and analog signals:
The DC code base only allows 1 encoder per connector, and the
preferred engine type is still going to be digital. So, for DVI-I
to work, we need to make sure the pre-existing link encoder can
also work with analog signals.

1. VGA, which only supports analog signals:
For VGA, we need to create a link encoder that only works with the
DAC without perturbing any digital transmitter functionality.
Since dce110_link_encoder already supports analog DVI-I,
just reuse that code for VGA as well.

v2:
Reduce code churn by reusing same link encoder for VGA and DVI-I.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 85 +++++++++++++++++++
 .../drm/amd/display/dc/dce/dce_link_encoder.h | 16 ++--
 .../dc/resource/dce100/dce100_resource.c      | 16 +++-
 .../dc/resource/dce60/dce60_resource.c        | 19 ++++-
 .../dc/resource/dce80/dce80_resource.c        | 16 +++-
 5 files changed, 141 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 0c50fe266c8a..87dbb8d7ed27 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -302,6 +302,10 @@ static void setup_panel_mode(
 	if (ctx->dc->caps.psp_setup_panel_mode)
 		return;
 
+	/* The code below is only applicable to encoders with a digital transmitter. */
+	if (enc110->base.transmitter == TRANSMITTER_UNKNOWN)
+		return;
+
 	ASSERT(REG(DP_DPHY_INTERNAL_CTRL));
 	value = REG_READ(DP_DPHY_INTERNAL_CTRL);
 
@@ -804,6 +808,33 @@ bool dce110_link_encoder_validate_dp_output(
 	return true;
 }
 
+static bool dce110_link_encoder_validate_rgb_output(
+	const struct dce110_link_encoder *enc110,
+	const struct dc_crtc_timing *crtc_timing)
+{
+	/* When the VBIOS doesn't specify any limits, use 400 MHz.
+	 * The value comes from amdgpu_atombios_get_clock_info.
+	 */
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
+	if (crtc_timing->display_color_depth != COLOR_DEPTH_888)
+		return false;
+
+	if (crtc_timing->pixel_encoding != PIXEL_ENCODING_RGB)
+		return false;
+
+	return true;
+}
+
 void dce110_link_encoder_construct(
 	struct dce110_link_encoder *enc110,
 	const struct encoder_init_data *init_data,
@@ -824,6 +855,7 @@ void dce110_link_encoder_construct(
 	enc110->base.connector = init_data->connector;
 
 	enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
+	enc110->base.analog_engine = init_data->analog_engine;
 
 	enc110->base.features = *enc_features;
 
@@ -847,6 +879,11 @@ void dce110_link_encoder_construct(
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
@@ -885,6 +922,13 @@ void dce110_link_encoder_construct(
 		enc110->base.preferred_engine = ENGINE_ID_DIGG;
 	break;
 	default:
+		if (init_data->analog_engine != ENGINE_ID_UNKNOWN) {
+			/* The connector is analog-only, ie. VGA */
+			enc110->base.preferred_engine = init_data->analog_engine;
+			enc110->base.output_signals = SIGNAL_TYPE_RGB;
+			enc110->base.transmitter = TRANSMITTER_UNKNOWN;
+			break;
+		}
 		ASSERT_CRITICAL(false);
 		enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
 	}
@@ -939,6 +983,10 @@ bool dce110_link_encoder_validate_output_with_stream(
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
@@ -969,6 +1017,10 @@ void dce110_link_encoder_hw_init(
 	cntl.coherent = false;
 	cntl.hpd_sel = enc110->base.hpd_source;
 
+	/* The code below is only applicable to encoders with a digital transmitter. */
+	if (enc110->base.transmitter == TRANSMITTER_UNKNOWN)
+		return;
+
 	if (enc110->base.connector.id == CONNECTOR_ID_EDP)
 		cntl.signal = SIGNAL_TYPE_EDP;
 
@@ -1034,6 +1086,8 @@ void dce110_link_encoder_setup(
 		/* DP MST */
 		REG_UPDATE(DIG_BE_CNTL, DIG_MODE, 5);
 		break;
+	case SIGNAL_TYPE_RGB:
+		break;
 	default:
 		ASSERT_CRITICAL(false);
 		/* invalid mode ! */
@@ -1282,6 +1336,24 @@ void dce110_link_encoder_disable_output(
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
+	/* The code below only applies to connectors that support digital signals. */
+	if (enc->transmitter == TRANSMITTER_UNKNOWN)
+		return;
+
 	if (!dce110_is_dig_enabled(enc)) {
 		/* OF_SKIP_POWER_DOWN_INACTIVE_ENCODER */
 		return;
@@ -1726,6 +1798,7 @@ void dce60_link_encoder_construct(
 	enc110->base.connector = init_data->connector;
 
 	enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
+	enc110->base.analog_engine = init_data->analog_engine;
 
 	enc110->base.features = *enc_features;
 
@@ -1749,6 +1822,11 @@ void dce60_link_encoder_construct(
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
@@ -1787,6 +1865,13 @@ void dce60_link_encoder_construct(
 		enc110->base.preferred_engine = ENGINE_ID_DIGG;
 	break;
 	default:
+		if (init_data->analog_engine != ENGINE_ID_UNKNOWN) {
+			/* The connector is analog-only, ie. VGA */
+			enc110->base.preferred_engine = init_data->analog_engine;
+			enc110->base.output_signals = SIGNAL_TYPE_RGB;
+			enc110->base.transmitter = TRANSMITTER_UNKNOWN;
+			break;
+		}
 		ASSERT_CRITICAL(false);
 		enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 261c70e01e33..c58b69bc319b 100644
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
@@ -215,10 +221,6 @@ bool dce110_link_encoder_validate_dvi_output(
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
index 54803fb7da67..075815e4041a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -225,6 +225,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(4),
 	link_regs(5),
 	link_regs(6),
+	{ .DAC_ENABLE = mmDAC_ENABLE },
 };
 
 #define stream_enc_regs(id)\
@@ -630,7 +631,20 @@ static struct link_encoder *dce100_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
+		return NULL;
+
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+		dce110_link_encoder_construct(enc110,
+			enc_init_data,
+			&link_enc_feature,
+			&link_enc_regs[ENGINE_ID_DACA],
+			NULL,
+			NULL);
+		return &enc110->base;
+	}
+
+	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 8862365d3082..5fa84c622282 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -240,7 +240,9 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(2),
 	link_regs(3),
 	link_regs(4),
-	link_regs(5)
+	link_regs(5),
+	{0},
+	{ .DAC_ENABLE = mmDAC_ENABLE },
 };
 
 #define stream_enc_regs(id)\
@@ -726,7 +728,20 @@ static struct link_encoder *dce60_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
+		return NULL;
+
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+		dce110_link_encoder_construct(enc110,
+			enc_init_data,
+			&link_enc_feature,
+			&link_enc_regs[ENGINE_ID_DACA],
+			NULL,
+			NULL);
+		return &enc110->base;
+	}
+
+	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 7091e69cbe98..902209a17fe4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -241,6 +241,7 @@ static const struct dce110_link_enc_registers link_enc_regs[] = {
 	link_regs(4),
 	link_regs(5),
 	link_regs(6),
+	{ .DAC_ENABLE = mmDAC_ENABLE },
 };
 
 #define stream_enc_regs(id)\
@@ -732,7 +733,20 @@ static struct link_encoder *dce80_link_encoder_create(
 		kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc110 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+	if (!enc110)
+		return NULL;
+
+	if (enc_init_data->connector.id == CONNECTOR_ID_VGA) {
+		dce110_link_encoder_construct(enc110,
+			enc_init_data,
+			&link_enc_feature,
+			&link_enc_regs[ENGINE_ID_DACA],
+			NULL,
+			NULL);
+		return &enc110->base;
+	}
+
+	if (enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.51.0


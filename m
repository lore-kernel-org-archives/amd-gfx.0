Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFDCC87FC5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBA110E800;
	Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fy4vpVGF";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A20C10E80D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:32 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso4049353f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286310; x=1753891110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Z/mBnF2C++8Y28ugjpgFUVT2mPtu84eg9HV77jgOw4=;
 b=Fy4vpVGFLM1067BgRcTjeGQ6eru1AJwRbtfzGSHDdOXFzh6jUlxEAJfUGIvGIkJjGD
 kBIHldm9w1TpQZ+a3oHkBb6YP4hDaGZOIa4U2mnct1K6q+rPk1Z6MG5TlCvb8JgxLyy/
 hFN81qQpfUQQiq0Ri8VVqan/d/MNpvd06176o2/MaEHpHsDhJ2FyWZ9qEvSVR0wF/JGW
 iCa9PxdvfRJvFJ3CGqia0nPQ2PGdOdPO89MnFv4f5QHXiQJ/Vc4ed1Zgrk3Lw3NBUoqQ
 jfDOSrfwfktu31d61Rz7TRYW5fNTUv1p37RYhz4CiOMZIA9WY4xRgWiQKN2b+5aTNpDU
 q1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286310; x=1753891110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Z/mBnF2C++8Y28ugjpgFUVT2mPtu84eg9HV77jgOw4=;
 b=B0cHUVvEgEU7BqHEsjlPFqosPZ30Qc80whGn9KfwUUa/OQDm6JH2vjz0y+ovrig/Xs
 bS7sKQRm9j9OQ51pLoAsKAK+bm0MbVfpAXoazcgpDGc+E4nGzPi9nNPG9YPOvaYE2Xa3
 GvrvTL68P/TUebCIBzkK4JI+FWbpQE1wvfzwoRJ9JrdTVbQ4Q2Iyc3LJImSwmp0QsQwf
 APi92649TsSFKjQdL+ZhIPAM2e0viqVi5lXzourM4KVLPvg275Ju24FE1dOyMoRr6bAE
 gCZJoxV6tM0cp8fME1gytKFFUVS0DPcbwp6dgMdx3YptOewGY003hNrgr4gg3x6cFlFT
 11+w==
X-Gm-Message-State: AOJu0Yy8ljt8mkyE8/Hs2YHAvLr1XjcPPLniG9sw2fDSLFIk0ZskpQBH
 Frwj5P8Atr2DMX7UGwIr0N+kUwRbvhFCDx8LCiGnUZseeILq1UyFHzJjJsKK0w==
X-Gm-Gg: ASbGncv26QPI9v83dxG1UxahGF4tw072a0M8FThc6T8n0wNKpoiCKzGgIHbG5i0RP0X
 wnZ4vEgil0/TUwLszSnauGiKj8fEqYPezUDMkwp3tsuXjCVwYk1tu6fEgQCPEFn6Jq2n+IqY0ie
 XYkvWfTp8OyxN/AQ1qPT6EeiyWnrqzMm/qMwgBahRRrh8ZwbOuRRu0smpiAYowxD6Ka2b55KqpL
 /9hCW6Jnys14/NnK/hmu0FHuzk0t3VW8CA1EVawPisWZs7KNmd7bFutRCOGeVBDRx93exGiGgB9
 8YgRvVg72qnw+0Wft8XBhfz73aAyTqBkq5CGCDk70CPKieUd86Ha7tZs9JO30/m2r2eCK88m/R6
 OUS12zQBzicnyZXLfPq5lPJVo/btySvKWTrohU6WkeAO4y729nHwH92+/07LVlyg/C3cgDYHKsK
 sxUA2EWVpr9kioHIjO3CkfMnvvg8GGMTUCvLuR
X-Google-Smtp-Source: AGHT+IHnvw2IfKvH09/EbxZOfjyOHZbOBbALxLER1F4qf16UeiVqeFV5JR0DrFib6pg9/f/YQbUU7g==
X-Received: by 2002:a05:6000:22ca:b0:3b3:9ca4:ac8e with SMTP id
 ffacd0b85a97d-3b768f1f20cmr3140902f8f.44.1753286310384; 
 Wed, 23 Jul 2025 08:58:30 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 13/20] drm/amd/display: Add analog link detection
Date: Wed, 23 Jul 2025 17:58:06 +0200
Message-ID: <20250723155813.9101-14-timur.kristof@gmail.com>
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

Analog displays typically have a DDC connection which can be
used by the GPU to read EDID. This commit adds the capability
to probe analog displays using DDC, reading the EDID header and
deciding whether the analog link is connected based on the data
that was read.

As a reference, I used the following functions:
amdgpu_connector_vga_detect
amdgpu_display_ddc_probe

DAC load detection will be implemented in a separate commit.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/dc/link/hwss/link_hwss_dio.c  | 16 ++--
 .../drm/amd/display/dc/link/link_detection.c  | 80 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +
 .../drm/amd/display/dc/link/link_factory.c    |  3 +
 4 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index f3470716734d..b9ebb992dc98 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -58,8 +58,9 @@ void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 		return;
 	}
 
-	link_enc->funcs->connect_dig_be_to_fe(link_enc,
-			pipe_ctx->stream_res.stream_enc->id, true);
+	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		link_enc->funcs->connect_dig_be_to_fe(link_enc,
+				pipe_ctx->stream_res.stream_enc->id, true);
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(pipe_ctx->stream->link,
 				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
@@ -98,10 +99,13 @@ void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 	if (stream_enc->funcs->enable_stream)
 		stream_enc->funcs->enable_stream(stream_enc,
 				pipe_ctx->stream->signal, false);
-	link_enc->funcs->connect_dig_be_to_fe(
-			link_enc,
-			pipe_ctx->stream_res.stream_enc->id,
-			false);
+
+	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		link_enc->funcs->connect_dig_be_to_fe(
+				link_enc,
+				pipe_ctx->stream_res.stream_enc->id,
+				false);
+
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(
 				pipe_ctx->stream->link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 827b630daf49..fcabc83464af 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -942,6 +942,12 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			break;
 		}
 
+		case SIGNAL_TYPE_RGB: {
+			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
+			sink_caps.signal = SIGNAL_TYPE_RGB;
+			break;
+		}
+
 		case SIGNAL_TYPE_LVDS: {
 			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
 			sink_caps.signal = SIGNAL_TYPE_LVDS;
@@ -1133,9 +1139,17 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				sink = prev_sink;
 				prev_sink = NULL;
 			}
-			query_hdcp_capability(sink->sink_signal, link);
+
+			if (!sink->edid_caps.analog)
+				query_hdcp_capability(sink->sink_signal, link);
 		}
 
+		/* DVI-I connector connected to analog display. */
+		if ((link->link_enc->connector.id == CONNECTOR_ID_DUAL_LINK_DVII ||
+		     link->link_enc->connector.id == CONNECTOR_ID_SINGLE_LINK_DVII) &&
+			sink->edid_caps.analog)
+			sink->sink_signal = SIGNAL_TYPE_RGB;
+
 		/* HDMI-DVI Dongle */
 		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
 		    !sink->edid_caps.edid_hdmi)
@@ -1228,6 +1242,64 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	return true;
 }
 
+/**
+ * Evaluates whether an EDID header is acceptable,
+ * for the purpose of determining a connection with a display.
+ */
+static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
+{
+	int edid_header_score = 0;
+	int i;
+
+	for (i = 0; i < 8; ++i)
+		edid_header_score += edid_header[i] == ((i == 0 || i == 7) ? 0x00 : 0xff);
+
+	return edid_header_score >= 6;
+}
+
+/**
+ * Tries to detect a connected display by probing the DDC
+ * and reading the EDID header.
+ * The probing is considered successful if we receive a
+ * reply from the DDC over I2C and the EDID header matches.
+ */
+static bool link_detect_ddc_probe(struct dc_link *link)
+{
+	if (!link->ddc)
+		return false;
+
+	uint8_t edid_header[8] = {0};
+	bool ddc_probed = i2c_read(link->ddc, 0x50, edid_header, sizeof(edid_header));
+
+	if (!ddc_probed)
+		return false;
+
+	if (!link_detect_evaluate_edid_header(edid_header))
+		return false;
+
+	return true;
+}
+
+/**
+ * Determines if there is an analog sink connected.
+ */
+static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *type)
+{
+	/* Don't care about connectors that don't support an analog signal. */
+	if (link->link_enc->connector.id != CONNECTOR_ID_VGA &&
+		link->link_enc->connector.id != CONNECTOR_ID_SINGLE_LINK_DVII &&
+		link->link_enc->connector.id != CONNECTOR_ID_DUAL_LINK_DVII)
+		return false;
+
+	if (link_detect_ddc_probe(link)) {
+		*type = dc_connection_single;
+		return true;
+	}
+
+	*type = dc_connection_none;
+	return true;
+}
+
 /*
  * link_detect_connection_type() - Determine if there is a sink connected
  *
@@ -1238,6 +1310,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *type)
 {
 	uint32_t is_hpd_high = 0;
+	bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
 
 	if (link->connector_signal == SIGNAL_TYPE_LVDS) {
 		*type = dc_connection_single;
@@ -1261,6 +1334,8 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		return true;
 	}
 
+	if (!supports_hpd)
+		return link_detect_analog(link, type);
 
 	if (!query_hpd_status(link, &is_hpd_high))
 		goto hpd_gpio_failure;
@@ -1269,6 +1344,9 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		*type = dc_connection_single;
 		/* TODO: need to do the actual detection */
 	} else {
+		if (link_detect_analog(link, type))
+			return true;
+
 		*type = dc_connection_none;
 		if (link->connector_signal == SIGNAL_TYPE_EDP) {
 			/* eDP is not connected, power down it */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index d6b7347c6c11..ac25d89a4148 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2256,6 +2256,9 @@ static enum dc_status enable_link(
 		enable_link_lvds(pipe_ctx);
 		status = DC_OK;
 		break;
+	case SIGNAL_TYPE_RGB:
+		status = DC_OK;
+		break;
 	case SIGNAL_TYPE_VIRTUAL:
 		status = enable_link_virtual(pipe_ctx);
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 71c10a1261b9..c9725fd316f6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -555,6 +555,9 @@ static bool construct_phy(struct dc_link *link,
 	case CONNECTOR_ID_DUAL_LINK_DVII:
 		link->connector_signal = SIGNAL_TYPE_DVI_DUAL_LINK;
 		break;
+	case CONNECTOR_ID_VGA:
+		link->connector_signal = SIGNAL_TYPE_RGB;
+		break;
 	case CONNECTOR_ID_DISPLAY_PORT:
 	case CONNECTOR_ID_MXM:
 	case CONNECTOR_ID_USBC:
-- 
2.50.1


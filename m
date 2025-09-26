Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9866ACAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C39210EAC3;
	Fri, 26 Sep 2025 18:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lV77j3wz";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF0310EAC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:28 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b57de3f63c8so910766a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909808; x=1759514608; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9V+g1i9U3r8Ch72lE47nxZ/XFHPXlMfhhYaviLBOwg=;
 b=lV77j3wzJ7oaVuGr2OFIInWTFtq+DCMify8xKhLX8Ad7fWk+k3oedOMljAK3h9gMGZ
 X6nvDKWtD2KTHCc+yIhpmVO2fJ8bUTK9SeJJ0q/tw6BC/0Xis08uBNCJsCxJts4lhaCZ
 OORCt9i8QNDJj4gT0KvCYSsh86xhR5DZszXnrl5Vs3fqUINoqRRoGAT+PXmanLO6QRnx
 MmAnZpv6fL2PLgPKZa2dDHRG68O0EG1gjU5/1WRIgSJDL33jV2qSsH6s0nuDsi78CdpE
 I34xfm9MNhqCY9eQe6ePC7yymfpZyuV8uaSJh5oJIRhKKDQHsTiG93J1/owm1vAsY0Bp
 2lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909808; x=1759514608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9V+g1i9U3r8Ch72lE47nxZ/XFHPXlMfhhYaviLBOwg=;
 b=sNScyNGJNwGXxRFBtHErRuNOug2vcUaA0mBpMhZTd/rzFo9oCigOF2yUN3jF1pFl3N
 qAcZvOxZPil2ttq363OrN9gQdwkT4QCGcx2rRdKnIFctVUlWIdWG+npXPwPGueIA+Jhy
 NIZbH2+Daq6gX7W+wITz1e/2C600nspcmn6UBbzmlwUUSHCjqmUvwwXeI7qV8bKfv/Q5
 8zaal3WHuRsLvmRmFtZUuic0cQIb4a0Ar+UoWlZBgO9Gh9RxVvuanWxdo5OlK6bgSahB
 QOn6h0mYXjNRiSTu6caBlXyo7mYSG5cJuPTD10ZmlZGZrIAnzzAo+wV/qWxIbTzdZrRz
 8gGA==
X-Gm-Message-State: AOJu0Yx7q9iR7CD1bJrl+LiGHY5Qs+NJr5+1oq3Job/ZqClk/YwpcFXN
 MIZoKpmlh9GUQTXQcHofMiahNlTW206RvOSU9UBN2yQdgLgmTSWr9AdyuNPX4Q==
X-Gm-Gg: ASbGnctXJqy8RMrBQ3Zd4EA+oYETKcBR7sQFDLsKyu2JkDSuwV9GVHJlHH38VXMOscR
 FJ0DBvNeAKIjy3GrNoe45o/xHSOjRo2izJguY4odlKVoN4z4SQORCMl059m5k8xXQkjU4fiPTvl
 BYxzAaC6k04yuPO0JP+Rk+O5gyaEKD8/HQZpOTvU4jcbmaAzPwM2N2NV6vc6L8JvFy50sAJWhFt
 MafyeEm12veWMm5Oc+5uEL9pYy5omlf9hqf8a6KcA+/SQGe66RTpEm0bNAaoy4ikiAUk+LLitsg
 lZu6eHO+1eWIwqdrdInnSXCvQecO69RDN9mpUr5Ran86KpKkKrAiw2gfDZOslmGQkB0awVNGmjm
 UJHM7hZBcL6KP3PAux2IZRwyI002pipaA5EyN9XfQgDxLId5Nt8yPGid8X4BQJsXYD274qsd34H
 BkSmo2m36+wXH8nqA4sK8=
X-Google-Smtp-Source: AGHT+IHTHtasvgxgD80qyKjiBfy99P+DikgNy6pJqJjo28tt6A+Xkc6zl/hsEtdDAa4MUxQ1nHlnGA==
X-Received: by 2002:a17:902:ebc4:b0:262:4878:9dff with SMTP id
 d9443c01a7336-27ed4a09347mr89547515ad.12.1758909808342; 
 Fri, 26 Sep 2025 11:03:28 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 14/23] drm/amd/display: Add analog link detection (v2)
Date: Fri, 26 Sep 2025 20:01:54 +0200
Message-ID: <20250926180203.16690-15-timur.kristof@gmail.com>
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

Analog displays typically have a DDC connection which can be
used by the GPU to read EDID. This commit adds the capability
to probe analog displays using DDC, reading the EDID header and
deciding whether the analog link is connected based on the data
that was read.

Note that VGA has no HPD (hotplug detection), so we need to
to do analog link detection for VGA before checking HPD.

In case of DVI-I, while the connector supports HPD, not all
analog cables connect the HPD pins, so we can't rely on HPD
either.

For reference, see the legacy display code:
amdgpu_connector_vga_detect
amdgpu_display_ddc_probe

DAC load detection will be implemented in a separate commit.

v2:
Fix crash / black screen on newer GPUs during link detection.
Ignore HPD pin for analog connectors.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/dc/link/hwss/link_hwss_dio.c  | 16 ++--
 .../drm/amd/display/dc/link/link_detection.c  | 86 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +
 .../drm/amd/display/dc/link/link_factory.c    |  3 +
 4 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 80344cbd1f99..befa67b2b2ae 100644
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
index 2ab8ee7f42c1..2ad4862ad659 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -858,6 +858,48 @@ static void verify_link_capability(struct dc_link *link, struct dc_sink *sink,
 		verify_link_capability_non_destructive(link);
 }
 
+/**
+ * link_detect_evaluate_edid_header() - Evaluate if an EDID header is acceptable.
+ *
+ * Evaluates an 8-byte EDID header to check if it's good enough
+ * for the purpose of determining whether a display is connected
+ * without reading the full EDID.
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
+ * link_detect_ddc_probe() - Probe the DDC to see if a display is connected.
+ *
+ * Detect whether a display is connected to DDC without reading full EDID.
+ * Reads only the EDID header (the first 8 bytes of EDID) from DDC and
+ * evaluates whether that matches.
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
 /*
  * detect_link_and_local_sink() - Detect if a sink is attached to a given link
  *
@@ -942,6 +984,12 @@ static bool detect_link_and_local_sink(struct dc_link *link,
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
@@ -1135,9 +1183,17 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				sink = prev_sink;
 				prev_sink = NULL;
 			}
-			query_hdcp_capability(sink->sink_signal, link);
+
+			if (!sink->edid_caps.analog)
+				query_hdcp_capability(sink->sink_signal, link);
 		}
 
+		/* DVI-I connector connected to analog display. */
+		if ((link->link_id.id == CONNECTOR_ID_DUAL_LINK_DVII ||
+		     link->link_id.id == CONNECTOR_ID_SINGLE_LINK_DVII) &&
+			sink->edid_caps.analog)
+			sink->sink_signal = SIGNAL_TYPE_RGB;
+
 		/* HDMI-DVI Dongle */
 		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
 		    !sink->edid_caps.edid_hdmi)
@@ -1234,6 +1290,23 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	return true;
 }
 
+/**
+ * link_detect_analog() - Determines if an analog sink is connected.
+ */
+static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *type)
+{
+	/* Don't care about connectors that don't support an analog signal. */
+	ASSERT(dc_connector_supports_analog(link->link_id.id));
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
@@ -1250,6 +1323,17 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 		return true;
 	}
 
+	/* Ignore the HPD pin (if any) for analog connectors.
+	 * Instead rely on DDC.
+	 *
+	 * - VGA connectors don't have any HPD at all.
+	 * - Some DVI-A cables don't connect the HPD pin.
+	 * - Some DVI-A cables pull up the HPD pin.
+	 *   (So it's high even when no display is connected.)
+	 */
+	if (dc_connector_supports_analog(link->link_id.id))
+		return link_detect_analog(link, type);
+
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/*in case it is not on*/
 		if (!link->dc->config.edp_no_power_sequencing)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index c92d46c25f8c..6e16d8419fd9 100644
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
index 4dbe88d17a11..b6990088b8b7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -583,6 +583,9 @@ static bool construct_phy(struct dc_link *link,
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
2.51.0


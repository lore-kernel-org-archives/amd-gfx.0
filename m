Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D56CAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C20010EAC9;
	Fri, 26 Sep 2025 18:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyTMzpEF";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB3610EAC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:59 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-27eed7bdfeeso16119235ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909839; x=1759514639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2Zy8gREh6vtbo6EoGyUoWhIZzeRjqOxLEGOM8kLMns=;
 b=iyTMzpEFtxPhvVGn9LjIxUbuIEhKyhM6Tx84a7jhQDAOrEUOzj8bVltlK/mJkogW9v
 psvXDUoYI7I+4Lu8Fw7PJe7AVQvj5pktEQQ6LuP7PsQWGuLh35DGpEF8KtsVUeS7lp0e
 SC7b40pQ9tMhDPSk0XhvRcfBqPYvVui3ehOyuw5Nb9AanqTlVhXnO2QphR+XV7s/pImk
 icoR5RGp9tGX2eVMomweUw3ht5RX5Y25rIT4Y9UTlwiBlc2pFFdqoqOoTquqHKlbvW8H
 7BtxTjVi49aJcU+hXDUPzAXR8ddBjybjJagjSImlplChSRQBNyt0zFr5i/M5wvhK9H12
 TvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909839; x=1759514639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2Zy8gREh6vtbo6EoGyUoWhIZzeRjqOxLEGOM8kLMns=;
 b=C3ipA5Xv72OepZZVlxh5XA8YkOU8CkvNF3jjpkJp6aKp8uM5oaGmptJLpnBYwBOkY9
 v1OU3joVaMrbUf3/ZAPLBEAsWajlONp92hXgOvn9489IHa/lOTR2y/Lc3CO5fRfLNFDv
 XkeYeBlHuUxPMJYrilTCAtPOCU3arEVuS3q2gOSlOeftAXA2FfIxJ8hfsT9ubY+B+s76
 SAN5RX3pzAgasrgWrQjnEM1bcTy7Gn0JuLNZCw8i+3YVIG8eqgUbg2mfS0dATThy1Gwr
 +Gvlp3Bh0lSeybDc/ZfK2siGfX7sqJ2eYyarwBEGda42kFAJdAiz7dXo2f9mlNFt27ZA
 JwFg==
X-Gm-Message-State: AOJu0YxXsDe3tmVItMCwwpVNR5poDfRA5B0ogq9HX0VPeEKzZ2X4lil/
 s4IJAG4nYgAle7yNO+SIX5/iI6R5xKldSm8OlIh+YzQaaQdOy1LDpAI9JqhueA==
X-Gm-Gg: ASbGncsIRCtWJuFNGFWzWcH8T+1r+ypiFdG862q5dZ8SmSzhhFki5EVpMUs3thSxpqo
 Vqa9arSDgN5u0HwisaC+QnS7F2rsNl6+AkENVRWKUmg8V3LP6Phq+2wln131k5ySceUb3wZh61c
 PGleSqLy4l3sA8y83QraxYC/Nv1qGgvN5AqyDzYy/kBKcAnfkjnFPj5GkvWjLKKDufhq49tr6ra
 +AA5x1hPSgQALTdecP7wh2D8u6HoPU/p0hIRjCYV1uvbfNe6LRS2XWqI0X2lMamVsfqg134TwEk
 8qKwWPsvB976ur2n+aL+KRJw4fGDVL2vEhT9x/ineAB90E2sXiwlp4dGwJ++wRixv8BqGpOqUN4
 5Rmw/YJT6xTcrMsKjYxEMdvmTpTbtPJTaluviRpFkh9THUKm1twWy9uI9i5ccSDg7xoIfWRm6PL
 OnKGHA1U8gAkx/Odw1Ozc=
X-Google-Smtp-Source: AGHT+IEv7BucDiRcnGs1K9lOmXeYDCDekyD/Sz3dOqhSD9Q6qtXZjhRjQHn1g1HBlS6Lbce3gPO/CA==
X-Received: by 2002:a17:902:c951:b0:273:ef4c:60f3 with SMTP id
 d9443c01a7336-2818434d82emr3951585ad.4.1758909839280; 
 Fri, 26 Sep 2025 11:03:59 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:59 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 20/23] drm/amd/display: Use DAC load detection on analog
 connectors (v2)
Date: Fri, 26 Sep 2025 20:02:00 +0200
Message-ID: <20250926180203.16690-21-timur.kristof@gmail.com>
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

This feature is useful for analog connections without EDID:
- Really old monitors with a VGA connector
- Cheap DVI/VGA adapters that don't connect DDC pins

When a connection is established through DAC load detection,
the driver is supposed to fill in the supported modes for the
display, which we already do in amdgpu_dm_connector_get_modes.

Also, because the load detection causes visible glitches, do not
attempt to poll the connector again after it was detected this
way. Note that it will still be polled after sleep/resume or
when force is enabled, which is okay.

v2:
Add dc_connection_dac_load connection type.
Properly release sink when no display is connected.
Don't print error when EDID isn't read from an analog display.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  3 +-
 .../drm/amd/display/dc/link/link_detection.c  | 61 ++++++++++++++++++-
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 07cfd9cae0df..09248ac2f37d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7145,6 +7145,16 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 	enum dc_connection_type conn_type = dc_connection_none;
 	enum drm_connector_status status = connector_status_disconnected;
 
+	/* When we determined the connection using DAC load detection,
+	 * do NOT poll the connector do detect disconnect because
+	 * that would run DAC load detection again which can cause
+	 * visible visual glitches.
+	 *
+	 * Only allow to poll such a connector again when forcing.
+	 */
+	if (!force && link->local_sink && link->type == dc_connection_dac_load)
+		return connector->status;
+
 	mutex_lock(&aconnector->hpd_lock);
 
 	if (dc_link_detect_connection_type(aconnector->dc_link, &conn_type) &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d948cdb98ea8..e0157a91a950 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -352,7 +352,8 @@ enum dc_connection_type {
 	dc_connection_none,
 	dc_connection_single,
 	dc_connection_mst_branch,
-	dc_connection_sst_branch
+	dc_connection_sst_branch,
+	dc_connection_dac_load
 };
 
 struct dc_csc_adjustments {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 2ad4862ad659..da54f696dafd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -900,6 +900,37 @@ static bool link_detect_ddc_probe(struct dc_link *link)
 	return true;
 }
 
+/**
+ * link_detect_dac_load_detect() - Performs DAC load detection.
+ *
+ * Load detection can be used to detect the presence of an
+ * analog display when we can't read DDC. This causes a visible
+ * visual glitch so it should be used sparingly.
+ */
+static bool link_detect_dac_load_detect(struct dc_link *link)
+{
+	struct dc_bios *bios = link->ctx->dc_bios;
+	struct link_encoder *link_enc = link->link_enc;
+	enum engine_id engine_id = link_enc->preferred_engine;
+	enum dal_device_type device_type = DEVICE_TYPE_CRT;
+	enum bp_result bp_result;
+	uint32_t enum_id;
+
+	switch (engine_id) {
+	case ENGINE_ID_DACB:
+		enum_id = 2;
+		break;
+	case ENGINE_ID_DACA:
+	default:
+		engine_id = ENGINE_ID_DACA;
+		enum_id = 1;
+		break;
+	}
+
+	bp_result = bios->funcs->dac_load_detection(bios, engine_id, device_type, enum_id);
+	return bp_result == BP_RESULT_OK;
+}
+
 /*
  * detect_link_and_local_sink() - Detect if a sink is attached to a given link
  *
@@ -1114,7 +1145,30 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			DC_LOG_ERROR("Partial EDID valid, abandon invalid blocks.\n");
 			break;
 		case EDID_NO_RESPONSE:
+			/* Analog connectors without EDID:
+			 * - old monitor that actually doesn't have EDID
+			 * - cheap DVI-A cable or adapter that doesn't connect DDC
+			 */
+			if (dc_connector_supports_analog(link->link_id.id)) {
+				/* If we didn't do DAC load detection yet, do it now
+				 * to verify there really is a display connected.
+				 */
+				if (link->type != dc_connection_dac_load &&
+					!link_detect_dac_load_detect(link)) {
+					if (prev_sink)
+						dc_sink_release(prev_sink);
+					link_disconnect_sink(link);
+					return false;
+				}
+
+				DC_LOG_INFO("%s detected analog display without EDID\n", __func__);
+				link->type = dc_connection_dac_load;
+				sink->edid_caps.analog = true;
+				break;
+			}
+
 			DC_LOG_ERROR("No EDID read.\n");
+
 			/*
 			 * Abort detection for non-DP connectors if we have
 			 * no EDID
@@ -1303,6 +1357,11 @@ static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *ty
 		return true;
 	}
 
+	if (link_detect_dac_load_detect(link)) {
+		*type = dc_connection_dac_load;
+		return true;
+	}
+
 	*type = dc_connection_none;
 	return true;
 }
@@ -1324,7 +1383,7 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 	}
 
 	/* Ignore the HPD pin (if any) for analog connectors.
-	 * Instead rely on DDC.
+	 * Instead rely on DDC and DAC.
 	 *
 	 * - VGA connectors don't have any HPD at all.
 	 * - Some DVI-A cables don't connect the HPD pin.
-- 
2.51.0


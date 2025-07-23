Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9A7C83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0FC810E804;
	Wed, 23 Jul 2025 15:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XWnjAvME";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D431D10E811
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:35 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b611665b96so3966127f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286314; x=1753891114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLIBQDuIzKYlNnxdeBudcHgqDxj8SdlbZbP43YviF7I=;
 b=XWnjAvMEQCEApibMaETsueGlkauUETZ9gOUHay/MX573P/eWDKM/v3NfYnvenZfNAV
 MfnJe6SEiWM9swnSUK+0mDRXHjyQDy4gt7aUQWFfB8RJFyu7ZA5MgvKjEvaGlKBntG0V
 dT1VcVzbvPaEBMkgGeyQFe3/7xZzZS1Bhq9J7+S4bjIJkTbiOlEPJdNyjo1YiFTVGNRX
 vCMM1wqT7lVFZDJqpMuov69VsRj0id+tzxavx3ZKdgqLmlHHU9A23t/4nuM6ZFdPQFbH
 1+7nUtrxdKsKVf/Yj5DsD7UzdEacgfbjWtlAkQocKtsmoWPFxvFrpZWo8sR0hzHC1EEv
 irPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286314; x=1753891114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLIBQDuIzKYlNnxdeBudcHgqDxj8SdlbZbP43YviF7I=;
 b=GqJpsB/vG7ZSWpWimByoEVzfCvy2X9OvsboTKFsOMcAn7XpjtCyM8h9pOMjA5CtuF0
 YnNQazpBiSg/4eP8zDHCS/32BcMQw44Ctt1Cnlzl6wVOvabBqoJcj457ANlFCB4BlG3G
 hCqsWxKj2tNbv/nz2O3N8kuMwHboncPKVs8aOrFTeQrO+d2UEtIY+BetY+xsZnfDMVbA
 Z5sN4/YEX+lc1BQEd5pdJiBSZRST4/zGFGB8WHEAbAd4XONhdj7MF0NYrzvU1h42jgzB
 ywQ67zhhr7ib5U6rqHmHRyBNM9tw14R57Kiq+YN3lXgp8gqq4R1ulullM4h4iyB1j7wf
 Hsmg==
X-Gm-Message-State: AOJu0YwL2AHfsY9s7/MwEUZFp/GYkFy271aWeM9F4ZzTJ328xfPJzj6w
 zMFvfXhepGoM+bbZWJPGnRTQgvtvQXhb8hVr7vLEvdtZhb+H79wHZuAYce+2jQ==
X-Gm-Gg: ASbGncsu71n1saD0+iFRWfhObBwzk+bxZE7mf8USc5rdF4E5Lp0NoLKLXwTEj4gKyu0
 K3vMd4dYvu5IRtrBAFOPJWGVPE3aG3XCE/kZp61+UIUxoM8UZYtXwYoepPoArA8cLLDNY05mKro
 XeGcfMTtUE+xINqdmnol43NshefkEGxgAJZxC3mTdY7v/9Panex86iJYCYFn6TiTqQV3ClDxHfQ
 LdZLdF1Ky8fMRQbatppaZccseBNE5+ElzN6qvtxxuP3ythgEC3SYARfOGFtKJTPPgNsQnOdu6BP
 39aucG/NInQTjep1N9UrGJL4SHmTjUzzB+aIOGCxxLMvTFUCQcyZqqFGyI6s6x2o8XBExW/bGtf
 Ks+en0T9pEoj/32bO0vPRECEoQdqTfwEI1RMY9n35eoH9QGzqlV28W5hQJWc167VlJzMjX1llW+
 BtT/U/JgW18X+mQktiCB9NUGY2mQ==
X-Google-Smtp-Source: AGHT+IEzfcf1kQBMXP5Gn40mJBdKjTNW2uDBrrRryKiJslwb8AX0vpHxRne69i0CUGcWmp9KjQM56w==
X-Received: by 2002:a05:6000:230b:b0:3b6:938:86b7 with SMTP id
 ffacd0b85a97d-3b768ef5b8amr3039846f8f.35.1753286314122; 
 Wed, 23 Jul 2025 08:58:34 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 18/20] drm/amd/display: Use DAC load detection on analog
 connectors
Date: Wed, 23 Jul 2025 17:58:11 +0200
Message-ID: <20250723155813.9101-19-timur.kristof@gmail.com>
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

This feature is useful for analog connections without EDID:
- Really old monitors with a VGA connector
- Cheap DVI/VGA adapters that don't connect DDC pins

When a connection is established through DAC load detection,
the driver is supposed to fill in the supported modes for the
display, which we already do in amdgpu_dm_connector_get_modes.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++
 .../drm/amd/display/dc/link/link_detection.c  | 43 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 13823469fa7c..49ee516dc83d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7077,6 +7077,18 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 	enum dc_connection_type conn_type = dc_connection_none;
 	enum drm_connector_status status = connector_status_disconnected;
 
+	/* When the EDID is missing on an analog connector, that means
+	 * we determined the connection using DAC load detection.
+	 * In this case do NOT poll the connector do detect disconnect
+	 * because that would run DAC load detection again which can cause
+	 * visible visual glitches.
+	 *
+	 * Only allow to poll such a connector again when forcing.
+	 */
+	if (!force && link->local_sink && link->local_sink->edid_caps.analog &&
+		!aconnector->drm_edid)
+		return connector->status;
+
 	mutex_lock(&aconnector->hpd_lock);
 
 	if (dc_link_detect_connection_type(aconnector->dc_link, &conn_type) &&
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index fcabc83464af..6dd96e2797f4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1073,6 +1073,20 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			break;
 		case EDID_NO_RESPONSE:
 			DC_LOG_ERROR("No EDID read.\n");
+
+			/* Analog connectors without EDID.
+			 * This can be an old monitor that actually doesn't have EDID,
+			 * or could be a cheap DVI/VGA adapter that doesn't connect DDC,
+			 * and therefore we can't read the EDID.
+			 */
+			if (link->link_enc->connector.id == CONNECTOR_ID_VGA ||
+				link->link_enc->connector.id == CONNECTOR_ID_DUAL_LINK_DVII ||
+				link->link_enc->connector.id == CONNECTOR_ID_SINGLE_LINK_DVII) {
+				DC_LOG_INFO("%s detected analog display without EDID\n", __func__);
+				sink->edid_caps.analog = true;
+				break;
+			}
+
 			/*
 			 * Abort detection for non-DP connectors if we have
 			 * no EDID
@@ -1280,6 +1294,30 @@ static bool link_detect_ddc_probe(struct dc_link *link)
 	return true;
 }
 
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
 /**
  * Determines if there is an analog sink connected.
  */
@@ -1296,6 +1334,11 @@ static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *ty
 		return true;
 	}
 
+	if (link_detect_dac_load_detect(link)) {
+		*type = dc_connection_single;
+		return true;
+	}
+
 	*type = dc_connection_none;
 	return true;
 }
-- 
2.50.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D48CD1951B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06D410E4B0;
	Mon, 26 Jan 2026 21:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YilhPoEK";
	dkim-atps=neutral
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F39A10E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:52 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so2873987f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461731; x=1770066531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jygu6aHsbVWbHUiEmQ5H2V6CbHm+/6rIUR05sU7yXck=;
 b=YilhPoEKvXIq7IaysGufvXENeGQWXR78P+B3pI6PvzYBbBuyJSeUX6MpnqWT7f7MPY
 duPZxv4049PlNFjLA3SrJrW9dWotMGmeqYqVKKvgMuyhzym1a+YKGSFadqOsS1rilX0v
 qyM6P9Y5bFk80OJ37CxQ6w35CH1GkwXD4eOpiXQOOoyJVBPiufmbiM67ahu2o8x3Hlr+
 +0kMUqHdeTzlvpVz8eoFBSwFs8HUuDqJ7DFq4Pp1ueDByRSgXrBZJmkNBq0gzIXIHsWY
 3o9nhwLExwiFQ6WlM7i5OakbG/3sc1schrTb7eIKgtcStiDudVEVbQ8bCHYM9c9bMBmA
 k9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461731; x=1770066531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jygu6aHsbVWbHUiEmQ5H2V6CbHm+/6rIUR05sU7yXck=;
 b=wyfrN7CcMCzpcY6IKM/njLhSDuQCSrI/jiyVFKnFKxmRkaen+1aYFzJly+JwO1nCkE
 S4vsFXJs20V9bHjdv5WyjfPTZ98bGDwkeer1V97Fk6GMXf2Yoyqe/qlvCU291ovvWADW
 JQltTVGZz49v48CAMGvSEJYEqU5QNdAIQ1DouaO2348sXIKhkinAgVe06dSODZRcYxEc
 0d4BkondAnSxtoubkIWAYoUqJvNTtXz8mnZ98aEd6423nNDwoja218v7Pp/KvSRFpgzJ
 0CHwxDlVD/3CApDGZEPJr0VJI+KJhJ20D2jZtmK3yE18F+RIc+TRN/Q7o8U3UwgJojSD
 I+nA==
X-Gm-Message-State: AOJu0YzE/voKjSOutdKD80ARU1FBwmq4g5YfzYiLFiHY/O0k4phpXBH5
 mJvkKoIMG4sRdbMAVW25zZs4qVlC69V64rwzew6jliU4k78ZJEWUIYdHAZGifW9B
X-Gm-Gg: AZuq6aJaAu8AxhhIRjVe8++TdYgL/nIEE4S08P6bpvDhPzP8NRrj8YqnyqY+L1E3StE
 siAJ4GYPw9AffAsIbSLB7q3ElsEQr+kyYgi+sWSE+1FFeb6ipLfcstjAtjFADf2d1JkPsv22iT8
 LbcSDnVLORQkwUVirv7c+SJCEMi0vRtiZJDplWx96Mqz5OZd8Ic/+fL/7hy1Gvne+6plVIK7ybe
 iGup6rM1XSG4W9VYZpGg9a4v5KgBAzN/raJkGx/ucOmOOSVZKnkKlCO3s9nwILgl1Bq9T0uD3f3
 Pv7KE2BB3Br384WM+u/sx0vcAdZNgIatoQb0PJ8n6B0cUPCZCifWiAr5pMqlXHPPshc+PMCnB9G
 fNZYW+PMamFjMwP9p+I5LlNB/P1r0PvuVnvxBGzW5J0Kiw8Wc4ynfWaK8aim2E4FK2Kb/Xeca1V
 vmpTfb2y9kHgXG8VqB3hL/b++7qAhkQuTETkilrDlvvJ69rko+j7RF
X-Received: by 2002:a05:6000:1841:b0:435:9770:9eb8 with SMTP id
 ffacd0b85a97d-435ca149ca1mr9766153f8f.25.1769461730895; 
 Mon, 26 Jan 2026 13:08:50 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:50 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/14] drm/amd/display: Use external DP bridge encoders
Date: Mon, 26 Jan 2026 22:08:35 +0100
Message-ID: <20260126210837.21885-13-timur.kristof@gmail.com>
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

Implement link creation for external DP bridge encoders
such as NUTMEG and TRAVIS used with CIK APUs such as
Kaveri for supporting analog and LVDS connections.
Typically found in CIK APU based laptops or on FM2
motherboards that have analog connectors.

When we query connector information from the VBIOS and
discover a connector using such an encoder, let's find the
real DisplayPort encoder and use that. Set the connector
signal type to DP, so the pre-existing DP code paths can
work with it without refactoring every signal type check
in the DC code base.

In the DM, make sure to report correct connector type and
also to initialize DP specifics such as the AUX channel.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 ++++--
 .../drm/amd/display/dc/link/link_factory.c    | 29 ++++++++++++++++++-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8b4c45ac3c05..bd76118fab19 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8539,6 +8539,12 @@ static int to_drm_connector_type(enum signal_type st, uint32_t connector_id)
 		return DRM_MODE_CONNECTOR_VGA;
 	case SIGNAL_TYPE_DISPLAY_PORT:
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		/* External DP bridges have a different connector type. */
+		if (connector_id == CONNECTOR_ID_VGA)
+			return DRM_MODE_CONNECTOR_VGA;
+		else if (connector_id == CONNECTOR_ID_LVDS)
+			return DRM_MODE_CONNECTOR_LVDS;
+
 		return DRM_MODE_CONNECTOR_DisplayPort;
 	case SIGNAL_TYPE_DVI_DUAL_LINK:
 	case SIGNAL_TYPE_DVI_SINGLE_LINK:
@@ -9211,8 +9217,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	    connector_type == DRM_MODE_CONNECTOR_HDMIB)
 		amdgpu_dm_initialize_hdmi_connector(aconnector);
 
-	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
-		|| connector_type == DRM_MODE_CONNECTOR_eDP)
+	if (dc_is_dp_signal(link->connector_signal))
 		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
 
 out_free:
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 5fbcf04c6251..7d9deb8b9c28 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -367,6 +367,18 @@ static enum transmitter translate_encoder_to_transmitter(
 	}
 }
 
+static bool encoder_is_external_dp(
+		struct graphics_object_id encoder)
+{
+	switch (encoder.id) {
+	case ENCODER_ID_EXTERNAL_NUTMEG:
+	case ENCODER_ID_EXTERNAL_TRAVIS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void link_destruct(struct dc_link *link)
 {
 	int i;
@@ -514,6 +526,13 @@ static bool construct_phy(struct dc_link *link,
 	 * so that we avoid initializing DDC and HPD, etc.
 	 */
 	bp_funcs->get_src_obj(bios, link->link_id, 0, &link_encoder);
+
+	if (encoder_is_external_dp(link_encoder)) {
+		/* External DP bridge encoders: find the actual link encoder and use that. */
+		link->ext_enc_id = link_encoder;
+		bp_funcs->get_src_obj(bios, link->ext_enc_id, 0, &link_encoder);
+	}
+
 	transmitter_from_encoder = translate_encoder_to_transmitter(link_encoder);
 	link_analog_engine = find_analog_engine(link, &enc_init_data.analog_encoder);
 
@@ -690,6 +709,13 @@ static bool construct_phy(struct dc_link *link,
 		goto create_fail;
 	}
 
+	/* For external DP bridge encoders:
+	 * Set the connector signal to DisplayPort so that they can work with
+	 * the pre-existing code paths for DP without a lot of code churn.
+	 */
+	if (link->ext_enc_id.id != ENCODER_ID_UNKNOWN)
+		link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
 	LINK_INFO("Connector[%d] description: signal: %s\n",
 		  init_params->connector_index,
 		  signal_type_to_string(link->connector_signal));
@@ -734,7 +760,8 @@ static bool construct_phy(struct dc_link *link,
 						      link->device_tag.dev_id))
 			continue;
 		if (link->device_tag.dev_id.device_type == DEVICE_TYPE_CRT &&
-		    link->connector_signal != SIGNAL_TYPE_RGB)
+		    link->connector_signal != SIGNAL_TYPE_RGB &&
+		    link->ext_enc_id.id == ENCODER_ID_UNKNOWN)
 			continue;
 		if (link->device_tag.dev_id.device_type == DEVICE_TYPE_LCD &&
 		    link->connector_signal == SIGNAL_TYPE_RGB)
-- 
2.52.0


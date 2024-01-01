Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22922C4706F
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jan 2024 18:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973A510E03D;
	Mon,  1 Jan 2024 18:28:42 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD9210E03D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jan 2024 18:28:41 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336f2c88361so4302533f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jan 2024 10:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1704133719; x=1704738519; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R3S8bDoB0+meAUy/v2hDeH2H5UnFu3JsGX7GaQedtVs=;
 b=lWYD0DuHzlneBTf7/XvMOzRJgFtOPo7SWdLm8yrrmu6Y3YmfIaiAfsLeFrxqUPl6Zs
 iGgW6BPdKCH/+vecWgaKEtX+DjkPScTnIHXfj380/GodZZj9Lzc3gSUihWWSlOZaGi/B
 +ArD3SzWpF6Dg6/r1UmdLnCLjZYTq8YuiRZB5iQAbCXipgRmusmDTRy3Bjk4lRkdsWzF
 AzMWDICCnK2FYT4fNThZ3zIZrBWEITDY/c4/BjEWMFa22WhBOBVU2Tl3YiJvgi1UOpPP
 ArWNZMGw0CPNo97/z+W5TbOa80PJ2oKGZQIrmUEYh10azBQ/TC2t7SS8tmlj4E1gsp7d
 X4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704133719; x=1704738519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R3S8bDoB0+meAUy/v2hDeH2H5UnFu3JsGX7GaQedtVs=;
 b=A0ndY/XsfBJtvFUn3ItLVGsVStnZhfg7/YNVCAgysD59ZBQOw+kcxvrx3ZQ4QhlPlg
 3equzZ79SJ2UbqTOQwEzF/iLrp3naWgiYMVbEw21C4DIHwIS4btE2Gga7GlVV+hq6CIi
 McsgTyHmcU0aFs5aGQJKYBbih7OUbvTw8Mosn9YVSCgSNe8aZUIFkvCXCA4o9E4jRTuP
 e4AW9bmKKdd1jNsaHmLTxzsnTG3bat/go0DisLCurx1EcQPA2ChzZqYt3MF7lDcS6QmU
 3bzMdEWNnmCmXL0/iOpETIcevmZwEkKKOD+sDwwvRoO1BPyyaSILLBrYMWnsABRRF7l9
 6rGQ==
X-Gm-Message-State: AOJu0YymHkklFAOdIGMAz5Ed+6hS04/l+NqD3x6We3lQNXX6oioDmhPl
 hK27Hma57Bn90Eg8krCFOCDcHW/9suDNeEhd3VmHX9ONOP8=
X-Google-Smtp-Source: AGHT+IHOeVYB9sPm8GoQKDJf0Iz1r8DrMwYNEefZxIkxaQnMbYCEUvtSmmFaSzw/wCl2GNiZ1hsYYQ==
X-Received: by 2002:a5d:5f4c:0:b0:336:ca94:3e00 with SMTP id
 cm12-20020a5d5f4c000000b00336ca943e00mr5049268wrb.69.1704133719363; 
 Mon, 01 Jan 2024 10:28:39 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a5d4d04000000b00336a1f6ce7csm21902232wrt.19.2024.01.01.10.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 10:28:39 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets for
 DP/eDP displays without PSR
Date: Mon,  1 Jan 2024 18:28:22 +0000
Message-ID: <20240101182836.817565-1-joshua@froggi.es>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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
Cc: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The check for sending the vsc infopacket to the display was gated behind
PSR (Panel Self Refresh) being enabled.

The vsc infopacket also contains the colorimetry (specifically the
container color gamut) information for the stream on modern DP.

PSR is typically only supported on mobile phone eDP displays, thus this
was not getting sent for typical desktop monitors or TV screens.

This functionality is needed for proper HDR10 functionality on DP as it
wants BT2020 RGB/YCbCr for the container color space.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++++---
 .../amd/display/modules/info_packet/info_packet.c   | 13 ++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2845c884398e..6dff56408bf4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
-
-	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
+	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+			 stream->signal == SIGNAL_TYPE_EDP) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
-		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
+		if (stream->link->psr_settings.psr_feature_enabled)
+			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 	}
 finish:
 	dc_sink_release(sink);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 84f9b412a4f1..738ee763f24a 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 
 	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
-	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-		vsc_packet_revision = vsc_packet_rev4;
-	else if (stream->link->replay_settings.config.replay_supported)
+	if (stream->link->psr_settings.psr_feature_enabled) {
+		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+			vsc_packet_revision = vsc_packet_rev4;
+		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+			vsc_packet_revision = vsc_packet_rev2;
+	}
+
+	if (stream->link->replay_settings.config.replay_supported)
 		vsc_packet_revision = vsc_packet_rev4;
-	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
-		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
 	if (stream->use_vsc_sdp_for_colorimetry)
-- 
2.43.0


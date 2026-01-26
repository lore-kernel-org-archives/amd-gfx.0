Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3402ED1951B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2EE910E4AA;
	Mon, 26 Jan 2026 21:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g2AY1mYi";
	dkim-atps=neutral
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D5310E4A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:46 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-432d28870ddso2588525f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461725; x=1770066525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xx+sJX1t/P5fyhKNulX24p1wSAnLp+W8H8wDsn3K+SY=;
 b=g2AY1mYi4Fh8KdUEYksg5OBFjlYxEYvyEXOAs5iJlbn7HGU20pJuw3aLt3p6vkFIBG
 ZVG0ZrdnD8GB8dLbQG3VhHWYt9edjjNZvM5OXcFAgufI0boOybQqP4xuJvTFRQjZ7IT3
 omjtDhWanYkvAR7IIcce4l+Sb/f03aJDDlMtqwoosJT+iPCmE56pQHwHaMemMVBxbuRC
 Tfk1LC4Eu+ZqnSDoZBU1zDjRhe2kMql+EPatPl2Gu/B67BnXdUGPyRb8lbdunrGFOqbV
 4VuU6CQN1miRPIBeeRrLQtw5yTjo0NIlRycQoveSzFrtXMhxmb8K6OrgVMDTI5gjdtTA
 4e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461725; x=1770066525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xx+sJX1t/P5fyhKNulX24p1wSAnLp+W8H8wDsn3K+SY=;
 b=s4m4v/BKgWUkktrIutokcfd8/OI6q8bBzfojZskezHZNkjoGI0uoD+kxLyHbDvgfq+
 EyHJfeRJfXGtI6Jd3HIp6Se4Kwq6nPZFAdY85LU3HOybGk2gtKwUCbXV5128KhrPNwWt
 vUpbCHuVCjXNoMGQBs/mf3AZIY11+2BIn34NgSfDI3cXj1mjylSCFtb4kY13JhrQo4+4
 Xxl+YfWrmF+tqsZTM79IcQcxqD+F3NuLj/ruEqFs5gXxXoNygueXK6gaPbKEOH3Vl0ms
 i0xYARuVfDHGK7Z1EZ9wqvC91aUi5myoW3n8D+1Xc/T8rN6eZ9R5Sm+z3tDJqfmEhwS8
 +1Wg==
X-Gm-Message-State: AOJu0Yx9CWj1kMx9aW9+8FErJTDgt3aDWNUal9T1febJ++tlgw/4UXBl
 vzT6djgRXdvdPussxPuTug/hVvlIcNRHcrjEf5uWbhhNZArdPXctlvGlSaK3A0Ia
X-Gm-Gg: AZuq6aKy74wTiensBReNDYWzFbCzdf7Q5zo+zKayZp87JOeNjtAObh5+7pLkLVV7F+8
 fpOFSOEXAiX9uQwF3mje5WAiNeKZSfOEorG02m899nBZKxuVcoWUuKBgyEu7l9rzYZafi6mox2m
 KA6S2X22aeDx+tALB7YD5vtNIVWsxJcMMQA2gE7gDXlf1QaDr7fnZOJMrRUYefrXImOPmEboHq2
 MMMl8nLpcy5zHKqMdyDiqWVYLOL6FsYokaqTfaCWS2p2i8CF8TUJzPiddCT8e3rk8U5ahJ1hsV1
 KUADgx+sfi9O+RbQNn4MpMZTUcNZ5loiAXRIRfrrFIXgivOBGMR+W2DpdEPsYNW7tQqmVaYHKvV
 u+QP8bH3SDQVZLY0YH/bgy4xcoZj1qC5GT6x5/VG3aGkRYpIUUf5J3C3aMkhWjqCsQW9cuM5/zr
 eIz9F3sp3pzsJr5rCsxwFKGp3oaWXA+SXERQ7qqzJBPkWpU9ZU7yUF8ONJS+d+rM8=
X-Received: by 2002:a05:6000:22c1:b0:435:94c1:3713 with SMTP id
 ffacd0b85a97d-435ca1adafamr10351984f8f.37.1769461725200; 
 Mon, 26 Jan 2026 13:08:45 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:44 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/14] drm/amd/display: Implement BIOS parser external encoder
 control
Date: Mon, 26 Jan 2026 22:08:29 +0100
Message-ID: <20260126210837.21885-7-timur.kristof@gmail.com>
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

The VBIOS has a function called ExternalEncoderControl which
controls the DP bridge encoders that some GPUs use for analog
and LVDS output. Fixup this old functionality.

For reference, see the legacy non-DC amdgpu display code:
amdgpu_atombios_encoder_setup_external_encoder()

- Set same parameters for the ENABLE action as the SETUP action
- Add missing enum values for DDC setup and DAC load detection
- Fix the bits per color field
- Clarify the code that sets the link rate
- Expose the function so that it can be called by rest of DC

A subsequent commit will call this function from DCE HWSS.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 14 +++++++++++
 .../drm/amd/display/dc/bios/command_table.c   | 23 +++++++++----------
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  3 +++
 .../amd/display/include/bios_parser_types.h   |  2 ++
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index e2b74dda00fc..82877f7b3b6f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -780,6 +780,18 @@ static enum bp_result bios_parser_encoder_control(
 	return bp->cmd_tbl.dig_encoder_control(bp, cntl);
 }
 
+static enum bp_result bios_parser_external_encoder_control(
+	struct dc_bios *dcb,
+	struct bp_external_encoder_control *cntl)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+
+	if (!bp->cmd_tbl.external_encoder_control)
+		return BP_RESULT_UNSUPPORTED;
+
+	return bp->cmd_tbl.external_encoder_control(bp, cntl);
+}
+
 static enum bp_result bios_parser_dac_load_detection(
 	struct dc_bios *dcb,
 	enum engine_id engine_id)
@@ -2909,6 +2921,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 
 	.encoder_control = bios_parser_encoder_control,
 
+	.external_encoder_control = bios_parser_external_encoder_control,
+
 	.dac_load_detection = bios_parser_dac_load_detection,
 
 	.transmitter_control = bios_parser_transmitter_control,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index b638cb5adb92..d2d59732d338 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -2521,6 +2521,7 @@ static enum bp_result external_encoder_control_v3(
 				cpu_to_le16((uint16_t)cntl->connector_obj_id.id);
 		break;
 	case EXTERNAL_ENCODER_CONTROL_SETUP:
+	case EXTERNAL_ENCODER_CONTROL_ENABLE:
 		/* EXTERNAL_ENCODER_CONTROL_PARAMETERS_V3 pixel clock unit in
 		 * 10KHz
 		 * output display device pixel clock frequency in unit of 10KHz.
@@ -2537,26 +2538,24 @@ static enum bp_result external_encoder_control_v3(
 		if (is_input_signal_dp) {
 			/* Bit[0]: indicate link rate, =1: 2.7Ghz, =0: 1.62Ghz,
 			 * only valid in encoder setup with DP mode. */
-			if (LINK_RATE_HIGH == cntl->link_rate)
-				cntl_params->ucConfig |= 1;
+			if (cntl->link_rate == LINK_RATE_LOW)
+				cntl_params->ucConfig |=
+					EXTERNAL_ENCODER_CONFIG_V3_DPLINKRATE_1_62GHZ;
+			else if (cntl->link_rate == LINK_RATE_HIGH)
+				cntl_params->ucConfig |=
+					EXTERNAL_ENCODER_CONFIG_V3_DPLINKRATE_2_70GHZ;
+			else
+				dm_error("Link rate not supported by external encoder");
+
 			/* output color depth Indicate encoder data bpc format
 			 * in DP mode, only valid in encoder setup in DP mode.
 			 */
-			cntl_params->ucBitPerColor =
-					(uint8_t)(cntl->color_depth);
+			cntl_params->ucBitPerColor = dc_color_depth_to_atom(cntl->color_depth);
 		}
 		/* Indicate how many lanes used by external encoder, only valid
 		 * in encoder setup and enableoutput. */
 		cntl_params->ucLaneNum = (uint8_t)(cntl->lanes_number);
 		break;
-	case EXTERNAL_ENCODER_CONTROL_ENABLE:
-		cntl_params->usPixelClock =
-				cpu_to_le16((uint16_t)(cntl->pixel_clock / 10));
-		cntl_params->ucEncoderMode =
-				(uint8_t)bp->cmd_helper->encoder_mode_bp_to_atom(
-						cntl->signal, false);
-		cntl_params->ucLaneNum = (uint8_t)cntl->lanes_number;
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 06fdde281a0c..6f96c5cf39fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -97,6 +97,9 @@ struct dc_vbios_funcs {
 	enum bp_result (*encoder_control)(
 		struct dc_bios *bios,
 		struct bp_encoder_control *cntl);
+	enum bp_result (*external_encoder_control)(
+		struct dc_bios *bios,
+		struct bp_external_encoder_control *cntl);
 	enum bp_result (*dac_load_detection)(
 		struct dc_bios *bios,
 		enum engine_id engine_id);
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index f40dc612ec73..b5d97b394131 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -93,6 +93,8 @@ enum bp_external_encoder_control_action {
 	EXTERNAL_ENCODER_CONTROL_SETUP = 0xf,
 	EXTERNAL_ENCODER_CONTROL_UNBLANK = 0x10,
 	EXTERNAL_ENCODER_CONTROL_BLANK = 0x11,
+	EXTERNAL_ENCODER_CONTROL_DAC_LOAD_DETECT = 0x12,
+	EXTERNAL_ENCODER_CONTROL_DDC_SETUP = 0x14,
 };
 
 enum bp_pipe_control_action {
-- 
2.52.0


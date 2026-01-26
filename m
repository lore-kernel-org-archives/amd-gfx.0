Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E96D19520
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9379910E4AC;
	Mon, 26 Jan 2026 21:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d+o73bif";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E4A10E4A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:44 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so2944801f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461723; x=1770066523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXN5z45cavYeNyBKFYEfp8gaVHGLmSktLvj6a4QMLYw=;
 b=d+o73bif3FRk/esyOGFxOtrO6ZOUrbiV7nynzbtZdTzJaOGyzOgzfqOXorX9JNQUV5
 AffqfRx5PLO7cEu6ntlUBXX/5SmalTbmI0JRvYw3LfFvR7CTuTmiAZkRtKsHa8cs6J4v
 OjZ+ruIqLcgF1Se5U/ue+cfanHYRfqMcVmp/BVlZXryAWPJ4a53eIuC/KS1MuX5xvwCX
 GfTdDEB7fQygXZvmuCc4KmIMhjjD5grYOdRKcgGhbGMBqo43DuDOAS47C8Xs/RumOcLn
 UVxExwFUXJys5sFWIQOOr+rI9q306ldRS401fBmWA94rCIcgaIRMOYQCYuX3YpituI1a
 CEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461723; x=1770066523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXN5z45cavYeNyBKFYEfp8gaVHGLmSktLvj6a4QMLYw=;
 b=tJL7uVGYy8D1gabgLM6NQ9wc/WOZrPLcsCmX1f67ubyKIlDh66ErItVtMDPNMYvtz5
 RhsJAFcyqvUKXpJc6OJjKzbjU609GlQJPEsMH4Z0WN/7sla7FOwtlZoePUPsCk/B7n6M
 zOARECPz0kjkBVVdz8QlJYl7D2sv1dHK7CmZId9+EukRAGpE2IW9x/Iut4G6VKe69sYA
 RtM7zj1/rB2hA2OEvSZfjaB80SYsjFkS+614nAMjRQOSfAyc134kiKbn7DYVW14cnd9f
 2tqNrz54D6rXLYi/yBhGs0KBvZr5tyiNkuLGUMn/psZdGtL7lbKFYz9l9N5f8+leQJBd
 uvvg==
X-Gm-Message-State: AOJu0Yx1q4Y2FQbiC2FhqstGQnPf0WNpLQ7REjG8zhJcxLo5i2wpLpMW
 2kL3ajXDOr0Q7fhBKMRpbLczn9yPba4JLHD3MwwZEJ1npcTRu3jZKRronOl/cg==
X-Gm-Gg: AZuq6aI6PcBD8J0o9rgu/Y2kDY3CNkDII2HeNMg8XSuS0mZmZ7J8MQ+cpdaKZfWh8nn
 DhP6aUqeMAV/p+3mDzQzCyb2XigTuGWhfk4ctUmLhrORh/rM1feyRGb6ESWLkzHNBoLBt9tSLeU
 PUEvRLHfZWXsQDqyZkwS6AhkQjSeJO7UIE0d1i7Fkmgghe8eB/0d0r0DhH6cZz1Fnm+DePXR2lB
 0k905dcCZNBkvWgI8If5ZBJJhOyY+wCy+5OPec/VsrLJucVp1wgD1NAAmnCofo5x3IZfEWAAvKX
 T3OafJpQAL04MY1AHKurf8fkxJaFyI/uGlBP26amqzO5HPGw1POIu1Rsr9rBX0dtp26voXbgBWm
 K09VNSma2C7sdjvBrhvEo8Qd2CJc4TEYELLJ6OCyWlHW0fzjk8IKZCVPEAvdaRYD6Tsr/d9eR1Z
 KEjd2kDBglW7RJWHktDoRisBYfQb84kenqfthY0guJqCFwxW9fBEF+ZbTcgNt0/wo=
X-Received: by 2002:a05:6000:40c8:b0:435:8f88:7235 with SMTP id
 ffacd0b85a97d-435ca1adebcmr9911207f8f.33.1769461723218; 
 Mon, 26 Jan 2026 13:08:43 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:42 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/14] drm/amd/display: Add color depth helper function to
 BIOS parser
Date: Mon, 26 Jan 2026 22:08:27 +0100
Message-ID: <20260126210837.21885-5-timur.kristof@gmail.com>
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

To improve consistency and avoid duplicating the same code.
Also, properly handle all enum values where they weren't
handled correctly before.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/bios/command_table.c   | 101 +++++-------------
 1 file changed, 26 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 76a3559f0ddc..b638cb5adb92 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -226,6 +226,28 @@ static enum bp_result encoder_control_dig2_v1(
 	return result;
 }
 
+static uint8_t dc_color_depth_to_atom(enum dc_color_depth color_depth)
+{
+	switch (color_depth) {
+	case COLOR_DEPTH_UNDEFINED:
+		return PANEL_BPC_UNDEFINE;
+	case COLOR_DEPTH_666:
+		return PANEL_6BIT_PER_COLOR;
+	default:
+	case COLOR_DEPTH_888:
+		return PANEL_8BIT_PER_COLOR;
+	case COLOR_DEPTH_101010:
+		return PANEL_10BIT_PER_COLOR;
+	case COLOR_DEPTH_121212:
+		return PANEL_12BIT_PER_COLOR;
+	case COLOR_DEPTH_141414:
+		dm_error("14-bit color not supported by ATOMBIOS\n");
+		return PANEL_BPC_UNDEFINE;
+	case COLOR_DEPTH_161616:
+		return PANEL_16BIT_PER_COLOR;
+	}
+}
+
 static enum bp_result encoder_control_digx_v3(
 	struct bios_parser *bp,
 	struct bp_encoder_control *cntl)
@@ -248,23 +270,7 @@ static enum bp_result encoder_control_digx_v3(
 					cntl->signal,
 					cntl->enable_dp_audio);
 	params.ucLaneNum = (uint8_t)(cntl->lanes_number);
-
-	switch (cntl->color_depth) {
-	case COLOR_DEPTH_888:
-		params.ucBitPerColor = PANEL_8BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_101010:
-		params.ucBitPerColor = PANEL_10BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_121212:
-		params.ucBitPerColor = PANEL_12BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_161616:
-		params.ucBitPerColor = PANEL_16BIT_PER_COLOR;
-		break;
-	default:
-		break;
-	}
+	params.ucBitPerColor = dc_color_depth_to_atom(cntl->color_depth);
 
 	if (EXEC_BIOS_CMD_TABLE(DIGxEncoderControl, params))
 		result = BP_RESULT_OK;
@@ -294,23 +300,7 @@ static enum bp_result encoder_control_digx_v4(
 					cntl->signal,
 					cntl->enable_dp_audio));
 	params.ucLaneNum = (uint8_t)(cntl->lanes_number);
-
-	switch (cntl->color_depth) {
-	case COLOR_DEPTH_888:
-		params.ucBitPerColor = PANEL_8BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_101010:
-		params.ucBitPerColor = PANEL_10BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_121212:
-		params.ucBitPerColor = PANEL_12BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_161616:
-		params.ucBitPerColor = PANEL_16BIT_PER_COLOR;
-		break;
-	default:
-		break;
-	}
+	params.ucBitPerColor = dc_color_depth_to_atom(cntl->color_depth);
 
 	if (EXEC_BIOS_CMD_TABLE(DIGxEncoderControl, params))
 		result = BP_RESULT_OK;
@@ -334,23 +324,7 @@ static enum bp_result encoder_control_digx_v5(
 					cntl->signal,
 					cntl->enable_dp_audio));
 	params.ucLaneNum = (uint8_t)(cntl->lanes_number);
-
-	switch (cntl->color_depth) {
-	case COLOR_DEPTH_888:
-		params.ucBitPerColor = PANEL_8BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_101010:
-		params.ucBitPerColor = PANEL_10BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_121212:
-		params.ucBitPerColor = PANEL_12BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_161616:
-		params.ucBitPerColor = PANEL_16BIT_PER_COLOR;
-		break;
-	default:
-		break;
-	}
+	params.ucBitPerColor = dc_color_depth_to_atom(cntl->color_depth);
 
 	if (cntl->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		switch (cntl->color_depth) {
@@ -1797,30 +1771,7 @@ static enum bp_result select_crtc_source_v3(
 		&params.ucEncodeMode))
 		return BP_RESULT_BADINPUT;
 
-	switch (bp_params->color_depth) {
-	case COLOR_DEPTH_UNDEFINED:
-		params.ucDstBpc = PANEL_BPC_UNDEFINE;
-		break;
-	case COLOR_DEPTH_666:
-		params.ucDstBpc = PANEL_6BIT_PER_COLOR;
-		break;
-	default:
-	case COLOR_DEPTH_888:
-		params.ucDstBpc = PANEL_8BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_101010:
-		params.ucDstBpc = PANEL_10BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_121212:
-		params.ucDstBpc = PANEL_12BIT_PER_COLOR;
-		break;
-	case COLOR_DEPTH_141414:
-		dm_error("14-bit color not supported by SelectCRTC_Source v3\n");
-		break;
-	case COLOR_DEPTH_161616:
-		params.ucDstBpc = PANEL_16BIT_PER_COLOR;
-		break;
-	}
+	params.ucDstBpc = dc_color_depth_to_atom(bp_params->color_depth);
 
 	if (EXEC_BIOS_CMD_TABLE(SelectCRTC_Source, params))
 		result = BP_RESULT_OK;
-- 
2.52.0


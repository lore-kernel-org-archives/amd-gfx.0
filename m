Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE14AC677F1
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 21:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B27710E35E;
	Tue, 17 Jan 2023 21:26:26 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6B410E35D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 21:26:24 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id n7so5923322wrx.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 13:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwdocgbBNjjWQzbUEnMeRHH3lJ+gsFux7e/H+kHA+VQ=;
 b=Ph4uVQFJfJYcsuuSu+1yzqgkc2iTqOZQFQ8RRH0AJLuz+qFlo5xlHBZdLAieFtCSJh
 oIBe5fkSGidstbE3j2rlsFqSgkQriQsFOASqHUAS0WBaMWWjVDULzmh3VBeDDyvY9QW2
 PTVb+WwG9ZMA8O8mPSenWPPw5coO3s8jlt7YPd/clEIgPUya4ywzs7DL5DqMeuxXcwod
 GhyrVMjxMEsXB+9hTvRYACehlKM/IUf6ssj8Qx47TOQwE1Zfd9n/SF3UuEYWQW2CBnaC
 cVoArSh02H+Uw6L6iX8Odsd2VKkkuvU+ehmc7CcQ88lEub2VJ+pFfLut2mGUe+YzroI8
 Dlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwdocgbBNjjWQzbUEnMeRHH3lJ+gsFux7e/H+kHA+VQ=;
 b=lIk3H6f0uTlNNWHETWw0pmzaDDQ5XmVjWBrIBzF3kqsj2KojkZ181jzyUTVWxi2B56
 1+o+DvoynxwBg51XNoapch6ye3FyzOVkqkX3BphhZr201aMy+vwmzO/Igm80wFBppi8o
 AiUN2sAF+28hrfqxc2nbHxhO5YtaB4vQeagYr49HbtjkXdpk/QAr1GIVv7YNMrp7VVn4
 L3iyxeMxFOJQ6NN93ltNsi3b+Ay170Iv0ZsHegWMtLXTJJtsNR0VtNe8leu2NWcn7OeL
 ioIQ/78bAiGQSXAbrsO6jzOiiBNESEwOVEDLy6AhTjTvdNf7+XLBB9twuGPgi4GV1Xsu
 h+jQ==
X-Gm-Message-State: AFqh2kqcFAhVkd9vKkTJzQGN+RtCY+xqFzm1q/cMm/WaE47v17MqQzeX
 GW6kr0yke2l8hLfs8SwHOieJ2mmfYtC1MUrh
X-Google-Smtp-Source: AMrXdXsEmjxB/yqfTzbIVSBeJTOhNY8+TjqYurtoNqYCb/hWcvQXLwtmm+hb/ZI+W8axApKC5XSkxQ==
X-Received: by 2002:a5d:4e83:0:b0:2bd:d857:f96 with SMTP id
 e3-20020a5d4e83000000b002bdd8570f96mr11337917wru.60.1673990782896; 
 Tue, 17 Jan 2023 13:26:22 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a5d6747000000b002b57bae7174sm30076381wrw.5.2023.01.17.13.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jan 2023 13:26:22 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/display: Remove unused display_content_support
Date: Tue, 17 Jan 2023 21:26:20 +0000
Message-Id: <20230117212620.11262-2-joshua@froggi.es>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117212620.11262-1-joshua@froggi.es>
References: <20230117212620.11262-1-joshua@froggi.es>
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was never filled in and thus never truly used.

Checking the EDID for content_type support is not required for sending
the avi infoframe packet.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h  | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 51dc30706e43..a499c0952ea0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -182,7 +182,6 @@ struct dc_stream_state {
 	 */
 	struct link_encoder *link_enc;
 	struct dc_panel_patch sink_patches;
-	union display_content_support content_support;
 	struct dc_crtc_timing timing;
 	struct dc_crtc_timing_adjust adjust;
 	struct dc_info_packet vrr_infopacket;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c73a655bd687..862af36027e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -175,18 +175,6 @@ struct dc_edid {
 
 #define AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS 20
 
-union display_content_support {
-	unsigned int raw;
-	struct {
-		unsigned int valid_content_type :1;
-		unsigned int game_content :1;
-		unsigned int cinema_content :1;
-		unsigned int photo_content :1;
-		unsigned int graphics_content :1;
-		unsigned int reserved :27;
-	} bits;
-};
-
 struct dc_panel_patch {
 	unsigned int dppowerup_delay;
 	unsigned int extra_t12_ms;
@@ -219,8 +207,6 @@ struct dc_edid_caps {
 	uint32_t audio_latency;
 	uint32_t video_latency;
 
-	union display_content_support content_support;
-
 	uint8_t qs_bit;
 	uint8_t qy_bit;
 
-- 
2.39.0


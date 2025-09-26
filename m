Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E466ECAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8407E10EABC;
	Fri, 26 Sep 2025 18:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSGYs728";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3F210EABD
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:53 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b57bffc0248so1940799a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909772; x=1759514572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViqjgfVQV1GRDN73jwQwmPqSQAJLjEmoiyfsDP+0oPU=;
 b=ZSGYs728enWV0/59mtR5C8PV71Nubua1jQBYFh9swGlDjUfYIaI8l5X0lnzK50sJ6Q
 /mH1LoQ8SxBcgv2gKWGeBrjPO3pAyHmz0SwojtzJRYKQvubohyIyJNHChHpDFdCNTrYT
 rvPC7XoF6TtvlseZVSOWN2lFyt1yN04x9Z6OpXUhUVS7WrxVgD24f5EnMxN8sygdYyaM
 DBEUGIJrNF4SA74biM2cXhaN0A5GM0knMQdSC56+ABUhI2pFdXwEj7BjVG2owhQY/3pm
 zoG41dNHqyK9JOYdofnmrbGPupIPQwGWMl26m2MUlSGTpGMzBHSFvjEEGXmCTxd+Fqis
 OWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909772; x=1759514572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ViqjgfVQV1GRDN73jwQwmPqSQAJLjEmoiyfsDP+0oPU=;
 b=EVVZ778K9aqxlSbtRHY1dBWKyejZb1ySH7VytErc6xge/c5kxmOqg8srnd35b6wFtZ
 yQTVICKLxaZcnX8aMqUG8UYgMyyv3zvEvT1pbPtJzcw/emz1qZDk6RVXx9bUolPVWkku
 v8+sCX+tOGOww1I7Uz8DBS+lrVyxlpUmnpdiO6VAZc5zvkn6SUCfoyRPpMN98od0rCzx
 7wrUnCwGm2TsnNDmC4P7ActCZlc5ygXbQG0pg9Aq35zWKR9FdMetewFa206gJL5fOgUp
 wCoTB7GZ6JDBwM014BDyDnMhKPCIexT7mcYuM4VrtO0aP+6qVJvMv3IKKzytQWmeGMb2
 6sBg==
X-Gm-Message-State: AOJu0YzwemYgCB69RZxzPwfmxa55bkJ+4mCzPoTbm+JLYyM/jEpPjvKl
 tvUaqiR2urtaFvnj1JTvMstvmE2C41xBMApN7qNLbRBFabbjB24bzBjb1p6Zzg==
X-Gm-Gg: ASbGncuju2TkR6zQSY9AMuGn9MlrlG1PAH4sRU9V6edPq+OHJP8tTgopP35r3OKUpmi
 +JjaiOA99HyIBhRhXTxwBL4og1B5KRrYkRV+5CcxwRVolwS4qMu3F1Xx+8BDB0kqdYp+0HpIdaE
 GJ3JIOew4p8YFIWBG3rvHjFSIqAe9uGhXuTI17nw1ENCCFE1zE5t5Hl9OIjrkgIZGCBR+uCa+FR
 r24Lk+8yeSwUNSPw/Cy2hv18eaiFHmmfCxEmnSs3gbDfNHsm2kHvyJG0JsVUJQQVzZRTg6vE347
 O3mjab1AgTcERL9Fv8Y3AiyzF75RkBSGBqvaiwu+CeKGLMgXZZx4XiiOm4+N/6pMPllPuUvPJ/G
 Fs0QDYpQphq0tcbDhQr9NsOfx70GKuNbnmMRgj0JsJpe/2Qs6BngrMaopx5uydD5/qkMRRMd5tJ
 x+er4PuCqabcrbsVB8VRt0UYMPkZiUug==
X-Google-Smtp-Source: AGHT+IGYMq794+arydfW23kiuG06xtufcn5qnJf/BGMqGJfhrVbOXHvct5GaKJk4J/mLzFvWuzaBiw==
X-Received: by 2002:a17:902:f70f:b0:262:f975:fcba with SMTP id
 d9443c01a7336-27ed6beb897mr67136135ad.9.1758909772420; 
 Fri, 26 Sep 2025 11:02:52 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/23] drm/amd/display: Don't use stereo sync and audio on RGB
 signals (v2)
Date: Fri, 26 Sep 2025 20:01:47 +0200
Message-ID: <20250926180203.16690-8-timur.kristof@gmail.com>
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

Analog video signals on VGA or DVI-A (analog part of DVI-I)
don't support audio, so avoid calling any audio related
functions on analog signals.

Stereo sync was not set up for analog signals in the legacy
display code either, so there is no loss of functionality if
we omit it from DC for now.

Also add a dc_is_rgb_signal similar to other dc_is_*_signal.

v2:
Added comment to clarify what we mean by RGB in this context.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c      |  6 ++++--
 drivers/gpu/drm/amd/display/include/signal_types.h   | 12 ++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 892907991f91..80344cbd1f99 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -115,7 +115,8 @@ void setup_dio_stream_attribute(struct pipe_ctx *pipe_ctx)
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 
-	if (!dc_is_virtual_signal(stream->signal))
+	if (!dc_is_virtual_signal(stream->signal) &&
+		!dc_is_rgb_signal(stream->signal))
 		stream_encoder->funcs->setup_stereo_sync(
 				stream_encoder,
 				pipe_ctx->stream_res.tg->inst,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 83419e1a9036..c92d46c25f8c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2369,7 +2369,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 			set_avmute(pipe_ctx, true);
 	}
 
-	dc->hwss.disable_audio_stream(pipe_ctx);
+	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dc->hwss.disable_audio_stream(pipe_ctx);
 
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
@@ -2654,7 +2655,8 @@ void link_set_dpms_on(
 		enable_stream_features(pipe_ctx);
 	update_psp_stream_config(pipe_ctx, false);
 
-	dc->hwss.enable_audio_stream(pipe_ctx);
+	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dc->hwss.enable_audio_stream(pipe_ctx);
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		set_avmute(pipe_ctx, false);
diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index a10d6b988aab..3a2c2d2fb629 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -118,6 +118,18 @@ static inline bool dc_is_dvi_signal(enum signal_type signal)
 	}
 }
 
+/**
+ * dc_is_rgb_signal() - Whether the signal is analog RGB.
+ *
+ * Returns whether the given signal type is an analog RGB signal
+ * that is used with a DAC on VGA or DVI-I connectors.
+ * Not to be confused with other uses of "RGB", such as RGB color space.
+ */
+static inline bool dc_is_rgb_signal(enum signal_type signal)
+{
+	return (signal == SIGNAL_TYPE_RGB);
+}
+
 static inline bool dc_is_tmds_signal(enum signal_type signal)
 {
 	switch (signal) {
-- 
2.51.0


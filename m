Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E1DC83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D318610E80A;
	Wed, 23 Jul 2025 15:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NCwgMYm7";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B3F10E7F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:27 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so647352f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286306; x=1753891106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EB0OHjLmXlZj3472MYxsu88NMA2nkg+SD8/F9YYij3s=;
 b=NCwgMYm7o3G2szxJGiPCa9I8lrnNhM3qvKvGgND0Gmq/UURQ3ppTICf+bznsqwK2SR
 XzQcQtvOBlZ0D1Qh0NCLz3/SO3OHql5A7uJ6Jiiv1wiq6bYod3Q8BnHsy7xfaWGrxuCZ
 3rVP3QEnlsBWqbKK8QWWYSv6Rt1GNDi5c5CoD2vA6dCJ6E2AxUg1SyEWxR+9XL/WTZwY
 /nnkJJPgoy1IB2uPwvEMqGPfPIk2FkkbPxZaBNc99T5P/btF5opdB82lK4+x11n2Qzm1
 jVL7U2h48Pyho6Lijycg3lKTFqmIbR9xVkFNGNnZMkpGQkU9BvyV052WRr4CNlMXBm8T
 gyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286306; x=1753891106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EB0OHjLmXlZj3472MYxsu88NMA2nkg+SD8/F9YYij3s=;
 b=In4kcqHkUd4akjeFCBuugoBnSzomMN4pBm47mPckCPnE38he0xXAK0BfCsCaMOARlm
 oqlbRUZ+ctjC18kcdYYg2mp/Fm3DwJta85ZL8zVv8COKZhlh6xhVeqUE8HYGsF6MJk16
 Ob5L36NJ+80V/nAlnU0qz77fdsyRD4NBQgakmWnFTglW+iYnwQFfNQ/99sIOaOWneBvy
 WN0Dex5Jehm55vwMXSUEyBEI8fgrjLz3D1txO1Q0B67ABZ3Qe8WtaBtpBq110FbQhucK
 g3WdAJJuHhBUjSw6W7mbc93WW5BRAmJ3vdMYC5D5u3YKo7elrLTiJsaIVrxqeyZ9URJ2
 pN7g==
X-Gm-Message-State: AOJu0YwZsvl8CrscohdEGsmve1vUXbKnHLfSlMs5eAcaD7ZQpxc8L4mu
 P15tosFFQP0WD2O7XgOchgRoNTnPdvL44Vk4QQLL5bnxFb4XUfJZYPg3atgpNA==
X-Gm-Gg: ASbGnctZhnNdhw+LQABwAMi/4xnk4r9RbokWDHHJnzwtIHO5+V0626NsHK7z2AoYZ5G
 Uwh0Fl52dDFaXXrIcQBD+sj5hjcHXpQeOnUvrVg7tC9vVw4Imk64m7roY5HRud/3wErs99LvfY5
 RuvoE0pA0IcNHZGetzgE/J+Z7e3MFiQx5XrTc4R8mpvW1Y6Bzl2Vc4dXqsIiROpRe8UYBB16Ixv
 AoJ274poJV3VJSy06jOZ/TTNVDSvu9O0qZn7T9I1yjXLdOplGRbSOfI93ed5mBZuwaVG3wSGYeX
 hzyt1vhr47FOThOlig2zNAck0lUyO32iHMezJFVjj1ntr0N2fRswujyU2MLkVWZbR5zwKYnG2gm
 X3Jn8WzXwWG7Du6Mza7KIvB/69Ec/a8XIp/Lk27OgUW/jFbQWA17YjfOlSZAwYQqjAOh9QauQgP
 YF508BiWXpQE1FDjioSMDvXjfFfw==
X-Google-Smtp-Source: AGHT+IHKTWF8WxKLDr1tDkLUeSibP2QdZwm1qOX2IbQhpucg6r2ENSGOmC8zUyRZmeA3nB33IOuMSg==
X-Received: by 2002:a05:6000:290f:b0:3a4:e231:8632 with SMTP id
 ffacd0b85a97d-3b7694c33b4mr3683601f8f.12.1753286305927; 
 Wed, 23 Jul 2025 08:58:25 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio on RGB
 signals
Date: Wed, 23 Jul 2025 17:58:00 +0200
Message-ID: <20250723155813.9101-8-timur.kristof@gmail.com>
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

Features like stereo sync and audio are not supported by RGB
signals, so don't try to use them.

Also add a dc_is_rgb_signal similar to other dc_is_*_signal.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c          | 6 ++++--
 drivers/gpu/drm/amd/display/include/signal_types.h       | 5 +++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index b68bcc9fca0a..f3470716734d 100644
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
index 8c8682f743d6..d6b7347c6c11 100644
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
@@ -2656,7 +2657,8 @@ void link_set_dpms_on(
 		enable_stream_features(pipe_ctx);
 	update_psp_stream_config(pipe_ctx, false);
 
-	dc->hwss.enable_audio_stream(pipe_ctx);
+	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dc->hwss.enable_audio_stream(pipe_ctx);
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		set_avmute(pipe_ctx, false);
diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h b/drivers/gpu/drm/amd/display/include/signal_types.h
index a10d6b988aab..825a08fcb125 100644
--- a/drivers/gpu/drm/amd/display/include/signal_types.h
+++ b/drivers/gpu/drm/amd/display/include/signal_types.h
@@ -118,6 +118,11 @@ static inline bool dc_is_dvi_signal(enum signal_type signal)
 	}
 }
 
+static inline bool dc_is_rgb_signal(enum signal_type signal)
+{
+	return (signal == SIGNAL_TYPE_RGB);
+}
+
 static inline bool dc_is_tmds_signal(enum signal_type signal)
 {
 	switch (signal) {
-- 
2.50.1


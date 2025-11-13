Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AF0CD8CA4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 16:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5D910E8D0;
	Thu, 13 Nov 2025 16:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TBSJ671I";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA47A10E8CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 16:33:56 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47755de027eso7817235e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763051635; x=1763656435; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCE0sW08nHLHbs9PMCm0+9FrEKxKDw9NCY10M/l5ECM=;
 b=TBSJ671IbPu5yFfCoHUU2ia6jXE+jR0yMrrP7qT9DoH82fytQL7o3LoB7qizHICFre
 sEdIT5T3OtgTcF4lAoXFRki0+r5yUKzPeeCCdzQh3Z9r/z1/fsMmnPwndK/wvXSEeVF2
 SnJZ5WR4kQO2C5EtQhY7tYQclJj02QQaM1reQZZ774S2h5RPmU5CvcQQt2Yj/riaAIbj
 RHyYkTgaQKQduEvmY/P9Ym3lJY4khKkIuCeI7Awhbcj2lgfqdzPIJ96213O1M/HOqTB0
 uiZ6XmTSY+77z/XD8nELI82+FiD8t1qYhzrhAxaUrTCI9+J/Ks74YyMixbY1f904WCQq
 DRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763051635; x=1763656435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCE0sW08nHLHbs9PMCm0+9FrEKxKDw9NCY10M/l5ECM=;
 b=JHU1ud5L8zvF8v/FUrAx3h47WyXPVClqtU4BnhRiUTm1RSQxw5UCcbdWnkPVhsfxUB
 dO08e7kySyqo3CgmqpRIaPy/b8nu6oimDM/2xNW3XeKd9O/u19x3n+C9xmq2hH90yNgd
 5WsrMgJmokwhBHr7TnXMoYdpDF5Qht9ThHiRFiO4siGbLFh/uknt2CZVEc4qlnn+UzQa
 62b9jfyvobX5fMn+jcbayZbkN/suqacFEXZSoD+GB0qj4vAUYdLFO20wuvbhgJuMUHLB
 eoxQdU8San9ab2ql3P1I8MG6VH3+qh5KkWSM110vReaMWBy8uRdlnx66yX3UK/GzC9/8
 1F1g==
X-Gm-Message-State: AOJu0YxgQL65h6NjYhC5W7TspdY2SSL/pNPI1ozSMOXiKGNy7J68gkCK
 Wz3QNSz+OFuFBcZxKiSRA2QeiSYJSjaFcTiDiE61b/RwsaOYqafNTe6XMNu1qg==
X-Gm-Gg: ASbGnct8Pd5DzqLIB7W3wur/XcKDMrMVtVbGg+I7wKResZANwP85Op20BAvBAjwBLZ/
 3/Wvi/paPdm97gPYa2j0QhoHw9pPiwJBuB9FAa9nDSoU2Q0dWBr5U51ZDxp9iv0w8drg96gCmmj
 SlK2v/4th8FDLFiRkP1EOlKGi8wDJDW9HnH2AwBhUxGRzmSnsX/ouITenlBRDZOREvjoW5/2ZTH
 ZO0k5eqhxYbEA6YTQTYNgVDF7Kl9o4b9JAW0AAuP8FRX3/BRRG6CeTN8jdV+iDzR6rIlv37CSq5
 700B1oazY9Fn+Q0OmPVl1yZ52q8WJTyeG1hKh+nacpR5mCASprPAHJzysP2OlB+6flkA34UbwY2
 3Yxe+4WlR5ow1HrTFBFkQLhB1QP1vqppHcqU8q03GvztAjeGmQJB7untRDUlV8mWkG4BflDJOc5
 MzRlNHGx23hl3FdRDLSfoLSA6OfgpIUoUM3rA1RlU3wSjLVp53eIWZtYpJkFzVQ+2/BdofR9F9T
 L2okBOR5Jf1RfexneSb1DBWfCMjUdTUnHOJH7NO
X-Google-Smtp-Source: AGHT+IFKRZfJK1B1PeXtjA4EFYq3dg0Vh/40xxXelvpAwTaswmRmg1eS9ng7a1wpADzOKxUHpXQCXg==
X-Received: by 2002:a05:600c:a44:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4778fe89e93mr1050975e9.29.1763051635351; 
 Thu, 13 Nov 2025 08:33:55 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47789ffea1esm76376335e9.13.2025.11.13.08.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:33:55 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Alex.Hung@amd.com, Wenjing.Liu@amd.com, Chris.Park@amd.com,
 Yu.Wang4@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Move analog check to dce110_hwseq
Date: Thu, 13 Nov 2025 17:33:48 +0100
Message-ID: <20251113163348.137315-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113163348.137315-1-timur.kristof@gmail.com>
References: <20251113163348.137315-1-timur.kristof@gmail.com>
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

Instead of checking that the signal is analog before calling the
HWSS disable_audio_stream() function to disable audio, move
the check inside the HWSS function.

Suggested-by: Ray Wu <Ray.Wu@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++++--
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c           | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 3005115c8505..94e66d96c403 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1139,6 +1139,9 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx)
 	if (!pipe_ctx || !pipe_ctx->stream)
 		return;
 
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		return;
+
 	dc = pipe_ctx->stream->ctx->dc;
 	clk_mgr = dc->clk_mgr;
 	link_hwss = get_link_hwss(pipe_ctx->stream->link, &pipe_ctx->link_res);
@@ -1193,8 +1196,7 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->stream_res.stream_enc->funcs->stop_dp_info_packets(
 			pipe_ctx->stream_res.stream_enc);
 
-	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
-		dc->hwss.disable_audio_stream(pipe_ctx);
+	dc->hwss.disable_audio_stream(pipe_ctx);
 
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 4ddcdc222913..f7ac26598c39 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2374,8 +2374,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 			set_avmute(pipe_ctx, true);
 	}
 
-	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
-		dc->hwss.disable_audio_stream(pipe_ctx);
+	dc->hwss.disable_audio_stream(pipe_ctx);
 
 	update_psp_stream_config(pipe_ctx, true);
 	dc->hwss.blank_stream(pipe_ctx);
-- 
2.51.1


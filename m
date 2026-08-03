Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D751C55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 12:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BD510E42B;
	Mon,  3 Aug 2026 12:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4yfN0PC";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2614810E42B
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 12:41:28 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-39da69c5ba3so29706811fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785760886; x=1786365686; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bf2OTBSlM2ilge5ufYpYSFxMrcAm12wbs5ftw+KdZpk=;
 b=m4yfN0PCYXO3vE8SfscmPARU4Bg7rmKH/7s2MH1bBLoexR14182G19dQuR3gzFsQva
 3mPPnQ6jrMUlM3U6fbF8t5WwF3NcpeeJdh4HoKKHMqun/IGktJPx9QuMEADh+3U3VvsJ
 HWT/TBZcaNq+16tN+hrMdko8Fg+qYC8XD+yIOx1Mc6aVxYbnkz8gU+8ETKT/Gz60WPM1
 74KP2pahXvbE9Sigyq8IQ4LkqwL/XvADD3lTI3pe0FMA1A82sQPHjtSlVoew8EMYoEUz
 Lfg23zT0BHnVQPPLcp6DtV+MEr3iVd13nMaDAB9jdgus7Fn3MFG+zJ6BnqEd91GoO1OL
 eZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760886; x=1786365686;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bf2OTBSlM2ilge5ufYpYSFxMrcAm12wbs5ftw+KdZpk=;
 b=iQEO3qQLaFVKh6+MrAZPoWc4msVuO0UQOYXRdEF3k90DM2XotqWS4xohChGn5FGZF9
 U47xJrHhTcP3qFRxquI5Hox0fqMeBPyR8tmW0v098pD9hIejX6ZRyGU5DLeCKh51gxpM
 82noipT4CnVNVxU6Q4ESRQMSQHDSQo7VpjlRHPfIg66bKn28q3F4avuygg42Bf/JTyUP
 Cy8CxUDridpTui9gibTYpLSD28NLOy9tYWmT8pU+DlWmpIYso8A+0r/+1Ld1QVcdhhEH
 aB3lQKkLPuUjyXYe0M1FH4jajkhuf6J1xYGsH5frt/MdTP3nIay0BY7zdgkQOmd3xWZ3
 8ojQ==
X-Gm-Message-State: AOJu0Yx44nGmNUkBQh0Mp7qMUVoOnND2GbIsSoDFbzljMkB7XVqRDHZ/
 wc2EFbf8hR28GUd/CrFoThqhpIaGeYuoBHw8EoIMInu7OxhdiQs61HAk/fF+dcm+
X-Gm-Gg: AR+sD122RDTcACDcnr8lNaOKwEcqhpL396AfxNb0h/lvJeRnr18HBRYWN8gtWUzsQ0A
 GfyDYItvvxRFR/U1dL8r8B2E5cKBEe7bWjLi7asPm31IG3XbK19b9YRiOxJeE77mtopw0AhC0Bx
 A6Up68YAxVyYFyUdJpCObGuPMuanTnr3EIZ60ov7T0wc9N3O2zqd9qUKD+8OCEZuYbbfxaol40e
 eTilxPMMhrBVx+lzCHJJux32xrxP96RH4iK1ANk8yiwEaXy5L2KetjO1SsCdxf23o82heWrtFap
 ZUBh+VblOEGcmnoTnxAMPn/nQFIt4x6KGWuf8/GZrfayfZJP4QT4NEk68QFZIFMLPDDTmhqZkD0
 9aPm/w+uymAtGA6nFzI+WSYZyZA2kLUsQXSGF3vYAgfCNYNDeQrfk1SJXUa/ebFhevTJD0m5dJH
 Kjpp922PwlgYUNV3rP1XYOWxCKJ2zCxG6noaa+tHMpL0LN2BkPo6aW7rGTWD72k1yMyhCvQpdyM
 EL+H5LDFCl0WCTsHWajOHSo5TYPUfc=
X-Received: by 2002:a2e:b8d6:0:b0:39b:37b9:50f4 with SMTP id
 38308e7fff4ca-39f860ebbddmr20212551fa.8.1785760885928; 
 Mon, 03 Aug 2026 05:41:25 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f810a0592sm13369931fa.7.2026.08.03.05.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:41:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tomasz Siemek <tomasz.siemek@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Fix crash in hwss_set_output_transfer_func()
Date: Mon,  3 Aug 2026 14:41:21 +0200
Message-ID: <20260803124121.16912-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The pipe_ctx->plane_res.hubp pointer is NULL on all DCE
hardware, which causes a kernel NULL pointer dereference
on all Vega and older GPUs.

Let's add a simple NULL check.

Fixes: f879f53407f0 ("drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop pipe_ctx")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Cc: Tomasz Siemek <tomasz.siemek@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 11411fa94665..5495e493b2eb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1900,7 +1900,8 @@ void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				.xfm = pipe_ctx->plane_res.xfm,
 				.dpp = pipe_ctx->plane_res.dpp,
 				.mpc = dc->res_pool->mpc,
-				.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+				.mpcc_id = pipe_ctx->plane_res.hubp ?
+						pipe_ctx->plane_res.hubp->inst : 0,
 				.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
 				.stream = pipe_ctx->stream,
 			}
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE471F5A8CE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 23:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F3A10E0BA;
	Mon, 20 Apr 2026 23:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F9Jy3TS5";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EC510E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 23:55:09 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso14647845e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 16:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776729307; x=1777334107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GpKnBihiQfiQkRK/QIHIlA0yF7t5TBoanxJLGFynGYM=;
 b=F9Jy3TS5WTBq55Nb4fzM/zOPeETiKMoTUcNfHvA9jCDDLJNQ0bMm9fUd8jO3S/LbaF
 kRwkoesRKO3BGMRV2PPC1SOIxxoFTObtkV6R76eUAShLl0bbx2fjV+U0Ks6NsqjUbUo4
 Ojyz7Iu2TBzDHuD9TH4NYo5oTtG6FQmd9lG9LIFkx8xrK+LzVK6YGHY8mttLQeFLJGjW
 JJrAF6Z20v52p2+M50lN+ecHxqQI4/1qrhq4wWIY87JScJuYMsSTReST9Nt0xKgF1iYE
 HBPXGfb0o+o4EiWCAEPUAPI1vmy3slBWIRzg6onE7liuWCuohGmV78ROaxn86+LVQ5R7
 0hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776729307; x=1777334107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpKnBihiQfiQkRK/QIHIlA0yF7t5TBoanxJLGFynGYM=;
 b=UOhNVUnwNPN+hDDLoug+YXMypRY6n5HWcz9so2atQT1HJfU4JKh9ZOUg0kt0AB/sPZ
 xQ6D8o9pb78OI9zL6u9L6boCF9N2iKtLy5vkFmYp9c2RsZXK6CB5tqwHvlxUVcIBdYYc
 g/9r+aPbNVuCT1cEmY0vO9F4NsTY6upLUQxbM1BTB7D/2dqON9M8YP6vwyxgLv5qe2uu
 IRWSIiGULNcghDWHld+1UdZ0zRD2G+xRrWIXar1oDx/l+ZRgJoxCUc9dB7velGTY9Mb1
 lmF+11WpFwX+1Wqv5Z1OJDQR1YMPvIDGdgSlCm5TZnnOZRFg/38ZHSvMbk91pOiKrQNZ
 Vnbg==
X-Gm-Message-State: AOJu0Yx4dF4gVpxapQQRrYpU0WOQiAU7tEmNKsSVwT3FCPQb1zDs8Ayv
 arTJt++WRQYo6YVjFYtqpHrk2/yBviCzNksdDa/xu6VD/PEY/BO1dk4UnGGp/Q==
X-Gm-Gg: AeBDiesTI8+WEbYnhSOfFlB0WpQ4dKzTp4q+lMhx6obQR7x57YgK6tB9e7ZKeKqzdTg
 rNyK7pxtuwlkPqBou3gHEV4EjlUMYkjA94QVteSmqpn6Tj17Lc1iPd7Kdoq6+2J8OjeJZeI6VS4
 QKWcyMqd4bUpKBTQfiI1MMgpIpKUxUtEihHLf0WrMOXza4jtsVCqTgGDwmUySzAY6cu7WV5PCT5
 vOyU8fxgHr1OxmVedtPgdvCygsuqOxmhhECHJXg2K3FeKf1m5fk5tszwaNns4udWogUJxMlkR9D
 5r1y8RfsP7dF0SPxd6dA+wUangCd8Y2eA0rYx+Zuf0v1MRHli86esxsSqnR48I2bJLUFdHEwvjP
 rT19GK6yPDrTMuNqSAv4keMiGUqt1JXnVhVUNEuRbwrVV5FcXj3++jr7I9s62vQUPSs1Wa7T8tL
 WsTe1Z8Ed6gOQHwwJVQjJrfigbtJ7nEBPOMAppb7HlsHa4vdRcaRRY/RwCSwMduEuFVl0zs3ecw
 qiCBw==
X-Received: by 2002:a05:600c:33aa:b0:488:ae6c:42c0 with SMTP id
 5b1f17b1804b1-488fb742e7fmr139402645e9.7.1776729307243; 
 Mon, 20 Apr 2026 16:55:07 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75ab25sm102227135e9.11.2026.04.20.16.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 16:55:06 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Disable 10-bit truncation and dithering on
 DCE 6.x
Date: Tue, 21 Apr 2026 01:55:04 +0200
Message-ID: <20260420235504.17998-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

DCE 6.x doesn't support 10-bit truncation and 10-bit dithering
because the following fields are 1-bit only:
FMT_TEMPORAL_DITHER_DEPTH
FMT_SPATIAL_DITHER_DEPTH
FMT_TRUNCATE_DEPTH
Programming these fields to "2" will program them as if the
dithering option was 6-bit, resulting in sub-par picture
quality and an ugly "color banding" effect.

Note that a recent commit changed the default 10-bit dithering
option to DITHER_OPTION_SPATIAL10 which improves the picture
quality because it happens to look better, but is still not
actually supported by DCE 6.x versions.

When the color depth is 10-bit or more, just disable
any kind of dithering options on DCE 6.x.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5151
Fixes: 529cad0f945c ("drm/amd/display: Add function to set dither option")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 19526a278b2a5..1ab76c2d0f723 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5069,6 +5069,12 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 		}
 	}
 
+	if (stream->ctx->dce_version < DCE_VERSION_8_0 &&
+	    stream->timing.display_color_depth >= COLOR_DEPTH_101010) {
+		/* DCE 6.x doesn't support 10-bit truncation or dither options. */
+		option = DITHER_OPTION_DISABLE;
+	}
+
 	if (option == DITHER_OPTION_DISABLE)
 		return;
 
-- 
2.53.0


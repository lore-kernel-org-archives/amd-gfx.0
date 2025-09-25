Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D547CAC5BA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 18:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2824110E2DB;
	Thu, 25 Sep 2025 18:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NW3L2pYv";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B7010E2DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 18:45:58 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b555b0fb839so966354a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758825958; x=1759430758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwvNopWmkaIl01KbZ4oKe8B4JIM8ZonWEO3nwmX/D+c=;
 b=NW3L2pYvlc4bOUSPk3nx3nTufesu1038MQpmNp20BgTG7ZbNdiK/GnENmPaTVBPMIM
 blgsCSu2J5j2zfk7fpCNbvsi6hKquI4uFx5Xj1YjLHNGp8nYmjqkgsd/NniQsSXoY2gx
 Q0N2A52xzcwa9XxBhMNicrO3sheFEAyxmgqxmHYEg3pAmIzOEeTF7vaZ0LbaG5aYIYy3
 2yJiJvMmuhwuBprCVo7W61THKhQqfF+g5Bux7LtUkhu4WuLuDYj4jwItZzhg9H4T2LTj
 WVArehE4aP99S7pBEYpqgnPlvgm1+Ujb/awNKGnFxxCQG/xtOic8GGh0BIAknpCFzlG8
 JvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758825958; x=1759430758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwvNopWmkaIl01KbZ4oKe8B4JIM8ZonWEO3nwmX/D+c=;
 b=SKjhFZv9oE0WspqDRHpBnUZFfjfMfIGrlDqohzkBKQrZbkGzA/XQKb7KxCFVmeqRsA
 OelU9jv9xNgyak1iEevCfabtGfF1RmL9s+f0+LLS4w49OLun1/bxtklszxzJrJdnPaij
 p13O52ApPnbEQ96rZEInuy/sKgkgV8rvtMU1ptq1tioTb8DCCGfbrPs3b5A+UEDkY+M8
 L3XL/M3sU2gciVp2j/5ZYUb4hQS8DuMCFSeAiAq5nb+I5hbkAPC+gnAVCvcmk2UkydiE
 5j+uAXqyAVMSw+jk7ECtJlnT7PINGug88xCPfn67SHGZxRUraxKeL8gpY+6Ztptacyx3
 Cnvg==
X-Gm-Message-State: AOJu0YxdQaX2qUyGu/SUgZitM9SqitcIPxCuf+FzzAByPvs3BRFQYJUc
 pbM1knrQoLl5v3liFt0lsn39UwEK/sLvLEIcHegNZoBdEMqoRkrjc6c41X3pcQ==
X-Gm-Gg: ASbGncuIJ7L4FcjGW8RI0AxodKHFSA3ChGZYH/nNUck9+z6GHei8fGtidmS4PC9hNjb
 fCD2EXEDaiOmBXj5SeaAHPRg5JBEvpMdK/q8wQ5WCM0Lf1Rx71QH4NvZWYASeEvZzMqO1Y5Y7e6
 QaA8uOr5ndA6VBmfT3FWrR15VP9MOvEfOtpXJintRSLUdim0ieLDKmBjKt6Hi+8TtMl4uZ604Vl
 LR3/vd1MPUQErz0yzQ+lUlNlHwegeBAxmCSHvopXi8tlk/O9vNqkb/4s8XPiR8atOk/uk98QykX
 z3AgYei6TXuo7NBhlYHAaHu8IZRaYTBv8GIovEwVXglsdr0ewXYoKRxDlxBAfdMadhoAkqb9mV9
 xm3ST74ZYZ04qT9VQRJHS7ZEUKXl5SbFTkQWqFiB19KOgfRuek6M/lgjmUJ0gkJFhOVWGDo7fAZ
 js6tEXYGXT8rt+TV+F018HqHTf7Q==
X-Google-Smtp-Source: AGHT+IFjuxA2KBfSBBLXtUFizcsfekAxuuKdv9NDrs3VSGNbZ+XSKFziZV8mIpx436mjN2LQN7YTAw==
X-Received: by 2002:a17:902:ecc3:b0:269:4759:904b with SMTP id
 d9443c01a7336-27ed4ade041mr49744965ad.58.1758825958330; 
 Thu, 25 Sep 2025 11:45:58 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D06700C9F588200B1ECEA8.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:c9f5:8820:b1e:cea8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27eeb9a8ebfsm4244125ad.67.2025.09.25.11.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 11:45:58 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amd/display: Disable scaling on DCE6 for now
Date: Thu, 25 Sep 2025 20:45:25 +0200
Message-ID: <20250925184525.43290-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925184525.43290-1-timur.kristof@gmail.com>
References: <20250925184525.43290-1-timur.kristof@gmail.com>
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

Scaling doesn't work on DCE6 at the moment, the current
register programming produces incorrect output when using
fractional scaling (between 100-200%) on resolutions higher
than 1080p.

Disable it until we figure out how to program it properly.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 53c67ebe779f..b75be6ad64f6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -404,13 +404,13 @@ static const struct dc_plane_cap plane_cap = {
 	},
 
 	.max_upscale_factor = {
-			.argb8888 = 16000,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	},
 
 	.max_downscale_factor = {
-			.argb8888 = 250,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	}
-- 
2.51.0


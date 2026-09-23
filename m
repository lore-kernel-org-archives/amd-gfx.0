Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B597C9830C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 12:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CBC10EFF2;
	Wed, 23 Sep 2026 12:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nFqCb+Ai";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A976A10EFEF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 12:20:40 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c29d50b7cf9so113432866b.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166039; x=1790770839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bRc5uBC0QtLQpvx4O/y5uquhEOg+j17lkZnRgdotBIU=;
 b=nFqCb+Aio/NgAErjNhWTBcRP8Qiw5mTgHMKSdwxysgewS/Zz9NehsL1bNlW+uTYJ0B
 NKxBsaZb9yy93twtdoJnJGBEw0zeKooB2pk/RFLhCVgjlhbo2ubnxW0Fkt1ICWt9iYX1
 yfDioZNesPP0vnZRpKpcKqlxHqn5i+IajLNpVJuyDXrB6TR0vTHu8zstA9lhKdLh5LzV
 EqsvcVSpE/Qjjz1CD9T49rXfkkkJdQa1osJV7nfezG5eNnRuI4Poj5/OhDth9A1+y8Jk
 bgixo5DWwxN57+ZFGOGr+HWrDMoq+hRxvDMWGfMGtumUtFarX9qATVoiYxIqbi7nOzxA
 HBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166039; x=1790770839;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bRc5uBC0QtLQpvx4O/y5uquhEOg+j17lkZnRgdotBIU=;
 b=MunU228d1s334jOEI3co+mU+2Mf7mTB6HeVMBrKFNMv8BuRmpp/uyfwEGk98kIGzMd
 mMqV4gO2i/HBh8Qy+Zi/1CeKBsgrafGmiychcpITw+jLN6PNWVxD08HgZRIdjlkBbaUy
 ZSb9yqNOLdl572rTd8IzxmbexskcoSmzpzGY99RdIlT4TYYj7zsPYsKhcqAoCXRZsumK
 snsq7rWcSz/T41lRE6dr/XCkDV/bRFbCE2zoBpdb7+7aHhvXu+x5pdScZxU7OOfIIeU9
 98iDGV5hnXrpmEski6hwVD9PQCIoMFq9wO7J3BlPzPNVYoBZ2bf0KYsj4QWG+adQZGsE
 OZgw==
X-Gm-Message-State: AFuF++mc3IUzga46TAD2uPq2JXj1LE5FUR8j7e6JMHXsaFyZPPsWHP9+
 XfQVEKD2JICmRV2Pqjh7mP31XHZi/+mco/KsrVpGO3d7TpFIBcurHC0cBXTYh5GulwY=
X-Gm-Gg: AYBFou2kEKAsL6etZOhbv0eZPmoGEun0q9yXbJpATmmlwJNrDDKy5rbTdAqSn4ID5P+
 gLCezXsn50iTAEidJ4Wzz09kD4vTKJocCj/C8hm4JyUJU/KzZUq3cp0Kn8Rbgy2fNviXltNHq1K
 g5PyiOjZZuShVtU5P5YxxFIg+ccr3ZIi/GAYvIqxGsGXys9kbhOCe/oh0e1ODuKnTEF7iSFhj32
 0m/+5dC132PaluwvWrAo61/tioU8U/l6S2lrGGUYMVYAUFkP6aYB4mAvXPoqXHYTIrvVGzWX/qd
 m+2Kf3tViVbW+U0VJNvSpYFR6IyQWat45rhrUDaL1wcjm705LFHLow6hsMFcg7pISri5MOQtF76
 5iT59ZKOewYIc5rYNCFlRW97iqLQ0VWfOtYHHguwZu9s+drXs23EzdsYEKm8Z/ocANgwf3lPWH0
 Oa8xDP3rfLz8Yq7NmOIWPbMi6dJAnn2SXYuuXxPF9305g48xYhP/rJPLoYtEhiu2rbGQDfWGjuL
 mfQ1d8Z+OXO3dr6qSZt9qAcsau9zLb8T3Za
X-Received: by 2002:a17:907:c23:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c2aadfc5a0amr210294866b.6.1790166038918; 
 Wed, 23 Sep 2026 05:20:38 -0700 (PDT)
Received: from Timur-Hyperion (86FF5B49.dsl.pool.telekom.hu. [134.255.91.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae5c604fsm108284966b.13.2026.09.23.05.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:20:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: Mark DCE 6.4 as not APU
Date: Wed, 23 Sep 2026 14:20:33 +0200
Message-ID: <20260923122033.1046651-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923122033.1046651-1-timur.kristof@gmail.com>
References: <20260923122033.1046651-1-timur.kristof@gmail.com>
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

DCE 6.4 is found in Oland chips, which were advertised
as low-end gaming GPUs in 2013~2015 and then have been
sold as low-end workstation GPUs until 2017~2019.

These are not APUs.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 8612cc66a6ba..65c7dae3ff66 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -1341,7 +1341,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 	dc->debug = debug_defaults;
 	dc->check_config = config_defaults;
 
-- 
2.55.0


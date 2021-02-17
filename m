Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF82C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 22:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8CE64E33
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 22:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8CE64E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA286E222;
	Wed, 17 Feb 2021 22:51:35 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575E06E222
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 22:51:34 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id w19so291117qki.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 14:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GQoAyx3QiWmLeWDOadpFquxqf+F/Ozzk8aTB0RV/7VY=;
 b=hR3yZud7cRcF7ou/DshpBxDoS65DY+kYhJCVGgFY8KpcO0PLMnslHhY8H2jaN9roej
 FtPUw3oS2OZ4jF/a1A5GsjDImxyGGoT5JRIPbP5el0V9acy+Q9J6Pe8iQknPFyKTjzPa
 TjNtrW3kC2p5NJBOFPOX+LW3McIk+MuLWJQML3P6ioJ4WMxt6XCBaco325qLy9rqYZjP
 tCLqH30ymnjb+zl08gVMdFsRMh9KiEO6vBreNwd1yS24Z9oabQFxHWKQIJzCuSFBDHfu
 a4GN8GyfByqHL5Tdi2NkRfHwPybwdWHu3Cdb3KE8Yy+EsDYUYkU5gzcWqMznxHElZUJB
 Vv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GQoAyx3QiWmLeWDOadpFquxqf+F/Ozzk8aTB0RV/7VY=;
 b=pC+/2r/qBKLlXdtiey+EMUOdGq/yba0Ehmq7oewhLsMRHRsc2qN/4n92VLnGbnXDnU
 KgXVAUhMzphWnsyFg0AhJ41imRUHu22hweejIalFT4mfdyK89ymsN6xZutqiGfOu4HAH
 431AF1qHiVsKxWrETPxnAfvymGdTSh82gJhYZpLAIVGHya1iGMAegdEYR70zWpb0bjuZ
 REjPvnKI4r1Lmcq0jS1Oamp9vGaKmZIV8QiR+HCfeGOWpeSmDu+YaEGOyjEKhZlYYg3I
 1WxK955FDvlRO21rEQOymxhBv8HK8jAJjMlYijtzGfgceIJrDyAHxIMjichM9GuoAwAj
 q94Q==
X-Gm-Message-State: AOAM5337sSXrUFXa77GBakSEzsOcbmuf2/1cvGTH13ZjGVY9lMPDkUZF
 8OcZiSWSYDKSaxnmHwmx/ZzH4ACS+yo=
X-Google-Smtp-Source: ABdhPJyqI3/IuOcV3QJ0Jvgt9tfMi5AjCaJXxI3bmwUpJ0sEGxAEb79VSFA7iauIqxXdNe4yG6+F5w==
X-Received: by 2002:a37:707:: with SMTP id 7mr1568997qkh.127.1613602293417;
 Wed, 17 Feb 2021 14:51:33 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id c17sm2192837qtn.71.2021.02.17.14.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 14:51:33 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Allow spatial dither to 10 bpc on all DCE
Date: Wed, 17 Feb 2021 17:51:23 -0500
Message-Id: <20210217225123.2305227-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Kleiner <mario.kleiner.de@gmail.com>

Spatial dithering to 10 bpc depth was disabled for all DCE's.

Testing on DCE-8.3 and DCE-11.2 did not show any obvious ill
effects, but a measureable precision improvement (via colorimeter)
when displaying a fp16 framebuffer to a 10 bpc DP or HDMI connected
HDR-10 monitor.

v2: enable it for all DCEs (Alex)

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index 4600231da6cb..895b015b02e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -216,9 +216,7 @@ static void set_spatial_dither(
 	REG_UPDATE(FMT_BIT_DEPTH_CONTROL,
 		FMT_TEMPORAL_DITHER_EN, 0);
 
-	/* no 10bpc on DCE11*/
-	if (params->flags.SPATIAL_DITHER_ENABLED == 0 ||
-		params->flags.SPATIAL_DITHER_DEPTH == 2)
+	if (params->flags.SPATIAL_DITHER_ENABLED == 0)
 		return;
 
 	/* only use FRAME_COUNTER_MAX if frameRandom == 1*/
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

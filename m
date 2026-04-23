Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95E9FDEE48
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C77D10F27A;
	Thu, 23 Apr 2026 19:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PoyJ/rBB";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6855010F26D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:33 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d7213b6ebso4664329f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971732; x=1777576532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFzZGWTWjsjyhqWZ2KMfEiEIPmR0JlBKklkPEOf0qMM=;
 b=PoyJ/rBBFAijKgq4X5gt7vV2/yeXxs7LAWxPuegDKrtoaDXjp4Aw7LPzaQV8amJ9yv
 BOpIOll0T3DHMcMEAg7YU7oaQtESWMnFhte5TOTuJXb4gBLtWpR96Qb+U1fCAjMEB4U0
 +E4pUYfPvJx9FM5NZTRVifQbgGUEyEh6kQX843MqO5+IszPS6FBxwG7ztk6wZxa4xfJR
 hDJbvhBYurO66Ntt0VwmWci7qJX4WvVR2NFO3Ovkv/F81E74DYKnegbsBhEdVl0PRLL3
 OQJD1CLjsjzi97SoIGZNZFxKELCQBMNWpWkAnMUAWXx2+AJOeMAzu2TZN5/Ngy67rMqV
 vuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971732; x=1777576532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MFzZGWTWjsjyhqWZ2KMfEiEIPmR0JlBKklkPEOf0qMM=;
 b=QAPiXJ84vFPIaR3z8eukCH/WSNeLin0P2RRa29exwL5X0gRRFnELHATwYIHqJqT6gw
 je+mMbEol5YPhJ7yIB0XXvbWiSbgu0CBjH7x3/C5PIsu+IlYpy+cp5QWQfqeaUvSHA00
 VWSCWj4Vo6musIbf6YGOUA76GT4u3Km3V3WFgACey7sI42T+xuC3W6QyN38EoHbgUm3q
 DOR04rct90qdERu2MQMoX0hyl8HLwhJITFbDuMATE6yzn9ZfuJZXBytVZoAEdrdqCZUz
 JltVHEg+OwpyeycAb5zLKV7oZ3KDdzWrT5V9WL6WtaE4ec+tGI1OE73qZWZYix/DRcR5
 mOog==
X-Gm-Message-State: AOJu0YxjYKWAnWoULEZX9dczDbSxNaThWgtKzZ91hIebK7ANcO/xtvKP
 YSuHymfnzsG6LChYqnf8LFlrp8xoQ5xpvSWREb27Z+Xfnr39NqvBkTTw8expIznM
X-Gm-Gg: AeBDietSFOh5Xz3J2enm8lBzJBmQU7DTaXBC7nihKwHNI7ITcjaaR2uW9VbLy6hFYfR
 jeZAkY3kVPTw21egjR2HWQCkSpsYdmsI3VRk9PXQCr5iUaDvJ4oJ65hf1kWnP2Gpi8cRLH5b3Gx
 um0CbPSJqsOmPgsOa1ZtsZWaxQW+yO6IO+qlAPrwtL0nyn1Qe5SmhrHEdJXHpUgE7e68S23WUND
 SQragCQfWbheE/hzk9Rj19X3PAqDIbgEq7XijRP8gbZYXNwZEbfXCZ3EZrJfjcpawWML5JNpw8V
 4JMRvNU209l6aREUn2P1aflKHJnTO64ojSj/7kCeDAR7A81M+B4WYgTBD3Fky21pkqi2HgK/t5a
 MTNfJ6GF9+5/k2aBahPU0u6sIG4gx1Xfr604WeKOmC02aJbYg6+LGxnChioPkzE8IZd+59Fer0j
 1kHo7AWXbYVw9cdVjHcPAcv8vMwTsmOn6khp9dcVoNAvOdp2+/RG4QwK7iMPmHKdxjjwuQfv1/J
 wLbwg==
X-Received: by 2002:a05:6000:2008:b0:43d:71f4:7ed4 with SMTP id
 ffacd0b85a97d-43fe3dcafb7mr45708337f8f.15.1776971731829; 
 Thu, 23 Apr 2026 12:15:31 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/14] drm/amd/pm: Delete unused get_display_power_level()
 function
Date: Thu, 23 Apr 2026 21:15:14 +0200
Message-ID: <20260423191519.73127-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423191519.73127-1-timur.kristof@gmail.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
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

Was not called from anywhere.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  2 --
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 12 ------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 1bbf531de5ed7..ac05a12e71bdf 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -476,8 +476,6 @@ struct amd_pm_funcs {
 	u32 (*get_mclk)(void *handle, bool low);
 	int (*display_configuration_change)(void *handle,
 		const struct amd_pp_display_configuration *input);
-	int (*get_display_power_level)(void *handle,
-		struct amd_pp_simple_clock_info *output);
 	int (*get_current_clocks)(void *handle,
 		struct amd_pp_clock_info *clocks);
 	int (*get_clock_by_type)(void *handle,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 0bbb89788335e..4c2c40e8123bf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1020,17 +1020,6 @@ static int pp_display_configuration_change(void *handle,
 	return 0;
 }
 
-static int pp_get_display_power_level(void *handle,
-		struct amd_pp_simple_clock_info *output)
-{
-	struct pp_hwmgr *hwmgr = handle;
-
-	if (!hwmgr || !hwmgr->pm_en || !output)
-		return -EINVAL;
-
-	return phm_get_dal_power_level(hwmgr, output);
-}
-
 static int pp_get_current_clocks(void *handle,
 		struct amd_pp_clock_info *clocks)
 {
@@ -1588,7 +1577,6 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.get_sclk = pp_dpm_get_sclk,
 	.get_mclk = pp_dpm_get_mclk,
 	.display_configuration_change = pp_display_configuration_change,
-	.get_display_power_level = pp_get_display_power_level,
 	.get_current_clocks = pp_get_current_clocks,
 	.get_clock_by_type = pp_get_clock_by_type,
 	.get_clock_by_type_with_latency = pp_get_clock_by_type_with_latency,
-- 
2.53.0


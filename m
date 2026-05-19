Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F5DCD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC5D10EBE5;
	Tue, 19 May 2026 10:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qJLJ/EWo";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6207010EC02
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:32 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso1853900f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186091; x=1779790891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K86SWZBmW9Vhxl3PsVu2iPlaKuRPAox26Od3KuXhDbY=;
 b=qJLJ/EWoV/dwI2MPQUFlehvgDukUjw0BmN1n/24CwUcva9tFeUcW/GhjRK+ylEBuUU
 DqnoAx5lVmw95HV9CCDx21qG8NQqgZdxy2vEvEwrShJG+0AatDvaufSjc9WRwJaCYjzm
 SGcArzRDUlHXppMpSV98CHjwFciPc8GGEtFfYiHL1Ksf6BrUpTFwPWOQeqjUATryw9Pk
 /2zxPyDmy11TUrMe6OTq1KGp2TnUQfAYDhxqkcQrif38OJVbeS0L9PmH7rdzm7BB6oQc
 c2/1TJm9ZiRJy7qN4R/w3yxuyyt2WEpmz7mhz4rW+LMmdQmOeEp4nP6wRrpIQeXFU8Zu
 k6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186091; x=1779790891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K86SWZBmW9Vhxl3PsVu2iPlaKuRPAox26Od3KuXhDbY=;
 b=LPGC9BX9oaFX1QKLty7b0m3xSmP3l5GnHoMDxXVtK2H2yOFjegXnyeNhjMg8NWcUoS
 GEjtzzON1vORlC1TWSJuIXrYdP8wHAtO/O5l4cHad98IxqbVKbyOlhmUinImoVi7eU54
 5dGH+5tSlLfWBR4B9eOGL0mHRgXBEqBu6vjv5mz8sg+lofmglUGw9hjJknI0W8aIpHnO
 5cmuh5/LfOqaZGYuMnLHASgDvxMH6596FLTd1WLYaG8tkJ8fzVuzZEYQZSb8HG/H/Q4s
 T/bDCAkOFEmvmtIUCpPQXPeVH5Nf0zsTr+M7H83uVi6ychHTxz4DyLB8Wd4ZtwcyGDlc
 0Guw==
X-Gm-Message-State: AOJu0Yw3Fvb0yy5LrVTRM2t6xuUqC0RAo2sukRhhCtAVvDPQmnmBB4Mx
 HMkDCun/IkGRas+MwgMCpFvGrv+341CLseA8WWIfOqq7g/xmkv2ioCFXM/2Z5c7a
X-Gm-Gg: Acq92OEIsjlI1037CYu5SalH3d0vL4Aakq5Yu8KhFZ9CIb7ed4/Lhkf2yO3ACr/qnjZ
 RnOq4RWHxvV+dKovBDQS9kp7jdSP70vnTUvkvIwYyuMzHPlbHf9J3sXbNv1/FveMbqJlEmZRd2p
 P4ujWGjB3n3AjxuVew5yWsDxc/b9wFtY1jxG+pUoxel2RGiuVJVVN0+zpU6BcQE8pzlWRx08WVb
 kA4V6vk/NJ1IOjhc4jgAlZsl77+jNsqtwtF060yFgQHtKaPr0X2tyXyoGUcXB070wAKr3H28ITW
 kpbtdx/j+4a3X8RrS3RrRCdOM9S0wKP7J7XWib4zd2UsaiskdnJkAjZwHlc9FIjOUAs4MOaYXyb
 zBNUBHJTq3tp2BendHlG1lHs9WSCK43x4C0BrcZ2LmmP0BoevlbzJ7GxJ8Nkqo6g95rs724O1y+
 WR2lYraavCxVwY3rMb+TlWaRr781zxhmXEta7B7WDcsYHE3u3cC6MBDIBMvzVP3Rq6Ww0K1rN3n
 F4=
X-Received: by 2002:a05:6000:24c6:b0:45d:b14b:23f0 with SMTP id
 ffacd0b85a97d-45e5c36754dmr28837297f8f.15.1779186090857; 
 Tue, 19 May 2026 03:21:30 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/14] drm/amd/pm: Delete unused get_display_power_level()
 function
Date: Tue, 19 May 2026 12:21:13 +0200
Message-ID: <20260519102118.246466-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
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
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  2 --
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 12 ------------
 2 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 1bbf531de5ed..ac05a12e71bd 100644
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
index 0bbb89788335..4c2c40e8123b 100644
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
2.54.0


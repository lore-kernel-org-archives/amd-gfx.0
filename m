Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E459CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 22:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3D410E293;
	Mon, 25 Aug 2025 22:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K6bqOq9w";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0526110E293
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 22:07:41 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so26403655e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756159659; x=1756764459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5pAq+2iEZd25tyqJI1YyqAib+Lv3nWTH/LUJHOQr08=;
 b=K6bqOq9w2KaIKohs2sqOW37dzPYpZkMvcGkD33tbUJ7uCsLsZmX8vHDXiENvXvrjIw
 BkvDi44EvtKpfqKsk+WjhzsP3KP2IGFqj/eECj2ZMFwe0m0IOmKVuNrJPP3jGIS0SBmI
 s1NBHwvgzBpC9JEtnbReRiHmg1vlelMJMJPBI3gIyhItSE85DQI5+PLYZVeyXbIGAFCr
 04dmHMuZDnWXsAto00QrYuX21a7je+ndYyyhWffrzGA1EXjb0fU3kfThLqUgmD5TjAsF
 NZKeP9ccfSHGAX6ftHq9EWaqsVAVZPEaMuHfU0uoQvrLuR8MK3358rT/d0yE3izjunOS
 uIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756159659; x=1756764459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5pAq+2iEZd25tyqJI1YyqAib+Lv3nWTH/LUJHOQr08=;
 b=MkLfwswsSuXYjwCkW+UlzPydvxqlzQl+jO3/3KP3yht2Z6PKl8mh6VkapIE0qTD0cD
 buHK8+TB8+wH3DSu8vr/qwXDNzSBE3OGw2vr6Rmd2ht5bdwjWNqshswC+lxLa1p9rvse
 rtihwaow3EfZuVCws6dMiXzr44Ol4oUkPbCZj353U9gU6/oUFcwgG4+y0NNdhVYJy3T6
 7g+XRXf8Gm2RSPp7aBdKAVwunh/+bPH9BXenF9mrsymqRezpHga7A7Z40/01cPBz9rLJ
 Amb3Vw2JdIXRVCfRmoT1ztNXwu6tWwXaVyBd7BxpFl3CZK8fF+72NA35i+/a6g4KMZ5j
 MIEQ==
X-Gm-Message-State: AOJu0Yyv4el4tNjdplhKiBqydqGSGCaoLMORHcrxhj1jaYq70BsxvXoc
 NoquekEXMQFPGsVtYar816W4/dwXmE0OIMyWA29GwqYFl8VFB+fOvznp4Tv25A==
X-Gm-Gg: ASbGncvVpoK6yXO5xxKnoyjK/ftP9Ux8/vgAwOsqatrAKQjkzqDz8KNf9A3PFe2C79M
 v/b7yqs+0b3+kPQtSaBWa3FC0aGi2k5pwd+I+HAbCbmMIuKBFaCso/RueboiExAze/89+oCfXbu
 d2PcRP6xNP4En8DwE1QwtnNFvoxlOaOmmJMhHoHAcnrPP+NRWEl8ULSWu1bUtMe80sXfj/OKRtE
 hfjrdfXMER+sX5pxjBG9hnBRs1nujAwu4AcjhnFldAAltG2soyH30342rNIBy7aSV42yDuAtkz/
 LN8FOOuFZxkHFPtiuSHhemmjJ5kBGpnKMZ0Bdb42KNRsULEdMrkHflLgaa9b5WTStB9ROXDbejs
 WfZ0yxvpeG4x0JAlHVbwRKTVQoERv8NqUUooa8WwBL5mj8b+X7471JAl4FwVGkd1vJ8V2T2fxM1
 20zFxj4fxEjiH+WLO7DUQbQJOA1w==
X-Google-Smtp-Source: AGHT+IHH91qMNs46baXPDPAfKXSlw+a+DTDcUGrZT8mSFHVBgElPMCmt4dLIJcZ/uIYNvq4LDl5CkA==
X-Received: by 2002:a05:600c:5493:b0:459:eeaf:d6c7 with SMTP id
 5b1f17b1804b1-45b517c2e69mr97049095e9.26.1756159659449; 
 Mon, 25 Aug 2025 15:07:39 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66a64023sm1296395e9.1.2025.08.25.15.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:07:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/pm: Remove unneeded legacy DPM related code.
Date: Tue, 26 Aug 2025 00:07:32 +0200
Message-ID: <20250825220732.636810-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825220732.636810-1-timur.kristof@gmail.com>
References: <20250825220732.636810-1-timur.kristof@gmail.com>
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

This code isn't needed anymore as we collect the same information
into pm_display_cfg instead.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  1 -
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 74 -------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 -
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  6 --
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  3 -
 6 files changed, 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..6c28fbbb574d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -434,7 +434,6 @@ struct amdgpu_clock {
 	uint32_t default_mclk;
 	uint32_t default_sclk;
 	uint32_t default_dispclk;
-	uint32_t current_dispclk;
 	uint32_t dp_extclk;
 	uint32_t max_pixel_clock;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index e476e45b996a..a549d2ffc91f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -706,7 +706,6 @@ int amdgpu_atombios_get_clock_info(struct amdgpu_device *adev)
 		}
 		adev->clock.dp_extclk =
 			le16_to_cpu(firmware_info->info_21.usUniphyDPModeExtClkFreq);
-		adev->clock.current_dispclk = adev->clock.default_dispclk;
 
 		adev->clock.max_pixel_clock = le16_to_cpu(firmware_info->info.usMaxPixelClock);
 		if (adev->clock.max_pixel_clock == 0)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index 9ef965e4a92e..b5e9c3ecf703 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -27,80 +27,6 @@
 #include "amdgpu_smu.h"
 #include "amdgpu_dpm_internal.h"
 
-void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
-{
-	struct drm_device *ddev = adev_to_drm(adev);
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *amdgpu_crtc;
-
-	adev->pm.dpm.new_active_crtcs = 0;
-	adev->pm.dpm.new_active_crtc_count = 0;
-	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
-		list_for_each_entry(crtc,
-				    &ddev->mode_config.crtc_list, head) {
-			amdgpu_crtc = to_amdgpu_crtc(crtc);
-			if (amdgpu_crtc->enabled) {
-				adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
-				adev->pm.dpm.new_active_crtc_count++;
-			}
-		}
-	}
-}
-
-u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *amdgpu_crtc;
-	u32 vblank_in_pixels;
-	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
-
-	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			amdgpu_crtc = to_amdgpu_crtc(crtc);
-			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
-				vblank_in_pixels =
-					amdgpu_crtc->hw_mode.crtc_htotal *
-					(amdgpu_crtc->hw_mode.crtc_vblank_end -
-					amdgpu_crtc->hw_mode.crtc_vdisplay +
-					(amdgpu_crtc->v_border * 2));
-
-				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
-
-				/* we have issues with mclk switching with
-				 * refresh rates over 120 hz on the non-DC code.
-				 */
-				if (drm_mode_vrefresh(&amdgpu_crtc->hw_mode) > 120)
-					vblank_time_us = 0;
-
-				break;
-			}
-		}
-	}
-
-	return vblank_time_us;
-}
-
-u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *amdgpu_crtc;
-	u32 vrefresh = 0;
-
-	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			amdgpu_crtc = to_amdgpu_crtc(crtc);
-			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
-				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
-				break;
-			}
-		}
-	}
-
-	return vrefresh;
-}
-
 void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev)
 {
 	struct drm_device *ddev = adev_to_drm(adev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 9748744133d9..65c1d98af26c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -263,10 +263,6 @@ struct amdgpu_dpm {
 	u32                     voltage_response_time;
 	u32                     backbias_response_time;
 	void                    *priv;
-	u32			new_active_crtcs;
-	int			new_active_crtc_count;
-	u32			current_active_crtcs;
-	int			current_active_crtc_count;
 	struct amdgpu_dpm_dynamic_state dyn_state;
 	struct amdgpu_dpm_fan fan;
 	u32 tdp_limit;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
index 8be11510cd92..cc6d7ba040e9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
@@ -23,12 +23,6 @@
 #ifndef __AMDGPU_DPM_INTERNAL_H__
 #define __AMDGPU_DPM_INTERNAL_H__
 
-void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
-
-u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
-
-u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
-
 void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 3a5da3ff4d00..9e3b60b9ef28 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -944,9 +944,6 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 
 	amdgpu_dpm_post_set_power_state(adev);
 
-	adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
-	adev->pm.dpm.current_active_crtc_count = adev->pm.dpm.new_active_crtc_count;
-
 	if (pp_funcs->force_performance_level) {
 		if (adev->pm.dpm.thermal_active) {
 			enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
-- 
2.50.1


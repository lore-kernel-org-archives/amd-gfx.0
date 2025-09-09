Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455E4CAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E154B10E76A;
	Tue,  9 Sep 2025 14:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EGqv0L5e";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFE410E76A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:18:13 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2445806df50so49512415ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757427493; x=1758032293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6YFdgNBqb5ybfFha9RoFukNQ2h/vzO5vUuBbjB6ScI=;
 b=EGqv0L5eLqHZX+qBnlVy74+GCIVi1ePdFeLGzScwHVUhudxsLpe/4P4+bXhpuvt4Tk
 HPBfEDR+2b1Nrf8yOyRNP+/ITiid9sr/VnBPcZJfFo9ARopn06ti/9xcyGKzz8nyRAA+
 Dy9DnV9FDymdgGhw23RvUQimWUXU2/ZxUmaoXVzYh1BIoTGwlktUJHzA7ndCXK2Gb3Gz
 hAcx6nhcafKq7pXTIy637oGr2oYQDPDeiMDIceRxbHnsirVe0c3YFbn5lxxsQNXKRCKX
 EtzQqUD16oUBAFo9QT3IKsj+ftkeFZsPocG30kkOzVrBbzZZpStP9jBoEuj9a0NJBaLN
 ohMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757427493; x=1758032293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6YFdgNBqb5ybfFha9RoFukNQ2h/vzO5vUuBbjB6ScI=;
 b=Qv8ObqOhSVkXvobU6AaV/LYqzQvDvTRLJbk8xKnqSwAtP/Da1YOJKDsmAkvfUX920T
 fxJejZuJ1+BBHHuFmj5DAYEaGT8+tKoNxbCpHrzZkiJDT9W8WFx1MXzy8J51fUJbj8sf
 wZsR7Nct7ZvPqun6Li5xkeQwJ2AnXqg5HN0ZvBGX3RYdNbxopkxmSMcRkv4xnRYkoB/A
 XEwbuck7iomRSXuQCGML87hqHQ31ol3zXY14hiFHyB4vE6/s+EuYVUJ1AxNzQyzm5ceO
 5TegjSjgXHgp1+Al1INKZ/ml/Hq/mPNCu5BeI1Q/MsH79oAM3P8P1PJ4WqzUM3JEGEuU
 8YIw==
X-Gm-Message-State: AOJu0YwMk/CVppaWnVQwN+e8Fm3EL5xb+u/SxcX848pJPMdtqWDsl24+
 neCi+P3Q3YKXGdWJNIGuN6tIev2zt9EHLNLE8W2/VLqoLJF8+bUtgbr3xGn/2g==
X-Gm-Gg: ASbGnctDaPhOOy8PnGAqGPbOepdmQzulYXdFDXpYEp3qrSmhDgdWLiJghplV89nNFmH
 vjdlxq/mtB/T+q+9dlIMNm6B48O8MF/8BOVtNgEofIYYbHYWOBq+VEy60u+g+Ii0UeunoiuBLh1
 kAKOEAATBMg16B+nmz0ZmbRZg5CgkuOtphMoPmMjRkKNRhg8BtREbv+U9TD9ehx5D1cm2BNW5kJ
 db3yDYjTdHQvGFl/59wkIKl669OjA31qWUI7Igt0OauSPzr8nuQYb+6c7tW17rJ3BbYBZnzYyjx
 97PA+KTPZeS2WfhDY4NT5bC4jLWnV6344F/1ekOI2InR+0Sqc5007ai5xbUI+ibvuMUUVR/D4tk
 +ln3JA9ww2UP1Jj1m312nSQ/Clgyur9E4Socl2M0zbMwhv8I6uYjr8I/VpMdZtEH2aDMyRm2N5a
 2IVodZYZTu5sZ0p2ShM6OdXxE3txk=
X-Google-Smtp-Source: AGHT+IG+X68jw4zttGMe8pUN5A1pfo5a/FITIetwbDERAD/MansOwvQzhoP4EXN95pHnmy2w4NzPcQ==
X-Received: by 2002:a17:902:fc8f:b0:242:9bc4:f1ca with SMTP id
 d9443c01a7336-25175d80722mr126356095ad.57.1757427492493; 
 Tue, 09 Sep 2025 07:18:12 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D7A10085C74347BA908E23.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:85c7:4347:ba90:8e23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b1ba1718bsm196057255ad.39.2025.09.09.07.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:18:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/pm: Remove unneeded legacy DPM related code.
Date: Tue,  9 Sep 2025 16:17:52 +0200
Message-ID: <20250909141752.9517-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909141752.9517-1-timur.kristof@gmail.com>
References: <20250909141752.9517-1-timur.kristof@gmail.com>
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
index 17848ce65d1f..07bb6ca48359 100644
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
index 9dfdc08cc887..763f2b8dcf13 100644
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
index 6ebe3d0f5b87..c7ed0b457129 100644
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
2.51.0


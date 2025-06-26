Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FFAC7EE2A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 02:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D6EB10E82E;
	Thu, 26 Jun 2025 02:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccH/orCs";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (unknown [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50C410E25B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 02:39:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DE9495C6373;
 Thu, 26 Jun 2025 02:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C43C4CEEB;
 Thu, 26 Jun 2025 02:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750905539;
 bh=T+mY0wbxLDcKy44JAJQ7IYS4uo5PCDF9vbsjFCpzTqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ccH/orCstXJ2iw0irii2f36SAyVa7LPcyqu+KIPt4rwJg5DlL9AUFM+uZCPag975t
 FpPRIZgBUzLjS0B+oJh07RT7cFXKqyoorLl1ulTIE60CXrn9i0SJJmaltYmo1whL2f
 IzrI0Po+qNaXlk9xAiCBA5/AmmKqTABVJm62NSw3daD3LfIyx/13PBhNwOpeTu39n6
 sBmXzwFIrXVaeGM86hj8zVIEJ4xh8llNsj5O/EEo0FobBVptYNDp9H1pY6885yLMXm
 VU2uguaHPrxC36D6MO8O9atSEQDpw/vU5abbABdc2WfskF0xusJ5GDLxl4WFqZQoJ+
 m+p044d0Fdl1w==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
Subject: [PATCH v2 3/3] drm/amd: Change kv-dpm DRM_*() macros to drm_*()
Date: Wed, 25 Jun 2025 21:38:55 -0500
Message-ID: <20250626023855.4026084-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626023855.4026084-1-superm1@kernel.org>
References: <20250626023855.4026084-1-superm1@kernel.org>
MIME-Version: 1.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

drm_*() macros can show the device a message came from.

Cc: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 81a6134bd56de..1520b2db6d70a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1242,7 +1242,7 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
 	if (pi->bapm_enable) {
 		ret = amdgpu_kv_smc_bapm_enable(adev, enable);
 		if (ret)
-			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 	}
 }
 
@@ -1266,40 +1266,40 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 
 	ret = kv_process_firmware_header(adev);
 	if (ret) {
-		DRM_ERROR("kv_process_firmware_header failed\n");
+		drm_err(adev_to_drm(adev), "kv_process_firmware_header failed\n");
 		return ret;
 	}
 	kv_init_fps_limits(adev);
 	kv_init_graphics_levels(adev);
 	ret = kv_program_bootup_state(adev);
 	if (ret) {
-		DRM_ERROR("kv_program_bootup_state failed\n");
+		drm_err(adev_to_drm(adev), "kv_program_bootup_state failed\n");
 		return ret;
 	}
 	kv_calculate_dfs_bypass_settings(adev);
 	ret = kv_upload_dpm_settings(adev);
 	if (ret) {
-		DRM_ERROR("kv_upload_dpm_settings failed\n");
+		drm_err(adev_to_drm(adev), "kv_upload_dpm_settings failed\n");
 		return ret;
 	}
 	ret = kv_populate_uvd_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_uvd_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_uvd_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_vce_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_vce_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_vce_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_samu_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_samu_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_samu_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_acp_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_acp_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_acp_table failed\n");
 		return ret;
 	}
 	kv_program_vc(adev);
@@ -1310,39 +1310,39 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	if (pi->enable_auto_thermal_throttling) {
 		ret = kv_enable_auto_thermal_throttling(adev);
 		if (ret) {
-			DRM_ERROR("kv_enable_auto_thermal_throttling failed\n");
+			drm_err(adev_to_drm(adev), "kv_enable_auto_thermal_throttling failed\n");
 			return ret;
 		}
 	}
 	ret = kv_enable_dpm_voltage_scaling(adev);
 	if (ret) {
-		DRM_ERROR("kv_enable_dpm_voltage_scaling failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_dpm_voltage_scaling failed\n");
 		return ret;
 	}
 	ret = kv_set_dpm_interval(adev);
 	if (ret) {
-		DRM_ERROR("kv_set_dpm_interval failed\n");
+		drm_err(adev_to_drm(adev), "kv_set_dpm_interval failed\n");
 		return ret;
 	}
 	ret = kv_set_dpm_boot_state(adev);
 	if (ret) {
-		DRM_ERROR("kv_set_dpm_boot_state failed\n");
+		drm_err(adev_to_drm(adev), "kv_set_dpm_boot_state failed\n");
 		return ret;
 	}
 	ret = kv_enable_ulv(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_ulv failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_ulv failed\n");
 		return ret;
 	}
 	kv_start_dpm(adev);
 	ret = kv_enable_didt(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_didt failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_didt failed\n");
 		return ret;
 	}
 	ret = kv_enable_smc_cac(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_smc_cac failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_smc_cac failed\n");
 		return ret;
 	}
 
@@ -1350,7 +1350,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 
 	ret = amdgpu_kv_smc_bapm_enable(adev, false);
 	if (ret) {
-		DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 		return ret;
 	}
 
@@ -1358,7 +1358,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	    kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
 		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
 		if (ret) {
-			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
+			drm_err(adev_to_drm(adev), "kv_set_thermal_temperature_range failed\n");
 			return ret;
 		}
 		amdgpu_irq_get(adev, &adev->pm.dpm.thermal.irq,
@@ -1382,7 +1382,7 @@ static void kv_dpm_disable(struct amdgpu_device *adev)
 
 	err = amdgpu_kv_smc_bapm_enable(adev, false);
 	if (err)
-		DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 
 	if (adev->asic_type == CHIP_MULLINS)
 		kv_enable_nb_dpm(adev, false);
@@ -1920,7 +1920,7 @@ static int kv_dpm_set_power_state(void *handle)
 	if (pi->bapm_enable) {
 		ret = amdgpu_kv_smc_bapm_enable(adev, adev->pm.ac_power);
 		if (ret) {
-			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 			return ret;
 		}
 	}
@@ -1931,7 +1931,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_update_dfs_bypass_settings(adev, new_ps);
 			ret = kv_calculate_ds_divider(adev);
 			if (ret) {
-				DRM_ERROR("kv_calculate_ds_divider failed\n");
+				drm_err(adev_to_drm(adev), "kv_calculate_ds_divider failed\n");
 				return ret;
 			}
 			kv_calculate_nbps_level_settings(adev);
@@ -1947,7 +1947,7 @@ static int kv_dpm_set_power_state(void *handle)
 
 			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
 			if (ret) {
-				DRM_ERROR("kv_update_vce_dpm failed\n");
+				drm_err(adev_to_drm(adev), "kv_update_vce_dpm failed\n");
 				return ret;
 			}
 			kv_update_sclk_t(adev);
@@ -1960,7 +1960,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_update_dfs_bypass_settings(adev, new_ps);
 			ret = kv_calculate_ds_divider(adev);
 			if (ret) {
-				DRM_ERROR("kv_calculate_ds_divider failed\n");
+				drm_err(adev_to_drm(adev), "kv_calculate_ds_divider failed\n");
 				return ret;
 			}
 			kv_calculate_nbps_level_settings(adev);
@@ -1972,7 +1972,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_set_enabled_levels(adev);
 			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
 			if (ret) {
-				DRM_ERROR("kv_update_vce_dpm failed\n");
+				drm_err(adev_to_drm(adev), "kv_update_vce_dpm failed\n");
 				return ret;
 			}
 			kv_update_acp_boot_level(adev);
@@ -2521,7 +2521,7 @@ static int kv_set_thermal_temperature_range(struct amdgpu_device *adev,
 	if (high_temp > max_temp)
 		high_temp = max_temp;
 	if (high_temp < low_temp) {
-		DRM_ERROR("invalid thermal range: %d - %d\n", low_temp, high_temp);
+		drm_err(adev_to_drm(adev), "invalid thermal range: %d - %d\n", low_temp, high_temp);
 		return -EINVAL;
 	}
 
@@ -2563,7 +2563,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
 					      data_offset);
 
 		if (crev != 8) {
-			DRM_ERROR("Unsupported IGP table: %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unsupported IGP table: %d %d\n", frev, crev);
 			return -EINVAL;
 		}
 		pi->sys_info.bootup_sclk = le32_to_cpu(igp_info->info_8.ulBootUpEngineClock);
@@ -2579,7 +2579,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
 		else
 			pi->sys_info.htc_hyst_lmt = igp_info->info_8.ucHtcHystLmt;
 		if (pi->sys_info.htc_tmp_lmt <= pi->sys_info.htc_hyst_lmt) {
-			DRM_ERROR("The htcTmpLmt should be larger than htcHystLmt.\n");
+			drm_err(adev_to_drm(adev), "The htcTmpLmt should be larger than htcHystLmt.\n");
 		}
 
 		if (le32_to_cpu(igp_info->info_8.ulSystemConfig) & (1 << 3))
@@ -3015,13 +3015,13 @@ static int kv_dpm_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
-	DRM_INFO("amdgpu: dpm initialized\n");
+	drm_info(adev_to_drm(adev), "dpm initialized\n");
 
 	return 0;
 
 dpm_failed:
 	kv_dpm_fini(adev);
-	DRM_ERROR("amdgpu: dpm initialization failed\n");
+	drm_err(adev_to_drm(adev), "dpm initialization failed: %d\n", ret);
 	return ret;
 }
 
-- 
2.43.0


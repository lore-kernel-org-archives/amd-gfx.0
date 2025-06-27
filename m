Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793E9C7EE32
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C5310EA46;
	Fri, 27 Jun 2025 14:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tdDPm2vN";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E0910EA47
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 056D15C69D5;
 Fri, 27 Jun 2025 14:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB04BC4CEED;
 Fri, 27 Jun 2025 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751034879;
 bh=6vmK5gtQeJGuQCLWvhOBKAdR6VOdGwgqBe4zP8gU8BI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tdDPm2vNRlT0ft2VbSd3i7pvycrVrwTGcc2eDQsRZdoEU8TKUqCjQDcVFCAVpVbug
 XJ65G4mMfjHITvkuXOm3YM2mMM0cCrmQoHZYThzXo7zPjBNjLBWRo46iV/ddnjWHHX
 7Itr1+t+l1vq31pY+onheE74bjRNJ+nBsIONq3KyopDO5WXXyHE0R5NALho3nMtxVk
 X8AhrvNEaQJ1IRyVT5+efN4BDSBnHIo04L1WAc8fszFH4J39EZoo9MEjMCSdy++nxr
 KhmLRz12mJSu3e6MGMPq2SDo1Dsz3a5NclshARDA+7LoWua0HT6B62GqKpyl0DHGlZ
 9C/d7QMENcpyA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
Subject: [PATCH v3 3/3] drm/amd: Change kv-dpm DRM_*() macros to drm_*()
Date: Fri, 27 Jun 2025 09:34:32 -0500
Message-ID: <20250627143432.3222843-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627143432.3222843-1-superm1@kernel.org>
References: <20250627143432.3222843-1-superm1@kernel.org>
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 5d0b18062b8c1..307ebf7e32267 100644
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


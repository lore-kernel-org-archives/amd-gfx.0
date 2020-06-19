Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FB1C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 19:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BC1208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 19:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BC1208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC0F6E4D4;
	Fri, 19 Jun 2020 19:01:11 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23F76E430
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 18:50:22 +0000 (UTC)
Received: from localhost.localdomain (ip5f5af4f7.dynamic.kabel-deutschland.de
 [95.90.244.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9483E20643C4C;
 Fri, 19 Jun 2020 20:50:20 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/3] drm/amdgpu/kv,si: DPM: Use new print helpers
Date: Fri, 19 Jun 2020 20:50:07 +0200
Message-Id: <20200619185009.12966-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 19 Jun 2020 19:01:06 +0000
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
Untested.

 drivers/gpu/drm/amd/amdgpu/kv_dpm.c | 58 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 82 ++++++++++++++---------------
 2 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
index 4b3faaccecb9..b179bdc17cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
@@ -1252,7 +1252,7 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
 	if (pi->bapm_enable) {
 		ret = amdgpu_kv_smc_bapm_enable(adev, enable);
 		if (ret)
-			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+			drm_err(adev, "amdgpu_kv_smc_bapm_enable failed\n");
 	}
 }
 
@@ -1263,40 +1263,40 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 
 	ret = kv_process_firmware_header(adev);
 	if (ret) {
-		DRM_ERROR("kv_process_firmware_header failed\n");
+		drm_err(adev, "kv_process_firmware_header failed\n");
 		return ret;
 	}
 	kv_init_fps_limits(adev);
 	kv_init_graphics_levels(adev);
 	ret = kv_program_bootup_state(adev);
 	if (ret) {
-		DRM_ERROR("kv_program_bootup_state failed\n");
+		dev_err(adev, "kv_program_bootup_state failed\n");
 		return ret;
 	}
 	kv_calculate_dfs_bypass_settings(adev);
 	ret = kv_upload_dpm_settings(adev);
 	if (ret) {
-		DRM_ERROR("kv_upload_dpm_settings failed\n");
+		dev_err(adev, "kv_upload_dpm_settings failed\n");
 		return ret;
 	}
 	ret = kv_populate_uvd_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_uvd_table failed\n");
+		drm_err(adev, "kv_populate_uvd_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_vce_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_vce_table failed\n");
+		drm_err(adev, "kv_populate_vce_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_samu_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_samu_table failed\n");
+		drm_err(adev, "kv_populate_samu_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_acp_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_acp_table failed\n");
+		drm_err(adev, "kv_populate_acp_table failed\n");
 		return ret;
 	}
 	kv_program_vc(adev);
@@ -1307,39 +1307,39 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	if (pi->enable_auto_thermal_throttling) {
 		ret = kv_enable_auto_thermal_throttling(adev);
 		if (ret) {
-			DRM_ERROR("kv_enable_auto_thermal_throttling failed\n");
+			drm_err(adev, "kv_enable_auto_thermal_throttling failed\n");
 			return ret;
 		}
 	}
 	ret = kv_enable_dpm_voltage_scaling(adev);
 	if (ret) {
-		DRM_ERROR("kv_enable_dpm_voltage_scaling failed\n");
+		drm_err(adev, "kv_enable_dpm_voltage_scaling failed\n");
 		return ret;
 	}
 	ret = kv_set_dpm_interval(adev);
 	if (ret) {
-		DRM_ERROR("kv_set_dpm_interval failed\n");
+		drm_err(adev, "kv_set_dpm_interval failed\n");
 		return ret;
 	}
 	ret = kv_set_dpm_boot_state(adev);
 	if (ret) {
-		DRM_ERROR("kv_set_dpm_boot_state failed\n");
+		drm_err(adev, "kv_set_dpm_boot_state failed\n");
 		return ret;
 	}
 	ret = kv_enable_ulv(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_ulv failed\n");
+		drm_err(adev, "kv_enable_ulv failed\n");
 		return ret;
 	}
 	kv_start_dpm(adev);
 	ret = kv_enable_didt(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_didt failed\n");
+		drm_err(adev, "kv_enable_didt failed\n");
 		return ret;
 	}
 	ret = kv_enable_smc_cac(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_smc_cac failed\n");
+		drm_err(adev, "kv_enable_smc_cac failed\n");
 		return ret;
 	}
 
@@ -1347,7 +1347,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 
 	ret = amdgpu_kv_smc_bapm_enable(adev, false);
 	if (ret) {
-		DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+		drm_err(adev, "amdgpu_kv_smc_bapm_enable failed\n");
 		return ret;
 	}
 
@@ -1355,7 +1355,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	    amdgpu_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
 		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
 		if (ret) {
-			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
+			drm_err(adev, "kv_set_thermal_temperature_range failed\n");
 			return ret;
 		}
 		amdgpu_irq_get(adev, &adev->pm.dpm.thermal.irq,
@@ -1928,7 +1928,7 @@ static int kv_dpm_set_power_state(void *handle)
 	if (pi->bapm_enable) {
 		ret = amdgpu_kv_smc_bapm_enable(adev, adev->pm.ac_power);
 		if (ret) {
-			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+			drm_err(adev, "amdgpu_kv_smc_bapm_enable failed\n");
 			return ret;
 		}
 	}
@@ -1939,7 +1939,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_update_dfs_bypass_settings(adev, new_ps);
 			ret = kv_calculate_ds_divider(adev);
 			if (ret) {
-				DRM_ERROR("kv_calculate_ds_divider failed\n");
+				drm_err(adev, "kv_calculate_ds_divider failed\n");
 				return ret;
 			}
 			kv_calculate_nbps_level_settings(adev);
@@ -1955,7 +1955,7 @@ static int kv_dpm_set_power_state(void *handle)
 
 			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
 			if (ret) {
-				DRM_ERROR("kv_update_vce_dpm failed\n");
+				drm_err(adev, "kv_update_vce_dpm failed\n");
 				return ret;
 			}
 			kv_update_sclk_t(adev);
@@ -1968,7 +1968,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_update_dfs_bypass_settings(adev, new_ps);
 			ret = kv_calculate_ds_divider(adev);
 			if (ret) {
-				DRM_ERROR("kv_calculate_ds_divider failed\n");
+				drm_err(adev, "kv_calculate_ds_divider failed\n");
 				return ret;
 			}
 			kv_calculate_nbps_level_settings(adev);
@@ -1980,7 +1980,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_set_enabled_levels(adev);
 			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
 			if (ret) {
-				DRM_ERROR("kv_update_vce_dpm failed\n");
+				drm_err(adev, "kv_update_vce_dpm failed\n");
 				return ret;
 			}
 			kv_update_acp_boot_level(adev);
@@ -2529,7 +2529,7 @@ static int kv_set_thermal_temperature_range(struct amdgpu_device *adev,
 	if (high_temp > max_temp)
 		high_temp = max_temp;
 	if (high_temp < low_temp) {
-		DRM_ERROR("invalid thermal range: %d - %d\n", low_temp, high_temp);
+		drm_err(adev, "invalid thermal range: %d - %d\n", low_temp, high_temp);
 		return -EINVAL;
 	}
 
@@ -2571,7 +2571,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
 					      data_offset);
 
 		if (crev != 8) {
-			DRM_ERROR("Unsupported IGP table: %d %d\n", frev, crev);
+			drm_err(adev, "Unsupported IGP table: %d %d\n", frev, crev);
 			return -EINVAL;
 		}
 		pi->sys_info.bootup_sclk = le32_to_cpu(igp_info->info_8.ulBootUpEngineClock);
@@ -2587,7 +2587,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
 		else
 			pi->sys_info.htc_hyst_lmt = igp_info->info_8.ucHtcHystLmt;
 		if (pi->sys_info.htc_tmp_lmt <= pi->sys_info.htc_hyst_lmt) {
-			DRM_ERROR("The htcTmpLmt should be larger than htcHystLmt.\n");
+			drm_err(adev, "The htcTmpLmt should be larger than htcHystLmt.\n");
 		}
 
 		if (le32_to_cpu(igp_info->info_8.ulSystemConfig) & (1 << 3))
@@ -3026,14 +3026,14 @@ static int kv_dpm_sw_init(void *handle)
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
 	mutex_unlock(&adev->pm.mutex);
-	DRM_INFO("amdgpu: dpm initialized\n");
+	drm_info(adev, "amdgpu: dpm initialized\n");
 
 	return 0;
 
 dpm_failed:
 	kv_dpm_fini(adev);
 	mutex_unlock(&adev->pm.mutex);
-	DRM_ERROR("amdgpu: dpm initialization failed\n");
+	drm_err(adev, "amdgpu: dpm initialization failed\n");
 	return ret;
 }
 
@@ -3194,12 +3194,12 @@ static int kv_dpm_process_interrupt(struct amdgpu_device *adev,
 
 	switch (entry->src_id) {
 	case 230: /* thermal low to high */
-		DRM_DEBUG("IH: thermal low to high\n");
+		drm_dbg(adev, "IH: thermal low to high\n");
 		adev->pm.dpm.thermal.high_to_low = false;
 		queue_thermal = true;
 		break;
 	case 231: /* thermal high to low */
-		DRM_DEBUG("IH: thermal high to low\n");
+		drm_dbg(adev, "IH: thermal high to low\n");
 		adev->pm.dpm.thermal.high_to_low = true;
 		queue_thermal = true;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index c00ba4b23c9a..8ba673ca2f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -1932,7 +1932,7 @@ static void si_update_dte_from_pl2(struct amdgpu_device *adev,
 			dte_data->tdep_r[i] = dte_data->r[4];
 		}
 	} else {
-		DRM_ERROR("Invalid PL2! DTE will not be updated.\n");
+		drm_err(adev, "Invalid PL2! DTE will not be updated.\n");
 	}
 }
 
@@ -1994,7 +1994,7 @@ static void si_initialize_powertune_defaults(struct amdgpu_device *adev)
 			break;
 		default:
 			if (si_pi->dte_data.enable_dte_by_default == true)
-				DRM_ERROR("DTE is not enabled!\n");
+				drm_err(adev, "DTE is not enabled!\n");
 			break;
 		}
 	} else if (adev->asic_type == CHIP_PITCAIRN) {
@@ -2122,7 +2122,7 @@ static void si_initialize_powertune_defaults(struct amdgpu_device *adev)
 		si_pi->dte_data = dte_data_sun_xt;
 		update_dte_from_pl2 = true;
 	} else {
-		DRM_ERROR("Unknown SI asic revision, failed to initialize PowerTune!\n");
+		drm_err(adev, "Unknown SI asic revision, failed to initialize PowerTune!\n");
 		return;
 	}
 
@@ -6336,15 +6336,15 @@ static int si_patch_dependency_tables_based_on_leakage(struct amdgpu_device *ade
 	ret = si_patch_single_dependency_table_based_on_leakage(adev,
 								&adev->pm.dpm.dyn_state.vddc_dependency_on_sclk);
 	if (ret)
-		DRM_ERROR("Could not patch vddc_on_sclk leakage table\n");
+		drm_err(adev, "Could not patch vddc_on_sclk leakage table\n");
 	ret = si_patch_single_dependency_table_based_on_leakage(adev,
 								&adev->pm.dpm.dyn_state.vddc_dependency_on_mclk);
 	if (ret)
-		DRM_ERROR("Could not patch vddc_on_mclk leakage table\n");
+		drm_err(adev, "Could not patch vddc_on_mclk leakage table\n");
 	ret = si_patch_single_dependency_table_based_on_leakage(adev,
 								&adev->pm.dpm.dyn_state.vddci_dependency_on_mclk);
 	if (ret)
-		DRM_ERROR("Could not patch vddci_on_mclk leakage table\n");
+		drm_err(adev, "Could not patch vddci_on_mclk leakage table\n");
 	return ret;
 }
 
@@ -6405,7 +6405,7 @@ static int si_thermal_set_temperature_range(struct amdgpu_device *adev,
 	if (high_temp > max_temp)
 		high_temp = max_temp;
 	if (high_temp < low_temp) {
-		DRM_ERROR("invalid thermal range: %d - %d\n", low_temp, high_temp);
+		drm_err(adev, "invalid thermal range: %d - %d\n", low_temp, high_temp);
 		return -EINVAL;
 	}
 
@@ -6503,7 +6503,7 @@ static int si_thermal_setup_fan_table(struct amdgpu_device *adev)
 					  si_pi->sram_end);
 
 	if (ret) {
-		DRM_ERROR("Failed to load fan table to the SMC.");
+		drm_err(adev, "Failed to load fan table to the SMC.");
 		adev->pm.dpm.fan.ucode_fan_control = false;
 	}
 
@@ -6774,7 +6774,7 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	if (pi->voltage_control || si_pi->voltage_control_svi2) {
 		ret = si_construct_voltage_tables(adev);
 		if (ret) {
-			DRM_ERROR("si_construct_voltage_tables failed\n");
+			drm_err(adev, "si_construct_voltage_tables failed\n");
 			return ret;
 		}
 	}
@@ -6796,64 +6796,64 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_program_vc(adev);
 	ret = si_upload_firmware(adev);
 	if (ret) {
-		DRM_ERROR("si_upload_firmware failed\n");
+		drm_err(adev, "si_upload_firmware failed\n");
 		return ret;
 	}
 	ret = si_process_firmware_header(adev);
 	if (ret) {
-		DRM_ERROR("si_process_firmware_header failed\n");
+		drm_err(adev, "si_process_firmware_header failed\n");
 		return ret;
 	}
 	ret = si_initial_switch_from_arb_f0_to_f1(adev);
 	if (ret) {
-		DRM_ERROR("si_initial_switch_from_arb_f0_to_f1 failed\n");
+		drm_err(adev, "si_initial_switch_from_arb_f0_to_f1 failed\n");
 		return ret;
 	}
 	ret = si_init_smc_table(adev);
 	if (ret) {
-		DRM_ERROR("si_init_smc_table failed\n");
+		drm_err(adev, "si_init_smc_table failed\n");
 		return ret;
 	}
 	ret = si_init_smc_spll_table(adev);
 	if (ret) {
-		DRM_ERROR("si_init_smc_spll_table failed\n");
+		drm_err(adev, "si_init_smc_spll_table failed\n");
 		return ret;
 	}
 	ret = si_init_arb_table_index(adev);
 	if (ret) {
-		DRM_ERROR("si_init_arb_table_index failed\n");
+		drm_err(adev, "si_init_arb_table_index failed\n");
 		return ret;
 	}
 	if (eg_pi->dynamic_ac_timing) {
 		ret = si_populate_mc_reg_table(adev, boot_ps);
 		if (ret) {
-			DRM_ERROR("si_populate_mc_reg_table failed\n");
+			drm_err(adev, "si_populate_mc_reg_table failed\n");
 			return ret;
 		}
 	}
 	ret = si_initialize_smc_cac_tables(adev);
 	if (ret) {
-		DRM_ERROR("si_initialize_smc_cac_tables failed\n");
+		drm_err(adev, "si_initialize_smc_cac_tables failed\n");
 		return ret;
 	}
 	ret = si_initialize_hardware_cac_manager(adev);
 	if (ret) {
-		DRM_ERROR("si_initialize_hardware_cac_manager failed\n");
+		drm_err(adev, "si_initialize_hardware_cac_manager failed\n");
 		return ret;
 	}
 	ret = si_initialize_smc_dte_tables(adev);
 	if (ret) {
-		DRM_ERROR("si_initialize_smc_dte_tables failed\n");
+		drm_err(adev, "si_initialize_smc_dte_tables failed\n");
 		return ret;
 	}
 	ret = si_populate_smc_tdp_limits(adev, boot_ps);
 	if (ret) {
-		DRM_ERROR("si_populate_smc_tdp_limits failed\n");
+		drm_err(adev, "si_populate_smc_tdp_limits failed\n");
 		return ret;
 	}
 	ret = si_populate_smc_tdp_limits_2(adev, boot_ps);
 	if (ret) {
-		DRM_ERROR("si_populate_smc_tdp_limits_2 failed\n");
+		drm_err(adev, "si_populate_smc_tdp_limits_2 failed\n");
 		return ret;
 	}
 	si_program_response_times(adev);
@@ -6861,7 +6861,7 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_dpm_start_smc(adev);
 	ret = si_notify_smc_display_change(adev, false);
 	if (ret) {
-		DRM_ERROR("si_notify_smc_display_change failed\n");
+		drm_err(adev, "si_notify_smc_display_change failed\n");
 		return ret;
 	}
 	si_enable_sclk_control(adev, true);
@@ -6963,12 +6963,12 @@ static int si_dpm_set_power_state(void *handle)
 
 	ret = si_disable_ulv(adev);
 	if (ret) {
-		DRM_ERROR("si_disable_ulv failed\n");
+		drm_err(adev, "si_disable_ulv failed\n");
 		return ret;
 	}
 	ret = si_restrict_performance_levels_before_switch(adev);
 	if (ret) {
-		DRM_ERROR("si_restrict_performance_levels_before_switch failed\n");
+		drm_err(adev, "si_restrict_performance_levels_before_switch failed\n");
 		return ret;
 	}
 	if (eg_pi->pcie_performance_request)
@@ -6976,56 +6976,56 @@ static int si_dpm_set_power_state(void *handle)
 	ni_set_uvd_clock_before_set_eng_clock(adev, new_ps, old_ps);
 	ret = si_enable_power_containment(adev, new_ps, false);
 	if (ret) {
-		DRM_ERROR("si_enable_power_containment failed\n");
+		drm_err(adev, "si_enable_power_containment failed\n");
 		return ret;
 	}
 	ret = si_enable_smc_cac(adev, new_ps, false);
 	if (ret) {
-		DRM_ERROR("si_enable_smc_cac failed\n");
+		drm_err(adev, "si_enable_smc_cac failed\n");
 		return ret;
 	}
 	ret = si_halt_smc(adev);
 	if (ret) {
-		DRM_ERROR("si_halt_smc failed\n");
+		drm_err(adev, "si_halt_smc failed\n");
 		return ret;
 	}
 	ret = si_upload_sw_state(adev, new_ps);
 	if (ret) {
-		DRM_ERROR("si_upload_sw_state failed\n");
+		drm_err(adev, "si_upload_sw_state failed\n");
 		return ret;
 	}
 	ret = si_upload_smc_data(adev);
 	if (ret) {
-		DRM_ERROR("si_upload_smc_data failed\n");
+		drm_err(adev, "si_upload_smc_data failed\n");
 		return ret;
 	}
 	ret = si_upload_ulv_state(adev);
 	if (ret) {
-		DRM_ERROR("si_upload_ulv_state failed\n");
+		drm_err(adev, "si_upload_ulv_state failed\n");
 		return ret;
 	}
 	if (eg_pi->dynamic_ac_timing) {
 		ret = si_upload_mc_reg_table(adev, new_ps);
 		if (ret) {
-			DRM_ERROR("si_upload_mc_reg_table failed\n");
+			drm_err(adev, "si_upload_mc_reg_table failed\n");
 			return ret;
 		}
 	}
 	ret = si_program_memory_timing_parameters(adev, new_ps);
 	if (ret) {
-		DRM_ERROR("si_program_memory_timing_parameters failed\n");
+		drm_err(adev, "si_program_memory_timing_parameters failed\n");
 		return ret;
 	}
 	si_set_pcie_lane_width_in_smc(adev, new_ps, old_ps);
 
 	ret = si_resume_smc(adev);
 	if (ret) {
-		DRM_ERROR("si_resume_smc failed\n");
+		drm_err(adev, "si_resume_smc failed\n");
 		return ret;
 	}
 	ret = si_set_sw_state(adev);
 	if (ret) {
-		DRM_ERROR("si_set_sw_state failed\n");
+		drm_err(adev, "si_set_sw_state failed\n");
 		return ret;
 	}
 	ni_set_uvd_clock_after_set_eng_clock(adev, new_ps, old_ps);
@@ -7033,23 +7033,23 @@ static int si_dpm_set_power_state(void *handle)
 		si_notify_link_speed_change_after_state_change(adev, new_ps, old_ps);
 	ret = si_set_power_state_conditionally_enable_ulv(adev, new_ps);
 	if (ret) {
-		DRM_ERROR("si_set_power_state_conditionally_enable_ulv failed\n");
+		drm_err(adev, "si_set_power_state_conditionally_enable_ulv failed\n");
 		return ret;
 	}
 	ret = si_enable_smc_cac(adev, new_ps, true);
 	if (ret) {
-		DRM_ERROR("si_enable_smc_cac failed\n");
+		drm_err(adev, "si_enable_smc_cac failed\n");
 		return ret;
 	}
 	ret = si_enable_power_containment(adev, new_ps, true);
 	if (ret) {
-		DRM_ERROR("si_enable_power_containment failed\n");
+		drm_err(adev, "si_enable_power_containment failed\n");
 		return ret;
 	}
 
 	ret = si_power_control_set_level(adev);
 	if (ret) {
-		DRM_ERROR("si_power_control_set_level failed\n");
+		drm_err(adev, "si_power_control_set_level failed\n");
 		return ret;
 	}
 
@@ -7655,7 +7655,7 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s\"\n",
+		drm_err(adev, "si_smc: Failed to load firmware. err = %d\"%s\"\n",
 			  err, fw_name);
 		release_firmware(adev->pm.fw);
 		adev->pm.fw = NULL;
@@ -7703,14 +7703,14 @@ static int si_dpm_sw_init(void *handle)
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
 	mutex_unlock(&adev->pm.mutex);
-	DRM_INFO("amdgpu: dpm initialized\n");
+	drm_info(adev, "amdgpu: dpm initialized\n");
 
 	return 0;
 
 dpm_failed:
 	si_dpm_fini(adev);
 	mutex_unlock(&adev->pm.mutex);
-	DRM_ERROR("amdgpu: dpm initialization failed\n");
+	drm_err(adev, "amdgpu: dpm initialization failed\n");
 	return ret;
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

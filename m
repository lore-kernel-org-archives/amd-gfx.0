Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB32C4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 05:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E861D221E8
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 05:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFIcnNuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E861D221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661676E122;
	Thu,  1 Oct 2020 05:08:59 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF8A6E122
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 05:08:58 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id d1so3378168qtr.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 22:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8IPkPb5jsEnU/6/6yh+HU5yBxUFVToOXXACyOPVThB0=;
 b=kFIcnNuFMLvwjpmnDVzdhr/IMitiImybVjPttIqK/dedmq8w7Pj8LkBj22Y8v/uK//
 2xWpHU6sAR9uq0FN1V5K5FNCqwyxPuXkfwmMIngDc1XDIUSBI7dj7elaxqDWOkj4tVnJ
 jYH4y0nQuJbfOtyTJhdZRhEJrdnl80yuglBQT6cYEFW6BKAS2trXEBMlrUWfW9zIIK6H
 DykeQzg+HxROvWmiQxCxx3A3O6/ummYzA541PHa2JqgJEOqYc//MN0DVciLcWrd3dIwF
 bEdhr6Plq9vyye0tIke7ENaa7a0+eEUYKjTDLk17gusjAGLOaPigjIaWIC4ueMMHyFba
 YofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8IPkPb5jsEnU/6/6yh+HU5yBxUFVToOXXACyOPVThB0=;
 b=RwJSAVLgKXW2oN5DNwt5KWAZfbFD+++MIqVpNPhBBPIu2sKopZM4Oe95T5hK+44quR
 tOHPC338WSF0kF40yiDHo+XUWCGgTtnvLAc3YV8ACPeVTz93JWtRsLCIg8MdGIzpbLEz
 2IstVq2zxNBxW5jdkf8ZM++xYaHRSMrvo/lLuxvcgBW6H1p0RVEKu3mHQtDc4tuNN3nb
 LUqnpWndTDEQv1te7kZ/zKqFiUNgq2hBp0jGFIcW/GrpVmtel9q+WFmLiVPCtkiWT5DD
 llq+19iAwnXffSaf3lpff8yI+oZ/vsrNyYXuK/qBB+oy7dpXVlPw4Rc7+zmRCfXPOm/r
 fA1A==
X-Gm-Message-State: AOAM533pQn9wec7aAP2NtJKepzRLwStzVSIfnJQVwLCYkohKqeoFJBaE
 RVLCEyKaGO7ScFygW8swmBohratlVcM=
X-Google-Smtp-Source: ABdhPJwm+LUlVCYQS9iUFI6SpHS7M62haBmDHaXahHsesuCPKVwsLKBaKmIDmWJcB11zRz40p/zj0g==
X-Received: by 2002:ac8:44b5:: with SMTP id a21mr5978342qto.36.1601528937621; 
 Wed, 30 Sep 2020 22:08:57 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id f2sm4520315qkk.80.2020.09.30.22.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 22:08:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu: clean up a bunch of stale interfaces
Date: Thu,  1 Oct 2020 01:08:49 -0400
Message-Id: <20201001050849.243796-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ryan Taylor <ryan.taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These were leftover from the initial implementation, but
never used.  Drop them.

Noticed-by: Ryan Taylor <ryan.taylor@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  23 --
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   8 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  46 ----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 196 ------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   7 -
 5 files changed, 4 insertions(+), 276 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 6e575ffe34d0..deb9164eb5fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -346,13 +346,6 @@ bool dm_pp_get_clock_levels_by_type(
 			get_default_clock_levels(clk_type, dc_clks);
 			return true;
 		}
-	} else if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->get_clock_by_type) {
-		if (smu_get_clock_by_type(&adev->smu,
-					  dc_to_pp_clock_type(clk_type),
-					  &pp_clks)) {
-			get_default_clock_levels(clk_type, dc_clks);
-			return true;
-		}
 	}
 
 	pp_to_dc_clock_levels(&pp_clks, dc_clks, clk_type);
@@ -366,13 +359,6 @@ bool dm_pp_get_clock_levels_by_type(
 			validation_clks.memory_max_clock = 80000;
 			validation_clks.level = 0;
 		}
-	} else if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->get_max_high_clocks) {
-		if (smu_get_max_high_clocks(&adev->smu, &validation_clks)) {
-			DRM_INFO("DM_PPLIB: Warning: using default validation clocks!\n");
-			validation_clks.engine_max_clock = 72000;
-			validation_clks.memory_max_clock = 80000;
-			validation_clks.level = 0;
-		}
 	}
 
 	DRM_INFO("DM_PPLIB: Validation clocks:\n");
@@ -461,11 +447,6 @@ bool dm_pp_get_clock_levels_by_type_with_voltage(
 						&pp_clk_info);
 		if (ret)
 			return false;
-	} else if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->get_clock_by_type_with_voltage) {
-		if (smu_get_clock_by_type_with_voltage(&adev->smu,
-						       dc_to_pp_clock_type(clk_type),
-						       &pp_clk_info))
-			return false;
 	}
 
 	pp_to_dc_clock_levels_with_voltage(&pp_clk_info, clk_level_info, clk_type);
@@ -528,8 +509,6 @@ bool dm_pp_get_static_clocks(
 		ret = adev->powerplay.pp_funcs->get_current_clocks(
 			adev->powerplay.pp_handle,
 			&pp_clk_info);
-	else if (adev->smu.ppt_funcs)
-		ret = smu_get_current_clocks(&adev->smu, &pp_clk_info);
 	else
 		return false;
 	if (ret)
@@ -603,8 +582,6 @@ void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 
 	if (pp_funcs && pp_funcs->notify_smu_enable_pwe)
 		pp_funcs->notify_smu_enable_pwe(pp_handle);
-	else if (adev->smu.ppt_funcs)
-		smu_notify_smu_enable_pwe(&adev->smu);
 }
 
 void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index bb773e118ae8..f2c6caa154d2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1501,7 +1501,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		value = smu_get_od_percentage(&(adev->smu), SMU_OD_SCLK);
+		value = 0;
 	else if (adev->powerplay.pp_funcs->get_sclk_od)
 		value = amdgpu_dpm_get_sclk_od(adev);
 
@@ -1536,7 +1536,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		value = smu_set_od_percentage(&(adev->smu), SMU_OD_SCLK, (uint32_t)value);
+		value = 0;
 	} else {
 		if (adev->powerplay.pp_funcs->set_sclk_od)
 			amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
@@ -1574,7 +1574,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		value = smu_get_od_percentage(&(adev->smu), SMU_OD_MCLK);
+		value = 0;
 	else if (adev->powerplay.pp_funcs->get_mclk_od)
 		value = amdgpu_dpm_get_mclk_od(adev);
 
@@ -1609,7 +1609,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev)) {
-		value = smu_set_od_percentage(&(adev->smu), SMU_OD_MCLK, (uint32_t)value);
+		value = 0;
 	} else {
 		if (adev->powerplay.pp_funcs->set_mclk_od)
 			amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 85c5e8627e3b..c0287c3049cc 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -469,11 +469,6 @@ struct pptable_funcs {
 	int (*populate_umd_state_clk)(struct smu_context *smu);
 	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
 	int (*force_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t mask);
-	int (*set_default_od8_settings)(struct smu_context *smu);
-	int (*get_od_percentage)(struct smu_context *smu, enum smu_clk_type clk_type);
-	int (*set_od_percentage)(struct smu_context *smu,
-				 enum smu_clk_type clk_type,
-				 uint32_t value);
 	int (*od_edit_dpm_table)(struct smu_context *smu,
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size);
@@ -482,11 +477,6 @@ struct pptable_funcs {
 					      struct
 					      pp_clock_levels_with_latency
 					      *clocks);
-	int (*get_clock_by_type_with_voltage)(struct smu_context *smu,
-					      enum amd_pp_clock_type type,
-					      struct
-					      pp_clock_levels_with_voltage
-					      *clocks);
 	int (*get_power_profile_mode)(struct smu_context *smu, char *buf);
 	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
 	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
@@ -497,7 +487,6 @@ struct pptable_funcs {
 	int (*display_config_changed)(struct smu_context *smu);
 	int (*apply_clocks_adjust_rules)(struct smu_context *smu);
 	int (*notify_smc_display_config)(struct smu_context *smu);
-	int (*set_cpu_power_state)(struct smu_context *smu);
 	bool (*is_dpm_running)(struct smu_context *smu);
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
 	int (*set_watermarks_table)(struct smu_context *smu,
@@ -533,7 +522,6 @@ struct pptable_funcs {
 	int (*set_driver_table_location)(struct smu_context *smu);
 	int (*set_tool_table_location)(struct smu_context *smu);
 	int (*notify_memory_pool_location)(struct smu_context *smu);
-	int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
 	int (*system_features_control)(struct smu_context *smu, bool en);
 	int (*send_smc_msg_with_param)(struct smu_context *smu,
 				       enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
@@ -551,27 +539,9 @@ struct pptable_funcs {
 	int (*enable_thermal_alert)(struct smu_context *smu);
 	int (*disable_thermal_alert)(struct smu_context *smu);
 	int (*set_min_dcef_deep_sleep)(struct smu_context *smu, uint32_t clk);
-	int (*set_active_display_count)(struct smu_context *smu, uint32_t count);
-	int (*store_cc6_data)(struct smu_context *smu, uint32_t separation_time,
-			      bool cc6_disable, bool pstate_disable,
-			      bool pstate_switch_disable);
-	int (*get_clock_by_type)(struct smu_context *smu,
-				 enum amd_pp_clock_type type,
-				 struct amd_pp_clocks *clocks);
-	int (*get_max_high_clocks)(struct smu_context *smu,
-				   struct amd_pp_simple_clock_info *clocks);
 	int (*display_clock_voltage_request)(struct smu_context *smu, struct
 					     pp_display_clock_request
 					     *clock_req);
-	int (*get_dal_power_level)(struct smu_context *smu,
-				   struct amd_pp_simple_clock_info *clocks);
-	int (*get_perf_level)(struct smu_context *smu,
-			      enum smu_perf_level_designation designation,
-			      struct smu_performance_level *level);
-	int (*get_current_shallow_sleep_clocks)(struct smu_context *smu,
-						struct smu_clock_info *clocks);
-	int (*notify_smu_enable_pwe)(struct smu_context *smu);
-	int (*conv_power_profile_to_pplib_workload)(int power_profile);
 	uint32_t (*get_fan_control_mode)(struct smu_context *smu);
 	int (*set_fan_control_mode)(struct smu_context *smu, uint32_t mode);
 	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
@@ -681,8 +651,6 @@ int smu_get_power_limit(struct smu_context *smu,
 
 int smu_set_power_limit(struct smu_context *smu, uint32_t limit);
 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
-int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type type);
-int smu_set_od_percentage(struct smu_context *smu, enum smu_clk_type type, uint32_t value);
 
 int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
@@ -705,25 +673,13 @@ int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
 
-int smu_get_clock_by_type(struct smu_context *smu,
-			  enum amd_pp_clock_type type,
-			  struct amd_pp_clocks *clocks);
-
-int smu_get_max_high_clocks(struct smu_context *smu,
-			    struct amd_pp_simple_clock_info *clocks);
-
 int smu_get_clock_by_type_with_latency(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       struct pp_clock_levels_with_latency *clocks);
 
-int smu_get_clock_by_type_with_voltage(struct smu_context *smu,
-				       enum amd_pp_clock_type type,
-				       struct pp_clock_levels_with_voltage *clocks);
-
 int smu_display_clock_voltage_request(struct smu_context *smu,
 				      struct pp_display_clock_request *clock_req);
 int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disable_memory_clock_switch);
-int smu_notify_smu_enable_pwe(struct smu_context *smu);
 
 int smu_set_xgmi_pstate(struct smu_context *smu,
 			uint32_t pstate);
@@ -761,8 +717,6 @@ int smu_set_watermarks_for_clock_ranges(
 extern int smu_display_configuration_change(struct smu_context *smu, const
 					    struct amd_pp_display_configuration
 					    *display_config);
-extern int smu_get_current_clocks(struct smu_context *smu,
-				  struct amd_pp_clock_info *clocks);
 extern int smu_dpm_set_power_gate(struct smu_context *smu,uint32_t block_type, bool gate);
 extern int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d4cc2825d364..6af262e4b047 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1355,96 +1355,11 @@ int smu_display_configuration_change(struct smu_context *smu,
 			num_of_active_display++;
 	}
 
-	smu_set_active_display_count(smu, num_of_active_display);
-
-	smu_store_cc6_data(smu, display_config->cpu_pstate_separation_time,
-			   display_config->cpu_cc6_disable,
-			   display_config->cpu_pstate_disable,
-			   display_config->nb_pstate_switch_disable);
-
 	mutex_unlock(&smu->mutex);
 
 	return 0;
 }
 
-static int smu_get_clock_info(struct smu_context *smu,
-			      struct smu_clock_info *clk_info,
-			      enum smu_perf_level_designation designation)
-{
-	int ret;
-	struct smu_performance_level level = {0};
-
-	if (!clk_info)
-		return -EINVAL;
-
-	ret = smu_get_perf_level(smu, PERF_LEVEL_ACTIVITY, &level);
-	if (ret)
-		return -EINVAL;
-
-	clk_info->min_mem_clk = level.memory_clock;
-	clk_info->min_eng_clk = level.core_clock;
-	clk_info->min_bus_bandwidth = level.non_local_mem_freq * level.non_local_mem_width;
-
-	ret = smu_get_perf_level(smu, designation, &level);
-	if (ret)
-		return -EINVAL;
-
-	clk_info->min_mem_clk = level.memory_clock;
-	clk_info->min_eng_clk = level.core_clock;
-	clk_info->min_bus_bandwidth = level.non_local_mem_freq * level.non_local_mem_width;
-
-	return 0;
-}
-
-int smu_get_current_clocks(struct smu_context *smu,
-			   struct amd_pp_clock_info *clocks)
-{
-	struct amd_pp_simple_clock_info simple_clocks = {0};
-	struct smu_clock_info hw_clocks;
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	smu_get_dal_power_level(smu, &simple_clocks);
-
-	if (smu->support_power_containment)
-		ret = smu_get_clock_info(smu, &hw_clocks,
-					 PERF_LEVEL_POWER_CONTAINMENT);
-	else
-		ret = smu_get_clock_info(smu, &hw_clocks, PERF_LEVEL_ACTIVITY);
-
-	if (ret) {
-		dev_err(smu->adev->dev, "Error in smu_get_clock_info\n");
-		goto failed;
-	}
-
-	clocks->min_engine_clock = hw_clocks.min_eng_clk;
-	clocks->max_engine_clock = hw_clocks.max_eng_clk;
-	clocks->min_memory_clock = hw_clocks.min_mem_clk;
-	clocks->max_memory_clock = hw_clocks.max_mem_clk;
-	clocks->min_bus_bandwidth = hw_clocks.min_bus_bandwidth;
-	clocks->max_bus_bandwidth = hw_clocks.max_bus_bandwidth;
-	clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
-	clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
-
-        if (simple_clocks.level == 0)
-                clocks->max_clocks_state = PP_DAL_POWERLEVEL_7;
-        else
-                clocks->max_clocks_state = simple_clocks.level;
-
-        if (!smu_get_current_shallow_sleep_clocks(smu, &hw_clocks)) {
-                clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
-                clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
-        }
-
-failed:
-	mutex_unlock(&smu->mutex);
-	return ret;
-}
-
 static int smu_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
@@ -1575,9 +1490,6 @@ int smu_handle_task(struct smu_context *smu,
 	switch (task_id) {
 	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
 		ret = smu_pre_display_config_changed(smu);
-		if (ret)
-			goto out;
-		ret = smu_set_cpu_power_state(smu);
 		if (ret)
 			goto out;
 		ret = smu_adjust_power_state_dynamic(smu, level, false);
@@ -2029,40 +1941,6 @@ int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_type, ch
 	return ret;
 }
 
-int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type type)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->get_od_percentage)
-		ret = smu->ppt_funcs->get_od_percentage(smu, type);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
-int smu_set_od_percentage(struct smu_context *smu, enum smu_clk_type type, uint32_t value)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->set_od_percentage)
-		ret = smu->ppt_funcs->set_od_percentage(smu, type, value);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
 int smu_od_edit_dpm_table(struct smu_context *smu,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
@@ -2303,43 +2181,6 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 	return ret;
 }
 
-int smu_get_clock_by_type(struct smu_context *smu,
-			  enum amd_pp_clock_type type,
-			  struct amd_pp_clocks *clocks)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->get_clock_by_type)
-		ret = smu->ppt_funcs->get_clock_by_type(smu, type, clocks);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
-int smu_get_max_high_clocks(struct smu_context *smu,
-			    struct amd_pp_simple_clock_info *clocks)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->get_max_high_clocks)
-		ret = smu->ppt_funcs->get_max_high_clocks(smu, clocks);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
 int smu_get_clock_by_type_with_latency(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       struct pp_clock_levels_with_latency *clocks)
@@ -2359,26 +2200,6 @@ int smu_get_clock_by_type_with_latency(struct smu_context *smu,
 	return ret;
 }
 
-int smu_get_clock_by_type_with_voltage(struct smu_context *smu,
-				       enum amd_pp_clock_type type,
-				       struct pp_clock_levels_with_voltage *clocks)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->get_clock_by_type_with_voltage)
-		ret = smu->ppt_funcs->get_clock_by_type_with_voltage(smu, type, clocks);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
-
 int smu_display_clock_voltage_request(struct smu_context *smu,
 				      struct pp_display_clock_request *clock_req)
 {
@@ -2415,23 +2236,6 @@ int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disabl
 	return ret;
 }
 
-int smu_notify_smu_enable_pwe(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->notify_smu_enable_pwe)
-		ret = smu->ppt_funcs->notify_smu_enable_pwe(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
 int smu_set_xgmi_pstate(struct smu_context *smu,
 			uint32_t pstate)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c5adbe46ba0d..c7e1fe5f442d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -42,7 +42,6 @@
 #define smu_check_fw_version(smu)					smu_ppt_funcs(check_fw_version, 0, smu)
 #define smu_write_pptable(smu)						smu_ppt_funcs(write_pptable, 0, smu)
 #define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
-#define smu_set_active_display_count(smu, count)			smu_ppt_funcs(set_active_display_count, 0, smu, count)
 #define smu_set_driver_table_location(smu)				smu_ppt_funcs(set_driver_table_location, 0, smu)
 #define smu_set_tool_table_location(smu)				smu_ppt_funcs(set_tool_table_location, 0, smu)
 #define smu_notify_memory_pool_location(smu)				smu_ppt_funcs(notify_memory_pool_location, 0, smu)
@@ -62,7 +61,6 @@
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
-#define smu_set_default_od8_settings(smu)				smu_ppt_funcs(set_default_od8_settings, 0, smu)
 #define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
 #define smu_disable_thermal_alert(smu)					smu_ppt_funcs(disable_thermal_alert, 0, smu)
 #define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_funcs(read_sensor, -EINVAL, smu, sensor, data, size)
@@ -70,13 +68,8 @@
 #define smu_display_config_changed(smu)					smu_ppt_funcs(display_config_changed, 0 , smu)
 #define smu_apply_clocks_adjust_rules(smu)				smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
 #define smu_notify_smc_display_config(smu)				smu_ppt_funcs(notify_smc_display_config, 0, smu)
-#define smu_set_cpu_power_state(smu)					smu_ppt_funcs(set_cpu_power_state, 0, smu)
 #define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
 #define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
-#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
-#define smu_get_dal_power_level(smu, clocks)				smu_ppt_funcs(get_dal_power_level, 0, smu, clocks)
-#define smu_get_perf_level(smu, designation, level)			smu_ppt_funcs(get_perf_level, 0, smu, designation, level)
-#define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_funcs(get_current_shallow_sleep_clocks, 0, smu, clocks)
 #define smu_set_watermarks_table(smu, clock_ranges)			smu_ppt_funcs(set_watermarks_table, 0, smu, clock_ranges)
 #define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
 #define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

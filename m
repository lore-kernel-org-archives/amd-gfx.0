Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDC0D68BF0
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2024 14:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF7C10E13A;
	Sat, 16 Nov 2024 14:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4WHDRl+";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103DF10E13A
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2024 14:02:30 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4608f0b8f27so3058281cf.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2024 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731765748; x=1732370548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ur4H9K74ZOnGLax5564KIvzjBg8PRDvbdoG1RDAwZvc=;
 b=D4WHDRl+/n1UDDGAMpWbkZDyrOeIW4+syIk39bnbPGVfJwGrI6VMoMcgleYmvtXzHS
 gD81LiY+xUp9CbNJ8R3S6CCEcUhhIVPXu8X2Jlsmv7+NHlJ5G1890LW6M2Oj9qMMwpe9
 xVRR2vtwvu2yXkWer0a9Gi9ANu5gGtxO6TccuC5c4OnmSHo3XBZzUKPKXDqWXbmV1SK2
 3v+ilaTnj6/zxHQbuhOea9W3l6d6b3+4PEFy14iMpm55n+1I9V8rzvRmc1IYx6u0fwxv
 z9J3utayvtb91MIL3QnJrMRhmsdh4Lu7Q+xuqacs1fyvHBvW2L+fOqDQofkcnBUg44Ql
 YhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731765748; x=1732370548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ur4H9K74ZOnGLax5564KIvzjBg8PRDvbdoG1RDAwZvc=;
 b=TnOBroshkh8jTES45Tokl3Q5h67lyus1ofs2iGOXptdFiiO1TCATUM053quTcYZ6U9
 e8ngh9yegl0+VYfR/k0tD4fhzsrZ+73Q7Sw9Gbi7/Al5TktG2J/x5y2rAs/zmqJAMK43
 kIU8MUsb30hLuycp0ESi6WJwReHFc5xd1DDCf49uSPat9L1lIn5OvCdyGwTkSB+jxgzx
 N9XDFnFU06DBkeSMFaMKdUt14yT4QYECYUTiCtHr4D3rJ7OEKPkVihxzTIIYtG+YDt2D
 zSU51nQKYqNl8oEIgFbFrO69BJO1jYFbgHq7Qpo4G2nDq0Bn0MERIj4jqOQum1CzuOml
 0lCw==
X-Gm-Message-State: AOJu0YxA20NDthV52qIGSlTM+rALkkhMRF9A78SaYpPBp8foS8DhuMCX
 70gMswYMe5ZD7itM+Iuqa2ldFmjuGsOe3V7pblNeqeCb09JjwIF5Qy7AAKNx
X-Gm-Gg: ASbGncv8lW0sjeHxwNhdL+R+VphV+b0Zb3AtC3sDQiEgSYmlkrwnKFPa1Y5Ew9oUoqR
 RhJzDB+5BAKPPK84J/cJ6qvIYXRKsEhA9CxMoSZA2dKNry/eBBMWJGVuYpOobOx0hXL3ZOpCN28
 g7hjZtgVX3xlCtxlod662HcjvUUgf2etXcLGDuouq9VehcJbPV/UEOWODmgsXqOHfvpepYI33ux
 5OD4xk8hRkKTMViq7fYXv35la7lqabodH+tGUs+N3vgPmrQI014OhD9XzUxV9IlEKQ=
X-Google-Smtp-Source: AGHT+IH+PfgS1n7kzxZgAD1z098hX7UYi8weMgYM23OvHoHXsIf5sBxk/eS4VJ+NmD9rEqlz4VDp1A==
X-Received: by 2002:a05:622a:1a1d:b0:462:fb51:7801 with SMTP id
 d75a77b69052e-46363e31038mr39652371cf.8.1731765746680; 
 Sat, 16 Nov 2024 06:02:26 -0800 (PST)
Received: from tr4.amd.com (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9eafeesm31759161cf.31.2024.11.16.06.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 06:02:25 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix and simplify workload handling
Date: Sat, 16 Nov 2024 09:02:09 -0500
Message-ID: <20241116140209.2081056-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116140209.2081056-1-alexander.deucher@amd.com>
References: <20241116140209.2081056-1-alexander.deucher@amd.com>
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

smu->workload_mask is IP specific and should not be messed with in
the common code. The mask bits vary across SMU versions.

Move all handling of smu->workload_mask in to the backends and
simplify the code.  Store the user's preference in smu->power_profile_mode
which will be reflected in sysfs.  For internal driver profile
switches for KFD or VCN, just update the workload mask so that the
user's preference is retained.  Remove all of the extra now unused
workload related elements in the smu structure.

v2: use refcounts for workload profiles
v3: rework based on feedback from Lijo
v4: fix the refcount on failure, drop backend mask

Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 156 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  15 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 146 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 146 ++++++++--------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 145 ++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  41 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  43 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 143 ++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 117 +++++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 144 ++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  30 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   5 +
 12 files changed, 611 insertions(+), 520 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index eb1e2473b36a..d0c94f894f84 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
 static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode);
 
 static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
@@ -1268,8 +1272,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
-	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
@@ -1277,27 +1279,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
-
 	if (smu->is_apu ||
 	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	else
-		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-
-	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
-	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
-	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
-	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
-	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
@@ -2133,6 +2121,9 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	if (!ret)
 		adev->gfx.gfx_off_entrycount = count;
 
+	/* clear this on suspend so it will get reprogrammed on resume */
+	smu->workload_mask = 0;
+
 	return 0;
 }
 
@@ -2244,26 +2235,46 @@ static int smu_enable_umd_pstate(void *handle,
 	return 0;
 }
 
-static int smu_bump_power_profile_mode(struct smu_context *smu,
-					   long *param,
-					   uint32_t param_size)
+static int smu_bump_power_profile_mode(struct smu_context *smu)
 {
-	int ret = 0;
+	u32 workload_mask = 0;
+	int i, ret = 0;
+
+	for (i = 0; i < PP_SMC_POWER_PROFILE_COUNT; i++) {
+		if (smu->workload_refcount[i])
+			workload_mask |= 1 << i;
+	}
+
+	if (smu->workload_mask == workload_mask)
+		return 0;
 
 	if (smu->ppt_funcs->set_power_profile_mode)
-		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
+		ret = smu->ppt_funcs->set_power_profile_mode(smu, workload_mask);
+
+	if (!ret)
+		smu->workload_mask = workload_mask;
 
 	return ret;
 }
 
+static void smu_power_profile_mode_get(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	smu->workload_refcount[profile_mode]++;
+}
+
+static void smu_power_profile_mode_put(struct smu_context *smu,
+				       enum PP_SMC_POWER_PROFILE profile_mode)
+{
+	if (smu->workload_refcount[profile_mode])
+		smu->workload_refcount[profile_mode]--;
+}
+
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
-					  bool skip_display_settings,
-					  bool init)
+					  bool skip_display_settings)
 {
 	int ret = 0;
-	int index = 0;
-	long workload[1];
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!skip_display_settings) {
@@ -2300,14 +2311,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	}
 
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-
-		if (init || smu->power_profile_mode != workload[0])
-			smu_bump_power_profile_mode(smu, workload, 0);
-	}
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+		smu_bump_power_profile_mode(smu);
 
 	return ret;
 }
@@ -2326,13 +2331,13 @@ static int smu_handle_task(struct smu_context *smu,
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
 			return ret;
-		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, true);
 		break;
 	default:
 		break;
@@ -2354,12 +2359,11 @@ static int smu_handle_dpm_task(void *handle,
 
 static int smu_switch_power_profile(void *handle,
 				    enum PP_SMC_POWER_PROFILE type,
-				    bool en)
+				    bool enable)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	long workload[1];
-	uint32_t index;
+	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -2367,21 +2371,21 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	if (!en) {
-		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
-		index = fls(smu->workload_mask);
-		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	} else {
-		smu->workload_mask |= (1 << smu->workload_prority[type]);
-		index = fls(smu->workload_mask);
-		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-		workload[0] = smu->workload_setting[index];
-	}
-
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
-		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
-		smu_bump_power_profile_mode(smu, workload, 0);
+	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+		if (enable)
+			smu_power_profile_mode_get(smu, type);
+		else
+			smu_power_profile_mode_put(smu, type);
+		ret = smu_bump_power_profile_mode(smu);
+		if (ret) {
+			if (enable)
+				smu_power_profile_mode_put(smu, type);
+			else
+				smu_power_profile_mode_get(smu, type);
+			return ret;
+		}
+	}
 
 	return 0;
 }
@@ -3080,12 +3084,48 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
+	bool custom_changed = false;
+	int ret = 0, i;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	return smu_bump_power_profile_mode(smu, param, param_size);
+	if (param[param_size] == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (param_size > SMU_BACKEND_MAX_CUSTOM_PARAMETERS)
+			return -EINVAL;
+		/* param_size is actually a max index, not an array size */
+		for (i = 0; i <= param_size; i++) {
+			if (smu->custom_profile_input[i] != param[i]) {
+				custom_changed = true;
+				break;
+			}
+		}
+	}
+
+	if ((param[param_size] != smu->power_profile_mode) || custom_changed) {
+		/* save the parameters for custom */
+		if (custom_changed) {
+			/* param_size is actually a max index, not an array size */
+			for (i = 0; i <= param_size; i++)
+				smu->custom_profile_input[i] = param[i];
+			smu->custom_profile_size = param_size;
+			/* clear frontend mask so custom changes propogate */
+			smu->workload_mask = 0;
+		}
+		/* clear the old user preference */
+		smu_power_profile_mode_put(smu, smu->power_profile_mode);
+		/* set the new user preference */
+		smu_power_profile_mode_get(smu, param[param_size]);
+		ret = smu_bump_power_profile_mode(smu);
+		if (ret)
+			smu_power_profile_mode_put(smu, param[param_size]);
+		else
+			/* store the user's preference */
+			smu->power_profile_mode = param[param_size];
+	}
+
+	return ret;
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 06d817fb84aa..85b9079a766b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -509,6 +509,8 @@ enum smu_fw_status {
  */
 #define SMU_WBRF_EVENT_HANDLING_PACE	10
 
+#define SMU_BACKEND_MAX_CUSTOM_PARAMETERS	11
+
 struct smu_context {
 	struct amdgpu_device            *adev;
 	struct amdgpu_irq_src		irq_source;
@@ -556,11 +558,14 @@ struct smu_context {
 	uint32_t hard_min_uclk_req_from_dal;
 	bool disable_uclk_switch;
 
+	/* asic agnostic workload mask */
 	uint32_t workload_mask;
-	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
-	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
+	/* default/user workload preference */
 	uint32_t power_profile_mode;
-	uint32_t default_power_profile_mode;
+	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
+	/* backend specific custom workload settings */
+	long custom_profile_input[SMU_BACKEND_MAX_CUSTOM_PARAMETERS];
+	bool custom_profile_size;
 	bool pm_enabled;
 	bool is_apu;
 
@@ -731,9 +736,9 @@ struct pptable_funcs {
 	 * @set_power_profile_mode: Set a power profile mode. Also used to
 	 *                          create/set custom power profile modes.
 	 * &input: Power profile mode parameters.
-	 * &size: Size of &input.
+	 * &workload_mask: mask of workloads to enable
 	 */
-	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
+	int (*set_power_profile_mode)(struct smu_context *smu, u32 workload_mask);
 
 	/**
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6c8e80f6b592..06dce73e1b7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1441,98 +1441,96 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int arcturus_set_power_profile_mode(struct smu_context *smu,
-					   long *input,
-					   uint32_t size)
+static int arcturus_set_power_profile_mode_coeff(struct smu_context *smu,
+						 long *input,
+						 uint32_t size)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type = 0;
-	uint32_t profile_mode = input[size];
-	int ret = 0;
+	int ret;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
+	if (size != 10)
 		return -EINVAL;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor.Gfx_FPS = input[1];
+		activity_monitor.Gfx_UseRlcBusy = input[2];
+		activity_monitor.Gfx_MinActiveFreqType = input[3];
+		activity_monitor.Gfx_MinActiveFreq = input[4];
+		activity_monitor.Gfx_BoosterFreqType = input[5];
+		activity_monitor.Gfx_BoosterFreq = input[6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Uclk */
+		activity_monitor.Mem_FPS = input[1];
+		activity_monitor.Mem_UseRlcBusy = input[2];
+		activity_monitor.Mem_MinActiveFreqType = input[3];
+		activity_monitor.Mem_MinActiveFreq = input[4];
+		activity_monitor.Mem_BoosterFreqType = input[5];
+		activity_monitor.Mem_BoosterFreq = input[6];
+		activity_monitor.Mem_PD_Data_limit_c = input[7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
-	     (smu->smc_fw_version >= 0x360d00)) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_UseRlcBusy = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Uclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_UseRlcBusy = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int arcturus_set_power_profile_mode(struct smu_context *smu,
+					   u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-				       WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor),
-				       true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
-	}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
 
-	/*
-	 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
-	 * Not all profile modes are supported on arcturus.
-	 */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
-		return -EINVAL;
+	if (custom_enabled) {
+		ret = arcturus_set_power_profile_mode_coeff(smu,
+							    smu->custom_profile_input,
+							    smu->custom_profile_size);
+		if (ret)
+			return ret;
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetWorkloadMask,
-					  1 << workload_type,
-					  NULL);
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int arcturus_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index faa8e7d9c3c6..a53725773ad4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2006,87 +2006,99 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 	return size;
 }
 
-static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int navi10_set_power_profile_mode_coeff(struct smu_context *smu,
+					       long *input,
+					       uint32_t size)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
-	int workload_type, ret = 0;
+	int ret;
 
-	smu->power_profile_mode = input[size];
+	if (size != 10)
+		return -EINVAL;
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor.Gfx_FPS = input[1];
+		activity_monitor.Gfx_MinFreqStep = input[2];
+		activity_monitor.Gfx_MinActiveFreqType = input[3];
+		activity_monitor.Gfx_MinActiveFreq = input[4];
+		activity_monitor.Gfx_BoosterFreqType = input[5];
+		activity_monitor.Gfx_BoosterFreq = input[6];
+		activity_monitor.Gfx_PD_Data_limit_c = input[7];
+		activity_monitor.Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Socclk */
+		activity_monitor.Soc_FPS = input[1];
+		activity_monitor.Soc_MinFreqStep = input[2];
+		activity_monitor.Soc_MinActiveFreqType = input[3];
+		activity_monitor.Soc_MinActiveFreq = input[4];
+		activity_monitor.Soc_BoosterFreqType = input[5];
+		activity_monitor.Soc_BoosterFreq = input[6];
+		activity_monitor.Soc_PD_Data_limit_c = input[7];
+		activity_monitor.Soc_PD_Data_error_coeff = input[8];
+		activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 2: /* Memclk */
+		activity_monitor.Mem_FPS = input[1];
+		activity_monitor.Mem_MinFreqStep = input[2];
+		activity_monitor.Mem_MinActiveFreqType = input[3];
+		activity_monitor.Mem_MinActiveFreq = input[4];
+		activity_monitor.Mem_BoosterFreqType = input[5];
+		activity_monitor.Mem_BoosterFreq = input[6];
+		activity_monitor.Mem_PD_Data_limit_c = input[7];
+		activity_monitor.Mem_PD_Data_error_coeff = input[8];
+		activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor.Gfx_FPS = input[1];
-			activity_monitor.Gfx_MinFreqStep = input[2];
-			activity_monitor.Gfx_MinActiveFreqType = input[3];
-			activity_monitor.Gfx_MinActiveFreq = input[4];
-			activity_monitor.Gfx_BoosterFreqType = input[5];
-			activity_monitor.Gfx_BoosterFreq = input[6];
-			activity_monitor.Gfx_PD_Data_limit_c = input[7];
-			activity_monitor.Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor.Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor.Soc_FPS = input[1];
-			activity_monitor.Soc_MinFreqStep = input[2];
-			activity_monitor.Soc_MinActiveFreqType = input[3];
-			activity_monitor.Soc_MinActiveFreq = input[4];
-			activity_monitor.Soc_BoosterFreqType = input[5];
-			activity_monitor.Soc_BoosterFreq = input[6];
-			activity_monitor.Soc_PD_Data_limit_c = input[7];
-			activity_monitor.Soc_PD_Data_error_coeff = input[8];
-			activity_monitor.Soc_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor.Mem_FPS = input[1];
-			activity_monitor.Mem_MinFreqStep = input[2];
-			activity_monitor.Mem_MinActiveFreqType = input[3];
-			activity_monitor.Mem_MinActiveFreq = input[4];
-			activity_monitor.Mem_BoosterFreqType = input[5];
-			activity_monitor.Mem_BoosterFreq = input[6];
-			activity_monitor.Mem_PD_Data_limit_c = input[7];
-			activity_monitor.Mem_PD_Data_error_coeff = input[8];
-			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int navi10_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
+
+	if (custom_enabled) {
+		ret = navi10_set_power_profile_mode_coeff(smu,
+							  smu->custom_profile_input,
+							  smu->custom_profile_size);
+		if (ret)
 			return ret;
-		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 30d050a6e953..928f17ba3d1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1704,90 +1704,101 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
 	return size;
 }
 
-static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int sienna_cichlid_set_power_profile_mode_coeff(struct smu_context *smu,
+						       long *input, uint32_t size)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret;
 
-	smu->power_profile_mode = input[size];
+	if (size != 10)
+		return -EINVAL;
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinFreqStep = input[2];
+		activity_monitor->Gfx_MinActiveFreqType = input[3];
+		activity_monitor->Gfx_MinActiveFreq = input[4];
+		activity_monitor->Gfx_BoosterFreqType = input[5];
+		activity_monitor->Gfx_BoosterFreq = input[6];
+		activity_monitor->Gfx_PD_Data_limit_c = input[7];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[8];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 1: /* Socclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinFreqStep = input[2];
+		activity_monitor->Fclk_MinActiveFreqType = input[3];
+		activity_monitor->Fclk_MinActiveFreq = input[4];
+		activity_monitor->Fclk_BoosterFreqType = input[5];
+		activity_monitor->Fclk_BoosterFreq = input[6];
+		activity_monitor->Fclk_PD_Data_limit_c = input[7];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[8];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
+		break;
+	case 2: /* Memclk */
+		activity_monitor->Mem_FPS = input[1];
+		activity_monitor->Mem_MinFreqStep = input[2];
+		activity_monitor->Mem_MinActiveFreqType = input[3];
+		activity_monitor->Mem_MinActiveFreq = input[4];
+		activity_monitor->Mem_BoosterFreqType = input[5];
+		activity_monitor->Mem_BoosterFreq = input[6];
+		activity_monitor->Mem_PD_Data_limit_c = input[7];
+		activity_monitor->Mem_PD_Data_error_coeff = input[8];
+		activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
+		break;
+	default:
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 10)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinFreqStep = input[2];
-			activity_monitor->Gfx_MinActiveFreqType = input[3];
-			activity_monitor->Gfx_MinActiveFreq = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_BoosterFreq = input[6];
-			activity_monitor->Gfx_PD_Data_limit_c = input[7];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[8];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 1: /* Socclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinFreqStep = input[2];
-			activity_monitor->Fclk_MinActiveFreqType = input[3];
-			activity_monitor->Fclk_MinActiveFreq = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_BoosterFreq = input[6];
-			activity_monitor->Fclk_PD_Data_limit_c = input[7];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[8];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[9];
-			break;
-		case 2: /* Memclk */
-			activity_monitor->Mem_FPS = input[1];
-			activity_monitor->Mem_MinFreqStep = input[2];
-			activity_monitor->Mem_MinActiveFreqType = input[3];
-			activity_monitor->Mem_MinActiveFreq = input[4];
-			activity_monitor->Mem_BoosterFreqType = input[5];
-			activity_monitor->Mem_BoosterFreq = input[6];
-			activity_monitor->Mem_PD_Data_limit_c = input[7];
-			activity_monitor->Mem_PD_Data_error_coeff = input[8];
-			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
+						 u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
+
+	if (custom_enabled) {
+		ret = sienna_cichlid_set_power_profile_mode_coeff(smu,
+								  smu->custom_profile_input,
+								  smu->custom_profile_size);
+		if (ret)
 			return ret;
-		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index cd3e9ba3eff4..f9ff1eafef14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1056,42 +1056,27 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int vangogh_set_power_profile_mode(struct smu_context *smu,
+					  u32 workload_mask)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
-	}
-
-	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
-		return 0;
-
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
-					profile_mode);
-		return -EINVAL;
-	}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
-					workload_type);
+		dev_err_once(smu->adev->dev, "Fail to set workload mask 0x%08x\n",
+			     workload_mask);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index a34797f3576b..c45974150ec2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -864,44 +864,27 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int renoir_set_power_profile_mode(struct smu_context *smu,
+					 u32 workload_mask)
 {
-	int workload_type, ret;
-	uint32_t profile_mode = input[size];
+	int ret;
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
 
-	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
-		return -EINVAL;
-	}
-
-	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
-			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
-		return 0;
-
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       profile_mode);
-	if (workload_type < 0) {
-		/*
-		 * TODO: If some case need switch to powersave/default power mode
-		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
-		 */
-		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
-		return -EINVAL;
-	}
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    1 << workload_type,
-				    NULL);
+					      backend_workload_mask,
+					      NULL);
 	if (ret) {
-		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
+		dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
+			     workload_mask);
 		return ret;
 	}
 
-	smu->power_profile_mode = profile_mode;
-
-	return 0;
+	return ret;
 }
 
 static int renoir_set_peak_clock_by_device(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 199bdd9720d3..a793fee2a086 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2571,82 +2571,76 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+static int smu_v13_0_0_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input,
+						    uint32_t size)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	u32 workload_mask, selected_workload_mask;
-
-	smu->power_profile_mode = input[size];
+	int ret;
 
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (size != 9)
 		return -EINVAL;
-	}
-
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinActiveFreqType = input[2];
+		activity_monitor->Gfx_MinActiveFreq = input[3];
+		activity_monitor->Gfx_BoosterFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreq = input[5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinActiveFreqType = input[2];
+		activity_monitor->Fclk_MinActiveFreq = input[3];
+		activity_monitor->Fclk_BoosterFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreq = input[5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
+		break;
+	default:
+		return -EINVAL;
+	}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
+	return ret;
+}
 
-	if (workload_type < 0)
-		return -EINVAL;
+static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int workload_type, ret;
 
-	selected_workload_mask = workload_mask = 1 << workload_type;
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2658,15 +2652,26 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 							       CMN2ASIC_MAPPING_WORKLOAD,
 							       PP_SMC_POWER_PROFILE_POWERSAVING);
 		if (workload_type >= 0)
-			workload_mask |= 1 << workload_type;
+			backend_workload_mask |= 1 << workload_type;
+	}
+
+	if (custom_enabled) {
+		ret = smu_v13_0_0_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
+			return ret;
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       workload_mask,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = selected_workload_mask;
+					      SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask,
+					      NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 34c1e0c7e1e4..41113569057b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2530,78 +2530,87 @@ do {													\
 	return result;
 }
 
-static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
+static int smu_v13_0_7_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input, uint32_t size)
 {
 
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
+	int ret;
 
-	smu->power_profile_mode = input[size];
+	if (size != 8)
+		return -EINVAL;
 
-	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
+	}
+
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_ActiveHystLimit = input[1];
+		activity_monitor->Gfx_IdleHystLimit = input[2];
+		activity_monitor->Gfx_FPS = input[3];
+		activity_monitor->Gfx_MinActiveFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreqType = input[5];
+		activity_monitor->Gfx_MinActiveFreq = input[6];
+		activity_monitor->Gfx_BoosterFreq = input[7];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_ActiveHystLimit = input[1];
+		activity_monitor->Fclk_IdleHystLimit = input[2];
+		activity_monitor->Fclk_FPS = input[3];
+		activity_monitor->Fclk_MinActiveFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreqType = input[5];
+		activity_monitor->Fclk_MinActiveFreq = input[6];
+		activity_monitor->Fclk_BoosterFreq = input[7];
+		break;
+	default:
 		return -EINVAL;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 8)
-			return -EINVAL;
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external), true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	return ret;
+}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_ActiveHystLimit = input[1];
-			activity_monitor->Gfx_IdleHystLimit = input[2];
-			activity_monitor->Gfx_FPS = input[3];
-			activity_monitor->Gfx_MinActiveFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreqType = input[5];
-			activity_monitor->Gfx_MinActiveFreq = input[6];
-			activity_monitor->Gfx_BoosterFreq = input[7];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_ActiveHystLimit = input[1];
-			activity_monitor->Fclk_IdleHystLimit = input[2];
-			activity_monitor->Fclk_FPS = input[3];
-			activity_monitor->Fclk_MinActiveFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreqType = input[5];
-			activity_monitor->Fclk_MinActiveFreq = input[6];
-			activity_monitor->Fclk_BoosterFreq = input[7];
-			break;
-		default:
-			return -EINVAL;
-		}
+static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
 
-		ret = smu_cmn_update_table(smu,
-				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-				       (void *)(&activity_monitor_external), true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
+
+	if (custom_enabled) {
+		ret = smu_v13_0_7_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
 			return ret;
-		}
 	}
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    1 << workload_type, NULL);
+					      backend_workload_mask, NULL);
 
-	if (ret)
-		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu->workload_mask = (1 << workload_type);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 884938d69fca..90a66913dc97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1717,90 +1717,98 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
-static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
-					      long *input,
-					      uint32_t size)
+static int smu_v14_0_2_set_power_profile_mode_coeff(struct smu_context *smu,
+						    long *input,
+						    uint32_t size)
 {
 	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
-	int workload_type, ret = 0;
-	uint32_t current_profile_mode = smu->power_profile_mode;
-	smu->power_profile_mode = input[size];
+	int ret;
 
-	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
-		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
+	if (size != 9)
 		return -EINVAL;
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   false);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
+		return ret;
 	}
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size != 9)
-			return -EINVAL;
+	switch (input[0]) {
+	case 0: /* Gfxclk */
+		activity_monitor->Gfx_FPS = input[1];
+		activity_monitor->Gfx_MinActiveFreqType = input[2];
+		activity_monitor->Gfx_MinActiveFreq = input[3];
+		activity_monitor->Gfx_BoosterFreqType = input[4];
+		activity_monitor->Gfx_BoosterFreq = input[5];
+		activity_monitor->Gfx_PD_Data_limit_c = input[6];
+		activity_monitor->Gfx_PD_Data_error_coeff = input[7];
+		activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
+		break;
+	case 1: /* Fclk */
+		activity_monitor->Fclk_FPS = input[1];
+		activity_monitor->Fclk_MinActiveFreqType = input[2];
+		activity_monitor->Fclk_MinActiveFreq = input[3];
+		activity_monitor->Fclk_BoosterFreqType = input[4];
+		activity_monitor->Fclk_BoosterFreq = input[5];
+		activity_monitor->Fclk_PD_Data_limit_c = input[6];
+		activity_monitor->Fclk_PD_Data_error_coeff = input[7];
+		activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
+		break;
+	default:
+		return -EINVAL;
+	}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   false);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
-			return ret;
-		}
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
+				   WORKLOAD_PPLIB_CUSTOM_BIT,
+				   (void *)(&activity_monitor_external),
+				   true);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
+		return ret;
+	}
 
-		switch (input[0]) {
-		case 0: /* Gfxclk */
-			activity_monitor->Gfx_FPS = input[1];
-			activity_monitor->Gfx_MinActiveFreqType = input[2];
-			activity_monitor->Gfx_MinActiveFreq = input[3];
-			activity_monitor->Gfx_BoosterFreqType = input[4];
-			activity_monitor->Gfx_BoosterFreq = input[5];
-			activity_monitor->Gfx_PD_Data_limit_c = input[6];
-			activity_monitor->Gfx_PD_Data_error_coeff = input[7];
-			activity_monitor->Gfx_PD_Data_error_rate_coeff = input[8];
-			break;
-		case 1: /* Fclk */
-			activity_monitor->Fclk_FPS = input[1];
-			activity_monitor->Fclk_MinActiveFreqType = input[2];
-			activity_monitor->Fclk_MinActiveFreq = input[3];
-			activity_monitor->Fclk_BoosterFreqType = input[4];
-			activity_monitor->Fclk_BoosterFreq = input[5];
-			activity_monitor->Fclk_PD_Data_limit_c = input[6];
-			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
-			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
-			break;
-		default:
-			return -EINVAL;
-		}
+	return ret;
+}
 
-		ret = smu_cmn_update_table(smu,
-					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
-					   WORKLOAD_PPLIB_CUSTOM_BIT,
-					   (void *)(&activity_monitor_external),
-					   true);
-		if (ret) {
-			dev_err(smu->adev->dev, "[%s] Failed to set activity monitor!", __func__);
-			return ret;
-		}
-	}
+static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
+					      u32 workload_mask)
+{
+	u32 backend_workload_mask = 0;
+	bool custom_enabled = false;
+	int ret;
+
+	smu_cmn_get_backend_workload_mask(smu, workload_mask,
+					  &backend_workload_mask,
+					  &custom_enabled);
 
-	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	/* disable deep sleep if compute is enabled */
+	if (workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE))
 		smu_v14_0_deep_sleep_control(smu, false);
-	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
+	else
 		smu_v14_0_deep_sleep_control(smu, true);
 
-	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
-	workload_type = smu_cmn_to_asic_specific_index(smu,
-						       CMN2ASIC_MAPPING_WORKLOAD,
-						       smu->power_profile_mode);
-	if (workload_type < 0)
-		return -EINVAL;
+	if (custom_enabled) {
+		ret = smu_v14_0_2_set_power_profile_mode_coeff(smu,
+							       smu->custom_profile_input,
+							       smu->custom_profile_size);
+		if (ret)
+			return ret;
+	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
-					       NULL);
-	if (!ret)
-		smu->workload_mask = 1 << workload_type;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+					      backend_workload_mask, NULL);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
+			workload_mask);
+		return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 007a81e108ec..9551c6f69c34 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1221,3 +1221,33 @@ void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy)
 {
 	policy->desc = &xgmi_plpd_policy_desc;
 }
+
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask,
+				       bool *custom_enabled)
+{
+	int workload_type;
+	u32 profile_mode;
+
+	*custom_enabled = false;
+	*backend_workload_mask = 0;
+
+	for (profile_mode = 0; profile_mode < PP_SMC_POWER_PROFILE_COUNT; profile_mode++) {
+		if (!(workload_mask & (1 << profile_mode)))
+			continue;
+
+		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       profile_mode);
+
+		if (workload_type < 0)
+			continue;
+
+		*backend_workload_mask |= 1 << workload_type;
+
+		if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM)
+			*custom_enabled = true;
+	}
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 1de685defe85..8d40c02efa00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -147,5 +147,10 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
 
+void smu_cmn_get_backend_workload_mask(struct smu_context *smu,
+				       u32 workload_mask,
+				       u32 *backend_workload_mask,
+				       bool *custom_enabled);
+
 #endif
 #endif
-- 
2.47.0


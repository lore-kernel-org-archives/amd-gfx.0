Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 22:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FFC64DD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 22:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FFC64DD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629E56E81B;
	Wed, 27 Jan 2021 22:41:16 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622656E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 22:41:14 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id n15so3491895qkh.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 14:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GBc7RfsFjHd17+5HgQtV9eLcerYZreLdPR/WVARqObg=;
 b=KStvTIZmjKYwr8/d36KPNxsYOImbbB7OLd2I/BpPcT0unY8XBqn1zQ1J7ZsF0jy9mu
 6+rwu6IhLnEeN5Q5R4xzU4Kva/EwkGASozZRN5p8uG9kq4nmSKf/RO7s+XU0UxLXTn9b
 ZpAkDkhl89wdw6+DBSd/S1OcHia9k6cpokE5/t1YadwB6ESy06x/bvKdRaV0Hxuz/zgZ
 +KFSH8tMtyH7gWoVmLKv1cbDcX61xKmUCsWJRq6vVLFP8OOuKBg6oUgexOK1iRXrSNRZ
 PWdIqnrgebpkLaEAUviamC2vq2radgimJh69/iWcJRzXedOfMYqfwC6w6mGBkZNaPv5B
 4rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GBc7RfsFjHd17+5HgQtV9eLcerYZreLdPR/WVARqObg=;
 b=f6MPRmObA4qUYMZB/CiapBkAwVT3R8HpTPAf+2Y3mzluw2YSPRgvZ4Jd+FjFx+Kjtj
 P6/uWmakchuoamBtH7EvbRSshFGgLr7LkBwEkr2vDrhs/JrRHgp6IbgwJ0lT2Uhem9uC
 26xAVlQ/PU3xW+8iV5hmnlJHd+cOlX5NotqFFOSFHNBtJEEomsHPSNh48FlRRFmavLCG
 80ADPCeISXavA0ZhwaxPiQEJbER4Yvd//OuhZswIz9BmKOvunCUteCtTW3LBoR0aM8r/
 3U6ULC4PRo2lan4Dbh0sE4R5IctFuTSP4h1eIMb43ley4QhBnZ9BFhMUBBfd2fvwkoMW
 hJnQ==
X-Gm-Message-State: AOAM5316wUio/B65aNj4RXU02ySknm9MYoKlCBs64M4kgz7dRENVgAsk
 src3a+4hYVLtIEE1TPmRHf/sJ+yboPg=
X-Google-Smtp-Source: ABdhPJzOIRbpoFn6XGCMHOa6YemATHxkepw8wRpi3Bn7uxR6VkZCojLR3q1PzQJ6a1jkd6VCHK9ngQ==
X-Received: by 2002:a37:455:: with SMTP id 82mr13412502qke.490.1611787273173; 
 Wed, 27 Jan 2021 14:41:13 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id x74sm2073580qkb.55.2021.01.27.14.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 14:41:12 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu: use percent rather than rpm for manual fan
 control
Date: Wed, 27 Jan 2021 17:40:52 -0500
Message-Id: <20210127224052.3957-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some boards the rpm interface apparently does not work at all
leading to the fan not spinning or spinning at strange speeds.
Both interfaces work properly on the boards I have.
Let's try and use the percent interface instead.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1408
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 12 +--
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  7 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 35 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 ++++--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 26 ++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 26 ++++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 89 +++++++------------
 7 files changed, 117 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 631a36a75ae3..44279c2afccb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -173,7 +173,7 @@ enum smu_memory_pool_size
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
 	uint32_t power_limit;
-	uint32_t fan_speed_rpm;
+	uint32_t fan_speed_percent;
 	uint32_t flags;
 
 	/* user clock state information */
@@ -472,7 +472,7 @@ struct smu_context
 	struct work_struct interrupt_work;
 
 	unsigned fan_max_rpm;
-	unsigned manual_fan_speed_rpm;
+	unsigned manual_fan_speed_percent;
 
 	uint32_t gfx_default_hard_min_freq;
 	uint32_t gfx_default_soft_max_freq;
@@ -648,9 +648,9 @@ struct pptable_funcs {
 	bool (*is_dpm_running)(struct smu_context *smu);
 
 	/**
-	 * @get_fan_speed_rpm: Get the current fan speed in RPM.
+	 * @get_fan_speed_percent: Get the current fan speed in percent.
 	 */
-	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
+	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
 
 	/**
 	 * @set_watermarks_table: Configure and upload the watermarks tables to
@@ -951,9 +951,9 @@ struct pptable_funcs {
 	int (*set_fan_control_mode)(struct smu_context *smu, uint32_t mode);
 
 	/**
-	 * @set_fan_speed_rpm: Set a static fan speed in RPM.
+	 * @set_fan_speed_percent: Set a static fan speed in percent.
 	 */
-	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
+	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);
 
 	/**
 	 * @set_xgmi_pstate: Set inter-chip global memory interconnect pstate.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 102a0cf12d7a..c7d57e9555cc 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -203,11 +203,8 @@ int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode);
 
-int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
-				       uint32_t speed);
-
-int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
-				uint32_t *speed);
+int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
+				    uint32_t speed);
 
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f958b02f9317..1c7ac81fe417 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -368,8 +368,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 			return;
 		}
 
-		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
-			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
+		if (!ret && smu->user_dpm_profile.fan_speed_percent) {
+			ret = smu_set_fan_speed_percent(smu, smu->user_dpm_profile.fan_speed_percent);
 			if (ret)
 				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
 		}
@@ -2025,6 +2025,7 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 
 int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 {
+	u32 percent;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2032,10 +2033,11 @@ int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_rpm) {
-		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
+	if (smu->ppt_funcs->set_fan_speed_percent) {
+		percent = speed * 100 / smu->fan_max_rpm;
+		ret = smu->ppt_funcs->set_fan_speed_percent(smu, percent);
 		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
-			smu->user_dpm_profile.fan_speed_rpm = speed;
+			smu->user_dpm_profile.fan_speed_percent = percent;
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2270,7 +2272,7 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
 			smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
-		smu->user_dpm_profile.fan_speed_rpm = 0;
+		smu->user_dpm_profile.fan_speed_percent = 0;
 
 	return ret;
 }
@@ -2279,17 +2281,15 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 {
 	int ret = 0;
 	uint32_t percent;
-	uint32_t current_rpm;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_rpm) {
-		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, &current_rpm);
+	if (smu->ppt_funcs->get_fan_speed_percent) {
+		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
 		if (!ret) {
-			percent = current_rpm * 100 / smu->fan_max_rpm;
 			*speed = percent > 100 ? 100 : percent;
 		}
 	}
@@ -2303,18 +2303,18 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 {
 	int ret = 0;
-	uint32_t rpm;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_rpm) {
+	if (smu->ppt_funcs->set_fan_speed_percent) {
 		if (speed > 100)
 			speed = 100;
-		rpm = speed * smu->fan_max_rpm / 100;
-		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, rpm);
+		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
+		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+			smu->user_dpm_profile.fan_speed_percent = speed;
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2325,14 +2325,17 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
 {
 	int ret = 0;
+	u32 percent;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_rpm)
-		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
+	if (smu->ppt_funcs->get_fan_speed_percent) {
+		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
+		*speed = percent * smu->fan_max_rpm / 100;
+	}
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index cd7b411457ff..f0cc4de9ced5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1080,15 +1080,27 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
-static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
-				      uint32_t *speed)
+static int arcturus_get_fan_speed_percent(struct smu_context *smu,
+					  uint32_t *speed)
 {
+	int ret;
+	u32 rpm;
+
 	if (!speed)
 		return -EINVAL;
 
-	return arcturus_get_smu_metrics_data(smu,
-					     METRICS_CURR_FANSPEED,
-					     speed);
+	switch (smu_v11_0_get_fan_control_mode(smu)) {
+	case AMD_FAN_CTRL_AUTO:
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_CURR_FANSPEED,
+						    &rpm);
+		if (!ret && smu->fan_max_rpm)
+			*speed = rpm * 100 / smu->fan_max_rpm;
+		return ret;
+	default:
+		*speed = smu->user_dpm_profile.fan_speed_percent;
+		return 0;
+	}
 }
 
 static int arcturus_get_fan_parameters(struct smu_context *smu)
@@ -2281,7 +2293,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.print_clk_levels = arcturus_print_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
-	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
+	.get_fan_speed_percent = arcturus_get_fan_speed_percent,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
 	.set_performance_level = arcturus_set_performance_level,
@@ -2326,7 +2338,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
+	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..f7f78daffd27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1317,15 +1317,27 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int navi10_get_fan_speed_rpm(struct smu_context *smu,
-				    uint32_t *speed)
+static int navi10_get_fan_speed_percent(struct smu_context *smu,
+					uint32_t *speed)
 {
+	int ret;
+	u32 rpm;
+
 	if (!speed)
 		return -EINVAL;
 
-	return navi10_get_smu_metrics_data(smu,
-					   METRICS_CURR_FANSPEED,
-					   speed);
+	switch (smu_v11_0_get_fan_control_mode(smu)) {
+	case AMD_FAN_CTRL_AUTO:
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_CURR_FANSPEED,
+						  &rpm);
+		if (!ret && smu->fan_max_rpm)
+			*speed = rpm * 100 / smu->fan_max_rpm;
+		return ret;
+	default:
+		*speed = smu->user_dpm_profile.fan_speed_percent;
+		return 0;
+	}
 }
 
 static int navi10_get_fan_parameters(struct smu_context *smu)
@@ -2413,7 +2425,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_config_changed = navi10_display_config_changed,
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
-	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
+	.get_fan_speed_percent = navi10_get_fan_speed_percent,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
 	.set_watermarks_table = navi10_set_watermarks_table,
@@ -2456,7 +2468,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
+	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 24f3c96a5e5e..e3ba40d9f83f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1237,15 +1237,27 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
-				    uint32_t *speed)
+static int sienna_cichlid_get_fan_speed_percent(struct smu_context *smu,
+						uint32_t *speed)
 {
+	int ret;
+	u32 rpm;
+
 	if (!speed)
 		return -EINVAL;
 
-	return sienna_cichlid_get_smu_metrics_data(smu,
-						METRICS_CURR_FANSPEED,
-						speed);
+	switch (smu_v11_0_get_fan_control_mode(smu)) {
+	case AMD_FAN_CTRL_AUTO:
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_CURR_FANSPEED,
+							  &rpm);
+		if (!ret && smu->fan_max_rpm)
+			*speed = rpm * 100 / smu->fan_max_rpm;
+		return ret;
+	default:
+		*speed = smu->user_dpm_profile.fan_speed_percent;
+		return 0;
+	}
 }
 
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
@@ -3087,7 +3099,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_config_changed = sienna_cichlid_display_config_changed,
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
-	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
+	.get_fan_speed_percent = sienna_cichlid_get_fan_speed_percent,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
@@ -3130,7 +3142,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
+	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..cf6176afd4d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1137,10 +1137,10 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 uint32_t
 smu_v11_0_get_fan_control_mode(struct smu_context *smu)
 {
-	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
-		return AMD_FAN_CTRL_MANUAL;
-	else
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
 		return AMD_FAN_CTRL_AUTO;
+	else
+		return smu->user_dpm_profile.fan_mode;
 }
 
 static int
@@ -1174,6 +1174,35 @@ smu_v11_0_set_fan_static_mode(struct smu_context *smu, uint32_t mode)
 	return 0;
 }
 
+int
+smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
+
+	if (speed > 100)
+		speed = 100;
+
+	if (smu_v11_0_auto_fan_control(smu, 0))
+		return -EINVAL;
+
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	if (!duty100)
+		return -EINVAL;
+
+	tmp64 = (uint64_t)speed * duty100;
+	do_div(tmp64, 100);
+	duty = (uint32_t)tmp64;
+
+	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
+				   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
+
+	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
+}
+
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode)
@@ -1182,7 +1211,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v11_0_set_fan_speed_rpm(smu, smu->fan_max_rpm);
+		ret = smu_v11_0_set_fan_speed_percent(smu, 100);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v11_0_auto_fan_control(smu, 0);
@@ -1202,58 +1231,6 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
-				       uint32_t speed)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret;
-	uint32_t tach_period, crystal_clock_freq;
-
-	if (!speed)
-		return -EINVAL;
-
-	ret = smu_v11_0_auto_fan_control(smu, 0);
-	if (ret)
-		return ret;
-
-	/*
-	 * crystal_clock_freq div by 4 is required since the fan control
-	 * module refers to 25MHz
-	 */
-
-	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
-	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
-	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
-		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
-				   CG_TACH_CTRL, TARGET_PERIOD,
-				   tach_period));
-
-	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
-
-	return ret;
-}
-
-int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,
-				uint32_t *speed)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t tach_period, crystal_clock_freq;
-	uint64_t tmp64;
-
-	tach_period = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
-				    CG_TACH_CTRL, TARGET_PERIOD);
-	if (!tach_period)
-		return -EINVAL;
-
-	crystal_clock_freq = amdgpu_asic_get_xclk(adev);
-
-	tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;
-	do_div(tmp64, (tach_period * 8));
-	*speed = (uint32_t)tmp64;
-
-	return 0;
-}
-
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate)
 {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

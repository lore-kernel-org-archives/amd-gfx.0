Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EAFC3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 02:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF1010E3A2;
	Tue, 20 Aug 2024 02:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F7GRG9ic";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AFE10E3A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 02:04:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8EFB36068C;
 Tue, 20 Aug 2024 02:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF11EC32782;
 Tue, 20 Aug 2024 02:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724119491;
 bh=67EanqhUiGBSJDhVS9vk5mrzwlLzlsouufRjkLCXBiI=;
 h=From:To:Cc:Subject:Date:From;
 b=F7GRG9icik2t8P6Sog5Oi9EIAej/1HibVReDz5GVwio2Zg2UeWwgVypbRJhWrfJAi
 Gzk2udHGmvCM8+37rnjyY/UYf61uHPEY+YT2j02kaxQQh1Fzd5Pm6ZajlA01QnInWJ
 mvzGiR8xWoIaT6AJCaFs4HpAhfiwgK6lBO0nH9aG6psDJB5VSuuaAY3sv7N00ROC6D
 Ib8lbhKfQ3B+pCYxAJXXml1G/+TCVkmhx3fgz1uEXfvAVBb0sKdNs7UyltNrz5T2Ef
 eBtYq3ee49t5XeEQPtyH5qUSXaEsqrNaxc6b8vactme3Wk+io7hf9Qac4YpFyGOZSA
 iDJOgcmeEcvIQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
Date: Mon, 19 Aug 2024 21:04:35 -0500
Message-ID: <20240820020435.472490-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

If the dGPU is off, then reading the sysfs files with a sensor monitoring
application will wake it. Change the behavior to return an error when the
dGPU is in D3cold.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c11952a4389bc..d6e38466fbb82 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	if (strncmp("battery", buf, strlen("battery")) == 0)
@@ -270,7 +270,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -309,7 +309,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	if (strncmp("low", buf, strlen("low")) == 0) {
@@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	if (adev->pm.pp_force_state_enabled)
@@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	adev->pm.pp_force_state_enabled = false;
@@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	if (count > 127 || count == 0)
@@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = kstrtou64(buf, 0, &featuremask);
@@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1424,7 +1424,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1463,7 +1463,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	tmp[0] = *(buf);
@@ -1517,7 +1517,7 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	if (adev->flags & AMD_IS_APU)
@@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	if (adev->unique_id)
@@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
@@ -2227,7 +2227,7 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	mode = amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
@@ -2250,7 +2250,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = kstrtos32(buf, 0, &mode);
@@ -2652,7 +2652,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2684,7 +2684,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	err = kstrtou32(buf, 10, &value);
@@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2817,7 +2817,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2881,7 +2881,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2912,7 +2912,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	err = kstrtou32(buf, 10, &value);
@@ -2956,7 +2956,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -2988,7 +2988,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -3128,7 +3128,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	if (amdgpu_sriov_vf(adev))
@@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->dev);
@@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = parse_input_od_command_lines(in_buf,
@@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
+	if (adev->in_suspend || adev->in_runpm)
 		return -EPERM;
 
 	ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
-- 
2.43.0


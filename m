Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286CDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 19:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D294761264
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 19:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D294761264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4297D6E843;
	Thu, 11 Nov 2021 19:14:58 +0000 (UTC)
X-Greylist: delayed 579 seconds by postgrey-1.36 at gabe;
 Thu, 11 Nov 2021 19:14:56 UTC
Received: from ubuntu2004-NV21-clean.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA586E8EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 19:14:56 +0000 (UTC)
Received: by ubuntu2004-NV21-clean.amd.com (Postfix, from userid 0)
 id 67AA3161C31; Thu, 11 Nov 2021 14:05:16 -0500 (EST)
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] SWDEV-306029 - add new sysfs interface for retrieving gpu
 metrics(V2)
Date: Thu, 11 Nov 2021 14:05:14 -0500
Message-Id: <20211111190514.11599-1-surbhi.kakarya@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A new interface for UMD to retrieve gpu metrics data.

Change-Id: Ieb8d56740147cf60a869a7fa0ef43d05cfbf802f
Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c              | 17 +++++++++++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       |  4 +---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 10 ++++++++++
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 53bb2565cc61..2e5d2059556a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1799,9 +1799,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
-	if (adev->powerplay.pp_funcs->get_gpu_metrics)
+	if (is_support_sw_smu(adev)){
+		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
+	} else if (adev->powerplay.pp_funcs->get_gpu_metrics) {
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
-
+	}
 	if (size <= 0)
 		goto out;
 
@@ -1817,6 +1819,8 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	return size;
 }
 
+static DEVICE_ATTR(gpu_metrics, S_IRUGO, amdgpu_get_gpu_metrics, NULL);
+
 /**
  * DOC: smartshift_apu_power
  *
@@ -3527,6 +3531,13 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
+	if (adev->asic_type >= CHIP_VEGA12) {
+		ret = device_create_file(adev->dev, &dev_attr_gpu_metrics);
+		if (ret) {
+			DRM_ERROR("failed to create device file gpu_metrics\n");
+			return ret;
+		}
+	}
 	switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
 	case SRIOV_VF_MODE_ONE_VF:
 		mask = ATTR_FLAG_ONEVF;
@@ -3562,6 +3573,8 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
 
 	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
+	if (adev->asic_type >= CHIP_VEGA12)
+		device_remove_file(adev->dev, &dev_attr_gpu_metrics);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 73fca113f3d9..cbb22d0c5568 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1339,6 +1339,6 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
-
+ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b4ea8b233240..6a3424d0a014 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2919,9 +2919,8 @@ static int smu_get_dpm_clock_table(void *handle,
 	return ret;
 }
 
-static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
+ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table)
 {
-	struct smu_context *smu = handle;
 	ssize_t size;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -3049,7 +3048,6 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.asic_reset_mode_2                = smu_mode2_reset,
 	.set_df_cstate                    = smu_set_df_cstate,
 	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
-	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
 	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e0632530e9bf..cc5d9768c33f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3672,6 +3672,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
 	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
+	if (metrics->CurrGfxVoltageOffset)
+		gpu_metrics->voltage_gfx =
+			(155000 - 625 * metrics->CurrGfxVoltageOffset) / 100;
+	if (metrics->CurrMemVidOffset)
+		gpu_metrics->voltage_mem =
+			(155000 - 625 * metrics->CurrMemVidOffset) / 100;
+	if (metrics->CurrSocVoltageOffset)
+		gpu_metrics->voltage_soc =
+			(155000 - 625 * metrics->CurrSocVoltageOffset) / 100;
+
 	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
 	else
-- 
2.25.1


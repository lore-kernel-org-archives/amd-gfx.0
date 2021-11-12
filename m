Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AF7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 17:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8744F60E8F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 17:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8744F60E8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4536E08A;
	Fri, 12 Nov 2021 17:46:36 +0000 (UTC)
Received: from ubuntu2004-NV21-clean.amd.com (unknown [165.204.54.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BE16E08A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 17:46:35 +0000 (UTC)
Received: by ubuntu2004-NV21-clean.amd.com (Postfix, from userid 0)
 id EB391161C31; Fri, 12 Nov 2021 12:46:33 -0500 (EST)
From: Surbhi Kakarya <surbhi.kakarya@amd.com>
To: amd-gfx@lists.freedesktop.org, Bokun.Zhang@amd.com, HaiJun.Chang@amd.com,
 Monk.Liu@amd.com, Alexander.Deucher@amd.com
Subject: [PATCH] drm/amd/pm: Add sysfs interface for retrieving gpu metrics(V2)
Date: Fri, 12 Nov 2021 12:46:32 -0500
Message-Id: <20211112174632.48205-1-surbhi.kakarya@amd.com>
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

A new interface for UMD to retrieve gpu metrics data. This patch is
based on an existing patch If7f3523915505c0ece0a56dfd476d2b8473440d4.

Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
Change-Id: I701110d78a85c092f5dda167a52350cc6dda7557
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                     |  6 +++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h                |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c              |  4 +---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 01cca08a774f..d60426daddae 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1800,8 +1800,12 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
-	if (adev->powerplay.pp_funcs->get_gpu_metrics)
+	down_read(&adev->reset_sem);
+	if (is_support_sw_smu(adev))
+		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
+	else if (adev->powerplay.pp_funcs->get_gpu_metrics)
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
+	up_read(&adev->reset_sem);
 
 	if (size <= 0)
 		goto out;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3557f4e7fc30..5ffe7e3bf1aa 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1397,6 +1397,6 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
 
 int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
-
+ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b06c59dcc1b4..ec81abe385e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3005,9 +3005,8 @@ static int smu_get_dpm_clock_table(void *handle,
 	return ret;
 }
 
-static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
+ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table)
 {
-	struct smu_context *smu = handle;
 	ssize_t size;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -3135,7 +3134,6 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.asic_reset_mode_2                = smu_mode2_reset,
 	.set_df_cstate                    = smu_set_df_cstate,
 	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
-	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
 	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
 	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
 	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3b1bf270ebc6..97d18e764665 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3619,6 +3619,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->energy_accumulator =
 		use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics->EnergyAccumulator;
 
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
 	average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
 	if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency =
-- 
2.25.1


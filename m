Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D9C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 22:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC022071A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 22:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7ndYpgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC022071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135046E3AC;
	Wed, 27 May 2020 22:52:08 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CB66E108
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 22:52:07 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id z80so1393379qka.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 15:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sjLbNGstpVNxrXPru57QLFg/b5h8+sD96DTtS7SM5p4=;
 b=G7ndYpgUg3Bblc4hfQBTCV58gSIlJos1VOK3mQMYK4qgztNTehUKgOBWxv+ErxotbV
 GauxUw/An8GC0XJ7r5DEsUuUf9SyOPnw5PioJqFHBojUX21yWS3ggFoWR+0seaoiAgWM
 +SFsMmMLHeauOxAndEcgkNe/ga/pMsHQSaQey60rzXHD0q2i7VU5ST9xmisVSmrbcq4i
 G0Jl3hF13pQ7KZkr5Wk44r5XjO+9vD4UJTfZVRnYgeyLP3y60ct0ae/ch7Vh+eXxKkLZ
 ibK1urKDqPaODm6Xn2TGbL62mRW/W+x4S52uy5XXel6jT2q0RdS7Xp2BhdNMdkJqlWvr
 7hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sjLbNGstpVNxrXPru57QLFg/b5h8+sD96DTtS7SM5p4=;
 b=WX2mHV40MGjj4rNBwlq8TX91GQFEi4nyjVyMrcDHYLF6ryWr1R/vmaV5ocDT0d543P
 91pDhlLm7Tba0lby+Qp4gwoP14YVRbxOdQ+w8jPHv/8/QvfR9OlKLvGCs1l0AaAf+bQo
 UGpSgNTaarwmttSdvrT20Iu6vTPGrR0qwsiWS/9DOY2Ht6cKwEIhPYrFeJm5BcqdvWrZ
 QXGzuBfzwfe6d87VZbhTKdxR+o/RFf5DKL9ylXCrwK9fe7e8+0XGU0DTLXZzuMKKLCcx
 OvhP3zAG5HzhA8H6MHmFdtdvSOd5oj0vDxXa+psUlfx1Ft70jJ+MBJ9muHfbzgtjhNP0
 Tmlw==
X-Gm-Message-State: AOAM533TvAmZIy9mL5ZLbvdZyQqijTBMba2JyhXwpt6jzbD5P8zGb5GQ
 VQdy0Bs0JK1L/OUjvsN0P50ck8oA
X-Google-Smtp-Source: ABdhPJyWGqMkcgbUwZoquIDk6V1+27mULn4faorrDiOqnEVkmTnfy1fIrh5lDph9S1EdCfDx0RhgsQ==
X-Received: by 2002:a37:85c4:: with SMTP id h187mr102105qkd.179.1590619925820; 
 Wed, 27 May 2020 15:52:05 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id b9sm3498366qto.91.2020.05.27.15.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 15:52:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: don't bail for in_suspend
Date: Wed, 27 May 2020 18:51:58 -0400
Message-Id: <20200527225158.27756-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise we disable sysfs/debugfs access with runtime pm.

Fixes: f7c8d853b029df ("drm/amdgpu/pm: return an error during GPU reset or suspend")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 114 ++++++++++++-------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 808884aaf36d..775e389c9a13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -163,7 +163,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -199,7 +199,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (strncmp("battery", buf, strlen("battery")) == 0)
@@ -303,7 +303,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -343,7 +343,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (strncmp("low", buf, strlen("low")) == 0) {
@@ -445,7 +445,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	struct pp_states_info data;
 	int i, buf_len, ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -487,7 +487,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -526,7 +526,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (adev->pp_force_state_enabled)
@@ -546,7 +546,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (strlen(buf) == 1)
@@ -604,7 +604,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -646,7 +646,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -751,7 +751,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (count > 127)
@@ -843,7 +843,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -895,7 +895,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = kstrtou64(buf, 0, &featuremask);
@@ -938,7 +938,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -997,7 +997,7 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1063,7 +1063,7 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1097,7 +1097,7 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1127,7 +1127,7 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	uint32_t mask = 0;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1161,7 +1161,7 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1191,7 +1191,7 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1227,7 +1227,7 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1257,7 +1257,7 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1293,7 +1293,7 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1323,7 +1323,7 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1359,7 +1359,7 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1389,7 +1389,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = amdgpu_read_mask(buf, count, &mask);
@@ -1425,7 +1425,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1453,7 +1453,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1494,7 +1494,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1522,7 +1522,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = kstrtol(buf, 0, &value);
@@ -1583,7 +1583,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
@@ -1621,7 +1621,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	tmp[0] = *(buf);
@@ -1683,7 +1683,7 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
@@ -1719,7 +1719,7 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
@@ -1760,7 +1760,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (adev->flags & AMD_IS_APU)
@@ -1799,7 +1799,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (adev->unique_id)
@@ -1996,7 +1996,7 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 	int channel = to_sensor_dev_attr(attr)->index;
 	int r, temp = 0, size = sizeof(temp);
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (channel >= PP_TEMP_MAX)
@@ -2130,7 +2130,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
@@ -2164,7 +2164,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	int err, ret;
 	int value;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -2216,7 +2216,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2268,7 +2268,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2301,7 +2301,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2333,7 +2333,7 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 	u32 size = sizeof(min_rpm);
 	int r;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2361,7 +2361,7 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 	u32 size = sizeof(max_rpm);
 	int r;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2388,7 +2388,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	int err;
 	u32 rpm = 0;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2420,7 +2420,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
@@ -2469,7 +2469,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
@@ -2504,7 +2504,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	int value;
 	u32 pwm_mode;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	err = kstrtoint(buf, 10, &value);
@@ -2547,7 +2547,7 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 	u32 vddgfx;
 	int r, size = sizeof(vddgfx);
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2582,7 +2582,7 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 	u32 vddnb;
 	int r, size = sizeof(vddnb);
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	/* only APUs have vddnb */
@@ -2622,7 +2622,7 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 	int r, size = sizeof(u32);
 	unsigned uw;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2661,7 +2661,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	ssize_t size;
 	int r;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2693,7 +2693,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	ssize_t size;
 	int r;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2726,7 +2726,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	int err;
 	u32 value;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	if (amdgpu_sriov_vf(adev))
@@ -2767,7 +2767,7 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 	uint32_t sclk;
 	int r, size = sizeof(sclk);
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -2802,7 +2802,7 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 	uint32_t mclk;
 	int r, size = sizeof(mclk);
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
@@ -3665,7 +3665,7 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 	u32 flags = 0;
 	int r;
 
-	if (adev->in_gpu_reset || adev->in_suspend)
+	if (adev->in_gpu_reset)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(dev->dev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

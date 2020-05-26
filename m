Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86061C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 17:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5A420776
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 17:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFrFSYye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5A420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF2889349;
	Tue, 26 May 2020 17:56:49 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7EE89349
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 17:56:48 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id f189so21534850qkd.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xyOBsxJDfQfAYTMMTBF10HkMKQ7ZeH0Q3a3dzNUGcWQ=;
 b=nFrFSYyehfWlpZdFKN5FR0NqSz5VXlv32gvno/FLfITw74+watBwc6wUzRb0uj+bD/
 yUZnrcdSUgWklEGx8/nmh7pGnklHQa/V53Ufe8FI9yX7DC0L5HzAt8OQD3EpzwLJPpXo
 yskIpUadaLWVFIw1NgLtBebBC2TvQAyyAxliIxIHrL2pTRa9uxYbSneMXYxq9VAwCdCW
 d1vcRTO8GTv9XE23NQEb7+Jq2zS89ZqgDXEGKRgWCdlNLzFaHdrr/760ZsKCiRsdy1eC
 JlLivvvpPt1c5B8GiIO7yJZMVZUM1C3NC8EY5E5or/bEYNA58ManX/nLvEkTbKjGxAZK
 3KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xyOBsxJDfQfAYTMMTBF10HkMKQ7ZeH0Q3a3dzNUGcWQ=;
 b=hiiyiTIO03IK5h+tmCxcx67qJ/6L3NWCs7twTfBxVWDdfi7vpL8px9X7rM27SObSPA
 3RqoFD5VdCslfWLCG6NKu9yfFZFx6pLFyPF4uJ0HwnhlQQwlGVwvpup7JEeoy6N833Ud
 jZB2x93nI+mECqfgDnImpZSbxbPCjn+KovPcpgB3jA3c7SA2vlMp0Ag5QHFVzGTDuCAS
 7PB9IHYXpGWmqhGALPTc5Pz1BK16hxE4+YgpUpmgvEmBl9sT9iluj6coJGKrRRNxZifK
 H32/wQfjVRacbAifgohUymMlyGzJOC+oTZyqP5XrG6klC4bhwumb+7EnBR7M/idliAb8
 A9xQ==
X-Gm-Message-State: AOAM532e4ryrm5sTkAcDdvSwZsqiaNrh9QQnjUow81hFQmQ2vqQFMz2n
 X6niSYwaBJpU4l7lbr6U80mK1FhF
X-Google-Smtp-Source: ABdhPJwUQvTTrmAZCaUYU9Tn17Xg5WyTT4Xy5Cpp/C0M20ygZxVC8VllqlsB1X9lx6+r6u0AqGYFxg==
X-Received: by 2002:a37:9807:: with SMTP id a7mr8648qke.112.1590515806989;
 Tue, 26 May 2020 10:56:46 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id q4sm368252qtf.35.2020.05.26.10.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:56:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: return an error during GPU reset or suspend
Date: Tue, 26 May 2020 13:56:37 -0400
Message-Id: <20200526175637.853730-1-alexander.deucher@amd.com>
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

Return an error for sysfs and debugfs power interfaces during
gpu reset and suspend.  Prevents access to the hw while it may
be in an unusable state.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 171 +++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 702a3a03c707..255e21d46921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -163,6 +163,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -196,6 +199,9 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
 	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
@@ -297,6 +303,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -334,6 +343,9 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
 	} else if (strncmp("high", buf, strlen("high")) == 0) {
@@ -433,6 +445,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	struct pp_states_info data;
 	int i, buf_len, ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -472,6 +487,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -508,6 +526,9 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (adev->pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
@@ -525,6 +546,9 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (strlen(buf) == 1)
 		adev->pp_force_state_enabled = false;
 	else if (is_support_sw_smu(adev))
@@ -580,6 +604,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -619,6 +646,9 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -721,6 +751,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (count > 127)
 		return -EINVAL;
 
@@ -810,6 +843,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -859,6 +895,9 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
 		return -EINVAL;
@@ -899,6 +938,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -955,6 +997,9 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1018,6 +1063,9 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1049,6 +1097,9 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1076,6 +1127,9 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	uint32_t mask = 0;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1107,6 +1161,9 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1134,6 +1191,9 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1167,6 +1227,9 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1194,6 +1257,9 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1227,6 +1293,9 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1254,6 +1323,9 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1287,6 +1359,9 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1314,6 +1389,9 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1347,6 +1425,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1372,6 +1453,9 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1410,6 +1494,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1435,6 +1522,9 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1493,6 +1583,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1528,6 +1621,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	tmp[0] = *(buf);
 	tmp[1] = '\0';
 	ret = kstrtol(tmp, 0, &profile_mode);
@@ -1587,6 +1683,9 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1620,6 +1719,9 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1658,6 +1760,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (adev->flags & AMD_IS_APU)
 		return -ENODATA;
 
@@ -1694,6 +1799,9 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (adev->unique_id)
 		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
 
@@ -1876,6 +1984,9 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 	int channel = to_sensor_dev_attr(attr)->index;
 	int r, temp = 0, size = sizeof(temp);
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (channel >= PP_TEMP_MAX)
 		return -EINVAL;
 
@@ -2007,6 +2118,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(adev->ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -2038,6 +2152,9 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	int err, ret;
 	int value;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	err = kstrtoint(buf, 10, &value);
 	if (err)
 		return err;
@@ -2087,6 +2204,9 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	err = pm_runtime_get_sync(adev->ddev->dev);
 	if (err < 0)
 		return err;
@@ -2136,6 +2256,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	int err;
 	u32 speed = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	err = pm_runtime_get_sync(adev->ddev->dev);
 	if (err < 0)
 		return err;
@@ -2166,6 +2289,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	int err;
 	u32 speed = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	err = pm_runtime_get_sync(adev->ddev->dev);
 	if (err < 0)
 		return err;
@@ -2195,6 +2321,9 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 	u32 size = sizeof(min_rpm);
 	int r;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -2220,6 +2349,9 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 	u32 size = sizeof(max_rpm);
 	int r;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -2244,6 +2376,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	int err;
 	u32 rpm = 0;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	err = pm_runtime_get_sync(adev->ddev->dev);
 	if (err < 0)
 		return err;
@@ -2273,6 +2408,9 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	err = pm_runtime_get_sync(adev->ddev->dev);
 	if (err < 0)
 		return err;
@@ -2319,6 +2457,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	ret = pm_runtime_get_sync(adev->ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -2351,6 +2492,9 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	int value;
 	u32 pwm_mode;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	err = kstrtoint(buf, 10, &value);
 	if (err)
 		return err;
@@ -2391,6 +2535,9 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 	u32 vddgfx;
 	int r, size = sizeof(vddgfx);
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -2423,6 +2570,9 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 	u32 vddnb;
 	int r, size = sizeof(vddnb);
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	/* only APUs have vddnb */
 	if  (!(adev->flags & AMD_IS_APU))
 		return -EINVAL;
@@ -2460,6 +2610,9 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 	int r, size = sizeof(u32);
 	unsigned uw;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -2496,6 +2649,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	ssize_t size;
 	int r;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -2525,6 +2681,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 	ssize_t size;
 	int r;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -2555,6 +2714,9 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	int err;
 	u32 value;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
@@ -2593,6 +2755,9 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 	uint32_t sclk;
 	int r, size = sizeof(sclk);
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -2625,6 +2790,9 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 	uint32_t mclk;
 	int r, size = sizeof(mclk);
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(adev->ddev->dev);
 	if (r < 0)
 		return r;
@@ -3484,6 +3652,9 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 	u32 flags = 0;
 	int r;
 
+	if (adev->in_gpu_reset || adev->in_suspend)
+		return -EPERM;
+
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0)
 		return r;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

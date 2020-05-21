Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CA7C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4F42078B
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 20:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDi6blh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4F42078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEDE6E055;
	Thu, 21 May 2020 20:23:18 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C09E6E055
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 20:23:18 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id f83so8530550qke.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ABMYSC65s8UhU99Ijmy64Vr4Ygn1+PXcWfM5VdaRrko=;
 b=oDi6blh9NymD7Mkp3HSVXdexSnmL7YqhYncddDPKwDkp+hjS/FpAQvn04b7GVX8cJf
 Be081Ob/pw+s/f85NQHiCwRsOWopdIJUNTlFrLNJor6NbriFhUCSMMdPklv4wQY1oFIG
 I0+AaXVlqT5RdmCPdeyNkN9fy47FH74Bt9r6FV1fyqy7vlKrS9Ev+CgYzOE0BCK6H8lM
 9taRs0KA71/oiEZGxnVTQWctAGfXICL+4Eg8k5n2qYncgum/aWFL+Q7uzO09p6KergXL
 3HUfpT0gaZFnZpte+RcO3S0laS3xy6RaTDFnDfDKyWgqD+gCmKa7H75pb8RVpTkEVdJ7
 Nl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ABMYSC65s8UhU99Ijmy64Vr4Ygn1+PXcWfM5VdaRrko=;
 b=UUGSyKswfIkzwz36FURmom5G2zTk2iAfIJhmilbOnP1cVMUEUXluIB/F+50Wm5m/Or
 ah/yQQmtqxWhWR1fSJbFCgzSogz7N3oDspeNrtngpN+KJr+VUD4MxXzy0AN5yCOpI/DD
 PzNssmXoBq+bbL4PyADzwVJ4u/63k6AUJ7gPQgntFwPtPnXPfNq72fRnc5Sof9BFo09+
 +N25Gmm2M4dsgVtjupvwJU6jVs1QNAOpcbOGtYhuTkFQwdUEfwo2a1WcXxdp9S8AuMuJ
 a2Ln2RvHkqcsLYLJIDA7uj5OCQZy+DgLLTb9zz81+8LrOKIdjGGg+AF3pnj/mSkHXoHY
 t24g==
X-Gm-Message-State: AOAM53366sCM+qSF0hhgGbiXJEEI4vfiCl23mlEvta1canJdvg8xWPlq
 +BUyBH9qNpRsS1zNbiAi0d03IBn7
X-Google-Smtp-Source: ABdhPJxusrwRR0b8SNQ5jkgzYNysq7fM/k0c1nLJI+n1egapvK2Y7qfEGfwdV/h5PxtESSUirwsplg==
X-Received: by 2002:a37:7603:: with SMTP id r3mr11378227qkc.243.1590092596636; 
 Thu, 21 May 2020 13:23:16 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t130sm5543470qka.14.2020.05.21.13.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:23:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] Revert "drm/amdgpu: cleanup unnecessary virt sriov check
 in amdgpu attribute"
Date: Thu, 21 May 2020 16:23:07 -0400
Message-Id: <20200521202308.1996496-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521202308.1996496-1-alexander.deucher@amd.com>
References: <20200521202308.1996496-1-alexander.deucher@amd.com>
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

This reverts commit e04aba8a382d86646a2a2cc194c3fc2441b64917.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 105 +++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 72bbb8175b22..63e3e6534913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -163,6 +163,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -196,6 +199,9 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
 	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
@@ -297,6 +303,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -334,6 +343,9 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level current_level = 0xff;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
 	} else if (strncmp("high", buf, strlen("high")) == 0) {
@@ -463,6 +475,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -499,6 +514,9 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (adev->pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
 	else
@@ -516,6 +534,9 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	if (strlen(buf) == 1)
 		adev->pp_force_state_enabled = false;
 	else if (is_support_sw_smu(adev))
@@ -571,6 +592,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -610,6 +634,9 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -712,6 +739,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	if (count > 127)
 		return -EINVAL;
 
@@ -801,6 +831,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -850,6 +883,9 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
 		return -EINVAL;
@@ -890,6 +926,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -946,6 +985,9 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1009,6 +1051,9 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1040,6 +1085,9 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1067,6 +1115,9 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	uint32_t mask = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+			return -EINVAL;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1098,6 +1149,9 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1125,6 +1179,9 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1158,6 +1215,9 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1185,6 +1245,9 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1218,6 +1281,9 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1245,6 +1311,9 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1278,6 +1347,9 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1305,6 +1377,9 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
@@ -1338,6 +1413,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1363,6 +1441,9 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1401,6 +1482,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1426,6 +1510,9 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
@@ -1484,6 +1571,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1525,6 +1615,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
 	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (count < 2 || count > 127)
 			return -EINVAL;
@@ -1578,6 +1671,9 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1611,6 +1707,9 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 	struct amdgpu_device *adev = ddev->dev_private;
 	int r, value, size = sizeof(value);
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	r = pm_runtime_get_sync(ddev->dev);
 	if (r < 0)
 		return r;
@@ -1655,6 +1754,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	if (!adev->asic_funcs->get_pcie_usage)
 		return -ENODATA;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
@@ -1685,6 +1787,9 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return 0;
+
 	if (adev->unique_id)
 		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

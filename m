Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C9BC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7BA2073E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHZy+vbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7BA2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B823E6E8E3;
	Wed, 17 Jun 2020 19:02:25 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD3D6E176
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 19:02:23 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id e2so1570565qvw.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6k91p9LZtnIqlCk/SI/Qw+FUCu9BUKEhHB2B6/HtI1c=;
 b=ZHZy+vboHt+IOCzT84bPWSaS7E8bociENJkR0EvF3sRcgoNeAYGieiastx3eCjAyZ3
 rdZEARADZwKC1kbbIRWL2vfR56khfS0bTd4kHe0NUqtpyUfILpdps8vBR593nrmhN8mk
 WCk0GRwLLRCe1LOhN2AmFRBfobz5yNzgEAO9q5gV8Hw7iDY8Rr7hNqOpfQ1cmmwvxXXi
 75TRyMoPaSC1GObYAYQdzgQAYykvMQMpzF8U2DhVF0wx/ieURJL63MwORSaa0wHXPbak
 PJmJyv2UWB/2pcoBSBCKh8sa86ogRwkBw28BXunFS323cM4jJ5xk0AxwKedXv+aCIoB+
 w51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6k91p9LZtnIqlCk/SI/Qw+FUCu9BUKEhHB2B6/HtI1c=;
 b=lO20E+XkBlLCe3NMITOO4lGZbVf2gwrOGUowE5Fwm6hf26yZEdVwjLDmXQd/u2o3Um
 zZlS2X7GkLMyT41ZfTGAKw7dUKDUncIYtJCDvXg1hWealqfhDyZ1NmF0VokMGZ9GXyU+
 k60XtSOQKR+LhFqSMS/bAbv5zPl2ZwO1MU3OhoVHFgOuijW2BwDAj2+RATYW0ANi1cNP
 SFkNRxTiRHjShcAdAx7T88Vz+71zEzUVZ6VTXFfyk+KzbU271WIi8p1vYmjYbb1p2jXd
 m9vYNttxgTmq2X/dd2FmIW4F8aKW+pErZgAFkTTnIo+z3D7wUKvfxgS6gdh6nHiLLp+z
 v6Bw==
X-Gm-Message-State: AOAM5328EHL6mIekKzZcYJsWIzrgCE/EjaUa4/KOH5lB5Sht39h9+J1g
 0rkxsiEiEtqwyKfwBnMNsfd985lB
X-Google-Smtp-Source: ABdhPJyJ59cRQ8JGSmV0ZXxUfWVbIVFw1qv9MpCNEHLVdmhvbQeMAlWcKekde5zPRhh90eD5588ASA==
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr53636qvw.211.1592420542374;
 Wed, 17 Jun 2020 12:02:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id v59sm705056qte.96.2020.06.17.12.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:02:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu/pm: fix ref count leak when
 pm_runtime_get_sync fails
Date: Wed, 17 Jun 2020 15:02:10 -0400
Message-Id: <20200617190212.3519907-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200617190212.3519907-1-alexander.deucher@amd.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
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

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 220 ++++++++++++++++++-------
 1 file changed, 165 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 42bbdf49458e..14cc6c546f65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -167,8 +167,10 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		if (adev->smu.ppt_funcs->get_current_power_state)
@@ -212,8 +214,10 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		mutex_lock(&adev->pm.mutex);
@@ -307,8 +311,10 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		level = smu_get_performance_level(&adev->smu);
@@ -369,8 +375,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	}
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		current_level = smu_get_performance_level(&adev->smu);
@@ -449,8 +457,10 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_get_power_num_states(&adev->smu, &data);
@@ -491,8 +501,10 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		pm = smu_get_current_power_state(smu);
@@ -567,8 +579,10 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 		state = data.states[idx];
 
 		ret = pm_runtime_get_sync(ddev->dev);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(ddev->dev);
 			return ret;
+		}
 
 		/* only set user selected power states */
 		if (state != POWER_STATE_TYPE_INTERNAL_BOOT &&
@@ -608,8 +622,10 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		size = smu_sys_get_pp_table(&adev->smu, (void **)&table);
@@ -650,8 +666,10 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_sys_set_pp_table(&adev->smu, (void *)buf, count);
@@ -790,8 +808,10 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	}
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_od_edit_dpm_table(&adev->smu, type,
@@ -847,8 +867,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		size = smu_print_clk_levels(&adev->smu, SMU_OD_SCLK, buf);
@@ -905,8 +927,10 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	pr_debug("featuremask = 0x%llx\n", featuremask);
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_sys_set_pp_feature_mask(&adev->smu, featuremask);
@@ -942,8 +966,10 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_sys_get_pp_feature_mask(&adev->smu, buf);
@@ -1001,8 +1027,10 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_SCLK, buf);
@@ -1071,8 +1099,10 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask, true);
@@ -1101,8 +1131,10 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_MCLK, buf);
@@ -1135,8 +1167,10 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask, true);
@@ -1165,8 +1199,10 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_SOCCLK, buf);
@@ -1199,8 +1235,10 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask, true);
@@ -1231,8 +1269,10 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_FCLK, buf);
@@ -1265,8 +1305,10 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask, true);
@@ -1297,8 +1339,10 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_DCEFCLK, buf);
@@ -1331,8 +1375,10 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask, true);
@@ -1363,8 +1409,10 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_print_clk_levels(&adev->smu, SMU_PCIE, buf);
@@ -1397,8 +1445,10 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask, true);
@@ -1429,8 +1479,10 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		value = smu_get_od_percentage(&(adev->smu), SMU_OD_SCLK);
@@ -1462,8 +1514,10 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		value = smu_set_od_percentage(&(adev->smu), SMU_OD_SCLK, (uint32_t)value);
@@ -1498,8 +1552,10 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		value = smu_get_od_percentage(&(adev->smu), SMU_OD_MCLK);
@@ -1531,8 +1587,10 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		value = smu_set_od_percentage(&(adev->smu), SMU_OD_MCLK, (uint32_t)value);
@@ -1587,8 +1645,10 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		size = smu_get_power_profile_mode(&adev->smu, buf);
@@ -1650,8 +1710,10 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	parameter[parameter_size] = profile_mode;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev))
 		ret = smu_set_power_profile_mode(&adev->smu, parameter, parameter_size, true);
@@ -1687,8 +1749,10 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return r;
+	}
 
 	/* read the IP busy sensor */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_LOAD,
@@ -1723,8 +1787,10 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return r;
+	}
 
 	/* read the IP busy sensor */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD,
@@ -1770,8 +1836,10 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 		return -ENODATA;
 
 	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
 		return ret;
+	}
 
 	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
 
@@ -2073,8 +2141,10 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	switch (channel) {
 	case PP_TEMP_JUNCTION:
@@ -2204,8 +2274,10 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2242,8 +2314,10 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 		return err;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		smu_set_fan_control_mode(&adev->smu, value);
@@ -2290,8 +2364,10 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return err;
+	}
 
 	if (is_support_sw_smu(adev))
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2342,8 +2418,10 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return err;
+	}
 
 	if (is_support_sw_smu(adev))
 		err = smu_get_fan_speed_percent(&adev->smu, &speed);
@@ -2375,8 +2453,10 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return err;
+	}
 
 	if (is_support_sw_smu(adev))
 		err = smu_get_fan_speed_rpm(&adev->smu, &speed);
@@ -2407,8 +2487,10 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MIN_FAN_RPM,
 				   (void *)&min_rpm, &size);
@@ -2435,8 +2517,10 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MAX_FAN_RPM,
 				   (void *)&max_rpm, &size);
@@ -2462,8 +2546,10 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return err;
+	}
 
 	if (is_support_sw_smu(adev))
 		err = smu_get_fan_speed_rpm(&adev->smu, &rpm);
@@ -2494,8 +2580,10 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 		return -EPERM;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return err;
+	}
 
 	if (is_support_sw_smu(adev))
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2543,8 +2631,10 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 		return -EPERM;
 
 	ret = pm_runtime_get_sync(adev->ddev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return ret;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		pwm_mode = smu_get_fan_control_mode(&adev->smu);
@@ -2589,8 +2679,10 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 		return -EINVAL;
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return err;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		smu_set_fan_control_mode(&adev->smu, pwm_mode);
@@ -2621,8 +2713,10 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* get the voltage */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX,
@@ -2660,8 +2754,10 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 		return -EINVAL;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* get the voltage */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB,
@@ -2696,8 +2792,10 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* get the voltage */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWER,
@@ -2735,8 +2833,10 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		smu_get_power_limit(&adev->smu, &limit, true);
@@ -2767,8 +2867,10 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	if (is_support_sw_smu(adev)) {
 		smu_get_power_limit(&adev->smu, &limit, false);
@@ -2810,8 +2912,10 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 
 
 	err = pm_runtime_get_sync(adev->ddev->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return err;
+	}
 
 	if (is_support_sw_smu(adev))
 		err = smu_set_power_limit(&adev->smu, value);
@@ -2841,8 +2945,10 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* get the sclk */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
@@ -2876,8 +2982,10 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 		return -EPERM;
 
 	r = pm_runtime_get_sync(adev->ddev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 		return r;
+	}
 
 	/* get the sclk */
 	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK,
@@ -3739,8 +3847,10 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 		return -EPERM;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	amdgpu_device_ip_get_clockgating_state(adev, &flags);
 	seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD3CC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D535F2075B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YltbuLc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D535F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CE489722;
	Tue, 14 Jan 2020 17:26:08 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB9B89722
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:26:07 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id i126so9681086ywe.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 09:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M/UIATRts48pBvupOPck0Wkvv8Aujze1z1swD1/IwlA=;
 b=YltbuLc9fAdPOmLHSSMdKCjv+KSvYcoSDTliGyWbT4EotwUKSIvmnzEi+vWyztUgou
 xTwTZKCO3oA3/uy4MPb/WmeI7sD3dyLKsnv7jZrEnhWYWBhsW2j1iEEq2KzUd9xw/4kL
 wyA5G3lhBXCOC45mtzcOa+JUlXFSHhWQC35GPJBlJ+jBWF9QHd9l4ozWGzosKec+1+la
 L0OprsdymO1/eP+34CAZQVmcz7gN9qe6/+UthKhtqlMWVrUTalwgQDI2hGjdrpKjpVta
 ci3AKfWfc6RHNpRpe8U7HclA8kn191cepdXf6S11l/I/q+VeB4esivqLhh/91ZaOLM1m
 l7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M/UIATRts48pBvupOPck0Wkvv8Aujze1z1swD1/IwlA=;
 b=tfZLfSmCh0d9CscwkAG726YFUzley+2ieeVyCrKEvTWWPXBA816Y6p1Mn+zCdc44K0
 BSk592zQw/5tk5jeF0WC9Z4O9yT/fR37S8vj9QiA2vQtm3Qa1U7bs4wZ6i8XbUYk+ECU
 IWJhrPEV2/yy7VfTFCpUiAtvncLK0FNzaS6h1p6wvqaNBbU+SJA9tlSJXixC1FazHot+
 9EHRop4xIueXih3Ji1Sxn22cGlAYdfTNR4RaeDW79R7ZzMY9ngCA6CZBR3XFrlDW/1pg
 cxFEhVYRnIznJOjk6FshWDoYN3OUjh6+189dkzsNNiFLDL2dT5PGPtPqd57qNF41gxbI
 rCjQ==
X-Gm-Message-State: APjAAAWr0QJVKd7lkw6QRQl3PSwROWApVAl/bKVUHlglMxT//iYe6t6c
 d4+oIGxqP5S1A3Y9FIszKGNgfYYi
X-Google-Smtp-Source: APXvYqwTLjp+a+huT7XbhLeOhsN70pBDiv8vKXYFWdeRne1bzGZVHDI1j1tskn04fXGbh3o1+XEMTg==
X-Received: by 2002:a25:d9d3:: with SMTP id
 q202mr17966626ybg.276.1579022766746; 
 Tue, 14 Jan 2020 09:26:06 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id u185sm6996321ywf.89.2020.01.14.09.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 09:26:05 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: clean up return types
Date: Tue, 14 Jan 2020 12:25:44 -0500
Message-Id: <20200114172544.1042534-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

count is size_t so don't use negative values.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 39 ++++++++++++++++----------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 806e731c1ff4..b03b1eb7ba04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -206,10 +206,8 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
 		state = POWER_STATE_TYPE_BALANCED;
 	else if (strncmp("performance", buf, strlen("performance")) == 0)
 		state = POWER_STATE_TYPE_PERFORMANCE;
-	else {
-		count = -EINVAL;
-		goto fail;
-	}
+	else
+		return -EINVAL;
 
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
@@ -231,8 +229,6 @@ static ssize_t amdgpu_set_dpm_state(struct device *dev,
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
-
-fail:
 	return count;
 }
 
@@ -399,8 +395,11 @@ static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_force_performance_level(&adev->smu, level);
-		if (ret)
-			count = -EINVAL;
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		}
 	} else if (adev->powerplay.pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
@@ -410,10 +409,14 @@ static ssize_t amdgpu_set_dpm_forced_performance_level(struct device *dev,
 			return -EINVAL;
 		}
 		ret = amdgpu_dpm_force_performance_level(adev, level);
-		if (ret)
-			count = -EINVAL;
-		else
+		if (ret) {
+			mutex_unlock(&adev->pm.mutex);
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		} else {
 			adev->pm.dpm.forced_level = level;
+		}
 		mutex_unlock(&adev->pm.mutex);
 	}
 	pm_runtime_mark_last_busy(ddev->dev);
@@ -890,12 +893,18 @@ static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
 
 	if (is_support_sw_smu(adev)) {
 		ret = smu_sys_set_pp_feature_mask(&adev->smu, featuremask);
-		if (ret)
-			count = -EINVAL;
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		}
 	} else if (adev->powerplay.pp_funcs->set_ppfeature_status) {
 		ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
-		if (ret)
-			count = -EINVAL;
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
+		}
 	}
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

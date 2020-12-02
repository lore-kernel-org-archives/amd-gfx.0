Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DB1C64E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199812158C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199812158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB386E9A5;
	Wed,  2 Dec 2020 03:05:17 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52CFD6E9A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 03:05:15 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id q5so36914qkc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FGjhQ8FuQlL3Hj58F44dSRL733LXKtJWnDQV4qyNpWo=;
 b=sCDEq8HE/Sen9Ur/QT1cP+T8uszpJKgx3nuq30VVq6ms6up9ZmxFpvo15hRkQxJaZT
 oN6RCZ3uE5vOBvx6f6lxtXypTT35/EdfZ3MJAGqZvKRIQRVgCZqtah+rJBSZvkeBN21d
 6GQd2HFCJZMqv389vTgdD7Ir+cRnso1RkizVDHRyvW562c1/RwXzU05vbveuHuteQBL4
 UgmI78XnqRbQbi8cy0AVTAAwXErnVT/uFo1GT6HNh2Kcb4Pmzdt4mxg1GdVkipmJJdII
 CAzUX9iHTtv53U19r3Af0ZQzTfqdLxCM+7ZtxC1L2PpF2KpSoHZ5sXd+Ea9tDfd/eM/j
 8KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FGjhQ8FuQlL3Hj58F44dSRL733LXKtJWnDQV4qyNpWo=;
 b=aCD9LQQtEcnGAZqSyroSjL6AIP6TuQQjBGqs5OMoBHHaOQOl/f+BP5iaEZBbt4BdvX
 1+lkClrdU3Z0UubnywgOl/8ytlGM8sP4mNCkUZY+FDxNjPP2SOWjCYxEug8/oTIsXVl/
 0MpfEJspobI8oWQMo6Z6rtedKDbZnnuRXAsG1+AGm3Qmwk0XFyHZPek9l2uTRLZtAITQ
 PljpPrKQrkA4VrLVQwXPoEi5+qn9L0X0Yq7KM9hje2R8cWhEcKk11p0LGCYjTxGvZxCr
 GIapKyJjWACbZO4VpWcxRRofilRjKIqCQFHRjax+3Y+qDCTiFk9ND+mpmwNLqr12SVtX
 haqg==
X-Gm-Message-State: AOAM531nE5uClPwrrNe3Me2uXkNTOiqb4pRkXuoBr8K+q0US2bRSDmxk
 e1KAGhzSeWg+s7l7T98cszTelHxTvhQ=
X-Google-Smtp-Source: ABdhPJx83DIEx+JsfqP6ln8g3QqFiarrSyV6ogppdNOH3xbSIk8xooYGFThAn/mvq9nc4RiiD431Mw==
X-Received: by 2002:a05:620a:244:: with SMTP id
 q4mr615199qkn.342.1606878314301; 
 Tue, 01 Dec 2020 19:05:14 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id b64sm471411qkg.19.2020.12.01.19.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 19:05:13 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu/swsmu/vangogh: simplify sensor handling
Date: Tue,  1 Dec 2020 22:05:03 -0500
Message-Id: <20201202030505.1310154-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201202030505.1310154-1-alexander.deucher@amd.com>
References: <20201202030505.1310154-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just query the metrics table directly rather than going through
an extra level of functions.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 114 +++---------------
 1 file changed, 20 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 56704181c5a9..1645509cdab8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -396,95 +396,6 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int vangogh_get_current_activity_percent(struct smu_context *smu,
-					       enum amd_pp_sensors sensor,
-					       uint32_t *value)
-{
-	int ret = 0;
-
-	if (!value)
-		return -EINVAL;
-
-	switch (sensor) {
-	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = vangogh_get_smu_metrics_data(smu,
-						  METRICS_AVERAGE_GFXACTIVITY,
-						  value);
-		if (ret)
-			return ret;
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int vangogh_get_gpu_power(struct smu_context *smu, uint32_t *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	return vangogh_get_smu_metrics_data(smu,
-					   METRICS_AVERAGE_SOCKETPOWER,
-					   value);
-}
-
-static int vangogh_thermal_get_temperature(struct smu_context *smu,
-					     enum amd_pp_sensors sensor,
-					     uint32_t *value)
-{
-	int ret = 0;
-
-	if (!value)
-		return -EINVAL;
-
-	switch (sensor) {
-	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		ret = vangogh_get_smu_metrics_data(smu,
-						  METRICS_TEMPERATURE_HOTSPOT,
-						  value);
-		break;
-	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = vangogh_get_smu_metrics_data(smu,
-						  METRICS_TEMPERATURE_EDGE,
-						  value);
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving temp\n");
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-static int vangogh_get_current_clk_freq_by_table(struct smu_context *smu,
-				       enum smu_clk_type clk_type,
-				       uint32_t *value)
-{
-	MetricsMember_t member_type;
-
-	switch (clk_type) {
-	case SMU_GFXCLK:
-		member_type = METRICS_AVERAGE_GFXCLK;
-		break;
-	case SMU_MCLK:
-	case SMU_UCLK:
-		member_type = METRICS_AVERAGE_UCLK;
-		break;
-	case SMU_SOCCLK:
-		member_type = METRICS_AVERAGE_SOCCLK;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return vangogh_get_smu_metrics_data(smu,
-					   member_type,
-					   value);
-}
-
 static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -526,25 +437,40 @@ static int vangogh_read_sensor(struct smu_context *smu,
 	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = vangogh_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_AVERAGE_GFXACTIVITY,
+						   (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = vangogh_get_gpu_power(smu, (uint32_t *)data);
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_AVERAGE_SOCKETPOWER,
+						   (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_TEMPERATURE_EDGE,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		ret = vangogh_thermal_get_temperature(smu, sensor, (uint32_t *)data);
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_TEMPERATURE_HOTSPOT,
+						   (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = vangogh_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_AVERAGE_UCLK,
+						   (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = vangogh_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = vangogh_get_smu_metrics_data(smu,
+						    METRICS_AVERAGE_GFXCLK,
+						    (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5473C64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536E320870
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2gZ1swP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536E320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC5E66E842;
	Tue,  1 Dec 2020 17:44:25 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3EDD6E82F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 17:44:24 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id y18so2080258qki.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+nJjV+W2A/y15GNhoL/v8TtzwgOr3VZScBq3qVAVFw0=;
 b=F2gZ1swPCcjPv2zap22MgC7AXjWQxL2H45fDzg8vZKexodrG5EkLh5XEXtxigjgUVk
 EUvlIuvGwWz82FoUDtbr2ly/1nn6JGiYukBk0xJ9hIUK3XKVCu/PuDTsrsplmWdSbiCg
 Z/QyJSELJPJ01gCBHZINAeL3SMqsmacuXqkJPRIf9IO/6Mhoo0Emak7eGYwgP9pW2+sI
 0NC3QOomys6TxdnAj3rEDRhub4RgqMmllbXuldo6tLLQx3cZdJ+iGGD4FfXm8R4fL0Gx
 gG2e4A11TgSRny3hAy0Bow0wjY2lEjIBAxnAbwA0/0F7Mm8zFZYHElLFwUqM4ngYL0Zj
 /jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+nJjV+W2A/y15GNhoL/v8TtzwgOr3VZScBq3qVAVFw0=;
 b=FC/C9F2Db+rdK7tKo8XmdUHwYn5D6zFbk8i21oXdCBajIgyFwILefEtZmL/sconqgI
 EPT/lNrKpqu2GjEbVnqWYcAbKy0J/+7jOh/Y9vPk1NiKhrAiyMSDll/+9XOK/3t0xjJg
 H0J7s8FHJD8RrCi9aV3qqXXYDOiog2QKvtVoOi7PLGG270Ofu3ggzfKK79DJ112RN1P5
 snvz5C33xTiae4CXhTk3PEvyzZon908ZPgePD5e7XDzRXuhsl7yOZ/yRe8cGBXA+QsK7
 ifGQWpTwuMEofu0xGIj1SGKcVwesxVxSFXDVW9NSnAFk8O1fv2H78UlasJkvaZFk4MF1
 vteA==
X-Gm-Message-State: AOAM531oE6WNilPHQF444KDSOHxEfxIs1r+veQY8z2M7Q8QQT7UzEeGw
 z9bwvBNxFJOqBhj9Zi0AnRnoYPcBNRE=
X-Google-Smtp-Source: ABdhPJxZYlImKiUZjcIpJA/UcN8eO/qwQ9O6oRy9UuSBNPR4Km3Wm+6j1eOWDYjbK497bSfTIzaNeQ==
X-Received: by 2002:a37:6546:: with SMTP id z67mr4073507qkb.22.1606844663500; 
 Tue, 01 Dec 2020 09:44:23 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o9sm302170qko.53.2020.12.01.09.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 09:44:23 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu/swsmu/vangogh: simplify sensor handling
Date: Tue,  1 Dec 2020 12:44:11 -0500
Message-Id: <20201201174413.643254-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201201174413.643254-1-alexander.deucher@amd.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
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

Just query the metrics table directly rather than going through
an extra level of functions.

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

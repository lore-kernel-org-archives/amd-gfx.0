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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36336C64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D8120870
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 17:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM9UXoq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D8120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99D36E87C;
	Tue,  1 Dec 2020 17:44:27 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F2266E871
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 17:44:26 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id q5so2085678qkc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IDuzHT/TCE8Wbmkmp7k1RGuNdJ75R1bo9AfHqx0f9Os=;
 b=iM9UXoq9pCE3QkiZ6muduI71BHio2s5FUYvn5wrWGoivc99zHvCIna9u7o4kBrs93+
 pL+KdRxTXTXHxCyWOUcqe6j7ilzwLXQ9hFuOmXOddOtKcZFb0bvP8GaDuG7/PaNRpNsY
 yUsRbR008pFhjq0EafIlIIoxDfXcL81UxdLW1FJn4aMeRL2V50C4MhPbC6cVJCzNvGFl
 G9LG/jtuYJ6iYaWhqHo55TJdxDzxX33AQwqTlPLoaWj0IEDiZ5TJbLIlBqDNtFOf66dh
 fK+xpPFa3+PC9FmRLNVzVPyP6At5oUmuBx8vADyRS9HNRTTEL4rNb7UlnE3Z7pPjd/3g
 Qdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IDuzHT/TCE8Wbmkmp7k1RGuNdJ75R1bo9AfHqx0f9Os=;
 b=rN66mozGIHooLMgKmyqGE0DcFo6VglXrr2D+fsX0FEN8zrL/qhLO25DC1OfETTKhvz
 9LpUEmErqvTaXj+emX8ocLxE5mS51kHR48GPOcGzwYVF6TMwFkYmJIPzV0/f9PH0GGy5
 wxbuDg4YbTouV8qQvqHak1eCmm6JfFVhJFZLd0h7RAZJYVUq6gx2l5JEbKVyNja33v7I
 g2ubW+kv3cVfAtUTJhGn8OxTeENfxH6tYnF6bPZ9PDXLbLoHjbE4fo/6AwQ0AQFgAYC6
 0KD8FMveqYYU8zIvAwO+jzVnWcGwRzeiiDgRIfuoUh5wnv521YuF99bifww/9ZWif3+E
 OZsQ==
X-Gm-Message-State: AOAM530cr8x0+UNMYIEiBU6mipDmnmA3bcnMUwcHLAGU4ny0orBqhsr3
 xtGS7lml+nKAdtL0d8TS+8FgbkAu4Fk=
X-Google-Smtp-Source: ABdhPJyBAjw4WUIgB5sTpDcjxgj0Ya8kpUYkj1xbmIwtfDgXcm1sEOhg8eU8PUbZvP8D4pboMh9wKA==
X-Received: by 2002:a05:620a:2018:: with SMTP id
 c24mr4083355qka.143.1606844665273; 
 Tue, 01 Dec 2020 09:44:25 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o9sm302170qko.53.2020.12.01.09.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 09:44:24 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu/swsmu/renoir: simplify sensor handling
Date: Tue,  1 Dec 2020 12:44:13 -0500
Message-Id: <20201201174413.643254-5-alexander.deucher@amd.com>
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
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 205 ++++++++----------
 1 file changed, 93 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index d3641a8ed99c..37e65c0b6136 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -492,28 +492,6 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-static int renoir_get_current_clk_freq_by_table(struct smu_context *smu,
-				       enum smu_clk_type clk_type,
-				       uint32_t *value)
-{
-	int ret = 0, clk_id = 0;
-	SmuMetrics_t metrics;
-
-	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-	if (ret)
-		return ret;
-
-	clk_id = smu_cmn_to_asic_specific_index(smu,
-						CMN2ASIC_MAPPING_CLK,
-						clk_type);
-	if (clk_id < 0)
-		return clk_id;
-
-	*value = metrics.ClockFrequency[clk_id];
-
-	return ret;
-}
-
 static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 {
 	int ret = 0, i = 0;
@@ -574,88 +552,6 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 	return ret;
 }
 
-static int renoir_get_gpu_temperature(struct smu_context *smu, uint32_t *value)
-{
-	int ret = 0;
-	SmuMetrics_t metrics;
-
-	if (!value)
-		return -EINVAL;
-
-	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-	if (ret)
-		return ret;
-
-	*value = (metrics.GfxTemperature / 100) *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-
-	return 0;
-}
-
-static int renoir_get_current_activity_percent(struct smu_context *smu,
-					       enum amd_pp_sensors sensor,
-					       uint32_t *value)
-{
-	int ret = 0;
-	SmuMetrics_t metrics;
-
-	if (!value)
-		return -EINVAL;
-
-	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-	if (ret)
-		return ret;
-
-	switch (sensor) {
-	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		*value = metrics.AverageGfxActivity / 100;
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int renoir_get_vddc(struct smu_context *smu, uint32_t *value,
-			   unsigned int index)
-{
-	int ret = 0;
-	SmuMetrics_t metrics;
-
-	if (index >= 2)
-		return -EINVAL;
-
-	if (!value)
-		return -EINVAL;
-
-	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-	if (ret)
-		return ret;
-
-	*value = metrics.Voltage[index];
-
-	return 0;
-}
-
-static int renoir_get_power(struct smu_context *smu, uint32_t *value)
-{
-	int ret = 0;
-	SmuMetrics_t metrics;
-
-	if (!value)
-		return -EINVAL;
-
-	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
-	if (ret)
-		return ret;
-
-	*value = metrics.CurrentSocketPower << 8;
-
-	return 0;
-}
-
 /*
  * This interface get dpm clock table for dc
  */
@@ -1011,6 +907,71 @@ static int renoir_get_power_profile_mode(struct smu_context *smu,
 	return size;
 }
 
+static int renoir_get_smu_metrics_data(struct smu_context *smu,
+				       MetricsMember_t member,
+				       uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       NULL,
+					       false);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+
+	switch (member) {
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->ClockFrequency[CLOCK_GFXCLK];
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->ClockFrequency[CLOCK_SOCCLK];
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->ClockFrequency[CLOCK_FCLK];
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->AverageGfxActivity / 100;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->AverageUvdActivity / 100;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = metrics->CurrentSocketPower << 8;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = (metrics->GfxTemperature / 100) *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = (metrics->SocTemperature / 100) *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = metrics->ThrottlerStatus;
+		break;
+	case METRICS_TEMPERATURE_VRGFX:
+		*value = metrics->Voltage[0];
+		break;
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = metrics->Voltage[1];
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
+
 static int renoir_read_sensor(struct smu_context *smu,
 				 enum amd_pp_sensors sensor,
 				 void *data, uint32_t *size)
@@ -1023,33 +984,53 @@ static int renoir_read_sensor(struct smu_context *smu,
 	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = renoir_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_GFXACTIVITY,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_EDGE,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
-	case AMDGPU_PP_SENSOR_GPU_TEMP:
-		ret = renoir_get_gpu_temperature(smu, (uint32_t *)data);
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_HOTSPOT,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = renoir_get_current_clk_freq_by_table(smu, SMU_UCLK, (uint32_t *)data);
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_UCLK,
+						  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = renoir_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_GFXCLK,
+						  (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
-		ret = renoir_get_vddc(smu, (uint32_t *)data, 0);
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_VRGFX,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDNB:
-		ret = renoir_get_vddc(smu, (uint32_t *)data, 1);
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_VRSOC,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = renoir_get_power(smu, (uint32_t *)data);
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_SOCKETPOWER,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

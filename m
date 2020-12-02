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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F68DC64E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF2720C56
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF2720C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356E26E9AB;
	Wed,  2 Dec 2020 03:05:18 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0C56E9A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 03:05:16 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id z9so112655qtn.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ono5roXbHJg+D7Dk0pg6z+1roiZ73Cht0TibktvPXAg=;
 b=mhHAsMEuUxbm0SbttQAhc900wu2LGK11PhmKv4lGcwhA5XxMfg80H89r3WNTTmorcv
 /Ajn7EDe4/jDGFr+Cka+8g69mq4ynXim+i6YGEZwSeavk3AqH+dIjIzLGlgakeS0B3Gx
 g/la7G+5qIWIGlqvysbS8Tbk+AclV70rwyBc65rO+w5WES+mnBSA+zd4phrZmojfms1r
 jJF+V9uZqvbFmoHBOMjJRFt9ITY9HZ6Nr3ajU5yzC8pp1gAJ0Kxtl/fFgBJT9NrrLcS9
 YjrdQbghzk6V5gL4wiFPRCg0LM8hwCMGP41idLmt4trr5qusMyU4ojUoqWCpibUDWSNp
 Kp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ono5roXbHJg+D7Dk0pg6z+1roiZ73Cht0TibktvPXAg=;
 b=cipiMe7VRn96JvaqDvY3sJCQ0iSfu1lC68L7DQ+CxqoK+MsYMwvWcVQw0qMZjx1IF8
 hNjQYhIB9Bl2koNG6aBzN1RxVCZGcbaLhafY1wHWwBe9ctqaIEhWaMv2NhvXLentOoAM
 N3E4XiufnKXhxBvZ9BNnmqCItpEMDDZkKvCTM01SqXXUqoiLeg51JlVS1zJCNDxvxAS1
 KIoWSp7Nj1ieznjAp80OZNvrVSqah/2RKx/xGGqHeqyE6uIkehc4weUAqwRWIfahxjIk
 jvOY5IUL7BuWiphefAeTj06b2xM39LMV6vztgNAWcpiTVELQSyCDGNZANIbcFBDi3zWx
 iAfg==
X-Gm-Message-State: AOAM533n45DQfwtu6ppoQt6m0YsnVjE8THiNdJdjT01shs5mjNaZUzeR
 Q3/TQ4kvaFVOEGVhKl+nMtPJ/gQPSA4=
X-Google-Smtp-Source: ABdhPJybm2qseu6qJVTrbxtfCSZ1DhSJNvZASxNNHI1XATBDlJ1JAhXiPAj2AatpeNDNIaH6Dory7g==
X-Received: by 2002:ac8:787:: with SMTP id l7mr641637qth.137.1606878316038;
 Tue, 01 Dec 2020 19:05:16 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id b64sm471411qkg.19.2020.12.01.19.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 19:05:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu/swsmu/renoir: simplify sensor handling (v2)
Date: Tue,  1 Dec 2020 22:05:05 -0500
Message-Id: <20201202030505.1310154-4-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just query the metrics table directly rather than going through
an extra level of functions.

v2: use proper enum

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 205 ++++++++----------
 1 file changed, 93 insertions(+), 112 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index d3641a8ed99c..dc75db8af371 100644
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
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = metrics->Voltage[0];
+		break;
+	case METRICS_VOLTAGE_VDDSOC:
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
+						  METRICS_VOLTAGE_VDDGFX,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDNB:
-		ret = renoir_get_vddc(smu, (uint32_t *)data, 1);
+		ret = renoir_get_smu_metrics_data(smu,
+						  METRICS_VOLTAGE_VDDSOC,
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

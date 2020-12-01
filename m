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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF31BC71155
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 18:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66577208FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 18:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw5dblHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66577208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDF96E554;
	Tue,  1 Dec 2020 18:43:28 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B371C6E554
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 18:43:27 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id q7so1311476qvt.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MGsEE990//NPb3nEy+fg/O5WPnk7IaSheQFL3hJE4Tg=;
 b=Vw5dblHuwMNMJ6tRvx+hHlvUqcWEk0Qlz9+Qxr6wwqFyb9Sw+5gUHoWRmNnoJ4mP2k
 bB5kmybPOjbiyGoQ9/15elTcryPatEF1lsXiKOy5Fxt6bBJI+SZowsCiBboEqcu4dbMj
 QaN3OUn22CDCbGrosgInHxLdltbOHPRGNwOGCXTsJADpaZQzjn7cohL26KafrV6pUY1C
 A2802WhDepanNrRsbDnrPzJIGSv04ISVENEjfCVxLuvvMySqK/Tz8Jso9pUGU7huCWnf
 m4r6Y/LJAOW2jgMYmGQYoGcJjJiQbeoMmYZfs2VrTrESuR504SbdeSDchO4XBtxG6hA2
 Aqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MGsEE990//NPb3nEy+fg/O5WPnk7IaSheQFL3hJE4Tg=;
 b=bO4APSYWKMZ94j8INYQeQSBzSYbO3FvczK2rFtt00+NWsnnUX0xcuinB9LD/jJZRCi
 No+z3mmGm7LCLD77NLUEprRdj91kYLlGahOEGk5uHi93kwtUcclptfd1qNqOlJhDJRPZ
 uwvwam0s59irO3bLA1+1fViKPv1hqeLYAqxj3aGPBx65MmeW3kTYxRB4i70F3mYX6QgG
 +U8BwmIIf7VrgTwg6GMUnwAkco5t+MBFOpRHKJk5HqPF1q8gQcL57+JvRCeRuGzkJCPx
 7TwHZVYugYgega5BIvEBD3xoxS9fNNHqjTcktnQ1Eswud8qbSejTwVp+wzEGChGOYqhy
 iosQ==
X-Gm-Message-State: AOAM533dtJ+Hxm90sgYDvNG1UYT1oviQBfFyO2Vb/9GVoTq71xV7dGVl
 vfAneW+TcFB7//ouS39qNnJ7EwcRMU4=
X-Google-Smtp-Source: ABdhPJx8jIsT+lVnAGt6DtqL6emEvy/7otjFZP5PyBbif9mPKETQfkDNXETWHQCYhITLrkfw1058ww==
X-Received: by 2002:ad4:4052:: with SMTP id r18mr4323047qvp.38.1606848206587; 
 Tue, 01 Dec 2020 10:43:26 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id e10sm421392qte.48.2020.12.01.10.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 10:43:26 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/swsmu/navi1x: simplify sensor handling
Date: Tue,  1 Dec 2020 13:43:18 -0500
Message-Id: <20201201184320.686358-1-alexander.deucher@amd.com>
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

Just query the metrics table directly rather than going through
an extra level of functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 98 +++++--------------
 1 file changed, 24 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 59bd7cd3ca8d..51e83123f72a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1302,44 +1302,6 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	return ret;
 }
 
-static int navi10_get_gpu_power(struct smu_context *smu, uint32_t *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	return navi10_get_smu_metrics_data(smu,
-					   METRICS_AVERAGE_SOCKETPOWER,
-					   value);
-}
-
-static int navi10_get_current_activity_percent(struct smu_context *smu,
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
-		ret = navi10_get_smu_metrics_data(smu,
-						  METRICS_AVERAGE_GFXACTIVITY,
-						  value);
-		break;
-	case AMDGPU_PP_SENSOR_MEM_LOAD:
-		ret = navi10_get_smu_metrics_data(smu,
-						  METRICS_AVERAGE_MEMACTIVITY,
-						  value);
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static bool navi10_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1652,39 +1614,6 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 	return 0;
 }
 
-static int navi10_thermal_get_temperature(struct smu_context *smu,
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
-		ret = navi10_get_smu_metrics_data(smu,
-						  METRICS_TEMPERATURE_HOTSPOT,
-						  value);
-		break;
-	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = navi10_get_smu_metrics_data(smu,
-						  METRICS_TEMPERATURE_EDGE,
-						  value);
-		break;
-	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = navi10_get_smu_metrics_data(smu,
-						  METRICS_TEMPERATURE_MEM,
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
 static int navi10_read_sensor(struct smu_context *smu,
 				 enum amd_pp_sensors sensor,
 				 void *data, uint32_t *size)
@@ -1703,18 +1632,39 @@ static int navi10_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_MEMACTIVITY,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = navi10_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_GFXACTIVITY,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = navi10_get_gpu_power(smu, (uint32_t *)data);
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_SOCKETPOWER,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_HOTSPOT,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_EDGE,
+						  (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = navi10_thermal_get_temperature(smu, sensor, (uint32_t *)data);
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_MEM,
+						  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

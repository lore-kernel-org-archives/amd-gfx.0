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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEFEC64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 18:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5E7208C3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSYTs5fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5E7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E316E87A;
	Tue,  1 Dec 2020 18:43:30 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C8E6E87A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 18:43:29 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 1so2329778qka.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 10:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yl/1MUw0ea/FdNpOSu3iCeVlyuveFNcSTIs7GSA1P2Q=;
 b=kSYTs5fsDRDzztTQ8TaVPyrI5z6HuSSd9tqOX7BfZjsxcNLFVITs0zO0FgnbSoebJh
 gEzLRjK9VaOv/6jAtyFopYHn4zkKg7INVo8eIRkuuS7K9QAqH2EJPFbB2bkx/RgIX0Te
 324CuEYQuo3DUWUwlnikwvnmVSVJcdIzrgDj1sxmhxnkl1l1OlAZ32IctB7pHETJacUC
 cFYJSKqjnbe/ColUVrLLezT9iMN6shFQ6J/Dj42B1sWkOM/2vdpTVn8DfhDXZyuVl3Rv
 YpMqxGrIJy68RmXox4IoFgIsxUVaIKHD2BTbFsXyKXWxb2l6sJG3Pehy89oP2z0VGVFH
 gw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yl/1MUw0ea/FdNpOSu3iCeVlyuveFNcSTIs7GSA1P2Q=;
 b=p0QeJSH3bg/hPhnvGT0Mqg7/rzBOBuAJkvrM67ufqLSopCojBVShp1+WyNRGl9NTYJ
 7T1FFQ6/SG6lKvWz82ReUzzREA+Ukhx0J2Gdos1//YxuBsj2yoQO2cO/OvUabtXwPblv
 z4NlayiRvKmgkWHhH8XRg2pAxWkYfZx32LEbLf9omeX8reF7zEYn7c45A5sJW/oqWcAA
 sDyqsOEIWnSICWB7jSsUz2MoHz28Trje+GsmBQJdqSkbFvNnro69q7/j76iZC2+EjS5Z
 kUIUQaiANwFg8WP2hAssUM1XKPPwW9f9wxfSoLPGYPU8biCfsfkGXcjENW0exXGAOf3s
 PF9w==
X-Gm-Message-State: AOAM5338E1dvM+PP0jDEu0Pwop7rwjS651HQQrqMVPlprug5BrXAGQxl
 XcnT8Zy1hMaAYJ2nkbezT+Gze8QMHio=
X-Google-Smtp-Source: ABdhPJwWVdcGr6iJfu+gZNxtvieuXjXx8HddZ9vMb7ey3uNK2o0qlK+8KLdArOfdjcvXckQCKsthpw==
X-Received: by 2002:a05:620a:146c:: with SMTP id
 j12mr4350028qkl.179.1606848208162; 
 Tue, 01 Dec 2020 10:43:28 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id e10sm421392qte.48.2020.12.01.10.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 10:43:27 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/swsmu/sienna_cichlid: simplify sensor handling
Date: Tue,  1 Dec 2020 13:43:20 -0500
Message-Id: <20201201184320.686358-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201201184320.686358-1-alexander.deucher@amd.com>
References: <20201201184320.686358-1-alexander.deucher@amd.com>
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
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 98 +++++--------------
 1 file changed, 24 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 21c5ea3a4a63..db0f2a476c23 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1119,44 +1119,6 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 	return ret;
 }
 
-static int sienna_cichlid_get_gpu_power(struct smu_context *smu, uint32_t *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	return sienna_cichlid_get_smu_metrics_data(smu,
-						   METRICS_AVERAGE_SOCKETPOWER,
-						   value);
-}
-
-static int sienna_cichlid_get_current_activity_percent(struct smu_context *smu,
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
-		ret = sienna_cichlid_get_smu_metrics_data(smu,
-							  METRICS_AVERAGE_GFXACTIVITY,
-							  value);
-		break;
-	case AMDGPU_PP_SENSOR_MEM_LOAD:
-		ret = sienna_cichlid_get_smu_metrics_data(smu,
-							  METRICS_AVERAGE_MEMACTIVITY,
-							  value);
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1468,39 +1430,6 @@ static int sienna_cichlid_set_watermarks_table(struct smu_context *smu,
 	return 0;
 }
 
-static int sienna_cichlid_thermal_get_temperature(struct smu_context *smu,
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
-		ret = sienna_cichlid_get_smu_metrics_data(smu,
-							  METRICS_TEMPERATURE_HOTSPOT,
-							  value);
-		break;
-	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = sienna_cichlid_get_smu_metrics_data(smu,
-							  METRICS_TEMPERATURE_EDGE,
-							  value);
-		break;
-	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = sienna_cichlid_get_smu_metrics_data(smu,
-							  METRICS_TEMPERATURE_MEM,
-							  value);
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving temp\n");
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static int sienna_cichlid_read_sensor(struct smu_context *smu,
 				 enum amd_pp_sensors sensor,
 				 void *data, uint32_t *size)
@@ -1519,18 +1448,39 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_MEMACTIVITY,
+							  (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = sienna_cichlid_get_current_activity_percent(smu, sensor, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_GFXACTIVITY,
+							  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = sienna_cichlid_get_gpu_power(smu, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_SOCKETPOWER,
+							  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_TEMPERATURE_HOTSPOT,
+							  (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_TEMPERATURE_EDGE,
+							  (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = sienna_cichlid_thermal_get_temperature(smu, sensor, (uint32_t *)data);
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_TEMPERATURE_MEM,
+							  (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

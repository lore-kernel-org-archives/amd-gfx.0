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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2DCC64E7B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 18:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D2D208C3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 18:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXXFwwP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D2D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042176E86F;
	Tue,  1 Dec 2020 18:43:29 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3CF6E554
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 18:43:28 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id 62so1315990qva.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bf5r1yL7vqtSQWMy5r+QYNWWRd7D+yRUj0MLkrggIu8=;
 b=NXXFwwP0eOKgo4xYVahGnc8JhOlpYNZW6oJ6nr9agKLERJ+yCZ8nXAikWR9UXwt+vJ
 y1E3qrLprTv8oIL2HRljfeUvODVuwR5DvjSuxdS2BolY5Mgv2LFtk3MXP3Xz236ZhQe+
 O0SHoDfS8mwHS0fCKvNHT7Ou6wF0+O0fSDnJSXThai6xlSEh2AczjKTcx+YoQRPpmLVD
 oyd1vWdn96F7PZnN3rnlzqZ84zUWOTTU8MGHHhqKEU6GVKOKaJBB0VkE/5Om/WV/lwd+
 0SghrxIS9m+kZ5pIKM/ON/c1gdJJPuHPzbR8xfIdoPs4ox2Rl/vqbcWllRVEm3zE8aqV
 OEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bf5r1yL7vqtSQWMy5r+QYNWWRd7D+yRUj0MLkrggIu8=;
 b=cKICKrIcTaqT0jfgDjMp4XdVQTmvlGyIiqgf7+Gm/kLTjAnHUijWmFVZcnNIH9BOJ5
 eMyfAw9X1TB+IN3vGrwB69+WzFjyGWH/T3e6ieXVCJpv3zZaDWktZKLyHNN3tqrAScdD
 6a/V2iylAQtKCW54W7F5ujKJzVm+b7IYxykPg8qhBhjE+NCI45tLg8rYMMIRdFn7ul8p
 /LxlQUdJWeTj+7RDaNsb8adjOpb1N/nw9J+893khdfddBZsTinEW5vprisFjEc6Immd5
 JAnXbvt++XaHqfFRi7bttylvUZvFJOd9FxxL56vZgH2YhWW1Lotc1yh9vMZ9SO1efK3l
 atfA==
X-Gm-Message-State: AOAM533NDH5R4wPvBaUrNrA6LNpooruV9lGr+5fsWvn/kTSKbHAJsgBS
 7vpjSTXVGVgCIH3wtyGXvS9H/siOlt8=
X-Google-Smtp-Source: ABdhPJwWbd8QNf/v/Ng4NpmamCjmsNL79hL1eXsMxI0o/wj6QvcVKg5MCVN/Q3jD6Dur6QM1gyp9Iw==
X-Received: by 2002:a05:6214:190f:: with SMTP id
 er15mr4273412qvb.33.1606848207301; 
 Tue, 01 Dec 2020 10:43:27 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id e10sm421392qte.48.2020.12.01.10.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 10:43:26 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/swsmu/arcturus: simplify sensor handling
Date: Tue,  1 Dec 2020 13:43:19 -0500
Message-Id: <20201201184320.686358-2-alexander.deucher@amd.com>
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
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 101 +++++-------------
 1 file changed, 24 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4fd850e58004..cd7b411457ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1000,77 +1000,6 @@ static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
-static int arcturus_get_current_activity_percent(struct smu_context *smu,
-						 enum amd_pp_sensors sensor,
-						 uint32_t *value)
-{
-	int ret = 0;
-
-	if (!value)
-		return -EINVAL;
-
-	switch (sensor) {
-	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = arcturus_get_smu_metrics_data(smu,
-						    METRICS_AVERAGE_GFXACTIVITY,
-						    value);
-		break;
-	case AMDGPU_PP_SENSOR_MEM_LOAD:
-		ret = arcturus_get_smu_metrics_data(smu,
-						    METRICS_AVERAGE_MEMACTIVITY,
-						    value);
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving clock activity\n");
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-static int arcturus_get_gpu_power(struct smu_context *smu, uint32_t *value)
-{
-	if (!value)
-		return -EINVAL;
-
-	return arcturus_get_smu_metrics_data(smu,
-					     METRICS_AVERAGE_SOCKETPOWER,
-					     value);
-}
-
-static int arcturus_thermal_get_temperature(struct smu_context *smu,
-					    enum amd_pp_sensors sensor,
-					    uint32_t *value)
-{
-	int ret = 0;
-
-	if (!value)
-		return -EINVAL;
-
-	switch (sensor) {
-	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		ret = arcturus_get_smu_metrics_data(smu,
-						    METRICS_TEMPERATURE_HOTSPOT,
-						    value);
-		break;
-	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = arcturus_get_smu_metrics_data(smu,
-						    METRICS_TEMPERATURE_EDGE,
-						    value);
-		break;
-	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = arcturus_get_smu_metrics_data(smu,
-						    METRICS_TEMPERATURE_MEM,
-						    value);
-		break;
-	default:
-		dev_err(smu->adev->dev, "Invalid sensor for retrieving temp\n");
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
 static int arcturus_read_sensor(struct smu_context *smu,
 				enum amd_pp_sensors sensor,
 				void *data, uint32_t *size)
@@ -1092,21 +1021,39 @@ static int arcturus_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_AVERAGE_MEMACTIVITY,
+						    (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		ret = arcturus_get_current_activity_percent(smu,
-							    sensor,
-						(uint32_t *)data);
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_AVERAGE_GFXACTIVITY,
+						    (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GPU_POWER:
-		ret = arcturus_get_gpu_power(smu, (uint32_t *)data);
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_AVERAGE_SOCKETPOWER,
+						    (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_TEMPERATURE_HOTSPOT,
+						    (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_TEMPERATURE_EDGE,
+						    (uint32_t *)data);
+		*size = 4;
+		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		ret = arcturus_thermal_get_temperature(smu, sensor,
-						(uint32_t *)data);
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_TEMPERATURE_MEM,
+						    (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

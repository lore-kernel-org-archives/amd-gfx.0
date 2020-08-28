Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4237CC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBF720776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2dNaW15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBF720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E256D6E504;
	Fri, 28 Aug 2020 17:59:06 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0DE96E504
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 17:59:05 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id z2so90419qtv.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wWTeAcv4gB9pQ1Er/vfvj52YUiu7n+89Ba8+pHldgNQ=;
 b=n2dNaW15au4Agy9addBXSWH2Hfj8S05W/X+vk+HN0AMYIURPOSGcO9tfktynMpfZjn
 bPhw84m3bA+kSmxCykTi6OdJPTN4iGkscV9esVGD5DqfEN6jDVNHXxRXHbVRs6UKQJ1q
 Otk8wETpDAJYZtb9ABmWbAB7yt76mcPROnybcQn3iEmwhvU2RvzFOb3QSPdGZOUzOfwc
 znsl1u1CdXhieDbGdbtoQ7DNc18NYk2oP4uriaypdznYOb7rbWhSTrF7bdSU3LlZTrpe
 kZZF/2pYK9igxqsHx0d5335j+ltNd1Hlh5DzRTHXMQQ44R3PNbs6BtOzaGrTBDmoeZ8c
 Zssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wWTeAcv4gB9pQ1Er/vfvj52YUiu7n+89Ba8+pHldgNQ=;
 b=tZsKu8DbrF2jVCPpiDmKRmdDJAZAm+C+P/HS/GCugp1B+dcP+vZjYya3QJcPOSRpI3
 U1W2Un6AnkQ4efJ8zq6TNPuIdfVIxmf2CTPpstmtYoMov+ybE8YV7elh7MDK9O9G2e7j
 xawbtUVn4pUlOcI137odLiezFKyy1xLvFApxqPceqrBoCD+nj1z6z4yqLmVFyP9MK3op
 fOdxIekt4TK0Rp7R6ZvuGqX4+0sZEIeha8CgOIvpQklLwoBe43B9Tky3cHWJjdEmVlik
 BCeugwnuuAhkwx5R6ktfrRE0eOC2Kx6Mj102FUYKo/WAGQDj0Vkhv4ABD2zbOh6ZLO9v
 q/yA==
X-Gm-Message-State: AOAM53134iPtuKatZs3/dqpfPxmRvvEKQw0n73Zxr+Wp8QIaQBPLvC59
 jAHJ5apOfWbnO4o1u7/wM2VwxU4QHsE=
X-Google-Smtp-Source: ABdhPJxLXKuL6ozPuiQ/Oi1dPChFOoGlNCsye9fjP6pgRjGSK8qbxpj/5Jgu2EeBGlyL4+5XFVz0uA==
X-Received: by 2002:ac8:708c:: with SMTP id y12mr2741838qto.24.1598637544668; 
 Fri, 28 Aug 2020 10:59:04 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id x28sm1278129qki.55.2020.08.28.10.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:59:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu/swsmu: drop get_fan_speed_percent (v2)
Date: Fri, 28 Aug 2020 13:58:50 -0400
Message-Id: <20200828175853.2378523-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200828175853.2378523-1-alexander.deucher@amd.com>
References: <20200828175853.2378523-1-alexander.deucher@amd.com>
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

No longer needed as we can calculate it based on
the fan's max rpm.

v2: rework code to avoid possible uninitialized
variable use.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 12 +++++++++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 21 -------------------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 19 -----------------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 19 -----------------
 5 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 787fc682e0a5..0ca997f83fb6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -498,7 +498,6 @@ struct pptable_funcs {
 	int (*notify_smc_display_config)(struct smu_context *smu);
 	int (*set_cpu_power_state)(struct smu_context *smu);
 	bool (*is_dpm_running)(struct smu_context *smu);
-	int (*get_fan_speed_percent)(struct smu_context *smu, uint32_t *speed);
 	int (*get_fan_speed_rpm)(struct smu_context *smu, uint32_t *speed);
 	int (*set_watermarks_table)(struct smu_context *smu,
 				    struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 114e85613e24..53e2051432bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2192,17 +2192,25 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 {
 	int ret = 0;
+	uint32_t percent;
+	uint32_t current_rpm;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_percent)
-		ret = smu->ppt_funcs->get_fan_speed_percent(smu, speed);
+	if (smu->ppt_funcs->get_fan_speed_rpm) {
+		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, &current_rpm);
+		if (!ret) {
+			percent = current_rpm * 100 / smu->fan_max_rpm;
+			*speed = percent > 100 ? 100 : percent;
+		}
+	}
 
 	mutex_unlock(&smu->mutex);
 
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 198fc1185b2d..1998e7916fef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1128,26 +1128,6 @@ static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
 					     speed);
 }
 
-static int arcturus_get_fan_speed_percent(struct smu_context *smu,
-					  uint32_t *speed)
-{
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-	uint32_t percent, current_rpm;
-	int ret = 0;
-
-	if (!speed)
-		return -EINVAL;
-
-	ret = arcturus_get_fan_speed_rpm(smu, &current_rpm);
-	if (ret)
-		return ret;
-
-	percent = current_rpm * 100 / pptable->FanMaximumRpm;
-	*speed = percent > 100 ? 100 : percent;
-
-	return ret;
-}
-
 static int arcturus_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -2338,7 +2318,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.print_clk_levels = arcturus_print_clk_levels,
 	.force_clk_levels = arcturus_force_clk_levels,
 	.read_sensor = arcturus_read_sensor,
-	.get_fan_speed_percent = arcturus_get_fan_speed_percent,
 	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 3a9500dcb436..d5c25e538a03 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1367,24 +1367,6 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
 					   speed);
 }
 
-static int navi10_get_fan_speed_percent(struct smu_context *smu,
-					uint32_t *speed)
-{
-	int ret = 0;
-	uint32_t percent = 0;
-	uint32_t current_rpm;
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-
-	ret = navi10_get_fan_speed_rpm(smu, &current_rpm);
-	if (ret)
-		return ret;
-
-	percent = current_rpm * 100 / pptable->FanMaximumRpm;
-	*speed = percent > 100 ? 100 : percent;
-
-	return ret;
-}
-
 static int navi10_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -2606,7 +2588,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_config_changed = navi10_display_config_changed,
 	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.is_dpm_running = navi10_is_dpm_running,
-	.get_fan_speed_percent = navi10_get_fan_speed_percent,
 	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 2ac942b13bad..97e54d382862 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1174,24 +1174,6 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
 						   speed);
 }
 
-static int sienna_cichlid_get_fan_speed_percent(struct smu_context *smu,
-					uint32_t *speed)
-{
-	int ret = 0;
-	uint32_t percent = 0;
-	uint32_t current_rpm;
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
-
-	ret = sienna_cichlid_get_fan_speed_rpm(smu, &current_rpm);
-	if (ret)
-		return ret;
-
-	percent = current_rpm * 100 / pptable->FanMaximumRpm;
-	*speed = percent > 100 ? 100 : percent;
-
-	return ret;
-}
-
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
 {
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
@@ -2753,7 +2735,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_config_changed = sienna_cichlid_display_config_changed,
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
-	.get_fan_speed_percent = sienna_cichlid_get_fan_speed_percent,
 	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

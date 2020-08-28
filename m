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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F258C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068E620776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKoPlaWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068E620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B566EB4F;
	Fri, 28 Aug 2020 17:59:11 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D116E50B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 17:59:07 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id w186so296914qkd.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eDwkUQWvSYjraAwHJTv6XtRAiYldIBbsM2t0m3xdop8=;
 b=ZKoPlaWOI42nLNGPhkRE7+euFv5/fcNFFpxsG7/calFzKyxWuvarUgotIDrBsSVkc4
 uL8Za5DhavrwPrt00bZ/zNv3sKdRfQG6I+skdQ/PrlwEUL9sLep/Ccp19wlbkW6WwwvV
 wRKeYFT/Bbaht5VaYpE0iU02jGosww+naxwk4NEbWrof3l3CV9H7PXgX4lHsiqN5sRxN
 148zlevrqjSetd87hPfPc3Rcrg9JpNSrDm2IcH/EPegWBIZfZqHg+bXTyq33eVjX9SCl
 TD27o1f/rk9jy3OGiQUzDTYWNrQGqFMfeKquxdMcPPOvSpjWIiGUwStulB2pHAq1S7lm
 E0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eDwkUQWvSYjraAwHJTv6XtRAiYldIBbsM2t0m3xdop8=;
 b=BeoP/wRHVdUeEU9qut9gM/OEF+LVQXt3EaRxtWRJ+vwWwMCUGE0MQB0Ymser4UnAjw
 b95dBX1WAQmEXO/jvwX5QD+4w4APndKDR1nC0am+akRYQ7Jnhq7smWtewTsVQ1hkwgS2
 od3FqMvrT8Z3zdMCAfLYAZWLmT8VhpzcT+vm/TLVabz17Ihq1+Tf/2Wgz4Ie1C6S/JYw
 MVLCan/T8dhD0whwpyvufzmdhm8mKBPDohpbl559FXyL3yjF/obgs1T6ctc1q4LR39MJ
 fMpXThEd1SHFaaIL7Z/7yWWU4dUU6p+Y+iGw5MGdpB8xvBiNzZoPylsfUBC5vQ30UIII
 CbkQ==
X-Gm-Message-State: AOAM533AzU0P6iayP/nMGTbZE94kWiTE37S8WgsSPfMwmczzIu1SNsL7
 dcFVzsJLN1ch1wwHDvbHPpePSP2Xux4=
X-Google-Smtp-Source: ABdhPJxS8B02L4NqYBuOZ4RwAnnmefCXiDHEX7qb3sPvqQVxckULjvgElg/JNN/7+s9EaGT9zvKXZw==
X-Received: by 2002:a05:620a:122c:: with SMTP id
 v12mr306377qkj.113.1598637545763; 
 Fri, 28 Aug 2020 10:59:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id x28sm1278129qki.55.2020.08.28.10.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:59:05 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu/swsmu: drop set_fan_speed_percent (v2)
Date: Fri, 28 Aug 2020 13:58:51 -0400
Message-Id: <20200828175853.2378523-4-alexander.deucher@amd.com>
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

v2: minor code rework

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 -
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 -
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 31 +------------------
 7 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 0ca997f83fb6..d22a759b6b43 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -573,7 +573,6 @@ struct pptable_funcs {
 	int (*conv_power_profile_to_pplib_workload)(int power_profile);
 	uint32_t (*get_fan_control_mode)(struct smu_context *smu);
 	int (*set_fan_control_mode)(struct smu_context *smu, uint32_t mode);
-	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);
 	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
 	int (*set_xgmi_pstate)(struct smu_context *smu, uint32_t pstate);
 	int (*gfx_off_control)(struct smu_context *smu, bool enable);
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 2a3f1ee4a50b..8307e2b790da 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -200,9 +200,6 @@ int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode);
 
-int
-smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
-
 int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				       uint32_t speed);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 53e2051432bf..7a55ece1f124 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2217,14 +2217,19 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 {
 	int ret = 0;
+	uint32_t rpm;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_percent)
-		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
+	if (smu->ppt_funcs->set_fan_speed_rpm) {
+		if (speed > 100)
+			speed = 100;
+		rpm = speed * smu->fan_max_rpm / 100;
+		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, rpm);
+	}
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1998e7916fef..f6d9b0db3e82 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2363,7 +2363,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d5c25e538a03..87b5f9ff4021 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2631,7 +2631,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 97e54d382862..863372436b98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2778,7 +2778,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
-	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index ec20e839f555..5abc06f7c9f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1099,35 +1099,6 @@ smu_v11_0_set_fan_static_mode(struct smu_context *smu, uint32_t mode)
 	return 0;
 }
 
-int
-smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t duty100, duty;
-	uint64_t tmp64;
-
-	if (speed > 100)
-		speed = 100;
-
-	if (smu_v11_0_auto_fan_control(smu, 0))
-		return -EINVAL;
-
-	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
-				CG_FDO_CTRL1, FMAX_DUTY100);
-	if (!duty100)
-		return -EINVAL;
-
-	tmp64 = (uint64_t)speed * duty100;
-	do_div(tmp64, 100);
-	duty = (uint32_t)tmp64;
-
-	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
-		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
-				   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
-
-	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
-}
-
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode)
@@ -1136,7 +1107,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v11_0_set_fan_speed_percent(smu, 100);
+		ret = smu_v11_0_set_fan_speed_rpm(smu, smu->fan_max_rpm);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v11_0_auto_fan_control(smu, 0);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

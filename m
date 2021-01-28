Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8747FC433E9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 16:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A24B64DEE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A24B64DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64A66E9B6;
	Thu, 28 Jan 2021 16:53:40 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052BE6E9B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 16:53:39 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id l11so3111854qvt.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 08:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L+IwDxwVcC3W31sRY/ZZ+gXhwX9sRYj2cBrqqY46Bpk=;
 b=N/HBViQ3/rBYiU3WyON8xYg2vAbVKu8ofkOAidb+qfLEOLb1HQn/+ZJ0oWW0i1k8Us
 e1U8jD1FXGrZxJQ+Y7Qts494yLlP+ey4HdxZ7DX2Sc598R6a+h7dAP6XLt89a8lMkZZF
 GsAfVZXMorpp+ZngUS3HJcQHP9VLsk3cfJp5GbbiMzvQmq2jiGNtSAhRqeHxH8dDqUxP
 Xr2VIbrNdGht185oou/eP2JmJ/Im+EwTtbbUKpuEDjmABQemwOZ3yZpM4wxZTcK37V2a
 S4LVgc97Gqa2DUR7h17SsUCclbAefSOcP+alsFvpsiZ6wtlUAEuhn60OWC10zxACMUqI
 mKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L+IwDxwVcC3W31sRY/ZZ+gXhwX9sRYj2cBrqqY46Bpk=;
 b=nlaur/IBkOB/Usrlwmqk/rzvUtaC1CeQcVQBzb7+Y3PnUOK4L6wKuESoxbg3+H/1qC
 pYffWmejF5wtBBoQ27nN9zA9mTeYg4Ot9pGWTTwp2SsA/+cB2uOxnqsLj4oIn6FFYSsq
 FT44zju6ymhv16+ibK1B7OmeeOLbNDrFlmSPfljNGKkCkZhxElEyRbHHnDfNptVCSGR4
 stbeq81dMLTWfV8LNXP5AWmEYQvRR+nbCbPKge9jdMZjm6YrVt3txCP2jMX8LWV3+TjG
 qzEj6tmBNyY/3qzg2++G1Mt/BnqO+kfiwbsJ8UCoW79LI+zg1QkCqUzqhvoe/k9qi7CC
 VddQ==
X-Gm-Message-State: AOAM5307Y5C/QOUQR8RjGn39peqw9VvUicuUChU48o/vMnKf+Mt3vexL
 QdOS5EM91rQmQU1Cm4W1YHhfMa0o23Q=
X-Google-Smtp-Source: ABdhPJy70+EWkVtjfgofD89O8P9dIvVF/ymFuPFDgEpNdOoWC56DNGuBUeUz31v/l8CIloUMhzKQbA==
X-Received: by 2002:a0c:b485:: with SMTP id c5mr81715qve.31.1611852818911;
 Thu, 28 Jan 2021 08:53:38 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id e19sm2708038qtq.75.2021.01.28.08.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 08:53:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] Revert "drm/amdgpu/swsmu: drop set_fan_speed_percent (v2)"
Date: Thu, 28 Jan 2021 11:53:28 -0500
Message-Id: <20210128165329.558839-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

On some boards the rpm interface apparently does not work at all
leading to the fan not spinning or spinning at strange speeds.
Revert this for now to fix 5.10, 5.11.  The follow on patch
fixes this properly for 5.12.

This reverts commit 8d6e65adc25e23fabbc5293b6cd320195c708dca.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1408
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 31 ++++++++++++++++++-
 7 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 631a36a75ae3..7c5c7d605e65 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -954,7 +954,7 @@ struct pptable_funcs {
 	 * @set_fan_speed_rpm: Set a static fan speed in RPM.
 	 */
 	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
-
+	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);
 	/**
 	 * @set_xgmi_pstate: Set inter-chip global memory interconnect pstate.
 	 * &pstate: Pstate to set. D0 if Nonzero, D3 otherwise.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 102a0cf12d7a..1dfccdfc6491 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -203,6 +203,9 @@ int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode);
 
+int
+smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
+
 int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 				       uint32_t speed);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f958b02f9317..dffa6ff7ba1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2303,19 +2303,14 @@ int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 {
 	int ret = 0;
-	uint32_t rpm;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_rpm) {
-		if (speed > 100)
-			speed = 100;
-		rpm = speed * smu->fan_max_rpm / 100;
-		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, rpm);
-	}
+	if (smu->ppt_funcs->set_fan_speed_percent)
+		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index cd7b411457ff..16db0b506b0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2326,6 +2326,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
+	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..43869149dcf3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2456,6 +2456,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
+	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 24f3c96a5e5e..52ace804f5b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3130,6 +3130,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
 	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
 	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
+	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
 	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
 	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
 	.gfx_off_control = smu_v11_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..6d84aea0cc38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1174,6 +1174,35 @@ smu_v11_0_set_fan_static_mode(struct smu_context *smu, uint32_t mode)
 	return 0;
 }
 
+int
+smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
+
+	if (speed > 100)
+		speed = 100;
+
+	if (smu_v11_0_auto_fan_control(smu, 0))
+		return -EINVAL;
+
+	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	if (!duty100)
+		return -EINVAL;
+
+	tmp64 = (uint64_t)speed * duty100;
+	do_div(tmp64, 100);
+	duty = (uint32_t)tmp64;
+
+	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
+		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
+				   CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));
+
+	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
+}
+
 int
 smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 			       uint32_t mode)
@@ -1182,7 +1211,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 
 	switch (mode) {
 	case AMD_FAN_CTRL_NONE:
-		ret = smu_v11_0_set_fan_speed_rpm(smu, smu->fan_max_rpm);
+		ret = smu_v11_0_set_fan_speed_percent(smu, 100);
 		break;
 	case AMD_FAN_CTRL_MANUAL:
 		ret = smu_v11_0_auto_fan_control(smu, 0);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

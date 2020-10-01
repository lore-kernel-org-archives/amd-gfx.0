Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B180CC4741F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621AC20754
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwDxCgn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621AC20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81AF6E89A;
	Thu,  1 Oct 2020 13:17:21 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C476E89A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 13:17:20 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id s131so5190611qke.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2020 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xUIJ+eI7zOeAvzAR6AYykn/VHMg3p89CUvngImlpU+4=;
 b=GwDxCgn9vkLeX5juA8d9vsNIzsVXltrTMui3NoSMeWVlgEwIFWYd7Ivz3Ym+DdjNND
 8Dii3RVEaZikRwfZlzBPhgY+Z4uqEBiqMuSSV3DQ8eHC9uOEl/TRzENZkMtOKFwboLeP
 QBrTJGC+gVLq8c++ZSnJ3haRMtyoeidB6XM032OKhza4EMmqGh0uU9hpP9iWs+typ+uM
 NrmE2QwHX9z8B38UPGvbW1i6M7OYe/J+P3DkzoUrL3Qil8diyo1V9alNkF+efv3a9pPs
 cKBpvnim827krUW2J3NYzpJcEwVcpcaZ2eLmnCaNDYeIimt5rBJLXLApJgVnvDQthPz5
 RtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xUIJ+eI7zOeAvzAR6AYykn/VHMg3p89CUvngImlpU+4=;
 b=CitEGJSq5BEjsQK3cHbeHVCw+6us8L6U/TYIelupoOrPy20D3dAPgxynq3hbm6eeDc
 09NxQtIaCbXJDj8o/RA9e6ajuJNuhho0yw9BaVX7wh0ZBoNPNlGHpF+A1upwSU+s+GrI
 ICQQEAM7Ev197CJIM4CaQfVlLT7httR1Y7sjby2Rk/zhEON5CJnYskSf+qp1QhOE+SEp
 8lp6kTB4cgigMj5HjrhMgt5IIoz8IuVeuEOvaLKqpIE4NRpUm+tdjcVmcJbV+LQYXB2H
 Cj1XKPdFs6M2SY3JQPesHUCsOGbKTvm5s+ril1S+G9bjCn7Vjk66X9/Z08CX9d4ex0aF
 Up6w==
X-Gm-Message-State: AOAM532UXBtPWtaKX6qGMiJDUCMRRoon9XzZW0NaZSB1chMMsqKZWVer
 wMIRXw0jGdG989CVlQh9omblFchD/UI=
X-Google-Smtp-Source: ABdhPJzkIj++xAk44H6X25vwcA2HDzaF21037k/+smLaIDrabA0TYncz/ftl9kHpKrR7urdOys2Y7w==
X-Received: by 2002:a05:620a:847:: with SMTP id
 u7mr7445708qku.487.1601558239290; 
 Thu, 01 Oct 2020 06:17:19 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id x126sm6164972qka.91.2020.10.01.06.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 06:17:18 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/swsmu: add interrupt work function
Date: Thu,  1 Oct 2020 09:17:10 -0400
Message-Id: <20201001131711.279333-1-alexander.deucher@amd.com>
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

So we can schedule work from interrupts.  This might include
long tasks or things that could sleep.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index c0287c3049cc..b039cc25c855 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -453,6 +453,7 @@ struct smu_context
 
 	struct work_struct throttling_logging_work;
 	atomic64_t throttle_int_counter;
+	struct work_struct interrupt_work;
 
 	unsigned fan_max_rpm;
 	unsigned manual_fan_speed_rpm;
@@ -571,6 +572,7 @@ struct pptable_funcs {
 	int (*deep_sleep_control)(struct smu_context *smu, bool enablement);
 	int (*get_fan_parameters)(struct smu_context *smu);
 	int (*post_init)(struct smu_context *smu);
+	void (*interrupt_work)(struct smu_context *smu);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6af262e4b047..e4699b71dc49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -787,6 +787,19 @@ static void smu_throttling_logging_work_fn(struct work_struct *work)
 	smu_log_thermal_throttling(smu);
 }
 
+static void smu_interrupt_work_fn(struct work_struct *work)
+{
+	struct smu_context *smu = container_of(work, struct smu_context,
+					       interrupt_work);
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs && smu->ppt_funcs->interrupt_work)
+		smu->ppt_funcs->interrupt_work(smu);
+
+	mutex_unlock(&smu->mutex);
+}
+
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -809,6 +822,7 @@ static int smu_sw_init(void *handle)
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
+	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
@@ -1207,6 +1221,7 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	int ret = 0;
 
 	cancel_work_sync(&smu->throttling_logging_work);
+	cancel_work_sync(&smu->interrupt_work);
 
 	ret = smu_disable_thermal_alert(smu);
 	if (ret) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

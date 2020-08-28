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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6BFC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9818720776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VljGurHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9818720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8556E50D;
	Fri, 28 Aug 2020 17:59:09 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859B66E503
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 17:59:04 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id t23so142838qto.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TKY2HA/SzLZIb1ZBtJFoeTp8wR6lR8GkMdDOohqvCC8=;
 b=VljGurHiQ/V/k5mVCL4ysd6JQB5Eos7pk9DA8STr08HAreejsJwblB1YNdvq7CN9g1
 vQ5VWdyNGcjgdZM1mocAgehwBwGEEdhzJdUFEhhOjspccx9bUFggcvuux3QE3C9EGRQd
 tRznZwr9AoFHwtEkbMIAkbMEGf3XJRJPFZBrCuUZOE8pL93nvmqZUlHK3FEx44rmcg4E
 qG+b+kpRgLluxjwG8KbKhxdjjgJvN/7De221BbUa8D1sH9SYsnzuq86uHCChnLlSt6Ko
 5AtChAP/XfEENmM0566ezAEQNpCj1/t3Unp6btFKSBUksb0uPAjF/iAPS7UPOFf3s+9H
 Q+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TKY2HA/SzLZIb1ZBtJFoeTp8wR6lR8GkMdDOohqvCC8=;
 b=Cr674pb73kLEIoGZYIY7qt/4k+ABN6XW7vf98yvt16mlxHBOXgYqgno3HGBQ+c6i8U
 ulLbm9lV+uThNs5ql4Fj3jqGrYQ549WzFgjnQhCLxHQgJiAWisl+P9E3+5KtlsDlqt8J
 ikbIFPmbsiaOuZtiZsx9aT1Tr3WkQQg2GfnCQZAqjfBE9DWhmGtB6pCuOG8ijhhi1xmx
 A3m45qjrfM5wM2m3GAR2VYigs+abaezj+G7fsrMFQS8n6UNH1rMO5eojabILxrEIM+UC
 ldON/XLIDU3kifVvB4kH4lCQIM8+VfxXtQRTXE2I9Ii93PxUp8ICnXK41xOEXsy7PMz9
 vf0Q==
X-Gm-Message-State: AOAM530HgdJKhlfVuzDoPMT3wY/GLKv6eshikn989oNpYaPgHLGjl++5
 yYnR5d+Kq6JfCIoTlvb3fpceyHGNt9w=
X-Google-Smtp-Source: ABdhPJxO80UrwWY03Nc1jIWLBkkTexsFel71M9gFlsd65FmKb+g2sfOtpvFCn46UMTmwm00QBiMiZA==
X-Received: by 2002:ac8:7741:: with SMTP id g1mr2566207qtu.28.1598637543531;
 Fri, 28 Aug 2020 10:59:03 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id x28sm1278129qki.55.2020.08.28.10.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:59:03 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu/swsmu: add get_fan_parameters callbacks for
 smu11 asics
Date: Fri, 28 Aug 2020 13:58:49 -0400
Message-Id: <20200828175853.2378523-2-alexander.deucher@amd.com>
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

grab the value from the pptable.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        | 10 ++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 59b245c6c4d7..198fc1185b2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1148,6 +1148,15 @@ static int arcturus_get_fan_speed_percent(struct smu_context *smu,
 	return ret;
 }
 
+static int arcturus_get_fan_parameters(struct smu_context *smu)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+
+	smu->fan_max_rpm = pptable->FanMaximumRpm;
+
+	return 0;
+}
+
 static int arcturus_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
@@ -2397,6 +2406,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_gpu_metrics = arcturus_get_gpu_metrics,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
+	.get_fan_parameters = arcturus_get_fan_parameters,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cc67d5c60f3d..3a9500dcb436 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1385,6 +1385,15 @@ static int navi10_get_fan_speed_percent(struct smu_context *smu,
 	return ret;
 }
 
+static int navi10_get_fan_parameters(struct smu_context *smu)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+
+	smu->fan_max_rpm = pptable->FanMaximumRpm;
+
+	return 0;
+}
+
 static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
@@ -2666,6 +2675,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
+	.get_fan_parameters = navi10_get_fan_parameters,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b67931fd64b4..2ac942b13bad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1192,6 +1192,15 @@ static int sienna_cichlid_get_fan_speed_percent(struct smu_context *smu,
 	return ret;
 }
 
+static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
+{
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
+
+	smu->fan_max_rpm = pptable->FanMaximumRpm;
+
+	return 0;
+}
+
 static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
 	DpmActivityMonitorCoeffInt_t activity_monitor;
@@ -2811,6 +2820,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.enable_mgpu_fan_boost = sienna_cichlid_enable_mgpu_fan_boost,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
+	.get_fan_parameters = sienna_cichlid_get_fan_parameters,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

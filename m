Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8CFC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF032082E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kksLXHaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF032082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3DF6E878;
	Mon, 16 Dec 2019 20:09:09 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C056E878
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:09:08 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id k6so3960703qki.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p9rUdzX2y6A09T5IwLzOCeBUe3BvBB4r4TVUbcbHXB8=;
 b=kksLXHaOK86/+KdN4fyPT/3bIIHAVp/RIC/gJd09If+wLSlh85IekChgzisX3qhqly
 DIVwt/ATMYmwbbDriZYowfMoDs8BOqxPOhqc+b1A0EDcYUJHjIvfKveyLtF2+NFFks8e
 B1G+svYqZDlsj2aftGrx3BNsKBZrb88IlPq0IYAmgl6NEtAa0OZ4+bpaIM6K8Snvi93x
 s+HCtCSWTYjF4WZ41GcnjontIfEEQ+mWrOGg/bFSj1FJG9/nnluYXV+C/9q9KBJiUma5
 ntOKTAXGYtIVaHWejPVlqoB1SHrbIxB5c8hsN9AYtaaIkYkIiTDaMvNEXhBZs0Qv+SJP
 i38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p9rUdzX2y6A09T5IwLzOCeBUe3BvBB4r4TVUbcbHXB8=;
 b=PdDsqtm9qeZ3RcOovaFdhcqpju1C9lhBv5/x1pfFKZ16kN/gvy2PuU8hOGffGGYtSJ
 jKMPc5BDjynE1F7Ln2lW9Dfugvi3EtH23zIUj13PqqU76oEsbUN1n75HhxBpkqyfBLCo
 TW6H26PkacyXD8iYIaDuEWMwDcMJil+aGAp3ob1VxaATtgVi9KlL02Njgb/K4SAaZpC5
 O915+GEN19nYqPKbUjZxPteJbVWN2sAGCbkuKiXbfqawaEgGM4YGtU4Sy74/knGmmA7O
 RphZn0VsW6pr5cQZvVow+EWEBzgrcWpZ3bez++1QWVET/Fnu1ntZkUwDvmOlHbLkE6gX
 Trgg==
X-Gm-Message-State: APjAAAXBHIbCU+yEbiIoxN/CmBcssvGSjm7dlTqOwHwV+/b+DTFP/nMk
 VldTH7bs2RT/4PYOsicGhYV6Id2S
X-Google-Smtp-Source: APXvYqyYUMguT28UxE7dQxaIHM46AQjGNLlK1/WgH8Yrc/uw24uaadxgv/e+uuaPqnoHbS2ohWGyoQ==
X-Received: by 2002:a37:2f02:: with SMTP id v2mr1174683qkh.3.1576526947589;
 Mon, 16 Dec 2019 12:09:07 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id s27sm6270331qkm.97.2019.12.16.12.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 12:09:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu: fix spelling
Date: Mon, 16 Dec 2019 15:08:59 -0500
Message-Id: <20191216200859.314406-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
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

s/dispaly/display/g

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 2 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 2 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 4 ++--
 drivers/gpu/drm/amd/powerplay/smu_internal.h   | 4 ++--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c     | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 6dddd7818558..f76a1717ffbd 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1670,7 +1670,7 @@ int smu_adjust_power_state_dynamic(struct smu_context *smu,
 	}
 
 	if (!skip_display_settings) {
-		ret = smu_notify_smc_dispaly_config(smu);
+		ret = smu_notify_smc_display_config(smu);
 		if (ret) {
 			pr_err("Failed to notify smc display config!");
 			return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ca3fdc6777cf..a7d0ad831491 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -443,7 +443,7 @@ struct pptable_funcs {
 	int (*pre_display_config_changed)(struct smu_context *smu);
 	int (*display_config_changed)(struct smu_context *smu);
 	int (*apply_clocks_adjust_rules)(struct smu_context *smu);
-	int (*notify_smc_dispaly_config)(struct smu_context *smu);
+	int (*notify_smc_display_config)(struct smu_context *smu);
 	int (*force_dpm_limit_value)(struct smu_context *smu, bool highest);
 	int (*unforce_dpm_levels)(struct smu_context *smu);
 	int (*get_profiling_clk_mask)(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 15403b7979d6..7b42e72dc939 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1374,7 +1374,7 @@ static int navi10_get_profiling_clk_mask(struct smu_context *smu,
 	return ret;
 }
 
-static int navi10_notify_smc_dispaly_config(struct smu_context *smu)
+static int navi10_notify_smc_display_config(struct smu_context *smu)
 {
 	struct smu_clocks min_clocks = {0};
 	struct pp_display_clock_request clock_req;
@@ -2047,7 +2047,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_clock_by_type_with_latency = navi10_get_clock_by_type_with_latency,
 	.pre_display_config_changed = navi10_pre_display_config_changed,
 	.display_config_changed = navi10_display_config_changed,
-	.notify_smc_dispaly_config = navi10_notify_smc_dispaly_config,
+	.notify_smc_display_config = navi10_notify_smc_display_config,
 	.force_dpm_limit_value = navi10_force_dpm_limit_value,
 	.unforce_dpm_levels = navi10_unforce_dpm_levels,
 	.is_dpm_running = navi10_is_dpm_running,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 60ce1fccaeb5..77864e4236c4 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -129,8 +129,8 @@ int smu_send_smc_msg(struct smu_context *smu, enum smu_message_type msg);
 	((smu)->ppt_funcs->display_config_changed ? (smu)->ppt_funcs->display_config_changed((smu)) : 0)
 #define smu_apply_clocks_adjust_rules(smu) \
 	((smu)->ppt_funcs->apply_clocks_adjust_rules ? (smu)->ppt_funcs->apply_clocks_adjust_rules((smu)) : 0)
-#define smu_notify_smc_dispaly_config(smu) \
-	((smu)->ppt_funcs->notify_smc_dispaly_config ? (smu)->ppt_funcs->notify_smc_dispaly_config((smu)) : 0)
+#define smu_notify_smc_display_config(smu) \
+	((smu)->ppt_funcs->notify_smc_display_config ? (smu)->ppt_funcs->notify_smc_display_config((smu)) : 0)
 #define smu_force_dpm_limit_value(smu, highest) \
 	((smu)->ppt_funcs->force_dpm_limit_value ? (smu)->ppt_funcs->force_dpm_limit_value((smu), (highest)) : 0)
 #define smu_unforce_dpm_levels(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 12bcc3e3ba99..2b1c3f8a0415 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -2232,7 +2232,7 @@ static int vega20_apply_clocks_adjust_rules(struct smu_context *smu)
 }
 
 static int
-vega20_notify_smc_dispaly_config(struct smu_context *smu)
+vega20_notify_smc_display_config(struct smu_context *smu)
 {
 	struct vega20_dpm_table *dpm_table = smu->smu_dpm.dpm_context;
 	struct vega20_single_dpm_table *memtable = &dpm_table->mem_table;
@@ -3200,7 +3200,7 @@ static const struct pptable_funcs vega20_ppt_funcs = {
 	.pre_display_config_changed = vega20_pre_display_config_changed,
 	.display_config_changed = vega20_display_config_changed,
 	.apply_clocks_adjust_rules = vega20_apply_clocks_adjust_rules,
-	.notify_smc_dispaly_config = vega20_notify_smc_dispaly_config,
+	.notify_smc_display_config = vega20_notify_smc_display_config,
 	.force_dpm_limit_value = vega20_force_dpm_limit_value,
 	.unforce_dpm_levels = vega20_unforce_dpm_levels,
 	.get_profiling_clk_mask = vega20_get_profiling_clk_mask,
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

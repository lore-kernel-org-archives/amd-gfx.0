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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5463DC4727F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAD6206B5
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt0JwSSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAD6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BE16E89E;
	Thu,  1 Oct 2020 13:17:22 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1B76E89A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 13:17:21 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id h1so2871357qvo.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2020 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4FHgww30MjVtSdIKliBz0PI/emwz+Hi4CmuIDXfrD3Y=;
 b=Vt0JwSSOCOTPKhrfocJzdSgkhIwrJ5aL1q4KDQgy07qECG5OkmIoZiQpuYa1vz07Qz
 sedKqePIRIOpUWfGWWxruAwtX5tlxgB3XcarINiddgEcZv/Gf6CyMmwKUzBtHksR6Ktu
 0Zb281tejuB9NEfDfUGTeJcz9BcBFfwFnvcYNFm8cUJn9f3mvZqJvASZq/MkGKzPHpQG
 MJ4of768GkjjQdsM11TxdjvMd97xJnwK2C+5J2il9HztGRxPSTW/3TIiQn2U4BAkeorZ
 AplkwLblIDQP1GfyzcocnVMGapobEgLhGd39XkIF1W2dm+eEZ3EXtOtBRR80tfUllyio
 mMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4FHgww30MjVtSdIKliBz0PI/emwz+Hi4CmuIDXfrD3Y=;
 b=Y0f9M/aXLb6F3paTELSL/wTCec5GkSTFzJJl191IEg49PzYemFEVxGPwlipEjHOl04
 xsEdVo6krdKf91i5xh7XOKC6duVcCrkHO7fXmV90Kc/HoZ5NorOW//AbWJHKmWgm5OcL
 JBrtIXHtEkyVrLdm4A6LnBvnDOaLsaDxUgAuIHdIVitYtBJ1IkRnrAqjCS7V88YWXL4p
 yCxcU8D83A2MmXFUvZaOl+sUNwJOMdKEd3yiaK/D9OkpzF1GLevs7mYjjYQf0mazXjxz
 6H9XSudri0XXE7mR97coIAArk1cy9lFEkVpORpAWofE4svQZzQ/sSDcwuGibs6BArw0z
 ceyQ==
X-Gm-Message-State: AOAM533hmnImE2BjZcSI+QqMeVI/YADTucFoYcUnipYpdPsSaKsDrFG3
 WMaTmkjjsv4rmCO2FPwqVTqp7vUEy8w=
X-Google-Smtp-Source: ABdhPJyQrZ6JhqzImvxdvAPnI7mF9f3jq9j9KZFd3LKp1lx0wZs/T+i+x+v6awfD+kmhlp+V6J221w==
X-Received: by 2002:a0c:bd02:: with SMTP id m2mr7831188qvg.0.1601558240196;
 Thu, 01 Oct 2020 06:17:20 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id x126sm6164972qka.91.2020.10.01.06.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 06:17:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/swsmu: add interrupt work handler for smu11
 parts
Date: Thu,  1 Oct 2020 09:17:11 -0400
Message-Id: <20201001131711.279333-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201001131711.279333-1-alexander.deucher@amd.com>
References: <20201001131711.279333-1-alexander.deucher@amd.com>
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

We need to schedule the smu AC/DC interrupt ack to avoid
potentially sleeping if the smu message mutex is contended.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                 |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c         | 10 ++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c       |  1 +
 6 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index f57dc586649a..8885bde3ea3d 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -281,5 +281,7 @@ int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 				 bool enablement);
 
+void smu_v11_0_interrupt_work(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d298fa65274d..fc376281e629 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2388,6 +2388,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = arcturus_get_fan_parameters,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index be44cb941e73..3f1377f28493 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2755,6 +2755,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a2cb831ce8aa..3c8732f34b1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2784,6 +2784,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
 	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 	.get_fan_parameters = sienna_cichlid_get_fan_parameters,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index effa4391b577..3e949e53cdc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -958,6 +958,12 @@ static int smu_v11_0_process_pending_interrupt(struct smu_context *smu)
 	return ret;
 }
 
+void smu_v11_0_interrupt_work(struct smu_context *smu)
+{
+	if (smu_v11_0_ack_ac_dc_interrupt(smu))
+		dev_err(smu->adev->dev, "Ack AC/DC interrupt Failed!\n");
+}
+
 int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1323,11 +1329,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 			switch (ctxid) {
 			case 0x3:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
-				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+				schedule_work(&smu->interrupt_work);
 				break;
 			case 0x4:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
-				smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
+				schedule_work(&smu->interrupt_work);
 				break;
 			case 0x7:
 				/*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index d6759de40503..145712a24b80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -341,6 +341,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
+	.interrupt_work = smu_v11_0_interrupt_work,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

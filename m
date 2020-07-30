Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C4C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A1D2072A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmwGick5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A1D2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5DAE6E95B;
	Thu, 30 Jul 2020 19:24:49 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A0E6E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:24:47 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id l23so26743570qkk.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JYeynkPIivTD/DtZOxTYtcIythtFUEZ9Ml060YzM/qE=;
 b=nmwGick5ZxdFIwdQ2VwKFrd59O+mUKsdA837SNUt0ySTJf+CCk4EyelqNGmtoygyg9
 P9PC94EzB3rZjzAvIMV89MRzjq5f48t4LciUabaJn7KptiD/hJcPFPKPsAEBJOBKgPo9
 649n7vJl4AsECDsCORA3Sz2PnNttVui7mBFD5FNQNRO5EGCEKac5ci/5Ng14h7+F+9QR
 cw38Rh0naTtOgooDxQFmnl9LV/E+ZIeGXSL1c19r7Nw1bcYz1vZyc9Bw/zzCvMu9264h
 RrHTvGSkSd3RHUmXH6c8z53lEuodtAi94WNBlfw4isBt611NshSsPfXlTARKw28Aysgq
 rayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JYeynkPIivTD/DtZOxTYtcIythtFUEZ9Ml060YzM/qE=;
 b=VGgp6r8ump67guGgBflin5INUHwYMUelFSqLYwFusceRuNiAl1kTil7gF1Rq0hcQJg
 8atpjJ6gbwL2ZYk1EI0oXddt94jC8KXB7vQFTcQGALZnpjCFi8kX7F2zaU+gEr6dWjLF
 dk6K65gXZeJsqhsE+5qimZlcPjnT2DqU+Kh7GeHrJhb3/EgGxLi2EDAuyy8gDxQib0eX
 TYJAi/ZF9hOSaS92HtRn3jiqLT7107FUWpkoza4okdU/rGY5zmKJHPKjVQ6nZBve9DlR
 rvy9jw9TkHIoGWIM+QMqZfBtUMUC8ilX9TS6Y6zhagKFLr8mDjFEZw9BllorDUUJB1yB
 2n+g==
X-Gm-Message-State: AOAM530DiRcu1v/YmpbFmKWG2mCZhgZWs2eOfwoIjMAS/H5pRgmuyzQr
 7TCOyAlAsqrqMBN+hM6JPsO7KSKC
X-Google-Smtp-Source: ABdhPJx9QmM+UD6Y52h96T3DJBw5TXUcGIjA8EXDZGC6d8ajR+M3VY36Rv6WDOJsU7ohCpbj9KOeGQ==
X-Received: by 2002:a37:e89:: with SMTP id 131mr714432qko.279.1596137086489;
 Thu, 30 Jul 2020 12:24:46 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q126sm4512113qke.34.2020.07.30.12.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 12:24:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/smu: rework i2c adpater registration
Date: Thu, 30 Jul 2020 15:24:39 -0400
Message-Id: <20200730192439.2005-1-alexander.deucher@amd.com>
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

The i2c init/fini functions just register the i2c adapter.
There is no need to call them during hw init/fini.  They only
need to be called once per driver init/fini.  The previous
behavior broke runtime pm because we unregistered the i2c
adapter during suspend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 12 ++++++------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 14 --------------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 14 --------------
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 14 --------------
 4 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..d03b4852ed5f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -579,6 +579,10 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = smu_i2c_init(smu, &smu->adev->pm.smu_i2c);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -586,6 +590,8 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
 {
 	int ret;
 
+	smu_i2c_fini(smu, &smu->adev->pm.smu_i2c);
+
 	ret = smu_free_memory_pool(smu);
 	if (ret)
 		return ret;
@@ -845,10 +851,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	ret = smu_i2c_init(smu, &adev->pm.smu_i2c);
-	if (ret)
-		return ret;
-
 	ret = smu_disable_umc_cdr_12gbps_workaround(smu);
 	if (ret) {
 		dev_err(adev->dev, "Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
@@ -1047,8 +1049,6 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	smu_i2c_fini(smu, &adev->pm.smu_i2c);
-
 	cancel_work_sync(&smu->throttling_logging_work);
 
 	ret = smu_disable_thermal_alert(smu);
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f13979687b9e..0147a5b9b06d 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2080,22 +2080,11 @@ static const struct i2c_algorithm arcturus_i2c_algo = {
 	.functionality = arcturus_i2c_func,
 };
 
-static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-
-	return control->dev.parent == &adev->pdev->dev;
-}
-
 static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
 
-	/* smu_i2c_eeprom_init may be called twice in sriov */
-	if (arcturus_i2c_adapter_is_added(control))
-		return 0;
-
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
@@ -2111,9 +2100,6 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 
 static void arcturus_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
 {
-	if (!arcturus_i2c_adapter_is_added(control))
-		return;
-
 	i2c_del_adapter(control);
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6aaf483858a0..c33bdc6747f2 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2457,22 +2457,11 @@ static const struct i2c_algorithm navi10_i2c_algo = {
 	.functionality = navi10_i2c_func,
 };
 
-static bool navi10_i2c_adapter_is_added(struct i2c_adapter *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-
-	return control->dev.parent == &adev->pdev->dev;
-}
-
 static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
 
-	/* smu_i2c_eeprom_init may be called twice in sriov */
-	if (navi10_i2c_adapter_is_added(control))
-		return 0;
-
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
@@ -2488,9 +2477,6 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 
 static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
 {
-	if (!navi10_i2c_adapter_is_added(control))
-		return;
-
 	i2c_del_adapter(control);
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index f64a1be94cb8..f373e2d0d31c 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2630,22 +2630,11 @@ static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
 	.functionality = sienna_cichlid_i2c_func,
 };
 
-static bool sienna_cichlid_i2c_adapter_is_added(struct i2c_adapter *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-
-	return control->dev.parent == &adev->pdev->dev;
-}
-
 static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
 
-	/* smu_i2c_eeprom_init may be called twice in sriov */
-	if (sienna_cichlid_i2c_adapter_is_added(control))
-		return 0;
-
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
@@ -2661,9 +2650,6 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
 
 static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
 {
-	if (!sienna_cichlid_i2c_adapter_is_added(control))
-		return;
-
 	i2c_del_adapter(control);
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

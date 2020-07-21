Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4548AC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE9C20792
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgpm8jDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE9C20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C1E89C93;
	Tue, 21 Jul 2020 16:52:51 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CA189C93
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:52:50 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id di5so9623827qvb.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uL7NlRCwkJMFXKX8dHXCyPAyx/ncleGIUTDq6tPRLwU=;
 b=Tgpm8jDSsUXylnr4dtw491NGuvNIJMQV58HesE9W24Fg+l1lbohf7rLAzV5o8EPBzu
 LHdth6dH4VSZsB0hSfwqry1cHAzULVbatqOpDXT5VwTEucj0JeeMb/PGeJbdOo5n6qhK
 z3LEZ4vRRTUE25yVRPimNX5J1Xm1BX/vK6njoNBpME2q21fD8h98wV2ezfMhKHe8wDnQ
 60QWLykYqakxbthlZKlrcr+NsALGndx9JW9PsBlaDxGGSjAR6s3R4/K0vOZWlLrCwd+U
 bqPOPPXFhsTZCsxmu0xKY+CTY177QARybVKPVO4sZFkUm7eqItXvowQZ30bqYCzKoJKF
 LLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uL7NlRCwkJMFXKX8dHXCyPAyx/ncleGIUTDq6tPRLwU=;
 b=pkwADuMl6PSFbcDG+Ble3ni98YeK25I831FKbkgOB6poBIn2mLSnyuEmgS3tL2lwRB
 RG1h09HoOcRY0jfX9wneX1vnxb1sVm8TNBbGFVIs01Rjboy4sPPmIE9FRVsUkAD9mIt/
 lH3kmM1dpY2nFXqtkTz95Fnio9bjcbe83KIYqZJeMZR0cnpadLImInAk6kFaqsCdxWOI
 QWiTd3b+Rgj3jf2suwmCALkwGe7zUADbmxCFVbT1T3rJ4UJ2U7kX7hDmUQNKHo4mFH5d
 kKvKMgf8wQwl9SCl/v31D6IL2MWe9LAjBxBlUMSr98B/l+JO4jFJIGvX/8dNEQg9BvD1
 Z5bA==
X-Gm-Message-State: AOAM531URJIu4Jsq9+xnbZQcNvGIcFHU+kJMh+mQMps0VbOjkzOw6RjH
 8HpCrO5Sk7cBTGLcscdulc8MHkt4
X-Google-Smtp-Source: ABdhPJx5810Eex6nDYKb+r+xRdYAcRe9vilsviDvGwzF+LEpzVUdE6kUwOG/doBbwdaXL+cpqY2QjQ==
X-Received: by 2002:a0c:f214:: with SMTP id h20mr26694290qvk.131.1595350369597; 
 Tue, 21 Jul 2020 09:52:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d16sm2709212qkk.106.2020.07.21.09.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:52:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: remove eeprom from the smu i2c handlers
Date: Tue, 21 Jul 2020 12:52:36 -0400
Message-Id: <20200721165240.296265-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721165240.296265-1-alexander.deucher@amd.com>
References: <20200721165240.296265-1-alexander.deucher@amd.com>
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

The driver uses it for EEPROM access, but it's just an i2c bus.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    | 52 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h    |  4 +-
 .../drm/amd/powerplay/smumgr/vega20_smumgr.c  |  4 +-
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index f3d0324c4a7f..d55bf64770c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -536,12 +536,12 @@ static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
 	return false;
 }
 
-/***************************** EEPROM I2C GLUE ****************************/
+/***************************** I2C GLUE ****************************/
 
-static uint32_t smu_v11_0_i2c_eeprom_read_data(struct i2c_adapter *control,
-					       uint8_t address,
-					       uint8_t *data,
-					       uint32_t numbytes)
+static uint32_t smu_v11_0_i2c_read_data(struct i2c_adapter *control,
+					uint8_t address,
+					uint8_t *data,
+					uint32_t numbytes)
 {
 	uint32_t  ret = 0;
 
@@ -561,10 +561,10 @@ static uint32_t smu_v11_0_i2c_eeprom_read_data(struct i2c_adapter *control,
 	return ret;
 }
 
-static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
-						uint8_t address,
-						uint8_t *data,
-						uint32_t numbytes)
+static uint32_t smu_v11_0_i2c_write_data(struct i2c_adapter *control,
+					 uint8_t address,
+					 uint8_t *data,
+					 uint32_t numbytes)
 {
 	uint32_t  ret;
 
@@ -624,7 +624,7 @@ static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
 	.unlock_bus = unlock_bus,
 };
 
-static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
+static int smu_v11_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	int i, ret;
@@ -639,13 +639,13 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	for (i = 0; i < num; i++) {
 		if (msgs[i].flags & I2C_M_RD)
-			ret = smu_v11_0_i2c_eeprom_read_data(i2c_adap,
-							(uint8_t)msgs[i].addr,
-							msgs[i].buf, msgs[i].len);
+			ret = smu_v11_0_i2c_read_data(i2c_adap,
+						      (uint8_t)msgs[i].addr,
+						      msgs[i].buf, msgs[i].len);
 		else
-			ret = smu_v11_0_i2c_eeprom_write_data(i2c_adap,
-							 (uint8_t)msgs[i].addr,
-							 msgs[i].buf, msgs[i].len);
+			ret = smu_v11_0_i2c_write_data(i2c_adap,
+						       (uint8_t)msgs[i].addr,
+						       msgs[i].buf, msgs[i].len);
 
 		if (ret != I2C_OK) {
 			num = -EIO;
@@ -657,18 +657,18 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
 	return num;
 }
 
-static u32 smu_v11_0_i2c_eeprom_i2c_func(struct i2c_adapter *adap)
+static u32 smu_v11_0_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 
-static const struct i2c_algorithm smu_v11_0_i2c_eeprom_i2c_algo = {
-	.master_xfer = smu_v11_0_i2c_eeprom_i2c_xfer,
-	.functionality = smu_v11_0_i2c_eeprom_i2c_func,
+static const struct i2c_algorithm smu_v11_0_i2c_algo = {
+	.master_xfer = smu_v11_0_i2c_xfer,
+	.functionality = smu_v11_0_i2c_func,
 };
 
-int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
+int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
@@ -676,8 +676,8 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
-	control->algo = &smu_v11_0_i2c_eeprom_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
+	control->algo = &smu_v11_0_i2c_algo;
+	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
 	control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
 
 	res = i2c_add_adapter(control);
@@ -687,7 +687,7 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
 	return res;
 }
 
-void smu_v11_0_i2c_eeprom_control_fini(struct i2c_adapter *control)
+void smu_v11_0_i2c_control_fini(struct i2c_adapter *control)
 {
 	i2c_del_adapter(control);
 }
@@ -715,9 +715,9 @@ bool smu_v11_0_i2c_test_bus(struct i2c_adapter *control)
 	smu_v11_0_i2c_init(control);
 
 	/* Write 0xde to address 0x0000 on the EEPROM */
-	ret = smu_v11_0_i2c_eeprom_write_data(control, I2C_TARGET_ADDR, data, 6);
+	ret = smu_v11_0_i2c_write_data(control, I2C_TARGET_ADDR, data, 6);
 
-	ret = smu_v11_0_i2c_eeprom_read_data(control, I2C_TARGET_ADDR, data, 6);
+	ret = smu_v11_0_i2c_read_data(control, I2C_TARGET_ADDR, data, 6);
 
 	smu_v11_0_i2c_fini(control);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h
index 973f28d68e70..44467c05f642 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h
@@ -28,7 +28,7 @@
 
 struct i2c_adapter;
 
-int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control);
-void smu_v11_0_i2c_eeprom_control_fini(struct i2c_adapter *control);
+int smu_v11_0_i2c_control_init(struct i2c_adapter *control);
+void smu_v11_0_i2c_control_fini(struct i2c_adapter *control);
 
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index c2e0fbbccf56..d1b7955bb4c7 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -523,7 +523,7 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size = sizeof(DpmActivityMonitorCoeffInt_t);
 
 	if (adev->psp.ras.ras) {
-		ret = smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
+		ret = smu_v11_0_i2c_control_init(&adev->pm.smu_i2c);
 		if (ret)
 			goto err4;
 	}
@@ -563,7 +563,7 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
 	struct amdgpu_device *adev = hwmgr->adev;
 
 	if (adev->psp.ras.ras)
-		smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
+		smu_v11_0_i2c_control_fini(&adev->pm.smu_i2c);
 
 	if (priv) {
 		amdgpu_bo_free_kernel(&priv->smu_tables.entry[TABLE_PPTABLE].handle,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

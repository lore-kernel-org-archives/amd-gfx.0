Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C26FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0645206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAm1yI6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0645206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9053A892D8;
	Tue, 21 Jul 2020 18:09:11 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8611892D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:09:10 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id ed14so9763708qvb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OiZfw7BivxHe5t4WdvP/Xi1WL6cb53dPLe1UR1RAl2I=;
 b=ZAm1yI6FgWFbzbk1GyfW0KHC+K6YMoKZbsijISnzbaA8cSywzUw1PhqiBBREelXpl6
 yrNrzw9cuItT7tBIemzzz89ljPPoqJ/PNhNFryHNsuVD5GnHa9ia7BZs4GetEMv0bF3j
 hyrmpn9R04NhcxTU7BlrQ/Kl4eX5sQTPKfSiQetaeYcqmSVB5hORFPVJ9GmnEdPqYJXi
 CTeVBRtB+weDxs8Jv+XLy+xIYyhYf7bTDpWOlhHgNFAbvF0lsN3UPWONEBsHYC2OEukL
 eGdsYk8VQbu2OoHq4zklHTM1KqM1uKbkmPgoGoYvTHRghJKlxFFAFcMwLRsOrVhx4KZ4
 hOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OiZfw7BivxHe5t4WdvP/Xi1WL6cb53dPLe1UR1RAl2I=;
 b=N7y0zahmIrgu0uvpdt4XVofGy7xGISAEYy0GiyBoJ8jen0tW6l/TPa+oXVjk71lJVY
 LHgXumqJDD92AefVsJmYl4t80hAuMK2s+b5njWWWFXcgWCaiqkqdyiY8Pyi+wqtyCRN6
 tZSNM8ufmmgPEiO5b59XvqEyDbx4TK5dKWKf7vbfThqcluWz7F/YgClfTkkznwaYMuMz
 N2WxDdd1k1pOssTbmS7a3+u6bxT4tFHQ7rMy5Hh+Ln91r/57JqQINkQCEosdHgR/6TfK
 dBdWdHMJjgA8Okt/CcMCCxIyh1TYBtqAePRE5yQOsAak+dBYyQx89Z6yYdDPPMsqyAWS
 3ODg==
X-Gm-Message-State: AOAM532tt1Xvld4kJsh0yyQ1kvjdUWxuWlsWOEhukKFewMpHaO2J7UQv
 ziGGBmCGssuMcCArEZCAl2URDFIg
X-Google-Smtp-Source: ABdhPJw0AnB9OLK7uT80Llm/tgjkwffF96XfdmSUI/7P5LpWRDBQbnvdHOlKVkZ2E646nWmQ91p31Q==
X-Received: by 2002:a05:6214:a6c:: with SMTP id
 ef12mr27533020qvb.74.1595354949193; 
 Tue, 21 Jul 2020 11:09:09 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t65sm2957284qkf.119.2020.07.21.11.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:09:08 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: remove eeprom from the smu i2c handlers
Date: Tue, 21 Jul 2020 14:08:46 -0400
Message-Id: <20200721180850.813406-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721180850.813406-1-alexander.deucher@amd.com>
References: <20200721180850.813406-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver uses it for EEPROM access, but it's just an i2c bus.

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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

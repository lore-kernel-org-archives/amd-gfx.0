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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B4C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FFA2073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLCcGMPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FFA2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D0989CF9;
	Tue, 21 Jul 2020 16:52:54 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F0089CF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:52:53 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id q2so9157180qkc.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lWLQsRstgjx5rvcP52F0jqF6zr7oZKpubDXfqtwHCG0=;
 b=VLCcGMPDMU2EEOIymOnCneUf0Bbv8MiOAN8bvQqbbFTSL4GZmO+yD57O669AYe4iUn
 MCWX1MHA5A3y/2mQSL5uVZX4LvZ89NOwzlk3vsir3VKZyUlAo1Uvch1uqpm86izOrAMV
 DOki+WowPeIB9wtGzGcvfvVenPQ70E6aZQZgzLziUwVnf1yseqUoXbv+g+oExUlACLAq
 142nU8bn1jJU6G2SLg4C3TTMAMOMdry4iWudtRZczjAdHFB41qHcOK8nNroTIqmlRMSX
 FpSw/8b+AReP+RGM5hWAbQ1awoUB7r4DciAaob9nWcRaW/MUUQbRRsyxb7OolyAhPXsO
 gEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lWLQsRstgjx5rvcP52F0jqF6zr7oZKpubDXfqtwHCG0=;
 b=RL7Q4FHTAp3mkMUP468GKQ5zJiMWoGYMA7RhOfNfVaIy1nohwJ7bCWlKTlai/G4kqc
 TgI3yl+GHkMt4QFW1QWRmBnAA4gEI2qj8BPa6sH6TVVZDkvJj361ny1EIIYzfY+4Wz+H
 Un32yMfP/BjtnAVh6aQxO7s5uNMKbaamvkTCvbdoqIbLjWv9V+MPz7kqUDO4K6CdHs46
 qWO/jC8NvFDpnk+tY51MUnh15+JFa5mnB8zdxUgVHXhLf7RVYx5NMBZBXJC7xcfMgwus
 66GJaHsLzRof92HG3aLdHPA9uatVusUeiuEyeVY3rJGRHDCNrHL6JZIPSMKpaDrhRFqJ
 Qn8w==
X-Gm-Message-State: AOAM533L01nvI89+sqr7oX2bE9bscsL6F7HB/yGh70+0UrFLulHm33IG
 Rs00c1DhnXBuOBm+7u74wc4QllAE
X-Google-Smtp-Source: ABdhPJysJ5LFXoHwEpi50a5E8iDH6Pqn51xbyLzzjPOHqnWBvkjjvRh7IbA/nCxbWUvQz1FTeH8VIg==
X-Received: by 2002:a05:620a:2482:: with SMTP id
 i2mr9517450qkn.364.1595350371897; 
 Tue, 21 Jul 2020 09:52:51 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d16sm2709212qkk.106.2020.07.21.09.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:52:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu/swSMU: remove eeprom from the smu i2c handlers
Date: Tue, 21 Jul 2020 12:52:38 -0400
Message-Id: <20200721165240.296265-4-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 60 ++++++++++----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 56dc20a617fd..7ab606734dcf 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1947,7 +1947,7 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 	return ret;
 }
 
-static void arcturus_fill_eeprom_i2c_req(SwI2cRequest_t  *req, bool write,
+static void arcturus_fill_i2c_req(SwI2cRequest_t  *req, bool write,
 				  uint8_t address, uint32_t numbytes,
 				  uint8_t *data)
 {
@@ -1981,7 +1981,7 @@ static void arcturus_fill_eeprom_i2c_req(SwI2cRequest_t  *req, bool write,
 	}
 }
 
-static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
+static int arcturus_i2c_read_data(struct i2c_adapter *control,
 					       uint8_t address,
 					       uint8_t *data,
 					       uint32_t numbytes)
@@ -1993,7 +1993,7 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
 	struct smu_table *table = &smu_table->driver_table;
 
 	memset(&req, 0, sizeof(req));
-	arcturus_fill_eeprom_i2c_req(&req, false, address, numbytes, data);
+	arcturus_fill_i2c_req(&req, false, address, numbytes, data);
 
 	mutex_lock(&adev->smu.mutex);
 	/* Now read data starting with that address */
@@ -2008,18 +2008,18 @@ static int arcturus_i2c_eeprom_read_data(struct i2c_adapter *control,
 		for (i = 0; i < numbytes; i++)
 			data[i] = res->SwI2cCmds[i].Data;
 
-		dev_dbg(adev->dev, "arcturus_i2c_eeprom_read_data, address = %x, bytes = %d, data :",
+		dev_dbg(adev->dev, "arcturus_i2c_read_data, address = %x, bytes = %d, data :",
 				  (uint16_t)address, numbytes);
 
 		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
 			       8, 1, data, numbytes, false);
 	} else
-		dev_err(adev->dev, "arcturus_i2c_eeprom_read_data - error occurred :%x", ret);
+		dev_err(adev->dev, "arcturus_i2c_read_data - error occurred :%x", ret);
 
 	return ret;
 }
 
-static int arcturus_i2c_eeprom_write_data(struct i2c_adapter *control,
+static int arcturus_i2c_write_data(struct i2c_adapter *control,
 						uint8_t address,
 						uint8_t *data,
 						uint32_t numbytes)
@@ -2029,7 +2029,7 @@ static int arcturus_i2c_eeprom_write_data(struct i2c_adapter *control,
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 
 	memset(&req, 0, sizeof(req));
-	arcturus_fill_eeprom_i2c_req(&req, true, address, numbytes, data);
+	arcturus_fill_i2c_req(&req, true, address, numbytes, data);
 
 	mutex_lock(&adev->smu.mutex);
 	ret = smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
@@ -2055,7 +2055,7 @@ static int arcturus_i2c_eeprom_write_data(struct i2c_adapter *control,
 	return ret;
 }
 
-static int arcturus_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
+static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr = 0;
@@ -2078,18 +2078,18 @@ static int arcturus_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
 			data_chunk[1] = (next_eeprom_addr & 0xff);
 
 			if (msgs[i].flags & I2C_M_RD) {
-				ret = arcturus_i2c_eeprom_read_data(i2c_adap,
-								(uint8_t)msgs[i].addr,
-								data_chunk, MAX_SW_I2C_COMMANDS);
+				ret = arcturus_i2c_read_data(i2c_adap,
+							     (uint8_t)msgs[i].addr,
+							     data_chunk, MAX_SW_I2C_COMMANDS);
 
 				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
 			} else {
 
 				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
 
-				ret = arcturus_i2c_eeprom_write_data(i2c_adap,
-								 (uint8_t)msgs[i].addr,
-								 data_chunk, MAX_SW_I2C_COMMANDS);
+				ret = arcturus_i2c_write_data(i2c_adap,
+							      (uint8_t)msgs[i].addr,
+							      data_chunk, MAX_SW_I2C_COMMANDS);
 			}
 
 			if (ret) {
@@ -2106,17 +2106,17 @@ static int arcturus_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
 			data_chunk[1] = (next_eeprom_addr & 0xff);
 
 			if (msgs[i].flags & I2C_M_RD) {
-				ret = arcturus_i2c_eeprom_read_data(i2c_adap,
-								(uint8_t)msgs[i].addr,
-								data_chunk, (data_size % data_chunk_size) + 2);
+				ret = arcturus_i2c_read_data(i2c_adap,
+							     (uint8_t)msgs[i].addr,
+							     data_chunk, (data_size % data_chunk_size) + 2);
 
 				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
 			} else {
 				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
 
-				ret = arcturus_i2c_eeprom_write_data(i2c_adap,
-								 (uint8_t)msgs[i].addr,
-								 data_chunk, (data_size % data_chunk_size) + 2);
+				ret = arcturus_i2c_write_data(i2c_adap,
+							      (uint8_t)msgs[i].addr,
+							      data_chunk, (data_size % data_chunk_size) + 2);
 			}
 
 			if (ret) {
@@ -2130,15 +2130,15 @@ static int arcturus_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
 	return num;
 }
 
-static u32 arcturus_i2c_eeprom_i2c_func(struct i2c_adapter *adap)
+static u32 arcturus_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 
-static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
-	.master_xfer = arcturus_i2c_eeprom_i2c_xfer,
-	.functionality = arcturus_i2c_eeprom_i2c_func,
+static const struct i2c_algorithm arcturus_i2c_algo = {
+	.master_xfer = arcturus_i2c_xfer,
+	.functionality = arcturus_i2c_func,
 };
 
 static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)
@@ -2148,7 +2148,7 @@ static bool arcturus_i2c_adapter_is_added(struct i2c_adapter *control)
 	return control->dev.parent == &adev->pdev->dev;
 }
 
-static int arcturus_i2c_eeprom_control_init(struct smu_context *smu, struct i2c_adapter *control)
+static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
@@ -2160,8 +2160,8 @@ static int arcturus_i2c_eeprom_control_init(struct smu_context *smu, struct i2c_
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
-	control->algo = &arcturus_i2c_eeprom_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
+	control->algo = &arcturus_i2c_algo;
+	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
 
 	res = i2c_add_adapter(control);
 	if (res)
@@ -2170,7 +2170,7 @@ static int arcturus_i2c_eeprom_control_init(struct smu_context *smu, struct i2c_
 	return res;
 }
 
-static void arcturus_i2c_eeprom_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+static void arcturus_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
 {
 	if (!arcturus_i2c_adapter_is_added(control))
 		return;
@@ -2346,8 +2346,8 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_power_limit = arcturus_get_power_limit,
 	.is_dpm_running = arcturus_is_dpm_running,
 	.dpm_set_vcn_enable = arcturus_dpm_set_vcn_enable,
-	.i2c_eeprom_init = arcturus_i2c_eeprom_control_init,
-	.i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
+	.i2c_eeprom_init = arcturus_i2c_control_init,
+	.i2c_eeprom_fini = arcturus_i2c_control_fini,
 	.get_unique_id = arcturus_get_unique_id,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

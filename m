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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CAFC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87054206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thE+Wius"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87054206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3674A6E456;
	Tue, 21 Jul 2020 18:09:18 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED426E426
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:09:16 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id 11so10809777qkn.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d8+tE3M8y8ZD9PCxB1FAflXKOsCV/iHdVfu46La29qk=;
 b=thE+WiusuXhrtz+o7NcZVw/eFaXauXNFJ26SqKQQmqhb+5cN+1tUPx+rXQ+shZdvbQ
 hMmJwkrWU2Sbu+ig2TYd9lUGeVyeObPxh4B4HfHvff/ImHpx0upodbAwJ6h72fqQ1syh
 lP5T4U6yv5/uerDNK3J1JfKHV59CytdLmTeyRmLHY0KWxSRm2tLW6JQAoVwsX49oND7/
 eg4/8WkoOOjFqNRn9/FVy1FJ7uw2Qw1eo1JVoa3PFjSWzPIUbdHjwmub1mtUWBHpXcwQ
 giKNnEsc99WOmft8xWqZbYl1pRFdwcW9dANsdq7rfrpQZdNgUEo0tSuQqCOz37KL4q9r
 20iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d8+tE3M8y8ZD9PCxB1FAflXKOsCV/iHdVfu46La29qk=;
 b=d0GUBPlIFAG5vp1egiI54q/9lWXHwrbVloZok0uJN7pEYPradyZQvDr7IcxOyr9aTy
 ugurl/M8PuJ0B5yAc4S3zis2oVe/niOHLOlfYcnuMY5oA4XqMsD6NwiTyzfuqxXAmQKw
 QkfmqiaNM/pllfTSbnCNQprWtduol0XWjKOewPPyylBqNZ0BKba67QbmJy/v+8GBPtAI
 el2DqB4nO6DBi1EJ0K8Ke1fzem0CUg2Y0C08veyyuA82V/t3UA944ApcCC1og8k2y1s/
 Hw4N7MexyVsPoTBKa3sPY07rhXXPKpBdIJsVBRgeY0cxMYqnhMoFk7oNIOMm96OW2zoc
 /27Q==
X-Gm-Message-State: AOAM532lvBUbkamA/c4TEX8jXMtR0/edM2fazwnMrTQ0HfCW2n3TrmfA
 C7N3OAerQgSgmgzFQZb4ox7FQAt6
X-Google-Smtp-Source: ABdhPJzkfM7AzwSnhswQNUZguFlQNjEkE0DENli1exTsWg+lDdAj/aXKQyL44f/lqmVsTukyOU022A==
X-Received: by 2002:a37:b341:: with SMTP id c62mr27341898qkf.128.1595354952728; 
 Tue, 21 Jul 2020 11:09:12 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t65sm2957284qkf.119.2020.07.21.11.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:09:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu/swSMU: remove eeprom from the smu i2c handlers
 (v2)
Date: Tue, 21 Jul 2020 14:08:48 -0400
Message-Id: <20200721180850.813406-4-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver uses it for EEPROM access, but it's just an i2c bus.

v2: change the callback name as well.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  4 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 60 +++++++++----------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 +-
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  4 +-
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 03125c8a2145..2940e94e9962 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1135,7 +1135,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	ret = smu_i2c_init(smu, &adev->pm.smu_i2c);
 	if (ret)
 		return ret;
 
@@ -1341,7 +1341,7 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+	smu_i2c_fini(smu, &adev->pm.smu_i2c);
 
 	cancel_work_sync(&smu->throttling_logging_work);
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 56dc20a617fd..5333827b7dd3 100644
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
+	.i2c_init = arcturus_i2c_control_init,
+	.i2c_fini = arcturus_i2c_control_fini,
 	.get_unique_id = arcturus_get_unique_id,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 70181ba7ee0c..ff8c7222c7c9 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -494,8 +494,8 @@ struct pptable_funcs {
 	int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
 	int (*allow_xgmi_power_down)(struct smu_context *smu, bool en);
 	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
-	int (*i2c_eeprom_init)(struct smu_context *smu, struct i2c_adapter *control);
-	void (*i2c_eeprom_fini)(struct smu_context *smu, struct i2c_adapter *control);
+	int (*i2c_init)(struct smu_context *smu, struct i2c_adapter *control);
+	void (*i2c_fini)(struct smu_context *smu, struct i2c_adapter *control);
 	void (*get_unique_id)(struct smu_context *smu);
 	int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
 	int (*init_microcode)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index afb3ef874fc5..1961cce5ef28 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -91,8 +91,8 @@
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
 #define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_funcs(disable_umc_cdr_12gbps_workaround, 0, smu)
 #define smu_set_power_source(smu, power_src)				smu_ppt_funcs(set_power_source, 0, smu, power_src)
-#define smu_i2c_eeprom_init(smu, control)				smu_ppt_funcs(i2c_eeprom_init, 0, smu, control)
-#define smu_i2c_eeprom_fini(smu, control)				smu_ppt_funcs(i2c_eeprom_fini, 0, smu, control)
+#define smu_i2c_init(smu, control)					smu_ppt_funcs(i2c_init, 0, smu, control)
+#define smu_i2c_fini(smu, control)					smu_ppt_funcs(i2c_fini, 0, smu, control)
 #define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
 #define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

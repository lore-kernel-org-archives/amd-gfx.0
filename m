Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17577C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE085206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 18:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnFYrDtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE085206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804286E422;
	Tue, 21 Jul 2020 18:09:18 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B086E455
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 18:09:18 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id t7so9747751qvl.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CJSFM9uO10BNf771GSZoBqgL6CN/rqjYaX8coLlpON0=;
 b=bnFYrDtQaRl79evlz3ouOx+6DC7zz/adRATZxypPTmCpXIM9bpBrDFsaoKVnIS/1jx
 rOlEJUcdJR1htRNQcc/B0wIJk/WsA0gqw5SzMt1UvowJtW/qpB5o/6IJDXm26fFKnLFs
 QknW8C5ZXabNGVRBwA7VCrjoMN8fWdANHJUIcvXHY9AiN7sEpmsC5ohpksx4f54b0WPF
 lBj1/aQ0q5UwaQx9InPv7WEnwOAu5Ypp1Y8TfTFHv7QW6KPzouSw+Zw9p/Q70uwbE6He
 jF+UgYvjaw18qamBmlpZySqsHG2FRipU+0jKJ/hkuh6WOoHUduzDu8omEyW9qGqhSTGA
 NPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CJSFM9uO10BNf771GSZoBqgL6CN/rqjYaX8coLlpON0=;
 b=nUnpslZBTVakrJmF5UwuHJm8CVF8Rbtau3wwXG7S8YuAizX+Kg9FND/MFGpeKspitE
 b2jfK/Ij48JtJEN60IQXymvkmX1yK+b6MGEwKz9xKOYGqMfMyNWTtT4YEKtSc1dL2AbY
 N74nDDsUV1zPied+nkv274Rh5PMMQdAbfBMXPC/V4wMJ6ncKvHjAPcCFrVTPWTirW/gR
 T2HgUIc6MR+LxXNpyOdHxxMzInBTLd8PJ0SRBYAxF2PL79WEuWAt7dl7pExoDVe3znwS
 rCEAIlYkf50q3TrScWIovL6YLh4sSqAosskoP/P4Xbuj9jNvdj93gQtpFIK9cnRfrFHz
 kICA==
X-Gm-Message-State: AOAM530DpIx6a3kOQZxu3cFYn4vGItXhifrZwtVXKo2VfjlvSjt239LE
 2NTHrNICkF8rpZZDZzCVMenoLM6P
X-Google-Smtp-Source: ABdhPJxlb2MxoZIZvh38Pn6rv/CB0XNLRax6Zk6okT5+8jNL8W5vgwej5ZV/bhNTGrAwMHRlM61CYA==
X-Received: by 2002:a0c:ec04:: with SMTP id y4mr27357046qvo.148.1595354956967; 
 Tue, 21 Jul 2020 11:09:16 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t65sm2957284qkf.119.2020.07.21.11.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:09:16 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support (v2)
Date: Tue, 21 Jul 2020 14:08:50 -0400
Message-Id: <20200721180850.813406-6-alexander.deucher@amd.com>
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

Enable SMU i2c bus access for sienna_cichlid asics.

v2: change callback name

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 239 ++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5faef41b63a3..2438751359e7 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/i2c.h>
 #include "amdgpu.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
@@ -52,6 +53,8 @@
 #undef pr_info
 #undef pr_debug
 
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
@@ -455,6 +458,8 @@ static int sienna_cichlid_tables_init(struct smu_context *smu, struct smu_table
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_OVERDRIVE, sizeof(OverDriveTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU11_TOOL_SIZE,
@@ -2487,6 +2492,238 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "MmHubPadding[7] = 0x%x\n", pptable->MmHubPadding[7]);
 }
 
+static void sienna_cichlid_fill_i2c_req(SwI2cRequest_t  *req, bool write,
+				  uint8_t address, uint32_t numbytes,
+				  uint8_t *data)
+{
+	int i;
+
+	BUG_ON(numbytes > MAX_SW_I2C_COMMANDS);
+
+	req->I2CcontrollerPort = 0;
+	req->I2CSpeed = 2;
+	req->SlaveAddress = address;
+	req->NumCmds = numbytes;
+
+	for (i = 0; i < numbytes; i++) {
+		SwI2cCmd_t *cmd =  &req->SwI2cCmds[i];
+
+		/* First 2 bytes are always write for lower 2b EEPROM address */
+		if (i < 2)
+			cmd->CmdConfig = CMDCONFIG_READWRITE_MASK;
+		else
+			cmd->CmdConfig = write ? CMDCONFIG_READWRITE_MASK : 0;
+
+
+		/* Add RESTART for read  after address filled */
+		cmd->CmdConfig |= (i == 2 && !write) ? CMDCONFIG_RESTART_MASK : 0;
+
+		/* Add STOP in the end */
+		cmd->CmdConfig |= (i == (numbytes - 1)) ? CMDCONFIG_STOP_MASK : 0;
+
+		/* Fill with data regardless if read or write to simplify code */
+		cmd->ReadWriteData = data[i];
+	}
+}
+
+static int sienna_cichlid_i2c_read_data(struct i2c_adapter *control,
+					       uint8_t address,
+					       uint8_t *data,
+					       uint32_t numbytes)
+{
+	uint32_t  i, ret = 0;
+	SwI2cRequest_t req;
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct smu_table_context *smu_table = &adev->smu.smu_table;
+	struct smu_table *table = &smu_table->driver_table;
+
+	memset(&req, 0, sizeof(req));
+	sienna_cichlid_fill_i2c_req(&req, false, address, numbytes, data);
+
+	mutex_lock(&adev->smu.mutex);
+	/* Now read data starting with that address */
+	ret = smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req,
+					true);
+	mutex_unlock(&adev->smu.mutex);
+
+	if (!ret) {
+		SwI2cRequest_t *res = (SwI2cRequest_t *)table->cpu_addr;
+
+		/* Assume SMU  fills res.SwI2cCmds[i].Data with read bytes */
+		for (i = 0; i < numbytes; i++)
+			data[i] = res->SwI2cCmds[i].ReadWriteData;
+
+		dev_dbg(adev->dev, "sienna_cichlid_i2c_read_data, address = %x, bytes = %d, data :",
+				  (uint16_t)address, numbytes);
+
+		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
+			       8, 1, data, numbytes, false);
+	} else
+		dev_err(adev->dev, "sienna_cichlid_i2c_read_data - error occurred :%x", ret);
+
+	return ret;
+}
+
+static int sienna_cichlid_i2c_write_data(struct i2c_adapter *control,
+						uint8_t address,
+						uint8_t *data,
+						uint32_t numbytes)
+{
+	uint32_t ret;
+	SwI2cRequest_t req;
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+
+	memset(&req, 0, sizeof(req));
+	sienna_cichlid_fill_i2c_req(&req, true, address, numbytes, data);
+
+	mutex_lock(&adev->smu.mutex);
+	ret = smu_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	mutex_unlock(&adev->smu.mutex);
+
+	if (!ret) {
+		dev_dbg(adev->dev, "sienna_cichlid_i2c_write(), address = %x, bytes = %d , data: ",
+					 (uint16_t)address, numbytes);
+
+		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE,
+			       8, 1, data, numbytes, false);
+		/*
+		 * According to EEPROM spec there is a MAX of 10 ms required for
+		 * EEPROM to flush internal RX buffer after STOP was issued at the
+		 * end of write transaction. During this time the EEPROM will not be
+		 * responsive to any more commands - so wait a bit more.
+		 */
+		msleep(10);
+
+	} else
+		dev_err(adev->dev, "sienna_cichlid_i2c_write- error occurred :%x", ret);
+
+	return ret;
+}
+
+static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
+			      struct i2c_msg *msgs, int num)
+{
+	uint32_t  i, j, ret, data_size, data_chunk_size, next_eeprom_addr = 0;
+	uint8_t *data_ptr, data_chunk[MAX_SW_I2C_COMMANDS] = { 0 };
+
+	for (i = 0; i < num; i++) {
+		/*
+		 * SMU interface allows at most MAX_SW_I2C_COMMANDS bytes of data at
+		 * once and hence the data needs to be spliced into chunks and sent each
+		 * chunk separately
+		 */
+		data_size = msgs[i].len - 2;
+		data_chunk_size = MAX_SW_I2C_COMMANDS - 2;
+		next_eeprom_addr = (msgs[i].buf[0] << 8 & 0xff00) | (msgs[i].buf[1] & 0xff);
+		data_ptr = msgs[i].buf + 2;
+
+		for (j = 0; j < data_size / data_chunk_size; j++) {
+			/* Insert the EEPROM dest addess, bits 0-15 */
+			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
+			data_chunk[1] = (next_eeprom_addr & 0xff);
+
+			if (msgs[i].flags & I2C_M_RD) {
+				ret = sienna_cichlid_i2c_read_data(i2c_adap,
+							     (uint8_t)msgs[i].addr,
+							     data_chunk, MAX_SW_I2C_COMMANDS);
+
+				memcpy(data_ptr, data_chunk + 2, data_chunk_size);
+			} else {
+
+				memcpy(data_chunk + 2, data_ptr, data_chunk_size);
+
+				ret = sienna_cichlid_i2c_write_data(i2c_adap,
+							      (uint8_t)msgs[i].addr,
+							      data_chunk, MAX_SW_I2C_COMMANDS);
+			}
+
+			if (ret) {
+				num = -EIO;
+				goto fail;
+			}
+
+			next_eeprom_addr += data_chunk_size;
+			data_ptr += data_chunk_size;
+		}
+
+		if (data_size % data_chunk_size) {
+			data_chunk[0] = ((next_eeprom_addr >> 8) & 0xff);
+			data_chunk[1] = (next_eeprom_addr & 0xff);
+
+			if (msgs[i].flags & I2C_M_RD) {
+				ret = sienna_cichlid_i2c_read_data(i2c_adap,
+							     (uint8_t)msgs[i].addr,
+							     data_chunk, (data_size % data_chunk_size) + 2);
+
+				memcpy(data_ptr, data_chunk + 2, data_size % data_chunk_size);
+			} else {
+				memcpy(data_chunk + 2, data_ptr, data_size % data_chunk_size);
+
+				ret = sienna_cichlid_i2c_write_data(i2c_adap,
+							      (uint8_t)msgs[i].addr,
+							      data_chunk, (data_size % data_chunk_size) + 2);
+			}
+
+			if (ret) {
+				num = -EIO;
+				goto fail;
+			}
+		}
+	}
+
+fail:
+	return num;
+}
+
+static u32 sienna_cichlid_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+
+static const struct i2c_algorithm sienna_cichlid_i2c_algo = {
+	.master_xfer = sienna_cichlid_i2c_xfer,
+	.functionality = sienna_cichlid_i2c_func,
+};
+
+static bool sienna_cichlid_i2c_adapter_is_added(struct i2c_adapter *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+
+	return control->dev.parent == &adev->pdev->dev;
+}
+
+static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	int res;
+
+	/* smu_i2c_eeprom_init may be called twice in sriov */
+	if (sienna_cichlid_i2c_adapter_is_added(control))
+		return 0;
+
+	control->owner = THIS_MODULE;
+	control->class = I2C_CLASS_SPD;
+	control->dev.parent = &adev->pdev->dev;
+	control->algo = &sienna_cichlid_i2c_algo;
+	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+
+	res = i2c_add_adapter(control);
+	if (res)
+		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+
+	return res;
+}
+
+static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+{
+	if (!sienna_cichlid_i2c_adapter_is_added(control))
+		return;
+
+	i2c_del_adapter(control);
+}
+
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.tables_init = sienna_cichlid_tables_init,
 	.alloc_dpm_context = sienna_cichlid_allocate_dpm_context,
@@ -2500,6 +2737,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
 	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
+	.i2c_init = sienna_cichlid_i2c_control_init,
+	.i2c_fini = sienna_cichlid_i2c_control_fini,
 	.print_clk_levels = sienna_cichlid_print_clk_levels,
 	.force_clk_levels = sienna_cichlid_force_clk_levels,
 	.populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

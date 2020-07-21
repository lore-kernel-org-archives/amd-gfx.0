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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6124C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC702073A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ2tT/Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC702073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1546E2C7;
	Tue, 21 Jul 2020 16:52:57 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970436E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 16:52:55 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id o2so7109421qvk.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i2xLlBQPxbDFw76O+IM73xdXDqu/HgvySLNgsoeRAIc=;
 b=fZ2tT/ZvWY8jFc7CRgP58IWqaE4+5zAG4Zxjneea6dyDuVz/4qo8O4nkzR374SLYDD
 fuu3OPfS5Bj9mIk4C5WO4lx6jFxwx7e84iXCK9ud5/1nAnfdZ07VCobQn98R4AQvSF0+
 gzoVgRKqGh5OJD4lrLKmE5sBexSSiZ3wArTpzJR6jhiKQ01SAx0Vv/0hr+CeBdN1mHTg
 UdNcZ8rpUajfTaFUn+HzDOKE60ZQ01aN7fOldZ8hzUUivRmCk0CJOTag/bj+k+U2HdiM
 QZ1QZViZmEeX5E8WBOLaXEQBBWNptQBsXhKk+/PxKp00lq83bdUW6ZNgmRuJqqy/xWuG
 QZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i2xLlBQPxbDFw76O+IM73xdXDqu/HgvySLNgsoeRAIc=;
 b=V4qR2IYHJhPS/ryee/bX1n0vuFa+WbJlAY++c7oEQTji9pOzjpO+u9B4Hj9sfLua51
 /+ZwHZTfl+Vc4E3XwPYC1k+dX3/5IJekYq+UszhyNMo546Qn1Mv94KvJz00YLt+7W+Nq
 ak920fTBBrTNKNn7aSKn640vH+EuGfn7BR7LpRqp1jRgi4eVahRu+nF5PbH+LizMpTvv
 Zc/ZHlRqMGoIfdfK33kPbZc0O8c+3/auWmGhUMQpDqCMk4dHInDgmWy7EXe+2H5R3Wjy
 Ho1PvcJVJ//V6/srxDowge93Mf5aEUoybYdUqJIhnPJABG0Y4vTg84wBEBXEtP4+gebs
 Kziw==
X-Gm-Message-State: AOAM532JMGfyAJzdkRPEJlkPbmgNQiWUNRggnAL06KnhahcGBDRZx/QP
 j6Nij/atplkWTnkyDpcjw0sHglon
X-Google-Smtp-Source: ABdhPJzxfCw2F8Paiw/QhudsqUM64WwqNQBGhoRBebarlc4ut9tXiPBF/PaunKyZw0FXUKpyjkO00Q==
X-Received: by 2002:a0c:aa15:: with SMTP id d21mr25949829qvb.155.1595350374418; 
 Tue, 21 Jul 2020 09:52:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d16sm2709212qkk.106.2020.07.21.09.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 09:52:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu/sienna_cichlid: add SMU i2c support
Date: Tue, 21 Jul 2020 12:52:40 -0400
Message-Id: <20200721165240.296265-6-alexander.deucher@amd.com>
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

Enable SMU i2c bus access for sienna_cichlid asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 239 ++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5faef41b63a3..e1857fbb0a6f 100644
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
+	.i2c_eeprom_init = sienna_cichlid_i2c_control_init,
+	.i2c_eeprom_fini = sienna_cichlid_i2c_control_fini,
 	.print_clk_levels = sienna_cichlid_print_clk_levels,
 	.force_clk_levels = sienna_cichlid_force_clk_levels,
 	.populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

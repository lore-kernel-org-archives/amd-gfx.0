Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799CC47423
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606972399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9K/vqVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606972399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1020C6ED77;
	Fri, 25 Sep 2020 20:11:41 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CEBF6ED7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:39 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id t138so4145633qka.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qCxeiS4T9FmpIhTiODMS2TeG2LWlxVjiu8JDIPKYrwk=;
 b=p9K/vqVdGTgj3LZPOy6hCo7j1ybKc6PUZn0+kaETya3l+Pu6kjBkT9rU0V/LEa0Fag
 9biWW9UnE2JxaK3Kz6nDBsU8gipnq7AndY3zoxDsyjoELXJ/0kIzX2DYqhOSlhEYxzMb
 ebw54lTUerAaIg2pxAWC3Xdp87H0YIp0qoAF6aff8Nf38FtzJKW9+O1kGYM1o/4Ma8K4
 H5wHJxJBHF89m17Qjf8pb7bIXiwmohvee8fSOzRa4T5xMUYwVEDu/xFqWZVAbm6gGI5n
 iwqVgewPZCaBfzT6z+jkQWY4O4d/jImew1LGOUtRUARHreGseO21F2xcWWX7arCtLdMJ
 h/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qCxeiS4T9FmpIhTiODMS2TeG2LWlxVjiu8JDIPKYrwk=;
 b=EpT6FrVgBKSwSI6tE41kzK1tz6l6y2kGwIEOWdN0i7kni8AVjKwFYauhrxnEOQeliu
 +CFiyNJ8I8oEwNIef0Int1ubzNnSSIU1XeCzywSmpPHMYS4BRjot12SITfOVAB9xs03V
 K+cMn3mubtgpVXVhl8QHnMggihgdOuLVSvdWT6dkanNaKJYDOtb9qstqnaGChzS4NNis
 OI+8IYSEApfW92Un2yJfeSdDNKrM3w+LfLgPhlQ8MXxN0XyYlr/goOM+2a/U9H/TiJaS
 8VcQWgU/buPAKFlwaFMxI0fCFjUiA8rEJ2FciGn/YLzmxxeAau9WqAUK/e442rAhJ8tA
 xOZw==
X-Gm-Message-State: AOAM5304yGvwa8sSgPDnBCdicajc62Jl/LeJJpV01/tR76MmbzW7rfcf
 PIF+lp+JsKF+1FGcmUmdfgDWdEKJlbU=
X-Google-Smtp-Source: ABdhPJzhimRoU4dEktFFO75HSPJnE3Q7QHK3iwWO9wjT6Sk/IZrK43+PalUGUQ+rFmuh3OsT4M6k6g==
X-Received: by 2002:a37:9f95:: with SMTP id i143mr1571614qke.121.1601064698288; 
 Fri, 25 Sep 2020 13:11:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/45] drm/amdgpu/powerplay: add smu initialize funcitons for
 vangogh (v2)
Date: Fri, 25 Sep 2020 16:10:15 -0400
Message-Id: <20200925201029.1738724-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Huang Rui <ray.huang@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

This patch is to add smu initialize functions for vangogh.

v2: squash in updates

Signed-off-by: Xiaojian Du <xiaojian.du@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 355 ++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h  |  30 ++
 2 files changed, 385 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
new file mode 100644
index 000000000000..a06495126a8c
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -0,0 +1,355 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#define SWSMU_CODE_LAYER_L2
+
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v11_0.h"
+#include "smu11_driver_if_vangogh.h"
+#include "vangogh_ppt.h"
+#include "smu_v11_5_ppsmc.h"
+#include "smu_v11_5_pmfw.h"
+#include "smu_cmn.h"
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+#define SMC_DPM_FEATURE ( \
+	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
+	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
+	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_GFX_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_ISP_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_A55_DPM_BIT)| \
+	FEATURE_MASK(FEATURE_CVIP_DSP_DPM_BIT))
+
+static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
+	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
+	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
+	MSG_MAP(GetDriverIfVersion,             PPSMC_MSG_GetDriverIfVersion,		1),
+	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_EnableGfxOff,			1),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisableGfxOff,		1),
+	MSG_MAP(PowerDownIspByTile,             PPSMC_MSG_PowerDownIspByTile,		1),
+	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		1),
+	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
+	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
+	MSG_MAP(Spare,                          PPSMC_MSG_spare,			1),
+	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
+	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,	1),
+	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		1),
+	MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,	1),
+	MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,	1),
+	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
+	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
+	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	1),
+	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		1),
+	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	1),
+	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,			1),
+	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	1),
+	MSG_MAP(SetMinVideoFclkFreq,            PPSMC_MSG_SetMinVideoFclkFreq,		1),
+	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,		1),
+	MSG_MAP(EnablePostCode,                 PPSMC_MSG_EnablePostCode,		1),
+	MSG_MAP(GetGfxclkFrequency,             PPSMC_MSG_GetGfxclkFrequency,		1),
+	MSG_MAP(GetFclkFrequency,               PPSMC_MSG_GetFclkFrequency,		1),
+	MSG_MAP(AllowGfxOff,                    PPSMC_MSG_AllowGfxOff,			1),
+	MSG_MAP(DisallowGfxOff,                 PPSMC_MSG_DisallowGfxOff,		1),
+	MSG_MAP(SetSoftMaxGfxClk,               PPSMC_MSG_SetSoftMaxGfxClk,		1),
+	MSG_MAP(SetHardMinGfxClk,               PPSMC_MSG_SetHardMinGfxClk,		1),
+	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	1),
+	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		1),
+	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,		1),
+	MSG_MAP(GpuChangeState,                 PPSMC_MSG_GpuChangeState,		1),
+	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,	1),
+	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,		1),
+	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,			1),
+	MSG_MAP(SetHardMinFclkByFreq,           PPSMC_MSG_SetHardMinFclkByFreq,		1),
+	MSG_MAP(SetSoftMinSocclkByFreq,         PPSMC_MSG_SetSoftMinSocclkByFreq,	1),
+	MSG_MAP(PowerUpCvip,                    PPSMC_MSG_PowerUpCvip,			1),
+	MSG_MAP(PowerDownCvip,                  PPSMC_MSG_PowerDownCvip,		1),
+};
+
+static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
+	FEA_MAP(PPT),
+	FEA_MAP(TDC),
+	FEA_MAP(THERMAL),
+	FEA_MAP(DS_GFXCLK),
+	FEA_MAP(DS_SOCCLK),
+	FEA_MAP(DS_LCLK),
+	FEA_MAP(DS_FCLK),
+	FEA_MAP(DS_MP1CLK),
+	FEA_MAP(DS_MP0CLK),
+	FEA_MAP(ATHUB_PG),
+	FEA_MAP(CCLK_DPM),
+	FEA_MAP(FAN_CONTROLLER),
+	FEA_MAP(ULV),
+	FEA_MAP(VCN_DPM),
+	FEA_MAP(FCLK_DPM),
+	FEA_MAP(SOCCLK_DPM),
+	FEA_MAP(MP0CLK_DPM),
+	FEA_MAP(LCLK_DPM),
+	FEA_MAP(SHUBCLK_DPM),
+	FEA_MAP(DCFCLK_DPM),
+	FEA_MAP(GFX_DPM),
+	FEA_MAP(DS_DCFCLK),
+	FEA_MAP(S0I2),
+	FEA_MAP(SMU_LOW_POWER),
+	FEA_MAP(GFX_DEM),
+	FEA_MAP(PSI),
+	FEA_MAP(PROCHOT),
+	FEA_MAP(CPUOFF),
+	FEA_MAP(STAPM),
+	FEA_MAP(S0I3),
+	FEA_MAP(DF_CSTATES),
+	FEA_MAP(PERF_LIMIT),
+	FEA_MAP(CORE_DLDO),
+	FEA_MAP(RSMU_LOW_POWER),
+	FEA_MAP(SMN_LOW_POWER),
+	FEA_MAP(THM_LOW_POWER),
+	FEA_MAP(SMUIO_LOW_POWER),
+	FEA_MAP(MP1_LOW_POWER),
+	FEA_MAP(DS_VCN),
+	FEA_MAP(CPPC),
+	FEA_MAP(OS_CSTATES),
+	FEA_MAP(ISP_DPM),
+	FEA_MAP(A55_DPM),
+	FEA_MAP(CVIP_DSP_DPM),
+	FEA_MAP(MSMU_LOW_POWER),
+};
+
+static struct cmn2asic_mapping vangogh_table_map[SMU_TABLE_COUNT] = {
+	TAB_MAP_VALID(WATERMARKS),
+	TAB_MAP_VALID(SMU_METRICS),
+	TAB_MAP_VALID(CUSTOM_DPM),
+	TAB_MAP_VALID(DPMCLOCKS),
+};
+
+static int vangogh_tables_init(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU11_TOOL_SIZE,
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF, sizeof(DpmActivityMonitorCoeffExt_t),
+		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	if (!smu_table->metrics_table)
+		goto err0_out;
+	smu_table->metrics_time = 0;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err1_out;
+
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		goto err2_out;
+
+	return 0;
+
+err2_out:
+	kfree(smu_table->gpu_metrics_table);
+err1_out:
+	kfree(smu_table->metrics_table);
+err0_out:
+	return -ENOMEM;
+}
+
+static int vangogh_allocate_dpm_context(struct smu_context *smu)
+{
+	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+	smu_dpm->dpm_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
+				       GFP_KERNEL);
+	if (!smu_dpm->dpm_context)
+		return -ENOMEM;
+
+	smu_dpm->dpm_context_size = sizeof(struct smu_11_0_dpm_context);
+
+	return 0;
+}
+
+static int vangogh_init_smc_tables(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = vangogh_tables_init(smu);
+	if (ret)
+		return ret;
+
+	ret = vangogh_allocate_dpm_context(smu);
+	if (ret)
+		return ret;
+
+	return smu_v11_0_init_smc_tables(smu);
+}
+
+static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	if (enable) {
+		/* vcn dpm on is a prerequisite for vcn power gate messages */
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+			if (ret)
+				return ret;
+		}
+	} else {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int vangogh_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	if (enable) {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+			if (ret)
+				return ret;
+		}
+	} else {
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int vangogh_set_default_dpm_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table->clocks_table, false);
+}
+
+static int vangogh_get_allowed_feature_mask(struct smu_context *smu,
+					    uint32_t *feature_mask,
+					    uint32_t num)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (num > 2)
+		return -EINVAL;
+
+	memset(feature_mask, 0, sizeof(uint32_t) * num);
+
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DPM_BIT)
+				| FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)
+				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
+				| FEATURE_MASK(FEATURE_PPT_BIT)
+				| FEATURE_MASK(FEATURE_TDC_BIT)
+				| FEATURE_MASK(FEATURE_FAN_CONTROLLER_BIT)
+				| FEATURE_MASK(FEATURE_DS_LCLK_BIT)
+				| FEATURE_MASK(FEATURE_DS_DCFCLK_BIT);
+
+	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT);
+
+	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT);
+
+	if (smu->adev->pg_flags & AMD_PG_SUPPORT_ATHUB)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_PG_BIT);
+
+	return 0;
+}
+
+static bool vangogh_is_dpm_running(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	/*
+	 * Until now, the pmfw hasn't exported the interface of SMU
+	 * feature mask to APU SKU so just force on all the feature
+	 * at early initial stage.
+	 */
+	if (adev->in_suspend)
+		return false;
+	else
+		return true;
+
+}
+
+static const struct pptable_funcs vangogh_ppt_funcs = {
+	.dpm_set_vcn_enable = vangogh_dpm_set_vcn_enable,
+	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
+	.check_fw_status = smu_v11_0_check_fw_status,
+	.check_fw_version = smu_v11_0_check_fw_version,
+	.init_smc_tables = vangogh_init_smc_tables,
+	.fini_smc_tables = smu_v11_0_fini_smc_tables,
+	.init_power = smu_v11_0_init_power,
+	.fini_power = smu_v11_0_fini_power,
+	.register_irq_handler = smu_v11_0_register_irq_handler,
+	.get_allowed_feature_mask = vangogh_get_allowed_feature_mask,
+	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
+	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
+	.send_smc_msg = smu_cmn_send_smc_msg,
+	.set_default_dpm_table = vangogh_set_default_dpm_table,
+	.is_dpm_running = vangogh_is_dpm_running,
+	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
+	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
+};
+
+void vangogh_set_ppt_funcs(struct smu_context *smu)
+{
+	smu->ppt_funcs = &vangogh_ppt_funcs;
+	smu->message_map = vangogh_message_map;
+	smu->feature_map = vangogh_feature_mask_map;
+	smu->table_map = vangogh_table_map;
+	smu->is_apu = true;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
new file mode 100644
index 000000000000..29929b360db8
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __VANGOGH_PPT_H__
+#define __VANGOGH_PPT_H__
+
+
+extern void vangogh_set_ppt_funcs(struct smu_context *smu);
+
+#endif
\ No newline at end of file
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9627C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A407410F72E;
	Thu, 24 Sep 2026 18:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0GFaUQY3";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CAA10F733
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV++AQIDF5ssu9LDrbu0Hoea3997KoSul/Vd25Yi6agmo6AlnWXw4t5GRRPE+u2BE2y+vfBMLS9ZkDqoMA/QPizoJwW3yBBj4BV3mcfAepe+/t6KeWXpINd7NW7xHnFGIG9X7AtvB0L5fTw+Tteg9Ki+TNuFp5Fa7JEttb6Nv+/PEiE7SVZTZHBmGIuE20SO7z5Tx63fb90hBZOgVlCQdlXf0P6KbEbILKzpGGU49f38zLO6jWA9n9uc1cMURYc++YdhnpWPnbDI5WLDsbNRvYrQdHzqv8tdPnHQP1AUYWzPfzUDKZ5lnJrnDgNkeRp3IZVMHT9RFEY4Iu59P5KS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5lMGkG5igZeHCQ04J7V7lTYNO8Ox+wwi/l9pDO+eiQ=;
 b=xg+Ka65CvOnxHPNGNYgKdVj0SxMZ9fo78B3Ygk6gqBCXteCCHMzuaUgLpjgYmtFtdpFjmRDtmAxmx7cYgnW+5oibCtReqkK5kUpUp0udSwcJrNJSOSfUNlXVDGtuL2aMgUR8BqjItffgdm5pzfgX1EvEoM8wEkLJ9EEA7v53aMSdFaZnJ7tn6joK2CCTSLBP5DwVdNT/1UVQdHwF9fsXNSixozrsZ9vgGi1h/PBCgoWhFlLeeumg0MxurgjhOCXspyoxa/f6Z8Hpt1iVIB9uusX5yzCnsya+rtohL2KXU7m+wlPc3u3U98iHW6iMUy3BgTzDfxILI/YbgQnHefd9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5lMGkG5igZeHCQ04J7V7lTYNO8Ox+wwi/l9pDO+eiQ=;
 b=0GFaUQY3FJZJyye1pQjo3TvUrOs/154W0UL1A1TcqdyE4pfx6AoV+Lep1viIWfhgWM1OR7WEID8GfAN7/7JFAHwGkn5X0ZYjfuofz14cwth+rNbldc/FlXfwVFKFovD6VO5qFAIsSvOhJFCl9+omqPEBe7pDfUAhmnC26lNh8C0=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:21 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::88) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:19 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:08 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 10/34] drm/amd/display: Disable gamcor light sleep before
 gamcor program
Date: Thu, 24 Sep 2026 14:45:23 -0400
Message-ID: <20260924184824.596894-11-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7c601c-e646-415b-4683-08df1a6c1f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xFayCtwB/iPEQf0vUnBI7+ZswWrCniTKMk79ObEfFH3jyDPNcExKpdx+zcIahlvmOOL9vW26MG5xNnKwaW5zJgAYZJenCHU3X19R1oufeJtzQfef2ajft/6/7VQa7vhA9iSg/hXsHjC8QhQ8BAMxb9R9Vw7r2qYGvy7ZCuGwbDYqxhtC9GXWDKlxzkhoKtAgkiBsw17aCzgQWlfQk4OSBEsnquv71EFay1Pf/Hv/klKBAUsZsFHxvgDo4/FBpCjhxF6S1mCTUr8uoc9txQwbf29SSVr3cZhQghfpgjTXvKFQIVWB2RbLOt6ETiRWYQQlixLgc3nz4+lJpHNQ8ry2tc2QjbWWqtByeXTa8XXXA9cYKt+PK7PZsbDUTRuYPsAG0cwNHZI7m/bSdXS6WcDL9gtNVVIvttbL+CZ1pMH1NByFLypF+++LMKfcTvUy1cJIrwVuTDQ1jdZMnHk92CUeRa9kGOJO2o+cvESnM5vUYQJA9puQyhV7n77jRaw/4n3iqw9Yo9dM4czBE90CVbHrHD9zdR7H1sCdDxjweD9XKKkqyfKYa7qr/Wc0aWPF6mTRr1VCiaW0rcVSUIdMy1KannJ9dFumYEOx8tfSw+fn9GZm6Gkz49a0yWidQ3PlBkeae5Ixu/djuMiKyEpuus/ouUXwWFkaPpYVbcJpZq+uk4vadfDuxDY01hXu3o3b0m3/XtGx7SCeRu1QM/KCwAclcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DADOb3jc1Pu/Q00Zgw7TXUOgq4sF2lwmKcRfIu64HNu95ntedjJWrAVAZLJhIKtWfBkq4SxpEQpbeo5V20s9bn7O+E9iPw78wlUi70mML9Ifh10gK9u2tnNn7PVLKBtK1JlMmJFx5etPcuYuaTiPnNCVY+puwQpcuKtMFz4/Bnb3wFxGbgDRaFEGb6ZTly6Dz6rNbYxaZTj90C2HCBv5Zl8c8N8Lq78TSZZdzsRKwmU23C/jLSGE8AMPDcfw9V70uoidgbqL6D6ACRbcL6i/BBtlVBGN7el1Hu8G8Bbs+cOEx+JAvN/p+/HYAa/2RSKhVNm3k4nFNd3pD/9zPoSm8Stg7mrgqG2xA8MPFcYHhucRcOpirct+v2lBPdCTfupqIPhBkEpF0R/VassE6iw1BgFYEatgdXlu/mK0/1oaijw3JFNQ54BOG/b1sSmp00T+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:19.7033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7c601c-e646-415b-4683-08df1a6c1f91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Gamcor light sleep must be disabled before gamcor programming
- Mirror the programming sequence for DSCL light sleep
- Create a dcn60 version for gamcor programming
- Make dcn30 helper functions public so they can be called from the
  new dcn60 function

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   |   2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  22 ++++
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |  10 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |   2 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |   3 +
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c   | 124 ++++++++++++++++++
 6 files changed, 156 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/Makefile b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
index f5da45aacfca..2aaa0e8a8bd6 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
@@ -99,7 +99,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN50)
 
 ###############################################################################
 
-DPP_DCN60 = dcn60_dpp.o dcn60_dpp_dscl.o
+DPP_DCN60 = dcn60_dpp.o dcn60_dpp_dscl.o dcn60_dpp_cm.o
 
 AMD_DAL_DPP_DCN60 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn60/,$(DPP_DCN60))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
index 6a61b99d6a79..f397e8222ac9 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
@@ -587,6 +587,28 @@ bool dpp3_construct(struct dcn3_dpp *dpp3,
 bool dpp3_program_gamcor_lut(
 	struct dpp *dpp_base, const struct pwl_params *params);
 
+struct dcn3_xfer_func_reg;
+
+void dpp3_enable_cm_block(
+	struct dpp *dpp_base);
+
+enum dc_lut_mode dpp30_get_gamcor_current(
+	struct dpp *dpp_base);
+
+void dpp3_program_gammcor_lut(
+	struct dpp *dpp_base,
+	const struct pwl_result_data *rgb,
+	uint32_t num,
+	bool is_ram_a);
+
+void dpp3_gamcor_reg_field(
+	struct dcn3_dpp *dpp,
+	struct dcn3_xfer_func_reg *reg);
+
+void dpp3_configure_gamcor_lut(
+	struct dpp *dpp_base,
+	bool is_ram_a);
+
 void dpp3_program_CM_dealpha(
 		struct dpp *dpp_base,
 		uint32_t enable, uint32_t additive_blending);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index 083ab6acb687..86f47d33ec64 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -42,7 +42,7 @@
 #define FN(reg_name, field_name) \
 	dpp->tf_shift->field_name, dpp->tf_mask->field_name
 
-static void dpp3_enable_cm_block(
+void dpp3_enable_cm_block(
 		struct dpp *dpp_base)
 {
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
@@ -56,7 +56,7 @@ static void dpp3_enable_cm_block(
 	REG_UPDATE(CM_CONTROL, CM_BYPASS, cm_bypass_mode);
 }
 
-static enum dc_lut_mode dpp30_get_gamcor_current(struct dpp *dpp_base)
+enum dc_lut_mode dpp30_get_gamcor_current(struct dpp *dpp_base)
 {
 	enum dc_lut_mode mode = LUT_BYPASS;
 	uint32_t state_mode;
@@ -76,7 +76,7 @@ static enum dc_lut_mode dpp30_get_gamcor_current(struct dpp *dpp_base)
 	return mode;
 }
 
-static void dpp3_program_gammcor_lut(
+void dpp3_program_gammcor_lut(
 		struct dpp *dpp_base,
 		const struct pwl_result_data *rgb,
 		uint32_t num,
@@ -171,7 +171,7 @@ void dpp3_program_cm_bias(
 			CM_BIAS_CB_B, bias_params->cm_bias_cb_b);
 }
 
-static void dpp3_gamcor_reg_field(
+void dpp3_gamcor_reg_field(
 		struct dcn3_dpp *dpp,
 		struct dcn3_xfer_func_reg *reg)
 {
@@ -204,7 +204,7 @@ static void dpp3_gamcor_reg_field(
 	reg->masks.exp_resion_start_segment = dpp->tf_mask->CM_GAMCOR_RAMA_EXP_REGION_START_SEGMENT_B;
 }
 
-static void dpp3_configure_gamcor_lut(
+void dpp3_configure_gamcor_lut(
 		struct dpp *dpp_base,
 		bool is_ram_a)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
index f02aebcedd70..be2effb14fc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
@@ -294,7 +294,7 @@ void dpp60_full_bypass(struct dpp *dpp_base)
 }
 
 static struct dpp_funcs dcn60_dpp_funcs = {
-	.dpp_program_gamcor_lut		= dpp3_program_gamcor_lut,
+	.dpp_program_gamcor_lut		= dpp6_program_gamcor_lut,
 	.dpp_read_state				= dpp401_read_state,
 	.dpp_reset					= dpp_reset,
 	.dpp_set_scaler				= dpp60_dscl_set_scaler_manual_scale,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
index a0cc57e79ff7..5d09fcd04553 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
@@ -518,5 +518,8 @@ bool dpp60_construct(struct dcn60_dpp *dpp60,
 	const struct dcn60_dpp_shift *tf_shift,
 	const struct dcn60_dpp_mask *tf_mask);
 
+bool dpp6_program_gamcor_lut(
+	struct dpp *dpp_base, const struct pwl_params *params);
+
 
 #endif /* __DCN60_DPP_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c
new file mode 100644
index 000000000000..cb34a9f856c1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+
+#include "dm_services.h"
+#include "core_types.h"
+#include "reg_helper.h"
+#include "dcn60/dcn60_dpp.h"
+#include "basics/conversion.h"
+#include "dcn30/dcn30_cm_common.h"
+
+#define REG(reg)\
+	dpp->tf_regs->reg
+
+#define CTX \
+	dpp->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name) \
+	dpp->tf_shift->field_name, dpp->tf_mask->field_name
+
+static void dpp6_power_on_gamcor_lut(struct dpp *dpp_base, bool power_on)
+{
+	struct dcn60_dpp *dpp = TO_DCN60_DPP(dpp_base);
+
+	if (power_on) {
+		REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_FORCE, 0);
+		REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_DIS, 1);
+		REG_WAIT(CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, 0, 1, 100);
+	} else {
+		if (dpp->base.ctx->dc->debug.enable_mem_low_power.bits.cm) {
+			dpp->base.ctx->dc->optimized_required = true;
+			dpp->base.deferred_reg_writes.bits.disable_gamcor = true;
+		}
+	}
+}
+
+bool dpp6_program_gamcor_lut(
+	struct dpp *dpp_base, const struct pwl_params *params)
+{
+	enum dc_lut_mode current_mode;
+	enum dc_lut_mode next_mode;
+	struct dcn60_dpp *dpp = TO_DCN60_DPP(dpp_base);
+	struct dcn3_xfer_func_reg gam_regs;
+
+	dpp3_enable_cm_block(dpp_base);
+
+	if (params == NULL) { //bypass if we have no pwl data
+		REG_SET(CM_GAMCOR_CONTROL, 0, CM_GAMCOR_MODE, 0);
+		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
+			dpp6_power_on_gamcor_lut(dpp_base, false);
+		return false;
+	}
+	dpp6_power_on_gamcor_lut(dpp_base, true);
+	REG_SET(CM_GAMCOR_CONTROL, 0, CM_GAMCOR_MODE, 2);
+
+	current_mode = dpp30_get_gamcor_current(dpp_base);
+	if (current_mode == LUT_BYPASS || current_mode == LUT_RAM_A)
+		next_mode = LUT_RAM_B;
+	else
+		next_mode = LUT_RAM_A;
+
+	dpp6_power_on_gamcor_lut(dpp_base, true);
+	dpp3_configure_gamcor_lut(dpp_base, next_mode == LUT_RAM_A);
+
+	if (next_mode == LUT_RAM_B) {
+		gam_regs.start_cntl_b = REG(CM_GAMCOR_RAMB_START_CNTL_B);
+		gam_regs.start_cntl_g = REG(CM_GAMCOR_RAMB_START_CNTL_G);
+		gam_regs.start_cntl_r = REG(CM_GAMCOR_RAMB_START_CNTL_R);
+		gam_regs.start_slope_cntl_b = REG(CM_GAMCOR_RAMB_START_SLOPE_CNTL_B);
+		gam_regs.start_slope_cntl_g = REG(CM_GAMCOR_RAMB_START_SLOPE_CNTL_G);
+		gam_regs.start_slope_cntl_r = REG(CM_GAMCOR_RAMB_START_SLOPE_CNTL_R);
+		gam_regs.start_end_cntl1_b = REG(CM_GAMCOR_RAMB_END_CNTL1_B);
+		gam_regs.start_end_cntl2_b = REG(CM_GAMCOR_RAMB_END_CNTL2_B);
+		gam_regs.start_end_cntl1_g = REG(CM_GAMCOR_RAMB_END_CNTL1_G);
+		gam_regs.start_end_cntl2_g = REG(CM_GAMCOR_RAMB_END_CNTL2_G);
+		gam_regs.start_end_cntl1_r = REG(CM_GAMCOR_RAMB_END_CNTL1_R);
+		gam_regs.start_end_cntl2_r = REG(CM_GAMCOR_RAMB_END_CNTL2_R);
+		gam_regs.region_start = REG(CM_GAMCOR_RAMB_REGION_0_1);
+		gam_regs.region_end = REG(CM_GAMCOR_RAMB_REGION_32_33);
+		gam_regs.offset_b =  REG(CM_GAMCOR_RAMB_OFFSET_B);
+		gam_regs.offset_g =  REG(CM_GAMCOR_RAMB_OFFSET_G);
+		gam_regs.offset_r =  REG(CM_GAMCOR_RAMB_OFFSET_R);
+		gam_regs.start_base_cntl_b = REG(CM_GAMCOR_RAMB_START_BASE_CNTL_B);
+		gam_regs.start_base_cntl_g = REG(CM_GAMCOR_RAMB_START_BASE_CNTL_G);
+		gam_regs.start_base_cntl_r = REG(CM_GAMCOR_RAMB_START_BASE_CNTL_R);
+	} else {
+		gam_regs.start_cntl_b = REG(CM_GAMCOR_RAMA_START_CNTL_B);
+		gam_regs.start_cntl_g = REG(CM_GAMCOR_RAMA_START_CNTL_G);
+		gam_regs.start_cntl_r = REG(CM_GAMCOR_RAMA_START_CNTL_R);
+		gam_regs.start_slope_cntl_b = REG(CM_GAMCOR_RAMA_START_SLOPE_CNTL_B);
+		gam_regs.start_slope_cntl_g = REG(CM_GAMCOR_RAMA_START_SLOPE_CNTL_G);
+		gam_regs.start_slope_cntl_r = REG(CM_GAMCOR_RAMA_START_SLOPE_CNTL_R);
+		gam_regs.start_end_cntl1_b = REG(CM_GAMCOR_RAMA_END_CNTL1_B);
+		gam_regs.start_end_cntl2_b = REG(CM_GAMCOR_RAMA_END_CNTL2_B);
+		gam_regs.start_end_cntl1_g = REG(CM_GAMCOR_RAMA_END_CNTL1_G);
+		gam_regs.start_end_cntl2_g = REG(CM_GAMCOR_RAMA_END_CNTL2_G);
+		gam_regs.start_end_cntl1_r = REG(CM_GAMCOR_RAMA_END_CNTL1_R);
+		gam_regs.start_end_cntl2_r = REG(CM_GAMCOR_RAMA_END_CNTL2_R);
+		gam_regs.region_start = REG(CM_GAMCOR_RAMA_REGION_0_1);
+		gam_regs.region_end = REG(CM_GAMCOR_RAMA_REGION_32_33);
+		gam_regs.offset_b =  REG(CM_GAMCOR_RAMA_OFFSET_B);
+		gam_regs.offset_g =  REG(CM_GAMCOR_RAMA_OFFSET_G);
+		gam_regs.offset_r =  REG(CM_GAMCOR_RAMA_OFFSET_R);
+		gam_regs.start_base_cntl_b = REG(CM_GAMCOR_RAMA_START_BASE_CNTL_B);
+		gam_regs.start_base_cntl_g = REG(CM_GAMCOR_RAMA_START_BASE_CNTL_G);
+		gam_regs.start_base_cntl_r = REG(CM_GAMCOR_RAMA_START_BASE_CNTL_R);
+	}
+
+	//get register fields
+	dpp3_gamcor_reg_field(TO_DCN30_DPP(dpp_base), &gam_regs);
+
+	//program register set for LUTA/LUTB
+	cm_helper_program_gamcor_xfer_func(dpp_base->ctx, params, &gam_regs);
+
+	dpp3_program_gammcor_lut(dpp_base, params->rgb_resulted, params->hw_points_num,
+				 next_mode == LUT_RAM_A);
+
+	//select Gamma LUT to use for next frame
+	REG_UPDATE(CM_GAMCOR_CONTROL, CM_GAMCOR_SELECT, next_mode == LUT_RAM_A ? 0:1);
+
+	return true;
+}
-- 
2.53.0


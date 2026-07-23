Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4673C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1718310F1A6;
	Thu, 23 Jul 2026 20:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jlz1rM7s";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013043.outbound.protection.outlook.com
 [40.93.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D297310E5F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELFO6WA7bxhqz5mLTSId6MWSsNo8Cl906dgpJXC+jqJveOQADsT5+zToAiUmlrDzo05eMOhe20b+luyW4pXbwzAvK8NYsDoyWch+brUD785Ty79jmc2kgltxwywanONNmCuiUTTMCcH1TK/dAwlAFr+9d7PUe1MFc7FXQd88wVo8ayhR+yL601iS/2Kz191X+a1d7GQrimEvy6RmBBDYBAM8jVNkuDWV1FaOFvXro6xYCKwnCYp2bvA8wg8r8xM9dI54QQE24jvnpAzRA4WcSDagfENTFX0TguqPfiRrh2S65azVQzZhwyRRKtPZEWSHEjb/DIqmLWxIX/E4dIvf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NIzSNxu5yXEWaJcBY0AWge3aG689ZC7bX27oIbfAf4=;
 b=QIle9jrCi2zzERe3ixedJZ2j5H/ZhKU0VB+EBuxP2wyFcH6sMfZYvCUP6BWZLZ/td5K8RrMgf7y2K/hunMa50M3eqtWYxJHm1TRkpiruYeql9+Rmdo2UULWVhCNdrBKlfeThjIy9SqS1kVA+cLfS5o198Yv12tz+9S7IsQX4jNQVotRyPYCf8tmSwUEsMTHufvKiA15KqMnfiCyMv4rhjw1cp9ht7ka6N03KUiJUj7BFgz3nqWjYibOJfqaXJzpCI09LxVCsvTlWftm5GLlstZr8uINCGplDVMz8sRvN6NNvDNHhPRYHws+9EVYk60qL3GnJktEq4TuKYQJqrEUSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NIzSNxu5yXEWaJcBY0AWge3aG689ZC7bX27oIbfAf4=;
 b=Jlz1rM7sqw+Iq6FbLNC3pMLlNXcpUzgSKbDQsZoq6LXspjkKE/DJ+LKl9NovxMB+o31qrgHi3Xd0yZG/kCLlbHulKmRFyMJs4d6WXrEfoCZcAGIR3q/XP7oBT7HU+t4VjtIUF2+x0jt1jHA72VP/2jkHx5Xn/1yu5ETPmkIlPXA=
Received: from MN0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::30)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:18:52 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::60) by MN0P223CA0003.outlook.office365.com
 (2603:10b6:208:52b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:52 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:49 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>
Subject: [PATCH 02/49] drm/amd/display: Port DCN4+ MCIF ARB programming to new
 format
Date: Thu, 23 Jul 2026 16:13:10 -0400
Message-ID: <20260723201908.373300-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6354ff-35bb-4e59-01f1-08dee8f79d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|376014|1800799024|82310400026|36860700016|23010399003|5023799004|11063799006|6133799003|3023799007|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: IMEbyxTlAHzcwInCRa9tyQx/4bcn4iQIP+QRnIp51MuwA3I07Llj76iLPG3rhE6Pm8ojxZ+M8YKZc664s43Qt9369AOHwT9+mLEAb21+gmQ9MeSsjY0QlgYsEsMB7rit+3xfUCwmVmIOM3nBkymIpUGL4DHET3v3u/tW5+tdVRmU6ev4W7ZiXL/xb81ztJkSD7ZNMdg/ysfA82lpQZkma2PuFHyk5c3JqA59LVIhLbQwFFEGXEVk3VJOH4bQWK8RnKHy+kwiOhVs608L+u9GnRt2JW+bXyv81UNTvqzz+jWc5BkycqELUVJlRSsAhb7tSLhCjAZII2Es/O8/w+vO2EFtdcys1F1xKjfzDeekJVlUnmm4Q8xgun8mqHX2A9qJUxbMDm+7F9zxyXwBmh61N1p8QdTWRDV6f6SQsE5mN83X+/7ZiO6LOkkA2comtL2yIpknsphTQ+YXOh1I8YFPafUitQJkF+fq5xXC0fpRBUtWqWU1l3X56q4dN2lsB4M8RsDfeTP3J0Pziz/8ehMZPmvlEdb/fakg4veN71c+eCZ5OQpr5OHtHWitIIpL1O3i7GybeD+bdCRs6UyH3jbWH+0zMKjJTUIAl0rQOT0/VkdnhsmXTW2lO2ZYGdT6JOjnVhtf/8q1CxuzO/FYIWhFp4ISD7xSeGVy1PrRnqOAbA1Z3lPMujNemP45Jr73eK4a6G2aAw6rj3FkaJbW4V2jUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(5023799004)(11063799006)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5LnfOkqTl+qEjyjsk+QBuSjQeLTG2lS5P3MU5bPhjFJaCxgVjRHaB83v1EzX7ptV6jM5gInCsh6OJcYllpMg79BZJP+fkKklB5W8mEzRxXgK576AtysB+8rDVrICqAxotUShzUXw/WHQwxpW6rH5lSM1mBmi0AHfkYx9QylR2xiJMSwpaMm/qHPuJMblpkJTLFTX1oydA86e5Bd7/ItHX0E1hbvexoQDWleiwiPZ0p9nakp0Rdy1maxwPKJ5pQ1thHx13uOHgwi2yguRO3zDzidhy2bQaj3JOBMz5AhzjWcVej3fmqCLmjqYD7JPoYKuEZy4H+5Cclx/xM1+52fALtRgfssdOmf2whUhoP/PYO4o+/IyR1EECPyWbzXtIRmubXIVUx5Ck9wZSn3SjNUK0P+5qpkNsCdmu9UyTuFJe6dykGWsaB3R3aCumooMa/9i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:52.5073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6354ff-35bb-4e59-01f1-08dee8f79d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
DML2.1 now outputs MCIF arbiter programming, but using a new
structure. Change  DCN401 and DCN42 to use this new format.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |  10 ++
 .../dc/mmhubbub/dcn32/dcn32_mmhubbub.c        |   4 +-
 .../dc/mmhubbub/dcn32/dcn32_mmhubbub.h        |   5 +
 .../dc/mmhubbub/dcn401/dcn401_mmhubbub.c      | 135 ++++++++++++++++++
 .../dc/mmhubbub/dcn401/dcn401_mmhubbub.h      |  40 ++++++
 .../dc/mmhubbub/dcn42/dcn42_mmhubbub.h        |   1 +
 .../dc/resource/dcn401/dcn401_resource.c      |  29 ++--
 .../dc/resource/dcn401/dcn401_resource.h      |   4 +
 .../dc/resource/dcn42/dcn42_resource.c        |  28 ++--
 9 files changed, 227 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h

diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
index afc376defa0b..dddf5a9eb0b8 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
@@ -50,6 +50,16 @@ MMHUBBUB_DCN35 = dcn35_mmhubbub.o
 AMD_DAL_MMHUBBUB_DCN35 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn35/,$(MMHUBBUB_DCN35))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN35)
+
+
+###############################################################################
+# DCN401
+###############################################################################
+MMHUBBUB_DCN401 = dcn401_mmhubbub.o
+
+AMD_DAL_MMHUBBUB_DCN401 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn401/,$(MMHUBBUB_DCN401))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN401)
 endif
 
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
index 6b6f80a3bfd5..5ce787632fe9 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
@@ -73,7 +73,7 @@
  *    the bufmgr status can show the progress of write back, can be used for debug purpose
  */
 
-static void mmhubbub32_warmup_mcif(struct mcif_wb *mcif_wb,
+void mmhubbub32_warmup_mcif(struct mcif_wb *mcif_wb,
 		struct mcif_warmup_params *params)
 {
 	struct dcn30_mmhubbub *mcif_wb30 = TO_DCN30_MMHUBBUB(mcif_wb);
@@ -100,7 +100,7 @@ static void mmhubbub32_warmup_mcif(struct mcif_wb *mcif_wb,
 	REG_UPDATE(MMHUBBUB_WARMUP_CONTROL_STATUS, MMHUBBUB_WARMUP_EN, false);
 }
 
-static void mmhubbub32_config_mcif_buf(struct mcif_wb *mcif_wb,
+void mmhubbub32_config_mcif_buf(struct mcif_wb *mcif_wb,
 		struct mcif_buf_params *params,
 		unsigned int dest_height)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h
index ef15b4f1f6b9..682f3bba6d50 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h
@@ -200,6 +200,11 @@
 	SF(MMHUBBUB_WARMUP_CONTROL_STATUS, MMHUBBUB_WARMUP_SW_INT_ACK, mask_sh),\
 	SF(MMHUBBUB_WARMUP_CONTROL_STATUS, MMHUBBUB_WARMUP_INC_ADDR, mask_sh)
 
+void mmhubbub32_warmup_mcif(struct mcif_wb *mcif_wb,
+		struct mcif_warmup_params *params);
+void mmhubbub32_config_mcif_buf(struct mcif_wb *mcif_wb,
+		struct mcif_buf_params *params,
+		unsigned int dest_height);
 
 void dcn32_mmhubbub_construct(struct dcn30_mmhubbub *mcif_wb30,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c
new file mode 100644
index 000000000000..d2845acb74c8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "dcn401_mmhubbub.h"
+#include "reg_helper.h"
+
+#define REG(reg)                                                             \
+	((const struct dcn35_mmhubbub_registers *)(mcif_wb30->mcif_wb_regs)) \
+		->reg
+
+#define CTX mcif_wb30->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name)                                                \
+	((const struct dcn401_mmhubbub_shift *)(mcif_wb30->mcif_wb_shift))       \
+		->field_name,                                                   \
+		((const struct dcn401_mmhubbub_mask *)(mcif_wb30->mcif_wb_mask)) \
+			->field_name
+
+static void mmhubbub401_config_mcif_arb(struct mcif_wb *mcif_wb,
+		struct mcif_arb_params *params)
+{
+	struct dcn30_mmhubbub *mcif_wb30 = TO_DCN30_MMHUBBUB(mcif_wb);
+
+	/* Programmed by the video driver based on the CRTC timing (for DWB) */
+	REG_UPDATE(MCIF_WB_ARBITRATION_CONTROL,
+			MCIF_WB_TIME_PER_PIXEL, params->dcn4x.inst_regs.time_per_pixel);
+
+	/*
+	 * Programming DWB watermark.
+	 * Watermark to generate urgent in MCIF_WB_CLI, value is determined by MCIF_WB_CLI_WATERMARK_MASK.
+	 * Program in ns. A formula will be provided in the pseudo code to calculate the value.
+	 */
+	/* Program urgent_watermarkA */
+	REG_UPDATE_2(MCIF_WB_WATERMARK,
+			MCIF_WB_CLI_WATERMARK_MASK, 0x0,
+			MCIF_WB_CLI_WATERMARK, params->dcn4x.global_regs.wm_regs[0].urgent);
+	/* Program urgent_watermarkB */
+	REG_UPDATE_2(MCIF_WB_WATERMARK,
+			MCIF_WB_CLI_WATERMARK_MASK, 0x1,
+			MCIF_WB_CLI_WATERMARK, params->dcn4x.global_regs.wm_regs[0].urgent);
+	/* Program urgent_watermarkC */
+	REG_UPDATE_2(MCIF_WB_WATERMARK,
+			MCIF_WB_CLI_WATERMARK_MASK, 0x2,
+			MCIF_WB_CLI_WATERMARK, params->dcn4x.global_regs.wm_regs[0].urgent);
+	/* Program urgent_watermarkD */
+	REG_UPDATE_2(MCIF_WB_WATERMARK,
+			MCIF_WB_CLI_WATERMARK_MASK, 0x3,
+			MCIF_WB_CLI_WATERMARK, params->dcn4x.global_regs.wm_regs[0].urgent);
+
+	/* Programming UCLK P-State watermark */
+	/* Program nbp_state_change_watermarkA */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x0,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x0,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].uclk_pstate);
+	/* Program nbp_state_change_watermarkB */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x1,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x0,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].uclk_pstate);
+	/* Program nbp_state_change_watermarkC */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x2,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x0,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].uclk_pstate);
+	/* Program nbp_state_change_watermarkD */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x3,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x0,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].uclk_pstate);
+
+	/* Programming FCLK P-State watermark */
+	/* Program nbp_state_change_watermarkA */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x0,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x1,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].temp_read_or_ppt);
+	/* Program nbp_state_change_watermarkB */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x1,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x1,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].temp_read_or_ppt);
+	/* Program nbp_state_change_watermarkC */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x2,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x1,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].fclk_pstate);
+	/* Program nbp_state_change_watermarkD */
+	REG_UPDATE_3(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, 0x3,
+		NB_PSTATE_CHANGE_WATERMARK_TYPE, 0x1,
+		NB_PSTATE_CHANGE_REFRESH_WATERMARK, params->dcn4x.global_regs.wm_regs[0].fclk_pstate);
+
+	/* Program max_scaled_time */
+	REG_UPDATE(MULTI_LEVEL_QOS_CTRL,
+			MAX_SCALED_TIME_TO_URGENT, params->dcn4x.inst_regs.max_scaled_time_ns);
+
+	/* Program slice_lines */
+	REG_UPDATE(MCIF_WB_BUFMGR_VCE_CONTROL,
+			MCIF_WB_BUFMGR_SLICE_SIZE, params->dcn4x.inst_regs.slice_lines);
+
+	/* Set arbitration unit for Luma/Chroma */
+	/* arb_unit=2 should be chosen for more efficiency */
+	/* Arbitration size, 0: 2048 bytes 1: 4096 bytes 2: 8192 Bytes */
+	REG_UPDATE(MCIF_WB_ARBITRATION_CONTROL,
+			MCIF_WB_CLIENT_ARBITRATION_SLICE, params->dcn4x.inst_regs.arbitration_slice);
+}
+
+static const struct mcif_wb_funcs dcn401_mmhubbub_funcs = {
+	.warmup_mcif		= mmhubbub32_warmup_mcif,
+	.enable_mcif		= mmhubbub2_enable_mcif,
+	.disable_mcif		= mmhubbub2_disable_mcif,
+	.config_mcif_buf	= mmhubbub32_config_mcif_buf,
+	.config_mcif_arb	= mmhubbub401_config_mcif_arb,
+	.config_mcif_irq	= mmhubbub2_config_mcif_irq,
+	.dump_frame			= mcifwb2_dump_frame,
+};
+
+void dcn401_mmhubbub_construct(struct dcn30_mmhubbub *mcif_wb30,
+		struct dc_context *ctx,
+		const struct dcn35_mmhubbub_registers *mcif_wb_regs,
+		const struct dcn401_mmhubbub_shift *mcif_wb_shift,
+		const struct dcn401_mmhubbub_mask *mcif_wb_mask,
+		int inst)
+{
+	mcif_wb30->base.ctx = ctx;
+
+	mcif_wb30->base.inst = inst;
+	mcif_wb30->base.funcs = &dcn401_mmhubbub_funcs;
+	mcif_wb30->mcif_wb_regs = (const struct dcn30_mmhubbub_registers *)mcif_wb_regs;
+	mcif_wb30->mcif_wb_shift = (const struct dcn30_mmhubbub_shift *)mcif_wb_shift;
+	mcif_wb30->mcif_wb_mask = (const struct dcn30_mmhubbub_mask *)mcif_wb_mask;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h
new file mode 100644
index 000000000000..fbc69a210fa7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2026 Advanced Micro Devices, Inc. */
+
+
+#ifndef __DCN401_MMHUBBUB_H
+#define __DCN401_MMHUBBUB_H
+
+#include "mcif_wb.h"
+#include "dcn32/dcn32_mmhubbub.h"
+#include "dcn35/dcn35_mmhubbub.h"
+
+#define MCIF_WB_REG_VARIABLE_LIST_DCN4_01  \
+	MCIF_WB_REG_VARIABLE_LIST_DCN3_5;
+
+#define MCIF_WB_COMMON_MASK_SH_LIST_DCN4_01(mask_sh)                            \
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN3_5(mask_sh),                            \
+    SF(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK, NB_PSTATE_CHANGE_WATERMARK_TYPE, mask_sh)
+
+#define MCIF_WB_REG_FIELD_LIST_DCN4_01(type)          \
+	struct {                                     \
+		MCIF_WB_REG_FIELD_LIST_DCN3_5(type); \
+		type NB_PSTATE_CHANGE_WATERMARK_TYPE;          \
+	}
+
+struct dcn401_mmhubbub_mask {
+	MCIF_WB_REG_FIELD_LIST_DCN4_01(uint32_t);
+};
+
+struct dcn401_mmhubbub_shift {
+	MCIF_WB_REG_FIELD_LIST_DCN4_01(uint8_t);
+};
+
+void dcn401_mmhubbub_construct(struct dcn30_mmhubbub *mcif_wb30,
+		struct dc_context *ctx,
+		const struct dcn35_mmhubbub_registers *mcif_wb_regs,
+		const struct dcn401_mmhubbub_shift *mcif_wb_shift,
+		const struct dcn401_mmhubbub_mask *mcif_wb_mask,
+		int inst);
+
+#endif // __DCN401_MMHUBBUB_H
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h
index 0dd1f0d2eb88..0001903a04ec 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h
@@ -8,6 +8,7 @@
 #include "mcif_wb.h"
 #include "dcn32/dcn32_mmhubbub.h"
 #include "dcn35/dcn35_mmhubbub.h"
+#include "dcn401/dcn401_mmhubbub.h"
 
 void dcn42_mmhubbub_set_fgcg(struct dcn30_mmhubbub *mcif_wb30, bool enabled);
 #endif // __DCN42_MMHUBBUB_H
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index e3ee792fb2e8..f7ba0509e6bd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -16,6 +16,7 @@
 #include "dcn30/dcn30_resource.h"
 #include "dcn32/dcn32_resource.h"
 #include "dcn321/dcn321_resource.h"
+#include "dcn35/dcn35_resource.h"
 
 #include "dcn10/dcn10_ipp.h"
 #include "dcn401/dcn401_hubbub.h"
@@ -58,7 +59,7 @@
 #include "dcn31/dcn31_panel_cntl.h"
 
 #include "dcn30/dcn30_dwb.h"
-#include "dcn32/dcn32_mmhubbub.h"
+#include "dcn401/dcn401_mmhubbub.h"
 
 #include "dcn/dcn_4_1_0_offset.h"
 #include "dcn/dcn_4_1_0_sh_mask.h"
@@ -435,17 +436,17 @@ static const struct dcn30_dwbc_mask dwbc401_mask = {
 };
 
 
-#define mcif_wb_regs_dcn3_init(id)\
-	MCIF_WB_COMMON_REG_LIST_DCN32_RI(id)
+#define mcif_wb_regs_dcn401_init(id) \
+	MCIF_WB_COMMON_REG_LIST_DCN4_01_RI(id)
 
-static struct dcn30_mmhubbub_registers mcif_wb30_regs[1];
+static struct dcn35_mmhubbub_registers mcif_wb401_regs[1];
 
-static const struct dcn30_mmhubbub_shift mcif_wb30_shift = {
-	MCIF_WB_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
+static const struct dcn401_mmhubbub_shift mcif_wb401_shift = {
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN4_01(__SHIFT)
 };
 
-static const struct dcn30_mmhubbub_mask mcif_wb30_mask = {
-	MCIF_WB_COMMON_MASK_SH_LIST_DCN32(_MASK)
+static const struct dcn401_mmhubbub_mask mcif_wb401_mask = {
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN4_01(_MASK)
 };
 
 #define dsc_regs_init(id)\
@@ -1704,13 +1705,13 @@ static bool dcn401_mmhubbub_create(struct dc_context *ctx, struct resource_pool
 		}
 
 #undef REG_STRUCT
-#define REG_STRUCT mcif_wb30_regs
-		mcif_wb_regs_dcn3_init(0);
+#define REG_STRUCT mcif_wb401_regs
+		mcif_wb_regs_dcn401_init(0);
 
-		dcn32_mmhubbub_construct(mcif_wb30, ctx,
-				&mcif_wb30_regs[i],
-				&mcif_wb30_shift,
-				&mcif_wb30_mask,
+		dcn401_mmhubbub_construct(mcif_wb30, ctx,
+				&mcif_wb401_regs[i],
+				&mcif_wb401_shift,
+				&mcif_wb401_mask,
 				i);
 
 		pool->mcif_wb[i] = &mcif_wb30->base;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index ce96fe1ddb7c..42a0986d6fe2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -7,6 +7,7 @@
 
 #include "core_types.h"
 #include "dcn32/dcn32_resource.h"
+#include "dcn35/dcn35_resource.h"
 #include "dcn401/dcn401_hubp.h"
 
 #define TO_DCN401_RES_POOL(pool)\
@@ -660,4 +661,7 @@ int dcn401_get_power_profile(const struct dc_state *context);
 	SR(SYMCLKC_CLOCK_ENABLE),\
 	SR(SYMCLKD_CLOCK_ENABLE)
 
+#define MCIF_WB_COMMON_REG_LIST_DCN4_01_RI(inst)  \
+	MCIF_WB_COMMON_REG_LIST_DCN3_5_RI(inst)
+
 #endif /* _DCN401_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 547a0b816539..67673a9e5155 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -400,16 +400,18 @@ static const struct dcn30_dwbc_shift dwbc401_shift = {
 static const struct dcn30_dwbc_mask dwbc401_mask = {
 	DWBC_COMMON_MASK_SH_LIST_DCN30(_MASK)};
 
-#define mcif_wb_regs_dcn3_init(id) \
-	MCIF_WB_COMMON_REG_LIST_DCN3_5_RI(id)
+#define mcif_wb_regs_dcn401_init(id) \
+	MCIF_WB_COMMON_REG_LIST_DCN4_01_RI(id)
 
-static struct dcn35_mmhubbub_registers mcif_wb35_regs[1];
+static struct dcn35_mmhubbub_registers mcif_wb401_regs[1];
 
-static const struct dcn35_mmhubbub_shift mcif_wb35_shift = {
-	MCIF_WB_COMMON_MASK_SH_LIST_DCN3_5(__SHIFT)};
+static const struct dcn401_mmhubbub_shift mcif_wb401_shift = {
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN4_01(__SHIFT)
+};
 
-static const struct dcn35_mmhubbub_mask mcif_wb35_mask = {
-	MCIF_WB_COMMON_MASK_SH_LIST_DCN3_5(_MASK)};
+static const struct dcn401_mmhubbub_mask mcif_wb401_mask = {
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN4_01(_MASK)
+};
 
 #define dsc_regs_init(id) \
 	DSC_REG_LIST_DCN401_RI(id)
@@ -1768,13 +1770,13 @@ static bool dcn42_mmhubbub_create(struct dc_context *ctx, struct resource_pool *
 		}
 
 #undef REG_STRUCT
-#define REG_STRUCT mcif_wb35_regs
-		mcif_wb_regs_dcn3_init(0);
+#define REG_STRUCT mcif_wb401_regs
+		mcif_wb_regs_dcn401_init(0);
 
-		dcn35_mmhubbub_construct(mcif_wb30, ctx,
-					&mcif_wb35_regs[i],
-					&mcif_wb35_shift,
-					&mcif_wb35_mask,
+		dcn401_mmhubbub_construct(mcif_wb30, ctx,
+					&mcif_wb401_regs[i],
+					&mcif_wb401_shift,
+					&mcif_wb401_mask,
 					i);
 
 		dcn42_mmhubbub_init(mcif_wb30, ctx);
-- 
2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A73CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E03610E477;
	Tue, 26 May 2026 07:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O31dc80d";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28B010E477
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZhd6tL6INjnLbgrVCQiQYHPdbpOif8KHNHnqnZLsAZMkm5ssgi9nc72CA0M8GMCK2J4vcdARy2xW0BZKm8P3CzhZoJEF2yUzIinKzYvD5EdJXOtE2R66rwsT4SlFnzeYaG1gse/4A4EmcNHT4Ge59SkiF5BPJRUsYHYDZDsOXnuzKfxQJi5yaGi0UG++dbweiFeul8WQh/tMtqkhPiYu71x7KwWUP7dcgNlplmapv2T64BV+675e1hu/TQkB/zjo/0pm5hAfK/7dfkNnqV+c8w7wy8rowCI9YWf36SOBVtazmAdp1Fv73/UxieL0+JVSBYozKbYqiL+w5R9XFl3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZidgMldXj3v30H7Nw69m2EVfxOXLom/GALCZU5b/so=;
 b=WXE+/KxaLTEq2xuT5HbZItomdmNZgyUlstm8CfaBp7joC5g9fOu43WxzhMWkkFVJEHZnKf9HyZrSZXuKYbgXU6HVeuwfW64B8z3we7DFSzk70q3JNTRE1sA637F20rsvzRoVoY3L0tXrdtygfqaNv58au3jtVrl3K6nXGJHZpmB4WX5o2deMa9cJ67PQe/7fy+ATjdzELV7GcxSh8192jGijl8pN86k1iWjMuuHa5nDjeCH51OQVLwwsgrUdK2AkIURgjaQHM6yZI9f2T8oVZY/xpdBAnbGpkDarGKlIzNelwvhnaJsh4TKQoo5rbRN7LiQRlP5J2xvJpMI9H0sxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZidgMldXj3v30H7Nw69m2EVfxOXLom/GALCZU5b/so=;
 b=O31dc80d80lrRy7LldthoJG9xFmIFBjoSQazPOzdfgFRNM3Rb6ppDMs5yet/IP1Ui3nI7l5dm6XbvGRzq+7qATNob/g4flYsJVKn+j75sH8qzPQzn+gz65ZNFNz3KDT8Z8yxCyc+ERdoByJiQfQX8BDzg7rbmcq+TRcmXgOd2N8=
Received: from MN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:52f::26)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 07:19:44 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::6b) by MN0PR03CA0006.outlook.office365.com
 (2603:10b6:208:52f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:19:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:19:42 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:19:34 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 34/41] drm/amd/display: Add DCN42B DC resource files
Date: Tue, 26 May 2026 15:01:57 +0800
Message-ID: <20260526071413.2181251-35-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a267364-7a01-4070-5b18-08debaf728f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|5023799004|3023799007|6133799003|56012099003|22082099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: l4BkdN3bBmP/nxLy//u7Mj/6lhqxhQVPcfJ1Ge0DoyUq6NDZNcVahjRrhl6tb8KYVn/HOqRqZflKMyjKCTthU5u5pDwBaD6qA1W0qsiI2nu0sKPccf0LoEsJVPhgOkIPaoz5RMwvt3H8a2SfFHxiUcj1bnxkAe+4zxvvdRLbiZ6jpgcMZZudVDXXRTt8rDk5a98fi0xmGzbZ6U+93I+5nhx2YuFK8trFU3sYvW9Pl+Ku7bsiSQzL77rySm34peYOmUT5CLcEj4umhZWPOkKOcbe6JaJlgVQJiPUlMXyYwP7RYAIBUoRPQL7Vg33lySpSR8thwY+JIPjaeGnAN/xE7KzkT5I4Yn/bDTwVOw2BW9CBqXiCJIHJ2TVt6TC6441AaPFJelwNC8LYLOh9l7GakVIEueHQ+MQJEuyaEWY3hf4fX25FRC+jhU53GKTHvNNz8HBEXE0m9iEig81AKlRBrFS+KG8UeAXHCyUFttT5X0v5kQBGXtj1Q4XhBe1kyxsSeJbJEJcLH7FSNQai1wsYGUuHYn2uSDS4D6SqhEerXnsbP3IhXIXpbC3UjaKSTwxlxLfk4pu7keoaXTNlyNi8Kd85gkl9TBSKtQjscgEN/K0TncDtkKaMPKczp7izwQRq3KmD/40wR2GcS7bm5a5QHUjy6G25e6ehMFKMWfGas1oIfFRDq5ctmOehqAZkfcSiDpbqdV3U/0GjucfUjryRpQ9OhOgvky5ulP2aC4U3XD4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(5023799004)(3023799007)(6133799003)(56012099003)(22082099003)(18002099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NoORpV+ePy0rM5crO9IJIAm/V0NMt/OFqG8+wyFCI93USxPBNQp13xnOhSBFd2dmuFIAI+ttbCJr1HvwS8C4pzYeD4ht8UVfxW+SG+jkZquk7iL3oSIsOaULGNvWexQk5vT7lkbyU4G2AKD0ZBPEEJkPGUbde1JCF57zZjqriWee7qZ3BPADE3n7nJqw6aX7IZUKF470KZ/AiXq4F9tO1O83kpKvq1jh2LJ3F4L4bflNFjeRfhH8PulXk70EbIzMl4p7FqK3DNVERhIaWTZfAasFqBdn24xrAMOaHM0gQbOtNoKGnveP4QdOfXnJi2lE4yNtWBolDNbHwMqlQVTfQOtlTNoP9cG+IyvZxtsXcyvssLxmM3uFSRkoDyVVCuODTj1tqIFG6sf/srLlkc/OCJj7UoWhSYNOC380BTR7t7CmY4SUVq/dtXNx8z6q2sRG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:19:43.9853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a267364-7a01-4070-5b18-08debaf728f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
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

From: Matthew Stewart <matthew.stewart2@amd.com>

[Why & How]
Add DC resource files for DCN42B.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |  483 ++++
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h        |   48 +
 .../dc/gpio/dcn42b/hw_factory_dcn42b.c        |  313 +++
 .../dc/gpio/dcn42b/hw_factory_dcn42b.h        |   11 +
 .../dc/gpio/dcn42b/hw_translate_dcn42b.c      |  192 ++
 .../dc/gpio/dcn42b/hw_translate_dcn42b.h      |   13 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c |  238 ++
 .../amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h |   15 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_init.c  |   20 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_init.h  |   14 +
 .../dc/resource/dcn42b/dcn42b_resource.c      | 2404 +++++++++++++++++
 .../dc/resource/dcn42b/dcn42b_resource.h      |  672 +++++
 12 files changed, 4423 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
new file mode 100644
index 000000000000..4be5abdc60ea
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -0,0 +1,483 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dcn42b_clk_mgr.h"
+
+#include "dccg.h"
+#include "clk_mgr_internal.h"
+
+// For dce12_get_dp_ref_freq_khz
+#include "dce100/dce_clk_mgr.h"
+
+// For dcn20_update_clocks_update_dpp_dto
+#include "dcn20/dcn20_clk_mgr.h"
+
+#include "reg_helper.h"
+#include "core_types.h"
+#include "dcn42/dcn42_smu.h"
+#include "dcn42/dcn42_clk_mgr.h"
+#include "dm_helpers.h"
+
+/* TODO: remove this include once we ported over remaining clk mgr functions*/
+#include "dcn30/dcn30_clk_mgr.h"
+#include "dcn31/dcn31_clk_mgr.h"
+#include "dcn35/dcn35_clk_mgr.h"
+
+#include "dc_dmub_srv.h"
+#include "link_service.h"
+#include "logger_types.h"
+
+#include "clk/clk_15_0_5_offset.h"
+#include "clk/clk_15_0_5_sh_mask.h"
+#include "dcn/dcn_4_2_1_offset.h"
+#include "dcn/dcn_4_2_1_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG0                       0x00000012
+#define DCN_BASE__INST0_SEG1                       0x000000C0
+
+
+#undef DC_LOGGER
+#define DC_LOGGER \
+	dc_logger
+#define DC_LOGGER_INIT(logger) \
+	struct dal_logger *dc_logger = logger
+
+
+#define mmCLK5_CLK_TICK_CNT_CONFIG_REG                  0x1B229
+#define mmCLK5_CLK0_CURRENT_CNT                         0x1B22B //DISPCLK
+#define mmCLK5_CLK1_CURRENT_CNT                         0x1B22C //DPPCLK
+#define mmCLK5_CLK2_CURRENT_CNT                         0x1B22D //DPREFCLK
+#define mmCLK5_CLK3_CURRENT_CNT                         0x1B22E //DCFCLK
+
+#define mmCLK5_CLK0_DS_CNTL                             0x1B204
+#define mmCLK5_CLK1_DS_CNTL                             0x1B20C
+#define mmCLK5_CLK2_DS_CNTL                             0x1B214
+#define mmCLK5_CLK3_DS_CNTL                             0x1B21C
+
+#define mmCLK5_CLK0_BYPASS_CNTL                         0x1B20A
+#define mmCLK5_CLK1_BYPASS_CNTL                         0x1B212
+#define mmCLK5_CLK2_BYPASS_CNTL                         0x1B21A
+#define mmCLK5_CLK3_BYPASS_CNTL                         0x1B222
+
+#undef FN
+#define FN(reg_name, field_name) \
+	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
+
+#define REG(reg) \
+	(clk_mgr->regs->reg)
+
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+#define SR(reg_name)\
+		.reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
+					reg ## reg_name
+
+#define CLK_SR_DCN42B(reg_name)\
+	.reg_name = mm ## reg_name
+
+static const struct clk_mgr_registers clk_mgr_regs_dcn42b = {
+	CLK_REG_LIST_DCN42B()
+};
+
+static const struct clk_mgr_shift clk_mgr_shift_dcn42b = {
+	CLK_COMMON_MASK_SH_LIST_DCN42B(__SHIFT)
+};
+
+static const struct clk_mgr_mask clk_mgr_mask_dcn42b = {
+	CLK_COMMON_MASK_SH_LIST_DCN42B(_MASK)
+};
+
+
+
+#define TO_CLK_MGR_DCN42B(clk_mgr_int)\
+	container_of(clk_mgr_int, struct clk_mgr_dcn42, base)
+
+static void dcn42b_dump_clk_registers_internal(struct dcn42b_clk_internal *internal, struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	REG_GET(CLK5_CLK_TICK_CNT_CONFIG_REG, TIMER_THRESHOLD, &internal->CLK5_CLK_TICK_CNT__TIMER_THRESHOLD);
+
+	// read dcf deep sleep divider
+	internal->CLK5_CLK0_DS_CNTL = REG_READ(CLK5_CLK0_DS_CNTL);
+	internal->CLK5_CLK3_DS_CNTL = REG_READ(CLK5_CLK3_DS_CNTL);
+	// read dispclk
+	internal->CLK5_CLK0_CURRENT_CNT = dcn42b_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dispclk);
+	internal->CLK5_CLK0_BYPASS_CNTL = REG_READ(CLK5_CLK0_BYPASS_CNTL);
+	// read dppclk
+	internal->CLK5_CLK1_CURRENT_CNT = dcn42b_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dppclk);
+	internal->CLK5_CLK1_BYPASS_CNTL = REG_READ(CLK5_CLK1_BYPASS_CNTL);
+	// read dprefclk
+	internal->CLK5_CLK2_CURRENT_CNT = dcn42b_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dprefclk);
+	internal->CLK5_CLK2_BYPASS_CNTL = REG_READ(CLK5_CLK2_BYPASS_CNTL);
+	// read dcfclk
+	internal->CLK5_CLK3_CURRENT_CNT = dcn42b_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dcfclk);
+	internal->CLK5_CLK3_BYPASS_CNTL = REG_READ(CLK5_CLK3_BYPASS_CNTL);
+	/* read dtbclk - DTBCLK tied off in DCN42B
+	* internal->CLK5_CLK4_CURRENT_CNT = REG_READ(CLK5_CLK4_CURRENT_CNT) / ratio;
+	* internal->CLK5_CLK4_BYPASS_CNTL = REG_READ(CLK5_CLK4_BYPASS_CNTL);
+	*/
+}
+
+static void dcn42b_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+		struct clk_mgr_dcn42 *clk_mgr)
+{
+	struct dcn42b_clk_internal internal = {0};
+	char *bypass_clks[5] = {"0x0 DFS", "0x1 REFCLK", "0x2 ERROR", "0x3 400 FCH", "0x4 600 FCH"};
+
+	DC_LOGGER_INIT(clk_mgr->base.base.ctx->logger);
+	(void)dc_logger;
+
+	dcn42b_dump_clk_registers_internal(&internal, &clk_mgr->base.base);
+	regs_and_bypass->timer_threshold = internal.CLK5_CLK_TICK_CNT__TIMER_THRESHOLD;
+	regs_and_bypass->dcfclk = internal.CLK5_CLK3_CURRENT_CNT / 10;
+	regs_and_bypass->dcf_deep_sleep_divider = internal.CLK5_CLK3_DS_CNTL / 10;
+	regs_and_bypass->dcf_deep_sleep_allow = internal.CLK5_CLK3_DS_CNTL & 0x10; /*bit 4: CLK0_ALLOW_DS*/
+	regs_and_bypass->dprefclk = internal.CLK5_CLK2_CURRENT_CNT / 10;
+	regs_and_bypass->dispclk = internal.CLK5_CLK0_CURRENT_CNT / 10;
+	regs_and_bypass->dppclk = internal.CLK5_CLK1_CURRENT_CNT / 10;
+	/* regs_and_bypass->dtbclk = internal.CLK5_CLK4_CURRENT_CNT / 10; */ /* DTBCLK tied off in DCN42B */
+
+	regs_and_bypass->dispclk_bypass = get_reg_field_value(internal.CLK5_CLK0_BYPASS_CNTL, CLK5_CLK0_BYPASS_CNTL, CLK0_BYPASS_SEL);
+	regs_and_bypass->dppclk_bypass = get_reg_field_value(internal.CLK5_CLK1_BYPASS_CNTL, CLK5_CLK1_BYPASS_CNTL, CLK1_BYPASS_SEL);
+	regs_and_bypass->dprefclk_bypass = get_reg_field_value(internal.CLK5_CLK2_BYPASS_CNTL, CLK5_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL);
+	regs_and_bypass->dcfclk_bypass = get_reg_field_value(internal.CLK5_CLK3_BYPASS_CNTL, CLK5_CLK3_BYPASS_CNTL, CLK3_BYPASS_SEL);
+
+	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
+		DC_LOG_SMU("clk_type,clk_value,deepsleep_cntl,deepsleep_allow,bypass\n");
+
+		DC_LOG_SMU("dcfclk,%d,%d,%d,%s\n",
+				   regs_and_bypass->dcfclk,
+				   regs_and_bypass->dcf_deep_sleep_divider,
+				   regs_and_bypass->dcf_deep_sleep_allow,
+				   bypass_clks[(int) regs_and_bypass->dcfclk_bypass]);
+
+		DC_LOG_SMU("dprefclk,%d,N/A,N/A,%s\n",
+			regs_and_bypass->dprefclk,
+			bypass_clks[(int) regs_and_bypass->dprefclk_bypass]);
+
+		DC_LOG_SMU("dispclk,%d,N/A,N/A,%s\n",
+			regs_and_bypass->dispclk,
+			bypass_clks[(int) regs_and_bypass->dispclk_bypass]);
+
+		//split
+		DC_LOG_SMU("SPLIT\n");
+
+		// REGISTER VALUES
+		DC_LOG_SMU("reg_name,value,clk_type\n");
+
+		DC_LOG_SMU("CLK5_CLK3_CURRENT_CNT,%d,dcfclk\n",
+				internal.CLK5_CLK3_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK5_CLK3_DS_CNTL,%d,dcf_deep_sleep_divider\n",
+					internal.CLK5_CLK3_DS_CNTL);
+
+		DC_LOG_SMU("CLK5_CLK3_ALLOW_DS,%d,dcf_deep_sleep_allow\n",
+					(internal.CLK5_CLK3_DS_CNTL & 0x10));
+
+		DC_LOG_SMU("CLK5_CLK2_CURRENT_CNT,%d,dprefclk\n",
+					internal.CLK5_CLK2_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK5_CLK0_CURRENT_CNT,%d,dispclk\n",
+					internal.CLK5_CLK0_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK5_CLK1_CURRENT_CNT,%d,dppclk\n",
+					internal.CLK5_CLK1_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK5_CLK3_BYPASS_CNTL,%d,dcfclk_bypass\n",
+					internal.CLK5_CLK3_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK5_CLK2_BYPASS_CNTL,%d,dprefclk_bypass\n",
+					internal.CLK5_CLK2_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK5_CLK0_BYPASS_CNTL,%d,dispclk_bypass\n",
+					internal.CLK5_CLK0_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK5_CLK1_BYPASS_CNTL,%d,dppclk_bypass\n",
+					internal.CLK5_CLK1_BYPASS_CNTL);
+	}
+}
+
+static void init_clk_states(struct clk_mgr *clk_mgr)
+{
+	/*
+	 * DTBCLK is tied off in DCN42B - no save/restore needed
+	 * uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+	 */
+
+	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
+	clk_mgr->clks.dtbclk_en = false; /* DTBCLK tied off in DCN42B */
+
+
+	clk_mgr->clks.ref_dtbclk_khz = 0;
+	clk_mgr->clks.p_state_change_support = true;
+	clk_mgr->clks.prev_p_state_change_support = true;
+	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
+	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
+}
+
+/* dcn42b_get_dpm_table_from_smu removed: reuse dcn42_get_dpm_table_from_smu.
+ * Function is identical - only uses SMU calls, no hardware register differences.
+ */
+
+void dcn42b_init_clocks(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct clk_mgr_dcn42 *clk_mgr = TO_CLK_MGR_DCN42B(clk_mgr_int);
+
+	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+	(void)dc_logger;
+
+	init_clk_states(clk_mgr_base);
+
+	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
+	if (dcn42_is_spll_ssc_enabled(clk_mgr_base))
+		clk_mgr_base->dp_dto_source_clock_in_khz =
+			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
+	else
+		clk_mgr_base->dp_dto_source_clock_in_khz = clk_mgr_base->dprefclk_khz;
+
+	DC_LOG_SMU("dp_dto_source_clock %d, dprefclk %d\n", clk_mgr_base->dp_dto_source_clock_in_khz, clk_mgr_base->dprefclk_khz);
+	dcn42b_dump_clk_registers(&clk_mgr_base->boot_snapshot, clk_mgr);
+}
+
+static struct clk_bw_params dcn42b_bw_params = {
+	.vram_type = Ddr4MemType,
+	.num_channels = 1,
+	.clk_table = {
+		.num_entries = 4,
+	},
+
+};
+
+static struct wm_table ddr5_wm_table = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+	}
+};
+
+static struct wm_table lpddr5_wm_table = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 28.0,
+			.sr_enter_plus_exit_time_us = 30.0,
+			.valid = true,
+		},
+	}
+};
+
+
+static void dcn42b_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
+{
+	uint32_t clock_source;
+
+	clock_source = (REG_READ(CLK5_CLK2_BYPASS_CNTL) & CLK5_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK);
+	// If it's DFS mode, clock_source is 0.
+	if (dcn42_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(dcn42_ss_info_table.ss_percentage))) {
+		clk_mgr->dprefclk_ss_percentage = dcn42_ss_info_table.ss_percentage[clock_source];
+
+		if (clk_mgr->dprefclk_ss_percentage != 0) {
+			clk_mgr->ss_on_dprefclk = true;
+			clk_mgr->dprefclk_ss_divider = dcn42_ss_info_table.ss_divider;
+		}
+	}
+}
+
+uint32_t dcn42b_get_clock_freq_from_clkip(struct clk_mgr *clk_mgr_base, enum clock_type clock)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint64_t clock_freq_mhz = 0;
+	uint32_t timer_threshold = 0;
+
+	// always safer to read the timer threshold instead of using cached value
+	REG_GET(CLK5_CLK_TICK_CNT_CONFIG_REG, TIMER_THRESHOLD, &timer_threshold);
+
+	if (timer_threshold == 0) {
+		BREAK_TO_DEBUGGER();
+		return 0;
+	}
+
+	switch (clock) {
+	case clock_type_dispclk:
+		clock_freq_mhz = REG_READ(CLK5_CLK0_CURRENT_CNT);
+		break;
+	case clock_type_dppclk:
+		clock_freq_mhz = REG_READ(CLK5_CLK1_CURRENT_CNT);
+		break;
+	case clock_type_dprefclk:
+		clock_freq_mhz = REG_READ(CLK5_CLK2_CURRENT_CNT);
+		break;
+	case clock_type_dcfclk:
+		clock_freq_mhz = REG_READ(CLK5_CLK3_CURRENT_CNT);
+		break;
+	case clock_type_dtbclk:
+		/* DTBCLK tied off in DCN42B - CLK5_CLK4 register doesn't exist.
+		 * Should never be called since dtbclk_en is always false.
+		 */
+		ASSERT(false);
+		clock_freq_mhz = 0;
+		break;
+	default:
+		break;
+	}
+
+	clock_freq_mhz *= DCN42_CLKIP_REFCLK;
+	clock_freq_mhz = div_u64(clock_freq_mhz, timer_threshold);
+
+	// there are no DCN clocks over 0xFFFFFFFF MHz
+	ASSERT(clock_freq_mhz <= 0xFFFFFFFF);
+
+	return (uint32_t)clock_freq_mhz;
+}
+
+/* dcn42b_get_dispclk_from_dentist removed: reuse dcn42_get_dispclk_from_dentist.
+ * DENTIST_DISPCLK_CNTL is a DCN register with the same offset on both dcn42 and dcn42b.
+ */
+
+static struct clk_mgr_funcs dcn42b_funcs = {
+	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
+	.update_clocks = dcn42_update_clocks,
+	.init_clocks = dcn42b_init_clocks,
+	.enable_pme_wa = dcn42_enable_pme_wa,
+	.are_clock_states_equal = dcn42_are_clock_states_equal,
+	.notify_wm_ranges = NULL,
+	.set_low_power_state = dcn42_set_low_power_state,
+	.exit_low_power_state = dcn42_exit_low_power_state,
+	.get_max_clock_khz = dcn42_get_max_clock_khz,
+	.get_dispclk_from_dentist = dcn42_get_dispclk_from_dentist,
+	.is_smu_present = dcn42_is_smu_present,
+};
+
+void dcn42b_clk_mgr_construct(
+		struct dc_context *ctx,
+		struct clk_mgr_dcn42 *clk_mgr,
+		struct pp_smu_funcs *pp_smu,
+		struct dccg *dccg)
+{
+	clk_mgr->base.base.ctx = ctx;
+	clk_mgr->base.base.funcs = &dcn42b_funcs;
+	clk_mgr->base.regs = &clk_mgr_regs_dcn42b;
+	clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn42b;
+	clk_mgr->base.clk_mgr_mask = &clk_mgr_mask_dcn42b;
+
+	clk_mgr->base.pp_smu = pp_smu;
+
+	clk_mgr->base.dccg = dccg;
+	clk_mgr->base.dfs_bypass_disp_clk = 0;
+
+	clk_mgr->base.dprefclk_ss_percentage = 0;
+	clk_mgr->base.dprefclk_ss_divider = 1000;
+	clk_mgr->base.ss_on_dprefclk = false;
+	clk_mgr->base.dfs_ref_freq_khz = 48000; /*sync with pmfw*/
+	clk_mgr->base.base.clks.ref_dtbclk_khz = 0;
+
+	/* Changed from DCN3.2_clock_frequency doc to match
+	 * dcn32_dump_clk_registers from 4 * dentist_vco_freq_khz /
+	 * dprefclk DID divider
+	 */
+	clk_mgr->base.base.dprefclk_khz = 600000;
+
+		clk_mgr->base.smu_present = false;
+		clk_mgr->base.smu_ver = dcn42_smu_get_pmfw_version(&clk_mgr->base);
+		if (clk_mgr->base.smu_ver && clk_mgr->base.smu_ver != -1)
+			clk_mgr->base.smu_present = true;
+
+		if (ctx->dc_bios->integrated_info) {
+			clk_mgr->base.base.dentist_vco_freq_khz = ctx->dc_bios->integrated_info->dentist_vco_freq;
+
+			if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
+				dcn42b_bw_params.wm_table = lpddr5_wm_table;
+			else
+				dcn42b_bw_params.wm_table = ddr5_wm_table;
+			dcn42b_bw_params.vram_type = ctx->dc_bios->integrated_info->memory_type;
+			dcn42b_bw_params.dram_channel_width_bytes = ctx->dc_bios->integrated_info->memory_type == 0x22 ? 8 : 4;
+			dcn42b_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 2;
+			if (clk_mgr->base.smu_present)
+				clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
+
+		}
+		/* in case we don't get a value from the BIOS, use default */
+		if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
+			clk_mgr->base.base.dentist_vco_freq_khz = 3000000; /* 3000MHz */
+
+		/* Saved clocks configured at boot for debug purposes */
+		dcn42b_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
+
+	dce_clock_read_ss_info(&clk_mgr->base);
+	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
+
+	dcn42b_read_ss_info_from_lut(&clk_mgr->base);
+
+	clk_mgr->base.base.bw_params = &dcn42b_bw_params;
+	if (clk_mgr->base.smu_present) {
+		dcn42_get_smu_clocks(&clk_mgr->base);
+		//overwrite values from dcn42_get_smu_clocks since dtbclk is tied off in DCN42B
+		clk_mgr->base.base.bw_params->clk_table.entries[0].dtbclk_mhz = 0;
+		clk_mgr->base.base.bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels = 0;
+		clk_mgr->base.base.clks.ref_dtbclk_khz = 0;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
new file mode 100644
index 000000000000..52ab87cdc7b6
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#ifndef __DCN42B_CLK_MGR_H__
+#define __DCN42B_CLK_MGR_H__
+#include "clk_mgr_internal.h"
+#include "dcn42/dcn42_clk_mgr.h"
+
+/* DCN42B reuses the following from DCN42:
+ * - dcn42_update_clocks (dtbclk_en=false so all dtbclk branches are skipped)
+ * - dcn42_get_dispclk_from_dentist (DENTIST_DISPCLK_CNTL has same DCN offset)
+ * - dcn42_get_dpm_table_from_smu (identical, only SMU calls)
+ * - dcn42_are_clock_states_equal
+ * - dcn42_enable_pme_wa
+ * - dcn42_update_clocks_update_dpp_dto
+ * - dcn42_update_clocks_update_dtb_dto
+ * - dcn42_build_watermark_ranges
+ * - dcn42_is_spll_ssc_enabled
+ * - dcn42_has_active_display
+ * - dcn42_notify_wm_ranges
+ * - dcn42_set_low_power_state
+ * - dcn42_exit_low_power_state
+ * - dcn42_get_max_clock_khz
+ * - dcn42_is_smu_present
+ *
+ * CANNOT reuse from DCN42 (hardware register differences):
+ * - dcn42_read_ss_info_from_lut (CLK8 vs CLK5 registers)
+ * - dcn42_dump_clk_registers* (CLK8 vs CLK5 registers)
+ * - dcn42_get_clock_freq_from_clkip (CLK8 vs CLK5 registers)
+ * - dcn42_init_clocks (calls CLK8-specific functions, dtbclk logic)
+ * - init_clk_states (dtbclk_en difference: true for dcn42, false for dcn42b)
+ *
+ * See dcn42_clk_mgr.h for declarations
+ */
+
+#define NUM_CLOCK_SOURCES 5
+
+void dcn42b_init_clocks(struct clk_mgr *clk_mgr);
+
+void dcn42b_clk_mgr_construct(struct dc_context *ctx,
+			      struct clk_mgr_dcn42 *clk_mgr,
+			      struct pp_smu_funcs *pp_smu,
+			      struct dccg *dccg);
+uint32_t dcn42b_get_clock_freq_from_clkip(struct clk_mgr *clk_mgr_base,
+				  enum clock_type clock);
+
+#endif //__DCN42B_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c
new file mode 100644
index 000000000000..181927510c3f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_factory.h"
+
+#include "../hw_gpio.h"
+#include "../hw_ddc.h"
+#include "../hw_hpd.h"
+#include "../hw_generic.h"
+
+#include "dcn/dcn_4_2_1_offset.h"
+#include "dcn/dcn_4_2_1_sh_mask.h"
+#include "dpcs/dpcs_4_0_1_offset.h"
+#include "dpcs/dpcs_4_0_1_sh_mask.h"
+
+#include "reg_helper.h"
+#include "../hpd_regs.h"
+#include "hw_factory_dcn42b.h"
+
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+
+/* DCN */
+#define block HPD
+#define reg_num 0
+
+#undef BASE_INNER
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+#define REG(reg_name) \
+	BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name
+
+#define SF_HPD(reg_name, field_name, post_fix) \
+	.field_name = HPD0_ ## reg_name ## __ ## field_name ## post_fix
+
+#define REGI(reg_name, block, id) \
+	BASE(reg ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
+			reg ## block ## id ## _ ## reg_name
+
+#define SF(reg_name, field_name, post_fix) \
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+/* macros to expend register list macro defined in HW object header file
+ * end *********************/
+
+#undef HPD_REG_LIST
+#define HPD_REG_LIST(id) \
+	.int_status = REGI(DC_HPD_INT_STATUS, HPD, id), \
+	.toggle_filt_cntl = REGI(DC_HPD_TOGGLE_FILT_CNTL, HPD, id)
+
+#define hpd_regs(id) \
+{ \
+	HPD_REG_LIST(id) \
+}
+
+static const struct hpd_registers hpd_regs[] = {
+	hpd_regs(0),
+	hpd_regs(1),
+	hpd_regs(2),
+    //hpd_regs(3),
+    //hpd_regs(4),
+};
+
+static const struct hpd_sh_mask hpd_shift = {
+	HPD_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct hpd_sh_mask hpd_mask = {
+	HPD_MASK_SH_LIST(_MASK)
+};
+
+#include "../ddc_regs.h"
+
+#define SF_DDC(reg_name, field_name, post_fix) \
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+static const struct ddc_registers ddc_data_regs_dcn[] = {
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		DDC_GPIO_VGA_REG_LIST(DATA),
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	}
+};
+
+static const struct ddc_registers ddc_clk_regs_dcn[] = {
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
+	{
+		DDC_GPIO_VGA_REG_LIST(CLK),
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	}
+};
+
+//static const struct ddc_sh_mask ddc_shift[] = {
+	//DDC_MASK_SH_LIST_DCN2(__SHIFT, 1),
+	//DDC_MASK_SH_LIST_DCN2(__SHIFT, 2),
+	//DDC_MASK_SH_LIST_DCN2(__SHIFT, 3),
+	//DDC_MASK_SH_LIST_DCN2(__SHIFT, 4),
+	//DDC_MASK_SH_LIST_DCN2(__SHIFT, 5),
+	//DDC_MASK_SH_LIST_DCN2(__SHIFT, 6),
+	//DDC_MASK_SH_LIST_DCN2_VGA(__SHIFT)
+//};
+
+//static const struct ddc_sh_mask ddc_mask[] = {
+	//DDC_MASK_SH_LIST_DCN2(_MASK, 1),
+	//DDC_MASK_SH_LIST_DCN2(_MASK, 2),
+	//DDC_MASK_SH_LIST_DCN2(_MASK, 3),
+	//DDC_MASK_SH_LIST_DCN2(_MASK, 4),
+	//DDC_MASK_SH_LIST_DCN2(_MASK, 5),
+	//DDC_MASK_SH_LIST_DCN2(_MASK, 6),
+	//DDC_MASK_SH_LIST_DCN2_VGA(_MASK)
+//};
+
+#include "../generic_regs.h"
+
+/* set field name */
+#define SF_GENERIC(reg_name, field_name, post_fix)\
+	.field_name = 0
+
+static const struct generic_registers generic_regs[] = {
+	{{ 0 }},
+	{{ 0 }},
+};
+
+static const struct generic_sh_mask generic_shift[] = {
+	{ 0 },
+	{ 0 },
+};
+
+static const struct generic_sh_mask generic_mask[] = {
+	{ 0 },
+	{ 0 },
+};
+
+static void define_generic_registers(struct hw_gpio_pin *pin, uint32_t en)
+{
+	struct hw_generic *generic = HW_GENERIC_FROM_BASE(pin);
+
+	generic->regs = &generic_regs[en];
+	generic->shifts = &generic_shift[en];
+	generic->masks = &generic_mask[en];
+	generic->base.regs = &generic_regs[en].gpio;
+}
+
+static void define_ddc_registers(
+		struct hw_gpio_pin *pin,
+		uint32_t en)
+{
+	struct hw_ddc *ddc = HW_DDC_FROM_BASE(pin);
+
+	switch (pin->id) {
+	case GPIO_ID_DDC_DATA:
+		ddc->regs = &ddc_data_regs_dcn[en];
+		ddc->base.regs = &ddc_data_regs_dcn[en].gpio;
+		break;
+	case GPIO_ID_DDC_CLOCK:
+		ddc->regs = &ddc_clk_regs_dcn[en];
+		ddc->base.regs = &ddc_clk_regs_dcn[en].gpio;
+		break;
+	default:
+		ASSERT_CRITICAL(false);
+		return;
+	}
+
+	//ddc->shifts = &ddc_shift[en];
+	//ddc->masks = &ddc_mask[en];
+	ddc->shifts = NULL;
+	ddc->masks = NULL;
+
+}
+
+static void define_hpd_registers(struct hw_gpio_pin *pin, uint32_t en)
+{
+	struct hw_hpd *hpd = HW_HPD_FROM_BASE(pin);
+
+	hpd->regs = &hpd_regs[en];
+	hpd->shifts = &hpd_shift;
+	hpd->masks = &hpd_mask;
+	hpd->base.regs = &hpd_regs[en].gpio;
+}
+
+
+/* function table */
+static const struct hw_factory_funcs funcs = {
+	.init_ddc_data = dal_hw_ddc_init,
+	.init_generic = dal_hw_generic_init,
+	.init_hpd = dal_hw_hpd_init,
+	.get_ddc_pin = dal_hw_ddc_get_pin,
+	.get_hpd_pin = dal_hw_hpd_get_pin,
+	.get_generic_pin = dal_hw_generic_get_pin,
+	.define_hpd_registers = define_hpd_registers,
+	.define_ddc_registers = define_ddc_registers,
+	.define_generic_registers = define_generic_registers
+};
+
+/*
+ * dal_hw_factory_dcn42_init
+ *
+ * @brief
+ * Initialize HW factory function pointers and pin info
+ *
+ * @param
+ * struct hw_factory *factory - [out] struct of function pointers
+ */
+void dal_hw_factory_dcn42b_init(struct hw_factory *factory)
+{
+	factory->number_of_pins[GPIO_ID_DDC_DATA] = 1; // VGA
+	factory->number_of_pins[GPIO_ID_DDC_CLOCK] = 1; // VGA
+	factory->number_of_pins[GPIO_ID_GENERIC] = 4;
+	factory->number_of_pins[GPIO_ID_HPD] = 3; // only 3 HPD
+	factory->number_of_pins[GPIO_ID_GPIO_PAD] = 28;
+	factory->number_of_pins[GPIO_ID_VIP_PAD] = 0;
+	factory->number_of_pins[GPIO_ID_SYNC] = 0;
+	factory->number_of_pins[GPIO_ID_GSL] = 0;/*add this*/
+
+	factory->funcs = &funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h
new file mode 100644
index 000000000000..088798ac95a3
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#ifndef __DAL_HW_FACTORY_DCN42B_H__
+#define __DAL_HW_FACTORY_DCN42B_H__
+
+/* Initialize HW factory function pointers and pin info */
+void dal_hw_factory_dcn42b_init(struct hw_factory *factory);
+
+#endif /* __DAL_HW_FACTORY_DCN42B_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.c
new file mode 100644
index 000000000000..89dd9e807a33
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "hw_translate_dcn42b.h"
+
+#include "dm_services.h"
+#include "include/gpio_types.h"
+#include "../hw_translate.h"
+
+#include "dcn/dcn_4_2_1_offset.h"
+#include "dcn/dcn_4_2_1_sh_mask.h"
+#include "dpcs/dpcs_4_0_1_offset.h"
+#include "dpcs/dpcs_4_0_1_sh_mask.h"
+
+#define DCN_BASE__INST0_SEG2                       0x000034C0
+
+#define block HPD
+#define reg_num 0
+
+#undef BASE_INNER
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
+
+#define BASE(seg) BASE_INNER(seg)
+
+#undef REG
+#define REG(reg_name) \
+	BASE(reg ## reg_name ## _BASE_IDX) + reg ## reg_name
+#define SF_HPD(reg_name, field_name, post_fix) \
+	.field_name = reg_name ## __ ## field_name ## post_fix
+
+static bool offset_to_id(
+	uint32_t offset,
+	uint32_t mask,
+	enum gpio_id *id,
+	uint32_t *en)
+{
+	(void)mask;
+	switch (offset) {
+	/* HPD */
+	case REG(HPD0_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_1;
+		return true;
+	case REG(HPD1_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_2;
+		return true;
+	case REG(HPD2_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_3;
+		return true;
+	/* Not in DNC42B
+	case REG(HPD3_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_4;
+		return true;
+	case REG(HPD4_DC_HPD_INT_STATUS):
+		*id = GPIO_ID_HPD;
+		*en = GPIO_HPD_5;
+		return true;
+	case REG(DC_GPIO_DDC1_A):
+		*en = GPIO_DDC_LINE_DDC1;
+		return true;
+	case REG(DC_GPIO_DDC2_A):
+		*en = GPIO_DDC_LINE_DDC2;
+		return true;
+	case REG(DC_GPIO_DDC3_A):
+		*en = GPIO_DDC_LINE_DDC3;
+		return true;
+	case REG(DC_GPIO_DDC4_A):
+		*en = GPIO_DDC_LINE_DDC4;
+		return true;
+	case REG(DC_GPIO_DDC5_A):
+		*en = GPIO_DDC_LINE_DDC5;
+		return true;
+	*/
+	case REG(DC_GPIO_DDCVGA_A):
+		*en = GPIO_DDC_LINE_DDC_VGA;
+		return true;
+	default:
+		//ASSERT_CRITICAL(false);
+		return false;
+	}
+}
+
+static bool id_to_offset(
+	enum gpio_id id,
+	uint32_t en,
+	struct gpio_pin_info *info)
+{
+	bool result = true;
+	switch (id) {
+	case GPIO_ID_DDC_DATA:
+		info->mask = DC_GPIO_DDCVGA_A__DC_GPIO_DDCVGADATA_A_MASK;
+		switch (en) {
+		/* Not in DCN42B
+		case GPIO_DDC_LINE_DDC
+			info->offset = REG(DC_GPIO_DDC1_A);
+			break;
+		case GPIO_DDC_LINE_DDC
+			info->offset = REG(DC_GPIO_DDC2_A);
+			break;
+		case GPIO_DDC_LINE_DDC
+			info->offset = REG(DC_GPIO_DDC3_A);
+			break;
+		case GPIO_DDC_LINE_DDC
+			info->offset = REG(DC_GPIO_DDC4_A);
+			break;
+		case GPIO_DDC_LINE_DDC5:
+			info->offset = REG(DC_GPIO_DDC5_A);
+			break;
+		*/
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = REG(DC_GPIO_DDCVGA_A);
+			break;
+		case GPIO_DDC_LINE_I2C_PAD:
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+		break;
+	case GPIO_ID_DDC_CLOCK:
+		info->mask = DC_GPIO_DDCVGA_A__DC_GPIO_DDCVGACLK_A_MASK;
+		switch (en) {
+		/* Not in DCN42B
+		case GPIO_DDC_LINE_DDC1:
+				info->offset = REG(DC_GPIO_DDC1_A);
+				break;
+		case GPIO_DDC_LINE_DDC2:
+				info->offset = REG(DC_GPIO_DDC2_A);
+				break;
+		case GPIO_DDC_LINE_DDC3:
+				info->offset = REG(DC_GPIO_DDC3_A);
+				break;
+		case GPIO_DDC_LINE_DDC4:
+				info->offset = REG(DC_GPIO_DDC4_A);
+				break;
+		case GPIO_DDC_LINE_DDC5:
+				info->offset = REG(DC_GPIO_DDC5_A);
+				break;
+		*/
+		case GPIO_DDC_LINE_DDC_VGA:
+			info->offset = REG(DC_GPIO_DDCVGA_A);
+			break;
+		case GPIO_DDC_LINE_I2C_PAD:
+		default:
+			ASSERT_CRITICAL(false);
+			result = false;
+		}
+			break;
+	case GPIO_ID_SYNC:
+	case GPIO_ID_VIP_PAD:
+	default:
+		ASSERT_CRITICAL(false);
+		result = false;
+	}
+
+	if (result) {
+		info->offset_y = info->offset + 2;
+		info->offset_en = info->offset + 1;
+		info->offset_mask = info->offset - 1;
+
+		info->mask_y = info->mask;
+		info->mask_en = info->mask;
+		info->mask_mask = info->mask;
+	}
+
+	return result;
+}
+
+/* function table */
+static const struct hw_translate_funcs funcs = {
+	.offset_to_id = offset_to_id,
+	.id_to_offset = id_to_offset,
+};
+
+/*
+ * dal_hw_translate_dcn42b_init
+ *
+ * @brief
+ * Initialize Hw translate function pointers.
+ *
+ * @param
+ * struct hw_translate *tr - [out] struct of function pointers
+ *
+ */
+void dal_hw_translate_dcn42b_init(struct hw_translate *tr)
+{
+	tr->funcs = &funcs;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.h b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.h
new file mode 100644
index 000000000000..7a782f353eae
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#ifndef __DAL_HW_TRANSLATE_DCN42B_H__
+#define __DAL_HW_TRANSLATE_DCN42B_H__
+
+struct hw_translate;
+
+/* Initialize Hw translate function pointers */
+void dal_hw_translate_dcn42b_init(struct hw_translate *tr);
+
+#endif /* __DAL_HW_TRANSLATE_DCN42B_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c
new file mode 100644
index 000000000000..167f2e53e1f4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c
@@ -0,0 +1,238 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "core_types.h"
+#include "resource.h"
+#include "dce/dce_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
+#include "reg_helper.h"
+#include "hubp.h"
+#include "dchubbub.h"
+#include "timing_generator.h"
+#include "opp.h"
+#include "mpc.h"
+#include "dcn42b_hwseq.h"
+
+#define CTX \
+	hws->ctx
+
+#define REG(reg)\
+	hws->regs->reg
+
+#define DC_LOGGER \
+	hws->ctx->logger
+
+#undef FN
+#define FN(reg_name, field_name) \
+	hws->shifts->field_name, hws->masks->field_name
+
+/*
+ * dcn42b_init_pipes - Initialize pipes for dcn42b
+ *
+ * This function is modeled after dcn10_init_pipes but handles the case
+ * where num_timing_generator != num_pipes (e.g., 3 TGs but 4 pipes).
+ *
+ * For dcn42b:
+ * - num_timing_generator = 3
+ * - num_pipes (num_dpp) = 4
+ *
+ * The key difference is that we iterate over timing generators separately
+ * from pipes to avoid accessing timing_generators[i] when i >= num_timing_generator.
+ */
+void dcn42b_init_pipes(struct dc *dc, struct dc_state *context)
+{
+	uint8_t i;
+	struct dce_hwseq *hws = dc->hwseq;
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+	bool can_apply_seamless_boot = false;
+	bool tg_enabled[MAX_PIPES] = {false};
+
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i]->apply_seamless_boot_optimization) {
+			can_apply_seamless_boot = true;
+			break;
+		}
+	}
+
+	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+		struct timing_generator *tg = dc->res_pool->timing_generators[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		/* There is assumption that pipe_ctx is not mapping irregularly
+		 * to non-preferred front end. If pipe_ctx->stream is not NULL,
+		 * we will use the pipe, so don't disable
+		 */
+		if (pipe_ctx->stream != NULL && can_apply_seamless_boot)
+			continue;
+
+		/* Blank controller using driver code instead of
+		 * command table.
+		 */
+		if (tg->funcs->is_tg_enabled(tg)) {
+			if (hws->funcs.init_blank != NULL) {
+				hws->funcs.init_blank(dc, tg);
+				tg->funcs->lock(tg);
+			} else {
+				tg->funcs->lock(tg);
+				tg->funcs->set_blank(tg, true);
+				hwss_wait_for_blank_complete(tg);
+			}
+		}
+	}
+
+	/* Reset det size */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+		struct hubp *hubp = dc->res_pool->hubps[i];
+
+		/* Do not need to reset for seamless boot */
+		if (pipe_ctx->stream != NULL && can_apply_seamless_boot)
+			continue;
+
+		if (hubbub && hubp) {
+			if (hubbub->funcs->program_det_size)
+				hubbub->funcs->program_det_size(hubbub, hubp->inst, 0);
+			if (hubbub->funcs->program_det_segments)
+				hubbub->funcs->program_det_segments(hubbub, hubp->inst, 0);
+		}
+	}
+
+	/* num_opp will be equal to number of mpcc */
+	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		/* Cannot reset the MPC mux if seamless boot */
+		if (pipe_ctx->stream != NULL && can_apply_seamless_boot)
+			continue;
+
+		dc->res_pool->mpc->funcs->mpc_init_single_inst(
+				dc->res_pool->mpc, i);
+	}
+
+	/* initialize DWB pointer to MCIF_WB */
+	for (i = 0; i < dc->res_pool->res_cap->num_dwb; i++)
+		dc->res_pool->dwbc[i]->mcif = dc->res_pool->mcif_wb[i];
+
+	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+		struct timing_generator *tg = dc->res_pool->timing_generators[i];
+		struct hubp *hubp = dc->res_pool->hubps[i];
+		struct dpp *dpp = dc->res_pool->dpps[i];
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		/* There is assumption that pipe_ctx is not mapping irregularly
+		 * to non-preferred front end. If pipe_ctx->stream is not NULL,
+		 * we will use the pipe, so don't disable
+		 */
+		if (can_apply_seamless_boot &&
+			pipe_ctx->stream != NULL &&
+			pipe_ctx->stream_res.tg->funcs->is_tg_enabled(
+				pipe_ctx->stream_res.tg)) {
+			// Enable double buffering for OTG_BLANK no matter if
+			// seamless boot is enabled or not to suppress global sync
+			// signals when OTG blanked. This is to prevent pipe from
+			// requesting data while in PSR.
+			tg->funcs->tg_init(tg);
+			hubp->power_gated = true;
+			tg_enabled[i] = true;
+			continue;
+		}
+
+		/* Disable on the current state so the new one isn't cleared. */
+		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		hubp->funcs->hubp_reset(hubp);
+		dpp->funcs->dpp_reset(dpp);
+
+		pipe_ctx->stream_res.tg = tg;
+		pipe_ctx->pipe_idx = i;
+
+		pipe_ctx->plane_res.hubp = hubp;
+		pipe_ctx->plane_res.dpp = dpp;
+		pipe_ctx->plane_res.mpcc_inst = (uint8_t)dpp->inst;
+		hubp->mpcc_id = dpp->inst;
+		hubp->opp_id = OPP_ID_INVALID;
+		hubp->power_gated = false;
+
+		dc->res_pool->opps[i]->mpc_tree_params.opp_id = dc->res_pool->opps[i]->inst;
+		dc->res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
+		dc->res_pool->opps[i]->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
+		pipe_ctx->stream_res.opp = dc->res_pool->opps[i];
+
+		hws->funcs.plane_atomic_disconnect(dc, context, pipe_ctx);
+
+		if (tg->funcs->is_tg_enabled(tg))
+			tg->funcs->unlock(tg);
+
+		dc->hwss.disable_plane(dc, context, pipe_ctx);
+
+		pipe_ctx->stream_res.tg = NULL;
+		pipe_ctx->plane_res.hubp = NULL;
+
+		if (tg->funcs->is_tg_enabled(tg)) {
+			if (tg->funcs->init_odm)
+				tg->funcs->init_odm(tg);
+		}
+
+		tg->funcs->tg_init(tg);
+	}
+
+	/* Clean up MPC tree */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (tg_enabled[i]) {
+			if (dc->res_pool->opps[i]->mpc_tree_params.opp_list) {
+				if (dc->res_pool->opps[i]->mpc_tree_params.opp_list->mpcc_bot) {
+					int bot_id = dc->res_pool->opps[i]->mpc_tree_params.opp_list->mpcc_bot->mpcc_id;
+
+					if ((bot_id < MAX_MPCC) && (bot_id < MAX_PIPES) && (!tg_enabled[bot_id]))
+						dc->res_pool->opps[i]->mpc_tree_params.opp_list = NULL;
+				}
+			}
+		}
+	}
+
+	/* Power gate DSCs */
+	if (hws->funcs.dsc_pg_control != NULL) {
+		uint32_t num_opps = 0;
+		uint32_t opp_id_src0 = OPP_ID_INVALID;
+		uint32_t opp_id_src1 = OPP_ID_INVALID;
+
+		// Step 1: To find out which OPTC is running & OPTC DSC is ON
+		// We can't use res_pool->res_cap->num_timing_generator to check
+		// Because it records display pipes default setting built in driver,
+		// not display pipes of the current chip.
+		// Some ASICs would be fused display pipes less than the default setting.
+		// In dcnxx_resource_construct function, driver would obatin real information.
+		for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+			uint32_t optc_dsc_state = 0;
+			struct timing_generator *tg = dc->res_pool->timing_generators[i];
+
+			if (tg->funcs->is_tg_enabled(tg)) {
+				if (tg->funcs->get_dsc_status)
+					tg->funcs->get_dsc_status(tg, &optc_dsc_state);
+				// Only one OPTC with DSC is ON, so if we got one result, we would exit this block.
+				// non-zero value is DSC enabled
+				if (optc_dsc_state != 0) {
+					tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
+					break;
+				}
+			}
+		}
+
+		// Step 2: To power down DSC but skip DSC  of running OPTC
+		for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+			struct dcn_dsc_state s  = {0};
+
+			dc->res_pool->dscs[i]->funcs->dsc_read_state(dc->res_pool->dscs[i], &s);
+
+			if ((s.dsc_opp_source == opp_id_src0 || s.dsc_opp_source == opp_id_src1) &&
+				s.dsc_clock_en && s.dsc_fw_en)
+				continue;
+
+			hws->funcs.dsc_pg_control(hws, dc->res_pool->dscs[i]->inst, false);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h
new file mode 100644
index 000000000000..ab1ac6fc720a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h
@@ -0,0 +1,15 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DC_HWSS_DCN42B_H__
+#define __DC_HWSS_DCN42B_H__
+
+#include "dc.h"
+#include "hw_sequencer_private.h"
+
+void dcn42b_init_pipes(struct dc *dc, struct dc_state *context);
+
+#endif /* __DC_HWSS_DCN42B_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c
new file mode 100644
index 000000000000..4210dc7a8eb4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c
@@ -0,0 +1,20 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dcn20/dcn20_hwseq.h"
+#include "dcn42/dcn42_init.h"
+#include "dcn42b_hwseq.h"
+#include "dcn42b_init.h"
+
+void dcn42b_hw_sequencer_init_functions(struct dc *dc)
+{
+	/* Initialize with dcn42 functions first */
+	dcn42_hw_sequencer_init_functions(dc);
+
+	/* Override only init_pipes with dcn42b version */
+	dc->hwseq->funcs.init_pipes = dcn42b_init_pipes;
+
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h
new file mode 100644
index 000000000000..af1d6ff953f5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DC_DCN42B_INIT_H__
+#define __DC_DCN42B_INIT_H__
+
+struct dc;
+
+void dcn42b_hw_sequencer_init_functions(struct dc *dc);
+
+#endif /* __DC_DCN42B_INIT_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
new file mode 100644
index 000000000000..527d17f29f3b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -0,0 +1,2404 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "dc.h"
+
+#include "dcn32/dcn32_init.h"
+#include "dcn42/dcn42_init.h"
+#include "dcn42b/dcn42b_init.h"
+
+#include "resource.h"
+#include "include/irq_service_interface.h"
+
+#include "dcn42b_resource.h"
+#include "dcn20/dcn20_resource.h"
+#include "dcn30/dcn30_resource.h"
+#include "dcn31/dcn31_resource.h"
+#include "dcn32/dcn32_resource.h"
+#include "dcn35/dcn35_resource.h"
+#include "dcn321/dcn321_resource.h"
+#include "dcn401/dcn401_resource.h"
+#include "dcn42/dcn42_resource_fpu.h"
+
+#include "dcn10/dcn10_ipp.h"
+#include "dcn35/dcn35_hubbub.h"
+#include "dcn42/dcn42_hubbub.h"
+#include "dcn401/dcn401_mpc.h"
+#include "dcn42/dcn42_mpc.h"
+#include "dcn35/dcn35_hubp.h"
+#include "dcn42/dcn42_hubp.h"
+#include "irq/dcn42/irq_service_dcn42.h"
+#include "dcn42/dcn42_dpp.h"
+#include "dcn401/dcn401_dsc.h"
+#include "dcn42/dcn42_optc.h"
+#include "dcn20/dcn20_hwseq.h"
+#include "dcn30/dcn30_hwseq.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn35/dcn35_opp.h"
+#include "dcn30/dcn30_vpg.h"
+#include "dcn31/dcn31_vpg.h"
+#include "dcn42/dcn42_dio_stream_encoder.h"
+#include "dcn42/dcn42_pg_cntl.h"
+#include "dcn31/dcn31_hpo_dp_stream_encoder.h"
+#include "dcn31/dcn31_hpo_dp_link_encoder.h"
+#include "dcn32/dcn32_hpo_dp_link_encoder.h"
+#include "dcn42/dcn42_hpo_dp_link_encoder.h"
+#include "dcn31/dcn31_apg.h"
+#include "dcn31/dcn31_dio_link_encoder.h"
+#include "dcn401/dcn401_dio_link_encoder.h"
+#include "dcn10/dcn10_link_encoder.h"
+#include "dcn321/dcn321_dio_link_encoder.h"
+#include "dce/dce_clock_source.h"
+#include "dce/dce_audio.h"
+#include "dce/dce_hwseq.h"
+#include "clk_mgr.h"
+#include "dio/virtual/virtual_stream_encoder.h"
+#include "dml/display_mode_vba.h"
+#include "dcn42/dcn42_dccg.h"
+#include "dcn10/dcn10_resource.h"
+#include "link_service.h"
+#include "dcn31/dcn31_panel_cntl.h"
+
+#include "dcn30/dcn30_dwb.h"
+#include "dcn42/dcn42_mmhubbub.h"
+#include "dcn42/dcn42_dio_link_encoder.h"
+
+#include "dcn/dcn_4_2_1_offset.h"
+#include "dcn/dcn_4_2_1_sh_mask.h"
+#include "dpcs/dpcs_4_0_1_offset.h"
+#include "dpcs/dpcs_4_0_1_sh_mask.h"
+
+#include "reg_helper.h"
+#include "dce/dmub_abm.h"
+#include "dce/dmub_psr.h"
+#include "dce/dmub_replay.h"
+#include "dce/dce_aux.h"
+#include "dce/dce_i2c.h"
+
+#include "dml/dcn30/display_mode_vba_30.h"
+#include "vm_helper.h"
+#include "dcn20/dcn20_vmid.h"
+
+#include "dc_state_priv.h"
+#include "link_enc_cfg.h"
+
+#include "dml2_0/dml2_wrapper.h"
+
+#define DC_LOGGER_INIT(logger)
+
+#define regBIF_BX1_BIOS_SCRATCH_3                                                                       0x003b
+#define regBIF_BX1_BIOS_SCRATCH_3_BASE_IDX                                                              1
+#define regBIF_BX1_BIOS_SCRATCH_6                                                                       0x003e
+#define regBIF_BX1_BIOS_SCRATCH_6_BASE_IDX                                                              1
+
+#define regAPG0_APG_DBG_GEN_CONTROL             0x2075
+#define regAPG0_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG1_APG_DBG_GEN_CONTROL             0x2199
+#define regAPG1_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG2_APG_DBG_GEN_CONTROL             0x22bd
+#define regAPG2_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG3_APG_DBG_GEN_CONTROL             0x23e1
+#define regAPG3_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG4_APG_DBG_GEN_CONTROL             0x2505
+#define regAPG4_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG5_APG_DBG_GEN_CONTROL             0x0915
+#define regAPG5_APG_DBG_GEN_CONTROL_BASE_IDX    3
+#define regAPG6_APG_DBG_GEN_CONTROL             0x3632
+#define regAPG6_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG7_APG_DBG_GEN_CONTROL             0x3706
+#define regAPG7_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG8_APG_DBG_GEN_CONTROL             0x37da
+#define regAPG8_APG_DBG_GEN_CONTROL_BASE_IDX    2
+#define regAPG9_APG_DBG_GEN_CONTROL             0x38ae
+#define regAPG9_APG_DBG_GEN_CONTROL_BASE_IDX    2
+
+enum dcn401_clk_src_array_id {
+	DCN401_CLK_SRC_PLL0,
+	DCN401_CLK_SRC_PLL1,
+	DCN401_CLK_SRC_PLL2,
+	DCN401_CLK_SRC_TOTAL
+};
+
+/* begin
+ * macros to expend register list macro defined in HW object header file
+ */
+
+/* DCN */
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+
+#define BASE(seg) BASE_INNER(seg)
+
+#define SR(reg_name)                                       \
+	REG_STRUCT.reg_name = BASE(reg##reg_name##_BASE_IDX) + \
+						  reg##reg_name
+#define SR_ARR(reg_name, id)                                   \
+	REG_STRUCT[id].reg_name = BASE(reg##reg_name##_BASE_IDX) + \
+							  reg##reg_name
+#define SR_ARR_INIT(reg_name, id, value) \
+	REG_STRUCT[id].reg_name = value
+
+#define SRI(reg_name, block, id)                                         \
+	REG_STRUCT.reg_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+						  reg##block##id##_##reg_name
+
+#define SRI_ARR(reg_name, block, id)                                         \
+	REG_STRUCT[id].reg_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+							  reg##block##id##_##reg_name
+
+/*
+ * Used when a reg_name would otherwise begin with an integer
+ */
+#define SRI_ARR_US(reg_name, block, id)                                   \
+	REG_STRUCT[id].reg_name = BASE(reg##block##id##reg_name##_BASE_IDX) + \
+							  reg##block##id##reg_name
+#define SR_ARR_I2C(reg_name, id) \
+	REG_STRUCT[id - 1].reg_name = BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+#define SRI_ARR_I2C(reg_name, block, id)                                         \
+	REG_STRUCT[id - 1].reg_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+								  reg##block##id##_##reg_name
+
+#define SRI_ARR_ALPHABET(reg_name, block, index, id)                            \
+	REG_STRUCT[index].reg_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+								 reg##block##id##_##reg_name
+
+#define SRI2(reg_name, block, id)                \
+	.reg_name = BASE(reg##reg_name##_BASE_IDX) + \
+				reg##reg_name
+#define SRI2_ARR(reg_name, block, id)                          \
+	REG_STRUCT[id].reg_name = BASE(reg##reg_name##_BASE_IDX) + \
+							  reg##reg_name
+
+#define SRIR(var_name, reg_name, block, id)                    \
+	.var_name = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+				reg##block##id##_##reg_name
+
+#define SRII(reg_name, block, id)                                            \
+	REG_STRUCT.reg_name[id] = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+							  reg##block##id##_##reg_name
+
+#define SRII_ARR_2(reg_name, block, id, inst)                                      \
+	REG_STRUCT[inst].reg_name[id] = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+									reg##block##id##_##reg_name
+
+#define SRII_MPC_RMU(reg_name, block, id)                                  \
+	.RMU##_##reg_name[id] = BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+							reg##block##id##_##reg_name
+
+#define SRII_DWB(reg_name, temp_name, block, id)                              \
+	REG_STRUCT.reg_name[id] = \
+		BASE(reg##block##id##_##temp_name##_BASE_IDX) + \
+							  reg##block##id##_##temp_name
+
+#define DCCG_SRII(reg_name, block, id)                                                 \
+	REG_STRUCT.block##_##reg_name[id] = \
+		BASE(reg##block##id##_##reg_name##_BASE_IDX) + \
+										reg##block##id##_##reg_name
+
+#define SF_DWB2(reg_name, block, id, field_name, post_fix) \
+	.field_name = reg_name##__##field_name##post_fix
+
+#define VUPDATE_SRII(reg_name, block, id)                                    \
+	REG_STRUCT.reg_name[id] = BASE(reg##reg_name##_##block##id##_BASE_IDX) + \
+							  reg##reg_name##_##block##id
+
+/* NBIO */
+#define NBIO_BASE_INNER(seg) ctx->nbio_reg_offsets[seg]
+
+#define NBIO_BASE(seg) \
+	NBIO_BASE_INNER(seg)
+
+#define NBIO_SR(reg_name)                                               \
+	REG_STRUCT.reg_name = NBIO_BASE(regBIF_BX1_##reg_name##_BASE_IDX) + \
+						  regBIF_BX1_##reg_name
+#define NBIO_SR_ARR(reg_name, id)                                           \
+	REG_STRUCT[id].reg_name = NBIO_BASE(regBIF_BX1_##reg_name##_BASE_IDX) + \
+							  regBIF_BX1_##reg_name
+
+#define CTX ctx
+#define REG(reg_name) \
+	(ctx->dcn_reg_offsets[reg##reg_name##_BASE_IDX] + reg##reg_name)
+
+static struct bios_registers bios_regs;
+
+#define bios_regs_init()     \
+	NBIO_SR(BIOS_SCRATCH_3), \
+		NBIO_SR(BIOS_SCRATCH_6)
+
+#define clk_src_regs_init(index, pllid) \
+	CS_COMMON_REG_LIST_DCN42B_RI(index, pllid)
+
+static struct dce110_clk_src_regs clk_src_regs[5];
+
+static const struct dce110_clk_src_shift cs_shift = {
+	CS_COMMON_MASK_SH_LIST_DCN3_2(__SHIFT)
+};
+static const struct dce110_clk_src_mask cs_mask = {
+	CS_COMMON_MASK_SH_LIST_DCN3_2(_MASK)
+};
+#define abm_regs_init(id) \
+	ABM_DCN42B_REG_LIST_RI(id)
+
+static struct dce_abm_registers abm_regs[4];
+
+static const struct dce_abm_shift abm_shift = {
+	ABM_MASK_SH_LIST_DCN42(__SHIFT)};
+
+static const struct dce_abm_mask abm_mask = {
+	ABM_MASK_SH_LIST_DCN42(_MASK)};
+
+#define audio_regs_init(id) \
+	AUD_COMMON_REG_LIST_RI(id)
+
+static struct dce_audio_registers audio_regs[5];
+
+/* DTO2 not present for DCN42b */
+#define DCE120_AUD_COMMON_MASK_SH_LIST(mask_sh)                                             \
+	SF(AZF0ENDPOINT0_AZALIA_F0_CODEC_ENDPOINT_INDEX, AZALIA_ENDPOINT_REG_INDEX, mask_sh),   \
+		SF(AZF0ENDPOINT0_AZALIA_F0_CODEC_ENDPOINT_DATA, AZALIA_ENDPOINT_REG_DATA, mask_sh), \
+		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),                     \
+		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh),                             \
+		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_USE_512FBR_DTO, mask_sh),                 \
+		SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO1_USE_512FBR_DTO, mask_sh),                 \
+		SF(DCCG_AUDIO_DTO0_MODULE, DCCG_AUDIO_DTO0_MODULE, mask_sh),                        \
+		SF(DCCG_AUDIO_DTO0_PHASE, DCCG_AUDIO_DTO0_PHASE, mask_sh),                          \
+		SF(DCCG_AUDIO_DTO1_MODULE, DCCG_AUDIO_DTO1_MODULE, mask_sh),                        \
+		SF(DCCG_AUDIO_DTO1_PHASE, DCCG_AUDIO_DTO1_PHASE, mask_sh),                          \
+		SF(AZALIA_F0_CODEC_FUNCTION_PARAMETER_SUPPORTED_SIZE_RATES, AUDIO_RATE_CAPABILITIES, mask_sh), \
+		SF(AZALIA_F0_CODEC_FUNCTION_PARAMETER_POWER_STATES, CLKSTOP, mask_sh),              \
+		SF(AZALIA_F0_CODEC_FUNCTION_PARAMETER_POWER_STATES, EPSS, mask_sh)
+
+static const struct dce_audio_shift audio_shift = {
+	DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)};
+
+static const struct dce_audio_mask audio_mask = {
+	DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)};
+
+#define vpg_regs_init(id) \
+	VPG_DCN401_REG_LIST_RI(id)
+
+static struct dcn31_vpg_registers vpg_regs[10];
+
+static const struct dcn31_vpg_shift vpg_shift = {
+	DCN31_VPG_MASK_SH_LIST(__SHIFT)};
+
+static const struct dcn31_vpg_mask vpg_mask = {
+	DCN31_VPG_MASK_SH_LIST(_MASK)};
+
+#define apg_regs_init(id) \
+	APG_DCN31_REG_LIST_RI(id)
+
+static struct dcn31_apg_registers apg_regs[10];
+
+static const struct dcn31_apg_shift apg_shift = {
+	DCN42B_APG_MASK_SH_LIST(__SHIFT)};
+
+static const struct dcn31_apg_mask apg_mask = {
+	DCN42B_APG_MASK_SH_LIST(_MASK)};
+
+#define stream_enc_regs_init(id) \
+	SE_DCN42B_REG_LIST_RI(id)
+
+static struct dcn10_stream_enc_registers stream_enc_regs[5];
+
+static const struct dcn10_stream_encoder_shift se_shift = {
+	SE_COMMON_MASK_SH_LIST_DCN42(__SHIFT)};
+
+static const struct dcn10_stream_encoder_mask se_mask = {
+	SE_COMMON_MASK_SH_LIST_DCN42(_MASK)};
+
+#define aux_regs_init(id) \
+	DCN2_AUX_REG_LIST_RI(id)
+
+static struct dcn10_link_enc_aux_registers link_enc_aux_regs[5];
+
+#define hpd_regs_init(id) \
+	HPD_REG_LIST_RI(id)
+
+static struct dcn10_link_enc_hpd_registers link_enc_hpd_regs[5];
+
+#define link_regs_init(id, phyid) \
+	LE_DCN401_REG_LIST_RI(id)
+
+static struct dcn10_link_enc_registers link_enc_regs[5];
+
+static const struct dcn10_link_enc_shift le_shift = {
+	LINK_ENCODER_MASK_SH_LIST_DCN42B(__SHIFT)};
+
+static const struct dcn10_link_enc_mask le_mask = {
+	LINK_ENCODER_MASK_SH_LIST_DCN42B(_MASK)};
+
+#define hpo_dp_stream_encoder_reg_init(id) \
+	DCN42B_HPO_DP_STREAM_ENC_REG_LIST_RI(id)
+
+static struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_regs[4];
+
+static const struct dcn31_hpo_dp_stream_encoder_shift hpo_dp_se_shift = {
+	DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(__SHIFT)};
+
+static const struct dcn31_hpo_dp_stream_encoder_mask hpo_dp_se_mask = {
+	DCN4_2B_HPO_DP_STREAM_ENC_MASK_SH_LIST(_MASK)};
+
+#define hpo_dp_link_encoder_reg_init(id) \
+	DCN42B_HPO_DP_LINK_ENC_REG_LIST_RI(id)
+/*DCN3_1_RDPCSTX_REG_LIST(0),*/
+/*DCN3_1_RDPCSTX_REG_LIST(1),*/
+/*DCN3_1_RDPCSTX_REG_LIST(2),*/
+/*DCN3_1_RDPCSTX_REG_LIST(3),*/
+
+/* DCN42B has 2 HPO DP link encoders */
+static struct dcn31_hpo_dp_link_encoder_registers hpo_dp_link_enc_regs[2];
+
+static const struct dcn31_hpo_dp_link_encoder_shift hpo_dp_le_shift = {
+	DCN3_2_HPO_DP_LINK_ENC_MASK_SH_LIST(__SHIFT)};
+
+static const struct dcn31_hpo_dp_link_encoder_mask hpo_dp_le_mask = {
+	DCN3_2_HPO_DP_LINK_ENC_MASK_SH_LIST(_MASK)};
+
+#define dpp_regs_init(id) \
+	DPP_REG_LIST_DCN42B_COMMON_RI(id)
+
+static struct dcn42_dpp_registers dpp_regs[4];
+
+static const struct dcn42_dpp_shift tf_shift = {
+	DPP_REG_LIST_SH_MASK_DCN42_COMMON(__SHIFT)};
+
+static const struct dcn42_dpp_mask tf_mask = {
+	DPP_REG_LIST_SH_MASK_DCN42_COMMON(_MASK)};
+
+#define opp_regs_init(id) \
+	OPP_REG_LIST_DCN401_RI(id)
+
+static struct dcn20_opp_registers opp_regs[4];
+
+static const struct dcn20_opp_shift opp_shift = {
+	OPP_MASK_SH_LIST_DCN20(__SHIFT)};
+
+static const struct dcn20_opp_mask opp_mask = {
+	OPP_MASK_SH_LIST_DCN20(_MASK)};
+
+#define aux_engine_regs_init(id)                                              \
+	AUX_COMMON_REG_LIST0_RI(id), SR_ARR_INIT(AUXN_IMPCAL, id, 0),             \
+		SR_ARR_INIT(AUXP_IMPCAL, id, 0),                                      \
+		SR_ARR_INIT(AUX_RESET_MASK, id, DP_AUX0_AUX_CONTROL__AUX_RESET_MASK), \
+		SR_ARR_INIT(AUX_RESET_MASK, id, DP_AUX0_AUX_CONTROL__AUX_RESET_MASK)
+
+static struct dce110_aux_registers aux_engine_regs[5];
+
+static const struct dce110_aux_registers_shift aux_shift = {
+	DCN_AUX_MASK_SH_LIST(__SHIFT)};
+
+static const struct dce110_aux_registers_mask aux_mask = {
+	DCN_AUX_MASK_SH_LIST(_MASK)};
+
+#define dwbc_regs_dcn401_init(id) \
+	DWBC_COMMON_REG_LIST_DCN30_RI(id)
+
+static struct dcn30_dwbc_registers dwbc401_regs[1];
+
+static const struct dcn30_dwbc_shift dwbc401_shift = {
+	DWBC_COMMON_MASK_SH_LIST_DCN30(__SHIFT)};
+
+static const struct dcn30_dwbc_mask dwbc401_mask = {
+	DWBC_COMMON_MASK_SH_LIST_DCN30(_MASK)};
+
+#define mcif_wb_regs_dcn3_init(id) \
+	MCIF_WB_COMMON_REG_LIST_DCN3_5_RI(id)
+
+static struct dcn35_mmhubbub_registers mcif_wb35_regs[1];
+
+static const struct dcn35_mmhubbub_shift mcif_wb35_shift = {
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN3_5(__SHIFT)};
+
+static const struct dcn35_mmhubbub_mask mcif_wb35_mask = {
+	MCIF_WB_COMMON_MASK_SH_LIST_DCN3_5(_MASK)};
+
+#define dsc_regs_init(id) \
+	DSC_REG_LIST_DCN401_RI(id)
+
+static struct dcn401_dsc_registers dsc_regs[4];
+
+static const struct dcn401_dsc_shift dsc_shift = {
+	DSC_REG_LIST_SH_MASK_DCN401(__SHIFT)};
+
+static const struct dcn401_dsc_mask dsc_mask = {
+	DSC_REG_LIST_SH_MASK_DCN401(_MASK)};
+
+static struct dcn42_mpc_registers mpc_regs;
+
+#define dcn_mpc_regs_init()                \
+	MPC_REG_LIST_DCN42(0),                 \
+		MPC_REG_LIST_DCN42(1),             \
+		MPC_REG_LIST_DCN42(2),             \
+		MPC_REG_LIST_DCN42(3),             \
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0), \
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1), \
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2), \
+		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3), \
+		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0), \
+		MPC_RMCM_REG_LIST_DCN42(0),		   \
+		MPC_RMCM_REG_LIST_DCN42(1)
+
+static const struct dcn42_mpc_shift mpc_shift = {
+	MPC_COMMON_MASK_SH_LIST_DCN42(__SHIFT)};
+
+static const struct dcn42_mpc_mask mpc_mask = {
+	MPC_COMMON_MASK_SH_LIST_DCN42(_MASK)};
+
+#define optc_regs_init(id) \
+	OPTC_COMMON_REG_LIST_DCN42B_RI(id)
+
+static struct dcn_optc_registers optc_regs[4];
+
+static const struct dcn_optc_shift optc_shift = {
+	OPTC_COMMON_MASK_SH_LIST_DCN42B(__SHIFT)};
+
+static const struct dcn_optc_mask optc_mask = {
+	OPTC_COMMON_MASK_SH_LIST_DCN42B(_MASK)};
+
+#define hubp_regs_init(id) \
+	HUBP_REG_LIST_DCN42B_RI(id)
+
+static struct dcn_hubp2_registers hubp_regs[4];
+
+static const struct dcn_hubp2_shift hubp_shift = {
+	HUBP_MASK_SH_LIST_DCN42B(__SHIFT)};
+
+static const struct dcn_hubp2_mask hubp_mask = {
+	HUBP_MASK_SH_LIST_DCN42B(_MASK)};
+
+static struct dcn_hubbub_registers hubbub_reg;
+
+#define hubbub_reg_init() \
+	HUBBUB_REG_LIST_DCN42B(0)
+
+static const struct dcn_hubbub_shift hubbub_shift = {
+	HUBBUB_MASK_SH_LIST_DCN42B(__SHIFT)};
+
+static const struct dcn_hubbub_mask hubbub_mask = {
+	HUBBUB_MASK_SH_LIST_DCN42B(_MASK)};
+
+static struct dccg_registers dccg_regs;
+
+#define dccg_regs_init() \
+	DCCG_REG_LIST_DCN42B_RI()
+
+static const struct dccg_shift dccg_shift = {
+	DCCG_MASK_SH_LIST_DCN42_COMMON(__SHIFT)};
+
+static const struct dccg_mask dccg_mask = {
+	DCCG_MASK_SH_LIST_DCN42_COMMON(_MASK)};
+
+static struct pg_cntl_registers pg_cntl_regs;
+
+#define pg_cntl_dcn42b_regs_init() \
+	PG_CNTL_REG_LIST_DCN42B()
+
+static const struct pg_cntl_shift pg_cntl_shift = {
+		PG_CNTL_MASK_SH_LIST_DCN42B(__SHIFT)
+};
+
+static const struct pg_cntl_mask pg_cntl_mask = {
+		PG_CNTL_MASK_SH_LIST_DCN42B(_MASK)
+};
+#define SRII2(reg_name_pre, reg_name_post, id)                                                       \
+	.reg_name_pre##_##reg_name_post[id] = \
+		BASE(reg##reg_name_pre##id##_##reg_name_post##_BASE_IDX) + \
+					reg##reg_name_pre##id##_##reg_name_post
+
+/* Not in DCN42B:
+ * SRII(PIXEL_RATE_CNTL, OTG, 3),
+ * SRII(PHYPLL_PIXEL_RATE_CNTL, OTG, 3),
+ * SR(DOMAIN19_PG_CONFIG),
+ * SR(DOMAIN19_PG_STATUS),
+ */
+#define HWSEQ_DCN42B_REG_LIST()                \
+		SR(DCHUBBUB_GLOBAL_TIMER_CNTL),           \
+		SR(DCHUBBUB_ARB_HOSTVM_CNTL), \
+		SR(DIO_MEM_PWR_CTRL),                 \
+		SR(ODM_MEM_PWR_CTRL3),                \
+		SR(MMHUBBUB_MEM_PWR_CNTL),            \
+		SR(DCCG_GATE_DISABLE_CNTL),           \
+		SR(DCCG_GATE_DISABLE_CNTL2),          \
+		SR(DCCG_GATE_DISABLE_CNTL4), \
+		SR(DCCG_GATE_DISABLE_CNTL5), \
+		SR(DCFCLK_CNTL),                      \
+		SR(DC_MEM_GLOBAL_PWR_REQ_CNTL),       \
+		SRII(PIXEL_RATE_CNTL, OTG, 0),        \
+		SRII(PIXEL_RATE_CNTL, OTG, 1),        \
+		SRII(PIXEL_RATE_CNTL, OTG, 2),        \
+		SRII(PHYPLL_PIXEL_RATE_CNTL, OTG, 0), \
+		SRII(PHYPLL_PIXEL_RATE_CNTL, OTG, 1), \
+		SRII(PHYPLL_PIXEL_RATE_CNTL, OTG, 2), \
+		SR(MICROSECOND_TIME_BASE_DIV),        \
+		SR(MILLISECOND_TIME_BASE_DIV),        \
+		SR(DISPCLK_FREQ_CHANGE_CNTL),         \
+		SR(RBBMIF_TIMEOUT_DIS),               \
+		SR(RBBMIF_TIMEOUT_DIS_2),             \
+		SR(DCHUBBUB_CRC_CTRL),                \
+		SR(DPP_TOP0_DPP_CRC_CTRL),            \
+		SR(DPP_TOP0_DPP_CRC_VAL_R),           \
+		SR(DPP_TOP0_DPP_CRC_VAL_G),           \
+		SR(DPP_TOP0_DPP_CRC_VAL_B),           \
+		SR(DPP_TOP0_DPP_CRC_VAL_A),           \
+		SR(MPC_CRC_CTRL),                     \
+		SR(MPC_CRC_RESULT_R),                 \
+		SR(MPC_CRC_RESULT_G),                 \
+		SR(MPC_CRC_RESULT_B),                 \
+		SR(MPC_CRC_RESULT_A),                 \
+		SR(DOMAIN0_PG_CONFIG),                \
+		SR(DOMAIN1_PG_CONFIG),                \
+		SR(DOMAIN2_PG_CONFIG),                \
+		SR(DOMAIN3_PG_CONFIG),                \
+		SR(DOMAIN16_PG_CONFIG),               \
+		SR(DOMAIN17_PG_CONFIG),               \
+		SR(DOMAIN18_PG_CONFIG),               \
+		SR(DOMAIN22_PG_CONFIG),               \
+		SR(DOMAIN23_PG_CONFIG),               \
+		SR(DOMAIN24_PG_CONFIG),               \
+		SR(DOMAIN25_PG_CONFIG),               \
+		SR(DOMAIN26_PG_CONFIG),               \
+		SR(DOMAIN0_PG_STATUS),                \
+		SR(DOMAIN1_PG_STATUS),                \
+		SR(DOMAIN2_PG_STATUS),                \
+		SR(DOMAIN3_PG_STATUS),                \
+		SR(DOMAIN16_PG_STATUS),               \
+		SR(DOMAIN17_PG_STATUS),               \
+		SR(DOMAIN18_PG_STATUS),               \
+		SR(DOMAIN22_PG_STATUS),               \
+		SR(DOMAIN23_PG_STATUS),               \
+		SR(DOMAIN24_PG_STATUS),               \
+		SR(DOMAIN25_PG_STATUS),               \
+		SR(DOMAIN26_PG_STATUS),               \
+		SR(DC_IP_REQUEST_CNTL),               \
+		SR(AZALIA_AUDIO_DTO),                 \
+		SR(HPO_TOP_HW_CONTROL),               \
+		SR(AZALIA_CONTROLLER_CLOCK_GATING),   \
+		SR(DMU_CLK_CNTL)
+
+static struct dce_hwseq_registers hwseq_reg;
+
+#define hwseq_reg_init() \
+	HWSEQ_DCN42B_REG_LIST()
+
+/*	Not in DCN42B
+	HWS_SF(, DOMAIN19_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh), \
+	HWS_SF(, DOMAIN19_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh), \
+	HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
+	HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN_DESIRED_PWR_STATE, mask_sh), \
+	HWS_SF(, DMU_CLK_CNTL, DPIACLK_ALLOW_DS_CLKSTOP, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK0_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK1_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK2_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK3_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK4_GATE_DISABLE, mask_sh), \
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK5_GATE_DISABLE, mask_sh), \
+ */
+#define HWSEQ_DCN42B_MASK_SH_LIST(mask_sh)                                            \
+	HWSEQ_DCN_MASK_SH_LIST(mask_sh),                                                 \
+		HWS_SF(, DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, mask_sh), \
+		HWS_SF(, DCHUBBUB_ARB_HOSTVM_CNTL, DISABLE_HOSTVM_FORCE_ALLOW_PSTATE, mask_sh), \
+		HWS_SF(, DOMAIN0_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                  \
+		HWS_SF(, DOMAIN0_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                     \
+		HWS_SF(, DOMAIN1_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                  \
+		HWS_SF(, DOMAIN1_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                     \
+		HWS_SF(, DOMAIN2_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                  \
+		HWS_SF(, DOMAIN2_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                     \
+		HWS_SF(, DOMAIN3_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                  \
+		HWS_SF(, DOMAIN3_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                     \
+		HWS_SF(, DOMAIN16_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN16_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN17_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN17_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN18_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN18_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN22_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN23_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN23_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN24_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN24_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN25_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN25_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN26_PG_CONFIG, DOMAIN_POWER_FORCEON, mask_sh),                 \
+		HWS_SF(, DOMAIN26_PG_CONFIG, DOMAIN_POWER_GATE, mask_sh),                    \
+		HWS_SF(, DOMAIN0_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),               \
+		HWS_SF(, DOMAIN1_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),               \
+		HWS_SF(, DOMAIN2_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),               \
+		HWS_SF(, DOMAIN3_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),               \
+		HWS_SF(, DOMAIN16_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DOMAIN17_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DOMAIN22_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DOMAIN23_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DOMAIN24_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DOMAIN25_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DOMAIN26_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh),              \
+		HWS_SF(, DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh),                        \
+		HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh),                \
+		HWS_SF(, HPO_TOP_HW_CONTROL, HPO_IO_EN, mask_sh),                            \
+		HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_UNASSIGNED_PWR_MODE, mask_sh),           \
+		HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh), \
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh), \
+		HWS_SF(, DMU_CLK_CNTL, DISPCLK_R_DMU_GATE_DIS, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, DISPCLK_G_RBBMIF_GATE_DIS, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, RBBMIF_FGCG_REP_DIS, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, DPREFCLK_ALLOW_DS_CLKSTOP, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, DISPCLK_ALLOW_DS_CLKSTOP, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, DPPCLK_ALLOW_DS_CLKSTOP, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, DTBCLK_ALLOW_DS_CLKSTOP, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, DCFCLK_ALLOW_DS_CLKSTOP, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, LONO_FGCG_REP_DIS, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, LONO_DISPCLK_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, LONO_SOCCLK_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DMU_CLK_CNTL, LONO_DMCUBCLK_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKA_FE_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKB_FE_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKC_FE_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKD_FE_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKE_FE_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKA_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKB_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKC_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKD_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, SYMCLKE_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P3_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK0_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK1_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK2_GATE_DISABLE, mask_sh),\
+		HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_GATE_DISABLE, mask_sh)
+
+static const struct dce_hwseq_shift hwseq_shift = {
+	HWSEQ_DCN42B_MASK_SH_LIST(__SHIFT)};
+
+static const struct dce_hwseq_mask hwseq_mask = {
+	HWSEQ_DCN42B_MASK_SH_LIST(_MASK)};
+
+#define vmid_regs_init(id) \
+	DCN20_VMID_REG_LIST_RI(id)
+
+static struct dcn_vmid_registers vmid_regs[16];
+
+static const struct dcn20_vmid_shift vmid_shifts = {
+	DCN20_VMID_MASK_SH_LIST(__SHIFT)};
+
+static const struct dcn20_vmid_mask vmid_masks = {
+	DCN20_VMID_MASK_SH_LIST(_MASK)};
+
+static const struct resource_caps res_cap_dcn42b = {
+	.num_timing_generator = 3,
+	.num_opp = 3,
+	.num_dpp = 4,
+	.num_video_plane = 4,
+	.num_audio = 4,
+	.num_stream_encoder = 3,
+	.num_dig_link_enc = 3,
+	// .num_usb4_dpia = 6,
+	.num_hpo_dp_stream_encoder = 3,
+	.num_hpo_dp_link_encoder = 2,
+	.num_pll = 3,
+	.num_dwb = 1,
+	.num_ddc = 0,
+	.num_vmid = 16,
+	.num_mpc_3dlut = 2,
+	.num_dsc = 3,
+	.num_rmcm = 2,
+	.num_mpc = 4,
+	.num_aux = 3,
+};
+
+static const struct dc_plane_cap plane_cap = {
+	.type = DC_PLANE_TYPE_DCN_UNIVERSAL,
+	.per_pixel_alpha = true,
+
+	.pixel_format_support = {
+		.argb8888 = true,
+		.nv12 = true,
+		.fp16 = true,
+		.p010 = true,
+		.ayuv = false,
+	},
+
+	.max_upscale_factor = {.argb8888 = 16000, .nv12 = 16000, .fp16 = 16000},
+
+	// 6:1 downscaling ratio: 1000/6 = 166.666
+	.max_downscale_factor = {.argb8888 = 167, .nv12 = 167, .fp16 = 167},
+
+	.min_width = 64,
+	.min_height = 64};
+
+static const struct dc_debug_options debug_defaults_drv = {
+	.disable_dmcu = true,
+	.force_abm_enable = false,
+	.clock_trace = true,
+	.disable_pplib_clock_request = false,
+	.disable_dpp_power_gate = true,
+	.disable_hubp_power_gate = true,
+	.disable_optc_power_gate = true,
+	.pipe_split_policy = MPC_SPLIT_AVOID,
+	.force_single_disp_pipe_split = false,
+	.disable_dcc = DCC_ENABLE,
+	.vsr_support = true,
+	.performance_trace = false,
+	.max_downscale_src_width = 4096, /*up to 4K*/
+	.disable_pplib_wm_range = false,
+	.scl_reset_length10 = true,
+	.sanity_checks = false,
+	.underflow_assert_delay_us = 0xFFFFFFFF,
+	.dwb_fi_phase = -1, // -1 = disable,
+	.dmub_command_table = true,
+	.pstate_enabled = false,
+	.enable_mem_low_power = {
+		.bits = {
+			.vga = false,
+			.i2c = true,
+			.dscl = true,
+			.cm = true,
+			.mpc = true,
+			.optc = true,
+			.vpg = true,
+		}},
+	.root_clock_optimization = {
+		.bits = {
+			.dpp = false,
+			.dsc = false,/*dscclk and dsc pg*/
+			.hdmistream = false,
+			.hdmichar = false,
+			.dpstream = false,
+			.symclk32_se = false,
+			.symclk32_le = false,
+			.symclk_fe = false,
+			.physymclk = false,
+			.dpiasymclk = false,
+		}
+	},
+	.seamless_boot_odm_combine = DML_FAIL_SOURCE_PIXEL_FORMAT,
+	.enable_z9_disable_interface = false, /* Allow support for the PMFW interface for disable Z9*/
+	.minimum_z8_residency_time = 1, /* Always allow when other conditions are met */
+	.support_eDP1_5 = true,
+	.use_max_lb = true,
+	.force_disable_subvp = false,
+	.exit_idle_opt_for_cursor_updates = true,
+	.using_dml2 = true,
+	.using_dml21 = true,
+	.enable_single_display_2to1_odm_policy = true,
+
+	// must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
+	.enable_double_buffered_dsc_pg_support = true,
+	.enable_dp_dig_pixel_rate_div_policy = 1,
+	.allow_sw_cursor_fallback = false,
+	.psp_disabled_wa = true,
+	.alloc_extra_way_for_cursor = true,
+	.min_prefetch_in_strobe_ns = 60000, // 60us
+	.disable_unbounded_requesting = false,
+	.dcc_meta_propagation_delay_us = 10,
+	.disable_timeout = true,
+	.min_disp_clk_khz = 50000,
+	.static_screen_wait_frames = 2,
+	.disable_z10 = true,
+	.ignore_pg = true,
+	.disable_stutter_for_wm_program = true,
+	.min_deep_sleep_dcfclk_khz = 8000,
+	.replay_skip_crtc_disabled = true,
+	.psr_skip_crtc_disable = true,
+};
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = false,
+};
+
+static struct dce_aux *dcn42b_aux_engine_create(
+	struct dc_context *ctx,
+	uint32_t inst)
+{
+	struct aux_engine_dce110 *aux_engine =
+		kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
+
+	if (!aux_engine)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT aux_engine_regs
+	aux_engine_regs_init(0),
+		aux_engine_regs_init(1),
+		aux_engine_regs_init(2);
+		/* Not in DCN42B:
+		 * aux_engine_regs_init(3),
+		 * aux_engine_regs_init(4);
+		*/
+	dce110_aux_engine_construct(aux_engine, ctx, inst,
+								SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,
+								&aux_engine_regs[inst],
+								&aux_mask,
+								&aux_shift,
+								ctx->dc->caps.extended_aux_timeout_support);
+
+	return &aux_engine->base;
+}
+
+#define i2c_inst_regs_init(id) \
+	I2C_HW_ENGINE_COMMON_REG_LIST_DCN30_RI(id)
+
+static struct dce_i2c_registers i2c_hw_regs[5];
+
+static const struct dce_i2c_shift i2c_shifts = {
+	I2C_COMMON_MASK_SH_LIST_DCN35(__SHIFT)
+};
+static const struct dce_i2c_mask i2c_masks = {
+	I2C_COMMON_MASK_SH_LIST_DCN35(_MASK)
+};
+
+/* ========================================================== */
+
+/*
+ * DPIA index | Preferred Encoder     |    Host Router
+ *   0        |      C                |       0
+ *   1        |      First Available  |       0
+ *   2        |      D                |       1
+ *   3        |      First Available  |       1
+ *   4        |      E                |       2
+ *   5        |      First Available  |       2
+ */
+/* ========================================================== */
+/* DPIA is not included in DCN42B */
+/*
+static const enum engine_id dpia_to_preferred_enc_id_table[] = {
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGD,
+		ENGINE_ID_DIGD,
+		ENGINE_ID_DIGE,
+		ENGINE_ID_DIGE
+};
+
+static enum engine_id dcn42b_get_preferred_eng_id_dpia(unsigned int dpia_index)
+{
+	return dpia_to_preferred_enc_id_table[dpia_index];
+}
+*/
+
+static struct dce_i2c_hw *dcn42b_i2c_hw_create(
+	struct dc_context *ctx,
+	uint32_t inst)
+{
+	struct dce_i2c_hw *dce_i2c_hw =
+		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
+
+	if (!dce_i2c_hw)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT i2c_hw_regs
+	i2c_inst_regs_init(1);
+	/* Not in DCN42B:
+	 * i2c_inst_regs_init(2),
+	 * i2c_inst_regs_init(3),
+	 * i2c_inst_regs_init(4),
+	 * i2c_inst_regs_init(5);
+	 */
+	dcn2_i2c_hw_construct(dce_i2c_hw, ctx, inst,
+						  &i2c_hw_regs[inst], &i2c_shifts, &i2c_masks);
+
+	return dce_i2c_hw;
+}
+
+static struct clock_source *dcn42b_clock_source_create(
+	struct dc_context *ctx,
+	struct dc_bios *bios,
+	enum clock_source_id id,
+	const struct dce110_clk_src_regs *regs,
+	bool dp_clk_src)
+{
+	struct dce110_clk_src *clk_src =
+		kzalloc(sizeof(struct dce110_clk_src), GFP_KERNEL);
+
+	if (!clk_src)
+		return NULL;
+
+	if (dcn401_clk_src_construct(clk_src, ctx, bios, id,
+								 regs, &cs_shift, &cs_mask)) {
+		clk_src->base.dp_clk_src = dp_clk_src;
+		return &clk_src->base;
+	}
+
+	kfree(clk_src);
+	BREAK_TO_DEBUGGER();
+	return NULL;
+}
+
+static struct hubbub *dcn42b_hubbub_create(struct dc_context *ctx)
+{
+	int i;
+
+	struct dcn20_hubbub *hubbub3 = kzalloc(sizeof(struct dcn20_hubbub),
+					  GFP_KERNEL);
+
+	if (!hubbub3)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT hubbub_reg
+	hubbub_reg_init();
+
+#undef REG_STRUCT
+#define REG_STRUCT vmid_regs
+	vmid_regs_init(0),
+		vmid_regs_init(1),
+		vmid_regs_init(2),
+		vmid_regs_init(3),
+		vmid_regs_init(4),
+		vmid_regs_init(5),
+		vmid_regs_init(6),
+		vmid_regs_init(7),
+		vmid_regs_init(8),
+		vmid_regs_init(9),
+		vmid_regs_init(10),
+		vmid_regs_init(11),
+		vmid_regs_init(12),
+		vmid_regs_init(13),
+		vmid_regs_init(14),
+		vmid_regs_init(15);
+
+	hubbub42_construct(hubbub3, ctx,
+					   &hubbub_reg,
+					   &hubbub_shift,
+					   &hubbub_mask,
+					   DCN42_DEFAULT_DET_SIZE,
+					   8,
+					   DCN42_CRB_SIZE_KB);
+	for (i = 0; i < res_cap_dcn42b.num_vmid; i++) {
+		struct dcn20_vmid *vmid = &hubbub3->vmid[i];
+
+		vmid->ctx = ctx;
+
+		vmid->regs = &vmid_regs[i];
+		vmid->shifts = &vmid_shifts;
+		vmid->masks = &vmid_masks;
+	}
+
+	return &hubbub3->base;
+}
+
+static struct hubp *dcn42b_hubp_create(
+	struct dc_context *ctx,
+	uint32_t inst)
+{
+	struct dcn20_hubp *hubp2 =
+		kzalloc(sizeof(struct dcn20_hubp), GFP_KERNEL);
+
+	if (!hubp2)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT hubp_regs
+	hubp_regs_init(0),
+		hubp_regs_init(1),
+		hubp_regs_init(2),
+		hubp_regs_init(3);
+
+	if (hubp42_construct(hubp2, ctx, inst,
+						 &hubp_regs[inst], &hubp_shift, &hubp_mask))
+		return &hubp2->base;
+
+	BREAK_TO_DEBUGGER();
+	kfree(hubp2);
+	return NULL;
+}
+static const struct dc_panel_config dcn42b_panel_config_defaults = {
+	.psr = {
+		.disable_psr = true,
+		.disallow_psrsu = true,
+		.disallow_replay = true,
+	},
+	.ilr = {
+		.optimize_edp_link_rate = true,
+	},
+};
+
+static void dcn42b_dpp_destroy(struct dpp **dpp)
+{
+	kfree(TO_DCN42_DPP(*dpp));
+	*dpp = NULL;
+}
+
+static struct dpp *dcn42b_dpp_create(
+	struct dc_context *ctx,
+	uint32_t inst)
+{
+	struct dcn42_dpp *dpp42b =
+		kzalloc(sizeof(struct dcn42_dpp), GFP_KERNEL);
+
+	if (!dpp42b)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT dpp_regs
+	dpp_regs_init(0),
+		dpp_regs_init(1),
+		dpp_regs_init(2),
+		dpp_regs_init(3);
+
+	if (dpp42_construct(dpp42b, ctx, inst,
+						&dpp_regs[inst], &tf_shift, &tf_mask))
+		return &dpp42b->base;
+
+	BREAK_TO_DEBUGGER();
+	kfree(dpp42b);
+	return NULL;
+}
+
+static struct mpc *dcn42b_mpc_create(
+	struct dc_context *ctx,
+	int num_mpcc,
+	int num_rmu)
+{
+	struct dcn42_mpc *mpc42b = kzalloc(sizeof(struct dcn42_mpc),
+										GFP_KERNEL);
+
+	if (!mpc42b)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT mpc_regs
+	dcn_mpc_regs_init();
+
+	dcn42_mpc_construct(mpc42b, ctx,
+						 &mpc_regs,
+						 &mpc_shift,
+						 &mpc_mask,
+						 num_mpcc,
+						 num_rmu);
+
+	return &mpc42b->base;
+}
+
+static struct output_pixel_processor *dcn42b_opp_create(
+	struct dc_context *ctx, uint32_t inst)
+{
+	struct dcn20_opp *opp4 =
+		kzalloc(sizeof(struct dcn20_opp), GFP_KERNEL);
+
+	if (!opp4) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+#undef REG_STRUCT
+#define REG_STRUCT opp_regs
+	opp_regs_init(0),
+		opp_regs_init(1),
+		opp_regs_init(2);
+		//DCN42B has 3 OPP Pipes
+		//opp_regs_init(3);
+	dcn20_opp_construct(opp4, ctx, inst,
+						&opp_regs[inst], &opp_shift, &opp_mask);
+	return &opp4->base;
+}
+
+static struct timing_generator *dcn42b_timing_generator_create(
+	struct dc_context *ctx,
+	uint32_t instance)
+{
+	struct optc *tgn10 =
+		kzalloc(sizeof(struct optc), GFP_KERNEL);
+
+	if (!tgn10)
+		return NULL;
+#undef REG_STRUCT
+#define REG_STRUCT optc_regs
+	optc_regs_init(0),
+		optc_regs_init(1),
+		optc_regs_init(2);
+		//optc_regs_init(3);
+	tgn10->base.inst = instance;
+	tgn10->base.ctx = ctx;
+
+	tgn10->tg_regs = &optc_regs[instance];
+	tgn10->tg_shift = &optc_shift;
+	tgn10->tg_mask = &optc_mask;
+
+	dcn42_timing_generator_init(tgn10);
+
+	return &tgn10->base;
+}
+
+static const struct encoder_feature_support link_enc_feature = {
+	.max_hdmi_deep_color = COLOR_DEPTH_121212,
+	.max_hdmi_pixel_clock = 600000,
+	.hdmi_ycbcr420_supported = true,
+	.dp_ycbcr420_supported = true,
+	.fec_supported = true,
+	.flags.bits.IS_HBR2_CAPABLE = true,
+	.flags.bits.IS_HBR3_CAPABLE = true,
+	.flags.bits.IS_TPS3_CAPABLE = true,
+	.flags.bits.IS_TPS4_CAPABLE = true};
+
+static struct link_encoder *dcn42b_link_encoder_create(
+	struct dc_context *ctx,
+	const struct encoder_init_data *enc_init_data)
+{
+	struct dcn20_link_encoder *enc20 =
+		kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
+
+	if (!enc20 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT link_enc_aux_regs
+	aux_regs_init(0),
+		aux_regs_init(1),
+		aux_regs_init(2);
+		/*
+		 * Not included in DCN42B:
+		 * aux_regs_init(3),
+		 * aux_regs_init(4);
+		 */
+#undef REG_STRUCT
+#define REG_STRUCT link_enc_hpd_regs
+	hpd_regs_init(0),
+		hpd_regs_init(1),
+		hpd_regs_init(2);
+		/*
+		 * Not included in DCN42B:
+		 * hpd_regs_init(3),
+		 * hpd_regs_init(4);
+		 */
+#undef REG_STRUCT
+#define REG_STRUCT link_enc_regs
+	link_regs_init(0, A),
+		link_regs_init(1, B),
+		link_regs_init(2, C);
+		/*
+		 * Not included in DCN42B:
+		 * link_regs_init(3, D),
+		 * link_regs_init(4, E);
+		 */
+
+	dcn42_link_encoder_construct(enc20,
+								  enc_init_data,
+								  &link_enc_feature,
+								  &link_enc_regs[enc_init_data->transmitter],
+								  &link_enc_aux_regs[enc_init_data->channel - 1],
+								  &link_enc_hpd_regs[enc_init_data->hpd_source],
+								  &le_shift,
+								  &le_mask);
+	return &enc20->enc10.base;
+}
+
+static void read_dce_straps(
+	struct dc_context *ctx,
+	struct resource_straps *straps)
+{
+	generic_reg_get(ctx, regDC_PINSTRAPS + BASE(regDC_PINSTRAPS_BASE_IDX),
+		FN(DC_PINSTRAPS, DC_PINSTRAPS_AUDIO), &straps->dc_pinstraps_audio);
+}
+
+static struct audio *dcn42b_create_audio(
+	struct dc_context *ctx, unsigned int inst)
+{
+
+#undef REG_STRUCT
+#define REG_STRUCT audio_regs
+	audio_regs_init(0),
+		audio_regs_init(1),
+		audio_regs_init(2),
+		audio_regs_init(3),
+		audio_regs_init(4);
+
+	return dce_audio_create(ctx, inst,
+							&audio_regs[inst], &audio_shift, &audio_mask);
+}
+
+static struct vpg *dcn42b_vpg_create(
+	struct dc_context *ctx,
+	uint32_t inst)
+{
+	struct dcn31_vpg *vpg4 = kzalloc(sizeof(struct dcn31_vpg), GFP_KERNEL);
+
+	if (!vpg4)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT vpg_regs
+	vpg_regs_init(0),
+		vpg_regs_init(1),
+		vpg_regs_init(2),
+		vpg_regs_init(3),
+		vpg_regs_init(4),
+		vpg_regs_init(5),
+		vpg_regs_init(6),
+		vpg_regs_init(7),
+		vpg_regs_init(8),
+		vpg_regs_init(9);
+	vpg31_construct(vpg4, ctx, inst,
+					&vpg_regs[inst],
+					&vpg_shift,
+					&vpg_mask);
+
+	return &vpg4->base;
+}
+
+static struct apg *dcn42b_apg_create(
+	struct dc_context *ctx,
+	uint32_t inst)
+{
+	struct dcn31_apg *apg31 = kzalloc(sizeof(struct dcn31_apg), GFP_KERNEL);
+
+	if (!apg31)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT apg_regs
+	apg_regs_init(0),
+	apg_regs_init(1),
+	apg_regs_init(2),
+	apg_regs_init(3),
+	apg_regs_init(4),
+	apg_regs_init(5),
+	apg_regs_init(6),
+	apg_regs_init(7),
+	apg_regs_init(8),
+	apg_regs_init(9);
+
+	apg31_construct(apg31, ctx, inst,
+					&apg_regs[inst],
+					&apg_shift,
+					&apg_mask);
+
+	return &apg31->base;
+}
+
+static struct stream_encoder *dcn42b_stream_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn10_stream_encoder *enc1;
+	struct vpg *vpg;
+	struct apg *apg;
+
+	uint32_t vpg_inst;
+	uint32_t apg_inst;
+
+	/* Mapping of VPG, DME register blocks to DIO block instance */
+	if (eng_id <= ENGINE_ID_DIGF) {
+		vpg_inst = eng_id;
+		apg_inst = eng_id;
+	} else
+		return NULL;
+
+	enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
+	vpg = dcn42b_vpg_create(ctx, vpg_inst);
+	apg = dcn42b_apg_create(ctx, apg_inst);
+
+	if (!enc1 || !vpg || !apg) {
+		kfree(enc1);
+		kfree(vpg);
+		kfree(apg);
+		return NULL;
+	}
+#undef REG_STRUCT
+#define REG_STRUCT stream_enc_regs
+	stream_enc_regs_init(0),
+		stream_enc_regs_init(1),
+		stream_enc_regs_init(2);
+		/*
+		 * stream_enc_regs_init(3),
+		 * stream_enc_regs_init(4);
+		 */
+
+	dcn42_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
+									eng_id, vpg, apg,
+									&stream_enc_regs[eng_id],
+									&se_shift, &se_mask);
+	return &enc1->base;
+}
+
+static struct hpo_dp_stream_encoder *dcn42b_hpo_dp_stream_encoder_create(
+	enum engine_id eng_id,
+	struct dc_context *ctx)
+{
+	struct dcn31_hpo_dp_stream_encoder *hpo_dp_enc31;
+	struct vpg *vpg;
+	struct apg *apg;
+	uint32_t hpo_dp_inst;
+	uint32_t vpg_inst;
+	uint32_t apg_inst;
+
+	ASSERT((eng_id >= ENGINE_ID_HPO_DP_0) && (eng_id <= ENGINE_ID_HPO_DP_3));
+	hpo_dp_inst = eng_id - ENGINE_ID_HPO_DP_0;
+
+	/* Mapping of VPG register blocks to HPO DP block instance:
+	 * VPG[6] -> HPO_DP[0]
+	 * VPG[7] -> HPO_DP[1]
+	 * VPG[8] -> HPO_DP[2]
+	 * VPG[9] -> HPO_DP[3]
+	 */
+	//specific to DCN42B: regVPG6..regVPG9 are the four HPO DP VPGs
+	vpg_inst = hpo_dp_inst + 6;
+
+	/* Mapping of APG register blocks to HPO DP block instance:
+	 * APG[6] -> HPO_DP[0]
+	 * APG[7] -> HPO_DP[1]
+	 * APG[8] -> HPO_DP[2]
+	 * APG[9] -> HPO_DP[3]
+	 */
+	//specific to DCN42B: APG slots 6..9 correspond to HPO DP encoders 0..3
+	apg_inst = hpo_dp_inst + 6;
+
+	/* allocate HPO stream encoder and create VPG sub-block */
+	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_stream_encoder), GFP_KERNEL);
+	vpg = dcn42b_vpg_create(ctx, vpg_inst);
+	apg = dcn42b_apg_create(ctx, apg_inst);
+
+	if (!hpo_dp_enc31 || !vpg || !apg) {
+		kfree(hpo_dp_enc31);
+		kfree(vpg);
+		kfree(apg);
+		return NULL;
+	}
+
+#undef REG_STRUCT
+#define REG_STRUCT hpo_dp_stream_enc_regs
+	hpo_dp_stream_encoder_reg_init(0),
+		hpo_dp_stream_encoder_reg_init(1),
+		hpo_dp_stream_encoder_reg_init(2);
+		//hpo_dp_stream_encoder_reg_init(3);
+
+	dcn31_hpo_dp_stream_encoder_construct(hpo_dp_enc31, ctx, ctx->dc_bios,
+				hpo_dp_inst, eng_id, vpg, apg,
+				&hpo_dp_stream_enc_regs[hpo_dp_inst],
+				&hpo_dp_se_shift, &hpo_dp_se_mask);
+
+	return &hpo_dp_enc31->base;
+}
+
+static struct hpo_dp_link_encoder *dcn42b_hpo_dp_link_encoder_create(
+	uint8_t inst,
+	struct dc_context *ctx)
+{
+	struct dcn31_hpo_dp_link_encoder *hpo_dp_enc31;
+
+	/* allocate HPO link encoder */
+	hpo_dp_enc31 = kzalloc(sizeof(struct dcn31_hpo_dp_link_encoder), GFP_KERNEL);
+	if (!hpo_dp_enc31)
+		return NULL; /* out of memory */
+
+/* DCN42B has 2 HPO DP link encoders */
+#undef REG_STRUCT
+#define REG_STRUCT hpo_dp_link_enc_regs
+	hpo_dp_link_encoder_reg_init(0),
+	hpo_dp_link_encoder_reg_init(1);
+
+	hpo_dp_link_encoder42_construct(hpo_dp_enc31, ctx, inst,
+				&hpo_dp_link_enc_regs[inst],
+				&hpo_dp_le_shift, &hpo_dp_le_mask);
+
+	return &hpo_dp_enc31->base;
+}
+
+static struct dce_hwseq *dcn42b_hwseq_create(
+	struct dc_context *ctx)
+{
+	struct dce_hwseq *hws = kzalloc(sizeof(struct dce_hwseq), GFP_KERNEL);
+
+#undef REG_STRUCT
+#define REG_STRUCT hwseq_reg
+	hwseq_reg_init();
+
+	if (hws) {
+		hws->ctx = ctx;
+		hws->regs = &hwseq_reg;
+		hws->shifts = &hwseq_shift;
+		hws->masks = &hwseq_mask;
+	}
+
+	return hws;
+}
+
+static const struct resource_create_funcs res_create_funcs = {
+	.read_dce_straps = read_dce_straps,
+	.create_audio = dcn42b_create_audio,
+	.create_stream_encoder = dcn42b_stream_encoder_create,
+	.create_hpo_dp_stream_encoder = dcn42b_hpo_dp_stream_encoder_create,
+	.create_hpo_dp_link_encoder = dcn42b_hpo_dp_link_encoder_create,
+	.create_hwseq = dcn42b_hwseq_create,
+};
+
+static void dcn42b_dsc_destroy(struct display_stream_compressor **dsc)
+{
+	kfree(container_of(*dsc, struct dcn401_dsc, base));
+	*dsc = NULL;
+}
+
+static void dcn42b_resource_destruct(struct dcn42b_resource_pool *pool)
+{
+	unsigned int i;
+
+	for (i = 0; i < pool->base.stream_enc_count; i++) {
+		if (pool->base.stream_enc[i] != NULL) {
+			if (pool->base.stream_enc[i]->vpg != NULL) {
+				kfree(DCN31_VPG_FROM_VPG(pool->base.stream_enc[i]->vpg));
+				pool->base.stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.stream_enc[i]->apg != NULL) {
+				kfree(DCN31_APG_FROM_APG(pool->base.stream_enc[i]->apg));
+				pool->base.stream_enc[i]->apg = NULL;
+			}
+			kfree(DCN10STRENC_FROM_STRENC(pool->base.stream_enc[i]));
+			pool->base.stream_enc[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < pool->base.hpo_dp_stream_enc_count; i++) {
+		if (pool->base.hpo_dp_stream_enc[i] != NULL) {
+			if (pool->base.hpo_dp_stream_enc[i]->vpg != NULL) {
+				kfree(DCN31_VPG_FROM_VPG(pool->base.hpo_dp_stream_enc[i]->vpg));
+				pool->base.hpo_dp_stream_enc[i]->vpg = NULL;
+			}
+			if (pool->base.hpo_dp_stream_enc[i]->apg != NULL) {
+				kfree(DCN31_APG_FROM_APG(pool->base.hpo_dp_stream_enc[i]->apg));
+				pool->base.hpo_dp_stream_enc[i]->apg = NULL;
+			}
+			kfree(DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(pool->base.hpo_dp_stream_enc[i]));
+			pool->base.hpo_dp_stream_enc[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < pool->base.hpo_dp_link_enc_count; i++) {
+		if (pool->base.hpo_dp_link_enc[i] != NULL) {
+			kfree(DCN3_1_HPO_DP_LINK_ENC_FROM_HPO_LINK_ENC(pool->base.hpo_dp_link_enc[i]));
+			pool->base.hpo_dp_link_enc[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dsc; i++) {
+		if (pool->base.dscs[i] != NULL)
+			dcn42b_dsc_destroy(&pool->base.dscs[i]);
+	}
+
+	if (pool->base.mpc != NULL) {
+		kfree(TO_DCN20_MPC(pool->base.mpc));
+		pool->base.mpc = NULL;
+	}
+	if (pool->base.hubbub != NULL) {
+		kfree(TO_DCN20_HUBBUB(pool->base.hubbub));
+		pool->base.hubbub = NULL;
+	}
+	for (i = 0; i < pool->base.pipe_count; i++) {
+		if (pool->base.dpps[i] != NULL)
+			dcn42b_dpp_destroy(&pool->base.dpps[i]);
+
+		if (pool->base.ipps[i] != NULL)
+			pool->base.ipps[i]->funcs->ipp_destroy(&pool->base.ipps[i]);
+
+		if (pool->base.hubps[i] != NULL) {
+			kfree(TO_DCN20_HUBP(pool->base.hubps[i]));
+			pool->base.hubps[i] = NULL;
+		}
+
+		if (pool->base.irqs != NULL)
+			dal_irq_service_destroy(&pool->base.irqs);
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_aux; i++) {
+		if (pool->base.engines[i] != NULL)
+			dce110_engine_destroy(&pool->base.engines[i]);
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_ddc; i++) {
+		if (pool->base.hw_i2cs[i] != NULL) {
+			kfree(pool->base.hw_i2cs[i]);
+			pool->base.hw_i2cs[i] = NULL;
+		}
+		if (pool->base.sw_i2cs[i] != NULL) {
+			kfree(pool->base.sw_i2cs[i]);
+			pool->base.sw_i2cs[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_opp; i++) {
+		if (pool->base.opps[i] != NULL)
+			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
+		if (pool->base.timing_generators[i] != NULL) {
+			kfree(DCN10TG_FROM_TG(pool->base.timing_generators[i]));
+			pool->base.timing_generators[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_dwb; i++) {
+		if (pool->base.dwbc[i] != NULL) {
+			kfree(TO_DCN30_DWBC(pool->base.dwbc[i]));
+			pool->base.dwbc[i] = NULL;
+		}
+		if (pool->base.mcif_wb[i] != NULL) {
+			kfree(TO_DCN30_MMHUBBUB(pool->base.mcif_wb[i]));
+			pool->base.mcif_wb[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < pool->base.audio_count; i++) {
+		if (pool->base.audios[i])
+			dce_aud_destroy(&pool->base.audios[i]);
+	}
+
+	for (i = 0; i < pool->base.clk_src_count; i++) {
+		if (pool->base.clock_sources[i] != NULL) {
+			dcn20_clock_source_destroy(&pool->base.clock_sources[i]);
+			pool->base.clock_sources[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_mpc_3dlut; i++) {
+		if (pool->base.mpc_lut[i] != NULL) {
+			dc_3dlut_func_release(pool->base.mpc_lut[i]);
+			pool->base.mpc_lut[i] = NULL;
+		}
+		if (pool->base.mpc_shaper[i] != NULL) {
+			dc_transfer_func_release(pool->base.mpc_shaper[i]);
+			pool->base.mpc_shaper[i] = NULL;
+		}
+	}
+
+	if (pool->base.dp_clock_source != NULL) {
+		dcn20_clock_source_destroy(&pool->base.dp_clock_source);
+		pool->base.dp_clock_source = NULL;
+	}
+
+	for (i = 0; i < (unsigned int)pool->base.res_cap->num_timing_generator; i++) {
+		if (pool->base.multiple_abms[i] != NULL)
+			dce_abm_destroy(&pool->base.multiple_abms[i]);
+	}
+
+	if (pool->base.psr != NULL)
+		dmub_psr_destroy(&pool->base.psr);
+
+	if (pool->base.pg_cntl != NULL)
+		dcn_pg_cntl_destroy(&pool->base.pg_cntl);
+	if (pool->base.replay != NULL)
+		dmub_replay_destroy(&pool->base.replay);
+	if (pool->base.dccg != NULL)
+		dcn_dccg_destroy(&pool->base.dccg);
+
+	if (pool->base.oem_device != NULL) {
+		struct dc *dc = pool->base.oem_device->ctx->dc;
+
+		dc->link_srv->destroy_ddc_service(&pool->base.oem_device);
+	}
+}
+
+static void dcn42b_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
+	struct pixel_clk_params *pixel_clk_params = &pipe_ctx->stream_res.pix_clk_params;
+
+	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
+
+	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0)
+		pixel_clk_params->requested_pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+
+	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
+		link_enc = link_enc_cfg_get_link_enc(link);
+	if (link_enc)
+		pixel_clk_params->encoder_object_id = link_enc->id;
+
+	pixel_clk_params->signal_type = pipe_ctx->stream->signal;
+	pixel_clk_params->controller_id = pipe_ctx->stream_res.tg->inst + 1;
+	/* TODO: un-hardcode*/
+
+	/* TODO - DP2.0 HW: calculate requested_sym_clk for UHBR rates */
+
+	pixel_clk_params->requested_sym_clk = LINK_RATE_LOW *
+		LINK_RATE_REF_FREQ_IN_KHZ;
+	pixel_clk_params->flags.ENABLE_SS = 0;
+	pixel_clk_params->color_depth =
+		stream->timing.display_color_depth;
+	pixel_clk_params->flags.DISPLAY_BLANKED = 1;
+	pixel_clk_params->pixel_encoding = stream->timing.pixel_encoding;
+
+	if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
+		pixel_clk_params->color_depth = COLOR_DEPTH_888;
+
+	if (stream->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
+		pixel_clk_params->requested_pix_clk_100hz *= 2;
+	if (dc_is_tmds_signal(stream->signal) &&
+			stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		pixel_clk_params->requested_pix_clk_100hz /= 2;
+
+	pipe_ctx->clock_source->funcs->get_pix_clk_dividers(
+			pipe_ctx->clock_source,
+			&pipe_ctx->stream_res.pix_clk_params,
+			&pipe_ctx->pll_settings);
+
+	pixel_clk_params->dio_se_pix_per_cycle = 1;
+	if (dc_is_tmds_signal(stream->signal) &&
+			stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		pixel_clk_params->dio_se_pix_per_cycle = 2;
+	} else if (dc_is_dp_signal(stream->signal)) {
+		/* round up to nearest power of 2, or max at 8 pixels per cycle */
+		if (pixel_clk_params->requested_pix_clk_100hz > (uint32_t)(4 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
+			pixel_clk_params->dio_se_pix_per_cycle = 8;
+		} else if (pixel_clk_params->requested_pix_clk_100hz > (uint32_t)(2 * stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
+			pixel_clk_params->dio_se_pix_per_cycle = 4;
+		} else if (pixel_clk_params->requested_pix_clk_100hz > (uint32_t)(stream->ctx->dc->clk_mgr->dprefclk_khz * 10)) {
+			pixel_clk_params->dio_se_pix_per_cycle = 2;
+		} else {
+			pixel_clk_params->dio_se_pix_per_cycle = 1;
+		}
+	}
+}
+
+static bool dcn42b_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
+{
+	unsigned int i;
+	uint32_t dwb_count = pool->res_cap->num_dwb;
+
+	for (i = 0; i < dwb_count; i++) {
+		struct dcn30_dwbc *dwbc42 = kzalloc(sizeof(struct dcn30_dwbc),
+											GFP_KERNEL);
+
+		if (!dwbc42) {
+			dm_error("DC: failed to create dwbc42!\n");
+			return false;
+		}
+
+#undef REG_STRUCT
+#define REG_STRUCT dwbc401_regs
+		dwbc_regs_dcn401_init(0);
+
+		dcn30_dwbc_construct(dwbc42, ctx,
+				&dwbc401_regs[i],
+				&dwbc401_shift,
+				&dwbc401_mask,
+				i);
+
+		pool->dwbc[i] = &dwbc42->base;
+	}
+	return true;
+}
+
+static void dcn42b_mmhubbub_init(struct dcn30_mmhubbub *mcif_wb30,
+								struct dc_context *ctx)
+{
+	dcn42_mmhubbub_set_fgcg(
+		mcif_wb30,
+		ctx->dc->debug.enable_fine_grain_clock_gating.bits.mmhubbub);
+}
+
+static bool dcn42b_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
+{
+	unsigned int i;
+	uint32_t pipe_count = pool->res_cap->num_dwb;
+
+	for (i = 0; i < pipe_count; i++) {
+		struct dcn30_mmhubbub *mcif_wb30 = kzalloc(sizeof(struct dcn30_mmhubbub),
+												   GFP_KERNEL);
+
+		if (!mcif_wb30) {
+			dm_error("DC: failed to create mcif_wb30!\n");
+			return false;
+		}
+
+#undef REG_STRUCT
+#define REG_STRUCT mcif_wb35_regs
+		mcif_wb_regs_dcn3_init(0);
+
+		dcn35_mmhubbub_construct(mcif_wb30, ctx,
+					&mcif_wb35_regs[i],
+					&mcif_wb35_shift,
+					&mcif_wb35_mask,
+					i);
+
+		dcn42b_mmhubbub_init(mcif_wb30, ctx);
+
+		pool->mcif_wb[i] = &mcif_wb30->base;
+	}
+	return true;
+}
+
+static struct display_stream_compressor *dcn42b_dsc_create(
+	struct dc_context *ctx, uint32_t inst)
+{
+	struct dcn401_dsc *dsc =
+		kzalloc(sizeof(struct dcn401_dsc), GFP_KERNEL);
+
+	if (!dsc) {
+		BREAK_TO_DEBUGGER();
+		return NULL;
+	}
+
+#undef REG_STRUCT
+#define REG_STRUCT dsc_regs
+	dsc_regs_init(0),
+		dsc_regs_init(1),
+		dsc_regs_init(2);
+		//Not in DCN42B: dsc_regs_init(3);
+
+	dsc401_construct(dsc, ctx, inst, &dsc_regs[inst], &dsc_shift, &dsc_mask);
+	dsc401_set_fgcg(dsc, ctx->dc->debug.enable_fine_grain_clock_gating.bits.dsc);
+
+	dsc->max_image_width = 5760;
+
+	return &dsc->base;
+}
+
+static void dcn42b_destroy_resource_pool(struct resource_pool **pool)
+{
+	struct dcn42b_resource_pool *dcn42b_pool = TO_DCN42B_RES_POOL(*pool);
+
+	dcn42b_resource_destruct(dcn42b_pool);
+	kfree(dcn42b_pool);
+	*pool = NULL;
+}
+
+static struct dc_cap_funcs cap_funcs = {
+	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap};
+
+static void dcn42b_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	(void)bw_params;
+	dc_assert_fp_enabled();
+
+	if (dc->current_state && dc->current_state->bw_ctx.dml2)
+		dml2_reinit(dc, &dc->dml2_options, &dc->current_state->bw_ctx.dml2);
+}
+
+static void dcn42b_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	DC_FP_START();
+	dcn42b_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
+enum dc_status dcn42b_validate_bandwidth(struct dc *dc,
+							  struct dc_state *context,
+							  enum dc_validate_mode validate_mode)
+{
+	bool out = false;
+
+	DC_FP_START();
+
+	out = dml2_validate(dc, context, context->bw_ctx.dml2,
+						validate_mode);
+
+	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING) {
+		/*not required for mode enumeration*/
+		dcn42_decide_zstate_support(dc, context);
+	}
+
+	DC_FP_END();
+
+	return out ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
+}
+void dcn42b_prepare_mcache_programming(struct dc *dc,
+									  struct dc_state *context)
+{
+	if (dc->debug.using_dml21) {
+		DC_FP_START();
+		dml2_prepare_mcache_programming(dc, context,
+			context->power_source == DC_POWER_SOURCE_DC ?
+			context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2);
+		DC_FP_END();
+	}
+}
+/* Create a minimal link encoder object not associated with a particular
+ * physical connector.
+ * resource_funcs.link_enc_create_minimal
+ */
+static struct link_encoder *dcn42b_link_enc_create_minimal(
+		struct dc_context *ctx, enum engine_id eng_id)
+{
+	struct dcn20_link_encoder *enc20;
+
+	if ((unsigned int)(eng_id - ENGINE_ID_DIGA) > ctx->dc->res_pool->res_cap->num_dig_link_enc)
+		return NULL;
+
+	enc20 = kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
+	if (!enc20)
+		return NULL;
+
+	dcn31_link_encoder_construct_minimal(
+			enc20,
+			ctx,
+			&link_enc_feature,
+			&link_enc_regs[eng_id - ENGINE_ID_DIGA],
+			eng_id);
+
+	return &enc20->enc10.base;
+}
+static void dcn42b_get_panel_config_defaults(struct dc_panel_config *panel_config)
+{
+	*panel_config = dcn42b_panel_config_defaults;
+}
+static unsigned int dcn42b_get_max_hw_cursor_size(const struct dc *dc,
+			struct dc_state *state,
+			const struct dc_stream_state *stream)
+{
+	(void)state;
+	(void)stream;
+
+	return dc->caps.max_cursor_size;
+}
+
+static struct resource_funcs dcn42b_res_pool_funcs = {
+	.destroy = dcn42b_destroy_resource_pool,
+	.link_enc_create = dcn42b_link_encoder_create,
+	.link_enc_create_minimal = dcn42b_link_enc_create_minimal,
+	.link_encs_assign = link_enc_cfg_link_encs_assign,
+	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
+	.panel_cntl_create = dcn32_panel_cntl_create,
+	.validate_bandwidth = dcn42b_validate_bandwidth,
+	.calculate_wm_and_dlg = NULL,
+	.populate_dml_pipes = NULL,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
+	.acquire_free_pipe_as_secondary_opp_head = dcn32_acquire_free_pipe_as_secondary_opp_head,
+	.release_pipe = dcn20_release_pipe,
+	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
+	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
+	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
+	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
+	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
+	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
+	.acquire_post_bldn_3dlut = dcn32_acquire_post_bldn_3dlut,
+	.release_post_bldn_3dlut = dcn32_release_post_bldn_3dlut,
+	.update_bw_bounding_box = dcn42b_update_bw_bounding_box,
+	.patch_unknown_plane_state = dcn35_patch_unknown_plane_state,
+	.get_panel_config_defaults = dcn42b_get_panel_config_defaults,
+	//.get_preferred_eng_id_dpia = dcn42b_get_preferred_eng_id_dpia,
+	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
+	.add_phantom_pipes = dcn32_add_phantom_pipes,
+	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
+#ifdef CONFIG_DRM_AMD_DC_DML21
+	.prepare_mcache_programming = dcn42b_prepare_mcache_programming,
+#endif
+	.build_pipe_pix_clk_params = dcn42b_build_pipe_pix_clk_params,
+	.get_power_profile = dcn401_get_power_profile,
+	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe,
+	.get_default_tiling_info = dcn401_get_default_tiling_info,
+	.get_max_hw_cursor_size = dcn42b_get_max_hw_cursor_size,
+};
+
+static bool dcn42b_resource_construct(
+	uint8_t num_virtual_links,
+	struct dc *dc,
+	struct dcn42b_resource_pool *pool)
+{
+	int i;
+	struct dc_context *ctx = dc->ctx;
+	struct irq_service_init_data init_data;
+	uint32_t num_pipes = 4;
+
+#undef REG_STRUCT
+#define REG_STRUCT bios_regs
+	bios_regs_init();
+
+#undef REG_STRUCT
+#define REG_STRUCT clk_src_regs
+	clk_src_regs_init(0, A),
+	clk_src_regs_init(1, B),
+	clk_src_regs_init(2, C),
+	clk_src_regs_init(3, D),
+	clk_src_regs_init(4, E);
+
+#undef REG_STRUCT
+#define REG_STRUCT abm_regs
+	abm_regs_init(0),
+		abm_regs_init(1),
+		abm_regs_init(2);
+		//abm_regs_init(3);
+#undef REG_STRUCT
+#define REG_STRUCT dccg_regs
+	dccg_regs_init();
+
+	ctx->dc_bios->regs = &bios_regs;
+
+	pool->base.res_cap = &res_cap_dcn42b;
+
+	/* max number of pipes for ASIC before checking for pipe fuses */
+	num_pipes = pool->base.res_cap->num_dpp;
+	pool->base.funcs = &dcn42b_res_pool_funcs;
+
+	/*************************************************
+	 *  Resource + asic cap harcoding                *
+	 *************************************************/
+	pool->base.underlay_pipe_index = (unsigned int)NO_UNDERLAY_PIPE;
+	pool->base.timing_generator_count = pool->base.res_cap->num_timing_generator;
+	pool->base.pipe_count = num_pipes;
+	pool->base.mpcc_count = num_pipes;
+	dc->caps.ips_v2_support = true;
+	dc->caps.max_downscale_ratio = 600;
+	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a applied by default*/
+	/* TODO: Bring max cursor size back to 256 after subvp cursor corruption is fixed*/
+	dc->caps.max_cursor_size = 64;
+	dc->caps.max_buffered_cursor_size = 64;
+	dc->caps.cursor_not_scaled = true;
+	dc->caps.min_horizontal_blanking_period = 80;
+	dc->caps.dmdata_alloc_size = 2048;
+	dc->caps.mall_size_per_mem_channel = 4;
+	/* total size = mall per channel * num channels * 1024 * 1024 */
+	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel *
+		dc->ctx->dc_bios->vram_info.num_chans * 1048576;
+	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
+	dc->caps.cache_line_size = 64;
+	dc->caps.cache_num_ways = 16;
+
+	/* Calculate the available MALL space */
+	dc->caps.max_cab_allocation_bytes =
+		dcn32_calc_num_avail_chans_for_mall(dc, dc->ctx->dc_bios->vram_info.num_chans) *
+				dc->caps.mall_size_per_mem_channel * 1024 * 1024;
+	dc->caps.mall_size_total = dc->caps.max_cab_allocation_bytes;
+
+	dc->caps.subvp_fw_processing_delay_us = 15;
+	dc->caps.subvp_drr_max_vblank_margin_us = 40;
+	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
+	dc->caps.subvp_swath_height_margin_lines = 16;
+	dc->caps.subvp_pstate_allow_width_us = 20;
+	dc->caps.subvp_vertical_int_margin_us = 30;
+	dc->caps.subvp_drr_vblank_start_margin_us = 100; // 100us margin
+
+	dc->caps.max_slave_planes = 2;
+	dc->caps.max_slave_yuv_planes = 2;
+	dc->caps.max_slave_rgb_planes = 2;
+	dc->caps.post_blend_color_processing = true;
+	dc->caps.force_dp_tps4_for_cp2520 = true;
+	if (dc->config.forceHBR2CP2520)
+		dc->caps.force_dp_tps4_for_cp2520 = false;
+	dc->caps.dp_hdmi21_pcon_support = true;
+	dc->caps.dp_hpo = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
+	dc->caps.edp_dsc_support = true;
+	dc->caps.extended_aux_timeout_support = true;
+	dc->caps.dmcub_support = true;
+	dc->caps.is_apu = true;
+	dc->caps.seamless_odm = true;
+	dc->caps.zstate_support = false;
+	dc->caps.ips_support = false;
+	dc->caps.max_v_total = (1 << 15) - 1;
+	dc->caps.vtotal_limited_by_fp2 = true;
+	dc->config.disable_ips = DMUB_IPS_DISABLE_ALL;
+
+	/* Color pipeline capabilities */
+	dc->caps.color.dpp.dcn_arch = 1;
+	dc->caps.color.dpp.input_lut_shared = 0;
+	dc->caps.color.dpp.icsc = 1;
+	dc->caps.color.dpp.dgam_ram = 0; // must use gamma_corr
+	dc->caps.color.dpp.dgam_rom_caps.srgb = 1;
+	dc->caps.color.dpp.dgam_rom_caps.bt2020 = 1;
+	dc->caps.color.dpp.dgam_rom_caps.gamma2_2 = 1;
+	dc->caps.color.dpp.dgam_rom_caps.pq = 1;
+	dc->caps.color.dpp.dgam_rom_caps.hlg = 1;
+	dc->caps.color.dpp.post_csc = 1;
+	dc->caps.color.dpp.gamma_corr = 1;
+	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
+
+	dc->caps.color.dpp.hw_3d_lut = 0;
+	dc->caps.color.dpp.ogam_ram = 0;
+	// no OGAM ROM on DCN2 and later ASICs
+	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
+	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
+	dc->caps.color.dpp.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.dpp.ogam_rom_caps.pq = 0;
+	dc->caps.color.dpp.ogam_rom_caps.hlg = 0;
+	dc->caps.color.dpp.ocsc = 0;
+
+	dc->caps.color.mpc.gamut_remap = 1;
+	//configurable to be before or after BLND in MPCC
+	dc->caps.color.mpc.num_3dluts = (uint16_t)pool->base.res_cap->num_mpc_3dlut;
+	dc->caps.color.mpc.num_rmcm_3dluts = 2;
+	dc->caps.color.mpc.ogam_ram = 1;
+	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
+	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
+	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
+	dc->caps.color.mpc.ocsc = 1;
+	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.mcm_3d_lut_caps.dma_3d_lut = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.lut_dim_caps.dim_9 = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.lut_dim_caps.dim_17 = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_layout_support.linear_1d = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_layout_support.swizzle_3d_bgr = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_layout_support.swizzle_3d_rgb = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_format_support.unorm_12msb = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_format_support.unorm_12lsb = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_format_support.float_fp1_5_10 = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_pixel_order_support.order_rgba = 1;
+	dc->caps.color.mpc.mcm_3d_lut_caps.mem_pixel_order_support.order_bgra = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.dma_3d_lut = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_17 = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33 = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_layout_support.linear_1d = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_layout_support.swizzle_3d_bgr = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_layout_support.swizzle_3d_rgb = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_format_support.unorm_12msb = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_format_support.unorm_12lsb = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_format_support.float_fp1_5_10 = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_rgba = 1;
+	dc->caps.color.mpc.rmcm_3d_lut_caps.mem_pixel_order_support.order_bgra = 1;
+
+	dc->caps.num_of_host_routers = 0;
+	dc->caps.num_of_dpias_per_host_router = 0;
+
+	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
+	 * to provide some margin.
+	 * It's expected for furture ASIC to have equal or higher value, in order to
+	 * have determinstic power improvement from generate to genration.
+	 * (i.e., we should not expect new ASIC generation with lower vmin rate)
+	 */
+	dc->caps.max_disp_clock_khz_at_vmin = 650000;
+	dc->config.use_spl = true;
+	dc->config.prefer_easf = true;
+
+	dc->config.dcn_sharpness_range.sdr_rgb_min = 0;
+	dc->config.dcn_sharpness_range.sdr_rgb_max = 1750;
+	dc->config.dcn_sharpness_range.sdr_rgb_mid = 750;
+	dc->config.dcn_sharpness_range.sdr_yuv_min = 0;
+	dc->config.dcn_sharpness_range.sdr_yuv_max = 3500;
+	dc->config.dcn_sharpness_range.sdr_yuv_mid = 1500;
+	dc->config.dcn_sharpness_range.hdr_rgb_min = 0;
+	dc->config.dcn_sharpness_range.hdr_rgb_max = 2750;
+	dc->config.dcn_sharpness_range.hdr_rgb_mid = 1500;
+
+	dc->config.dcn_override_sharpness_range.sdr_rgb_min = 0;
+	dc->config.dcn_override_sharpness_range.sdr_rgb_max = 3250;
+	dc->config.dcn_override_sharpness_range.sdr_rgb_mid = 1250;
+	dc->config.dcn_override_sharpness_range.sdr_yuv_min = 0;
+	dc->config.dcn_override_sharpness_range.sdr_yuv_max = 3500;
+	dc->config.dcn_override_sharpness_range.sdr_yuv_mid = 1500;
+	dc->config.dcn_override_sharpness_range.hdr_rgb_min = 0;
+	dc->config.dcn_override_sharpness_range.hdr_rgb_max = 2750;
+	dc->config.dcn_override_sharpness_range.hdr_rgb_mid = 1500;
+
+	dc->config.use_pipe_ctx_sync_logic = true;
+	dc->config.dc_mode_clk_limit_support = false;
+	dc->config.enable_windowed_mpo_odm = true;
+	/* Use psp mailbox to enable assr */
+	dc->config.use_assr_psp_message = true;
+	/* dcn42 and afterward always support external panel replay */
+	dc->config.frame_update_cmd_version2 = true;
+
+	/* read VBIOS LTTPR caps */
+	{
+		if (ctx->dc_bios->funcs->get_lttpr_caps) {
+			enum bp_result bp_query_result;
+			uint8_t is_vbios_lttpr_enable = 0;
+
+			bp_query_result = ctx->dc_bios->funcs->get_lttpr_caps(ctx->dc_bios, &is_vbios_lttpr_enable);
+			dc->caps.vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
+		}
+
+		dc->caps.vbios_lttpr_aware = true;
+	}
+	dc->check_config = config_defaults;
+
+	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
+		dc->debug = debug_defaults_drv;
+	/*HW default is to have all the FGCG enabled, SW no need to program them*/
+	dc->debug.enable_fine_grain_clock_gating.u32All = 0xFFFF;
+	// Init the vm_helper
+	if (dc->vm_helper)
+		vm_helper_init(dc->vm_helper, 16);
+
+	/*************************************************
+	 *  Create resources                             *
+	 *************************************************/
+
+	/* Clock Sources for Pixel Clock*/
+	pool->base.clock_sources[DCN401_CLK_SRC_PLL0] =
+		dcn42b_clock_source_create(ctx, ctx->dc_bios,
+								  CLOCK_SOURCE_COMBO_PHY_PLL0,
+								  &clk_src_regs[0], false);
+	pool->base.clock_sources[DCN401_CLK_SRC_PLL1] =
+		dcn42b_clock_source_create(ctx, ctx->dc_bios,
+								  CLOCK_SOURCE_COMBO_PHY_PLL1,
+								  &clk_src_regs[1], false);
+	pool->base.clock_sources[DCN401_CLK_SRC_PLL2] =
+		dcn42b_clock_source_create(ctx, ctx->dc_bios,
+								  CLOCK_SOURCE_COMBO_PHY_PLL2,
+								  &clk_src_regs[2], false);
+
+	pool->base.clk_src_count = DCN401_CLK_SRC_TOTAL;
+
+	/* todo: not reuse phy_pll registers */
+	pool->base.dp_clock_source =
+		dcn42b_clock_source_create(ctx, ctx->dc_bios,
+								  CLOCK_SOURCE_ID_DP_DTO,
+								  &clk_src_regs[0], true);
+
+	for (i = 0; i < (int)pool->base.clk_src_count; i++) {
+		if (pool->base.clock_sources[i] == NULL) {
+			dm_error("DC: failed to create clock sources!\n");
+			BREAK_TO_DEBUGGER();
+			goto create_fail;
+		}
+	}
+
+	/* DCCG */
+	pool->base.dccg = dccg42_create(ctx, &dccg_regs, &dccg_shift, &dccg_mask);
+	if (pool->base.dccg == NULL) {
+		dm_error("DC: failed to create dccg!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+
+#undef REG_STRUCT
+#define REG_STRUCT pg_cntl_regs
+	pg_cntl_dcn42b_regs_init();
+
+	pool->base.pg_cntl = pg_cntl42_create(ctx, &pg_cntl_regs, &pg_cntl_shift, &pg_cntl_mask);
+	if (pool->base.pg_cntl == NULL) {
+		dm_error("DC: failed to create power gate control!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+	/* IRQ Service */
+	init_data.ctx = dc->ctx;
+	pool->base.irqs = dal_irq_service_dcn42_create(&init_data);
+	if (!pool->base.irqs)
+		goto create_fail;
+
+	/* HUBBUB */
+	pool->base.hubbub = dcn42b_hubbub_create(ctx);
+	if (pool->base.hubbub == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create hubbub!\n");
+		goto create_fail;
+	}
+
+	/* HUBPs, DPPs, OPPs, TGs, ABMs */
+	/* HUBPs */
+	for (i = 0; i < pool->base.res_cap->num_dpp; i++) {
+		pool->base.hubps[i] = dcn42b_hubp_create(ctx, i);
+		if (pool->base.hubps[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create hubps!\n");
+			goto create_fail;
+		}
+	}
+
+	/* DPPs */
+	for (i = 0; i < pool->base.res_cap->num_dpp; i++) {
+		pool->base.dpps[i] = dcn42b_dpp_create(ctx, i);
+		if (pool->base.dpps[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create dpps!\n");
+			goto create_fail;
+		}
+	}
+
+	/* OPPs */
+	for (i = 0; i < pool->base.res_cap->num_opp; i++) {
+		pool->base.opps[i] = dcn42b_opp_create(ctx, i);
+		if (pool->base.opps[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create output pixel processor!\n");
+			goto create_fail;
+		}
+	}
+
+	/* TGs */
+	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+		pool->base.timing_generators[i] = dcn42b_timing_generator_create(ctx, i);
+		if (pool->base.timing_generators[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create tg!\n");
+			goto create_fail;
+		}
+	}
+
+	/* ABMs */
+	for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
+		pool->base.multiple_abms[i] = dmub_abm_create(ctx,
+													  &abm_regs[i],
+													  &abm_shift,
+													  &abm_mask);
+		if (pool->base.multiple_abms[i] == NULL) {
+			dm_error("DC: failed to create abm for pipe %d!\n", i);
+			BREAK_TO_DEBUGGER();
+			goto create_fail;
+		}
+	}
+
+	/* PSR */
+	pool->base.psr = dmub_psr_create(ctx);
+	if (pool->base.psr == NULL) {
+		dm_error("DC: failed to create psr obj!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+
+	/* Replay */
+	pool->base.replay = dmub_replay_create(ctx);
+	if (pool->base.replay == NULL) {
+		dm_error("DC: failed to create replay obj!\n");
+		BREAK_TO_DEBUGGER();
+		goto create_fail;
+	}
+
+	/* Auto Test */
+
+	/* MPCCs */
+	pool->base.mpc = dcn42b_mpc_create(ctx, pool->base.mpcc_count,
+			pool->base.res_cap->num_mpc_3dlut);
+	if (pool->base.mpc == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create mpc!\n");
+		goto create_fail;
+	}
+
+	/* DSCs */
+	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
+		pool->base.dscs[i] = dcn42b_dsc_create(ctx, i);
+		if (pool->base.dscs[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error("DC: failed to create display stream compressor %d!\n", i);
+			goto create_fail;
+		}
+	}
+
+	/* DWB */
+	if (!dcn42b_dwbc_create(ctx, &pool->base)) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dwbc!\n");
+		goto create_fail;
+	}
+
+	/* MMHUBBUB */
+	if (!dcn42b_mmhubbub_create(ctx, &pool->base)) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create mcif_wb!\n");
+		goto create_fail;
+	}
+
+	/* AUX */
+	for (i = 0; i < pool->base.res_cap->num_aux; i++) {
+		pool->base.engines[i] = dcn42b_aux_engine_create(ctx, i);
+		if (pool->base.engines[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error(
+				"DC:failed to create aux engine!!\n");
+			goto create_fail;
+		}
+	}
+
+	/* I2C */
+	for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
+		pool->base.hw_i2cs[i] = dcn42b_i2c_hw_create(ctx, i);
+		if (pool->base.hw_i2cs[i] == NULL) {
+			BREAK_TO_DEBUGGER();
+			dm_error(
+				"DC:failed to create hw i2c!!\n");
+			goto create_fail;
+		}
+		pool->base.sw_i2cs[i] = NULL;
+	}
+	/* DCN4.2B has 0 DPIA */
+	/*pool->base.usb4_dpia_count = dc->caps.num_of_host_routers * dc->caps.num_of_dpias_per_host_router;
+	if (dc->debug.dpia_debug.bits.disable_dpia)*/
+	pool->base.usb4_dpia_count = 0;
+
+	/* Audio, HWSeq, Stream Encoders including HPO and virtual, MPC 3D LUTs */
+	if (!resource_construct(num_virtual_links, dc, &pool->base,
+							&res_create_funcs))
+		goto create_fail;
+
+	/* HW Sequencer init functions and Plane caps */
+	dcn42b_hw_sequencer_init_functions(dc);
+
+	dc->caps.max_planes = pool->base.pipe_count;
+	dc->config.dp_connector_no_native_i2c = true;
+
+	for (i = 0; i < (int)dc->caps.max_planes; ++i)
+		dc->caps.planes[i] = plane_cap;
+
+	dc->caps.max_odm_combine_factor = 4;
+
+	dc->cap_funcs = cap_funcs;
+	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
+
+	// For now enable SDPIF_REQUEST_RATE_LIMIT on DCN4_01 when vram_info.num_chans provided
+	if (dc->config.sdpif_request_limit_words_per_umc == 0)
+		dc->config.sdpif_request_limit_words_per_umc = 16;
+
+	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
+	 /*this will use real soc clock table*/
+	dc->dml2_options.use_native_soc_bb_construction = true;
+	dc->dml2_options.minimize_dispclk_using_odm = false;
+	if (dc->config.EnableMinDispClkODM)
+		dc->dml2_options.minimize_dispclk_using_odm = true;
+	dc->dml2_options.enable_windowed_mpo_odm = dc->config.enable_windowed_mpo_odm;
+	dc->dml2_options.map_dc_pipes_with_callbacks = true;
+	dc->dml2_options.force_tdlut_enable = true;
+
+	resource_init_common_dml2_callbacks(dc, &dc->dml2_options);
+	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch =
+			&dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
+	dc->dml2_options.svp_pstate.callbacks.release_dsc = &dcn20_release_dsc;
+	dc->dml2_options.svp_pstate.callbacks.calculate_mall_ways_from_bytes =
+		pool->base.funcs->calculate_mall_ways_from_bytes;
+
+	dc->dml2_options.svp_pstate.subvp_fw_processing_delay_us = dc->caps.subvp_fw_processing_delay_us;
+	dc->dml2_options.svp_pstate.subvp_prefetch_end_to_mall_start_us = dc->caps.subvp_prefetch_end_to_mall_start_us;
+	dc->dml2_options.svp_pstate.subvp_pstate_allow_width_us = dc->caps.subvp_pstate_allow_width_us;
+	dc->dml2_options.svp_pstate.subvp_swath_height_margin_lines = dc->caps.subvp_swath_height_margin_lines;
+
+	dc->dml2_options.svp_pstate.force_disable_subvp = dc->debug.force_disable_subvp;
+	dc->dml2_options.svp_pstate.force_enable_subvp = dc->debug.force_subvp_mclk_switch;
+
+	dc->dml2_options.mall_cfg.cache_line_size_bytes = dc->caps.cache_line_size;
+	dc->dml2_options.mall_cfg.cache_num_ways = dc->caps.cache_num_ways;
+	dc->dml2_options.mall_cfg.max_cab_allocation_bytes =
+				dc->caps.max_cab_allocation_bytes;
+	dc->dml2_options.mall_cfg.mblk_height_4bpe_pixels = DCN3_2_MBLK_HEIGHT_4BPE;
+	dc->dml2_options.mall_cfg.mblk_height_8bpe_pixels = DCN3_2_MBLK_HEIGHT_8BPE;
+	dc->dml2_options.mall_cfg.mblk_size_bytes = DCN3_2_MALL_MBLK_SIZE_BYTES;
+	dc->dml2_options.mall_cfg.mblk_width_pixels = DCN3_2_MBLK_WIDTH;
+
+	dc->dml2_options.max_segments_per_hubp = 24;
+	dc->dml2_options.det_segment_size = DCN42_CRB_SEGMENT_SIZE_KB;
+	dc->dml2_options.gpuvm_enable = true;
+	dc->dml2_options.hostvm_enable = true;
+
+	/* SPL */
+	dc->caps.scl_caps.sharpener_support = true;
+
+	return true;
+
+create_fail:
+
+	dcn42b_resource_destruct(pool);
+
+	return false;
+}
+struct resource_pool *dcn42b_create_resource_pool(
+	const struct dc_init_data *init_data,
+	struct dc *dc)
+{
+	struct dcn42b_resource_pool *pool =
+		kzalloc(sizeof(struct dcn42b_resource_pool), GFP_KERNEL);
+
+	if (!pool)
+		return NULL;
+
+	if (dcn42b_resource_construct((uint8_t)init_data->num_virtual_links, dc, pool))
+		return &pool->base;
+
+	BREAK_TO_DEBUGGER();
+	kfree(pool);
+	return NULL;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
new file mode 100644
index 000000000000..2da3e3c8304a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#ifndef _DCN42B_RESOURCE_H_
+#define _DCN42B_RESOURCE_H_
+
+#include "core_types.h"
+
+#define TO_DCN42B_RES_POOL(pool) \
+	container_of(pool, struct dcn42b_resource_pool, base)
+
+/* DPP */
+#define DPP_REG_LIST_DCN42B_COMMON_RI(id)	                                    \
+	SRI_ARR(CM_DEALPHA, CM, id), SRI_ARR(CM_MEM_PWR_STATUS, CM, id),            \
+		SRI_ARR(CM_BIAS_CR_R, CM, id), SRI_ARR(CM_BIAS_Y_G_CB_B, CM, id),       \
+		SRI_ARR(PRE_DEGAM, CNVC_CFG, id), SRI_ARR(CM_GAMCOR_CONTROL, CM, id),   \
+		SRI_ARR(CM_GAMCOR_LUT_CONTROL, CM, id),                                 \
+		SRI_ARR(CM_GAMCOR_LUT_INDEX, CM, id),                                   \
+		SRI_ARR(CM_GAMCOR_LUT_INDEX, CM, id),                                   \
+		SRI_ARR(CM_GAMCOR_LUT_DATA, CM, id),                                    \
+		SRI_ARR(CM_GAMCOR_RAMB_START_CNTL_B, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMB_START_CNTL_G, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMB_START_CNTL_R, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMB_START_SLOPE_CNTL_B, CM, id),                     \
+		SRI_ARR(CM_GAMCOR_RAMB_START_SLOPE_CNTL_G, CM, id),                     \
+		SRI_ARR(CM_GAMCOR_RAMB_START_SLOPE_CNTL_R, CM, id),                     \
+		SRI_ARR(CM_GAMCOR_RAMB_END_CNTL1_B, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMB_END_CNTL2_B, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMB_END_CNTL1_G, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMB_END_CNTL2_G, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMB_END_CNTL1_R, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMB_END_CNTL2_R, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMB_REGION_0_1, CM, id),                             \
+		SRI_ARR(CM_GAMCOR_RAMB_REGION_32_33, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMB_OFFSET_B, CM, id),                               \
+		SRI_ARR(CM_GAMCOR_RAMB_OFFSET_G, CM, id),                               \
+		SRI_ARR(CM_GAMCOR_RAMB_OFFSET_R, CM, id),                               \
+		SRI_ARR(CM_GAMCOR_RAMB_START_BASE_CNTL_B, CM, id),                      \
+		SRI_ARR(CM_GAMCOR_RAMB_START_BASE_CNTL_G, CM, id),                      \
+		SRI_ARR(CM_GAMCOR_RAMB_START_BASE_CNTL_R, CM, id),                      \
+		SRI_ARR(CM_GAMCOR_RAMA_START_CNTL_B, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMA_START_CNTL_G, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMA_START_CNTL_R, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMA_START_SLOPE_CNTL_B, CM, id),                     \
+		SRI_ARR(CM_GAMCOR_RAMA_START_SLOPE_CNTL_G, CM, id),                     \
+		SRI_ARR(CM_GAMCOR_RAMA_START_SLOPE_CNTL_R, CM, id),                     \
+		SRI_ARR(CM_GAMCOR_RAMA_END_CNTL1_B, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMA_END_CNTL2_B, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMA_END_CNTL1_G, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMA_END_CNTL2_G, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMA_END_CNTL1_R, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMA_END_CNTL2_R, CM, id),                            \
+		SRI_ARR(CM_GAMCOR_RAMA_REGION_0_1, CM, id),                             \
+		SRI_ARR(CM_GAMCOR_RAMA_REGION_32_33, CM, id),                           \
+		SRI_ARR(CM_GAMCOR_RAMA_OFFSET_B, CM, id),                               \
+		SRI_ARR(CM_GAMCOR_RAMA_OFFSET_G, CM, id),                               \
+		SRI_ARR(CM_GAMCOR_RAMA_OFFSET_R, CM, id),                               \
+		SRI_ARR(CM_GAMCOR_RAMA_START_BASE_CNTL_B, CM, id),                      \
+		SRI_ARR(CM_GAMCOR_RAMA_START_BASE_CNTL_G, CM, id),                      \
+		SRI_ARR(CM_GAMCOR_RAMA_START_BASE_CNTL_R, CM, id),                      \
+		SRI_ARR(CM_HIST_CNTL, CM, id),                                          \
+		SRI_ARR(CM_HIST_LOCK, CM, id),                                          \
+		SRI_ARR(CM_HIST_INDEX, CM, id),                                         \
+		SRI_ARR(CM_HIST_DATA, CM, id),                                          \
+		SRI_ARR(CM_HIST_STATUS, CM, id),                                        \
+		SRI_ARR(CM_HIST_SCALE_SRC1, CM, id),                                    \
+		SRI_ARR(CM_HIST_COEFA_SRC2, CM, id),                                    \
+		SRI_ARR(CM_HIST_COEFB_SRC2, CM, id),                                    \
+		SRI_ARR(CM_HIST_COEFC_SRC2, CM, id),                                    \
+		SRI_ARR(CM_HIST_SCALE_SRC3, CM, id),                                    \
+		SRI_ARR(CM_HIST_BIAS_SRC1, CM, id),                                     \
+		SRI_ARR(CM_HIST_BIAS_SRC2, CM, id),                                     \
+		SRI_ARR(CM_HIST_BIAS_SRC3, CM, id),                                     \
+		SRI_ARR(DSCL_EXT_OVERSCAN_LEFT_RIGHT, DSCL, id),                        \
+		SRI_ARR(DSCL_EXT_OVERSCAN_TOP_BOTTOM, DSCL, id),                        \
+		SRI_ARR(OTG_H_BLANK, DSCL, id), SRI_ARR(OTG_V_BLANK, DSCL, id),         \
+		SRI_ARR(SCL_MODE, DSCL, id), SRI_ARR(LB_DATA_FORMAT, DSCL, id),         \
+		SRI_ARR(LB_MEMORY_CTRL, DSCL, id), SRI_ARR(DSCL_AUTOCAL, DSCL, id),     \
+		SRI_ARR(SCL_TAP_CONTROL, DSCL, id),                                     \
+		SRI_ARR(SCL_COEF_RAM_TAP_SELECT, DSCL, id),                             \
+		SRI_ARR(SCL_COEF_RAM_TAP_DATA, DSCL, id),                               \
+		SRI_ARR(DSCL_2TAP_CONTROL, DSCL, id), SRI_ARR(MPC_SIZE, DSCL, id),      \
+		SRI_ARR(SCL_HORZ_FILTER_SCALE_RATIO, DSCL, id),                         \
+		SRI_ARR(SCL_VERT_FILTER_SCALE_RATIO, DSCL, id),                         \
+		SRI_ARR(SCL_HORZ_FILTER_SCALE_RATIO_C, DSCL, id),                       \
+		SRI_ARR(SCL_VERT_FILTER_SCALE_RATIO_C, DSCL, id),                       \
+		SRI_ARR(SCL_HORZ_FILTER_INIT, DSCL, id),                                \
+		SRI_ARR(SCL_HORZ_FILTER_INIT_C, DSCL, id),                              \
+		SRI_ARR(SCL_VERT_FILTER_INIT, DSCL, id),                                \
+		SRI_ARR(SCL_VERT_FILTER_INIT_C, DSCL, id),                              \
+		SRI_ARR(RECOUT_START, DSCL, id), SRI_ARR(RECOUT_SIZE, DSCL, id),        \
+		SRI_ARR(PRE_DEALPHA, CNVC_CFG, id), SRI_ARR(PRE_REALPHA, CNVC_CFG, id), \
+		SRI_ARR(PRE_CSC_MODE, CNVC_CFG, id),                                    \
+		SRI_ARR(PRE_CSC_C11_C12, CNVC_CFG, id),                                 \
+		SRI_ARR(PRE_CSC_C33_C34, CNVC_CFG, id),                                 \
+		SRI_ARR(PRE_CSC_B_C11_C12, CNVC_CFG, id),                               \
+		SRI_ARR(PRE_CSC_B_C33_C34, CNVC_CFG, id),                               \
+		SRI_ARR(CM_POST_CSC_CONTROL, CM, id),                                   \
+		SRI_ARR(CM_POST_CSC_C11_C12, CM, id),                                   \
+		SRI_ARR(CM_POST_CSC_C33_C34, CM, id),                                   \
+		SRI_ARR(CM_POST_CSC_B_C11_C12, CM, id),                                 \
+		SRI_ARR(CM_POST_CSC_B_C33_C34, CM, id),                                 \
+		SRI_ARR(CM_MEM_PWR_CTRL, CM, id), SRI_ARR(CM_CONTROL, CM, id),          \
+		SRI_ARR(CM_TEST_DEBUG_INDEX, CM, id),                                   \
+		SRI_ARR(CM_TEST_DEBUG_DATA, CM, id),                                    \
+		SRI_ARR(FORMAT_CONTROL, CNVC_CFG, id),                                  \
+		SRI_ARR(CNVC_SURFACE_PIXEL_FORMAT, CNVC_CFG, id),                       \
+		SRI_ARR(CURSOR0_CONTROL, CM_CUR, id),                                   \
+		SRI_ARR(CURSOR0_COLOR0, CM_CUR, id),                                    \
+		SRI_ARR(CURSOR0_COLOR1, CM_CUR, id),                                    \
+		SRI_ARR(CURSOR0_FP_SCALE_BIAS_G_Y, CM_CUR, id),                         \
+		SRI_ARR(CURSOR0_FP_SCALE_BIAS_RB_CRCB, CM_CUR, id),                     \
+		SRI_ARR(CUR0_MATRIX_MODE, CM_CUR, id),                                  \
+		SRI_ARR(CUR0_MATRIX_C11_C12_A, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C13_C14_A, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C21_C22_A, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C23_C24_A, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C31_C32_A, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C33_C34_A, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C11_C12_B, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C13_C14_B, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C21_C22_B, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C23_C24_B, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C31_C32_B, CM_CUR, id),                             \
+		SRI_ARR(CUR0_MATRIX_C33_C34_B, CM_CUR, id),                             \
+		SRI_ARR(DPP_CONTROL, DPP_TOP, id), SRI_ARR(CM_HDR_MULT_COEF, CM, id),   \
+		SRI_ARR(CURSOR_CONTROL, CURSOR0_, id),                                  \
+		SRI_ARR(ALPHA_2BIT_LUT01, CNVC_CFG, id),                                \
+		SRI_ARR(ALPHA_2BIT_LUT23, CNVC_CFG, id),                                \
+		SRI_ARR(FCNV_FP_BIAS_R, CNVC_CFG, id),                                  \
+		SRI_ARR(FCNV_FP_BIAS_G, CNVC_CFG, id),                                  \
+		SRI_ARR(FCNV_FP_BIAS_B, CNVC_CFG, id),                                  \
+		SRI_ARR(FCNV_FP_SCALE_R, CNVC_CFG, id),                                 \
+		SRI_ARR(FCNV_FP_SCALE_G, CNVC_CFG, id),                                 \
+		SRI_ARR(FCNV_FP_SCALE_B, CNVC_CFG, id),                                 \
+		SRI_ARR(COLOR_KEYER_CONTROL, CNVC_CFG, id),                             \
+		SRI_ARR(COLOR_KEYER_ALPHA, CNVC_CFG, id),                               \
+		SRI_ARR(COLOR_KEYER_RED, CNVC_CFG, id),                                 \
+		SRI_ARR(COLOR_KEYER_GREEN, CNVC_CFG, id),                               \
+		SRI_ARR(COLOR_KEYER_BLUE, CNVC_CFG, id),                                \
+		SRI_ARR(OBUF_MEM_PWR_CTRL, DSCL, id),                                   \
+		SRI_ARR(DSCL_MEM_PWR_STATUS, DSCL, id),                                 \
+		SRI_ARR(DSCL_MEM_PWR_CTRL, DSCL, id),                                   \
+		SRI_ARR(DSCL_CONTROL, DSCL, id),										\
+		SRI_ARR(DSCL_SC_MODE, DSCL, id),                                        \
+		SRI_ARR(DSCL_EASF_H_MODE, DSCL, id),                                    \
+		SRI_ARR(DSCL_EASF_H_BF_CNTL, DSCL, id),                                 \
+		SRI_ARR(DSCL_EASF_H_RINGEST_EVENTAP_REDUCE, DSCL, id),                  \
+		SRI_ARR(DSCL_EASF_H_RINGEST_EVENTAP_GAIN, DSCL, id),                    \
+		SRI_ARR(DSCL_EASF_H_BF_FINAL_MAX_MIN, DSCL, id),                        \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG0, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG1, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG2, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG3, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG4, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG5, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG6, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF1_PWL_SEG7, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF3_PWL_SEG0, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF3_PWL_SEG1, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF3_PWL_SEG2, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF3_PWL_SEG3, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF3_PWL_SEG4, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_H_BF3_PWL_SEG5, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_MODE, DSCL, id),                                    \
+		SRI_ARR(DSCL_EASF_V_BF_CNTL, DSCL, id),                                 \
+		SRI_ARR(DSCL_EASF_V_RINGEST_3TAP_CNTL1, DSCL, id),                      \
+		SRI_ARR(DSCL_EASF_V_RINGEST_3TAP_CNTL2, DSCL, id),                      \
+		SRI_ARR(DSCL_EASF_V_RINGEST_3TAP_CNTL3, DSCL, id),                      \
+		SRI_ARR(DSCL_EASF_V_RINGEST_EVENTAP_REDUCE, DSCL, id),                  \
+		SRI_ARR(DSCL_EASF_V_RINGEST_EVENTAP_GAIN, DSCL, id),                    \
+		SRI_ARR(DSCL_EASF_V_BF_FINAL_MAX_MIN, DSCL, id),                        \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG0, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG1, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG2, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG3, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG4, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG5, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG6, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF1_PWL_SEG7, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF3_PWL_SEG0, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF3_PWL_SEG1, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF3_PWL_SEG2, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF3_PWL_SEG3, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF3_PWL_SEG4, DSCL, id),                            \
+		SRI_ARR(DSCL_EASF_V_BF3_PWL_SEG5, DSCL, id),                            \
+		SRI_ARR(DSCL_SC_MATRIX_C0C1, DSCL, id),                                 \
+		SRI_ARR(DSCL_SC_MATRIX_C2C3, DSCL, id),                                 \
+		SRI_ARR(ISHARP_MODE, DSCL, id),                                         \
+		SRI_ARR(ISHARP_DELTA_LUT_MEM_PWR_CTRL, DSCL, id),                        \
+		SRI_ARR(ISHARP_NOISEDET_THRESHOLD, DSCL, id),                           \
+		SRI_ARR(ISHARP_NOISE_GAIN_PWL, DSCL, id),                               \
+		SRI_ARR(ISHARP_LBA_PWL_SEG0, DSCL, id),                                 \
+		SRI_ARR(ISHARP_LBA_PWL_SEG1, DSCL, id),                                 \
+		SRI_ARR(ISHARP_LBA_PWL_SEG2, DSCL, id),                                 \
+		SRI_ARR(ISHARP_LBA_PWL_SEG3, DSCL, id),                                 \
+		SRI_ARR(ISHARP_LBA_PWL_SEG4, DSCL, id),                                 \
+		SRI_ARR(ISHARP_LBA_PWL_SEG5, DSCL, id),                                 \
+		SRI_ARR(ISHARP_DELTA_CTRL, DSCL, id),                                   \
+		SRI_ARR(ISHARP_DELTA_DATA, DSCL, id),                                   \
+		SRI_ARR(ISHARP_DELTA_INDEX, DSCL, id),                                  \
+		SRI_ARR(ISHARP_NLDELTA_SOFT_CLIP, DSCL, id),                            \
+		SRI_ARR(SCL_VERT_FILTER_INIT_BOT, DSCL, id),                            \
+		SRI_ARR(SCL_VERT_FILTER_INIT_BOT_C, DSCL, id)
+
+/* Stream encoder */
+#define SE_DCN42B_REG_LIST_RI(id)                                                \
+	SRI_ARR(HDMI_CONTROL, DIG, id), SRI_ARR(HDMI_DB_CONTROL, DIG, id),          \
+		SRI_ARR(HDMI_GC, DIG, id),                                              \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL0, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL1, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL2, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL3, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL4, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL5, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL6, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL7, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL8, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL9, DIG, id),                         \
+		SRI_ARR(HDMI_GENERIC_PACKET_CONTROL10, DIG, id),                        \
+		SRI_ARR(HDMI_INFOFRAME_CONTROL0, DIG, id),                              \
+		SRI_ARR(HDMI_VBI_PACKET_CONTROL, DIG, id),                              \
+		SRI_ARR(HDMI_AUDIO_PACKET_CONTROL, DIG, id),                            \
+		SRI_ARR(HDMI_ACR_PACKET_CONTROL, DIG, id),                              \
+		SRI_ARR(HDMI_ACR_32_0, DIG, id), SRI_ARR(HDMI_ACR_32_1, DIG, id),       \
+		SRI_ARR(HDMI_ACR_44_0, DIG, id), SRI_ARR(HDMI_ACR_44_1, DIG, id),       \
+		SRI_ARR(HDMI_ACR_48_0, DIG, id), SRI_ARR(HDMI_ACR_48_1, DIG, id),       \
+		SRI_ARR(DP_DB_CNTL, DP, id), SRI_ARR(DP_MSA_MISC, DP, id),              \
+		SRI_ARR(DP_MSA_VBID_MISC, DP, id), SRI_ARR(DP_MSA_COLORIMETRY, DP, id), \
+		SRI_ARR(DP_MSA_TIMING_PARAM1, DP, id),                                  \
+		SRI_ARR(DP_MSA_TIMING_PARAM2, DP, id),                                  \
+		SRI_ARR(DP_MSA_TIMING_PARAM3, DP, id),                                  \
+		SRI_ARR(DP_MSA_TIMING_PARAM4, DP, id),                                  \
+		SRI_ARR(DP_MSE_RATE_CNTL, DP, id), SRI_ARR(DP_MSE_RATE_UPDATE, DP, id), \
+		SRI_ARR(DP_PIXEL_FORMAT, DP, id), SRI_ARR(DP_SEC_CNTL, DP, id),         \
+		SRI_ARR(DP_SEC_CNTL1, DP, id), SRI_ARR(DP_SEC_CNTL2, DP, id),           \
+		SRI_ARR(DP_SEC_CNTL5, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),           \
+		SRI_ARR(DP_STEER_FIFO, DP, id), SRI_ARR(DP_VID_M, DP, id),              \
+		SRI_ARR(DP_VID_N, DP, id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),         \
+		SRI_ARR(DP_VID_TIMING, DP, id), SRI_ARR(DP_SEC_AUD_N, DP, id),          \
+		SRI_ARR(DP_SEC_TIMESTAMP, DP, id),                                      \
+		SRI_ARR(DP_SEC_METADATA_TRANSMISSION, DP, id),                          \
+		SRI_ARR(HDMI_METADATA_PACKET_CONTROL, DIG, id),                         \
+		SRI_ARR(DP_SEC_FRAMING4, DP, id), SRI_ARR(DP_GSP11_CNTL, DP, id),       \
+		SRI_ARR(DME_CONTROL, DME, id),                                          \
+		SRI_ARR(DP_SEC_METADATA_TRANSMISSION, DP, id),                          \
+		SRI_ARR(HDMI_METADATA_PACKET_CONTROL, DIG, id),                         \
+		SRI_ARR(DIG_FE_CNTL, DIG, id),                                          \
+		SRI_ARR(DIG_FE_EN_CNTL, DIG, id),                                       \
+		SRI_ARR(DIG_FE_CLK_CNTL, DIG, id),                                      \
+		SRI_ARR(DIG_CLOCK_PATTERN, DIG, id),                                    \
+		SRI_ARR(DIG_FIFO_CTRL0, DIG, id),                                       \
+		SRI_ARR(STREAM_MAPPER_CONTROL, DIG, id),\
+		SRI_ARR(DIG_FE_AUDIO_CNTL, DIG, id)
+
+/* HPO DP stream encoder */
+/* Not in DCN42B:
+ * SRI_ARR(DP_SYM32_ENC_VID_CRC_CONTROL, DP_SYM32_ENC, id),
+ * SRI_ARR(DP_SYM32_ENC_HBLANK_CONTROL, DP_SYM32_ENC, id),
+ */
+#define DCN42B_HPO_DP_STREAM_ENC_REG_LIST_RI(id)                                             \
+	SR_ARR(DP_STREAM_MAPPER_CONTROL0, id),                                                  \
+		SR_ARR(DP_STREAM_MAPPER_CONTROL1, id),                                              \
+		SR_ARR(DP_STREAM_MAPPER_CONTROL2, id),                                              \
+		SR_ARR(DP_STREAM_MAPPER_CONTROL3, id),                                              \
+		SRI_ARR(DP_STREAM_ENC_CLOCK_CONTROL, DP_STREAM_ENC, id),                            \
+		SRI_ARR(DP_STREAM_ENC_INPUT_MUX_CONTROL, DP_STREAM_ENC, id),                        \
+		SRI_ARR(DP_STREAM_ENC_AUDIO_CONTROL, DP_STREAM_ENC, id),                            \
+		SRI_ARR(DP_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0, DP_STREAM_ENC, id), \
+		SRI_ARR(DP_SYM32_ENC_CONTROL, DP_SYM32_ENC, id),                                    \
+		SRI_ARR(DP_SYM32_ENC_VID_PIXEL_FORMAT, DP_SYM32_ENC, id),                           \
+		SRI_ARR(DP_SYM32_ENC_VID_PIXEL_FORMAT_DOUBLE_BUFFER_CONTROL, DP_SYM32_ENC, id),     \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA0, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA1, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA2, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA3, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA4, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA5, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA6, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA7, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA8, DP_SYM32_ENC, id),                                   \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA_CONTROL, DP_SYM32_ENC, id),                            \
+		SRI_ARR(DP_SYM32_ENC_VID_MSA_DOUBLE_BUFFER_CONTROL, DP_SYM32_ENC, id),              \
+		SRI_ARR(DP_SYM32_ENC_VID_FIFO_CONTROL, DP_SYM32_ENC, id),                           \
+		SRI_ARR(DP_SYM32_ENC_VID_STREAM_CONTROL, DP_SYM32_ENC, id),                         \
+		SRI_ARR(DP_SYM32_ENC_VID_VBID_CONTROL, DP_SYM32_ENC, id),                           \
+		SRI_ARR(DP_SYM32_ENC_SDP_CONTROL, DP_SYM32_ENC, id),                                \
+		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL0, DP_SYM32_ENC, id),                           \
+		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL2, DP_SYM32_ENC, id),                           \
+		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL3, DP_SYM32_ENC, id),                           \
+		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL5, DP_SYM32_ENC, id),                           \
+		SRI_ARR(DP_SYM32_ENC_SDP_GSP_CONTROL11, DP_SYM32_ENC, id),                          \
+		SRI_ARR(DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL, DP_SYM32_ENC, id),                \
+		SRI_ARR(DP_SYM32_ENC_SDP_AUDIO_CONTROL0, DP_SYM32_ENC, id)
+
+/*HPO DP link encoder regs */
+#define DCN42B_HPO_DP_LINK_ENC_REG_LIST_RI(id)                    \
+	SRI_ARR(DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC, id),         \
+		SRI_ARR(DP_DPHY_SYM32_CONTROL, DP_DPHY_SYM32, id),       \
+		SRI_ARR(DP_DPHY_SYM32_STATUS, DP_DPHY_SYM32, id),        \
+		SRI_ARR(DP_DPHY_SYM32_TP_CONFIG, DP_DPHY_SYM32, id),     \
+		SRI_ARR(DP_DPHY_SYM32_TP_PRBS_SEED0, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_TP_PRBS_SEED1, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_TP_PRBS_SEED2, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_TP_PRBS_SEED3, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_TP_SQ_PULSE, DP_DPHY_SYM32, id),   \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM0, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM1, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM2, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM3, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM4, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM5, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM6, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM7, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM8, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM9, DP_DPHY_SYM32, id),    \
+		SRI_ARR(DP_DPHY_SYM32_TP_CUSTOM10, DP_DPHY_SYM32, id),   \
+		SRI_ARR(DP_DPHY_SYM32_SAT_VC0, DP_DPHY_SYM32, id),       \
+		SRI_ARR(DP_DPHY_SYM32_SAT_VC1, DP_DPHY_SYM32, id),       \
+		SRI_ARR(DP_DPHY_SYM32_SAT_VC2, DP_DPHY_SYM32, id),       \
+		SRI_ARR(DP_DPHY_SYM32_SAT_VC3, DP_DPHY_SYM32, id),       \
+		SRI_ARR(DP_DPHY_SYM32_VC_RATE_CNTL0, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_VC_RATE_CNTL1, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_VC_RATE_CNTL2, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_VC_RATE_CNTL3, DP_DPHY_SYM32, id), \
+		SRI_ARR(DP_DPHY_SYM32_SAT_UPDATE, DP_DPHY_SYM32, id)
+
+#define VPG_DCN42B_REG_LIST_RI(id) \
+	SRI(VPG_GENERIC_STATUS, VPG, id), \
+	SRI(VPG_GENERIC_PACKET_ACCESS_CTRL, VPG, id), \
+	SRI(VPG_GENERIC_PACKET_DATA, VPG, id), \
+	SRI(VPG_GSP_FRAME_UPDATE_CTRL, VPG, id), \
+	SRI(VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG, id), \
+	SRI(VPG_MEM_PWR, VPG, id)
+
+/* DCCG */
+/*
+ *  Following registers are not used in DCN42B.
+ *
+ *  DCCG_SRII(CLOCK_CNTL, HDMICHARCLK, 0),
+ *	SR(PHYDSYMCLK_CLOCK_CNTL),
+ *  DCCG_SRII(PIXEL_RATE_CNTL, OTG, 3),
+ *  DCCG_SRII(PHASE, DP_DTO, 3),
+ *  DCCG_SRII(MODULO, DP_DTO, 3),
+ *	SR(DSCCLK3_DTO_PARAM),
+ *	SR(HDMISTREAMCLK_CNTL),
+ *  SR(SYMCLKD_CLOCK_ENABLE),
+ *  SR(SYMCLKE_CLOCK_ENABLE)
+ */
+#define DCCG_REG_LIST_DCN42B_RI()               \
+	SR(DPPCLK_DTO_CTRL),                       \
+	DCCG_SRII(DTO_PARAM, DPPCLK, 0),       \
+	DCCG_SRII(DTO_PARAM, DPPCLK, 1),       \
+	DCCG_SRII(DTO_PARAM, DPPCLK, 2),       \
+	DCCG_SRII(DTO_PARAM, DPPCLK, 3),       \
+	SR(DCCG_GLOBAL_FGCG_REP_CNTL),\
+	SR(DISPCLK_FREQ_CHANGE_CNTL), \
+	SR(PHYASYMCLK_CLOCK_CNTL),  \
+	SR(PHYBSYMCLK_CLOCK_CNTL), \
+	SR(PHYCSYMCLK_CLOCK_CNTL), \
+	SR(DPSTREAMCLK_CNTL), \
+	SR(SYMCLK32_SE_CNTL), \
+	SR(SYMCLK32_LE_CNTL), \
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0), \
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 1), \
+	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 2), \
+	SR(OTG_PIXEL_RATE_DIV), \
+	SR(DTBCLK_P_CNTL), \
+	SR(DCCG_AUDIO_DTO_SOURCE), \
+	SR(DENTIST_DISPCLK_CNTL), \
+	SR(DPPCLK_CTRL), \
+	DCCG_SRII(MODULO, DP_DTO, 0), \
+	DCCG_SRII(MODULO, DP_DTO, 1), \
+	DCCG_SRII(MODULO, DP_DTO, 2), \
+	DCCG_SRII(PHASE, DP_DTO, 0), \
+	DCCG_SRII(PHASE, DP_DTO, 1), \
+	DCCG_SRII(PHASE, DP_DTO, 2), \
+	SR(OTG_ADD_DROP_PIXEL_CNTL), \
+	SR(DSCCLK0_DTO_PARAM), \
+	SR(DSCCLK1_DTO_PARAM), \
+	SR(DSCCLK2_DTO_PARAM), \
+	SR(DSCCLK_DTO_CTRL), \
+	SR(DCCG_GATE_DISABLE_CNTL), \
+	SR(DCCG_GATE_DISABLE_CNTL2), \
+	SR(DCCG_GATE_DISABLE_CNTL3), \
+	SR(DCCG_GATE_DISABLE_CNTL4), \
+	SR(DCCG_GATE_DISABLE_CNTL5), \
+	SR(DCCG_GATE_DISABLE_CNTL6), \
+	SR(SYMCLKA_CLOCK_ENABLE), \
+	SR(SYMCLKB_CLOCK_ENABLE), \
+	SR(SYMCLKC_CLOCK_ENABLE)
+
+
+/* OPTC */
+#define OPTC_COMMON_REG_LIST_DCN42B_RI(inst)                                      \
+		SRI_ARR(OTG_VSTARTUP_PARAM, OTG, inst),                                      \
+		SRI_ARR(OTG_VUPDATE_PARAM, OTG, inst),                                   \
+		SRI_ARR(OTG_VREADY_PARAM, OTG, inst),                                    \
+		SRI_ARR(OTG_MASTER_UPDATE_LOCK, OTG, inst),                              \
+		SRI_ARR(OTG_MASTER_UPDATE_MODE, OTG, inst),                              \
+		SRI_ARR(OTG_V_COUNT_STOP_CONTROL, OTG, inst),                            \
+		SRI_ARR(OTG_V_COUNT_STOP_CONTROL2, OTG, inst),                           \
+		SRI_ARR(OTG_GSL_CONTROL, OTG, inst),									 \
+		SRI2_ARR(OPTC_CLOCK_CONTROL, OPTC, inst),\
+		SRI_ARR(OTG_GLOBAL_CONTROL0, OTG, inst),                                 \
+		SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
+		SRI_ARR(OTG_GLOBAL_CONTROL2, OTG, inst),                                 \
+		SRI_ARR(OTG_GLOBAL_CONTROL4, OTG, inst),                                 \
+		SRI_ARR(OTG_DOUBLE_BUFFER_CONTROL, OTG, inst),                           \
+		SRI_ARR(OTG_H_TOTAL, OTG, inst),                                         \
+		SRI_ARR(OTG_H_BLANK_START_END, OTG, inst),                               \
+		SRI_ARR(OTG_H_SYNC_A, OTG, inst),\
+		SRI_ARR(OTG_H_SYNC_A_CNTL, OTG, inst), \
+		SRI_ARR(OTG_H_TIMING_CNTL, OTG, inst), \
+		SRI_ARR(OTG_V_TOTAL, OTG, inst),  \
+		SRI_ARR(OTG_V_BLANK_START_END, OTG, inst),                               \
+		SRI_ARR(OTG_V_SYNC_A, OTG, inst), \
+		SRI_ARR(OTG_V_SYNC_A_CNTL, OTG, inst), \
+		SRI_ARR(OTG_CONTROL, OTG, inst), \
+		SRI_ARR(OTG_MASTER_EN, OTG, inst), \
+		SRI_ARR(OTG_LONG_VBLANK_STATUS, OTG, inst), \
+		SRI_ARR(OTG_STEREO_CONTROL, OTG, inst), \
+		SRI_ARR(OTG_3D_STRUCTURE_CONTROL, OTG, inst),                            \
+		SRI_ARR(OTG_STEREO_STATUS, OTG, inst),                                   \
+		SRI_ARR(OTG_V_TOTAL_MAX, OTG, inst),                                     \
+		SRI_ARR(OTG_V_TOTAL_MIN, OTG, inst),                                     \
+		SRI_ARR(OTG_V_TOTAL_CONTROL, OTG, inst),                                 \
+		SRI_ARR(OTG_TRIGA_CNTL, OTG, inst),                                      \
+		SRI_ARR(OTG_FORCE_COUNT_NOW_CNTL, OTG, inst),                            \
+		SRI_ARR(OTG_STATIC_SCREEN_CONTROL, OTG, inst),                           \
+		SRI_ARR(OTG_STATUS_FRAME_COUNT, OTG, inst),                              \
+		SRI_ARR(OTG_STATUS, OTG, inst), 										\
+		SRI_ARR(OTG_STATUS_POSITION, OTG, inst), \
+		SRI_ARR(OTG_NOM_VERT_POSITION, OTG, inst),                               \
+		SRI_ARR(OTG_M_CONST_DTO0, OTG, inst),                                    \
+		SRI_ARR(OTG_M_CONST_DTO1, OTG, inst),                                    \
+		SRI_ARR(OTG_CLOCK_CONTROL, OTG, inst),                                   \
+		SRI_ARR(OTG_COUNT_CONTROL, OTG, inst),                                   \
+		SRI_ARR(OTG_COUNT_RESET, OTG, inst),                                   \
+		SRI_ARR(OTG_CRC_SIG_BLUE_CONTROL_MASK, OTG, inst),                      \
+		SRI_ARR(OTG_CRC_SIG_RED_GREEN_MASK, OTG, inst),                      \
+		SRI_ARR(OTG_DRR_TIMING_INT_STATUS, OTG, inst),                      \
+		SRI_ARR(OTG_VERTICAL_INTERRUPT0_CONTROL, OTG, inst),					 \
+		SRI_ARR(OTG_VERTICAL_INTERRUPT0_POSITION, OTG, inst),                    \
+		SRI_ARR(OTG_VERTICAL_INTERRUPT1_CONTROL, OTG, inst),                     \
+		SRI_ARR(OTG_VERTICAL_INTERRUPT1_POSITION, OTG, inst),                    \
+		SRI_ARR(OTG_VERTICAL_INTERRUPT2_CONTROL, OTG, inst),                     \
+		SRI_ARR(OTG_VERTICAL_INTERRUPT2_POSITION, OTG, inst),                    \
+		SRI_ARR(OPTC_INPUT_CLOCK_CONTROL, ODM, inst),                            \
+		SRI_ARR(OPTC_DATA_SOURCE_SELECT, ODM, inst),                             \
+		SRI_ARR(OPTC_INPUT_GLOBAL_CONTROL, ODM, inst),                           \
+		SRI_ARR(OPTC_RSMU_UNDERFLOW, ODM, inst),                           \
+		SRI_ARR(OPTC_UNDERFLOW_THRESHOLD, ODM, inst),                           \
+		SRI_ARR(CONTROL, VTG, inst), \
+		SRI_ARR(OTG_VERT_SYNC_CONTROL, OTG, inst),  \
+		SRI_ARR(OTG_GSL_CONTROL, OTG, inst), \
+		SRI_ARR(OTG_CRC_CNTL, OTG, inst),   \
+		SRI_ARR(OTG_CRC0_DATA_R, OTG, inst),                                     \
+		SRI_ARR(OTG_CRC0_DATA_G, OTG, inst),                                     \
+		SRI_ARR(OTG_CRC0_DATA_B, OTG, inst),                                     \
+		SRI_ARR(OTG_CRC1_DATA_R, OTG, inst),                                     \
+		SRI_ARR(OTG_CRC1_DATA_G, OTG, inst),                                     \
+		SRI_ARR(OTG_CRC1_DATA_B, OTG, inst),                                     \
+		SRI_ARR(OTG_CRC0_WINDOWA_X_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                          \
+		SRI_ARR(OTG_CRC0_WINDOWA_X_CONTROL_READBACK, OTG, inst),\
+		SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL_READBACK, OTG, inst),\
+		SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL_READBACK, OTG, inst),\
+		SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL_READBACK, OTG, inst),\
+		SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL_READBACK, OTG, inst),\
+		SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL_READBACK, OTG, inst),\
+		SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL_READBACK, OTG, inst),\
+		SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG, inst),\
+		SR_ARR(GSL_SOURCE_SELECT, inst),                                         \
+		SRI_ARR(OTG_TRIGA_MANUAL_TRIG, OTG, inst),                               \
+		SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
+		SRI_ARR(OTG_GLOBAL_CONTROL2, OTG, inst),                                 \
+		SRI_ARR(OTG_GLOBAL_CONTROL3, OTG, inst),                                 \
+		SRI_ARR(OTG_GLOBAL_SYNC_STATUS, OTG, inst),                                 \
+		SRI_ARR(OTG_GSL_WINDOW_X, OTG, inst),                                    \
+		SRI_ARR(OTG_GSL_WINDOW_Y, OTG, inst),                                    \
+		SRI_ARR(OTG_VUPDATE_KEEPOUT, OTG, inst),                                 \
+		SRI_ARR(OTG_DRR_TRIGGER_WINDOW, OTG, inst),                              \
+		SRI_ARR(OTG_DRR_V_TOTAL_CHANGE, OTG, inst),                              \
+		SRI_ARR(OPTC_DATA_FORMAT_CONTROL, ODM, inst),                            \
+		SRI_ARR(OPTC_BYTES_PER_PIXEL, ODM, inst),                                \
+		SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
+		SRI_ARR(OPTC_WIDTH_CONTROL2, ODM, inst),                                 \
+		SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
+		SRI_ARR(OTG_DRR_CONTROL, OTG, inst),                                     \
+		SRI_ARR(OTG_DRR_CONTOL2, OTG, inst),                                     \
+		SRI_ARR(OTG_PSTATE_REGISTER, OTG, inst),                                 \
+		SRI_ARR(OTG_PWA_FRAME_SYNC_CONTROL, OTG, inst),\
+		SRI_ARR(OTG_PIPE_UPDATE_STATUS, OTG, inst),\
+		SRI_ARR(INTERRUPT_DEST, OTG, inst)
+
+/* CLK SRC */
+/**
+ *	 Not used in DCN42B:
+ *   SRII_ARR_2(PHASE, DP_DTO, 3, index),                                     \
+ *   SRII_ARR_2(MODULO, DP_DTO, 3, index),                                    \
+ *   SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 3, index)
+ */
+#define CS_COMMON_REG_LIST_DCN42B_RI(index, pllid)               \
+	SRI_ARR_ALPHABET(PIXCLK_RESYNC_CNTL, PHYPLL, index, pllid), \
+		SRII_ARR_2(PHASE, DP_DTO, 0, index),                    \
+		SRII_ARR_2(PHASE, DP_DTO, 1, index),                    \
+		SRII_ARR_2(PHASE, DP_DTO, 2, index),                    \
+		SRII_ARR_2(MODULO, DP_DTO, 0, index),                   \
+		SRII_ARR_2(MODULO, DP_DTO, 1, index),                   \
+		SRII_ARR_2(MODULO, DP_DTO, 2, index),                   \
+		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 0, index),             \
+		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 1, index),             \
+		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 2, index)
+
+/* ABM */
+#define ABM_DCN42B_REG_LIST_RI(id)                               \
+	SRI_ARR(DC_ABM1_HG_SAMPLE_RATE, ABM, id),                   \
+		SRI_ARR(DC_ABM1_LS_SAMPLE_RATE, ABM, id),               \
+		SRI_ARR(DC_ABM1_HG_MISC_CTRL, ABM, id),                 \
+		SRI_ARR(DC_ABM1_IPCSC_COEFF_SEL, ABM, id),              \
+		SRI_ARR(BL1_PWM_BL_UPDATE_SAMPLE_RATE, ABM, id),        \
+		SRI_ARR(BL1_PWM_CURRENT_ABM_LEVEL, ABM, id),            \
+		SRI_ARR(BL1_PWM_TARGET_ABM_LEVEL, ABM, id),             \
+		SRI_ARR(BL1_PWM_USER_LEVEL, ABM, id),                   \
+		SRI_ARR(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, ABM, id), \
+		SRI_ARR(DC_ABM1_HGLS_REG_READ_PROGRESS, ABM, id),       \
+		SRI_ARR(DC_ABM1_HG_BIN_33_40_SHIFT_INDEX, ABM, id),     \
+		SRI_ARR(DC_ABM1_HG_BIN_33_64_SHIFT_FLAG, ABM, id),      \
+		SRI_ARR(DC_ABM1_HG_BIN_41_48_SHIFT_INDEX, ABM, id),     \
+		SRI_ARR(DC_ABM1_HG_BIN_49_56_SHIFT_INDEX, ABM, id),     \
+		SRI_ARR(DC_ABM1_HG_BIN_57_64_SHIFT_INDEX, ABM, id),     \
+		SRI_ARR(DC_ABM1_HG_RESULT_DATA, ABM, id),               \
+		SRI_ARR(DC_ABM1_HG_RESULT_INDEX, ABM, id),              \
+		SRI_ARR(DC_ABM1_ACE_OFFSET_SLOPE_DATA, ABM, id),        \
+		SRI_ARR(DC_ABM1_ACE_PWL_CNTL, ABM, id)
+
+/* HUBP */
+/* Not in DCN42B: HUBPREQ_DEBUG_DB and HUBPREQ_DEBUG */
+#define HUBP_REG_LIST_DCN42B_RI(id)                                         \
+	SRI_ARR(DCN_DMDATA_VM_CNTL, HUBPREQ, id),                               \
+	SRI_ARR(FLIP_PARAMETERS_3, HUBPREQ, id),                               \
+	SRI_ARR(FLIP_PARAMETERS_4, HUBPREQ, id),                               \
+	SRI_ARR(FLIP_PARAMETERS_5, HUBPREQ, id),                               \
+	SRI_ARR(FLIP_PARAMETERS_6, HUBPREQ, id),                               \
+	SRI_ARR(VBLANK_PARAMETERS_5, HUBPREQ, id),                             \
+	SRI_ARR(VBLANK_PARAMETERS_6, HUBPREQ, id),                             \
+	HUBP_REG_LIST_DCN_VM_RI(id),                                            \
+	SRI_ARR(PREFETCH_SETTINGS, HUBPREQ, id),                               \
+	SRI_ARR(PREFETCH_SETTINGS_C, HUBPREQ, id),                             \
+	SRI_ARR(DCN_VM_SYSTEM_APERTURE_LOW_ADDR, HUBPREQ, id),                 \
+	SRI_ARR(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR, HUBPREQ, id),                \
+	SRI_ARR(CURSOR_SETTINGS, HUBPREQ, id),                                 \
+	SRI_ARR(CURSOR_SURFACE_ADDRESS_HIGH, CURSOR0_, id),                    \
+	SRI_ARR(CURSOR_SURFACE_ADDRESS, CURSOR0_, id),                         \
+	SRI_ARR(CURSOR_SIZE, CURSOR0_, id),                                    \
+	SRI_ARR(CURSOR_CONTROL, CURSOR0_, id),                                 \
+	SRI_ARR(CURSOR_POSITION, CURSOR0_, id),                                \
+	SRI_ARR(CURSOR_HOT_SPOT, CURSOR0_, id),                                \
+	SRI_ARR(CURSOR_DST_OFFSET, CURSOR0_, id),                              \
+	SRI_ARR(DMDATA_ADDRESS_HIGH, CURSOR0_, id),                            \
+	SRI_ARR(DMDATA_ADDRESS_LOW, CURSOR0_, id),                             \
+	SRI_ARR(DMDATA_CNTL, CURSOR0_, id),                                    \
+	SRI_ARR(DMDATA_SW_CNTL, CURSOR0_, id),                                 \
+	SRI_ARR(DMDATA_QOS_CNTL, CURSOR0_, id),                                \
+	SRI_ARR(DMDATA_SW_DATA, CURSOR0_, id),                                 \
+	SRI_ARR(DMDATA_STATUS, CURSOR0_, id),                                  \
+	SRI_ARR(FLIP_PARAMETERS_0, HUBPREQ, id),                               \
+	SRI_ARR(FLIP_PARAMETERS_1, HUBPREQ, id),                               \
+	SRI_ARR(FLIP_PARAMETERS_2, HUBPREQ, id),                               \
+	SRI_ARR(DCN_CUR1_TTU_CNTL0, HUBPREQ, id),                              \
+	SRI_ARR(DCN_CUR1_TTU_CNTL1, HUBPREQ, id),                              \
+	SRI_ARR(DCSURF_FLIP_CONTROL2, HUBPREQ, id),                            \
+	SRI_ARR(VMID_SETTINGS_0, HUBPREQ, id),                                 \
+	SRI_ARR(DCHUBP_CNTL, HUBP, id),                                        \
+	SRI_ARR(DCSURF_ADDR_CONFIG, HUBP, id),                                 \
+	SRI_ARR(DCSURF_TILING_CONFIG, HUBP, id),                               \
+	SRI_ARR(DCSURF_SURFACE_PITCH, HUBPREQ, id),                            \
+	SRI_ARR(DCSURF_SURFACE_PITCH_C, HUBPREQ, id),                          \
+	SRI_ARR(DCSURF_SURFACE_CONFIG, HUBP, id),                              \
+	SRI_ARR(DCSURF_FLIP_CONTROL, HUBPREQ, id),                             \
+	SRI_ARR(DCSURF_PRI_VIEWPORT_DIMENSION, HUBP, id),                      \
+	SRI_ARR(DCSURF_PRI_VIEWPORT_START, HUBP, id),                          \
+	SRI_ARR(DCSURF_SEC_VIEWPORT_DIMENSION, HUBP, id),                      \
+	SRI_ARR(DCSURF_SEC_VIEWPORT_START, HUBP, id),                          \
+	SRI_ARR(DCSURF_PRI_VIEWPORT_DIMENSION_C, HUBP, id),                    \
+	SRI_ARR(DCSURF_PRI_VIEWPORT_START_C, HUBP, id),                        \
+	SRI_ARR(DCSURF_SEC_VIEWPORT_DIMENSION_C, HUBP, id),                    \
+	SRI_ARR(DCSURF_SEC_VIEWPORT_START_C, HUBP, id),                        \
+	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, HUBPREQ, id),             \
+	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS, HUBPREQ, id),                  \
+	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH, HUBPREQ, id),           \
+	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS, HUBPREQ, id),                \
+	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, HUBPREQ, id),        \
+	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS, HUBPREQ, id),             \
+	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH, HUBPREQ, id),      \
+	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS, HUBPREQ, id),           \
+	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),           \
+	SRI_ARR(DCSURF_PRIMARY_SURFACE_ADDRESS_C, HUBPREQ, id),                \
+	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),         \
+	SRI_ARR(DCSURF_SECONDARY_SURFACE_ADDRESS_C, HUBPREQ, id),              \
+	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),      \
+	SRI_ARR(DCSURF_PRIMARY_META_SURFACE_ADDRESS_C, HUBPREQ, id),           \
+	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH_C, HUBPREQ, id),    \
+	SRI_ARR(DCSURF_SECONDARY_META_SURFACE_ADDRESS_C, HUBPREQ, id),         \
+	SRI_ARR(DCSURF_SURFACE_INUSE, HUBPREQ, id),                            \
+	SRI_ARR(DCSURF_SURFACE_INUSE_HIGH, HUBPREQ, id),                       \
+	SRI_ARR(DCSURF_SURFACE_INUSE_C, HUBPREQ, id),                          \
+	SRI_ARR(DCSURF_SURFACE_INUSE_HIGH_C, HUBPREQ, id),                     \
+	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE, HUBPREQ, id),                   \
+	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE_HIGH, HUBPREQ, id),              \
+	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE_C, HUBPREQ, id),                 \
+	SRI_ARR(DCSURF_SURFACE_EARLIEST_INUSE_HIGH_C, HUBPREQ, id),            \
+	SRI_ARR(DCSURF_SURFACE_CONTROL, HUBPREQ, id),                          \
+	SRI_ARR(DCSURF_SURFACE_FLIP_INTERRUPT, HUBPREQ, id),                   \
+	SRI_ARR(HUBPRET_CONTROL, HUBPRET, id),                                 \
+	SRI_ARR(HUBPRET_READ_LINE_STATUS, HUBPRET, id),                        \
+	SRI_ARR(DCN_EXPANSION_MODE, HUBPREQ, id),                              \
+	SRI_ARR(DCHUBP_REQ_SIZE_CONFIG, HUBP, id),                             \
+	SRI_ARR(DCHUBP_REQ_SIZE_CONFIG_C, HUBP, id),                           \
+	SRI_ARR(BLANK_OFFSET_0, HUBPREQ, id),                                  \
+	SRI_ARR(BLANK_OFFSET_1, HUBPREQ, id),                                  \
+	SRI_ARR(DST_DIMENSIONS, HUBPREQ, id),                                  \
+	SRI_ARR(DST_AFTER_SCALER, HUBPREQ, id),                                \
+	SRI_ARR(VBLANK_PARAMETERS_0, HUBPREQ, id),                             \
+	SRI_ARR(REF_FREQ_TO_PIX_FREQ, HUBPREQ, id),                            \
+	SRI_ARR(VBLANK_PARAMETERS_1, HUBPREQ, id),                             \
+	SRI_ARR(VBLANK_PARAMETERS_3, HUBPREQ, id),                             \
+	SRI_ARR(NOM_PARAMETERS_4, HUBPREQ, id),                                \
+	SRI_ARR(NOM_PARAMETERS_5, HUBPREQ, id),                                \
+	SRI_ARR(PER_LINE_DELIVERY_PRE, HUBPREQ, id),                           \
+	SRI_ARR(PER_LINE_DELIVERY, HUBPREQ, id),                               \
+	SRI_ARR(VBLANK_PARAMETERS_2, HUBPREQ, id),                             \
+	SRI_ARR(VBLANK_PARAMETERS_4, HUBPREQ, id),                             \
+	SRI_ARR(NOM_PARAMETERS_6, HUBPREQ, id),                                \
+	SRI_ARR(NOM_PARAMETERS_7, HUBPREQ, id),                                \
+	SRI_ARR(DCN_TTU_QOS_WM, HUBPREQ, id),                                  \
+	SRI_ARR(DCN_GLOBAL_TTU_CNTL, HUBPREQ, id),                             \
+	SRI_ARR(DCN_SURF0_TTU_CNTL0, HUBPREQ, id),                             \
+	SRI_ARR(DCN_SURF0_TTU_CNTL1, HUBPREQ, id),                             \
+	SRI_ARR(DCN_SURF1_TTU_CNTL0, HUBPREQ, id),                             \
+	SRI_ARR(DCN_SURF1_TTU_CNTL1, HUBPREQ, id),                             \
+	SRI_ARR(DCN_CUR0_TTU_CNTL0, HUBPREQ, id),                              \
+	SRI_ARR(DCN_CUR0_TTU_CNTL1, HUBPREQ, id),                              \
+	SRI_ARR(HUBP_CLK_CNTL, HUBP, id),                                      \
+	SRI_ARR(HUBPRET_READ_LINE_VALUE, HUBPRET, id),                         \
+	SRI_ARR(DCHUBP_MALL_CONFIG, HUBP, id),                                 \
+	SRI_ARR(DCHUBP_VMPG_CONFIG, HUBP, id),                                 \
+	SRI_ARR(UCLK_PSTATE_FORCE, HUBPREQ, id),                               \
+	SRI_ARR(HUBP_3DLUT_DLG_PARAM, CURSOR0_, id),                           \
+	HUBP_3DLUT_FL_REG_LIST_DCN401(id)
+struct dcn42b_resource_pool {
+	struct resource_pool base;
+};
+struct resource_pool *dcn42b_create_resource_pool(
+	const struct dc_init_data *init_data,
+	struct dc *dc);
+
+enum dc_status dcn42b_validate_bandwidth(struct dc *dc,
+							  struct dc_state *context,
+							  enum dc_validate_mode validate_mode);
+
+void dcn42b_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
+
+#endif /* _DCN42B_RESOURCE_H_ */
-- 
2.43.0


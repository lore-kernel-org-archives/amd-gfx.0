Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C510C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBD410ED03;
	Wed,  5 Aug 2026 06:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJTWV683";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F3710ED02
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIqkYL5MLJLEVbs41UwggkVmfvI3gqq6dpY/BL/DKJyFOJi8lXX18wiE5WmGLTd9ZFc8N15oiESpdj3k8PeaESB0PPYCqwVI4BbrUUZdsKPCYWWAkMnN4E9YCqbiCT632cjgNvU6xcb74gOH6dkR0vGzr9FpzIhJ2rK3MxrAK11kvMFsi1T7GfG7r5S1KiAGI8ZtcpD5dSw2jpnA5biXfG/HPguhqLpy1rc4cmHmnduNlAsP6+pqEhqNTPscXYJ3bGKw4ZqZ+4kEQ0XfstQ6qVE+OqDqcxbDI6yIpCSNlMs45NHJuz9q02xHnuuKUEZWg9IK13Xj3t0y8FMLQdCW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia5N/B2iVvYqgRSWIOVVRdV4AYr8rKG4zz1YigPRUdo=;
 b=jphbk1QD9HRf0wKWmlA1c7awxcsBAXhF0C/oRO94PdU0NxwpYVF1EqRlpCrUp5xN/4uEr0dOtYvvA76KyBFfmGXGZeyYO+doMVd53PeX2ojlDWpRf3F3f4lC4uEZd/durDBg94gK9ZvRGWfcO/bb4+AqgBqvzFjjeer6rDfzFqA98uevKSKGH39Z7zmws8V9AB6uaUTbWy7fMK8NkKyMe/ikCfsBJzquAydS0Fc39ip1NPOgmgUSzHQMxd7zc+pp7339dShM58rD8MxvT/zA2WsNUvJoeU1wDd5Z3AJ0RwlaJ/+lbL3itkzOHOxAS4xaG2slFBw3l0ybFqUrijHsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia5N/B2iVvYqgRSWIOVVRdV4AYr8rKG4zz1YigPRUdo=;
 b=vJTWV683HxFdRNNETbGLXqG8CL+PeYWWvod8xPr9s719y/hTd2JCXhr8feP2FzzPgGFPfkR98OcLf/HdZQliK8D5hUvQSCinoQKrm0nfDNN6AJ27THx68GiEO9jUXjz/KawhnsMkukCYzKc2Jtd0tgfiphkvtUMerudWdXNdrRA=
Received: from BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Wed, 5 Aug
 2026 06:40:52 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::5d) by BL0PR05CA0020.outlook.office365.com
 (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:49 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:46 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 15/34] drm/amd/display: gate DCE ASIC code behind
 CONFIG_DRM_AMD_DC_DCE
Date: Wed, 5 Aug 2026 14:36:27 +0800
Message-ID: <20260805063937.2145774-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b191400-2024-404f-0940-08def2bc7e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|3023799007|56012099006|11063799006|10067099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: pffm0yueZa01P14x0Eyga5HsVRx2+AdAUEnskNqjwElILLgj6ZI/kpUjwA3VqqYY8qUevCQBgKnkBGk0PXx/1hBJKrVM0WJd77+gERNTa9PmNL+71Y7GKwn8uSEAd8dRHMH8lCbuHH5OK9Bb29wnDiQf9FbrKkSDUaV3S5wR2Yzyuqb+EuVVsUuNk9grOaprRWzNOUtIpTZDGtX1USM2N4HEpxMZGJZvjHwgqOx09vql3VMgmUAju9xKsPjCMXyZD4Ck8/1SDV4/XUjDS8OaVUKw6GsQaM1yJoKEC7Q16U2YdxtGhYaAJ72jtC97BF/6yzDV0ZRBVtr6V1LHNbaRGe3t1sxMMKal6GwlHy8U05k0mflABKJkWSzsuDMy/EpzB1CUvdgdvdY9OtN34l5NBGGaYmvSSJDctL/mNUy1GglBYSnWB8qt72PTPywJdgQx4oExytosB8HopLPb/hvI9AZ3JPCx3fLSXsyNdb6ngIlNM52BxlGwzKiUf8p0RZG5VFV8bWNSO1A51Vn8AyQwHxhqMLosY66+RcGVttBz9G3ocFCVP5y5CzJeF6NoR7Zj5K+1rPPbQNofinGzOAey2hES2iwjXy8r6yW3J7dJfMDsskWgiL3ws2QwdEr0xrezmp/8DPx9KiuHin7s2vstapqaD63acobdh12nsOh51H+10iOMI/ZbXKYeKH496i0V0UwpZt8tYZEXpuf65np5ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zxaPe+iP0LtqIhJhm0t8hmJ0YXa/+CkSw4X2bcGBPO+ARq7pt6g20ttb8dLZP8aY4VxH55zOBBfVNfZMKWKSQ+TZXSYZALQ3NPaLEWHe8bIAj1kcBEsO0w8jcfrN7cLGTCiA1RJhQKlyYMkauXgy5aQ8NNDKbx4lv89efgIVpxVcua4HBhd/YKUXp7p3+5CBTVvbxy32nG0+bvu/F9Qm+bPmPSBhDFcQZrBWnutalDaSOdpSAZhLUR5/vU0S/JjXb1BC67lL4YEQ3zS0GtNpCzhvyrbaU7VFCWkyxwrS+T1mRORBsxb9ZYSPUwm6/PkfCkKai3GBZ6QDjj0FoOS9jvw4widObZvKtoraL76JkbtZL1DEvEb5QayupJpyJFhMA6JKalEKA5qt25b8HBzZr8/a24isUASHFbKE72CTVEoWHyiBe8TvoiAQ+CGyGgBy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:51.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b191400-2024-404f-0940-08def2bc7e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why&How]
Refactor to make DCE support optional.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |   9 +
 .../display/dc/bios/command_table_helper.c    |   7 +-
 .../display/dc/bios/command_table_helper2.c   |   2 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   8 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   4 +
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 115 -----------
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   8 +-
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  59 ------
 .../dc/clk_mgr/dce112/dce112_clk_mgr.h        |   4 +-
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  | 181 ++++++++++++++++++
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h  |  29 +++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  79 ++++++++
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   4 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   6 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   2 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   2 +
 .../dc/irq/dce110/irq_service_dce110.c        |  21 --
 .../dc/irq/dce110/irq_service_dce110.h        |   9 -
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |  28 +++
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |   9 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |   4 +
 .../dc/resource/dce112/dce112_resource.c      |  62 ------
 23 files changed, 380 insertions(+), 276 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 1727d25646cc..617bc1932524 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -34,11 +34,20 @@ config DRM_AMD_DC_SI
 	bool "AMD DC support for Southern Islands ASICs"
 	depends on DRM_AMDGPU_SI
 	depends on DRM_AMD_DC
+	depends on DRM_AMD_DC_DCE
 	help
 	  Choose this option to enable new AMD DC support for SI asics
 	  by default. This includes Tahiti, Pitcairn, Cape Verde, Oland.
 	  Hainan is not supported by AMD DC and it has no physical DCE6.
 
+config DRM_AMD_DC_DCE
+	bool "AMD DC support for legacy DCE ASICs"
+	default y
+	depends on DRM_AMD_DC
+	help
+	  Enable support for the legacy DCE (DCE 8/10/11/12) display engines.
+	  Enabled by default so DC keeps support for these older ASICs.
+
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
 	depends on DRM_AMD_DC
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
index 91bc8a06e2cf..ab67771ddab4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
@@ -35,7 +35,10 @@ bool dal_bios_parser_init_cmd_tbl_helper(
 	const struct command_table_helper **h,
 	enum dce_version dce)
 {
-	switch (dce) {
+  if (!h)
+    return false;
+
+  switch (dce) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
 	case DCE_VERSION_6_0:
 	case DCE_VERSION_6_1:
@@ -44,6 +47,7 @@ bool dal_bios_parser_init_cmd_tbl_helper(
 		return true;
 #endif
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
@@ -62,6 +66,7 @@ bool dal_bios_parser_init_cmd_tbl_helper(
 	case DCE_VERSION_11_22:
 		*h = dal_cmd_tbl_helper_dce112_get_table();
 		return true;
+#endif
 
 	default:
 		/* Unsupported DCE */
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 9ae5cf42754a..ea0a270e9de3 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -45,6 +45,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 		return true;
 #endif
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
@@ -58,6 +59,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCE_VERSION_11_0:
 		*h = dal_cmd_tbl_helper_dce110_get_table();
 		return true;
+#endif
 
 	case DCE_VERSION_11_2:
 	case DCE_VERSION_11_22:
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 8cfd7bf57fbe..c803a2bdf749 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -29,6 +29,7 @@ AMD_DAL_CLK_MGR = $(addprefix $(AMDDALPATH)/dc/clk_mgr/,$(CLK_MGR))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR)
 
+ifdef CONFIG_DRM_AMD_DC_DCE
 ###############################################################################
 # DCE 100 and DCE8x
 ###############################################################################
@@ -62,6 +63,13 @@ CLK_MGR_DCE120 = dce120_clk_mgr.o
 AMD_DAL_CLK_MGR_DCE120 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dce120/,$(CLK_MGR_DCE120))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCE120)
+endif # CONFIG_DRM_AMD_DC_DCE
+
+# Shared clock helpers used by both the DCE and DCN clock managers. Built
+# unconditionally (not gated on CONFIG_DRM_AMD_DC_FP) so non-FP configs that
+# still build the DCE clock managers can resolve them.
+AMD_DISPLAY_FILES += $(AMDDALPATH)/dc/clk_mgr/dcn10/dcn10_clk_mgr.o
+
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN10
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index e2148cb3b8ab..bdc755be7bf6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -30,10 +30,12 @@
 #include "dc_state_priv.h"
 #include "link_service.h"
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 #include "dce100/dce_clk_mgr.h"
 #include "dce110/dce110_clk_mgr.h"
 #include "dce112/dce112_clk_mgr.h"
 #include "dce120/dce120_clk_mgr.h"
+#endif
 #include "dcn10/rv1_clk_mgr.h"
 #include "dcn10/rv2_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
@@ -152,6 +154,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	struct hw_asic_id asic_id = ctx->asic_id;
 
 	switch (asic_id.chip_family) {
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 	case FAMILY_SI:
 	case FAMILY_CI:
 	case FAMILY_KV: {
@@ -211,6 +214,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			dce120_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
+#endif
 #if defined(CONFIG_DRM_AMD_DC_FP)
 	case FAMILY_RV: {
 		struct clk_mgr_internal *clk_mgr = kzalloc_obj(*clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index d891b3bfe2a1..42e6d6538825 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -62,56 +62,6 @@ static const struct clk_mgr_mask disp_clk_mask = {
 		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-unsigned int dentist_get_divider_from_did(unsigned int did)
-{
-	if (did < DENTIST_BASE_DID_1)
-		did = DENTIST_BASE_DID_1;
-	if (did > DENTIST_MAX_DID)
-		did = DENTIST_MAX_DID;
-
-	if (did < DENTIST_BASE_DID_2) {
-		return DENTIST_DIVIDER_RANGE_1_START + DENTIST_DIVIDER_RANGE_1_STEP
-							* (did - DENTIST_BASE_DID_1);
-	} else if (did < DENTIST_BASE_DID_3) {
-		return DENTIST_DIVIDER_RANGE_2_START + DENTIST_DIVIDER_RANGE_2_STEP
-							* (did - DENTIST_BASE_DID_2);
-	} else if (did < DENTIST_BASE_DID_4) {
-		return DENTIST_DIVIDER_RANGE_3_START + DENTIST_DIVIDER_RANGE_3_STEP
-							* (did - DENTIST_BASE_DID_3);
-	} else {
-		return DENTIST_DIVIDER_RANGE_4_START + DENTIST_DIVIDER_RANGE_4_STEP
-							* (did - DENTIST_BASE_DID_4);
-	}
-}
-
-/* SW will adjust DP REF Clock average value for all purposes
- * (DP DTO / DP Audio DTO and DP GTC)
- if clock is spread for all cases:
- -if SS enabled on DP Ref clock and HW de-spreading enabled with SW
- calculations for DS_INCR/DS_MODULO (this is planned to be default case)
- -if SS enabled on DP Ref clock and HW de-spreading enabled with HW
- calculations (not planned to be used, but average clock should still
- be valid)
- -if SS enabled on DP Ref clock and HW de-spreading disabled
- (should not be case with CIK) then SW should program all rates
- generated according to average value (case as with previous ASICs)
-  */
-
-int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz)
-{
-	if (clk_mgr_dce->ss_on_dprefclk && clk_mgr_dce->dprefclk_ss_divider != 0) {
-		struct fixed31_32 ss_percentage = dc_fixpt_div_int(
-				dc_fixpt_from_fraction(clk_mgr_dce->dprefclk_ss_percentage,
-							clk_mgr_dce->dprefclk_ss_divider), 200);
-		struct fixed31_32 adj_dp_ref_clk_khz;
-
-		ss_percentage = dc_fixpt_sub(dc_fixpt_one, ss_percentage);
-		adj_dp_ref_clk_khz = dc_fixpt_mul_int(ss_percentage, dp_ref_clk_khz);
-		dp_ref_clk_khz = dc_fixpt_floor(adj_dp_ref_clk_khz);
-	}
-	return dp_ref_clk_khz;
-}
-
 static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -155,13 +105,6 @@ int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
 }
 
-int dce12_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-
-	return dce_adjust_dp_ref_freq_for_ss(clk_mgr_dce, clk_mgr_base->dprefclk_khz);
-}
-
 /* unit: in_khz before mode set, get pixel clock from context. ASIC register
  * may not be programmed yet
  */
@@ -256,64 +199,6 @@ static void dce_clock_read_integrated_info(struct clk_mgr_internal *clk_mgr_dce)
 			clk_mgr_dce->dfs_bypass_enabled = true;
 }
 
-void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
-{
-	struct dc_bios *bp = clk_mgr_dce->base.ctx->dc_bios;
-	int ss_info_num = bp->funcs->get_ss_entry_number(
-			bp, AS_SIGNAL_TYPE_GPU_PLL);
-
-	if (ss_info_num) {
-		struct spread_spectrum_info info = { { 0 } };
-		enum bp_result result = bp->funcs->get_spread_spectrum_info(
-				bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
-
-		/* Based on VBIOS, VBIOS will keep entry for GPU PLL SS
-		 * even if SS not enabled and in that case
-		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
-		 * that SS is enabled
-		 */
-		if (result == BP_RESULT_OK &&
-				info.spread_spectrum_percentage != 0) {
-			clk_mgr_dce->ss_on_dprefclk = true;
-			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
-
-			if (info.type.CENTER_MODE == 0) {
-				/* TODO: Currently for DP Reference clock we
-				 * need only SS percentage for
-				 * downspread */
-				clk_mgr_dce->dprefclk_ss_percentage =
-						info.spread_spectrum_percentage;
-			}
-
-			return;
-		}
-
-		result = bp->funcs->get_spread_spectrum_info(
-				bp, AS_SIGNAL_TYPE_DISPLAY_PORT, 0, &info);
-
-		/* Based on VBIOS, VBIOS will keep entry for DPREFCLK SS
-		 * even if SS not enabled and in that case
-		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
-		 * that SS is enabled
-		 */
-		if (result == BP_RESULT_OK &&
-				info.spread_spectrum_percentage != 0) {
-			clk_mgr_dce->ss_on_dprefclk = true;
-			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
-
-			if (info.type.CENTER_MODE == 0) {
-				/* Currently for DP Reference clock we
-				 * need only SS percentage for
-				 * downspread */
-				clk_mgr_dce->dprefclk_ss_percentage =
-						info.spread_spectrum_percentage;
-			}
-			if (clk_mgr_dce->base.ctx->dc->config.ignore_dpref_ss)
-				clk_mgr_dce->dprefclk_ss_percentage = 0;
-		}
-	}
-}
-
 static void dce_pplib_apply_display_requirements(
 	struct dc *dc,
 	struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
index e1c6a92d7957..2f4165f1a7bc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
@@ -28,9 +28,9 @@
 #define _DCE_CLK_MGR_H_
 
 #include "dc.h"
+#include "dcn10/dcn10_clk_mgr.h"
 
 /* functions shared by other dce clk mgrs */
-int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
 int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base);
 
 uint32_t dce_get_max_pixel_clock_for_all_paths(struct dc_state *context);
@@ -40,10 +40,6 @@ void dce_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_internal *clk_mgr_dce);
 
-void dce_clock_read_ss_info(struct clk_mgr_internal *dccg_dce);
-
-int dce12_get_dp_ref_freq_khz(struct clk_mgr *dccg);
-
 int dce_set_clock(
 	struct clk_mgr *clk_mgr_base,
 	int requested_clk_khz);
@@ -51,6 +47,4 @@ int dce_set_clock(
 
 void dce_clk_mgr_destroy(struct clk_mgr **clk_mgr);
 
-unsigned int dentist_get_divider_from_did(unsigned int did);
-
 #endif /* _DCE_CLK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index 08ed6f88025f..2157761c3b4b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -101,65 +101,6 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 	return actual_clock;
 }
 
-int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
-{
-	struct bp_set_dce_clock_parameters dce_clk_params;
-	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
-	struct dc *dc = clk_mgr->base.ctx->dc;
-	struct dmcu *dmcu = dc->res_pool->dmcu;
-	int actual_clock = requested_clk_khz;
-	/* Prepare to program display clock*/
-	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
-
-	/* Make sure requested clock isn't lower than minimum threshold*/
-	if (requested_clk_khz > 0)
-		requested_clk_khz = max(requested_clk_khz,
-				clk_mgr->base.dentist_vco_freq_khz / 62);
-
-	dce_clk_params.target_clock_frequency = requested_clk_khz;
-	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
-	dce_clk_params.clock_type = DCECLOCK_TYPE_DISPLAY_CLOCK;
-
-	bp->funcs->set_dce_clock(bp, &dce_clk_params);
-	actual_clock = dce_clk_params.target_clock_frequency;
-
-	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
-		if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
-			dmcu->funcs->set_psr_wait_loop(dmcu,
-					actual_clock / 1000 / 7);
-	}
-
-	clk_mgr->dfs_bypass_disp_clk = actual_clock;
-	return actual_clock;
-
-}
-
-int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr)
-{
-	struct bp_set_dce_clock_parameters dce_clk_params;
-	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
-
-	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
-
-	/*Program DP ref Clock*/
-	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
-	dce_clk_params.target_clock_frequency = 0;
-	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
-	dce_clk_params.clock_type = DCECLOCK_TYPE_DPREFCLK;
-	if (!((clk_mgr->base.ctx->asic_id.chip_family == FAMILY_AI) &&
-	       ASICREV_IS_VEGA20_P(clk_mgr->base.ctx->asic_id.hw_internal_rev)))
-		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK =
-			(dce_clk_params.pll_id ==
-					CLOCK_SOURCE_COMBO_DISPLAY_PLL0);
-	else
-		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK = false;
-
-	bp->funcs->set_dce_clock(bp, &dce_clk_params);
-
-	/* Returns the dp_refclk that was set */
-	return dce_clk_params.target_clock_frequency;
-}
-
 static void dce112_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h
index dfb06db118e1..766b73c19365 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h
@@ -26,6 +26,8 @@
 #ifndef DAL_DC_DCE_DCE112_CLK_MGR_H_
 #define DAL_DC_DCE_DCE112_CLK_MGR_H_
 
+/* dce112_set_dispclk and dce112_set_dprefclk are declared here. */
+#include "dcn10/dcn10_clk_mgr.h"
 
 void dce112_clk_mgr_construct(
 		struct dc_context *ctx,
@@ -33,7 +35,5 @@ void dce112_clk_mgr_construct(
 
 /* functions shared with other clk mgr */
 int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz);
-int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz);
-int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr);
 
 #endif /* DAL_DC_DCE_DCE112_CLK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
new file mode 100644
index 000000000000..75d5c90e7707
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "clk_mgr_internal.h"
+#include "core_types.h"
+#include "dal_asic_id.h"
+#include "dcn10_clk_mgr.h"
+
+unsigned int dentist_get_divider_from_did(unsigned int did)
+{
+	if (did < DENTIST_BASE_DID_1)
+		did = DENTIST_BASE_DID_1;
+	if (did > DENTIST_MAX_DID)
+		did = DENTIST_MAX_DID;
+
+	if (did < DENTIST_BASE_DID_2) {
+		return DENTIST_DIVIDER_RANGE_1_START + DENTIST_DIVIDER_RANGE_1_STEP
+							* (did - DENTIST_BASE_DID_1);
+	} else if (did < DENTIST_BASE_DID_3) {
+		return DENTIST_DIVIDER_RANGE_2_START + DENTIST_DIVIDER_RANGE_2_STEP
+							* (did - DENTIST_BASE_DID_2);
+	} else if (did < DENTIST_BASE_DID_4) {
+		return DENTIST_DIVIDER_RANGE_3_START + DENTIST_DIVIDER_RANGE_3_STEP
+							* (did - DENTIST_BASE_DID_3);
+	} else {
+		return DENTIST_DIVIDER_RANGE_4_START + DENTIST_DIVIDER_RANGE_4_STEP
+							* (did - DENTIST_BASE_DID_4);
+	}
+}
+
+/* SW will adjust DP REF Clock average value for all purposes
+ * (DP DTO / DP Audio DTO and DP GTC)
+ if clock is spread for all cases:
+ -if SS enabled on DP Ref clock and HW de-spreading enabled with SW
+ calculations for DS_INCR/DS_MODULO (this is planned to be default case)
+ -if SS enabled on DP Ref clock and HW de-spreading enabled with HW
+ calculations (not planned to be used, but average clock should still
+ be valid)
+ -if SS enabled on DP Ref clock and HW de-spreading disabled
+ (should not be case with CIK) then SW should program all rates
+ generated according to average value (case as with previous ASICs)
+  */
+int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz)
+{
+	if (clk_mgr_dce->ss_on_dprefclk && clk_mgr_dce->dprefclk_ss_divider != 0) {
+		struct fixed31_32 ss_percentage = dc_fixpt_div_int(
+				dc_fixpt_from_fraction(clk_mgr_dce->dprefclk_ss_percentage,
+							clk_mgr_dce->dprefclk_ss_divider), 200);
+		struct fixed31_32 adj_dp_ref_clk_khz;
+
+		ss_percentage = dc_fixpt_sub(dc_fixpt_one, ss_percentage);
+		adj_dp_ref_clk_khz = dc_fixpt_mul_int(ss_percentage, dp_ref_clk_khz);
+		dp_ref_clk_khz = dc_fixpt_floor(adj_dp_ref_clk_khz);
+	}
+	return dp_ref_clk_khz;
+}
+
+int dce12_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return dce_adjust_dp_ref_freq_for_ss(clk_mgr_dce, clk_mgr_base->dprefclk_khz);
+}
+
+void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
+{
+	struct dc_bios *bp = clk_mgr_dce->base.ctx->dc_bios;
+	int ss_info_num = bp->funcs->get_ss_entry_number(
+			bp, AS_SIGNAL_TYPE_GPU_PLL);
+
+	if (ss_info_num) {
+		struct spread_spectrum_info info = { { 0 } };
+		enum bp_result result = bp->funcs->get_spread_spectrum_info(
+				bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
+
+		/* Based on VBIOS, VBIOS will keep entry for GPU PLL SS
+		 * even if SS not enabled and in that case
+		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
+		 * that SS is enabled
+		 */
+		if (result == BP_RESULT_OK &&
+				info.spread_spectrum_percentage != 0) {
+			clk_mgr_dce->ss_on_dprefclk = true;
+			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
+
+			if (info.type.CENTER_MODE == 0) {
+				/* TODO: Currently for DP Reference clock we
+				 * need only SS percentage for
+				 * downspread */
+				clk_mgr_dce->dprefclk_ss_percentage =
+						info.spread_spectrum_percentage;
+			}
+
+			return;
+		}
+
+		result = bp->funcs->get_spread_spectrum_info(
+				bp, AS_SIGNAL_TYPE_DISPLAY_PORT, 0, &info);
+
+		/* Based on VBIOS, VBIOS will keep entry for DPREFCLK SS
+		 * even if SS not enabled and in that case
+		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
+		 * that SS is enabled
+		 */
+		if (result == BP_RESULT_OK &&
+				info.spread_spectrum_percentage != 0) {
+			clk_mgr_dce->ss_on_dprefclk = true;
+			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
+
+			if (info.type.CENTER_MODE == 0) {
+				/* Currently for DP Reference clock we
+				 * need only SS percentage for
+				 * downspread */
+				clk_mgr_dce->dprefclk_ss_percentage =
+						info.spread_spectrum_percentage;
+			}
+			if (clk_mgr_dce->base.ctx->dc->config.ignore_dpref_ss)
+				clk_mgr_dce->dprefclk_ss_percentage = 0;
+		}
+	}
+}
+
+int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
+{
+	struct bp_set_dce_clock_parameters dce_clk_params;
+	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
+	struct dc *dc = clk_mgr->base.ctx->dc;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	int actual_clock;
+	/* Prepare to program display clock*/
+	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
+
+	/* Make sure requested clock isn't lower than minimum threshold*/
+	if (requested_clk_khz > 0)
+		requested_clk_khz = max(requested_clk_khz,
+				clk_mgr->base.dentist_vco_freq_khz / 62);
+
+	dce_clk_params.target_clock_frequency = requested_clk_khz;
+	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
+	dce_clk_params.clock_type = DCECLOCK_TYPE_DISPLAY_CLOCK;
+
+	bp->funcs->set_dce_clock(bp, &dce_clk_params);
+	actual_clock = dce_clk_params.target_clock_frequency;
+
+		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
+			if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
+				dmcu->funcs->set_psr_wait_loop(dmcu,
+						actual_clock / 1000 / 7);
+		}
+
+	clk_mgr->dfs_bypass_disp_clk = actual_clock;
+	return actual_clock;
+
+}
+
+int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr)
+{
+	struct bp_set_dce_clock_parameters dce_clk_params;
+	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
+
+	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
+
+	/*Program DP ref Clock*/
+	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
+	dce_clk_params.target_clock_frequency = 0;
+	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
+	dce_clk_params.clock_type = DCECLOCK_TYPE_DPREFCLK;
+	if (!((clk_mgr->base.ctx->asic_id.chip_family == FAMILY_AI) &&
+	       ASICREV_IS_VEGA20_P(clk_mgr->base.ctx->asic_id.hw_internal_rev)))
+		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK =
+			(dce_clk_params.pll_id ==
+					CLOCK_SOURCE_COMBO_DISPLAY_PLL0);
+	else
+		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK = false;
+
+	bp->funcs->set_dce_clock(bp, &dce_clk_params);
+
+	/* Returns the dp_refclk that was set */
+	return dce_clk_params.target_clock_frequency;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
new file mode 100644
index 000000000000..e27486db4b62
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
@@ -0,0 +1,29 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DCN10_CLK_MGR_H__
+#define __DCN10_CLK_MGR_H__
+
+#include "dc.h"
+
+struct clk_mgr_internal;
+
+/*
+ * Shared clock helpers referenced by both the DCE and DCN clock managers.
+ */
+int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
+
+void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce);
+
+int dce12_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base);
+
+unsigned int dentist_get_divider_from_did(unsigned int did);
+
+int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz);
+
+int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr);
+
+#endif /* __DCN10_CLK_MGR_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7eaaf38cd9ab..e019db3dc822 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -55,11 +55,13 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/dce60_resource.h"
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 #include "dce80/dce80_resource.h"
 #include "dce100/dce100_resource.h"
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
 #include "dce120/dce120_resource.h"
+#endif
 #include "dcn10/dcn10_resource.h"
 #include "dcn20/dcn20_resource.h"
 #include "dcn21/dcn21_resource.h"
@@ -293,6 +295,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 			init_data->num_virtual_links, dc);
 		break;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 	case DCE_VERSION_8_0:
 		res_pool = dce80_create_resource_pool(
 				(uint8_t)init_data->num_virtual_links, dc);
@@ -324,6 +327,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 		res_pool = dce120_create_resource_pool(
 				(uint8_t)init_data->num_virtual_links, dc);
 		break;
+#endif
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
 	case DCN_VERSION_1_0:
@@ -5301,6 +5305,81 @@ void resource_build_info_frame(struct pipe_ctx *pipe_ctx)
 	patch_gamut_packet_checksum(&info->gamut);
 }
 
+/*
+ * Physical-clock resource mapping used by the DCE and DCN resource pools.
+ * Unit tests provide their own stub (see dc_resource_ut_helpers.c).
+ */
+enum {
+	CLK_SRC_PLL0 = 0,
+	CLK_SRC_PLL1,
+	CLK_SRC_PLL2,
+	CLK_SRC_PLL3,
+	CLK_SRC_PLL4,
+	CLK_SRC_PLL5,
+};
+
+static struct clock_source *find_matching_pll(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		const struct dc_stream_state *const stream)
+{
+	(void)res_ctx;
+	switch (stream->link->link_enc->transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		return pool->clock_sources[CLK_SRC_PLL0];
+	case TRANSMITTER_UNIPHY_B:
+		return pool->clock_sources[CLK_SRC_PLL1];
+	case TRANSMITTER_UNIPHY_C:
+		return pool->clock_sources[CLK_SRC_PLL2];
+	case TRANSMITTER_UNIPHY_D:
+		return pool->clock_sources[CLK_SRC_PLL3];
+	case TRANSMITTER_UNIPHY_E:
+		return pool->clock_sources[CLK_SRC_PLL4];
+	case TRANSMITTER_UNIPHY_F:
+		return pool->clock_sources[CLK_SRC_PLL5];
+	default:
+		return NULL;
+	}
+}
+
+enum dc_status resource_map_phy_clock_resources(
+		const struct dc *dc,
+		struct dc_state *context,
+		struct dc_stream_state *stream)
+{
+
+	/* acquire new resources */
+	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(
+			&context->res_ctx, stream);
+
+	if (!pipe_ctx)
+		return DC_ERROR_UNEXPECTED;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal)
+		|| dc_is_virtual_signal(pipe_ctx->stream->signal))
+		pipe_ctx->clock_source =
+				dc->res_pool->dp_clock_source;
+	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL)
+			pipe_ctx->clock_source =
+				dc->res_pool->dp_clock_source;
+	else {
+		if (stream && stream->link && stream->link->link_enc)
+			pipe_ctx->clock_source = find_matching_pll(
+				&context->res_ctx, dc->res_pool,
+				stream);
+	}
+
+	if (pipe_ctx->clock_source == NULL)
+		return DC_NO_CLOCK_SOURCE_RESOURCE;
+
+	resource_reference_clock_source(
+		&context->res_ctx,
+		dc->res_pool,
+		pipe_ctx->clock_source);
+
+	return DC_OK;
+}
+
 enum dc_status resource_map_clock_resources(
 		const struct dc  *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 3300dbc67f32..368ebcbf3fed 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -43,9 +43,11 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/hw_factory_dce60.h"
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 #include "dce80/hw_factory_dce80.h"
 #include "dce110/hw_factory_dce110.h"
 #include "dce120/hw_factory_dce120.h"
+#endif
 #include "dcn10/hw_factory_dcn10.h"
 #include "dcn20/hw_factory_dcn20.h"
 #include "dcn21/hw_factory_dcn21.h"
@@ -71,6 +73,7 @@ bool dal_hw_factory_init(
 		dal_hw_factory_dce60_init(factory);
 		return true;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
@@ -89,6 +92,7 @@ bool dal_hw_factory_init(
 	case DCE_VERSION_12_1:
 		dal_hw_factory_dce120_init(factory);
 		return true;
+#endif
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 		dal_hw_factory_dcn10_init(factory);
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 5a231f97aee3..46cdc8b1069a 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -43,9 +43,11 @@
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/hw_translate_dce60.h"
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 #include "dce80/hw_translate_dce80.h"
 #include "dce110/hw_translate_dce110.h"
 #include "dce120/hw_translate_dce120.h"
+#endif
 #include "dcn10/hw_translate_dcn10.h"
 #include "dcn20/hw_translate_dcn20.h"
 #include "dcn21/hw_translate_dcn21.h"
@@ -75,6 +77,7 @@ bool dal_hw_translate_init(
 		dal_hw_translate_dce60_init(translate);
 		return true;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 	case DCE_VERSION_8_0:
 	case DCE_VERSION_8_1:
 	case DCE_VERSION_8_3:
@@ -90,6 +93,7 @@ bool dal_hw_translate_init(
 	case DCE_VERSION_12_1:
 		dal_hw_translate_dce120_init(translate);
 		return true;
+#endif
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 		dal_hw_translate_dcn10_init(translate);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index 9769ec9a32df..7c2afb773685 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -36,11 +36,13 @@ endif
 
 ###############################################################################
 
+ifdef CONFIG_DRM_AMD_DC_DCE
 HWSS_DCE80 = dce80_hwseq.o
 
 AMD_DAL_HWSS_DCE80 = $(addprefix $(AMDDALPATH)/dc/hwss/dce80/,$(HWSS_DCE80))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE80)
+endif
 
 ###############################################################################
 
@@ -52,11 +54,13 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE)
 
 ###############################################################################
 
+ifdef CONFIG_DRM_AMD_DC_DCE
 HWSS_DCE100 = dce100_hwseq.o
 
 AMD_DAL_HWSS_DCE100 = $(addprefix $(AMDDALPATH)/dc/hwss/dce100/,$(HWSS_DCE100))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE100)
+endif
 
 ###############################################################################
 
@@ -68,6 +72,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE110)
 
 ###############################################################################
 
+ifdef CONFIG_DRM_AMD_DC_DCE
 HWSS_DCE112 = dce112_hwseq.o
 
 AMD_DAL_HWSS_DCE112 = $(addprefix $(AMDDALPATH)/dc/hwss/dce112/,$(HWSS_DCE112))
@@ -81,6 +86,7 @@ HWSS_DCE120 = dce120_hwseq.o
 AMD_DAL_HWSS_DCE120 = $(addprefix $(AMDDALPATH)/dc/hwss/dce120/,$(HWSS_DCE120))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE120)
+endif
 
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 80180cb00aba..77948df809b8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3614,6 +3614,7 @@ void dce110_disable_link_output(struct dc_link *link,
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 static const struct hw_sequencer_funcs dce110_funcs = {
 	.program_gamut_remap = program_gamut_remap,
 	.program_output_csc = program_output_csc,
@@ -3682,4 +3683,5 @@ void dce110_hw_sequencer_construct(struct dc *dc)
 	dc->hwss = dce110_funcs;
 	dc->hwseq->funcs = dce110_private_funcs;
 }
+#endif /* CONFIG_DRM_AMD_DC_DCE */
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index bbec53719c5d..497794a1f1d1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -41,6 +41,7 @@ AMD_DAL_IRQ_DCE60 = $(addprefix $(AMDDALPATH)/dc/irq/dce60/,$(IRQ_DCE60))
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCE60)
 endif
 
+ifdef CONFIG_DRM_AMD_DC_DCE
 ###############################################################################
 # DCE 8x
 ###############################################################################
@@ -67,6 +68,7 @@ IRQ_DCE12 = irq_service_dce120.o
 AMD_DAL_IRQ_DCE12 = $(addprefix $(AMDDALPATH)/dc/irq/dce120/,$(IRQ_DCE12))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCE12)
+endif # CONFIG_DRM_AMD_DC_DCE
 
 ###############################################################################
 # DCN 1x
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 8958d286dde1..7f3084c6dd49 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -179,27 +179,6 @@ static struct irq_source_info_funcs vupdate_irq_info_funcs = {
 #define dc_underflow_int_entry(reg_num) \
 	[DC_IRQ_SOURCE_DC ## reg_num ## UNDERFLOW] = dummy_irq_entry()
 
-bool dal_irq_service_dummy_set(struct irq_service *irq_service,
-			       const struct irq_source_info *info,
-			       bool enable)
-{
-	(void)enable;
-	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
-		     __func__, info->src_id, info->ext_id);
-
-	return false;
-}
-
-bool dal_irq_service_dummy_ack(struct irq_service *irq_service,
-			       const struct irq_source_info *info)
-{
-	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
-		     __func__, info->src_id, info->ext_id);
-
-	return false;
-}
-
-
 bool dce110_vblank_set(struct irq_service *irq_service,
 		       const struct irq_source_info *info,
 		       bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.h b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.h
index 9237646c0959..b641e6a9b135 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.h
@@ -36,15 +36,6 @@ enum dc_irq_source to_dal_irq_source_dce110(
 		uint32_t src_id,
 		uint32_t ext_id);
 
-bool dal_irq_service_dummy_set(
-	struct irq_service *irq_service,
-	const struct irq_source_info *info,
-	bool enable);
-
-bool dal_irq_service_dummy_ack(
-	struct irq_service *irq_service,
-	const struct irq_source_info *info);
-
 bool dce110_vblank_set(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info,
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index b595a11c5eaf..f8c8ca266ec1 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -28,14 +28,18 @@
 #include "include/irq_service_interface.h"
 #include "include/logger_interface.h"
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 #include "dce110/irq_service_dce110.h"
+#endif
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/irq_service_dce60.h"
 #endif
 
+#if defined(CONFIG_DRM_AMD_DC_DCE)
 #include "dce80/irq_service_dce80.h"
 #include "dce120/irq_service_dce120.h"
+#endif
 #include "dcn10/irq_service_dcn10.h"
 
 #include "reg_helper.h"
@@ -105,6 +109,30 @@ void dal_irq_service_set_generic(
 	dm_write_reg(irq_service->ctx, addr, value);
 }
 
+/*
+ * Base "non-implemented source" irq handlers referenced by irq_service.c and
+ * every DCN irq vtable.
+ */
+bool dal_irq_service_dummy_set(struct irq_service *irq_service,
+			       const struct irq_source_info *info,
+			       bool enable)
+{
+	(void)enable;
+	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
+		     __func__, info->src_id, info->ext_id);
+
+	return false;
+}
+
+bool dal_irq_service_dummy_ack(struct irq_service *irq_service,
+			       const struct irq_source_info *info)
+{
+	DC_LOG_ERROR("%s: called for non-implemented irq source, src_id=%u, ext_id=%u\n",
+		     __func__, info->src_id, info->ext_id);
+
+	return false;
+}
+
 bool dal_irq_service_set(
 	struct irq_service *irq_service,
 	enum dc_irq_source source,
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
index bbcef3d2fe33..c13986754a4a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.h
@@ -90,4 +90,13 @@ bool hpd1_ack(
 	struct irq_service *irq_service,
 	const struct irq_source_info *info);
 
+bool dal_irq_service_dummy_set(
+	struct irq_service *irq_service,
+	const struct irq_source_info *info,
+	bool enable);
+
+bool dal_irq_service_dummy_ack(
+	struct irq_service *irq_service,
+	const struct irq_source_info *info);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index b29986266888..bf127b9882f7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -37,6 +37,8 @@ endif
 
 ###############################################################################
 
+ifdef CONFIG_DRM_AMD_DC_DCE
+
 RESOURCE_DCE80 = dce80_resource.o
 
 AMD_DAL_RESOURCE_DCE80 = $(addprefix $(AMDDALPATH)/dc/resource/dce80/,$(RESOURCE_DCE80))
@@ -75,6 +77,8 @@ AMD_DAL_RESOURCE_DCE120 = $(addprefix $(AMDDALPATH)/dc/resource/dce120/,$(RESOUR
 
 AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCE120)
 
+endif # CONFIG_DRM_AMD_DC_DCE
+
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
 # DCN
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 8c4494a8ec8f..2da5d44e5203 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -848,30 +848,6 @@ static void dce112_resource_destruct(struct dce110_resource_pool *pool)
 	}
 }
 
-static struct clock_source *find_matching_pll(
-		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		const struct dc_stream_state *const stream)
-{
-	(void)res_ctx;
-	switch (stream->link->link_enc->transmitter) {
-	case TRANSMITTER_UNIPHY_A:
-		return pool->clock_sources[DCE112_CLK_SRC_PLL0];
-	case TRANSMITTER_UNIPHY_B:
-		return pool->clock_sources[DCE112_CLK_SRC_PLL1];
-	case TRANSMITTER_UNIPHY_C:
-		return pool->clock_sources[DCE112_CLK_SRC_PLL2];
-	case TRANSMITTER_UNIPHY_D:
-		return pool->clock_sources[DCE112_CLK_SRC_PLL3];
-	case TRANSMITTER_UNIPHY_E:
-		return pool->clock_sources[DCE112_CLK_SRC_PLL4];
-	case TRANSMITTER_UNIPHY_F:
-		return pool->clock_sources[DCE112_CLK_SRC_PLL5];
-	default:
-		return NULL;
-	}
-}
-
 static enum dc_status build_mapped_resource(
 		const struct dc *dc,
 		struct dc_state *context,
@@ -963,44 +939,6 @@ enum dc_status dce112_validate_bandwidth(
 	return result ? DC_OK : DC_FAIL_BANDWIDTH_VALIDATE;
 }
 
-enum dc_status resource_map_phy_clock_resources(
-		const struct dc *dc,
-		struct dc_state *context,
-		struct dc_stream_state *stream)
-{
-
-	/* acquire new resources */
-	struct pipe_ctx *pipe_ctx = resource_get_otg_master_for_stream(
-			&context->res_ctx, stream);
-
-	if (!pipe_ctx)
-		return DC_ERROR_UNEXPECTED;
-
-	if (dc_is_dp_signal(pipe_ctx->stream->signal)
-		|| dc_is_virtual_signal(pipe_ctx->stream->signal))
-		pipe_ctx->clock_source =
-				dc->res_pool->dp_clock_source;
-	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_HDMI_FRL)
-			pipe_ctx->clock_source =
-				dc->res_pool->dp_clock_source;
-	else {
-		if (stream && stream->link && stream->link->link_enc)
-			pipe_ctx->clock_source = find_matching_pll(
-				&context->res_ctx, dc->res_pool,
-				stream);
-	}
-
-	if (pipe_ctx->clock_source == NULL)
-		return DC_NO_CLOCK_SOURCE_RESOURCE;
-
-	resource_reference_clock_source(
-		&context->res_ctx,
-		dc->res_pool,
-		pipe_ctx->clock_source);
-
-	return DC_OK;
-}
-
 static bool dce112_validate_surface_sets(
 		struct dc_state *context)
 {
-- 
2.43.0


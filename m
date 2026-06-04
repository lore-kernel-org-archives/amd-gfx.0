Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1FBCD6E6D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1F511284F;
	Thu,  4 Jun 2026 14:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fnfKI65";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA1A112847
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsxqCINtTtE6G9tYzBfNS6zNI6xlybE4HBsOyPzeYo64ZFsZsHVFFfwJ+NFVr7pinlMoq6n5EPTjvCDvXaCAoOzNvwBg6Sz+ElJd0iyI5TkyLGwu7OzF+rHTqwIENTisc6ZaDX2rQl5cvPU+al5aKIU9oNdK1nBeIHiZAN4Y3tGc+W3rqsBmNWZ50EJJKcV8D6X7sDFUYrkvu7FjsIm1mwQiI7iUp1tV+r0hg7fbgG1blAfdOtKxfCbbmhvqTZYE8xmEtJbglrDm1B1XvLzn8CdDNVduArpHnA4AX5heEsJiVrAEn30XhX7IEBwfuOFdB2Mm58FvcfXAEza+PDAK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyJmG0TbOllSh9AHxSM5w9I2rPNo1e6GeoUwQTaeZIY=;
 b=yqSHbPCEsLo5wQ6FY3SVSJVXvs1ybrCV++kbHrO/u2AWYQ9ZzUJr7PuyBnMZwzJ1JXsQbtOqxivg/yNAwxdugdFXYT7A4HR+37hjAhcH8igmNIYJ6FzPtXvq6VVEN7c7CCNok5nSzumTD1soECqWfhwXKk4nmgNx4u9DgZQeL2RZjUd+lcPX1N4wBWF06bTpbsR7QzrOlF/bqXNCEb9vL3PzTQr4L8qKOoyK0YOrXjxByo7WskRNS0D8GpMz8SPb2Oa5daIHRMfIRCmG1rQNn1TN+sJsQZTkZctAqo5J/42NxG8LBFZMWR0pqdFkOx3Uye8ESXiSjOGxEhOxt0iohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyJmG0TbOllSh9AHxSM5w9I2rPNo1e6GeoUwQTaeZIY=;
 b=5fnfKI65amr0Ba5rgxpYrK9YOImNI++vZAqz1gmBHpxsxYCvjO4vX22moxg/QYV0kz6yeUIrNiXQJ+41L5Sn7bHvd/gA0OnRBlUVDg+Lmy7r1803ClhjWGYeXN/lgABpFIrw2ieS5gqHX1N3/8ReAClafxb9Z44s7kjcpHYAFCw=
Received: from BL1PR13CA0411.namprd13.prod.outlook.com (2603:10b6:208:2c2::26)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:55:19 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::24) by BL1PR13CA0411.outlook.office365.com
 (2603:10b6:208:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:06 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 17/24] drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu
Date: Thu, 4 Jun 2026 10:52:11 -0400
Message-ID: <20260604145428.809959-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3b7574-0d41-42bc-2795-08dec2494b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FB/l2xsJjAavhsuZaha0EKki7yYm/0EA/Q73PgALzI+NBTt7X1b/57arpYVGh4USOe4VrU2NHX6bETb5tQugFkGukO2Gesdzd6N3PUl+obvicREuR9xvoI/Xd6Nh8wDQuRTdO0wIcHcOeE9W4jbRa8vrIpsnYpYF3bsdbBjfNUzLeOSNZWnF9jMd42TQ1AfSW9WXk6DTMHvlXUA1jNxKsrQOsFXUC40tv5v7qYc3FB5okN0pgj+mqS0YRVG1U+txy0oa7gQnIjB1bMVRKiH/1tw2u7Flpgcb8vHFw1I5+DrpqDai4th/QZRJrD9Iiek4DmSXEZqYckIZNV3UjcX9jmsJl13N3rbDHHVC+ZRtSqH1PbA/RZmIyzgyxCp1U17iE0RLJ0XmKDih6lzwY+gC+pQzdK7EEEujTpy4rOvfbMkFt379986diY+g+/g9yv1FPYdsf33UK7COsrOp3HaUw/sF7tB8Nsm1bXQLayEZlnHidO/lZZc4I4nn8HN+eD1HBu+b49fboel1SzO2mWIJQRrAPzpvhHbcAbGl9zWXkSEM6tqnZ4CC/p3slSdml5hrnKZXjMjH591WmzMbFPNeR8cVTIVQIQ6NoAC6ysd9v8M6QUJzbPpBvPWIiLQbEjqxcbEUIoS18aIPy/5ig31GNCsWsKuJr882OfkbQ7SWtIM1ab8f+jvx364JMRTzv5ohEH4wY5NZoFGRhatezlkzhjZaFWY4FDbKvOg57E0+kHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gw21Be6JH56xKz8+sqdrkK2FTcrNkbXMcW0CIj2WvvBwu6nxpuVsjkX4otu38MoQlSm8UlIZFFyvEYLWmmeIUh3GvocjPIhzeq/tqP3bd1rut8QVn+JZza4QJOeisRX31uZS7jZ9ncZdvq13udba4i2HHs/XrydzFcSg7pHjR+xi+q8/fm+rSZruUtmb7bImpV8mQow6IRbxeVy9rdcJAfJGwQvOM5blwrncb2fYjw3EabOUga1RzdLqdDU8CWJUtFl7ii/AwzfyOU2ndHjR0PVwUFBbDImiTCgfZp+CjTIIGFxEoTznXygIo2a02rHj6DoCXe9cIpNpoT1dHKrTfr+JLyVc26UHwWwS+cC5zJAR3RA4uIUzD4aePEdzYPGpju6FAiCNxz+k1qqE+640WWoJXR53i9CdZ8/YBOYiQn1xeRP6P/krVKqRYRJ2+avt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:18.9917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b7574-0d41-42bc-2795-08dec2494b9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for two functions in amdgpu_dm_pp_smu.c:
get_default_clock_levels and dc_to_pp_clock_type.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |  16 ++
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 241 ++++++++++++++++++
 4 files changed, 265 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 2fda6fbed88f..ca7141dbdf6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -33,6 +33,8 @@
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
 #include "dm_pp_smu.h"
+#include "amdgpu_dm_kunit_helpers.h"
+#include "amdgpu_dm_pp_smu.h"
 
 bool dm_pp_apply_display_requirements(
 		const struct dc_context *ctx,
@@ -109,7 +111,7 @@ bool dm_pp_apply_display_requirements(
 	return true;
 }
 
-static void get_default_clock_levels(
+STATIC_IFN_KUNIT void get_default_clock_levels(
 		enum dm_pp_clock_type clk_type,
 		struct dm_pp_clock_levels *clks)
 {
@@ -140,8 +142,9 @@ static void get_default_clock_levels(
 		break;
 	}
 }
+EXPORT_IF_KUNIT(get_default_clock_levels);
 
-static enum amd_pp_clock_type dc_to_pp_clock_type(
+STATIC_IFN_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 		enum dm_pp_clock_type dm_pp_clk_type)
 {
 	enum amd_pp_clock_type amd_pp_clk_type = 0;
@@ -182,6 +185,7 @@ static enum amd_pp_clock_type dc_to_pp_clock_type(
 
 	return amd_pp_clk_type;
 }
+EXPORT_IF_KUNIT(dc_to_pp_clock_type);
 
 static void pp_to_dc_clock_levels(
 		const struct amd_pp_clocks *pp_clks,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
new file mode 100644
index 000000000000..827b60d5affe
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __AMDGPU_DM_PP_SMU_H__
+#define __AMDGPU_DM_PP_SMU_H__
+
+#include "dm_pp_interface.h"
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void get_default_clock_levels(enum dm_pp_clock_type clk_type, struct dm_pp_clock_levels *clks);
+enum amd_pp_clock_type dc_to_pp_clock_type(enum dm_pp_clock_type dm_pp_clk_type);
+#endif
+
+#endif /* __AMDGPU_DM_PP_SMU_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index fe9f32c9bdde..4d2eb301c2af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -8,6 +8,7 @@ ccflags-y += -I$(src)/../../include
 ccflags-y += -I$(src)/../../modules/inc
 ccflags-y += -I$(src)/../../dc
 ccflags-y += -I$(src)/../../../amdgpu
+ccflags-y += -I$(src)/../../../include
 
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
@@ -18,3 +19,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_wb_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
new file mode 100644
index 000000000000..556473f55ebe
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_pp_smu.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <linux/types.h>
+
+#include "dc.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_pp_smu.h"
+
+/* ---- Tests for get_default_clock_levels ---- */
+
+/**
+ * dm_test_default_clock_levels_display - Test display clock default levels
+ * @test: KUnit test context
+ *
+ * Verify that get_default_clock_levels populates 6 display clock levels
+ * with the expected frequencies in kHz.
+ */
+static void dm_test_default_clock_levels_display(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+	uint32_t expected[] = { 300000, 400000, 496560, 626090, 685720, 757900 };
+	int i;
+
+	get_default_clock_levels(DM_PP_CLOCK_TYPE_DISPLAY_CLK, &clks);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 6U);
+	for (i = 0; i < 6; i++)
+		KUNIT_EXPECT_EQ(test, clks.clocks_in_khz[i], expected[i]);
+}
+
+/**
+ * dm_test_default_clock_levels_engine - Test engine clock default levels
+ * @test: KUnit test context
+ *
+ * Verify that get_default_clock_levels populates 6 engine clock levels
+ * with the expected frequencies in kHz.
+ */
+static void dm_test_default_clock_levels_engine(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+	uint32_t expected[] = { 300000, 360000, 423530, 514290, 626090, 720000 };
+	int i;
+
+	get_default_clock_levels(DM_PP_CLOCK_TYPE_ENGINE_CLK, &clks);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 6U);
+	for (i = 0; i < 6; i++)
+		KUNIT_EXPECT_EQ(test, clks.clocks_in_khz[i], expected[i]);
+}
+
+/**
+ * dm_test_default_clock_levels_memory - Test memory clock default levels
+ * @test: KUnit test context
+ *
+ * Verify that get_default_clock_levels populates 2 memory clock levels
+ * with the expected frequencies in kHz.
+ */
+static void dm_test_default_clock_levels_memory(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+
+	get_default_clock_levels(DM_PP_CLOCK_TYPE_MEMORY_CLK, &clks);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 2U);
+	KUNIT_EXPECT_EQ(test, clks.clocks_in_khz[0], 333000U);
+	KUNIT_EXPECT_EQ(test, clks.clocks_in_khz[1], 800000U);
+}
+
+/**
+ * dm_test_default_clock_levels_unknown - Test unknown clock type default
+ * @test: KUnit test context
+ *
+ * Verify that get_default_clock_levels sets num_levels to 0 for an
+ * unrecognized clock type.
+ */
+static void dm_test_default_clock_levels_unknown(struct kunit *test)
+{
+	struct dm_pp_clock_levels clks = { 0 };
+
+	get_default_clock_levels(DM_PP_CLOCK_TYPE_FCLK, &clks);
+
+	KUNIT_EXPECT_EQ(test, clks.num_levels, 0U);
+}
+
+/* ---- Tests for dc_to_pp_clock_type ---- */
+
+/**
+ * dm_test_dc_to_pp_clock_type_display - Test display clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_DISPLAY_CLK maps to amd_pp_disp_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_display(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_DISPLAY_CLK),
+			(int)amd_pp_disp_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_engine - Test engine clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_ENGINE_CLK maps to amd_pp_sys_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_engine(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_ENGINE_CLK),
+			(int)amd_pp_sys_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_memory - Test memory clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_MEMORY_CLK maps to amd_pp_mem_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_memory(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_MEMORY_CLK),
+			(int)amd_pp_mem_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_dcefclk - Test DCEF clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_DCEFCLK maps to amd_pp_dcef_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_dcefclk(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_DCEFCLK),
+			(int)amd_pp_dcef_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_dcfclk - Test DCF clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_DCFCLK maps to amd_pp_dcf_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_dcfclk(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_DCFCLK),
+			(int)amd_pp_dcf_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_pixelclk - Test pixel clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_PIXELCLK maps to amd_pp_pixel_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_pixelclk(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_PIXELCLK),
+			(int)amd_pp_pixel_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_fclk - Test FCLK type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_FCLK maps to amd_pp_f_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_fclk(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_FCLK),
+			(int)amd_pp_f_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_phyclk - Test display PHY clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_DISPLAYPHYCLK maps to amd_pp_phy_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_phyclk(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_DISPLAYPHYCLK),
+			(int)amd_pp_phy_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_dppclk - Test DPP clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify DM_PP_CLOCK_TYPE_DPPCLK maps to amd_pp_dpp_clock.
+ */
+static void dm_test_dc_to_pp_clock_type_dppclk(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(DM_PP_CLOCK_TYPE_DPPCLK),
+			(int)amd_pp_dpp_clock);
+}
+
+/**
+ * dm_test_dc_to_pp_clock_type_invalid - Test invalid clock type mapping
+ * @test: KUnit test context
+ *
+ * Verify that an invalid clock type value maps to 0.
+ */
+static void dm_test_dc_to_pp_clock_type_invalid(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, (int)dc_to_pp_clock_type(0), 0);
+}
+
+static struct kunit_case dm_pp_smu_test_cases[] = {
+	/* get_default_clock_levels */
+	KUNIT_CASE(dm_test_default_clock_levels_display),
+	KUNIT_CASE(dm_test_default_clock_levels_engine),
+	KUNIT_CASE(dm_test_default_clock_levels_memory),
+	KUNIT_CASE(dm_test_default_clock_levels_unknown),
+	/* dc_to_pp_clock_type */
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_display),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_engine),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_memory),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_dcefclk),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_dcfclk),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_pixelclk),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_fclk),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_phyclk),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_dppclk),
+	KUNIT_CASE(dm_test_dc_to_pp_clock_type_invalid),
+	{}
+};
+
+static struct kunit_suite dm_pp_smu_test_suite = {
+	.name = "amdgpu_dm_pp_smu",
+	.test_cases = dm_pp_smu_test_cases,
+};
+
+kunit_test_suite(dm_pp_smu_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_pp_smu");
-- 
2.54.0


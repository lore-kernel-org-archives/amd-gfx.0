Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56FCC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BF410EACA;
	Thu,  6 Jun 2024 21:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G/I7q6xP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7575C10EAC4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4p94h/SWYp1U9GA4zTH/4JP18r56O2SFyxDuw+loFRqqlN8PratITqZhbIXkG1ZM2hEXvIFLeBwy+TDOWye2eE3NmatNVnVFI/t1uNAhIAAq3BdsgoxZPCQ0kh4PKuxVwjSzHdUFuH/JjM93zHw7mFynldS+MW/rhCO4bKYVeCrb2//sP+rOFjGAEdkjdtcj4g28+y911QqW9xGQOMB3X+8eIJWw44le28RqHjQ0bktPa4YhYmKFF+dpNnFS44asvTQBjyJrx402MO1kTC23K+BS4TLZNZ4RfEEvsklRTncc1c66XWU+SgqHzThsK23Bxkef5+41f32dOujGj9X3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMrWbOJyQLyUoe836QGHMWGu/BkTR0PxH0lKZ10OLzw=;
 b=iiBsJYjK2AtIJOXipzrXz8Ga1Sb/WN7gF6GaKfQA55wy0aSFcygmjZ5wcK2owCu6ow3ukONbZ+CFDTtHylFhjq3fF+BJLQdlhvwmO4b+/Z9MPh1Qp8zSLyB8EVfdvHSF2Hx0qkPW56yJXUNjKS9Z4JAVPlQgVkDjZfYm2Lj/oMtxc5P1bIT8mRi4kPPFGhtguH+00wjxE1P9dd9QSLXQOrJsMhg3Cny1e94XaJlo63gOX0PiRgMWUVP8CXVPWuCNQzPnWnRwdYGzhAzriH430kKakallTpfqXL4pDeFk4Fw0zu+eTZ8QG3FvNmOjBfXM79QfBXr+CEr3jJIop20orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMrWbOJyQLyUoe836QGHMWGu/BkTR0PxH0lKZ10OLzw=;
 b=G/I7q6xPWdrVpJ/xUaRz7+Sf6y+XbwWsGyEnesWF1fzwYK14XSFAOfmTQHpbV6T29I8MtHgcCDAbp3Og6WMxW3+pt48g3zHN7/hv3kg1S3ymsQckDWHDgUK1Q6X+5oEdXxaa0yxM1sJHZ0XTsaF/qa8z8jF7IpsT1hgcZ329g/Q=
Received: from MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:57:05 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::fd) by MN2PR20CA0019.outlook.office365.com
 (2603:10b6:208:e8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:05 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:03 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 11/67] drm/amd/display: Remove dcn32_smu13 duplicate header
Date: Thu, 6 Jun 2024 17:55:36 -0400
Message-ID: <20240606215632.4061204-12-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: f1702ffe-2017-467f-5465-08dc86739af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ndVT+WrPlI2n1WnJYdAgMFbLsz1vBBaZ8FQNKzOk7v3moPyHfvp4WQnhVZ5e?=
 =?us-ascii?Q?8+kfq0aWp6Q6EUonqjjsypuIdPzXjLJlIRfI6wKBgWSFotFi8Q4mJFR8Anze?=
 =?us-ascii?Q?zeua53jxwcVayO4eFIYGlQ53yQUJ/hDJxpM4M5bCC62SGiU2CvJD4/ZoX5cl?=
 =?us-ascii?Q?+tINbNx6DBME+5+b6Y7Tz4A9RQemZQTc9xolC8yzAE5ghKl7Zi37HXCwIuN1?=
 =?us-ascii?Q?uol3l8JLWn3Ozf/2UymmacJxMqQYu7G3FNooKDFWBCrCRQAwsk6h9hdT5guo?=
 =?us-ascii?Q?4usDQot4DWc2vVxfW6iesUhe4Acmn4gK3QxC9tsiN3i+dKLJm5MxQUayTxg5?=
 =?us-ascii?Q?vU3LU5JgVgTy+36etXxmz+LpKxN09lnnbeWYZvPA1vETYR/IpNka0XxnA4rr?=
 =?us-ascii?Q?2RFCnRqUZp9UrdeS2SvuAeI/Rmr/syP6EeMseuvYdd1eGxwbZzRkLMjIMRtm?=
 =?us-ascii?Q?QIa8TmYyZ6efxyp2QzfLvBrwYyCE9+1tSgvKumAvlvT1zy+NzGiiyo87iJ1u?=
 =?us-ascii?Q?PnhQaPuHpx6OnfJpkXu9cC4xQShlg2I63Okdb3e+6/OHitwMuiB4MQ386rf6?=
 =?us-ascii?Q?ATlHGkXhwYr4aFRv4QAJdIABt/siK+ZfLbc3MXVsohWEmGwGDWOkdti/ZEQ1?=
 =?us-ascii?Q?RMCI0rk5FHOSvlAd4qsAmREiiL/gFcjHASeHPCub5PKbGN3Krd1oyixO3LZo?=
 =?us-ascii?Q?VDSvj8BXbL/VSEeKzWG66GpBeqKYOzRN74NpBNZxsJBCuWAcik0GIkNCjjyP?=
 =?us-ascii?Q?plYox3letrNczF4QThgwRsgwrtETgYnJsUb6oxsw/D3TLwQXYsvsrAmOTw5P?=
 =?us-ascii?Q?XmoL9BS8uFsFmtyfNcyxQYUSFhk/Bq9Q4uIQr83P8Ah5rR8kTVyHHNV2jAMf?=
 =?us-ascii?Q?hkV/wwdXjENo7rHORUUixbTGCbGU9HUk5XImCRL6uf7cb/Cfc7skRX40DWdH?=
 =?us-ascii?Q?nQPOQxUdr1dyG48s56z1EUEHfYfXsfT8nhH+SsTfeUhTb0D5mgFsCdnybzIw?=
 =?us-ascii?Q?qKFvrJeBu/o9XQpDiCQeuEfpQsqWGDu3DCCRoZemskbnqNmvXWywx5YDAP36?=
 =?us-ascii?Q?eUYZCMdXuiJzvF8Ptoo+Dfw3MxluJz8TGFwqpTkse/Y3lvDBiPiOQYDyI1n/?=
 =?us-ascii?Q?hW4sy7we5lGzv51eGzG1laW9hIqCA8R3Kn2hA7x9+AwZaVIvMWEDO+8OW+mW?=
 =?us-ascii?Q?3lhwrJO/4Mh8+9LldiOQWfgg8rWjG7n+6cws0UgoY1GpZu4tgaaKmnnV0B1o?=
 =?us-ascii?Q?As7dQ0uI3otPeNR5ZA4lFZUsqjIPY2EKK0wl7EuzVVkrwCAvzrDrz1tyQLLX?=
 =?us-ascii?Q?Fr354Ylcs9af1nwtWXFNA2xJ9yPMrld4VQUozTRm2hxuH7YzITeOL20l9/ZM?=
 =?us-ascii?Q?0SmP51iYETwl2Bhmc1F8ZJDKwP3y3cAB1P7up98274fCzixUew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:05.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1702ffe-2017-467f-5465-08dc86739af0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

[WHY]
Duplicate headers requiring unecessary maintenance of both headers

[HOW]
Removal of smu13_driver_if header and all referneces to it changed to dcn32_smu13_driver

Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   2 +-
 .../dc/clk_mgr/dcn32/smu13_driver_if.h        | 108 ------------------
 3 files changed, 2 insertions(+), 110 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/smu13_driver_if.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index ff5fdc7b1198..ee4b02c8c807 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -36,7 +36,7 @@
 #include "link.h"
 #include "dc_state_priv.h"
 #include "atomfirmware.h"
-#include "smu13_driver_if.h"
+#include "dcn32_smu13_driver_if.h"
 
 #include "dcn/dcn_3_2_0_offset.h"
 #include "dcn/dcn_3_2_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index f2f60478b1a6..cf2d35363e8b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -28,7 +28,7 @@
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
 #include "dalsmc.h"
-#include "smu13_driver_if.h"
+#include "dcn32_smu13_driver_if.h"
 
 #define mmDAL_MSG_REG  0x1628A
 #define mmDAL_ARG_REG  0x16273
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/smu13_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/smu13_driver_if.h
deleted file mode 100644
index deeb85047e7b..000000000000
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/smu13_driver_if.h
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * Copyright 2021 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-#ifndef SMU13_DRIVER_IF_DCN32_H
-#define SMU13_DRIVER_IF_DCN32_H
-
-// *** IMPORTANT ***
-// PMFW TEAM: Always increment the interface version on any change to this file
-#define SMU13_DRIVER_IF_VERSION  0x18
-
-//Only Clks that have DPM descriptors are listed here
-typedef enum {
-  PPCLK_GFXCLK = 0,
-  PPCLK_SOCCLK,
-  PPCLK_UCLK,
-  PPCLK_FCLK,
-  PPCLK_DCLK_0,
-  PPCLK_VCLK_0,
-  PPCLK_DCLK_1,
-  PPCLK_VCLK_1,
-  PPCLK_DISPCLK,
-  PPCLK_DPPCLK,
-  PPCLK_DPREFCLK,
-  PPCLK_DCFCLK,
-  PPCLK_DTBCLK,
-  PPCLK_COUNT,
-} PPCLK_e;
-
-typedef enum {
-  UCLK_DIV_BY_1 = 0,
-  UCLK_DIV_BY_2,
-  UCLK_DIV_BY_4,
-  UCLK_DIV_BY_8,
-} UCLK_DIV_e;
-
-typedef struct {
-  uint8_t  WmSetting;
-  uint8_t  Flags;
-  uint8_t  Padding[2];
-
-} WatermarkRowGeneric_t;
-
-#define NUM_WM_RANGES 4
-
-typedef enum {
-  WATERMARKS_CLOCK_RANGE = 0,
-  WATERMARKS_DUMMY_PSTATE,
-  WATERMARKS_MALL,
-  WATERMARKS_COUNT,
-} WATERMARKS_FLAGS_e;
-
-typedef struct {
-  // Watermarks
-  WatermarkRowGeneric_t WatermarkRow[NUM_WM_RANGES];
-} Watermarks_t;
-
-typedef struct {
-  Watermarks_t Watermarks;
-  uint32_t  Spare[16];
-
-  uint32_t     MmHubPadding[8]; // SMU internal use
-} WatermarksExternal_t;
-
-// These defines are used with the following messages:
-// SMC_MSG_TransferTableDram2Smu
-// SMC_MSG_TransferTableSmu2Dram
-
-// Table transfer status
-#define TABLE_TRANSFER_OK         0x0
-#define TABLE_TRANSFER_FAILED     0xFF
-#define TABLE_TRANSFER_PENDING    0xAB
-
-// Table types
-#define TABLE_PMFW_PPTABLE            0
-#define TABLE_COMBO_PPTABLE           1
-#define TABLE_WATERMARKS              2
-#define TABLE_AVFS_PSM_DEBUG          3
-#define TABLE_PMSTATUSLOG             4
-#define TABLE_SMU_METRICS             5
-#define TABLE_DRIVER_SMU_CONFIG       6
-#define TABLE_ACTIVITY_MONITOR_COEFF  7
-#define TABLE_OVERDRIVE               8
-#define TABLE_I2C_COMMANDS            9
-#define TABLE_DRIVER_INFO             10
-#define TABLE_COUNT                   11
-
-#endif
-- 
2.34.1


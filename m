Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21978C27C6D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F82B10EAB5;
	Thu,  6 Jun 2024 21:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FZqsTS3Q";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC4B10EAB4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWzD8sHUgAnZI95ReOIiSg1ebO/XQ07jyuLhOFTb43cPx74e10Lv/VO+X/1I7AUV13XQHdY3DfxjF7v/Z/VWcV8lBeUnHCqNe/gUB0YASJYMGljkf58OM8iEykEQgnibzZo147z+H0/18XmQ6WKPMCaMIOQpRy/A9rFGljrJq0hWCAOCCNLoR9TCO4ECS8KwbFxCee4R40IPJos2Ou/FYYbogmupwSEfHO9QgBpEIUZhFl8V9lSSauH7qvYRYbLPT19iYkQF2uxfHb0a2L7FqbMK/TLwWoHAkZgccbm7gMPGO/NUz0bs0in2jIBYv+VSnx64HYz1s14JMbAozy476w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMrWbOJyQLyUoe836QGHMWGu/BkTR0PxH0lKZ10OLzw=;
 b=Ukxrd//vAFDTbSOpy1K7rQcqr5kT999ZU/Rck4n/50UXQUrw6BzrfY/bJTWfYn9sAhCmO1zrkHb8ML61TFRkuEbWNU3WPk5a1A+SCNAIa85E2ccoNenfbrM2YPbz6NDgJ5fpC5FdTYEV33udjQgznBAhfCZgKvuzYMnXW7ftOwj6RrbZKJXH8k5MkRhgr6B+A6XA7Xj+Lw5eywGm+s1C2b5CKUXRDHojFbzqFjrijIIz/SdYWeKfG5iu/Q//A+1BWd7a9sR0bkfhwglJ00s59kNS3q80TIonBw3bit1ExZMz6oDbnQm0YrK9OKbQg9dDXCdgraxTIIF0YssbIGWMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMrWbOJyQLyUoe836QGHMWGu/BkTR0PxH0lKZ10OLzw=;
 b=FZqsTS3QnKMq87oPVGpb/JxZFCCoCpChfFUaqpGkErJH2RKKZFjdG3fACqhejCnI1n/LEJhunOEsVR1atCmWU9i+dKgnKEJWouYw234SMB2SGYadHd/gBVjDacoG480AtYklmMBeQQthxJgS9vPpO/XdNXUhBtKZ2zu12SodDcs=
Received: from SN7PR04CA0051.namprd04.prod.outlook.com (2603:10b6:806:120::26)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:02:07 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::f8) by SN7PR04CA0051.outlook.office365.com
 (2603:10b6:806:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:07 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:05 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 11/67] drm/amd/display: Remove dcn32_smu13 duplicate header
Date: Thu, 6 Jun 2024 16:58:32 -0400
Message-ID: <20240606205928.4050859-12-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8280587e-2fc2-4791-a76c-08dc866becc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hAOnwF+myuog0k1DS5/bx9WmHGHWKEXDYvg9GooihS9gc3a6jyc0IbQcTXsN?=
 =?us-ascii?Q?/goBR2FjRpoBp+FkhC21HtLdk0Y0V6E82AbolsUwg1OAAcnvVYjofMyb22np?=
 =?us-ascii?Q?5hUcJJQGRsHXsejLxzOk4xTr7wwTnOWsp+JRl0+v24V2fGrUwORU0hBUI345?=
 =?us-ascii?Q?ludPder5ORcnFQmOibStxgOVhAatEr+nqLQV2K64kOLkDnqaZGlnsQrFWWe3?=
 =?us-ascii?Q?//+KlNg0HMd+WQ+nTIF+PXh/Abm8ed6oeYlc8G5HBePIUBFoN39pBAhse3c1?=
 =?us-ascii?Q?K+U0f2xwnIaaJFnumNvPY9D0ZBjQ2Ah3vy9p/1ZHakHLoSG1uc8l3JbiTvpw?=
 =?us-ascii?Q?bsQOF8sE6ddX+3q7f04B+ij9Ji4E72F7hHVdlKDl5Hj/b/UWo1QL94ds/+aK?=
 =?us-ascii?Q?J4detiaxSPDMNqNRFapP12Fl9uemm2GIP5TjF7rgRyujXNo38jorw2bPpNfK?=
 =?us-ascii?Q?PcUMauRh359zDqXLB93p3bit8xCBmUTLmqDvuu3I1XhEnApEWQyKr6YHkeJA?=
 =?us-ascii?Q?3DkomeFedGGbYdXQjESk02i3DmYD1OMFI/29mHa5AyUuP8zmE1A1pZ7By5LZ?=
 =?us-ascii?Q?5L+uOCkG1QYLbrDhRq0qhYLTR4ihkvZdmMcyZ+mtrL9HQ5UzK5Tzgc/eW4lW?=
 =?us-ascii?Q?WfbZQNYKoRfE6B6gTWeR01pZPjLREK0Dy6KI05Mc5oyLuVkd/0/7axKUlUHu?=
 =?us-ascii?Q?3V6Mg6x/mb9Mu6BD0hsdi94BgfLEX2NkdQL48Xm81JwAdjLsq0N+uJ5PcCm0?=
 =?us-ascii?Q?AZFdarcu9b0hVbRri+UKWrr1Z2uJEVJKLTRSv/u/QFqXyOpWrdI0cHb1+VlT?=
 =?us-ascii?Q?p6uAmSS5empDc/LEoga9DfJH0iwmxfPEO8X9EIxNaUiGq7vkg+FN+EoIBUZS?=
 =?us-ascii?Q?z6F/DhQYgPPlzChtosLb9leZsmH3AA0M/8a1Y5iT97L0DbPmlglKptiZka73?=
 =?us-ascii?Q?HII8fi760U/1q6YboM1UdOKD6iJkWfKV72NZWRHCx1gATjwv9VB2UugEmN/C?=
 =?us-ascii?Q?dSwqmWxVzlFUCpYFlvYE7CkTPqcPhLd8+o/3u4mH/o8yaAZCgRJITJ/AfEEI?=
 =?us-ascii?Q?WrnjlBAA1QYqiFYFMg3KuV6Op/Gw/mal/Ahg+N123/UNflVF+vutEDw74x2n?=
 =?us-ascii?Q?v4OPCJWxdZ4UJN5H89wnUjs4k2lvMdGwzy5T1vPcWyuPsdU84GpvtlEFW8P1?=
 =?us-ascii?Q?tBcAx7pIMq3q3+td6wuMNhkeOGjQZFujEsJ/zMQcZlTf3xqTbHTZMdVHEY8m?=
 =?us-ascii?Q?MSaYb+c9We4fJZdQdInp7sEQlASBGEp0slbTFLe1gZCkGvrGf74FMsvbRl21?=
 =?us-ascii?Q?KXsZrgcMXWkbH7/lA+EyKdldo9nFYS//UYfCacALsOf+kIuyMqAIJgYekFH5?=
 =?us-ascii?Q?u3HbZqDIeFluS/iVKtDn4aCMWzhbAEvwnjOzXhg6VIdzVK/wLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:07.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8280587e-2fc2-4791-a76c-08dc866becc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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


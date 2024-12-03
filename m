Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23AEE74ADE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCE710EB7B;
	Tue,  3 Dec 2024 21:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nW915TnO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA6A10EB7A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuSvUJsULVQrXIh/uzK8eHOG0sM5opr5apuCqraWbC81bm9jXH0pXXvyRDlWLeW9UUUdvj3qj6pSP0IWXGJUzhk+lcFbTpgBYW/kAKkEqeCKRJSy/+BQiTz5SJjPjHoVq3F2naGdhx3YdacHB3BinThUdn34D/LyQx/BbJcd8PKsZO3tVUhlnP/l5P5CxG5Bz+y75ag1TUJ1HD69DYxR6xeXjpyKhbmkAHEc3C5JYw7F6PQclaAbraetZM6C5YZG4ZRSc8HKJBQ24eTpqbXEMor2DixNiKxr9bcdQPooYK4D4sCauD+Fl7WuMMRoSEtbVspGlXYuoMuqjXf7LDaYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioKqzfUsSRzle6fkQ1zwUqNQCK+iS2LvsWGV6w6X00s=;
 b=cVtFw61oKg4gb5ILncCwWbPdtX1/01Wb4k+bBBE0yG0+rBjPb6tUpY5o74XvgNbN33KSsQnNuOITC8o0jPh8Jf0aDpE6q/iDYSya3vyr5Vc3JOaiKoJ+QAz1GEhdl0d6A3zqfkdsQeL7ikUwdtqsrfYl9ySAWghXjLmy9K25BN0U88PtIs9GYI+F5jwTAXBfZF3WENz3XG2RPqUA/bx2sQN10VRDP6mFlQICkhCQEbuHxSBABaotgi1BJ11vxa6VsfVQtdsmA+0iXMM7WeOajUVZHfITVjxo/qF6nUignXdBOLO+bOmQeQqup6cYyhBojW+QOhA3VqNoW45UmnYWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioKqzfUsSRzle6fkQ1zwUqNQCK+iS2LvsWGV6w6X00s=;
 b=nW915TnOP5zwSpLpBXMUKzFDLJBK9Oi2PbLP7e0xWkkncvIsmE5RdSBwCZVR/XO1o0/TvCz2OYazTVB7ORx8O185zpERMlggrGntth18vY63oWS+90GAAhrEnbrrF2kJOnDJUJ7n+CqFCwCXSjLMs90dvwQ+ouhhFNGiZBgUqQ0=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:50 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::c6) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:48 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:47 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>
Subject: [PATCH 17/19] drm/amd/display: update dcn351 used clock offset
Date: Tue, 3 Dec 2024 16:39:55 -0500
Message-ID: <20241203214120.1161810-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e164df-b505-4f4f-f1c5-08dd13e34b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ay8cNjSCTfeMIlwgBD6pQGMppWspWR+bpWZBWp3HuCEEGej0+oQERya2HDpZ?=
 =?us-ascii?Q?tFr9hOq/iKVwiWsG+iy9tiNRlahECrzEEoybUKBA5g2wQo8AwVJvrY+TSqPO?=
 =?us-ascii?Q?V3zOG5cBEGCldRE5gEl3DPaVWq4BgKXFZVO/6BOftRQRhUdAOSSpKFUWLbIo?=
 =?us-ascii?Q?Zdwd1Vuq6y5OHFKULttRUWJ1wiZ0Q6TTI5vnKiqVwVk3qcOB+IycwA6Ieqjm?=
 =?us-ascii?Q?e6UXcK0q0RQx9DYUwGNvlYYWwFafklza0akqyxIVDhai3ukQz+FjdZJdvWv0?=
 =?us-ascii?Q?uD/WA+wCKIWPkUuyAV/O9/EQt7mbaoIVXqIaViz923BaS55WO9P6pfbhUfNQ?=
 =?us-ascii?Q?oJeDuQGhke/1+swXxLtlg+Sl52HeaP2Vmi25PaaF3mrj0hJJHc2tvFJ3A5f9?=
 =?us-ascii?Q?sW61Vt70rtiA1/x+8uPJKbPqzo/o7ga39ULqHFihkHBXOPLwgCQWF+xKvmKf?=
 =?us-ascii?Q?wf7ncwQEs2AHbEnseYp7iLdN0nmNcfMK/88ETNwPpFTULLrgCVQRhAWSjSCL?=
 =?us-ascii?Q?UXv07SiS/ol8KkzypqUzoK8DU9q1424ByjDWtU+o7a3F58/0SQ9X08KsuSe8?=
 =?us-ascii?Q?/sRrOkcyPrk1eg4eG0MVc5hj3nMWPeHBLCxl/MtDql9z/i/TO5NVbuEerTKr?=
 =?us-ascii?Q?xkyi1E4uwN+XAbl+hSNvzwBzEIHnNEiLa45FT2y8NRHrHJrv8zT13UTAASR2?=
 =?us-ascii?Q?S/mmEg++rVHSBboUnvovl5NFDc9AkLEdH4WSqM0H4a9+MTNwQqx40zi3MpTc?=
 =?us-ascii?Q?Mt960OvULy47Ze1GpSQBZ3EU0y4wezEovYZ8iwMvEmluVMG3Ui2a0UDvGwMy?=
 =?us-ascii?Q?zYAebFRh1ew10MdD6dVQADTb0ekzokNw5y+wUJdwG359wpTvizpVXgTO4HvO?=
 =?us-ascii?Q?j1OrC6tvzZDVivB15Vvsel1q5NV37dQ/X+YSQtaGsgRmRA8p2oeaBi44eLz7?=
 =?us-ascii?Q?kK88cHFUq1KMRu1lak9cBMIMaa/9q2BZl2xNFWzbDr+D8+1OiYLJAIFlW2tj?=
 =?us-ascii?Q?jhZQOJGXh0Q6qWTv4dV2pRa/8lASgC75mrvxY4rOcVCcCjEIxt8LmOnfLRk4?=
 =?us-ascii?Q?6NieiVGqVouVo75HKctwyes441So/eoSLNuYa7yGitQeTgLPdOCT4u1E+msq?=
 =?us-ascii?Q?gQdKKW/DWWvXzMgyARhiaOU9rzAxeGqrqDwfj0h4I4WJX7ObyDlLkrRnlyq+?=
 =?us-ascii?Q?KiCagE3LFqvOmnAfYboM55yLaebOVAYy/jC2mElHeijNNno9g+KHXwa4xfje?=
 =?us-ascii?Q?W8RMG63co6yGvqgMkEOi8o9ZsAJF9O9kKgT/p8Pa+xVcdce513vntj2i4b5w?=
 =?us-ascii?Q?lz0+N1oTUuEmW+HQ97LnhzpGjtjBvD6VYnC9tvh0XnIdrxWoBH+etGFicmC2?=
 =?us-ascii?Q?NmaQyhbN5OpIZE9UkPECw13krpJIJJkrbkEhDSnTuS0Sqn3quVFRWIcLegdb?=
 =?us-ascii?Q?6Bae75SL6JhrrNiO9yPbfr2dPdko/6Ao?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:49.8739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e164df-b505-4f4f-f1c5-08dd13e34b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
hw register offset delta

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c | 140 ++++++++++++++++++
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 132 +++++++++++++----
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h  |   4 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  59 ++++++++
 6 files changed, 308 insertions(+), 34 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index ab1132bc896a..d9955c5d2e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -174,7 +174,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN32)
 ###############################################################################
 # DCN35
 ###############################################################################
-CLK_MGR_DCN35 = dcn35_smu.o dcn35_clk_mgr.o
+CLK_MGR_DCN35 = dcn35_smu.o dcn351_clk_mgr.o dcn35_clk_mgr.o
 
 AMD_DAL_CLK_MGR_DCN35 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn35/,$(CLK_MGR_DCN35))
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 0e243f4344d0..4c3e58c730b1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -355,8 +355,11 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			BREAK_TO_DEBUGGER();
 			return NULL;
 		}
+		if (ctx->dce_version == DCN_VERSION_3_51)
+			dcn351_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+		else
+			dcn35_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 
-		dcn35_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 		return &clk_mgr->base.base;
 	}
 	break;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
new file mode 100644
index 000000000000..6a6ae618650b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+ * Authors: AMD
+ *
+ */
+
+#include "core_types.h"
+#include "dcn35_clk_mgr.h"
+
+#define DCN_BASE__INST0_SEG1 0x000000C0
+#define mmCLK1_CLK_PLL_REQ 0x16E37
+
+#define mmCLK1_CLK0_DFS_CNTL 0x16E69
+#define mmCLK1_CLK1_DFS_CNTL 0x16E6C
+#define mmCLK1_CLK2_DFS_CNTL 0x16E6F
+#define mmCLK1_CLK3_DFS_CNTL 0x16E72
+#define mmCLK1_CLK4_DFS_CNTL 0x16E75
+#define mmCLK1_CLK5_DFS_CNTL 0x16E78
+
+#define mmCLK1_CLK0_CURRENT_CNT 0x16EFC
+#define mmCLK1_CLK1_CURRENT_CNT 0x16EFD
+#define mmCLK1_CLK2_CURRENT_CNT 0x16EFE
+#define mmCLK1_CLK3_CURRENT_CNT 0x16EFF
+#define mmCLK1_CLK4_CURRENT_CNT 0x16F00
+#define mmCLK1_CLK5_CURRENT_CNT 0x16F01
+
+#define mmCLK1_CLK0_BYPASS_CNTL 0x16E8A
+#define mmCLK1_CLK1_BYPASS_CNTL 0x16E93
+#define mmCLK1_CLK2_BYPASS_CNTL 0x16E9C
+#define mmCLK1_CLK3_BYPASS_CNTL 0x16EA5
+#define mmCLK1_CLK4_BYPASS_CNTL 0x16EAE
+#define mmCLK1_CLK5_BYPASS_CNTL 0x16EB7
+
+#define mmCLK1_CLK0_DS_CNTL 0x16E83
+#define mmCLK1_CLK1_DS_CNTL 0x16E8C
+#define mmCLK1_CLK2_DS_CNTL 0x16E95
+#define mmCLK1_CLK3_DS_CNTL 0x16E9E
+#define mmCLK1_CLK4_DS_CNTL 0x16EA7
+#define mmCLK1_CLK5_DS_CNTL 0x16EB0
+
+#define mmCLK1_CLK0_ALLOW_DS 0x16E84
+#define mmCLK1_CLK1_ALLOW_DS 0x16E8D
+#define mmCLK1_CLK2_ALLOW_DS 0x16E96
+#define mmCLK1_CLK3_ALLOW_DS 0x16E9F
+#define mmCLK1_CLK4_ALLOW_DS 0x16EA8
+#define mmCLK1_CLK5_ALLOW_DS 0x16EB1
+
+#define mmCLK5_spll_field_8 0x1B04B
+#define mmDENTIST_DISPCLK_CNTL 0x0124
+#define regDENTIST_DISPCLK_CNTL 0x0064
+#define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
+
+#define CLK1_CLK_PLL_REQ__FbMult_int__SHIFT 0x0
+#define CLK1_CLK_PLL_REQ__PllSpineDiv__SHIFT 0xc
+#define CLK1_CLK_PLL_REQ__FbMult_frac__SHIFT 0x10
+#define CLK1_CLK_PLL_REQ__FbMult_int_MASK 0x000001FFL
+#define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK 0x0000F000L
+#define CLK1_CLK_PLL_REQ__FbMult_frac_MASK 0xFFFF0000L
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK 0x00000007L
+
+// DENTIST_DISPCLK_CNTL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER__SHIFT 0x0
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER__SHIFT 0x8
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE__SHIFT 0x13
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE__SHIFT 0x14
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER__SHIFT 0x18
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER_MASK 0x0000007FL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER_MASK 0x00007F00L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE_MASK 0x00080000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE_MASK 0x00100000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER_MASK 0x7F000000L
+
+#define CLK5_spll_field_8__spll_ssc_en_MASK 0x00002000L
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
+#define CLK_SR_DCN35(reg_name)\
+	.reg_name = mm ## reg_name
+
+static const struct clk_mgr_registers clk_mgr_regs_dcn351 = {
+	CLK_REG_LIST_DCN35()
+};
+
+static const struct clk_mgr_shift clk_mgr_shift_dcn351 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
+};
+
+static const struct clk_mgr_mask clk_mgr_mask_dcn351 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(_MASK)
+};
+
+#define TO_CLK_MGR_DCN35(clk_mgr)\
+	container_of(clk_mgr, struct clk_mgr_dcn35, base)
+
+
+void dcn351_clk_mgr_construct(
+		struct dc_context *ctx,
+		struct clk_mgr_dcn35 *clk_mgr,
+		struct pp_smu_funcs *pp_smu,
+		struct dccg *dccg)
+{
+	/*register offset changed*/
+	clk_mgr->base.regs = &clk_mgr_regs_dcn351;
+	clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn351;
+	clk_mgr->base.clk_mgr_mask = &clk_mgr_mask_dcn351;
+
+	dcn35_clk_mgr_construct(ctx,  clk_mgr, pp_smu, dccg);
+
+}
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index d6e68c0d9e42..2a74140d7ebf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -36,15 +36,11 @@
 #include "dcn20/dcn20_clk_mgr.h"
 
 
-
-
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dcn35_smu.h"
 #include "dm_helpers.h"
 
-/* TODO: remove this include once we ported over remaining clk mgr functions*/
-#include "dcn30/dcn30_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
 
 #include "dc_dmub_srv.h"
@@ -55,35 +51,102 @@
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
 
+#define DCN_BASE__INST0_SEG1 0x000000C0
+#define mmCLK1_CLK_PLL_REQ 0x16E37
+
+#define mmCLK1_CLK0_DFS_CNTL 0x16E69
+#define mmCLK1_CLK1_DFS_CNTL 0x16E6C
+#define mmCLK1_CLK2_DFS_CNTL 0x16E6F
+#define mmCLK1_CLK3_DFS_CNTL 0x16E72
+#define mmCLK1_CLK4_DFS_CNTL 0x16E75
+#define mmCLK1_CLK5_DFS_CNTL 0x16E78
+
+#define mmCLK1_CLK0_CURRENT_CNT 0x16EFB
+#define mmCLK1_CLK1_CURRENT_CNT 0x16EFC
+#define mmCLK1_CLK2_CURRENT_CNT 0x16EFD
+#define mmCLK1_CLK3_CURRENT_CNT 0x16EFE
+#define mmCLK1_CLK4_CURRENT_CNT 0x16EFF
+#define mmCLK1_CLK5_CURRENT_CNT 0x16F00
+
+#define mmCLK1_CLK0_BYPASS_CNTL 0x16E8A
+#define mmCLK1_CLK1_BYPASS_CNTL 0x16E93
+#define mmCLK1_CLK2_BYPASS_CNTL 0x16E9C
+#define mmCLK1_CLK3_BYPASS_CNTL 0x16EA5
+#define mmCLK1_CLK4_BYPASS_CNTL 0x16EAE
+#define mmCLK1_CLK5_BYPASS_CNTL 0x16EB7
+
+#define mmCLK1_CLK0_DS_CNTL 0x16E83
+#define mmCLK1_CLK1_DS_CNTL 0x16E8C
+#define mmCLK1_CLK2_DS_CNTL 0x16E95
+#define mmCLK1_CLK3_DS_CNTL 0x16E9E
+#define mmCLK1_CLK4_DS_CNTL 0x16EA7
+#define mmCLK1_CLK5_DS_CNTL 0x16EB0
+
+#define mmCLK1_CLK0_ALLOW_DS 0x16E84
+#define mmCLK1_CLK1_ALLOW_DS 0x16E8D
+#define mmCLK1_CLK2_ALLOW_DS 0x16E96
+#define mmCLK1_CLK3_ALLOW_DS 0x16E9F
+#define mmCLK1_CLK4_ALLOW_DS 0x16EA8
+#define mmCLK1_CLK5_ALLOW_DS 0x16EB1
+
+#define mmCLK5_spll_field_8 0x1B04B
+#define mmDENTIST_DISPCLK_CNTL 0x0124
+#define regDENTIST_DISPCLK_CNTL 0x0064
+#define regDENTIST_DISPCLK_CNTL_BASE_IDX 1
+
+#define CLK1_CLK_PLL_REQ__FbMult_int__SHIFT 0x0
+#define CLK1_CLK_PLL_REQ__PllSpineDiv__SHIFT 0xc
+#define CLK1_CLK_PLL_REQ__FbMult_frac__SHIFT 0x10
+#define CLK1_CLK_PLL_REQ__FbMult_int_MASK 0x000001FFL
+#define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK 0x0000F000L
+#define CLK1_CLK_PLL_REQ__FbMult_frac_MASK 0xFFFF0000L
+
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK 0x00000007L
+#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK 0x000F0000L
+// DENTIST_DISPCLK_CNTL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER__SHIFT 0x0
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER__SHIFT 0x8
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE__SHIFT 0x13
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE__SHIFT 0x14
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER__SHIFT 0x18
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_WDIVIDER_MASK 0x0000007FL
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_RDIVIDER_MASK 0x00007F00L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DISPCLK_CHG_DONE_MASK 0x00080000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_CHG_DONE_MASK 0x00100000L
+#define DENTIST_DISPCLK_CNTL__DENTIST_DPPCLK_WDIVIDER_MASK 0x7F000000L
+
+#define CLK5_spll_field_8__spll_ssc_en_MASK 0x00002000L
+
+#define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
+#undef FN
+#define FN(reg_name, field_name) \
+	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
 
-#define regCLK1_CLK_PLL_REQ			0x0237
-#define regCLK1_CLK_PLL_REQ_BASE_IDX		0
+#define REG(reg) \
+	(clk_mgr->regs->reg)
 
-#define CLK1_CLK_PLL_REQ__FbMult_int__SHIFT	0x0
-#define CLK1_CLK_PLL_REQ__PllSpineDiv__SHIFT	0xc
-#define CLK1_CLK_PLL_REQ__FbMult_frac__SHIFT	0x10
-#define CLK1_CLK_PLL_REQ__FbMult_int_MASK	0x000001FFL
-#define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
-#define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
+#define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
-#define regCLK1_CLK2_BYPASS_CNTL			0x029c
-#define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
+#define BASE(seg) BASE_INNER(seg)
 
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV__SHIFT	0x10
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV_MASK		0x000F0000L
+#define SR(reg_name)\
+		.reg_name = BASE(reg ## reg_name ## _BASE_IDX) +  \
+					reg ## reg_name
 
-#define regCLK5_0_CLK5_spll_field_8				0x464b
-#define regCLK5_0_CLK5_spll_field_8_BASE_IDX	0
+#define CLK_SR_DCN35(reg_name)\
+	.reg_name = mm ## reg_name
 
-#define CLK5_0_CLK5_spll_field_8__spll_ssc_en__SHIFT	0xd
-#define CLK5_0_CLK5_spll_field_8__spll_ssc_en_MASK		0x00002000L
+static const struct clk_mgr_registers clk_mgr_regs_dcn35 = {
+	CLK_REG_LIST_DCN35()
+};
 
-#define SMU_VER_THRESHOLD 0x5D4A00 //93.74.0
+static const struct clk_mgr_shift clk_mgr_shift_dcn35 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
+};
 
-#define REG(reg_name) \
-	(ctx->clk_reg_offsets[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
+static const struct clk_mgr_mask clk_mgr_mask_dcn35 = {
+	CLK_COMMON_MASK_SH_LIST_DCN32(_MASK)
+};
 
 #define TO_CLK_MGR_DCN35(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn35, base)
@@ -452,7 +515,6 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 	struct fixed31_32 pll_req;
 	unsigned int fbmult_frac_val = 0;
 	unsigned int fbmult_int_val = 0;
-	struct dc_context *ctx = clk_mgr->base.ctx;
 
 	/*
 	 * Register value of fbmult is in 8.16 format, we are converting to 314.32
@@ -512,12 +574,12 @@ static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dc_context *ctx = clk_mgr->base.ctx;
+
 	uint32_t ssc_enable;
 
-	REG_GET(CLK5_0_CLK5_spll_field_8, spll_ssc_en, &ssc_enable);
+	ssc_enable = REG_READ(CLK5_spll_field_8) & CLK5_spll_field_8__spll_ssc_en_MASK;
 
-	return ssc_enable == 1;
+	return ssc_enable != 0;
 }
 
 static void init_clk_states(struct clk_mgr *clk_mgr)
@@ -643,10 +705,10 @@ static struct dcn35_ss_info_table ss_info_table = {
 
 static void dcn35_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
 {
-	struct dc_context *ctx = clk_mgr->base.ctx;
-	uint32_t clock_source;
+	uint32_t clock_source = 0;
+
+	clock_source = REG_READ(CLK1_CLK2_BYPASS_CNTL) & CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK;
 
-	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
 	// If it's DFS mode, clock_source is 0.
 	if (dcn35_is_spll_ssc_enabled(&clk_mgr->base) && (clock_source < ARRAY_SIZE(ss_info_table.ss_percentage))) {
 		clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
@@ -1181,6 +1243,12 @@ void dcn35_clk_mgr_construct(
 	clk_mgr->base.dprefclk_ss_divider = 1000;
 	clk_mgr->base.ss_on_dprefclk = false;
 	clk_mgr->base.dfs_ref_freq_khz = 48000;
+	if (ctx->dce_version == DCN_VERSION_3_5) {
+		clk_mgr->base.regs = &clk_mgr_regs_dcn35;
+		clk_mgr->base.clk_mgr_shift = &clk_mgr_shift_dcn35;
+		clk_mgr->base.clk_mgr_mask = &clk_mgr_mask_dcn35;
+	}
+
 
 	clk_mgr->smu_wm_set.wm_set = (struct dcn35_watermarks *)dm_helpers_allocate_gpu_mem(
 				clk_mgr->base.base.ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
index 1203dc605b12..a12a9bf90806 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
@@ -60,4 +60,8 @@ void dcn35_clk_mgr_construct(struct dc_context *ctx,
 
 void dcn35_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
+void dcn351_clk_mgr_construct(struct dc_context *ctx,
+		struct clk_mgr_dcn35 *clk_mgr,
+		struct pp_smu_funcs *pp_smu,
+		struct dccg *dccg);
 #endif //__DCN35_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index c2dd061892f4..7a1ca1e98059 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -166,6 +166,41 @@ enum dentist_divider_range {
     CLK_SR_DCN32(CLK1_CLK4_CURRENT_CNT), \
     CLK_SR_DCN32(CLK4_CLK0_CURRENT_CNT)
 
+#define CLK_REG_LIST_DCN35()	  \
+	CLK_SR_DCN35(CLK1_CLK_PLL_REQ), \
+	CLK_SR_DCN35(CLK1_CLK0_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK1_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK2_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK3_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK4_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK5_DFS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK0_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK1_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK2_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK3_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK4_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK5_CURRENT_CNT), \
+	CLK_SR_DCN35(CLK1_CLK0_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK1_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK2_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK3_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK4_BYPASS_CNTL),\
+	CLK_SR_DCN35(CLK1_CLK5_BYPASS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK0_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK1_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK2_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK3_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK4_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK5_DS_CNTL), \
+	CLK_SR_DCN35(CLK1_CLK0_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK1_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK2_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK3_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK4_ALLOW_DS), \
+	CLK_SR_DCN35(CLK1_CLK5_ALLOW_DS), \
+	CLK_SR_DCN35(CLK5_spll_field_8), \
+	SR(DENTIST_DISPCLK_CNTL), \
+
 #define CLK_COMMON_MASK_SH_LIST_DCN32(mask_sh) \
 	CLK_COMMON_MASK_SH_LIST_DCN20_BASE(mask_sh),\
 	CLK_SF(CLK1_CLK_PLL_REQ, FbMult_int, mask_sh),\
@@ -236,6 +271,7 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK2_DFS_CNTL;
 	uint32_t CLK1_CLK3_DFS_CNTL;
 	uint32_t CLK1_CLK4_DFS_CNTL;
+	uint32_t CLK1_CLK5_DFS_CNTL;
 	uint32_t CLK2_CLK2_DFS_CNTL;
 
 	uint32_t CLK1_CLK0_CURRENT_CNT;
@@ -243,11 +279,34 @@ struct clk_mgr_registers {
     uint32_t CLK1_CLK2_CURRENT_CNT;
     uint32_t CLK1_CLK3_CURRENT_CNT;
     uint32_t CLK1_CLK4_CURRENT_CNT;
+	uint32_t CLK1_CLK5_CURRENT_CNT;
 
 	uint32_t CLK0_CLK0_DFS_CNTL;
 	uint32_t CLK0_CLK1_DFS_CNTL;
 	uint32_t CLK0_CLK3_DFS_CNTL;
 	uint32_t CLK0_CLK4_DFS_CNTL;
+	uint32_t CLK1_CLK0_BYPASS_CNTL;
+	uint32_t CLK1_CLK1_BYPASS_CNTL;
+	uint32_t CLK1_CLK2_BYPASS_CNTL;
+	uint32_t CLK1_CLK3_BYPASS_CNTL;
+	uint32_t CLK1_CLK4_BYPASS_CNTL;
+	uint32_t CLK1_CLK5_BYPASS_CNTL;
+
+	uint32_t CLK1_CLK0_DS_CNTL;
+	uint32_t CLK1_CLK1_DS_CNTL;
+	uint32_t CLK1_CLK2_DS_CNTL;
+	uint32_t CLK1_CLK3_DS_CNTL;
+	uint32_t CLK1_CLK4_DS_CNTL;
+	uint32_t CLK1_CLK5_DS_CNTL;
+
+	uint32_t CLK1_CLK0_ALLOW_DS;
+	uint32_t CLK1_CLK1_ALLOW_DS;
+	uint32_t CLK1_CLK2_ALLOW_DS;
+	uint32_t CLK1_CLK3_ALLOW_DS;
+	uint32_t CLK1_CLK4_ALLOW_DS;
+	uint32_t CLK1_CLK5_ALLOW_DS;
+	uint32_t CLK5_spll_field_8;
+
 };
 
 struct clk_mgr_shift {
-- 
2.47.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21E4CCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4215F10E707;
	Wed, 22 Oct 2025 07:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XIHxRXw/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27E110E700
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBiPTmA8yHxQbP6jRejMIPcK2cZfdP6MaoVv9Q0pMBr5u6hHHTCoN3+272B1f0cQVo6BqYSf3fNJiVazhjwdsXdQBqdVgDVJhc3n/lhxoo0BkMopPyXBq8ebzcj1cVmj3/mOdREfllag6hiStquLdXEUEnsCaCoUX0hPqd3Vh8PyQW1NOi4Qvyr5nKRG6VzYnO1aVOViylyfKsttwORneWR1C95YfWoeIt4ftaRYTK/7B26jIAo5aTjw7viWxwCpcq6qUs79Q/Lq9To7lpJGxrZNUtsk2O+QUJ4L/yfqBNUjmODvzHpps+VxbaGrTB7ObdWU64x7O03zGgTH/E8xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPvzC6TrEPQP/pE3QIkpv4P1RIr6FvHw0ZoaVkGczto=;
 b=v/7tA03Lu5gxPbUmgnzOjfcO66+9W4g98kX3NMPF5lhzmpGrNR36PcyS+H6mNEOxAReqoRgVO3ZJj3+Uhk+w9kJU4fDTxVPM2HR5FwNEQ4wXSGcl3IJdSieVq+I7SR14jUJbN3zZwf2f/WpZfTM07uaanDPDONovDFPW2TL9THZocqimMyJ0U8AZzlHEwnt/rbTofO+m1EmXiRZcmXKOTM/QRZTKBnau7O2087Xx4+Q7foho4i9UDnUfmbjI9I/vMTEPSxlFsYUrVt+F0GNA1XQ/qroQSolzd0/brNybNu3Jih6YzsRyimzMCic9YeMRQI0+mVvAwpuLxRUC+8y8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPvzC6TrEPQP/pE3QIkpv4P1RIr6FvHw0ZoaVkGczto=;
 b=XIHxRXw/kgi2NaIr8/v0S6ftd/4sKKB+ngLRhL5ubR5sV2bdVxpr1HWyQAQVa/+uaS9nrFoLB2646R69DssSqouVYHGgGwDO8n+dqKv5zTIVW7+vy5lsULtO4oVRGAbhpo4xZ75P1t0PxENO2n4BF08HaCvX1GW2bnL4okGTUi8=
Received: from DS7PR07CA0024.namprd07.prod.outlook.com (2603:10b6:5:3af::6) by
 SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 07:34:54 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::47) by DS7PR07CA0024.outlook.office365.com
 (2603:10b6:5:3af::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:54 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:54 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:51 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Zhongwei Zhang <Zhongwei.Zhang@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 12/20] drm/amd/display: init dispclk from bootup clock for
 DCN315
Date: Wed, 22 Oct 2025 15:30:24 +0800
Message-ID: <20251022073332.666119-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: aa58071a-1430-410a-a7ec-08de113d7eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oq4336AX0RcsFVCmf/yt4PNvcEZSrQ+TSiRhFuZApP8ii+Vl70Ox0lhTBhFy?=
 =?us-ascii?Q?f22YhvEmJiDG7QnlRLD5K3TH6AKLXhWlOIhKbP//NEsfN6qloV7p6uYW+xav?=
 =?us-ascii?Q?tQMchIvngFN7qyZsux7lfSwvm+hrKhNPbQaZXWoWOm705eWqgb+8z7jPB1lL?=
 =?us-ascii?Q?QjuF/ALes0QNKQG4LajY+F0ENevLowjlSS9NCeDfitue4BCoM2kYwSUbikC1?=
 =?us-ascii?Q?He4K3vDJzCmZyClxl0R4S6RV1FLNFO0YZ9OMs1rXpnEjp20BTDluFgd6l4IZ?=
 =?us-ascii?Q?C98M0UyGMLigX2a1pr6E4boOS+bE5PlnpkJEvEyOL0Bi35dve2GG8I6Gkigm?=
 =?us-ascii?Q?jaFDMK8/+LerGdqtiH7M8wS4sN1wuMLw6K5YPt3hBhgETRuoCJ4Igj5gAlCt?=
 =?us-ascii?Q?jnh2volMba8ijfsD/uahEV0d7UYC00GOYCeEVPER9O41r99sG2/NATdpIE/r?=
 =?us-ascii?Q?/Bx3ArSz3qUJeeD4c6vYNc6sV5/BOyKpfxZPqM80VtFSbD46SzjARnvHhwW2?=
 =?us-ascii?Q?ZqQMiv2yUwNJ28YAqCRIxiM0vZI/Q8ng7qWxBzR4yOvFieval3SWe+Gl/Mf8?=
 =?us-ascii?Q?UuQcnM2GF5Ml8A2Ks4i2rQTSIORggFV5oa0pY/hyADW7MyE8pMF+j6garZbF?=
 =?us-ascii?Q?dmA4EEtqGjeJ7UIUEq1vEYrFi1AzRCGUPN2SE3XrE0ON78+ZUMDCk4NLcqZv?=
 =?us-ascii?Q?oUkH0qZ53sYRlPwN3+KJSd8QObUdjs1oOncWEBQuug8IxrtDk6yrU742MYys?=
 =?us-ascii?Q?nJ/luEg+iBDIqVP48oHf8tE67gPCbZt3SRljNBmwWwTl6HUdG7ocGa8lqK7X?=
 =?us-ascii?Q?8QuxiY26J8zTv15VjicRks5PMN85ZtNyQNTV9BA9Zq6UVD/hnaMXZRQlkid6?=
 =?us-ascii?Q?qNdUU5jYfdjn6pokQkdhW10A5q51k6Qcs7RQYL9MFDHf0zG8n9AAzZBKZXKt?=
 =?us-ascii?Q?YoSdgAr5VOVaoptR8LsnZvJmNdiKR8fAuov1HNtJ5Upew6xPR0bY1mYlam2H?=
 =?us-ascii?Q?sRGH7bTJGjxXB+gzakPTE+jEKNOSprVO+avlURGNXKaMOmSMkJCR0MyL2z24?=
 =?us-ascii?Q?/IyL5fVjgqYsdJFlN/8kM/nL5HJNGJVZdWqMIG2hwM/Ni0WN/aJrf5R1957I?=
 =?us-ascii?Q?v/2Ojobw+b8rMwrZpKBpusuX2RcLxYDypXyEk5TVQCk6vDmUnPez8IPy+4gQ?=
 =?us-ascii?Q?MjdyMjbYmbUrNRmXTHBAnlLEs7FHPBFQ5PsRl1mwsZhff7QJQsb/s39ofpXN?=
 =?us-ascii?Q?AZtvp5olFegO8L/VAgaOS0P0X1PKjml5DTvkyOUP2Lgz9Iu4vTYL5VYnW3nu?=
 =?us-ascii?Q?DAVA0ZnqShoJD5qylqM3ndeKo58ryEj2v4nRc7PDB5tD3m6qFj4njR9ZRS6O?=
 =?us-ascii?Q?vYEb4r1pAlWL0pKfacbqFooblXHFdT4OuPRQSse0C+84evURqrzoScNIW/XL?=
 =?us-ascii?Q?NH4Mun+D4dEyA7a4vcye8CztdzppAY9Z36bTmehy4G3HF0DeEI9EhsXulBdp?=
 =?us-ascii?Q?/h4zWGzTLxDxU5BuRjHZVtgvDSJ6ZU68newWnAfXoF6epiiD+fRxydictcNO?=
 =?us-ascii?Q?GswO5WRe3xUcQVtHwzZTT/xk5xn1plSJU7hyOJsU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:54.8643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa58071a-1430-410a-a7ec-08de113d7eb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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

From: Zhongwei Zhang <Zhongwei.Zhang@amd.com>

[Why]
Driver does not pick up and save vbios's clocks during init clocks,
the dispclk in clk_mgr will keep 0.
OS might change the timing (lower the pixel clock) after boot.
Then driver will set the dispclk to lower when safe_to_lower is false,
for in clk_mgr dispclk is zero, it's illegal and causes garbage.

[How]
Dump and save the vbios's clocks, and init the dispclk in
dcn315_init_clocks.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 87 ++++++++++++++++++-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.h        |  1 +
 .../dc/resource/dcn315/dcn315_resource.c      |  1 +
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index b315ed91e010..3a881451e9da 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -40,7 +40,7 @@
 #include "dm_helpers.h"
 
 #include "dc_dmub_srv.h"
-
+#include "reg_helper.h"
 #include "logger_types.h"
 #undef DC_LOGGER
 #define DC_LOGGER \
@@ -48,9 +48,43 @@
 
 #include "link_service.h"
 
+#define MAX_INSTANCE                                        7
+#define MAX_SEGMENT                                         8
+
+struct IP_BASE_INSTANCE {
+	unsigned int segment[MAX_SEGMENT];
+};
+
+struct IP_BASE {
+	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
+};
+
+static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x00016E00, 0x02401C00, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x00017000, 0x02402000, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x00017200, 0x02402400, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x0001B000, 0x0242D800, 0, 0, 0, 0, 0, 0 } },
+					{ { 0x0001B200, 0x0242DC00, 0, 0, 0, 0, 0, 0 } } } };
+
+#define regCLK1_CLK0_CURRENT_CNT			0x0314
+#define regCLK1_CLK0_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK1_CURRENT_CNT			0x0315
+#define regCLK1_CLK1_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK2_CURRENT_CNT			0x0316
+#define regCLK1_CLK2_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK3_CURRENT_CNT			0x0317
+#define regCLK1_CLK3_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK4_CURRENT_CNT			0x0318
+#define regCLK1_CLK4_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK5_CURRENT_CNT			0x0319
+#define regCLK1_CLK5_CURRENT_CNT_BASE_IDX	0
+
 #define TO_CLK_MGR_DCN315(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn315, base)
 
+#define REG(reg_name) \
+	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
+
 #define UNSUPPORTED_DCFCLK 10000000
 #define MIN_DPP_DISP_CLK     100000
 
@@ -245,9 +279,38 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
+static void dcn315_dump_clk_registers_internal(struct dcn35_clk_internal *internal, struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	// read dtbclk
+	internal->CLK1_CLK4_CURRENT_CNT = REG_READ(CLK1_CLK4_CURRENT_CNT);
+
+	// read dcfclk
+	internal->CLK1_CLK3_CURRENT_CNT = REG_READ(CLK1_CLK3_CURRENT_CNT);
+
+	// read dppclk
+	internal->CLK1_CLK1_CURRENT_CNT = REG_READ(CLK1_CLK1_CURRENT_CNT);
+
+	// read dprefclk
+	internal->CLK1_CLK2_CURRENT_CNT = REG_READ(CLK1_CLK2_CURRENT_CNT);
+
+	// read dispclk
+	internal->CLK1_CLK0_CURRENT_CNT = REG_READ(CLK1_CLK0_CURRENT_CNT);
+}
+
 static void dcn315_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
+	struct dcn35_clk_internal internal = {0};
+
+	dcn315_dump_clk_registers_internal(&internal, clk_mgr_base);
+
+	regs_and_bypass->dcfclk = internal.CLK1_CLK3_CURRENT_CNT / 10;
+	regs_and_bypass->dprefclk = internal.CLK1_CLK2_CURRENT_CNT / 10;
+	regs_and_bypass->dispclk = internal.CLK1_CLK0_CURRENT_CNT / 10;
+	regs_and_bypass->dppclk = internal.CLK1_CLK1_CURRENT_CNT / 10;
+	regs_and_bypass->dtbclk = internal.CLK1_CLK4_CURRENT_CNT / 10;
 	return;
 }
 
@@ -594,13 +657,32 @@ static struct clk_mgr_funcs dcn315_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn315_update_clocks,
-	.init_clocks = dcn31_init_clocks,
+	.init_clocks = dcn315_init_clocks,
 	.enable_pme_wa = dcn315_enable_pme_wa,
 	.are_clock_states_equal = dcn31_are_clock_states_equal,
 	.notify_wm_ranges = dcn315_notify_wm_ranges
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
+void dcn315_init_clocks(struct clk_mgr *clk_mgr)
+{
+	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+	struct clk_mgr_dcn315 *clk_mgr_dcn315 = TO_CLK_MGR_DCN315(clk_mgr_int);
+	struct clk_log_info log_info = {0};
+
+	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
+	// Assumption is that boot state always supports pstate
+	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
+	clk_mgr->clks.p_state_change_support = true;
+	clk_mgr->clks.prev_p_state_change_support = true;
+	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
+	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
+
+	dcn315_dump_clk_registers(&clk_mgr->boot_snapshot, &clk_mgr_dcn315->base.base, &log_info);
+	clk_mgr->clks.dispclk_khz =  clk_mgr->boot_snapshot.dispclk * 1000;
+}
+
 void dcn315_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn315 *clk_mgr,
@@ -661,6 +743,7 @@ void dcn315_clk_mgr_construct(
 	/* Saved clocks configured at boot for debug purposes */
 	dcn315_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				  &clk_mgr->base.base, &log_info);
+	clk_mgr->base.base.clks.dispclk_khz =  clk_mgr->base.base.boot_snapshot.dispclk * 1000;
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h
index ac36ddf5dd1a..642ae3d4a790 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h
@@ -44,6 +44,7 @@ void dcn315_clk_mgr_construct(struct dc_context *ctx,
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg);
 
+void dcn315_init_clocks(struct clk_mgr *clk_mgr);
 void dcn315_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
 #endif //__DCN315_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 38f6328cda92..4e962f522f1b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -889,6 +889,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.psr_power_use_phy_fsm = 0,
 	.using_dml2 = false,
+	.min_disp_clk_khz = 100000,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0


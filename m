Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B22DC5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EDF10E7B8;
	Wed,  4 Jun 2025 19:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NqC74BCF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C008310E7A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNRQDRjpLOuuOZfq64RXDeNRg9t2g+i9lJIpS1FMUYgdsQ/iN7qzoL42AT0XYraIU+/v7XZOcahMDsDwbX3qzy/0i/T1COeM4pPN01/WjlHKNW1G5KtAeSRRXPpWmovY19KcW34G8yqdHDo2RcKpqnV50jpqw/B4EhYoUG39U0HnYcsVhBuf5b5E04a6OmoiSNOJ0zla/c/HrfygxWdHRoErWnzqPfGfA4NESl+/neCbp4UTQcAIqqGjmJD1fG/0iuMiMQlTF+l2x5WBTpTCB4EQGDtXSt9/95udA9uirlkvD89ftQQv5YB+4zin7OhpZJ1xdO3/fNyAlwCDZXyU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fbiMkROPoHjyk5OD0jSYYcuIdjj60yS2OGPsxhBx0k=;
 b=JD+j+UV1+2vtYmV3dYt6wDEfBfqT6BkqkWFbzDbjxCC8S7W61H/m/t29d/v2tZfkf2/0xokfEv2ZGuldAKYNgqbTBlz/zFDu1F68deAeGGkpIu04zm76P3en+giHclTBElPtnd6CC8dKSpQCzB9I0vlcI5y6A/pPz0nHdyLVMWex4Ud4wo/Yg8SUVYiqOO/m7J/+D1mYANOqQGoYw7uu5Wm9W0lVLBsdEeP2k5rLS3KT80M+VgVfbNq2IGRUOptj74mHu66llTOnU0q1qEkAD87ie4a6YAdJSH8zvMJOj4e32HkpzYe1Vl4RJ00r6gAD1TcHk/1Nj8mU3Vgi28xVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fbiMkROPoHjyk5OD0jSYYcuIdjj60yS2OGPsxhBx0k=;
 b=NqC74BCFzy34rVcLf5ZSez1Fy6JC9Rq1d+qYzonU6sJ9cYQ5PxNX8QqGZPnz/y1TQhQJuXJk53HnsVslC2Yk/Barms0jujPQ/xeL91ibWfBKMIAnCuig+YEkADe49ZXi0UWZQTQI4rSJRpKJlLvr4ua6Ze5x+s7lupZU4Xs8R28=
Received: from CH2PR19CA0009.namprd19.prod.outlook.com (2603:10b6:610:4d::19)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 19:38:44 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::c2) by CH2PR19CA0009.outlook.office365.com
 (2603:10b6:610:4d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:38:44 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:38:42 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/23] drm/amd/display: Remove dml/dcn401 files and references
Date: Wed, 4 Jun 2025 12:43:17 -0600
Message-ID: <20250604193659.2462225-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfb6599-8755-404c-d57a-08dda39f6adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bTO+mkuymkQqvbYARnVqS+/859Oiy3JKg2AiX2r1X3spLJk6+9vO5A5aNcE+?=
 =?us-ascii?Q?F7hwzC94KyNxVFHVm3biwjg84+aEOFgGqwS44wi0HP2a4AAuDYFr94NqWOle?=
 =?us-ascii?Q?8vafg+usnyfl/a3HV3nrVuxtqzlYyf4IKWdNJnssV9832b/gVTmxIV+hY7A2?=
 =?us-ascii?Q?7OgFm5bgqnSVGme+3Zz99q8KUjGVPf3xEoYxpxmDLboX6Bof7/G6A+UZDTCx?=
 =?us-ascii?Q?KKnhWfMWuZ8NykntrSopVTzKwE5INBBmOqO62MFVh/VYREJIfw5+NzOpxgxM?=
 =?us-ascii?Q?bWx8tb6qEIEcxodQePLbZId78Hv0Bx/u/6KeYVDDwr+kQomNETVGHnZagZrI?=
 =?us-ascii?Q?6i0IlckoWj326rZo5uyQa1116MKhkQrBSyhKIDHpZ6fUQjKgENx+WyHQ9n7h?=
 =?us-ascii?Q?36/IukGxm+WG4Rsdkl+u2PrX72ga+W10/t2hC9QeI4SaBs8SwhiBBeZ+NaPv?=
 =?us-ascii?Q?8fn+sHz5l/d+EOUJGkY16d1bSg4bd/wf1mXKdE3ll69eBdGafSgBbgr1N7Ur?=
 =?us-ascii?Q?jaP+vsc1NjrvjbcU5pL3SDWfeBgmYd6NAqzDNuTiXtYWfla9rDdpNilfggZ2?=
 =?us-ascii?Q?iIChde1dWTdHpG7cRjbYBoRffZYOEnuyeD2icFLqWGsoIXTfkF145I6dgy56?=
 =?us-ascii?Q?DSwEISUUlOtfeRcRoSgTl7g0AGA7KoiX1aibOlAl89aqchrRZmAQdGGonPHp?=
 =?us-ascii?Q?VEi5vP13ynda0PvdxMfD0N9Pej8UBfdp5//wRjlrsdQTY1NxIS9l2RZvQpOY?=
 =?us-ascii?Q?H2uTVY/Ctxhd2rg4GUZ+/a69bl7pWKk8W0Alg7MRvCIbGxCW3wQGbIq59ysP?=
 =?us-ascii?Q?sVzJQspUZ8nhPvCTbthTOgXLmafsFxP9+Z46cMhgI8Lal7Ss40okht0b3jUo?=
 =?us-ascii?Q?7hk2gKVnBUXdDF9F3E26WjXlfmjUU9+ka+HSxjGZkrXrCGnK0p0Bga9wgvue?=
 =?us-ascii?Q?9V4WSQ/CuhF3RCZLA46c4Coj2ISIwQNXt2ZBYcVtZQVT7Wj80qZVlqwNFqPG?=
 =?us-ascii?Q?NtKCvLUEXqskfs3XoDTkWVq/ovo7sj+EL7VSs/jxFazyEvMERuZA8SbWdxse?=
 =?us-ascii?Q?URrHrtwhdTDttZHNsIpcVcQYaYouMlA8PJjnO04uQZDgG0XklqesaZ5OoaIY?=
 =?us-ascii?Q?sYE3/mJQEKMqUHgWd5a9qTZ8gAisxwKZhhDiZct3RH/8PL1f0MyqHm/3MCbG?=
 =?us-ascii?Q?0Ji7C+sr6fZDnYAi+On5Zpig0gQIejCgkOGbN30zO/bIBlV98sHoNhurKlCu?=
 =?us-ascii?Q?wWLgt/opNqgdXjVtm1kLbz7IVSVfNCG2j0ZCzppSm8oeQpwhT/98WQMfgtV5?=
 =?us-ascii?Q?/HAWg88bSiCa15wGA5cs9YQ9UuHjfceDJtnnmf89MJ4sB8XajyQTRZdp7UhJ?=
 =?us-ascii?Q?BaSQYqgKQwxFfwqztx1HUpC2CEnZTgBzmbmFPQoW/VLOGKpWT7+NB7oeKPp7?=
 =?us-ascii?Q?ecpLmoQgi73pThKiAS0VcKw3Gg7OKdI8W85EhzB42a8/Nu/4B/F5ojEZXg2B?=
 =?us-ascii?Q?2bZcM1khpRGMyBGEYw6n8V6zbNh50jXVpW+r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:38:44.3591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfb6599-8755-404c-d57a-08dda39f6adb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
DCN401 is only supported using DML2.1, so remove unused code and files.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  67 +++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   4 -
 .../amd/display/dc/dml/dcn401/dcn401_fpu.c    | 239 ------------------
 .../amd/display/dc/dml/dcn401/dcn401_fpu.h    |  14 -
 .../dc/resource/dcn401/dcn401_resource.c      |   3 -
 5 files changed, 29 insertions(+), 298 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index a3b8e3d4a429..13334ee987f7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -22,8 +22,6 @@
 #include "dcn/dcn_4_1_0_offset.h"
 #include "dcn/dcn_4_1_0_sh_mask.h"
 
-#include "dml/dcn401/dcn401_fpu.h"
-
 #define DCN_BASE__INST0_SEG1                       0x000000C0
 
 #define mmCLK01_CLK0_CLK_PLL_REQ                        0x16E37
@@ -183,43 +181,36 @@ static void dcn401_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e c
 
 static void dcn401_build_wm_range_table(struct clk_mgr *clk_mgr)
 {
-	/* legacy */
-	DC_FP_START();
-	dcn401_build_wm_range_table_fpu(clk_mgr);
-	DC_FP_END();
-
-	if (clk_mgr->ctx->dc->debug.using_dml21) {
-		/* For min clocks use as reported by PM FW and report those as min */
-		uint16_t min_uclk_mhz = clk_mgr->bw_params->clk_table.entries[0].memclk_mhz;
-		uint16_t min_dcfclk_mhz	= clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
-
-		/* Set A - Normal - default values */
-		clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid = true;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_dcfclk = 0xFFFF;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk = min_uclk_mhz;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_uclk = 0xFFFF;
-
-		/* Set B - Unused on dcn4 */
-		clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid = false;
-
-		/* Set 1A - Dummy P-State - P-State latency set to "dummy p-state" value */
-		/* 'DalDummyClockChangeLatencyNs' registry key option set to 0x7FFFFFFF can be used to disable Set C for dummy p-state */
-		if (clk_mgr->ctx->dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF) {
-			clk_mgr->bw_params->wm_table.nv_entries[WM_1A].valid = true;
-			clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.wm_type = WATERMARKS_DUMMY_PSTATE;
-			clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-			clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.max_dcfclk = 0xFFFF;
-			clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_uclk = min_uclk_mhz;
-			clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.max_uclk = 0xFFFF;
-		} else {
-			clk_mgr->bw_params->wm_table.nv_entries[WM_1A].valid = false;
-		}
-
-		/* Set 1B - Unused on dcn4 */
-		clk_mgr->bw_params->wm_table.nv_entries[WM_1B].valid = false;
+	/* For min clocks use as reported by PM FW and report those as min */
+	uint16_t min_uclk_mhz = clk_mgr->bw_params->clk_table.entries[0].memclk_mhz;
+	uint16_t min_dcfclk_mhz	= clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
+
+	/* Set A - Normal - default values */
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid = true;
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_dcfclk = 0xFFFF;
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk = min_uclk_mhz;
+	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_uclk = 0xFFFF;
+
+	/* Set B - Unused on dcn4 */
+	clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid = false;
+
+	/* Set 1A - Dummy P-State - P-State latency set to "dummy p-state" value */
+	/* 'DalDummyClockChangeLatencyNs' registry key option set to 0x7FFFFFFF can be used to disable Set C for dummy p-state */
+	if (clk_mgr->ctx->dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF) {
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].valid = true;
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.wm_type = WATERMARKS_DUMMY_PSTATE;
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.max_dcfclk = 0xFFFF;
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.min_uclk = min_uclk_mhz;
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].pmfw_breakdown.max_uclk = 0xFFFF;
+	} else {
+		clk_mgr->bw_params->wm_table.nv_entries[WM_1A].valid = false;
 	}
+
+	/* Set 1B - Unused on dcn4 */
+	clk_mgr->bw_params->wm_table.nv_entries[WM_1B].valid = false;
 }
 
 void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index e1d500633dfa..b357683b4255 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -114,9 +114,6 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
 
-CFLAGS_$(AMDDALPATH)/dc/dml/dcn401/dcn401_fpu.o := $(dml_ccflags)
-CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn401/dcn401_fpu.o := $(dml_rcflags)
-
 ifdef CONFIG_DRM_AMD_DC_FP
 DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
 DML += dcn10/dcn10_fpu.o
@@ -137,7 +134,6 @@ DML += dcn303/dcn303_fpu.o
 DML += dcn314/dcn314_fpu.o
 DML += dcn35/dcn35_fpu.o
 DML += dcn351/dcn351_fpu.o
-DML += dcn401/dcn401_fpu.o
 DML += dsc/rc_calc_fpu.o
 DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.c
deleted file mode 100644
index 4fbecb5ff349..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.c
+++ /dev/null
@@ -1,239 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-#include "dcn401_fpu.h"
-#include "dcn401/dcn401_resource.h"
-// We need this includes for WATERMARKS_* defines
-#include "clk_mgr/dcn401/dcn401_smu14_driver_if.h"
-#include "link.h"
-
-#define DC_LOGGER_INIT(logger)
-
-void dcn401_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
-{
-	/* defaults */
-	double pstate_latency_us = clk_mgr->ctx->dc->dml.soc.dram_clock_change_latency_us;
-	double fclk_change_latency_us = clk_mgr->ctx->dc->dml.soc.fclk_change_latency_us;
-	double sr_exit_time_us = clk_mgr->ctx->dc->dml.soc.sr_exit_time_us;
-	double sr_enter_plus_exit_time_us = clk_mgr->ctx->dc->dml.soc.sr_enter_plus_exit_time_us;
-	/* For min clocks use as reported by PM FW and report those as min */
-	uint16_t min_uclk_mhz			= clk_mgr->bw_params->clk_table.entries[0].memclk_mhz;
-	uint16_t min_dcfclk_mhz			= clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
-	uint16_t setb_min_uclk_mhz		= min_uclk_mhz;
-	uint16_t dcfclk_mhz_for_the_second_state = clk_mgr->ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz;
-
-	dc_assert_fp_enabled();
-
-	/* For Set B ranges use min clocks state 2 when available, and report those to PM FW */
-	if (dcfclk_mhz_for_the_second_state)
-		clk_mgr->bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = dcfclk_mhz_for_the_second_state;
-	else
-		clk_mgr->bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
-
-	if (clk_mgr->bw_params->clk_table.entries[2].memclk_mhz)
-		setb_min_uclk_mhz = clk_mgr->bw_params->clk_table.entries[2].memclk_mhz;
-
-	/* Set A - Normal - default values */
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid = true;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us = pstate_latency_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us = sr_exit_time_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_dcfclk = 0xFFFF;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk = min_uclk_mhz;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_uclk = 0xFFFF;
-
-	/* Set B - Performance - higher clocks, using DPM[2] DCFCLK and UCLK */
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid = true;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us = pstate_latency_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us = sr_exit_time_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_dcfclk = 0xFFFF;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_uclk = setb_min_uclk_mhz;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_uclk = 0xFFFF;
-
-	/* Set C - Dummy P-State - P-State latency set to "dummy p-state" value */
-	/* 'DalDummyClockChangeLatencyNs' registry key option set to 0x7FFFFFFF can be used to disable Set C for dummy p-state */
-	if (clk_mgr->ctx->dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF) {
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid = true;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us = 50;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us = sr_exit_time_us;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.wm_type = WATERMARKS_DUMMY_PSTATE;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_dcfclk = 0xFFFF;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_uclk = min_uclk_mhz;
-		clk_mgr->bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_uclk = 0xFFFF;
-		clk_mgr->bw_params->dummy_pstate_table[0].dram_speed_mts = clk_mgr->bw_params->clk_table.entries[0].memclk_mhz * 16;
-		clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us = 50;
-		clk_mgr->bw_params->dummy_pstate_table[1].dram_speed_mts = clk_mgr->bw_params->clk_table.entries[1].memclk_mhz * 16;
-		clk_mgr->bw_params->dummy_pstate_table[1].dummy_pstate_latency_us = 9;
-		clk_mgr->bw_params->dummy_pstate_table[2].dram_speed_mts = clk_mgr->bw_params->clk_table.entries[2].memclk_mhz * 16;
-		clk_mgr->bw_params->dummy_pstate_table[2].dummy_pstate_latency_us = 8;
-		clk_mgr->bw_params->dummy_pstate_table[3].dram_speed_mts = clk_mgr->bw_params->clk_table.entries[3].memclk_mhz * 16;
-		clk_mgr->bw_params->dummy_pstate_table[3].dummy_pstate_latency_us = 5;
-	}
-	/* Set D - MALL - SR enter and exit time specific to MALL, TBD after bringup or later phase for now use DRAM values / 2 */
-	/* For MALL DRAM clock change latency is N/A, for watermak calculations use lowest value dummy P state latency */
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid = true;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us = clk_mgr->bw_params->dummy_pstate_table[3].dummy_pstate_latency_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = sr_exit_time_us / 2; // TBD
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us / 2; // TBD
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.wm_type = WATERMARKS_MALL;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_dcfclk = 0xFFFF;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_uclk = min_uclk_mhz;
-	clk_mgr->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
-}
-
-/*
- * dcn401_update_bw_bounding_box
- *
- * This would override some dcn4_01 ip_or_soc initial parameters hardcoded from
- * spreadsheet with actual values as per dGPU SKU:
- * - with passed few options from dc->config
- * - with dentist_vco_frequency from Clk Mgr (currently hardcoded, but might
- *   need to get it from PM FW)
- * - with passed latency values (passed in ns units) in dc-> bb override for
- *   debugging purposes
- * - with passed latencies from VBIOS (in 100_ns units) if available for
- *   certain dGPU SKU
- * - with number of DRAM channels from VBIOS (which differ for certain dGPU SKU
- *   of the same ASIC)
- * - clocks levels with passed clk_table entries from Clk Mgr as reported by PM
- *   FW for different clocks (which might differ for certain dGPU SKU of the
- *   same ASIC)
- */
-void dcn401_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
-{
-	dc_assert_fp_enabled();
-
-	/* Override from passed dc->bb_overrides if available*/
-	if (dc->bb_overrides.sr_exit_time_ns)
-		dc->dml2_options.bbox_overrides.sr_exit_latency_us =
-				dc->bb_overrides.sr_exit_time_ns / 1000.0;
-
-	if (dc->bb_overrides.sr_enter_plus_exit_time_ns)
-		dc->dml2_options.bbox_overrides.sr_enter_plus_exit_latency_us =
-			dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
-
-	if (dc->bb_overrides.urgent_latency_ns)
-		dc->dml2_options.bbox_overrides.urgent_latency_us =
-				dc->bb_overrides.urgent_latency_ns / 1000.0;
-
-	if (dc->bb_overrides.dram_clock_change_latency_ns)
-		dc->dml2_options.bbox_overrides.dram_clock_change_latency_us =
-			dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
-
-	if (dc->bb_overrides.fclk_clock_change_latency_ns)
-		dc->dml2_options.bbox_overrides.fclk_change_latency_us =
-			dc->bb_overrides.fclk_clock_change_latency_ns / 1000;
-
-	/* Override from VBIOS if VBIOS bb_info available */
-	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-		struct bp_soc_bb_info bb_info = {0};
-		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
-			if (bb_info.dram_clock_change_latency_100ns > 0)
-				dc->dml2_options.bbox_overrides.dram_clock_change_latency_us =
-					bb_info.dram_clock_change_latency_100ns * 10;
-
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dc->dml2_options.bbox_overrides.sr_enter_plus_exit_latency_us =
-					bb_info.dram_sr_enter_exit_latency_100ns * 10;
-
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dc->dml2_options.bbox_overrides.sr_exit_latency_us =
-					bb_info.dram_sr_exit_latency_100ns * 10;
-		}
-	}
-
-	/* Override from VBIOS for num_chan */
-	if (dc->ctx->dc_bios->vram_info.num_chans) {
-		dc->dml2_options.bbox_overrides.dram_num_chan =
-				dc->ctx->dc_bios->vram_info.num_chans;
-
-	}
-
-	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
-		dc->dml2_options.bbox_overrides.dram_chanel_width_bytes =
-				dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-
-	dc->dml2_options.bbox_overrides.disp_pll_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-	dc->dml2_options.bbox_overrides.xtalclk_mhz = dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency / 1000.0;
-	dc->dml2_options.bbox_overrides.dchub_refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000.0;
-	dc->dml2_options.bbox_overrides.dprefclk_mhz = dc->clk_mgr->dprefclk_khz / 1000.0;
-
-	if (dc->clk_mgr->bw_params->clk_table.num_entries > 1) {
-		unsigned int i = 0;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_states = dc->clk_mgr->bw_params->clk_table.num_entries;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
-			dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_fclk_levels =
-			dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_fclk_levels;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_memclk_levels =
-			dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_socclk_levels =
-			dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_socclk_levels;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dtbclk_levels =
-			dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dispclk_levels =
-			dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
-
-		dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dppclk_levels =
-			dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dppclk_levels;
-
-		for (i = 0; i < dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels; i++) {
-			if (dc->clk_mgr->bw_params->clk_table.entries[i].dcfclk_mhz)
-				dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz =
-					dc->clk_mgr->bw_params->clk_table.entries[i].dcfclk_mhz;
-		}
-
-		for (i = 0; i < dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_fclk_levels; i++) {
-			if (dc->clk_mgr->bw_params->clk_table.entries[i].fclk_mhz)
-				dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].fclk_mhz =
-					dc->clk_mgr->bw_params->clk_table.entries[i].fclk_mhz;
-		}
-
-		for (i = 0; i < dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels; i++) {
-			if (dc->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
-				dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
-					dc->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz;
-		}
-
-		for (i = 0; i < dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_socclk_levels; i++) {
-			if (dc->clk_mgr->bw_params->clk_table.entries[i].socclk_mhz)
-				dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].socclk_mhz =
-					dc->clk_mgr->bw_params->clk_table.entries[i].socclk_mhz;
-		}
-
-		for (i = 0; i < dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels; i++) {
-			if (dc->clk_mgr->bw_params->clk_table.entries[i].dtbclk_mhz)
-				dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz =
-					dc->clk_mgr->bw_params->clk_table.entries[i].dtbclk_mhz;
-		}
-
-		for (i = 0; i < dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels; i++) {
-			if (dc->clk_mgr->bw_params->clk_table.entries[i].dispclk_mhz) {
-				dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dispclk_mhz =
-					dc->clk_mgr->bw_params->clk_table.entries[i].dispclk_mhz;
-				dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dppclk_mhz =
-					dc->clk_mgr->bw_params->clk_table.entries[i].dispclk_mhz;
-			}
-		}
-	}
-}
-
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.h
deleted file mode 100644
index 329f1788843c..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.h
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-#ifndef __DCN401_FPU_H__
-#define __DCN401_FPU_H__
-
-#include "clk_mgr.h"
-
-void dcn401_build_wm_range_table_fpu(struct clk_mgr *clk_mgr);
-
-void dcn401_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
-
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 1dce22b81c97..aff30274fa96 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -70,7 +70,6 @@
 #include "dml/dcn30/display_mode_vba_30.h"
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
-#include "dml/dcn401/dcn401_fpu.h"
 
 #include "dc_state_priv.h"
 
@@ -1622,8 +1621,6 @@ static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 
 	DC_FP_START();
 
-	dcn401_update_bw_bounding_box_fpu(dc, bw_params);
-
 	dml2_opt->use_clock_dc_limits = false;
 	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
 		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
-- 
2.43.0


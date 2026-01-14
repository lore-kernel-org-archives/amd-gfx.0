Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698B1D39011
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA4810E67E;
	Wed, 14 Jan 2026 20:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQ8+tjbi";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20F110E678
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8R9vlFWkM7pjV1YAlnbjJqZnzFJUB31DLmhLrv28bFYtfF3zRPEF2Ft63hV0fjx2XzurwKcSTGOui+NNPoXuFGcPCpqHmLqatZewbypcffowS6dNwr1PnrefA/gM7tEwH0uZSoGZAAk+2ON0wVs4p2gKZW8Qr9mlNl9flmnGxMhSUWFFFnHzj3KliAsrCojYB2TakR4jXDFwVtilptGwUhUZfT4VIM9meusoLM3XWJUXk5mEC26fm+PJ+Rdc3oloSWA8MrlEm4emmSDJvkxpXlvP374UJ8a2OTwRfX/5SHkAYnpr1gYOUa0dSJRup8XPMTsM0Vy7n5fu2If60guIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gxNW9rxVuNah5zCGuMAO6zqxCS1KLKsh1XukeS1FAc=;
 b=NSFDBXwuhkzV5eYKfuoxfqaG6hgQ9EWsvTq4VrBM/NIf0tO663b8lVfxIVwt8pRbrUnVOQdmB3uVwFdyLBTq4G7tNY+TGLkosBj/rJC5EasAs4FEY9lQSoCKv+8UHS5YQJbVFdijtJ8674hzmzkO6lTMa2H+dnfA+ip+bQnMFsoaXyfJTNfvrlXbj2HpE8g/jWKK+kViUzS74yCzsv7BMg2wE0zVE7B3xb7wrjPpCZ4StUEWmsWzB7N0tQGxJdrmJmlFHexGYDDK0U5RSQh19qdmRfIMmKWhCZ5LrQ/DXwVqnBFmKO6hcvmN14FVeflYTX59MYBUnAmNA6Fl4i+Llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gxNW9rxVuNah5zCGuMAO6zqxCS1KLKsh1XukeS1FAc=;
 b=wQ8+tjbiC7s9gNly4GdjKxsdrdUdi6akwfnwVnuy/luzGqDHucd1+PDZfse1dZGwFYB7zKqs4KiTVDwQ6KoWz1wicXljIGJZ9vKvy5KMtMm4Drax1qe8I4t1wrHDKWCfaw9r5hhDyJRxZHM1/fHWAWnu/mDqQvZMSmg/Nb8/Dag=
Received: from CH0PR03CA0247.namprd03.prod.outlook.com (2603:10b6:610:e5::12)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Wed, 14 Jan
 2026 20:24:07 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::f5) by CH0PR03CA0247.outlook.office365.com
 (2603:10b6:610:e5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 20:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:06 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 14:24:06 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:05 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Wang, Sung-huai" <Danny.Wang@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 08/14] drm/amd/display: Revert "init dispclk from bootup clock
 for DCN315"
Date: Wed, 14 Jan 2026 15:21:49 -0500
Message-ID: <20260114202421.3654137-9-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a62ab3c-9a93-49f4-5cca-08de53aade3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h3lXlLcwB3lWyNtp03I4mkAKu5RjJvrtqVL8pCEi54Nm3egK+8WN1A6KeZH8?=
 =?us-ascii?Q?3AKSM4EpgYwCLPBL+uYpDVKBYWIivmn7bOyYFfOLX+2N1KoDpOAL9geed04B?=
 =?us-ascii?Q?oCuC4xv48uFkL1nimIeQ9v1lKFxWH2o4ZF/l1aiwRNB5ok/j5ZMNyzzMN9kM?=
 =?us-ascii?Q?Y3TUt8AsP9jAk8JNRnc6LuBE0FlFJrjsCPATqaM4y6RAa1YTbX2i4vnOhnZw?=
 =?us-ascii?Q?3aZ0jgCCT4Cv6wlO3rkQG1qQoSbLFykUsuji2qeUY0FHmFWDlcU2NUH80UgB?=
 =?us-ascii?Q?jk81EhEgHFxd4LXJdYrMwq1hoS8tG0YB4a5NqKcHQWQlLDHYhWZMPDGXUQH0?=
 =?us-ascii?Q?rT1u3PP4eoieAPtOPjwEJ1ITRCMtcJcV3N9iFoewttL1Vaibms/oQPFUUU/u?=
 =?us-ascii?Q?G09p4U0fXbe3vWNCH3CT3rfV3XPyCPkMXPdB0qLzm63p5nFAWlEsIOLtDz4Y?=
 =?us-ascii?Q?QXsr6GI9/iv88KObKGQPus/qW9x5gEu1h73oyPDn0w6s2UFMFkQ7e+BBMiSH?=
 =?us-ascii?Q?c+8XoAwFksIDU2D7sIyk8Ix/qaHXdkQb0ZXda80Z5XaxGkUEoxonDDmC0Swr?=
 =?us-ascii?Q?Wbrt4B1mtiinjvVTIq+LOkbmZyNze0eoD5RcPM+pI/Fxrv3PEZWkgRWwxUne?=
 =?us-ascii?Q?nRys3Am8w6xWhYDHDoxKZ/j06xgx70SMHCU7H0Qo4n6w7gYmRI764ZOia9Sn?=
 =?us-ascii?Q?IsjDbDNnsBUoJ5Jk2sEEQA5h8BrcNNVLGVRQrkqwdWawYbOqJenq0OdW54iH?=
 =?us-ascii?Q?ImkzChc7Ot3mL/5jexCNcyrkJ3jqaPUJOvjHVZDH9R/dv/psG9KbrptTZbOB?=
 =?us-ascii?Q?MxEHV3iYMrQUKGqD9mVKzL2nr6avmc2OHaqTjXBrEmKzJkNzBJo5tnL+SW7S?=
 =?us-ascii?Q?b6fwnawBUR59oNN38tcsRS97Dlp17cuZo/CM6nEG03jTy7dJORO+aCv57HQ0?=
 =?us-ascii?Q?hX45vrLH69MLwCR1yp6WFytghQF4tbBHmGVonq80KFoEc28VISkRRIV2hzO7?=
 =?us-ascii?Q?27tWyIFmVMD9m6JP1AnK8LyEOq7pd8/k8NqJ0LigBYAlncYYRv4EXtZUGplP?=
 =?us-ascii?Q?JLqSPY1aqdRH98COR9EUdOe8j0IGkPR2+4cosnd4p6H3EPvRP88x+btq5kWx?=
 =?us-ascii?Q?zFoZGa7u8bnnWvPRAe5LCvPaujc6El/gNPPr/0Ie7xoaCf8aRKRCvp18/3Ci?=
 =?us-ascii?Q?+ircnAL6KPTv7+VMZy6ajmI4/dog2HPiKd6d/QmwuXneQcIM8gTGJdUrIj8F?=
 =?us-ascii?Q?6V9H4jEHr8mitrJVHE2vd/SNpipnMJRrSw8C7OTpI0+y9dd4C8bvFs/+6+xG?=
 =?us-ascii?Q?7SDLAb1MsdLTEMwQHSn7ZJqMJqmz7jROPYPqQWcFM1MNUdoZab4KArZzUwgx?=
 =?us-ascii?Q?XQI5dHwvbP6ULMXiSBDbru4LU1YnZeSG82xTDgkqWNvwYSr+EOqz5RSJpryl?=
 =?us-ascii?Q?sNe/pCySzxufN1npYMmsFrpRGVEUPm1dMpBxkrVts+Lng8b5pSIM2nMmpOWz?=
 =?us-ascii?Q?A7SnmT8u8F4cXXpZ8sSjYk8sfjuoEtmBWOjwC5/1zPaWIiMe8PuZgsXQyPYH?=
 =?us-ascii?Q?8FtqZCIGT7sbPRA4+3xxspMyecR/PP4Gd++HA3945BAdBzAbdJt3hezfymv0?=
 =?us-ascii?Q?Hs/PuMOzZkU+lfQrXIqPFb2SVGh/cJrFyCRwutnJs4MmpaKkvpRoDmlP5wtf?=
 =?us-ascii?Q?lJcGew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:07.0565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a62ab3c-9a93-49f4-5cca-08de53aade3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
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

From: "Wang, Sung-huai" <Danny.Wang@amd.com>

[Why&How]
This reverts commit 60a7bb0697c8.
Due to the change, the display shows garbage on startup.

We have proposed an alternative solution for the original issue. (ee13cf4d5226)

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wang, Sung-huai <Danny.Wang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 90 +------------------
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.h        |  1 -
 2 files changed, 3 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 3a881451e9da..c49268db85f6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -40,7 +40,7 @@
 #include "dm_helpers.h"
 
 #include "dc_dmub_srv.h"
-#include "reg_helper.h"
+
 #include "logger_types.h"
 #undef DC_LOGGER
 #define DC_LOGGER \
@@ -48,43 +48,9 @@
 
 #include "link_service.h"
 
-#define MAX_INSTANCE                                        7
-#define MAX_SEGMENT                                         8
-
-struct IP_BASE_INSTANCE {
-	unsigned int segment[MAX_SEGMENT];
-};
-
-struct IP_BASE {
-	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
-
-static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0, 0, 0 } },
-					{ { 0x00016E00, 0x02401C00, 0, 0, 0, 0, 0, 0 } },
-					{ { 0x00017000, 0x02402000, 0, 0, 0, 0, 0, 0 } },
-					{ { 0x00017200, 0x02402400, 0, 0, 0, 0, 0, 0 } },
-					{ { 0x0001B000, 0x0242D800, 0, 0, 0, 0, 0, 0 } },
-					{ { 0x0001B200, 0x0242DC00, 0, 0, 0, 0, 0, 0 } } } };
-
-#define regCLK1_CLK0_CURRENT_CNT			0x0314
-#define regCLK1_CLK0_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK1_CURRENT_CNT			0x0315
-#define regCLK1_CLK1_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK2_CURRENT_CNT			0x0316
-#define regCLK1_CLK2_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK3_CURRENT_CNT			0x0317
-#define regCLK1_CLK3_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK4_CURRENT_CNT			0x0318
-#define regCLK1_CLK4_CURRENT_CNT_BASE_IDX	0
-#define regCLK1_CLK5_CURRENT_CNT			0x0319
-#define regCLK1_CLK5_CURRENT_CNT_BASE_IDX	0
-
 #define TO_CLK_MGR_DCN315(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn315, base)
 
-#define REG(reg_name) \
-	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
-
 #define UNSUPPORTED_DCFCLK 10000000
 #define MIN_DPP_DISP_CLK     100000
 
@@ -172,7 +138,7 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->work_arounds.skip_clock_update)
 		return;
 
-	clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
+	display_count = dcn315_get_active_display_cnt_wa(dc, context);
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
@@ -185,7 +151,6 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
-			display_count = dcn315_get_active_display_cnt_wa(dc, context);
 			/* if we can go lower, go lower */
 			if (display_count == 0) {
 				union display_idle_optimization_u idle_info = { 0 };
@@ -279,38 +244,9 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-static void dcn315_dump_clk_registers_internal(struct dcn35_clk_internal *internal, struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-
-	// read dtbclk
-	internal->CLK1_CLK4_CURRENT_CNT = REG_READ(CLK1_CLK4_CURRENT_CNT);
-
-	// read dcfclk
-	internal->CLK1_CLK3_CURRENT_CNT = REG_READ(CLK1_CLK3_CURRENT_CNT);
-
-	// read dppclk
-	internal->CLK1_CLK1_CURRENT_CNT = REG_READ(CLK1_CLK1_CURRENT_CNT);
-
-	// read dprefclk
-	internal->CLK1_CLK2_CURRENT_CNT = REG_READ(CLK1_CLK2_CURRENT_CNT);
-
-	// read dispclk
-	internal->CLK1_CLK0_CURRENT_CNT = REG_READ(CLK1_CLK0_CURRENT_CNT);
-}
-
 static void dcn315_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
-	struct dcn35_clk_internal internal = {0};
-
-	dcn315_dump_clk_registers_internal(&internal, clk_mgr_base);
-
-	regs_and_bypass->dcfclk = internal.CLK1_CLK3_CURRENT_CNT / 10;
-	regs_and_bypass->dprefclk = internal.CLK1_CLK2_CURRENT_CNT / 10;
-	regs_and_bypass->dispclk = internal.CLK1_CLK0_CURRENT_CNT / 10;
-	regs_and_bypass->dppclk = internal.CLK1_CLK1_CURRENT_CNT / 10;
-	regs_and_bypass->dtbclk = internal.CLK1_CLK4_CURRENT_CNT / 10;
 	return;
 }
 
@@ -657,32 +593,13 @@ static struct clk_mgr_funcs dcn315_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn315_update_clocks,
-	.init_clocks = dcn315_init_clocks,
+	.init_clocks = dcn31_init_clocks,
 	.enable_pme_wa = dcn315_enable_pme_wa,
 	.are_clock_states_equal = dcn31_are_clock_states_equal,
 	.notify_wm_ranges = dcn315_notify_wm_ranges
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
-void dcn315_init_clocks(struct clk_mgr *clk_mgr)
-{
-	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
-	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
-	struct clk_mgr_dcn315 *clk_mgr_dcn315 = TO_CLK_MGR_DCN315(clk_mgr_int);
-	struct clk_log_info log_info = {0};
-
-	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
-	// Assumption is that boot state always supports pstate
-	clk_mgr->clks.ref_dtbclk_khz = ref_dtbclk;	// restore ref_dtbclk
-	clk_mgr->clks.p_state_change_support = true;
-	clk_mgr->clks.prev_p_state_change_support = true;
-	clk_mgr->clks.pwr_state = DCN_PWR_STATE_UNKNOWN;
-	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
-
-	dcn315_dump_clk_registers(&clk_mgr->boot_snapshot, &clk_mgr_dcn315->base.base, &log_info);
-	clk_mgr->clks.dispclk_khz =  clk_mgr->boot_snapshot.dispclk * 1000;
-}
-
 void dcn315_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn315 *clk_mgr,
@@ -743,7 +660,6 @@ void dcn315_clk_mgr_construct(
 	/* Saved clocks configured at boot for debug purposes */
 	dcn315_dump_clk_registers(&clk_mgr->base.base.boot_snapshot,
 				  &clk_mgr->base.base, &log_info);
-	clk_mgr->base.base.clks.dispclk_khz =  clk_mgr->base.base.boot_snapshot.dispclk * 1000;
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h
index 642ae3d4a790..ac36ddf5dd1a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.h
@@ -44,7 +44,6 @@ void dcn315_clk_mgr_construct(struct dc_context *ctx,
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg);
 
-void dcn315_init_clocks(struct clk_mgr *clk_mgr);
 void dcn315_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
 #endif //__DCN315_CLK_MGR_H__
-- 
2.52.0


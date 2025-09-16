Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA475CAC59B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D80310E3EC;
	Tue, 16 Sep 2025 19:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLRGWe0z";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E95910E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8NIK6rTxECVp5csl9iJSKK2UfOxvxRfSp90CFN0O5gFE35LQqtLycqLioyJL0HE5+ffy63kfzyDBQPCETyTGiopgqPWdctywILHC+efJG4KwioT1YX7O3ev8ZEyLhIbI7tmldFvs9jTy/ZI4igShIJPNiq8sr5zXJyclwPM5CQJ1aMAHltq+MBpGokBTpEsEZHD1ztU61ZPz1Qr8fOSVF/6ZIatsqvyyz+WoO3fwuP+4go20ZySPj0vKPYu+4o0bmMkQIPkU9FrlpaPDHiTww6pkRfEwkfFmR3ntYwNr2VDVpCNMA4eDtdDM+zeU+SHxiMUfJ90HftXe/6S6t3KVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVUTYseol6POPiwxCdpuRAOc5Bbf7ZM42JUZXufadJc=;
 b=gKqVf/h8SfEmE0oHAyaki4/rHMRYnniQJDmmdOk3GkKh4NQbStWHZoxbtmnd/XUw2FZerN5CCnCvSbNkDzWb3li0f4sdvfnPehYzFsxCQtSKFOpBZNqW0GMeEiEIjEkLTeYmDsuuttXkclcnhR4+rRu0qPx//9x3b+QE/a54US4v3RmdJivZbu4SW/ohZC6MDHxcoHD3c0seo4PV0XD9CoH6NVHJm/778cecNtzh/u2oES9BXYYpJBM6KuLL7TRJNLZ042Jx8p945UMKl1+mcylQvC8GvCzXFcwY+J6nOAijfZ5kDhwnaM5FtFtNFWpg8Vnw8ryHh4rBIhOLRSB6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVUTYseol6POPiwxCdpuRAOc5Bbf7ZM42JUZXufadJc=;
 b=RLRGWe0zfnKAsWSJekHucQPB6cMpLoH5z0vsjTJinH+D7tD86toachz+zg+Yp2K6TkqWZ1L29w5dSaL4YR+WAERscypo9Q/KcW4+j/Klvh6lCvdxC3t51njvDmEbnFZK1t5+/zdBwLLIslEJdHsPfq2aEq1Jq4KVyVA55IVlr2Q=
Received: from DS7PR03CA0357.namprd03.prod.outlook.com (2603:10b6:8:55::10) by
 MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:14 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::db) by DS7PR03CA0357.outlook.office365.com
 (2603:10b6:8:55::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 19:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:10 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:09 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Lo-an Chen <lo-an.chen@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 06/20] drm/amd/display: Init dispclk from bootup clock for
 DCN314
Date: Tue, 16 Sep 2025 15:09:26 -0400
Message-ID: <20250916191142.3504643-7-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c27da89-c70b-4b5c-c34a-08ddf554f23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8GHgoVbBqmfyBHc6W/cMypmUGlRp93ioagVRStBag8TyVuWPBBsBeNfWL8I4?=
 =?us-ascii?Q?iyIg1AzPI4XqLk41ApAII/F80x2w1R1x4rP5HFcwOxkEqm6L/qVfAn1JHnzQ?=
 =?us-ascii?Q?nIX8fAC+d83kU2KgxDG97N/2OoUkKxl69c4BVP0ZLi7qbnWp5nHmAY3ePu2j?=
 =?us-ascii?Q?VGMXOl9t2yimL2e80pKBhkni0YYIpAZ2gWsfYycyknvXDYAlkeQvCg+WzM7v?=
 =?us-ascii?Q?u1bvtymxtPmWI3Mk9e/eR4t3iFyFkZHNjU/ieSMYHmlacbvwUJ/qQ7xXWzqM?=
 =?us-ascii?Q?rybOoQTAO6ppQ/Dt6afngC7CypqVkr+zWtuI92G/64kJXqiz8IQ+YVY6IHCG?=
 =?us-ascii?Q?eAadBoPLgUydGyJ5Xw0iHxGkx0gtVyyXvAfcK+IoFJlwViPPOmPnHjoKvcLA?=
 =?us-ascii?Q?AkC78gL8ODTS1iMz3hSQ0DTzazkktOYN1TjBtKhhzuG15g8kYI6lQs2kpOQg?=
 =?us-ascii?Q?yBYURrWj0G/+6efNvgznSuP5KoVrWrEOJzDZ+yLPCW7XvM1hRqUASYNHj4AR?=
 =?us-ascii?Q?IwAMxyV0Ud6EcokvlMz7vbr7MkdQI8mHZ5SO4smPQvn4NFLrIk6BOub2ERek?=
 =?us-ascii?Q?tUJEPPPtFLXkGqjQQ+/DrMYyTYKVC23iXLrGy2hpgIevNpxNagyYyOjPDfVJ?=
 =?us-ascii?Q?5ItO8+XZAUuIFDzNZo+M7q4AUA/CceJcP0YyxQ5dm5xj84BnnVTJ5B9NEWM4?=
 =?us-ascii?Q?5GhvKaPJHjWXOcsGNkS4GkYPzU465AL3dFP1UPnvuOP8PqRkH9nOFxC//ukr?=
 =?us-ascii?Q?R4N6I3Y1pUFvmpCcCp4TofDq4nVnwWR6HkYvwtKWoO2DiQklPS87rtLw44ES?=
 =?us-ascii?Q?1YVoHr+fLjkGtO/STlQ48c3DWEI0/WafyjIMKtvend/x32aAcTU2ijlujJcB?=
 =?us-ascii?Q?xr1iVpvKwwdWG9EHipnxGtuc9wk6ylD+g5bGtDQVjHs5fnxBmAn5reyCcVU5?=
 =?us-ascii?Q?nwpdVzCbpG5aX8bRujMXLbkQNRWBHzZcXmDNueHqLD9pqyq0XP5sbznp1MUa?=
 =?us-ascii?Q?gNayojegXQvMIjdahKMIrdtaH//HMcqPFot3VMHXhpKm8AoyorwiclkKEDxl?=
 =?us-ascii?Q?RWKT8eGdksdK3xjxBDTVVvy4JFQVklCysrhTTwhb6pz4AtJ3Dfo1XhuYmyUq?=
 =?us-ascii?Q?tMPPYPyqjAHkBEBOwalF0bolxpdLX2PG0J25whypRW7VHdglLdAhuCGC87UF?=
 =?us-ascii?Q?Is/dVHk/o37+6T5b9BCQ5qIX0JLt/YQcZWW+S8WdenRGvHwTkOj3s0nEqOVk?=
 =?us-ascii?Q?8l8dyXCv2+9HWvYNMci9cBNpS7zHfJIO9gDs+sXBUZ3rPYTq4RFRCUiDmGd8?=
 =?us-ascii?Q?yxTFUARzj7K8CnkWePK5RKG98Ved3IxWSYbntpnQwlW/Ymtz9bk7oDmBYEDR?=
 =?us-ascii?Q?eoiouGMdwp9epAoKV7DH/4G4Ds9ocYkQQqLJy7vGpgkRIZgLNo4cJ5JWGj1x?=
 =?us-ascii?Q?zetRuMbFvZDE88G0xZfUEq+lvIGOcmrCBUb831LHUIpZ0MorwzGocNavdUfT?=
 =?us-ascii?Q?a4Af+pUhnk1MJ9jKHJAlIj/Fu5LXsB+eJrVk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:14.5928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c27da89-c70b-4b5c-c34a-08ddf554f23e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

From: Lo-an Chen <lo-an.chen@amd.com>

[Why]
Driver does not pick up and save vbios's clocks during init clocks,
the dispclk in clk_mgr will keep 0 until the first update clocks.
In some cases, OS changes the timing in the second set mode
(lower the pixel clock), causing the driver to lower the dispclk
in prepare bandwidth, which is illegal and causes grey screen.

[How]
1. Dump and save the vbios's clocks, and init the dispclk in
dcn314_init_clocks.
2. Fix the condition in dcn314_update_clocks, regarding a 0kHz value.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Lo-an Chen <lo-an.chen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 142 +++++++++++++++++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   5 +
 .../dc/resource/dcn314/dcn314_resource.c      |   1 +
 3 files changed, 143 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 790bbd8235b1..9e63fa72101c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -77,6 +77,7 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #undef DC_LOGGER
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
+
 #define regCLK1_CLK_PLL_REQ			0x0237
 #define regCLK1_CLK_PLL_REQ_BASE_IDX		0
 
@@ -87,8 +88,70 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
 
+#define regCLK1_CLK0_DFS_CNTL				0x0269
+#define regCLK1_CLK0_DFS_CNTL_BASE_IDX		0
+#define regCLK1_CLK1_DFS_CNTL				0x026c
+#define regCLK1_CLK1_DFS_CNTL_BASE_IDX		0
+#define regCLK1_CLK2_DFS_CNTL				0x026f
+#define regCLK1_CLK2_DFS_CNTL_BASE_IDX		0
+#define regCLK1_CLK3_DFS_CNTL				0x0272
+#define regCLK1_CLK3_DFS_CNTL_BASE_IDX		0
+#define regCLK1_CLK4_DFS_CNTL				0x0275
+#define regCLK1_CLK4_DFS_CNTL_BASE_IDX		0
+#define regCLK1_CLK5_DFS_CNTL				0x0278
+#define regCLK1_CLK5_DFS_CNTL_BASE_IDX		0
+
+#define regCLK1_CLK0_CURRENT_CNT			0x02fb
+#define regCLK1_CLK0_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK1_CURRENT_CNT			0x02fc
+#define regCLK1_CLK1_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK2_CURRENT_CNT			0x02fd
+#define regCLK1_CLK2_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK3_CURRENT_CNT			0x02fe
+#define regCLK1_CLK3_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK4_CURRENT_CNT			0x02ff
+#define regCLK1_CLK4_CURRENT_CNT_BASE_IDX	0
+#define regCLK1_CLK5_CURRENT_CNT			0x0300
+#define regCLK1_CLK5_CURRENT_CNT_BASE_IDX	0
+
+#define regCLK1_CLK0_BYPASS_CNTL			0x028a
+#define regCLK1_CLK0_BYPASS_CNTL_BASE_IDX	0
+#define regCLK1_CLK1_BYPASS_CNTL			0x0293
+#define regCLK1_CLK1_BYPASS_CNTL_BASE_IDX	0
 #define regCLK1_CLK2_BYPASS_CNTL			0x029c
 #define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
+#define regCLK1_CLK3_BYPASS_CNTL			0x02a5
+#define regCLK1_CLK3_BYPASS_CNTL_BASE_IDX	0
+#define regCLK1_CLK4_BYPASS_CNTL			0x02ae
+#define regCLK1_CLK4_BYPASS_CNTL_BASE_IDX	0
+#define regCLK1_CLK5_BYPASS_CNTL			0x02b7
+#define regCLK1_CLK5_BYPASS_CNTL_BASE_IDX	0
+
+#define regCLK1_CLK0_DS_CNTL				0x0283
+#define regCLK1_CLK0_DS_CNTL_BASE_IDX		0
+#define regCLK1_CLK1_DS_CNTL				0x028c
+#define regCLK1_CLK1_DS_CNTL_BASE_IDX		0
+#define regCLK1_CLK2_DS_CNTL				0x0295
+#define regCLK1_CLK2_DS_CNTL_BASE_IDX		0
+#define regCLK1_CLK3_DS_CNTL				0x029e
+#define regCLK1_CLK3_DS_CNTL_BASE_IDX		0
+#define regCLK1_CLK4_DS_CNTL				0x02a7
+#define regCLK1_CLK4_DS_CNTL_BASE_IDX		0
+#define regCLK1_CLK5_DS_CNTL				0x02b0
+#define regCLK1_CLK5_DS_CNTL_BASE_IDX		0
+
+#define regCLK1_CLK0_ALLOW_DS				0x0284
+#define regCLK1_CLK0_ALLOW_DS_BASE_IDX		0
+#define regCLK1_CLK1_ALLOW_DS				0x028d
+#define regCLK1_CLK1_ALLOW_DS_BASE_IDX		0
+#define regCLK1_CLK2_ALLOW_DS				0x0296
+#define regCLK1_CLK2_ALLOW_DS_BASE_IDX		0
+#define regCLK1_CLK3_ALLOW_DS				0x029f
+#define regCLK1_CLK3_ALLOW_DS_BASE_IDX		0
+#define regCLK1_CLK4_ALLOW_DS				0x02a8
+#define regCLK1_CLK4_ALLOW_DS_BASE_IDX		0
+#define regCLK1_CLK5_ALLOW_DS				0x02b1
+#define regCLK1_CLK5_ALLOW_DS_BASE_IDX		0
 
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
 #define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_DIV__SHIFT	0x10
@@ -185,6 +248,8 @@ void dcn314_init_clocks(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
 	uint32_t ref_dtbclk = clk_mgr->clks.ref_dtbclk_khz;
+	struct clk_mgr_dcn314 *clk_mgr_dcn314 = TO_CLK_MGR_DCN314(clk_mgr_int);
+	struct clk_log_info log_info = {0};
 
 	memset(&(clk_mgr->clks), 0, sizeof(struct dc_clocks));
 	// Assumption is that boot state always supports pstate
@@ -200,6 +265,9 @@ void dcn314_init_clocks(struct clk_mgr *clk_mgr)
 			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
+
+	dcn314_dump_clk_registers(&clk_mgr->boot_snapshot, &clk_mgr_dcn314->base.base, &log_info);
+	clk_mgr->clks.dispclk_khz =  clk_mgr->boot_snapshot.dispclk * 1000;
 }
 
 void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
@@ -218,6 +286,8 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->work_arounds.skip_clock_update)
 		return;
 
+	display_count = dcn314_get_active_display_cnt_wa(dc, context);
+
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
@@ -236,7 +306,6 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
-			display_count = dcn314_get_active_display_cnt_wa(dc, context);
 			/* if we can go lower, go lower */
 			if (display_count == 0) {
 				union display_idle_optimization_u idle_info = { 0 };
@@ -293,11 +362,19 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
+
 		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+
+		dcn314_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn314_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
+
 		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
@@ -385,10 +462,65 @@ bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 	return true;
 }
 
-static void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+
+static void dcn314_dump_clk_registers_internal(struct dcn35_clk_internal *internal, struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	// read dtbclk
+	internal->CLK1_CLK4_CURRENT_CNT = REG_READ(CLK1_CLK4_CURRENT_CNT);
+	internal->CLK1_CLK4_BYPASS_CNTL = REG_READ(CLK1_CLK4_BYPASS_CNTL);
+
+	// read dcfclk
+	internal->CLK1_CLK3_CURRENT_CNT = REG_READ(CLK1_CLK3_CURRENT_CNT);
+	internal->CLK1_CLK3_BYPASS_CNTL = REG_READ(CLK1_CLK3_BYPASS_CNTL);
+
+	// read dcf deep sleep divider
+	internal->CLK1_CLK3_DS_CNTL = REG_READ(CLK1_CLK3_DS_CNTL);
+	internal->CLK1_CLK3_ALLOW_DS = REG_READ(CLK1_CLK3_ALLOW_DS);
+
+	// read dppclk
+	internal->CLK1_CLK1_CURRENT_CNT = REG_READ(CLK1_CLK1_CURRENT_CNT);
+	internal->CLK1_CLK1_BYPASS_CNTL = REG_READ(CLK1_CLK1_BYPASS_CNTL);
+
+	// read dprefclk
+	internal->CLK1_CLK2_CURRENT_CNT = REG_READ(CLK1_CLK2_CURRENT_CNT);
+	internal->CLK1_CLK2_BYPASS_CNTL = REG_READ(CLK1_CLK2_BYPASS_CNTL);
+
+	// read dispclk
+	internal->CLK1_CLK0_CURRENT_CNT = REG_READ(CLK1_CLK0_CURRENT_CNT);
+	internal->CLK1_CLK0_BYPASS_CNTL = REG_READ(CLK1_CLK0_BYPASS_CNTL);
+}
+
+void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
-	return;
+
+	struct dcn35_clk_internal internal = {0};
+
+	dcn314_dump_clk_registers_internal(&internal, clk_mgr_base);
+
+	regs_and_bypass->dcfclk = internal.CLK1_CLK3_CURRENT_CNT / 10;
+	regs_and_bypass->dcf_deep_sleep_divider = internal.CLK1_CLK3_DS_CNTL / 10;
+	regs_and_bypass->dcf_deep_sleep_allow = internal.CLK1_CLK3_ALLOW_DS;
+	regs_and_bypass->dprefclk = internal.CLK1_CLK2_CURRENT_CNT / 10;
+	regs_and_bypass->dispclk = internal.CLK1_CLK0_CURRENT_CNT / 10;
+	regs_and_bypass->dppclk = internal.CLK1_CLK1_CURRENT_CNT / 10;
+	regs_and_bypass->dtbclk = internal.CLK1_CLK4_CURRENT_CNT / 10;
+
+	regs_and_bypass->dppclk_bypass = internal.CLK1_CLK1_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dppclk_bypass < 0 || regs_and_bypass->dppclk_bypass > 4)
+		regs_and_bypass->dppclk_bypass = 0;
+	regs_and_bypass->dcfclk_bypass = internal.CLK1_CLK3_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dcfclk_bypass < 0 || regs_and_bypass->dcfclk_bypass > 4)
+		regs_and_bypass->dcfclk_bypass = 0;
+	regs_and_bypass->dispclk_bypass = internal.CLK1_CLK0_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dispclk_bypass < 0 || regs_and_bypass->dispclk_bypass > 4)
+		regs_and_bypass->dispclk_bypass = 0;
+	regs_and_bypass->dprefclk_bypass = internal.CLK1_CLK2_BYPASS_CNTL & 0x0007;
+	if (regs_and_bypass->dprefclk_bypass < 0 || regs_and_bypass->dprefclk_bypass > 4)
+		regs_and_bypass->dprefclk_bypass = 0;
+
 }
 
 static struct clk_bw_params dcn314_bw_params = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index 002c28e80720..0577eb527bc3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -65,4 +65,9 @@ void dcn314_clk_mgr_construct(struct dc_context *ctx,
 
 void dcn314_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
+
+void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info);
+
+
 #endif //__DCN314_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 663c49cce4aa..d4917a35b991 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -927,6 +927,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_legacy_fast_update = true,
 	.using_dml2 = false,
 	.disable_dsc_power_gate = true,
+	.min_disp_clk_khz = 100000,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.43.0


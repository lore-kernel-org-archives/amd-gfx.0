Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D8CAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FB910E3DE;
	Tue, 16 Sep 2025 19:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQ01+Awj";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3F610E7AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qh5gGxCXMP/3+roiQ/ofgBp+63iLU6yqNQGiia/pUvvFIdfAIbFVcbVGq+YrEHHt8wW1qLvgTU/oaXN6uBnhXkRBMkVDe4rsTL3iFLX1XIwNthwevpM0ihs0+llOblubyNJd3Rmf8oe196+50t6cp1/gv+cYxqVmTcPLYoQ2WzKNO4mREI6wc5+/oA16Qlor6WSTY8UFF5Y44UFBOkq1nKBQ+5yTn05T+IdXpIpBIWsrrR1BlAMAXtQgXoJl3xIVGnk0PxltdjD32l+zRmAcoOk7HX+hMpQ39ORoT0M7akI85jfVI1h0fpIVpK2FAgPX8O4rhZaoIy/2SP/d+Y25UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT/8AXKk52fCWa1Gd5HVpMn/kfqsSU1W9MIDxP6AS1I=;
 b=OM2mJEj4w1XlO9NGgfYG2+Kl1lM5Z/s5Dv4n1k5WFjCuDBIUguOhi8C1oS3dJyHU47l4r7OyiPAbfPxyk2U4PmCaBSjJ+FdRry7zPqfC3WWD2zemnbDjYUqUi8U7FN34L6FjYQJB1hAZYYjJjBWhSNT2qiFEimetEZS7GQwZRDXRTCtNVf9SybYVg7bBsw/ufukgK2KYuwh9tStptUqumpsR/xQaM7vS7lGaG8sFbbwhJ7SHw5XbffDVjsP2gxOAKl1iZWoHVBMlc9QPyu4RxfhXMoXV6iOF4ZAnoI87bIzf1MCksgoIwgeTRWXi9rykHnVcWhpsOEqXN/9rGeGEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT/8AXKk52fCWa1Gd5HVpMn/kfqsSU1W9MIDxP6AS1I=;
 b=BQ01+AwjedYf7ijvLlotGS5LPRgsOOiiyI9t73HnIV/icZX9JI+OSVURbokvrVLsggCdIex6aePQEOR925Z1yn0sGBSFeyWo6u9O3/UTv+9VyzlwEncwMKrl4puZ+43G/AtW5GO/kYH6Zvde3s4tVO5rZvXZgfnxMXvbNcl7D4Y=
Received: from DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::12) by
 SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Tue, 16 Sep 2025 19:12:29 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::d8) by DSZP220CA0005.outlook.office365.com
 (2603:10b6:5:280::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:23 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 14:12:23 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:17 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 18/20] drm/amd/display: Init DCN35 clocks from pre-os HW values
Date: Tue, 16 Sep 2025 15:09:38 -0400
Message-ID: <20250916191142.3504643-19-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b0fe43-4ffe-403e-dc78-08ddf554fb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dKLSyir1SyC02fBNDkOpW0I5WA0OAWESNAsmJFvAFcJN3OGNkKuqlGVQ3+ZB?=
 =?us-ascii?Q?V2U3RFyh2nUB+Ny4XsEEupKaNNlDaR0BOFIvGffj2e4PVXfG0KVswTNa/QMC?=
 =?us-ascii?Q?FMrOks3EiTHH0oCwwYIVuxBi6aAMRB5nkE7Zv5ZoEAi4hXbk5PHpL1dvKlrI?=
 =?us-ascii?Q?jo/8et36bzSwTj4IMsDJBCNWFWZDic8F3hji6sJtEVr/MZiNe+LstEyefuWR?=
 =?us-ascii?Q?Cuf20vxqFZf9HPzKpilvrOBqwa4li4bXunKKOqTKA/3GsuCGqNqxYpx9l49P?=
 =?us-ascii?Q?ewl9KtVyd3tqO00AoMDNeHX/Tj/fN7tUmGgOIqL6+0pOrCd4xPSkHHu/1edt?=
 =?us-ascii?Q?3DC4u5hVQ1PDuM1FDtHDWPH11vD7fjMorai2hAG7w1+OtxkCa1rVrGn1IJZs?=
 =?us-ascii?Q?WN3rTzUYIceNp+tSNWkVnE24hoFJsctYXGoFMawgl74+pzfZd5uRb4vkdnNy?=
 =?us-ascii?Q?t85DRwHB274H4bXQRm/x9egc70NHnD5vmBCY6OHRSg9R4KNtp+7UoOQXmNzh?=
 =?us-ascii?Q?PzgJ0Ba9H9AIebkOzEbXpAxzEwzTC/hioqeBBt+4vs+5AP/UvGS7dGJjtf8J?=
 =?us-ascii?Q?iwskQPkFJGU8FKWXscNs/Oth25dZ/4/Rlk/WBrYi5FVuj/fUZ+kYIUFopcms?=
 =?us-ascii?Q?mM/ZhhHUO7GGEsOv60Tsvlaik4VtpREmrcJlEm769arsRNB1Ul7kgpwBNNc9?=
 =?us-ascii?Q?VZkyJv/7jANgdjyOs0dAUbHMtR4EQxLCPiETP7Wi32GI1dTambM2IY9sFQ/2?=
 =?us-ascii?Q?Cne7HuxAaR7MxHdPCfHlId/0t7adqjq7A9sRh2EQUF374XrJk92wU3borq4C?=
 =?us-ascii?Q?9gKxIlttriWn2atBZSVwwhgxxR7b7WHa4zBB/Gtcsg6si4iPJKXBaJZ1HXqJ?=
 =?us-ascii?Q?+/t7A1bqB3j7uYuurt4JeVdfUm5D6BxJ+8N+KNILqxdJRn/c+n7a4VB30s3g?=
 =?us-ascii?Q?nqS9MbB/LidAbrbGu/2eD4+1vJgj8zZUixyeW8Zos5aAq9xYcpQrmjzA947G?=
 =?us-ascii?Q?GdYShzI6vhVklHv6a828vHKGRGH9qEjOclAnkYfBh+DZ1JJs2QgWuW8Fp+O2?=
 =?us-ascii?Q?kx5e17+/wWXpnzKfXTquTTO89O1q3vDZQbKxI0n7XGIcbTuvLLf0hWb5juMi?=
 =?us-ascii?Q?XePc9wdKKXtORbnNv65q61f0ZTqpViMXKY+unrLNjTnPLh67ZwJEfNtU2mcv?=
 =?us-ascii?Q?T7w2rnyriEom5G6c/DFNMG+a6wASnmR3i5HEq5X0+fp6xeNY/w0mL0s+tA3l?=
 =?us-ascii?Q?e33mf7j+pjn5gvRhfWu5uChXkWkcn9rl93IbCs9QsCfeuNKeCaM0mlJgyXDa?=
 =?us-ascii?Q?maIb8l295Xj1zN8dNCLPjve8muCSmCzeVf5atYj094u8GaUskIwVuzMPghje?=
 =?us-ascii?Q?zMOrJGqIKnnRd0wltbCPpFE4hBd87uFtSANOLjvP8gqBZV3J6DdBpHabYwM4?=
 =?us-ascii?Q?/+OKHs7kadKa9r+gKRUePqLJXT3mQd2t/fmBzNhAEfnhdQ5MydNjmVnyI+dW?=
 =?us-ascii?Q?h58V5VT9Rc1bjnshH1GiB1/8fWOARKQ+Zgvl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:29.7503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b0fe43-4ffe-403e-dc78-08ddf554fb47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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

From: Leo Li <sunpeng.li@amd.com>

[Why]
We did not initialize dc clocks with boot-time hw values during init.
This lead to incorrect clock values in dc, causing `dcn35_update_clocks`
to make incorrect updates.

[How]
Correctly initialize DC with pre-os clk values from HW.
s/dump/save/ as that accurately reflects the purpose of the functions.

Fixes: 8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 121 +++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 86edf11b8c5a..b11383fba35f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -587,9 +587,118 @@ bool dcn35_are_clock_states_equal(struct dc_clocks *a,
 	return true;
 }
 
-static void dcn35_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
+static void dcn35_save_clk_registers_internal(struct dcn35_clk_internal *internal, struct clk_mgr *clk_mgr_base)
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
+static void dcn35_save_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr_dcn35 *clk_mgr)
 {
+	struct dcn35_clk_internal internal = {0};
+	char *bypass_clks[5] = {"0x0 DFS", "0x1 REFCLK", "0x2 ERROR", "0x3 400 FCH", "0x4 600 FCH"};
+
+	dcn35_save_clk_registers_internal(&internal, &clk_mgr->base.base);
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
+		// REGISTER VALUES
+		DC_LOG_SMU("reg_name,value,clk_type");
+
+		DC_LOG_SMU("CLK1_CLK3_CURRENT_CNT,%d,dcfclk",
+				internal.CLK1_CLK3_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK4_CURRENT_CNT,%d,dtbclk",
+					internal.CLK1_CLK4_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK3_DS_CNTL,%d,dcf_deep_sleep_divider",
+					internal.CLK1_CLK3_DS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK3_ALLOW_DS,%d,dcf_deep_sleep_allow",
+					internal.CLK1_CLK3_ALLOW_DS);
+
+		DC_LOG_SMU("CLK1_CLK2_CURRENT_CNT,%d,dprefclk",
+					internal.CLK1_CLK2_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK0_CURRENT_CNT,%d,dispclk",
+					internal.CLK1_CLK0_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK1_CURRENT_CNT,%d,dppclk",
+					internal.CLK1_CLK1_CURRENT_CNT);
+
+		DC_LOG_SMU("CLK1_CLK3_BYPASS_CNTL,%d,dcfclk_bypass",
+					internal.CLK1_CLK3_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK2_BYPASS_CNTL,%d,dprefclk_bypass",
+					internal.CLK1_CLK2_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK0_BYPASS_CNTL,%d,dispclk_bypass",
+					internal.CLK1_CLK0_BYPASS_CNTL);
+
+		DC_LOG_SMU("CLK1_CLK1_BYPASS_CNTL,%d,dppclk_bypass",
+					internal.CLK1_CLK1_BYPASS_CNTL);
+
+	}
 }
 
 static bool dcn35_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base)
@@ -623,6 +732,7 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr);
+	struct clk_mgr_dcn35 *clk_mgr_dcn35 = TO_CLK_MGR_DCN35(clk_mgr_int);
 
 	init_clk_states(clk_mgr);
 
@@ -633,6 +743,13 @@ void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
 
+	dcn35_save_clk_registers(&clk_mgr->boot_snapshot, clk_mgr_dcn35);
+
+	clk_mgr->clks.ref_dtbclk_khz =  clk_mgr->boot_snapshot.dtbclk * 10;
+	if (clk_mgr->boot_snapshot.dtbclk > 59000) {
+		/*dtbclk enabled based on */
+		clk_mgr->clks.dtbclk_en = true;
+	}
 }
 static struct clk_bw_params dcn35_bw_params = {
 	.vram_type = Ddr4MemType,
@@ -1323,7 +1440,7 @@ void dcn35_clk_mgr_construct(
 		dcn35_bw_params.wm_table = ddr5_wm_table;
 	}
 	/* Saved clocks configured at boot for debug purposes */
-	dcn35_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
+	dcn35_save_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-- 
2.43.0


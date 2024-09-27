Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F5CDD1BD
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 15:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F0010ECE1;
	Fri, 27 Sep 2024 15:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fGmd6jV0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3B510ECE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 15:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcSkWWELt1Au1xSyFPpm+ni7OeBdpHz+90oJq/fp7zlWTEDXQFZD7X5t0Lnz/fs5kUctGLFSg2WHtCSBL3smcdhEgz7cNxX3gcAYXX8tj1LMWrc4FaWPlsu+dwSkhvGZOq/WUiT2NQxYtQKphcrX/hTuQot2U1NWguDkqqBJyedhP9JGWsvUdmxK06pBIA3hgdr7lD1KMbS70M2KqMM9BMhoJ+ELWs9tZHi36iTjXxh/InDk/a22Zd2bAG3ZuglFpaw7bdDpBL6yHLueGVzvv6+aofQiOl5uJDrdTAxAJnA+jX+bBa0UAzdbNYic5xyy49cobeq9fwdRPC7Rn9JJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC3kUEtLkmGJXJzDiPi9rOOd9IJb77c4rWCyHaiKpQM=;
 b=eIpE0wVtb9LW6Q+bgpr/pLFmHroSO/NEq+KUyC7uN4LTilirItfXT9PNvkqJuE1qWysW71uDxigsW+KEwfyyqIIhQ1QcLzUChKaRp8QEnneVceK/nSFT2jLjHHIIJBql6lPnXRBhSJaWaq+SpemUzgRZbnh04nHdq1WkOPqXwo6v6M6phZb3fY3nd+LZlqk2sxrOkqWOMiOLGcRvSxiMH7IVKM0YwYgc7cnCt78OLJBireA4JwtklXPR4JgrfKYIYNTgwAxRqBhpoH+qYd0F7VxwWQwOcBrFf3LscG4N8FKO74Cr4f/vADAU46quZQU2dlr/lBPb1p0TZrmsTq4Ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC3kUEtLkmGJXJzDiPi9rOOd9IJb77c4rWCyHaiKpQM=;
 b=fGmd6jV02oZUox1ef4kzBKgKnCUV29Tu/3ZL3WMpyylQsN2bUmgckdFd3NB67toR6sMzR3nOsZ3vljCHMF67be4oJSa411zZfrMa1gWNkSmFBpDbM7rW91W9K5LZnllNQl2h5cneoK+4Ii6sR8Mvh49MI78cvunwbtIr136z6Yg=
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Fri, 27 Sep 2024 15:38:03 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::42) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Fri, 27 Sep 2024 15:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 15:38:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 10:38:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 10:38:02 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 10:38:01 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ryan Seto <ryanseto@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 01/13] drm/amd/display: Adjust PHY FSM transition to
 TX_EN-to-PLL_ON for TMDS
Date: Fri, 27 Sep 2024 11:37:08 -0400
Message-ID: <20240927153720.99916-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927153720.99916-1-Jerry.Zuo@amd.com>
References: <20240927153720.99916-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fb14be-d647-4ec0-9aa6-08dcdf0a6028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?od+VLfyGOMwHLKOayZZ+BoI4gn3wYeIcBHTGcrXkDDNVLVeDAVGeKZRaoog/?=
 =?us-ascii?Q?dl/FvbpWrxaAnNraka4TmUMS5x1s0ECSGsRZUG1QpaM+4SVDiipekoINp3+P?=
 =?us-ascii?Q?lXWVIIFvEx6jLZ3QtUJBtPCxfmmRgF5w4NGKlQ5B51YlD6r8UF22fMMi8zmB?=
 =?us-ascii?Q?qLqzOw5uocMa5v0SRx9MaZOBuFjTDBAQk/mN+9LWb4aClULcsmYzKTCvB2uX?=
 =?us-ascii?Q?6hQYFImwbwp9ReHUrk0GRu3FiisvH9lgPwWb33lmjcZy/uNCBijsvpB1Gqb9?=
 =?us-ascii?Q?OEjZFLn280Z5HwVkkETJGEfgiYWbEdTl0ags8aADSc22KDsJL0C6w2l7pVWB?=
 =?us-ascii?Q?gpHcc2NwB5RTlZIo071+FAcGv0g4K5HBhBLzb7f4UeaV9WRqa7CUklI5Htkw?=
 =?us-ascii?Q?bIJSxwMESWApbr9w8/ci9wzHzQf1GZkDj+4h42AgYocyfxCTgJfS04vlVJ1g?=
 =?us-ascii?Q?/nPJRrvoCz30JJFvtjJCFJOO2ssQpgNn+dmA3DTjVSiBuGaaK9/eWCRUwOyJ?=
 =?us-ascii?Q?S/L/iIwpKCDRcuoMTyhqgblwf3mAxRpub/uMBQ6nnvwZLUjbSo39lrYxf73P?=
 =?us-ascii?Q?1k7eqdLauxxLrle50MKc0t66Ex5DU7CJ2ryBN42wGKu/VsqNmXhSt8qb3KDp?=
 =?us-ascii?Q?v0ab6v87y2B24BauKaOW0EYTSYA96IoQNpKxanhfkzBrr6j/7Jh48Xqqeme1?=
 =?us-ascii?Q?aB8enl2thSw3vlwAhe04iQbKH8caBpNnxf4MB9U5B6nEg1jHwsSziXvYRQPn?=
 =?us-ascii?Q?Fkid5lKGNTzrtY5a1DY0Rdf+viqDm8bf03bB0+jOXGgU1evhhgkmnrcpOBwA?=
 =?us-ascii?Q?kr9Yteo8ivnJ7k4SsnCYYaP2VTQkkFerF/xGLEOWnbRmq4qDoSox2blyWjUD?=
 =?us-ascii?Q?HDx4xPDaWgLlz4MUajzIW6Z4qlLU/vbLEXqqUMYuRJMCaf0znA/+kalDI5T6?=
 =?us-ascii?Q?r9vp8XJ3XglVhCJAM60IPDE9dPl6oPjGs49aWWeBO2mfOq1C7r1T+VlxdJ1m?=
 =?us-ascii?Q?jDcawqg7lNsXIP2FZsMzvu++aRBObJ9toUfsxVbUIsP1rBH5Xbk8mKlxU5Bi?=
 =?us-ascii?Q?hRAZmDLpDgIIJOSuAyCk/HqXhNr+E8IuZcxTebBtkl+v2fed084KnVXYcMIw?=
 =?us-ascii?Q?h9xgUeeqMF3AlMe5Mfi4Dxx41xOBNcrrPY5uHGk+C9FTgi+Md9fKspbVgpGg?=
 =?us-ascii?Q?fvgABMi6Zqw6Xe73/xAHbAbMW5cPcq01s0dz0EagtCrDmW1uijNPilIERuHX?=
 =?us-ascii?Q?X0WTFGLOb4OH3C+iZDe4g7pwpl5r17x0cKZ1HhKJek48ysABFC1A+BOAFawK?=
 =?us-ascii?Q?zlLf2x1iyzEcA8X16PV1Jh6KljdEmLC2QSPZ7dJST+bJdSJskNNr9ystR/LQ?=
 =?us-ascii?Q?6EfQmrA73+fKWIvHvpW+sZsB1Mxh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:38:03.4927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fb14be-d647-4ec0-9aa6-08dcdf0a6028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
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

From: Ryan Seto <ryanseto@amd.com>

[Why]
If two monitors with TMDS signals were timing synced and one was
disconnected, the stream would go out of sync too early due to
the PLL turning off and the system could hang

[How]
On link disable output, change PHY FSM transition from TX_EN-to-PHY_OFF
to TX_EN-to-PLL_ON for TMDS

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 81 -------------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 52 ++++++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  4 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 4 files changed, 57 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 0b889004509a..5babd53025ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -805,33 +805,6 @@ static void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	switch (link_enc_inst) {
-	case 0:
-		REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
-				SYMCLKA_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKA_ROOT_GATE_DISABLE, 1);
-		break;
-	case 1:
-		REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
-				SYMCLKB_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKB_ROOT_GATE_DISABLE, 1);
-		break;
-	case 2:
-		REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
-				SYMCLKC_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKC_ROOT_GATE_DISABLE, 1);
-		break;
-	case 3:
-		REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
-				SYMCLKD_CLOCK_ENABLE, 1);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_ROOT_GATE_DISABLE, 1);
-		break;
-	}
-
 	switch (stream_enc_inst) {
 	case 0:
 		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
@@ -864,37 +837,8 @@ static void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 	}
 }
 
-/*get other front end connected to this backend*/
-static uint8_t dccg401_get_number_enabled_symclk_fe_connected_to_be(struct dccg *dccg, uint32_t link_enc_inst)
-{
-	uint8_t num_enabled_symclk_fe = 0;
-	uint32_t fe_clk_en[4] = {0}, be_clk_sel[4] = {0};
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	uint8_t i;
-
-	REG_GET_2(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_EN, &fe_clk_en[0],
-			SYMCLKA_FE_SRC_SEL, &be_clk_sel[0]);
-
-	REG_GET_2(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_EN, &fe_clk_en[1],
-			SYMCLKB_FE_SRC_SEL, &be_clk_sel[1]);
-
-	REG_GET_2(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_EN, &fe_clk_en[2],
-			SYMCLKC_FE_SRC_SEL, &be_clk_sel[2]);
-
-	REG_GET_2(SYMCLKD_CLOCK_ENABLE,	SYMCLKD_FE_EN, &fe_clk_en[3],
-			SYMCLKD_FE_SRC_SEL, &be_clk_sel[3]);
-
-	for (i = 0; i < ARRAY_SIZE(fe_clk_en); i++) {
-		if (fe_clk_en[i] && be_clk_sel[i] == link_enc_inst)
-			num_enabled_symclk_fe++;
-	}
-
-	return num_enabled_symclk_fe;
-}
-
 static void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
 {
-	uint8_t num_enabled_symclk_fe = 0;
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	switch (stream_enc_inst) {
@@ -919,31 +863,6 @@ static void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_ins
 				SYMCLKD_FE_SRC_SEL, 0);
 		break;
 	}
-
-	/*check other enabled symclk fe connected to this be */
-	num_enabled_symclk_fe = dccg401_get_number_enabled_symclk_fe_connected_to_be(dccg, link_enc_inst);
-	/*only turn off backend clk if other front ends attached to this backend are all off,
-	 for mst, only turn off the backend if this is the last front end*/
-	if (num_enabled_symclk_fe == 0) {
-		switch (link_enc_inst) {
-		case 0:
-			REG_UPDATE(SYMCLKA_CLOCK_ENABLE,
-					SYMCLKA_CLOCK_ENABLE, 0);
-			break;
-		case 1:
-			REG_UPDATE(SYMCLKB_CLOCK_ENABLE,
-					SYMCLKB_CLOCK_ENABLE, 0);
-			break;
-		case 2:
-			REG_UPDATE(SYMCLKC_CLOCK_ENABLE,
-					SYMCLKC_CLOCK_ENABLE, 0);
-			break;
-		case 3:
-			REG_UPDATE(SYMCLKD_CLOCK_ENABLE,
-					SYMCLKD_CLOCK_ENABLE, 0);
-			break;
-		}
-	}
 }
 
 static const struct dccg_funcs dccg401_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 805e7b52df29..b690f0565d28 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1097,6 +1097,58 @@ void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct
 	}
 }
 
+static void disable_link_output_symclk_on_tx_off(struct dc_link *link, enum dp_link_encoding link_encoding)
+{
+	struct dc *dc = link->ctx->dc;
+	struct pipe_ctx *pipe_ctx = NULL;
+	uint8_t i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx->stream && pipe_ctx->stream->link == link && pipe_ctx->top_pipe == NULL) {
+			pipe_ctx->clock_source->funcs->program_pix_clk(
+					pipe_ctx->clock_source,
+					&pipe_ctx->stream_res.pix_clk_params,
+					link_encoding,
+					&pipe_ctx->pll_settings);
+			break;
+		}
+	}
+}
+
+void dcn401_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc *dc = link->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
+		link->dc->hwss.edp_backlight_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->lock_phy(dmcu);
+
+	if (dc_is_tmds_signal(signal) && link->phy_state.symclk_ref_cnts.otg > 0) {
+		disable_link_output_symclk_on_tx_off(link, DP_UNKNOWN_ENCODING);
+		link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
+	} else {
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	}
+
+	if (signal == SIGNAL_TYPE_EDP &&
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
+		link->dc->hwss.edp_power_control(link, false);
+	else if (dmcu != NULL && dmcu->funcs->lock_phy)
+		dmcu->funcs->unlock_phy(dmcu);
+
+	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+}
+
 void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 1e8189bb447e..e6692cd905d6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -55,6 +55,10 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		bool lut_bank_a);
 void dcn401_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable);
 
+void dcn401_disable_link_output(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
+
 void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx);
 
 bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 73a632b5ff89..d1128a8082a5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -84,7 +84,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.disable_link_output = dcn32_disable_link_output,
+	.disable_link_output = dcn401_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.enable_phantom_streams = dcn32_enable_phantom_streams,
-- 
2.34.1


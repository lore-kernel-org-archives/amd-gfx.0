Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DBBCDD1CF
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D0210ECF0;
	Fri, 27 Sep 2024 17:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0EeIGIHY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804E310ECEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mkm5DTasmZz6cuWb1qo1Me4H5yTIjdiVgBNbEST6z4PKFeQqWJM78r430+PrHLYDphNC4UXzhQQ76Qzka9JhK09fZwtmO0DD+tHCpj9sfMl7P132hl3GgrPAtam3WzRBbOR/mbrUJA8mApjdlVOpuzF5bNLYJy7As3jewajuJ0ARiMmDJrow2lTsWi9ngWISXxkoN8FkARPsZRZ1Za8Ig0akEzSgBRTXszS6JaACk48AyS7j6KTkvGSpoFm613asEjqPoRst/VPpqSxP/iPcvX+FBeSamYklYCq0QHQ4lq9QGnrT1XQ1FrzLq63fjIKP3+R9j71XipFK5KzZ+0eixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC3kUEtLkmGJXJzDiPi9rOOd9IJb77c4rWCyHaiKpQM=;
 b=OhQT6uCGUEOzggQ4mufK/dSX8lfeNJfvmDogSeV21wcYAphQWSlYk7KcPKwOokW6n4+yKUlujhe4GfmmyvBjpqW2vr+5zn0kpp3VQ4mY3ZTVnpwFygtAa2tqlKB8DaiDceTxAtASPw3HSIKo1KUsiAzvbybSPfL/A17wb0KEAuSQd6Usz0gKKK/24WIJgtsILrDQ4GwChNk9KRNpp1NAMONEtPkBv9GVYbowe3VmLr8Ud2pqEeWcMWi3M/bpmTHzI9DfhiajgRtQKkCMkNWYB7zlKegKkJDUFQaeATQ+6lSSzTCT0nDDUWiYBTXZPhYNhN5L6PEnDAt+yGMzyIBaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC3kUEtLkmGJXJzDiPi9rOOd9IJb77c4rWCyHaiKpQM=;
 b=0EeIGIHY/iDBoShnbX9Wmv1gLaftZi/EyaubRWaqYpeXEgE6C5SNZZtnQYzfXR4HSf2TODzcDQM7XI27YvOTnZmC5UX+63XKYkleYyrGPRmmwnOtEDiOCcfIjzaLyIP0CUnMcBNk+lHgFWW2KxSCwgr2kEf/94BkSmn5cUsLH7o=
Received: from PH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::25)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 17:01:43 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::4d) by PH0P220CA0005.outlook.office365.com
 (2603:10b6:510:d3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:39 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:39 -0500
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
Date: Fri, 27 Sep 2024 13:00:51 -0400
Message-ID: <20240927170103.102180-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6556a4f9-12b7-487e-e172-08dcdf160ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g9PlQt850j1gwxF+rDmm8VTFx5LYByFMNbetr/7qchmFDRUsTDYKHCDeB/hu?=
 =?us-ascii?Q?jFWFqXaXBE6s98JEPrfXTZX4F3MsBhbpx/Ry32xyKt0N8HRh4mqhn75AjBXx?=
 =?us-ascii?Q?GmY6RjJYPbGGzF79sMlfFWOrjkMh7WAK/YLMgpRrwLqaFicTr2QasmuSMS2r?=
 =?us-ascii?Q?F4IZJRN6khdisyuRxOx/HG7eCXOTSQVWS4iNKOBGC1uCAoGj91MqSja6Yikg?=
 =?us-ascii?Q?ccQbQBNyghIn4S2sZTkma5UwD/q91s1uNSVjNi39s9zWzPBe4JqENOmkmSI0?=
 =?us-ascii?Q?r1Ua+ny9KzyndJZAxgprGTdEk4/fwWomtlUtsRjeGlb+3CL0+Z64jrDFdQUb?=
 =?us-ascii?Q?fzj/k+/uWZUfCTC5c6xM5Fv/b11d/Xiv8voQ+870Zc9kFm7MqMDG5dFkMP2W?=
 =?us-ascii?Q?bT5uaKb4eN3pItjOVxrYiouvDS0QqzqeZF9HlZDCbM6D6+f3gk0IFx0x/njq?=
 =?us-ascii?Q?qZv5hIOTA5bb12JmD1+SUdybafLWcNH+jDqx6inVBAp6e63/kcNuJT49As3i?=
 =?us-ascii?Q?qfevZcqxNTqglTjv7yw/ldTzTilGorxkY+ywNIslp67jMUWoMvnBQCQvHwxm?=
 =?us-ascii?Q?tir71IUGuPmS3QFx344fkPEBYbQytj6V4eyQ1w5W641i2+64U5ffynC/Gfjs?=
 =?us-ascii?Q?vkUUNtB61XVjOSFdCsk1p4f+QRWGAUpXsCbJjzY3NU0B5GGChFecLXn0FxuM?=
 =?us-ascii?Q?PecejIiC9aiJlybDcPPrn2eb68WjnKOFjdD/50PEn6qvTSTZ6C6kpFMWjCX8?=
 =?us-ascii?Q?+4LUueqBUfvxsD4AH0ElCHv15C3HNMm97S4JPX6KLWW38O/oPNbbF0w+MfjX?=
 =?us-ascii?Q?WXi1qEVlsP5+ncQjmNxmceomsNXnTtXwU2f9ollK2EoSVVhBeoB32z6ccU1d?=
 =?us-ascii?Q?4KLTHScYaDvEF8i2C2qyNW1n+6TadjZ2DwXblAkA3As2UuVvAk/DVOsfALiK?=
 =?us-ascii?Q?mXeI/pB2QaN+v/DWbsFJo7cJeCo0oq3aa9YewXIeqNqrL9Iwy/WV+IvIsadK?=
 =?us-ascii?Q?meTwsRPPLN9hZ5f8AYjjLqwgxMcAeM54r1rz1HjGIBjteyl98pm6JOPPJLsM?=
 =?us-ascii?Q?UYqvtfsOXoQASc1PmbnV2bI32pLMTrCpMuOcNZmESuTYnRCOVyxOhExABKmr?=
 =?us-ascii?Q?d8M7xlyMdzN5fR1rwvL0LP05KjFX91GSgoluYSffoPAbIe2kVFDS//c+1aKj?=
 =?us-ascii?Q?TEoC3JG5NMD6PjU++6T6zQoT5qdLIxrTChl3MYu16DsjEfaXzCgy5SdjC8+3?=
 =?us-ascii?Q?RQed9iZDYrifjA7EletZ2G0OATrm7gS4iwyZSMm5EIrALhnKE8f4mXIYkCiS?=
 =?us-ascii?Q?zL0EFNnYX1toSpKTn7B2BPNbBeLSU7u/dOVpywKdQw3UQjoqaHCsW8YXlPYV?=
 =?us-ascii?Q?gIBeZKGHilRQQ/zpJkz1FNpwR10zn98dKgCYZa5dA+K1CDvb00Q45cYTlZdM?=
 =?us-ascii?Q?dpGdCxZv8EcBMCbOQ/n9b+ivUVOsR3Cb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:42.7743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6556a4f9-12b7-487e-e172-08dcdf160ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2A1D6AAF9
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942FA10F28A;
	Thu,  2 Apr 2026 18:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MYDiNhdu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D420F10F28A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtXyCsw3x+We2rzWVhFfwwboDkhACztsmohW9U0RXe98GHr7ZDxi8B47F/gpcbfAI2LI5NFvdcuaHVJ/TI1twXu9HzLowQXpBxnSQCru8woxPe0nBfT052Djsrva9v4nO4SzU45wL69AXRr4ybwViCde8Uj2LiKBquSwf5EaVs7GMuQSgHnOKHwayhcgqjKkhQZIGFDGZZTxdq+nqI5xVGH0k1wkrWu/4Ly+NOsYKG2vUM1AHb/UfViXHlRXyM0Z4mYU2roCZemu93gcZqEudiuf1dpp5AaAthSkmVCWEQEZzFBYIFx6HI1H1rF0Xg/wT0MEOnS4v2ZXbMbde80m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkVIL04kNFgJXoqTcePi6B9u4hvLIzZPiuuqB4fLtoY=;
 b=m+PDwFIghXzSOfhw1OQVKkDvubq1lTSlozQIqWbOYU0dO8k++gIYTY2p8eERYaCndKLr5f0Wqz2tLR4V+MVA8u5cfxBd+qWgzXmjKFepVj01p+PawQUaGD9TurYHlCtgOUXkIeLPuvLGWA8QlmKyncAvGqyD0uITJJv3El9oMtdOsUUWFhx7LDuKpig08tDrMrgblmAx1Hx+FnGix5SHO62mIkUEan8okuZe6IqXYMPgYb/+0w4yWdLpK1PXQcaboVVEL09Sm+o71UR0GMX4dgXRToumNb69TyCEcFWn9oJsFDBugEgyyky9y1O3K4BZ9KN+QtMYOnwON8HgcslzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkVIL04kNFgJXoqTcePi6B9u4hvLIzZPiuuqB4fLtoY=;
 b=MYDiNhduvG7alTATkdhLZBGrCuqR8uU4LoMfw2qfJQyZCk+3RTAW1/9YNjbcw2VmkE5crhtfSwtWvnGrRzlBVBcPzsHwrQy4AWuK67dCrneMRJCKplnsF+Bxf3V2WmV7JJ+SicUhvDYoOES7cMXtHvdITq21/BBftUkdShK5hXQ=
Received: from CH2PR02CA0004.namprd02.prod.outlook.com (2603:10b6:610:4e::14)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 18:34:20 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::9) by CH2PR02CA0004.outlook.office365.com
 (2603:10b6:610:4e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 18:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:14 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:14 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 18/22] drm/amd/display: move memory latency update to dml for
 dcn42
Date: Thu, 2 Apr 2026 14:33:10 -0400
Message-ID: <20260402183314.1388755-19-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fad8509-35f1-4045-6c05-08de90e673f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LrqXXFksIyrwLx5zltws+3cz4RyhyFe5WKCoq979XoAgCNB8EctSswFQ88J9eep4LoIS7Q935HtdbBtTqyew6/MqxLlzeQ/If03pvwPCiweHFRis7cf2tsJvtA8S6zMPcL1SFYkPLtxO9mLIdFBKhLP4fRaMJR2wSVGCZR43pJmov6a116ubI4AHnG5hQBYAJzybyvLpQoJ8y5QGlmY+qsDZ0JXYXMDdJV66Aj/FQkfPT+mklR03y42Mbjf5Iq1j3f+ynedk080RQXL/8/8tRyY7e1r2vNlhrPfWLjGfrMqkFkgNrYLdG3wDKUsr/4WZp7jyW4LaAB7Q+cZnIhYNNxzJp8iCUNprvUv6bBktGwWeE59549bPqUYZaLxJSyPCHJq99HM+8mgW0cylx/50M/+w+YqngfTwN3w4zTIYSrMShS1tQV99qmjixW5q2OuoPvGFDeuWGsoWBP7DcGyPA43e6siykUP303ylIAFXs+95GndnHTb+3EsylMq9zI3gzosBJe7MTHYBMudLWahoqQEeeubYBniHEKuwMhbjvlAx5PQc3+ZZX67VILXfcwFzon7FEMxTa6DAfeoejaCaKHYdYde55SZ+dVVH0aVuYtB2Z7zu6u1seqgqWyakzpdgFL30ys8GhcqyWjrhmwBz6eQ7QslJMUgaIb5MDqfZyqC0uGMdXYRRUz0JPRKCfE8HXKLx28obGfI77Md7lI6GhX0SnLJV2Ly2TOFpWOQ+8DHl9BoWvkl4qXLr+fwp+FARZIRDBJMjWqUhhfpJouK5vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +PZJlYNuglyD/3tfFxbsE3adOecdR4pY+fij/q2SjYBdTpOYNaYwsMPFK+LWFAnH59lyrIOCgglE8DLrHA+2EMcvRFlNbfYbdcyojDE4PWYnBP0hl4pJv+vNAr5GIIXjSScUkwEfoh77gNLd9gr/JrGhH0twC16zlSyH3nea8CzDOFofWjQ3BkVttClAZsDBqRUXOiCpCfOfV77O4dY3FBfkMRFuNHsQVNA0FMmeXvZhHoMMOW/OTvFNnKRBvxyKReaU2xorNOs5q9hu83QoSBmNuKIT+dNiyBaOqcUPwuwyUHlg2qGaqmvCIVOERe7RMVtL/IObSeGssRA8aSHUKmgc/lVDj08awo6IOuk6rb7wUouuuAEZjWrwZI0hhP5eD6BvcHCC+UgBpQQBoxQLf1k4kc5v00KSQaUfgsfurgPS0xtoUVEgWMmSE95nHG1M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:19.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fad8509-35f1-4045-6c05-08de90e673f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Memory latencies are soc specific and should be part of dml soc
bounding box. This change removes them from clk_mgr and has
latency update happen based on memory type when dml socbb is being
updated.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 78 -------------------
 .../dcn42/dcn42_soc_and_ip_translator.c       |  4 +
 2 files changed, 4 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index ec888aed207d..6a97ce69a562 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -611,80 +611,6 @@ static struct clk_bw_params dcn42_bw_params = {
 
 };
 
-static struct wm_table ddr5_wm_table = {
-	.entries = {
-		{
-			.wm_inst = WM_A,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_B,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_C,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_D,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-	}
-};
-
-static struct wm_table lpddr5_wm_table = {
-	.entries = {
-		{
-			.wm_inst = WM_A,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_B,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_C,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_D,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
-			.valid = true,
-		},
-	}
-};
-
 struct dcn42_ss_info_table dcn42_ss_info_table = {
 	.ss_divider = 1000,
 	.ss_percentage = {0, 0, 375, 375, 375}
@@ -1141,10 +1067,6 @@ void dcn42_clk_mgr_construct(
 		if (ctx->dc_bios->integrated_info) {
 			clk_mgr->base.base.dentist_vco_freq_khz = ctx->dc_bios->integrated_info->dentist_vco_freq;
 
-			if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
-				dcn42_bw_params.wm_table = lpddr5_wm_table;
-			else
-				dcn42_bw_params.wm_table = ddr5_wm_table;
 			dcn42_bw_params.vram_type = ctx->dc_bios->integrated_info->memory_type;
 			dcn42_bw_params.dram_channel_width_bytes = ctx->dc_bios->integrated_info->memory_type == 0x22 ? 8 : 4;
 			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 1;
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index 146a6e47934b..e723b4d0aff3 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -155,6 +155,10 @@ static void dcn42_update_soc_bb_with_values_from_clk_mgr(struct dml2_soc_bb *soc
 		dcn42_convert_dc_clock_table_to_soc_bb_clock_table(&soc_bb->clk_table, &soc_bb->vmin_limit,
 			dc->clk_mgr->bw_params);
 	}
+
+	if (dc->clk_mgr->bw_params->vram_type == Ddr5MemType) {
+		soc_bb->power_management_parameters = dcn42_ddr5_power_management_parameters;
+	}
 }
 
 static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
-- 
2.34.1


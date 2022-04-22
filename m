Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CD4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6298E10E497;
	Fri, 22 Apr 2022 16:46:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10A210E497
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuaMpRnRXAV24dIRNPmGo9x8picLEKj2fvozVE3AKYmGAnacs149EL0EODf1nlkC/7k3nV6GUuofbpmKcYi48hl3b3sC4XQoUqY+/W0TEc9AxM9eAWgU3IIrhXEOQpSi7vDyPLwen5aVBSaBq87lM87xmz1X9Ax1d/uD6pDDqHnH6tq417iA9/RsHiTxWkEfFecfNXruenwdhOhpL2tS6lDmF0NinQ0vD+PDSgI8t5rilAtjt4NBLVQkVzQy1N9rNLcr3F3p95XmjHsFyJyFmUT2PsAkw3fLgnGIEaxVO+t5keRYOK650EVkAHpBEaa59mHCZYHJ73hhZ75jDS0+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te7TYg8uU8lHQouzKKGavD0Pw0wQFC7wVS42lGZ0p0Y=;
 b=mhG6g0IU8Onks45wikQjJzhBlt6lpKYYfORdY3WH8KlIomR2WSC7Cxm744oDlGZCiczCihfPuBuONDzvFthqRbe30bJlrsV4IHpkuDcUpfFrDG0vwH8YtqctJeU1Uk1TTbi8zqMPnfj2IYwXjJ3xJBLPq3x3ietdZI4UTqHkOaV0nVmLWLxiXZOsrQo0UQ320vlsTRJUnzfNLxvquJ/GxA/rPoqcVTSRFXmJj/o+Om7MpFqnfKMOtyG/Kqkp57sV/esg+pCQoeqaeC+CW8T4D64VP6XgLjBxltsYrqua4eTLuOFRNVff+oos2MRtPObk+bOZLEwtP8rYJZ8wpMKASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te7TYg8uU8lHQouzKKGavD0Pw0wQFC7wVS42lGZ0p0Y=;
 b=2ZjM3NTeg9DutEToAvUsyCa0zb7xi8RizcgUEx0HU3gzjfD3egMZorn3a9pd7+l+ln2I0Mm0LVFrRCfsa3kHMtt0zroTurpkr0aDNUqavKzMX2l6L0OzJHvw1jHhNWRmjNBVDgCVrAsqyiPNMyE62M6N0OwvNndjlFJp83/kZ34=
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 16:46:24 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::d5) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 16:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:46:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:46:23 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:46:13 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amd/display: update dcn315 clk table read
Date: Sat, 23 Apr 2022 00:44:48 +0800
Message-ID: <20220422164457.1755751-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044f636a-7505-407c-3641-08da247fa310
X-MS-TrafficTypeDiagnostic: BY5PR12MB4164:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB416407AA1D82E07BC11CEC3BE6F79@BY5PR12MB4164.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtSrvB0MYMp51F0lnHvu78Ae6RXWy20hhd7PPCt8WKsayOMZTRaoiZm/MAlh4PfmJiY1VU4hWgVdW/X//j2PlkDJQ0VsaayLArbb22usFzCI2k4LM4WRb6Wh6Fa2xUu7AqL37fU2INDiL0MwOyX3rgOw6ran8hFOpOvYVgnutrxvmYgHq4g6JuSKNbaFtM9M4ar+6Z6Umh+2noQljkubTcsRJlOpttfqDQ6Z86GqjbKeF1w1+ASO6wjujdWgeBoTngSdNYKQRt33HWtW1vV1OtSwKL4eneoiVlkp1GWmPRkbzCj95TH2neoHUvWgfQhGgYMr2rP808YLtU6WNM0RMAiOZN0yRLUL903pPFhnarNu2+JnPrE5wGjOgtkH6ZSir9iy1TxXsXlmdqgvKOxw8wSXZCPKNy4GUHkBYpE5aq8vXUrtcF+8a3fJSAjcKVCdcQ35ZJSCH+NNRpW5LYyzwa3Vf+wgOw3mS5FX2lgpccztJf8IK0tr8lalrZSX8tlAFwYsuVXe63ybDiBXW7vJipKY56jItOgNAl10rf3yiqP9a316BmJ5ZbVoSkugse8Z4JF63rNWKOh8Wy1e/OZ766e3p7FIsIoUPIeLH6xS7IeCCA9OhvkUn1LyRq2+GcH6o1izCwpaQu0G4ssSRqgbzx1UaybHlqny9ZGy7/tm8GaZHbzE4IycCulR3683Rni9htv89GTYEa58cnm1huPqFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(6916009)(30864003)(15650500001)(8936002)(426003)(336012)(2906002)(47076005)(356005)(36756003)(54906003)(86362001)(40460700003)(5660300002)(2616005)(6666004)(7696005)(70586007)(4326008)(1076003)(8676002)(70206006)(508600001)(83380400001)(82310400005)(36860700001)(26005)(186003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:46:24.0448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044f636a-7505-407c-3641-08da247fa310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Clean up the sequence by making sure clk_mgr always builds a
reasonable clock table regardless of what we read from smu
by moving all defaults from resource soc struct to clk_mgr.

Now the only thing resource soc update does is read
the clock table and apply any DC specific policy decisions
to how clocks are populated in dml soc.

Reviewed-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 114 +++++++++-----
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 145 ++++--------------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 3 files changed, 111 insertions(+), 149 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 8be4c1970628..27501b735a9c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -219,8 +219,50 @@ static void dcn315_dump_clk_registers(struct clk_state_registers_and_bypass *reg
 
 static struct clk_bw_params dcn315_bw_params = {
 	.vram_type = Ddr4MemType,
-	.num_channels = 1,
+	.num_channels = 2,
 	.clk_table = {
+		.entries = {
+			{
+				.voltage = 0,
+				.dispclk_mhz = 640,
+				.dppclk_mhz = 640,
+				.phyclk_mhz = 810,
+				.phyclk_d18_mhz = 667,
+				.dtbclk_mhz = 600,
+			},
+			{
+				.voltage = 1,
+				.dispclk_mhz = 739,
+				.dppclk_mhz = 739,
+				.phyclk_mhz = 810,
+				.phyclk_d18_mhz = 667,
+				.dtbclk_mhz = 600,
+			},
+			{
+				.voltage = 2,
+				.dispclk_mhz = 960,
+				.dppclk_mhz = 960,
+				.phyclk_mhz = 810,
+				.phyclk_d18_mhz = 667,
+				.dtbclk_mhz = 600,
+			},
+			{
+				.voltage = 3,
+				.dispclk_mhz = 1200,
+				.dppclk_mhz = 1200,
+				.phyclk_mhz = 810,
+				.phyclk_d18_mhz = 667,
+				.dtbclk_mhz = 600,
+			},
+			{
+				.voltage = 4,
+				.dispclk_mhz = 1372,
+				.dppclk_mhz = 1372,
+				.phyclk_mhz = 810,
+				.phyclk_d18_mhz = 667,
+				.dtbclk_mhz = 600,
+			},
+		},
 		.num_entries = 5,
 	},
 
@@ -300,8 +342,8 @@ static struct wm_table lpddr5_wm_table = {
 	}
 };
 
-static DpmClocks_315_t dummy_clocks;
-
+/* Temporary Place holder until we can get them from fuse */
+static DpmClocks_315_t dummy_clocks = { 0 };
 static struct dcn315_watermarks dummy_wms = { 0 };
 
 static void dcn315_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn315_watermarks *table)
@@ -415,22 +457,6 @@ static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 	return max;
 }
 
-static unsigned int find_clk_for_voltage(
-		const DpmClocks_315_t *clock_table,
-		const uint32_t clocks[],
-		unsigned int voltage)
-{
-	int i;
-
-	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
-		if (clock_table->SocVoltage[i] == voltage)
-			return clocks[i];
-	}
-
-	ASSERT(0);
-	return 0;
-}
-
 static void dcn315_clk_mgr_helper_populate_bw_params(
 		struct clk_mgr_internal *clk_mgr,
 		struct integrated_info *bios_info,
@@ -438,13 +464,9 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 {
 	int i;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
-	uint32_t max_dispclk, max_dppclk, max_pstate, max_socclk, max_fclk = 0, min_pstate = 0;
+	uint32_t max_pstate = 0, max_fclk = 0, min_pstate = 0;
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
 
-	max_dispclk = find_max_clk_value(clock_table->DispClocks, clock_table->NumDispClkLevelsEnabled);
-	max_dppclk = find_max_clk_value(clock_table->DppClocks, clock_table->NumDispClkLevelsEnabled);
-	max_socclk = find_max_clk_value(clock_table->SocClocks, clock_table->NumSocClkLevelsEnabled);
-
 	/* Find highest fclk pstate */
 	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
 		if (clock_table->DfPstateTable[i].FClk > max_fclk) {
@@ -466,35 +488,44 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 			}
 		}
 
+		/* First search defaults for the clocks we don't read using closest lower or equal default dcfclk */
+		for (j = bw_params->clk_table.num_entries - 1; j > 0; j--)
+			if (bw_params->clk_table.entries[j].dcfclk_mhz <= clock_table->DcfClocks[i])
+				break;
+		bw_params->clk_table.entries[i].phyclk_mhz = bw_params->clk_table.entries[j].phyclk_mhz;
+		bw_params->clk_table.entries[i].phyclk_d18_mhz = bw_params->clk_table.entries[j].phyclk_d18_mhz;
+		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
+
+		/* Now update clocks we do read */
 		bw_params->clk_table.entries[i].fclk_mhz = min_fclk;
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[min_pstate].MemClk;
 		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[min_pstate].Voltage;
 		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
 		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
-		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
-		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[i].dispclk_mhz = clock_table->DispClocks[i];
+		bw_params->clk_table.entries[i].dppclk_mhz = clock_table->DppClocks[i];
 		bw_params->clk_table.entries[i].wck_ratio = 1;
 	};
 
 	/* Make sure to include at least one entry and highest pstate */
-	if (max_pstate != min_pstate) {
+	if (max_pstate != min_pstate || i == 0) {
 		bw_params->clk_table.entries[i].fclk_mhz = max_fclk;
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[max_pstate].MemClk;
 		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[max_pstate].Voltage;
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_clk_for_voltage(
-				clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[max_pstate].Voltage);
-		bw_params->clk_table.entries[i].socclk_mhz = find_clk_for_voltage(
-				clock_table, clock_table->SocClocks, clock_table->DfPstateTable[max_pstate].Voltage);
-		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
-		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[i].dcfclk_mhz = find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS);
 		bw_params->clk_table.entries[i].wck_ratio = 1;
 		i++;
 	}
-	bw_params->clk_table.num_entries = i;
+	bw_params->clk_table.num_entries = i--;
 
-	/* Include highest socclk */
-	if (bw_params->clk_table.entries[i-1].socclk_mhz < max_socclk)
-		bw_params->clk_table.entries[i-1].socclk_mhz = max_socclk;
+	/* Make sure all highest clocks are included*/
+	bw_params->clk_table.entries[i].socclk_mhz = find_max_clk_value(clock_table->SocClocks, NUM_SOCCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dispclk_mhz = find_max_clk_value(clock_table->DispClocks, NUM_DISPCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dppclk_mhz = find_max_clk_value(clock_table->DppClocks, NUM_DPPCLK_DPM_LEVELS);
+	ASSERT(clock_table->DcfClocks[i] == find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS));
+	bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
+	bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+	bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
 
 	/* Set any 0 clocks to max default setting. Not an issue for
 	 * power since we aren't doing switching in such case anyway
@@ -513,9 +544,18 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 			bw_params->clk_table.entries[i].dispclk_mhz = def_max.dispclk_mhz;
 		if (!bw_params->clk_table.entries[i].dppclk_mhz)
 			bw_params->clk_table.entries[i].dppclk_mhz = def_max.dppclk_mhz;
+		if (!bw_params->clk_table.entries[i].phyclk_mhz)
+			bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
+		if (!bw_params->clk_table.entries[i].phyclk_d18_mhz)
+			bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
+			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
 	}
+	ASSERT(bw_params->clk_table.entries[i].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
+	if (!bw_params->num_channels)
+		bw_params->num_channels = 2;
 
 	for (i = 0; i < WM_SET_COUNT; i++) {
 		bw_params->wm_table.entries[i].wm_inst = i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index a0a2e125c9c8..54db2eca9e6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -260,55 +260,6 @@ struct _vcs_dpi_ip_params_st dcn3_15_ip = {
 };
 
 struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
-		/*TODO: correct dispclk/dppclk voltage level determination*/
-	.clock_limits = {
-		{
-			.state = 0,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 1,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 2,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 3,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 4,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-	},
-	.num_states = 5,
 	.sr_exit_time_us = 9.0,
 	.sr_enter_plus_exit_time_us = 11.0,
 	.sr_exit_z8_time_us = 50.0,
@@ -696,80 +647,50 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
-	unsigned int i, closest_clk_lvl;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
-	int j;
+	int i, max_dispclk_mhz = 0, max_dppclk_mhz = 0;
 
 	dc_assert_fp_enabled();
 
-	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-
-		dcn3_15_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
-		dcn3_15_ip.max_num_dpp = dc->res_pool->pipe_count;
-		dcn3_15_soc.num_chans = bw_params->num_channels;
+	dcn3_15_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
+	dcn3_15_ip.max_num_dpp = dc->res_pool->pipe_count;
+	dcn3_15_soc.num_chans = bw_params->num_channels;
 
-		ASSERT(clk_table->num_entries);
+	ASSERT(clk_table->num_entries);
 
-		/* Prepass to find max clocks independent of voltage level. */
-		for (i = 0; i < clk_table->num_entries; ++i) {
-			if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
-				max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
-			if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
-				max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
-		}
+	/* Setup soc to always use max dispclk/dppclk to avoid odm-to-lower-voltage */
+	for (i = 0; i < clk_table->num_entries; ++i) {
+		if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
+			max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
+		if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
+			max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
+	}
 
-		for (i = 0; i < clk_table->num_entries; i++) {
-			/* loop backwards*/
-			for (closest_clk_lvl = 0, j = dcn3_15_soc.num_states - 1; j >= 0; j--) {
-				if ((unsigned int) dcn3_15_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
-					closest_clk_lvl = j;
-					break;
-				}
-			}
-			if (clk_table->num_entries == 1) {
-				/*smu gives one DPM level, let's take the highest one*/
-				closest_clk_lvl = dcn3_15_soc.num_states - 1;
-			}
+	for (i = 0; i < clk_table->num_entries; i++) {
+		dcn3_15_soc.clock_limits[i].state = i;
 
-			clock_limits[i].state = i;
+		/* Clocks dependent on voltage level. */
+		dcn3_15_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+		dcn3_15_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+		dcn3_15_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+		dcn3_15_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
 
-			/* Clocks dependent on voltage level. */
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			if (clk_table->num_entries == 1 &&
-				clock_limits[i].dcfclk_mhz < dcn3_15_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
-				/*SMU fix not released yet*/
-				clock_limits[i].dcfclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
-			}
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
-
-			/* Clocks independent of voltage level. */
-			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
-				dcn3_15_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-
-			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
-				dcn3_15_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+		/* These aren't actually read from smu, but rather set in clk_mgr defaults */
+		dcn3_15_soc.clock_limits[i].dtbclk_mhz = clk_table->entries[i].dtbclk_mhz;
+		dcn3_15_soc.clock_limits[i].phyclk_d18_mhz = clk_table->entries[i].phyclk_d18_mhz;
+		dcn3_15_soc.clock_limits[i].phyclk_mhz = clk_table->entries[i].phyclk_mhz;
 
-			clock_limits[i].dram_bw_per_chan_gbps = dcn3_15_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
-		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_15_soc.clock_limits[i] = clock_limits[i];
-		if (clk_table->num_entries) {
-			dcn3_15_soc.num_states = clk_table->num_entries;
-		}
+		/* Clocks independent of voltage level. */
+		dcn3_15_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
+		dcn3_15_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz;
+		dcn3_15_soc.clock_limits[i].dscclk_mhz = max_dispclk_mhz / 3.0;
 	}
+	dcn3_15_soc.num_states = clk_table->num_entries;
 
-	if (max_dispclk_mhz) {
-		dcn3_15_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-	}
+
+	/* Set vco to max_dispclk * 2 to make sure the highest dispclk is always available for dml calcs,
+	 * no impact outside of dml validation
+	 */
+	dcn3_15_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index c920c4b6077d..46ce5a0ee4ec 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -91,6 +91,7 @@ struct clk_limit_table_entry {
 	unsigned int dispclk_mhz;
 	unsigned int dppclk_mhz;
 	unsigned int phyclk_mhz;
+	unsigned int phyclk_d18_mhz;
 	unsigned int wck_ratio;
 };
 
-- 
2.25.1


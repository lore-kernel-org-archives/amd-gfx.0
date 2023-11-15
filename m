Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1732C5AE5E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0216610E58F;
	Wed, 15 Nov 2023 19:44:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5770210E58D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai1niGe5rdWH8QQU2KEsXw/jTwWN3eq6oEmHxdW/bc61x95mej8WOksu+Ndbai9GPpmB5WDHKp0+Tr4F/GPQ1+Xw6p9CCkIng64SDBAviyYTprayhXmOTScVA1d7I1156Y4JAAOF0NrWz+ZXu7ICPhf2OzdZpjliOfOsIhundL0q+X2vK9rRMljx2QRSMDND/fT9TzuPvtMOwrrxNY3dUtJPiekw52B3IZCxfFO8fLedoT5ahM4JjNn8DS6bLh3pdTL9UwqEbltPBQA74JxPUKoWoIGbeuIiDrHO4qlmuCr162HS7XkwlVGIlGWDzsTg/gYh6y72Rp/UnhRZB/r5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqTvAqLn+8QEdE4PNTsW1SXGibnp1dtwTEBjgvXdODE=;
 b=a5pC5e99Pz5/8CEkEE9SYHe0cCa99Yk74ponU+M5ODFKa8eV92IM5xALgPwNSfo3Pef85vS8bp4A+eCLJm4m5hIXiCBTBLI/8jyYWGOEJI2AYxA29njU/A4Z4PwauCUwlmMJzWYsJZuBVxTm0o8cZsR8Qyepe1XjOnQjyjOxGr0BqQ9TQILRqUfVVHAsPpe0PCygi2DQoSxRi7OCeNV7B/mteWfr84Da92OmlVrJc79YAYgtwDHuGetDigerOb3FdCmw1auOadU2Hqs0lwRorGuTbHKnqDYsoP37n0+9E0RX9o2VWHUAoQbDVLfNwD0DGB2Mw540zRP5ifI1VPgpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqTvAqLn+8QEdE4PNTsW1SXGibnp1dtwTEBjgvXdODE=;
 b=CuWet1+z/mUCSr4jtb8XqcJH/YoGGWV2vI9BTrX5i1LtV5m2YUVGc9DKqShUavBF3q0aARAhQFL9+FGws9vVG+4vLRGH5Mi+YTd1hRrKlNyXnt4vRzz4yRI5LYpoSA6aZkfgc6Ij8NI6YimKw94RXEPjCM5N7GLLLehbiYpSN5w=
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:43 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::3d) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:43 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:41 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/35] drm/amd/display: Update DCN35 clock table policy
Date: Wed, 15 Nov 2023 14:40:42 -0500
Message-ID: <20231115194332.39469-30-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0abf31-8312-4d35-936a-08dbe6135069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joOdFO1fQumkSXwxxFl7uxDQ0fY/KX4X500sgcIaQ1ovzE63pxBHmH4TcnMyEbVkPVdpF6DZn1mtOr7hR+dDRt/bs2qXAeO+1Mqm2ah/YKE3SPggkWwGEzFZqN17t3bX8vEcKHswXsqKWstAVdl6HpeZlGVd+y3vgrdlQMb4wu4xtK0mcaastfcSK4tPsSEb0w7tOZuhLEMHXajq+FCazEFVh84tBAmJSOA8bhxnlOrOOhwRYji/VMdTp6atOPk5vyUR3kNVGt26Q91qLFbXa4wztAWxbbGEj65Q9FuHLqA71BJ+SSjnKfLLPoRfo9VzxKaX5VXZJizFEVdNL2NzH2QHxxn7fl1ym96qv/S541fOAYyd5YsJM/C8gFRgY/B2R27l1/zALEoMfP8kSshKTtGioepKkbUElTONYV4e68uJgVRS057hx8OFmEqI3Vgh7il/QQbVHnVZbTMVoCaFYynw6iXdoRFlgsp9PuFwWgQzWxAx+pjDFG+xEBY3JFs4br5cL8hsndbbzuIK8Y8ee9U/FIEkPqd58aPlV3AZQ078mo0hhHsYZVJttVSAQpZWtpCYXGLSUw4NqZx4PnOvHAQKoezvlHxoYqY3APPF84aetDxRF6mGdD0EpUhNWcRnAl59e+tHz8fBRuK0AimwxXMh7MIKnW97Wh1GdwS1wid+4bM/CxAndN07Kyf21fGlkQwUgljiUTo7hASsUyNNVeRSykhtvpHu/6CZ+lqAb4eem8yk6ywoZCJTDfqmIUAOd0S5sH/nBVf7kVOtTWWOSGCsI4gFnrudVmwOGulUqgI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(356005)(36756003)(47076005)(15650500001)(2906002)(40460700003)(5660300002)(81166007)(36860700001)(41300700001)(40480700001)(86362001)(6916009)(4326008)(8676002)(316002)(8936002)(426003)(336012)(83380400001)(478600001)(2616005)(1076003)(82740400003)(16526019)(54906003)(70206006)(26005)(70586007)(44832011)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:43.0608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0abf31-8312-4d35-936a-08dbe6135069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The new table doesn't have an implicit mapping between Fclk SOC voltage
and MemClk and it currently builds the table off of number of Fclk
states rather than DcfClock states.

The DML table in use is not correct for functionality or power and
does not align with our existing policies for DCN3x.

[How]
Build the table based on DcfClock with the following assumptions:

1. Raising Soc voltage is the most expensive operation, so assume that
running at max DispClock or DppClock is preferable.

2. Assume that we can run at max Fclk / MemClk at any state, but
restrict the maximum state to the very last entry in the table as the
worst case scenario.

3. Assume that Fclk always has a 2x multiplier on DcfClock unless the
table specifies something lower.

Reviewed-by: Taimur Hassan <syed.hassan@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 77 ++++++++++++-------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 0f3f6a9d5144..19f8d83698be 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -648,27 +648,47 @@ static unsigned int convert_wck_ratio(uint8_t wck_ratio)
 	return 1;
 }
 
+static inline uint32_t calc_dram_speed_mts(const MemPstateTable_t *entry)
+{
+	return entry->UClk * convert_wck_ratio(entry->WckRatio) * 2;
+}
+
 static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk_mgr,
 						    struct integrated_info *bios_info,
 						    DpmClocks_t_dcn35 *clock_table)
 {
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
-	uint32_t max_pstate = 0,  max_uclk = 0, max_fclk = 0;
-	uint32_t min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
+	uint32_t max_fclk = 0, min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
+	uint32_t max_pstate = 0, max_dram_speed_mts = 0, min_dram_speed_mts = 0;
 	int i;
 
+	/* Determine min/max p-state values. */
 	for (i = 0; i < clock_table->NumMemPstatesEnabled; i++) {
-		if (is_valid_clock_value(clock_table->MemPstateTable[i].UClk) &&
-		    clock_table->MemPstateTable[i].UClk > max_uclk) {
-			max_uclk = clock_table->MemPstateTable[i].UClk;
+		uint32_t dram_speed_mts = calc_dram_speed_mts(&clock_table->MemPstateTable[i]);
+
+		if (is_valid_clock_value(dram_speed_mts) && dram_speed_mts > max_dram_speed_mts) {
+			max_dram_speed_mts = dram_speed_mts;
 			max_pstate = i;
 		}
 	}
 
-	/* We expect the table to contain at least one valid Uclk entry. */
-	ASSERT(is_valid_clock_value(max_uclk));
+	min_dram_speed_mts = max_dram_speed_mts;
+	min_pstate = max_pstate;
 
+	for (i = 0; i < clock_table->NumMemPstatesEnabled; i++) {
+		uint32_t dram_speed_mts = calc_dram_speed_mts(&clock_table->MemPstateTable[i]);
+
+		if (is_valid_clock_value(dram_speed_mts) && dram_speed_mts < min_dram_speed_mts) {
+			min_dram_speed_mts = dram_speed_mts;
+			min_pstate = i;
+		}
+	}
+
+	/* We expect the table to contain at least one valid P-state entry. */
+	ASSERT(clock_table->NumMemPstatesEnabled &&
+	       is_valid_clock_value(max_dram_speed_mts) &&
+	       is_valid_clock_value(min_dram_speed_mts));
 
 	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
 	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS &&
@@ -678,47 +698,46 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 		max_dppclk = find_max_clk_value(clock_table->DppClocks,
 			clock_table->NumDispClkLevelsEnabled);
 	} else {
+		/* Invalid number of entries in the table from PMFW. */
 		ASSERT(0);
 	}
-	if (clock_table->NumFclkLevelsEnabled <= NUM_FCLK_DPM_LEVELS)
-		max_fclk = find_max_clk_value(clock_table->FclkClocks_Freq,
-			clock_table->NumFclkLevelsEnabled);
 
-	for (i = 0; i < clock_table->NumMemPstatesEnabled; i++) {
-		uint32_t min_uclk = clock_table->MemPstateTable[0].UClk;
-		int j;
+	/* Base the clock table on dcfclk, need at least one entry regardless of pmfw table */
+	ASSERT(clock_table->NumDcfClkLevelsEnabled > 0);
 
-		for (j = 1; j < clock_table->NumMemPstatesEnabled; j++) {
-			if (is_valid_clock_value(clock_table->MemPstateTable[j].UClk) &&
-			    clock_table->MemPstateTable[j].UClk < min_uclk &&
-			    clock_table->MemPstateTable[j].Voltage <= clock_table->SocVoltage[i]) {
-				min_uclk = clock_table->MemPstateTable[j].UClk;
-				min_pstate = j;
-			}
-		}
+	max_fclk = find_max_clk_value(clock_table->FclkClocks_Freq, clock_table->NumFclkLevelsEnabled);
 
+	for (i = 0; i < clock_table->NumDcfClkLevelsEnabled; i++) {
+		int j;
+
+		/* First search defaults for the clocks we don't read using closest lower or equal default dcfclk */
 		for (j = bw_params->clk_table.num_entries - 1; j > 0; j--)
 			if (bw_params->clk_table.entries[j].dcfclk_mhz <= clock_table->DcfClocks[i])
-			break;
+				break;
 
 		bw_params->clk_table.entries[i].phyclk_mhz = bw_params->clk_table.entries[j].phyclk_mhz;
 		bw_params->clk_table.entries[i].phyclk_d18_mhz = bw_params->clk_table.entries[j].phyclk_d18_mhz;
 		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
-		bw_params->clk_table.entries[i].fclk_mhz = max_fclk;
+
+		/* Now update clocks we do read */
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemPstateTable[min_pstate].MemClk;
 		bw_params->clk_table.entries[i].voltage = clock_table->MemPstateTable[min_pstate].Voltage;
 		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
 		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
 		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
 		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
-		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
-			clock_table->MemPstateTable[min_pstate].WckRatio);
-		}
+		bw_params->clk_table.entries[i].wck_ratio =
+			convert_wck_ratio(clock_table->MemPstateTable[min_pstate].WckRatio);
+
+		/* Dcfclk and Fclk are tied, but at a different ratio */
+		bw_params->clk_table.entries[i].fclk_mhz = min(max_fclk, 2 * clock_table->DcfClocks[i]);
+	}
 
 	/* Make sure to include at least one entry at highest pstate */
 	if (max_pstate != min_pstate || i == 0) {
 		if (i > MAX_NUM_DPM_LVL - 1)
 			i = MAX_NUM_DPM_LVL - 1;
+
 		bw_params->clk_table.entries[i].fclk_mhz = max_fclk;
 		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemPstateTable[max_pstate].MemClk;
 		bw_params->clk_table.entries[i].voltage = clock_table->MemPstateTable[max_pstate].Voltage;
@@ -734,6 +753,7 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	}
 	bw_params->clk_table.num_entries = i--;
 
+	/* Make sure all highest clocks are included*/
 	bw_params->clk_table.entries[i].socclk_mhz =
 		find_max_clk_value(clock_table->SocClocks, NUM_SOCCLK_DPM_LEVELS);
 	bw_params->clk_table.entries[i].dispclk_mhz =
@@ -752,6 +772,11 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	bw_params->clk_table.num_entries_per_clk.num_fclk_levels = clock_table->NumFclkLevelsEnabled;
 	bw_params->clk_table.num_entries_per_clk.num_memclk_levels = clock_table->NumMemPstatesEnabled;
 	bw_params->clk_table.num_entries_per_clk.num_socclk_levels = clock_table->NumSocClkLevelsEnabled;
+
+	/*
+	 * Set any 0 clocks to max default setting. Not an issue for
+	 * power since we aren't doing switching in such case anyway
+	 */
 	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
 		if (!bw_params->clk_table.entries[i].fclk_mhz) {
 			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
-- 
2.42.0


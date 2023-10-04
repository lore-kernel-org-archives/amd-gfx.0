Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E62E776F4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3534710E365;
	Wed,  4 Oct 2023 09:23:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B2510E35B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA4HuXJsiPcpDBVRotp8VcWfDWoJv8N3mLM10dfcUZbWD8mlIwqs+WULMxVizmNTqT5vNk99gSde+GZISYA137MEHXTy+9dvE8qOJB3VvyYvallRv+01m1DQTI7OWO/7SstNOCz0E1lHATET5BC8/r9iqr3tCu3nEws/xr7kbWyuG41GPzfpTZanCCujcyMPHMhlAo/cVhQFnnKAw7tWHiwvvPvRMv1AE1lFo+26I2tMnAlsV4ZPM4PRvKalexjRlzEVNNHL/TFN+kLSRDhUAi9IQGQ+IkkikaTHRUx1d//4KlFqM9x5KMRI1I1qqwpL4I6HoL+XyswApb6wlhETLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njxl48JJzIHG6xFCakCiw7wZ1n0rWTmThQ4Y/N1pBr0=;
 b=YsJkCmAf3PXVAG5jXHoceuYoW57VFsZOlsP+1uKKL/I5ionzrwoB6+TZwTci79YGx8inVgEJh51c6WKEc9dSjmO2GKPhGClfNrg3368W0P0ugfwRPnEqhI50t1POTfeNFfqGEZr3si54jHF9OU70ypg0W0qS6RGXGZ7qWyU46TN24gsLE6/+nKeskJY5em5WsBdu2cVfoxWKyoaX3zCgn2aNsQ14/DdYlVBeKELLlTZlKFgCY11ks31evKNeGdBmacPm5BU4doF4cq4KU72oQdFKNX2sqO78rXQpQNn1AY29qn7yvmx3aEez/61Cco5XZV7aUuAfi3wR5ERXP/sErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njxl48JJzIHG6xFCakCiw7wZ1n0rWTmThQ4Y/N1pBr0=;
 b=wU3sj5us+5cynyliWYpHMZhGGSv8TgOmRSwJ3JHJke5B6sMeG1brJu3XzO2MxlubP09uOIpH0W1KL/QkneDAt787/aTfwINZuckHAlOiaAGhQCWtelADkIEtvgd8HSbUldKyB5LA/4cXH5WiF/1qfkc6bkcujC4Fyv6wTgu9rPs=
Received: from MN2PR19CA0043.namprd19.prod.outlook.com (2603:10b6:208:19b::20)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 4 Oct
 2023 09:23:41 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::e3) by MN2PR19CA0043.outlook.office365.com
 (2603:10b6:208:19b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:23:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:23:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:23:39 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Update pmfw_driver_if new structure
Date: Wed, 4 Oct 2023 17:22:48 +0800
Message-ID: <20231004092301.2371458-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8262f71d-cc22-4e9f-1715-08dbc4bb9939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzixDUO1uiOpWmG38qWLDAz6qn5CYrL8/jyCNd+odK2tvjLr+gp8t+8P1Y7qrCzyM0Li7S6jTYdDiUms6q14SSrCBgDPwiXpDrfxp0dLhSjFLCEbSEGYe4xZoSmIQm0SNzPS1oSzxKwRC1LRyEVilBgcX93JaIzPUMRK2O/4KjCFqVE0b+MdIkrxNuK/ic0SzEa1p3xDDwuaSZ91QLZg1uRkrniG3RHnUJYRFXz1InS4J4XwgL34B/1dWjxGxMVgxTXdXkQsEJ+Gujg8umX5SpeDRZeJJdWi6ZSvb7Sdfe3Zhy1oh7ZLFopTmwDVNmuJPzLekWhRjhf5aqb+SsW0CsoYKwBDv45H4Gzmlqmj5OCM7cr7S9gBxnd/6VqhXkPkGtjN91YTWFM430NaO86aXOY61L3eR6snMXSLWngLN/+gSzA8ksS6FB1JLhcj/AOT/4VZtA6yK4wfCjErjsi/lsmmAJIABEo8t2OWBg+Fg78DtgLdywtW10tQGNNGk8an7wrl0h2vZnxV5xL4/1iBFqGC0dtUKvvYJNfCvcADvcGf994SpG/DiQqlTZIVAcx8OW7nH8j4qg2BNS3BPI9KRNia6OsKwN9MH99uEGJ9XZFVtFKQSFcK+4uvTiKC06qcuAFRgyaakzbv5FcrXAxv6My9VXSQgMV9UlmmzBUiQJj6dfgBDQOV5Uf1v5w+q2kPGwe+4v+wFYQdotIMtJ9JtOMXMQK0+z11Q6yHC4wfvwi1XEzHblFC+UFP3f5IbN4DjE4n25nTyz5B2ceNNkRfew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(356005)(30864003)(82740400003)(7696005)(81166007)(40480700001)(26005)(336012)(426003)(70586007)(41300700001)(2616005)(4326008)(15650500001)(8676002)(8936002)(5660300002)(2906002)(86362001)(6916009)(70206006)(54906003)(316002)(36756003)(6666004)(478600001)(1076003)(47076005)(36860700001)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:23:41.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8262f71d-cc22-4e9f-1715-08dbc4bb9939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Sung joon Kim <sungjoon.kim@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
pmfw header file updated, need align with data structure.

[How]
Update the data structure.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 214 ++++++++++++------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  36 ++-
 2 files changed, 174 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 21dfe3faf08c..f80917f6153b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -507,7 +507,7 @@ static struct wm_table lpddr5_wm_table = {
 	}
 };
 
-static DpmClocks_t dummy_clocks;
+static DpmClocks_t_dcn35 dummy_clocks;
 
 static struct dcn35_watermarks dummy_wms = { 0 };
 
@@ -597,7 +597,7 @@ static void dcn35_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 static void dcn35_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct dcn35_smu_dpm_clks *smu_dpm_clks)
 {
-	DpmClocks_t *table = smu_dpm_clks->dpm_clks;
+	DpmClocks_t_dcn35 *table = smu_dpm_clks->dpm_clks;
 
 	if (!clk_mgr->smu_ver)
 		return;
@@ -627,88 +627,158 @@ static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 	return max;
 }
 
-static unsigned int find_clk_for_voltage(
-		const DpmClocks_t *clock_table,
-		const uint32_t clocks[],
-		unsigned int voltage)
+static inline bool is_valid_clock_value(uint32_t clock_value)
 {
-	int i;
-	int max_voltage = 0;
-	int clock = 0;
-
-	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
-		if (clock_table->SocVoltage[i] == voltage) {
-			return clocks[i];
-		} else if (clock_table->SocVoltage[i] >= max_voltage &&
-				clock_table->SocVoltage[i] < voltage) {
-			max_voltage = clock_table->SocVoltage[i];
-			clock = clocks[i];
-		}
+	return clock_value > 1 && clock_value < 100000;
+}
+
+static unsigned int convert_wck_ratio(uint8_t wck_ratio)
+{
+	switch (wck_ratio) {
+	case WCK_RATIO_1_2:
+		return 2;
+
+	case WCK_RATIO_1_4:
+		return 4;
+	/* Find lowest DPM, FCLK is filled in reverse order*/
+
+	default:
+			break;
 	}
 
-	ASSERT(clock);
-	return clock;
+	return 1;
 }
 
 static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk_mgr,
 						    struct integrated_info *bios_info,
-						    const DpmClocks_t *clock_table)
+						    DpmClocks_t_dcn35 *clock_table)
 {
-	int i, j;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
-	uint32_t max_dispclk = 0, max_dppclk = 0;
-
-	j = -1;
-
-	ASSERT(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL);
-
-	/* Find lowest DPM, FCLK is filled in reverse order*/
+	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
+	uint32_t max_pstate = 0,  max_uclk = 0, max_fclk = 0;
+	uint32_t min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
+	int i;
 
-	for (i = NUM_DF_PSTATE_LEVELS - 1; i >= 0; i--) {
-		if (clock_table->DfPstateTable[i].FClk != 0) {
-			j = i;
-			break;
+	for (i = 0; i < clock_table->NumMemPstatesEnabled; i++) {
+		if (is_valid_clock_value(clock_table->MemPstateTable[i].UClk) &&
+		    clock_table->MemPstateTable[i].UClk > max_uclk) {
+			max_uclk = clock_table->MemPstateTable[i].UClk;
+			max_pstate = i;
 		}
 	}
 
-	if (j == -1) {
-		/* clock table is all 0s, just use our own hardcode */
-		ASSERT(0);
-		return;
-	}
+	/* We expect the table to contain at least one valid Uclk entry. */
+	ASSERT(is_valid_clock_value(max_uclk));
 
-	bw_params->clk_table.num_entries = j + 1;
 
 	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
 	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS &&
 	    clock_table->NumDispClkLevelsEnabled <= NUM_DPPCLK_DPM_LEVELS) {
-		max_dispclk = find_max_clk_value(clock_table->DispClocks, clock_table->NumDispClkLevelsEnabled);
-		max_dppclk = find_max_clk_value(clock_table->DppClocks, clock_table->NumDispClkLevelsEnabled);
+		max_dispclk = find_max_clk_value(clock_table->DispClocks,
+			clock_table->NumDispClkLevelsEnabled);
+		max_dppclk = find_max_clk_value(clock_table->DppClocks,
+			clock_table->NumDispClkLevelsEnabled);
 	} else {
 		ASSERT(0);
 	}
+	if (clock_table->NumFclkLevelsEnabled <= NUM_FCLK_DPM_LEVELS)
+		max_fclk = find_max_clk_value(clock_table->FclkClocks_Freq,
+			clock_table->NumFclkLevelsEnabled);
+
+	for (i = 0; i < clock_table->NumMemPstatesEnabled; i++) {
+		uint32_t min_uclk = clock_table->MemPstateTable[0].UClk;
+		int j;
+
+		for (j = 1; j < clock_table->NumMemPstatesEnabled; j++) {
+			if (is_valid_clock_value(clock_table->MemPstateTable[j].UClk) &&
+			    clock_table->MemPstateTable[j].UClk < min_uclk &&
+			    clock_table->MemPstateTable[j].Voltage <= clock_table->SocVoltage[i]) {
+				min_uclk = clock_table->MemPstateTable[j].UClk;
+				min_pstate = j;
+			}
+		}
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
-		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
-		switch (clock_table->DfPstateTable[j].WckRatio) {
-		case WCK_RATIO_1_2:
-			bw_params->clk_table.entries[i].wck_ratio = 2;
-			break;
-		case WCK_RATIO_1_4:
-			bw_params->clk_table.entries[i].wck_ratio = 4;
+		for (j = bw_params->clk_table.num_entries - 1; j > 0; j--)
+			if (bw_params->clk_table.entries[j].dcfclk_mhz <= clock_table->DcfClocks[i])
 			break;
-		default:
-			bw_params->clk_table.entries[i].wck_ratio = 1;
+
+		bw_params->clk_table.entries[i].phyclk_mhz = bw_params->clk_table.entries[j].phyclk_mhz;
+		bw_params->clk_table.entries[i].phyclk_d18_mhz = bw_params->clk_table.entries[j].phyclk_d18_mhz;
+		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
+		bw_params->clk_table.entries[i].fclk_mhz = max_fclk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemPstateTable[min_pstate].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->MemPstateTable[min_pstate].Voltage;
+		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
+		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
+		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
+			clock_table->MemPstateTable[min_pstate].WckRatio);
 		}
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
-		bw_params->clk_table.entries[i].socclk_mhz = find_clk_for_voltage(clock_table, clock_table->SocClocks, clock_table->DfPstateTable[j].Voltage);
+
+	/* Make sure to include at least one entry at highest pstate */
+	if (max_pstate != min_pstate || i == 0) {
+		if (i > MAX_NUM_DPM_LVL - 1)
+			i = MAX_NUM_DPM_LVL - 1;
+		bw_params->clk_table.entries[i].fclk_mhz = max_fclk;
+		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemPstateTable[max_pstate].MemClk;
+		bw_params->clk_table.entries[i].voltage = clock_table->MemPstateTable[max_pstate].Voltage;
+		bw_params->clk_table.entries[i].dcfclk_mhz =
+			find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS);
+		bw_params->clk_table.entries[i].socclk_mhz =
+			find_max_clk_value(clock_table->SocClocks, NUM_SOCCLK_DPM_LEVELS);
 		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
 		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[i].wck_ratio = convert_wck_ratio(
+			clock_table->MemPstateTable[max_pstate].WckRatio);
+		i++;
 	}
-
+	bw_params->clk_table.num_entries = i--;
+
+	bw_params->clk_table.entries[i].socclk_mhz =
+		find_max_clk_value(clock_table->SocClocks, NUM_SOCCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dispclk_mhz =
+		find_max_clk_value(clock_table->DispClocks, NUM_DISPCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].dppclk_mhz =
+		find_max_clk_value(clock_table->DppClocks, NUM_DPPCLK_DPM_LEVELS);
+	bw_params->clk_table.entries[i].fclk_mhz =
+		find_max_clk_value(clock_table->FclkClocks_Freq, NUM_FCLK_DPM_LEVELS);
+	ASSERT(clock_table->DcfClocks[i] == find_max_clk_value(clock_table->DcfClocks, NUM_DCFCLK_DPM_LEVELS));
+	bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
+	bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+	bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
+	bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels = clock_table->NumDcfClkLevelsEnabled;
+	bw_params->clk_table.num_entries_per_clk.num_dispclk_levels = clock_table->NumDispClkLevelsEnabled;
+	bw_params->clk_table.num_entries_per_clk.num_dppclk_levels = clock_table->NumDispClkLevelsEnabled;
+	bw_params->clk_table.num_entries_per_clk.num_fclk_levels = clock_table->NumFclkLevelsEnabled;
+	bw_params->clk_table.num_entries_per_clk.num_memclk_levels = clock_table->NumMemPstatesEnabled;
+	bw_params->clk_table.num_entries_per_clk.num_socclk_levels = clock_table->NumSocClkLevelsEnabled;
+	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
+		if (!bw_params->clk_table.entries[i].fclk_mhz) {
+			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
+			bw_params->clk_table.entries[i].memclk_mhz = def_max.memclk_mhz;
+			bw_params->clk_table.entries[i].voltage = def_max.voltage;
+		}
+		if (!bw_params->clk_table.entries[i].dcfclk_mhz)
+			bw_params->clk_table.entries[i].dcfclk_mhz = def_max.dcfclk_mhz;
+		if (!bw_params->clk_table.entries[i].socclk_mhz)
+			bw_params->clk_table.entries[i].socclk_mhz = def_max.socclk_mhz;
+		if (!bw_params->clk_table.entries[i].dispclk_mhz)
+			bw_params->clk_table.entries[i].dispclk_mhz = def_max.dispclk_mhz;
+		if (!bw_params->clk_table.entries[i].dppclk_mhz)
+			bw_params->clk_table.entries[i].dppclk_mhz = def_max.dppclk_mhz;
+		if (!bw_params->clk_table.entries[i].fclk_mhz)
+			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
+		if (!bw_params->clk_table.entries[i].phyclk_mhz)
+			bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
+		if (!bw_params->clk_table.entries[i].phyclk_d18_mhz)
+			bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
+			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
+	}
+	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
+	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 	bw_params->num_channels = bios_info->ma_channel_number ? bios_info->ma_channel_number : 4;
 
 	for (i = 0; i < WM_SET_COUNT; i++) {
@@ -938,10 +1008,10 @@ void dcn35_clk_mgr_construct(
 	}
 	ASSERT(clk_mgr->smu_wm_set.wm_set);
 
-	smu_dpm_clks.dpm_clks = (DpmClocks_t *)dm_helpers_allocate_gpu_mem(
+	smu_dpm_clks.dpm_clks = (DpmClocks_t_dcn35 *)dm_helpers_allocate_gpu_mem(
 				clk_mgr->base.base.ctx,
 				DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
-				sizeof(DpmClocks_t),
+				sizeof(DpmClocks_t_dcn35),
 				&smu_dpm_clks.mc_address.quad_part);
 
 	if (smu_dpm_clks.dpm_clks == NULL) {
@@ -988,14 +1058,16 @@ void dcn35_clk_mgr_construct(
 				   "NumDispClkLevelsEnabled: %d\n"
 				   "NumSocClkLevelsEnabled: %d\n"
 				   "VcnClkLevelsEnabled: %d\n"
-				   "NumDfPst atesEnabled: %d\n"
+				   "FClkLevelsEnabled: %d\n"
+				   "NumMemPstatesEnabled: %d\n"
 				   "MinGfxClk: %d\n"
 				   "MaxGfxClk: %d\n",
 				   smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled,
 				   smu_dpm_clks.dpm_clks->NumDispClkLevelsEnabled,
 				   smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled,
 				   smu_dpm_clks.dpm_clks->VcnClkLevelsEnabled,
-				   smu_dpm_clks.dpm_clks->NumDfPstatesEnabled,
+				   smu_dpm_clks.dpm_clks->NumFclkLevelsEnabled,
+				   smu_dpm_clks.dpm_clks->NumMemPstatesEnabled,
 				   smu_dpm_clks.dpm_clks->MinGfxClk,
 				   smu_dpm_clks.dpm_clks->MaxGfxClk);
 		for (i = 0; i < smu_dpm_clks.dpm_clks->NumDcfClkLevelsEnabled; i++) {
@@ -1011,17 +1083,23 @@ void dcn35_clk_mgr_construct(
 			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocClocks[%d] = %d\n",
 					   i, smu_dpm_clks.dpm_clks->SocClocks[i]);
 		}
-		for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++)
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumFclkLevelsEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->FclkClocks_Freq[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->FclkClocks_Freq[i]);
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks->FclkClocks_Voltage[%d] = %d\n",
+					   i, smu_dpm_clks.dpm_clks->FclkClocks_Voltage[i]);
+		}
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumSocClkLevelsEnabled; i++)
 			DC_LOG_SMU("smu_dpm_clks.dpm_clks->SocVoltage[%d] = %d\n",
 					   i, smu_dpm_clks.dpm_clks->SocVoltage[i]);
 
-		for (i = 0; i < NUM_DF_PSTATE_LEVELS; i++) {
-			DC_LOG_SMU("smu_dpm_clks.dpm_clks.DfPstateTable[%d].FClk = %d\n"
-					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].MemClk= %d\n"
-					   "smu_dpm_clks.dpm_clks->DfPstateTable[%d].Voltage = %d\n",
-					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].FClk,
-					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].MemClk,
-					   i, smu_dpm_clks.dpm_clks->DfPstateTable[i].Voltage);
+		for (i = 0; i < smu_dpm_clks.dpm_clks->NumMemPstatesEnabled; i++) {
+			DC_LOG_SMU("smu_dpm_clks.dpm_clks.MemPstateTable[%d].UClk = %d\n"
+					   "smu_dpm_clks.dpm_clks->MemPstateTable[%d].MemClk= %d\n"
+					   "smu_dpm_clks.dpm_clks->MemPstateTable[%d].Voltage = %d\n",
+					   i, smu_dpm_clks.dpm_clks->MemPstateTable[i].UClk,
+					   i, smu_dpm_clks.dpm_clks->MemPstateTable[i].MemClk,
+					   i, smu_dpm_clks.dpm_clks->MemPstateTable[i].Voltage);
 		}
 
 		if (ctx->dc_bios && ctx->dc_bios->integrated_info && ctx->dc->config.use_default_clock_table == false) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 8fb65a49351b..2b8e6959a03d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -79,7 +79,9 @@ typedef struct {
 #define NUM_SOCCLK_DPM_LEVELS   8
 #define NUM_VCN_DPM_LEVELS      8
 #define NUM_SOC_VOLTAGE_LEVELS  8
-#define NUM_DF_PSTATE_LEVELS    4
+#define NUM_VPE_DPM_LEVELS        8
+#define NUM_FCLK_DPM_LEVELS       8
+#define NUM_MEM_PSTATE_LEVELS     4
 
 typedef enum{
   WCK_RATIO_1_1 = 0,  // DDR5, Wck:ck is always 1:1;
@@ -89,12 +91,12 @@ typedef enum{
 } WCK_RATIO_e;
 
 typedef struct {
-  uint32_t FClk;
+  uint32_t UClk;
   uint32_t MemClk;
   uint32_t Voltage;
   uint8_t  WckRatio;
   uint8_t  Spare[3];
-} DfPstateTable_t;
+} MemPstateTable_t;
 
 //Freq in MHz
 //Voltage in milli volts with 2 fractional bits
@@ -105,19 +107,37 @@ typedef struct {
   uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
   uint32_t VClocks[NUM_VCN_DPM_LEVELS];
   uint32_t DClocks[NUM_VCN_DPM_LEVELS];
+  uint32_t VPEClocks[NUM_VPE_DPM_LEVELS];
+  uint32_t FclkClocks_Freq[NUM_FCLK_DPM_LEVELS];
+  uint32_t FclkClocks_Voltage[NUM_FCLK_DPM_LEVELS];
   uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
-  DfPstateTable_t DfPstateTable[NUM_DF_PSTATE_LEVELS];
+  MemPstateTable_t MemPstateTable[NUM_MEM_PSTATE_LEVELS];
 
   uint8_t  NumDcfClkLevelsEnabled;
   uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
   uint8_t  NumSocClkLevelsEnabled;
   uint8_t  VcnClkLevelsEnabled;     //Applies to both Vclk and Dclk
-  uint8_t  NumDfPstatesEnabled;
-  uint8_t  spare[3];
+  uint8_t  VpeClkLevelsEnabled;
+  uint8_t  NumMemPstatesEnabled;
+  uint8_t  NumFclkLevelsEnabled;
+  uint8_t  spare[2];
 
   uint32_t MinGfxClk;
   uint32_t MaxGfxClk;
-} DpmClocks_t;
+} DpmClocks_t_dcn35;
+
+
+// Throttler Status Bitmask
+
+
+
+
+
+
+
+
+
+
 
 #define TABLE_BIOS_IF            0 // Called by BIOS
 #define TABLE_WATERMARKS         1 // Called by DAL through VBIOS
@@ -139,7 +159,7 @@ struct dcn35_watermarks {
 };
 
 struct dcn35_smu_dpm_clks {
-	DpmClocks_t *dpm_clks;
+	DpmClocks_t_dcn35 *dpm_clks;
 	union large_integer mc_address;
 };
 
-- 
2.25.1


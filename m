Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E37C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D3310EE14;
	Wed,  2 Sep 2026 05:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LmBTuTjt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6C910EE14
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf6B/ZFZk4XMKx8Me6W1wR8Voa2NSr0VxyfB07GoYS79jC28zDCPFca+ceWZj2U3VB/QOFPzfcj/YFikfJz1lT4TbQ0Re3FEReMOnpwbuVHw1uSbc+lk94C1M4D/N8wnLVkJpKD+XhVf5jSDBHP3+SVsJBjP+fsy0F75xbtnLL+qkwKwocFwWEVHoHo26kMWZiLKDp5gY/I1QIlkee2KDMQsfrO1q7zulpf3VvhR2FEMsM8yp5uyYjoIvay832d2c6j4Gc9EyxX8r8nQrRFxfmE6djsSVol1JglzZ8s9L/R7HO9UVmlhbfiTrTBKO3JlCVuW0uZKbRyMbWBFbSuOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMnVz9My50M3FmaixZ1Tt2DB75K9b6ZMyT2OMTUggwg=;
 b=irdo6aJta8Qbs3jQxXOv3+8OqnZiImqGJvOH1a3zpVeLiuaySwAeMf6lhzHlubUaR62DDncogUizCYOnBixf4NWbEKXpr84pAWgZ9QcPTngktZUPSLHa3cTNd0vXHFVCSAsNRCZ2s77jvUsNFWmCgd/hC/kL4IJeFWCfPixLiQh92e+tQJVnmYYGTiIbo7TnFkillfzzoz86i8odnfyozv1A70ZRU0JpA9uISy4/spFCF09YbY47Djz24BqHn4yFNBSJJec19Ae9f0ZLlKGhO0h08cRIjRy/5aF3cvm4wyDJ96ZpW5r1LGfqNCNDGKUc15Ivb+2RmOljGDkcp9FFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMnVz9My50M3FmaixZ1Tt2DB75K9b6ZMyT2OMTUggwg=;
 b=LmBTuTjtOp6CktA+s1dTEQUpKoV/wNLByudZ6PMSo33SlkW9jGDoupkWmbKSllOyLAgXsRZzRSqFeMrDT51T5Kj0mozjNwTzXuJuQPJNyM6St+k6XY+KhiiCGucyjrorW406kzZsfHLjGY+JnZ12aj7mCp7OI+vWXq9iXpzIq6M=
Received: from CH5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:1f4::6)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:06:56 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::14) by CH5PR04CA0001.outlook.office365.com
 (2603:10b6:610:1f4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:06:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:55 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:06:47 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 17/40] drm/amd/display: Add override capability for UTM table
 params
Date: Wed, 2 Sep 2026 12:58:39 +0800
Message-ID: <20260902050411.3473916-18-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a7ff3c-b996-408f-2cf9-08df08b002ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|3023799007|10067099003|56012099006|22082099003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: jcbwB1J5A+G2GpF/DZYhU3McjMe/NW3Pq3F5IiJufj+0MozjdGbpvMJ5D3pFvsKz5+4A01ew+hZX2pOqXPC3z1gPkFK1KHrC0MWfY51cLL74+71MLu8Q9QatY1BSBmlEoK38ss46ZDkROw2myGcibUd6+teB1DyJtmJKAHTtcyAcis83xp4JFPgScrmL6kkIN6zSIWrNeahUAxAQdZC3RTn+3boPL7JLwj2P1w9pyPxS0jv+acTAzLqkSCi5L9ivPp8MKXALehpZ1g0QLzw8BoO/+vZTHy735ramV+XhrmGhE3z0W7DlKBIMZPfQkp7OsR7ppL9KuGiMwyAeLAgSCgc0ZOgPmgTW7Yrn4TzAgGTDChSGO8SoMDHhqdSvHxQYwo+XIQX5njHa10YFd+iv5riPSWwiWIgC7pOlcQzv0tUJJ2f0RQbPbt6XLxBkLuQNWcmxXOsGFOLxO8D4/2H2Vx/RmyHHHIPV/8FsMmGkd/Uo1V/c74UYYsTnS0uGhcLoRkmdQmO0EYWWMU7+mxPnwOOZtc4xynBtcxOu4ymP9/X/jAK+y8GhY6bNSfdL2N0V+8P7gYPOsbUpwuJOfcJa9ouUPo8dYO8h9AvM/k4mC+teUg9IlZR8MHAWYueIQ9KLx2J/4k3xf3+xiS7NhIkyIOeqK92bhwijwZm968mpsmDp9eD1LKEW+d/YpcZSp3mZyGP/kvBaZ/ArjbIS3BteiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(3023799007)(10067099003)(56012099006)(22082099003)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BrZ+wFQamd/NG6hOpw7/OUxQJOAI4s7X5PZX9LNFF7+nNIxtNI44M9i4eST1bA/ckaS4fHBWUaeFBqNYiR9IcaCdoeIhDI7w7mYCwXLvjEOODdmVZdPoEnmT5FWv+dItBeztkiQh9yDhAkvmLvqz66xQEA/Tyt7kgae7sOy9YzP0nzR8Cookz9AW/WMRlbJClWNThPGnCa8JK5tZ8Cq4UC11/DHWPxR3psSb/vNMGp4umWnlZpgR84WLzzHClMxwP8ZN4sjkLcIvL0JhUXgh3hJawgU8At3cZ6R2BxUJ15s8WEnfViuK1iAteMChe2sNQdzVc8cdEaARLf0NvnV1m/VfZFURTaR3v5vWgPpPN8hkPkEFnlZROygG2ShqBcFzl848dKaqBJxNCNgXph9JqEF1986bDOyXYXQdopf25TQ3cv85hCkldSEjQlyO6sUU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:06:56.3829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a7ff3c-b996-408f-2cf9-08df08b002ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
Add calls for overriding UTM table params from PMFW. This is for
debug and test purposes only when PMFW has not yet populated the table
values correctly.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |  2 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 70 +++++++++++++++++--
 .../dc/clk_mgr/dcn60/dcn60_smu_driver_if.h    | 44 ++++++------
 3 files changed, 88 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
index 6954a54dad89..9b109959bd7f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
@@ -112,7 +112,7 @@ typedef struct {
  * TABLE_DAL_INIT - Full TABLE_DAL_INIT payload transferred from SMU to DRAM.
  */
 #define TABLE_DAL_INIT    0xD
-#define MAX_PPCLK_COUNT   20
+#define MAX_PPCLK_COUNT   22
 #define DPM_CLOCK_OFFSET(Ppclk) \
 	(sizeof(DalInitHeader_t) + (Ppclk) * sizeof(DpmClock_t))
 #define UTM_TABLE_OFFSET \
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 83989b4b1fdd..2b7740b82161 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -479,6 +479,39 @@ static int dcn60_get_dtb_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 	return dtb_ref_clk_khz;
 }
 
+/**
+ * dcn60_override_dc_mode_limit - Override DC mode limits from the clock table.
+ * @dc_limit: output DC mode limit to populate
+ * @clk_table: clock table already populated (and possibly overridden)
+ *
+ * Sets the DC mode max frequency for each clock to the highest populated DPM
+ * level in the clock table. Deriving the limit from the clock table (rather
+ * than the raw DAL init table) ensures any overrides applied to the clock
+ * levels are respected.
+ */
+static void dcn60_override_dc_mode_limit(
+		struct clk_limit_table_entry *dc_limit,
+		const struct clk_limit_table *clk_table)
+{
+	const struct clk_limit_table_entry *entries = clk_table->entries;
+	const struct clk_limit_num_entries *num_entries = &clk_table->num_entries_per_clk;
+
+	dc_limit->dcfclk_mhz  = num_entries->num_dcfclk_levels ?
+			entries[num_entries->num_dcfclk_levels - 1].dcfclk_mhz : 0;
+	dc_limit->socclk_mhz  = num_entries->num_socclk_levels ?
+			entries[num_entries->num_socclk_levels - 1].socclk_mhz : 0;
+	dc_limit->dtbclk_mhz  = num_entries->num_dtbclk_levels ?
+			entries[num_entries->num_dtbclk_levels - 1].dtbclk_mhz : 0;
+	dc_limit->dispclk_mhz = num_entries->num_dispclk_levels ?
+			entries[num_entries->num_dispclk_levels - 1].dispclk_mhz : 0;
+	dc_limit->dppclk_mhz  = num_entries->num_dppclk_levels ?
+			entries[num_entries->num_dppclk_levels - 1].dppclk_mhz : 0;
+	dc_limit->memclk_mhz  = num_entries->num_memclk_levels ?
+			entries[num_entries->num_memclk_levels - 1].memclk_mhz : 0;
+	dc_limit->fclk_mhz    = num_entries->num_fclk_levels ?
+			entries[num_entries->num_fclk_levels - 1].fclk_mhz : 0;
+}
+
 static unsigned int dcn60_get_dc_mode_limit_mhz(const DpmClock_t *dpm_clk)
 {
 	if (dpm_clk->NumClocks
@@ -495,8 +528,10 @@ static unsigned int dcn60_get_dc_mode_limit_mhz(const DpmClock_t *dpm_clk)
  *
  * Sets the DC mode max frequency for each clock. If DcMaxClock equals the
  * highest DPM level, the limit is set to 0 (no DC-specific cap).
+ *
+ * Temporarily unused.
  */
-static void dcn60_populate_dc_mode_limit(
+static void __maybe_unused dcn60_populate_dc_mode_limit(
 		struct clk_limit_table_entry *dc_limit,
 		const DalInitTable_t *init_table)
 {
@@ -578,6 +613,20 @@ static void dcn60_populate_clk_table(struct clk_mgr_internal *clk_mgr,
 		clk_table->num_entries = 1;
 }
 
+/**
+ * dcn60_override_clk_table - Override the clock table with hardcoded values.
+ * @clk_table: clock table to override
+ *
+ * Temporary debug/bring-up override that replaces the DPM clock levels
+ * populated from the DAL init table (see dcn60_populate_clk_table) with a
+ * fixed set of hardcoded values. Implement any override as needed.
+ */
+static void dcn60_override_clk_table(struct clk_limit_table *clk_table)
+{
+	/* Override as needed */
+	(void)clk_table;
+}
+
 static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 		struct clk_bw_params *bw_params)
 {
@@ -605,12 +654,17 @@ static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 
 	bw_params->dc_mode_softmax_memclk = bw_params->dc_mode_limit.memclk_mhz;
 
-	/* The qos model stores dchub_v3 as a const view of a mutable table, so
-	 * cast away const to apply the override.
-	 */
-	if (bw_params->utm_qos_model && bw_params->utm_qos_model->dchub_v3)
+	/* Override as needed - temporary for debug only. */
+	if (bw_params->utm_qos_model && bw_params->utm_qos_model->dchub_v3) {
+		dcn6_test_initialize_utm_qos_model_v3(
+				(struct utm_qos_model *)bw_params->utm_qos_model,
+				(struct utm_qos_model_dchub_v3 *)bw_params->utm_qos_model->dchub_v3);
+
+		// Override for lsdma here is redundant with the above call, but this may need to outlive
+		// the test_initialize call for debug purposes so keep it here for now.
 		dcn6_test_override_lsdma_bandwidth_v3(
 				(struct utm_qos_model_dchub_v3 *)bw_params->utm_qos_model->dchub_v3);
+	}
 }
 
 /**
@@ -685,7 +739,9 @@ static bool dcn60_fetch_dal_init_table(struct clk_mgr_internal *clk_mgr)
 	clk_mgr->smu_ver = init_table->Header.SmuVersion;
 
 	dcn60_populate_clk_table(clk_mgr, &bw_params->clk_table, init_table);
-	dcn60_populate_dc_mode_limit(&bw_params->dc_mode_limit, init_table);
+	// Comment out for now - DC mode limit is not yet used in DCN6 and the current
+	// population from init table will cause undefined behaviors.
+	//dcn60_populate_dc_mode_limit(&bw_params->dc_mode_limit, init_table);
 
 	bw_params->num_channels = init_table->MemoryConfig.NumUmcChannels;
 	bw_params->dram_channel_width_bytes =
@@ -694,6 +750,8 @@ static bool dcn60_fetch_dal_init_table(struct clk_mgr_internal *clk_mgr)
 	dcn60_populate_utm_qos_model(clk_mgr, &bw_params->utm_qos_model, init_table);
 
 	dcn60_override_bw_params(clk_mgr, bw_params);
+	dcn60_override_clk_table(&bw_params->clk_table);
+	dcn60_override_dc_mode_limit(&bw_params->dc_mode_limit, &bw_params->clk_table);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h
index 3e101fa87cfd..ca23518d88b9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h
@@ -9,27 +9,29 @@
 //Only Clks that have DPM descriptors are listed here
 // This should be the same order as DPM_e
 typedef enum {
-  PPCLK_GFXCLK = 0,
-  PPCLK_BTNCLK = 1,
-  PPCLK_LCLK = 2,
-  PPCLK_UCLK = 3,
-  PPCLK_FCLK = 4,
-  PPCLK_G7FCLK = 5,
-  PPCLK_SOCCLK = 6,
-  PPCLK_ACLK = 7,
-  PPCLK_DCFCLK = 8,
-  PPCLK_VPECLK = 9,
-  PPCLK_DISPCLK = 10,
-  PPCLK_DPPCLK = 11,
-  PPCLK_DPREFCLK = 12,
-  PPCLK_CFPUCLK = 13,
-  PPCLK_LOGANCLK = 14,
-  PPCLK_MSPCLK = 15,
-  PPCLK_MOVADCLK = 16,
-  PPCLK_DTBCLK = 17,
-  PPCLK_DCLK_0 = 18,
-  PPCLK_VCLK_0 = 19,
-  PPCLK_COUNT = 20,
+	PPCLK_GFXCLK = 0,
+	PPCLK_NVECLK1,
+	PPCLK_NVECLK2,
+	PPCLK_NVECLK3,
+	PPCLK_LCLK,
+	PPCLK_UCLK,
+	PPCLK_FCLK,
+	PPCLK_G7FCLK,
+	PPCLK_SOCCLK,
+	PPCLK_ACLK,
+	PPCLK_DCFCLK,
+	PPCLK_VPECLK,
+	PPCLK_DISPCLK,
+	PPCLK_DPPCLK,
+	PPCLK_DPREFCLK,
+	PPCLK_CFPUCLK,
+	PPCLK_LOGANCLK,
+	PPCLK_MSPHCLK,
+	PPCLK_MSPLCLK,
+	PPCLK_MSPEDECLK,
+	PPCLK_MOVADCLK,
+	PPCLK_DTBCLK,
+	PPCLK_COUNT,
 } PPCLK_e;
 
 typedef struct {
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3633FA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5193A10E6A0;
	Wed, 15 Apr 2026 07:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fpyqFl1H";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013037.outbound.protection.outlook.com
 [40.93.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF9C10E69E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6EHffbTUQPTBxvlraC7Hn3rBsmiN7eUStbr+1SHr5HRWmFdsfNrWBEJVxmnFArt59JwYRVEffeKuoKmWE5Szo3sEeSGBqUhOWl7rL3L5G9ubTI1GDm8pykDVSADFnuDPosmpVE8GjYCK1uIIktjA7fZJ1Adiz0ggYotnZ2bup8yq0kEppCHHx9hk7zq7/BAwGj7uZPIM30V9CCgU+1eDaAwKVUy2xYzEKZTN5z1SsAIWFRNXaj75avn7ii/lnjqJ7R3NjtGdhXI7nKqq0k9Cmf5QWuOjhr2uRnwPStSMlg2oNmNON80YW4FouNoyCtCg8TT1x4qdlsU3XgfoePRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/+fOdIS3t90VTRZAeNRCthC24mhk6h+7NYKyfVeXXo=;
 b=uMla27PM99GKKlw11eGy2or5qF8uqPMCkuiEx1NKPOoBiT8qrkdeyq50F9bGzRCjV1fy+q4bgpZx4r4JquIH6RJRuJ9kgoGOucGFE3nQx8KHFsUAcx0oconCrfxAmq9R1n4Ro5AZPt+9q1NE6uDo7BsRvoBg/ycrf8ukPgRRY0X9CsxpEuJSr3SQ/yP7DnJhCZtHNOSPHeplBHt5xum2o9Hs0sUK+54IPM4xXKjyR/nCHbjgCoH1vuVb6vRj4REvcX7O05s1tZkZ7V/VDTG/lF5r6PXJVejmOTXLu6McV+RSL9S+7p6zd/nBK8vkXQrFmDlgOCUaGUwdMvB1CukT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/+fOdIS3t90VTRZAeNRCthC24mhk6h+7NYKyfVeXXo=;
 b=fpyqFl1HQonqo/vtg6C2an54vMIIqauVKPQp1551fkyNTgEdm/aqBdmOz5D20KE2Lbggj6VhYM19TFBb005PhAjym3uGcKNVcGFYY5ChQZtzvSEhG4ij7MsV644Y3n7bVeXidD3ygnYAFc4JbD9npOF1QbFy/RddTpWFTm66xD0=
Received: from DS7PR03CA0347.namprd03.prod.outlook.com (2603:10b6:8:55::6) by
 PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:44:09 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::91) by DS7PR03CA0347.outlook.office365.com
 (2603:10b6:8:55::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:08 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:44:04 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Gaghik
 Khachatrian" <gaghik.khachatrian@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 14/19] drm/amd/display: Fix narrowing boundaries and eDP
 parser assignment
Date: Wed, 15 Apr 2026 15:39:53 +0800
Message-ID: <20260415074223.34848-15-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e98ffc-ef38-4e72-5c3f-08de9ac2c76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q9tn+DJ9hmK3dalJ9WcCq9W6PBZnt3hlLVWI36zHeTBErNPYAx3rwYBiapmVHl6CREDLUyLHzzKxP+21Gr3KbTzYECUXdmzKhT6uQOmE2wgHVQ5w5u3mnFbB8o/xzWLJCSfOgkn8GwpNXMyovCcJErgA0l1J0zlNOWjs/5MN3CfQNryEfMXmGv9cr7dBT3aCG88ZRpU6aINrMi4xB0kvf4RkPm9XhVzWBW88gWqnscSRfvyGC7VLApVR69XUBkZThSFdtnrIhWvtNHjNI9TAOyenme9q5X5h560JBKyjVgjm3Redal0XlLrnerOFGnRvW8KvbTssh+5fDRtJw2GDfgMt9xT0arwtqemIDPzU/5yW7PTJbBl6JWdzne2bWLFMXM40mU1fMmwzkW2RLLacnCir0Gm3t6rNtUy/F9JZUTlva2RSsMxETGzeRLCVSf6GfWqhnxRsgyGtGK85kbsb3XiLM3hrAc5FdNCCEVrHiAvsJm7ucIzD7NvJ9VqbSU2fENgf8avGusV3RrMmWE992DmIwz3RH3EDUYZhMeN9gcCaYTQxZ3MNd0Hz625wcSD/+px5fIIva7QdHHj6nTDctfMbxr54Rt2nYindXrdkutXjLTcD2kwUd8s6xwEqZ0dYE6+eIDG3fxE90hO1P4Yn2+1z2SyO+txW7z6WFxvLOJm76eiEAifIW3FhN2R5voGPoNmyM9tMXeMF9Z1bO/ThizyPIMRfvmbmOuXnYyEs06fm5K37NiTTj2Bc2J2nofgpAqPk+PjssrLAjTnrGJojcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uA+ijof67gQJamgQzqxRBBFD1RNxWNZyL5EtNTchxsnfiXtyCZGqwKtDdtDVm2+11CW6BFkxyNSSNwc2lIS093v71mHI7opObdIMvwVw1dOptqGfpuF4iG76kH7TYjfmUogmVnjgUK2poMtwRoTCOpT5Lb1Q0AdlOHKEe6mnWklS0ypV7P/qg3UIb6aVmBM4oeCC5cuuU8WBGZiSCv1IIep2NgQhYzRHt4yANFpENzlxsXj90mgywbNOrb//4FFg633Y40HUX4QZqnkVroCGu3i9X8hE5JeGld8nbbw0aUM14oXM54Nbafl1h77r/ME+rmicxFlFMFPZNHyjFKwzI4i9bwo9DBuuu0fVxNvLxwkFnWEOPHBlLFEmRq2updC+gsiWfUcjwYDbSMqum0fiMSbduKcdx/eMxz9EZoy+DtYItt7xOtDXzmlOGA+bCU0E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:09.2725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e98ffc-ef38-4e72-5c3f-08de9ac2c76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why] drm/amd/display had implicit integer narrowing at protocol/storage boundaries
and an incomplete eDP assignment in integrated info parsing.

[How] Apply explicit boundary casts for intentional narrowing, keep intermediate math
in wider types, and restore explicit eDP field mapping in v2.2 parser.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c   |  1 +
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c    |  3 ++-
 .../amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c   |  2 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c |  2 +-
 .../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c   |  2 +-
 .../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c   |  2 +-
 .../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c   |  2 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c |  2 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c    | 14 +++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c     |  7 ++++---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c  | 16 ++++++++--------
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c |  4 ++--
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c |  3 ++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c    |  4 ++--
 .../display/dc/irq/dce110/irq_service_dce110.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c  | 10 +++++-----
 .../amd/display/dc/link/protocols/link_dp_dpia.c |  2 +-
 .../display/dc/link/protocols/link_dp_dpia_bw.c  |  6 +++---
 .../dc/link/protocols/link_dp_panel_replay.c     |  4 ++--
 .../dc/resource/dcn32/dcn32_resource_helpers.c   |  2 +-
 .../dcn401/dcn401_soc_and_ip_translator.c        | 14 +++++++-------
 .../display/modules/info_packet/info_packet.c    |  2 +-
 .../amd/display/modules/power/power_helpers.c    | 16 ++++++++--------
 24 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index dd45cc170fc7..b4dd8219b8f0 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2977,6 +2977,7 @@ static enum bp_result get_integrated_info_v2_2(
 	info->edp1_info.edp_panel_bpc =
 		info_v2_2->edp1_info.edp_panel_bpc;
 	info->edp1_info.edp_bootup_bl_level =
+		info_v2_2->edp1_info.edp_bootup_bl_level;
 
 	info->edp2_info.edp_backlight_pwm_hz =
 	le16_to_cpu(info_v2_2->edp2_info.edp_backlight_pwm_hz);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 79eb5ae8ec6f..df06e5cd27aa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -476,7 +476,8 @@ static void build_watermark_ranges(struct clk_bw_params *bw_params, struct pp_sm
 				ranges->reader_wm_sets[num_valid_sets].min_drain_clk_mhz = 0;
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
-				ranges->reader_wm_sets[num_valid_sets].min_drain_clk_mhz = bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+				ranges->reader_wm_sets[num_valid_sets].min_drain_clk_mhz =
+					(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			ranges->reader_wm_sets[num_valid_sets].max_drain_clk_mhz =
 				(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index caa15cfba7c3..70f6f0913f13 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -409,7 +409,7 @@ static void vg_build_watermark_ranges(struct clk_bw_params *bw_params, struct wa
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
 				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
-						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+						(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
 					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 1d94c4bae9de..68a121dbb489 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -447,7 +447,7 @@ static void dcn31_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
 				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
-						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+						(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
 					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 1814ec248dab..0d5892266112 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -518,7 +518,7 @@ static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
 				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
-						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+						(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
 					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 382e1b891c47..ef184f28e426 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -408,7 +408,7 @@ static void dcn315_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
 				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
-						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+						(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
 					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index a162a453447c..aa8f2a5edc21 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -374,7 +374,7 @@ static void dcn316_build_watermark_ranges(struct clk_bw_params *bw_params, struc
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
 				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
-						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+						(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
 					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 688a4bdc20b5..ddcde2433211 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -886,7 +886,7 @@ static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
 				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
-						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+						(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
 					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index e39fd97b3ffd..a0cdaf69056e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -657,7 +657,7 @@ void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_
 			else {
 				/* add 1 to make it non-overlapping with next lvl */
 				table->WatermarkRow[WM_DCFCLK][num_valid_sets].MinMclk =
-						bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1;
+						(uint16_t)(bw_params->clk_table.entries[i - 1].dcfclk_mhz + 1);
 			}
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxMclk =
 					(uint16_t)bw_params->clk_table.entries[i].dcfclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 20600455ff63..19526a278b2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4724,10 +4724,10 @@ static void set_avi_info_frame(
 	 * barLeft:   Pixel Number of End of Left Bar.
 	 * barRight:  Pixel Number of Start of Right Bar. */
 	hdmi_info.bits.bar_top = (uint16_t)stream->timing.v_border_top;
-	hdmi_info.bits.bar_bottom = (stream->timing.v_total
+	hdmi_info.bits.bar_bottom = (uint16_t)(stream->timing.v_total
 			- stream->timing.v_border_bottom + 1);
 	hdmi_info.bits.bar_left  = (uint16_t)stream->timing.h_border_left;
-	hdmi_info.bits.bar_right = (stream->timing.h_total
+	hdmi_info.bits.bar_right = (uint16_t)(stream->timing.h_total
 			- stream->timing.h_border_right + 1);
 
     /* Additional Colorimetry Extension
@@ -5363,7 +5363,7 @@ bool get_temp_dp_link_res(struct dc_link *link,
 void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 		struct dc_state *context)
 {
-	int i, j;
+	uint8_t i, j;
 	struct pipe_ctx *pipe_ctx_old, *pipe_ctx, *pipe_ctx_syncd;
 
 	/* If pipe backend is reset, need to reset pipe syncd status */
@@ -5426,7 +5426,7 @@ void reset_sync_context_for_pipe(const struct dc *dc,
 	struct dc_state *context,
 	uint8_t pipe_idx)
 {
-	int i;
+	uint8_t i;
 	struct pipe_ctx *pipe_ctx_reset;
 
 	/* reset the otg sync context for the pipe and its slave pipes if any */
@@ -5442,7 +5442,7 @@ void reset_sync_context_for_pipe(const struct dc *dc,
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter)
 {
 	/* TODO - get transmitter to phy idx mapping from DMUB */
-	uint8_t phy_idx = transmitter - TRANSMITTER_UNIPHY_A;
+	uint8_t phy_idx = (uint8_t)(transmitter - TRANSMITTER_UNIPHY_A);
 
 	if (dc->ctx->dce_version == DCN_VERSION_3_1 &&
 			dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
@@ -5509,8 +5509,8 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 bool is_h_timing_divisible_by_2(struct dc_stream_state *stream)
 {
 	bool divisible = false;
-	uint16_t h_blank_start = 0;
-	uint16_t h_blank_end = 0;
+	uint32_t h_blank_start = 0;
+	uint32_t h_blank_end = 0;
 
 	if (stream) {
 		h_blank_start = stream->timing.h_total - stream->timing.h_front_porch;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 317c69719313..0dd6d1463137 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -697,7 +697,8 @@ static void populate_subvp_cmd_vblank_pipe_info(struct dc *dc,
 	pipe_data->pipe_config.vblank_data.vblank_pipe_index = vblank_pipe->pipe_idx;
 	pipe_data->pipe_config.vblank_data.vstartup_start = (uint16_t)vblank_pipe->pipe_dlg_param.vstartup_start;
 	pipe_data->pipe_config.vblank_data.vblank_end =
-			vblank_pipe->stream->timing.v_total - vblank_pipe->stream->timing.v_front_porch - vblank_pipe->stream->timing.v_addressable;
+			(uint16_t)(vblank_pipe->stream->timing.v_total -
+			vblank_pipe->stream->timing.v_front_porch - vblank_pipe->stream->timing.v_addressable);
 
 	if (vblank_pipe->stream->ignore_msa_timing_param &&
 		(vblank_pipe->stream->allow_freesync || vblank_pipe->stream->vrr_active_variable || vblank_pipe->stream->vrr_active_fixed))
@@ -831,7 +832,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	// Prefetch lines is equal to VACTIVE + BP + VSYNC
 	pipe_data->pipe_config.subvp_data.prefetch_lines =
-			phantom_timing->v_total - phantom_timing->v_front_porch;
+			(uint16_t)(phantom_timing->v_total - phantom_timing->v_front_porch);
 
 	// Round up
 	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
@@ -1811,7 +1812,7 @@ static void dc_dmub_srv_rb_based_fams2_update_config(struct dc *dc,
 		struct dc_state *context,
 		bool enable)
 {
-	uint8_t num_cmds = 1;
+	uint32_t num_cmds = 1;
 	uint32_t i;
 	union dmub_rb_cmd cmd[2 * MAX_STREAMS + 1];
 	struct dmub_rb_cmd_fams2 *global_cmd = &cmd[0].fams2_config;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
index 52e05b9185f1..e64b3b6bff5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
@@ -75,7 +75,7 @@ static void release_engine_dce_sw(
 static bool wait_for_scl_high_sw(
 	struct dc_context *ctx,
 	struct ddc *ddc,
-	uint16_t clock_delay_div_4)
+	uint32_t clock_delay_div_4)
 {
 	(void)ctx;
 	uint32_t scl_retry = 0;
@@ -97,7 +97,7 @@ static bool wait_for_scl_high_sw(
 static bool write_byte_sw(
 	struct dc_context *ctx,
 	struct ddc *ddc_handle,
-	uint16_t clock_delay_div_4,
+	uint32_t clock_delay_div_4,
 	uint8_t byte)
 {
 	int32_t shift = 7;
@@ -154,7 +154,7 @@ static bool write_byte_sw(
 static bool read_byte_sw(
 	struct dc_context *ctx,
 	struct ddc *ddc_handle,
-	uint16_t clock_delay_div_4,
+	uint32_t clock_delay_div_4,
 	uint8_t *byte,
 	bool more)
 {
@@ -214,7 +214,7 @@ static bool read_byte_sw(
 static bool stop_sync_sw(
 	struct dc_context *ctx,
 	struct ddc *ddc_handle,
-	uint16_t clock_delay_div_4)
+	uint32_t clock_delay_div_4)
 {
 	uint32_t retry = 0;
 
@@ -251,7 +251,7 @@ static bool stop_sync_sw(
 static bool i2c_write_sw(
 	struct dc_context *ctx,
 	struct ddc *ddc_handle,
-	uint16_t clock_delay_div_4,
+	uint32_t clock_delay_div_4,
 	uint8_t address,
 	uint32_t length,
 	const uint8_t *data)
@@ -273,7 +273,7 @@ static bool i2c_write_sw(
 static bool i2c_read_sw(
 	struct dc_context *ctx,
 	struct ddc *ddc_handle,
-	uint16_t clock_delay_div_4,
+	uint32_t clock_delay_div_4,
 	uint8_t address,
 	uint32_t length,
 	uint8_t *data)
@@ -298,7 +298,7 @@ static bool i2c_read_sw(
 static bool start_sync_sw(
 	struct dc_context *ctx,
 	struct ddc *ddc_handle,
-	uint16_t clock_delay_div_4)
+	uint32_t clock_delay_div_4)
 {
 	uint32_t retry = 0;
 
@@ -399,7 +399,7 @@ static void dce_i2c_sw_engine_submit_channel_request(struct dce_i2c_sw *engine,
 						     struct i2c_request_transaction_data *req)
 {
 	struct ddc *ddc = engine->ddc;
-	uint16_t clock_delay_div_4 = engine->clock_delay >> 2;
+	uint32_t clock_delay_div_4 = engine->clock_delay >> 2;
 
 	/* send sync (start / repeated start) */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 9e63d075c1cf..9c326ad1d3b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -415,10 +415,10 @@ bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values
 	dsc_reg_vals->ich_reset_at_eol = (dsc_cfg->is_odm || dsc_reg_vals->num_slices_h > 1) ? 0xF : 0;
 
 	// Need to find the ceiling value for the slice width
-	dsc_reg_vals->pps.slice_width = (dsc_cfg->pic_width + dsc_cfg->dsc_padding + dsc_cfg->dc_dsc_cfg.num_slices_h - 1) / dsc_cfg->dc_dsc_cfg.num_slices_h;
+	dsc_reg_vals->pps.slice_width = (u16)((dsc_cfg->pic_width + dsc_cfg->dsc_padding + dsc_cfg->dc_dsc_cfg.num_slices_h - 1) / dsc_cfg->dc_dsc_cfg.num_slices_h);
 	// TODO: in addition to validating slice height (pic height must be divisible by slice height),
 	// see what happens when the same condition doesn't apply for slice_width/pic_width.
-	dsc_reg_vals->pps.slice_height = dsc_cfg->pic_height / dsc_cfg->dc_dsc_cfg.num_slices_v;
+	dsc_reg_vals->pps.slice_height = (u16)(dsc_cfg->pic_height / dsc_cfg->dc_dsc_cfg.num_slices_v);
 
 	ASSERT(dsc_reg_vals->pps.slice_height * dsc_cfg->dc_dsc_cfg.num_slices_v == dsc_cfg->pic_height);
 	if (!(dsc_reg_vals->pps.slice_height * dsc_cfg->dc_dsc_cfg.num_slices_v == dsc_cfg->pic_height)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index a34031b5c9d5..6c07d9a87bfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -103,7 +103,8 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps,
 	struct drm_dsc_config   dsc_cfg;
 
 	dsc_params->pps = *pps;
-	dsc_params->pps.initial_scale_value = 8 * rc->rc_model_size / (rc->rc_model_size - rc->initial_fullness_offset);
+	dsc_params->pps.initial_scale_value = (u8)(8 * rc->rc_model_size /
+			(rc->rc_model_size - rc->initial_fullness_offset));
 
 	copy_pps_fields(&dsc_cfg, &dsc_params->pps);
 	copy_rc_to_cfg(&dsc_cfg, rc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index f2ac516b685f..7af239524d71 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1443,8 +1443,8 @@ void build_audio_output(
 			(stream->timing.flags.INTERLACE != 0);
 
 	audio_output->crtc_info.refresh_rate =
-		(stream->timing.pix_clk_100hz*100)/
-		(stream->timing.h_total*stream->timing.v_total);
+		(uint16_t)((stream->timing.pix_clk_100hz*100)/
+		(stream->timing.h_total*stream->timing.v_total));
 
 	audio_output->crtc_info.color_depth =
 		stream->timing.display_color_depth;
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 65a98400c486..0ac8a2e8380c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -210,7 +210,7 @@ bool dce110_vblank_set(struct irq_service *irq_service,
 			dc_interrupt_to_irq_source(irq_service->ctx->dc,
 						   info->src_id,
 						   info->ext_id);
-	uint8_t pipe_offset = dal_irq_src - IRQ_TYPE_VBLANK;
+	unsigned int pipe_offset = dal_irq_src - IRQ_TYPE_VBLANK;
 
 	struct timing_generator *tg;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index f7cc419cfbff..e7d3f9bd8aa5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -546,24 +546,24 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	config.dig_fe = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
 
 	/* stream encoder index */
-	config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
+	config.stream_enc_idx = (uint8_t)(pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA);
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		config.stream_enc_idx =
-				pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0;
+				(uint8_t)(pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0);
 
 	/* dig back end */
 	config.dig_be = pipe_ctx->stream->link->link_enc_hw_inst;
 
 	/* link encoder index */
-	config.link_enc_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+	config.link_enc_idx = (uint8_t)(link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	if (dp_is_128b_132b_signal(pipe_ctx))
 		config.link_enc_idx = (uint8_t)pipe_ctx->link_res.hpo_dp_link_enc->inst;
 
 	/* dio output index is dpia index for DPIA endpoint & dcio index by default */
 	if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
-		config.dio_output_idx = pipe_ctx->stream->link->link_id.enum_id - ENUM_ID_1;
+		config.dio_output_idx = (uint8_t)(pipe_ctx->stream->link->link_id.enum_id - ENUM_ID_1);
 	else
-		config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+		config.dio_output_idx = (uint8_t)(link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 
 
 	/* phy index */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index 766b54631c79..da227889e007 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -119,7 +119,7 @@ bool dpia_query_hpd_status(struct dc_link *link)
 	/* prepare QUERY_HPD command */
 	cmd.query_hpd.header.type = DMUB_CMD__QUERY_HPD_STATE;
 	cmd.query_hpd.header.payload_bytes = sizeof(cmd.query_hpd.data);
-	cmd.query_hpd.data.instance = link->link_id.enum_id - ENUM_ID_1;
+	cmd.query_hpd.data.instance = (uint8_t)(link->link_id.enum_id - ENUM_ID_1);
 	cmd.query_hpd.data.ch_type = AUX_CHANNEL_DPIA;
 
 	/* Query dpia hpd status from dmub */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 6406fe890850..d79c18c4903a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -180,7 +180,7 @@ static void dpia_bw_alloc_unplug(struct dc_link *link)
 
 static void link_dpia_send_bw_alloc_request(struct dc_link *link, int req_bw)
 {
-	uint8_t request_reg_val;
+	uint32_t request_reg_val;
 	uint32_t temp, request_bw;
 
 	if (link->dpia_bw_alloc_config.bw_granularity == 0) {
@@ -212,8 +212,8 @@ static void link_dpia_send_bw_alloc_request(struct dc_link *link, int req_bw)
 	link->dpia_bw_alloc_config.allocated_bw = request_bw;
 	DC_LOG_DC("%s:  Link[%d]:  Request BW:  %d", __func__, link->link_index, request_bw);
 
-	core_link_write_dpcd(link, REQUESTED_BW,
-		&request_reg_val,
+	uint8_t requested_bw_dpcd = (uint8_t)request_reg_val;
+	core_link_write_dpcd(link, REQUESTED_BW, &requested_bw_dpcd,
 		sizeof(uint8_t));
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index e1991776c59d..72d6e6011a09 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -328,9 +328,9 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 		link->dpcd_caps.vesa_replay_su_info.pr_su_y_granularity_extended_caps;
 
 	if (pipe_ctx->stream->timing.dsc_cfg.num_slices_v > 0)
-		cmd.pr_copy_settings.data.dsc_slice_height = (pipe_ctx->stream->timing.v_addressable +
+		cmd.pr_copy_settings.data.dsc_slice_height = (uint16_t)((pipe_ctx->stream->timing.v_addressable +
 			pipe_ctx->stream->timing.v_border_top + pipe_ctx->stream->timing.v_border_bottom) /
-			pipe_ctx->stream->timing.dsc_cfg.num_slices_v;
+			pipe_ctx->stream->timing.dsc_cfg.num_slices_v);
 
 	if (dc_is_embedded_signal(link->connector_signal))
 		cmd.pr_copy_settings.data.main_link_activity_option = OPTION_1C;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
index 4808c793590f..b2eac83ef02c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
@@ -333,7 +333,7 @@ void dcn32_determine_det_override(struct dc *dc,
 				continue;
 
 			if (context->stream_status[i].plane_count > 0)
-				plane_segments = stream_segments / context->stream_status[i].plane_count;
+				plane_segments = (uint8_t)(stream_segments / context->stream_status[i].plane_count);
 			else
 				plane_segments = stream_segments;
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
index e4811c3728a9..89f7ccd7f81f 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -49,7 +49,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dc_clk_table->entries[i].dcfclk_mhz > dc_bw_params->dc_mode_limit.dcfclk_mhz) {
 					if (i == 0 || dc_clk_table->entries[i-1].dcfclk_mhz < dc_bw_params->dc_mode_limit.dcfclk_mhz) {
 						dml_clk_table->dcfclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dcfclk_mhz * 1000;
-						dml_clk_table->dcfclk.num_clk_values = i + 1;
+						dml_clk_table->dcfclk.num_clk_values = (uint8_t)(i + 1);
 					} else {
 						dml_clk_table->dcfclk.clk_values_khz[i] = 0;
 						dml_clk_table->dcfclk.num_clk_values = (uint8_t)i;
@@ -72,7 +72,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dc_clk_table->entries[i].fclk_mhz > dc_bw_params->dc_mode_limit.fclk_mhz) {
 					if (i == 0 || dc_clk_table->entries[i-1].fclk_mhz < dc_bw_params->dc_mode_limit.fclk_mhz) {
 						dml_clk_table->fclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.fclk_mhz * 1000;
-						dml_clk_table->fclk.num_clk_values = i + 1;
+						dml_clk_table->fclk.num_clk_values = (uint8_t)(i + 1);
 					} else {
 						dml_clk_table->fclk.clk_values_khz[i] = 0;
 						dml_clk_table->fclk.num_clk_values = (uint8_t)i;
@@ -95,7 +95,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dc_clk_table->entries[i].memclk_mhz > dc_bw_params->dc_mode_limit.memclk_mhz) {
 					if (i == 0 || dc_clk_table->entries[i-1].memclk_mhz < dc_bw_params->dc_mode_limit.memclk_mhz) {
 						dml_clk_table->uclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.memclk_mhz * 1000;
-						dml_clk_table->uclk.num_clk_values = i + 1;
+						dml_clk_table->uclk.num_clk_values = (uint8_t)(i + 1);
 					} else {
 						dml_clk_table->uclk.clk_values_khz[i] = 0;
 						dml_clk_table->uclk.num_clk_values = (uint8_t)i;
@@ -121,7 +121,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dc_clk_table->entries[i].dispclk_mhz > dc_bw_params->dc_mode_limit.dispclk_mhz) {
 					if (i == 0 || dc_clk_table->entries[i-1].dispclk_mhz < dc_bw_params->dc_mode_limit.dispclk_mhz) {
 						dml_clk_table->dispclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dispclk_mhz * 1000;
-						dml_clk_table->dispclk.num_clk_values = i + 1;
+						dml_clk_table->dispclk.num_clk_values = (uint8_t)(i + 1);
 					} else {
 						dml_clk_table->dispclk.clk_values_khz[i] = 0;
 						dml_clk_table->dispclk.num_clk_values = (uint8_t)i;
@@ -144,7 +144,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dc_clk_table->entries[i].dppclk_mhz > dc_bw_params->dc_mode_limit.dppclk_mhz) {
 					if (i == 0 || dc_clk_table->entries[i-1].dppclk_mhz < dc_bw_params->dc_mode_limit.dppclk_mhz) {
 						dml_clk_table->dppclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dppclk_mhz * 1000;
-						dml_clk_table->dppclk.num_clk_values = i + 1;
+						dml_clk_table->dppclk.num_clk_values = (uint8_t)(i + 1);
 					} else {
 						dml_clk_table->dppclk.clk_values_khz[i] = 0;
 						dml_clk_table->dppclk.num_clk_values = (uint8_t)i;
@@ -167,7 +167,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dc_clk_table->entries[i].dtbclk_mhz > dc_bw_params->dc_mode_limit.dtbclk_mhz) {
 					if (i == 0 || dc_clk_table->entries[i-1].dtbclk_mhz < dc_bw_params->dc_mode_limit.dtbclk_mhz) {
 						dml_clk_table->dtbclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.dtbclk_mhz * 1000;
-						dml_clk_table->dtbclk.num_clk_values = i + 1;
+						dml_clk_table->dtbclk.num_clk_values = (uint8_t)(i + 1);
 					} else {
 						dml_clk_table->dtbclk.clk_values_khz[i] = 0;
 						dml_clk_table->dtbclk.num_clk_values = (uint8_t)i;
@@ -190,7 +190,7 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 						dc_clk_table->entries[i].socclk_mhz > dc_bw_params->dc_mode_limit.socclk_mhz) {
 					if (i == 0 || dc_clk_table->entries[i-1].socclk_mhz < dc_bw_params->dc_mode_limit.socclk_mhz) {
 						dml_clk_table->socclk.clk_values_khz[i] = dc_bw_params->dc_mode_limit.socclk_mhz * 1000;
-						dml_clk_table->socclk.num_clk_values = i + 1;
+						dml_clk_table->socclk.num_clk_values = (uint8_t)(i + 1);
 					} else {
 						dml_clk_table->socclk.clk_values_khz[i] = 0;
 						dml_clk_table->socclk.num_clk_values = (uint8_t)i;
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 00473c6284d5..55c7250f18d8 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -246,7 +246,7 @@ void set_vsc_packet_colorimetry_data(
 		break;
 	}
 
-	info_packet->sb[16] = (pixelEncoding << 4) | colorimetryFormat;
+	info_packet->sb[16] = (uint8_t)((pixelEncoding << 4) | colorimetryFormat);
 
 	/* Set color depth */
 	switch (stream->timing.display_color_depth) {
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 5d444e9eb38f..f8b763db9b8c 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -647,12 +647,12 @@ static void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram
 	unsigned int set = params.set;
 
 	ram_table->flags = 0x0;
-	ram_table->min_abm_backlight = (big_endian) ?
+	ram_table->min_abm_backlight = (uint16_t)((big_endian) ?
 		cpu_to_be16(params.min_abm_backlight) :
-		cpu_to_le16(params.min_abm_backlight);
+		cpu_to_le16(params.min_abm_backlight));
 
 	for (i = 0; i < NUM_AGGR_LEVEL; i++) {
-		ram_table->hybrid_factor[i] = abm_settings[set][i].brightness_gain;
+		ram_table->hybrid_factor[i] = (uint8_t)abm_settings[set][i].brightness_gain;
 		ram_table->contrast_factor[i] = abm_settings[set][i].contrast_factor;
 		ram_table->deviation_gain[i] = abm_settings[set][i].deviation_gain;
 		ram_table->min_knee[i] = abm_settings[set][i].min_knee;
@@ -960,8 +960,8 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 			      struct dc_stream_state *stream,
 			      struct psr_config *config)
 {
-	uint16_t pic_height;
-	uint16_t slice_height;
+	uint32_t pic_height;
+	uint32_t slice_height;
 
 	config->dsc_slice_height = 0;
 	if (!(link->connector_signal & SIGNAL_TYPE_EDP) ||
@@ -978,7 +978,7 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 		return false;
 
 	slice_height = pic_height / stream->timing.dsc_cfg.num_slices_v;
-	config->dsc_slice_height = slice_height;
+	config->dsc_slice_height = (uint16_t)slice_height;
 
 	if (slice_height) {
 		if (config->su_y_granularity &&
@@ -1056,7 +1056,7 @@ void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal)
 {
-	uint8_t max_link_off_frame_count = 0;
+	uint32_t max_link_off_frame_count = 0;
 	uint16_t max_deviation_line = 0,  pixel_deviation_per_line = 0;
 
 	if (!link || link->replay_settings.config.replay_version != DC_FREESYNC_REPLAY)
@@ -1093,7 +1093,7 @@ bool fill_custom_backlight_caps(unsigned int config_no, struct dm_acpi_atif_back
 	caps->dc_level_percentage = custom_backlight_profiles[config_no].dc_level_percentage;
 	caps->min_input_signal = custom_backlight_profiles[config_no].min_input_signal;
 	caps->max_input_signal = custom_backlight_profiles[config_no].max_input_signal;
-	caps->num_data_points = custom_backlight_profiles[config_no].num_data_points;
+	caps->num_data_points = (uint8_t)custom_backlight_profiles[config_no].num_data_points;
 	memcpy(caps->data_points, custom_backlight_profiles[config_no].data_points, data_points_size);
 	return true;
 }
-- 
2.43.0


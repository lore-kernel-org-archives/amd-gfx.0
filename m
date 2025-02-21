Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A50C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C586E10EADC;
	Fri, 21 Feb 2025 16:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZpZQ5mjQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80FA10EAE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHFK3hYf+ZPUKVxfEJ57BZHLmabd3y1S6xUWYg3O/tPymzMnoQaH5eIEdhVG7xoikmNfebRtI6eJZkZUXrR+Q7+rVAzekbKfs3wv5Ba8vMTq1WJFJpVBX4ttulAZbi7GLP6M2zBORBNv7yJ42KhYbWAM8IhQCZwchZOmWLJByN9QK6VAmWRbcMHI9PbyCOAiqHjhG4R08JzCiC2NUbUw7oO7D0ob7duwmexhj1MuMkzOyvtlkFyBu2mkjKB5xmJ4Yda8AghGz6X/IeyLSAxyuWFbcGmdazY4Uk9qXasrbrHrOhczzF6GmMr/jZraa5pfNRijUoNI3mopXiWdhV5aSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h09KjrrNPs/+n9ePvEGfIRN0Ms8QRSVD5An1PpLmP/I=;
 b=FUnj/VjNyLz/XXEHus4vH1xxlh1dmWf+Iat9NsvyrFt52rBqiJaYGSwHtMbmiTpl1hOsvLP4xHZRFyujpJwMW5SrLcOLR4xZS5uaz+iU3qz7BNudOhXxqHlXNLd/KHKfw/eyCFV1qvQjS3IbaYPtZ4d6ALoasXdnw9H8KxIK+aUB4nZPIt7FsBCfLBowSWFInCcv/S3Ffz3yATgHbhlKDy1LHOKRQyojfZkbtU6qQu7i9kMun4H3nazP/P07xk+dNbtt/mLYj2/hZ+9wAfGdC4X/B535K9c/nIkmtI7bCEYssxUs9m3Mof+0yrxLn0Qm1sVdzdhc4EgSiXO6lmORHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h09KjrrNPs/+n9ePvEGfIRN0Ms8QRSVD5An1PpLmP/I=;
 b=ZpZQ5mjQXs0oZj9ZnjY43H0ZYJXO5+DlNDCD6nuClG/UyY5j5n6uCIWfATSQtiQTrap41lfK4Lz9PpZ2hHEc1SR5PV0cKU6Mh0+1sQ8GLCY7F9XoTIg2pNyWBrRb3Ktm3yQzKdPnziNscClE+Uv5rOxRx6mfyuUul2j4L1Sigko=
Received: from PH7P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::28)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:02:28 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::87) by PH7P220CA0050.outlook.office365.com
 (2603:10b6:510:32b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 16:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:28 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:19 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Ostrowski, Rafal" <rostrows@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 14/24] drm/amd/display: ACPI Re-timer Programming
Date: Fri, 21 Feb 2025 11:01:35 -0500
Message-ID: <20250221160145.1730752-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f69f3c9-4535-42b8-4103-08dd529123f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mLuW4TTkpQQsKZdnIqj6zYQ0O8tr8grX4w0xW5WDTnjkbuWpuKFprR/2v75X?=
 =?us-ascii?Q?Eo2iGlkE/hD/7uJdD3YcIOyU3/WYl6JdXMFUIn3jkysEAK+IyFtKvPwBcZG+?=
 =?us-ascii?Q?7692yR1vtjBdoU04oVTVPGJvQ7yLx+dNaFaqE2r9bv85cTSbp+ZHTRa08/qA?=
 =?us-ascii?Q?sOhHdHZi25zkS13oACs0fCZEfJYKcggV4RdwhRuuQlSKaDBt6PxYSWoCsZ+9?=
 =?us-ascii?Q?/LONsk2pC6sxh0wN1edHKV3NSudYIG8JQ+e6jhOJZOc/uCDKHVQLb57BSb+2?=
 =?us-ascii?Q?vLqoemMg7uClWI5FYEE2Wl9rQJ0TI9Nt/6KJBO0kZ+RON8j/O5rJZfDkzMzv?=
 =?us-ascii?Q?TZ9Aft5y6kdxxR+03udmNfbGPM2e0m7RXe6t5vVQLN9IYG4iJTp/yFzNB8Oa?=
 =?us-ascii?Q?0Nax6T1rWputVkUaNAIs06qzcXlvuGbtc9prjlVt+2XIl8a60pHKTcl8xLS4?=
 =?us-ascii?Q?9YyNYqyUOGvKMMiNykUFJlcWcQsZAqswzYck0r0YVN7fEVs7mNgQ+Dl8wFc+?=
 =?us-ascii?Q?wMuw/Yd7OZa9NLX+ryijBEyChrCl2x0s1JyyiENl3dAk+gxxS61FMwJXgn7Z?=
 =?us-ascii?Q?n4M20sJCWi9l8s+mDKaA+26P77tN+g7gXbnr7FlMeQF0YbqOZ4cykb7t+TBI?=
 =?us-ascii?Q?+yuziVl6SUX5uNZQRPrFWEl4g6yHRgfswZ0sm5YMSk6KpbXayMXwnCTR6aC2?=
 =?us-ascii?Q?g5SLyO5NAF4Z8Z8pjF1z9mqgHhvUutziKTL6ENFF3yHm2jgMkhlopus0XgO8?=
 =?us-ascii?Q?H/+zFgSwnZ4oC3y6ud5gAmsiu00ccwH3aYag471tq8mmkjI9qZePFTE5MBqR?=
 =?us-ascii?Q?GZQ+1CddNyhY8PEF+vcmnMVP4yJZeWSaFgHOvUhDIUYCLOKMM/v8lSNYkuGM?=
 =?us-ascii?Q?KPZZYPvgbUCfrfo0fQxJMOtMA4x+b4aUoZSZc3/16kCvuKYgxdnupJwXr56f?=
 =?us-ascii?Q?Ud3USE/QP6fRiYolIgr6kRVToFnZKSRXVoFjnj1H3usSbvae6CbnFLa9MDcM?=
 =?us-ascii?Q?ul5EyCosXXRnoemEikV01wNUojrNzSthZqscw7qNyMBHq/KTWqRP8jSnHjBt?=
 =?us-ascii?Q?F/UcYqtWJwwjutPsJ/HRvYN89MztyUUlodOz31SqA2zc3JS4iNSy8dEDjPk5?=
 =?us-ascii?Q?o4MUu3RilGpXN2+3Q0ZQ4gha+NxZnO/++xsw8aIEVpUYIVVWYyOcbToxlaxS?=
 =?us-ascii?Q?GiPvDsUJygLufOEQFqoGP1ZayBQaEeEMCG736aEEr0UkHir+R/TLMpdoPz81?=
 =?us-ascii?Q?Nc/7hVFf80EchLnSDdOxbK0chZ8Gy9DeUx3HA6gXVLjm8WKiK+XtD6v9RDIC?=
 =?us-ascii?Q?d30j/btiaQgq3RjJQrniBAIiLqyiSdmobiY1t/17rZClUtHNIU7sNUpMPfVZ?=
 =?us-ascii?Q?YnW1PTCm/nWCXxKBtsg/OXgNJ15QzZBu+X8Xw1qs0Dqn+f32LR8tfYXzdA/i?=
 =?us-ascii?Q?79ZMka7GmNIwCfVQbzM1J4bEoWJxkqDEGK/zKJvT8UZkYv+nK4GUZQk3WezU?=
 =?us-ascii?Q?JahPqf7u+NbtjE0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:28.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69f3c9-4535-42b8-4103-08dd529123f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

From: "Ostrowski, Rafal" <rostrows@amd.com>

[Why]
We must implement an ACPI re-timer programming interface and notify
ACPI driver whenever a PHY transition is about to take place.

Because some trace lengths on certain platforms are very long,
then a re-timer may need to be programmed whenever a PHY transition
takes place. The implementation of this re-timer programming interface
will notify ACPI driver that PHY transition is taking place and it
will trigger the re-timer as needed.

First we need to gather retimer information from ACPI interface.

Then, in the PRE case, the re-timer interface needs to be called before we call
transmitter ENABLE.
In the POST case, it has to be called after we call transmitter DISABLE.

[How]
Implemented ACPI retimer programming interface.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rostrows@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +++
 .../drm/amd/display/dc/bios/command_table2.c  | 47 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  7 +++
 .../drm/amd/display/dc/dm_services_types.h    | 26 ++++++++++
 5 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9f53d88ad7ca..bb8ba30994b6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12696,3 +12696,10 @@ bool dm_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int count,
 {
 	return dc_dmub_srv_cmd_run_list(ctx->dmub_srv, count, cmd, wait_type);
 }
+
+void dm_acpi_process_phy_transition_interlock(
+	const struct dc_context *ctx,
+	struct dm_process_phy_transition_init_params process_phy_transition_init_params)
+{
+	// Not yet implemented
+}
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 7d18f372ce7a..2c96a5e64567 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -210,6 +210,7 @@ static enum bp_result encoder_control_fallback(
  ******************************************************************************
  *****************************************************************************/
 
+
 static enum bp_result transmitter_control_v1_6(
 	struct bios_parser *bp,
 	struct bp_transmitter_control *cntl);
@@ -325,6 +326,21 @@ static void transmitter_control_dmcub_v1_7(
 	dc_wake_and_execute_dmub_cmd(dmcub->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
+static struct dc_link *get_link_by_phy_id(struct dc *p_dc, uint32_t phy_id)
+{
+	struct dc_link *link = NULL;
+
+	// Get Transition Bitmask from dc_link structure associated with PHY
+	for (uint8_t link_id = 0; link_id < MAX_LINKS; link_id++) {
+		if (phy_id == p_dc->links[link_id]->link_enc->transmitter) {
+			link = p_dc->links[link_id];
+			break;
+		}
+	}
+
+	return link;
+}
+
 static enum bp_result transmitter_control_v1_7(
 	struct bios_parser *bp,
 	struct bp_transmitter_control *cntl)
@@ -363,7 +379,37 @@ static enum bp_result transmitter_control_v1_7(
 
 	if (bp->base.ctx->dc->ctx->dmub_srv &&
 		bp->base.ctx->dc->debug.dmub_command_table) {
+		struct dm_process_phy_transition_init_params process_phy_transition_init_params = {0};
+		struct dc_link *link = get_link_by_phy_id(bp->base.ctx->dc, dig_v1_7.phyid);
+		bool is_phy_transition_interlock_allowed = false;
+		uint8_t action = dig_v1_7.action;
+
+		if (link) {
+			if (link->phy_transition_bitmask &&
+				(action == TRANSMITTER_CONTROL_ENABLE || action == TRANSMITTER_CONTROL_DISABLE)) {
+				is_phy_transition_interlock_allowed = true;
+
+				// Prepare input parameters for processing ACPI retimers
+				process_phy_transition_init_params.action                   = action;
+				process_phy_transition_init_params.display_port_lanes_count = cntl->lanes_number;
+				process_phy_transition_init_params.phy_id                   = dig_v1_7.phyid;
+				process_phy_transition_init_params.signal                   = cntl->signal;
+				process_phy_transition_init_params.sym_clock_10khz          = dig_v1_7.symclk_units.symclk_10khz;
+				process_phy_transition_init_params.display_port_link_rate   = link->cur_link_settings.link_rate;
+				process_phy_transition_init_params.transition_bitmask       = link->phy_transition_bitmask;
+			}
+		}
+
+		// Handle PRE_OFF_TO_ON: Process ACPI PHY Transition Interlock
+		if (is_phy_transition_interlock_allowed && action == TRANSMITTER_CONTROL_ENABLE)
+			dm_acpi_process_phy_transition_interlock(bp->base.ctx, process_phy_transition_init_params);
+
 		transmitter_control_dmcub_v1_7(bp->base.ctx->dmub_srv, &dig_v1_7);
+
+		// Handle POST_ON_TO_OFF: Process ACPI PHY Transition Interlock
+		if (is_phy_transition_interlock_allowed && action == TRANSMITTER_CONTROL_DISABLE)
+			dm_acpi_process_phy_transition_interlock(bp->base.ctx, process_phy_transition_init_params);
+
 		return BP_RESULT_OK;
 	}
 
@@ -1046,3 +1092,4 @@ void dal_firmware_parser_init_cmd_tbl(struct bios_parser *bp)
 
 	init_enable_lvtma_control(bp);
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5e96913bcab1..f76884fe86e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1083,6 +1083,7 @@ struct dc_debug_options {
 	unsigned int enable_oled_edp_power_up_opt;
 	bool enable_hblank_borrow;
 	bool force_subvp_df_throttle;
+	uint32_t acpi_transition_bitmasks[MAX_PIPES];
 };
 
 
@@ -1806,6 +1807,7 @@ struct dc_link {
 
 	struct dc_panel_config panel_config;
 	struct phy_state phy_state;
+	uint32_t phy_transition_bitmask;
 	// BW ALLOCATON USB4 ONLY
 	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
 	bool skip_implict_edp_power_control;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index f81e5a4e1d6d..7b9c22c45453 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -290,6 +290,13 @@ void dm_trace_smu_delay(uint32_t delay, struct dc_context *ctx);
 bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
 bool dm_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int count, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
 
+/*
+ * ACPI Interfaces
+ */
+void dm_acpi_process_phy_transition_interlock(
+	const struct dc_context *ctx,
+	struct dm_process_phy_transition_init_params process_phy_transition_init_params);
+
 /*
  * Debug and verification hooks
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index facf269c4326..bf63da266a18 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -275,4 +275,30 @@ enum dm_dmub_wait_type {
 	DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY,
 };
 
+enum dm_acpi_transition_link_type {
+	hdmi_tmds,
+	hdmi_frl,
+	dp_8b_10b,
+	dp_128b_132b,
+	none
+};
+
+struct dm_process_phy_transition_init_params {
+	uint32_t phy_id;
+	uint8_t action;
+	uint32_t sym_clock_10khz;
+	enum signal_type signal;
+	enum dc_lane_count display_port_lanes_count;
+	enum dc_link_rate display_port_link_rate;
+	uint32_t transition_bitmask;
+	uint8_t hdmi_frl_num_lanes;
+};
+
+struct dm_process_phy_transition_input_params {
+	uint32_t phy_id;
+	uint32_t transition_id;
+	uint32_t phy_configuration;
+	uint32_t data_rate;
+};
+
 #endif
-- 
2.34.1


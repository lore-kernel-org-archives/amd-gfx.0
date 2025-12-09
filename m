Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF51D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B36510E4E0;
	Tue,  9 Dec 2025 08:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vtyMF8WU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B854D10E4E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWBi6gfHuvPmwfvwWfJufhUQEPSoNRl3v0c3hnUBPrkEkHN/XtGbYYSGG0ZpMM0CM4DcsPtPoI00afHuCDB3MWWrefke5IEqIjdQ+6L4nDZT5Ainy0pvZL7zjWrgXdMZw47aOIUT43OT5X4Jnd2+Pd5io4pSaPLg6ww2DMRGOVyG1atf7wFUQPPBmpICim3I/f1Sy6N7WOJN78mFnADCDiuHr4CgN+Ew6gIawMdsePMAYEK4Rzaun/XUjvqYUguJKdx6aSTxYSFOUeuhOrQkAffDmqavdsJ4J3V/+1fqJy8CYum1OTUE7v2oZGGxPiLTLk2NeWd+GG7/zWNgK0MIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=707zisagrm9nbxzzJfCLAGqUNfZ6AFEcV+dZXaoJ7NE=;
 b=O3pOhCAhtELBZUmQd/Cv3XDQBx4VGvgkcjRlaYP18GoDMt8kvvHzgbHE+zkt65LYoHT0/4vhmHmdXv4Kw+cAg/W6r5h1C+oI5BFnZAMCd2I2jyPN64PWbFXhZQhVDKcP9v0X6TuIr67M49y58J6LVPrUwuyMwB1GXiMXOIqhaM8b+tNvuv0wgSsiExfAwGntj6ObLDZZ95Ul6IVjUH/XimWaclAXKUAkqmPs1xRM1RFFaryXFPPe39IHqI3HVK4I2a4GcdSzjcifSAWckGT1PBiQJPODBYYy0S8CVJfhV+d7EV0OsnSm/lNeKCc87fEWDjcUXQ/Pwx2UTLNfaLJ6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=707zisagrm9nbxzzJfCLAGqUNfZ6AFEcV+dZXaoJ7NE=;
 b=vtyMF8WUblAtKbAPzQscQJouL5A9mt1BTarKNuKhJsl9e8Gsy0zE+vRmJWFRriTDx3FCopaUIy4XsweVN2tuNUMA/XNc7sgBFDprWjp51Y5HMYH0uv0KlgQ6ioI8O1SsrSBxX//J5AoWMaB2if3Av3tckQ8XjRmy0KRTgFC50WM=
Received: from BYAPR02CA0014.namprd02.prod.outlook.com (2603:10b6:a02:ee::27)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:58:41 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::9f) by BYAPR02CA0014.outlook.office365.com
 (2603:10b6:a02:ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:40 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:39 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:31 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 14/15] drm/amd/display: [FW Promotion] Release 0.1.40.0
Date: Tue, 9 Dec 2025 16:55:17 +0800
Message-ID: <20251209085702.293682-15-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5a274f-8e00-40a7-faf8-08de37012657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?we6KjnFkY9V/aAEnOggcK90fmwYxPFqMfSCbKSrRD6tdQOZ2xQcN4xCjDdjz?=
 =?us-ascii?Q?BcMZcY1+dFecDOlHXxnMsKmUt881N0lFa8sCY+/nebV/FM2UAL0q4+vYfXsf?=
 =?us-ascii?Q?cuOwMP7BUv1ttW3ikxouyfKIFN6X/QsMhI3qpYkbtZ5oowRiDqeHm2ZXx2ka?=
 =?us-ascii?Q?newgkOAgrMKPRi4E9R3LzkHkdcXsY+IEL3MS8gjXYWH/rpqhGeQcjYgTwPTk?=
 =?us-ascii?Q?nWjKpH71U2Uh8Q/hGmK1/xdzTCVmLnZwt2iOYBJVZdhkitTYw2PbplCffi8F?=
 =?us-ascii?Q?LrKAZY+4pIrN5+fO/OjMM09EPzSa68D0pE+pJZV5n9Jd65A+xLbXoskNOYtE?=
 =?us-ascii?Q?0Icm8/BpwjHmVFjdHhyKdTbhDDWXRWemc2A5kSDSDeZ14jk2zeRDyHlvQKfb?=
 =?us-ascii?Q?raM7KDvDYsRGkAh8VneHi1ZjtbE1JD3lZcjJ8PdZBdwDI3ho3qPcYgln4adG?=
 =?us-ascii?Q?tVZzEuKbUhe2sjknPwNqZiAdpVzD+27dx36X/TI2CPXKAyqTcxoR39TtFbkX?=
 =?us-ascii?Q?uNxjuBX7ble4bdCHGbUV+CPFnayIIXiaamIFL5hNB7WdqtUaNmXHngMikuqr?=
 =?us-ascii?Q?TDdpFRgxW8JGOJc00o8OwZ5u9uZ1g6S/styhUw9APVlXbtgJVi142Muun28F?=
 =?us-ascii?Q?WcPkB6fcCbBMNmO1mPv2c6qpXnNKH75Q+zS2R/MPJxo5xRnHwdLQu/muWpWm?=
 =?us-ascii?Q?y+BFbzrjX4Un31bhOZaxsQ0sE+SlvmCLmqNoeRBdw772Zk2XzUzdO4JRmEuZ?=
 =?us-ascii?Q?otZWiTUqNV4xgaapiLwKfZhwHW9DfLv9Q5lePiD1u8Ky7f0RnW7CUCS488pk?=
 =?us-ascii?Q?nzPjaB5nY1iutU4M/GOWVBgZ7rFLBotTXQE9Ge7ETwayhKACrFuNTiRdRTgF?=
 =?us-ascii?Q?QelhmBiGCpH/gXHwQBOxDmj9py20OjO5D5n7ADT7dLX7pSlxEkHKpc6urLB7?=
 =?us-ascii?Q?aiF7okX8Yx4oYrxzaHqpx0GSHws0M6XMgQjWieX41nhRhDg8Nd9DD0F/L5Sv?=
 =?us-ascii?Q?aK8JR1g/lrDX6A7IuCXnCXrudhIHulhRczhio+3/BKaGV22/SIn1X+q1dozx?=
 =?us-ascii?Q?qv0Q+Az5Pu0WK0B516Pd8wZYYZginRQfsP/pQjTRf5nhp1KoFlurHXd8t/dx?=
 =?us-ascii?Q?sKDh+ZYnnbXfyMEtft2ICNKk7OEwp6mvby+WtNkp4r2XEvOS0Jwu1NNJ5Uyr?=
 =?us-ascii?Q?FbnZrJVzDO3gOI0U9ZhwXj3YQJHGHIYJWWNsBdlcbnM34qWUA8GddJYCPDH8?=
 =?us-ascii?Q?vbfV88xlU9FdiT29uEUd7W4tNu4RVfRm40sCZw2Bu6r8SNk7eKHlNMZvCAEs?=
 =?us-ascii?Q?GWoPNC0c2tk/jq4tGx1LkcQZqxY+jiJUuPh2Q3isuByL8Nh8YuzfQw/Fhcbi?=
 =?us-ascii?Q?rmGRMz59gIPfzFnXKM8IlO2MeLgUeZDJxY4jPRHXTqNf3JxPt2AnlKW99fJq?=
 =?us-ascii?Q?vRfJaA/mBHmW9HF6uW6buRoTDNCZMPI55mHmZlr0DAdxus02ne6uZkQMMtcO?=
 =?us-ascii?Q?ue0QkxpKfTjbGC16SwHqY5YB7gVwvWZrvZcMxDC2r7KSdzwIbIMAWWDFHEyj?=
 =?us-ascii?Q?g/oSonHyIjuIHWnCJ48=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:40.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5a274f-8e00-40a7-faf8-08de37012657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary for changes in firmware:
* Update DCHVM restore sequence for dcn35
* Add 2 new debug polling methods for dchvm "busy" during IPS entry for DCN35

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 70 +++++++++++++------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 9c2d687eb7fd..87249b8005d6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -636,17 +636,29 @@ union pr_debug_flags {
 
 		/**
 		 * 0x10 (bit 4)
-		 * @skip_crtc_disabled: CRTC disable skipped
+		 * @visual_confirm_rate_control: Enable Visual Confirm rate control detection
 		 */
-		uint32_t skip_crtc_disabled : 1;
+		uint32_t visual_confirm_rate_control : 1;
 
-		/*
+		/**
 		 * 0x20 (bit 5)
-		 * @visual_confirm_rate_control: Enable Visual Confirm rate control detection
+		 * @force_full_frame_update: Force all selective updates to be full frame updates
 		 */
-		uint32_t visual_confirm_rate_control : 1;
+		uint32_t force_full_frame_update : 1;
 
-		uint32_t reserved : 26;
+		/**
+		 * 0x40 (bit 6)
+		 * @force_dpg_on: Force DPG on
+		 */
+		uint32_t force_dpg_on : 1;
+
+		/**
+		 * 0x80 (bit 7)
+		 * @force_hubp_on: Force Hubp on
+		 */
+		uint32_t force_hubp_on : 1;
+
+		uint32_t reserved : 24;
 	} bitfields;
 
 	uint32_t u32All;
@@ -669,19 +681,12 @@ union pr_hw_flags {
 		 * @fec_enable_status: receive fec enable/disable status from driver
 		 */
 		uint32_t fec_enable_status : 1;
-
 		/*
 		 * @smu_optimizations_en: SMU power optimization.
 		 * Only when active display is Replay capable and display enters Replay.
 		 * Trigger interrupt to SMU to powerup/down.
 		 */
 		uint32_t smu_optimizations_en : 1;
-
-		/**
-		 * @phy_power_state: Indicates current phy power state
-		 */
-		uint32_t phy_power_state : 1;
-
 		/**
 		 * @link_power_state: Indicates current link power state
 		 */
@@ -698,6 +703,7 @@ union pr_hw_flags {
 		 * @alpm_mode: Indicates ALPM mode selected
 		 */
 		uint32_t alpm_mode : 2;
+		uint32_t reserved : 23;
 	} bitfields;
 
 	uint32_t u32All;
@@ -4279,7 +4285,7 @@ enum pr_state {
 	// Active and Pending Power Up
 	PR_STATE_2_PENDING_POWER_UP					= 0x33,
 	// Active and Powered Up, Pending DPG latch
-	PR_STATE_2_PENDING_LOCK_FOR_DPG_POWER_ON	= 0x34,
+	PR_STATE_2_PENDING_LOCK	= 0x34,
 	// Active and Powered Up, Pending SDP and Unlock
 	PR_STATE_2_PENDING_SDP_AND_UNLOCK			= 0x35,
 	// Pending transmission of AS SDP for timing sync, but no rfb update
@@ -6617,10 +6623,6 @@ struct dmub_cmd_pr_copy_settings_data {
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
-	/**
-	 * Length of each horizontal line in ns.
-	 */
-	uint32_t line_time_in_ns;
 	/**
 	 * PHY instance.
 	 */
@@ -6629,10 +6631,10 @@ struct dmub_cmd_pr_copy_settings_data {
 	 * Determines if SMU optimzations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
-	/*
-	 * Use FSM state for Replay power up/down
+	/**
+	 * Length of each horizontal line in ns.
 	 */
-	uint8_t use_phy_fsm;
+	uint32_t line_time_in_ns;
 	/*
 	 * Use FSFT afftet pixel clk
 	 */
@@ -6645,6 +6647,14 @@ struct dmub_cmd_pr_copy_settings_data {
 	 * Use for AUX-less ALPM LFPS wake operation
 	 */
 	struct dmub_alpm_auxless_data auxless_alpm_data;
+	/**
+	 * DSC Slice height.
+	 */
+	uint16_t dsc_slice_height;
+	/*
+	 * Use FSM state for Replay power up/down
+	 */
+	uint8_t use_phy_fsm;
 	/**
 	 * @hpo_stream_enc_inst: HPO stream encoder instance
 	 */
@@ -6653,10 +6663,26 @@ struct dmub_cmd_pr_copy_settings_data {
 	 * @hpo_link_enc_inst: HPO link encoder instance
 	 */
 	uint8_t hpo_link_enc_inst;
+	/*
+	 * Selective Update granularity needed.
+	 */
+	uint8_t su_granularity_needed;
+	/*
+	 * Horizontal granularity for Selective Update.
+	 */
+	uint16_t su_x_granularity;
+	/*
+	 * Extended caps of vertical granularity for Selective Update.
+	 */
+	uint16_t su_y_granularity_extended_caps;
+	/*
+	 * Vertical granularity for Selective Update.
+	 */
+	uint8_t su_y_granularity;
 	/**
 	 * @pad: Align structure to 4 byte boundary.
 	 */
-	uint8_t pad[2];
+	uint8_t pad;
 };
 
 /**
-- 
2.43.0


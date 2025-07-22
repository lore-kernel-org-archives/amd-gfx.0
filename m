Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E807FC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A25710E72D;
	Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="crAez+B6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446B010E724
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqVmwFaql6RDLDrC3rl0O2AXh0UBTA7RPQrsUO8D4jnbMSc+lac8u5IkC0n8bupJH2XELmNsPa3bM6YqXFwJJuYUJgoqSaFT6Kqre4claEvqtmoBcHR40BEhlFK88I4t2h6qrMUWlakbipclHYjmLnc2EgP48ZfSQ11ZZO1P5lDOnjCYRlEpK11+negaL8K+JAT0gmWlnJNFUvm3+6HRPuxz/Zb+bkM2h2UuXuIpIMrZwwjgMF7ImSHWrBR8yICWiAQN8v8dD9pfj0rw+rS8wmOYv1FG4hrX6L01gQEcNkq5B5xTqjl2hopO+Q4BGqXf1P1NFHulqkRZVrgOfMgW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVVnwTC5RiKHyS5Oh5ZLvnnvQ9DQs/5KGIjjBGGyiNM=;
 b=mhOgtZjUzGVDLNvVtxUNdqmsV24+1wDM4xP1C/PIi4R+IzTJmKwiNgb/UH2/GqsfYyVJjcGQH+Q1mo9AYvURF82Pv/xxWULPqBl2WZ3iiRUoCN07RJ5wuBOxw4m1nAmDA3kWG8sFAhHoU216VkyFVCqw6FPntJ/aezkr5dNWuJK5Xwh26bJlJ+eMsm1VKuZP+Q2n+v64520kh6wf5K1SZRNacrEQ5QloDZlbALrh/lFLuPBIeoQA54BvXxeAtRUL0I/XR/BDrLdlJqXFYYfBC6+Q71WsmGvZ1YEDG5z4+yBrPZAcpjD1TZU26A0TTbICblzsaSMzGYzJZWPeaEgdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVVnwTC5RiKHyS5Oh5ZLvnnvQ9DQs/5KGIjjBGGyiNM=;
 b=crAez+B6XW+BBzsq/FhpbHk1fzVi4lrcxFf9k2xCYjqvHDbyE5F/jQoZiUeRK0uIEniLRsUcMFcr0QAFULh7w1eCk/FxOn8kwnyRb/nANGTDEQj2x2tPlHJgUMHb/mCDs8GaRPuEN7uX0NB8YSb8/d8LJ7ZvYaiEifGTGewLUZU=
Received: from MN2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:c0::41)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 22:39:29 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::c2) by MN2PR05CA0028.outlook.office365.com
 (2603:10b6:208:c0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:28 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:27 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Duncan Ma
 <Duncan.Ma@amd.com>, Charlene Liu <charlene.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 12/25] drm/amd/display: Add eDP AUXless ALPM
Date: Tue, 22 Jul 2025 18:36:18 -0400
Message-ID: <20250722223911.2655505-13-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 594c13de-6c4b-4fca-cc92-08ddc9709ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k3OL0WLMQZ+hytM2rxzxgE4Hmg928qB4sMrAI0fhosI1UZc06lw0+NPsBQGV?=
 =?us-ascii?Q?ovwC2Jc6BrkM5GDYpxo80RjdcjARUoiPU9STQxwF7QfqEFDnGpjV1Pc0L4I1?=
 =?us-ascii?Q?n6UVFpgAEohUiLDYM6nmew4feaK/hLS3zGW3HsvaE8UaIu/HG6EeBFFmHsys?=
 =?us-ascii?Q?Co8yqrBo3tvFfvLzg90jwgKJ7msmtzbn+CQEXfC5cXMCw35pxjxOjYTcUH5w?=
 =?us-ascii?Q?nUH6bPx5L8w3xNJZzGmMDfE1rfAy7PNJ5jot0d82vmCHa8fgJExVRd8bpHnK?=
 =?us-ascii?Q?oTmtUQHbxAKaZ8Fx0NTKi/1lEnv0Mbq/NePS6lYfci0sKoireY7Yossl76gf?=
 =?us-ascii?Q?Mok2DRlcMJZ12SNU8xy0AVyQNFSTZdzxgRYGvPDezLyvbroic9koee7NTF+y?=
 =?us-ascii?Q?GW9iwj9gmbwpr2vPMnadtfqigDckS0T/NLO86VC7d9sx7AVwRrYteKU1cVgm?=
 =?us-ascii?Q?/kqa9+4Tt2JwQJi/cxu1new4KGSRk6ScikHvOkYbbLuDH9xZZcvnhHI8r+Gm?=
 =?us-ascii?Q?wc1q4Ru8USCsBo3m0PIRX6w640WUoLMPf7ZvY5VmXHlWGjcc0MFEI2IWuAX4?=
 =?us-ascii?Q?3UBytfSuMpF5JZpcdpsfpuMcsi6wKfnQD5hmUINOgChyIWis+4Fc4U/pB84j?=
 =?us-ascii?Q?L4FHpG8mLuiNztW1HmlK+M8fIaicv5+3Qh6sPRjEhJUSAudS/3IWZ5CQ7nDp?=
 =?us-ascii?Q?/GLMz6csuW/j30WsrAmulaFYMEPG6jCeyoKaf6xTtXYa4KVPb+7O0MFvxUmY?=
 =?us-ascii?Q?L11xo+avWuj4anSTxgRBCWZ/V/wpWByZMaFGDTJp+R/3HUIfrXLc1x33hwr1?=
 =?us-ascii?Q?44OEAM0Vfxn4TU9Drf9xtd4LPZcZBHF3miyHFJEy7K1tcJv//CWkDAETApVB?=
 =?us-ascii?Q?k2vTbF4QX6Yu0gLLd4OF3v+HBL1tfptSHvvDIG8/1pzCmbugA5h6lCv/RH64?=
 =?us-ascii?Q?lma+md7NoEVe/A0nFdtZXAvv1lwG+kEKfBSxHHJLK7Mv8J48WeQ8u8Wxzqy0?=
 =?us-ascii?Q?v9OvmdvDMRJ+dAwxmWjkeUS+ZT0jULxXAhfH5Y2rmZ8KoLjO5YA2D/ip9Qlt?=
 =?us-ascii?Q?yigTvYHO6049M7Ar3//OLeOTEuzfHt397botEIqDfrDzakcuikodZR28KoKz?=
 =?us-ascii?Q?X92caudHc5ZkUgeQu2T57mf31Wo6t7lzLNQZDSCBgPByvUd8gL/zco9zWppQ?=
 =?us-ascii?Q?wYxAcxuiV3/koxdV/NClbyBCYtHwoR6uzdm1emuzRAyP7eYcFM6PqgTwcn+l?=
 =?us-ascii?Q?nva5gsNITdP6ID0aQbEV485yiWYktFDIq5jITOOLPsWr3GihHzkzGNypoU1f?=
 =?us-ascii?Q?FicuAL4i0XhYzszSODsUvh+0IKFLApUq7KPwUjEFpndi8QyzE5cs08+xa26z?=
 =?us-ascii?Q?jdTXalLx9oHmdmsVoD7nXbz5DAkTUBNAh3uaZcQQ3y2TWqXrzDZUq43XWtmB?=
 =?us-ascii?Q?XZSHpBVwKnsgocechYTd+wIhsYxmtJ/Y8NdWO8E9PKRiTYJgnK5uy4Y1E/Xi?=
 =?us-ascii?Q?W32m3GqjbH67JiamdluZThcyBD+J2LKXQ2jD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:29.3472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594c13de-6c4b-4fca-cc92-08ddc9709ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

From: Duncan Ma <Duncan.Ma@amd.com>

[Why & How]
Add AUX-less ALPM capability check and initialization

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Duncan Ma <Duncan.Ma@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c |  7 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 11 ++++++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 16 +++++---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  8 ++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 13 +++++++
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  5 ++-
 .../drm/amd/display/dc/link/link_factory.c    |  2 +
 .../dc/link/protocols/link_dp_capability.c    | 37 +++++++++++++++++++
 .../dc/link/protocols/link_dp_capability.h    |  6 +++
 .../link/protocols/link_edp_panel_control.c   |  8 +++-
 10 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 130455f2802a..b7a5de4ecb61 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -520,3 +520,10 @@ enum dc_status dc_link_validate_dp_tunneling_bandwidth(const struct dc *dc, cons
 	return dc->link_srv->validate_dp_tunnel_bandwidth(dc, new_ctx);
 }
 
+void dc_link_get_alpm_support(struct dc_link *link,
+	bool *auxless_support,
+	bool *auxwake_support)
+{
+	link->dc->link_srv->edp_get_alpm_support(link, auxless_support, auxwake_support);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 779b39e33443..fee54cc0f7d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1145,6 +1145,11 @@ struct dc_debug_options {
 	bool enable_hblank_borrow;
 	bool force_subvp_df_throttle;
 	uint32_t acpi_transition_bitmasks[MAX_PIPES];
+	unsigned int auxless_alpm_lfps_setup_ns;
+	unsigned int auxless_alpm_lfps_period_ns;
+	unsigned int auxless_alpm_lfps_silence_ns;
+	unsigned int auxless_alpm_lfps_t1t2_us;
+	short auxless_alpm_lfps_t1t2_offset_us;
 };
 
 
@@ -2447,6 +2452,12 @@ void dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(
  */
 enum dc_status dc_link_validate_dp_tunneling_bandwidth(const struct dc *dc, const struct dc_state *new_ctx);
 
+/*
+ * Get if ALPM is supported by the link
+ */
+void dc_link_get_alpm_support(struct dc_link *link, bool *auxless_support,
+	bool *auxwake_support);
+
 /* Sink Interfaces - A sink corresponds to a display output device */
 
 struct dc_container_id {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 5ce1be362534..3a3ec38cdf8b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -1021,7 +1021,8 @@ union dp_128b_132b_supported_lttpr_link_rates {
 union dp_alpm_lttpr_cap {
 	struct {
 		uint8_t AUX_LESS_ALPM_SUPPORTED	:1;
-		uint8_t RESERVED				:7;
+		uint8_t ASSR_SUPPORTED			:1;
+		uint8_t RESERVED			:6;
 	} bits;
 	uint8_t raw;
 };
@@ -1119,10 +1120,11 @@ union dp_128b_132b_training_aux_rd_interval {
 
 union edp_alpm_caps {
 	struct {
-		uint8_t AUX_WAKE_ALPM_CAP       :1;
-		uint8_t PM_STATE_2A_SUPPORT     :1;
-		uint8_t AUX_LESS_ALPM_CAP       :1;
-		uint8_t RESERVED                :5;
+		uint8_t AUX_WAKE_ALPM_CAP                               :1;
+		uint8_t PM_STATE_2A_SUPPORT                             :1;
+		uint8_t AUX_LESS_ALPM_CAP                               :1;
+		uint8_t AUX_LESS_ALPM_ML_PHY_SLEEP_STATUS_SUPPORTED     :1;
+		uint8_t RESERVED                                        :4;
 	} bits;
 	uint8_t raw;
 };
@@ -1347,7 +1349,9 @@ union dpcd_alpm_configuration {
 	struct {
 		unsigned char ENABLE                    : 1;
 		unsigned char IRQ_HPD_ENABLE            : 1;
-		unsigned char RESERVED                  : 6;
+		unsigned char ALPM_MODE_SEL             : 1;
+		unsigned char ACDS_PERIOD_DURATION      : 1;
+		unsigned char RESERVED                  : 4;
 	} bits;
 	unsigned char raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2a86058c3bfa..2e2dea21b332 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -577,6 +577,12 @@ struct dc_plane_flip_time {
 	unsigned int prev_update_time_in_us;
 };
 
+enum dc_alpm_mode {
+	DC_ALPM_AUXWAKE = 0,
+	DC_ALPM_AUXLESS = 1,
+	DC_ALPM_UNSUPPORTED = 0xF,
+};
+
 enum dc_psr_state {
 	PSR_STATE0 = 0x0,
 	PSR_STATE1,
@@ -1143,6 +1149,8 @@ struct replay_config {
 	bool low_rr_supported;
 	/* Replay Video Conferencing Optimization Enabled */
 	bool replay_video_conferencing_optimization_enabled;
+	/* Replay alpm mode */
+	enum dc_alpm_mode alpm_mode;
 };
 
 /* Replay feature flags*/
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fcd3d86ad517..65b979617b0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -3,6 +3,7 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dc.h"
+#include "link.h"
 #include "dc_dmub_srv.h"
 #include "dmub/dmub_srv.h"
 #include "core_types.h"
@@ -189,6 +190,18 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	else
 		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 0;
 
+	copy_settings_data->flags.bitfields.alpm_mode = (enum dmub_alpm_mode)link->replay_settings.config.alpm_mode;
+	if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
+		copy_settings_data->auxless_alpm_data.lfps_setup_ns = dc->dc->debug.auxless_alpm_lfps_setup_ns;
+		copy_settings_data->auxless_alpm_data.lfps_period_ns = dc->dc->debug.auxless_alpm_lfps_period_ns;
+		copy_settings_data->auxless_alpm_data.lfps_silence_ns = dc->dc->debug.auxless_alpm_lfps_silence_ns;
+		copy_settings_data->auxless_alpm_data.lfps_t1_t2_override_us =
+			dc->dc->debug.auxless_alpm_lfps_t1t2_us;
+		copy_settings_data->auxless_alpm_data.lfps_t1_t2_offset_us =
+			dc->dc->debug.auxless_alpm_lfps_t1t2_offset_us;
+		copy_settings_data->auxless_alpm_data.lttpr_count = link->dc->link_srv->dp_get_lttpr_count(link);
+	}
+
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index f2503402c10e..0cce49d95e26 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -218,7 +218,10 @@ struct link_service {
 	bool (*dp_overwrite_extended_receiver_cap)(struct dc_link *link);
 	enum lttpr_mode (*dp_decide_lttpr_mode)(struct dc_link *link,
 			struct dc_link_settings *link_setting);
-
+	uint8_t (*dp_get_lttpr_count)(struct dc_link *link);
+	void (*edp_get_alpm_support)(struct dc_link *link,
+		bool *auxless_support,
+		bool *auxwake_support);
 
 	/*************************** DP DPIA/PHY ******************************/
 	void (*dpia_handle_usb4_bandwidth_allocation_for_link)(
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index de1143dbbd25..31a73867cd4c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -165,6 +165,8 @@ static void construct_link_service_dp_capability(struct link_service *link_srv)
 	link_srv->dp_overwrite_extended_receiver_cap =
 			dp_overwrite_extended_receiver_cap;
 	link_srv->dp_decide_lttpr_mode = dp_decide_lttpr_mode;
+	link_srv->dp_get_lttpr_count = dp_get_lttpr_count;
+	link_srv->edp_get_alpm_support = edp_get_alpm_support;
 }
 
 /* link dp phy/dpia implements basic dp phy/dpia functionality such as
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 651926e547b9..e0c4416993d9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2506,3 +2506,40 @@ bool dp_is_sink_present(struct dc_link *link)
 
 	return present;
 }
+
+uint8_t dp_get_lttpr_count(struct dc_link *link)
+{
+	if (dp_is_lttpr_present(link))
+		return dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+	return 0;
+}
+
+void edp_get_alpm_support(struct dc_link *link,
+	bool *auxless_support,
+	bool *auxwake_support)
+{
+	bool lttpr_present = dp_is_lttpr_present(link);
+
+	if (auxless_support == NULL || auxwake_support == NULL)
+		return;
+
+	*auxless_support = false;
+	*auxwake_support = false;
+
+	if (!dc_is_embedded_signal(link->connector_signal))
+		return;
+
+	if (link->dpcd_caps.alpm_caps.bits.AUX_LESS_ALPM_CAP) {
+		if (lttpr_present) {
+			if (link->dpcd_caps.lttpr_caps.alpm.bits.AUX_LESS_ALPM_SUPPORTED)
+				*auxless_support = true;
+		} else
+			*auxless_support = true;
+	}
+
+	if (link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP) {
+		if (!lttpr_present)
+			*auxwake_support = true;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
index 940b147cc5d4..7170db5a1c13 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
@@ -108,4 +108,10 @@ uint32_t link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
 
 bool dp_overwrite_extended_receiver_cap(struct dc_link *link);
 
+uint8_t dp_get_lttpr_count(struct dc_link *link);
+
+void edp_get_alpm_support(struct dc_link *link,
+	bool *auxless_support,
+	bool *auxwake_support);
+
 #endif /* __DC_LINK_DP_CAPABILITY_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 98ec9b5a559c..be714cbf6615 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1042,7 +1042,13 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 			(uint8_t *)&(replay_config.raw), sizeof(uint8_t));
 
 		memset(&alpm_config, 0, sizeof(alpm_config));
-		alpm_config.bits.ENABLE = 1;
+		alpm_config.bits.ENABLE = link->replay_settings.config.alpm_mode != DC_ALPM_UNSUPPORTED ? 1 : 0;
+
+		if (link->replay_settings.config.alpm_mode == DC_ALPM_AUXLESS) {
+			alpm_config.bits.ALPM_MODE_SEL = 1;
+			alpm_config.bits.ACDS_PERIOD_DURATION = 1;
+		}
+
 		dm_helpers_dp_write_dpcd(
 			link->ctx,
 			link,
-- 
2.43.0


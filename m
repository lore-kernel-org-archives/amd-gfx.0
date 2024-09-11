Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59977EE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B03B10EA56;
	Wed, 11 Sep 2024 16:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HYWryoZZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211AE10EA56
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3k1UfZDKERz1UIeQS7dO1VxULAzk99IAohdHzJOGDqTeX6Jzn7Voxto8utnN1VrEsCabakaWw3f3sk9fIq5YN8a1DlH17lPZJPLMRJvPJP+pSJTsSYR0xQfb+3WdSrxsbFSKI2JMMPsRZvqu3V52SSaX1G3N7o7tvFJpigCigDacD2mXreg6WYMG0F5hS2rm7HYZF7Drt2/GGcWYfbiYj2kMuw0rsJpco5XYwd02PDjzx16guavZVOuFm1d04/Is61iS9Wcf3SAJ99Tika0XuIMMenfZ6GkZO2AzX5SXB0Tbu2CMS1iiKOGkBPI/YS+MspDBVh/xr3rpIYqzMLI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX/qgQ+Ui8joQwmsrqxcCbYgdtfopju4oV2pUo86joc=;
 b=Fvd1kuFxrmU/jqTmJqLAA+PvVEjZsp5ozLOHfUBrsBUAGaYil03qc4OtS7JuLWVXDVXBMq7SEZVSY1/210UGc9yA+IFLZrtd1upy4+SJDg9VUSj6v1Q909QnETt1i7i9BuNvAu1pJdqRII/5mWu/NXYeNtLGGCOvmLBURLP+hfwlzfenAC77qjpka6RymdyEv4t+ct51w12xdeosueGm2wCcPwGcIxhvPFS+g01t9QBGKL18tL30LRHtLpPEv5IZal2usW4OZ7+gK/syo/jWqcyNEWvRjxBG7r7fBPoEg46BptPvBtNibQ3LvWZ/p51rJwALHAfc59+EUI0CFgdy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX/qgQ+Ui8joQwmsrqxcCbYgdtfopju4oV2pUo86joc=;
 b=HYWryoZZtma9H72yU7Odiht7hvaykV5Hh3ZM30cioSLjxZaw74KQQs09Ize1wet/rGDI4asBcDIx5JVwE6ecE9wEHtySNxrm+M1yES6otJ7nBsa1CBxqUZJuq+rAsoE41P4JlG7NnEbUndIfzAl2g+zdajnmdAyTbmTXm1uV+/w=
Received: from CH0PR04CA0073.namprd04.prod.outlook.com (2603:10b6:610:74::18)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 16:24:25 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::cb) by CH0PR04CA0073.outlook.office365.com
 (2603:10b6:610:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 16:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:24:25 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:24:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Cruise Hung
 <cruise.hung@amd.com>, George Shen <george.shen@amd.com>, "Meenakshikumar
 Somasundaram" <meenakshikumar.somasundaram@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 12/23] drm/amd/display: Restructure dpia link training
Date: Wed, 11 Sep 2024 10:20:54 -0600
Message-ID: <20240911162105.3567133-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 323e0628-5bb3-44b7-dc6e-08dcd27e33b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yNpzwaRyhNnCmW3/hWqu7/NcccaCKJMGvyxMPaxvVKjj0rG0NeO7h7x24LUq?=
 =?us-ascii?Q?fi9KOau0wekSi6OBe2oGjSYzLWbh3wt3enLOpvUAMC853BL3A+IVROVZxRQK?=
 =?us-ascii?Q?aQPVdXEQwE25s0x+Kyo9DmzCu1UG/6yYMiu8vwJV18KmSeIGsN4JF+S/0rn0?=
 =?us-ascii?Q?zk4FbYKiqfeXKUiogei5CojUOIU48xctT358JRw3ui92vOnFkGNLQQ3bctGh?=
 =?us-ascii?Q?oBEaezkufnlxe4NM91NXow40k4/WZ3IXpKCUdzt2ktHDvX1M9Hhfk363PBF2?=
 =?us-ascii?Q?bIxPIBr/KIGI8NI6xeSPPoNitm5zL8gPIzuGlk9hKyv3WNBve/0pmaGIc3gB?=
 =?us-ascii?Q?OHYlT9T6hgCD7/Res/s5KFgUsFHTjdnxO9BjaGLqDj/HLeNYtz2jjbO9sF7B?=
 =?us-ascii?Q?4vRDRn6+1k336h16OPVavZWlFDfMDr5cfzHHrw/FsF1eQsOpM6xp/onC1n86?=
 =?us-ascii?Q?4eFFUivbKIJ+V8yvF9FxzH/NSgFShfyR3hRZunflDiEzjn/xUmk2ayqsjxQZ?=
 =?us-ascii?Q?dp4HCWDYlcO/AWvpqu0QTAXjEhaDMH3RbnQrK4MSYFCBHPnyNxBgXVPAznr8?=
 =?us-ascii?Q?Vo7UgNiFxCbzjx/wMNEz434YpZPFz4ohF7a4HO7LU6OQdUVS2zRomEYat8La?=
 =?us-ascii?Q?vWIzDh+cJQGyMvTwouUoEqEXu1CbOhy6uTkPmCZJGhG2wt+SxBpMCVL/Lmr7?=
 =?us-ascii?Q?hG6u7kUElE2COtts9K/sx8arf541Ffqmw2gONilbvOmBPmIrDSr8Vu+kOq5Y?=
 =?us-ascii?Q?HPZB3h3k7XLs+Gi5KzRsP/zGqVNA2XAfJqV/xSE6dBtQGxJSmZOm/A1XYNSJ?=
 =?us-ascii?Q?BB2rFAKcBobYBAtG1z42OHflaUhPDUNNV17CFZuZbg5bno0BNH1P2OJFpkik?=
 =?us-ascii?Q?SjHPAn+gcMeFRCEnQfPhNRRTHV/VMkkmSxjkGW0qNhz/zTCPYoZ5QOws1DGs?=
 =?us-ascii?Q?ZJVrLyufjqsAjPb2AQR8+GP4dP8eIL4f9UeOQXlXaUrWNVJdBF65iIYxcDCg?=
 =?us-ascii?Q?o6ukkzTYa7CDb+l8Th+crEUlYAWE6z/2B0UvyS5qhQc5h8imWenFt1uKUQiD?=
 =?us-ascii?Q?QL7H91VW1UGxkltdxX1z+6DWPJSxMaT4BSXcVSgvNqANoA5EknhehA7sbLVG?=
 =?us-ascii?Q?AtnMzlg35nCPU9HLrkk3L/Hi4sjY81hPSekgYIGHoJPBkDHAqdK3d6m7N6pe?=
 =?us-ascii?Q?yi9gIoqe67pwK+wWNpUxqrXvJ+a0A30QR4hrXaAJTemB7zD8neBAiO0QwDEX?=
 =?us-ascii?Q?+UE5znrq8bDGFIQEervf9dav1aa9zCfFrlJ6oiLaiwzcFAwOEJH55RzYyQdi?=
 =?us-ascii?Q?JidU5G1qZnbIBWogQh+ELK0kwaXEoSFHQ75x1WfUwqQWrwDiq89ox4k5Qd+v?=
 =?us-ascii?Q?F/dlaRNEa0219VMS0uUbX2brKsVzTNyIileiOQP27WWs2TfPYFpywZZQvBeQ?=
 =?us-ascii?Q?5lB/cK7kIyhavIWdDAoIeMlIWMtWK3/b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:24:25.4033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323e0628-5bb3-44b7-dc6e-08dcd27e33b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
We intend to consolidate dp tunneling and conventional dp link training.

[HOW]
1. Use the same link training entry for both dp and dpia
2. Move SET_CONFIG of non-transparent mode to dmub side
3. Add set_tps_notification dmub_cmd to notify tps request for
   non-transparent dpia link training
4. Check dpcd request result and abort link training early if dpia
   aux tunneling fails
5. Add option to avoid affect old product
6. Separately handle wait_time_microsec for dpia

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: George Shen <george.shen@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c | 31 ++++++-
 .../dc/link/protocols/link_dp_training.c      | 80 ++++++++++++++++---
 .../dc/link/protocols/link_dp_training.h      | 16 +++-
 .../link/protocols/link_dp_training_8b_10b.c  | 21 ++---
 .../dc/link/protocols/link_dp_training_dpia.c | 64 ++++++++-------
 .../dc/link/protocols/link_dp_training_dpia.h | 19 +++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 25 +++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  1 +
 11 files changed, 233 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 243928b0a39f..eb7c7681bdd9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5755,6 +5755,27 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 	return DC_OK;
 }
 
+/**
+ * dc_process_dmub_dpia_set_tps_notification - Submits tps notification
+ *
+ * @dc: [in] dc structure
+ * @link_index: [in] link index
+ * @ts: [in] request tps
+ *
+ * Submits set_tps_notification command to dmub via inbox message
+ */
+void dc_process_dmub_dpia_set_tps_notification(const struct dc *dc, uint32_t link_index, uint8_t tps)
+{
+	union dmub_rb_cmd cmd = {0};
+
+	cmd.set_tps_notification.header.type = DMUB_CMD__DPIA;
+	cmd.set_tps_notification.header.sub_type = DMUB_CMD__DPIA_SET_TPS_NOTIFICATION;
+	cmd.set_tps_notification.tps_notification.instance = dc->links[link_index]->ddc_hw_inst;
+	cmd.set_tps_notification.tps_notification.tps = tps;
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
 /**
  * dc_process_dmub_dpia_hpd_int_enable - Submits DPIA DPD interruption
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7c4812dd1a71..133cac4d9fc4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -462,6 +462,7 @@ struct dc_config {
 	bool support_edp0_on_dp1;
 	unsigned int enable_fpo_flicker_detection;
 	bool disable_hbr_audio_dp2;
+	bool consolidated_dpia_dp_lt;
 };
 
 enum visual_confirm {
@@ -762,7 +763,8 @@ union dpia_debug_options {
 		uint32_t disable_mst_dsc_work_around:1; /* bit 3 */
 		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
 		uint32_t disable_usb4_pm_support:1; /* bit 5 */
-		uint32_t reserved:26;
+		uint32_t enable_consolidated_dpia_dp_lt:1; /* bit 6 */
+		uint32_t reserved:25;
 	} bits;
 	uint32_t raw;
 };
@@ -2525,6 +2527,8 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 				uint8_t mst_alloc_slots,
 				uint8_t *mst_slots_in_use);
 
+void dc_process_dmub_dpia_set_tps_notification(const struct dc *dc, uint32_t link_index, uint8_t tps);
+
 void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 				uint32_t hpd_int_enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
index 46fb3649bc86..6499807af72a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
@@ -50,8 +50,31 @@ static void update_dpia_stream_allocation_table(struct dc_link *link,
 	DC_LOG_MST("dpia : status[%d]: alloc_slots[%d]: used_slots[%d]\n",
 			status, mst_alloc_slots, prev_mst_slots_in_use);
 
-	ASSERT(link_enc);
-	link_enc->funcs->update_mst_stream_allocation_table(link_enc, table);
+	if (link_enc)
+		link_enc->funcs->update_mst_stream_allocation_table(link_enc, table);
+}
+
+static void set_dio_dpia_link_test_pattern(struct dc_link *link,
+		const struct link_resource *link_res,
+		struct encoder_set_dp_phy_pattern_param *tp_params)
+{
+	if (tp_params->dp_phy_pattern != DP_TEST_PATTERN_VIDEO_MODE)
+		return;
+
+	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(link);
+
+	if (!link_enc)
+		return;
+
+	link_enc->funcs->dp_set_phy_pattern(link_enc, tp_params);
+	link->dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
+}
+
+static void set_dio_dpia_lane_settings(struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct dc_link_settings *link_settings,
+		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
+{
 }
 
 static const struct link_hwss dpia_link_hwss = {
@@ -65,8 +88,8 @@ static const struct link_hwss dpia_link_hwss = {
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dio_dp_link_output,
-		.set_dp_link_test_pattern = set_dio_dp_link_test_pattern,
-		.set_dp_lane_settings = set_dio_dp_lane_settings,
+		.set_dp_link_test_pattern = set_dio_dpia_link_test_pattern,
+		.set_dp_lane_settings = set_dio_dpia_lane_settings,
 		.update_stream_allocation_table = update_dpia_stream_allocation_table,
 	},
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 988999c44475..27b881f947e8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -515,6 +515,41 @@ bool dp_is_interlane_aligned(union lane_align_status_updated align_status)
 	return align_status.bits.INTERLANE_ALIGN_DONE == 1;
 }
 
+bool dp_check_interlane_aligned(union lane_align_status_updated align_status,
+		struct dc_link *link,
+		uint8_t retries)
+{
+	/* Take into consideration corner case for DP 1.4a LL Compliance CTS as USB4
+	 * has to share encoders unlike DP and USBC
+	 */
+	return (dp_is_interlane_aligned(align_status) ||
+			(link->skip_fallback_on_link_loss && retries));
+}
+
+uint32_t dp_get_eq_aux_rd_interval(
+		const struct dc_link *link,
+		const struct link_training_settings *lt_settings,
+		uint32_t offset,
+		uint8_t retries)
+{
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+		if (offset == 0 && retries == 1 && lt_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT)
+			return max(lt_settings->eq_pattern_time, (uint32_t) DPIA_CLK_SYNC_DELAY);
+		else
+			return dpia_get_eq_aux_rd_interval(link, lt_settings, offset);
+	} else if (is_repeater(lt_settings, offset))
+		return dp_translate_training_aux_read_interval(
+				link->dpcd_caps.lttpr_caps.aux_rd_interval[offset - 1]);
+	else
+		return lt_settings->eq_pattern_time;
+}
+
+bool dp_check_dpcd_reqeust_status(const struct dc_link *link,
+		enum dc_status status)
+{
+	return (status != DC_OK && link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA);
+}
+
 enum link_training_result dp_check_link_loss_status(
 	struct dc_link *link,
 	const struct link_training_settings *link_training_setting)
@@ -973,13 +1008,17 @@ void repeater_training_done(struct dc_link *link, uint32_t offset)
 		dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
 }
 
-static void dpcd_exit_training_mode(struct dc_link *link, enum dp_link_encoding encoding)
+static enum link_training_result dpcd_exit_training_mode(struct dc_link *link, enum dp_link_encoding encoding)
 {
+	enum dc_status status;
 	uint8_t sink_status = 0;
 	uint8_t i;
 
 	/* clear training pattern set */
-	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
+	status = dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
+
+	if (dp_check_dpcd_reqeust_status(link, status))
+		return LINK_TRAINING_ABORT;
 
 	if (encoding == DP_128b_132b_ENCODING) {
 		/* poll for intra-hop disable */
@@ -990,6 +1029,8 @@ static void dpcd_exit_training_mode(struct dc_link *link, enum dp_link_encoding
 			fsleep(1000);
 		}
 	}
+
+	return LINK_TRAINING_SUCCESS;
 }
 
 enum dc_status dpcd_configure_channel_coding(struct dc_link *link,
@@ -1013,17 +1054,18 @@ enum dc_status dpcd_configure_channel_coding(struct dc_link *link,
 	return status;
 }
 
-void dpcd_set_training_pattern(
+enum dc_status dpcd_set_training_pattern(
 	struct dc_link *link,
 	enum dc_dp_training_pattern training_pattern)
 {
+	enum dc_status status;
 	union dpcd_training_pattern dpcd_pattern = {0};
 
 	dpcd_pattern.v1_4.TRAINING_PATTERN_SET =
 			dp_training_pattern_to_dpcd_training_pattern(
 					link, training_pattern);
 
-	core_link_write_dpcd(
+	status = core_link_write_dpcd(
 		link,
 		DP_TRAINING_PATTERN_SET,
 		&dpcd_pattern.raw,
@@ -1033,6 +1075,8 @@ void dpcd_set_training_pattern(
 		__func__,
 		DP_TRAINING_PATTERN_SET,
 		dpcd_pattern.v1_4.TRAINING_PATTERN_SET);
+
+	return status;
 }
 
 enum dc_status dpcd_set_link_settings(
@@ -1185,6 +1229,13 @@ void dpcd_set_lt_pattern_and_lane_settings(
 	dpcd_lt_buffer[DP_TRAINING_PATTERN_SET - DP_TRAINING_PATTERN_SET]
 		= dpcd_pattern.raw;
 
+	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		dpia_set_tps_notification(
+			link,
+			lt_settings,
+			dpcd_pattern.v1_4.TRAINING_PATTERN_SET,
+			offset);
+
 	if (is_repeater(lt_settings, offset)) {
 		DC_LOG_HW_LINK_TRAINING("%s\n LTTPR Repeater ID: %d\n 0x%X pattern = %x\n",
 			__func__,
@@ -1455,7 +1506,8 @@ static enum link_training_result dp_transition_to_video_idle(
 		 */
 		if (link->connector_signal != SIGNAL_TYPE_EDP && status == LINK_TRAINING_SUCCESS) {
 			msleep(5);
-			status = dp_check_link_loss_status(link, lt_settings);
+			if (!link->skip_fallback_on_link_loss)
+				status = dp_check_link_loss_status(link, lt_settings);
 		}
 		return status;
 	}
@@ -1521,7 +1573,9 @@ enum link_training_result dp_perform_link_training(
 		ASSERT(0);
 
 	/* exit training mode */
-	dpcd_exit_training_mode(link, encoding);
+	if ((dpcd_exit_training_mode(link, encoding) != LINK_TRAINING_SUCCESS || status == LINK_TRAINING_ABORT) &&
+			link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+		dpia_training_abort(link, &lt_settings, 0);
 
 	/* switch to video idle */
 	if ((status == LINK_TRAINING_SUCCESS) || !skip_video_pattern)
@@ -1599,8 +1653,7 @@ bool perform_link_training_with_retries(
 			dp_perform_link_training_skip_aux(link, &pipe_ctx->link_res, &cur_link_settings);
 			return true;
 		} else {
-			/** @todo Consolidate USB4 DP and DPx.x training. */
-			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
+			if (!link->dc->config.consolidated_dpia_dp_lt && link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
 				status = dpia_perform_link_training(
 						link,
 						&pipe_ctx->link_res,
@@ -1629,8 +1682,17 @@ bool perform_link_training_with_retries(
 			dp_trace_lt_total_count_increment(link, false);
 			dp_trace_lt_result_update(link, status, false);
 			dp_trace_set_lt_end_timestamp(link, false);
-			if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low)
+			if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low) {
+				// Update verified link settings to current one
+				// Because DPIA LT might fallback to lower link setting.
+				if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+						stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+					link->verified_link_cap.link_rate = link->cur_link_settings.link_rate;
+					link->verified_link_cap.lane_count = link->cur_link_settings.lane_count;
+					dm_helpers_dp_mst_update_branch_bandwidth(link->ctx, link);
+				}
 				return true;
+			}
 		}
 
 		fail_count++;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
index 851bd17317a0..0b18aa35c33c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
@@ -55,7 +55,7 @@ void dp_set_hw_test_pattern(
 		uint8_t *custom_pattern,
 		uint32_t custom_pattern_size);
 
-void dpcd_set_training_pattern(
+enum dc_status dpcd_set_training_pattern(
 	struct dc_link *link,
 	enum dc_dp_training_pattern training_pattern);
 
@@ -182,4 +182,18 @@ uint32_t dp_translate_training_aux_read_interval(
 
 uint8_t dp_get_nibble_at_index(const uint8_t *buf,
 	uint32_t index);
+
+bool dp_check_interlane_aligned(union lane_align_status_updated align_status,
+		struct dc_link *link,
+		uint8_t retries);
+
+uint32_t dp_get_eq_aux_rd_interval(
+		const struct dc_link *link,
+		const struct link_training_settings *lt_settings,
+		uint32_t offset,
+		uint8_t retries);
+
+bool dp_check_dpcd_reqeust_status(const struct dc_link *link,
+		enum dc_status status);
+
 #endif /* __DC_LINK_DP_TRAINING_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 2b4c15b0b407..3bdce32a85e3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -157,6 +157,7 @@ enum link_training_result perform_8b_10b_clock_recovery_sequence(
 	struct link_training_settings *lt_settings,
 	uint32_t offset)
 {
+	enum dc_status status;
 	uint32_t retries_cr;
 	uint32_t retry_count;
 	uint32_t wait_time_microsec;
@@ -216,7 +217,7 @@ enum link_training_result perform_8b_10b_clock_recovery_sequence(
 		/* 4. Read lane status and requested drive
 		* settings as set by the sink
 		*/
-		dp_get_lane_status_and_lane_adjust(
+		status = dp_get_lane_status_and_lane_adjust(
 				link,
 				lt_settings,
 				dpcd_lane_status,
@@ -224,6 +225,9 @@ enum link_training_result perform_8b_10b_clock_recovery_sequence(
 				dpcd_lane_adjust,
 				offset);
 
+		if (dp_check_dpcd_reqeust_status(link, status))
+			return LINK_TRAINING_ABORT;
+
 		/* 5. check CR done*/
 		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
 			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
@@ -273,6 +277,7 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 	struct link_training_settings *lt_settings,
 	uint32_t offset)
 {
+	enum dc_status status;
 	enum dc_dp_training_pattern tr_pattern;
 	uint32_t retries_ch_eq;
 	uint32_t wait_time_microsec;
@@ -308,12 +313,7 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 			dpcd_set_lane_settings(link, lt_settings, offset);
 
 		/* 3. wait for receiver to lock-on*/
-		wait_time_microsec = lt_settings->eq_pattern_time;
-
-		if (is_repeater(lt_settings, offset))
-			wait_time_microsec =
-					dp_translate_training_aux_read_interval(
-						link->dpcd_caps.lttpr_caps.aux_rd_interval[offset - 1]);
+		wait_time_microsec = dp_get_eq_aux_rd_interval(link, lt_settings, offset, retries_ch_eq);
 
 		dp_wait_for_training_aux_rd_interval(
 				link,
@@ -322,7 +322,7 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 		/* 4. Read lane status and requested
 		 * drive settings as set by the sink*/
 
-		dp_get_lane_status_and_lane_adjust(
+		status = dp_get_lane_status_and_lane_adjust(
 			link,
 			lt_settings,
 			dpcd_lane_status,
@@ -330,6 +330,9 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 			dpcd_lane_adjust,
 			offset);
 
+		if (dp_check_dpcd_reqeust_status(link, status))
+			return LINK_TRAINING_ABORT;
+
 		/* 5. check CR done*/
 		if (!dp_is_cr_done(lane_count, dpcd_lane_status))
 			return dpcd_lane_status[0].bits.CR_DONE_0 ?
@@ -339,7 +342,7 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
 		/* 6. check CHEQ done*/
 		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
 				dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
-				dp_is_interlane_aligned(dpcd_lane_status_updated))
+				dp_check_interlane_aligned(dpcd_lane_status_updated, link, retries_ch_eq))
 			return LINK_TRAINING_SUCCESS;
 
 		/* 7. update VS/PE/PC2 in lt_settings*/
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index cd1975c03f38..39e4b7dc9588 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -43,9 +43,6 @@
 #define DC_LOGGER \
 	link->ctx->logger
 
-/* The approximate time (us) it takes to transmit 9 USB4 DP clock sync packets. */
-#define DPIA_CLK_SYNC_DELAY 16000
-
 /* Extend interval between training status checks for manual testing. */
 #define DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US 60000000
 
@@ -566,28 +563,6 @@ static enum link_training_result dpia_training_cr_phase(
 	return result;
 }
 
-/* Return status read interval during equalization phase. */
-static uint32_t dpia_get_eq_aux_rd_interval(
-		const struct dc_link *link,
-		const struct link_training_settings *lt_settings,
-		uint32_t hop)
-{
-	uint32_t wait_time_microsec;
-
-	if (hop == DPRX)
-		wait_time_microsec = lt_settings->eq_pattern_time;
-	else
-		wait_time_microsec =
-				dp_translate_training_aux_read_interval(
-					link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
-
-	/* Check debug option for extending aux read interval. */
-	if (link->dc->debug.dpia_debug.bits.extend_aux_rd_interval)
-		wait_time_microsec = DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US;
-
-	return wait_time_microsec;
-}
-
 /* Execute equalization phase of link training for specified hop in display
  * path in non-transparent mode:
  * - driver issues both DPCD and SET_CONFIG transactions.
@@ -936,6 +911,22 @@ static enum link_training_result dpia_training_end(
 	return result;
 }
 
+/* Return status read interval during equalization phase. */
+uint32_t dpia_get_eq_aux_rd_interval(
+		const struct dc_link *link,
+		const struct link_training_settings *lt_settings,
+		uint32_t hop)
+{
+	/* Check debug option for extending aux read interval. */
+	if (link->dc->debug.dpia_debug.bits.extend_aux_rd_interval)
+		return DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US;
+	else if (hop == DPRX)
+		return lt_settings->eq_pattern_time;
+	else
+		return dp_translate_training_aux_read_interval(
+					link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
+}
+
 /* When aborting training of specified hop in display path, clean up by:
  * - Attempting to clear DPCD TRAINING_PATTERN_SET, LINK_BW_SET and LANE_COUNT_SET.
  * - Sending SET_CONFIG(SET_LINK) with lane count and link rate set to 0.
@@ -943,7 +934,7 @@ static enum link_training_result dpia_training_end(
  * @param link DPIA link being trained.
  * @param hop Hop in display path. DPRX = 0.
  */
-static void dpia_training_abort(
+void dpia_training_abort(
 		struct dc_link *link,
 		struct link_training_settings *lt_settings,
 		uint32_t hop)
@@ -968,7 +959,26 @@ static void dpia_training_abort(
 	core_link_write_dpcd(link, dpcd_tps_offset, &data, 1);
 	core_link_write_dpcd(link, DP_LINK_BW_SET, &data, 1);
 	core_link_write_dpcd(link, DP_LANE_COUNT_SET, &data, 1);
-	core_link_send_set_config(link, DPIA_SET_CFG_SET_LINK, data);
+
+	if (!link->dc->config.consolidated_dpia_dp_lt)
+		core_link_send_set_config(link, DPIA_SET_CFG_SET_LINK, data);
+}
+
+void dpia_set_tps_notification(
+		struct dc_link *link,
+		const struct link_training_settings *lt_settings,
+		uint8_t pattern,
+		uint32_t hop)
+{
+	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
+
+	if (lt_settings->lttpr_mode != LTTPR_MODE_NON_TRANSPARENT || pattern == DPCD_TRAINING_PATTERN_VIDEOIDLE)
+		return;
+
+	repeater_cnt = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+
+	if (hop != repeater_cnt)
+		dc_process_dmub_dpia_set_tps_notification(link->ctx->dc, link->link_index, pattern);
 }
 
 enum link_training_result dpia_perform_link_training(
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h
index b39fb9faf1c2..9f4eceb494c2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.h
@@ -28,6 +28,9 @@
 #define __DC_LINK_DP_TRAINING_DPIA_H__
 #include "link_dp_training.h"
 
+/* The approximate time (us) it takes to transmit 9 USB4 DP clock sync packets. */
+#define DPIA_CLK_SYNC_DELAY 16000
+
 /* Train DP tunneling link for USB4 DPIA display endpoint.
  * DPIA equivalent of dc_link_dp_perfrorm_link_training.
  * Aborts link training upon detection of sink unplug.
@@ -38,4 +41,20 @@ enum link_training_result dpia_perform_link_training(
 	const struct dc_link_settings *link_setting,
 	bool skip_video_pattern);
 
+void dpia_training_abort(
+		struct dc_link *link,
+		struct link_training_settings *lt_settings,
+		uint32_t hop);
+
+uint32_t dpia_get_eq_aux_rd_interval(
+		const struct dc_link *link,
+		const struct link_training_settings *lt_settings,
+		uint32_t hop);
+
+void dpia_set_tps_notification(
+		struct dc_link *link,
+		const struct link_training_settings *lt_settings,
+		uint8_t pattern,
+		uint32_t offset);
+
 #endif /* __DC_LINK_DP_TRAINING_DPIA_H__ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index cd70453aeae0..fe5b6f7a3eb1 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -300,6 +300,7 @@ struct dmub_srv_hw_params {
 	enum dmub_ips_disable_type disable_ips;
 	bool disallow_phy_access;
 	bool disable_sldo_opt;
+	bool enable_non_transparent_setconfig;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e20c220aa8b4..ebcf68bfae2b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -682,7 +682,7 @@ union dmub_fw_boot_options {
 		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
 		uint32_t usb4_cm_version: 1; /**< 1 CM support */
 		uint32_t dpia_hpd_int_enable_supported: 1; /* 1 if dpia hpd int enable supported */
-		uint32_t reserved0: 1;
+		uint32_t enable_non_transparent_setconfig: 1; /* 1 if dpia use conventional dp lt flow*/
 		uint32_t disable_clk_ds: 1; /* 1 if disallow dispclk_ds and dppclk_ds*/
 		uint32_t disable_timeout_recovery : 1; /* 1 if timeout recovery should be disabled */
 		uint32_t ips_pg_disable: 1; /* 1 to disable ONO domains power gating*/
@@ -1308,6 +1308,7 @@ enum dmub_cmd_dpia_type {
 	DMUB_CMD__DPIA_DIG1_DPIA_CONTROL = 0,
 	DMUB_CMD__DPIA_SET_CONFIG_ACCESS = 1,
 	DMUB_CMD__DPIA_MST_ALLOC_SLOTS = 2,
+	DMUB_CMD__DPIA_SET_TPS_NOTIFICATION = 3,
 };
 
 /* DMUB_OUT_CMD__DPIA_NOTIFICATION command types. */
@@ -2138,6 +2139,24 @@ struct dmub_rb_cmd_set_mst_alloc_slots {
 	struct dmub_cmd_mst_alloc_slots_control_data mst_slots_control; /* mst slots control */
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__SET_TPS_NOTIFICATION command.
+ */
+struct dmub_cmd_tps_notification_data {
+	uint8_t instance; /* DPIA instance */
+	uint8_t tps; /* requested training pattern */
+	uint8_t reserved1;
+	uint8_t reserved2;
+};
+
+/**
+ * DMUB command structure for SET_TPS_NOTIFICATION command.
+ */
+struct dmub_rb_cmd_set_tps_notification {
+	struct dmub_cmd_header header; /* header */
+	struct dmub_cmd_tps_notification_data tps_notification; /* set tps_notification data */
+};
+
 /**
  * DMUB command structure for DPIA HPD int enable control.
  */
@@ -5304,6 +5323,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__DPIA_MST_ALLOC_SLOTS command.
 	 */
 	struct dmub_rb_cmd_set_mst_alloc_slots set_mst_alloc_slots;
+	/**
+	 * Definition of a DMUB_CMD__DPIA_SET_TPS_NOTIFICATION command.
+	 */
+	struct dmub_rb_cmd_set_tps_notification set_tps_notification;
 	/**
 	 * Definition of a DMUB_CMD__EDID_CEA command.
 	 */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 746696b6f09a..2ccad79053c5 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -425,6 +425,7 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.ips_disable = params->disable_ips;
 	boot_options.bits.ips_sequential_ono = params->ips_sequential_ono;
 	boot_options.bits.disable_sldo_opt = params->disable_sldo_opt;
+	boot_options.bits.enable_non_transparent_setconfig = params->enable_non_transparent_setconfig;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
-- 
2.34.1


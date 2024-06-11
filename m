Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED45C27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D381910E6D0;
	Tue, 11 Jun 2024 16:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DbTSnjqe";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FABF10E6DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLDO2/OAq8sxkWucgRHpq+t8nsZwbkNimFbHUy5AVWIywrGLAYyusFXvEo03IvuxqGN/dyEagmoz0LSixtSd+YMcAxw+iJ7Az/v5jAX89PXk67egIktZH+hICZokhuDzabL+HbJ+GH84akCe07D8lTMBgK9YC2CP1R0mPobbD9GvO2l5ucrI+bW4lVBpW4ZqDRVoBefhEETZgSnb3IRkxLCm/Eg/9751BflWNwDjfGDYsSjf7Z6nuf8uvDl82GlfaAi3MsIFJNqVXPpGNkdUNEQIoq4+lX6YVQR9kk1kdF83G0pYTVqh+q6RVYtPhTlLG5VzmezCj1HXaTcYslw/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl6Ndoo6wiRXn6jYWxNlttfrMm48WV6BcACzsyTJ+Pw=;
 b=IHyhaiOqeOtTbCqEbL2syN9+qTAue21wwQs88IyqnRGc0sXaLFAN4CdUIs47enkWzO+HSyp0orLX1wLFIb191l7/QAKZBp/DjJb0npcOW0pjHr8TvQK1yF1gqPJlBPzf56QTwf32GCgWRAd39BmVhW23KKjbmUy5aO9k7eJVG1WYzufAppexd48Og7P1u+RWzRcfgmi2gGKZ81mZDIzz8OXVmMV2erl+eVN5ywjT+klmE5YTV1IN6mWwJpJYD2hsi2mcyVciQnB2pMtDe5DLjWwiH259ugqgNFnOO1JKbfShcRO4Xr2Q/881MFR8Z9PdfxX9/zVZP3iDTwu7u/kKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pl6Ndoo6wiRXn6jYWxNlttfrMm48WV6BcACzsyTJ+Pw=;
 b=DbTSnjqeiT4XbQVN6qLggPA9Y4dPjGPcL5Jrr+qUPx3Wlyq2h1woWjUIbiq+oG/73onVlk1QRO1adWLPpnnjuqnQ92yn3SxOJXslOCcyaznhfm0+zKVIaNfPfTlEf6JUyomb3s+mjWEaoGsEFTKfNyx62hwdyB6+AR8/iDFrY98=
Received: from BL1PR13CA0170.namprd13.prod.outlook.com (2603:10b6:208:2bd::25)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:50 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::da) by BL1PR13CA0170.outlook.office365.com
 (2603:10b6:208:2bd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:49 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:47 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 30/36] drm/amd/display: Remove redundant null checks
Date: Tue, 11 Jun 2024 12:51:33 -0400
Message-ID: <20240611165204.195093-31-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: a067536b-78f2-4e8d-4efd-08dc8a36edb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JLASvfB6XjyfXIzcxUZjqmfxSO0lkYZ8nqo8szaZX7ysrjvrWdmNvQ+qOs+6?=
 =?us-ascii?Q?+N3dsJjOm0vp76pSR2MQLj7KZ6P/UbpEn/cyFcdnY3p34tbGV2TxRIOS2XKP?=
 =?us-ascii?Q?ZkATeo7c3lL15NlG7mrM7sye6Czunm0g5NQsfbGclF+GJsE8MfMB6Rx+OhR8?=
 =?us-ascii?Q?zD3QfXE8qRGjEaojcsQf/oH+TcRfLecPPtk9me3TuOmFnbF1dJzCYa3q7qLG?=
 =?us-ascii?Q?Z+PpGhRdFEfy62RBeZBpsBTXbg8Yg/cpQA2KLr0mkZEC9ch0VtOCp9JtmNLt?=
 =?us-ascii?Q?Oj7qOBm5jABc2gOTy/ikwbNzlP8vcukvqX04sZ13vI7GU9utGSQFED3MNyLO?=
 =?us-ascii?Q?PQ2vjf6LUjLZhXjbEuOAlv3/zLheHhP8092PJvgNwMQhaJOjltOGZ/P9HeJm?=
 =?us-ascii?Q?UI2lQWEH+PTfSSQ8HETolTwDNOnoychbaYMU49pdrpuXiYrV1a6o8BVDc9zc?=
 =?us-ascii?Q?wR1u2kiQVDu2tOWQZbR+DFhNbBKiD1xQ014tVtCh3cPq15Dv80aGcfQbKFW5?=
 =?us-ascii?Q?fn9c7pzemof9VOIh0wn5WC9pUNlarF7UQVTalSZwmHUS52LRCLewB0cIkpIN?=
 =?us-ascii?Q?JmQA/KyqNykOjk2wTtiStlqoHRMSrftNLy3m+Bx+jqrS3kyC1uucKyszEKqW?=
 =?us-ascii?Q?lUYY15dTn8d1LHY5DP4BQzM47g4N0qtlzYMeiF9DEWAXLUBiUB9Tfv3oNFdr?=
 =?us-ascii?Q?Ipd3zsJRHgdEWCobqqUaPtyEygegED2aagfUlmaBRqqtXLx9XVTFNxt/b5jj?=
 =?us-ascii?Q?VlGFnRWUYsUom+W94gFDxa/rISMNx4Gm+e10NOvWPXDWfAGfMscxN9eEtRcF?=
 =?us-ascii?Q?jzvKH6z8ukpwouPeWAG3TJX1E510ixAgkozxKpMj+TL7sWZfwbIk9qlihR+q?=
 =?us-ascii?Q?qtz/eWlxwr52uCDCQek9h26DKLJ0Vmv0FNPBugzPm5dedEWGaIkst1Q24FUJ?=
 =?us-ascii?Q?ImNRuwRlcagifvRKQ26n9fHIMaYkhSL4P7XzYCM3H0mURrODmQd9HF+8dAnp?=
 =?us-ascii?Q?G1K5G9SI09vPjaDVfTPurUzsUhrEoKssXz03M503Q7GsGAGiuXFhusgZ+WZZ?=
 =?us-ascii?Q?Jr8GGcQ4o3nuWJSrRuVLMzPgGMAWa7URgmBsIv8qYz1XnSrD3l5Rtso8jQqA?=
 =?us-ascii?Q?dWSZyNU1IIyp0K6o3NLnQjkyl+Q95qfcZg0TJW0X1jOPxcRviEH8WpxKpOJx?=
 =?us-ascii?Q?6Ev5WThuLEoDSQ7us9oRyofpYhY6my3LusThkBvzPbVgXG87Ncc21SKFlAqn?=
 =?us-ascii?Q?HVzLiipah9biyanO086YyhQl1EpMP+/6ExOJws3YWwUHTPlrnUdgKiAvtTmM?=
 =?us-ascii?Q?C+x1mJxdxTGAjUObcIytSuZfByv3Vc+r+WvSh8zvuu8DfOM/VOUiyQ6fpgBc?=
 =?us-ascii?Q?YNikP+FikGo3IZwPOl2ib9KnRU5Tyk/Z8iyxNOhxekExj9QLpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:49.8413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a067536b-78f2-4e8d-4efd-08dc8a36edb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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

From: Alex Hung <alex.hung@amd.com>

The null checks are redundant as they were already dereferenced
previously, as reported by Coverity; therefore the null checks
are removed.

This fixes 7 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 81 +++++++++----------
 6 files changed, 47 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index ee4b02c8c807..06f0c41ad6f1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -553,7 +553,7 @@ static void dcn32_auto_dpm_test_log(
 	//
 	//				AutoDPMTest: clk1:%d - clk2:%d - clk3:%d - clk4:%d\n"
 	////////////////////////////////////////////////////////////////////////////
-	if (new_clocks && active_pipe_count > 0 &&
+	if (active_pipe_count > 0 &&
 		new_clocks->dramclk_khz > 0 &&
 		new_clocks->fclk_khz > 0 &&
 		new_clocks->dcfclk_khz > 0 &&
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index fce1c3e03094..a4ba6f99cd34 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2640,7 +2640,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 
 		if (u->plane_info)
 			format = u->plane_info->format;
-		else if (u->surface)
+		else
 			format = u->surface->format;
 
 		if (dce_use_lut(format))
@@ -2741,7 +2741,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 		if (stream_update->mst_bw_update)
 			su_flags->bits.mst_bw = 1;
 
-		if (stream_update->stream && stream_update->stream->freesync_on_desktop &&
+		if (stream_update->stream->freesync_on_desktop &&
 			(stream_update->vrr_infopacket || stream_update->allow_freesync ||
 				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
 			su_flags->bits.fams_changed = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1cba8f58f1e6..eb053e1791c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2099,7 +2099,7 @@ int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 			timing->h_border_right;
 	width = h_active / count;
 
-	if (otg_master->stream_res.tg && otg_master->stream)
+	if (otg_master->stream_res.tg)
 		two_pixel_alignment_required =
 				otg_master->stream_res.tg->funcs->is_two_pixels_per_container(timing) ||
 				/*
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index a7d02da16bb5..d5ead0205053 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -102,9 +102,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 	struct dml2_soc_state_table *dml_clk_table = &dml_soc_bb->clk_table;
 
 	/* override clocks if smu is present */
-	if (in_dc->clk_mgr &&
-			in_dc->clk_mgr->funcs->is_smu_present &&
-			in_dc->clk_mgr->funcs->is_smu_present(in_dc->clk_mgr)) {
+	if (in_dc->clk_mgr->funcs->is_smu_present && in_dc->clk_mgr->funcs->is_smu_present(in_dc->clk_mgr)) {
 		/* dcfclk */
 		if (dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
 			dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 871f1e1ca2e0..307af11b4bb6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -742,12 +742,10 @@ void dce110_edp_wait_for_hpd_ready(
 		return;
 	}
 
-	if (link != NULL) {
-		if (link->panel_config.pps.extra_t3_ms > 0) {
-			int extra_t3_in_ms = link->panel_config.pps.extra_t3_ms;
+	if (link->panel_config.pps.extra_t3_ms > 0) {
+		int extra_t3_in_ms = link->panel_config.pps.extra_t3_ms;
 
-			msleep(extra_t3_in_ms);
-		}
+		msleep(extra_t3_in_ms);
 	}
 
 	dal_gpio_open(hpd, GPIO_MODE_INTERRUPT);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a597b2342472..64a158625fc2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -271,58 +271,55 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	}
 
 	if (enable) {
-		if (dc->current_state) {
+		/* 1. Check no memory request case for CAB.
+		 * If no memory request case, send CAB_ACTION NO_DF_REQ DMUB message
+		 */
+		if (dcn32_check_no_memory_request_for_cab(dc)) {
+			/* Enable no-memory-requests case */
+			memset(&cmd, 0, sizeof(cmd));
+			cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
+			cmd.cab.header.sub_type = DMUB_CMD__CAB_NO_DCN_REQ;
+			cmd.cab.header.payload_bytes = sizeof(cmd.cab) - sizeof(cmd.cab.header);
 
-			/* 1. Check no memory request case for CAB.
-			 * If no memory request case, send CAB_ACTION NO_DF_REQ DMUB message
-			 */
-			if (dcn32_check_no_memory_request_for_cab(dc)) {
-				/* Enable no-memory-requests case */
-				memset(&cmd, 0, sizeof(cmd));
-				cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
-				cmd.cab.header.sub_type = DMUB_CMD__CAB_NO_DCN_REQ;
-				cmd.cab.header.payload_bytes = sizeof(cmd.cab) - sizeof(cmd.cab.header);
+			dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 
-				dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+			return true;
+		}
 
-				return true;
-			}
+		/* 2. Check if all surfaces can fit in CAB.
+		 * If surfaces can fit into CAB, send CAB_ACTION_ALLOW DMUB message
+		 * and configure HUBP's to fetch from MALL
+		 */
+		ways = dcn32_calculate_cab_allocation(dc, dc->current_state);
 
-			/* 2. Check if all surfaces can fit in CAB.
-			 * If surfaces can fit into CAB, send CAB_ACTION_ALLOW DMUB message
-			 * and configure HUBP's to fetch from MALL
-			 */
-			ways = dcn32_calculate_cab_allocation(dc, dc->current_state);
+		/* MALL not supported with Stereo3D or TMZ surface. If any plane is using stereo,
+		 * or TMZ surface, don't try to enter MALL.
+		 */
+		for (i = 0; i < dc->current_state->stream_count; i++) {
+			for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
+				plane = dc->current_state->stream_status[i].plane_states[j];
 
-			/* MALL not supported with Stereo3D or TMZ surface. If any plane is using stereo,
-			 * or TMZ surface, don't try to enter MALL.
-			 */
-			for (i = 0; i < dc->current_state->stream_count; i++) {
-				for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
-					plane = dc->current_state->stream_status[i].plane_states[j];
-
-					if (plane->address.type == PLN_ADDR_TYPE_GRPH_STEREO ||
-							plane->address.tmz_surface) {
-						mall_ss_unsupported = true;
-						break;
-					}
-				}
-				if (mall_ss_unsupported)
+				if (plane->address.type == PLN_ADDR_TYPE_GRPH_STEREO ||
+						plane->address.tmz_surface) {
+					mall_ss_unsupported = true;
 					break;
+				}
 			}
-			if (ways <= dc->caps.cache_num_ways && !mall_ss_unsupported) {
-				memset(&cmd, 0, sizeof(cmd));
-				cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
-				cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
-				cmd.cab.header.payload_bytes = sizeof(cmd.cab) - sizeof(cmd.cab.header);
-				cmd.cab.cab_alloc_ways = (uint8_t)ways;
-
-				dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+			if (mall_ss_unsupported)
+				break;
+		}
+		if (ways <= dc->caps.cache_num_ways && !mall_ss_unsupported) {
+			memset(&cmd, 0, sizeof(cmd));
+			cmd.cab.header.type = DMUB_CMD__CAB_FOR_SS;
+			cmd.cab.header.sub_type = DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB;
+			cmd.cab.header.payload_bytes = sizeof(cmd.cab) - sizeof(cmd.cab.header);
+			cmd.cab.cab_alloc_ways = (uint8_t)ways;
 
-				return true;
-			}
+			dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 
+			return true;
 		}
+
 		return false;
 	}
 
-- 
2.45.1


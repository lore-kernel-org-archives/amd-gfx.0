Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A81C7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E936810ED55;
	Thu, 20 Apr 2023 23:50:49 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D769D10ED55
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyrlzqeNn2ILbmnht4dpgaN3A42aW1XMUsWsKAeEVDuQoiiOZ4AZ4ZfamTLuSQTdD2oCKbSC4CUwONa2HNc8uRUEWw7ya7dJeVS0D1RQotoOQilBm0WLDKfnuK6OQLjo9dx41yyObzR1OsyKrS8gAWJ9EMU9MfF9qEJFzffn1Tix3J+Bh7RS1VFE6+yXmBstWX36u8cbiMHoU3zqKDZORg4ZTly5FKqrhILrdAtwIt+1Bvgg0x0J2SuiEJ8I/7tJ7duWnZoZ86kPkAQnh11f/5hn3bG3/eVkCRldiMTrD7HeXsgUnqRJoVaFgHNg0iBejiCAOtHHPJWtuJbPRYQsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeNb92TS3e4zpc/dfFeqlMIR5lHDLGRgxUH1TSxnooU=;
 b=cxOHXlbTLTUrt74qZF0EGn7F8oj2g1GVihc6IMmV8nfP1Uvtu14jaZ4iskDi/yByorRE3w3tV63/P4+SuPDw2kG+2HkPA+66Egyi3Y1BaE8JpRleq5dZOlWlozINloWNwU/QVrIqdBE7BQr0d7UuSB+CgngiULcj+0amDX9TijVo73mYzuHSci9XNCbLfxJDJJ335YwJ83fY2RFZ/XwTN5G4N6l9EzTkMa//wt9J1MsZx0I9JjRV3ZezRP/07m+yhwh8p3/5P2EmnIVB1QbmmhFm6PgS0VMDdmHrL2cucbNok6yMK9l3HwqvmW1+olxvkvhAWgBuWY71Aakj4u4/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeNb92TS3e4zpc/dfFeqlMIR5lHDLGRgxUH1TSxnooU=;
 b=pFT285er9GTg3Wky5LixPaDser/1inx2o49qUtZjDkxdcB5sxj6dbvk7NMafcIgURlY16K4zqlUIJYG+fYcsoU+IxQUSKpDBJ0dHNkNzSEIRZw1BIaKIqD2TSDowteIiA4QF8Dn3UDMPUOjN4DJx+Hp7wKeP1rTb6jlXCG4VCk4=
Received: from DM6PR02CA0150.namprd02.prod.outlook.com (2603:10b6:5:332::17)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:43 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::ff) by DM6PR02CA0150.outlook.office365.com
 (2603:10b6:5:332::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:42 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/21] drm/amd/display: Enable SubVP for high refresh rate
 displays
Date: Thu, 20 Apr 2023 17:49:49 -0600
Message-ID: <20230420234951.1772270-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9371d6bc-7be1-4c1c-a6dc-08db41fa0d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsGaLs5Qd19sVQe+BOdwCed2RJWBZHWUbXnpulxdWnvW4GrlAxoNCpvM/P3kqj1s5kc00ZtiOyOKRZVJQIEtrJdBFVkyS1e2gBiJ+rN0T4HGRoU4uOxxqMzTs5x0IFKZ4s6+xyXl25XXvNjqx0NcmPZFxkQOALNhBI1QS4sxq6UWaKNv34GMxWRNMQfI48o7Scnm3xXHpS8wHuMuG+A6xoSD73BoiBfXOu1frfcLnJTyAFkXup4XrkNR//exLb0xbe4EpfOgNhV+m4o9GA2VXHkPy5iKIPLUm2D5BLz7TB/7at2QEfHvMRJXkisepfqjmO+zalnCAkHd7Nh0yqHF6FfGuX+p3Cv4/VyWlHNwdEaL8ojyC6UrecOIEAFrbh5sDU7UCTyNskhRe33tXgfmiDGoklXaHIyBo6ZiClFqdOZmpoY8/aIF1rdPdQXSLc/CnO8l5T8s7BQHB8R623Qi6Yvii0JGk3fg+xKqb7TfZcnVr6zHr3xqb8VXv1DDtW+R+CEHoMhjFZvzfylHgKh0ttOQx4yfXt5jiDbX91AAic17J+flkR+RkEbZqimqb/OiSGGjxHcbnlgmsqbuS/siXN2DoTIuzNGSXbTc6Za59DjN/Glswo+TkY8YSsJABflc9UVC/W/gCINBN5Oiljc29kCpns7zbLJ8PF8b6BF+1iLe40lbQPnsnFGCbGXtFjBHVNAi1j146NfHijbHnsRiXi3xQLpkakEQV6tQmuUJXpd4CD9MrNyNexENIu+jevLusSRZ3ue6hs5oYEmfUAx3jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(4326008)(316002)(6916009)(70206006)(70586007)(54906003)(478600001)(40480700001)(82310400005)(8936002)(8676002)(5660300002)(41300700001)(2906002)(82740400003)(86362001)(81166007)(2616005)(47076005)(426003)(336012)(26005)(16526019)(40460700003)(1076003)(36860700001)(83380400001)(356005)(186003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:42.8209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9371d6bc-7be1-4c1c-a6dc-08db41fa0d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Add debug option to enable SubVP for high refresh rate displays
- For now limit the enabled modes based on a table in debug options
- Currently disabled by default

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 14 +++++
 .../display/dc/dcn32/dcn32_resource_helpers.c | 15 +++++
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 62 ++++++++++++++++++-
 .../dc/dml/dcn32/display_mode_vba_32.c        | 12 ++--
 7 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 17afe7915f48..f52ab717ac7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -882,6 +882,7 @@ struct dc_debug_options {
 	bool disable_boot_optimizations;
 	bool override_odm_optimization;
 	bool minimize_dispclk_using_odm;
+	bool disable_subvp_high_refresh;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0085ea78ea31..7feeba78c0c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -728,6 +728,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_margin_us = 2000, // 2000us
 	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
+	.disable_subvp_high_refresh = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 3937dbc1e552..04be01ae1ecf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -40,6 +40,7 @@
 #define DCN3_2_VMIN_DISPCLK_HZ 717000000
 #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
 #define DCN3_2_MIN_ACTIVE_SWITCH_MARGIN_FPO_US 100 // Only allow FPO + Vactive if active margin >= 100
+#define SUBVP_HIGH_REFRESH_LIST_LEN 3
 
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
@@ -47,6 +48,15 @@
 extern struct _vcs_dpi_ip_params_st dcn3_2_ip;
 extern struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc;
 
+struct subvp_high_refresh_list {
+	int min_refresh;
+	int max_refresh;
+	struct resolution {
+		int width;
+		int height;
+	} res[SUBVP_HIGH_REFRESH_LIST_LEN];
+};
+
 struct dcn32_resource_pool {
 	struct resource_pool base;
 };
@@ -151,10 +161,14 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 
 bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe);
 
+bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe);
+
 unsigned int dcn32_calc_num_avail_chans_for_mall(struct dc *dc, int num_chans);
 
 double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *context);
 
+bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int width, unsigned int height);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index eeca16faf31a..df912c333bbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -656,3 +656,18 @@ struct dc_stream_state *dcn32_can_support_mclk_switch_using_fw_based_vblank_stre
 
 	return fpo_candidate_stream;
 }
+
+bool dcn32_check_native_scaling_for_res(struct pipe_ctx *pipe, unsigned int width, unsigned int height)
+{
+	bool is_native_scaling = false;
+
+	if (pipe->stream->timing.h_addressable == width &&
+			pipe->stream->timing.v_addressable == height &&
+			pipe->plane_state->src_rect.width == width &&
+			pipe->plane_state->src_rect.height == height &&
+			pipe->plane_state->dst_rect.width == width &&
+			pipe->plane_state->dst_rect.height == height)
+		is_native_scaling = true;
+
+	return is_native_scaling;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 138657c38afe..63bd6928c82f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -727,6 +727,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_margin_us = 2000, // 2000us
 	.disable_fpo_vactive = false,
 	.disable_boot_optimizations = false,
+	.disable_subvp_high_refresh = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 34ac5a1eb3ca..a73cacef6e48 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -35,6 +35,15 @@
 
 #define DC_LOGGER_INIT(logger)
 
+static const struct subvp_high_refresh_list subvp_high_refresh_list = {
+			.min_refresh = 120,
+			.max_refresh = 165,
+			.res = {
+				{.width = 3840, .height = 2160, },
+				{.width = 3440, .height = 1440, },
+				{.width = 2560, .height = 1440, }},
+};
+
 struct _vcs_dpi_ip_params_st dcn3_2_ip = {
 	.gpuvm_enable = 0,
 	.gpuvm_max_page_table_levels = 4,
@@ -694,7 +703,9 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 */
 		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
-				pipe->stream->mall_stream_config.type == SUBVP_NONE && refresh_rate < 120 && !pipe->plane_state->address.tmz_surface &&
+				pipe->stream->mall_stream_config.type == SUBVP_NONE &&
+				(refresh_rate < 120 || dcn32_allow_subvp_high_refresh_rate(dc, context, pipe)) &&
+				!pipe->plane_state->address.tmz_surface &&
 				(vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] <= 0 ||
 				(vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] > 0 &&
 						dcn32_allow_subvp_with_active_margin(pipe)))) {
@@ -2789,6 +2800,55 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
 	return allow;
 }
 
+/**
+ * ************************************************************************************************
+ * dcn32_allow_subvp_high_refresh_rate: Determine if the high refresh rate config will allow subvp
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ * @param [in]: pipe: Pipe to be considered for use in subvp
+ *
+ * On high refresh rate display configs, we will allow subvp under the following conditions:
+ * 1. Resolution is 3840x2160, 3440x1440, or 2560x1440
+ * 2. Refresh rate is between 120hz - 165hz
+ * 3. No scaling
+ * 4. Freesync is inactive
+ * 5. For single display cases, freesync must be disabled
+ *
+ * @return: True if pipe can be used for subvp, false otherwise
+ *
+ * ************************************************************************************************
+ */
+bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe)
+{
+	bool allow = false;
+	uint32_t refresh_rate = 0;
+	uint32_t min_refresh = subvp_high_refresh_list.min_refresh;
+	uint32_t max_refresh = subvp_high_refresh_list.max_refresh;
+	uint32_t i;
+
+	if (!dc->debug.disable_subvp_high_refresh && pipe->stream &&
+			pipe->plane_state && !pipe->stream->vrr_active_variable) {
+		refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
+						pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
+						/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
+		if (refresh_rate >= min_refresh && refresh_rate <= max_refresh) {
+			for (i = 0; i < SUBVP_HIGH_REFRESH_LIST_LEN; i++) {
+				uint32_t width = subvp_high_refresh_list.res[i].width;
+				uint32_t height = subvp_high_refresh_list.res[i].height;
+
+				if (dcn32_check_native_scaling_for_res(pipe, width, height)) {
+					if ((context->stream_count == 1 && !pipe->stream->allow_freesync) || context->stream_count > 1) {
+						allow = true;
+						break;
+					}
+				}
+			}
+		}
+	}
+	return allow;
+}
+
 /**
  * *******************************************************************************************
  * dcn32_determine_max_vratio_prefetch: Determine max Vratio for prefetch by driver policy
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 13c7e7394b1c..66f44a013fe5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -2322,10 +2322,14 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		mode_lib->vba.LinkCapacitySupport[i] = true;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k
-					&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
-							|| mode_lib->vba.Output[k] == dm_edp
-							|| mode_lib->vba.Output[k] == dm_hdmi)
-					&& mode_lib->vba.OutputBppPerState[i][k] == 0) {
+				&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
+					|| mode_lib->vba.Output[k] == dm_edp
+					|| mode_lib->vba.Output[k] == dm_hdmi)
+				&& mode_lib->vba.OutputBppPerState[i][k] == 0 &&
+				(mode_lib->vba.UsesMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe)) {
+				/* Phantom pipes don't consider DSC in DML, so it could fail link check.
+				 * However, we don't care about the link for phantom pipes.
+				 */
 				mode_lib->vba.LinkCapacitySupport[i] = false;
 			}
 		}
-- 
2.39.2


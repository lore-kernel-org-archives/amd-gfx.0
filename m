Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BD7CD1294
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E77F112E7D;
	Wed,  3 Apr 2024 19:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XMzNMInJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601AB112E7A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZIQwpm6NeALIYSbMSIxQtnNBi55GsrpkHHfcNRHicPjh5i1elgajnUIIepRFFOGGfIDjetaA/rPAPUkDDiwlWJU61Fhuqi/MaQ4lnqZQP4Pl+Gabc8jUOGvy6W7YGhwyavex76s4qRzppNXA6u1RXDuCn/tlypTtsqBouxbPUmNSOpZpqfOxQ+cH4PAUZ9947UUUwRGCmPKlXCJTkL+VyJNAzArPfC6ncKLnGd9qe2nFZKCWnUgDtGHVspEFAwf4M517b643gJCFJ81OlmTUaiV0eGZQ7NGfUq4y2P91EhrX7WTFwimhfev1GyfhbsKw9kyOzcJH6usF7SDzztgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKZwjS3LleGwUmkxmkNGFp4XKynvbCKBcXRdulja5nQ=;
 b=c8mTyskH+K/mfLjTRoq+keb1ouHsFaDXwIByCZXof/hM0uhzENEq4K4o76CSA5YNX1WZZl9OQehmJYgrNojNyG+DEQ7wtBk8eYyhVnZV6g9i77Nu052IE3fMNgourRb9T3xoovJnbnomXsYx83tRWzwowEH9qywnnXQf+uFjRtWCH265JTACJlgLYPfpYQR0WC5qbk+fbAgW/R3qnhpQFXnmKpCDWlfkw11M1IslLnm+vVzK+l/8q/UJhfEk5anspRbcdcmclI3D73GhVGD6RrcI4aAivISWzAU1+4rGvAGvZIF7MkMR9gs0maZeggKDUbCgvImgwGGGYWbbF8qoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKZwjS3LleGwUmkxmkNGFp4XKynvbCKBcXRdulja5nQ=;
 b=XMzNMInJvxn9ZQv+XrxDoB6ZBgbj2KDOlR8NLtJLkJXBq8XVHiiU0yG6H3IynB32HTh4tI27Sg/2+5NqqID+LlDpRkmrkLhMzBDrLOG4LFgCK5WYSkyThf6hcEuiJSElmM7oUvg8WM9ge7g2b59GL5rPT7RovVeickyY7MEDNpM=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:47 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::1d) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:47 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:39 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chris Park <chris.park@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 10/28] drm/amd/display: add dwb support to dml2
Date: Wed, 3 Apr 2024 15:49:00 -0400
Message-ID: <20240403195116.25221-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da81651-1b99-46d5-e326-08dc54177f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dtu6XkqSo7Mz1eY2K7xA+T7GsmK9lN81kZX46mctmmD+y4DwYT156r+tisqmyvw0PLFHcJMOe2fIyd67q9x7Yw6GiAXDXVIjl9wIrWcU2fBkMLplhWkTDcjr64WkdrRFmyDZU4c6dp3WZeYWEhyafuKKtd6P3oaz2FKn3i7tujy9NIqFNNn7M1jDX1lhw7LGdmyPd579r2ox7LXU+u6COgLcNx1CmSaOqNUSI0rlmTDYBpQAnWTMN/t3hFP6Bib5g7syfGGnTW3+MSjqkZxTcAuPplXW3LtxwBDlBCPgL+Yem1kQr1pBf1Oxd6irQlATL/UWqHcDbstqNxPuWFCwha5uvHh3G4fJKtPJsnq6xVyOMK4v4LlqhnfPDr1XS5z8gLh1vjmKxRRcGOx83xfBSw9aAUi9PCHMkFHV2ReyYJFaxg8tPNPSdQ5ZACEHsCgZgfY5bUYJRp5uWhFYiWC3nSBxOy8RaCZ6rlOPW+DLSJqOM6bdbfIlIMuzcyYttyOBgRl7mc26fTq8iNDBcq4g+SQhBvGTIxwcyVnCC4wkpMqRPb0aVOzH40i9ACMiGiiIDLHwEozJ/T+CXkn3yPzGchL6n41Wml1IBmWHiurwhiCePfko4fiUk9n4mqxTwfuOfxxg2+51tMzoLTcC7e4cqnHJcrx7lVACMpEQSbvvr6Ao/aIWEtRx5F73EN4c0Q29R2oXBVcNvRL3/Jrp++Xodbryye0Yw7s9zm6dPD27wkinsFTufPvrMFznL2I5gH9w
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:47.1740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da81651-1b99-46d5-e326-08dc54177f0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

From: Charlene Liu <charlene.liu@amd.com>

[why]
dwb was not previosly a priority.
now we need to enable dwb in dml2.

Limitation:
HW DML assumes only one DWB
one set of watermark for all 4 watermark sets
one stream has one DWB only.
WB scaling dml input has one set of scaling tap.
(no chroma so far)

needs to follow up

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   |  1 +
 .../amd/display/dc/dml2/display_mode_core.h   |  1 +
 .../dc/dml2/display_mode_lib_defines.h        |  2 +
 .../display/dc/dml2/dml2_translation_helper.c | 45 ++++++++++++-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  | 65 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.h  |  5 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  1 +
 7 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 470dca3950c3..6255101737b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -10214,6 +10214,7 @@ dml_get_var_func(fraction_of_urgent_bandwidth_imm_flip, dml_float_t, mode_lib->m
 dml_get_var_func(urgent_latency, dml_float_t, mode_lib->mp.UrgentLatency);
 dml_get_var_func(clk_dcf_deepsleep, dml_float_t, mode_lib->mp.DCFCLKDeepSleep);
 dml_get_var_func(wm_writeback_dram_clock_change, dml_float_t, mode_lib->mp.Watermark.WritebackDRAMClockChangeWatermark);
+dml_get_var_func(wm_writeback_urgent, dml_float_t, mode_lib->mp.Watermark.WritebackUrgentWatermark);
 dml_get_var_func(stutter_efficiency, dml_float_t, mode_lib->mp.StutterEfficiency);
 dml_get_var_func(stutter_efficiency_no_vblank, dml_float_t, mode_lib->mp.StutterEfficiencyNotIncludingVBlank);
 dml_get_var_func(stutter_efficiency_z8, dml_float_t, mode_lib->mp.Z8StutterEfficiency);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
index 8452485684f5..3116b88e99dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
@@ -94,6 +94,7 @@ dml_get_var_decl(wm_usr_retraining, dml_float_t);
 dml_get_var_decl(urgent_latency, dml_float_t);
 
 dml_get_var_decl(wm_writeback_dram_clock_change, dml_float_t);
+dml_get_var_decl(wm_writeback_urgent, dml_float_t);
 dml_get_var_decl(stutter_efficiency_no_vblank, dml_float_t);
 dml_get_var_decl(stutter_efficiency, dml_float_t);
 dml_get_var_decl(stutter_efficiency_z8, dml_float_t);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
index de63364be01d..14d389525296 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
@@ -41,6 +41,7 @@
 #define DCN_DML__VM_PRESENT__1 1
 #define DCN_DML__HOST_VM_PRESENT 1
 #define DCN_DML__HOST_VM_PRESENT__1 1
+#define DCN_DML__DWB 1
 
 #include "dml_depedencies.h"
 
@@ -59,6 +60,7 @@
 #define __DML_NUM_PLANES__                              DCN_DML__NUM_PLANE
 #define __DML_NUM_CURSORS__                             DCN_DML__NUM_CURSOR
 #define __DML_DPP_INVALID__                             0
+#define __DML_NUM_DMB__                                 DCN_DML__DWB
 #define __DML_PIPE_NO_PLANE__                           99
 
 #define __DML_MAX_STATE_ARRAY_SIZE__        DCN_DML__NUM_PWR_STATE
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 151b480b3cea..f43a31cd2c8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -1061,7 +1061,46 @@ static void dml2_populate_pipe_to_plane_index_mapping(struct dml2_context *dml2,
 		plane_index = 0;
 	}
 }
-
+static void populate_dml_writeback_cfg_from_stream_state(struct dml_writeback_cfg_st *out,
+		unsigned int location, const struct dc_stream_state *in)
+{
+	if (in->num_wb_info > 0) {
+		for (int i = 0; i < __DML_NUM_DMB__; i++) {
+			const struct dc_writeback_info *wb_info = &in->writeback_info[i];
+			/*current dml support 1 dwb per stream, limitation*/
+			if (wb_info->wb_enabled) {
+				out->WritebackEnable[location] = wb_info->wb_enabled;
+				out->ActiveWritebacksPerSurface[location] = wb_info->dwb_params.cnv_params.src_width;
+				out->WritebackDestinationWidth[location] = wb_info->dwb_params.dest_width;
+				out->WritebackDestinationHeight[location] = wb_info->dwb_params.dest_height;
+
+				out->WritebackSourceWidth[location] = wb_info->dwb_params.cnv_params.crop_en ?
+					wb_info->dwb_params.cnv_params.crop_width :
+					wb_info->dwb_params.cnv_params.src_width;
+
+				out->WritebackSourceHeight[location] = wb_info->dwb_params.cnv_params.crop_en ?
+					wb_info->dwb_params.cnv_params.crop_height :
+					wb_info->dwb_params.cnv_params.src_height;
+				/*current design does not have chroma scaling, need to follow up*/
+				out->WritebackHTaps[location] = wb_info->dwb_params.scaler_taps.h_taps > 0 ?
+					wb_info->dwb_params.scaler_taps.h_taps : 1;
+				out->WritebackVTaps[location] = wb_info->dwb_params.scaler_taps.v_taps > 0 ?
+					wb_info->dwb_params.scaler_taps.v_taps : 1;
+
+				out->WritebackHRatio[location] = wb_info->dwb_params.cnv_params.crop_en ?
+					(double)wb_info->dwb_params.cnv_params.crop_width /
+						(double)wb_info->dwb_params.dest_width :
+					(double)wb_info->dwb_params.cnv_params.src_width /
+						(double)wb_info->dwb_params.dest_width;
+				out->WritebackVRatio[location] = wb_info->dwb_params.cnv_params.crop_en ?
+					(double)wb_info->dwb_params.cnv_params.crop_height /
+						(double)wb_info->dwb_params.dest_height :
+					(double)wb_info->dwb_params.cnv_params.src_height /
+						(double)wb_info->dwb_params.dest_height;
+			}
+		}
+	}
+}
 void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg)
 {
 	int i = 0, j = 0, k = 0;
@@ -1106,6 +1145,10 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 
 		populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_stream_location, context->streams[i]);
 		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context);
+		/*Call site for populate_dml_writeback_cfg_from_stream_state*/
+		populate_dml_writeback_cfg_from_stream_state(&dml_dispcfg->writeback,
+			disp_cfg_stream_location, context->streams[i]);
+
 		switch (context->streams[i]->debug.force_odm_combine_segments) {
 		case 2:
 			dml2->v20.dml_core_ctx.policy.ODMUse[disp_cfg_stream_location] = dml_odm_use_policy_combine_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 81b4e08f8098..0f8b3336e26d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -404,6 +404,71 @@ void dml2_extract_watermark_set(struct dcn_watermarks *watermark, struct display
 	watermark->cstate_pstate.cstate_exit_z8_ns = dml_get_wm_z8_stutter(dml_core_ctx) * 1000;
 }
 
+unsigned int dml2_calc_max_scaled_time(
+		unsigned int time_per_pixel,
+		enum mmhubbub_wbif_mode mode,
+		unsigned int urgent_watermark)
+{
+	unsigned int time_per_byte = 0;
+	unsigned int total_free_entry = 0xb40;
+	unsigned int buf_lh_capability;
+	unsigned int max_scaled_time;
+
+	if (mode == PACKED_444) /* packed mode 32 bpp */
+		time_per_byte = time_per_pixel/4;
+	else if (mode == PACKED_444_FP16) /* packed mode 64 bpp */
+		time_per_byte = time_per_pixel/8;
+
+	if (time_per_byte == 0)
+		time_per_byte = 1;
+
+	buf_lh_capability = (total_free_entry*time_per_byte*32) >> 6; /* time_per_byte is in u6.6*/
+	max_scaled_time   = buf_lh_capability - urgent_watermark;
+	return max_scaled_time;
+}
+
+void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib_st *dml_core_ctx)
+{
+	int i, j = 0;;
+	struct mcif_arb_params *wb_arb_params = NULL;
+	struct dcn_bw_writeback *bw_writeback = NULL;
+	enum mmhubbub_wbif_mode wbif_mode = PACKED_444_FP16; /*for now*/
+
+	if (context->stream_count != 0) {
+		for (i = 0; i < context->stream_count; i++) {
+			if (context->streams[i]->num_wb_info != 0)
+				j++;
+		}
+	}
+	if (j == 0) /*no dwb */
+		return;
+	for (i = 0; i < __DML_NUM_DMB__; i++) {
+		bw_writeback = &context->bw_ctx.bw.dcn.bw_writeback;
+		wb_arb_params = &context->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[i];
+
+		for (j = 0 ; j < 4; j++) {
+			/*current dml only has one set of watermark, need to follow up*/
+			bw_writeback->mcif_wb_arb[i].cli_watermark[j] =
+					dml_get_wm_writeback_urgent(dml_core_ctx) * 1000;
+			bw_writeback->mcif_wb_arb[i].pstate_watermark[j] =
+					dml_get_wm_writeback_dram_clock_change(dml_core_ctx) * 1000;
+		}
+		if (context->res_ctx.pipe_ctx[i].stream->phy_pix_clk != 0) {
+			/* time_per_pixel should be in u6.6 format */
+			bw_writeback->mcif_wb_arb[i].time_per_pixel =
+				(1000000 << 6) / context->res_ctx.pipe_ctx[i].stream->phy_pix_clk;
+		}
+		bw_writeback->mcif_wb_arb[i].slice_lines = 32;
+		bw_writeback->mcif_wb_arb[i].arbitration_slice = 2;
+		bw_writeback->mcif_wb_arb[i].max_scaled_time =
+			dml2_calc_max_scaled_time(wb_arb_params->time_per_pixel,
+					wbif_mode, 	wb_arb_params->cli_watermark[0]);
+		/*not required any more*/
+		bw_writeback->mcif_wb_arb[i].dram_speed_change_duration =
+			dml_get_wm_writeback_dram_clock_change(dml_core_ctx) * 1000;
+
+	}
+}
 void dml2_initialize_det_scratch(struct dml2_context *in_ctx)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
index 5842d6d3c4b6..04fcfe637119 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
@@ -40,9 +40,14 @@ void dml2_util_copy_dml_output(struct dml_output_cfg_st *dml_output_array, unsig
 unsigned int dml2_util_get_maximum_odm_combine_for_output(bool force_odm_4to1, enum dml_output_encoder_class encoder, bool dsc_enabled);
 void dml2_copy_clocks_to_dc_state(struct dml2_dcn_clocks *out_clks, struct dc_state *context);
 void dml2_extract_watermark_set(struct dcn_watermarks *watermark, struct display_mode_lib_st *dml_core_ctx);
+void dml2_extract_writeback_wm(struct dc_state *context, struct display_mode_lib_st *dml_core_ctx);
 int dml2_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsigned int stream_id);
 bool is_dtbclk_required(const struct dc *dc, struct dc_state *context);
 bool dml2_is_stereo_timing(const struct dc_stream_state *stream);
+unsigned int dml2_calc_max_scaled_time(
+		unsigned int time_per_pixel,
+		enum mmhubbub_wbif_mode mode,
+		unsigned int urgent_watermark);
 
 /*
  * dml2_dc_construct_pipes - This function will determine if we need additional pipes based
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index abf946f089b3..9412d5384a41 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -640,6 +640,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.b, &dml2->v20.dml_core_ctx);
 		memcpy(&context->bw_ctx.bw.dcn.watermarks.c, &dml2->v20.g6_temp_read_watermark_set, sizeof(context->bw_ctx.bw.dcn.watermarks.c));
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.d, &dml2->v20.dml_core_ctx);
+		dml2_extract_writeback_wm(context, &dml2->v20.dml_core_ctx);
 		//copy for deciding zstate use
 		context->bw_ctx.dml.vba.StutterPeriod = context->bw_ctx.dml2->v20.dml_core_ctx.mp.StutterPeriod;
 
-- 
2.44.0


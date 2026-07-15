Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5248C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6353010F083;
	Wed, 15 Jul 2026 13:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02vcR1zl";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4983510F083
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDqkMc6b3YmoL1fjLc/G2qboSyhwfqL3VMrZtfl2dDbpepeMkbjJSCcfHT0iutkrFfbjXCFpATavuGlOa11E/hpLa+329O9xuUVYZ8HYt41Am8seGKwGNT8D5fu/IqdRZJPiou6tTf2ekk0OyM5bx73MRZrqAwJxO+Efqv+zEJetjQw0BYmWQ59aRbSgOhcWMB8Ni+xYUtL3I4euKwEwu1JVJSgXkS7BsEpXRHM8oyIU7ZFrPpjpw9rXxe+GSPVzt83XFLXar599V+x3rxtVs8/sqCc2ktDyCtGDd6teOg0FmIk4bcZwOc1R8uFzf9IphnQXnnRcmxikux5Gbid4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ajtX5Hb6Fnd1fuCe1z6SCQU51JcN+0hgriQ649Forc=;
 b=RCLbW/dk8ESWSJwz0fxgGFDu8QeyxJqluVrNhDo+bcach0emwZRaiRUKi40XvZi1Ij3J6oMpmx6Jcan76bW12pdjvRpoU2AK5VbX7+HkitUkgPYUqNcP5isVycIOg6xQHmNqaAFnPgJkaJrzsva/uB3r5+5cd5edbf1KlQm4UnSnlpYA+B69rWV+Hv2RQYOFAQvcJ71/BGyVsQcg2WakBJPIoDdu0ZenshayF+pgsyF9xMDD1IOXSzpnHDGWqAOWi2ccQ2HsbybsRBS0gwkqobpJwVx9SKwrL9w9EGfEwwRhAX2OKtUhumBVheiWtMmqo2RyRXHwQ2acZNYvDc2neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ajtX5Hb6Fnd1fuCe1z6SCQU51JcN+0hgriQ649Forc=;
 b=02vcR1zlJ3wMxcwZ/t6J/Jklv/s30FSMzdQZIN76PKOaBSB+/Evq/+DR5GqZJwlxbgjFnxpoFgFJkXe0+S1HNH2Y7RX0ysKBSls1Ygyj839qpDQv8Uayjt74IZONa+qLXAGYGKhY4bbsiXMwWL7OIup8g7EDbCSaT+7JrnJSqTM=
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:46:29 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::84) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Wed, 15
 Jul 2026 13:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:17 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 23/70] drm/amd/display: Add DWB validation support to DML2.1
 wrapper
Date: Wed, 15 Jul 2026 21:37:33 +0800
Message-ID: <20260715134432.1975118-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff588dc-028c-473e-0284-08dee27778cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|22082099003|18002099003|3023799007|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: rJJ0f17Yx1AYTqVgH8KH+LPLkZKHJ9fd7KswFF2+Tg57///yY6YqJKVr0YiFq4fKFIICDPikjgCjBOwn+jUHEG9rI4+3aQdpW1koZhufXAfe84Eodi5Oc4CceIwZrFYMnt5PvNBkfH+32+ppCZup40o3cl1niDVg2gsXRwnoClQj+QN07LashB6UGXNavU0kyiZep4BRbTOG2Pbdu4ritgmb394xXgNIOKDe38bcGynHhSJnNFiakviMwS/yHrJ1+MnK07L7tys+ijokkf+HqoGYhHXtlNNxSt4pfSl+yH4pZqD5GLN3Eb8Nz16gtM6MS2N4suowcUY8D2goWCNJBouJvaoweG0s3jMAyEZCa1/q26UrEEikTKIQGOjAHdCCfAwxVkLSxefQymz98Huk/fxWaCisIgwMnQIHCWcowUpZ6Grt5CetNWQiic3rqvIEj40PYPusQZv1roaJFC8w/db7l4z82GBzCTtz+HGQSSw0uK8gm1RLzURLHjbBsIp/BtEr8FTTOVz8KlooOleIggMg+8WoqYPrVXw5MAqC7Sp7626BxAMqYLlQj71WjqVEujMq7jNBMcNcTNefKZW6oIjh/M4sFwxgGGsXO3Bhf21ckYwBcSEQVXcEvz6Ku9wHZaiBcvSk4qyIKiHl88N+i6ynTzPaKKJKMW7CVRg+88nmSAGZvU9ywlDa/g9439qxCkkzQILlovE8/YW2u1l/aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kHtM88n6M8p/9kajmLdfMeg32U+ZF5lsJjOSCUOGER77Nr92bazfDu4AaxvwTOgpUnHKjFiQ146n8frJz5pg3k/VA/9nrHmQN+Gr0gQUWbiqpUrxQGEYk1HTE6ij08CP3px8tfiqjId4gwLyZkofofYXFYAPGKRqKQBcX6hhFU6pJ1aFvIZMrZzBjQ+hwRFWqgT/P/4lizt0491zhjYwfXUXyn34waG9FnAtGPL5qzqdNfwIpPMlg0yxGGmENjfx4WPvCAbF0YwVtaJFrJTK3858iMFc3ee4/WAR9TBqhuY99eSLRhpV59vGM0Di69LxRL3ZxZD0VPJBb1Osw0eF0WvH10oM1DlirfRMUZWkeH1GKrPmQqyNIYHNI45GvsXdj1fIrXD4ff5nAdPA1/+Ma585LFOxfQLyTtfdRWCg39/nmISvX7/2Es5y5lnM4hXe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:28.7542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff588dc-028c-473e-0284-08dee27778cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
DML2.1 wrapper was lacking translation for DWB. This change adds the
necessary translation for DWB validation and programming support.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 56 +++++++++++++++
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c | 17 +++++
 .../amd/display/dc/dml2_0/dml21/dml21_utils.h |  5 ++
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       | 10 +++
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |  2 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      | 34 +++++++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 68 ++++++++++++++++---
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |  2 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 21 ++++++
 9 files changed, 206 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 51260369cd8a..a76dcde1efbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -267,6 +267,61 @@ static void populate_dml21_output_config_from_stream_state(struct dml2_link_outp
 	// output->validate_output
 }
 
+static void populate_dml21_writeback_config_from_stream_state(struct dml2_writeback_cfg *writeback,
+		const struct dc_stream_state *stream)
+{
+	if (stream->num_wb_info > 0) {
+		writeback->active_writebacks_per_stream = stream->num_wb_info <= DML2_MAX_WRITEBACK ?
+				stream->num_wb_info : DML2_MAX_WRITEBACK;
+
+		ASSERT(stream->num_wb_info <= DML2_MAX_WRITEBACK);
+
+		for (unsigned int wb_index = 0; wb_index < stream->num_wb_info; wb_index++) {
+			const struct dc_writeback_info *dc_wb_info = &stream->writeback_info[wb_index];
+			struct dml2_writeback_info *wb_info = &writeback->writeback_stream[wb_index];
+
+			switch (dc_wb_info->dwb_params.cnv_params.fc_out_format) {
+			case DWB_OUT_FORMAT_64BPP_ARGB:
+			case DWB_OUT_FORMAT_64BPP_RGBA:
+				wb_info->pixel_format = dml2_444_64;
+				break;
+			case DWB_OUT_FORMAT_32BPP_ARGB:
+			case DWB_OUT_FORMAT_32BPP_RGBA:
+			default:
+				wb_info->pixel_format = dml2_444_32;
+				break;
+			}
+
+			wb_info->input_width = dc_wb_info->dwb_params.cnv_params.crop_en ?
+					dc_wb_info->dwb_params.cnv_params.crop_width :
+					dc_wb_info->dwb_params.cnv_params.src_width;
+			wb_info->input_height = dc_wb_info->dwb_params.cnv_params.crop_en ?
+					dc_wb_info->dwb_params.cnv_params.crop_height :
+					dc_wb_info->dwb_params.cnv_params.src_height;
+			wb_info->output_width = dc_wb_info->dwb_params.dest_width;
+			wb_info->output_height = dc_wb_info->dwb_params.dest_height;
+			wb_info->v_taps = dc_wb_info->dwb_params.scaler_taps.v_taps > 0 ?
+					dc_wb_info->dwb_params.scaler_taps.v_taps : 1;
+			wb_info->h_taps = dc_wb_info->dwb_params.scaler_taps.h_taps > 0 ?
+					dc_wb_info->dwb_params.scaler_taps.h_taps : 1;
+			wb_info->v_taps_chroma = dc_wb_info->dwb_params.scaler_taps.v_taps_c > 0 ?
+					dc_wb_info->dwb_params.scaler_taps.v_taps_c : 1;
+			wb_info->h_taps_chroma = dc_wb_info->dwb_params.scaler_taps.h_taps_c > 0 ?
+					dc_wb_info->dwb_params.scaler_taps.h_taps_c : 1;
+			wb_info->h_ratio = dc_wb_info->dwb_params.cnv_params.crop_en ?
+					(double)dc_wb_info->dwb_params.cnv_params.crop_width /
+					(double)dc_wb_info->dwb_params.dest_width :
+					(double)dc_wb_info->dwb_params.cnv_params.src_width /
+					(double)dc_wb_info->dwb_params.dest_width;
+			wb_info->v_ratio = dc_wb_info->dwb_params.cnv_params.crop_en ?
+					(double)dc_wb_info->dwb_params.cnv_params.crop_height /
+					(double)dc_wb_info->dwb_params.dest_height :
+					(double)dc_wb_info->dwb_params.cnv_params.src_height /
+					(double)dc_wb_info->dwb_params.dest_height;
+		}
+	}
+}
+
 static void populate_dml21_stream_overrides_from_stream_state(
 		struct dml2_stream_parameters *stream_desc,
 		struct dc_stream_state *stream,
@@ -826,6 +881,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], otg_master_pipe, dml_ctx);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], otg_master_pipe);
+		populate_dml21_writeback_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].writeback, context->streams[stream_index]);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index], &context->stream_status[stream_index]);
 
 		dml_dispcfg->stream_descriptors[disp_cfg_stream_location].overrides.hw.twait_budgeting.fclk_pstate = dml2_twait_budgeting_setting_if_needed;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 835fece1d46a..16e1315da2fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -532,3 +532,20 @@ bool dml21_is_plane1_enabled(enum dml2_source_format_class source_format)
 {
 	return source_format >= dml2_420_8 && source_format <= dml2_rgbe_alpha;
 }
+
+void dml21_program_dc_mcif_arb_params(struct dml2_context *dml_ctx,
+		struct dc_state *context,
+		struct dml2_per_stream_programming *stream_prog,
+		unsigned int wb_index,
+		unsigned int dwb_inst)
+{
+	/* DC struct contains global reg for every WB instance */
+	memcpy(&context->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[dwb_inst].dcn4x.global_regs,
+			&dml_ctx->v21.mode_programming.programming->mcif_global_regs,
+			sizeof(struct dml2_mcif_global_register_set));
+
+	/* copy per-DWB pipe registers */
+	memcpy(&context->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[dwb_inst].dcn4x.inst_regs,
+			stream_prog->mcif_regs[wb_index],
+			sizeof(struct dml2_mcif_per_pipe_register_set));
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
index bff945a4ab3a..7312c33143c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.h
@@ -48,4 +48,9 @@ void dml21_build_fams2_programming(const struct dc *dc,
 		struct dc_state *context,
 		struct dml2_context *dml_ctx);
 bool dml21_is_plane1_enabled(enum dml2_source_format_class source_format);
+void dml21_program_dc_mcif_arb_params(struct dml2_context *dml_ctx,
+		struct dc_state *context,
+		struct dml2_per_stream_programming *stream_prog,
+		unsigned int wb_index,
+		unsigned int dwb_inst);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index 11fc0b1cd152..a975d36ce15d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -60,6 +60,7 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
 	int num_pipes;
 	unsigned int dml_phantom_prog_idx;
+	unsigned int stream_wb_idx;
 
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 
@@ -102,6 +103,15 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 			}
 		}
 
+		/* program WB */
+		for (stream_wb_idx = 0; stream_wb_idx < stream_prog->stream_descriptor->writeback.active_writebacks_per_stream; stream_wb_idx++) {
+			dml21_program_dc_mcif_arb_params(in_ctx,
+					context,
+					stream_prog,
+					stream_wb_idx,
+					dc_main_pipes[0]->stream->writeback_info[stream_wb_idx].dwb_pipe_inst);
+		}
+
 		/* copy per plane mcache allocation */
 		memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[dml_prog_idx], &pln_prog->mcache_allocation, sizeof(struct dml2_mcache_surface_allocation));
 		if (pln_prog->phantom_plane.valid) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index bd0d7549d20f..f00ca2983ff5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -279,6 +279,8 @@ struct dml2_per_stream_programming {
 
 	enum dml2_pstate_method uclk_pstate_method;
 
+	struct dml2_mcif_per_pipe_register_set *mcif_regs[DML2_MAX_WRITEBACK];
+
 	struct {
 		bool enabled;
 		struct dml2_stream_parameters descriptor;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index c983869e0fa3..727b01ca18bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -368,9 +368,10 @@ static void expand_implict_subvp(const struct display_configuation_with_meta *di
 static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_instance *core, const struct display_configuation_with_meta *display_cfg,
 	const struct dml2_display_cfg *svp_expanded_display_cfg, struct dml2_display_cfg_programming *programming, struct dml2_core_scratch *scratch)
 {
-	unsigned int stream_index, plane_index, pipe_offset, stream_already_populated_mask, main_plane_index, mcache_index;
+	unsigned int stream_index, plane_index, pipe_offset, stream_already_populated_mask, main_plane_index, mcache_index, dwb_index;
 	unsigned int total_main_mcaches_required = 0;
 	int total_pipe_regs_copied = 0;
+	int total_dwb_regs_copied = 0;
 	int dml_internal_pipe_index = 0;
 	const struct dml2_plane_parameters *main_plane;
 	const struct dml2_plane_parameters *phantom_plane;
@@ -386,6 +387,8 @@ static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_in
 	// display config
 	dml2_core_calcs_get_watermarks(&display_cfg->display_config, &core->clean_me_up.mode_lib, &programming->global_regs.wm_regs[0]);
 
+	dml2_core_calcs_get_mcif_arb_params(&core->clean_me_up.mode_lib, &programming->mcif_global_regs);
+
 	// Check if FAMS2 is required
 	if (display_cfg->stage3.performed && display_cfg->stage3.success) {
 		programming->fams2_required = display_cfg->stage3.fams2_required;
@@ -470,6 +473,19 @@ static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_in
 					programming->stream_programming[main_plane->stream_index].uclk_pstate_method,
 					plane_index);
 
+				/* populate DWB */
+				for (dwb_index = 0; dwb_index < svp_expanded_display_cfg->stream_descriptors[main_plane->stream_index].writeback.active_writebacks_per_stream; dwb_index++) {
+					programming->stream_programming[main_plane->stream_index].mcif_regs[dwb_index] = &programming->mcif_regs[total_dwb_regs_copied];
+					memset(programming->stream_programming[main_plane->stream_index].mcif_regs[dwb_index], 0, sizeof(struct dml2_mcif_per_pipe_register_set));
+					total_dwb_regs_copied++;
+
+					dml2_core_calcs_get_per_dwb_params(svp_expanded_display_cfg,
+							&core->clean_me_up.mode_lib,
+							programming->stream_programming[main_plane->stream_index].mcif_regs[dwb_index],
+							main_plane->stream_index,
+							dwb_index);
+				}
+
 				stream_already_populated_mask |= (0x1 << main_plane->stream_index);
 			}
 			dml_internal_pipe_index++;
@@ -661,10 +677,12 @@ bool core_dcn4_mode_programming(struct dml2_core_mode_programming_in_out *in_out
 	unsigned int pipe_offset;
 	int dml_internal_pipe_index;
 	int total_pipe_regs_copied = 0;
+	int total_dwb_regs_copied = 0;
 	int stream_already_populated_mask = 0;
 
 	int main_stream_index;
 	unsigned int plane_index;
+	unsigned int dwb_index;
 
 	expand_implict_subvp(in_out->display_cfg, &l->svp_expanded_display_cfg, &core->scratch);
 
@@ -688,6 +706,8 @@ bool core_dcn4_mode_programming(struct dml2_core_mode_programming_in_out *in_out
 			dml2_core_calcs_get_arb_params(&l->svp_expanded_display_cfg, &core->clean_me_up.mode_lib, &in_out->programming->global_regs.arb_regs);
 			dml2_core_calcs_get_watermarks(&l->svp_expanded_display_cfg, &core->clean_me_up.mode_lib, &in_out->programming->global_regs.wm_regs[0]);
 
+			dml2_core_calcs_get_mcif_arb_params(&core->clean_me_up.mode_lib, &in_out->programming->mcif_global_regs);
+
 			dml_internal_pipe_index = 0;
 
 			for (plane_index = 0; plane_index < in_out->programming->display_config.num_planes; plane_index++) {
@@ -733,6 +753,18 @@ bool core_dcn4_mode_programming(struct dml2_core_mode_programming_in_out *in_out
 						in_out->programming->stream_programming[main_stream_index].num_odms_required = in_out->cfg_support_info->stream_support_info[main_stream_index].odms_used;
 						dml2_core_calcs_get_stream_programming(&core->clean_me_up.mode_lib, &in_out->programming->stream_programming[main_stream_index], dml_internal_pipe_index);
 
+						for (dwb_index = 0; dwb_index < l->svp_expanded_display_cfg.stream_descriptors[main_stream_index].writeback.active_writebacks_per_stream; dwb_index++) {
+							in_out->programming->stream_programming[main_stream_index].mcif_regs[dwb_index] = &in_out->programming->mcif_regs[total_dwb_regs_copied];
+							memset(in_out->programming->stream_programming[main_stream_index].mcif_regs[dwb_index], 0, sizeof(struct dml2_mcif_per_pipe_register_set));
+							total_dwb_regs_copied++;
+
+							dml2_core_calcs_get_per_dwb_params(&l->svp_expanded_display_cfg,
+									&core->clean_me_up.mode_lib,
+									in_out->programming->stream_programming[main_stream_index].mcif_regs[dwb_index],
+									main_stream_index,
+									dwb_index);
+						}
+
 						stream_already_populated_mask |= (0x1 << main_stream_index);
 					}
 					dml_internal_pipe_index++;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index b667fc9ad75f..fa78016b32fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6741,6 +6741,25 @@ static void CalculateFlipSchedule(
 #endif
 }
 
+static double calculate_writeback_latency_hiding_us(
+		const struct dml2_display_cfg *display_cfg,
+		unsigned int writeback_buffer_size_bytes,
+		unsigned int stream_index,
+		unsigned int dwb_index)
+{
+	double line_time_us = (double)display_cfg->stream_descriptors[stream_index].timing.h_total /
+			(double)display_cfg->stream_descriptors[stream_index].timing.pixel_clock_khz / 1000.0;
+
+	double writeback_latency_hiding_us = (double)writeback_buffer_size_bytes /
+			((double)display_cfg->stream_descriptors[stream_index].writeback.writeback_stream[dwb_index].output_height *
+			(double)display_cfg->stream_descriptors[stream_index].writeback.writeback_stream[dwb_index].output_width /
+			((double)display_cfg->stream_descriptors[stream_index].writeback.writeback_stream[dwb_index].input_height *
+			line_time_us) * 4.0);
+
+	return display_cfg->stream_descriptors[stream_index].writeback.writeback_stream[dwb_index].pixel_format == dml2_444_64 ?
+			writeback_latency_hiding_us / 2 : writeback_latency_hiding_us;
+}
+
 static void CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 	struct dml2_core_internal_scratch *scratch,
 	struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params *p)
@@ -6905,13 +6924,10 @@ static void CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 			p->VActiveLatencyHidingUs[k] = s->ActiveClockChangeLatencyHiding;
 
 		if (p->display_cfg->stream_descriptors[p->display_cfg->plane_descriptors[k].stream_index].writeback.active_writebacks_per_stream > 0) {
-			s->WritebackLatencyHiding = (double)p->WritebackInterfaceBufferSize * 1024.0
-				/ ((double)p->display_cfg->stream_descriptors[p->display_cfg->plane_descriptors[k].stream_index].writeback.writeback_stream[0].output_height
-					* (double)p->display_cfg->stream_descriptors[p->display_cfg->plane_descriptors[k].stream_index].writeback.writeback_stream[0].output_width
-					/ ((double)p->display_cfg->stream_descriptors[p->display_cfg->plane_descriptors[k].stream_index].writeback.writeback_stream[0].input_height * (double)h_total / pixel_clock_mhz) * 4.0);
-			if (p->display_cfg->stream_descriptors[p->display_cfg->plane_descriptors[k].stream_index].writeback.writeback_stream[0].pixel_format == dml2_444_64) {
-				s->WritebackLatencyHiding = s->WritebackLatencyHiding / 2;
-			}
+			s->WritebackLatencyHiding = calculate_writeback_latency_hiding_us(p->display_cfg,
+					p->WritebackInterfaceBufferSize * 1024,
+					p->display_cfg->plane_descriptors[k].stream_index,
+					0);
 			s->WritebackDRAMClockChangeLatencyMargin = s->WritebackLatencyHiding - p->Watermark->WritebackDRAMClockChangeWatermark;
 
 			s->WritebackFCLKChangeLatencyMargin = s->WritebackLatencyHiding - p->Watermark->WritebackFCLKChangeWatermark;
@@ -8693,6 +8709,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	s->TotalNumberOfActiveWriteback = 0;
 	memset(s->stream_visited, 0, DML2_MAX_PLANES * sizeof(bool));
 
+	mode_lib->ms.support.EnoughWritebackUnits = true;
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 		if (!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k])) {
 			if (!s->stream_visited[display_cfg->plane_descriptors[k].stream_index]) {
@@ -8701,6 +8718,10 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 				if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.active_writebacks_per_stream > 0)
 					s->TotalNumberOfActiveWriteback = s->TotalNumberOfActiveWriteback + 1;
 
+				/* >1 writeback per stream is currently not supported */
+				if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.active_writebacks_per_stream > 1)
+					mode_lib->ms.support.EnoughWritebackUnits = false;
+
 				s->TotalNumberOfActiveOTG = s->TotalNumberOfActiveOTG + 1;
 				if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_hdmifrl)
 					s->TotalNumberOfActiveHDMIFRL = s->TotalNumberOfActiveHDMIFRL + 1;
@@ -8716,10 +8737,10 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	}
 
 	/* Writeback Mode Support Check */
-	mode_lib->ms.support.EnoughWritebackUnits = 1;
 	if (s->TotalNumberOfActiveWriteback > (unsigned int)mode_lib->ip.max_num_wb) {
 		mode_lib->ms.support.EnoughWritebackUnits = false;
 	}
+
 	mode_lib->ms.support.NumberOfOTGSupport = (s->TotalNumberOfActiveOTG <= (unsigned int)mode_lib->ip.max_num_otg);
 	mode_lib->ms.support.NumberOfHDMIFRLSupport = (s->TotalNumberOfActiveHDMIFRL <= (unsigned int)mode_lib->ip.max_num_hdmi_frl_outputs);
 	mode_lib->ms.support.NumberOfDP2p0Support = (s->TotalNumberOfActiveDP2p0 <= (unsigned int)mode_lib->ip.max_num_dp2p0_streams && s->TotalNumberOfActiveDP2p0Outputs <= (unsigned int)mode_lib->ip.max_num_dp2p0_outputs);
@@ -12831,6 +12852,14 @@ void dml2_core_calcs_get_arb_params(const struct dml2_display_cfg *display_cfg,
 	rq_dlg_get_arb_params(display_cfg, mode_lib, out);
 }
 
+void dml2_core_calcs_get_mcif_arb_params(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_mcif_global_register_set *out)
+{
+	out->wm_regs[0].fclk_pstate = (unsigned int)(mode_lib->mp.Watermark.WritebackFCLKChangeWatermark * 1000.0);
+	out->wm_regs[0].uclk_pstate = (unsigned int)(mode_lib->mp.Watermark.WritebackDRAMClockChangeWatermark * 1000.0);
+	out->wm_regs[0].urgent = (unsigned int)(mode_lib->mp.Watermark.WritebackUrgentWatermark * 1000.0);
+	out->wm_regs[0].temp_read_or_ppt = (unsigned int)(mode_lib->mp.Watermark.writeback_temp_read_or_ppt_watermark_us * 1000.0);
+}
+
 void dml2_core_calcs_get_pipe_regs(const struct dml2_display_cfg *display_cfg,
 	struct dml2_core_internal_display_mode_lib *mode_lib,
 	struct dml2_dchub_per_pipe_register_set *out, int pipe_index)
@@ -12854,6 +12883,29 @@ void dml2_core_calcs_get_stream_programming(const struct dml2_core_internal_disp
 	dml2_core_calcs_get_global_sync_programming(mode_lib, &out->global_sync, pipe_index);
 }
 
+void dml2_core_calcs_get_per_dwb_params(const struct dml2_display_cfg *display_cfg,
+		const struct dml2_core_internal_display_mode_lib *mode_lib,
+		struct dml2_mcif_per_pipe_register_set *out,
+		int stream_index,
+		int dwb_index)
+{
+	double writeback_latency_hiding_us = calculate_writeback_latency_hiding_us(display_cfg,
+					mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024,
+					stream_index,
+					dwb_index);
+
+	out->max_scaled_time_ns = (unsigned int)math_max2(
+			(writeback_latency_hiding_us - mode_lib->mp.Watermark.WritebackUrgentWatermark) * 1000.0,
+			0.0);
+
+	/* 1024ps units in U6.6 format */
+	out->time_per_pixel = (unsigned int)((1000000.0 * math_pow(2, 6)) /
+			(double)display_cfg->stream_descriptors[stream_index].timing.pixel_clock_khz);
+
+	out->slice_lines = 31;
+	out->arbitration_slice = 2;
+}
+
 void dml2_core_calcs_get_global_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib,
 		const struct display_configuation_with_meta *display_cfg,
 		struct dmub_cmd_fams2_global_config *fams2_global_config)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
index 27ef0e096b25..3249f6bcf7bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
@@ -19,6 +19,7 @@ struct display_configuation_with_meta;
 unsigned int dml2_core_calcs_mode_support_ex(struct dml2_core_calcs_mode_support_ex *in_out_params);
 bool dml2_core_calcs_mode_programming_ex(struct dml2_core_calcs_mode_programming_ex *in_out_params);
 void dml2_core_calcs_get_watermarks(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_dchub_watermark_regs *out);
+void dml2_core_calcs_get_mcif_arb_params(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_mcif_global_register_set *out);
 void dml2_core_calcs_get_arb_params(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_display_arb_regs *out);
 void dml2_core_calcs_get_pipe_regs(const struct dml2_display_cfg *dml2_display_cfg, struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_dchub_per_pipe_register_set *out, int pipe_index);
 void dml2_core_calcs_get_stream_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_per_stream_programming *out, int pipe_index);
@@ -30,6 +31,7 @@ void dml2_core_calcs_get_stream_support_info(const struct dml2_display_cfg *disp
 void dml2_core_calcs_get_mall_allocation(struct dml2_core_internal_display_mode_lib *mode_lib, unsigned int *out, int pipe_index);
 void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, const struct display_configuation_with_meta *display_cfg, union dmub_cmd_fams2_config *fams2_base_programming, union dmub_cmd_fams2_config *fams2_sub_programming, enum dml2_pstate_method pstate_method, int plane_index);
 void dml2_core_calcs_get_global_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, const struct display_configuation_with_meta *display_cfg, struct dmub_cmd_fams2_global_config *fams2_global_config);
+void dml2_core_calcs_get_per_dwb_params(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_mcif_per_pipe_register_set *out, int stream_index, int dwb_index);
 
 void dml2_core_calcs_get_dpte_row_height(unsigned int *dpte_row_height, struct dml2_core_internal_display_mode_lib *mode_lib, bool is_plane1, enum dml2_source_format_class SourcePixelFormat, enum dml2_swizzle_mode SurfaceTiling, enum dml2_rotation_angle ScanDirection, unsigned int pitch, unsigned int GPUVMMinPageSizeKBytes);
 void dml2_core_calcs_cursor_dlg_reg(struct dml2_cursor_dlg_regs *cursor_dlg_regs, const struct dml2_get_cursor_dlg_reg *p);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 5ffe211a6643..c60a1faf2d5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -779,6 +779,25 @@ bool dpmm_dcn4_map_mode_to_soc_dpm(struct dml2_dpmm_map_mode_to_soc_dpm_params_i
 	return result;
 }
 
+static void dpmm_dcn4_map_mcif_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out)
+{
+	const struct dml2_core_internal_display_mode_lib *mode_lib = &in_out->core->clean_me_up.mode_lib;
+	struct dml2_mcif_global_register_set *mcif_regs = &in_out->programming->mcif_global_regs;
+
+	/* MCIF */
+	mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].urgent = (int unsigned)(mode_lib->mp.Watermark.WritebackUrgentWatermark * 1000.0);
+	mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].uclk_pstate = (int unsigned)(mode_lib->mp.Watermark.WritebackDRAMClockChangeWatermark * 1000.0);
+	mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.WritebackFCLKChangeWatermark * 1000.0);
+	mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].temp_read_or_ppt = (int unsigned)(mode_lib->mp.Watermark.writeback_temp_read_or_ppt_watermark_us * 1000.0);
+
+	/* replicate sets A through D */
+	memcpy(&mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B], &mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A], sizeof(mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A]));
+	memcpy(&mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_C], &mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A], sizeof(mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A]));
+	memcpy(&mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_D], &mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A], sizeof(mcif_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A]));
+
+	mcif_regs->num_watermark_sets = 4;
+}
+
 bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out)
 {
 	const struct dml2_display_cfg *display_cfg = &in_out->display_cfg->display_config;
@@ -821,6 +840,8 @@ bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 
 	dchubbub_regs->num_watermark_sets = 2;
 
+	dpmm_dcn4_map_mcif_watermarks(in_out);
+
 	return true;
 }
 bool dpmm_dcn42_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out)
-- 
2.43.0


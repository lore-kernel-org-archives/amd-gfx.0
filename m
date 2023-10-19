Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27262CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA6A10E4E7;
	Thu, 19 Oct 2023 13:33:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91C610E4E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IndaAJnGgcWWNc6Fh68gdI3nbOOSrXiy+EvYqpRRS6yk+gAFecC0em5cgycDTcp9bWEMHNiYHen6ZagtlVozzfvQN904V01IoalbBSJ3TSR0pluSVi8iQmlViK3CHWArAWV1gdCYgTFwxV72aFpQms2sASpJ/mOeLACd9Bx0++Zn+//U/DZTuKEzuYAm5c2FkInS9h6p0DP7My6cm6cQScSt2hVzW/bof8u/CWcdQ3vzdx/3WGlR0r5Sj4kierY6zdcxsQ64WMjwg1Ygdi2Ukh43SmdMCzqmiMmpNdxUOLvne0vuYfUPimh9hd1DgjD/8UgoIjYwUpBK/8cIchDiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpkNkoWkjoDryE2iZr6LswRjRAq+3rIxC1aK+uzhqrs=;
 b=BkfZBOPXkU1QnV2OmI6B+sDxFkc5FZpuSfelAQuPqUgFoJxC4u6ur/vNjJ2K+j7ShV2iqj0WdJEzrOwNTr1D+yRP/WWEMbZFZVtMmu8OMvqtQSQoWHjLhHWj5aQqjb4Vp42Npjz5IoV7j7K19qpcJZi9nfUHHn79BVfC4BeCxraOA5uUAEaTSpx01D6ESnUhSzhj2RET97PCZQCGSehhatCaNSQlNbij6jn9koNssE9O0nI3XEQJudoYbxWUCvwCO4ND8pwtTjN0UaKQox+HJ8kHr4M/8CYRI6vgShUIfeSzTutKmtxPYcHQVxDsRQt8eRie8E4KEVys+YqwQKDYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpkNkoWkjoDryE2iZr6LswRjRAq+3rIxC1aK+uzhqrs=;
 b=gbz161DSvCmjTyYwMWVIPYjHPV+z5/y+vGnIrDM0NIpV4JvpVdBHUaEKH/obIey5YGX9HBAj5fmqIHB47AOD2ewjV3/ZQZyqwXL4d5AA46JNLLWeJGtEW6sGUUyBRsCwxAWgCu5SogV7UUlWwdhFoOxp/Nq3V/e+8oSmUrB4P68=
Received: from BL0PR0102CA0024.prod.exchangelabs.com (2603:10b6:207:18::37) by
 PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.43; Thu, 19 Oct 2023 13:33:08 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::6e) by BL0PR0102CA0024.outlook.office365.com
 (2603:10b6:207:18::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:07 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 09/24] drm/amd/display: implement map dc pipe with callback
 in DML2
Date: Thu, 19 Oct 2023 09:32:07 -0400
Message-ID: <20231019133222.1633077-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: c92b1d28-914a-440f-6a0e-08dbd0a7ee31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibyLhWjNDK8bBZ5VO+cFLIuekvpXXmc/EnGkEU2ahzmhvs1aITx8psAdTEL0XZhHLdrNJZUeAIbozcjQVzU3tsJBJOdppJSu9/7paQVb64uLxVAH40KCxM60DD6TIY/ycGwx70kknxYe9GcsQhcLzFT91lI1iTcgRDFeYadocBWqygdbhbmdDShbe1y1h7EqHUUyDof/aNe1QCxL0p85iQHzf2jf26iyvFzYmLpmi+sQkl1r0ycdyG1R7fxAg8my7pffBlwp7ndgQDUZRDOPUNWVjCrCkiuf6CHS+BtPh77Jzn8elGm90OnHpbK+ifIH8Iv63TZpl2jSZXVwFbDGs2FaIoabd9CKCnxpW2Yzqmahu+BPyeanBRu5koIcSRH82Pmewc4zLS9IBh95VIMcIE7FvE4Mt1yOIu0FKyUHmh2cyo0YRBSbieFsMNP557II4HOQ0Z3rx34rGPDOuJ7CZUevNIaJZaYChjbRI2FTZKdDCuxHSz9vuziQiUzN0AHn4VYYvElwrTOwpjkYLQUaDe1O16laS2l5VToo7tJTZHt3i7WP8kMu959Yu+S1fMVQbYDjEAMkyq+4Ya2JUQqbfbrLvqGMXcCOFJNaRippV6L+uSJ07u1ki/LEbFiAykuJfGGQ4hyKA2pcms4zbHu/yyr3VOFmSuK5N1g0k/64bNfKmKeQHAOsjysUA5Pue+6/muqzHp0O0Bpm+DVJYPQM8Yop7Fo5wCvlEcjPcXBqlMzKoAdHwh/tx57iXNQOXlRwrN1g6NwS3zcK2SeqZnLT6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(4326008)(82740400003)(40460700003)(8936002)(356005)(5660300002)(81166007)(41300700001)(8676002)(2906002)(86362001)(40480700001)(2876002)(36860700001)(426003)(478600001)(336012)(1076003)(2616005)(7696005)(47076005)(36756003)(26005)(54906003)(70206006)(316002)(6916009)(70586007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:07.6920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c92b1d28-914a-440f-6a0e-08dbd0a7ee31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Jun
 Lei <jun.lei@amd.com>, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Unify pipe resource management logic in dc resource layer.

V2:
Add default case for switch.

CC: Hamza Mahfooz <hamza.mahfooz@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   1 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 146 ++++++++++++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 3 files changed, 148 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 02d3168f1673..0e1d395a9340 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2481,6 +2481,7 @@ static bool dcn32_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 18;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;
+	dc->dml2_options.map_dc_pipes_with_callbacks = true;
 
 	if (ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev) && (dc->config.sdpif_request_limit_words_per_umc == 0))
 		dc->config.sdpif_request_limit_words_per_umc = 16;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 36baf35bb170..fc266c6e1398 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -756,6 +756,148 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool, stream->stream_id);
 }
 
+static unsigned int get_mpc_factor(struct dml2_context *ctx,
+		const struct dc_state *state,
+		const struct dml_display_cfg_st *disp_cfg,
+		struct dml2_dml_to_dc_pipe_mapping *mapping,
+		const struct dc_stream_status *status, unsigned int stream_id,
+		int plane_idx)
+{
+	unsigned int plane_id;
+	unsigned int cfg_idx;
+
+	get_plane_id(state, status->plane_states[plane_idx], stream_id, &plane_id);
+	cfg_idx = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
+	if (ctx->architecture == dml2_architecture_20)
+		return (unsigned int)disp_cfg->hw.DPPPerSurface[cfg_idx];
+	ASSERT(false);
+	return 1;
+}
+
+static unsigned int get_odm_factor(
+		const struct dml2_context *ctx,
+		const struct dml_display_cfg_st *disp_cfg,
+		struct dml2_dml_to_dc_pipe_mapping *mapping,
+		const struct dc_stream_state *stream)
+{
+	unsigned int cfg_idx = find_disp_cfg_idx_by_stream_id(
+			mapping, stream->stream_id);
+
+	if (ctx->architecture == dml2_architecture_20)
+		switch (disp_cfg->hw.ODMMode[cfg_idx]) {
+		case dml_odm_mode_bypass:
+			return 1;
+		case dml_odm_mode_combine_2to1:
+			return 2;
+		case dml_odm_mode_combine_4to1:
+			return 4;
+		default:
+			break;
+		}
+	ASSERT(false);
+	return 1;
+}
+
+static void populate_mpc_factors_for_stream(
+		struct dml2_context *ctx,
+		const struct dml_display_cfg_st *disp_cfg,
+		struct dml2_dml_to_dc_pipe_mapping *mapping,
+		const struct dc_state *state,
+		unsigned int stream_idx,
+		unsigned int odm_factor,
+		unsigned int mpc_factors[MAX_PIPES])
+{
+	const struct dc_stream_status *status = &state->stream_status[stream_idx];
+	unsigned int stream_id = state->streams[stream_idx]->stream_id;
+	int i;
+
+	for (i = 0; i < status->plane_count; i++)
+		if (odm_factor == 1)
+			mpc_factors[i] = get_mpc_factor(
+					ctx, state, disp_cfg, mapping, status,
+					stream_id, i);
+		else
+			mpc_factors[i] = 1;
+}
+
+static void populate_odm_factors(const struct dml2_context *ctx,
+		const struct dml_display_cfg_st *disp_cfg,
+		struct dml2_dml_to_dc_pipe_mapping *mapping,
+		const struct dc_state *state,
+		unsigned int odm_factors[MAX_PIPES])
+{
+	int i;
+
+	for (i = 0; i < state->stream_count; i++)
+		odm_factors[i] = get_odm_factor(
+				ctx, disp_cfg, mapping, state->streams[i]);
+}
+
+static bool map_dc_pipes_for_stream(struct dml2_context *ctx,
+		struct dc_state *state,
+		const struct dc_state *existing_state,
+		const struct dc_stream_state *stream,
+		const struct dc_stream_status *status,
+		unsigned int odm_factor,
+		unsigned int mpc_factors[MAX_PIPES])
+{
+	int plane_idx;
+	bool result = true;
+
+	if (odm_factor == 1)
+		/*
+		 * ODM and MPC combines are by DML design mutually exclusive.
+		 * ODM factor of 1 means MPC factors may be greater than 1.
+		 * In this case, we want to set ODM factor to 1 first to free up
+		 * pipe resources from previous ODM configuration before setting
+		 * up MPC combine to acquire more pipe resources.
+		 */
+		result &= ctx->config.callbacks.update_pipes_for_stream_with_slice_count(
+				state,
+				existing_state,
+				ctx->config.callbacks.dc->res_pool,
+				stream,
+				odm_factor);
+	for (plane_idx = 0; plane_idx < status->plane_count; plane_idx++)
+		result &= ctx->config.callbacks.update_pipes_for_plane_with_slice_count(
+				state,
+				existing_state,
+				ctx->config.callbacks.dc->res_pool,
+				status->plane_states[plane_idx],
+				mpc_factors[plane_idx]);
+	if (odm_factor > 1)
+		result &= ctx->config.callbacks.update_pipes_for_stream_with_slice_count(
+				state,
+				existing_state,
+				ctx->config.callbacks.dc->res_pool,
+				stream,
+				odm_factor);
+	return result;
+}
+
+static bool map_dc_pipes_with_callbacks(struct dml2_context *ctx,
+		struct dc_state *state,
+		const struct dml_display_cfg_st *disp_cfg,
+		struct dml2_dml_to_dc_pipe_mapping *mapping,
+		const struct dc_state *existing_state)
+{
+	unsigned int odm_factors[MAX_PIPES];
+	unsigned int mpc_factors_for_stream[MAX_PIPES];
+	int i;
+	bool result = true;
+
+	populate_odm_factors(ctx, disp_cfg, mapping, state, odm_factors);
+	for (i = 0; i < state->stream_count; i++) {
+		populate_mpc_factors_for_stream(ctx, disp_cfg, mapping, state,
+				i, odm_factors[i], mpc_factors_for_stream);
+		result &= map_dc_pipes_for_stream(ctx, state, existing_state,
+				state->streams[i],
+				&state->stream_status[i],
+				odm_factors[i], mpc_factors_for_stream);
+	}
+	return result;
+}
+
 bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const struct dml_display_cfg_st *disp_cfg, struct dml2_dml_to_dc_pipe_mapping *mapping, const struct dc_state *existing_state)
 {
 	int stream_index, plane_index, i;
@@ -770,6 +912,10 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 	unsigned int odm_mode_array[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0}, dpp_per_surface_array[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
 	struct dc_pipe_mapping_scratch scratch;
 
+	if (ctx->config.map_dc_pipes_with_callbacks)
+		return map_dc_pipes_with_callbacks(
+				ctx, state, disp_cfg, mapping, existing_state);
+
 	if (ctx->architecture == dml2_architecture_21) {
 		/*
 		 * Extract ODM and DPP outputs from DML2.1 and map them in an array as required for pipe mapping in dml2_map_dc_pipes.
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index c3d5b84ee914..5494380062dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -167,6 +167,7 @@ struct dml2_configuration_options {
 	struct dml2_soc_bbox_overrides bbox_overrides;
 	unsigned int max_segments_per_hubp;
 	unsigned int det_segment_size;
+	bool map_dc_pipes_with_callbacks;
 };
 
 /*
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7C1CDB487
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F7B10E426;
	Wed, 18 Oct 2023 17:42:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45D210E41F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXt4JV06pRH8YLkCyzPEZF0LOLudqb6B2vg8IOagr1tzO4QShp9dPJhRM4Rq7Qqf91tgvxBy53dfYeaSuyKOqymdm4DJICETKu6Q8pCF3eYechLsDBXyQWBNTdjymumG9hF0oGNGOnCqdmNDVSmHE0+rbkKsCTIEMnsiQsbXLQTQe+njMu2r4/y27vE78KBCaj4SI30vaaQ0XxXhe6MkC5yxW5o/ENUOn+vLlr2hnJQujrkSbo+AE7Z8fTHPoxZe1bfvmNOMtep+obq56jH6EGEpSxlZ2K/2l/A3YhlUMxXgUZcdMrK84naIboqQt2iwoXM0RPwZscmmFPqBhK+LOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HTMvKrcZt1DdmSHiivT2Em7V020NduJKXnQBH6UJus=;
 b=Ux2Ftw2VOHNWWc4Vat+xLRSESJf2zgSy+nZEat/m9dY1uOiAg8L0TnZcYHvi9Ym2K6HCD3UgqevoW55J6X7axwLJVa2rGjP/CONb7lcgrxr8Fcx29c6Oc0AkycXH65giPg6rxmSu9y7xLLBIX1QAtS1uccEuBNjchwyzuGlD4WGRPhq3HPME5kTrBpLjfuhiUNxo/5HHPs5DqzeeL53tg37rEj9MboZ+/4fkF7uGJzQD8rGB1iC8nm8SU/gSeqmDAMEqqDSiMJPrQTNCYupFuojq5rAdbnekZT/znCHUKSCwfJM8o7GW4LXh/PWA+3NeBu8xtQHAgrqLc+ADJ4R8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HTMvKrcZt1DdmSHiivT2Em7V020NduJKXnQBH6UJus=;
 b=TQtA1qAgHtKR5AXGr3ZYJnWibGlfS64fid+2vriXt1aAcdX89MNszk8KDtTqYmBNHVU12fMPVjWP1gW6S9Icg1efa2VjbC7TiVUWQbwCTbd4MHLiaY2ikIngOCpBAi4mqNNhhzcEwX89bd1+dF8SRNCEya7GKVwUZ2eVh4mH8sE=
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:42:36 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::ff) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 17:42:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:02 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/26] drm/amd/display: implement map dc pipe with callback in
 DML2
Date: Wed, 18 Oct 2023 13:41:17 -0400
Message-ID: <20231018174133.1613439-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 850de3fd-6647-495c-e118-08dbd0019d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXg09ZFmxdIIJ2+al9kudZ+iedpIBdV1W7t7Ul2aE88g1GoAV0MMyo+LYgwVPGKMH+fc3t1htyP4+SNJhrsy1is88u7tKNjpxS7ITGmX7AVh3kBJNTOMFSBjHezxDc2FCWpUAMV2fRWcL4JyQMbtJBX8YhPzxziWqfr6GeD8uWISWx3zeaFzgR5cYEaPrgOwqUapx4SDqgFVFjyyRSxG4HWl1ooJ9LSyllU6lZqqVqQNex1u43LNCYEhwOC0JTwtr9yrcJ0tHwcEYELVVm7Q8QsUgN9tiFtNJm1Z3zqVInDgTTotvcA9DWSO1PKp687uxaZDfToQm2rQYkGqJ+1hG2NKL4syMZw19gRMyQ2IclhTM059CDRKS9qibNKdpzd9uu5wn+tZq+XIX+b2NMehl0DWSuyf18wEgdPiT6T+xoJiUIjoStBMB8+itfSLanxjsQt9SrtVDRXe1Yn19j1/cy7TYzk2al1pY5L95yYTNtpH999oGKqQp6B9j7j2Xe2rSVCLohm6RbR+bWSnkEmR3I+eWqffob5aX/z+n40oNSLMO8oe2oLfpbHDWENibdsCHynDKFfU9QIz6P5BfMblCTzQM2t4qRxPok8TrXk/ekV6sQLOO8U2hzpJLQWG6PWENUpF3g94TLudV9hv0uFvkaUHY+41r9KEeSeCJ4Vn/ZIge0Iw50/GK+KD7qk4aS4dHpDa9AV3QHCUIQM+LOsqIfrCspGtaPsb/t1WAatEWIJei2xqT42qQnlMWK9lnSYDmeT844ZDkZf28xiZPP4DIyLthcFLOXlQBHbcxGXovOBsvEBsx6ki8p2Wbz11T+xw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(54906003)(6916009)(36860700001)(70586007)(70206006)(6666004)(478600001)(7696005)(426003)(356005)(81166007)(336012)(83380400001)(2616005)(316002)(2906002)(41300700001)(8936002)(8676002)(4326008)(2876002)(36756003)(5660300002)(86362001)(82740400003)(47076005)(26005)(1076003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:35.6847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850de3fd-6647-495c-e118-08dbd0019d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Unify pipe resource management logic in dc resource layer.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   1 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 144 ++++++++++++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 3 files changed, 146 insertions(+)

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
index 36baf35bb170..71fce58da44d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -756,6 +756,146 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
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
@@ -770,6 +910,10 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
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


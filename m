Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF47C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F9610E3BC;
	Wed, 17 Jul 2024 19:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bZ7i7B4i";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3488510E3BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSUfTJP7dj38SFJE+vm5eFipA6yDpqBaAR1tgt8+O00dsrH2gQjidtLKqMyK7sPFqrEBgewlSKHc3EKDZI9TD0BpouLk5VV100km/mNYlS3Nkcbwx9fol4yD/MzcC9qGxxwuxzQIEpb8cUQe8LuCRDupsdOtug48ZPnHK6ayGqgIfeYSBzkUSVpWbNQlHQXAkgaYSy4IN8ZeOjEuIMIe2HfEZqCKhOSezvFyymyHOzRPUGNicnilvMe6jgyM7Fk2oXHjlQzN5iWbpBvPLQqfDlhICACHKFMxke0PyM3lJcFP4UlG9Ed/LXbdp3T6pACvUCU7DpBb6FJ8cL6WwH83eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHugqA93u6ydeGSvBpGiZ4wWjAaLrSncf8yopOHS2r0=;
 b=Ys9Bv+mOa/C0tILDvnbHMYztEs3SgeyWhaUfizhpQg+J8RagC43S6AWN5x6jxH8ziSYROiQUW3Y47ESl3zvXPwLokJjs5wv83/xH3Vq8Kzs7hDHcbtWtbziAEdNCc+GiF27qA9+c+t9XjKhg85WGsyqZkPWNnPA+Dg7lupQiCUir6A1CAq6OtweRmTy1PWjdvOveE4+ikAoaB8lp/SoctLAMzbAMGHzoKQJ35xNuwDU8Pu4tAmnEEtJcpiSkyg7oDkRYUwT4ewdqKgZFHbZl9LbI4+MsoVKQX6czGixf4eGks2B5h/rAf1ofEg8DhOZ//BX4HTmxgMoo5UwshyAQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHugqA93u6ydeGSvBpGiZ4wWjAaLrSncf8yopOHS2r0=;
 b=bZ7i7B4igQRmj0JOTVyjKLcmOZx0M570ytpQQEsshwALPcszBeJF3g1lzTICumJIiNxaXtFHvRG+8Y/ntt8NQ5W0Ofj6sGSBRpB+4Ozye9uZWR0/i3p3oPpTyrV8itDkP9Fn1mw0GPhNmel4hm5S5E9lZm6Rc2h8YvOJZhnEbFU=
Received: from CH2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:610:54::26)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Wed, 17 Jul
 2024 19:40:51 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::5a) by CH2PR11CA0016.outlook.office365.com
 (2603:10b6:610:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 19:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:40:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:49 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:40:44 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>
Subject: [PATCH 15/22] drm/amd/display: Check top sink only when multiple
 streams for DP2
Date: Wed, 17 Jul 2024 19:38:54 +0000
Message-ID: <20240717193901.8821-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffe2932-ac95-4e03-46df-08dca6985d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsyLCf54nayeiEoA3Og2t1dEWxhqQr87lhZgIEcLcupxf1XEZegQ4nlnUa0+?=
 =?us-ascii?Q?UXBYphJuu/FyyAuOuhb8PyVQP7fRJJ5gqofuIjtptebfdYgzAysZfgAkKBZG?=
 =?us-ascii?Q?KxwPbU6J+mpOuWnSZDKTmeX9Yw1tpx+d0Tg4twtaMJaPEPgrcV4h3Uz70Hxq?=
 =?us-ascii?Q?fuHGwDmppcV3YB97GcaUGWluJoUM84z3XG6Tfxp8crUe7hhB41fWkZtFSldQ?=
 =?us-ascii?Q?FO7/EJHUBUrXV8j04j1KCUCGCpftyc3ytb8RB5I7fqozwK0tehFrJfP4UkNS?=
 =?us-ascii?Q?ArYv+/NtfiVLFW9v3f2REWgDw//2KpZ/NVZIlHB/W7/EvjtrPFV0pIiZUasM?=
 =?us-ascii?Q?gzGLivKB0rGdstNI8k36YfXVbcm/XEaZuq0jrq054XiWwSsA4PrAKWh51XZv?=
 =?us-ascii?Q?Cr79a9nuXHIhodaCvCFIVXedVU2X0vdYAJyEqDR633KlI6hAZzSJyd4qek4C?=
 =?us-ascii?Q?V/5XUmXMflLwIkmBkk6UdtmXNhPJI2G3KFzpRDVuUdv1zeuwQSfPIf4PbIEX?=
 =?us-ascii?Q?DQVM0jivzbgXJZbo5FK9djHHL3O5xnNTPsRYrL9TYFY0d8yuY1dgskeesyDM?=
 =?us-ascii?Q?/wVbs9b5Ka+vaeSTWLyLdyBSVJiIpG8wnitu5ufVjrdYZmO3m6WPcRvlXbfx?=
 =?us-ascii?Q?ISL1JzkZcHBxi1H7uKRLYDWoyYsrEXWMqn3wQ96K+mwS81bvP2pTliUqdwnD?=
 =?us-ascii?Q?qbSaqmK7f2MNN0HNrEdiBTsUt/SpWUz96zMz1JT6MldNfYR0SXT8c03zQLYH?=
 =?us-ascii?Q?PFAC1aRVoX9u9I6k03T5KnbChOSnlhWYlJULaZMSwol81fSsvWhzDcIXHuPn?=
 =?us-ascii?Q?qG5VDsQzwE3Dx67g1VxL+WGYk1gG1Ez5EOtsAHA3Y0WNF1LR1W7rvib8EdaZ?=
 =?us-ascii?Q?fNmAQ7TFp+7aIiYCIuBbl+k5IdgYuoXKLKHE7whf2Nmi4Dv1XYkpWLcF93Yf?=
 =?us-ascii?Q?/ldsASUMdGGPAiUGRiNHzPJu0d4bZOXCbZzD65bFcml9yWBlWWidPO0ayznB?=
 =?us-ascii?Q?MiGYodWsJnvQxTW3AXzTzgcCJniGpFV/w26QymiEpFdLu4G5MgjZ2dN7biEi?=
 =?us-ascii?Q?7NBFL24CaHhZw4Zio0DVZ2nCFfDzGClKXP8PKaF5LMWrTzitcI1NRoWOubLj?=
 =?us-ascii?Q?BmXkV1TVXIUkDjZKVJoY9YnVZ7YEZrpFZdpiEvc19pBOr15eUqkVRn8v5/8b?=
 =?us-ascii?Q?mgd6zefDSiCeS9VhmguCE0bMqEMd0wAiRkMdlzesGWpoxheSWP6u+4Bl0la6?=
 =?us-ascii?Q?ANkIi+oQO52KfkkFbQSwLrxkXfShrg/s08JEGdfveoaIFtYMHJRACCQ5/NWe?=
 =?us-ascii?Q?rlaqON+1CORgK+7ocOMtVQjuz/WRxd5+HScekIr2iQmC7M0AWd00Y5uw6zQi?=
 =?us-ascii?Q?+BwN9XbYjr2hG5Ho4u9LpMij0CY/adBBWzhrZovg5gl5r/1NvYciEQPlSYH4?=
 =?us-ascii?Q?T0du+oXLqQJb1DKKp49af7mQJLlgETR/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:40:50.5917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffe2932-ac95-4e03-46df-08dca6985d1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
When switching from extended to second display only
mode, the top remote sink is not removed while the top stream
itself is released. This causes DML to think there is no
DP2 output encoder because top remote sink does not match
with the second stream and disables DTBCLK and causes
hang.

[how]
For DP2.0 MST hubs, only treat 1st remote sink as an encoder
only when there are multiple displays connected.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 .../amd/display/dc/dml2/dml2_internal_types.h |  1 +
 .../display/dc/dml2/dml2_translation_helper.c | 41 +++++++++++++++++--
 .../display/dc/dml2/dml2_translation_helper.h |  2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  6 +--
 4 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
index b566f53608c6..3ba184be25d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
@@ -101,6 +101,7 @@ struct dml2_wrapper_scratch {
 	struct dml2_dml_to_dc_pipe_mapping dml_to_dc_pipe_mapping;
 	bool enable_flexible_pipe_mapping;
 	bool plane_duplicate_exists;
+	unsigned int dp2_mst_stream_count;
 };
 
 struct dml2_helper_det_policy_scratch {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 8b9dcee77266..25d4ef040173 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -733,7 +733,8 @@ static void populate_dml_timing_cfg_from_stream_state(struct dml_timing_cfg_st *
 }
 
 static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *out, unsigned int location,
-				const struct dc_stream_state *in, const struct pipe_ctx *pipe)
+				const struct dc_stream_state *in, const struct pipe_ctx *pipe,
+				unsigned int dp2_mst_stream_count)
 {
 	unsigned int output_bpc;
 
@@ -746,7 +747,7 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 	case SIGNAL_TYPE_DISPLAY_PORT:
 		out->OutputEncoder[location] = dml_dp;
-		if (is_dp2p0_output_encoder(pipe))
+		if (is_dp2p0_output_encoder(pipe, dp2_mst_stream_count))
 			out->OutputEncoder[location] = dml_dp2p0;
 		break;
 	case SIGNAL_TYPE_EDP:
@@ -1193,6 +1194,37 @@ static void dml2_populate_pipe_to_plane_index_mapping(struct dml2_context *dml2,
 		plane_index = 0;
 	}
 }
+
+static unsigned int calculate_dp2_mst_stream_count(struct dc_state *context)
+{
+	int i, j;
+	unsigned int dp2_mst_stream_count = 0;
+
+	for (i = 0; i < context->stream_count; i++) {
+		struct dc_stream_state *stream = context->streams[i];
+
+		if (!stream || stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
+			continue;
+
+		for (j = 0; j < MAX_PIPES; j++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+			if (!pipe_ctx || !pipe_ctx->stream)
+				continue;
+
+			if (stream != pipe_ctx->stream)
+				continue;
+
+			if (pipe_ctx->stream_res.hpo_dp_stream_enc && pipe_ctx->link_res.hpo_dp_link_enc) {
+				dp2_mst_stream_count++;
+				break;
+			}
+		}
+	}
+
+	return dp2_mst_stream_count;
+}
+
 static void populate_dml_writeback_cfg_from_stream_state(struct dml_writeback_cfg_st *out,
 		unsigned int location, const struct dc_stream_state *in)
 {
@@ -1255,6 +1287,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 	if (dml2->v20.dml_core_ctx.ip.hostvm_enable)
 		dml2->v20.dml_core_ctx.policy.AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter;
 
+	dml2->v20.scratch.dp2_mst_stream_count = calculate_dp2_mst_stream_count(context);
 	dml2_populate_pipe_to_plane_index_mapping(dml2, context);
 
 	for (i = 0; i < context->stream_count; i++) {
@@ -1276,7 +1309,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 		populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_stream_location, context->streams[i]);
-		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context);
+		populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_stream_location, context->streams[i], current_pipe_context, dml2->v20.scratch.dp2_mst_stream_count);
 		/*Call site for populate_dml_writeback_cfg_from_stream_state*/
 		populate_dml_writeback_cfg_from_stream_state(&dml_dispcfg->writeback,
 			disp_cfg_stream_location, context->streams[i]);
@@ -1337,7 +1370,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 
 				if (j >= 1) {
 					populate_dml_timing_cfg_from_stream_state(&dml_dispcfg->timing, disp_cfg_plane_location, context->streams[i]);
-					populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_plane_location, context->streams[i], current_pipe_context);
+					populate_dml_output_cfg_from_stream_state(&dml_dispcfg->output, disp_cfg_plane_location, context->streams[i], current_pipe_context, dml2->v20.scratch.dp2_mst_stream_count);
 					switch (context->streams[i]->debug.force_odm_combine_segments) {
 					case 2:
 						dml2->v20.dml_core_ctx.policy.ODMUse[disp_cfg_plane_location] = dml_odm_use_policy_combine_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
index d764773938f4..55659b22d87f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
@@ -36,6 +36,6 @@ void dml2_translate_socbb_params(const struct dc *in_dc, struct soc_bounding_box
 void dml2_translate_soc_states(const struct dc *in_dc, struct soc_states_st *out, int num_states);
 void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg);
 void dml2_update_pipe_ctx_dchub_regs(struct _vcs_dpi_dml_display_rq_regs_st *rq_regs, struct _vcs_dpi_dml_display_dlg_regs_st *disp_dlg_regs, struct _vcs_dpi_dml_display_ttu_regs_st *disp_ttu_regs, struct pipe_ctx *out);
-bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe);
+bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe, unsigned int dp2_mst_stream_count);
 
 #endif //__DML2_TRANSLATION_HELPER_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 92238ff333a4..7655501e75d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -153,7 +153,7 @@ unsigned int dml2_util_get_maximum_odm_combine_for_output(bool force_odm_4to1, e
 	}
 }
 
-bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
+bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx, unsigned int dp2_mst_stream_count)
 {
 	if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
 		return false;
@@ -162,7 +162,7 @@ bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 	ASSERT(pipe_ctx->stream_res.hpo_dp_stream_enc ? pipe_ctx->link_res.hpo_dp_link_enc != NULL : true);
 
 	/* Count MST hubs once by treating only 1st remote sink in topology as an encoder */
-	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0]) {
+	if (pipe_ctx->stream->link && pipe_ctx->stream->link->remote_sinks[0] && dp2_mst_stream_count > 1) {
 		return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
 			pipe_ctx->link_res.hpo_dp_link_enc &&
 			dc_is_dp_signal(pipe_ctx->stream->signal) &&
@@ -181,7 +181,7 @@ bool is_dtbclk_required(const struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
-		if (is_dp2p0_output_encoder(&context->res_ctx.pipe_ctx[i]))
+		if (is_dp2p0_output_encoder(&context->res_ctx.pipe_ctx[i], context->bw_ctx.dml2->v20.scratch.dp2_mst_stream_count))
 			return true;
 	}
 	return false;
-- 
2.39.2


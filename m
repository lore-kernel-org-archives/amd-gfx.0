Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D477DC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5D510E9C9;
	Wed, 28 Sep 2022 19:41:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226FB10E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy63ICESK46AHkC5N2TfBoatN6TSxnoR86zSmMknETDkHA4oG3eo/BXx4Tgc++B0CjRybuH4GPMP+V7M1QoxiWydMEoZWYtWUiY/6sHO4p/c/3rT0jmd6tkiHoLd6/j6Q2x5AbXQKB50c5c+S1Oa+DSmaNRX8T8wCMhK77/uG7PsWq4hVfSo422ngJyGLIrtcovH1HYvzGisuazCfSm2RHnc115TyM3rdBRq+YJ5hHzXhepCtQXtslzxbvmQnnwGHiv2PGvPtXOoCsNL5EfohSz9Qt/q2MEytUQk1ByAXqAYYsRStZV+4TyHj2c8DzHW6kVBzy6AuzAbk1MLmP2CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em2us7Qz4ULrUr07SjZQVXpQClVVInLXEuWeIkkpipk=;
 b=CIboB5GsFqSdACdgiQxUsnWZBBAFHiztBsU6PBKm3bOoaXykRhZ8McunqF5AgBydM8zWgBLzaldKbSpGULtNpitbQ5oIZ2pH9BmCfJVw4kjkOtFxkYpso9NzQrnP+pXdVV5wMVHqPa+IFCH+Sh48LtOr8F01d6OFUK74YZxpYIJNeee97aWkBFauq8XJ4/6vxC0xZYiC+mf+wzbSBKS2RWVPYtYjhYU0sH5EXVt3MXryHrn5wzic1z7bx9xcb7FiPz+OLVltB4PHGMTcM3g2T1m4b3bfQt/xuBvBd3O32Grbq8DGqFXqCbUjiR6GwipRlazAJan8st8qOHW5cWVSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em2us7Qz4ULrUr07SjZQVXpQClVVInLXEuWeIkkpipk=;
 b=YUwX0W0uKPxnGdHmJ8vI8/b7CrEVebdVotCmlo+5ocM/MxFc0YwFFsozl8MTvjiDuqc/tiYdK3QnGNeRU0ihTeDhMs78++tUURTkoesTc+O6AB/BFRY1K1aHnnpDoljHCOEY1e/jH095p4adV1fPFhsdrugU5q5Le6kQpGunQuk=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.23; Wed, 28 Sep 2022 19:41:06 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::d4) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:05 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:03 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/36] drm/amd/display: For SubVP pipe split case use min
 transition into MPO
Date: Wed, 28 Sep 2022 15:40:04 -0400
Message-ID: <20220928194028.144879-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: d04ce999-87fa-4c8d-6ebd-08daa1896263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5N3aDi0P5PjEfo43j1swno0Tz6u7gRhDYKVasrV7Yv/k+dvc3GXyQiGyJ6Tv8608WhcZAUqMj5raIg3VyqyQd/aQsOMRQwFDOEfB5PgY5emPGS7PRY7DXR6TL4zgo2T4K+ZXSOUMg7Cgm+tPMyOw7jJPf9pBvxUXruV04nmicivtrvT2JC9aT/Zq38BcDyViueYDpjowrfhD3pL3hXsZdEeTGWeFsssZMSb8J3NbTcv5CA/V00EFivPgbGHtmJGymzcVPNgDH/KhhE+uWqx64AOVQMkoEUbBdtXElA0F2ywNoxwT/l9VPvhbJ33O3GLvXRnDCK/kOI4Vn4mnQ61nCM88LwDxhUSJQCJxKlZhYvkY3QtF+ty1LYbtG18m0TW2bwjQLFxkAQL2jrXRZaijaGOx6A7NGztzIzBqjwLZUatxot524BAnNjjU8JACZyc91yrP818z7Y7uDgKEvvdzT0OsEXsmwUD8X+oH51Ijn8O/sSM6+CGHDiy02AeFaYQWWUv/mVC4ieYjqv0jP91qnW9lTYd4c8Tnjl8u0dnnGHJSvg1iDiUYswju52GMQUcRVdHJGx2buPFRIFjee+BZL2kHOgF8QNTgA7ZXdFAWT7+6iWAvWe2a1PwnRnvRN9TEMb2NAnyvqlr9zs3OZJtZlAivcHcs/rKorRyjimXDugq2YHjvBsp1yjpXHu3wM3nXAaVCt9xejDxBmdRRcwXdaUSdq15lp8agXPA7O31cyzgQmxcfAU3TiN/R5ovRIpR149tbTCZw47lWTBQliUVk65pGUj2YEzLKZhhv2zrIXAGiVA0lxtD9JxYP+gKcJdiLTxFINaKFD9qocPP6JoPOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(336012)(426003)(47076005)(86362001)(16526019)(54906003)(7696005)(316002)(40480700001)(36756003)(26005)(186003)(83380400001)(478600001)(1076003)(6916009)(40460700003)(356005)(81166007)(36860700001)(82740400003)(5660300002)(4326008)(82310400005)(41300700001)(8936002)(2906002)(44832011)(70206006)(8676002)(70586007)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:05.8527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04ce999-87fa-4c8d-6ebd-08daa1896263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542
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
 wayne.lin@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For SubVP pipe split case we need to use a minimial transition
  when opening MPO video since we are transitioning from 4 pipes
  to 3 pipes where an OPP for a previous MPCC will change
- Also save and restore mall config when doing fast_validate in case
  there was a shallow copy of the dc->current_state

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 36 ++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 18 +++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 20 ++++++
 .../display/dc/dcn32/dcn32_resource_helpers.c | 71 +++++++++++++++++++
 4 files changed, 145 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2584cb8f44e2..9b7c6bac4760 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3561,6 +3561,7 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 
 	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
 	bool force_minimal_pipe_splitting = false;
+	uint32_t i;
 
 	*is_plane_addition = false;
 
@@ -3592,6 +3593,36 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		}
 	}
 
+	/* For SubVP pipe split case when adding MPO video
+	 * we need to add a minimal transition. In this case
+	 * there will be 2 streams (1 main stream, 1 phantom
+	 * stream).
+	 */
+	if (cur_stream_status &&
+			dc->current_state->stream_count == 2 &&
+			stream->mall_stream_config.type == SUBVP_MAIN) {
+		bool is_pipe_split = false;
+
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream &&
+					(dc->current_state->res_ctx.pipe_ctx[i].bottom_pipe ||
+					dc->current_state->res_ctx.pipe_ctx[i].next_odm_pipe)) {
+				is_pipe_split = true;
+				break;
+			}
+		}
+
+		/* determine if minimal transition is required due to SubVP*/
+		if (surface_count > 0 && is_pipe_split) {
+			if (cur_stream_status->plane_count > surface_count) {
+				force_minimal_pipe_splitting = true;
+			} else if (cur_stream_status->plane_count < surface_count) {
+				force_minimal_pipe_splitting = true;
+				*is_plane_addition = true;
+			}
+		}
+	}
+
 	return force_minimal_pipe_splitting;
 }
 
@@ -3601,6 +3632,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	struct dc_state *transition_context = dc_create_state(dc);
 	enum pipe_split_policy tmp_mpc_policy;
 	bool temp_dynamic_odm_policy;
+	bool temp_subvp_policy;
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
 
@@ -3615,6 +3647,9 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	temp_dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
 	dc->debug.enable_single_display_2to1_odm_policy = false;
 
+	temp_subvp_policy = dc->debug.force_disable_subvp;
+	dc->debug.force_disable_subvp = true;
+
 	dc_resource_state_copy_construct(transition_base_context, transition_context);
 
 	//commit minimal state
@@ -3643,6 +3678,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 		dc->debug.pipe_split_policy = tmp_mpc_policy;
 
 	dc->debug.enable_single_display_2to1_odm_policy = temp_dynamic_odm_policy;
+	dc->debug.force_disable_subvp = temp_subvp_policy;
 
 	if (ret != DC_OK) {
 		/*this should never happen*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 05de97ea855f..752a4accb116 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1798,14 +1798,32 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	int vlevel = 0;
 	int pipe_cnt = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	struct mall_temp_config mall_temp_config;
 	DC_LOGGER_INIT(dc->ctx->logger);
 
+	/* For fast validation, there are situations where a shallow copy of
+	 * of the dc->current_state is created for the validation. In this case
+	 * we want to save and restore the mall config because we always
+	 * teardown subvp at the beginning of validation (and don't attempt
+	 * to add it back if it's fast validation). If we don't restore the
+	 * subvp config in cases of fast validation + shallow copy of the
+	 * dc->current_state, the dc->current_state will have a partially
+	 * removed subvp state when we did not intend to remove it.
+	 */
+	if (fast_validate) {
+		memset(&mall_temp_config, 0, sizeof(mall_temp_config));
+		dcn32_save_mall_state(dc, context, &mall_temp_config);
+	}
+
 	BW_VAL_TRACE_COUNT();
 
 	DC_FP_START();
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
 	DC_FP_END();
 
+	if (fast_validate)
+		dcn32_restore_mall_state(dc, context, &mall_temp_config);
+
 	if (pipe_cnt == 0)
 		goto validate_out;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index a24f538bdc4c..f76120e67c16 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -45,6 +45,17 @@
 extern struct _vcs_dpi_ip_params_st dcn3_2_ip;
 extern struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc;
 
+/* Temp struct used to save and restore MALL config
+ * during validation.
+ *
+ * TODO: Move MALL config into dc_state instead of stream struct
+ * to avoid needing to save/restore.
+ */
+struct mall_temp_config {
+	struct mall_stream_config mall_stream_config[MAX_PIPES];
+	bool is_phantom_plane[MAX_PIPES];
+};
+
 struct dcn32_resource_pool {
 	struct resource_pool base;
 };
@@ -122,6 +133,15 @@ void dcn32_determine_det_override(struct dc *dc,
 
 void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes);
+
+void dcn32_save_mall_state(struct dc *dc,
+		struct dc_state *context,
+		struct mall_temp_config *temp_config);
+
+void dcn32_restore_mall_state(struct dc *dc,
+		struct dc_state *context,
+		struct mall_temp_config *temp_config);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 7f318ced5dee..d51d0c40ae5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -380,3 +380,74 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 	} else
 		dcn32_determine_det_override(dc, context, pipes);
 }
+
+/**
+ * *******************************************************************************************
+ * dcn32_save_mall_state: Save MALL (SubVP) state for fast validation cases
+ *
+ * This function saves the MALL (SubVP) case for fast validation cases. For fast validation,
+ * there are situations where a shallow copy of the dc->current_state is created for the
+ * validation. In this case we want to save and restore the mall config because we always
+ * teardown subvp at the beginning of validation (and don't attempt to add it back if it's
+ * fast validation). If we don't restore the subvp config in cases of fast validation +
+ * shallow copy of the dc->current_state, the dc->current_state will have a partially
+ * removed subvp state when we did not intend to remove it.
+ *
+ * NOTE: This function ONLY works if the streams are not moved to a different pipe in the
+ *       validation. We don't expect this to happen in fast_validation=1 cases.
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ * @param [out]: temp_config: struct used to cache the existing MALL state
+ *
+ * @return: void
+ *
+ * *******************************************************************************************
+ */
+void dcn32_save_mall_state(struct dc *dc,
+		struct dc_state *context,
+		struct mall_temp_config *temp_config)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream)
+			temp_config->mall_stream_config[i] = pipe->stream->mall_stream_config;
+
+		if (pipe->plane_state)
+			temp_config->is_phantom_plane[i] = pipe->plane_state->is_phantom;
+	}
+}
+
+/**
+ * *******************************************************************************************
+ * dcn32_restore_mall_state: Restore MALL (SubVP) state for fast validation cases
+ *
+ * Restore the MALL state based on the previously saved state from dcn32_save_mall_state
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in/out]: context: New DC state to be programmed, restore MALL state into here
+ * @param [in]: temp_config: struct that has the cached MALL state
+ *
+ * @return: void
+ *
+ * *******************************************************************************************
+ */
+void dcn32_restore_mall_state(struct dc *dc,
+		struct dc_state *context,
+		struct mall_temp_config *temp_config)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream)
+			pipe->stream->mall_stream_config = temp_config->mall_stream_config[i];
+
+		if (pipe->plane_state)
+			pipe->plane_state->is_phantom = temp_config->is_phantom_plane[i];
+	}
+}
-- 
2.37.2


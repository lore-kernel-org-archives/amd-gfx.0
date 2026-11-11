Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C12606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a9b/yUFb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653B310F8AD;
	Wed, 11 Nov 2026 01:40:44 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB50410F8C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwitC9zTeDgBxu9KeBXqstzCxBqDqE3Zm9wNCE8tzo6aLp0izNejqw2USNEI6MHUrRJrAtM6N4n0KWU25INglnbpxU97mhFvuohh6ET5EgN28isTM1VKazTb2k1Ygf+FQyQwjtekxJN0uFjX3mO8CjmwFIOwjlBZ63K5eZ7wWzb3wrzVjVfDhFHpPymN4W2YLuQck9+OV6xJvgt+LsyNkVv0gDkMJCtjSzGALkSJ/7NaxSWPMxVZbuSwugFS1LQ4pAlsLK+8RNeNU7sBxWjj9gYHYi4dkvVORDIGrp+PxO+ijwj9//MqKAE7trbOnozePLpH6865txuuRc1v9n75LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcxuQpdRLwI2wPmsiN3YqdzAtmh07c0fOi1GXiMZVsI=;
 b=J5g7TceDjGwV38o0FJFE+HgEyIzWointscHFy2h0nZbiJIeFxuOMZuxWSyHXYpDBGs++N5GkcYXlfhMV6Sbs/pUUjbRHUV7O/pdimbnDEP4cPg9lpw8ci2Bxfv1yWyvt9/siKcc2g6B/UQgXL6m7LlpdSVc+jIetD6aTnfLKDCKEHT6YW/apobqfByP4NsGGj3rqoFo4xf/vINJrcXdcZcPZah5Ovg5vpVm488rE6Yi4u8g8UeZYGKgIEmAg8b7EBhkjuvpUAZxyZCdvTyx0J+F0+Di6vHW1zNpaqcjndKOmnL76b/bZd8622+ilUsZklWkW49WvcFgEhX6aTWTL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcxuQpdRLwI2wPmsiN3YqdzAtmh07c0fOi1GXiMZVsI=;
 b=a9b/yUFb49MV6ckbr70vBRBKvWo/avQa7yw8Pr67nbyMWd6Lt5XufjNb9y/F6lUyH/PSg2QJ6aawfRjHp77VMgmEaEf0jjq/pgilAUQEmvrn73hdismF9YIc4aP9CeEq3/l+C7T7FfFEYpLNHyTSCCcUYQ0YR/ayoffVophO9Mw=
Received: from BY5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:1e0::32)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 11 Nov
 2026 01:40:32 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::22) by BY5PR03CA0022.outlook.office365.com
 (2603:10b6:a03:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 11 Nov 2026 01:40:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:29 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:26 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/74] drm/amd/display: Remove duplicate block sequence
 leftovers
Date: Wed, 11 Nov 2026 09:28:09 +0800
Message-ID: <20261111014100.3596072-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: b14985f1-a083-4db1-fbb4-08df3f94c638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|261021123027099003|22082099003|18002099003|10067099003|3023799007|56012099006|261026140227099003|261028144727099003|261026121527099003|261009223027099003|261022075727099003|261009221227099003|261022105027099003|261102123227099003|11063799006|261021121427099003;
X-Microsoft-Antispam-Message-Info: Y7HEBhcJNwe8GX1XghGRcVZA1YT/uUJg9pi/HApYZPXhT31J++zDcYMAJLDZ0lhkDn3rnL8DPMw7eBHEqjQM3xgybiZR+Tel2rKG0k/kIrDh5LF6iLIhMJMbqPI1k9rPUly3OZDNknIrZbf1pSHlAuai2G8VGojylytqD/117QOiKl/+/0Opa+PmHGqhqTIGbydIQXm8N2MzQrsEhtShI6zszuolYaCn/8KpLeoMWUBRzvfJ3B3VU4EkfQv6XwUK4PwJd6gJ5mZB//NjAGSxHSsusPHTLsimunKp0Tp5L9FiwYm1QokorBCGUMQ4rby0zdSnpGjL+gN9126MRLrDzbgXyYhRpqHqg0lhC9AEiwl6G0SWx0wlC58R5RAvN+Nx3Y6n/4rkvWcnoJE4Necr7mifjsLrIlLZ0+ZhmrOvk3L/TfWJxTt8uhRGzRv75p2ElQNH/Yfa9q+yfZ5nxvsBEhXrDg41QhCFDRC6QGhMrrs6phd053mv9vd8NmF3WI1kRTp3Qf+b4YJLdVjC5PpEZnBfTZGM5OqULQ4Jh6Cgqjo/HosLULord8pim7bCn5rfR4CXfeisntQTKAbnCRz6Kdow127BG6PfVYfgK+fleNjncByztWXI+oKVtLwKKr4aAvyey0++DZP1FQycBh0JlqBSa+CQq9/FrO1hK7nlnR3gUbuTAwH+NQsiiiAEsmNO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(261021123027099003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(261026140227099003)(261028144727099003)(261026121527099003)(261009223027099003)(261022075727099003)(261009221227099003)(261022105027099003)(261102123227099003)(11063799006)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oocmlwxpp6YP9BZBFmY1avDgZy3t75gGwTJ7b8GgnKEYrdfak7d+mvinqPHUrk50B7hs/NQvTpE/3+uSRxCzxxr4B6MJiEQwMsfqt5bAaPnbcYpEnQotAo8snIgre1TB143wb9WjhZgM/87/zOc6+EQsdwyatJwQgXLhs9qGKdCTseYbbOE50gxnt6P+m4uMibpAmdjq4Vr7HZlbrYbP9Ht1Y4CoW6DUlUN8KVaZ2OF1l4kjb96b9gGI3i9foUoLldWsCM8Tvl6BImDEsbL7icW/YavO7eedngREo+9bDUu1Vn7j3IZAx6NPLLre/rrYgBUsT9dEjXvxylTZ6m25haF9KJ5v1IkUN93nEEMZHXri4n6wR1p4Z54bwvwN2LZ0+DBTl/IVQGUqt+Qdn8VnPy6kbSas0WFyAzDPirHpMXcAJJPlmY5E7xoOjnwu39s2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:32.2194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14985f1-a083-4db1-fbb4-08df3f94c638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
hw_sequencer.h carried parameter structs, union members, executor
declarations that no builder, adder or dispatcher case uses.
Each one duplicates work that existing opcodes already do.
These are also breaking BLS rules as contain dc,
dc_state or pipe_ctx pointers.

Below list contains removed structures and information where
it is already supported by other HWSS operations:
- program_tg_params, hwss_program_tg:
  TG_PROGRAM_GLOBAL_SYNC, TG_WAIT_FOR_STATE, TG_SET_VTG_PARAMS,
  TG_SETUP_VERTICAL_INTERRUPT2
- setup_vupdate_interrupt_params:
  TG_SETUP_VERTICAL_INTERRUPT2
- update_dchubp_dpp_params:
  update_dchubp_dpp_sequence steps
- set_disp_pattern_generator_params:
  OPP_SET_DISP_PATTERN_GENERATOR
- mpc_update_mpcc_params, hwss_mpc_update_mpcc:
  MPC_UPDATE_BLENDING, MPC_REMOVE_MPCC, MPC_INSERT_PLANE,
  MPC_UPDATE_VISUAL_CONFIRM
- hubp_program_mcache_id_and_split_coordinate_params:
  HUBP_PROGRAM_MCACHE_ID
- hwss_blank_pixel_data:
  blank_pixel_data_sequence steps
- PROGRAM_MALL_PIPE_CONFIG:
  HUBP_UPDATE_MALL_SEL and HUBP_PREPARE_SUBVP_BUFFERING from
  program_mall_pipe_config_sequence

[How]
Remove the unused structs and union members, the hwss_mpc_update_mpcc
executor, the hwss_blank_pixel_data and hwss_program_tg declarations and
the PROGRAM_MALL_PIPE_CONFIG enumerator.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 10 ----
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 51 -------------------
 2 files changed, 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 694c425e22b4..512e128d52b3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -4191,16 +4191,6 @@ void hwss_dpp_set_cursor_matrix(union block_sequence_params *params)
 		dpp->funcs->set_cursor_matrix(dpp, color_space, *cursor_csc_color_matrix);
 }
 
-void hwss_mpc_update_mpcc(union block_sequence_params *params)
-{
-	struct dc *dc = params->mpc_update_mpcc_params.dc;
-	struct pipe_ctx *pipe_ctx = params->mpc_update_mpcc_params.pipe_ctx;
-	struct dce_hwseq *hws = dc->hwseq;
-
-	if (hws->funcs.update_mpcc)
-		hws->funcs.update_mpcc(dc, pipe_ctx);
-}
-
 void hwss_mpc_update_blending(union block_sequence_params *params)
 {
 	struct mpc *mpc = params->mpc_update_blending_params.mpc;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 6580d13d9041..9f97503a02ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -456,12 +456,6 @@ struct dsc_enable_with_opp_params {
 	int opp_inst;
 };
 
-struct program_tg_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-	struct dc_state *context;
-};
-
 struct tg_program_global_sync_params {
 	struct timing_generator *tg;
 	int vready_offset;
@@ -504,11 +498,6 @@ struct pipe_control_lock_params {
 	struct tg_3dlut_wa_unlock_params tg_3dlut_wa_unlock_params;
 };
 
-struct setup_vupdate_interrupt_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-};
-
 struct tg_setup_vertical_interrupt2_params {
 	struct timing_generator *tg;
 	int start_line;
@@ -531,12 +520,6 @@ struct program_det_segments_params {
 	unsigned int det_size;
 };
 
-struct update_dchubp_dpp_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-	struct dc_state *context;
-};
-
 struct opp_set_dyn_expansion_params {
 	struct output_pixel_processor *opp;
 	enum dc_color_space color_space;
@@ -583,18 +566,6 @@ struct set_abm_immediate_disable_params {
 	struct pipe_ctx *pipe_ctx;
 };
 
-struct set_disp_pattern_generator_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-	enum controller_dp_test_pattern test_pattern;
-	enum controller_dp_color_space color_space;
-	enum dc_color_depth color_depth;
-	const struct tg_color *solid_color;
-	int width;
-	int height;
-	int offset;
-};
-
 struct mpc_update_blending_params {
 	struct mpc *mpc;
 	struct mpcc_blnd_cfg blnd_cfg;
@@ -935,11 +906,6 @@ struct dpp_set_cursor_matrix_params {
 	struct dc_csc_transform *cursor_csc_color_matrix;
 };
 
-struct mpc_update_mpcc_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-};
-
 struct dpp_set_scaler_params {
 	struct dpp *dpp;
 	const struct scaler_data *scl_data;
@@ -951,11 +917,6 @@ struct hubp_mem_program_viewport_params {
 	const struct rect *viewport_c;
 };
 
-struct hubp_program_mcache_id_and_split_coordinate_params {
-	struct hubp *hubp;
-	struct mcache_regs_struct *mcache_regs;
-};
-
 struct cursor_lock_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
@@ -1237,7 +1198,6 @@ union block_sequence_params {
 	struct dsc_disconnect_params dsc_disconnect_params;
 	struct dsc_read_state_params dsc_read_state_params;
 	struct dsc_enable_with_opp_params dsc_enable_with_opp_params;
-	struct program_tg_params program_tg_params;
 	struct tg_program_global_sync_params tg_program_global_sync_params;
 	struct tg_wait_for_state_params tg_wait_for_state_params;
 	struct tg_set_vtg_params_params tg_set_vtg_params_params;
@@ -1245,10 +1205,8 @@ union block_sequence_params {
 	struct dpp_set_hdr_multiplier_params dpp_set_hdr_multiplier_params;
 	struct tg_set_gsl_params tg_set_gsl_params;
 	struct tg_set_gsl_source_select_params tg_set_gsl_source_select_params;
-	struct setup_vupdate_interrupt_params setup_vupdate_interrupt_params;
 	struct program_det_size_params program_det_size_params;
 	struct program_det_segments_params program_det_segments_params;
-	struct update_dchubp_dpp_params update_dchubp_dpp_params;
 	struct opp_set_dyn_expansion_params opp_set_dyn_expansion_params;
 	struct opp_program_fmt_params opp_program_fmt_params;
 	struct opp_program_bit_depth_reduction_params opp_program_bit_depth_reduction_params;
@@ -1256,7 +1214,6 @@ union block_sequence_params {
 	struct set_abm_pipe_params set_abm_pipe_params;
 	struct set_abm_level_params set_abm_level_params;
 	struct set_abm_immediate_disable_params set_abm_immediate_disable_params;
-	struct set_disp_pattern_generator_params set_disp_pattern_generator_params;
 	struct mpc_remove_mpcc_params mpc_remove_mpcc_params;
 	struct dc_set_optimized_required_params dc_set_optimized_required_params;
 	struct hubp_disconnect_params hubp_disconnect_params;
@@ -1318,7 +1275,6 @@ union block_sequence_params {
 	struct hubp_setup_interdependent2_params hubp_setup_interdependent2_params;
 	struct hubp_setup_interdependent_params hubp_setup_interdependent_params;
 	struct dpp_set_cursor_matrix_params dpp_set_cursor_matrix_params;
-	struct mpc_update_mpcc_params mpc_update_mpcc_params;
 	struct mpc_update_blending_params mpc_update_blending_params;
 	struct mpc_assert_idle_mpcc_params mpc_assert_idle_mpcc_params;
 	struct mpc_insert_plane_params mpc_insert_plane_params;
@@ -1467,7 +1423,6 @@ enum block_sequence_func {
 	HUBP_WAIT_FLIP_PENDING,
 	TG_WAIT_DOUBLE_BUFFER_PENDING,
 	UPDATE_FORCE_PSTATE,
-	PROGRAM_MALL_PIPE_CONFIG,
 	HUBBUB_APPLY_DEDCN21_147_WA,
 	MPC_SET_DWB_MUX,
 	MPC_DISABLE_DWB_MUX,
@@ -2112,8 +2067,6 @@ void hwss_opp_pipe_clock_control(union block_sequence_params *params);
 
 void hwss_opp_program_left_edge_extra_pixel(union block_sequence_params *params);
 
-void hwss_blank_pixel_data(union block_sequence_params *params);
-
 void hwss_dccg_set_dto_dscclk(union block_sequence_params *params);
 
 void hwss_dsc_set_config(union block_sequence_params *params);
@@ -2164,8 +2117,6 @@ void hwss_prepare_bandwidth(struct dc *dc, union block_sequence_params *params);
 
 void hwss_link_set_dpms_on(union block_sequence_params *params);
 
-void hwss_program_tg(union block_sequence_params *params);
-
 void hwss_tg_program_global_sync(union block_sequence_params *params);
 
 void hwss_tg_wait_for_state(union block_sequence_params *params);
@@ -2327,8 +2278,6 @@ void hwss_hubp_setup_interdependent(union block_sequence_params *params);
 
 void hwss_dpp_set_cursor_matrix(union block_sequence_params *params);
 
-void hwss_mpc_update_mpcc(union block_sequence_params *params);
-
 void hwss_mpc_update_blending(union block_sequence_params *params);
 
 void hwss_mpc_assert_idle_mpcc(union block_sequence_params *params);
-- 
2.43.0


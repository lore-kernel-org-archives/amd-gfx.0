Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50C6C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE6410EC8A;
	Tue, 18 Aug 2026 20:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="29CXYl6J";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010049.outbound.protection.outlook.com
 [40.93.198.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31F810EC8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPYWGXgukCvlBycrBZD+lTFjE90Y3FB/Mu9OOmcWxLqtA9r7KK1neQsVnblwwnwQan9tyJHDu01VHxuzgOVcdk463ZmmiZ5LMCUwl9GzfDu1WCbEfjijy4h3Kk9DIjaO7zcj0RPCLmHLNU6tFUGMN6tWpsm76/AvAwUBmx6rViJ5C093YEIlevDgLfMMBa3vEj776x6sh00JoS5le6hvZf0eTPcNokV4eDoYyv/UP9l8pQ3zKJYTzh8yAvmODdyZhKJmkkBNf6qNeBJoQUi0qwWnw44d1Ovnq+ho49V2oGncOACrdJjw5cOTEyTieTvOEMtbgucJGPgj11+pSmUDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecrLKrVTX+Tev0l94jC70rUkmsNoKGUSrZTjQEmOOGc=;
 b=fLQw43jBxDOQ7O41W9dRUH2RMPUqDcc5VSAbjSGyBMvBig7OQGbyKQ02DIO3RpNSG+AMd7bR7D+BKoV3qmhdy0m9596wGArXb/jMjomD38xKEygtpbF2p1FkH2gXLaY/v4koEUx6sq/o9a9t2+DFbrXcbyKUlHIw12Tv94eD2qzkPwieorAsKu9iGILvXJakJX/QwsAJlNmFgYvNFMCguPgQh5p5W4+d8BVeRy3PSxS/HHO5tTGczeiYpCPl7TIxZET2EmkbOAYFI2CjGCeP3MAbCwPR56dUXMuqwZtvZxaixBdG8Y5Tb0LYnHVEek/gypXULq0pqYWWXC8JoIt+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecrLKrVTX+Tev0l94jC70rUkmsNoKGUSrZTjQEmOOGc=;
 b=29CXYl6Jk6FB9wT4xn93T/J6QHLaNXQMHfiuiMONykqssldMuDSt2m2eihmu7PojeGY5XNwxMz5qBSN0KbuKJLg2vMpeVHUclFL5HpF9n2whPuyaL+D742/KmcTUAtTnslpe/s+hF6eZVErwL3AGK306kngvI3R4lgcrS39QysM=
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 18 Aug
 2026 20:21:56 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::c) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:21:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:50 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:50 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <Tomasz.Siemek@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/82] drm/amd/display: Refactor DPP_SET_INPUT_TRANSFER_FUNC
 to drop pipe_ctx
Date: Tue, 18 Aug 2026 16:14:55 -0400
Message-ID: <20260818202139.4172592-4-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b7d355-66cc-4e6a-051b-08defd665958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|56012099006|10067099003|22082099003|11063799006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: WqALYRdxLzmW6WauDgreS/T8jgBTCZW/n6KYH4qcvZRUkMEe/XIAYj93xeFlXcNIt+xkFb2/kcSMcwghnz3zLNfvDIZ8H38Z9IsGxACQnQvd1txdAzSINW71wJQTc7wfYgZ/eTS9mUstYMRymvKtnTDC/Wq50u9JzoUK72zlUgrs5BRTWWHEDr0n/7ttOJCnmI2OaGzr7pQfikPpgZklq+VY2lpSbchIuWeKyaI+z+v50bmhCL0rDdaPYyEYekiBDGXeE/2m7NGnhgFzr+wRW+2bynbb1E6NggrHTIfH6sekMRmZzDRcIDHDMWjRsQubteJpy+bCYoCSrnMfDxzuWctIKAaDCMCymi/r8PWHCXQRYxHZM4wOtyms/yvRa86NfXWu+e7yD62YgPkb/gAS3DWNtgEYEKOfIW+EoZyB8f3UpctYzHrfN1cZJrhMrJ09XqqCqjHhe/8ri4XAH5+mZXJL9Zl0Hr/oDDlHbEyaYbY41Jukj+VC+8r1bn8RdUt13L+Tmp29ZJbL2SZnF8mEPFtuVFEZbHK+3rGA6YeRCY1MN4NT0ProXNrMR8cE61DMhO00IOuoZnKsPtCuzYRA/D3y1iOZSL0XoW67ajVcjrgsr37jFeUjBXVbZpb6t6u+E+wi0qglri/JGnqkJPjybKDheVphksm1uA24R/eGikV+e11MYka6nuRUa5KPPfuQDKio/jZ+ZUIuo++kELKbEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(56012099006)(10067099003)(22082099003)(11063799006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yWa+xW/pNpWEDNtRysNgBGjAQq3lyg9L5Pet3HEClClfwmcr95GWXZOSM63wWQ9t05EzEt9KwDxjunW1hu5xxPLodoQIKZWw7xaAR2rk+SNp56/bcPWudqFtkp18fq/ICPnJh25NqKjPDOPv9t2J1hA/R3jajjW5n9IkBXHLdrRAyitkB/ndFr7lYfG2yI0AZK0cjnYMo4LQjJITWqFFPgB4ExmdYh5TD9lWbQZbDJlc5dYeicNWBve5A117Bgn77qQ48BuM/DVOpeDEiZUK9yIyXkizkuDDb9OTOYQ+Cj+yevhHZzj/dGoI5QWXWiP1qYumm591lpbQj1vy0+fEK3mFeKy7j3i+0WLsTq5qFJXEKb1j2skEp5dwGS5aTsQI1V6HD9dOMSeKAUb4dD4yjSwxCjVsdjjAX4RriWgjv/BKB1WaSJppJI6EjVrvaTp2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:21:56.0159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b7d355-66cc-4e6a-051b-08defd665958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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

From: Tomasz Siemek <Tomasz.Siemek@amd.com>

[Why]
Pipe_ctx shouldn't be passed as block sequence block parameter.

[How]
- Adjust arguments for:
	- set_input_transfer_func,
	- populate_mcm_luts,
	- set_mcm_location_post_blend,
	- set_mcm_luts,
	- program_rmcm_luts.
- Remove const qualifier from plane_state in set_mcm_luts since it is
  mutated.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <Tomasz.Siemek@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 68 +++++++++++++++----
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 11 ++-
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 35 +++++-----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 63 ++++++++---------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  7 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 45 ++++++------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  8 +--
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 60 ++++++++--------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   | 10 +--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 29 ++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  6 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 49 +++++++------
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   | 12 ++--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 12 +++-
 .../display/dc/hwss/hw_sequencer_private.h    | 18 ++---
 17 files changed, 238 insertions(+), 201 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 9e82980e809b0..d61c4d9488c59 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1514,9 +1514,22 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 				if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_bits.gamma_change) {
-					block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
-					block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
-					block_sequence[*num_steps].params.set_input_transfer_func_params.plane_state = current_mpc_pipe->plane_state;
+					struct pipe_ctx *primary_dpp_pipe =
+						resource_get_primary_dpp_pipe(current_mpc_pipe);
+
+					block_sequence[*num_steps].params.set_input_transfer_func_params =
+						(struct set_input_transfer_func_params) {
+						.dc = dc,
+						.dpp = current_mpc_pipe->plane_res.dpp,
+						.hubp = current_mpc_pipe->plane_res.hubp,
+						.primary_hubp = primary_dpp_pipe ?
+							primary_dpp_pipe->plane_res.hubp : current_mpc_pipe->plane_res.hubp,
+						.ipp = current_mpc_pipe->plane_res.ipp,
+						.mpc = dc->res_pool->mpc,
+						.mpcc_id = current_mpc_pipe->plane_res.mpcc_inst,
+						.stream = current_mpc_pipe->stream,
+						.plane_state = current_mpc_pipe->plane_state,
+					};
 					block_sequence[*num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
 					(*num_steps)++;
 				}
@@ -1717,9 +1730,7 @@ void hwss_execute_sequence(struct dc *dc,
 					params->update_plane_addr_params.pipe_ctx);
 			break;
 		case DPP_SET_INPUT_TRANSFER_FUNC:
-			hws->funcs.set_input_transfer_func(params->set_input_transfer_func_params.dc,
-					params->set_input_transfer_func_params.pipe_ctx,
-					params->set_input_transfer_func_params.plane_state);
+			hws->funcs.set_input_transfer_func(&params->set_input_transfer_func_params);
 			break;
 		case DPP_PROGRAM_GAMUT_REMAP:
 			if (dc->hwss.program_gamut_remap)
@@ -2290,15 +2301,25 @@ void hwss_add_hubp_update_plane_addr(struct block_sequence_state *seq_state,
 /*
  * Helper function to add DPP set input transfer function to block sequence
  */
-void hwss_add_dpp_set_input_transfer_func(struct block_sequence_state *seq_state,
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_plane_state *plane_state)
+void hwss_add_dpp_set_input_transfer_func(struct block_sequence_state *seq_state, struct dc *dc,
+	struct pipe_ctx *pipe_ctx)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.set_input_transfer_func_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.set_input_transfer_func_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].params.set_input_transfer_func_params.plane_state = plane_state;
+		struct pipe_ctx *primary_dpp_pipe = resource_get_primary_dpp_pipe(pipe_ctx);
+
+		seq_state->steps[*seq_state->num_steps].params.set_input_transfer_func_params =
+			(struct set_input_transfer_func_params) {
+			.dc = dc,
+			.dpp = pipe_ctx->plane_res.dpp,
+			.hubp = pipe_ctx->plane_res.hubp,
+			.primary_hubp = primary_dpp_pipe ?
+				primary_dpp_pipe->plane_res.hubp : pipe_ctx->plane_res.hubp,
+			.ipp = pipe_ctx->plane_res.ipp,
+			.mpc = dc->res_pool->mpc,
+			.mpcc_id = pipe_ctx->plane_res.mpcc_inst,
+			.plane_state = pipe_ctx->plane_state,
+			.stream = pipe_ctx->stream,
+		};
 		seq_state->steps[*seq_state->num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
 		(*seq_state->num_steps)++;
 	}
@@ -4544,6 +4565,26 @@ void hwss_disable_audio_stream(struct dc *dc, union block_sequence_params *param
 			params->disable_audio_stream_params.pipe_ctx);
 }
 
+void hwss_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	if (dc->hwseq->funcs.set_input_transfer_func) {
+		struct pipe_ctx *primary_dpp_pipe = resource_get_primary_dpp_pipe(pipe_ctx);
+
+		dc->hwseq->funcs.set_input_transfer_func(&(struct set_input_transfer_func_params) {
+			.dc = dc,
+			.dpp = pipe_ctx->plane_res.dpp,
+			.hubp = pipe_ctx->plane_res.hubp,
+			.primary_hubp = primary_dpp_pipe ?
+				primary_dpp_pipe->plane_res.hubp : pipe_ctx->plane_res.hubp,
+			.ipp = pipe_ctx->plane_res.ipp,
+			.mpc = dc->res_pool->mpc,
+			.mpcc_id = pipe_ctx->plane_res.mpcc_inst,
+			.plane_state = pipe_ctx->plane_state,
+			.stream = pipe_ctx->stream,
+		});
+	}
+}
+
 void hwss_prepare_bandwidth(struct dc *dc, union block_sequence_params *params)
 {
 	if (dc && dc->hwss.prepare_bandwidth)
@@ -6203,4 +6244,3 @@ void hwss_hubp_wait_for_dcc_meta_prop(struct dc *dc, struct pipe_ctx *top_pipe_t
 		dc->hwss.wait_for_dcc_meta_propagation(delay);
 	}
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index ff0c6e64c2b4a..ef91c61033a33 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -283,11 +283,10 @@ static void dce110_prescale_params(struct ipp_prescale_params *prescale_params,
 }
 
 static bool
-dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-			       const struct dc_plane_state *plane_state)
+dce110_set_input_transfer_func(struct set_input_transfer_func_params *params)
 {
-	(void)dc;
-	struct input_pixel_processor *ipp = pipe_ctx->plane_res.ipp;
+	struct input_pixel_processor *ipp = params->ipp;
+	struct dc_plane_state *plane_state = params->plane_state;
 	const struct dc_transfer_func *tf = NULL;
 	struct ipp_prescale_params prescale_params = { 0 };
 	bool result = true;
@@ -3140,7 +3139,6 @@ static void dce110_program_front_end_for_pipe(
 	struct xfm_grph_csc_adjustment adjust;
 	struct out_csc_color_matrix tbl_entry;
 	unsigned int i;
-	struct dce_hwseq *hws = dc->hwseq;
 
 	memset(&tbl_entry, 0, sizeof(tbl_entry));
 
@@ -3199,7 +3197,7 @@ static void dce110_program_front_end_for_pipe(
 	if (pipe_ctx->plane_state->update_bits.full_update ||
 			pipe_ctx->plane_state->update_bits.in_transfer_func_change ||
 			pipe_ctx->plane_state->update_bits.gamma_change)
-		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
+		hwss_set_input_transfer_func(dc, pipe_ctx);
 
 	if (pipe_ctx->plane_state->update_bits.full_update)
 		hwss_set_output_transfer_func(dc, pipe_ctx);
@@ -3689,5 +3687,6 @@ void dce110_hw_sequencer_construct(struct dc *dc)
 	dc->hwss = dce110_funcs;
 	dc->hwseq->funcs = dce110_private_funcs;
 }
+
 #endif /* CONFIG_DRM_AMD_DC_DCE */
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
index 221996b348abf..1652e47716a0a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
@@ -275,7 +275,6 @@ dce60_program_front_end_for_pipe(
 	struct xfm_grph_csc_adjustment adjust;
 	struct out_csc_color_matrix tbl_entry;
 	unsigned int i;
-	struct dce_hwseq *hws = dc->hwseq;
 
 	DC_LOGGER_INIT();
 	memset(&tbl_entry, 0, sizeof(tbl_entry));
@@ -335,7 +334,7 @@ dce60_program_front_end_for_pipe(
 	if (pipe_ctx->plane_state->update_bits.full_update ||
 			pipe_ctx->plane_state->update_bits.in_transfer_func_change ||
 			pipe_ctx->plane_state->update_bits.gamma_change)
-		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
+		hwss_set_input_transfer_func(dc, pipe_ctx);
 
 	if (pipe_ctx->plane_state->update_bits.full_update)
 		hwss_set_output_transfer_func(dc, pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 2739f7acce988..d76fc6ef38c4e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2083,39 +2083,38 @@ void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx)
 		pipe_ctx->plane_state->address.grph_stereo.left_addr = addr;
 }
 
-bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-			const struct dc_plane_state *plane_state)
+bool dcn10_set_input_transfer_func(struct set_input_transfer_func_params *params)
 {
-	(void)dc;
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+	struct dpp *dpp = params->dpp;
+	struct dc_plane_state *plane_state = params->plane_state;
 	const struct dc_transfer_func *tf = NULL;
 	bool result = true;
 
-	if (dpp_base == NULL)
+	if (dpp == NULL)
 		return false;
 
 	tf = &plane_state->in_transfer_func;
 
-	if (!dpp_base->ctx->dc->debug.always_use_regamma
+	if (!dpp->ctx->dc->debug.always_use_regamma
 		&& !plane_state->gamma_correction.is_identity
 			&& dce_use_lut(plane_state->format))
-		dpp_base->funcs->dpp_program_input_lut(dpp_base, &plane_state->gamma_correction);
+		dpp->funcs->dpp_program_input_lut(dpp, &plane_state->gamma_correction);
 
 	if (tf->type == TF_TYPE_PREDEFINED) {
 		switch (tf->tf) {
 		case TRANSFER_FUNCTION_SRGB:
-			dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_HW_sRGB);
+			dpp->funcs->dpp_set_degamma(dpp, IPP_DEGAMMA_MODE_HW_sRGB);
 			break;
 		case TRANSFER_FUNCTION_BT709:
-			dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_HW_xvYCC);
+			dpp->funcs->dpp_set_degamma(dpp, IPP_DEGAMMA_MODE_HW_xvYCC);
 			break;
 		case TRANSFER_FUNCTION_LINEAR:
-			dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_BYPASS);
+			dpp->funcs->dpp_set_degamma(dpp, IPP_DEGAMMA_MODE_BYPASS);
 			break;
 		case TRANSFER_FUNCTION_PQ:
-			dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_USER_PWL);
-			cm_helper_translate_curve_to_degamma_hw_format(tf, &dpp_base->degamma_params);
-			dpp_base->funcs->dpp_program_degamma_pwl(dpp_base, &dpp_base->degamma_params);
+			dpp->funcs->dpp_set_degamma(dpp, IPP_DEGAMMA_MODE_USER_PWL);
+			cm_helper_translate_curve_to_degamma_hw_format(tf, &dpp->degamma_params);
+			dpp->funcs->dpp_program_degamma_pwl(dpp, &dpp->degamma_params);
 			result = true;
 			break;
 		default:
@@ -2123,12 +2122,12 @@ bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			break;
 		}
 	} else if (tf->type == TF_TYPE_BYPASS) {
-		dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_BYPASS);
+		dpp->funcs->dpp_set_degamma(dpp, IPP_DEGAMMA_MODE_BYPASS);
 	} else {
 		cm_helper_translate_curve_to_degamma_hw_format(tf,
-					&dpp_base->degamma_params);
-		dpp_base->funcs->dpp_program_degamma_pwl(dpp_base,
-				&dpp_base->degamma_params);
+					&dpp->degamma_params);
+		dpp->funcs->dpp_program_degamma_pwl(dpp,
+				&dpp->degamma_params);
 		result = true;
 	}
 
@@ -3303,7 +3302,7 @@ void dcn10_program_pipe(
 	if (pipe_ctx->plane_state->update_bits.full_update ||
 			pipe_ctx->plane_state->update_bits.in_transfer_func_change ||
 			pipe_ctx->plane_state->update_bits.gamma_change)
-		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
+		hwss_set_input_transfer_func(dc, pipe_ctx);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
 	 * only do gamma programming for full update.
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index a93109c2199b1..1f36bd58beb24 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -74,8 +74,7 @@ void dcn10_program_output_csc(struct dc *dc,
 		uint16_t *matrix,
 		int opp_id);
 bool dcn10_set_output_transfer_func(struct set_output_transfer_func_params *params);
-bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-			const struct dc_plane_state *plane_state);
+bool dcn10_set_input_transfer_func(struct set_input_transfer_func_params *params);
 void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn10_reset_hw_ctx_wrap(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 66e2a6eb41c09..23e191d472991 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1065,9 +1065,8 @@ bool dcn20_set_output_transfer_func(struct set_output_transfer_func_params *otf_
 }
 
 bool dcn20_set_blend_lut(
-	struct pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state)
+	struct dpp *dpp, struct dc_plane_state *plane_state)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	bool result = true;
 	const struct pwl_params *blend_lut = NULL;
 
@@ -1076,18 +1075,17 @@ bool dcn20_set_blend_lut(
 	else if (plane_state->cm.blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 		cm_helper_translate_curve_to_hw_format(plane_state->ctx,
 				&plane_state->cm.blend_func,
-				&dpp_base->regamma_params, false);
-		blend_lut = &dpp_base->regamma_params;
+				&dpp->regamma_params, false);
+		blend_lut = &dpp->regamma_params;
 	}
-	result = dpp_base->funcs->dpp_program_blnd_lut(dpp_base, blend_lut);
+	result = dpp->funcs->dpp_program_blnd_lut(dpp, blend_lut);
 
 	return result;
 }
 
 bool dcn20_set_shaper_3dlut(
-	struct pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state)
+	struct dpp *dpp, struct dc_plane_state *plane_state)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	bool result = true;
 	const struct pwl_params *shaper_lut = NULL;
 
@@ -1096,35 +1094,34 @@ bool dcn20_set_shaper_3dlut(
 	else if (plane_state->cm.shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 		cm_helper_translate_curve_to_hw_format(plane_state->ctx,
 				&plane_state->cm.shaper_func,
-				&dpp_base->shaper_params, true);
-		shaper_lut = &dpp_base->shaper_params;
+				&dpp->shaper_params, true);
+		shaper_lut = &dpp->shaper_params;
 	}
 
-	result = dpp_base->funcs->dpp_program_shaper_lut(dpp_base, shaper_lut);
+	dpp->funcs->dpp_program_shaper_lut(dpp, shaper_lut);
 	if (plane_state->cm.lut3d_func.state.bits.initialized == 1)
-		result = dpp_base->funcs->dpp_program_3dlut(dpp_base,
+		result = dpp->funcs->dpp_program_3dlut(dpp,
 								&plane_state->cm.lut3d_func.lut_3d);
 	else
-		result = dpp_base->funcs->dpp_program_3dlut(dpp_base, NULL);
+		result = dpp->funcs->dpp_program_3dlut(dpp, NULL);
 
 	return result;
 }
 
-bool dcn20_set_input_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state)
+bool dcn20_set_input_transfer_func(struct set_input_transfer_func_params *params)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+	struct dpp *dpp = params->dpp;
+	struct dc_plane_state *plane_state = params->plane_state;
+	struct dce_hwseq *hws = params->dc->hwseq;
 	const struct dc_transfer_func *tf = NULL;
 	bool result = true;
 	bool use_degamma_ram = false;
 
-	if (dpp_base == NULL || plane_state == NULL)
+	if (dpp == NULL || plane_state == NULL)
 		return false;
 
-	hws->funcs.set_shaper_3dlut(pipe_ctx, plane_state);
-	hws->funcs.set_blend_lut(pipe_ctx, plane_state);
+	hws->funcs.set_shaper_3dlut(dpp, plane_state);
+	hws->funcs.set_blend_lut(dpp, plane_state);
 
 	tf = &plane_state->in_transfer_func;
 
@@ -1133,13 +1130,13 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
 
 	if (use_degamma_ram == true) {
 		if (tf->type == TF_TYPE_HWPWL)
-			dpp_base->funcs->dpp_program_degamma_pwl(dpp_base,
+			dpp->funcs->dpp_program_degamma_pwl(dpp,
 					&tf->pwl);
 		else if (tf->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			cm_helper_translate_curve_to_degamma_hw_format(tf,
-					&dpp_base->degamma_params);
-			dpp_base->funcs->dpp_program_degamma_pwl(dpp_base,
-				&dpp_base->degamma_params);
+					&dpp->degamma_params);
+			dpp->funcs->dpp_program_degamma_pwl(dpp,
+				&dpp->degamma_params);
 		}
 		return true;
 	}
@@ -1149,21 +1146,21 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
 	if (tf->type == TF_TYPE_PREDEFINED) {
 		switch (tf->tf) {
 		case TRANSFER_FUNCTION_SRGB:
-			dpp_base->funcs->dpp_set_degamma(dpp_base,
+			dpp->funcs->dpp_set_degamma(dpp,
 					IPP_DEGAMMA_MODE_HW_sRGB);
 			break;
 		case TRANSFER_FUNCTION_BT709:
-			dpp_base->funcs->dpp_set_degamma(dpp_base,
+			dpp->funcs->dpp_set_degamma(dpp,
 					IPP_DEGAMMA_MODE_HW_xvYCC);
 			break;
 		case TRANSFER_FUNCTION_LINEAR:
-			dpp_base->funcs->dpp_set_degamma(dpp_base,
+			dpp->funcs->dpp_set_degamma(dpp,
 					IPP_DEGAMMA_MODE_BYPASS);
 			break;
 		case TRANSFER_FUNCTION_PQ:
-			dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_USER_PWL);
-			cm_helper_translate_curve_to_degamma_hw_format(tf, &dpp_base->degamma_params);
-			dpp_base->funcs->dpp_program_degamma_pwl(dpp_base, &dpp_base->degamma_params);
+			dpp->funcs->dpp_set_degamma(dpp, IPP_DEGAMMA_MODE_USER_PWL);
+			cm_helper_translate_curve_to_degamma_hw_format(tf, &dpp->degamma_params);
+			dpp->funcs->dpp_program_degamma_pwl(dpp, &dpp->degamma_params);
 			result = true;
 			break;
 		default:
@@ -1171,7 +1168,7 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
 			break;
 		}
 	} else if (tf->type == TF_TYPE_BYPASS)
-		dpp_base->funcs->dpp_set_degamma(dpp_base,
+		dpp->funcs->dpp_set_degamma(dpp,
 				IPP_DEGAMMA_MODE_BYPASS);
 	else {
 		/*
@@ -1179,7 +1176,7 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
 		 * fix is required for this use case
 		 */
 		BREAK_TO_DEBUGGER();
-		dpp_base->funcs->dpp_set_degamma(dpp_base,
+		dpp->funcs->dpp_set_degamma(dpp,
 				IPP_DEGAMMA_MODE_BYPASS);
 	}
 
@@ -1987,7 +1984,7 @@ static void dcn20_program_pipe(
 			pipe_ctx->plane_state->update_bits.gamma_change ||
 			pipe_ctx->plane_state->update_bits.lut_3d ||
 			pipe_ctx->update_flags.bits.enable))
-		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
+		hwss_set_input_transfer_func(dc, pipe_ctx);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
 	 * only do gamma programming for powering on, internal memcmp to avoid
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index 749348d3c7938..9312c88e31ad9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -31,9 +31,9 @@
 void dcn20_log_color_state(struct dc *dc,
 			   struct dc_log_buffer_ctx *log_ctx);
 bool dcn20_set_blend_lut(
-	struct pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state);
+	struct dpp *dpp, struct dc_plane_state *plane_state);
 bool dcn20_set_shaper_3dlut(
-	struct pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state);
+	struct dpp *dpp, struct dc_plane_state *plane_state);
 void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context);
@@ -42,8 +42,7 @@ void dcn20_post_unlock_program_front_end(
 		struct dc_state *context);
 void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
-bool dcn20_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-			const struct dc_plane_state *plane_state);
+bool dcn20_set_input_transfer_func(struct set_input_transfer_func_params *params);
 bool dcn20_set_output_transfer_func(struct set_output_transfer_func_params *params);
 void dcn20_program_output_csc(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 8c29aa2cd2c92..71608f07be938 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -234,9 +234,8 @@ void dcn30_log_color_state(struct dc *dc,
 }
 
 bool dcn30_set_blend_lut(
-	struct pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state)
+	struct dpp *dpp, struct dc_plane_state *plane_state)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	bool result = true;
 	const struct pwl_params *blend_lut = NULL;
 
@@ -245,14 +244,14 @@ bool dcn30_set_blend_lut(
 	else if (plane_state->cm.blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 		result = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
 				&plane_state->cm.blend_func,
-				&dpp_base->regamma_params,
+				&dpp->regamma_params,
 				false);
 		if (!result)
 			return result;
 
-		blend_lut = &dpp_base->regamma_params;
+		blend_lut = &dpp->regamma_params;
 	}
-	result = dpp_base->funcs->dpp_program_blnd_lut(dpp_base, blend_lut);
+	result = dpp->funcs->dpp_program_blnd_lut(dpp, blend_lut);
 
 	return result;
 }
@@ -314,17 +313,16 @@ static bool dcn30_set_mpc_shaper_3dlut(struct dpp *dpp, struct mpc *mpc,
 	return result;
 }
 
-bool dcn30_set_input_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state)
+bool dcn30_set_input_transfer_func(struct set_input_transfer_func_params *params)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+	struct dpp *dpp = params->dpp;
+	struct dce_hwseq *hws = params->dc->hwseq;
+	struct dc_plane_state *plane_state = params->plane_state;
 	enum dc_transfer_func_predefined tf;
 	bool result = true;
-	const struct pwl_params *params = NULL;
+	const struct pwl_params *pwl_params = NULL;
 
-	if (dpp_base == NULL || plane_state == NULL)
+	if (dpp == NULL || plane_state == NULL)
 		return false;
 
 	tf = TRANSFER_FUNCTION_UNITY;
@@ -332,25 +330,24 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
 	if (plane_state->in_transfer_func.type == TF_TYPE_PREDEFINED)
 		tf = plane_state->in_transfer_func.tf;
 
-	dpp_base->funcs->dpp_set_pre_degam(dpp_base, tf);
+	dpp->funcs->dpp_set_pre_degam(dpp, tf);
 
 	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
-		params = &plane_state->in_transfer_func.pwl;
+		pwl_params = &plane_state->in_transfer_func.pwl;
 	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
 		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
 							&plane_state->in_transfer_func,
-							&dpp_base->degamma_params, false))
-		params = &dpp_base->degamma_params;
+							&dpp->degamma_params, false))
+		pwl_params = &dpp->degamma_params;
 
-	result = dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
+	result = dpp->funcs->dpp_program_gamcor_lut(dpp, pwl_params);
+
+	if (dpp->funcs->dpp_program_blnd_lut)
+		hws->funcs.set_blend_lut(dpp, plane_state);
+	if (dpp->funcs->dpp_program_shaper_lut &&
+			dpp->funcs->dpp_program_3dlut)
+		hws->funcs.set_shaper_3dlut(dpp, plane_state);
 
-	if (pipe_ctx->stream_res.opp && pipe_ctx->stream_res.opp->ctx) {
-		if (dpp_base->funcs->dpp_program_blnd_lut)
-			hws->funcs.set_blend_lut(pipe_ctx, plane_state);
-		if (dpp_base->funcs->dpp_program_shaper_lut &&
-				dpp_base->funcs->dpp_program_3dlut)
-			hws->funcs.set_shaper_3dlut(pipe_ctx, plane_state);
-	}
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 0399642076eb5..65014d42195ca 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -56,12 +56,10 @@ bool dcn30_mmhubbub_warmup(
 void dcn30_log_color_state(struct dc *dc,
 			   struct dc_log_buffer_ctx *log_ctx);
 
-bool dcn30_set_blend_lut(struct pipe_ctx *pipe_ctx,
-		const struct dc_plane_state *plane_state);
+bool dcn30_set_blend_lut(struct dpp *dpp,
+		struct dc_plane_state *plane_state);
 
-bool dcn30_set_input_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state);
+bool dcn30_set_input_transfer_func(struct set_input_transfer_func_params *params);
 
 void dcn30_program_gamut_remap(struct program_gamut_remap_params *params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index e188796cf272d..ec38fc2ba65cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -477,26 +477,30 @@ bool dcn32_set_mpc_shaper_3dlut(struct dpp *dpp, struct mpc *mpc,
 	return result;
 }
 
-bool dcn32_set_mcm_luts(
-	struct pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state)
+bool dcn32_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
+	struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
+	struct dc_stream_state *stream,
+	struct dc_plane_state *plane_state)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	bool rval, result;
 	const struct pwl_params *lut_params = NULL;
 
+	(void)dc;
+	(void)hubp;
+	(void)primary_hubp;
+	(void)stream;
+
 	// 1D LUT
 	if (plane_state->cm.blend_func.type == TF_TYPE_HWPWL)
 		lut_params = &plane_state->cm.blend_func.pwl;
 	else if (plane_state->cm.blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 		result = cm3_helper_translate_curve_to_degamma_hw_format(
 			&plane_state->cm.blend_func,
-			&dpp_base->regamma_params);
+			&dpp->regamma_params);
 		if (!result)
 			return result;
 
-		lut_params = &dpp_base->regamma_params;
+		lut_params = &dpp->regamma_params;
 	}
 	mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
 	lut_params = NULL;
@@ -505,12 +509,12 @@ bool dcn32_set_mcm_luts(
 	if (plane_state->cm.shaper_func.type == TF_TYPE_HWPWL)
 		lut_params = &plane_state->cm.shaper_func.pwl;
 	else if (plane_state->cm.shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		// TODO: dpp_base replace
+		// TODO: dpp replace
 		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
 			&plane_state->cm.shaper_func,
-			&dpp_base->shaper_params,
+			&dpp->shaper_params,
 			true);
-		lut_params = rval ? &dpp_base->shaper_params : NULL;
+		lut_params = rval ? &dpp->shaper_params : NULL;
 	}
 
 	mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
@@ -524,19 +528,17 @@ bool dcn32_set_mcm_luts(
 	return result;
 }
 
-bool dcn32_set_input_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state)
+bool dcn32_set_input_transfer_func(struct set_input_transfer_func_params *params)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-	struct mpc *mpc = dc->res_pool->mpc;
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+	struct dce_hwseq *hws = params->dc->hwseq;
+	struct dpp *dpp = params->dpp;
+	struct dc_plane_state *plane_state = params->plane_state;
 
 	enum dc_transfer_func_predefined tf;
 	bool result = true;
-	const struct pwl_params *params = NULL;
+	const struct pwl_params *pwl_params = NULL;
 
-	if (mpc == NULL || plane_state == NULL)
+	if (params->mpc == NULL || plane_state == NULL)
 		return false;
 
 	tf = TRANSFER_FUNCTION_UNITY;
@@ -544,24 +546,24 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 	if (plane_state->in_transfer_func.type == TF_TYPE_PREDEFINED)
 		tf = plane_state->in_transfer_func.tf;
 
-	if (dpp_base->funcs->dpp_set_pregam_state)
-		dpp_base->funcs->dpp_set_pregam_state(dpp_base, tf, plane_state->scaling_linearity);
+	if (dpp->funcs->dpp_set_pregam_state)
+		dpp->funcs->dpp_set_pregam_state(dpp, tf, plane_state->scaling_linearity);
 	else
-		dpp_base->funcs->dpp_set_pre_degam(dpp_base, tf);
+		dpp->funcs->dpp_set_pre_degam(dpp, tf);
 
 	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
-		params = &plane_state->in_transfer_func.pwl;
+		pwl_params = &plane_state->in_transfer_func.pwl;
 	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
 		cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
-								&dpp_base->degamma_params))
-		params = &dpp_base->degamma_params;
+								&dpp->degamma_params))
+		pwl_params = &dpp->degamma_params;
 
-	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
+	dpp->funcs->dpp_program_gamcor_lut(dpp, pwl_params);
 
-	if (pipe_ctx->stream_res.opp &&
-			pipe_ctx->stream_res.opp->ctx &&
-			hws->funcs.set_mcm_luts)
-		result = hws->funcs.set_mcm_luts(pipe_ctx, plane_state);
+	if (hws->funcs.set_mcm_luts)
+		result = hws->funcs.set_mcm_luts(params->dc, dpp, params->hubp,
+			params->primary_hubp, params->mpc, params->mpcc_id,
+			params->stream, plane_state);
 
 	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 090d94d38343b..c85ff14596afb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -47,12 +47,12 @@ void dcn32_cab_for_ss_control(struct dc *dc, bool enable);
 
 void dcn32_commit_subvp_config(struct dc *dc, struct dc_state *context);
 
-bool dcn32_set_mcm_luts(struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state);
+bool dcn32_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
+				struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
+				struct dc_stream_state *stream,
+				struct dc_plane_state *plane_state);
 
-bool dcn32_set_input_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state);
+bool dcn32_set_input_transfer_func(struct set_input_transfer_func_params *params);
 
 bool dcn32_set_mpc_shaper_3dlut(struct dpp *dpp_base, struct mpc *mpc,
 	int mpcc_id, const struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index bdefe699f8ca2..0e107754c891e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -421,18 +421,12 @@ void dcn401_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state)
+bool dcn401_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
+				struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
+				struct dc_stream_state *stream,
+				struct dc_plane_state *plane_state)
 {
-	struct dc *dc = pipe_ctx->plane_res.hubp->ctx->dc;
-	const struct pipe_ctx *primary_dpp_pipe_ctx = resource_get_primary_dpp_pipe(pipe_ctx);
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
-	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct hubp *primary_hubp = primary_dpp_pipe_ctx ?
-			primary_dpp_pipe_ctx->plane_res.hubp : hubp;   /* fall back to current pipe */
 	const struct dc_plane_cm *cm = &plane_state->cm;
-	int mpcc_id = hubp->inst;
-	struct mpc *mpc = dc->res_pool->mpc;
 	union mcm_lut_params m_lut_params;
 	struct dc_3dlut_dma lut3d_dma;
 	bool lut_enable;
@@ -440,6 +434,9 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 	bool rval;
 	bool result = true;
 
+	(void)dc;
+	(void)stream;
+
 	/* decide LUT bank based on current in use */
 	mpc->funcs->get_lut_mode(mpc, MCM_LUT_1DLUT, mpcc_id, &lut_enable, &lut_bank_a);
 	if (!lut_enable) {
@@ -466,9 +463,9 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 		else if (cm->blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 			rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
 					&cm->blend_func,
-					&dpp_base->regamma_params,
+					&dpp->regamma_params,
 					false);
-			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
+			m_lut_params.pwl = rval ? &dpp->regamma_params : NULL;
 		}
 
 		if (!m_lut_params.pwl) {
@@ -493,9 +490,9 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 			ASSERT(false);
 			rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
 					&cm->shaper_func,
-					&dpp_base->shaper_params,
+					&dpp->shaper_params,
 					true);
-			m_lut_params.pwl = rval ? &dpp_base->shaper_params : NULL;
+			m_lut_params.pwl = rval ? &dpp->shaper_params : NULL;
 		}
 		if (!m_lut_params.pwl) {
 			lut_enable = false;
@@ -2291,7 +2288,7 @@ void dcn401_program_pipe(
 			pipe_ctx->plane_state->update_bits.gamma_change ||
 			pipe_ctx->plane_state->update_bits.lut_3d ||
 			pipe_ctx->update_flags.bits.enable))
-		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
+		hwss_set_input_transfer_func(dc, pipe_ctx);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
 	 * only do gamma programming for powering on, internal memcmp to avoid
@@ -2448,7 +2445,7 @@ void dcn401_program_pipe_sequence(
 			pipe_ctx->plane_state->update_bits.lut_3d ||
 			pipe_ctx->update_flags.bits.enable)) {
 
-		hwss_add_dpp_set_input_transfer_func(seq_state, dc, pipe_ctx, pipe_ctx->plane_state);
+		hwss_add_dpp_set_input_transfer_func(seq_state, dc, pipe_ctx);
 	}
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 2e3392c963d03..c08fd359b38b0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -36,8 +36,10 @@ void dcn401_program_gamut_remap(struct program_gamut_remap_params *params);
 
 void dcn401_init_hw(struct dc *dc);
 
-bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state);
+bool dcn401_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
+				struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
+				struct dc_stream_state *stream,
+				struct dc_plane_state *plane_state);
 bool dcn401_set_output_transfer_func(struct set_output_transfer_func_params *params);
 void dcn401_trigger_3dlut_dma_load(struct pipe_ctx *pipe_ctx);
 void dcn401_calculate_dccg_tmds_div_value(struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 13580d9f9303e..23d4786ea2464 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -413,19 +413,18 @@ static bool dc_is_rmcm_3dlut_supported(struct hubp *hubp, struct mpc *mpc)
 }
 
 bool dcn42_program_rmcm_luts(
+	struct dc *dc,
+	struct dpp *dpp,
 	struct hubp *hubp,
-	struct pipe_ctx *pipe_ctx,
 	const struct dc_plane_cm *cm,
 	struct mpc *mpc,
-	int mpcc_id)
+	int mpcc_id,
+	struct dc_stream_state *stream)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	union mcm_lut_params m_lut_params = {0};
 
-	struct dc *dc = hubp->ctx->dc;
 	struct mpc_fl_3dlut_config mpc_fl_config;
 
-	struct dc_stream_state *stream = pipe_ctx->stream;
 	bool bypass_rmcm_shaper = false;
 	// true->false when it can be allocated at DI time
 	struct dc_rmcm_3dlut *rmcm_3dlut = dc_stream_get_3dlut_for_stream(dc, stream, false);
@@ -457,8 +456,8 @@ bool dcn42_program_rmcm_luts(
 			cm_helper_translate_curve_to_hw_format(
 					dc->ctx,
 					&cm->shaper_func,
-					&dpp_base->shaper_params, true);
-			m_lut_params.pwl = &dpp_base->shaper_params;
+					&dpp->shaper_params, true);
+			m_lut_params.pwl = &dpp->shaper_params;
 		}
 		if (m_lut_params.pwl) {
 			if (mpc->funcs->rmcm.populate_lut)
@@ -511,31 +510,29 @@ bool dcn42_program_rmcm_luts(
 	return true;
 }
 
-bool dcn42_set_mcm_luts(struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state)
+bool dcn42_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
+				struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
+				struct dc_stream_state *stream,
+				struct dc_plane_state *plane_state)
 {
 	bool result;
+	const struct dc_plane_cm *cm = &plane_state->cm;
 
 	/* MCM */
-	result = dcn401_set_mcm_luts(pipe_ctx, plane_state);
+	result = dcn401_set_mcm_luts(dc, dpp, hubp, primary_hubp, mpc, mpcc_id,
+			stream, plane_state);
 
 	/* RMCM */
-	{
-		struct dc *dc = pipe_ctx->plane_res.hubp->ctx->dc;
-		struct hubp *hubp = pipe_ctx->plane_res.hubp;
-		const struct dc_plane_cm *cm = &plane_state->cm;
-		struct mpc *mpc = dc->res_pool->mpc;
-		int mpcc_id = hubp->inst;
-
-		if (cm->flags.bits.rmcm_enable && cm->flags.bits.lut3d_dma_enable) {
-			/* TODO - move RMCM to its own block */
-			dcn42_program_rmcm_luts(
-				hubp,
-				pipe_ctx,
-				cm,
-				mpc,
-				mpcc_id);
-		}
+	if (cm->flags.bits.rmcm_enable && cm->flags.bits.lut3d_dma_enable) {
+		/* TODO - move RMCM to its own block */
+		dcn42_program_rmcm_luts(
+			dc,
+			dpp,
+			hubp,
+			cm,
+			mpc,
+			mpcc_id,
+			stream);
 	}
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
index c4cfeed45b190..61d1217a30df5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
@@ -15,15 +15,19 @@ void dcn42_program_cm_hist(
 	struct pipe_ctx *pipe_ctx,
 	const struct dc_plane_state *plane_state);
 
-bool dcn42_set_mcm_luts(struct pipe_ctx *pipe_ctx,
-	const struct dc_plane_state *plane_state);
+bool dcn42_set_mcm_luts(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
+	struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
+	struct dc_stream_state *stream,
+	struct dc_plane_state *plane_state);
 
 bool dcn42_program_rmcm_luts(
+	struct dc *dc,
+	struct dpp *dpp,
 	struct hubp *hubp,
-	struct pipe_ctx *pipe_ctx,
 	const struct dc_plane_cm *cm,
 	struct mpc *mpc,
-	int mpcc_id);
+	int mpcc_id,
+	struct dc_stream_state *stream);
 void dcn42_hardware_release(struct dc *dc);
 
 void dcn42_prepare_bandwidth(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index bf63281a8cd2c..169f3420ac6dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -90,7 +90,13 @@ struct update_plane_addr_params {
 
 struct set_input_transfer_func_params {
 	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct dpp *dpp;
+	struct hubp *hubp;
+	struct hubp *primary_hubp;
+	struct mpc *mpc;
+	int mpcc_id;
+	struct dc_stream_state *stream;
+	struct input_pixel_processor *ipp;
 	struct dc_plane_state *plane_state;
 };
 
@@ -2119,6 +2125,8 @@ void hwss_disable_audio_stream(struct dc *dc, union block_sequence_params *param
 
 void hwss_hubp_wait_for_dcc_meta_prop(struct dc *dc, struct pipe_ctx *top_pipe_to_program);
 
+void hwss_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx);
+
 void hwss_add_optc_pipe_control_lock(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx, bool lock);
 
@@ -2132,7 +2140,7 @@ void hwss_add_hubp_update_plane_addr(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx);
 
 void hwss_add_dpp_set_input_transfer_func(struct block_sequence_state *seq_state,
-		struct dc *dc, struct pipe_ctx *pipe_ctx, struct dc_plane_state *plane_state);
+		struct dc *dc, struct pipe_ctx *pipe_ctx);
 
 void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 0f7881a214620..956513125be0b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -90,9 +90,7 @@ struct hwseq_private_funcs {
 	void (*update_mpcc)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*update_mpcc_sequence)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			struct block_sequence_state *seq_state);
-	bool (*set_input_transfer_func)(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state);
+	bool (*set_input_transfer_func)(struct set_input_transfer_func_params *params);
 	bool (*set_output_transfer_func)(struct set_output_transfer_func_params *params);
 	void (*power_down)(struct dc *dc);
 	void (*enable_display_pipe_clock_gating)(struct dc_context *ctx,
@@ -187,12 +185,14 @@ struct hwseq_private_funcs {
 		struct block_sequence_state *seq_state);
 	bool (*wait_for_blank_complete)(struct output_pixel_processor *opp);
 	void (*dccg_init)(struct dce_hwseq *hws);
-	bool (*set_blend_lut)(struct pipe_ctx *pipe_ctx,
-			const struct dc_plane_state *plane_state);
-	bool (*set_shaper_3dlut)(struct pipe_ctx *pipe_ctx,
-			const struct dc_plane_state *plane_state);
-	bool (*set_mcm_luts)(struct pipe_ctx *pipe_ctx,
-			const struct dc_plane_state *plane_state);
+	bool (*set_blend_lut)(struct dpp *dpp,
+			struct dc_plane_state *plane_state);
+	bool (*set_shaper_3dlut)(struct dpp *dpp,
+			struct dc_plane_state *plane_state);
+	bool (*set_mcm_luts)(struct dc *dc, struct dpp *dpp, struct hubp *hubp,
+			struct hubp *primary_hubp, struct mpc *mpc, int mpcc_id,
+			struct dc_stream_state *stream,
+			struct dc_plane_state *plane_state);
 	void (*PLAT_58856_wa)(struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
-- 
2.43.0


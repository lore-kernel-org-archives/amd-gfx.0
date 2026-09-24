Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08826C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D7610F729;
	Thu, 24 Sep 2026 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQ2vkwmR";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C596910F728
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8cVrL4hAM7PVX6mDSbXg1qEvSBJp2AqmvuRtBQIEVN19skOAKTD6ZA9z1sb7hTO8nvWQSl3ZKUo4uRVL/UVGYrzsEPycViiKDhViaT4CvzbCqnmX0O6b532fOCkvKERmiC29pr6ahF3tH3cPDQYU6rf92pSuzZFn+RfuNoOCd7LAZ5KPmb9KuATKsDnvxvpepVasNwMIIuMuz59+VrCrNx4eN2Hv89+fLtvYEzA0+XbiQXxAnZrGquB+Z7FIQ9uOGvTiBcHS/TW95aFqq8p/DHIn8fhC2mf1JwI9vNflnpCaFXXLXglzcX5oOvxrRUib9TpM92on+SA0SNJEoaXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3uhsX+IgUgZyqgYHNZbvxAdWzy4PIonacBDQZ22jMM=;
 b=BESfJxo6HefVv8rvkqbTWlgYcY6P1agXItd6wP4iMXd0OhpDGYQmPBN32hGIRKY7/sxrwNYF2nKxApuSJqdN7KeoXwvUn8VBTAWocYjBL0kMo1WX79zF/ilV3mW2lcfw+z+SlfLVjd/3aDPPbs6HivoIamK4mzi6Cmu7GlcAJiw/jpKagXlXw6MgoqqzF1BrdURA2T5re+Fn9MSoqkX9Q3EhLvaqGpiKsDVefPTf1knNhZhKuPmfKIboZR3oh/x+p+aF5kwSnfmv8xZLmVOMpwKTu0Ylvu0yFHcpG4SDpv5vkzSc80hFpVwjW3f2QK2Hctcdwxk3VvP/5s66QVOC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3uhsX+IgUgZyqgYHNZbvxAdWzy4PIonacBDQZ22jMM=;
 b=xQ2vkwmR2l2BKvXpAqe6jrM580zYitrrtrzNNtXdirBZXb/sxw7u2InYFFmA/Nv0mtmX/l+fzzKsCwbFw4To0egv97ADhcD1UAkkXO1E51jOmP+eXa0seocQy7Jte5M96t+L32K1t8SndVzeAW87iHwWC9t9GcO/nkamJugHKTY=
Received: from PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::11)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:32 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::38) by PH8P221CA0050.outlook.office365.com
 (2603:10b6:510:346::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:29 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:14 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 18/34] drm/amd/display: Remove OPP_SET_MPCC_DISCONNECT_PENDING
Date: Thu, 24 Sep 2026 14:45:31 -0400
Message-ID: <20260924184824.596894-19-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 19594ca6-e240-45f3-17b7-08df1a6c259e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Wk8bMI0Nrx08a0vNZWuGz1a4vtbLDbcBum+fgaaOEKhgSyC/OTkteneahjalkANk/tAM5YsE822ap8Azf4O4/Urb7+9wCpMNrYDSS8VhaaxV5fzSRmxy6BUBHpIu/MtU/k7THn4wstSXjdShaGs7JrBeiXXJzSWv9zaf+gPiw5UvcszuFis3NaRS79f3s4om0ROhDDf/EzSvUVL6JznfZKup38vTXYGjX535Gp92KF2G32mx+LhQSB2BMXBKf9EjdS04yJGBVOJyNLEu5b5KzixEA5xe7ZyYLeIyBaH/WrZISZqsd1NiSOWv+rWMPO/IdsYvrp2IHEC+H5KqnOd1ZbbpuVd1k92jsQlzhbW+8vuWUhSDSow+AAbq1M1/8vUH3pZNHqGhPcmiGEUkxH8jxO5h5X5V+9gJCWFHcWvMO0wiAl5FTxD1IL41KUamwkD2+mC2LCOCu0BucKcO8riRUhomK70DHo6S7YevRe199P3ChUJWA4s/+579wh8xUXy24vPs6+QQYV5J2Me6+tpN51Qj975HZL8b/aSVOLKAeGX3PjP/gH9jnLtawNDqAHvJGH8KbrBAYr9ssL43XEOiO6VjQsGYB5V5CWXKvfQOTMf2R3bASAPq+x8t4PdfiZ51Pb948uEpoy+VoGmDEThWFYK9w1nIVlei3w72pCCpNMQockpZWT38knWZQjA1EmbiNWwDF/OYpy7V2VY2ra6vlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wDNNn4579Wa8GBss2L7xhMXoXzHlQ8HOuW1kGDhTpb9svPlIzxyTkV1S2fd3Lw1aatn/kUQz1iHeaLmPeI3UqYCmgzGBAYYpKU/L7uybx29nx64vQo19VTtGbghsdWo4ArdPZ2fjRrro1rO1H4DqH1yqungHHt93Om/Dn7ExCuRjfylUVLvZobMnTgj43GpCtovdmJgT5QvJbRDOZFEdq5wzI+47p62LR0TmGaeXsYWiVYxtn04Z/o8Z95wmK9aIwpFRaFQOslOO6/9NvWFUeUDKG3mV9x9Q5FCUrP4PHxInqtwFngGDDsJ2pXgK0W/OAuiputy51Ew8R0jGXe64ksFhx3tqM4QUlcwGTsx08TsP2pq2pFig0JhZbWKlP0kqwm7TG7CplMONCuwJDC6zR3B2bA6WaKVZ5fHWdFLzzPKzvg/YBoj4T4qDH28M76vF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:29.8550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19594ca6-e240-45f3-17b7-08df1a6c259e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
The operation wrote no hardware register. Its executor only set
opp->mpcc_disconnect_pending, a driver side flag, which breaks the rule
that a block sequence step programs a hardware block rather than mutating
logical objects. It was also split across phases: written while the
pre-unlock sequence executed, then read and cleared while the post-unlock
sequence was still being built.

[HOW]
Deleted the enum value, the params struct, the add helper, the executor and
the dispatch case. dcn401_plane_atomic_disconnect_sequence now sets the
flag during the build phase, matching what dcn10, dcn20, dcn201, dcn35,
dcn3ag and dcn42b already do. Updated the operation specs and the
core_gtest dumper.

Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 24 -------------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  6 +++--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 13 ----------
 3 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e1d6e31af657..5e41792c622a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1888,9 +1888,6 @@ void hwss_execute_sequence(struct dc *dc,
 		case MPC_REMOVE_MPCC:
 			hwss_mpc_remove_mpcc(params);
 			break;
-		case OPP_SET_MPCC_DISCONNECT_PENDING:
-			hwss_opp_set_mpcc_disconnect_pending(params);
-			break;
 		case DC_SET_OPTIMIZED_REQUIRED:
 			hwss_dc_set_optimized_required(params);
 			break;
@@ -3581,15 +3578,6 @@ void hwss_mpc_remove_mpcc(union block_sequence_params *params)
 	mpc->funcs->remove_mpcc(mpc, mpc_tree_params, mpcc_to_remove);
 }
 
-void hwss_opp_set_mpcc_disconnect_pending(union block_sequence_params *params)
-{
-	struct output_pixel_processor *opp = params->opp_set_mpcc_disconnect_pending_params.opp;
-	int mpcc_inst = params->opp_set_mpcc_disconnect_pending_params.mpcc_inst;
-	bool pending = params->opp_set_mpcc_disconnect_pending_params.pending;
-
-	opp->mpcc_disconnect_pending[mpcc_inst] = pending;
-}
-
 void hwss_dc_set_optimized_required(union block_sequence_params *params)
 {
 	struct dc *dc = params->dc_set_optimized_required_params.dc;
@@ -4773,18 +4761,6 @@ void hwss_add_mpc_remove_mpcc(struct block_sequence_state *seq_state,
 	}
 }
 
-void hwss_add_opp_set_mpcc_disconnect_pending(struct block_sequence_state *seq_state,
-		struct output_pixel_processor *opp, int mpcc_inst, bool pending)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = OPP_SET_MPCC_DISCONNECT_PENDING;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_mpcc_disconnect_pending_params.opp = opp;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_mpcc_disconnect_pending_params.mpcc_inst = mpcc_inst;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_mpcc_disconnect_pending_params.pending = pending;
-		(*seq_state->num_steps)++;
-	}
-}
-
 void hwss_add_hubp_disconnect(struct block_sequence_state *seq_state,
 		struct hubp *hubp)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c82f941f42ec..b7680326f495 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3301,8 +3301,10 @@ void dcn401_plane_atomic_disconnect_sequence(struct dc *dc,
 	// Phantom pipes have OTG disabled by default, so MPCC_STATUS will never assert idle,
 	// so don't wait for MPCC_IDLE in the programming sequence
 	if (dc_state_get_pipe_subvp_type(state, pipe_ctx) != SUBVP_PHANTOM) {
-		/* Step 2: Set MPCC disconnect pending flag */
-		hwss_add_opp_set_mpcc_disconnect_pending(seq_state, opp, pipe_ctx->plane_res.mpcc_inst, true);
+		/* Step 2: Set MPCC disconnect pending flag. Set here rather than as a sequence step
+		 * because the post-unlock build phase reads it to decide what to emit.
+		 */
+		opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
 	}
 
 	/* Step 3: Set optimized required flag */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d7ab21c5a1e4..9ad18c9dcff9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -486,12 +486,6 @@ struct mpc_remove_mpcc_params {
 	struct mpcc *mpcc_to_remove;
 };
 
-struct opp_set_mpcc_disconnect_pending_params {
-	struct output_pixel_processor *opp;
-	int mpcc_inst;
-	bool pending;
-};
-
 struct dc_set_optimized_required_params {
 	struct dc *dc;
 	bool optimized_required;
@@ -1128,7 +1122,6 @@ union block_sequence_params {
 	struct set_abm_immediate_disable_params set_abm_immediate_disable_params;
 	struct set_disp_pattern_generator_params set_disp_pattern_generator_params;
 	struct mpc_remove_mpcc_params mpc_remove_mpcc_params;
-	struct opp_set_mpcc_disconnect_pending_params opp_set_mpcc_disconnect_pending_params;
 	struct dc_set_optimized_required_params dc_set_optimized_required_params;
 	struct hubp_disconnect_params hubp_disconnect_params;
 	struct hubbub_force_pstate_change_control_params hubbub_force_pstate_change_control_params;
@@ -1299,7 +1292,6 @@ enum block_sequence_func {
 	ABM_SET_LEVEL,
 	ABM_SET_IMMEDIATE_DISABLE,
 	MPC_REMOVE_MPCC,
-	OPP_SET_MPCC_DISCONNECT_PENDING,
 	DC_SET_OPTIMIZED_REQUIRED,
 	HUBP_DISCONNECT,
 	HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
@@ -2007,8 +1999,6 @@ void hwss_set_abm_immediate_disable(union block_sequence_params *params);
 
 void hwss_mpc_remove_mpcc(union block_sequence_params *params);
 
-void hwss_opp_set_mpcc_disconnect_pending(union block_sequence_params *params);
-
 void hwss_dc_set_optimized_required(union block_sequence_params *params);
 
 void hwss_hubp_disconnect(union block_sequence_params *params);
@@ -2323,9 +2313,6 @@ void hwss_add_dsc_calculate_and_set_config(struct block_sequence_state *seq_stat
 void hwss_add_mpc_remove_mpcc(struct block_sequence_state *seq_state,
 		struct mpc *mpc, struct mpc_tree *mpc_tree_params, struct mpcc *mpcc_to_remove);
 
-void hwss_add_opp_set_mpcc_disconnect_pending(struct block_sequence_state *seq_state,
-		struct output_pixel_processor *opp, int mpcc_inst, bool pending);
-
 void hwss_add_hubp_disconnect(struct block_sequence_state *seq_state,
 		struct hubp *hubp);
 
-- 
2.53.0


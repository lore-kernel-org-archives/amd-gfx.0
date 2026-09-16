Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5559DC982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A329D10ECE9;
	Wed, 16 Sep 2026 17:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbxQa94S";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EA210ECE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlmmYCelljdGQeQL/Z9hIW8yvPRMNpeK02/J5EWwIjb8uGFL6VMqcb+lsfM5wRsgxxR2aSQIVvo3xo2D+wD9BWdh1AvZF75yKzAFHCT9n4JaNon0TtLh4ry9gJpERqBPvROZOQRNOsDKgkVf3Rzjuutw+Vsh4V8WoaS4px50hrnpuT5ii24eGIAUhEBsTqwBITZt43yoQOs8U0cMkkxCsRCu2srpBLY7LKlPMRFnDeeXqOsqdX7qlLc3qbzXvelqbJHP5SF2DDaOuyzpqm/n+egQnFh9rM/1Z9SziZPkvs1OnpORow2srTew94TRuV3/LUufmQ7QZyGWA/E27Pbfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jlbg6RVdl35ZQPwyBu58Vu4zyBy9TqW2PuK2uqV+Hc=;
 b=KBaKqwPh/WOwtnZieNtIgfgKysB8lhJO1Q0jFt5NtSrBNQ7hXNgo3NxBI1HMK2p8QCC1bvtYrJLHbtb4yyx7sprX7TpjyegvIz3P0AeNK8qJzX2+BhYUhHkThUZt6TafXDA5w5F/O5T1Gnl1qhf4bvlc2yPZY6TtLYEmEEJK/yjiajG+gR4p7LKVaGBwU6u0HhDWA+rn7VBaoIuv7yJrFd4fCEvj0KYGiplQ/rTpsxPomyamhvO2JJaIXMMMoHiDhJvXF7kGALc8sNzK5ngfemOupxAFnUTWwFMj41w5BysRbonwy1aWK/fCMuKsbtnpK+w+/RrtMl8DtTjjgHjsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jlbg6RVdl35ZQPwyBu58Vu4zyBy9TqW2PuK2uqV+Hc=;
 b=gbxQa94STXqH741XKDeeJDQIxOl7T+LJwFbLBoiTXBnfX2Fl3gNUU+uuetawVGtijS7dX/EQZ4e/LSQMLqm+JiCLQnNwcXI0sBYoSv8Zjm6+RHxfQrFplHt+RSGM4325Y/GO214rlqIF9E2+m7yWNVcYW5qdufG85LHDmB8jVtY=
Received: from CH2PR10CA0026.namprd10.prod.outlook.com (2603:10b6:610:4c::36)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:53:08 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::24) by CH2PR10CA0026.outlook.office365.com
 (2603:10b6:610:4c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:07 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:56 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 55/64] drm/amd/display: refactor hwss SET_CURSOR_POSITION
 block sequence
Date: Wed, 16 Sep 2026 13:52:10 -0400
Message-ID: <20260916175301.368306-56-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8f194e-5db3-41f2-120f-08df141b5d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|11063799006|5023799004|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: q8Xmw4x2FvcylRV1SFw9ypzOrg8nfMCZMXPCLirtetZf3XfSgE0/SkgNI+HfMYi28w1CAI0DpJtAp0oraYlQnbe7o569xAR5CJRnT7nkejxjL/I4PqysWyf8u3JCrhSBqGExj9E0472Lc5seY0iNbVQPfoLOMybb9HJwdIt0IGp40ReaKJ8HFfFs1raCeluk7pAUukLZplsx9+sJvxh3NCDi7fMddXYZjW4Ekxrf9/IU9PWOYN1T1H/V5hQ6aFAO3UvLgu45yN900pkSNgLtCWuvxD2ODRSISgNt9LsGQ/lA7Y0HQcF8JCDa08VXWo63V1Kec9voVHUVIXjqSlfdqCPZJ+dvVtSHkjxp1n7BlsvFQuVPyt4zsGqXi7auUIWTaRMyVAZ0NlMfYLUC8XUtBWs0BF8Agn3sKc2qmgH9Ra2Y/7yF8XxCS7M8UoOOgJa4WF4CyMvleVxqH+4Fq9kn4s/qh19w2F7nXcsbautsOmrW3xl60m6eAVy6rJNEYHoPbfdBcuHi5HQMUbZf7VKQwkhFcL/8BNscw43LwqebyZb4drm+rJRP7EXJ8RrfX3G4UrpTlJbFjXlWMLVT2CbDgcbrE1pOahI/IQuSEe04TXUGVzFek129Ba+kcfG4MTRq/QPYbiGPpToG26/mCpYRXE1USqeoR8aSUMuUUn3FwFRIGGJQ43rcykOfCSL2vmRQopZFovEQRwMyXpcqhT2Acw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(5023799004)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AuFpDa527ONgjZiKtLlqXxZFfbuGv/rn9o/K2/AVC2Ik8Ki2PbV+siUoPdADcsGz4Cn4anSbifrKMs9A2pEuYxFRtyC+c6cPiWjnq21Rrlj5jyF7Ubz/QDbaZWbuaMEVCX4XTSPXX9Cx6LXFhKtFJc3Wedx0jMvwl34PI4o1pGNWV7Z6ROUHIvScFv5OkkCim7Tcq6O71VvfaRaBcJ9hVZ8r6s1iLKEYkQcm9Bs5AqikMZCdT++KRk3i++iZaLvvRHkzUI6GUtAeSDbn5Co0YWgMRhX1Npefy6GcbJSlOc6YOtqhCEl1TfciXoQw5xV3bTJhnEkUfFUVoK6vbZ9IGAnapXNyLMlqZOwbBh7+qbdE/R1MaT3yRFKI/he5JjGuhpOd29Zr9GmRr3QZXR0qKF90VjdHvBtINqrfc2A/PJKj8DCsKT14f6VbYziXA5wo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:07.5679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8f194e-5db3-41f2-120f-08df141b5d8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

Flatten the executor params for the initial set of HWSS block sequence ops
for SET_CURSOR_POSITION to separate SW and HW logic

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 52 +++++++++++++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 51 ++------------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 ++++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |  1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |  1 +
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |  1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |  1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 66 +++++++++++++++++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |  1 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 13 +++-
 .../display/dc/hwss/hw_sequencer_private.h    |  3 +
 27 files changed, 172 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index f33562dff6ac..3bc0362d9dc0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1304,7 +1304,8 @@ void hwss_build_fast_sequence(struct dc *dc,
 	bool enable_cursor_offload = false;
 
 	if ((dc->hwss.set_cursor_attribute && stream->update_flags.bits.cursor_attr) ||
-		(dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos))
+		(dc->hwseq && dc->hwseq->funcs.build_cursor_position &&
+			dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos))
 		enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 
 	/* Cursor attribute updates - separate lock/iterate/unlock */
@@ -1390,7 +1391,8 @@ void hwss_build_fast_sequence(struct dc *dc,
 	}
 
 	/* Cursor position updates */
-	if (dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos) {
+	if (dc->hwseq && dc->hwseq->funcs.build_cursor_position &&
+			dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos) {
 		struct pipe_ctx *cursor_pipe_to_program = NULL;
 
 		for (i = 0; i < MAX_PIPES; i++) {
@@ -1417,8 +1419,16 @@ void hwss_build_fast_sequence(struct dc *dc,
 				}
 			}
 
+			struct dc_cursor_position pos;
+			struct dc_cursor_mi_param param;
+
+			dc->hwseq->funcs.build_cursor_position(current_pipe, &pos, &param);
+
 			block_sequence[*num_steps].params.set_cursor_position_params.dc = dc;
-			block_sequence[*num_steps].params.set_cursor_position_params.pipe_ctx = current_pipe;
+			block_sequence[*num_steps].params.set_cursor_position_params.hubp = current_pipe->plane_res.hubp;
+			block_sequence[*num_steps].params.set_cursor_position_params.dpp = current_pipe->plane_res.dpp;
+			block_sequence[*num_steps].params.set_cursor_position_params.pos = pos;
+			block_sequence[*num_steps].params.set_cursor_position_params.param = param;
 			block_sequence[*num_steps].func = SET_CURSOR_POSITION;
 			(*num_steps)++;
 
@@ -4357,10 +4367,28 @@ void hwss_dpp_set_cursor_attributes(union block_sequence_params *params)
 void hwss_set_cursor_position(union block_sequence_params *params)
 {
 	struct dc *dc = params->set_cursor_position_params.dc;
-	struct pipe_ctx *pipe_ctx = params->set_cursor_position_params.pipe_ctx;
+	struct hubp *hubp = params->set_cursor_position_params.hubp;
+	struct dpp *dpp = params->set_cursor_position_params.dpp;
+	const struct dc_cursor_position *pos = &params->set_cursor_position_params.pos;
+	const struct dc_cursor_mi_param *param = &params->set_cursor_position_params.param;
 
+	/* DCN path: SW logic ran in the builder; just invoke the BLCs */
 	if (dc && dc->hwss.set_cursor_position)
-		dc->hwss.set_cursor_position(pipe_ctx);
+		dc->hwss.set_cursor_position(hubp, dpp, pos, param);
+}
+
+void hwss_program_cursor_position(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	if (dc->hwseq && dc->hwseq->funcs.build_cursor_position && dc->hwss.set_cursor_position) {
+		struct dc_cursor_position pos;
+		struct dc_cursor_mi_param param;
+
+		dc->hwseq->funcs.build_cursor_position(pipe_ctx, &pos, &param);
+		dc->hwss.set_cursor_position(pipe_ctx->plane_res.hubp,
+				pipe_ctx->plane_res.dpp, &pos, &param);
+	} else if (dc->hwss.set_cursor_position_legacy) {
+		dc->hwss.set_cursor_position_legacy(pipe_ctx);
+	}
 }
 
 void hwss_set_cursor_sdr_white_level(union block_sequence_params *params)
@@ -5783,10 +5811,20 @@ void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE &&
+			dc->hwseq && dc->hwseq->funcs.build_cursor_position &&
+			dc->hwss.set_cursor_position) {
+		struct dc_cursor_position pos;
+		struct dc_cursor_mi_param param;
+
+		dc->hwseq->funcs.build_cursor_position(pipe_ctx, &pos, &param);
+
 		seq_state->steps[*seq_state->num_steps].func = SET_CURSOR_POSITION;
 		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.hubp = pipe_ctx->plane_res.hubp;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.dpp = pipe_ctx->plane_res.dpp;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.pos = pos;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.param = param;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 88ac4a4cfd6e..b446c311e662 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -530,7 +530,7 @@ void program_cursor_position(
 			}
 		}
 
-		dc->hwss.set_cursor_position(pipe_ctx);
+		hwss_program_cursor_position(dc, pipe_ctx);
 		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
 			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 084c506a8a94..40cd4e5d1340 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -562,6 +562,9 @@ struct dc_cursor_mi_param {
 	enum dc_rotation_angle rotation;
 	bool mirror;
 	struct dc_stream_state *stream;
+	int dst_x_offset;
+	int cur_rect_x;
+	int cur_rect_y;
 };
 
 /* IPP related types */
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 5ca40941c355..a985c3e00dca 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -816,24 +816,9 @@ void hubp401_cursor_set_position(
 	const struct dc_cursor_mi_param *param)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-	int rec_x_offset = pos->x - pos->x_hotspot;
-	int rec_y_offset = pos->y - pos->y_hotspot;
-	int dst_x_offset;
-	int x_pos_viewport = 0;
-	int x_hot_viewport = 0;
+	int dst_x_offset = param->dst_x_offset;
 	uint32_t cur_en = pos->enable ? 1 : 0;
-	uint32_t x_hotspot_clamped = pos->x_hotspot;
 	hubp->curs_pos = *pos;
-	/* Recout is zero for pipes if the entire dst_rect is contained
-	 * within preceeding ODM slices.
-	 */
-	if (param->recout.width) {
-		x_pos_viewport = pos->x * param->viewport.width / param->recout.width;
-		x_hot_viewport = pos->x_hotspot * param->viewport.width / param->recout.width;
-	} else {
-		ASSERT(!cur_en || pos->x == 0);
-		ASSERT(!cur_en || pos->x_hotspot == 0);
-	}
 
 	/*
 	 * Guard aganst cursor_set_position() from being called with invalid
@@ -842,25 +827,6 @@ void hubp401_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
-	/* Translate the x position of the cursor from rect
-	 * space into viewport space. CURSOR_DST_X_OFFSET
-	 * is the offset relative to viewport start position.
-	 */
-	dst_x_offset = x_pos_viewport - x_hot_viewport *
-			(1 + hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION);
-	dst_x_offset = (dst_x_offset >= 0) ? dst_x_offset : 0;
-	dst_x_offset *= param->ref_clk_khz;
-	dst_x_offset /= param->pixel_clk_khz;
-
-	ASSERT(param->h_scale_ratio.value);
-
-	if (x_hotspot_clamped > 0xFF)
-		x_hotspot_clamped = 0xFF;
-	if (param->h_scale_ratio.value)
-		dst_x_offset = dc_fixpt_floor(dc_fixpt_div(
-			dc_fixpt_from_int(dst_x_offset),
-			param->h_scale_ratio));
-
 	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
 		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
 			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
@@ -876,7 +842,7 @@ void hubp401_cursor_set_position(
 			CURSOR_Y_POSITION, pos->y);
 
 		REG_SET_2(CURSOR_HOT_SPOT, 0,
-			CURSOR_HOT_SPOT_X, x_hotspot_clamped,
+			CURSOR_HOT_SPOT_X, pos->x_hotspot,
 			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
 
 		REG_SET(CURSOR_DST_OFFSET, 0,
@@ -889,18 +855,9 @@ void hubp401_cursor_set_position(
 	hubp->pos.hot_spot.bits.x_hot = pos->x_hotspot;
 	hubp->pos.hot_spot.bits.y_hot = pos->y_hotspot;
 	hubp->pos.dst_offset.bits.dst_x_offset = dst_x_offset;
-	/* Cursor Rectangle Cache
-	 * Cursor bitmaps have different hotspot values
-	 * There's a possibility that the above logic returns a negative value,
-	 * so we clamp them to 0
-	 */
-	if (rec_x_offset < 0)
-		rec_x_offset = 0;
-	if (rec_y_offset < 0)
-		rec_y_offset = 0;
 	/* Save necessary cursor info x, y position. w, h is saved in attribute func. */
-	hubp->cur_rect.x = rec_x_offset + param->recout.x;
-	hubp->cur_rect.y = rec_y_offset + param->recout.y;
+	hubp->cur_rect.x = param->cur_rect_x;
+	hubp->cur_rect.y = param->cur_rect_y;
 }
 
 void hubp401_read_state(struct hubp *hubp)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index bb46d7249025..d48894017c0e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3655,7 +3655,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
-	.set_cursor_position = dce110_set_cursor_position,
+	.set_cursor_position_legacy = dce110_set_cursor_position,
 	.set_cursor_attribute = dce110_set_cursor_attribute,
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 84e146f2509c..613f1f62cd80 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3176,7 +3176,7 @@ static void dcn10_update_dchubp_dpp(
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
-		dc->hwss.set_cursor_position(pipe_ctx);
+		hwss_program_cursor_position(dc, pipe_ctx);
 
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
@@ -3729,11 +3729,11 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 	hubbub->funcs->update_dchub(hubbub, dh_data);
 }
 
-void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
+void dcn10_build_cursor_position(struct pipe_ctx *pipe_ctx,
+		struct dc_cursor_position *pos_out,
+		struct dc_cursor_mi_param *param_out)
 {
 	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
-	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 	struct dc_cursor_mi_param param = {
 		.pixel_clk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10,
 		.ref_clk_khz = pipe_ctx->stream->ctx->dc->res_pool->ref_clocks.dchub_ref_clock_inKhz,
@@ -3949,8 +3949,16 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->plane_res.scl_data.viewport.height - pos_cpy.y;
 	}
 
-	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
-	dpp->funcs->set_cursor_position(dpp, &pos_cpy, &param, hubp->curs_attr.width, hubp->curs_attr.height);
+	*pos_out = pos_cpy;
+	*param_out = param;
+}
+
+void dcn10_set_cursor_position(struct hubp *hubp, struct dpp *dpp,
+		const struct dc_cursor_position *pos,
+		const struct dc_cursor_mi_param *param)
+{
+	hubp->funcs->set_cursor_position(hubp, pos, param);
+	dpp->funcs->set_cursor_position(dpp, pos, param, hubp->curs_attr.width, hubp->curs_attr.height);
 }
 
 void dcn10_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 5cb109040d3d..9c4f1186ca9f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -177,7 +177,12 @@ void dce110_edp_power_control(
 void dce110_edp_wait_for_hpd_ready(
 		struct dc_link *link,
 		bool power_up);
-void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx);
+void dcn10_build_cursor_position(struct pipe_ctx *pipe_ctx,
+		struct dc_cursor_position *pos,
+		struct dc_cursor_mi_param *param);
+void dcn10_set_cursor_position(struct hubp *hubp, struct dpp *dpp,
+		const struct dc_cursor_position *pos,
+		const struct dc_cursor_mi_param *param);
 void dcn10_set_cursor_attribute(struct pipe_ctx *pipe_ctx);
 void dcn10_set_cursor_sdr_white_level(struct pipe_ctx *pipe_ctx);
 void dcn10_setup_periodic_interrupt(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index 07e92742c11a..ddd52722bc49 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -94,6 +94,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index e7ca38bcaabf..45a4a7707507 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1846,7 +1846,7 @@ void dcn20_update_dchubp_dpp(
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
-		dc->hwss.set_cursor_position(pipe_ctx);
+		hwss_program_cursor_position(dc, pipe_ctx);
 
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index c4de9cf11c23..5817fb44d2e0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -107,6 +107,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index be1fb2366c8a..d421bc813cbd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -99,6 +99,7 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn201_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = NULL,
 	.plane_atomic_disconnect = dcn201_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index 20c6e7d7c897..e691e86629c5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -110,6 +110,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index f62f1c6efff8..f7a095796039 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -117,6 +117,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index a62434138eca..191245bde1ca 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -113,6 +113,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 30ad41d08d6e..5500eb46dedb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -119,6 +119,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index a53e7fb6f23f..b278f58b844d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -122,6 +122,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 7e68029f1e12..49387de29382 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -130,6 +130,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 69fa91aeb836..e4864b9606ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -140,6 +140,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn35_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 3ceaa4590148..f57c0f6adccf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -129,6 +129,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
+	.build_cursor_position = dcn10_build_cursor_position,
 	.init_pipes = dcn35_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 3dd3dacfe5ee..8fd60ed7669b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1045,11 +1045,12 @@ void dcn401_disable_link_output(struct dc_link *link,
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
-void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
+void dcn401_build_cursor_position(struct pipe_ctx *pipe_ctx,
+		struct dc_cursor_position *pos_out,
+		struct dc_cursor_mi_param *param_out)
 {
 	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 	struct dc_cursor_mi_param param = {
 		.pixel_clk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10,
 		.ref_clk_khz = pipe_ctx->stream->ctx->dc->res_pool->ref_clocks.dchub_ref_clock_inKhz,
@@ -1073,6 +1074,11 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	int y_pos = pos_cpy.y;
 	int recout_x_pos = 0;
 	int recout_y_pos = 0;
+	int x_pos_viewport = 0;
+	int x_hot_viewport = 0;
+	int dst_x_offset = 0;
+	int rec_x_offset = 0;
+	int rec_y_offset = 0;
 
 	if ((pipe_ctx->top_pipe != NULL) || (pipe_ctx->bottom_pipe != NULL)) {
 		if ((pipe_ctx->plane_state->src_rect.width != pipe_ctx->plane_res.scl_data.viewport.width) ||
@@ -1215,8 +1221,60 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	pos_cpy.x = x_pos;
 	pos_cpy.y = y_pos;
 
-	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
-	dpp->funcs->set_cursor_position(dpp, &pos_cpy, &param, hubp->curs_attr.width, hubp->curs_attr.height);
+	/* Precompute the HW destination offset so the executor only programs
+	 * registers. Translate cursor x position from rect space into viewport
+	 * space; CURSOR_DST_X_OFFSET is relative to the viewport start position.
+	 */
+	if (param.recout.width) {
+		x_pos_viewport = pos_cpy.x * param.viewport.width / param.recout.width;
+		x_hot_viewport = pos_cpy.x_hotspot * param.viewport.width / param.recout.width;
+	} else {
+		ASSERT(!pos_cpy.enable || pos_cpy.x == 0);
+		ASSERT(!pos_cpy.enable || pos_cpy.x_hotspot == 0);
+	}
+
+	dst_x_offset = x_pos_viewport - x_hot_viewport *
+			(1 + hubp->curs_attr.attribute_flags.bits.ENABLE_MAGNIFICATION);
+	dst_x_offset = (dst_x_offset >= 0) ? dst_x_offset : 0;
+	dst_x_offset *= param.ref_clk_khz;
+	dst_x_offset /= param.pixel_clk_khz;
+
+	ASSERT(param.h_scale_ratio.value);
+
+	if (param.h_scale_ratio.value)
+		dst_x_offset = dc_fixpt_floor(dc_fixpt_div(
+			dc_fixpt_from_int(dst_x_offset),
+			param.h_scale_ratio));
+
+	param.dst_x_offset = dst_x_offset;
+
+	/* Cursor rectangle cache origin: derived from the final cursor position
+	 * minus hotspot, clamped to 0, offset by the recout origin. Precompute
+	 * here so the executor only stores the value.
+	 */
+	rec_x_offset = pos_cpy.x - pos_cpy.x_hotspot;
+	rec_y_offset = pos_cpy.y - pos_cpy.y_hotspot;
+	if (rec_x_offset < 0)
+		rec_x_offset = 0;
+	if (rec_y_offset < 0)
+		rec_y_offset = 0;
+	param.cur_rect_x = rec_x_offset + param.recout.x;
+	param.cur_rect_y = rec_y_offset + param.recout.y;
+
+	/* Clamp hotspot to the CURSOR_HOT_SPOT_X register field width */
+	if (pos_cpy.x_hotspot > 0xFF)
+		pos_cpy.x_hotspot = 0xFF;
+
+	*pos_out = pos_cpy;
+	*param_out = param;
+}
+
+void dcn401_set_cursor_position(struct hubp *hubp, struct dpp *dpp,
+		const struct dc_cursor_position *pos,
+		const struct dc_cursor_mi_param *param)
+{
+	hubp->funcs->set_cursor_position(hubp, pos, param);
+	dpp->funcs->set_cursor_position(dpp, pos, param, hubp->curs_attr.width, hubp->curs_attr.height);
 }
 
 static bool dcn401_check_no_memory_request_for_cab(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 43bea09fb205..f958ea34a3c6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -55,7 +55,12 @@ void dcn401_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
 
-void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx);
+void dcn401_build_cursor_position(struct pipe_ctx *pipe_ctx,
+		struct dc_cursor_position *pos,
+		struct dc_cursor_mi_param *param);
+void dcn401_set_cursor_position(struct hubp *hubp, struct dpp *dpp,
+		const struct dc_cursor_position *pos,
+		const struct dc_cursor_mi_param *param);
 
 bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 5ac79c32ee48..ac5ebe546d0c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -125,6 +125,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
+	.build_cursor_position = dcn401_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.plane_atomic_disconnect_sequence = dcn401_plane_atomic_disconnect_sequence,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index faeb365dbcab..eba34f124e39 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -129,6 +129,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn42_private_funcs = {
+	.build_cursor_position = dcn401_build_cursor_position,
 	.init_pipes = dcn35_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn42_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index f1c044fe0ba2..0361c520b7d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -212,7 +212,7 @@ void dcn50_update_dchubp_dpp(
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
-		dc->hwss.set_cursor_position(pipe_ctx);
+		hwss_program_cursor_position(dc, pipe_ctx);
 
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index 4aaecd6f8bb7..ce0905820f7e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -128,6 +128,7 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn60_private_funcs = {
+	.build_cursor_position = dcn401_build_cursor_position,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.plane_atomic_disconnect_sequence = dcn401_plane_atomic_disconnect_sequence,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index c902a28b3220..7c5f88bf44c7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -874,7 +874,10 @@ struct dpp_set_cursor_attributes_params {
 
 struct set_cursor_position_params {
 	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct hubp *hubp;
+	struct dpp *dpp;
+	struct dc_cursor_position pos;
+	struct dc_cursor_mi_param param;
 };
 
 struct set_cursor_sdr_white_level_params {
@@ -1539,7 +1542,11 @@ struct hw_sequencer_funcs {
 	bool (*dmdata_status_done)(struct pipe_ctx *pipe_ctx);
 
 	/* Cursor Related */
-	void (*set_cursor_position)(struct pipe_ctx *pipe);
+	void (*set_cursor_position)(struct hubp *hubp, struct dpp *dpp,
+			const struct dc_cursor_position *pos,
+			const struct dc_cursor_mi_param *param);
+	/* Fallback for DCE */
+	void (*set_cursor_position_legacy)(struct pipe_ctx *pipe);
 	void (*set_cursor_attribute)(struct pipe_ctx *pipe);
 	void (*set_cursor_sdr_white_level)(struct pipe_ctx *pipe);
 	void (*abort_cursor_offload_update)(struct dmub_srv *dmub, struct dpp *dpp,
@@ -2152,6 +2159,8 @@ void hwss_dpp_set_cursor_attributes(union block_sequence_params *params);
 
 void hwss_set_cursor_position(union block_sequence_params *params);
 
+void hwss_program_cursor_position(struct dc *dc, struct pipe_ctx *pipe_ctx);
+
 void hwss_set_cursor_sdr_white_level(union block_sequence_params *params);
 
 void hwss_program_gamut_remap(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index b6932b9bc206..136c2c2eab1c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -229,6 +229,9 @@ struct hwseq_private_funcs {
 	void (*program_cm_hist)(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		const struct dc_plane_state *plane_state);
+	void (*build_cursor_position)(struct pipe_ctx *pipe_ctx,
+		struct dc_cursor_position *pos,
+		struct dc_cursor_mi_param *param);
 };
 
 struct dce_hwseq {
-- 
2.55.0


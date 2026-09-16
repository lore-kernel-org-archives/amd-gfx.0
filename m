Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43CEC982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB0F10ECA1;
	Wed, 16 Sep 2026 17:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tookN4xx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DADEB10ECA6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHSs8iup4X9npqQYONHHEs2aSWvk4q4SSQ3nYKYA5O770FntHMeWUv+Mq+gTzaIlfMF3YoHpqhVU4tMndLjrEkf7qrbmZjPqCFlRXc25liMV+7ifiWMLOfGvgehBMwg37N19KB0hlrKh3R1SJ623yDfvJkWBzqsG5q0dggHWDTZArY7JsnRZML0kLMQOtoF+vsQHTKCHS3xElmIhZQhm0hR9JaIvMWwsCtu93KV2tZzB+Rc45uctNZAtPkia0Ryv67kCnrM8q3E70mtZME/dRpTx2/DvMg63H5TkoIpTaN5V4P3RzwZngYKath0sUsO9komxnOn7t3Ehr0z92MD0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNdoKw/F96jNB1b7uzIYKJgUR2wnbW4n5wkvpoygqcI=;
 b=m05Vnj3+lJiCRD8/lJaym76AA43tVDPYwDu/gUr7Ldkeb3gxLlsbKnsVASrOJgylI7hltDy3WMHRjKIUAwEp5ANjre+LzhaFNBqSqzZuIhm/52NWYWeaOf4Z8aJbarQ1jMyqW/lcYBXiKAMzwNbQaBTucXiZVuEyWiNttdnzX5oUuoSzGDDWqskI09ifnI+Tr+S4mx6bjymKttIWe6wOvIkZbdlTzMvA8XlaqPc7G1SeMNa9INDrGQElqOV3fOpeAvmstHD5TEFFrUvdGcgeQjvpmcg/WVabLouTJ8B5nt43zv3H6bf8nvkOuoQzzntGlba1fTre5g+5n/+hcSJyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNdoKw/F96jNB1b7uzIYKJgUR2wnbW4n5wkvpoygqcI=;
 b=tookN4xx2RrsI6o+2KtbylrGMlq4CO/hOB2+WkjgWuQEWh4DLweDnDx1w0EGDwvyiJipu2+M5L733CTDby+Akqmbv/O9kk1cr0w9jvXEduQz4AlYub3z28a7tEN2K4yV94qRmfEHXc2jBcfG+jE10f0FchhZT8qizSKaq/Cnlwg=
Received: from CH0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:610:e5::26)
 by CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:52:41 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::6) by CH0PR03CA0261.outlook.office365.com
 (2603:10b6:610:e5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:40 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:30 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 22/64] drm/amd/display: Refactor DPP_PROGRAM_UPSP to drop
 pipe_ctx
Date: Wed, 16 Sep 2026 13:51:37 -0400
Message-ID: <20260916175301.368306-23-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY5PR12MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: c6888427-6388-43f6-af27-08df141b4d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|56012099006|3023799007|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: Zfvau1ApBrAG2Vplw2r02sNy4YWZFslDYnV0Z4y6+/h3ehHmREcNJluYWEvFlQML7iwbQ/9o5focNkp+8tVHyK3idHKSFdTRHZGGZex8RBg7p6QPIAIN6x4tHlvdVWYudNPEyPI8cLRRANjKT2M6vGjnLFfTyBEULWrAKNNheBgoS70f7MDK5ksDiV25uDBIm3reFwJQwTY+p1OFBzTPpADG0OPPDF3nhogkaPdlx5odO+UaZS1SXakQDF7CugXgYgxY/AXbsBNwd074unmRQBUfuZek3Nv0k7ucd2VWZJddJIusT6iiE9m/1twSNDyawQh+u83OSZthnLGESH9bawzS1Q/4U76ZTLqJT8Zsj6i1qIP10stZZowBr5u6gAExCzq90CMLhdqtet3wIl9GkjFx4fyBt2xMpjHiNFA66PgRm0s+CWcAKA0c+vlPd9QS7xEtjeTzLsWjkQk1dPEs3/p5xwpbM7VQLMqskN9KJrqh4zbakc0dh6/NRgvIzNT7H0ptVu/ye4sEU/4x2EMFNtivL2Ah2pYI1su9Plr1E9IWTkOLk2/cU2AmkpscXMO5HLoZXdGUxB68pD7R1bNg/RGYoc4mmcVDfcpbcuQpWtv2jNvJSSqkpLGIeHcnC2TCr2OWc+Z2PxTUVaA/umiV3zXYh2yVTA3SriqCNcFf0mVeVlzBeSqnrWYmg/RKYBzQQc35TYcNX7QhxycBqnz17w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wz0fgVnNv93f5FXdAMv1AR6ZONi7txsqwE2OwJlwVgKAQHA2Ro1VGFlNoJguifiDuFgqBq8Xd9gn6KofWu9buzoyPtJXksKiM8EAsDkLJSdytzSZfnxz+SWWtlkI+ij+3hqWKnQISQjWDO3KyAfK1/+hpBaJ+CUadn3pucFNSnCJ5lxtYqv8oIHRZrHW3fbMBNJCXy63wEryo/u/glwsC8ZFCStlC3/R5FIl0P+sawiiGGV/J3jdjOMGzw4hR2Ga0MVYMF+sCrf0Hh+vRjBqA608QJPHPxsASEPXq0+mY0wlQBE0r7LwzWu2dGuJ0hxN8dYIquF58xEe9o5hm1sb2dxAOpW2NxbwkX23zMcbeZvJQGad+CxULYbNPZtlOpSc73hNdRLb6KcFhsWHbalRTWbVWGBmMAY0EcUtjCaqngJykYCuhGCd2CBfVqrFQR2Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:40.4662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6888427-6388-43f6-af27-08df141b4d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6372
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

[Why]
Hwss executors shouldn't be coupled to complex dc structs such as
pipe_ctx. The DPP_PROGRAM_UPSP executor took a whole pipe_ctx only to
reach two fields.

[How]
Change program_upsp_params to hold the dpp and the dscl_prog_data that
dpp_program_upsp() actually needs, and extract them in the generic HWSS
layer. Add hwss_add_dpp_program_upsp() so the build site uses a helper
with the standard bounds check instead of assigning the step inline.
Update the BLS specs.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 35 ++++++++++---------
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  8 ++++-
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 6ed22b2e9c74..b3270f5bb56e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1023,11 +1023,9 @@ void hwss_build_full_sequence(struct dc *dc,
 					if (current_pipe->plane_res.hubp->funcs->hubp_program_mcache_id_and_split_coordinate)
 						hwss_add_hubp_program_mcache_id(&seq_state, current_pipe->plane_res.hubp, &current_pipe->mcache_regs);
 
-					if (current_pipe->plane_res.dpp->funcs->dpp_program_upsp) {
-						block_sequence[*num_steps].params.program_upsp_params.pipe_ctx = current_pipe;
-						block_sequence[*num_steps].func = DPP_PROGRAM_UPSP;
-						(*num_steps)++;
-					}
+					if (current_pipe->plane_res.dpp->funcs->dpp_program_upsp)
+						hwss_add_dpp_program_upsp(&seq_state, current_pipe->plane_res.dpp,
+							&current_pipe->plane_res.scl_data.dscl_prog_data);
 				}
 			}
 			current_pipe = current_pipe->bottom_pipe;
@@ -3009,18 +3007,11 @@ void hwss_program_bias_and_scale(union block_sequence_params *params)
 
 void hwss_program_upsp(union block_sequence_params *params)
 {
-	struct pipe_ctx *pipe_ctx = params->program_upsp_params.pipe_ctx;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	struct dscl_prog_data *dscl_prog_data = &pipe_ctx->plane_res.scl_data.dscl_prog_data;
+	struct dpp *dpp = params->program_upsp_params.dpp;
+	const struct dscl_prog_data *dscl_prog_data = params->program_upsp_params.dscl_prog_data;
 
-	if (!dpp || !dscl_prog_data)
-		return;
-
-	if (dpp && dpp->funcs->dpp_program_upsp) {
-		// program upsampler
-		dpp->funcs->dpp_program_upsp(dpp,
-				dscl_prog_data);
-	}
+	if (dpp && dscl_prog_data && dpp->funcs->dpp_program_upsp)
+		dpp->funcs->dpp_program_upsp(dpp, dscl_prog_data);
 }
 
 void hwss_power_on_mpc_mem_pwr(union block_sequence_params *params)
@@ -5737,6 +5728,18 @@ void hwss_add_dpp_set_scaler(struct block_sequence_state *seq_state,
 	}
 }
 
+void hwss_add_dpp_program_upsp(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		const struct dscl_prog_data *dscl_prog_data)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_PROGRAM_UPSP;
+		seq_state->steps[*seq_state->num_steps].params.program_upsp_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.program_upsp_params.dscl_prog_data = dscl_prog_data;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_hubp_mem_program_viewport(struct block_sequence_state *seq_state,
 		struct hubp *hubp,
 		const struct rect *viewport,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index fc5935b1e8b7..7d4310c0ef3f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -54,6 +54,7 @@ struct pg_block_update;
 struct drr_params;
 struct dc_underflow_debug_data;
 struct dsc_optc_config;
+struct dscl_prog_data;
 struct vm_system_aperture_param;
 struct stream_encoder;
 struct hpo_dp_stream_encoder;
@@ -171,7 +172,8 @@ struct set_output_transfer_func_params {
 	const struct dc_stream_state *stream;
 };
 struct program_upsp_params {
-	struct pipe_ctx *pipe_ctx;
+	struct dpp *dpp;
+	const struct dscl_prog_data *dscl_prog_data;
 };
 
 struct update_visual_confirm_params {
@@ -2628,6 +2630,10 @@ void hwss_add_dpp_set_scaler(struct block_sequence_state *seq_state,
 		struct dpp *dpp,
 		const struct scaler_data *scl_data);
 
+void hwss_add_dpp_program_upsp(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		const struct dscl_prog_data *dscl_prog_data);
+
 void hwss_add_hubp_mem_program_viewport(struct block_sequence_state *seq_state,
 		struct hubp *hubp,
 		const struct rect *viewport,
-- 
2.55.0


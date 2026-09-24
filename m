Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4953C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259D410F72F;
	Thu, 24 Sep 2026 18:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U0R1pFAE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B6F10F72C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdCAYUT8IINPp47BwczRtMQ+TzLyRFp38t0igW/+D9+nZMTn8L2b/IPi5R22nS+NE0xyxbYWlJfTCzrGnbS/YFsyB8ZcDI8MQN4XjZOc8ScPwYNkfomDXTcPM8kXu6xCPmyf4emF4l9NttlqFj5mCoa9jcjNPeoxOu3rvyADlXksmS8X37BcBJWzjaZfZykwQWEL83Bvz5H6JFx+3vrupaB9Uw1dKj24GPTtXABMXLTkdZXQTikcmeElhVQv/8di9EenHT4RU8fiuwEwqLkk2X+Gc2w054Q1vxjJXh/0KV9Yyy1obWLMjpThTgroSn/x+EX4WsiS0zR98OL25mfZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0JSDTMZs3q7/67ATYZAMNBzpV3r5hNw6BUq0xtmMXA=;
 b=bXWxYxU7IdjjYidJQI1qQV6Y1Md2hd4490g2msQZVm6bZfI2UMQD3tSWvGX/feLC9lkbfXB6LCghUJRxCbk6/vMh6TS7y70+DVVUVm9bBa94AAp8ZqrwElHhgxkFSIODP2lWHrA7+vD//BLBsSxz6ShQpT7T8+mjoXRNwaP46nE6mA2xoIHmHjNiSS2+QDwroF9Zw79GKgW2rvplQRsyHuoqyeAaGHffCNhVLl4l7kIl4E+c8abwLKWv08Jve0KQXZOaRL45EykT3FSNW6HuQPuWMKzE2rFKYzcaH0qF3cAnLC3L+OZAYKWQm3uYzKSFXfWeLbSazLD1mhaK+OGxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0JSDTMZs3q7/67ATYZAMNBzpV3r5hNw6BUq0xtmMXA=;
 b=U0R1pFAEKrq6IHvdr7fZAIDgqfEEM9C9rHbMXlatv4amnTB9Frg9TIPY6omU8RBVIPH/qMUivl1ZwGfPZBRbFtk1YZ94vzXSk2yJoPSFtjNqw/5NGEyeCco6NssGl3qasbAC94o2UeXyUi/KCnSYTXnmvUT9c5e8f1QTxWmS5+g=
Received: from PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::17)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:34 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::74) by PH8P221CA0012.outlook.office365.com
 (2603:10b6:510:2d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:33 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:16 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 22/34] drm/amd/display: Remove dead self-refresh BLS steps
Date: Thu, 24 Sep 2026 14:45:35 -0400
Message-ID: <20260924184824.596894-23-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cffc8a-0ce3-4d70-88d6-08df1a6c2803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: nynKifRCDps4Bg2qNCszINrTUkuaJXcxxMYyS5DUMQNXh2QSGVK4R9uLRXTOuuRjF4xqQj79l8vpeKlC+sZhxKHBHWE6DTKYQyiRKyHyScMxHkhwco/wwKIZQnKmc3qd4F9Lz0JIGzcnYyD7m+Az+XasEAaqA5wsMEYmf9wGITC4VgaclFZhos0iCiMdaGL7MRWhDSIrzEeQnam9tS5UopFt2c3fhl6bzpXszVLPnMPmOyms/ut5ouiKK+8o7rPN6/UO8JhepER+VCEPdB0+9b4oKZIpCkPlBfXI8m5naOHRFsdh2Vr23U1KuEQJqaLDKoOTpKecX7i2E2BWPmntzhinZQJHlI7jMBcctn+/gXCJ/CJPf1I+EqCAEVKaxgFFKdD9kWyp1ylAPYezpanDGXMXN/kKoOrmQn1i9eHd1+bJEMHpHBz0sL2HoFJJOF6GS4ZigRuASt7sVM1T5KBfd8gmQx6uJO9wDSZqpaZLi/RBVNn54Z4aoD/RCLuLnoZcO+TlKjfOKtl8vpy5LAzHzzAACTkNTX8QQzayyZOE9j7Mxacyi7xCvETnBYNMtvEFrnI15MqmSqErwBqa8B9lFlc5vuNuRNvcYXLCkJ856mkovRbSHbQkBE7LUoPBqLD9aXXn16GiSI9ekv/Ntf6d0SfPQKlX2YJ62Oa9Vi/U7Rkh4RZIBvmavuOvekEwSdFRjvlMQAbO7gYqH/Q2W39o5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U/uMqibA0X6IcoYawfU+6exp1WzN0/r1GzirH5osEWzUhR7Gxsh4RnztIyy653PZvY5OAx4SnfBcE6OpQwPI4MjxoVclTxPP5b580UibRyKZTUbXoSbRMc4lsBRG/uL4u/8OZPHHjCB0ieYRqA8fu3WLAz6Xr4s1HH4xqc9LrvnhX17y33OidtKVh7IrwBozUTCIXwuyLptFhVLRh8fDzGEfvEt924CZP3fFjWgt5T1ztzwlh813OqKy/60ZIU9DboKJTGwKLsKoLTNwhpMYop1FsoqbcGgLmtYlwgj4cBnojjPzP6PF4mKMAsGhlusJ1ImmSilPq1x3WGj7AD9r+Ub7R0/Pas5AptpG85qJ63hgy720N5l/1CQHaHZjc8nW0oeQaR4Nct6Iz9bwgeQHt4+KdxXfxGLIyabY82sdl2Z1ESg8iZM2tP2agIoVMmmh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:33.8694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cffc8a-0ce3-4d70-88d6-08df1a6c2803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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
The DCN10 post-unlock BLS path still emitted self-refresh suppression steps
that are dead for this flow. Keeping them also left non-compliant BLS enums
and documentation behind after the architecture cleanup.

[HOW]
Removed the dead DCN10 BLS producer path, dropped the associated BLS enums,
params, helpers, dispatcher cases, unit-test dumper cases, and updated the
BLS documentation. Kept the shared dcn10_update_pending_status consumer
because later DCN generations still use it.

Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 65 -------------------
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 26 --------
 2 files changed, 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index ccf5ed47ce62..21a62ca4c8dc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1160,25 +1160,6 @@ void hwss_build_post_unlock_full_sequence(struct dc *dc,
 	if (hwseq && hwseq->wa.DEGVIDCN21)
 		hwss_add_hubbub_apply_dedcn21_147_wa(&seq_state, dc->res_pool->hubbub);
 
-	/* Handle stutter underflow WA during MPO transitions */
-	if (hwseq && hwseq->wa.disallow_self_refresh_during_multi_plane_transition &&
-			dc->current_state->stream_status[0].plane_count == 1 &&
-			context->stream_status[0].plane_count > 1) {
-
-		hwss_add_hubbub_allow_self_refresh_control(&seq_state, dc->res_pool->hubbub, false);
-
-		/* Get frame count for WA state tracking - this needs to be done immediately after the above call */
-		if (dc->res_pool->timing_generators[0]->funcs->get_frame_count) {
-			hwss_add_tg_get_frame_count(&seq_state, dc->res_pool->timing_generators[0],
-				&hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied_on_frame);
-		}
-
-		/*
-		 * Set here rather than as a sequence step: the executor must not
-		 * write to logical objects.
-		 */
-		hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied = true;
-	}
 }
 
 static uint32_t get_dcc_meta_propagation_delay(struct dc *dc, struct pipe_ctx *pipe_ctx)
@@ -1924,12 +1905,6 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBBUB_APPLY_DEDCN21_147_WA:
 			hwss_hubbub_apply_dedcn21_147_wa(params);
 			break;
-		case HUBBUB_ALLOW_SELF_REFRESH_CONTROL:
-			hwss_hubbub_allow_self_refresh_control(params);
-			break;
-		case TG_GET_FRAME_COUNT:
-			hwss_tg_get_frame_count(params);
-			break;
 		case MPC_SET_DWB_MUX:
 			hwss_mpc_set_dwb_mux(params);
 			break;
@@ -3684,22 +3659,6 @@ void hwss_hubbub_apply_dedcn21_147_wa(union block_sequence_params *params)
 	hubbub->funcs->apply_DEDCN21_147_wa(hubbub);
 }
 
-void hwss_hubbub_allow_self_refresh_control(union block_sequence_params *params)
-{
-	struct hubbub *hubbub = params->hubbub_allow_self_refresh_control_params.hubbub;
-	bool allow = params->hubbub_allow_self_refresh_control_params.allow;
-
-	hubbub->funcs->allow_self_refresh_control(hubbub, allow);
-}
-
-void hwss_tg_get_frame_count(union block_sequence_params *params)
-{
-	struct timing_generator *tg = params->tg_get_frame_count_params.tg;
-	unsigned int *frame_count = params->tg_get_frame_count_params.frame_count;
-
-	*frame_count = tg->funcs->get_frame_count(tg);
-}
-
 void hwss_mpc_set_dwb_mux(union block_sequence_params *params)
 {
 	struct mpc *mpc = params->mpc_set_dwb_mux_params.mpc;
@@ -5879,30 +5838,6 @@ void hwss_add_hubbub_apply_dedcn21_147_wa(struct block_sequence_state *seq_state
 	}
 }
 
-void hwss_add_hubbub_allow_self_refresh_control(struct block_sequence_state *seq_state,
-		struct hubbub *hubbub,
-		bool allow)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = HUBBUB_ALLOW_SELF_REFRESH_CONTROL;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.hubbub = hubbub;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.allow = allow;
-		(*seq_state->num_steps)++;
-	}
-}
-
-void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
-		struct timing_generator *tg,
-		unsigned int *frame_count)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = TG_GET_FRAME_COUNT;
-		seq_state->steps[*seq_state->num_steps].params.tg_get_frame_count_params.tg = tg;
-		seq_state->steps[*seq_state->num_steps].params.tg_get_frame_count_params.frame_count = frame_count;
-		(*seq_state->num_steps)++;
-	}
-}
-
 void hwss_add_cursor_lock(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 9c32418be8f2..c0c098b5bcaa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -525,16 +525,6 @@ struct hubbub_apply_dedcn21_147_wa_params {
 	struct hubbub *hubbub;
 };
 
-struct hubbub_allow_self_refresh_control_params {
-	struct hubbub *hubbub;
-	bool allow;
-};
-
-struct tg_get_frame_count_params {
-	struct timing_generator *tg;
-	unsigned int *frame_count;
-};
-
 struct mpc_set_dwb_mux_params {
 	struct mpc *mpc;
 	int dwb_id;
@@ -1128,8 +1118,6 @@ union block_sequence_params {
 	struct tg_wait_double_buffer_pending_params tg_wait_double_buffer_pending_params;
 	struct update_force_pstate_params update_force_pstate_params;
 	struct hubbub_apply_dedcn21_147_wa_params hubbub_apply_dedcn21_147_wa_params;
-	struct hubbub_allow_self_refresh_control_params hubbub_allow_self_refresh_control_params;
-	struct tg_get_frame_count_params tg_get_frame_count_params;
 	struct mpc_set_dwb_mux_params mpc_set_dwb_mux_params;
 	struct mpc_disable_dwb_mux_params mpc_disable_dwb_mux_params;
 	struct mcif_wb_config_buf_params mcif_wb_config_buf_params;
@@ -1301,8 +1289,6 @@ enum block_sequence_func {
 	UPDATE_FORCE_PSTATE,
 	PROGRAM_MALL_PIPE_CONFIG,
 	HUBBUB_APPLY_DEDCN21_147_WA,
-	HUBBUB_ALLOW_SELF_REFRESH_CONTROL,
-	TG_GET_FRAME_COUNT,
 	MPC_SET_DWB_MUX,
 	MPC_DISABLE_DWB_MUX,
 	MCIF_WB_CONFIG_BUF,
@@ -2018,10 +2004,6 @@ void hwss_update_force_pstate(union block_sequence_params *params);
 
 void hwss_hubbub_apply_dedcn21_147_wa(union block_sequence_params *params);
 
-void hwss_hubbub_allow_self_refresh_control(union block_sequence_params *params);
-
-void hwss_tg_get_frame_count(union block_sequence_params *params);
-
 void hwss_mpc_set_dwb_mux(union block_sequence_params *params);
 
 void hwss_mpc_disable_dwb_mux(union block_sequence_params *params);
@@ -2660,14 +2642,6 @@ void hwss_add_update_force_pstate(struct block_sequence_state *seq_state,
 void hwss_add_hubbub_apply_dedcn21_147_wa(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub);
 
-void hwss_add_hubbub_allow_self_refresh_control(struct block_sequence_state *seq_state,
-		struct hubbub *hubbub,
-		bool allow);
-
-void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
-		struct timing_generator *tg,
-		unsigned int *frame_count);
-
 void hwss_add_tg_set_dsc_config(struct block_sequence_state *seq_state,
 		struct timing_generator *tg,
 		struct dsc_optc_config *dsc_optc_cfg,
-- 
2.53.0


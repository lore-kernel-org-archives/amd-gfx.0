Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205F606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uwE990Hu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D60A10F6B1;
	Wed, 25 Nov 2026 06:58:08 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779E110F679
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fteg8WkvWn1ADS3YC8qhuRd2CdftAW+Ke+l+8cj1yLMu6LTY8lv7kC5YrLcqK2mvbPi5netW/WlJwpVj5ybMrNCWrEuQCCgUUG5ImX+hgUnb6EjcF0OUbwuTYBkY2JrPq7kA8pJy/mWPKPG/c+mi4OxLC+jPuPsjhqINzuqRiDWYVvCTxQLcO0msLgn/qcJ9Cz9H7K13tb50hl9nfWzbA3o/1qJq4zf/8RbdgCi1j2vjlWwEFczXv+c7/lg9UjcrtgsrJMQ+Sh65TeoJXVyU7iq/NjJgPFuds2geMayXFGn7G39WESvuMyUPczbQ+e4YZGdRzdn9Z/p94VB3iS8Llg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiElgwvGVhvXPuwNjXeybDWqfEI1KFVlAGV3R4XX+DM=;
 b=MBVdIM2bMHw8jJSlOvGT1MTHEMoqI1AviEZHCVve75S3vWP4miAJ6mOpeu+qnj6wcZqmKeJy05M4mIzgbrbWbdcyDAilJRKhEOjegeTQU+Y+ZQbS13KPim1aULrlbKNbMls3X1bNXPT/ZKHN04k08/4b9B6YxqjtTTtZ2B3MqwQvi1tsWvr+cZloX9TlVx11jlbtiZIswsTI/POZeOUjMXdojhzCUaetwIg2/XOVH84ZitsVbPbI+WRz9GwynP9xwk5IsfTHkQUXNU+tT8wnG4BPjj+vN5wHXbypg5YqBu4Iq7EpxZ85yqg40zgNyK13A7vyjktJizd1c+i89D87rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiElgwvGVhvXPuwNjXeybDWqfEI1KFVlAGV3R4XX+DM=;
 b=uwE990HudkuB11aFuExjqcfJJGTfC8RShjhn2Ge4D3Qp8WD7tsFXfo2EjJQqbwWJ6Ax3B5iP1208u54VlrtmKSpsX2X0AIjDO50+TVkvyu07LLSVkhOCCk1SS2OGWCjutlAt4BS3TJ2Idg1c49ErS5j4FC7CJ47H/KJhnAuWQs4=
Received: from PH8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:2cd::21)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 06:57:43 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::6c) by PH8PR07CA0022.outlook.office365.com
 (2603:10b6:510:2cd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:57:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:57:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:41 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:40 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:57:32 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 16/27] drm/amd/display: Refactor ABM_SET_PIPE and
 ABM_SET_IMMEDIATE_DISABLE
Date: Wed, 25 Nov 2026 14:55:05 +0800
Message-ID: <20261125065631.3889665-17-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: c19d46e0-5928-49ea-7b6e-08df4ac166ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|261021123027099003|261022105027099003|261026121527099003|261009221227099003|261009223027099003|261026140227099003|261021121427099003|261102123227099003|261028144727099003|261022075727099003|22082099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: D0uHxhBegt15uiX8FjSm2JpDnQBUy771c7Y35K6FshqHPNhsP7yvV4JxK3LFtwXubjK7I5sm5GrIHpagB5VKGi0q6rFq7aRz3z/gRYhLdmoMI1VZFGP3h4K/oRlsElcqDTYukhDI0JvWXNAvvt9vdwzeMUXjYglns1NBu8/j/rmUhrGeuERLwbGU3J5OQ0yuQsuIs/H7WBMO5rjR96o0pIaqolnkVpL7tK8e5lLS9EQIfIboyC+gcrnoukr26D5OwVc83gon5Mh+qxs2ckssLNf4Kmm1j5Z1Iw/d1FIaehBiqQxM8/nEZf0The8MvE+0NsfiInVqIuNCeoT4RwZc/He572JcArGBVDyUcIzzSaZ8xojIP/tfKBk3ulRwQhgPRNiMWNZBPorXSduLO65r3LNFQseivcf2U98EfY+5BcR+snd2ldeaEBN2XtuALjhMjfhKDmSTKA0QM4xvDO+wPpK6wrAjyPZO0Lwe2TPRdrL3mYCuzhoGq0jBAo91g0I1fU6CSfgdk5f0CCkb/st9KQ7wN8c7CwBkVbzVeajSabsChUKKdqjTEhLUD4KiuL+SaOAS2Ze2t+kyx+ZV5eNTG1/+QJu140spMJXfhzWxEHHQLhvjqr+HTVHSFSpYnF/RWziZ8sJdl6a+YsSkcAj84MLc0FstpDi0jFOTbrZVPOY3HpS1k4oTkWNEV5sMvvgdHu5Y4I4YkUUu4qQKkcKjdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(261021123027099003)(261022105027099003)(261026121527099003)(261009221227099003)(261009223027099003)(261026140227099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022075727099003)(22082099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iLUL5VvT9Px9VB9XFXaj7aHpoy6BT4cZA7959JP/TqBsI7UCu5wV/HPaa+9oFPDWi3wcpJ9lckPr2hKrSexXpvqVNx1LIk2rFYB+gLwZBWHojIsl+CzT5kaBv79glYD0sBYwT6KRoFeZ0LfcXh/InCCXruoFZeJkoj6Lvc2zful3Fl1PIuUfqL0QcGwmW0hE+6zG+rzAUXn60wqLBdBOXW+Z4nV48qK/0iJ6lp1M4cqfUBgyIR5hIc4A1nL1sOIJInt9vzBZz5XYYIzyoIJZe88D49pA1y+p8hVcm/ZWfmdKl8GZ6VRT0ukD3ikThET7dh2FLk3QkWAX5RXOoVUGKBJ+nttsZc2EsIrlriAxoTUfYnDLABTINKKYp1KsoHTqIChSUwkP2o6hlE1SSgEuxLwe6bZRuo+/aWYTwiPc7fmIlqLzIP+nBowYEL+mL+mI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:57:42.4681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19d46e0-5928-49ea-7b6e-08df4ac166ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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
- Both steps carried dc and pipe_ctx, which breaks the block sequence
  rules on flat params and instance specification.
- ABM_SET_IMMEDIATE_DISABLE also stored the panel backlight level, which
  belongs to a different HW block (panel_cntl).

[How]
- Both steps share set_abm_pipe_params: the ABM handle, otg, panel and
  pwrseq instances and the ABM type of the panel. The builder resolves
  them with hwss_prepare_abm_set_pipe(), which the legacy dcn21 path
  uses too.
- Add a sixth parameter, feature_support, to abm_funcs.set_pipe_ex so
  the executor needs no dc lookup. The type is the new enum
  abm_feature_support in abm.h.
- Rename abm_feature_support() in dmub_abm.c to
  dmub_abm_feature_support(), declare it in dmub_abm.h and make it
  return the new enum. It looks the panel up by panel_inst, so the ABM
  type is unchanged.
  hwss_prepare_abm_set_pipe() uses it, like the other dmub_abm hooks.
- Adders return bool and hold all null and hook checks. Both adders
  require set_pipe_ex: no ASIC that runs the block sequence creates a
  DMCU, so the DMCU branch is gone from the BLS path. The level 0/255
  skip for non-CACP panels applies as in dcn21_set_abm_immediate_disable.
- Add PANEL_CNTL_STORE_BACKLIGHT_LEVEL. The callers add it with
  hwss_add_abm_immediate_disable_and_store_backlight(), which checks
  both free slots and the store hook first, so the ABM is never
  disabled without storing the backlight level.
Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 164 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  66 ++++---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h |   2 +
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 108 ++++++------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  49 ++++--
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  10 +-
 8 files changed, 267 insertions(+), 140 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 584eb3e0f4c6..032ce62c810e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4471,7 +4471,7 @@ static void commit_planes_do_stream_update_sequence(struct dc *dc,
 
 				if (should_program_abm) {
 					if (*stream_update->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) {
-						hwss_add_abm_set_immediate_disable(&seq_state, dc, pipe_ctx);
+						hwss_add_abm_immediate_disable_and_store_backlight(&seq_state, pipe_ctx);
 					} else {
 						hwss_add_abm_set_level(&seq_state, pipe_ctx->stream_res.abm, stream->abm_level);
 					}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 079a9ee8c5f5..0cd17e0a4b9f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -40,6 +40,7 @@
 #include "clk_mgr.h"
 #include "dcn10/dcn10_hubbub.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "dce/dmub_abm.h"
 #include "link_service.h"
 #include "custom_float.h"
 
@@ -1926,13 +1927,16 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_opp_set_disp_pattern_generator(params);
 			break;
 		case ABM_SET_PIPE:
-			hwss_set_abm_pipe(params);
+			hwss_abm_set_pipe(params);
 			break;
 		case ABM_SET_LEVEL:
-			hwss_set_abm_level(params);
+			hwss_abm_set_level(params);
 			break;
 		case ABM_SET_IMMEDIATE_DISABLE:
-			hwss_set_abm_immediate_disable(params);
+			hwss_abm_set_immediate_disable(params);
+			break;
+		case PANEL_CNTL_STORE_BACKLIGHT_LEVEL:
+			hwss_panel_cntl_store_backlight_level(params);
 			break;
 		case MPC_REMOVE_MPCC:
 			hwss_mpc_remove_mpcc(params);
@@ -2948,19 +2952,64 @@ void hwss_add_opp_program_left_edge_extra_pixel(struct block_sequence_state *seq
 	}
 }
 
+bool hwss_should_skip_abm_immediate_disable(const struct pipe_ctx *pipe_ctx)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	const struct dc_link *link = stream->link;
+
+	// make a short term w/a for an issue that backlight ramping unexpectedly paused in the middle,
+	// will decouple backlight from ABM and redefine DMUB interface, then this w/a could be removed
+	return (stream->abm_level == 0 || stream->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE) &&
+			(link && !link->panel_config.cacp.cacp_supported);
+}
+
+bool hwss_prepare_abm_set_pipe(const struct pipe_ctx *pipe_ctx,
+		struct set_abm_pipe_params *params)
+{
+	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct panel_cntl *panel_cntl = NULL;
+
+	memset(params, 0, sizeof(*params));
+
+	if (!pipe_ctx->stream || !pipe_ctx->stream->link)
+		return false;
+
+	panel_cntl = pipe_ctx->stream->link->panel_cntl;
+
+	if (!abm || !tg || !panel_cntl)
+		return false;
+
+	params->abm = abm;
+	params->otg_inst = tg->inst;
+	params->panel_inst = panel_cntl->inst;
+	params->pwrseq_inst = panel_cntl->pwrseq_inst;
+	params->abm_feature_support = dmub_abm_feature_support(abm, params->panel_inst);
+
+	return true;
+}
+
 /*
  * Helper function to add ABM set pipe to block sequence
  */
-void hwss_add_abm_set_pipe(struct block_sequence_state *seq_state,
-		struct dc *dc,
+bool hwss_add_abm_set_pipe(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.set_abm_pipe_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.set_abm_pipe_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].func = ABM_SET_PIPE;
-		(*seq_state->num_steps)++;
-	}
+	struct set_abm_pipe_params prepared = {};
+
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE || !pipe_ctx)
+		return false;
+
+	if (!hwss_prepare_abm_set_pipe(pipe_ctx, &prepared) ||
+			!prepared.abm->funcs || !prepared.abm->funcs->set_pipe_ex)
+		return false;
+
+	seq_state->steps[*seq_state->num_steps].func = ABM_SET_PIPE;
+	seq_state->steps[*seq_state->num_steps].params.set_abm_pipe_params = prepared;
+	(*seq_state->num_steps)++;
+
+	return true;
 }
 
 /*
@@ -3803,15 +3852,15 @@ void hwss_opp_set_disp_pattern_generator(union block_sequence_params *params)
 	}
 }
 
-void hwss_set_abm_pipe(union block_sequence_params *params)
+void hwss_abm_set_pipe(union block_sequence_params *params)
 {
-	struct dc *dc = params->set_abm_pipe_params.dc;
-	struct pipe_ctx *pipe_ctx = params->set_abm_pipe_params.pipe_ctx;
+	struct set_abm_pipe_params *p = &params->set_abm_pipe_params;
 
-	dc->hwss.set_pipe(pipe_ctx);
+	p->abm->funcs->set_pipe_ex(p->abm, p->otg_inst, SET_ABM_PIPE_NORMAL, p->panel_inst,
+			p->pwrseq_inst, p->abm_feature_support);
 }
 
-void hwss_set_abm_level(union block_sequence_params *params)
+void hwss_abm_set_level(union block_sequence_params *params)
 {
 	struct abm *abm = params->set_abm_level_params.abm;
 	unsigned int abm_level = params->set_abm_level_params.abm_level;
@@ -3820,13 +3869,19 @@ void hwss_set_abm_level(union block_sequence_params *params)
 		abm->funcs->set_abm_level(abm, abm_level);
 }
 
-void hwss_set_abm_immediate_disable(union block_sequence_params *params)
+void hwss_abm_set_immediate_disable(union block_sequence_params *params)
 {
-	struct dc *dc = params->set_abm_immediate_disable_params.dc;
-	struct pipe_ctx *pipe_ctx = params->set_abm_immediate_disable_params.pipe_ctx;
+	struct set_abm_pipe_params *p = &params->set_abm_immediate_disable_params;
 
-	if (dc && dc->hwss.set_abm_immediate_disable)
-		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+	p->abm->funcs->set_pipe_ex(p->abm, p->otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+			p->panel_inst, p->pwrseq_inst, p->abm_feature_support);
+}
+
+void hwss_panel_cntl_store_backlight_level(union block_sequence_params *params)
+{
+	struct panel_cntl *panel_cntl = params->panel_cntl_store_backlight_level_params.panel_cntl;
+
+	panel_cntl->funcs->store_backlight_level(panel_cntl);
 }
 
 void hwss_mpc_remove_mpcc(union block_sequence_params *params)
@@ -5112,15 +5167,66 @@ void hwss_add_dc_set_optimized_required(struct block_sequence_state *seq_state,
 	}
 }
 
-void hwss_add_abm_set_immediate_disable(struct block_sequence_state *seq_state,
-		struct dc *dc, struct pipe_ctx *pipe_ctx)
+bool hwss_add_abm_set_immediate_disable(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = ABM_SET_IMMEDIATE_DISABLE;
-		seq_state->steps[*seq_state->num_steps].params.set_abm_immediate_disable_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.set_abm_immediate_disable_params.pipe_ctx = pipe_ctx;
-		(*seq_state->num_steps)++;
-	}
+	struct set_abm_pipe_params prepared = {};
+
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE || !pipe_ctx)
+		return false;
+
+	if (!hwss_prepare_abm_set_pipe(pipe_ctx, &prepared) ||
+			!prepared.abm->funcs || !prepared.abm->funcs->set_pipe_ex)
+		return false;
+
+	if (hwss_should_skip_abm_immediate_disable(pipe_ctx))
+		return false;
+
+	seq_state->steps[*seq_state->num_steps].func = ABM_SET_IMMEDIATE_DISABLE;
+	seq_state->steps[*seq_state->num_steps].params.set_abm_immediate_disable_params = prepared;
+	(*seq_state->num_steps)++;
+
+	return true;
+}
+
+bool hwss_add_panel_cntl_store_backlight_level(struct block_sequence_state *seq_state,
+		struct panel_cntl *panel_cntl)
+{
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps ||
+			*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE || !panel_cntl)
+		return false;
+
+	if (!panel_cntl->funcs || !panel_cntl->funcs->store_backlight_level)
+		return false;
+
+	seq_state->steps[*seq_state->num_steps].func = PANEL_CNTL_STORE_BACKLIGHT_LEVEL;
+	seq_state->steps[*seq_state->num_steps]
+			.params.panel_cntl_store_backlight_level_params.panel_cntl = panel_cntl;
+	(*seq_state->num_steps)++;
+
+	return true;
+}
+
+bool hwss_add_abm_immediate_disable_and_store_backlight(
+		struct block_sequence_state *seq_state, struct pipe_ctx *pipe_ctx)
+{
+	struct panel_cntl *panel_cntl;
+
+	if (!seq_state || !seq_state->num_steps || !pipe_ctx || !pipe_ctx->stream ||
+			!pipe_ctx->stream->link)
+		return false;
+
+	panel_cntl = pipe_ctx->stream->link->panel_cntl;
+
+	if (*seq_state->num_steps + 2 > MAX_HWSS_BLOCK_SEQUENCE_SIZE || !panel_cntl ||
+			!panel_cntl->funcs || !panel_cntl->funcs->store_backlight_level)
+		return false;
+
+	if (!hwss_add_abm_set_immediate_disable(seq_state, pipe_ctx))
+		return false;
+
+	return hwss_add_panel_cntl_store_backlight_level(seq_state, panel_cntl);
 }
 
 void hwss_add_opp_set_disp_pattern_generator(struct block_sequence_state *seq_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 8cca8599b917..b50260d2bd45 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -35,33 +35,26 @@
 #define TO_DMUB_ABM(abm)\
 	container_of(abm, struct dce_abm, base)
 
-#define ABM_FEATURE_NO_SUPPORT	0
-#define ABM_LCD_SUPPORT			1
-#define ABM_CACP_SUPPORT		2
-
-static unsigned int abm_feature_support(struct abm *abm, unsigned int panel_inst)
+enum abm_feature_support dmub_abm_feature_support(struct abm *abm, unsigned int panel_inst)
 {
-	struct dc_context *dc = abm->ctx;
 	struct dc_link *edp_links[MAX_NUM_EDP];
-	unsigned int i, edp_num;
-	unsigned int ret = ABM_FEATURE_NO_SUPPORT;
+	unsigned int edp_num;
+	const struct dc_link *link;
 
-	dc_get_edp_links(dc->dc, edp_links, &edp_num);
+	dc_get_edp_links(abm->ctx->dc, edp_links, &edp_num);
 
-	for (i = 0; i < edp_num; i++) {
-		if (panel_inst == i)
-			break;
-	}
+	if (panel_inst >= edp_num)
+		return ABM_FEATURE_NO_SUPPORT;
 
-	if (i < edp_num) {
-		if (edp_links[panel_inst]->panel_config.cacp.cacp_supported)
-			ret = ABM_CACP_SUPPORT;
-		else if ((edp_links[panel_inst]->panel_type == PANEL_TYPE_LCD) ||
-				(edp_links[panel_inst]->panel_type == PANEL_TYPE_MINILED))
-			ret = ABM_LCD_SUPPORT;
-	}
+	link = edp_links[panel_inst];
 
-	return ret;
+	if (link->panel_config.cacp.cacp_supported)
+		return ABM_CACP_SUPPORT;
+
+	if (link->panel_type == PANEL_TYPE_LCD || link->panel_type == PANEL_TYPE_MINILED)
+		return ABM_LCD_SUPPORT;
+
+	return ABM_FEATURE_NO_SUPPORT;
 }
 
 static enum dc_panel_type abm_get_paneltype(struct abm *abm, unsigned int panel_inst)
@@ -115,12 +108,13 @@ static unsigned int dmub_abm_get_target_backlight_ex(struct abm *abm)
 static bool dmub_abm_set_level_ex(struct abm *abm, uint32_t level)
 {
 	bool ret = false;
-	unsigned int feature_support, i;
+	enum abm_feature_support feature_support;
+	unsigned int i;
 	uint8_t panel_mask0 = 0;
 	uint8_t panel_mask1 = 0;
 
 	for (i = 0; i < MAX_NUM_EDP; i++) {
-		feature_support = abm_feature_support(abm, i);
+		feature_support = dmub_abm_feature_support(abm, i);
 
 		if (feature_support == ABM_LCD_SUPPORT)
 			panel_mask0 |= (0x01 << i);
@@ -142,9 +136,9 @@ static bool dmub_abm_init_config_ex(struct abm *abm,
 	unsigned int bytes,
 	unsigned int inst)
 {
-	unsigned int feature_support;
+	enum abm_feature_support feature_support;
 
-	feature_support = abm_feature_support(abm, inst);
+	feature_support = dmub_abm_feature_support(abm, inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
 		dmub_abm_init_config(abm, src, bytes, inst);
@@ -157,9 +151,9 @@ static bool dmub_abm_init_config_ex(struct abm *abm,
 static bool dmub_abm_set_pause_ex(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst)
 {
 	bool ret = false;
-	unsigned int feature_support;
+	enum abm_feature_support feature_support;
 
-	feature_support = abm_feature_support(abm, panel_inst);
+	feature_support = dmub_abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_set_pause(abm, pause, panel_inst, stream_inst);
@@ -184,10 +178,10 @@ static bool dmub_abm_save_restore_ex(
 		struct abm_save_restore *pData)
 {
 	bool ret = false;
-	unsigned int feature_support;
+	enum abm_feature_support feature_support;
 	struct dc_context *dc = abm->ctx;
 
-	feature_support = abm_feature_support(abm, panel_inst);
+	feature_support = dmub_abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_save_restore(dc, panel_inst, pData);
@@ -199,12 +193,10 @@ static bool dmub_abm_set_pipe_ex(struct abm *abm,
 		uint32_t otg_inst,
 		uint32_t option,
 		uint32_t panel_inst,
-		uint32_t pwrseq_inst)
+		uint32_t pwrseq_inst,
+		enum abm_feature_support feature_support)
 {
 	bool ret = false;
-	unsigned int feature_support;
-
-	feature_support = abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_set_pipe(abm, otg_inst, option, panel_inst, pwrseq_inst);
@@ -219,9 +211,9 @@ static bool dmub_abm_set_event_ex(struct abm *abm, unsigned int full_screen, uns
 		unsigned int panel_inst)
 {
 	bool ret = false;
-	unsigned int feature_support;
+	enum abm_feature_support feature_support;
 
-	feature_support = abm_feature_support(abm, panel_inst);
+	feature_support = dmub_abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_set_event(abm, scaling_enable, scaling_strength_map, panel_inst);
@@ -239,10 +231,10 @@ static bool dmub_abm_set_backlight_level_pwm_ex(struct abm *abm,
 {
 	(void)controller_id;
 	bool ret = false;
-	unsigned int feature_support;
+	enum abm_feature_support feature_support;
 	enum dc_panel_type panel_type = PANEL_TYPE_NONE;
 
-	feature_support = abm_feature_support(abm, panel_inst);
+	feature_support = dmub_abm_feature_support(abm, panel_inst);
 
 	if (feature_support == ABM_LCD_SUPPORT)
 		ret = dmub_abm_set_backlight_level(abm, backlight_pwm_u16_16, frame_ramp, panel_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h
index 3a5d5ac7a86e..eef2fa803aed 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.h
@@ -37,4 +37,6 @@ struct abm *dmub_abm_create(
 
 void dmub_abm_destroy(struct abm **abm);
 
+enum abm_feature_support dmub_abm_feature_support(struct abm *abm, unsigned int panel_inst);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 2be68f8dd0fc..673fc188fca9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -197,55 +197,51 @@ static void dmub_abm_set_backlight(struct dc_context *dc, uint32_t backlight_pwm
 
 void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 {
-	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
-	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	struct set_abm_pipe_params params = {};
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 	struct dc_link *link = pipe_ctx->stream->link;
+	struct abm *abm = NULL;
 
-	// make a short term w/a for an issue that backlight ramping unexpectedly paused in the middle,
-	// will decouple backlight from ABM and redefine DMUB interface, then this w/a could be removed
-	if ((pipe_ctx->stream->abm_level == 0 || pipe_ctx->stream->abm_level == ABM_LEVEL_IMMEDIATE_DISABLE)
-		&& (link && !link->panel_config.cacp.cacp_supported)) {
+	if (hwss_should_skip_abm_immediate_disable(pipe_ctx))
 		return;
-	}
 
 	if (dmcu) {
 		dce110_set_abm_immediate_disable(pipe_ctx);
 		return;
 	}
 
-	if (abm && panel_cntl) {
-		if (abm->funcs && abm->funcs->set_pipe_ex) {
-			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-					panel_cntl->inst, panel_cntl->pwrseq_inst);
-		} else if (link && link->panel_config.cacp.cacp_supported) {
-			dcn21_dmub_cacp_set_pipe(abm, otg_inst, SET_CACP_PIPE_IMMEDIATELY_DISABLE,
-						panel_cntl->inst, panel_cntl->pwrseq_inst);
-		} else {
-			dcn21_dmub_abm_set_pipe(abm,
-						otg_inst,
-						SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-						panel_cntl->inst,
-						panel_cntl->pwrseq_inst);
-		}
-		panel_cntl->funcs->store_backlight_level(panel_cntl);
+	if (!hwss_prepare_abm_set_pipe(pipe_ctx, &params))
+		return;
+
+	abm = params.abm;
+
+	if (abm->funcs && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm, params.otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+				params.panel_inst, params.pwrseq_inst, params.abm_feature_support);
+	} else if (link->panel_config.cacp.cacp_supported) {
+		dcn21_dmub_cacp_set_pipe(abm, params.otg_inst, SET_CACP_PIPE_IMMEDIATELY_DISABLE,
+					params.panel_inst, params.pwrseq_inst);
+	} else {
+		dcn21_dmub_abm_set_pipe(abm,
+					params.otg_inst,
+					SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+					params.panel_inst,
+					params.pwrseq_inst);
 	}
+	link->panel_cntl->funcs->store_backlight_level(link->panel_cntl);
 }
 
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 {
-	struct abm *abm = pipe_ctx->stream_res.abm;
-	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	struct set_abm_pipe_params params = {};
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
 	struct dc_link *link = pipe_ctx->stream->link;
-	uint32_t otg_inst;
+	struct abm *abm = NULL;
 
-	if (!abm || !tg || !panel_cntl)
+	if (!hwss_prepare_abm_set_pipe(pipe_ctx, &params))
 		return;
 
-	otg_inst = tg->inst;
+	abm = params.abm;
 
 	if (dmcu) {
 		dce110_set_pipe(pipe_ctx);
@@ -254,20 +250,21 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 
 	if (abm->funcs && abm->funcs->set_pipe_ex) {
 		abm->funcs->set_pipe_ex(abm,
-					otg_inst,
+					params.otg_inst,
 					SET_ABM_PIPE_NORMAL,
-					panel_cntl->inst,
-					panel_cntl->pwrseq_inst);
+					params.panel_inst,
+					params.pwrseq_inst,
+					params.abm_feature_support);
 	} else {
 
-		if (link && link->panel_config.cacp.cacp_supported)
-			dcn21_dmub_cacp_set_pipe(abm, otg_inst, SET_CACP_PIPE_NORMAL,
-					panel_cntl->inst, panel_cntl->pwrseq_inst);
+		if (link->panel_config.cacp.cacp_supported)
+			dcn21_dmub_cacp_set_pipe(abm, params.otg_inst, SET_CACP_PIPE_NORMAL,
+					params.panel_inst, params.pwrseq_inst);
 		else
-			dcn21_dmub_abm_set_pipe(abm, otg_inst,
+			dcn21_dmub_abm_set_pipe(abm, params.otg_inst,
 				  SET_ABM_PIPE_NORMAL,
-				  panel_cntl->inst,
-				  panel_cntl->pwrseq_inst);
+				  params.panel_inst,
+				  params.pwrseq_inst);
 	}
 }
 
@@ -275,18 +272,16 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	struct set_backlight_level_params *backlight_level_params)
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
-	struct abm *abm = pipe_ctx->stream_res.abm;
-	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
-	uint32_t otg_inst;
+	struct set_abm_pipe_params params = {};
 	uint32_t backlight_pwm_u16_16 = backlight_level_params->backlight_pwm_u16_16;
 	uint32_t frame_ramp = backlight_level_params->frame_ramp;
 	struct dc_link *link = pipe_ctx->stream->link;
+	struct abm *abm = NULL;
 
-	if (!abm || !tg || !panel_cntl)
+	if (!hwss_prepare_abm_set_pipe(pipe_ctx, &params))
 		return false;
 
-	otg_inst = tg->inst;
+	abm = params.abm;
 
 	if (dc->dc->res_pool->dmcu) {
 		dce110_set_backlight_level(pipe_ctx, backlight_level_params);
@@ -295,29 +290,30 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 
 	if (abm->funcs && abm->funcs->set_pipe_ex) {
 		abm->funcs->set_pipe_ex(abm,
-					otg_inst,
+					params.otg_inst,
 					SET_ABM_PIPE_NORMAL,
-					panel_cntl->inst,
-					panel_cntl->pwrseq_inst);
+					params.panel_inst,
+					params.pwrseq_inst,
+					params.abm_feature_support);
 	} else {
-		if (link && link->panel_config.cacp.cacp_supported)
-			dcn21_dmub_cacp_set_pipe(abm, otg_inst,
+		if (link->panel_config.cacp.cacp_supported)
+			dcn21_dmub_cacp_set_pipe(abm, params.otg_inst,
 					SET_CACP_PIPE_NORMAL,
-					panel_cntl->inst,
-					panel_cntl->pwrseq_inst);
+					params.panel_inst,
+					params.pwrseq_inst);
 		else
 			dcn21_dmub_abm_set_pipe(abm,
-				  otg_inst,
+				  params.otg_inst,
 				  SET_ABM_PIPE_NORMAL,
-				  panel_cntl->inst,
-				  panel_cntl->pwrseq_inst);
+				  params.panel_inst,
+				  params.pwrseq_inst);
 	}
 
 	if (abm->funcs && abm->funcs->set_backlight_level_pwm)
 		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
-			frame_ramp, 0, panel_cntl->inst);
+			frame_ramp, 0, params.panel_inst);
 	else
-		dmub_abm_set_backlight(dc, backlight_pwm_u16_16, frame_ramp, panel_cntl->inst);
+		dmub_abm_set_backlight(dc, backlight_pwm_u16_16, frame_ramp, params.panel_inst);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 7b1eca0e2b57..26b9137dc017 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2553,7 +2553,7 @@ void dcn401_program_pipe_sequence(
 	/* Set ABM pipe after other pipe configurations done */
 	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->visible)) {
 		if (pipe_ctx->stream_res.abm) {
-			hwss_add_abm_set_pipe(seq_state, dc, pipe_ctx);
+			hwss_add_abm_set_pipe(seq_state, pipe_ctx);
 
 			hwss_add_abm_set_level(seq_state, pipe_ctx->stream_res.abm, pipe_ctx->stream->abm_level);
 		}
@@ -3382,7 +3382,7 @@ void dcn401_blank_pixel_data_sequence(
 
 	if (blank) {
 		/* Set ABM immediate disable */
-		hwss_add_abm_set_immediate_disable(seq_state, dc, pipe_ctx);
+		hwss_add_abm_immediate_disable_and_store_backlight(seq_state, pipe_ctx);
 
 		if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE) {
 			test_pattern = CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
@@ -3432,7 +3432,7 @@ void dcn401_blank_pixel_data_sequence(
 	if (!blank) {
 		if (stream_res->abm) {
 			/* Set pipe for ABM */
-			hwss_add_abm_set_pipe(seq_state, dc, pipe_ctx);
+			hwss_add_abm_set_pipe(seq_state, pipe_ctx);
 
 			/* Set ABM level */
 			hwss_add_abm_set_level(seq_state, stream_res->abm, stream->abm_level);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 4769c71f05fb..da795c6501f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -34,6 +34,7 @@
 #include "inc/core_status.h"
 #include "inc/hw/hw_shared.h"
 #include "inc/hw/dchubbub.h"
+#include "inc/hw/abm.h"
 #include "dsc/dsc.h"
 #include "link_service_types.h"
 #include "dmub/inc/dmub_cmd.h"
@@ -772,9 +773,13 @@ struct opp_set_disp_pattern_generator_params {
 	bool disable_dyn_exp_for_test_pattern;
 };
 
+/* Params of both ABM_SET_PIPE and ABM_SET_IMMEDIATE_DISABLE. */
 struct set_abm_pipe_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct abm *abm;
+	unsigned int otg_inst;
+	unsigned int panel_inst;
+	unsigned int pwrseq_inst;
+	enum abm_feature_support abm_feature_support; /* resolved at build time */
 };
 
 struct set_abm_level_params {
@@ -782,9 +787,8 @@ struct set_abm_level_params {
 	unsigned int abm_level;
 };
 
-struct set_abm_immediate_disable_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+struct panel_cntl_store_backlight_level_params {
+	struct panel_cntl *panel_cntl;
 };
 
 struct mpc_update_blending_params {
@@ -1459,7 +1463,9 @@ union block_sequence_params {
 	struct opp_set_disp_pattern_generator_params opp_set_disp_pattern_generator_params;
 	struct set_abm_pipe_params set_abm_pipe_params;
 	struct set_abm_level_params set_abm_level_params;
-	struct set_abm_immediate_disable_params set_abm_immediate_disable_params;
+	struct set_abm_pipe_params set_abm_immediate_disable_params;
+	struct panel_cntl_store_backlight_level_params
+			panel_cntl_store_backlight_level_params;
 	struct mpc_remove_mpcc_params mpc_remove_mpcc_params;
 	struct dc_set_optimized_required_params dc_set_optimized_required_params;
 	struct hubp_disconnect_params hubp_disconnect_params;
@@ -1896,6 +1902,7 @@ enum block_sequence_func {
 	HUBP_SET_3DLUT_FL,
 	PMFW_SEND_MESSAGE_AND_WAIT,
 	DMUB_SEND_DMCUB_CMD2,
+	PANEL_CNTL_STORE_BACKLIGHT_LEVEL,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
@@ -2500,11 +2507,13 @@ void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params);
 
 void hwss_opp_set_disp_pattern_generator(union block_sequence_params *params);
 
-void hwss_set_abm_pipe(union block_sequence_params *params);
+void hwss_abm_set_pipe(union block_sequence_params *params);
 
-void hwss_set_abm_level(union block_sequence_params *params);
+void hwss_abm_set_level(union block_sequence_params *params);
 
-void hwss_set_abm_immediate_disable(union block_sequence_params *params);
+void hwss_abm_set_immediate_disable(union block_sequence_params *params);
+
+void hwss_panel_cntl_store_backlight_level(union block_sequence_params *params);
 
 void hwss_mpc_remove_mpcc(union block_sequence_params *params);
 
@@ -2805,8 +2814,13 @@ void hwss_add_opp_program_fmt(struct block_sequence_state *seq_state,
 		struct output_pixel_processor *opp, struct bit_depth_reduction_params *fmt_bit_depth,
 		struct clamping_and_pixel_encoding_params *clamping);
 
-void hwss_add_abm_set_pipe(struct block_sequence_state *seq_state,
-		struct dc *dc, struct pipe_ctx *pipe_ctx);
+bool hwss_add_abm_set_pipe(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+bool hwss_prepare_abm_set_pipe(const struct pipe_ctx *pipe_ctx,
+		struct set_abm_pipe_params *params);
+
+bool hwss_should_skip_abm_immediate_disable(const struct pipe_ctx *pipe_ctx);
 
 void hwss_add_abm_set_level(struct block_sequence_state *seq_state,
 		struct abm *abm, uint32_t abm_level);
@@ -2842,8 +2856,17 @@ void hwss_add_dsc_disconnect(struct block_sequence_state *seq_state,
 void hwss_add_dc_set_optimized_required(struct block_sequence_state *seq_state,
 		bool optimized_required);
 
-void hwss_add_abm_set_immediate_disable(struct block_sequence_state *seq_state,
-		struct dc *dc, struct pipe_ctx *pipe_ctx);
+/* Callers must use hwss_add_abm_immediate_disable_and_store_backlight(): this step alone
+ * does not store the backlight level.
+ */
+bool hwss_add_abm_set_immediate_disable(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+bool hwss_add_panel_cntl_store_backlight_level(struct block_sequence_state *seq_state,
+		struct panel_cntl *panel_cntl);
+
+bool hwss_add_abm_immediate_disable_and_store_backlight(
+		struct block_sequence_state *seq_state, struct pipe_ctx *pipe_ctx);
 
 void hwss_add_opp_set_disp_pattern_generator(struct block_sequence_state *seq_state,
 		struct output_pixel_processor *opp,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index e3fa987304da..925d80d956d8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -27,6 +27,13 @@
 
 #include "dm_services_types.h"
 
+/* ABM engine type a panel is driven by. */
+enum abm_feature_support {
+	ABM_FEATURE_NO_SUPPORT = 0,
+	ABM_LCD_SUPPORT = 1,
+	ABM_CACP_SUPPORT = 2,
+};
+
 struct abm_save_restore;
 
 struct abm {
@@ -66,7 +73,8 @@ struct abm_funcs {
 			unsigned int otg_inst,
 			unsigned int option,
 			unsigned int panel_inst,
-			unsigned int pwrseq_inst);
+			unsigned int pwrseq_inst,
+			enum abm_feature_support feature_support);
 	bool (*set_abm_event)(struct abm *abm, unsigned int full_screen, unsigned int trans_info,
 			unsigned int hdr_mode, unsigned int scaling_enable, unsigned int scaling_strength_map,
 			unsigned int panel_inst);
-- 
2.43.0


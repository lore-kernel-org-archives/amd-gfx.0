Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EFDC5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 980DF10EC90;
	Tue, 11 Aug 2026 15:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hElkOxL8";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E8F10EC90
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPS/6LOP52PUT8mMRgsAbJ6k/6QVzE9ZZngXQJoQSLGyAL6unz4zeA3Cuditbkqod237sRMetMzt5ya8ubOF3bwQpOsDewzY1rZyylr1kqKDJ+KPfUnZ/ZKPXUTwl56h9lRAUJIf15NZXD8P72qoFLyE8ivs/5+JoEcF8M0TXDYTdIvWmBTYRprnndq3emEWhKZjLZT8c+suP2YLxvB9Fqp9h10FipO5uPb6RhYR+ewJ98whKwuAeqYurUwT/jrOPeoTX+KQAkffffdY5VC77i5ks0n4jjMbKz3SDuzPhqfy/jBBLXcEyXncwRovKAnjR7ztT/ftXmt3EpuYfxqcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPskHRLerjsljkqwLZQJPQXyPSlTT9toWt9IKCEzOIM=;
 b=jEnP1oHHFnMdI9vjuraKwGFTG8hbm1WZJ70LCMi5hyfJixqtIhpNkiJREu3mbHyqHucguu2ZMGVUXgbDuZrFhzooEuWo9nSE6567mEJrKHgmuD/d2leOOY3aVtPwnJavYvDi6C2pHwMiORu2cJK9pkiVtQONjoG05x/Xz4A5tQ55yOwUAVOklvxlB7r6L8rFp022zH9iuV5SYUJKgLdCHCUMZw46o7c+HeBRt/WMm0w4315HU7/0WtOCkxgIPuP6HXoaTNNADRgfu3qem5HmJIul+V+vIlnA1GBaYz4mOAkrrFJB0iL7Aj6Xjxh9HCZzvot/6UmteoOjsoDVe2m/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPskHRLerjsljkqwLZQJPQXyPSlTT9toWt9IKCEzOIM=;
 b=hElkOxL8DEgBEEs0Ll5OAkAA/wJBy5t9AH645uKRzqL0Hds6+vXYziHIBq1T7NjgdQFGdrbHOf8JnrLdtXp03KCPGir9SbVcxkU8SlRfVD/amJjzXTGTRr1dzhcEkAb9588BPmPyBIaBZtG8XiqA5Bkl4da7sxqNxUfWJ+21vPg=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 15:49:42 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::5f) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:49:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:41 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:49:32 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 10/24] drm/amd/display: Refactor HUBP_WAIT_FOR_DCC_META_PROP
 to drop pipe_ctx
Date: Tue, 11 Aug 2026 05:28:44 +0800
Message-ID: <20260810213010.1703162-11-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6b63bd-bdb4-47ac-f88f-08def7c02881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wqZtctD/NYi/18xym8y5bvakHfkXAuhUxCdahZQcsFG7PwOtLLPkV94cD271BuIcH6tfd9x5tsmtzju48mtVfk+gz6pQ4V42S9VCMTKXPk9DYTjXrA1SFydjqrYskiKhOeQFyy+7KssjcwB+9ebwS7ZyUxW0pB5AD3lK7emxQwf20Bj8SWtQ4DY7qXVTPiO0D3rZ/KVUGU2SOAGD71rC+pC2RN5rLy9DPTpv8XT8tAgDtuI4VukynrjS7sVHwcU0LBZe1gHdt1sRbVYzVdvyhsHWA5s8+jRXMJzFVdVAcORSQ6l1U2Oa+HVEwoHYKU5O1sJNSHRH/FCRmZ/6y8/apWzrp8PUqOgC/gIOR2jnckiKki4mEoBK4KJskHmJduLGbdsMqyV7gThZ5bkrP/ZJxF99Oa0po1YorwWgXTbRHciyfS/ihq82CLethivJuKXbQeP6EXRgJAEiPUd+uobK0w2CSaQ8fsSH8voeLkkK6Vt/PBgAjcLhWBLT+HrkXndAF/W9qpKh4qgElWRq1gVeHo0+o5MNgIgg23K+27ZOHFS1eQG38YjEKMmIaLO7KNJdKYdMb454BdAH2NFijSKjG+v2RTcvtUnOAsAD2HnrVYBZbryEk7VysneGAzxZSMMwzwliv89ZdVaUz2+3Qn5TXAAOySZl7t4yG6ofbUv8q8+wrZb1P+lrVPkj6lgtWjEG7XhxAG0RLZY+gmQMIrBscg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NplTNso/coEzmec/14BtPNQQb7uNYXLWInoM5PIsSHT7SEsdQshfaubqhCfkqqpcqhsG52xDDxVuz0QQy3MKkB94wEveQlpH1owP6aDYR4JE/0ke3zLbqzrzbzWwfHEgga5p0OA8uQW0KwgbShG6igrZOATabk0w7H8BOuM0tqhBUVV6O6wIZp2lPmFdy5H3bf90yKCWwR+9BheFz03ZvD26FFH5hO7QpmlLUeO7o16VK9J6tdvH814/PVv19s1X3giMQzP9yStJE8hVIGcy9vfRswuxXcszkEim86aTtKJ9q9QuPQ/SokDI7IC0CwX9yUMkknvdPovDv+yzEynQoQ4E1m6Sh8Ulz7I20BBhDMiCIaqskiV7SvaybJqw4OkN+M0ZAOLp0Twp5m/BTv14YR/IEJbADj5MTzaSfu7KgUnPniMMnOEC5vF0TvwQ/e0z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:49:41.8159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6b63bd-bdb4-47ac-f88f-08def7c02881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[why]
Pipe_ctx shouldn't be passed as block sequence block parameter.

[how]
Precalculate delay during building stage instead during execution.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 47 +++++++++++--------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 24 ++--------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 11 ++---
 5 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bc2207d29954..6f7b715d4717 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4967,9 +4967,7 @@ static void commit_planes_for_stream(struct dc *dc,
 						top_pipe_to_program->stream_res.tg);
 		}
 
-	if (dc->hwss.wait_for_dcc_meta_propagation) {
-		dc->hwss.wait_for_dcc_meta_propagation(dc, top_pipe_to_program);
-	}
+	hwss_hubp_wait_for_dcc_meta_prop(dc, top_pipe_to_program);
 
 	if (dc->hwseq->funcs.wait_for_pipe_update_if_needed)
 		dc->hwseq->funcs.wait_for_pipe_update_if_needed(dc, top_pipe_to_program, update_type < UPDATE_TYPE_FULL);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index bfb598a22c26..a8ff59f619c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1142,6 +1142,22 @@ void hwss_build_post_unlock_full_sequence(struct dc *dc,
 	}
 }
 
+static uint32_t get_dcc_meta_propagation_delay(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	/* check if any surfaces are updating address while using flip immediate and dcc */
+	while (pipe_ctx != NULL) {
+		if (pipe_ctx->plane_state &&
+				pipe_ctx->plane_state->dcc.enable &&
+				pipe_ctx->plane_state->flip_immediate &&
+				pipe_ctx->plane_state->update_bits.addr_update) {
+			return dc->debug.dcc_meta_propagation_delay_us;
+		}
+		/* check next pipe */
+		pipe_ctx = pipe_ctx->bottom_pipe;
+	}
+	return 0;
+}
+
 void hwss_build_fast_sequence(struct dc *dc,
 		struct dc_dmub_cmd *dc_dmub_cmd,
 		unsigned int dmub_cmd_count,
@@ -1165,8 +1181,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 		return;
 
 	if (dc->hwss.wait_for_dcc_meta_propagation) {
-		block_sequence[*num_steps].params.wait_for_dcc_meta_propagation_params.dc = dc;
-		block_sequence[*num_steps].params.wait_for_dcc_meta_propagation_params.top_pipe_to_program = pipe_ctx;
+		block_sequence[*num_steps].params.wait_for_dcc_meta_propagation_params.delay = get_dcc_meta_propagation_delay(dc, pipe_ctx);
 		block_sequence[*num_steps].func = HUBP_WAIT_FOR_DCC_META_PROP;
 		(*num_steps)++;
 	}
@@ -1756,9 +1771,7 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_subvp_save_surf_addr(params);
 			break;
 		case HUBP_WAIT_FOR_DCC_META_PROP:
-			dc->hwss.wait_for_dcc_meta_propagation(
-					params->wait_for_dcc_meta_propagation_params.dc,
-					params->wait_for_dcc_meta_propagation_params.top_pipe_to_program);
+			dc->hwss.wait_for_dcc_meta_propagation(params->wait_for_dcc_meta_propagation_params.delay);
 			break;
 		case DMUB_HW_CONTROL_LOCK_FAST:
 			dc->hwss.dmub_hw_control_lock_fast(params);
@@ -2471,21 +2484,6 @@ void hwss_add_dmub_subvp_save_surf_addr(struct block_sequence_state *seq_state,
 	}
 }
 
-/*
- * Helper function to add HUBP wait for DCC meta propagation to block sequence
- */
-void hwss_add_hubp_wait_for_dcc_meta_prop(struct block_sequence_state *seq_state,
-		struct dc *dc,
-		struct pipe_ctx *top_pipe_to_program)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.wait_for_dcc_meta_propagation_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.wait_for_dcc_meta_propagation_params.top_pipe_to_program = top_pipe_to_program;
-		seq_state->steps[*seq_state->num_steps].func = HUBP_WAIT_FOR_DCC_META_PROP;
-		(*seq_state->num_steps)++;
-	}
-}
-
 /*
  * Helper function to add HUBP wait pipe read start to block sequence
  */
@@ -6189,3 +6187,12 @@ void get_refresh_rate_confirm_color(struct pipe_ctx *pipe_ctx, struct tg_color *
 		pipe_ctx->visual_confirm_color.color_b_cb = (uint16_t)color_value;
 	}
 }
+
+void hwss_hubp_wait_for_dcc_meta_prop(struct dc *dc, struct pipe_ctx *top_pipe_to_program)
+{
+	if (dc->hwss.wait_for_dcc_meta_propagation) {
+		uint32_t delay = get_dcc_meta_propagation_delay(dc, top_pipe_to_program);
+		dc->hwss.wait_for_dcc_meta_propagation(delay);
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f20a7b99d20c..42b2fbb8a4ae 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1333,28 +1333,10 @@ bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	return true;
 }
 
-void dcn401_wait_for_dcc_meta_propagation(const struct dc *dc,
-		const struct pipe_ctx *top_pipe)
+void dcn401_wait_for_dcc_meta_propagation(uint32_t delay)
 {
-	bool is_wait_needed = false;
-	const struct pipe_ctx *pipe_ctx = top_pipe;
-
-	/* check if any surfaces are updating address while using flip immediate and dcc */
-	while (pipe_ctx != NULL) {
-		if (pipe_ctx->plane_state &&
-				pipe_ctx->plane_state->dcc.enable &&
-				pipe_ctx->plane_state->flip_immediate &&
-				pipe_ctx->plane_state->update_bits.addr_update) {
-			is_wait_needed = true;
-			break;
-		}
-
-		/* check next pipe */
-		pipe_ctx = pipe_ctx->bottom_pipe;
-	}
-
-	if (is_wait_needed && dc->debug.dcc_meta_propagation_delay_us > 0) {
-		udelay(dc->debug.dcc_meta_propagation_delay_us);
+	if (delay > 0) {
+		udelay(delay);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 69c7dc73a29a..2e3392c963d0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -57,8 +57,7 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx);
 
 bool dcn401_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
-void dcn401_wait_for_dcc_meta_propagation(const struct dc *dc,
-		const struct pipe_ctx *top_pipe_to_program);
+void dcn401_wait_for_dcc_meta_propagation(uint32_t delay);
 
 void dcn401_prepare_bandwidth(struct dc *dc,
 		struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 129120ac6d9e..bf63281a8cd2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -182,8 +182,7 @@ struct subvp_save_surf_addr {
 };
 
 struct wait_for_dcc_meta_propagation_params {
-	const struct dc *dc;
-	const struct pipe_ctx *top_pipe_to_program;
+	uint32_t delay;
 };
 
 struct dmub_hw_control_lock_fast_params {
@@ -1654,8 +1653,7 @@ struct hw_sequencer_funcs {
 	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
 			const struct dc_state *cur_ctx,
 			const struct dc_state *new_ctx);
-	void (*wait_for_dcc_meta_propagation)(const struct dc *dc,
-		const struct pipe_ctx *top_pipe_to_program);
+	void (*wait_for_dcc_meta_propagation)(uint32_t delay);
 	void (*dmub_hw_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock);
@@ -2119,6 +2117,8 @@ void hwss_setup_periodic_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx);
 
 void hwss_disable_audio_stream(struct dc *dc, union block_sequence_params *params);
 
+void hwss_hubp_wait_for_dcc_meta_prop(struct dc *dc, struct pipe_ctx *top_pipe_to_program);
+
 void hwss_add_optc_pipe_control_lock(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx, bool lock);
 
@@ -2166,9 +2166,6 @@ void hwss_add_dmub_send_dmcub_cmd(struct block_sequence_state *seq_state,
 void hwss_add_dmub_subvp_save_surf_addr(struct block_sequence_state *seq_state,
 		struct dc_dmub_srv *dc_dmub_srv, struct dc_plane_address *addr, uint8_t subvp_index);
 
-void hwss_add_hubp_wait_for_dcc_meta_prop(struct block_sequence_state *seq_state,
-		struct dc *dc, struct pipe_ctx *top_pipe_to_program);
-
 void hwss_add_hubp_wait_pipe_read_start(struct block_sequence_state *seq_state,
 		struct hubp *hubp);
 
-- 
2.43.0


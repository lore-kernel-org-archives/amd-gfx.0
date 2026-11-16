Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A0606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dhSiVKql
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EE010F813;
	Tue, 17 Nov 2026 17:13:03 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7D310F813
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jpb1M8QniUQmcwHrhSaqZChTkfx6Fx2Azz+zsJLWv+vFQWdky084FEeXNJSDEXdnW+VpWBXix3KJ+Xj+yhAf224ZFCiqtyi1XeZwwGiD1p425X5adK1+dHshfJwCXrVQwA+iCgnHGejv1nPoMKWMzTxSbx9Tzat5p5zH8mU76/jzPzBUqSRKwdACvbk4rnoU5J1bUFT2aVxewlXKvnvZXMbgcvYrwToV2yTQUC/TAR5ISx10pvJqypA8cJxd5kPr4XeIiiaUV/44Ld669e9v/zKJdghclHFO8sEam7MC9eD+jVC5q1hG8pWubkvgzzZbKCQzz0+k8eSCGJ4UGhutDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bowRbtR5hSffehEKX5zpOYrBy3bt5ETxwoeHBYpAGJw=;
 b=YdewFSDjJrw1j9XTttZ4jPlhPMfPDt2MBLEuvSNtDOgW9DLfd73v9HVuXTs5N7MxvUZdzbfEqyC0JOgYtdY5FnCVH6JBQC/hX+Fx3pD8t3bBs+Jh0IyZnRfJ3iEcZrsalTnmkJ1ltiHVQNfdMdTepjuBa5p3d3522dT/CF/ufM5FreW+Abtu5xbf94w5pL0v0HdptbqgZniGlBYWUiQBrdrDYUxmlRfnXmIe8vFd8i6QzgoF+D0QHvaMwdEAQ5l+qpmBVVDwRfcAZ+Bgw7EEDalBf5fxXhPTJx/5U/KzHnEHN7cnphAcOpVSnfxxRZmEkms5DGbSsJqO7Fc65Vb9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bowRbtR5hSffehEKX5zpOYrBy3bt5ETxwoeHBYpAGJw=;
 b=dhSiVKqlVXsEl7U5LY+5JIIV+IA3BXZiGgvWqP580dxJS/chPHN7sjyt07Ovd9eH0Jzvp/U6PIo//R1kESt08k2BYRyR/QA/7zybLBIaQjbOnUv3b94Jgo10lyFnbclYWl42NP/PUz1CcAYl/YPbkaobHN4V2EUfubLaRm7vzM8=
Received: from MW4PR04CA0074.namprd04.prod.outlook.com (2603:10b6:303:6b::19)
 by PH8PR12MB999298.namprd12.prod.outlook.com (2603:10b6:510:40b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:12:54 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::46) by MW4PR04CA0074.outlook.office365.com
 (2603:10b6:303:6b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:12:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:12:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:52 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:12:43 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Shen <george.shen@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 05/33] drm/amd/display: Refactor DP retrain link HW sequence
Date: Tue, 17 Nov 2026 05:50:42 +0800
Message-ID: <20261116215641.2800595-6-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH8PR12MB999298:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc90f60-2142-430e-85b4-08df44ce045e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: BNn0GvwqU3BXHCEhaLPin6GXjWiJfGDfziRMbLlEPqcvX21iqCV57xx44ftxLENG+caaZRxE3ZcrOEY5uWpr7rOlwAT1d1Rjv9iE908D6uHjKOw5xdsHWs9+13ngGzZVJQ4W5+tWYRYWlGghrtBj8Mq7TQKuCBGJDiwXTn3a63XssvCDyTmwoLHG5kD6r1hx+SeMusUL5qOvxc+drz9CZLZbkOitacBjStCpRv6AYAT4i90Ay0ZyrjM1+XqEPLviP20xQHMgjiMXf4VEensmQM47rRWfdxmQhwvOXvLRW2zFCUaI6UjF6z+W+mDp3gsB8CYJCU2J+RyMkx/wQ1XsoyTU2C5dxF4t3UGvu2R3JDFl99T5CEtqK1Xyi0rgW4SuBu933y4NW1gr1zELL8hasHbpIBFXqXVqyJLmHkTAeUJyX8Nuxjy2Ok61isY/1VNY/PvH4C8j5mNL0OV1q5QZT6CnAsV6mDEoNvhH3OqxYBUISEsgRpGHWYK9CoF+tVWzbPV6nQSirmdALO98ZRnRIy+JiW1YFg7F7s6/n7nZ2YG3ObNQ+2j23x9wwpj+/Gwp1hELIi9q1mOR0icQziLFH5Vk0TWJ7I98h+82EqXm2e7KkXbB92kPciIR2zI1A97vL5gUb214J6E9fiw+JSPLe9E4gEgEp9mqUAcpwJULUmnih4U38DVE3MFFg8MhTLpu7dWzUGxapMoE/r/SOo/F0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aYNSX8zE1bzBvSfedTj577UhewABYrqbIvBETq+izUiGesom6iUTbpEVDjp0zYroOABpJfUPDuIMIc7NfMrtk3/dbSRBD9t4OuMifCTj3LXSs/bVsR1baR0X8ni17yWtPZzJOpNVsGp8jJv6NH4qecyw1ZuU2cnst5Ehhd+WpPaW6fxvW6Dinr6CRhyFwX9RW3aNVqJ/8/QrSJL9mKpUm8ToB7zgoMxQS37A0EqmrdCxwagCGKC3M6j1mP269VcnP5v8GnyDeE7LpZB/CG9rnvYyW3ZO7k6aeW2we8P3fLlK3vPD2xhlI20lyQMF5vYxepXKrRFKrB8OlyGpQYYrMuYguIu+AbEpW3EH4D8kWUcKpWnmyVds41hpdTOWoTtdQT7NXZVZAYtSsd7ZWo7HF4uUZYbOsJ5z2pKWNtzec23KKLV5HbbM9Vjy6k1UhBYn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:12:53.5921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc90f60-2142-430e-85b4-08df44ce045e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999298
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Shen <george.shen@amd.com>

[Why]
Current implementation of DP retrain link test function contains an
issue where ODM combine is cleared and not reconfigured when we toggle
off/on OTG.

The function is also rigid and difficult to maintain when all the HW
programming logic is done directly within it.

[How]
Move HW programming calls to a hwss function and call it from the DP
retrain link function.

Additionaly, add a call to reprogram the ODM combine register that is
cleared when disabling OTG in the hwss function call.

Cc: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 84 +++++++++++++++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  8 ++
 .../display/dc/link/accessories/link_dp_cts.c | 39 ++-------
 3 files changed, 98 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index ecf90e3a770c..061ea11cef0e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -3195,6 +3195,90 @@ void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *c
 	hwss_wait_for_all_blank_complete(dc, context);
 }
 
+/**
+ * hwss_restart_otg_for_dp_test_link_retrain - restart the OTGs of a link retrained
+ * by a DP test request, with the stream's planes left attached
+ *
+ * Disables the OTGs, programs the pixel clock and audio if requested, restores
+ * the ODM combine configuration cleared by disable_crtc, then re-enables the
+ * OTGs. The caller must have already turned DPMS off and updated the stream and
+ * link resources in @context for the new link settings.
+ *
+ * @dc: [in] dc reference
+ * @context: [in] hardware context in use
+ * @otg_masters: [in] OTG master pipes of the streams being retrained
+ * @otg_master_count: [in] number of entries in @otg_masters
+ * @program_pix_clk: [in] program pixel clock and audio, needed when the link encoding changes
+ * @audio_output: [in] audio output per OTG master, used if @program_pix_clk
+ */
+void hwss_restart_otg_for_dp_test_link_retrain(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx **otg_masters,
+		uint8_t otg_master_count,
+		bool program_pix_clk,
+		struct audio_output *audio_output)
+{
+	int i;
+
+	// TODO: Confirm with HW docs if disable/re-enable is actually required here
+	for (i = 0; i < otg_master_count; i++)
+		otg_masters[i]->stream_res.tg->funcs->disable_crtc(otg_masters[i]->stream_res.tg);
+
+	if (program_pix_clk) {
+		for (i = 0; i < otg_master_count; i++) {
+			struct pipe_ctx *pipe = otg_masters[i];
+			struct audio *audio = pipe->stream_res.audio;
+
+			if (pipe->stream_res.pix_clk_params.controller_id != CONTROLLER_ID_UNDEFINED)
+				pipe->clock_source->funcs->program_pix_clk(
+						pipe->clock_source,
+						&pipe->stream_res.pix_clk_params,
+						dc->link_srv->dp_get_encoding_format(&pipe->link_config.dp_link_settings),
+						&pipe->pll_settings);
+
+			if (audio != NULL) {
+				const struct link_hwss *link_hwss = get_link_hwss(
+						pipe->stream->link, &pipe->link_res);
+
+				link_hwss->setup_audio_output(pipe, &audio_output[i], audio->inst);
+
+				audio->funcs->az_configure(
+						audio,
+						pipe->stream->signal,
+						&audio_output[i].crtc_info,
+						&pipe->stream->audio_info,
+						&audio_output[i].dp_link_info);
+
+				if (dc->config.disable_hbr_audio_dp2 &&
+						audio->funcs->az_disable_hbr_audio &&
+						dc->link_srv->dp_is_128b_132b_signal(pipe))
+					audio->funcs->az_disable_hbr_audio(audio);
+			}
+		}
+	}
+
+	for (i = 0; i < otg_master_count; i++) {
+		struct pipe_ctx *pipe = otg_masters[i];
+
+		/* disable_crtc cleared the ODM segment config */
+		if (pipe->next_odm_pipe) {
+			struct pipe_ctx *opp_heads[MAX_PIPES];
+			int opp_inst[MAX_PIPES] = {0};
+			int opp_head_count = resource_get_opp_heads_for_otg_master(pipe, &context->res_ctx, opp_heads);
+			int j;
+
+			for (j = 0; j < opp_head_count; j++)
+				opp_inst[j] = opp_heads[j]->stream_res.opp->inst;
+
+			pipe->stream_res.tg->funcs->set_odm_combine(pipe->stream_res.tg, opp_inst, opp_head_count,
+					resource_get_odm_slice_dst_width(pipe, false),
+					resource_get_odm_slice_dst_width(pipe, true));
+		}
+
+		pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+	}
+}
+
 void hwss_reset_unused_det(struct dc *dc, struct dc_state *context)
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index bfe9afb434af..c2e256a40128 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -66,6 +66,7 @@ struct link_training_settings;
 struct dc_link;
 struct dc_crtc_timing;
 struct dmub_srv_hw_params;
+struct audio_output;
 
 struct tg_lock_params {
 	struct dc *dc;
@@ -2316,6 +2317,13 @@ void hwss_wait_for_all_blank_complete(struct dc *dc,
 void hwss_wait_for_odm_update_pending_complete(struct dc *dc,
 		struct dc_state *context);
 
+void hwss_restart_otg_for_dp_test_link_retrain(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx **otg_masters,
+		uint8_t otg_master_count,
+		bool program_pix_clk,
+		struct audio_output *audio_output);
+
 void hwss_wait_for_no_pipes_pending(struct dc *dc,
 		struct dc_state *context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index f316337cee1b..2fe7ceff1f50 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -72,6 +72,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	struct dc_stream_update stream_update = { 0 };
 	bool dpms_off = false;
 	bool needs_divider_update = false;
+	bool program_pix_clk = false;
 	bool was_hpo_acquired = resource_is_hpo_acquired(link->dc->current_state);
 	bool is_hpo_acquired;
 	uint8_t count;
@@ -97,52 +98,24 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 				link->dc,
 				state,
 				pipes[i]);
-
-		// Disable OTG and re-enable after updating clocks
-		pipes[i]->stream_res.tg->funcs->disable_crtc(pipes[i]->stream_res.tg);
 	}
 
 	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
 				*pipes, &audio_output[0]);
-		for (i = 0; i < count; i++) {
-			pipes[i]->clock_source->funcs->program_pix_clk(
-					pipes[i]->clock_source,
-					&pipes[i]->stream_res.pix_clk_params,
-					link->dc->link_srv->dp_get_encoding_format(&pipes[i]->link_config.dp_link_settings),
-					&pipes[i]->pll_settings);
-
-			if (pipes[i]->stream_res.audio != NULL) {
-				const struct link_hwss *link_hwss = get_link_hwss(
-					link, &pipes[i]->link_res);
-
-				link_hwss->setup_audio_output(pipes[i], &audio_output[i],
-						pipes[i]->stream_res.audio->inst);
-
-				pipes[i]->stream_res.audio->funcs->az_configure(
-						pipes[i]->stream_res.audio,
-						pipes[i]->stream->signal,
-						&audio_output[i].crtc_info,
-						&pipes[i]->stream->audio_info,
-						&audio_output[i].dp_link_info);
-
-				if (link->dc->config.disable_hbr_audio_dp2 &&
-						pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio &&
-						link->dc->link_srv->dp_is_128b_132b_signal(pipes[i]))
-					pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio(pipes[i]->stream_res.audio);
-			}
-		}
+		program_pix_clk = true;
 	}
 
+	// Disable OTG, update clocks and re-enable OTG with its ODM configuration restored
+	hwss_restart_otg_for_dp_test_link_retrain(dc, state, pipes, count,
+			program_pix_clk, audio_output);
+
 	// Toggle on HPO I/O if necessary
 	is_hpo_acquired = resource_is_hpo_acquired(state);
 	if (was_hpo_acquired != is_hpo_acquired && link->dc->hwss.setup_hpo_hw_control)
 		link->dc->hwss.setup_hpo_hw_control(link->dc->hwseq, is_hpo_acquired);
 
-	for (i = 0; i < count; i++)
-		pipes[i]->stream_res.tg->funcs->enable_crtc(pipes[i]->stream_res.tg);
-
 	// Set DPMS on with stream update
 	// Cache all streams on current link since dc_update_planes_and_stream might kill current_state
 	for (i = 0; i < MAX_PIPES; i++) {
-- 
2.43.0


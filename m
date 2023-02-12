Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B41C636D4
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D720A10E2FB;
	Sun, 12 Feb 2023 17:00:48 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F0010E2EF
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPDfVS1qBaLClrJITljjm6mEy3+3USBnW+NaftnoXnyTvHytO2pF1JTvKDgS4YRzgC5kD5vjYA8D7DAR1O3QW1yJ+75LlpA8eSTb0hSGtaNsjZDb+cz9plIM/hPcVCM0HuU3V6fe3Yfda33mYOxJ4OcI0u1xkX9mODTunB8P4mngZ0Tv3quuT3b39Bdsa+UuKcv4LSps8jeIUT6ljCdI4WLt0vG+q8y1q7F4ka2DlOueQOfOQxJYx85ZMn8HqSnnOw8EmVKv1Xe4XzAucZpXMnFHgdJd1MtfsnxnsvBvC/OcKKiOW0/c9MrEjLHfGxMgaFCpMLbx/jY628fXKCgqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtslHaJ2D2CrkoXaprmNVCp1IacH8V0Upp2w22AjiqY=;
 b=enE8fVOHFJrMWwPygs4JnmbgKvKMWk36Lc/q26VAXKEoqb0zshLMm/E9rLuOQ4MtG+mTN7tFpTsff1HQqCp05QMZR0ODMFFFiiJ99QQTolUbHm9OTAev1cSrhh4J/ECVVGbSdyYDKvDAjfH9kcciAc3XwblCukNOY3E08Uc8b13QAUREr0aul3Qk3qGShV8QDVSSIISpN3IvfsEdYwTuEyY1LGM3h7z8v+eIYw5a0wbVIImWmEPEQsjsHMg299vcE4WsOc7HTBJ/UPRpMAGlBn+WbdslpbRLcsqtW7dKRuUXVbyT2++F8QN0jbrbWqZJDUX3ZAAk0VPGNTvVgELKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtslHaJ2D2CrkoXaprmNVCp1IacH8V0Upp2w22AjiqY=;
 b=pKknJsIRyiN6j0hkuk5UcjNQ4GbtFm00G1LInrRgi9b7cygAGNinOWsK2F19zXo9iir/knWbXqtHFhkHbvbWn93hxIiYpDIUXz9IC6qsfIYXMzdl71yYNWk1VvFPhjdWHRNxnlEAGua+HbSKVa9I7NV42SuiEHSgRpWcMEgJGQs=
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:43 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::66) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:41 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:39 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/22] drm/amd/display: on dp link lost event toggle dpms for
 master pipe only
Date: Sun, 12 Feb 2023 11:59:43 -0500
Message-ID: <20230212165955.1993601-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a35134-86ae-4dbd-562e-08db0d1aad10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IbooDEWhGYGEC7HYihY+9SbkvQdc+Pbf3WfaympxZwipdP3cvext0A2Oxjhn2XrdKaEOu7LmdCRW0pDtgMG+iaxE163RbW8zBdfpIVuGc3vxOtjDLnBSu/hp1Of0eWavg/aJHfXYjyjOswlh6uQYkCT6/tXccNKdrZwpa16/o8K55SiITXNj3JqZYlX/wiau2JO/hxO6zaveTQCL5cqoW/mTzjTkVgrAk56hFaoZ/6C2ngplJRZ5kiLdUIL5VOCczp6NJ2EOVqEfIo2ZCmtUllsBNaVVk7YucbEtyawmNG3UalxF5ZUp6XYJX31EYcWSghkaR8Z694afDuXqZx/WYr6GAdgr2I8e+2oAJMr9HkxGtM2lmEEBBLi4Mcediq6RiR/eKkTGLVwWetIa4hrkbWtCeUO2M2YAJHgL6w3JMe3OllB2sZMc4OsAnaVzp/UX8W1i9nG33YXIrgX+UKY15mNObjO4Tz8+bVRYVZTuxrs/cPU5um2D/RdQdxtmnUPDLfD6YkDhxFQUTz213oVOK0iEH4bgBc3zdCnL6Fwe1JBNc4f7ZAcGsLyP6n/487PxHFu9Rc0amoIamVuBNXIV+IiLERMd9GvxWX7wZ7cglJiZ28EEPtryYX6m81AT1K5ARLIpWFxTtHR/kaM6gYYGYQZ8+tq7hQoJgaMGrG2sAMeqUuwqQb+ZPlbtQytbziN9qxt7ZAM0JnvwUCLeoFyYXChqv7VpXfKIDdTfN5toE28=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(70206006)(70586007)(83380400001)(54906003)(316002)(8676002)(6916009)(5660300002)(8936002)(4326008)(41300700001)(478600001)(6666004)(16526019)(186003)(26005)(47076005)(426003)(336012)(2616005)(356005)(1076003)(36756003)(40480700001)(82310400005)(86362001)(2906002)(44832011)(30864003)(36860700001)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:42.6115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a35134-86ae-4dbd-562e-08db0d1aad10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
We mistakenly toggle dpms state for non master pipe when handling
link lost. A non master pipe doesn't connect to a backend. So it is
toggling dpms for non master is undefined and caused NULL pointer
dereference.

[how]
Add helper functions to find an array of active master pipes for current
link and only toggle DPMS for active master pipes connected to the link.
Add assert in case we get called to program dpms with non master pipe.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../display/dc/link/accessories/link_dp_cts.c | 42 +++++------
 .../drm/amd/display/dc/link/link_detection.c  | 31 +--------
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 69 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |  5 ++
 .../dc/link/protocols/link_dp_irq_handler.c   | 46 +++++--------
 5 files changed, 108 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 769b782a9b84..ee290ec247de 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -27,6 +27,7 @@
 #include "link/protocols/link_dp_training.h"
 #include "link/protocols/link_dp_phy.h"
 #include "link/protocols/link_dp_training_fixed_vs_pe_retimer.h"
+#include "link/link_dpms.h"
 #include "resource.h"
 #include "dm_helpers.h"
 #include "dc_dmub_srv.h"
@@ -77,37 +78,26 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			struct dc_link_settings *link_setting,
 			bool skip_video_pattern)
 {
-	struct pipe_ctx *pipe;
-	unsigned int i;
+	struct pipe_ctx *pipes[MAX_PIPES];
+	struct dc_state *state = link->dc->current_state;
+	uint8_t count;
+	int i;
 
 	udelay(100);
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe->stream != NULL &&
-				pipe->stream->link == link &&
-				!pipe->stream->dpms_off &&
-				!pipe->top_pipe && !pipe->prev_odm_pipe) {
-			link_set_dpms_off(pipe);
-			pipe->link_config.dp_link_settings = *link_setting;
-			update_dp_encoder_resources_for_test_harness(
-					link->dc,
-					pipe->stream->ctx->dc->current_state,
-					pipe);
-		}
-	}
+	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe->stream != NULL &&
-				pipe->stream->link == link &&
-				!pipe->stream->dpms_off &&
-				!pipe->top_pipe && !pipe->prev_odm_pipe) {
-			link_set_dpms_on(
-					pipe->stream->ctx->dc->current_state,
-					pipe);
-		}
+	for (i = 0; i < count; i++) {
+		link_set_dpms_off(pipes[i]);
+		pipes[i]->link_config.dp_link_settings = *link_setting;
+		update_dp_encoder_resources_for_test_harness(
+				link->dc,
+				state,
+				pipes[i]);
 	}
+
+	for (i = count-1; i >= 0; i--)
+		link_set_dpms_on(state, pipes[i]);
 }
 
 static void dp_test_send_link_training(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 63e75c392031..001a4ac9bfcf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -30,6 +30,7 @@
  * directly from connected receivers.
  */
 
+#include "link_dpms.h"
 #include "link_detection.h"
 #include "link_hwss.h"
 #include "protocols/link_edp_panel_control.h"
@@ -755,34 +756,6 @@ static void restore_phy_clocks_for_destructive_link_verification(const struct dc
 	clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 }
 
-static void set_all_streams_dpms_off_for_link(struct dc_link *link)
-{
-	int i;
-	struct pipe_ctx *pipe_ctx;
-	struct dc_stream_update stream_update;
-	bool dpms_off = true;
-	struct link_resource link_res = {0};
-
-	memset(&stream_update, 0, sizeof(stream_update));
-	stream_update.dpms_off = &dpms_off;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
-			stream_update.stream = pipe_ctx->stream;
-			dc_commit_updates_for_stream(link->ctx->dc, NULL, 0,
-					pipe_ctx->stream, &stream_update,
-					link->ctx->dc->current_state);
-		}
-	}
-
-	/* link can be also enabled by vbios. In this case it is not recorded
-	 * in pipe_ctx. Disable link phy here to make sure it is completely off
-	 */
-	dp_disable_link_phy(link, &link_res, link->connector_signal);
-}
-
 static void verify_link_capability_destructive(struct dc_link *link,
 		struct dc_sink *sink,
 		enum dc_detect_reason reason)
@@ -796,7 +769,7 @@ static void verify_link_capability_destructive(struct dc_link *link,
 	if (dc_is_dp_signal(link->local_sink->sink_signal)) {
 		struct dc_link_settings known_limit_link_setting =
 				dp_get_max_link_cap(link);
-		set_all_streams_dpms_off_for_link(link);
+		link_set_all_streams_dpms_off_for_link(link);
 		dp_verify_link_cap_with_retries(
 				link, &known_limit_link_setting,
 				LINK_TRAINING_MAX_VERIFY_RETRY);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 47a9adb680a9..3ab7bab2fed9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -141,12 +141,76 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 	}
 }
 
+void link_set_all_streams_dpms_off_for_link(struct dc_link *link)
+{
+	struct pipe_ctx *pipes[MAX_PIPES];
+	struct dc_state *state = link->dc->current_state;
+	uint8_t count;
+	int i;
+	struct dc_stream_update stream_update;
+	bool dpms_off = true;
+	struct link_resource link_res = {0};
+
+	memset(&stream_update, 0, sizeof(stream_update));
+	stream_update.dpms_off = &dpms_off;
+
+	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
+
+	for (i = 0; i < count; i++) {
+		stream_update.stream = pipes[i]->stream;
+		dc_commit_updates_for_stream(link->ctx->dc, NULL, 0,
+				pipes[i]->stream, &stream_update,
+				state);
+	}
+
+	/* link can be also enabled by vbios. In this case it is not recorded
+	 * in pipe_ctx. Disable link phy here to make sure it is completely off
+	 */
+	dp_disable_link_phy(link, &link_res, link->connector_signal);
+}
+
 void link_resume(struct dc_link *link)
 {
 	if (link->connector_signal != SIGNAL_TYPE_VIRTUAL)
 		program_hpd_filter(link);
 }
 
+/* This function returns true if the pipe is used to feed video signal directly
+ * to the link.
+ */
+static bool is_master_pipe_for_link(const struct dc_link *link,
+		const struct pipe_ctx *pipe)
+{
+	return (pipe->stream &&
+			pipe->stream->link &&
+			pipe->stream->link == link &&
+			pipe->top_pipe == NULL &&
+			pipe->prev_odm_pipe == NULL);
+}
+
+/*
+ * This function finds all master pipes feeding to a given link with dpms set to
+ * on in given dc state.
+ */
+void link_get_master_pipes_with_dpms_on(const struct dc_link *link,
+		struct dc_state *state,
+		uint8_t *count,
+		struct pipe_ctx *pipes[MAX_PIPES])
+{
+	int i;
+	struct pipe_ctx *pipe = NULL;
+
+	*count = 0;
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &state->res_ctx.pipe_ctx[i];
+
+		if (is_master_pipe_for_link(link, pipe) &&
+				pipe->stream->dpms_off == false) {
+			pipes[(*count)++] = pipe;
+		}
+	}
+}
+
 static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 		enum engine_id eng_id,
 		struct ext_hdmi_settings *settings)
@@ -2177,6 +2241,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->sink->link;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
 
+	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
+
 	if (link_is_dp_128b_132b_signal(pipe_ctx))
 		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
 
@@ -2281,6 +2347,8 @@ void link_set_dpms_on(
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 
+	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
+
 	if (link_is_dp_128b_132b_signal(pipe_ctx))
 		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
 
@@ -2464,4 +2532,3 @@ void link_set_dpms_on(
 		set_avmute(pipe_ctx, false);
 	}
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
index 7ce0124ed7d1..33d312dabdb8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
@@ -32,4 +32,9 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx,
 struct fixed31_32 link_calculate_sst_avg_time_slots_per_mtp(
 		const struct dc_stream_state *stream,
 		const struct dc_link *link);
+void link_set_all_streams_dpms_off_for_link(struct dc_link *link);
+void link_get_master_pipes_with_dpms_on(const struct dc_link *link,
+		struct dc_state *state,
+		uint8_t *count,
+		struct pipe_ctx *pipes[MAX_PIPES]);
 #endif /* __DC_LINK_DPMS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index eff23b7b324a..9d80427520cf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -34,6 +34,7 @@
 #include "link_dp_training.h"
 #include "link_dp_capability.h"
 #include "link/accessories/link_dp_trace.h"
+#include "link/link_dpms.h"
 #include "dm_helpers.h"
 
 #define DC_LOGGER_INIT(logger)
@@ -175,40 +176,27 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 
 void dc_link_dp_handle_link_loss(struct dc_link *link)
 {
+	struct pipe_ctx *pipes[MAX_PIPES];
+	struct dc_state *state = link->dc->current_state;
+	uint8_t count;
 	int i;
-	struct pipe_ctx *pipe_ctx;
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
-			break;
-	}
+	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
 
-	if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
-		return;
+	for (i = 0; i < count; i++)
+		link_set_dpms_off(pipes[i]);
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
-			link_set_dpms_off(pipe_ctx);
-	}
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off
-				&& pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
-			// Always use max settings here for DP 1.4a LL Compliance CTS
-			if (link->is_automated) {
-				pipe_ctx->link_config.dp_link_settings.lane_count =
-						link->verified_link_cap.lane_count;
-				pipe_ctx->link_config.dp_link_settings.link_rate =
-						link->verified_link_cap.link_rate;
-				pipe_ctx->link_config.dp_link_settings.link_spread =
-						link->verified_link_cap.link_spread;
-			}
-			link_set_dpms_on(link->dc->current_state, pipe_ctx);
+	for (i = count - 1; i >= 0; i--) {
+		// Always use max settings here for DP 1.4a LL Compliance CTS
+		if (link->is_automated) {
+			pipes[i]->link_config.dp_link_settings.lane_count =
+					link->verified_link_cap.lane_count;
+			pipes[i]->link_config.dp_link_settings.link_rate =
+					link->verified_link_cap.link_rate;
+			pipes[i]->link_config.dp_link_settings.link_spread =
+					link->verified_link_cap.link_spread;
 		}
+		link_set_dpms_on(link->dc->current_state, pipes[i]);
 	}
 }
 
-- 
2.25.1


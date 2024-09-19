Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2AFCF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAA810E75E;
	Thu, 19 Sep 2024 18:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nU5qA9eO";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD38F10E75D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKkNyUpWE77mz7elcjBifwx8emkuCEfet/wSXR9yjCsdkcmoYeljZI0qVyeKwHclMX6DlewlRV4Eub1gC2ku/a8XGa2gvbIj+FHgVhSA3gZ22qiMrAmkgcgA+G4OuTycQx/+MI7Xkc1ffnHWIBS8LPy3VvLqs24JQ7YBPxuqASKFd+VoKF6VYiTTy0x8cZ8Zqt8ibQo8F5OqMLrHSpTgXfEIh9bRpl3qWkaaz67HLUAUgcmitDdp+nlMv6c8Zlwiz82wXzcwUCFs0mEnJlk8ZRwl6PQYbruDYW8S8ig8yq2sjZxA2N0VXo9zmxw4DuthULRkL5gmeMpTYJzLTmQTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J/JMOzkXDT2X5aX9Jg4rVu0mydNzqvlbRna4Ft8tJ0=;
 b=Iv+L6xi/+t0njGvlGveJGXn1ZjngSOs1hVlTJ9iHLcZ5Pa3+Las2ga8z8vgfaRXgSmFAP4jOP/L+1FxUoZTNdeATD5sWM2Tup3pl9SaYnW9ZZ32C7EbMCxbjAm2FbkjnMFp/8FZiEuh18XeR4QJK/U2zFHHfm4mE3KtN3UYXAN6n82FjrKwWK4od9BRtMuOZIKlo2HYnmvRv7KuxvzmS6mN43zvXTzbEIYjVkAMkFhOxxYf2pwI2Fj0q8spE2WeSkRp8DSGxYVO7OGXL+bwmOPif+Clgu9kNxWQPkj24+m3APHhl7fWbVzHIjGQl1xz02D5k8bnZdhMY1jhIl+j6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J/JMOzkXDT2X5aX9Jg4rVu0mydNzqvlbRna4Ft8tJ0=;
 b=nU5qA9eO3dozvd7mvpwFVz1DjxZhHmAKLNmM2JqwqZgaCfyMdmiLfA3t5ns1TDXtY80TVKlPpGgrljB3SEK7CvYQw1y0qTCVcM4osK2I9FOqDaCtukxf3dCCFxc4RyweTbFsQfwSoPxRNoaM0zQnR60abaHsXD8k89Z7f3pm/BI=
Received: from MN0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::17)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Thu, 19 Sep
 2024 18:34:58 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::6a) by MN0P220CA0020.outlook.office365.com
 (2603:10b6:208:52e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:56 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 10/21] drm/amd/display: Set Pipe Unlock Order Outside of HWSEQ
Date: Thu, 19 Sep 2024 14:33:28 -0400
Message-ID: <20240919183435.1896209-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6d6a87-1d72-448d-629b-08dcd8d9c3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1n04hnJu1sajX+b9Il/o9PhEbpzpq1WaGrYALQpGzyBDrCKkHMG1Us25P+jX?=
 =?us-ascii?Q?6eB85i8F/g+wF/H9JWVWh6nCzxWgp9NMlrb6bGrBn3P+xQy+x1pXxqw10gt8?=
 =?us-ascii?Q?j59zXQb8josxU4HScfmkWIfkKifJ6v8p5oo2ZpM7XuPLqoSEP4EgfpPJHt18?=
 =?us-ascii?Q?w8WTNfZOXopTt+cXjQwaKNqHr+QKSJOU73/IgGH3ZnVUpHaXii/NB7WBwdVg?=
 =?us-ascii?Q?YFgK5RJ4Xy4WDVym1tu6RYUktysqAGEie96pzcjwRB4loq+f38F6+GqdxcUf?=
 =?us-ascii?Q?3GhXVsXtWUmI2Qp05l2kYhvpJjVVC2lG0JwouKA7S7xTyeL2qCoW+fWIAN5R?=
 =?us-ascii?Q?AV4s0qMmdPzi8UvHGSX5WmYs5wIvY4MjZC6tMDattgCnGKbOpQsaTlPJU5mI?=
 =?us-ascii?Q?UP8NVWosuuNKe62rOLTkRL0W13lraNLcrw9skQuS8yKVKcNqVuJ6Jtd9LHlS?=
 =?us-ascii?Q?Ckmj9NlFhVDIZm6jPlvMh/sfa8AJiUseX20yssNnE95FuzY55xdlfef2QWjM?=
 =?us-ascii?Q?Y3MrO8TIyjAxlsJKCu7WFLVU2ymOzFuB1L+8qGSbfmDn0j0Wc0ll5J7alrhe?=
 =?us-ascii?Q?V+OKoWJh3qLHTYm9iWE/Vu+NaYS/nVo24yAaVci/Vs+csyRJH9hb6+FOVZw0?=
 =?us-ascii?Q?Zsbq/e+rMZjfJUSQPeDkBiFNQEms6UubLkZI1oZqNJVUeg8TzHIacVbSwEcH?=
 =?us-ascii?Q?aTrg+xGAGHdqbiilK+dqYVI29X1oiJvez2cdMkV+IVqweJlibOOfHZTSMWjH?=
 =?us-ascii?Q?WqSpsDQh5eA8ruHuo05RvtIUuWUokXMdIlsd4z00L1yR4tiAT6LjFBHRZW6u?=
 =?us-ascii?Q?HzJP81USVN6aXCZzz2eIc7x04GT0k+beLS8OTilmExWQJ//GJ4oHHmJgOSlS?=
 =?us-ascii?Q?lfnEy6q74P4npQ2S6yTrbkzu822aL2wRiyJir3YmhYACKt0gYckJoq/daQ8e?=
 =?us-ascii?Q?teYkP0kd13X/0NyKVt/jlVWoTZ7t5FEzRmfBd5btywzVxl5WAthqf7JMYaW6?=
 =?us-ascii?Q?aOgzD+InstHnlR52fAf9b1SNaKTBTwRDDdX2XBpH6hEWEGhqV7GczU3XTOjn?=
 =?us-ascii?Q?DI7cYls16CII9ciKTaMdSvh4diT28Gd3k7ARtq5sCSFwKxecvGaqTT/NtXjI?=
 =?us-ascii?Q?S7LcQ931cglLsW30170ZAG49ZVE8McH99auDxsL89ORw34WpZx2Go6hZ+73j?=
 =?us-ascii?Q?hNoCuGAZQsqs0WFHpNYGNP3MsmkM8KM1sLaabyk7f03G1pCuKCZh86il3eOa?=
 =?us-ascii?Q?NaSP9G31mFmn4QMAMfVNTgJPQj0vfiP97gacZm81BYLoeCm4BW2G5AF17AIX?=
 =?us-ascii?Q?F5z5OGARLv2RMWMNSB6vbwBfSiNfrtTiq9kbOPItlacYCMwl5jxJufWnRt3Y?=
 =?us-ascii?Q?UtIZiQ87tOksSB8k+yMPPorsSsE68fEklT37tafbY0IMT2JZcgAoacp1V1HT?=
 =?us-ascii?Q?7ZCGKjzIhLTb4qejXPnzUT9Uzy/aRsww?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:58.4383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6d6a87-1d72-448d-629b-08dcd8d9c3d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Current pipe unlock order set within dcn401_interdependent_update_lock.
Separate the logic from the functionality to allow for unit testing
and make it easier to debug.

[How]
Add a flag to indicate if a pipe unlock order should be set.
Create function to determine unlock order.
Indicate which pipes should be unlocked first using
array stored in dc scratch memory.
Pipes indicated in array can be unlocked in any order.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 42 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 32 ++++++--------
 .../dc/resource/dcn401/dcn401_resource.c      |  1 +
 4 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 09fb04231250..98b94415e86c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1876,6 +1876,41 @@ void dc_z10_save_init(struct dc *dc)
 		dc->hwss.z10_save_init(dc);
 }
 
+/* Set a pipe unlock order based on the change in DET allocation and stores it in dc scratch memory
+ * Prevents over allocation of DET during unlock process
+ * e.g. 2 pipe config with different streams with a max of 20 DET segments
+ *	Before:								After:
+ *		- Pipe0: 10 DET segments			- Pipe0: 12 DET segments
+ *		- Pipe1: 10 DET segments			- Pipe1: 8 DET segments
+ * If Pipe0 gets updated first, 22 DET segments will be allocated
+ */
+static void determine_pipe_unlock_order(struct dc *dc, struct dc_state *context)
+{
+	unsigned int i = 0;
+	struct pipe_ctx *pipe = NULL;
+	struct timing_generator *tg = NULL;
+
+	if (!dc->config.set_pipe_unlock_order)
+		return;
+
+	memset(dc->scratch.pipes_to_unlock_first, 0, sizeof(dc->scratch.pipes_to_unlock_first));
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		tg = pipe->stream_res.tg;
+
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!tg->funcs->is_tg_enabled(tg) ||
+				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM) {
+			continue;
+		}
+
+		if (resource_calculate_det_for_stream(context, pipe) <
+				resource_calculate_det_for_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i])) {
+			dc->scratch.pipes_to_unlock_first[i] = true;
+		}
+	}
+}
+
 /**
  * dc_commit_state_no_check - Apply context to the hardware
  *
@@ -1974,6 +2009,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		context->streams[i]->update_flags.bits.dsc_changed = prev_dsc_changed;
 	}
 
+	determine_pipe_unlock_order(dc, context);
 	/* Program all planes within new context*/
 	if (dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
@@ -3625,6 +3661,10 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
 	bool should_offload_fams2_flip = false;
+	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
+
+	if (should_lock_all_pipes)
+		determine_pipe_unlock_order(dc, context);
 
 	if (dc->debug.fams2_config.bits.enable &&
 			dc->debug.fams2_config.bits.enable_offload_flip &&
@@ -3743,6 +3783,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	bool subvp_curr_use = false;
 	uint8_t current_stream_mask = 0;
 
+	if (should_lock_all_pipes)
+		determine_pipe_unlock_order(dc, context);
 	// Once we apply the new subvp context to hardware it won't be in the
 	// dc->current_state anymore, so we have to cache it before we apply
 	// the new SubVP context
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7b164e8fa104..d3b6a389fece 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -463,6 +463,7 @@ struct dc_config {
 	unsigned int enable_fpo_flicker_detection;
 	bool disable_hbr_audio_dp2;
 	bool consolidated_dpia_dp_lt;
+	bool set_pipe_unlock_order;
 };
 
 enum visual_confirm {
@@ -1461,6 +1462,7 @@ struct dc {
 		struct dc_scratch_space current_state;
 		struct dc_scratch_space new_state;
 		struct dc_stream_state temp_stream; // Used so we don't need to allocate stream on the stack
+		bool pipes_to_unlock_first[MAX_PIPES]; /* Any of the pipes indicated here should be unlocked first */
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0b743669f23b..29fcb4ed6646 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1705,7 +1705,6 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 	unsigned int i = 0;
 	struct pipe_ctx *pipe = NULL;
 	struct timing_generator *tg = NULL;
-	bool pipe_unlocked[MAX_PIPES] = {0};
 
 	if (lock) {
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1719,43 +1718,36 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 			dc->hwss.pipe_control_lock(dc, pipe, true);
 		}
 	} else {
-		/* Unlock pipes based on the change in DET allocation instead of pipe index
-		 * Prevents over allocation of DET during unlock process
-		 * e.g. 2 pipe config with different streams with a max of 20 DET segments
-		 *	Before:								After:
-		 *		- Pipe0: 10 DET segments			- Pipe0: 12 DET segments
-		 *		- Pipe1: 10 DET segments			- Pipe1: 8 DET segments
-		 * If Pipe0 gets updated first, 22 DET segments will be allocated
-		 */
+		/* Need to free DET being used first and have pipe update, then unlock the remaining pipes*/
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe = &context->res_ctx.pipe_ctx[i];
 			tg = pipe->stream_res.tg;
-			int current_pipe_idx = i;
 
 			if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
 					!tg->funcs->is_tg_enabled(tg) ||
 					dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM) {
-				pipe_unlocked[i] = true;
 				continue;
 			}
 
-			// If the same stream exists in old context, ensure the OTG_MASTER pipes for the same stream get compared
-			struct pipe_ctx *old_otg_master = resource_get_otg_master_for_stream(&dc->current_state->res_ctx, pipe->stream);
-
-			if (old_otg_master)
-				current_pipe_idx = old_otg_master->pipe_idx;
-			if (resource_calculate_det_for_stream(context, pipe) <
-					resource_calculate_det_for_stream(dc->current_state, &dc->current_state->res_ctx.pipe_ctx[current_pipe_idx])) {
+			if (dc->scratch.pipes_to_unlock_first[i]) {
 				dc->hwss.pipe_control_lock(dc, pipe, false);
-				pipe_unlocked[i] = true;
 				dcn401_wait_for_det_buffer_update(dc, context, pipe);
 			}
 		}
 
+		/* Unlocking the rest of the pipes */
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (pipe_unlocked[i])
+			if (dc->scratch.pipes_to_unlock_first[i])
 				continue;
+
 			pipe = &context->res_ctx.pipe_ctx[i];
+			tg = pipe->stream_res.tg;
+			if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+					!tg->funcs->is_tg_enabled(tg) ||
+					dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM) {
+				continue;
+			}
+
 			dc->hwss.pipe_control_lock(dc, pipe, false);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 9d56fbdcd06a..f2653a86d3e7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1867,6 +1867,7 @@ static bool dcn401_resource_construct(
 	dc->config.prefer_easf = true;
 	dc->config.dc_mode_clk_limit_support = true;
 	dc->config.enable_windowed_mpo_odm = true;
+	dc->config.set_pipe_unlock_order = true; /* Need to ensure DET gets freed before allocating */
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.46.0


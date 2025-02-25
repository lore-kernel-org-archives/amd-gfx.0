Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C2FC021BC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515AE10E55E;
	Tue, 25 Feb 2025 06:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGvuxt5/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBF810E549
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2tdU24tBJl14qhhkJQeJKCfyicRreA8gYE4cARvRGIcYCw4u8LuTwRI8e2yM8hh7MplwKNeFV/DinAELAr6+z1xlO+VySZCXNwvTGk0CX/SMnuw5uGJ1EGJwm4c4ocgWETDYF2G1EMPudV4oErELkO8TR4SEhcy9eAoTLFLIxEOJCgnoM39xpa3rFbvwFrO2z6xpLPDyLEpm3x9Q8ZwV8lbYaSmu23/PvyXKb3gJWJ93PEHEiWEKyi0V7B6kwe4RdmfjnwY/FsDwwxR5r+vz9UIEtoF9CnS/56h/bOcqASCq9kz4MrniXjd4T2qEGqP7Mr7a8FryNdTvpkrPGq5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYju0TDlmMLztjBqbi8cWlZ95CeSLKMmaL8wqqs9KRg=;
 b=az9tRIEFeDm1qPzSz6i3Jtv9TvkzNhMIvvQJOW/HLAvqaqDejksBGECM02+oqSDNbnZNWzCHfVeHEsTy3zvoTzCIaoUKgAORsnpqvIvs84thyhu17kHbTT2qRpevGH8y78NW2wptFuZoIogYu2Je6OJuI/azoB+LgWNBg18nfogu6X37HQDVaXlREzlzR1ImgFFi0GYgc7eodrHPYlxlFESNidTtMsbWvQrsMY6/m8zfZ8OkTbyDkPI7iU8pi0cUdc4ySeGeA41mjl4m/xEjWEAPkfGP7431dyoEZFZ8VY+m9fc0Nht5IHuRbavvzjWeVU92ue8rdekeTArbsQPiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYju0TDlmMLztjBqbi8cWlZ95CeSLKMmaL8wqqs9KRg=;
 b=bGvuxt5/m38MTQC6JLkM8vIFy94JvsTHg0QStlfra8J1zk7TQsGGpK9PXW+xglXreb5bioYptJ/FtBm+zsRrF6cDgb9Qovx8bESZqBHkcN0WkyPRKe7mPtNUI4lebvhInXpFRJ3VAgADcnUaVPTrVuxq7WYiNlW+qjafANVoYTs=
Received: from BL1PR13CA0381.namprd13.prod.outlook.com (2603:10b6:208:2c0::26)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 06:36:56 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::f2) by BL1PR13CA0381.outlook.office365.com
 (2603:10b6:208:2c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 06:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:36:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:36:55 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:36:50 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Cruise Hung
 <cruise.hung@amd.com>
Subject: [PATCH 05/27] drm/amd/display: misc for dio encoder refactor
Date: Tue, 25 Feb 2025 14:35:48 +0800
Message-ID: <20250225063610.631461-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b36f88-e786-4668-18ff-08dd5566cc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I/QhOiNkSxCRVMkh+m7JoIQx/PwxwllJA8Q7Gsbaqc3CuTNg6lG9yz3T4Rwg?=
 =?us-ascii?Q?GVeRLU2DPnnYYrk1ivPGRswMwHkZUSii5n4sEAgIgSCpu+Kyzk1/fzdE8flw?=
 =?us-ascii?Q?MkaBf4z8NFhIhVUe6B/Tt/77En5JN+c8BTj8XXuKFHL2fTU/5FpfoVcp0Ok0?=
 =?us-ascii?Q?ZFVTJdd7OLHBpqn7gC4iawLhZkKEuhZD38X2qdFzaCs6Dtsul23NkjfbFUfp?=
 =?us-ascii?Q?rLvm2cV1Cm7rjsJfyblJvIKXtOxumRk0O8+/icD0j7jA0zQVjm1FXWy/7oSu?=
 =?us-ascii?Q?jQkcchrvsW9hwPrSl3j6sSIMnxkCyfdmBy08qTDLcqq9DZGc5icy7T8VZrnu?=
 =?us-ascii?Q?gynyEdfZi/nWVfSJLgXazR1UEdMXlFEdNKWLr8y/Sg78RbaDQt8/NuruFbAI?=
 =?us-ascii?Q?S1autmm6o+a412ucoBwoLH2nVqpM4JAW5j9OB90Nx0aiSohZ9rHWrXHi4fmb?=
 =?us-ascii?Q?jrUzxzlqPAlItcfWzGTpL2FNkhQKv9a6Vsh4ZO9z1iRWoEQFRbbBufyRJ97N?=
 =?us-ascii?Q?UBbE9La4EcdkYS1bAucSW7kmsmDSC3FjUBkYj3a974fYtb3yJi5fiSkEydo7?=
 =?us-ascii?Q?KToA7fOz2t75AcgxZgr8bwHeXUSE42rgDLrNXdmQbQqJBOQN2c+sWJKaoeEW?=
 =?us-ascii?Q?87XEmy1+oFcBSB+RSm9pcI4uGV8WbKlkcuumSdHq6VkoMPaWFsaSLGsnoH9q?=
 =?us-ascii?Q?z1+aSYB9U86MAg17O/EVJQ5HRpPT5P/Z6D/bzoQldRzZvDHOivh27CH7IdgH?=
 =?us-ascii?Q?IhX7MhoccVDL2J0gKwLLcpdBUUjRmCtEDz18ai1W9linIXynnPU5R5VyveFq?=
 =?us-ascii?Q?VacahbdhKMv38fOE++Q9iYt5melp2zXmL9tf0J26pQ2qBvwZ0Xzoasb8kfyw?=
 =?us-ascii?Q?J1+onQyx5OWH6Tihvtz3I0swfPz34zIp61218ikHfrcLL26uv3wJzwXqM/VT?=
 =?us-ascii?Q?P/LHImEz7HGqGzjQp4G7mrqZ6iMddh0Ilzw01c8x4zdC67wfhm+TQw8L5CfL?=
 =?us-ascii?Q?9m2ntgBgP+A5SzWYJ6nej3/FatkCyz8DeinAb5ejgHrBfJXqNl24wwAHu7vj?=
 =?us-ascii?Q?kabVEFE5pXmKAUUBbUkQPj7Km3JFX6qFl3xmDGqq71uWqQxxSaHbHriWotNK?=
 =?us-ascii?Q?ikW59XTXzJkWX2zFQAQkbViwOz5K0G6OdAQxMnjafHLl5BOuNdqMzCwtdAfd?=
 =?us-ascii?Q?19lcPCliYzT17kNP75HP0MV9pGclPE+vWYSQ8iXCroyZBoCR/pcOLsK8vVfl?=
 =?us-ascii?Q?0mEC9pA4AJ5KNWPRGKJWuJ4wtHlQ3QXuEeCmJzLJvyfdY0V5dYlE/G8bMQ7f?=
 =?us-ascii?Q?ykTmrJqFchAK07J4FLn/eACnnSBQX5LsywKwG8WpZZRWC4xR2/8R1uwSd0SZ?=
 =?us-ascii?Q?ZBruHDRyMydPNtp7ZO4Ly0YIWIpqmVxMso55GUaoI0VXBROmR6NdOC/I24Vu?=
 =?us-ascii?Q?V4Am4SfTl/9G6VpQmtgTtg+g4xgrHlIbTJEepcbZYNN5OoeCnNps1BV5KSRm?=
 =?us-ascii?Q?e1CRdINz67lXim4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:36:56.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b36f88-e786-4668-18ff-08dd5566cc66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
These are left required changes for dio encoder refactor.

[HOW]
1. original logic is separated by config option
2. new link encoder dp enable/disable code for dcn35
3. process fec only for DP 8b10b encoding

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 20 ++++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  3 +-
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     | 50 +++++++++++++++++--
 .../dc/dio/dcn35/dcn35_dio_link_encoder.h     | 23 +++++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  3 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  5 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c | 40 +++++++--------
 .../drm/amd/display/dc/link/link_detection.c  |  5 +-
 .../dc/link/protocols/link_dp_training.c      |  3 +-
 .../dc/link/protocols/link_dp_training_dpia.c | 13 +++--
 12 files changed, 133 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index df29d28d89c9..af722519a1fa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -201,16 +201,26 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		struct pipe_ctx *pipe = safe_to_lower
 			? &context->res_ctx.pipe_ctx[i]
 			: &dc->current_state->res_ctx.pipe_ctx[i];
+		struct link_encoder *new_pipe_link_enc = new_pipe->link_res.dio_link_enc;
+		struct link_encoder *pipe_link_enc = pipe->link_res.dio_link_enc;
 		bool stream_changed_otg_dig_on = false;
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
+
+		if (!dc->config.unify_link_enc_assignment) {
+			if (new_pipe->stream)
+				new_pipe_link_enc = new_pipe->stream->link_enc;
+			if (pipe->stream)
+				pipe_link_enc = pipe->stream->link_enc;
+		}
+
 		stream_changed_otg_dig_on = old_pipe->stream && new_pipe->stream &&
 		old_pipe->stream != new_pipe->stream &&
 		old_pipe->stream_res.tg == new_pipe->stream_res.tg &&
-		new_pipe->stream->link_enc && !new_pipe->stream->dpms_off &&
-		new_pipe->stream->link_enc->funcs->is_dig_enabled &&
-		new_pipe->stream->link_enc->funcs->is_dig_enabled(
-		new_pipe->stream->link_enc) &&
+		new_pipe_link_enc && !new_pipe->stream->dpms_off &&
+		new_pipe_link_enc->funcs->is_dig_enabled &&
+		new_pipe_link_enc->funcs->is_dig_enabled(
+		new_pipe_link_enc) &&
 		new_pipe->stream_res.stream_enc &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled(new_pipe->stream_res.stream_enc);
@@ -226,7 +236,7 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 
 		if (!has_active_hpo && !dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe) &&
 					(pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
-					!pipe->stream->link_enc) && !stream_changed_otg_dig_on)) {
+					!pipe_link_enc) && !stream_changed_otg_dig_on)) {
 
 
 			/* This w/a should not trigger when we have a dig active */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a99ce7c86781..fe59649d3e15 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -905,7 +905,8 @@ void dc_stream_set_static_screen_params(struct dc *dc,
 static void dc_destruct(struct dc *dc)
 {
 	// reset link encoder assignment table on destruct
-	if (dc->res_pool && dc->res_pool->funcs->link_encs_assign)
+	if (dc->res_pool && dc->res_pool->funcs->link_encs_assign &&
+			!dc->config.unify_link_enc_assignment)
 		link_enc_cfg_init(dc, dc->current_state);
 
 	if (dc->current_state) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0bd3e7c072a1..1accc04f92e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4925,7 +4925,10 @@ bool pipe_need_reprogram(
 		return true;
 
 	/* DIG link encoder resource assignment for stream changed. */
-	if (pipe_ctx_old->stream->ctx->dc->res_pool->funcs->link_encs_assign) {
+	if (pipe_ctx_old->stream->ctx->dc->config.unify_link_enc_assignment) {
+		if (pipe_ctx_old->link_res.dio_link_enc != pipe_ctx->link_res.dio_link_enc)
+			return true;
+	} else if (pipe_ctx_old->stream->ctx->dc->res_pool->funcs->link_encs_assign) {
 		bool need_reprogram = false;
 		struct dc *dc = pipe_ctx_old->stream->ctx->dc;
 		struct link_encoder *link_enc_prev =
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index e8134c47fe0d..0478dd856d8c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -201,7 +201,8 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 	dc_stream_assign_stream_id(new_stream);
 
 	/* If using dynamic encoder assignment, wait till stream committed to assign encoder. */
-	if (new_stream->ctx->dc->res_pool->funcs->link_encs_assign)
+	if (new_stream->ctx->dc->res_pool->funcs->link_encs_assign &&
+			!new_stream->ctx->dc->config.unify_link_enc_assignment)
 		new_stream->link_enc = NULL;
 
 	kref_init(&new_stream->refcount);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
index ea0c9a9d0bd6..9972911330b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
@@ -137,9 +137,9 @@ static const struct link_encoder_funcs dcn35_link_enc_funcs = {
 	.hw_init = dcn35_link_encoder_init,
 	.setup = dcn35_link_encoder_setup,
 	.enable_tmds_output = dcn10_link_encoder_enable_tmds_output,
-	.enable_dp_output = dcn31_link_encoder_enable_dp_output,
-	.enable_dp_mst_output = dcn31_link_encoder_enable_dp_mst_output,
-	.disable_output = dcn31_link_encoder_disable_output,
+	.enable_dp_output = dcn35_link_encoder_enable_dp_output,
+	.enable_dp_mst_output = dcn35_link_encoder_enable_dp_mst_output,
+	.disable_output = dcn35_link_encoder_disable_output,
 	.dp_set_lane_settings = dcn10_link_encoder_dp_set_lane_settings,
 	.dp_set_phy_pattern = dcn10_link_encoder_dp_set_phy_pattern,
 	.update_mst_stream_allocation_table =
@@ -297,6 +297,50 @@ static void link_encoder_disable(struct dcn10_link_encoder *enc10)
 	REG_UPDATE(DP_LINK_CNTL, DP_LINK_TRAINING_COMPLETE, 0);
 }
 
+void dcn35_link_encoder_enable_dp_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	if (!enc->ctx->dc->config.unify_link_enc_assignment)
+		dcn31_link_encoder_enable_dp_output(enc, link_settings, clock_source);
+	else {
+		DC_LOG_DEBUG("%s: enc_id(%d)\n", __func__, enc->preferred_engine);
+		dcn20_link_encoder_enable_dp_output(enc, link_settings, clock_source);
+	}
+}
+
+void dcn35_link_encoder_enable_dp_mst_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	if (!enc->ctx->dc->config.unify_link_enc_assignment)
+		dcn31_link_encoder_enable_dp_mst_output(enc, link_settings, clock_source);
+	else {
+		DC_LOG_DEBUG("%s: enc_id(%d)\n", __func__, enc->preferred_engine);
+		dcn10_link_encoder_enable_dp_mst_output(enc, link_settings, clock_source);
+	}
+}
+
+void dcn35_link_encoder_disable_output(
+	struct link_encoder *enc,
+	enum signal_type signal)
+{
+	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
+
+	if (!enc->ctx->dc->config.unify_link_enc_assignment)
+		dcn31_link_encoder_disable_output(enc, signal);
+	else {
+		DC_LOG_DEBUG("%s: enc_id(%d)\n", __func__, enc->preferred_engine);
+		dcn10_link_encoder_disable_output(enc, signal);
+	}
+}
+
 void dcn35_link_encoder_enable_dpia_output(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
index f9d4221f4b43..5712e6553fab 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
@@ -144,6 +144,29 @@ bool dcn35_is_dig_enabled(struct link_encoder *enc);
 enum signal_type dcn35_get_dig_mode(struct link_encoder *enc);
 void dcn35_link_encoder_setup(struct link_encoder *enc, enum signal_type signal);
 
+/*
+ * Enable DP transmitter and its encoder.
+ */
+void dcn35_link_encoder_enable_dp_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source);
+
+/*
+ * Enable DP transmitter and its encoder in MST mode.
+ */
+void dcn35_link_encoder_enable_dp_mst_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source);
+
+/*
+ * Disable transmitter and its encoder.
+ */
+void dcn35_link_encoder_disable_output(
+	struct link_encoder *enc,
+	enum signal_type signal);
+
 /*
  * Enable DP transmitter and its encoder for dpia port.
  */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index f698062f1e90..288e9dd9205d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -621,7 +621,8 @@ void dcn31_reset_hw_ctx_wrap(
 	}
 
 	/* New dc_state in the process of being applied to hardware. */
-	link_enc_cfg_set_transient_mode(dc, dc->current_state, context);
+	if (!dc->config.unify_link_enc_assignment)
+		link_enc_cfg_set_transient_mode(dc, dc->current_state, context);
 }
 
 void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index 4a3578a9586e..b68bcc9fca0a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -328,7 +328,10 @@ static const struct link_hwss dio_link_hwss = {
 bool can_use_dio_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
-	return link->link_enc != NULL;
+	if (!link->dc->config.unify_link_enc_assignment)
+		return link->link_enc != NULL;
+	else
+		return link_res->dio_link_enc != NULL;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
index 81d5085e322f..81bf3c5e1fdf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
@@ -90,33 +90,27 @@ static void enable_dpia_link_output(struct dc_link *link,
 		const struct dc_link_settings *link_settings)
 {
 	struct link_encoder *link_enc = link_res->dio_link_enc;
+	DC_LOGGER_INIT(link->ctx->logger);
 
 	if (!link->dc->config.unify_link_enc_assignment)
 		link_enc = link_enc_cfg_get_link_enc(link);
 
 	if (link_enc != NULL) {
-		if (link->dc->config.enable_dpia_pre_training && link_enc->funcs->enable_dpia_output) {
+		if (link->dc->config.enable_dpia_pre_training || link->dc->config.unify_link_enc_assignment) {
 			uint8_t fec_rdy = link->dc->link_srv->dp_should_enable_fec(link);
 			uint8_t digmode = dc_is_dp_sst_signal(signal) ? DIG_SST_MODE : DIG_MST_MODE;
 
-			link_enc->funcs->enable_dpia_output(
-					link_enc,
-					link_settings,
-					link->ddc_hw_inst,
-					digmode,
-					fec_rdy);
-		} else {
-			if (dc_is_dp_sst_signal(signal))
-				link_enc->funcs->enable_dp_output(
+			if (link_enc->funcs->enable_dpia_output)
+				link_enc->funcs->enable_dpia_output(
 						link_enc,
 						link_settings,
-						clock_source);
+						link->ddc_hw_inst,
+						digmode,
+						fec_rdy);
 			else
-				link_enc->funcs->enable_dp_mst_output(
-						link_enc,
-						link_settings,
-						clock_source);
-		}
+				DC_LOG_ERROR("%s: link encoder does not support enable_dpia_output\n", __func__);
+		} else
+			enable_dio_dp_link_output(link, link_res, signal, clock_source, link_settings);
 
 	}
 
@@ -129,15 +123,19 @@ static void disable_dpia_link_output(struct dc_link *link,
 		enum signal_type signal)
 {
 	struct link_encoder *link_enc = link_res->dio_link_enc;
+	DC_LOGGER_INIT(link->ctx->logger);
 
 	if (!link->dc->config.unify_link_enc_assignment)
 		link_enc = link_enc_cfg_get_link_enc(link);
 
 	if (link_enc != NULL) {
-		if (link->dc->config.enable_dpia_pre_training && link_enc->funcs->disable_dpia_output) {
+		if (link->dc->config.enable_dpia_pre_training || link->dc->config.unify_link_enc_assignment) {
 			uint8_t digmode = dc_is_dp_sst_signal(signal) ? DIG_SST_MODE : DIG_MST_MODE;
 
-			link_enc->funcs->disable_dpia_output(link_enc, link->ddc_hw_inst, digmode);
+			if (link_enc->funcs->disable_dpia_output)
+				link_enc->funcs->disable_dpia_output(link_enc, link->ddc_hw_inst, digmode);
+			else
+				DC_LOG_ERROR("%s: link encoder does not support disable_dpia_output\n", __func__);
 		} else
 			link_enc->funcs->disable_output(link_enc, signal);
 	}
@@ -166,8 +164,10 @@ static const struct link_hwss dpia_link_hwss = {
 bool can_use_dpia_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
-	return link->is_dig_mapping_flexible &&
-			link->dc->res_pool->funcs->link_encs_assign;
+	if (!link->dc->config.unify_link_enc_assignment)
+		return link->is_dig_mapping_flexible && link->dc->res_pool->funcs->link_encs_assign;
+	else
+		return link->is_dig_mapping_flexible && link_res->dio_link_enc != NULL;
 }
 
 const struct link_hwss *get_dpia_link_hwss(void)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 550e1a098fa2..cc9191a5c9e6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -816,7 +816,10 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 {
 	bool destrictive = false;
 	struct dc_link_settings max_link_cap;
-	bool is_link_enc_unavailable = link->link_enc &&
+	bool is_link_enc_unavailable = false;
+
+	if (!link->dc->config.unify_link_enc_assignment)
+		is_link_enc_unavailable = link->link_enc &&
 			link->dc->res_pool->funcs->link_encs_assign &&
 			!link_enc_cfg_is_link_enc_avail(
 					link->ctx->dc,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 40ac17ba9479..613298d21d03 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1575,7 +1575,8 @@ enum link_training_result dp_perform_link_training(
 
 	/* configure link prior to entering training mode */
 	dpcd_configure_lttpr_mode(link, &lt_settings);
-	dp_set_fec_ready(link, link_res, lt_settings.should_set_fec_ready);
+	if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING)
+		dp_set_fec_ready(link, link_res, lt_settings.should_set_fec_ready);
 	dpcd_configure_channel_coding(link, &lt_settings);
 
 	/* enter training mode:
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index 6e2d08cfc546..603537ffd128 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -130,11 +130,14 @@ static enum link_training_result dpia_configure_link(
 	if (status != DC_OK && link->is_hpd_pending)
 		return LINK_TRAINING_ABORT;
 
-	if (link->preferred_training_settings.fec_enable != NULL)
-		fec_enable = *link->preferred_training_settings.fec_enable;
-	else
-		fec_enable = true;
-	status = dp_set_fec_ready(link, link_res, fec_enable);
+	if (link_dp_get_encoding_format(link_setting) == DP_8b_10b_ENCODING) {
+		if (link->preferred_training_settings.fec_enable != NULL)
+			fec_enable = *link->preferred_training_settings.fec_enable;
+		else
+			fec_enable = true;
+		status = dp_set_fec_ready(link, link_res, fec_enable);
+	}
+
 	if (status != DC_OK && link->is_hpd_pending)
 		return LINK_TRAINING_ABORT;
 
-- 
2.37.3


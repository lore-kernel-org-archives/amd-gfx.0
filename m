Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28D4ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB4D510E6D2;
	Thu, 27 Oct 2022 18:41:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68B510E6D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5Wgo4S3ItkGIaT0G0Dv+gGL9VWbUNxpUl3fjDY4uLM4Q96BXGirSF9NFN9nUJ19DT/vPwYYRQCqSJKnt6MgO1R7Oq3AW5DO3CR8A75wg47uyIBTM+ELZisVOKE4JDSAKewrj+QzMJJPHC9NCO9nnkUnStSBEI0buO7eq7rcpkqlmNwVqsB9fD8HFNHzLNQ7sm0HZQG3XIm4YbM224wg8wsMNUvyqz+tdFCcnJhDLwt9gd5Fpk+9x23nHeHKfMjZ2sd8QzSJ+n5RwYe0v4DSkt6XcEF3y4FFGsxTmpTZm3fuaJlJ5z0q9vCz6lR68+Jv7E+NENqfIAufmWC9fsg+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tir9EWPoMAIMHd4Jh2GY0+RFeIxP3voo5nG8Byavh4=;
 b=he2VQf1VsHiAoVRe1+uwMNYMuWBHA483KD4iiOUxYHJ/OGCDHE5sJproSfKuYfZOG7KA+UCfjyIiIPjy3gz1DfC9cqwX5uE5oxAiTxahg0hZbb8vBc7/8sSRVGLYcvdg1ZpANSXcUKW69iWkstcaNMglEQfG36Wnhvjoy8PaM3dBbliOfbmGGlh7X1fp7qC4MpQWpSBcUC7E1QWw+kte+r573EXv9VOns/Y7+PUThG8TCxdJVBn0CvaayZ9oqK91W61T+btruecHRf/5B20VgPOV9QUFCl192ixdhzFaV8MXf3PtTik0dYipWSbbVTaSWNvbjVZHmAC4OG+V6rddpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tir9EWPoMAIMHd4Jh2GY0+RFeIxP3voo5nG8Byavh4=;
 b=MA7aWJnyVZyRnzmIR5VSXijwBx6pbIdmuFVBuefF2Mb0KT8J7juQpBHQwTGgNKk4+eP0bQekkiUi2Anwf/IVpm/ev+ggiy+zngPtZLIseBxtyMG0xek9lIHezEaMUmUTCUSQDmtNQX4SDbOz6/1Lfa8/Jbu8s8T3vvBRdO1AF6s=
Received: from BN1PR14CA0027.namprd14.prod.outlook.com (2603:10b6:408:e3::32)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 27 Oct
 2022 18:41:13 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::4) by BN1PR14CA0027.outlook.office365.com
 (2603:10b6:408:e3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 18:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Thu, 27 Oct 2022 18:41:12 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:41:10 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/18] drm/amd/display: Use min transition for SubVP into MPO
Date: Thu, 27 Oct 2022 12:35:36 -0600
Message-ID: <20221027183543.1117976-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b05b4b-ae01-486f-a47b-08dab84ad2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jXxGrwFlkWH0vZlkGRKmDpbWiriyfEwyfYJo6EFidAA7ZUJiLZ9q2JlnaKjMVxmw5Tsb2HG6KkI54765fOTJrqIB+A8dN6A4fuXpg1gZ+oSkdsT0WuNcsFB8RCNdkdFQrbFC5mC612SdRMmR6mn180YjJEYWWrnoBAakLpEXCbZnQodEDUQfmNuyBn5nVRvXemYHLkrAg1xUXxbfZmvdWi9wwNQ6rkWsX18ZbNcwS2NWpE9PrDaejfcYJCvV55XmZ1fT2CXyQ9d5Q7DUw3nANdcbZCNyO+PiomoNWagyHy+00M/n9wTsCven8zLo/yaNFwW7dV70Zx+j1o5owxhZ5/bUtUwq6UbkrrabJt8m0SS5Otp7lVNmVx8mpYuSyO1itdqBgRWYKVWgB6z6Q6pj3DCMepshKLA+DvMNkpywdUqno2QTT6kFPKYunXeJEs03yC6bsc5zZCHXkNLbMDdMS2zyHW+wP7zYBx0uAIwd6Oawmq7LSgTLB+WhMnoicurx9CuzHztUzdd4r/Gi0LN6LCf9uwhj+OfB3fkCI32/1EAT7dkfTdFfypXtHvl8XVTn7Q6AAcHAqYFowMCyUxVw531bDhjWnaOsoI5Fxb38anqgAQn0HkE4OxxR6i6lrNu5JQWZ97rs3TQdYBuXML/DkPVw+8rshwKJIJFvH49+RPjol1Nh9+czSbanSIiMA9zuHXG2spnd4OiEnjpyU/Yez9qlAHYDLkqPiB2xNfGgMa8j38KCbjaGnm0+Nf25qDu3DGbTAAPQ2qnL2CMT280ges1ZvAQCz/0YAX+dFrnif2xvjqg+CKoyW2OqHFEUmmC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(70586007)(70206006)(336012)(1076003)(16526019)(186003)(2906002)(44832011)(2616005)(40460700003)(86362001)(83380400001)(426003)(47076005)(26005)(41300700001)(4326008)(356005)(7696005)(81166007)(8676002)(5660300002)(36756003)(82740400003)(8936002)(478600001)(36860700001)(82310400005)(6916009)(40480700001)(316002)(6666004)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:41:12.9464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b05b4b-ae01-486f-a47b-08dab84ad2ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For SubVP transitioning into MPO, we want to
  use a minimal transition to prevent transient
  underflow
- Transitioning a phantom pipe directly into a
  "real" pipe can result in underflow due to the
  HUBP still having it's "phantom" programming
  when HUBP is unblanked (have to wait for next
  VUPDATE of the new OTG)
- Also ensure subvp pipe lock is acquired early
  enough for programming in dc_commit_state_no_check
- When disabling phantom planes, enable phantom OTG
  first so the disable gets the double buffer update

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 43 +++++++++++-------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d446e6098948..da808996e21d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1054,6 +1054,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	int i, j;
 	struct dc_state *dangling_context = dc_create_state(dc);
 	struct dc_state *current_ctx;
+	struct pipe_ctx *pipe;
 
 	if (dangling_context == NULL)
 		return;
@@ -1096,6 +1097,16 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 		}
 
 		if (should_disable && old_stream) {
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			/* When disabling plane for a phantom pipe, we must turn on the
+			 * phantom OTG so the disable programming gets the double buffer
+			 * update. Otherwise the pipe will be left in a partially disabled
+			 * state that can result in underflow or hang when enabling it
+			 * again for different use.
+			 */
+			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
+				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
 
@@ -1749,6 +1760,12 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		context->stream_count == 0)
 		dc->hwss.prepare_bandwidth(dc, context);
 
+	/* When SubVP is active, all HW programming must be done while
+	 * SubVP lock is acquired
+	 */
+	if (dc->hwss.subvp_pipe_control_lock)
+		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
+
 	if (dc->debug.enable_double_buffered_dsc_pg_support)
 		dc->hwss.update_dsc_pg(dc, context, false);
 
@@ -1776,9 +1793,6 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe);
 	}
 
-	if (dc->hwss.subvp_pipe_control_lock)
-		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
-
 	result = dc->hwss.apply_ctx_to_hw(dc, context);
 
 	if (result != DC_OK) {
@@ -3675,7 +3689,6 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 
 	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
 	bool force_minimal_pipe_splitting = false;
-	uint32_t i;
 
 	*is_plane_addition = false;
 
@@ -3707,27 +3720,11 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		}
 	}
 
-	/* For SubVP pipe split case when adding MPO video
-	 * we need to add a minimal transition. In this case
-	 * there will be 2 streams (1 main stream, 1 phantom
-	 * stream).
+	/* For SubVP when adding MPO video we need to add a minimal transition.
 	 */
-	if (cur_stream_status &&
-			dc->current_state->stream_count == 2 &&
-			stream->mall_stream_config.type == SUBVP_MAIN) {
-		bool is_pipe_split = false;
-
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream &&
-					(dc->current_state->res_ctx.pipe_ctx[i].bottom_pipe ||
-					dc->current_state->res_ctx.pipe_ctx[i].next_odm_pipe)) {
-				is_pipe_split = true;
-				break;
-			}
-		}
-
+	if (cur_stream_status && stream->mall_stream_config.type == SUBVP_MAIN) {
 		/* determine if minimal transition is required due to SubVP*/
-		if (surface_count > 0 && is_pipe_split) {
+		if (surface_count > 0) {
 			if (cur_stream_status->plane_count > surface_count) {
 				force_minimal_pipe_splitting = true;
 			} else if (cur_stream_status->plane_count < surface_count) {
-- 
2.38.1


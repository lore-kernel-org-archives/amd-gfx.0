Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2BBC3526B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB3023B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 22:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB3023B7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD5689BF3;
	Fri, 18 Dec 2020 22:30:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CE489BB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 22:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWe0eewd4E3QVFrhN+QidHyQLbtf4+xezn+94C6N3ReAQBgkDklE6g9+e8BB5jQxYgCxBF6iD+4BiRADJ3TTpjqYYaNuHBX3xNNLVcQiCdPBAFpoIz/Z9xBMNcg0xTC0erQGVNcCem6yAIvaEeGSKt/VGt/1noGySrYNaNX1baWBiyTo3h67Mso9mwskWtDWGRZRGXsTBTrp5CY4XMO4AtflShIbRG1H1emq8cP8JlIu86ghThySt+o9vMTNMzseRYDdfQTLfjcwR76sqEUTb69tgoPSzS86IrmNQ+AFu2ZLfWspNazbm0vHNWFTlHplIrkM+mDdTwjCrvjawH1noA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6eVujQTBvyloqcrlczK2U/N7+Vz3o80Pb+uE04ZSNU=;
 b=nyPN21tOgCSiqpnn6UVEauhcJToSe5K0EJJl6s7IH+Taok/wjQxSllaQ2nWoCiM15fNt8GpwX0AuGC8KVJ5e8oz3oKLJTY3nJGBV8wm5iyj7AvioLm7hAXoHr5Nq0HZZE6vfxHqP2hzNTWl1gmTVHbl4qenQnUhh+I1kO+suJQZXzfJBCfGfhK1MrFGBcBDDgZIISbAz3RxTKOsXEfoz6gw9FJv3AQ1uXRG6ZlxUG1Le2jQIaPogY9tPt4KU9M6OYweRnjmOvxBJSMM8lQE9hgUjequJzcqpzhHfi8gpuqa+op56eM2Mzv0yuJyy9m194y7Fmw/Yd8NEV0VbM6v2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6eVujQTBvyloqcrlczK2U/N7+Vz3o80Pb+uE04ZSNU=;
 b=kWlzWKRH87WG/kW33oUgNLBLwsqHVd0qv0IXkgC4MfFzNw9ByYnFoCqr2cg0U0iFCJNXACBksry8y4eyrt73zaN6AOfsWTEzgsXdRHn0SuPu7nEoUFb1maEu8YX1wqBp9psM2XDYMDSdB9C51iv2eHGuIyesLNblMb6JBqRRe50=
Received: from BN1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:408:e2::20)
 by BN7PR12MB2690.namprd12.prod.outlook.com (2603:10b6:408:32::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 22:30:06 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::b) by BN1PR13CA0015.outlook.office365.com
 (2603:10b6:408:e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.21 via Frontend
 Transport; Fri, 18 Dec 2020 22:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Fri, 18 Dec 2020 22:30:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:03 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Dec
 2020 16:30:03 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 18 Dec 2020 16:30:02 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: Multi-display underflow observed
Date: Fri, 18 Dec 2020 17:28:59 -0500
Message-ID: <20201218222904.393785-10-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218222904.393785-1-bindu.r@amd.com>
References: <20201218222904.393785-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e76758cb-225d-43f1-f211-08d8a3a477ae
X-MS-TrafficTypeDiagnostic: BN7PR12MB2690:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26905F2BA11C683395E2A7DEF5C30@BN7PR12MB2690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5xe0FMbQtB59ZgbNfokFhW7G5D3T9Es+STtveIIKcGPuVfpY53z1eqBSHFkjZ1JRGf7yTGRJIIwInY6IIxbMt4i8ugAkSOaUEoEKoD8bXtyw57WRnYSIZCdOswRqBB+KZ6jD3ANOb6JSrwX4kXF5FudOwJBcNJjVBG2FNHz+p4gnvul7D67PpvatQiDNxH9FXIIDPs/mDBx4MQt75Rx+/sbEUvDCnwSCOlcELa/Nxownlmoa2tpYZGvJqJOA9HLZmZwwHcDydfrwyh81u17a6aUI5kbalJHN7JXoCHu/473tNRXtfKOzWLmlVTF5lMqWR9mgeffVNzcogYA3BFZRfLI1Pc2ckSsLhmRimSal4uEM5bJGTdAfNORgY2pAQStfUUA/QsGeeJqngVTAZPWRUdSF8E/gFaxE6ytu6heokp7Luv8YPU0v4vDtkW5jxirOWYVoQc/HPiGOfLAP8xDvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(54906003)(6916009)(186003)(5660300002)(36756003)(8936002)(86362001)(82310400003)(2906002)(26005)(1076003)(83380400001)(478600001)(82740400003)(81166007)(2616005)(336012)(316002)(47076004)(6666004)(426003)(356005)(8676002)(70586007)(70206006)(4326008)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 22:30:05.0333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76758cb-225d-43f1-f211-08d8a3a477ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2690
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
FP2 programming not happening when topology changes occur with multiple
displays.

[How]
Ensure FP2 is programmed whenever global sync changes occur but wait for
VACTIVE first to avoid underflow.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 -------------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 ++++++++---
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7339d9855ec8..58eb0d69873a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2625,26 +2625,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	if (update_type != UPDATE_TYPE_FAST) {
-		// If changing VTG FP2: wait until back in vactive to program FP2
-		// Need to ensure that pipe unlock happens soon after to minimize race condition
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-			if (pipe_ctx->top_pipe || pipe_ctx->stream != stream)
-				continue;
-
-			if (!pipe_ctx->update_flags.bits.global_sync)
-				continue;
-
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
-
-			pipe_ctx->stream_res.tg->funcs->set_vtg_params(
-					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
-		}
-	}
-
 	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
 		dc->hwss.interdependent_update_lock(dc, context, false);
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 31a477194d3b..cb822df21b7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1586,7 +1586,10 @@ static void dcn20_program_pipe(
 			&& !pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe)
 		hws->funcs.blank_pixel_data(dc, pipe_ctx, !pipe_ctx->plane_state->visible);
 
-	if (pipe_ctx->update_flags.bits.global_sync) {
+	/* Only update TG on top pipe */
+	if (pipe_ctx->update_flags.bits.global_sync && !pipe_ctx->top_pipe
+			&& !pipe_ctx->prev_odm_pipe) {
+
 		pipe_ctx->stream_res.tg->funcs->program_global_sync(
 				pipe_ctx->stream_res.tg,
 				pipe_ctx->pipe_dlg_param.vready_offset,
@@ -1594,8 +1597,11 @@ static void dcn20_program_pipe(
 				pipe_ctx->pipe_dlg_param.vupdate_offset,
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
+		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+
 		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
-				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, false);
+				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
@@ -2570,4 +2576,4 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 {
 	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
 			color_space, color_depth, solid_color, width, height, offset);
-}
\ No newline at end of file
+}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

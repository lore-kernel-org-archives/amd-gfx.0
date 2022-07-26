Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F56C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 20:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B788BDFF;
	Tue, 26 Jul 2022 20:22:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A6D10E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 20:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odG6T3maFgobt4pIUrn4bfTH3z5tS9RX1EV7dx/hDDNCnPF32eMO79fgjW7lBzhZQaMYDU+XmU0sWM5yvHP5iDW5NvnAj76Iywbbz40LRKpnx4DMwLsyKTGMZUMaIF2nOGekA+uw29jNPyIYFTlPg6TriVgMi3mZtXOAl0IljJ7Bxh1Fp5KIc4EZ+P/76DA1QqT2nujLuL9S0Qu5ZSu+U6Qdd9MeOh72EtPOYyZF+ESiRc2Ne6eSz2/sCTmF80lmgiPxpn0PfpjIVWZL2dv/6t3dWEDbsuAQWJDv8/8eGEpmilSoHb0VF9seoE2D5M/7STcLmLud/WCxzNFKl4lsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0HWUstNGyzLlIdTWG/++X+IFqUwPcTmDl+BcWDPCfc=;
 b=YI0dhIdoRfPu30GDlBFO+r9FnasUXmhTkLcy7gZm9t4FE/MiYmcAo8Evxb5MyXWYal3j5xvyeWsCLU+OpDHTd378bWc/fQe5to1GFh246EV9WTrjRdu7QBItgUeYWyF/IcmlNLEdIOazsXK5H7umvTr9rnRVvbshx1yHr3m6lhr825rR5UdL0t8x18JfIdvTwu3MgLlgm3vh4/o6znjNsrUx0zEHSTUU2ADtAe/+ApLjrX0uC7SZu5FCDGJ2Ja8cakNh++MikvyjqZCettRjPWSfztNqrbiKu26tkAi/dyWZkuKpTU2kq9ud0/axe/TdIuBgadbMratkmThiuYH5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0HWUstNGyzLlIdTWG/++X+IFqUwPcTmDl+BcWDPCfc=;
 b=GrQKQsFCaiEP/d7dfDAp3/cQiNn4ECoxk0T0KO02d23kGVCEkhNDLAfxu5YE3t8hSNhl2aYLjw/mEgmfR+2D2Q+CKK95pg4DjyGIKMQLnCKlYyQtpXMwQLFVwqUk2Y2eojuwzWFXo9U7UTdKxc/egK+Y+U8vKunIXUDxJuqnLeI=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 20:22:24 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::2e) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Tue, 26 Jul 2022 20:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 20:22:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 15:22:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Fix indentation in
 commit_planes_for_stream()
Date: Tue, 26 Jul 2022 16:21:59 -0400
Message-ID: <20220726202159.305943-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220726202159.305943-1-alexander.deucher@amd.com>
References: <20220726202159.305943-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3802a7cf-cda0-4089-32cc-08da6f448d3c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQG0zzdp2kdZr1u1E508LAZPocnQkG+xkFMivNw5DlNm74NSQE70WDO4CX8+5hW/NAnAztYDc1Vlb562KakVmiZlxdRD5HauqLmrLC77YzIAOflVvcgq/EhhyKOUlRpvRpcSSJ0p573mVt6LrUJnfPH7tq/db+23lr3rVxyCFPglyTms6wRoqljTbGf4hijPm0NLjdvKCotlbrAYbe12zkydkacXJO3yTA0LZeFe+/7iTE/qDKjQ3YT37I0euA68AjexpAAYmml6u/YE2KvhWh+JVu0oSiHNVVOvvt6Ne69Qlspb+0oZ1J501Qexrd9QNRU2vc27p4R0Wc9i5jkgpvp++GGywdto+vsC0XP4RaM132o0yqjegNr7guUVp2uziRoMuXu/JnTZmGXLnlUywlYZ3/0QslK8M0lSlW02L6wG8jPeUpkHnzzCxwiptnnqZdqaZ6NuYtkvLZM/W+ImRAl4U0IC+hDegFemuoNaat7lBxVRi1gDTb5Dpcmx36O19nUA7uWB5tNZE4MMf33h6jv3Tm2Tc9ZTiD/BjOmH13JxdH335pG0bKQlZXf0XBjGnuFdeLzlDGaY60/if5S3Qm7O1ab8iyZeHelqeHuv72lLxHByM45shsWbWQtD4PPPN9po/Ma8p2J3osOho627Jz8SK8gjZcXAujAKWOp0O7KfMuLcZZIWpCn9UcTPGmsYmnoWyR9ix56c5FbsPm2ts/SIEL5H1FWXZRR92YU6J5B11kac5MCiO4Q3Pj36lQweAmd7r0OtXxzaeqtyt4yGY3gK8KsgWFzoMfQR2Fo91jmF+PDiysX3nmoF8TusbCrj4YFWVfuzkem7yzluW8GpBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(46966006)(40470700004)(40460700003)(70206006)(8676002)(1076003)(6916009)(82310400005)(4326008)(54906003)(70586007)(478600001)(2616005)(2906002)(26005)(40480700001)(7696005)(36860700001)(316002)(81166007)(8936002)(82740400003)(356005)(86362001)(6666004)(5660300002)(83380400001)(36756003)(186003)(16526019)(426003)(41300700001)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 20:22:24.2307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3802a7cf-cda0-4089-32cc-08da6f448d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3953
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Martin Leung <martin.leung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functional change.  Just update whitespace.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Martin Leung <martin.leung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 62 ++++++++++++------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7be3ad1c717c..8c97abd3bc5b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3365,8 +3365,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
 		if (!pipe_ctx->top_pipe &&
-			!pipe_ctx->prev_odm_pipe &&
-			should_update_pipe_for_stream(context, pipe_ctx, stream)) {
+		    !pipe_ctx->prev_odm_pipe &&
+		    should_update_pipe_for_stream(context, pipe_ctx, stream)) {
 			struct dc_stream_status *stream_status = NULL;
 
 			if (!pipe_ctx->plane_state)
@@ -3455,27 +3455,27 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	}
 
-		if (update_type != UPDATE_TYPE_FAST)
-			if (dc->hwss.commit_subvp_config)
-				dc->hwss.commit_subvp_config(dc, context);
+	if (update_type != UPDATE_TYPE_FAST)
+		if (dc->hwss.commit_subvp_config)
+			dc->hwss.commit_subvp_config(dc, context);
 
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-			dc->hwss.interdependent_update_lock(dc, context, false);
-		} else {
-			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
-		}
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
+		dc->hwss.interdependent_update_lock(dc, context, false);
+	} else {
+		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+	}
 
-		if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
-			if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
-				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-					top_pipe_to_program->stream_res.tg,
-					CRTC_STATE_VACTIVE);
-				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-					top_pipe_to_program->stream_res.tg,
-					CRTC_STATE_VBLANK);
-				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-					top_pipe_to_program->stream_res.tg,
-					CRTC_STATE_VACTIVE);
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg,
+				CRTC_STATE_VACTIVE);
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg,
+				CRTC_STATE_VBLANK);
+			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+				top_pipe_to_program->stream_res.tg,
+				CRTC_STATE_VACTIVE);
 
 			if (should_use_dmub_lock(stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
@@ -3485,9 +3485,9 @@ static void commit_planes_for_stream(struct dc *dc,
 				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
 
 				dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
-							false,
-							&hw_locks,
-							&inst_flags);
+						     false,
+						     &hw_locks,
+						     &inst_flags);
 			} else
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
 					top_pipe_to_program->stream_res.tg);
@@ -3499,13 +3499,13 @@ static void commit_planes_for_stream(struct dc *dc,
 		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 		 * move the SubVP lock to after the phantom pipes have been setup
 		 */
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		} else {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
-		}
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
+		if (dc->hwss.subvp_pipe_control_lock)
+			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
+	} else {
+		if (dc->hwss.subvp_pipe_control_lock)
+			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
+	}
 
 	// Fire manual trigger only when bottom plane is flipped
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-- 
2.35.3


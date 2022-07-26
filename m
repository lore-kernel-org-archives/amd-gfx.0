Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5501AC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 20:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFBB18BD8F;
	Tue, 26 Jul 2022 20:22:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC91D14B776
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 20:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6Uwf8Kh0jxh5lLzqxA56qVMKGLlQD+ueqk2UWUBQh6Hc0aFjD1Uztk7NCtSx7x+rl6zdadc0lsNwN2wksOu8XfhAImgQn7o6UrM33jxZWSR5izeGtGLjHU7ykoqIvIKw8t6h+ccFNfOLCxNmHXAmFQwmuobMbGYI8vs5J3RmVJ5bG0g3xBzQgTkYeeUPWNpDL9Z4IUVyJjZdyOm0oHVCTUf4mllun3C52brPPJF07sqgfkRaZZvktiLVRCVBAkYAJdsBwFF2BQgpZVD+rIwawpdarW8UeMY9Mksa8yb7GNYB68aVY4f2Tnp8XGg7XHDatR0hbb6GO7UqN5jdDaRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhWVxkZ/pzvcQWhWpyWDatUdjZuLgS+37V151y0vR0o=;
 b=VXSI9ExE2A/L9xoPpxTRxB7R8i2ivMUFFWP6Vox9SLhPCGuxw7TwtqsCqSIR5KwbgCtrKBzDnZmjr4R8vYNNBXvTaKb2H1qpRT1S5puvMkmzgXvGYmn/FtHgYwOoKdw7hO0OPCPak8sCEzukD2P8D9OWnC3AM0WufnHdgJirEC9AOP+X1HqvlJiL+EWigvzKq6sqCeyxLzu5PZ3Dqwr+aLMF5PIpAdAMUITg05GvAQHlXioj34HBc+JKPVpLEIaqLkvsXJVXn1LOIu2h8UVFhYLnIoChnloIJ9LH5OrUy2UVG+1ytiESPIu1nYoX1IsILEIzytnXlob9C0VK57k9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhWVxkZ/pzvcQWhWpyWDatUdjZuLgS+37V151y0vR0o=;
 b=EAAb4t6LuxXGAwlLw8eK+CJA6VO1uwnjxrKe0WSGjIt53cIq3a/2ENt0TezVf/QGCljEpbNGFcqE8QqHWcC+a7sWAs7XzKkApb1QId+mcyy8/nQKemu/uIFLnlqvkdhTr3/CZlP0JByt6DDbZDV1RDKcsgz3hS40Y1ACFHSI+/w=
Received: from MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::21)
 by CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 20:22:23 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::cd) by MW4P222CA0016.outlook.office365.com
 (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Tue, 26 Jul 2022 20:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Tue, 26 Jul 2022 20:22:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 15:22:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amd/display: attempt to fix the logic in
 commit_planes_for_stream()"
Date: Tue, 26 Jul 2022 16:21:58 -0400
Message-ID: <20220726202159.305943-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c665ad-ab86-4a28-4d0e-08da6f448cd3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1814:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jPdkjnvY5y1bkwWq5v9V5C6XVqsTwIqpaDjTfD71volE/XFVDU6RALSI23hXucNkrmqd5PeAnaRnOam92Qdp7LMm+OjAOXYE/nEWA0u0HsAN2ezUPVsRyTOlyco3jFkhPhvZg/4GyojeYd0vt6CNr6notAmmho7ExvVVyAH3IXlUBLwRzPOUsr2kglf1oQgUP5HN9fRqprQEloT3yNQ0zMQaAKsIFofZX27EtCAUNRT+fFaSXwGG3nW4NSdj2FCB1S+aeIlv1TH23SHAC71NyTadic8kdIM56s0lh1Pr9VJBi60gXahEGsAAn8+eAzCeUDZVFAw7YTxyyiFf7J66JTeQI2/vrEEaMdzCTGPYrOgCNk4eJBQ2vJdcHKo8Z3nEkw3n+qPWYtsd2s0Ca/7lsJGxZmYErdwZRnkLqDsNdjWyyGCA6r4e63JjMx8fp71g13/zjPTgY78R6EBmZwcTMgFL3j3DpEaX7CjNO5Lmg7HHzk5cpPuVgrPLUWS2kBcv4BIZGIhgxVFGc2AssMCukQekl6LKOTubxDfj6fdLNk1ZPgG0jbGOF27SCoYmxwOdhfFfx/d+R/8qHG6nBkPCFPC+ReviDv3NNoPKQStYo165IFqPmUgzBFScADe/7PqDSgNoVEhyTJiOmbeNjjiJp3J99emQFvXhMaNjb/UYpwULk5fqq2LCVXGksdkWf6mv1iTCXfFGDPSICq4KehVwMFT29sAbmRmc3jr8B8g5cA8dxDMfQFWNGAgJe25SGne0haVCvzuqK/6YB4wA8L7QQL6C3xgYqvYxDfjn53Lg6Iaa3c5UhtrMceEc7PA/Qu9Oa7EbFk9F/Gfi2mO2k7B7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(40470700004)(46966006)(36840700001)(316002)(54906003)(16526019)(6916009)(1076003)(2616005)(186003)(36756003)(82310400005)(426003)(336012)(40460700003)(47076005)(5660300002)(2906002)(8936002)(81166007)(4326008)(356005)(82740400003)(70586007)(83380400001)(41300700001)(86362001)(40480700001)(478600001)(70206006)(26005)(7696005)(6666004)(36860700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 20:22:23.5276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c665ad-ab86-4a28-4d0e-08da6f448cd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1814
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

This reverts commit a0d10c437c1c9859d24a16b90abf85120603b4ff.

This caused a regression in the DC team testing.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Martin Leung <martin.leung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 45 +++++++++++-------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e42f44fc1c08..7be3ad1c717c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3229,7 +3229,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_lock(stream->link)) {
@@ -3247,7 +3247,6 @@ static void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
 						top_pipe_to_program->stream_res.tg);
 		}
-	}
 
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
@@ -3456,27 +3455,27 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	}
 
-	if (update_type != UPDATE_TYPE_FAST)
-		if (dc->hwss.commit_subvp_config)
-			dc->hwss.commit_subvp_config(dc, context);
+		if (update_type != UPDATE_TYPE_FAST)
+			if (dc->hwss.commit_subvp_config)
+				dc->hwss.commit_subvp_config(dc, context);
 
-	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-		dc->hwss.interdependent_update_lock(dc, context, false);
-	} else {
-		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
-	}
+		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
+			dc->hwss.interdependent_update_lock(dc, context, false);
+		} else {
+			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+		}
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
-		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
-			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-				top_pipe_to_program->stream_res.tg,
-				CRTC_STATE_VACTIVE);
-			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-				top_pipe_to_program->stream_res.tg,
-				CRTC_STATE_VBLANK);
-			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
-				top_pipe_to_program->stream_res.tg,
-				CRTC_STATE_VACTIVE);
+		if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+			if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+					top_pipe_to_program->stream_res.tg,
+					CRTC_STATE_VACTIVE);
+				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+					top_pipe_to_program->stream_res.tg,
+					CRTC_STATE_VBLANK);
+				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
+					top_pipe_to_program->stream_res.tg,
+					CRTC_STATE_VACTIVE);
 
 			if (should_use_dmub_lock(stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
@@ -3493,9 +3492,8 @@ static void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
 					top_pipe_to_program->stream_res.tg);
 		}
-	}
 
-	if (update_type != UPDATE_TYPE_FAST) {
+	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
 		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
@@ -3508,7 +3506,6 @@ static void commit_planes_for_stream(struct dc *dc,
 			if (dc->hwss.subvp_pipe_control_lock)
 				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
 		}
-	}
 
 	// Fire manual trigger only when bottom plane is flipped
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-- 
2.35.3


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9491EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0838714A192;
	Tue, 12 Jul 2022 15:14:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEEA14B390
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVDGuI3bml5TdyNpJFvaL2BE6lYp7hR0RIH8qvZ2xnEI155FvviLPpszvyKWYSlqvNmVj6thgz6EumIEHDXY15QDyBsGmFCm5jH6UPLedi8JT5D+VYvqycyMk76UJGi/Ni6auGTELDr6SFbkH+gQ4VlcdpUs3uTyXRIEJdYoEFLnFw4kYYHN0EZEfiBvDBX0uj/EHhJPLJYQdJE4et7CUBhSp7uuqzoRVE/BQFnu43ND2WbVrs3kWgRVkukthsvb1miZt2Zv6vHzZq2AAAbRp5Kq04V4GsWRltS5X/cqRHXdmsAYNDQmh3BouQo57gt4nBc2Atw615fh4PP0s5XYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVFMoVum42UIdUZ+pj0SGo37sOqaNjypcqmxRYioDEw=;
 b=A9MXE4F4EgBS8jw3Ci7NGcuaoHmL9YYul1qD4WDCUo9UHtHm2Ev5lK9f6qn4PwCv2xXGGviAf/SkQ9i7ZY6EQvx38O9n9vAFcTAiJ5NHXEiTzkQM1VpE1n+CUA183wV1jPQ2/i7C4gc540ZxVCTa7VVIkzeKEylRSW8pClPtSLHllgQhWJZT+YSnPDMF+oFS7QdoiEYVa0MOygN8kqsUVCJle+Sa95Mb/FipHkB1aYsMMVGTzp33K6AYNvbNvus4pGN1UV0hmkiFNEFu1LXhpGMYGD6OZzf7CzZ/Mxx0wSmyp267SuLM8hL7WlQx2XQo4rXoNEwXVm012D5MqImRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVFMoVum42UIdUZ+pj0SGo37sOqaNjypcqmxRYioDEw=;
 b=NGnDUKnMWXdca0H9mX4jD5XkinsVwXFkR1J9wtjt16nssPVa1lE8tD8Po7jS7ziW8RG0A1p5uUOHajuaV9wDsI3Q5nTakNzwBnXG6sI/7DZv55S9MU5i2QQ4HP4oE1Sdz5kK6CvfCK5PovCPbbbTJzsVZI/IRVCMtQo4z6RhF/k=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by BYAPR12MB3637.namprd12.prod.outlook.com (2603:10b6:a03:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:14:04 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::a1) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:14:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:14:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/display: attempt to fix the logic in
 commit_planes_for_stream()
Date: Tue, 12 Jul 2022 11:13:48 -0400
Message-ID: <20220712151348.3047904-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712151348.3047904-1-alexander.deucher@amd.com>
References: <20220712151348.3047904-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f6e522a-842a-4b2a-1f12-08da64192899
X-MS-TrafficTypeDiagnostic: BYAPR12MB3637:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZZqYppv22m6gv8gJfPTXxcm4XCGW9kUy5/KVdwDW5D6/kXA/eWZN4aeI2s19pWHBvs2CsDigjkvmhOj31aA9qmq/H+sbcy7x/pZP/sURNhW3iHIDkS2mJmv6CPIVWfCRjqhT++ZBCj/LiZkpWKlh7HbGMDL8Eg+lGg3Cy8s0MS5I/MR9jJslEBV9XbL3VWalJzMP5vjBXDZbzlnMYet5EQwNz5un6eSha6Y/fMP9jCQpg4pngzPHjqQyWpbkStHDHBAlG5osnOMb6zY+6++1EbQSMtiP0a9Ijvr/r9WMzIRmxlwzTHntzGNp8QzzCRKTRcRGEEFhw7VK7oo23yk66CIbPuKbZnoel66JzBk88F0q1TkO9XMTV7E7hL5DLPsXdSRiPJNagH3UktGV0Bjz+g7qgF79eHDfbvfZvqaOemOIUtopBwIbBgRIShkE895xVXIazJoe0ZaUjb0V3bn791ii3Q1FaJW7zgya3dF/1o/BoPCKKhSfeqIF62uJUnWVyZw0in1AwL5+vDiv132IXzCkgo6cqVR5CpGNsH1AJAPdpZdLlZyc7RKJiPvVjdzPGgnmo7Zpyk4iGcFohobbworeMvu1Ud9i/vxwolW1sH694Sr8NkXCvbEm5bgL3Kf1LoU1SyOWHMmhqj4NdikFP2UBlKHb0NdyLWJGyQeERG5WJ5SoeHXsj8D2p6r21AyU1nwnE+zZxgpxjZy5sTsqlPUB67kdCM2AI6pMzGn2dnrSPOMBBcgiUHWEgA7nGBDOUM2lZZVWwuL8HomlcC0zgQZRkcg+yqp0TGFviSjy5xL7ENhAc5J0/OrzT6pRyX0ATVWohwofnMLl3TUM/aGPZYLj2Qvv9/o3ewREUrrLwc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(40470700004)(46966006)(356005)(81166007)(2906002)(82740400003)(6916009)(316002)(86362001)(8936002)(83380400001)(1076003)(8676002)(40460700003)(70206006)(40480700001)(4326008)(70586007)(26005)(5660300002)(82310400005)(186003)(47076005)(36756003)(16526019)(336012)(478600001)(2616005)(41300700001)(6666004)(426003)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:14:04.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6e522a-842a-4b2a-1f12-08da64192899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3637
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The indentation is screwed up.  I'm not sure quite how the logic
should flow.  Someone more familiar with this code should
verify this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 45 +++++++++++++-----------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7453ec54420b..efc61a485561 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3229,7 +3229,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_lock(stream->link)) {
@@ -3247,6 +3247,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
 						top_pipe_to_program->stream_res.tg);
 		}
+	}
 
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
@@ -3455,27 +3456,27 @@ static void commit_planes_for_stream(struct dc *dc,
 
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
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
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
 
 			if (stream && should_use_dmub_lock(stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
@@ -3492,8 +3493,9 @@ static void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
 					top_pipe_to_program->stream_res.tg);
 		}
+	}
 
-	if (update_type != UPDATE_TYPE_FAST)
+	if (update_type != UPDATE_TYPE_FAST) {
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
 		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
@@ -3506,6 +3508,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			if (dc->hwss.subvp_pipe_control_lock)
 				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
 		}
+	}
 
 	// Fire manual trigger only when bottom plane is flipped
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-- 
2.35.3


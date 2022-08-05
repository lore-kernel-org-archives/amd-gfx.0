Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED700C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CCDB9446;
	Fri,  5 Aug 2022 18:01:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0469EB9217
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsmRXgjANfH/Tbx43jTragoi2KE4Lj+gzLWCouvI3o22GJAt5zt0kYFx8BspDGgsL0TgzNUs9QRpFZ+SBI9nxlrPL5G8MhNr5irZNgJH3CWDRQEXK4ExQoZel4fE23KX+Ere+BhUz8lyiRE943adHy4GaKQui/vA8nUOcKF9Ikz2VnRLnzSYk1apCRJ3C5ZNA93l+vLewvtkFGzsWwW4TfxuD8VOEuE1LLbiYc6yIeR2jxQGq81GgR+yIGV5UPshLt7hR5MOkEHoE5EzFM6QF5VVI/10x2acxgNX1Bc8X2is8+0ZqWSsDDV8MCivyuXNyJHGQPF9fciFTgng+isIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYSTxUB9U4UupTU+jfRG+J1N4n64Rqn/iZ/gcYqLPSo=;
 b=m0RupGitJgw+HD/7BTijlxCLZn8IBKeSuZhkFdKEtxubQWrRDgXUX1WMWJhBjovj+IFgPPBKEZs97OgjrMhzN9EZWST9C4FTYAiCUQA5N9K26zoEfhzZ5V3UDy8KglLZ594i4RJRJaHOAnj6gzYvYLYk7dLCWiLJELPXSCHoMXPTit7G9IPyUPdwm4yQKrnz625H8YVjhNoJvzd1pfC/vxY1iVvBHu4WUVJATz01bNml6CTaUuLVlRbgvee7CoQRrig4U6ww7FfXLPMaahaskuhFdR4U2QWN8WPHHI5JdFMq+V8KFeLmtc3/thwiPp6ipfU3oYNlgmY+Lph7E90NWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYSTxUB9U4UupTU+jfRG+J1N4n64Rqn/iZ/gcYqLPSo=;
 b=RwSa5IRXLV1aGfxMxi99vLKwzXOTwiR+br/jfHQE9rNoSoApo4RLBNzxH16Rmy5pLdIEHvlnovqaICwi3dPhY280CVZPkh8JLqoIc9J5OgXNz0Azw1b9wluJEFu3IuuWZNTGEBvLhD4Hx5wGkW3rzFicipvcDEBjNlUlyBeoW+M=
Received: from DS7PR03CA0278.namprd03.prod.outlook.com (2603:10b6:5:3ad::13)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:01:32 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::74) by DS7PR03CA0278.outlook.office365.com
 (2603:10b6:5:3ad::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:31 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/32] drm/amd/display: Revert "attempt to fix the logic in
 commit_planes_for_stream()"
Date: Sat, 6 Aug 2022 01:58:21 +0800
Message-ID: <20220805175826.2992171-28-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e354a5-7352-4ce5-bea6-08da770c8789
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lszzgMLTYOl2gCn438wWmwNjpE7F3H7WjCsvsCILs9ljjxcvYw8f3nB5Pd7qSYyKXaSsvq/jTKBmYvL6m5rIAA32MAfaEhtwZEy+Deun7A1aikfUFHpvY7x1ihTa9ifMPeX6YOIHpGBD3VuBwqbFKkLcGhIB/5cWfU9vtwk4CWJm3ISLRaWl51p7jXRCev0U25zCQ99aO6geKAGrE5AnTzNpfKWyb4K7w0ZEWtAhnlwUDopGcpXwheTtDij1RFu/tsY8LszBhXF6/mIRkpS1pf8kHOP/xDm4OZiUa+RhuvXKx8wpy/jYFE7alrjjx1YtcOWbdUVGoZwvS3Orab0R0WcfKRmog9Zx7Xd9DajcNkZvavuQzUIe8kbxFcJrdX1btwjDUpIL+d9CpoKkbO9KDGo8qmlMXlxnjZw7eNgGDljeb6CdpYyQ3ZCVqaacILb3OaXwHQllj/0tblMBPp5jliSm0Vl7oltQSR+/dUkMOqHJdqnE2dYGVXtyZi30YhIp7unuz0+BBdGRY71O3RfCBVoj6MIjrGjebu4aGaGbd1A27YLDlCD+YB9yO1pu5CQg0r4JIUx7Lt7389xOTkgeQonenHJ9EU2oBkXYFy+e7Y4v/mEkUCAVtNW8vXeCrZGt78PeRr43Tcnu/mfyKURLqOLAVd4Io1tQYSoo0lZicLKSqfb8NKroK27/LdNwCRbmwZw6YY8JxSEnY/8p0IehMKgGpHD39d0YophOxTrGirVRB+MhWUqd9P7IxgvVIs3wHiq+sBuBAjME7wqTZLsLz4MdSNu5GP8ails07ksN+Bey0shDUwd1peUNVTysXx7xNXTDstZjydbB4ZP7QfIeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(70586007)(36860700001)(70206006)(478600001)(40460700003)(40480700001)(356005)(86362001)(41300700001)(26005)(2906002)(6666004)(7696005)(36756003)(336012)(8936002)(426003)(1076003)(6916009)(47076005)(83380400001)(2616005)(54906003)(82310400005)(4326008)(81166007)(8676002)(5660300002)(186003)(316002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:32.2517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e354a5-7352-4ce5-bea6-08da770c8789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Reverts commit "attempt to fix the logic in commit_planes_for_stream()"
since it caused a regression.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 27 +++++++++++-------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6f5a7e4378a7..08f533f86520 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3232,7 +3232,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_lock(stream->link)) {
@@ -3250,7 +3250,6 @@ static void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
 						top_pipe_to_program->stream_res.tg);
 		}
-	}
 
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
@@ -3469,7 +3468,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed) {
+	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 				top_pipe_to_program->stream_res.tg,
@@ -3496,21 +3495,19 @@ static void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_disable(
 					top_pipe_to_program->stream_res.tg);
 		}
-	}
 
-	if (update_type != UPDATE_TYPE_FAST) {
+	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
-		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
-		 * move the SubVP lock to after the phantom pipes have been setup
-		 */
-		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		} else {
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
-		}
+	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
+	 * move the SubVP lock to after the phantom pipes have been setup
+	 */
+	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
+		if (dc->hwss.subvp_pipe_control_lock)
+			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
+	} else {
+		if (dc->hwss.subvp_pipe_control_lock)
+			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
 	}
 
 	// Fire manual trigger only when bottom plane is flipped
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6404DC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E9710E9B7;
	Wed, 28 Sep 2022 19:41:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5516710E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUYZOKlN7/Moc+hcvZAY3eVLohy6BgMA+R2/I2JuBNJT8Sc5tOk2McvZed0jdiYv3z31ydEJZNYUHeiRHP/lH6hpx0vf1C8DDGLTRKYHAEadDYSUVDjwCq1xvl82SrAkX2GSfnSOwLv2H6eqUtoopMkmYxJtyRIbrqPC6w6vjlSGuG4Jv9ctXzDva10T9idDxc2pJwZ7W1AsQ1SlGz2xVf1SeSIFJs/zhkvaRi7MSSv3/LOuc1rzxlmuNkXAiDqxm8s/FWRtFSK5DrFkb9PjE0oQVJ2rzmvUDvtMIEn84H7Ei6Zp34n3bQ8kMwFY39GoVR0Y5Iq5a6VNR5tc1JjKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EFS2FKPBGLH9od5SBLxsA7aZhxuXj6nLyIufhYIicc=;
 b=IhYDaV5KirZuGsNYIsKP/oiQkajGtUHTOKMmvxR9LbDkF0BAXYiiDSu/wLh48pRKyLUY6ACeuergWbERs/EER77IBpaqQD7vyaBwvqmbMqEGQIYTHj01dX5+Ct9HaCzfzS9SyNCZBURym8boYSyAT85X3tnK9bwUnBsuCGSvXNK4pOCk5fMhyrZi9xu4iIzbC/5uJJcZvx8aE2qzPBXvg/mL9PXyr5P0DtJBdyyu6+vrhaLkR6eN6qLZQMnNqiNdvlXTRIadSLoReVRTddeaNp84F29wzpmUibbU2MZsnX8TGfFYE/R0gm6FTaktxjlIgsgimC2R7M9GFlYQkCGxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EFS2FKPBGLH9od5SBLxsA7aZhxuXj6nLyIufhYIicc=;
 b=tOrwUX8mG57cJlCOQYPidzgcdzuObKoWqxCRyPJzGaztO0u8K3K4pl6bmjHtdiDnod8XBNbDbxs1gC1guhS+hD0udtun/YhWCRTJHWTXOvUFT+HN625aB3C+qtCsHs6LBCtPicozruBlgO4eYY7x8PUeakc7UDCC3YgjBzyXa/A=
Received: from BN9PR03CA0736.namprd03.prod.outlook.com (2603:10b6:408:110::21)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 19:41:31 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::f6) by BN9PR03CA0736.outlook.office365.com
 (2603:10b6:408:110::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:31 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:29 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/36] drm/amd/display: Fix SubVP control flow in the MPO
 context
Date: Wed, 28 Sep 2022 15:40:17 -0400
Message-ID: <20220928194028.144879-26-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 785c4fdf-b578-4cea-8cc8-08daa18971cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FUMlbBSOVuKB8CZfCDk7BGb+WTA+F1/FXxe8A3gK4p4MK5KximSWOv/FejvDoUFxypANIOOGP4Upa4rdxmBr07bPxY/n05hkZ2VypoDQhZtqidS7Hcxe7skNQzXfPWHVHyZXws4gnUcZ3KHin4nT06zcfvJiJBc6aVMSokWIVO0TXKnOpj4SIUEqOma7Ynf2TWV81vbGWd5iwahrNuECFPzJxJmf19sFY9taZweivbZXOby+cnhKQtkeyfzBgtSpZrTvjuehMfmiLDahkqp+oD/CNCtOJh5eqvn3Y9JpcXc9GZDjtD2NI6XZTERM6jpnrenD0Wb/tFfgpgawBCIyPX7R66yy7V8ASyTl8ViKL9TJQ35NQczPNd2jgCEg2fri8l/9PY7xuqjogXB0Cc3UxgtE0EXKfRbjoAVEqTg5y+A1/lJFfYhiKKLctvgzyBqKNM4UKP083kO9i6eOPwdGak/1N5G3qqH9/uS2K07etL5pgmeNkjIuITTYg5nUn1B+7AbxMwmpMV2DmAJ6YGk5hrjQxMGeELmxeCOIUkfc/bc20sPhJmjT2vK9STb4t3NQ8OBEHSqbYjGqif7JyNX1vAC9eC7t3RgozbXwR3pcinBFj6N6g0TbXkYLCpk1C0JM+qbXZnlRPmVyqjylIEFzXA08n2paccMrTESOrMcctpFWkvS85N53qiwyQatf9ywiLvtQ4cd9/kscIDp1+iyxQzik4Q6Agp0w2wxikdZiORrz3k7oekReYOPtG+4QnMrZxv07T/NjXVVi9VtWrq02AhKTOBGJLoNTHyMMlWga5m5FDy78AkPbBN/q36exlXhWxvhpsyX0Tze0o91Y9LS6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(44832011)(41300700001)(47076005)(478600001)(336012)(8936002)(16526019)(426003)(82310400005)(81166007)(356005)(26005)(316002)(6666004)(82740400003)(186003)(86362001)(83380400001)(40480700001)(8676002)(4326008)(1076003)(2616005)(7696005)(36756003)(2906002)(54906003)(36860700001)(6916009)(70206006)(70586007)(5660300002)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:31.7322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785c4fdf-b578-4cea-8cc8-08daa18971cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

SubVP has some issues related to how we allocate and enable it. This
commit fixes this behavior by adding the proper check and configuration
to the SubVP code path.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c       | 16 ++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 18 ------------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.c  |  6 ++++++
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1508679873d9..3a4f2d58f2e8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2946,6 +2946,12 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		dc_resource_state_copy_construct(
 				dc->current_state, context);
 
+		/* For each full update, remove all existing phantom pipes first.
+		 * Ensures that we have enough pipes for newly added MPO planes
+		 */
+		if (dc->res_pool->funcs->remove_phantom_pipes)
+			dc->res_pool->funcs->remove_phantom_pipes(dc, context);
+
 		/*remove old surfaces from context */
 		if (!dc_rem_all_planes_for_stream(dc, stream, context)) {
 
@@ -3353,8 +3359,14 @@ static void commit_planes_for_stream(struct dc *dc,
 		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 		 * move the SubVP lock to after the phantom pipes have been setup
 		 */
-		if (dc->hwss.subvp_pipe_control_lock)
-			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
+		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
+			if (dc->hwss.subvp_pipe_control_lock)
+				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
+		} else {
+			if (dc->hwss.subvp_pipe_control_lock)
+				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
+		}
+
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 7de511fd004b..d732b6f031a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1860,24 +1860,6 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *mpcc_pipe;
-
-		if (pipe->vtp_locked) {
-			dc->hwseq->funcs.wait_for_blank_complete(pipe->stream_res.opp);
-			pipe->plane_res.hubp->funcs->set_blank(pipe->plane_res.hubp, true);
-			pipe->vtp_locked = false;
-
-			for (mpcc_pipe = pipe->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
-
-			for (i = 0; i < dc->res_pool->pipe_count; i++)
-				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
-					dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
-		}
-	}
-
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 752a4accb116..9585b25f10e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1680,6 +1680,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 		phantom_plane->clip_rect.y = 0;
 		phantom_plane->clip_rect.height = phantom_stream->timing.v_addressable;
 
+		phantom_plane->is_phantom = true;
+
 		dc_add_plane_to_context(dc, phantom_stream, phantom_plane, context);
 
 		curr_pipe = curr_pipe->bottom_pipe;
@@ -1749,6 +1751,10 @@ bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context)
 			pipe->stream->mall_stream_config.type = SUBVP_NONE;
 			pipe->stream->mall_stream_config.paired_stream = NULL;
 		}
+
+		if (pipe->plane_state) {
+			pipe->plane_state->is_phantom = false;
+		}
 	}
 	return removed_pipe;
 }
-- 
2.37.2


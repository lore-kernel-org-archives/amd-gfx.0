Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE3CC54FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE422071C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EPp9/3/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE422071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DF16E13A;
	Wed, 22 Apr 2020 22:08:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE80D6E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfap8R86skihS5aNOjN0JRQB95AeMsr6sE6ZNNOBfQKJxvtCjhNaJrdGCFK4R2cxIE+R7MWnlKegYn5mrLNJW9BckGPPDRwWSCOG+w6lKDpW2v4qg28//H9HHGJc1XHcm31Weixd5uYDSVoRVRtUeA7duNvp+0bBvqQ2scZto1JxgpmHwFfLH/Ky1jZK4W4UnUKJjDAwETLBevRcH4PffduLWIftdm879KZf5rpeq8S2uu2J/Z24bygXvPPesSyyl6uVqd0EUzODx3JGCRUP18TMTaKcoCULvAfCnXscey9R9FIe3I5wqGBwtxrru28KzTtb4tTUwbr4QvonaINP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0MdFxSOFpF9wQ2iVpQR0TaOdcgvwsIQilZGL5JIsNM=;
 b=DNibb3vXlS9f0Ntf4YcFmGqOLldHbvQenbMxurL/ZG4rCfFNyfZMcMv2UtLw76m9kHylT/8uiovLpb6HuPqhEr1Y2Y6n4ZZDdCXasvTbtC7cq1Adow24zezOqt0tQzlixmheSYuuDInhGqJP58i57e+wU217j/WdOcvUqC02G5WTjdyIPdtZRsa5j+c3CvN1/zxOmt3623I4K3Nit2hPvUPGhSWosOsmLEbCwk51XcmVByH8k4cGnFlL9w1+k4UvgUSOIiDCPEGKJb7A9ZscwrZxZPPsUxWhdHk6j4+tjC6GTFKkZButgzR18xRIo6HbDtOcSqjQSvkYZ0ONMH0GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0MdFxSOFpF9wQ2iVpQR0TaOdcgvwsIQilZGL5JIsNM=;
 b=EPp9/3/CvGTylHwTqIi6dQm3LIj6s2cvuXCFbYsbkPFbq/4p4q12isNvd9gHQqrHQzC7ynwU4gc72aBRWgzGZ8IMyrIzoHp5oyYH8vDS35y1skVshcfbPBR2njmXNcJyg01OhtOa4c2Yvfs28Jh8YFyrn0Jd5NPh3WAaD4batZY=
Received: from MW2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:907:1::21)
 by BN6PR12MB1937.namprd12.prod.outlook.com (2603:10b6:404:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 22:08:32 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e5) by MW2PR16CA0044.outlook.office365.com
 (2603:10b6:907:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:32 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:31 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:30 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: Use cursor locking to prevent flip
 delays
Date: Wed, 22 Apr 2020 18:08:03 -0400
Message-ID: <20200422220805.15759-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(428003)(46966005)(316002)(6666004)(82310400002)(8936002)(2906002)(70206006)(4326008)(6916009)(8676002)(1076003)(26005)(86362001)(81156014)(70586007)(30864003)(44832011)(5660300002)(336012)(81166007)(426003)(36756003)(356005)(186003)(54906003)(82740400003)(2616005)(7696005)(47076004)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a3294c2-9e02-489e-812d-08d7e709b1b8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1937:
X-Microsoft-Antispam-PRVS: <BN6PR12MB19379D8192A96E9A6D5155F98BD20@BN6PR12MB1937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+5qbGZuMJ9Rw1Y6kZs3tXmfxj+GLT11/OYhWsY1zGhmhVa/FO/v+SySN9gumRwmy6R9vgfj/jqw4wi0sz/Arwden3po/ij9+BtMHx1r1015SLS3OjqQlCNithIBQnAMg8BAflQMnpvnXsTOuXT1r9PqW5QQJyKGGlKUkbmNOt0JIImA4/DDwPwgVhB6zLyNXD1/TCX2A45ynKzStBZOjwHg0yiUkcgFv2JbsZ2P4bjuSRhSn3JxD9Mg/gEToqvslJbmQlrsCU2+8YVXmZ8BtEXOC0X+rPDgXA5pVeUcYopgyvCRckouy4TpVIrOhlrgOyiiVRPSva7gwv46KjWeT1DIQEuaLVZ7kG8MiRuOCR/UvNwlzVLRw31aC9hmiwcy1EgagwRwOmx9AKm0DEpy8wri/7uuKWsFB3PzIg2hwFtm1K4RbuIokmq4fiiT/Dw4/wD0TJOc2poZdDpi5C7y+DERZyU7AQojq8XEhgH2aEuFE7BaZbJEmZZhc5hVXP4THxq3kAKe296Cib7R/9MIDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:31.6866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3294c2-9e02-489e-812d-08d7e709b1b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1937
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Current locking scheme for cursor can result in a flip missing
its vsync, deferring it for one or more vsyncs.  Result is a
potential for stuttering when cursor is moved.

[How]
Use cursor update lock so that flips are not blocked while cursor
is being programmed.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 40 ++-----------------
 .../display/dc/dce110/dce110_hw_sequencer.c   |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 10 +++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  | 15 +++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h  | 20 +++++++---
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 14 ++++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h  |  3 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  4 ++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  4 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 16 ++++++++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  1 +
 16 files changed, 88 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 8c20e9e907b2..4f0e7203dba4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -231,34 +231,6 @@ struct dc_stream_status *dc_stream_get_status(
 	return dc_stream_get_status_from_state(dc->current_state, stream);
 }
 
-static void delay_cursor_until_vupdate(struct pipe_ctx *pipe_ctx, struct dc *dc)
-{
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	unsigned int vupdate_line;
-	unsigned int lines_to_vupdate, us_to_vupdate, vpos, nvpos;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	unsigned int us_per_line;
-
-	if (!dc->hwss.get_vupdate_offset_from_vsync)
-		return;
-
-	vupdate_line = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
-	if (!dc_stream_get_crtc_position(dc, &stream, 1, &vpos, &nvpos))
-		return;
-
-	if (vpos >= vupdate_line)
-		return;
-
-	us_per_line =
-		stream->timing.h_total * 10000 / stream->timing.pix_clk_100hz;
-	lines_to_vupdate = vupdate_line - vpos;
-	us_to_vupdate = lines_to_vupdate * us_per_line;
-
-	/* 70 us is a conservative estimate of cursor update time*/
-	if (us_to_vupdate < 70)
-		udelay(us_to_vupdate);
-#endif
-}
 
 /**
  * dc_stream_set_cursor_attributes() - Update cursor attributes and set cursor surface address
@@ -298,9 +270,7 @@ bool dc_stream_set_cursor_attributes(
 
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
-
-			delay_cursor_until_vupdate(pipe_ctx, dc);
-			dc->hwss.pipe_control_lock(dc, pipe_to_program, true);
+			dc->hwss.cursor_lock(dc, pipe_to_program, true);
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
@@ -309,7 +279,7 @@ bool dc_stream_set_cursor_attributes(
 	}
 
 	if (pipe_to_program)
-		dc->hwss.pipe_control_lock(dc, pipe_to_program, false);
+		dc->hwss.cursor_lock(dc, pipe_to_program, false);
 
 	return true;
 }
@@ -349,16 +319,14 @@ bool dc_stream_set_cursor_position(
 
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
-
-			delay_cursor_until_vupdate(pipe_ctx, dc);
-			dc->hwss.pipe_control_lock(dc, pipe_to_program, true);
+			dc->hwss.cursor_lock(dc, pipe_to_program, true);
 		}
 
 		dc->hwss.set_cursor_position(pipe_ctx);
 	}
 
 	if (pipe_to_program)
-		dc->hwss.pipe_control_lock(dc, pipe_to_program, false);
+		dc->hwss.cursor_lock(dc, pipe_to_program, false);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 30469026c642..6bd8d4e1c294 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2767,6 +2767,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.disable_plane = dce110_power_down_fe,
 	.pipe_control_lock = dce_pipe_control_lock,
 	.interdependent_update_lock = NULL,
+	.cursor_lock = dce_pipe_control_lock,
 	.prepare_bandwidth = dce110_prepare_bandwidth,
 	.optimize_bandwidth = dce110_optimize_bandwidth,
 	.set_drr = set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bfc8578eda15..2eb5d0e3e425 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1669,6 +1669,16 @@ void dcn10_pipe_control_lock(
 		hws->funcs.verify_allow_pstate_change_high(dc);
 }
 
+void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock)
+{
+	/* cursor lock is per MPCC tree, so only need to lock one pipe per stream */
+	if (!pipe || pipe->top_pipe)
+		return;
+
+	dc->res_pool->mpc->funcs->cursor_lock(dc->res_pool->mpc,
+			pipe->stream_res.opp->inst, lock);
+}
+
 static bool wait_for_reset_trigger_to_occur(
 	struct dc_context *dc_ctx,
 	struct timing_generator *tg)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 16a50e05ffbf..af51424315d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -49,6 +49,7 @@ void dcn10_pipe_control_lock(
 	struct dc *dc,
 	struct pipe_ctx *pipe,
 	bool lock);
+void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock);
 void dcn10_blank_pixel_data(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 6f3dbcdb06f5..6ff7e2bd1d4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -50,6 +50,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn10_disable_plane,
 	.pipe_control_lock = dcn10_pipe_control_lock,
+	.cursor_lock = dcn10_cursor_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.prepare_bandwidth = dcn10_prepare_bandwidth,
 	.optimize_bandwidth = dcn10_optimize_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 04f863499cfb..3fcd408e9103 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -223,6 +223,9 @@ struct mpcc *mpc1_insert_plane(
 	REG_SET(MPCC_TOP_SEL[mpcc_id], 0, MPCC_TOP_SEL, dpp_id);
 	REG_SET(MPCC_OPP_ID[mpcc_id], 0, MPCC_OPP_ID, tree->opp_id);
 
+	/* Configure VUPDATE lock set for this MPCC to map to the OPP */
+	REG_SET(MPCC_UPDATE_LOCK_SEL[mpcc_id], 0, MPCC_UPDATE_LOCK_SEL, tree->opp_id);
+
 	/* update mpc tree mux setting */
 	if (tree->opp_list == insert_above_mpcc) {
 		/* insert the toppest mpcc */
@@ -318,6 +321,7 @@ void mpc1_remove_mpcc(
 		REG_SET(MPCC_TOP_SEL[mpcc_id], 0, MPCC_TOP_SEL, 0xf);
 		REG_SET(MPCC_BOT_SEL[mpcc_id], 0, MPCC_BOT_SEL, 0xf);
 		REG_SET(MPCC_OPP_ID[mpcc_id],  0, MPCC_OPP_ID,  0xf);
+		REG_SET(MPCC_UPDATE_LOCK_SEL[mpcc_id], 0, MPCC_UPDATE_LOCK_SEL, 0xf);
 
 		/* mark this mpcc as not in use */
 		mpc10->mpcc_in_use_mask &= ~(1 << mpcc_id);
@@ -328,6 +332,7 @@ void mpc1_remove_mpcc(
 		REG_SET(MPCC_TOP_SEL[mpcc_id], 0, MPCC_TOP_SEL, 0xf);
 		REG_SET(MPCC_BOT_SEL[mpcc_id], 0, MPCC_BOT_SEL, 0xf);
 		REG_SET(MPCC_OPP_ID[mpcc_id],  0, MPCC_OPP_ID,  0xf);
+		REG_SET(MPCC_UPDATE_LOCK_SEL[mpcc_id], 0, MPCC_UPDATE_LOCK_SEL, 0xf);
 	}
 }
 
@@ -361,6 +366,7 @@ void mpc1_mpc_init(struct mpc *mpc)
 		REG_SET(MPCC_TOP_SEL[mpcc_id], 0, MPCC_TOP_SEL, 0xf);
 		REG_SET(MPCC_BOT_SEL[mpcc_id], 0, MPCC_BOT_SEL, 0xf);
 		REG_SET(MPCC_OPP_ID[mpcc_id],  0, MPCC_OPP_ID,  0xf);
+		REG_SET(MPCC_UPDATE_LOCK_SEL[mpcc_id], 0, MPCC_UPDATE_LOCK_SEL, 0xf);
 
 		mpc1_init_mpcc(&(mpc->mpcc_array[mpcc_id]), mpcc_id);
 	}
@@ -381,6 +387,7 @@ void mpc1_mpc_init_single_inst(struct mpc *mpc, unsigned int mpcc_id)
 	REG_SET(MPCC_TOP_SEL[mpcc_id], 0, MPCC_TOP_SEL, 0xf);
 	REG_SET(MPCC_BOT_SEL[mpcc_id], 0, MPCC_BOT_SEL, 0xf);
 	REG_SET(MPCC_OPP_ID[mpcc_id],  0, MPCC_OPP_ID,  0xf);
+	REG_SET(MPCC_UPDATE_LOCK_SEL[mpcc_id], 0, MPCC_UPDATE_LOCK_SEL, 0xf);
 
 	mpc1_init_mpcc(&(mpc->mpcc_array[mpcc_id]), mpcc_id);
 
@@ -453,6 +460,13 @@ void mpc1_read_mpcc_state(
 			MPCC_BUSY, &s->busy);
 }
 
+void mpc1_cursor_lock(struct mpc *mpc, int opp_id, bool lock)
+{
+	struct dcn10_mpc *mpc10 = TO_DCN10_MPC(mpc);
+
+	REG_SET(CUR[opp_id], 0, CUR_VUPDATE_LOCK_SET, lock ? 1 : 0);
+}
+
 static const struct mpc_funcs dcn10_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
@@ -464,6 +478,7 @@ static const struct mpc_funcs dcn10_mpc_funcs = {
 	.assert_mpcc_idle_before_connect = mpc1_assert_mpcc_idle_before_connect,
 	.init_mpcc_list_from_hw = mpc1_init_mpcc_list_from_hw,
 	.update_blending = mpc1_update_blending,
+	.cursor_lock = mpc1_cursor_lock,
 	.set_denorm = NULL,
 	.set_denorm_clamp = NULL,
 	.set_output_csc = NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h
index 962a68e322ee..66a4719c22a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h
@@ -39,11 +39,12 @@
 	SRII(MPCC_BG_G_Y, MPCC, inst),\
 	SRII(MPCC_BG_R_CR, MPCC, inst),\
 	SRII(MPCC_BG_B_CB, MPCC, inst),\
-	SRII(MPCC_BG_B_CB, MPCC, inst),\
-	SRII(MPCC_SM_CONTROL, MPCC, inst)
+	SRII(MPCC_SM_CONTROL, MPCC, inst),\
+	SRII(MPCC_UPDATE_LOCK_SEL, MPCC, inst)
 
 #define MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0(inst) \
-	SRII(MUX, MPC_OUT, inst)
+	SRII(MUX, MPC_OUT, inst),\
+	VUPDATE_SRII(CUR, VUPDATE_LOCK_SET, inst)
 
 #define MPC_COMMON_REG_VARIABLE_LIST \
 	uint32_t MPCC_TOP_SEL[MAX_MPCC]; \
@@ -55,7 +56,9 @@
 	uint32_t MPCC_BG_R_CR[MAX_MPCC]; \
 	uint32_t MPCC_BG_B_CB[MAX_MPCC]; \
 	uint32_t MPCC_SM_CONTROL[MAX_MPCC]; \
-	uint32_t MUX[MAX_OPP];
+	uint32_t MUX[MAX_OPP]; \
+	uint32_t MPCC_UPDATE_LOCK_SEL[MAX_MPCC]; \
+	uint32_t CUR[MAX_OPP];
 
 #define MPC_COMMON_MASK_SH_LIST_DCN1_0(mask_sh)\
 	SF(MPCC0_MPCC_TOP_SEL, MPCC_TOP_SEL, mask_sh),\
@@ -78,7 +81,8 @@
 	SF(MPCC0_MPCC_SM_CONTROL, MPCC_SM_FIELD_ALT, mask_sh),\
 	SF(MPCC0_MPCC_SM_CONTROL, MPCC_SM_FORCE_NEXT_FRAME_POL, mask_sh),\
 	SF(MPCC0_MPCC_SM_CONTROL, MPCC_SM_FORCE_NEXT_TOP_POL, mask_sh),\
-	SF(MPC_OUT0_MUX, MPC_OUT_MUX, mask_sh)
+	SF(MPC_OUT0_MUX, MPC_OUT_MUX, mask_sh),\
+	SF(MPCC0_MPCC_UPDATE_LOCK_SEL, MPCC_UPDATE_LOCK_SEL, mask_sh)
 
 #define MPC_REG_FIELD_LIST(type) \
 	type MPCC_TOP_SEL;\
@@ -101,7 +105,9 @@
 	type MPCC_SM_FIELD_ALT;\
 	type MPCC_SM_FORCE_NEXT_FRAME_POL;\
 	type MPCC_SM_FORCE_NEXT_TOP_POL;\
-	type MPC_OUT_MUX;
+	type MPC_OUT_MUX;\
+	type MPCC_UPDATE_LOCK_SEL;\
+	type CUR_VUPDATE_LOCK_SET;
 
 struct dcn_mpc_registers {
 	MPC_COMMON_REG_VARIABLE_LIST
@@ -192,4 +198,6 @@ void mpc1_read_mpcc_state(
 		int mpcc_inst,
 		struct mpcc_state *s);
 
+void mpc1_cursor_lock(struct mpc *mpc, int opp_id, bool lock);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 6d506c37fc71..bacf865f55c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -182,6 +182,14 @@ enum dcn10_clk_src_array_id {
 	.reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## reg_name
 
+#define VUPDATE_SRII(reg_name, block, id)\
+	.reg_name[id] = BASE(mm ## reg_name ## 0 ## _ ## block ## id ## _BASE_IDX) + \
+					mm ## reg_name ## 0 ## _ ## block ## id
+
+/* set field/register/bitfield name */
+#define SFRB(field_name, reg_name, bitfield, post_fix)\
+	.field_name = reg_name ## __ ## bitfield ## post_fix
+
 /* NBIO */
 #define NBIO_BASE_INNER(seg) \
 	NBIF_BASE__INST0_SEG ## seg
@@ -432,11 +440,13 @@ static const struct dcn_mpc_registers mpc_regs = {
 };
 
 static const struct dcn_mpc_shift mpc_shift = {
-	MPC_COMMON_MASK_SH_LIST_DCN1_0(__SHIFT)
+	MPC_COMMON_MASK_SH_LIST_DCN1_0(__SHIFT),\
+	SFRB(CUR_VUPDATE_LOCK_SET, CUR0_VUPDATE_LOCK_SET0, CUR0_VUPDATE_LOCK_SET, __SHIFT)
 };
 
 static const struct dcn_mpc_mask mpc_mask = {
-	MPC_COMMON_MASK_SH_LIST_DCN1_0(_MASK),
+	MPC_COMMON_MASK_SH_LIST_DCN1_0(_MASK),\
+	SFRB(CUR_VUPDATE_LOCK_SET, CUR0_VUPDATE_LOCK_SET0, CUR0_VUPDATE_LOCK_SET, _MASK)
 };
 
 #define tg_regs(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 1e33e29b37f8..c83d98e0d211 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -52,6 +52,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index de9c857ab3e9..570dfd9a243f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -545,6 +545,7 @@ const struct mpc_funcs dcn20_mpc_funcs = {
 	.mpc_init = mpc1_mpc_init,
 	.mpc_init_single_inst = mpc1_mpc_init_single_inst,
 	.update_blending = mpc2_update_blending,
+	.cursor_lock = mpc1_cursor_lock,
 	.get_mpcc_for_dpp = mpc2_get_mpcc_for_dpp,
 	.wait_for_idle = mpc2_assert_idle_mpcc,
 	.assert_mpcc_idle_before_connect = mpc2_assert_mpcc_idle_before_connect,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
index c78fd5123497..496658f420db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
@@ -179,7 +179,8 @@
 	SF(MPC_OUT0_DENORM_CLAMP_G_Y, MPC_OUT_DENORM_CLAMP_MAX_G_Y, mask_sh),\
 	SF(MPC_OUT0_DENORM_CLAMP_G_Y, MPC_OUT_DENORM_CLAMP_MIN_G_Y, mask_sh),\
 	SF(MPC_OUT0_DENORM_CLAMP_B_CB, MPC_OUT_DENORM_CLAMP_MAX_B_CB, mask_sh),\
-	SF(MPC_OUT0_DENORM_CLAMP_B_CB, MPC_OUT_DENORM_CLAMP_MIN_B_CB, mask_sh)
+	SF(MPC_OUT0_DENORM_CLAMP_B_CB, MPC_OUT_DENORM_CLAMP_MIN_B_CB, mask_sh),\
+	SF(CUR_VUPDATE_LOCK_SET0, CUR_VUPDATE_LOCK_SET, mask_sh)
 
 /*
  *	DCN2 MPC_OCSC debug status register:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index f04d0872a8ed..60ea499c1ca8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -509,6 +509,10 @@ enum dcn20_clk_src_array_id {
 	.block ## _ ## reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## reg_name
 
+#define VUPDATE_SRII(reg_name, block, id)\
+	.reg_name[id] = BASE(mm ## reg_name ## _ ## block ## id ## _BASE_IDX) + \
+					mm ## reg_name ## _ ## block ## id
+
 /* NBIO */
 #define NBIO_BASE_INNER(seg) \
 	NBIO_BASE__INST0_SEG ## seg
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 128d5e3729c6..ae05a8bfdae1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -53,6 +53,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d771fe1e2c4e..ceaf70a934c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -342,6 +342,10 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.block ## _ ## reg_name[id] = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 					mm ## block ## id ## _ ## reg_name
 
+#define VUPDATE_SRII(reg_name, block, id)\
+	.reg_name[id] = BASE(mm ## reg_name ## _ ## block ## id ## _BASE_IDX) + \
+					mm ## reg_name ## _ ## block ## id
+
 /* NBIO */
 #define NBIO_BASE_INNER(seg) \
 	NBIF0_BASE__INST0_SEG ## seg
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 094afc4c8173..50ee8aa7ec3b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -210,6 +210,22 @@ struct mpc_funcs {
 		struct mpcc_blnd_cfg *blnd_cfg,
 		int mpcc_id);
 
+	/*
+	 * Lock cursor updates for the specified OPP.
+	 * OPP defines the set of MPCC that are locked together for cursor.
+	 *
+	 * Parameters:
+	 * [in] 	mpc		- MPC context.
+	 * [in]     opp_id	- The OPP to lock cursor updates on
+	 * [in]		lock	- lock/unlock the OPP
+	 *
+	 * Return:  void
+	 */
+	void (*cursor_lock)(
+			struct mpc *mpc,
+			int opp_id,
+			bool lock);
+
 	struct mpcc* (*get_mpcc_for_dpp)(
 			struct mpc_tree *tree,
 			int dpp_id);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index ed3505cbba6e..1570fed20de0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -90,6 +90,7 @@ struct hw_sequencer_funcs {
 			struct dc_state *context, bool lock);
 	void (*set_flip_control_gsl)(struct pipe_ctx *pipe_ctx,
 			bool flip_immediate);
+	void (*cursor_lock)(struct dc *dc, struct pipe_ctx *pipe, bool lock);
 
 	/* Timing Related */
 	void (*get_position)(struct pipe_ctx **pipe_ctx, int num_pipes,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0ADC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E27610E3A6;
	Wed, 21 Sep 2022 23:17:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D078510E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJliY0USkCYTKb02lAUhtqmeey+ZrZijk72myx1QaTpa+3ysetW0lMOQvNX5M0il+5n1FsPpsGzB9asbNzPi04ZbhCkbOXRMWHriYAEoBfJknM67/UQ3ErCXoCc35sFsT2rdF07EWKQJnWp74G951Cr5oLVavFY8hpmTaf3G+ZckTqs+Be86uCcZK9i59V8SvtfqmcR7FqIoSqvZLVusZcXzl+UTwF53av5gKE4kndTjVgLPIiGbICBWZ/5Q2BPACQbW9u8XzCKC9eQbGg5XMuJUt7Dea3pDmnXxUAOuR7xsm/pjocV5hipMA71idnDFwxis/fQ19RWdBpBXVFw+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1wmvKO+Ty2utetS6pgfc1cWf4siRUZZCKpuQz0ADLA=;
 b=KfQz1W9/6YSkQPR7BmQ6h470tnq7mVjD3hLhGPIFg9ZLCq4ch9lPudbptUl2f1S7nSrS6Divt6B5QuAoKV2OSUzY0l+QjVSnoSa9VRPrvpmKlD5peorJqexJL4PYjHHD3T3kRwEkt6ybNP20PRcZuuyh379r5q70Id1VkVriQpJ+HgIL6gmtXJxoCC8/F5w1XcRNOWLykMGkUC4F38TwGCtTjyoLjfeiWh04EVGH6Hb/O0dKgo9MzmB6pnptQ+D98tBlYM0LEcsK7BA7/IrLZRcdMB3FtDoPQsJ0lFaHI/HFV3FCBRut+g+ZU+rkh18QGvxKriRzUY/l2SDLyRQpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1wmvKO+Ty2utetS6pgfc1cWf4siRUZZCKpuQz0ADLA=;
 b=EU8z1PGDfvY7OY3as43ME9nERAyj4CEFjZWApaFuhp3NE50O55sblv8ODyIqz7Ip6rzVEY+PJuC4DOaOIExEEdu4tdMmhUgZHW9IMlin0bp5zSFyBadtdMKu1sgRFa4xqYV42F8xoUvAPk3l4xJ8+mR3sDzsjPk4ekR1SdUgjdE=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 23:17:39 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::50) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:37 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:33 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/31] drm/amd/display: Fix various dynamic ODM transitions on
 DCN32
Date: Wed, 21 Sep 2022 19:16:46 -0400
Message-ID: <20220921231714.303727-4-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 408ac85d-f9aa-40af-1518-08da9c277904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMLQvV9MRwjbNoHAO3TgdxOIuMAgVXi9SkxslBWvGvS+n5DEqnjF9LxX5yf5Y7QrQndEeU4JDlGMY+K2kQbSZ44yQRhDmlybQSy7BrRxMNU+Fh4f9Y9Nam2lRsWPprY8jbDwlwEob1pCuZtlM3Eu/7xOJB8ddMgtCZXpUQABxike2isV1Vt4gsimHNRGL+/Nv4cr2qY5JRyNTmc9/RIDwL4ABA6Sbf+WFcGqE+GLMua1vKAGRd9iHTE+9uSo9lp3vRUkQ63/NPGsu5JRUMPMB6Wk8zQmvAFTWadGggwhrt3tQftmcD6JUAGfDWSu9NBABJNSPmUDJBNg8CN+EOewnHm7kd47ysSp+zQk9wpS1h85WkzlqKxaHDOTNAAAKjDjZaf/9bvXT8GYfdEy0ZMWeK4ndK67f3KHB3mvlkNh81eO54MKNepOEpuiXWDSq4Rf1BLgscD8GyteZSAdcUQ0sWW4naJGLWEI4JGQkMKzRfT1Huo9wWsTuh3d1+ES8Zdfe750Cqe/1UefC8t20hSR8qzQ5XamXaNSBQ+Ex9vjv0IPJcyAnwMD35hwiTjzZU5y6W0CxWt44u+o0jigiXVEStHSq1Iy4rTUppmpr3CrySFrqGMOELxKFnaL3NwgHTOpX0NTlnoOeAJva3gE8ir/RTV+1rafaoyNpO1uuPW/LpMiiS1lNZhdTbAcC0MSNoqUGJM48DVyMU3UeMEOhz66mO+RQl0Xg+j6gH54CPJ7imj7lY6HrjYC2tklZpRyrf20uKGdfoYe1+gv7EycHrhNsz3A+/HLEfjcdsgdVqN5kmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(8676002)(36756003)(81166007)(36860700001)(8936002)(82740400003)(356005)(186003)(336012)(83380400001)(16526019)(1076003)(2616005)(47076005)(426003)(41300700001)(478600001)(40460700003)(54906003)(6916009)(316002)(26005)(30864003)(70206006)(5660300002)(70586007)(6666004)(4326008)(2906002)(40480700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:37.2439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408ac85d-f9aa-40af-1518-08da9c277904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Why&How]

Several transitions were fixed that will allow Dynamic ODM and MPO
transitions to be supported on DCN32.

1) Due to resource limitations, in certain scenarios that require an MPO
plane to be split, the features cannot be combined with the current
policy. This is due to unsafe transitions being required (OPP instance
per MPCC being switched on active pipe is not supported by DCN), to
support the split plane with ODM active as it moves across the viewport.
Dynamic ODM will now be disabled when MPO is required.

2) When exiting MPO and re-entering ODM, DC assigns an inactive pipe for
the next ODM pipe, which under previous power gating policy would result
in programming a gated DSC HW block. New policy dynamically
gates/un-gates DSC blocks when Dynamic ODM is active to support

transitions on DCN32 only.

3) Entry and exit from 3 plane MPO and Dynamic ODM requires a minimal
transition so that all pipes which require their MPCC OPP instance to
be changed have a full frame to be disabled before reprogramming. To
solve this, the Dynamic ODM policy now utilizes minimal state
transitions when entering or exiting 3 plane scenarios.

4) Various fixes to DCN32 pipe merge/split algorithm to support Dynamic
ODM and MPO transitions.

In summary, this commit fixes various transitions to support ODM->MPO
and MPO->ODM.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 99 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 54 ++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  8 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 27 ++---
 .../amd/display/dc/dcn321/dcn321_resource.c   |  3 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 24 +++++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  2 +
 10 files changed, 186 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 19eb960d75d8..390adc00cd28 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1750,6 +1750,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		context->stream_count == 0)
 		dc->hwss.prepare_bandwidth(dc, context);
 
+	if (dc->debug.enable_double_buffered_dsc_pg_support)
+		dc->hwss.update_dsc_pg(dc, context, false);
+
 	disable_dangling_plane(dc, context);
 	/* re-program planes for existing stream, in case we need to
 	 * free up plane resource for later use
@@ -1840,6 +1843,9 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.optimize_bandwidth(dc, context);
 	}
 
+	if (dc->debug.enable_double_buffered_dsc_pg_support)
+		dc->hwss.update_dsc_pg(dc, context, true);
+
 	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
 		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
 	else
@@ -2003,6 +2009,9 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	dc->hwss.optimize_bandwidth(dc, context);
 
+	if (dc->debug.enable_double_buffered_dsc_pg_support)
+		dc->hwss.update_dsc_pg(dc, context, true);
+
 	dc->optimized_required = false;
 	dc->wm_optimized_required = false;
 }
@@ -3198,6 +3207,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (get_seamless_boot_stream_count(context) == 0)
 			dc->hwss.prepare_bandwidth(dc, context);
 
+		if (dc->debug.enable_double_buffered_dsc_pg_support)
+			dc->hwss.update_dsc_pg(dc, context, false);
+
 		context_clock_trace(dc, context);
 	}
 
@@ -3521,11 +3533,59 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 }
 
+/* Determines if the incoming context requires a applying transition state with unnecessary
+ * pipe splitting and ODM disabled, due to hardware limitations. In a case where
+ * the OPP associated with an MPCC might change due to plane additions, this function
+ * returns true.
+ */
+static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
+		struct dc_stream_state *stream,
+		int surface_count,
+		bool *is_plane_addition)
+{
+
+	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
+	bool force_minimal_pipe_splitting = false;
+
+	*is_plane_addition = false;
+
+	if (cur_stream_status &&
+			dc->current_state->stream_count > 0 &&
+			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID) {
+		/* determine if minimal transition is required due to MPC*/
+		if (surface_count > 0) {
+			if (cur_stream_status->plane_count > surface_count) {
+				force_minimal_pipe_splitting = true;
+			} else if (cur_stream_status->plane_count < surface_count) {
+				force_minimal_pipe_splitting = true;
+				*is_plane_addition = true;
+			}
+		}
+	}
+
+	if (cur_stream_status &&
+			dc->current_state->stream_count == 1 &&
+			dc->debug.enable_single_display_2to1_odm_policy) {
+		/* determine if minimal transition is required due to dynamic ODM*/
+		if (surface_count > 0) {
+			if (cur_stream_status->plane_count > 2 && cur_stream_status->plane_count > surface_count) {
+				force_minimal_pipe_splitting = true;
+			} else if (surface_count > 2 && cur_stream_status->plane_count < surface_count) {
+				force_minimal_pipe_splitting = true;
+				*is_plane_addition = true;
+			}
+		}
+	}
+
+	return force_minimal_pipe_splitting;
+}
+
 static bool commit_minimal_transition_state(struct dc *dc,
 		struct dc_state *transition_base_context)
 {
 	struct dc_state *transition_context = dc_create_state(dc);
-	enum pipe_split_policy tmp_policy;
+	enum pipe_split_policy tmp_mpc_policy;
+	bool temp_dynamic_odm_policy;
 	enum dc_status ret = DC_ERROR_UNEXPECTED;
 	unsigned int i, j;
 
@@ -3533,10 +3593,13 @@ static bool commit_minimal_transition_state(struct dc *dc,
 		return false;
 
 	if (!dc->config.is_vmin_only_asic) {
-		tmp_policy = dc->debug.pipe_split_policy;
+		tmp_mpc_policy = dc->debug.pipe_split_policy;
 		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
 	}
 
+	temp_dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
+	dc->debug.enable_single_display_2to1_odm_policy = false;
+
 	dc_resource_state_copy_construct(transition_base_context, transition_context);
 
 	//commit minimal state
@@ -3560,9 +3623,11 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	//always release as dc_commit_state_no_check retains in good case
 	dc_release_state(transition_context);
 
-	//restore previous pipe split policy
+	//restore previous pipe split and odm policy
 	if (!dc->config.is_vmin_only_asic)
-		dc->debug.pipe_split_policy = tmp_policy;
+		dc->debug.pipe_split_policy = tmp_mpc_policy;
+
+	dc->debug.enable_single_display_2to1_odm_policy = temp_dynamic_odm_policy;
 
 	if (ret != DC_OK) {
 		//this should never happen
@@ -3593,24 +3658,14 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	 * cause underflow. Apply stream configuration with minimal pipe
 	 * split first to avoid unsupported transitions for active pipes.
 	 */
-	bool force_minimal_pipe_splitting = false;
-	bool is_plane_addition = false;
+	bool force_minimal_pipe_splitting;
+	bool is_plane_addition;
 
-	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
-
-	if (cur_stream_status &&
-			dc->current_state->stream_count > 0 &&
-			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID) {
-		/* determine if minimal transition is required */
-		if (surface_count > 0) {
-			if (cur_stream_status->plane_count > surface_count) {
-				force_minimal_pipe_splitting = true;
-			} else if (cur_stream_status->plane_count < surface_count) {
-				force_minimal_pipe_splitting = true;
-				is_plane_addition = true;
-			}
-		}
-	}
+	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
+			dc,
+			stream,
+			surface_count,
+			&is_plane_addition);
 
 	/* on plane addition, minimal state is the current one */
 	if (force_minimal_pipe_splitting && is_plane_addition &&
@@ -3627,7 +3682,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 			&context))
 		return false;
 
-	/* on plane addition, minimal state is the new one */
+	/* on plane removal, minimal state is the new one */
 	if (force_minimal_pipe_splitting && !is_plane_addition) {
 		if (!commit_minimal_transition_state(dc, context)) {
 			dc_release_state(context);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 659c71778a64..bbc352b18bf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -846,6 +846,7 @@ struct dc_debug_options {
 	bool use_legacy_soc_bb_mechanism;
 	bool exit_idle_opt_for_cursor_updates;
 	bool enable_single_display_2to1_odm_policy;
+	bool enable_double_buffered_dsc_pg_support;
 	bool enable_dp_dig_pixel_rate_div_policy;
 	enum lttpr_mode lttpr_mode_override;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 7544ac8e33ac..6baea56f259c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1375,3 +1375,57 @@ void dcn32_update_phantom_vp_position(struct dc *dc,
 		}
 	}
 }
+
+bool dcn32_dsc_pg_status(
+		struct dce_hwseq *hws,
+		unsigned int dsc_inst)
+{
+	uint32_t pwr_status = 0;
+
+	switch (dsc_inst) {
+	case 0: /* DSC0 */
+		REG_GET(DOMAIN16_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 1: /* DSC1 */
+
+		REG_GET(DOMAIN17_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 2: /* DSC2 */
+		REG_GET(DOMAIN18_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	case 3: /* DSC3 */
+		REG_GET(DOMAIN19_PG_STATUS,
+				DOMAIN_PGFSM_PWR_STATUS, &pwr_status);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	return pwr_status == 0 ? true : false;
+}
+
+void dcn32_update_dsc_pg(struct dc *dc,
+		struct dc_state *context,
+		bool safe_to_disable)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+
+	for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+		struct display_stream_compressor *dsc = dc->res_pool->dscs[i];
+		bool is_dsc_ungated = hws->funcs.dsc_pg_status(hws, dsc->inst);
+
+		if (context->res_ctx.is_dsc_acquired[i]) {
+			if (!is_dsc_ungated) {
+				hws->funcs.dsc_pg_control(hws, dsc->inst, true);
+			}
+		} else if (safe_to_disable) {
+			if (is_dsc_ungated) {
+				hws->funcs.dsc_pg_control(hws, dsc->inst, false);
+			}
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 86c018b2f132..ac3657a5b9ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -92,4 +92,12 @@ void dcn32_update_phantom_vp_position(struct dc *dc,
 		struct dc_state *context,
 		struct pipe_ctx *phantom_pipe);
 
+bool dcn32_dsc_pg_status(
+		struct dce_hwseq *hws,
+		unsigned int dsc_inst);
+
+void dcn32_update_dsc_pg(struct dc *dc,
+		struct dc_state *context,
+		bool safe_to_disable);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index c66dfe14909a..45a949ba6f3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -109,6 +109,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
+	.update_dsc_pg = dcn32_update_dsc_pg,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
@@ -138,6 +139,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn32_update_odm,
 	.dsc_pg_control = dcn32_dsc_pg_control,
+	.dsc_pg_status = dcn32_dsc_pg_status,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f8c6afacf633..38dc46da2b63 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -718,6 +718,9 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_disable_subvp = false,
 	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
+
+	// Must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
+	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
 	.alloc_extra_way_for_cursor = true,
@@ -1846,7 +1849,7 @@ int dcn32_populate_dml_pipes_from_context(
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool subvp_in_use = false;
-	int plane_count = 0;
+	uint8_t is_pipe_split_expected[MAX_PIPES] = {0};
 	struct dc_crtc_timing *timing;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
@@ -1865,12 +1868,12 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
-				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream)) {
-			if (dc->debug.enable_single_display_2to1_odm_policy) {
-				if (!((plane_count > 2) && pipe->top_pipe))
-					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
-			}
+		if (context->stream_count == 1 &&
+				context->stream_status[0].plane_count <= 1 &&
+				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
+				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
+				dc->debug.enable_single_display_2to1_odm_policy) {
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
 		}
 		pipe_cnt++;
 	}
@@ -1927,12 +1930,10 @@ int dcn32_populate_dml_pipes_from_context(
 			}
 		}
 
-		/* Calculate the number of planes we have so we can determine
-		 *  whether to apply ODM 2to1 policy or not
-		 */
-		if (pipe->stream && !pipe->prev_odm_pipe &&
-				(!pipe->top_pipe || pipe->top_pipe->plane_state != pipe->plane_state))
-			++plane_count;
+		DC_FP_START();
+		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, &pipes[pipe_cnt]);
+		DC_FP_END();
+
 		pipe_cnt++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index c772ef962194..20382bd4758c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -718,6 +718,9 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_disable_subvp = false,
 	.exit_idle_opt_for_cursor_updates = true,
 	.enable_single_display_2to1_odm_policy = true,
+
+	//must match enable_single_display_2to1_odm_policy to support dynamic ODM transitions
+	.enable_double_buffered_dsc_pg_support = true,
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
 	.alloc_extra_way_for_cursor = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6687cfed2ca9..3202b52224b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1119,6 +1119,8 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	    dc->debug.force_subvp_mclk_switch)) {
 
 		dcn32_merge_pipes_for_subvp(dc, context);
+		memset(merge, 0, MAX_PIPES * sizeof(bool));
+		
 		// to re-initialize viewport after the pipe merge
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -1588,6 +1590,28 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 			if (pipe->next_odm_pipe)
 				pipe->next_odm_pipe->prev_odm_pipe = pipe->prev_odm_pipe;
 
+			//2:1ODM+MPC Split MPO to Single Pipe + MPC Split MPO
+			if (pipe->bottom_pipe) {
+				if (pipe->bottom_pipe->prev_odm_pipe || pipe->bottom_pipe->next_odm_pipe) {
+					//MPC split rules will handle this case
+					pipe->bottom_pipe->top_pipe = NULL;
+				} else {
+					if (pipe->prev_odm_pipe->bottom_pipe) {
+						// 3 plane MPO
+						pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe->bottom_pipe;
+						pipe->prev_odm_pipe->bottom_pipe->bottom_pipe = pipe->bottom_pipe;
+					} else {
+						// 2 plane MPO
+						pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe;
+						pipe->prev_odm_pipe->bottom_pipe = pipe->bottom_pipe;
+					}
+				}
+			}
+
+			if (pipe->top_pipe) {
+				pipe->top_pipe->bottom_pipe = NULL;
+			}
+
 			pipe->bottom_pipe = NULL;
 			pipe->next_odm_pipe = NULL;
 			pipe->plane_state = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 416b700a8d5a..60cbd423c911 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -89,6 +89,7 @@ struct hw_sequencer_funcs {
 		struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
 	void (*update_pending_status)(struct pipe_ctx *pipe_ctx);
 	void (*power_down)(struct dc *dc);
+	void (*update_dsc_pg)(struct dc *dc, struct dc_state *context, bool safe_to_disable);
 
 	/* Pipe Lock Related */
 	void (*pipe_control_lock)(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 1cdea0efe5c1..a4d61bb724b6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -124,6 +124,8 @@ struct hwseq_private_funcs {
 	void (*dsc_pg_control)(struct dce_hwseq *hws,
 			unsigned int dsc_inst,
 			bool power_on);
+	bool (*dsc_pg_status)(struct dce_hwseq *hws,
+			unsigned int dsc_inst);
 	void (*update_odm)(struct dc *dc, struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
 	void (*program_all_writeback_pipes_in_tree)(struct dc *dc,
-- 
2.25.1


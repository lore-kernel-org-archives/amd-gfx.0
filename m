Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211AAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE8C20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HpbCNm/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE8C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A160E6ECEF;
	Fri, 15 May 2020 18:13:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6522B6ECEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfPBf1zO7slx7zIwwrZDoaIlrrLz5uLIcPWkewko//TqQLTuJjgr68QXRCskCpVKHf3QM72gTPgf7scxJpgJ6OA77zL0t2/OxQmg+CqCBnJ22ZmMCQtSzssAAboCSRma56HiN4hiUf7jZoIBOe8QftM0vZRlSqqupZosWMNyTjfxVE4ryr1VGeH5es1mSD6bRgTcmGdaB8zldGSCDT5tmGA3KT83vWo3i47hrTtoPhC2keF8d4iFB3sKvHA0Mr4nxSI5XV9WssKDIayBCM9PTs5hEXX/Hp+Ht4EUh/hm/XPdnAUqTrNz8uWkzs7tImxKK+jMIqDfZelttQhLe+ndGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlZyQa1g1ycoxZrcGl6R7f9hrrrmRV2lAsT3u8cDvFU=;
 b=YH+mpt0b+RtIQbPVkXQftfsrbF6JlfpJCMFc9blP80/X3DQfxQIT6EiCtfKWSNCPBXS1xsux/lwGocXluT4qVeTfj/D7cZ/uhxmPwLJj8Z6AUXKnNpFIgvUqbcsbsgR4v3wdwGd2A+qFZnTB3/luCwgZjVzJeRFLIMif4vWU5QUmubYcCngt2SbemuVtiZ2y/c/U2XbNpn4sw2ViBxP0xw1Khhxv6MvVIq9DeYM2dFwFaWwqy8vwDyYdzP/av5/SGSnp5fc0/6RRwOY6G4D/6FpbwmLXkSo3WzUfamOBSboMSU/nT5zdYl9jXSSK3Oyk0Aq2lJUOIHlzpRn+Ihnu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlZyQa1g1ycoxZrcGl6R7f9hrrrmRV2lAsT3u8cDvFU=;
 b=HpbCNm/wQEDD8uxmLKABp/RozUFWEvdxa47xtPosffNYtwgRxAQ1sEO+m3AuXRICql29kAvMpa2SnfMqzGGh1ORokZc4ZWRohupm5YEZouYb3up+lFXBUEwd51siUg4uAKXIZQmFwU3Aheq5HEHiur85VN8waAF3SeF6DM0ro68=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:13:39 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/27] drm/amd/display: fix and simplify pipe split logic
Date: Fri, 15 May 2020 14:12:49 -0400
Message-Id: <20200515181315.1237251-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:38 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0e53c35-6874-4f95-c5e2-08d7f8fbb12f
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39746E0629085635C3FF97DB98BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taU+hZJS5Dwfh8tu+f4m13lp12e0UFZrUP1/ZJUZjOsczOR6+8ewjAqrYNbnGiKme+SZIFdqokMG5SLLmOVELJcPD6XHI+L8ZoxjMhmbEzDsx4R55+f4F2b8nWP3GXSE00u06wubK0lP1D4tPpWWVN7Ki08jj6QJUaxoE6jkORBp7BxvHbKINrvI56P13F3IBVqyP2A1SbzHlfoMxWaEcpkgCOIt43frsvtIn2v66kwGUbi+U6gHockyRjYB1bMn8YQnNuwJ4lI8huxx1oxXDyd0dNt/Kdr7EHG/U3i+X4qfWDqD7HBfgoD5S4jlLAG28P5H9M4hT2in22QwWeIYW3bQPgb8pMuNVOUPmz7gThflFGftS25u2LWb31XtMjAhBizrCQVFEUtRzwpAqLgYtBPxL4ssrN+eE/vHCiGNJG2HPrcdp0gxLkIBb7v/MgUr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(30864003)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oZX8uzL91y1IUHRtPAyo2cPlnxLED2GJSLCDq+y/ZzDOchVkbzVJ3VmZcUw1UgznNhk05B67wabOYSy2SKMxbMfHaW0h2CPbrEt7fJfljl2owM4Lb2XHoqSXgWceKqJqCU/079jY0mtMlZEdZ2W3mt0ItxG4VwPpuDJrHhEsAwI0l646fVjA5464LGZ9UBkOoQMyqADLR0PL9lYD+wzkJS/ENhXzpoZ2CqIJYaVXumia8Z8GvFx4CEF8yqx9PECHn/o56D2Mj6cUat6GmP6MVn3bY5WZkqVlTYTCgeVTNFavZzonuVc0Su/5A73lPhiI+WJsPEvJ2WEjDtwM/o2VHOTpg4lHCO/5pJPpFFKJeMJwaEg9Tj+CnMvNaYdPMPWDjyZ+4muoGRCxxkwbiDP4uLlmOfA+XdkjFZxaUkWuL+oQALHJORgYDxidCdb45Mbz67sxbzriafT6Kb9/r6DcWIvxit4CTxKkZRlFI2ALjlWFQzNJkJN6HtfuJr9OotLyzbohR5EjViFVN/5ogpbLuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e53c35-6874-4f95-c5e2-08d7f8fbb12f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:39.1886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFCPuewU9TjLM+YoGP7czILy2zOkU+LCKFtPEVH0bq97cF8Lt9n4Ly0LDx5cHO6+6YWHojiuZ7pYImf3bxZclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Current odm/mpc combine logic to detect which pipes need to split
logically is flawed leading to incorrect pipe merge/split operations
being taken.

This change cleans up the logic and fixes the logical errors.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  25 ++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 153 ++++++++----------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   2 +
 4 files changed, 94 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bbef8c67d1db..0c5619364e7d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -532,6 +532,24 @@ static inline void get_vp_scan_direction(
 		*flip_horz_scan_dir = !*flip_horz_scan_dir;
 }
 
+int get_num_mpc_splits(struct pipe_ctx *pipe)
+{
+	int mpc_split_count = 0;
+	struct pipe_ctx *other_pipe = pipe->bottom_pipe;
+
+	while (other_pipe && other_pipe->plane_state == pipe->plane_state) {
+		mpc_split_count++;
+		other_pipe = other_pipe->bottom_pipe;
+	}
+	other_pipe = pipe->top_pipe;
+	while (other_pipe && other_pipe->plane_state == pipe->plane_state) {
+		mpc_split_count++;
+		other_pipe = other_pipe->top_pipe;
+	}
+
+	return mpc_split_count;
+}
+
 int get_num_odm_splits(struct pipe_ctx *pipe)
 {
 	int odm_split_count = 0;
@@ -556,16 +574,11 @@ static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *spli
 		/*Check for mpc split*/
 		struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
 
+		*split_count = get_num_mpc_splits(pipe_ctx);
 		while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
 			(*split_idx)++;
-			(*split_count)++;
 			split_pipe = split_pipe->top_pipe;
 		}
-		split_pipe = pipe_ctx->bottom_pipe;
-		while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
-			(*split_count)++;
-			split_pipe = split_pipe->bottom_pipe;
-		}
 	} else {
 		/*Get odm split index*/
 		struct pipe_ctx *split_pipe = pipe_ctx->prev_odm_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 4912160f81b3..4190ee592e6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1663,7 +1663,7 @@ enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state
 }
 
 
-static void acquire_dsc(const struct dc *dc,
+void dcn20_acquire_dsc(const struct dc *dc,
 			struct resource_context *res_ctx,
 			struct display_stream_compressor **dsc,
 			int pipe_idx)
@@ -1731,7 +1731,7 @@ enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc,
 		if (pipe_ctx->stream_res.dsc)
 			continue;
 
-		acquire_dsc(dc, &dc_ctx->res_ctx, &pipe_ctx->stream_res.dsc, i);
+		dcn20_acquire_dsc(dc, &dc_ctx->res_ctx, &pipe_ctx->stream_res.dsc, i);
 
 		/* The number of DSCs can be less than the number of pipes */
 		if (!pipe_ctx->stream_res.dsc) {
@@ -1923,7 +1923,7 @@ bool dcn20_split_stream_for_odm(
 	}
 	next_odm_pipe->stream_res.opp = pool->opps[next_odm_pipe->pipe_idx];
 	if (next_odm_pipe->stream->timing.flags.DSC == 1) {
-		acquire_dsc(dc, res_ctx, &next_odm_pipe->stream_res.dsc, next_odm_pipe->pipe_idx);
+		dcn20_acquire_dsc(dc, res_ctx, &next_odm_pipe->stream_res.dsc, next_odm_pipe->pipe_idx);
 		ASSERT(next_odm_pipe->stream_res.dsc);
 		if (next_odm_pipe->stream_res.dsc == NULL)
 			return false;
@@ -2586,27 +2586,6 @@ static void dcn20_merge_pipes_for_validate(
 	}
 }
 
-int dcn20_find_previous_split_count(struct pipe_ctx *pipe)
-{
-	int previous_split = 1;
-	struct pipe_ctx *current_pipe = pipe;
-
-	while (current_pipe->bottom_pipe) {
-		if (current_pipe->plane_state != current_pipe->bottom_pipe->plane_state)
-			break;
-		previous_split++;
-		current_pipe = current_pipe->bottom_pipe;
-	}
-	current_pipe = pipe;
-	while (current_pipe->top_pipe) {
-		if (current_pipe->plane_state != current_pipe->top_pipe->plane_state)
-			break;
-		previous_split++;
-		current_pipe = current_pipe->top_pipe;
-	}
-	return previous_split;
-}
-
 int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
@@ -2618,6 +2597,8 @@ int dcn20_validate_apply_pipe_split_flags(
 	int plane_count = 0;
 	bool force_split = false;
 	bool avoid_split = dc->debug.pipe_split_policy == MPC_SPLIT_AVOID;
+	struct vba_vars_st *v = &context->bw_ctx.dml.vba;
+	int max_mpc_comb = v->maxMpcComb;
 
 	if (context->stream_count > 1) {
 		if (dc->debug.pipe_split_policy == MPC_SPLIT_AVOID_MULT_DISP)
@@ -2638,15 +2619,13 @@ int dcn20_validate_apply_pipe_split_flags(
 
 	/* Avoid split loop looks for lowest voltage level that allows most unsplit pipes possible */
 	if (avoid_split) {
-		int max_mpc_comb = context->bw_ctx.dml.vba.maxMpcComb;
-
 		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			if (!context->res_ctx.pipe_ctx[i].stream)
 				continue;
 
 			for (vlevel_split = vlevel; vlevel <= context->bw_ctx.dml.soc.num_states; vlevel++)
-				if (context->bw_ctx.dml.vba.NoOfDPP[vlevel][0][pipe_idx] == 1 &&
-						context->bw_ctx.dml.vba.ModeSupport[vlevel][0])
+				if (v->NoOfDPP[vlevel][0][pipe_idx] == 1 &&
+						v->ModeSupport[vlevel][0])
 					break;
 			/* Impossible to not split this pipe */
 			if (vlevel > context->bw_ctx.dml.soc.num_states)
@@ -2655,21 +2634,21 @@ int dcn20_validate_apply_pipe_split_flags(
 				max_mpc_comb = 0;
 			pipe_idx++;
 		}
-		context->bw_ctx.dml.vba.maxMpcComb = max_mpc_comb;
+		v->maxMpcComb = max_mpc_comb;
 	}
 
 	/* Split loop sets which pipe should be split based on dml outputs and dc flags */
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		int pipe_plane = context->bw_ctx.dml.vba.pipe_plane[pipe_idx];
+		int pipe_plane = v->pipe_plane[pipe_idx];
+		bool split4mpc = context->stream_count == 1 && plane_count == 1
+				&& dc->config.enable_4to1MPC && dc->res_pool->pipe_count >= 4;
 
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
 
-		if (force_split
-				|| context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_plane] > 1) {
-			if (context->stream_count == 1 && plane_count == 1
-					&& dc->config.enable_4to1MPC && dc->res_pool->pipe_count >= 4)
+		if (force_split || v->NoOfDPP[vlevel][max_mpc_comb][pipe_plane] > 1) {
+			if (split4mpc)
 				split[i] = 4;
 			else
 				split[i] = 2;
@@ -2685,66 +2664,72 @@ int dcn20_validate_apply_pipe_split_flags(
 			split[i] = 2;
 		if (dc->debug.force_odm_combine & (1 << pipe->stream_res.tg->inst)) {
 			split[i] = 2;
-			context->bw_ctx.dml.vba.ODMCombineEnablePerState[vlevel][pipe_plane] = dm_odm_combine_mode_2to1;
+			v->ODMCombineEnablePerState[vlevel][pipe_plane] = dm_odm_combine_mode_2to1;
 		}
-		context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] =
-			context->bw_ctx.dml.vba.ODMCombineEnablePerState[vlevel][pipe_plane];
-
-		if (pipe->prev_odm_pipe && context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] != dm_odm_combine_mode_disabled) {
-			/*Already split odm pipe tree, don't try to split again*/
-			split[i] = 0;
-			split[pipe->prev_odm_pipe->pipe_idx] = 0;
-		} else if (pipe->top_pipe && pipe->plane_state == pipe->top_pipe->plane_state
-				&& context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] == dm_odm_combine_mode_disabled) {
-			/*If 2 way split but can support 4 way split, then split each pipe again*/
-			if (context->stream_count == 1 && plane_count == 1
-					&& dc->config.enable_4to1MPC && dc->res_pool->pipe_count >= 4) {
-				split[i] = 2;
-			} else {
+		v->ODMCombineEnabled[pipe_plane] =
+			v->ODMCombineEnablePerState[vlevel][pipe_plane];
+
+		if (v->ODMCombineEnabled[pipe_plane] == dm_odm_combine_mode_disabled) {
+			if (get_num_mpc_splits(pipe) == 1) {
+				/*If need split for mpc but 2 way split already*/
+				if (split[i] == 4)
+					split[i] = 2; /* 2 -> 4 MPC */
+				else if (split[i] == 2)
+					split[i] = 0; /* 2 -> 2 MPC */
+				else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state)
+					merge[i] = true; /* 2 -> 1 MPC */
+			} else if (get_num_mpc_splits(pipe) == 3) {
+				/*If need split for mpc but 4 way split already*/
+				if (split[i] == 2 && ((pipe->top_pipe && !pipe->top_pipe->top_pipe)
+						|| !pipe->bottom_pipe)) {
+					merge[i] = true; /* 4 -> 2 MPC */
+				} else if (split[i] == 0 && pipe->top_pipe &&
+						pipe->top_pipe->plane_state == pipe->plane_state)
+					merge[i] = true; /* 4 -> 1 MPC */
 				split[i] = 0;
-				split[pipe->top_pipe->pipe_idx] = 0;
-			}
-		} else if (pipe->prev_odm_pipe || (dcn20_find_previous_split_count(pipe) == 2 && pipe->top_pipe)) {
-			if (split[i] == 0) {
-				/*Exiting mpc/odm combine*/
-				merge[i] = true;
-			} else {
-				/*Transition from mpc combine to odm combine or vice versa*/
-				ASSERT(0); /*should not actually happen yet*/
-				split[i] = 2;
-				merge[i] = true;
+			} else if (get_num_odm_splits(pipe)) {
+				/* ODM -> MPC transition */
+				ASSERT(0); /* NOT expected yet */
 				if (pipe->prev_odm_pipe) {
-					split[pipe->prev_odm_pipe->pipe_idx] = 2;
-					merge[pipe->prev_odm_pipe->pipe_idx] = true;
-				} else {
-					split[pipe->top_pipe->pipe_idx] = 2;
-					merge[pipe->top_pipe->pipe_idx] = true;
+					split[i] = 0;
+					merge[i] = true;
 				}
 			}
-		} else if (dcn20_find_previous_split_count(pipe) == 3) {
-			if (split[i] == 0 && !pipe->top_pipe) {
-				merge[pipe->bottom_pipe->pipe_idx] = true;
-				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
-			} else if (split[i] == 2 && !pipe->top_pipe) {
-				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
-				split[i] = 0;
-			}
-		} else if (dcn20_find_previous_split_count(pipe) == 4) {
-			if (split[i] == 0 && !pipe->top_pipe) {
-				merge[pipe->bottom_pipe->pipe_idx] = true;
-				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
-				merge[pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
-			} else if (split[i] == 2 && !pipe->top_pipe) {
-				merge[pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
-				merge[pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx] = true;
+		} else {
+			if (get_num_odm_splits(pipe) == 1) {
+				/*If need split for odm but 2 way split already*/
+				if (split[i] == 4)
+					split[i] = 2; /* 2 -> 4 ODM */
+				else if (split[i] == 2)
+					split[i] = 0; /* 2 -> 2 ODM */
+				else if (pipe->prev_odm_pipe) {
+					ASSERT(0); /* NOT expected yet */
+					merge[i] = true; /* exit ODM */
+				}
+			} else if (get_num_odm_splits(pipe) == 3) {
+				/*If need split for odm but 4 way split already*/
+				if (split[i] == 2 && ((pipe->prev_odm_pipe && !pipe->prev_odm_pipe->prev_odm_pipe)
+						|| !pipe->next_odm_pipe)) {
+					ASSERT(0); /* NOT expected yet */
+					merge[i] = true; /* 4 -> 2 ODM */
+				} else if (split[i] == 0 && pipe->prev_odm_pipe) {
+					ASSERT(0); /* NOT expected yet */
+					merge[i] = true; /* exit ODM */
+				}
 				split[i] = 0;
+			} else if (get_num_mpc_splits(pipe)) {
+				/* MPC -> ODM transition */
+				ASSERT(0); /* NOT expected yet */
+				if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
+					split[i] = 0;
+					merge[i] = true;
+				}
 			}
 		}
 
 		/* Adjust dppclk when split is forced, do not bother with dispclk */
-		if (split[i] != 0
-				&& context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] == 1)
-			context->bw_ctx.dml.vba.RequiredDPPCLK[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] /= 2;
+		if (split[i] != 0 && v->NoOfDPP[vlevel][max_mpc_comb][pipe_idx] == 1)
+			v->RequiredDPPCLK[vlevel][max_mpc_comb][pipe_idx] /= 2;
 		pipe_idx++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index ed5d31253314..2c1959845c29 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -119,7 +119,6 @@ void dcn20_set_mcif_arb_params(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt);
 bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context, bool fast_validate);
-int dcn20_find_previous_split_count(struct pipe_ctx *pipe);
 int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
@@ -140,6 +139,10 @@ bool dcn20_split_stream_for_odm(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *prev_odm_pipe,
 		struct pipe_ctx *next_odm_pipe);
+void dcn20_acquire_dsc(const struct dc *dc,
+			struct resource_context *res_ctx,
+			struct display_stream_compressor **dsc,
+			int pipe_idx);
 struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 109c589eb97c..a9be495af922 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -177,6 +177,8 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
 
+int get_num_mpc_splits(struct pipe_ctx *pipe);
+
 int get_num_odm_splits(struct pipe_ctx *pipe);
 
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

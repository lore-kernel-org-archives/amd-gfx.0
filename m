Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA47C2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230842051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A0pgMb30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230842051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FFB6E484;
	Mon, 16 Mar 2020 13:50:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AEF6E479
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyE8B1JltnPCmdJCMLHTDL1XbtSgTyw/AQAMHUWMSnuCqYJQlB9NuuCKizeS2m3AV+VCwf+ebAAOtmLCF+Xc25VHZita8vPA2VjBqDuHEJVvjdXeuW1rOeeDrRy2ymjKK5fyNnR+wQOkPouKWYNZELjgn5EOF61XKQ+QU4NeHqSxlRHGxS6CvPcuR6myij7A+I6t3wqz0HzKZC3c1BYNl/eaxjfB7ghRfNRpJ65y0AS4JfvYGpynimT2HFnTgM9bRXpNH9haKD4JfVkX86rau5N820nJhJyaq2ulMAPbQKBWTxBM/EokPTm+oshjUob8M9Jq/NiHKzRVHnBBjRIguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4racHfru8klXxlDm5fet7rLmj0xmNEGJe/XaP7VwsxU=;
 b=nEJsydOyLhkOJaeiD6Vt7/1wjgURnW84I75hnyTLNZHXbcphQhCW7wXtnxAoQZ39b/wCFPHIlPUWR/ZKFZ78BvYYDlsdTyrMmL09EFK4Eb2h4Ol2cqZPqbSvR5OapHSaaSGdbrorhiAbI6pjt7Iic43R0JWg9FtfAhWDaYLzkjaimMJDosOyh6udwlk9Mnkn8/xRi2Tl4rRORxdTQNPEDNez9o9+P11E2sik6C9oUB9uvONxtNGEO1+fm/3IN5L9NlKEchZNJ+p6omoBkD3qxhT59O7sy5qiKA92loB3RS16yHyJYUI0KfxSHEEu+r7qhpc9sgkxoOWEJyam9CV02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4racHfru8klXxlDm5fet7rLmj0xmNEGJe/XaP7VwsxU=;
 b=A0pgMb30vDk/ZVzH3hsIBQdVUHOTXSYwhLirYubQIbP+28FeDtGyNG01/NXrboU879tQArka47YGCmaX4A2mxyFf0G63BlFeN+sDYEoqR7/AijbVKmiSEA1xueFus+HqDb+vJcMJJEj4N7JS35yWq9Lf671W5UwDw8vGIiv5Rf8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:13 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:13 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/19] drm/amd/display: add on demand pipe merge logic for
 dcn2+
Date: Mon, 16 Mar 2020 09:49:20 -0400
Message-Id: <20200316134920.2526155-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:12 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2725cb85-5cc0-43e8-beb9-08d7c9b0f381
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23968A2EF6F7B32F20F314AE98F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMJW6z4vS6BRjOEyRiiEqXHC0LKfkPhcW2xoKzuoCgjBf8nb/L3aGSsjysIrpVaIKbVUPAAkRVDC3s5PM0eS5M0He1dDui1zrzKw05GKoT2TZWTBG/iutxEUBZNUh5aDermbf+Md3GPu/j3apTpZfiX+l6HZGmOBC0sldxzCZ+kX99wMPaOkvTRfUMYqzemNpjXTM0vSkuwWQLf4OL+OI0rca+7hzGWY/2w4ECkwtIqJkFDvL0j0VPqLo68XkpU20FzVtHqhMNJ2PmdCqnnT+rgGk6ZFgfSQQny76GY/slFz/JLcvomZouMj+RsTc//ivFWfJHgkxrWSxKGTnzMjHARuafV9JLbGB94rOThAATIOBvLcFG99RPWTkbFTLSnn3Uyw+rBAkRwwQ2GXoto7QOfYMPx+wubIhvUBxWPF7RgLTiDNAsvDwJ+wHfsBwCc7
X-MS-Exchange-AntiSpam-MessageData: zmE922jUJqG6SfAwcwKVCUMVGutpnVFP7hNChEj640gNFemrIRR5jO0hSAiVl4t5PLK1OiE0uAP7aYUrsp+GhLIIHztakM02vF11JkP6eii7etB4CpewFNoNqZNB1Nj/exN3VBi+09is7GUjOZg8ow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2725cb85-5cc0-43e8-beb9-08d7c9b0f381
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:13.6136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGSueK6dIYQPlVJ7iNIrjo1mJTxHJ2fVKkLpd7a3vzWY4AcjXVozZQM+ry6iKgiRTmjRtrZPiXqDBTNmrBEcJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Adds logic that will determine if pipes need merging during validation.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 ++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 56 +++++++++++++++----
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  9 +--
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3a1a5aef524d..75c7ce4c7581 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -893,6 +893,7 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
 			|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
 	bool orthogonal_rotation, flip_vert_scan_dir, flip_horz_scan_dir;
+	int odm_idx = 0;
 
 	/*
 	 * Need to calculate the scan direction for viewport to make adjustments
@@ -924,11 +925,13 @@ static void calculate_inits_and_adj_vp(struct pipe_ctx *pipe_ctx)
 					* stream->dst.width / stream->src.width -
 					src.x * plane_state->dst_rect.width / src.width
 					* stream->dst.width / stream->src.width);
-	/*modified recout_skip_h calculation due to odm having no recout offset caused by split*/
+	/*modified recout_skip_h calculation due to odm having no recout offset*/
 	while (odm_pipe) {
-		recout_skip_h += odm_pipe->plane_res.scl_data.recout.width + odm_pipe->plane_res.scl_data.recout.x;
+		odm_idx++;
 		odm_pipe = odm_pipe->prev_odm_pipe;
 	}
+	if (odm_idx)
+		recout_skip_h += odm_idx * data->recout.width;
 
 	recout_skip_v = data->recout.y - (stream->dst.y + (plane_state->dst_rect.y - stream->src.y)
 					* stream->dst.height / stream->src.height -
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e25ed6235812..a67395208991 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1671,7 +1671,7 @@ static void acquire_dsc(struct resource_context *res_ctx,
 		}
 }
 
-static void release_dsc(struct resource_context *res_ctx,
+void dcn20_release_dsc(struct resource_context *res_ctx,
 			const struct resource_pool *pool,
 			struct display_stream_compressor **dsc)
 {
@@ -1731,7 +1731,7 @@ static enum dc_status remove_dsc_from_stream_resource(struct dc *dc,
 			pipe_ctx = &new_ctx->res_ctx.pipe_ctx[i];
 
 			if (pipe_ctx->stream_res.dsc)
-				release_dsc(&new_ctx->res_ctx, dc->res_pool, &pipe_ctx->stream_res.dsc);
+				dcn20_release_dsc(&new_ctx->res_ctx, dc->res_pool, &pipe_ctx->stream_res.dsc);
 		}
 	}
 
@@ -2502,7 +2502,7 @@ struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
 	return secondary_pipe;
 }
 
-void dcn20_merge_pipes_for_validate(
+static void dcn20_merge_pipes_for_validate(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -2527,7 +2527,7 @@ void dcn20_merge_pipes_for_validate(
 			odm_pipe->prev_odm_pipe = NULL;
 			odm_pipe->next_odm_pipe = NULL;
 			if (odm_pipe->stream_res.dsc)
-				release_dsc(&context->res_ctx, dc->res_pool, &odm_pipe->stream_res.dsc);
+				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &odm_pipe->stream_res.dsc);
 			/* Clear plane_res and stream_res */
 			memset(&odm_pipe->plane_res, 0, sizeof(odm_pipe->plane_res));
 			memset(&odm_pipe->stream_res, 0, sizeof(odm_pipe->stream_res));
@@ -2565,7 +2565,8 @@ int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
 		int vlevel,
-		bool *split)
+		bool *split,
+		bool *merge)
 {
 	int i, pipe_idx, vlevel_split;
 	int plane_count = 0;
@@ -2609,11 +2610,12 @@ int dcn20_validate_apply_pipe_split_flags(
 	/* Split loop sets which pipe should be split based on dml outputs and dc flags */
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		int pipe_plane = context->bw_ctx.dml.vba.pipe_plane[pipe_idx];
 
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
 
-		if (force_split || context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] > 1)
+		if (force_split || context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_plane] > 1)
 			split[i] = true;
 		if ((pipe->stream->view_format ==
 				VIEW_3D_FORMAT_SIDE_BY_SIDE ||
@@ -2626,10 +2628,44 @@ int dcn20_validate_apply_pipe_split_flags(
 			split[i] = true;
 		if (dc->debug.force_odm_combine & (1 << pipe->stream_res.tg->inst)) {
 			split[i] = true;
-			context->bw_ctx.dml.vba.ODMCombineEnablePerState[vlevel][pipe_idx] = dm_odm_combine_mode_2to1;
+			context->bw_ctx.dml.vba.ODMCombineEnablePerState[vlevel][pipe_plane] = dm_odm_combine_mode_2to1;
 		}
-		context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_idx] =
-			context->bw_ctx.dml.vba.ODMCombineEnablePerState[vlevel][pipe_idx];
+		context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] =
+			context->bw_ctx.dml.vba.ODMCombineEnablePerState[vlevel][pipe_plane];
+
+		if (pipe->prev_odm_pipe && context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] != dm_odm_combine_mode_disabled) {
+			/*Already split odm pipe tree, don't try to split again*/
+			split[i] = false;
+			split[pipe->prev_odm_pipe->pipe_idx] = false;
+		} else if (pipe->top_pipe && pipe->plane_state == pipe->top_pipe->plane_state
+				&& context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_plane] == dm_odm_combine_mode_disabled) {
+			/*Already split mpc tree, don't try to split again, assumes only 2x mpc combine*/
+			split[i] = false;
+			split[pipe->top_pipe->pipe_idx] = false;
+		} else if (pipe->prev_odm_pipe || (pipe->top_pipe && pipe->plane_state == pipe->top_pipe->plane_state)) {
+			if (split[i] == false) {
+				/*Exiting mpc/odm combine*/
+				merge[i] = true;
+				if (pipe->prev_odm_pipe) {
+					ASSERT(0); /*should not actually happen yet*/
+					merge[pipe->prev_odm_pipe->pipe_idx] = true;
+				} else
+					merge[pipe->top_pipe->pipe_idx] = true;
+			} else {
+				/*Transition from mpc combine to odm combine or vice versa*/
+				ASSERT(0); /*should not actually happen yet*/
+				split[i] = true;
+				merge[i] = true;
+				if (pipe->prev_odm_pipe) {
+					split[pipe->prev_odm_pipe->pipe_idx] = true;
+					merge[pipe->prev_odm_pipe->pipe_idx] = true;
+				} else {
+					split[pipe->top_pipe->pipe_idx] = true;
+					merge[pipe->top_pipe->pipe_idx] = true;
+				}
+			}
+		}
+
 		/* Adjust dppclk when split is forced, do not bother with dispclk */
 		if (split[i] && context->bw_ctx.dml.vba.NoOfDPP[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] == 1)
 			context->bw_ctx.dml.vba.RequiredDPPCLK[vlevel][context->bw_ctx.dml.vba.maxMpcComb][pipe_idx] /= 2;
@@ -2671,7 +2707,7 @@ bool dcn20_fast_validate_bw(
 	if (vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
 
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 5eadca0ae7ec..9d5bff9455fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -119,14 +119,15 @@ void dcn20_set_mcif_arb_params(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt);
 bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context, bool fast_validate);
-void dcn20_merge_pipes_for_validate(
-		struct dc *dc,
-		struct dc_state *context);
 int dcn20_validate_apply_pipe_split_flags(
 		struct dc *dc,
 		struct dc_state *context,
 		int vlevel,
-		bool *split);
+		bool *split,
+		bool *merge);
+void dcn20_release_dsc(struct resource_context *res_ctx,
+			const struct resource_pool *pool,
+			struct display_stream_compressor **dsc);
 bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx);
 void dcn20_split_stream_for_mpc(
 		struct resource_context *res_ctx,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

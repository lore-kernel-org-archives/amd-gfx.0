Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC110C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AD610E85E;
	Sat, 16 Jul 2022 14:35:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD3F10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZx+PJF+mji5VRlkKJAl3eZNtF6CxfyCbqUXFaATvPEwD7DVaHBganu5cS6a46LgZRYeOYrc9BU/zekcPKKFJhnaipGVvNIytNwIccPG+MMOmiKoqrvr1SCv8uPdNerICAdsKytSt1IpSiSTikOFVA7o1eVH/odiL6aidSKoxly/N3Eoxyc2g4hbXG0fmJOLal5foeUJPOi3v74w4tQNYwr0gnDnc+gz7sW0gcMgkHMFOB6VMOm84L2eyUfMECizo6m/B+2xBuDc0zboMOTSax3zR9HGf2IS0Al+y4BNRPSeQ/8bU6SIzD2eLsJmu6SoGbR/+Wz7hMD2UDPhJcA87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrXgPGq/W1xSwYNXCLb9OtzZt9L/L48OxtkTWlu1Jws=;
 b=e11x4Gxmz2JrBjP6kUhNt1Dtft3u4UQytxTs1ZGWPFZVSC4Z4JvFbi+bvZa3UuL75mwIjMifs39B3mw2KYZPaBo7+srrm7yXkidZSIsQkNP+GPNz2J3ur3JTVfgitdZ5KmZhJ9coAvIwogjL8ScvMF7lrOU/HU4nZOfcl0xkPlcz+mgobbKStmr6LIHjYOZPB/l2a2rbWwSpqCwaCQPIksox7WPORsu8v4+PCsRuR7xqH+hb3jYiU7J/gVYXJTmOkVjkir/cqrIf4+oO9tHWSprbVA1ByntPldN0OqiOqECI0A7or4R/HX7gDY7j7qPZig2i+qdO3Po109jAh8fStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrXgPGq/W1xSwYNXCLb9OtzZt9L/L48OxtkTWlu1Jws=;
 b=pwe34Cm2toknkeJX/qGJk/skixd7fVhTfKMmX+NtWZ5TpZA0Xnb1UObehEzmz+LWXsiDV9gxEur6pq0RGsvFJQ1xYCyvf5/ZWZK4s/o8pz/17LcwMDqx9GOwv/QlR3fMjMSPmxre7mBNb+gAIh7seM5KznAuO2wKNPcm9pKZpQg=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:17:56 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::42) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:53 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/31] drm/amd/display: Move dlg params calculation
Date: Fri, 15 Jul 2022 14:16:59 -0400
Message-ID: <20220715181705.1030401-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f35582f7-6748-4b00-8a54-08da668e56d6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FStWJEMKg6SQb9ACsElV/PrlKp8FMiuk9O5zpPiOpYQ7avAS/on/2IUG5xfu2Z86S5wgZ7IycpEATymwE2YotdHZ5nLKeRFJ/FIXN651T+dbCQyb/OTCZLW3myaacEY3z2Uu2M1acv8e8LuXwF92/LngK8Edylkwl7RO8ln54bHsWVneoOYmzpb+B6miN+9E8TV0rR4fstyc8SH04dlDxxHa89dbrmElgiC/ooFB1EY8LfJmapK/qhD5BA+FPCgDEpqxxUaiY3+ACa+B9IWN2olWBCXODxum86+9Hp0+OE3z7LREfXglGyTUbJO5HlTLCne3bXTwR5N/oTDH74EVe/LZ+pI7kpVoOE6xXZx6MSxK/D66euWVhscHZd95S2HFxzNXUR6oTYK/aR5Hkt2MBMrKaZ6qnxbusr8WY9AAuYc0VvbW5vcM7viT8LXzgmMu57czDiOdHHb3mI0RpyLVU/Cskezt9fEQo/KQcRNG4oLV3aFDTlPVLb27qiug/o/fQDfe/2him9WP3U+aaDyYM7WGCFZIsssX+lu7WYxHevp8koHiDROJbiB9r15WJlPizXSq/MUIuwnyk+p3ONBJ8PLAnBlcgOCWTyIAsajahHCzjjzMzJMTGUzLPMBX4jEk0r+Se7hm/hzbg23r8Ug9qdyhc4yuvRdeeF/vsMJCYB/Osj8Vt5RpYD5yvxpBQDnfTAqxPeDUSlpJ1w8Fk7TTLZdUBRUF3srxrdAp24UevnYcKLWD8KjAeAdFu7eRawhf73o8ioIevnhImQiiVGc5N9JXMwncNeL5LYvis5lpjletfWoDUNXy0elHbj8JmwqyrDNZsSCcVQun8zSo9wn3m1/R7qaoWXHjMkKDI3ajlgo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(40470700004)(426003)(336012)(36860700001)(47076005)(82310400005)(83380400001)(36756003)(186003)(2616005)(2906002)(1076003)(40460700003)(40480700001)(4326008)(70206006)(81166007)(70586007)(5660300002)(8676002)(86362001)(30864003)(54906003)(6916009)(26005)(356005)(82740400003)(478600001)(316002)(41300700001)(8936002)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:55.2449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35582f7-6748-4b00-8a54-08da668e56d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move dlg params calculation to the FPU folder and make it static.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 485 +----------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   6 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 506 +++++++++++++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  13 +-
 4 files changed, 513 insertions(+), 497 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 45768eff9315..32edb3e5715a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1753,368 +1753,6 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
 	}
 }
 
-static bool dcn32_split_stream_for_mpc_or_odm(
-		const struct dc *dc,
-		struct resource_context *res_ctx,
-		struct pipe_ctx *pri_pipe,
-		struct pipe_ctx *sec_pipe,
-		bool odm)
-{
-	int pipe_idx = sec_pipe->pipe_idx;
-	const struct resource_pool *pool = dc->res_pool;
-
-	if (pri_pipe->plane_state) {
-		/* ODM + window MPO, where MPO window is on left half only */
-		if (pri_pipe->plane_state->clip_rect.x + pri_pipe->plane_state->clip_rect.width <=
-				pri_pipe->stream->src.x + pri_pipe->stream->src.width/2)
-			return true;
-
-		/* ODM + window MPO, where MPO window is on right half only */
-		if (pri_pipe->plane_state->clip_rect.x >= pri_pipe->stream->src.width/2)
-			return true;
-	}
-
-	*sec_pipe = *pri_pipe;
-
-	sec_pipe->pipe_idx = pipe_idx;
-	sec_pipe->plane_res.mi = pool->mis[pipe_idx];
-	sec_pipe->plane_res.hubp = pool->hubps[pipe_idx];
-	sec_pipe->plane_res.ipp = pool->ipps[pipe_idx];
-	sec_pipe->plane_res.xfm = pool->transforms[pipe_idx];
-	sec_pipe->plane_res.dpp = pool->dpps[pipe_idx];
-	sec_pipe->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
-	sec_pipe->stream_res.dsc = NULL;
-	if (odm) {
-		if (pri_pipe->next_odm_pipe) {
-			ASSERT(pri_pipe->next_odm_pipe != sec_pipe);
-			sec_pipe->next_odm_pipe = pri_pipe->next_odm_pipe;
-			sec_pipe->next_odm_pipe->prev_odm_pipe = sec_pipe;
-		}
-		if (pri_pipe->top_pipe && pri_pipe->top_pipe->next_odm_pipe) {
-			pri_pipe->top_pipe->next_odm_pipe->bottom_pipe = sec_pipe;
-			sec_pipe->top_pipe = pri_pipe->top_pipe->next_odm_pipe;
-		}
-		if (pri_pipe->bottom_pipe && pri_pipe->bottom_pipe->next_odm_pipe) {
-			pri_pipe->bottom_pipe->next_odm_pipe->top_pipe = sec_pipe;
-			sec_pipe->bottom_pipe = pri_pipe->bottom_pipe->next_odm_pipe;
-		}
-		pri_pipe->next_odm_pipe = sec_pipe;
-		sec_pipe->prev_odm_pipe = pri_pipe;
-		ASSERT(sec_pipe->top_pipe == NULL);
-
-		if (!sec_pipe->top_pipe)
-			sec_pipe->stream_res.opp = pool->opps[pipe_idx];
-		else
-			sec_pipe->stream_res.opp = sec_pipe->top_pipe->stream_res.opp;
-		if (sec_pipe->stream->timing.flags.DSC == 1) {
-			dcn20_acquire_dsc(dc, res_ctx, &sec_pipe->stream_res.dsc, pipe_idx);
-			ASSERT(sec_pipe->stream_res.dsc);
-			if (sec_pipe->stream_res.dsc == NULL)
-				return false;
-		}
-	} else {
-		if (pri_pipe->bottom_pipe) {
-			ASSERT(pri_pipe->bottom_pipe != sec_pipe);
-			sec_pipe->bottom_pipe = pri_pipe->bottom_pipe;
-			sec_pipe->bottom_pipe->top_pipe = sec_pipe;
-		}
-		pri_pipe->bottom_pipe = sec_pipe;
-		sec_pipe->top_pipe = pri_pipe;
-
-		ASSERT(pri_pipe->plane_state);
-	}
-
-	return true;
-}
-
-static struct pipe_ctx *dcn32_find_split_pipe(
-		struct dc *dc,
-		struct dc_state *context,
-		int old_index)
-{
-	struct pipe_ctx *pipe = NULL;
-	int i;
-
-	if (old_index >= 0 && context->res_ctx.pipe_ctx[old_index].stream == NULL) {
-		pipe = &context->res_ctx.pipe_ctx[old_index];
-		pipe->pipe_idx = old_index;
-	}
-
-	if (!pipe)
-		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
-			if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe == NULL
-					&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
-				if (context->res_ctx.pipe_ctx[i].stream == NULL) {
-					pipe = &context->res_ctx.pipe_ctx[i];
-					pipe->pipe_idx = i;
-					break;
-				}
-			}
-		}
-
-	/*
-	 * May need to fix pipes getting tossed from 1 opp to another on flip
-	 * Add for debugging transient underflow during topology updates:
-	 * ASSERT(pipe);
-	 */
-	if (!pipe)
-		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
-			if (context->res_ctx.pipe_ctx[i].stream == NULL) {
-				pipe = &context->res_ctx.pipe_ctx[i];
-				pipe->pipe_idx = i;
-				break;
-			}
-		}
-
-	return pipe;
-}
-
-static bool dcn32_internal_validate_bw(
-		struct dc *dc,
-		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int *pipe_cnt_out,
-		int *vlevel_out,
-		bool fast_validate)
-{
-	bool out = false;
-	bool repopulate_pipes = false;
-	int split[MAX_PIPES] = { 0 };
-	bool merge[MAX_PIPES] = { false };
-	bool newly_split[MAX_PIPES] = { false };
-	int pipe_cnt, i, pipe_idx, vlevel;
-	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
-
-	ASSERT(pipes);
-	if (!pipes)
-		return false;
-
-	// For each full update, remove all existing phantom pipes first
-	dc->res_pool->funcs->remove_phantom_pipes(dc, context);
-
-	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
-
-	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
-
-	if (!pipe_cnt) {
-		out = true;
-		goto validate_out;
-	}
-
-	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
-
-	if (!fast_validate) {
-		DC_FP_START();
-		dcn32_full_validate_bw_helper(dc, context, pipes, &vlevel, split, merge, &pipe_cnt);
-		DC_FP_END();
-	}
-
-	if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
-			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
-		/*
-		 * If mode is unsupported or there's still no p-state support then
-		 * fall back to favoring voltage.
-		 *
-		 * We don't actually support prefetch mode 2, so require that we
-		 * at least support prefetch mode 1.
-		 */
-		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
-				dm_prefetch_support_stutter;
-
-		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
-		if (vlevel < context->bw_ctx.dml.soc.num_states) {
-			memset(split, 0, MAX_PIPES * sizeof(int));
-			memset(merge, 0, MAX_PIPES * sizeof(bool));
-			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
-		}
-	}
-
-	dml_log_mode_support_params(&context->bw_ctx.dml);
-
-	if (vlevel == context->bw_ctx.dml.soc.num_states)
-		goto validate_fail;
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
-
-		if (!pipe->stream)
-			continue;
-
-		/* We only support full screen mpo with ODM */
-		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
-				&& pipe->plane_state && mpo_pipe
-				&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
-						&pipe->plane_res.scl_data.recout,
-						sizeof(struct rect)) != 0) {
-			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
-			goto validate_fail;
-		}
-		pipe_idx++;
-	}
-
-	/* merge pipes if necessary */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		/*skip pipes that don't need merging*/
-		if (!merge[i])
-			continue;
-
-		/* if ODM merge we ignore mpc tree, mpo pipes will have their own flags */
-		if (pipe->prev_odm_pipe) {
-			/*split off odm pipe*/
-			pipe->prev_odm_pipe->next_odm_pipe = pipe->next_odm_pipe;
-			if (pipe->next_odm_pipe)
-				pipe->next_odm_pipe->prev_odm_pipe = pipe->prev_odm_pipe;
-
-			pipe->bottom_pipe = NULL;
-			pipe->next_odm_pipe = NULL;
-			pipe->plane_state = NULL;
-			pipe->stream = NULL;
-			pipe->top_pipe = NULL;
-			pipe->prev_odm_pipe = NULL;
-			if (pipe->stream_res.dsc)
-				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
-			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
-			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
-			repopulate_pipes = true;
-		} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
-			struct pipe_ctx *top_pipe = pipe->top_pipe;
-			struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
-
-			top_pipe->bottom_pipe = bottom_pipe;
-			if (bottom_pipe)
-				bottom_pipe->top_pipe = top_pipe;
-
-			pipe->top_pipe = NULL;
-			pipe->bottom_pipe = NULL;
-			pipe->plane_state = NULL;
-			pipe->stream = NULL;
-			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
-			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
-			repopulate_pipes = true;
-		} else
-			ASSERT(0); /* Should never try to merge master pipe */
-
-	}
-
-	for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *hsplit_pipe = NULL;
-		bool odm;
-		int old_index = -1;
-
-		if (!pipe->stream || newly_split[i])
-			continue;
-
-		pipe_idx++;
-		odm = vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled;
-
-		if (!pipe->plane_state && !odm)
-			continue;
-
-		if (split[i]) {
-			if (odm) {
-				if (split[i] == 4 && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe)
-					old_index = old_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
-				else if (old_pipe->next_odm_pipe)
-					old_index = old_pipe->next_odm_pipe->pipe_idx;
-			} else {
-				if (split[i] == 4 && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
-						old_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
-					old_index = old_pipe->bottom_pipe->bottom_pipe->pipe_idx;
-				else if (old_pipe->bottom_pipe &&
-						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
-					old_index = old_pipe->bottom_pipe->pipe_idx;
-			}
-			hsplit_pipe = dcn32_find_split_pipe(dc, context, old_index);
-			ASSERT(hsplit_pipe);
-			if (!hsplit_pipe)
-				goto validate_fail;
-
-			if (!dcn32_split_stream_for_mpc_or_odm(
-					dc, &context->res_ctx,
-					pipe, hsplit_pipe, odm))
-				goto validate_fail;
-
-			newly_split[hsplit_pipe->pipe_idx] = true;
-			repopulate_pipes = true;
-		}
-		if (split[i] == 4) {
-			struct pipe_ctx *pipe_4to1;
-
-			if (odm && old_pipe->next_odm_pipe)
-				old_index = old_pipe->next_odm_pipe->pipe_idx;
-			else if (!odm && old_pipe->bottom_pipe &&
-						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
-				old_index = old_pipe->bottom_pipe->pipe_idx;
-			else
-				old_index = -1;
-			pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
-			ASSERT(pipe_4to1);
-			if (!pipe_4to1)
-				goto validate_fail;
-			if (!dcn32_split_stream_for_mpc_or_odm(
-					dc, &context->res_ctx,
-					pipe, pipe_4to1, odm))
-				goto validate_fail;
-			newly_split[pipe_4to1->pipe_idx] = true;
-
-			if (odm && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe
-					&& old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
-				old_index = old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
-			else if (!odm && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
-					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
-					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
-				old_index = old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx;
-			else
-				old_index = -1;
-			pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
-			ASSERT(pipe_4to1);
-			if (!pipe_4to1)
-				goto validate_fail;
-			if (!dcn32_split_stream_for_mpc_or_odm(
-					dc, &context->res_ctx,
-					hsplit_pipe, pipe_4to1, odm))
-				goto validate_fail;
-			newly_split[pipe_4to1->pipe_idx] = true;
-		}
-		if (odm)
-			dcn20_build_mapped_resource(dc, context, pipe->stream);
-	}
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (pipe->plane_state) {
-			if (!resource_build_scaling_params(pipe))
-				goto validate_fail;
-		}
-	}
-
-	/* Actual dsc count per stream dsc validation*/
-	if (!dcn20_validate_dsc(dc, context)) {
-		vba->ValidationStatus[vba->soc.num_states] = DML_FAIL_DSC_VALIDATION_FAILURE;
-		goto validate_fail;
-	}
-
-	if (repopulate_pipes)
-		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
-	*vlevel_out = vlevel;
-	*pipe_cnt_out = pipe_cnt;
-
-	out = true;
-	goto validate_out;
-
-validate_fail:
-	out = false;
-
-validate_out:
-	return out;
-}
-
 bool dcn32_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
@@ -2130,9 +1768,9 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 
 	BW_VAL_TRACE_COUNT();
 
-    DC_FP_START();
+	DC_FP_START();
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
-    DC_FP_END();
+	DC_FP_END();
 
 	if (pipe_cnt == 0)
 		goto validate_out;
@@ -2318,125 +1956,6 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
     DC_FP_END();
 }
 
-static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
-{
-	int i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-		if (is_dp_128b_132b_signal(&context->res_ctx.pipe_ctx[i]))
-			return true;
-	}
-	return false;
-}
-
-void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes,
-		int pipe_cnt, int vlevel)
-{
-	int i, pipe_idx;
-	bool usr_retraining_support = false;
-	bool unbounded_req_enabled = false;
-
-	/* Writeback MCIF_WB arbitration parameters */
-	dc->res_pool->funcs->set_mcif_arb_params(dc, context, pipes, pipe_cnt);
-
-	context->bw_ctx.bw.dcn.clk.dispclk_khz = context->bw_ctx.dml.vba.DISPCLK * 1000;
-	context->bw_ctx.bw.dcn.clk.dcfclk_khz = context->bw_ctx.dml.vba.DCFCLK * 1000;
-	context->bw_ctx.bw.dcn.clk.socclk_khz = context->bw_ctx.dml.vba.SOCCLK * 1000;
-	context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
-	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = context->bw_ctx.dml.vba.DCFCLKDeepSleep * 1000;
-	context->bw_ctx.bw.dcn.clk.fclk_khz = context->bw_ctx.dml.vba.FabricClock * 1000;
-	context->bw_ctx.bw.dcn.clk.p_state_change_support =
-			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
-					!= dm_dram_clock_change_unsupported;
-	context->bw_ctx.bw.dcn.clk.num_ways = dcn32_helper_calculate_num_ways_for_subvp(dc, context);
-	/*
- *
-	 * TODO: needs FAMS
-	 * Pstate change might not be supported by hardware, but it might be
-	 * possible with firmware driven vertical blank stretching.
-	 */
-	// context->bw_ctx.bw.dcn.clk.p_state_change_support |= context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
-	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
-	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
-	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = context->bw_ctx.dml.vba.DTBCLKPerState[vlevel] * 1000;
-	if (context->bw_ctx.dml.vba.FCLKChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_fclock_change_unsupported)
-		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = false;
-	else
-		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
-
-	usr_retraining_support = context->bw_ctx.dml.vba.USRRetrainingSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
-	ASSERT(usr_retraining_support);
-
-	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
-		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
-
-	unbounded_req_enabled = get_unbounded_request_enabled(&context->bw_ctx.dml, pipes, pipe_cnt);
-
-	if (unbounded_req_enabled && pipe_cnt > 1) {
-		// Unbounded requesting should not ever be used when more than 1 pipe is enabled.
-		ASSERT(false);
-		unbounded_req_enabled = false;
-	}
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt,
-				pipe_idx);
-		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
-				pipe_idx);
-		pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt,
-				pipe_idx);
-		pipes[pipe_idx].pipe.dest.vready_offset = get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
-				pipe_idx);
-		if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
-			// Phantom pipe requires that DET_SIZE = 0 and no unbounded requests
-			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = 0;
-			context->res_ctx.pipe_ctx[i].unbounded_req = false;
-		} else {
-			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = get_det_buffer_size_kbytes(&context->bw_ctx.dml, pipes, pipe_cnt,
-							pipe_idx);
-			context->res_ctx.pipe_ctx[i].unbounded_req = unbounded_req_enabled;
-		}
-		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
-			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
-		pipe_idx++;
-	}
-	/*save a original dppclock copy*/
-	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
-	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
-	context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dppclk_mhz
-			* 1000;
-	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dispclk_mhz
-			* 1000;
-
-	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		if (context->res_ctx.pipe_ctx[i].stream)
-			context->bw_ctx.bw.dcn.compbuf_size_kb -= context->res_ctx.pipe_ctx[i].det_buffer_size_kb;
-	}
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		context->bw_ctx.dml.funcs.rq_dlg_get_dlg_reg_v2(&context->bw_ctx.dml,
-				&context->res_ctx.pipe_ctx[i].dlg_regs, &context->res_ctx.pipe_ctx[i].ttu_regs, pipes,
-				pipe_cnt, pipe_idx);
-
-		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg_v2(&context->res_ctx.pipe_ctx[i].rq_regs,
-				&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-
-		pipe_idx++;
-	}
-}
-
 static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
 {
 	if (entry->dcfclk_mhz > 0) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 37d37067e983..fc0fe48023a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -44,12 +44,6 @@ struct resource_pool *dcn32_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
 
-void dcn32_calculate_dlg_params(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel);
-
 struct panel_cntl *dcn32_panel_cntl_create(
 		const struct panel_cntl_init_data *init_data);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 353d3a74e40b..66102db87265 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -24,12 +24,15 @@
  *
  */
 #include "dcn32_fpu.h"
+#include "dc_link_dp.h"
 #include "dcn32/dcn32_resource.h"
 #include "dcn20/dcn20_resource.h"
 #include "display_mode_vba_util_32.h"
 // We need this includes for WATERMARKS_* defines
 #include "clk_mgr/dcn32/dcn32_smu13_driver_if.h"
 
+#define DC_LOGGER_INIT(logger)
+
 struct _vcs_dpi_ip_params_st dcn3_2_ip = {
 	.gpuvm_enable = 0,
 	.gpuvm_max_page_table_levels = 4,
@@ -931,7 +934,7 @@ static bool subvp_validate_static_schedulability(struct dc *dc,
 	return schedulable;
 }
 
-void dcn32_full_validate_bw_helper(struct dc *dc,
+static void dcn32_full_validate_bw_helper(struct dc *dc,
 				   struct dc_state *context,
 				   display_e2e_pipe_params_st *pipes,
 				   int *vlevel,
@@ -1058,6 +1061,507 @@ void dcn32_full_validate_bw_helper(struct dc *dc,
 	}
 }
 
+static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
+{
+	int i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+		if (is_dp_128b_132b_signal(&context->res_ctx.pipe_ctx[i]))
+			return true;
+	}
+	return false;
+}
+
+static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
+				       display_e2e_pipe_params_st *pipes,
+				       int pipe_cnt, int vlevel)
+{
+	int i, pipe_idx;
+	bool usr_retraining_support = false;
+	bool unbounded_req_enabled = false;
+
+	dc_assert_fp_enabled();
+
+	/* Writeback MCIF_WB arbitration parameters */
+	dc->res_pool->funcs->set_mcif_arb_params(dc, context, pipes, pipe_cnt);
+
+	context->bw_ctx.bw.dcn.clk.dispclk_khz = context->bw_ctx.dml.vba.DISPCLK * 1000;
+	context->bw_ctx.bw.dcn.clk.dcfclk_khz = context->bw_ctx.dml.vba.DCFCLK * 1000;
+	context->bw_ctx.bw.dcn.clk.socclk_khz = context->bw_ctx.dml.vba.SOCCLK * 1000;
+	context->bw_ctx.bw.dcn.clk.dramclk_khz = context->bw_ctx.dml.vba.DRAMSpeed * 1000 / 16;
+	context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = context->bw_ctx.dml.vba.DCFCLKDeepSleep * 1000;
+	context->bw_ctx.bw.dcn.clk.fclk_khz = context->bw_ctx.dml.vba.FabricClock * 1000;
+	context->bw_ctx.bw.dcn.clk.p_state_change_support =
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
+					!= dm_dram_clock_change_unsupported;
+	context->bw_ctx.bw.dcn.clk.num_ways = dcn32_helper_calculate_num_ways_for_subvp(dc, context);
+
+	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
+	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = context->bw_ctx.dml.vba.DTBCLKPerState[vlevel] * 1000;
+	if (context->bw_ctx.dml.vba.FCLKChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_fclock_change_unsupported)
+		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = false;
+	else
+		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
+
+	usr_retraining_support = context->bw_ctx.dml.vba.USRRetrainingSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	ASSERT(usr_retraining_support);
+
+	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
+		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
+
+	unbounded_req_enabled = get_unbounded_request_enabled(&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	if (unbounded_req_enabled && pipe_cnt > 1) {
+		// Unbounded requesting should not ever be used when more than 1 pipe is enabled.
+		ASSERT(false);
+		unbounded_req_enabled = false;
+	}
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt,
+				pipe_idx);
+		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
+				pipe_idx);
+		pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt,
+				pipe_idx);
+		pipes[pipe_idx].pipe.dest.vready_offset = get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
+				pipe_idx);
+
+		if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			// Phantom pipe requires that DET_SIZE = 0 and no unbounded requests
+			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = 0;
+			context->res_ctx.pipe_ctx[i].unbounded_req = false;
+		} else {
+			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = get_det_buffer_size_kbytes(&context->bw_ctx.dml, pipes, pipe_cnt,
+							pipe_idx);
+			context->res_ctx.pipe_ctx[i].unbounded_req = unbounded_req_enabled;
+		}
+
+		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
+			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
+		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
+		pipe_idx++;
+	}
+	/*save a original dppclock copy*/
+	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
+	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
+	context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dppclk_mhz
+			* 1000;
+	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dispclk_mhz
+			* 1000;
+
+	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (context->res_ctx.pipe_ctx[i].stream)
+			context->bw_ctx.bw.dcn.compbuf_size_kb -= context->res_ctx.pipe_ctx[i].det_buffer_size_kb;
+	}
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		context->bw_ctx.dml.funcs.rq_dlg_get_dlg_reg_v2(&context->bw_ctx.dml,
+				&context->res_ctx.pipe_ctx[i].dlg_regs, &context->res_ctx.pipe_ctx[i].ttu_regs, pipes,
+				pipe_cnt, pipe_idx);
+
+		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg_v2(&context->res_ctx.pipe_ctx[i].rq_regs,
+				&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		pipe_idx++;
+	}
+}
+
+static struct pipe_ctx *dcn32_find_split_pipe(
+		struct dc *dc,
+		struct dc_state *context,
+		int old_index)
+{
+	struct pipe_ctx *pipe = NULL;
+	int i;
+
+	if (old_index >= 0 && context->res_ctx.pipe_ctx[old_index].stream == NULL) {
+		pipe = &context->res_ctx.pipe_ctx[old_index];
+		pipe->pipe_idx = old_index;
+	}
+
+	if (!pipe)
+		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+			if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe == NULL
+					&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
+				if (context->res_ctx.pipe_ctx[i].stream == NULL) {
+					pipe = &context->res_ctx.pipe_ctx[i];
+					pipe->pipe_idx = i;
+					break;
+				}
+			}
+		}
+
+	/*
+	 * May need to fix pipes getting tossed from 1 opp to another on flip
+	 * Add for debugging transient underflow during topology updates:
+	 * ASSERT(pipe);
+	 */
+	if (!pipe)
+		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+			if (context->res_ctx.pipe_ctx[i].stream == NULL) {
+				pipe = &context->res_ctx.pipe_ctx[i];
+				pipe->pipe_idx = i;
+				break;
+			}
+		}
+
+	return pipe;
+}
+
+static bool dcn32_split_stream_for_mpc_or_odm(
+		const struct dc *dc,
+		struct resource_context *res_ctx,
+		struct pipe_ctx *pri_pipe,
+		struct pipe_ctx *sec_pipe,
+		bool odm)
+{
+	int pipe_idx = sec_pipe->pipe_idx;
+	const struct resource_pool *pool = dc->res_pool;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	if (odm && pri_pipe->plane_state) {
+		/* ODM + window MPO, where MPO window is on left half only */
+		if (pri_pipe->plane_state->clip_rect.x + pri_pipe->plane_state->clip_rect.width <=
+				pri_pipe->stream->src.x + pri_pipe->stream->src.width/2) {
+
+			DC_LOG_SCALER("%s - ODM + window MPO(left). pri_pipe:%d\n",
+					__func__,
+					pri_pipe->pipe_idx);
+			return true;
+		}
+
+		/* ODM + window MPO, where MPO window is on right half only */
+		if (pri_pipe->plane_state->clip_rect.x >= pri_pipe->stream->src.x +  pri_pipe->stream->src.width/2) {
+
+			DC_LOG_SCALER("%s - ODM + window MPO(right). pri_pipe:%d\n",
+					__func__,
+					pri_pipe->pipe_idx);
+			return true;
+		}
+	}
+
+	*sec_pipe = *pri_pipe;
+
+	sec_pipe->pipe_idx = pipe_idx;
+	sec_pipe->plane_res.mi = pool->mis[pipe_idx];
+	sec_pipe->plane_res.hubp = pool->hubps[pipe_idx];
+	sec_pipe->plane_res.ipp = pool->ipps[pipe_idx];
+	sec_pipe->plane_res.xfm = pool->transforms[pipe_idx];
+	sec_pipe->plane_res.dpp = pool->dpps[pipe_idx];
+	sec_pipe->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+	sec_pipe->stream_res.dsc = NULL;
+	if (odm) {
+		if (pri_pipe->next_odm_pipe) {
+			ASSERT(pri_pipe->next_odm_pipe != sec_pipe);
+			sec_pipe->next_odm_pipe = pri_pipe->next_odm_pipe;
+			sec_pipe->next_odm_pipe->prev_odm_pipe = sec_pipe;
+		}
+		if (pri_pipe->top_pipe && pri_pipe->top_pipe->next_odm_pipe) {
+			pri_pipe->top_pipe->next_odm_pipe->bottom_pipe = sec_pipe;
+			sec_pipe->top_pipe = pri_pipe->top_pipe->next_odm_pipe;
+		}
+		if (pri_pipe->bottom_pipe && pri_pipe->bottom_pipe->next_odm_pipe) {
+			pri_pipe->bottom_pipe->next_odm_pipe->top_pipe = sec_pipe;
+			sec_pipe->bottom_pipe = pri_pipe->bottom_pipe->next_odm_pipe;
+		}
+		pri_pipe->next_odm_pipe = sec_pipe;
+		sec_pipe->prev_odm_pipe = pri_pipe;
+		ASSERT(sec_pipe->top_pipe == NULL);
+
+		if (!sec_pipe->top_pipe)
+			sec_pipe->stream_res.opp = pool->opps[pipe_idx];
+		else
+			sec_pipe->stream_res.opp = sec_pipe->top_pipe->stream_res.opp;
+		if (sec_pipe->stream->timing.flags.DSC == 1) {
+			dcn20_acquire_dsc(dc, res_ctx, &sec_pipe->stream_res.dsc, pipe_idx);
+			ASSERT(sec_pipe->stream_res.dsc);
+			if (sec_pipe->stream_res.dsc == NULL)
+				return false;
+		}
+	} else {
+		if (pri_pipe->bottom_pipe) {
+			ASSERT(pri_pipe->bottom_pipe != sec_pipe);
+			sec_pipe->bottom_pipe = pri_pipe->bottom_pipe;
+			sec_pipe->bottom_pipe->top_pipe = sec_pipe;
+		}
+		pri_pipe->bottom_pipe = sec_pipe;
+		sec_pipe->top_pipe = pri_pipe;
+
+		ASSERT(pri_pipe->plane_state);
+	}
+
+	return true;
+}
+
+bool dcn32_internal_validate_bw(struct dc *dc,
+				struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int *pipe_cnt_out,
+				int *vlevel_out,
+				bool fast_validate)
+{
+	bool out = false;
+	bool repopulate_pipes = false;
+	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
+	bool newly_split[MAX_PIPES] = { false };
+	int pipe_cnt, i, pipe_idx, vlevel;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+
+	dc_assert_fp_enabled();
+
+	ASSERT(pipes);
+	if (!pipes)
+		return false;
+
+	// For each full update, remove all existing phantom pipes first
+	dc->res_pool->funcs->remove_phantom_pipes(dc, context);
+
+	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
+
+	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
+
+	if (!pipe_cnt) {
+		out = true;
+		goto validate_out;
+	}
+
+	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	if (!fast_validate) {
+		DC_FP_START();
+		dcn32_full_validate_bw_helper(dc, context, pipes, &vlevel, split, merge, &pipe_cnt);
+		DC_FP_END();
+	}
+
+	if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
+			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
+		/*
+		 * If mode is unsupported or there's still no p-state support then
+		 * fall back to favoring voltage.
+		 *
+		 * If Prefetch mode 0 failed for this config, or passed with Max UCLK, try if
+		 * supported with Prefetch mode 1 (dm_prefetch_support_fclk_and_stutter == 2)
+		 */
+		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
+				dm_prefetch_support_fclk_and_stutter;
+
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+
+		/* Last attempt with Prefetch mode 2 (dm_prefetch_support_stutter == 3) */
+		if (vlevel == context->bw_ctx.dml.soc.num_states) {
+			context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
+				dm_prefetch_support_stutter;
+			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		}
+
+		if (vlevel < context->bw_ctx.dml.soc.num_states) {
+			memset(split, 0, sizeof(split));
+			memset(merge, 0, sizeof(merge));
+			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+		}
+	}
+
+	dml_log_mode_support_params(&context->bw_ctx.dml);
+
+	if (vlevel == context->bw_ctx.dml.soc.num_states)
+		goto validate_fail;
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
+
+		if (!pipe->stream)
+			continue;
+
+		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
+				&& !dc->config.enable_windowed_mpo_odm
+				&& pipe->plane_state && mpo_pipe
+				&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
+						&pipe->plane_res.scl_data.recout,
+						sizeof(struct rect)) != 0) {
+			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
+			goto validate_fail;
+		}
+		pipe_idx++;
+	}
+
+	/* merge pipes if necessary */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		/*skip pipes that don't need merging*/
+		if (!merge[i])
+			continue;
+
+		/* if ODM merge we ignore mpc tree, mpo pipes will have their own flags */
+		if (pipe->prev_odm_pipe) {
+			/*split off odm pipe*/
+			pipe->prev_odm_pipe->next_odm_pipe = pipe->next_odm_pipe;
+			if (pipe->next_odm_pipe)
+				pipe->next_odm_pipe->prev_odm_pipe = pipe->prev_odm_pipe;
+
+			pipe->bottom_pipe = NULL;
+			pipe->next_odm_pipe = NULL;
+			pipe->plane_state = NULL;
+			pipe->stream = NULL;
+			pipe->top_pipe = NULL;
+			pipe->prev_odm_pipe = NULL;
+			if (pipe->stream_res.dsc)
+				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
+			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
+			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+			repopulate_pipes = true;
+		} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
+			struct pipe_ctx *top_pipe = pipe->top_pipe;
+			struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
+
+			top_pipe->bottom_pipe = bottom_pipe;
+			if (bottom_pipe)
+				bottom_pipe->top_pipe = top_pipe;
+
+			pipe->top_pipe = NULL;
+			pipe->bottom_pipe = NULL;
+			pipe->plane_state = NULL;
+			pipe->stream = NULL;
+			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
+			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+			repopulate_pipes = true;
+		} else
+			ASSERT(0); /* Should never try to merge master pipe */
+
+	}
+
+	for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *hsplit_pipe = NULL;
+		bool odm;
+		int old_index = -1;
+
+		if (!pipe->stream || newly_split[i])
+			continue;
+
+		pipe_idx++;
+		odm = vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled;
+
+		if (!pipe->plane_state && !odm)
+			continue;
+
+		if (split[i]) {
+			if (odm) {
+				if (split[i] == 4 && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe)
+					old_index = old_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
+				else if (old_pipe->next_odm_pipe)
+					old_index = old_pipe->next_odm_pipe->pipe_idx;
+			} else {
+				if (split[i] == 4 && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+					old_index = old_pipe->bottom_pipe->bottom_pipe->pipe_idx;
+				else if (old_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+					old_index = old_pipe->bottom_pipe->pipe_idx;
+			}
+			hsplit_pipe = dcn32_find_split_pipe(dc, context, old_index);
+			ASSERT(hsplit_pipe);
+			if (!hsplit_pipe)
+				goto validate_fail;
+
+			if (!dcn32_split_stream_for_mpc_or_odm(
+					dc, &context->res_ctx,
+					pipe, hsplit_pipe, odm))
+				goto validate_fail;
+
+			newly_split[hsplit_pipe->pipe_idx] = true;
+			repopulate_pipes = true;
+		}
+		if (split[i] == 4) {
+			struct pipe_ctx *pipe_4to1;
+
+			if (odm && old_pipe->next_odm_pipe)
+				old_index = old_pipe->next_odm_pipe->pipe_idx;
+			else if (!odm && old_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+				old_index = old_pipe->bottom_pipe->pipe_idx;
+			else
+				old_index = -1;
+			pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
+			ASSERT(pipe_4to1);
+			if (!pipe_4to1)
+				goto validate_fail;
+			if (!dcn32_split_stream_for_mpc_or_odm(
+					dc, &context->res_ctx,
+					pipe, pipe_4to1, odm))
+				goto validate_fail;
+			newly_split[pipe_4to1->pipe_idx] = true;
+
+			if (odm && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe
+					&& old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
+				old_index = old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
+			else if (!odm && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
+					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
+					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+				old_index = old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx;
+			else
+				old_index = -1;
+			pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
+			ASSERT(pipe_4to1);
+			if (!pipe_4to1)
+				goto validate_fail;
+			if (!dcn32_split_stream_for_mpc_or_odm(
+					dc, &context->res_ctx,
+					hsplit_pipe, pipe_4to1, odm))
+				goto validate_fail;
+			newly_split[pipe_4to1->pipe_idx] = true;
+		}
+		if (odm)
+			dcn20_build_mapped_resource(dc, context, pipe->stream);
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->plane_state) {
+			if (!resource_build_scaling_params(pipe))
+				goto validate_fail;
+		}
+	}
+
+	/* Actual dsc count per stream dsc validation*/
+	if (!dcn20_validate_dsc(dc, context)) {
+		vba->ValidationStatus[vba->soc.num_states] = DML_FAIL_DSC_VALIDATION_FAILURE;
+		goto validate_fail;
+	}
+
+	if (repopulate_pipes)
+		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
+	*vlevel_out = vlevel;
+	*pipe_cnt_out = pipe_cnt;
+
+	out = true;
+	goto validate_out;
+
+validate_fail:
+	out = false;
+
+validate_out:
+	return out;
+}
+
+
 void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				display_e2e_pipe_params_st *pipes,
 				int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index c7602f084be2..56973debc348 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -57,13 +57,12 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 				     unsigned int pipe_cnt,
 				     unsigned int dc_pipe_idx);
 
-void dcn32_full_validate_bw_helper(struct dc *dc,
-				   struct dc_state *context,
-				   display_e2e_pipe_params_st *pipes,
-				   int *vlevel,
-				   int *split,
-				   bool *merge,
-				   int *pipe_cnt);
+bool dcn32_internal_validate_bw(struct dc *dc,
+				struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int *pipe_cnt_out,
+				int *vlevel_out,
+				bool fast_validate);
 
 void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				display_e2e_pipe_params_st *pipes,
-- 
2.37.0


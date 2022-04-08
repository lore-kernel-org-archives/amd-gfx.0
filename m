Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C483CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A7C10F116;
	Fri,  8 Apr 2022 17:27:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8160510F0FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJRovI7jwfGfCKzMLfq+RctXkTfE0acGA3n9tZb8jCZKhFXOjxb/Oli3gCYNql8i02DX9RAs98Ejh/JPtP1cZUNRl1O2SbH0MQ/6bU2BrMh7YS4taNDNw/BOr7xe4kZUK+ju3KfsPUakYNywr9vTFiScWZqAO0x7cu75PHk2TAWe595X6PWh1aR2Fpap7Uf5pGhAbmerUH6cqr+suKXW1SZNnFcAVmI8MNv1hK5U8ExstT2AoQIj41QrcHHGaxRr8qfd/UjGhnLPn/HKKu4GT608UcYPt9t6hhJToo/3GJ0cWvlyhQPLumB7in7Vz/g9FA7JftasxGKbXCi/S+DDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8n+F461n/5l/R/w3TF8ojSxiJSq11wuvQRE/T2BbUU=;
 b=k04UzKej+0V6WCwYO8gxqGVotQ6lDWQVoDQu6doUXFcSeOC/76D6WaoHLjp4zI8Ir8JBLlh07coHp+xmquut3sYqlbpgPAo0P0Ok5BjnLRUDB3nnQgw9lHLNswoMUDyDd+k2BkONVEVgJZIiGUMU0TJAHDI1Tag3Z+ZP/e10Eazk0xpJ7OvReHDtL3RZZRhFg7QQ1ik61yV60oX3RAu6I6qXb4O+xePZiMI0FFOGvsRicK9OWTbGXZKup3fbKWD9pyd0m62taLDNRRepKt+C+p7eULrPwoUmjVIQ/FjrX8/jkKuruvTnot+j5Ul9VilCH5t8rYjbQ5VN+zn4gxk10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8n+F461n/5l/R/w3TF8ojSxiJSq11wuvQRE/T2BbUU=;
 b=sLk+GWTyY/2D9aq2jg2JwM8ANF7ja7CNf/y/7wuQkiiVWTx2QYjp0Q+au8sN7AB4eJWDy9ljDUc7HMOfO+Mr3LIQs1XmAbiWAOCvP0yplCTJ3kIdhK2mQVwbeZzm0grb1P5U39NJoE92781FfkGM+KKlwIjlIm1md8nxmmWli70=
Received: from DM6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:100::48)
 by BYAPR12MB3062.namprd12.prod.outlook.com (2603:10b6:a03:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:27:43 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::a1) by DM6PR03CA0071.outlook.office365.com
 (2603:10b6:5:100::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:42 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:41 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/20] drm/amd/display: Add odm seamless boot support
Date: Fri, 8 Apr 2022 13:19:03 -0400
Message-ID: <20220408171911.601615-13-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd925c09-7d6d-41f7-7955-08da1985168a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3062:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB306274F32CA986C3644EDFC2FCE99@BYAPR12MB3062.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHwb5kfNJlgEc0PY+VJTWLz2Qd6nPKlZLo1AAMrBRFOHRJqMcq+uvaPIAGcIg4t5j66vIkqb6axkR5OFZXmGRo3vsRRlwW9sYEDdgZZigD8f4Ks+kn17agAPFLlZcLEdiRViE72f5EduDwnmY7YoKONxwJuPiuQktpU6Rpe1dTE+VWs7UV0grixEuArNo67QLheiKjN1VdSWdTxEsAPF1Ki/D3YZEiSgBp9c3lEM/kIBF6etHLCSj+iTGPglt0l+StWKgJk3K5R3f3SWd616gHj0KAg7P5jt0btb2D1aRGeBTYxU31V64sdjpDuOHVO0e41WIHfIdRTK2MNfZlKS1ozCNv8zLy7zRvoWNMsw7JCNax5JF62a/WuV4JzidUP5RUdkJ8xQWQep4cHGpHDJCgVu+XYVnflUKpfOzCWaH2vkYSTB1sFceRUDpvKTEO8ufNdQsDLaj7MpPs8YEba3Vv8HhTRbBQgt3YdW87DrZkaqg1SrGCda1U4TiuiRpU7Yi+YRe7qmhIZLMFWP9T9Hm7UwS5aW8g5dFq6O+DETcZCEpLKIzQ8cNeAzRow0+6KtMFpYcM38zY9pUxe1CSLbeUO/Em8bHNYkUfYvXRdHn3mUf3kBEBX/6zKN1IylQCIZEGB5IgNa0X9Jf6KBc167mk1eZBXzX12puXVRNqXR2hXlaRg1bJk0WT2qlBpXwGaqjP6mvlCwZCiOrD5plzBJAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(36860700001)(6916009)(8676002)(70206006)(82310400005)(70586007)(5660300002)(36756003)(316002)(8936002)(6666004)(40460700003)(83380400001)(2616005)(30864003)(336012)(81166007)(1076003)(356005)(7696005)(47076005)(508600001)(86362001)(2906002)(426003)(26005)(16526019)(186003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:42.4771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd925c09-7d6d-41f7-7955-08da1985168a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
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
 Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <Duncan.Ma@amd.com>

[WHY]
Implement changes to transition from Pre-OS odm to
Post-OS odm support. Seamless boot case is also
considered.

[HOW]
Revised validation logic when marking for seamless
boot. Init resources accordingly when Pre-OS has
odm enabled. Reset odm and det size when transitioning
Pre-OS odm to Post-OS non-odm to avoid corruption.
Apply logic to set odm accordingly upon commit.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: "Duncan Ma" <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 82 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 21 +++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 21 +++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  2 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +
 8 files changed, 115 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c436db416708..c2fcd67bcc4d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1569,11 +1569,24 @@ bool dc_validate_boot_timing(const struct dc *dc,
 
 	if (dc_is_dp_signal(link->connector_signal)) {
 		unsigned int pix_clk_100hz;
+		uint32_t numOdmPipes = 1;
+		uint32_t id_src[4] = {0};
 
 		dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
 			dc->res_pool->dp_clock_source,
 			tg_inst, &pix_clk_100hz);
 
+		if (tg->funcs->get_optc_source)
+			tg->funcs->get_optc_source(tg,
+						&numOdmPipes, &id_src[0], &id_src[1]);
+
+		if (numOdmPipes == 2)
+			pix_clk_100hz *= 2;
+		if (numOdmPipes == 4)
+			pix_clk_100hz *= 4;
+
+		// Note: In rare cases, HW pixclk may differ from crtc's pixclk
+		// slightly due to rounding issues in 10 kHz units.
 		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
 			return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f5777a71f2f1..f292303b75a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2120,6 +2120,8 @@ static int acquire_resource_from_hw_enabled_state(
 {
 	struct dc_link *link = stream->link;
 	unsigned int i, inst, tg_inst = 0;
+	uint32_t numPipes = 1;
+	uint32_t id_src[4] = {0};
 
 	/* Check for enabled DIG to identify enabled display */
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
@@ -2148,38 +2150,62 @@ static int acquire_resource_from_hw_enabled_state(
 	if (!res_ctx->pipe_ctx[tg_inst].stream) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[tg_inst];
 
-		pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-		pipe_ctx->plane_res.mi = pool->mis[tg_inst];
-		pipe_ctx->plane_res.hubp = pool->hubps[tg_inst];
-		pipe_ctx->plane_res.ipp = pool->ipps[tg_inst];
-		pipe_ctx->plane_res.xfm = pool->transforms[tg_inst];
-		pipe_ctx->plane_res.dpp = pool->dpps[tg_inst];
-		pipe_ctx->stream_res.opp = pool->opps[tg_inst];
-
-		if (pool->dpps[tg_inst]) {
-			pipe_ctx->plane_res.mpcc_inst = pool->dpps[tg_inst]->inst;
-
-			// Read DPP->MPCC->OPP Pipe from HW State
-			if (pool->mpc->funcs->read_mpcc_state) {
-				struct mpcc_state s = {0};
-
-				pool->mpc->funcs->read_mpcc_state(pool->mpc, pipe_ctx->plane_res.mpcc_inst, &s);
-
-				if (s.dpp_id < MAX_MPCC)
-					pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].dpp_id = s.dpp_id;
-
-				if (s.bot_mpcc_id < MAX_MPCC)
-					pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].mpcc_bot =
-							&pool->mpc->mpcc_array[s.bot_mpcc_id];
+		id_src[0] = tg_inst;
+
+		if (pipe_ctx->stream_res.tg->funcs->get_optc_source)
+			pipe_ctx->stream_res.tg->funcs->get_optc_source(pipe_ctx->stream_res.tg,
+					&numPipes, &id_src[0], &id_src[1]);
+
+		for (i = 0; i < numPipes; i++) {
+			//Check if src id invalid
+			if (id_src[i] == 0xf)
+				return -1;
+
+			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
+			pipe_ctx->plane_res.mi = pool->mis[id_src[i]];
+			pipe_ctx->plane_res.hubp = pool->hubps[id_src[i]];
+			pipe_ctx->plane_res.ipp = pool->ipps[id_src[i]];
+			pipe_ctx->plane_res.xfm = pool->transforms[id_src[i]];
+			pipe_ctx->plane_res.dpp = pool->dpps[id_src[i]];
+			pipe_ctx->stream_res.opp = pool->opps[id_src[i]];
+
+			if (pool->dpps[id_src[i]]) {
+				pipe_ctx->plane_res.mpcc_inst = pool->dpps[id_src[i]]->inst;
+
+				if (pool->mpc->funcs->read_mpcc_state) {
+					struct mpcc_state s = {0};
+					pool->mpc->funcs->read_mpcc_state(pool->mpc, pipe_ctx->plane_res.mpcc_inst, &s);
+					if (s.dpp_id < MAX_MPCC)
+						pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].dpp_id =
+								s.dpp_id;
+					if (s.bot_mpcc_id < MAX_MPCC)
+						pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].mpcc_bot =
+								&pool->mpc->mpcc_array[s.bot_mpcc_id];
+					if (s.opp_id < MAX_OPP)
+						pipe_ctx->stream_res.opp->mpc_tree_params.opp_id = s.opp_id;
+				}
+			}
+			pipe_ctx->pipe_idx = id_src[i];
 
-				if (s.opp_id < MAX_OPP)
-					pipe_ctx->stream_res.opp->mpc_tree_params.opp_id = s.opp_id;
+			if (id_src[i] >= pool->timing_generator_count) {
+				id_src[i] = pool->timing_generator_count - 1;
+				pipe_ctx->stream_res.tg = pool->timing_generators[id_src[i]];
+				pipe_ctx->stream_res.opp = pool->opps[id_src[i]];
 			}
+
+			pipe_ctx->stream = stream;
 		}
-		pipe_ctx->pipe_idx = tg_inst;
 
-		pipe_ctx->stream = stream;
-		return tg_inst;
+		if (numPipes == 2) {
+			stream->apply_boot_odm_mode = dm_odm_combine_policy_2to1;
+			res_ctx->pipe_ctx[id_src[0]].next_odm_pipe = &res_ctx->pipe_ctx[id_src[1]];
+			res_ctx->pipe_ctx[id_src[0]].prev_odm_pipe = NULL;
+			res_ctx->pipe_ctx[id_src[1]].next_odm_pipe = NULL;
+			res_ctx->pipe_ctx[id_src[1]].prev_odm_pipe = &res_ctx->pipe_ctx[id_src[0]];
+		} else
+			stream->apply_boot_odm_mode = dm_odm_combine_mode_disabled;
+
+		return id_src[0];
 	}
 
 	return -1;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e723553f9c5a..863d90bec61b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -666,6 +666,7 @@ struct dc_debug_options {
 	uint32_t edid_read_retry_times;
 	bool remove_disconnect_edp;
 	unsigned int force_odm_combine; //bit vector based on otg inst
+	unsigned int seamless_boot_odm_combine;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
 	bool disable_z9_mpc;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index c4168c11257c..580420c3eedc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -246,6 +246,7 @@ struct dc_stream_state {
 
 	bool apply_edp_fast_boot_optimization;
 	bool apply_seamless_boot_optimization;
+	uint32_t apply_boot_odm_mode;
 
 	uint32_t stream_id;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 328569ad2bd6..283bc42d2fc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1259,6 +1259,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 {
 	int i;
 	struct dce_hwseq *hws = dc->hwseq;
+	struct hubbub *hubbub = dc->res_pool->hubbub;
 	bool can_apply_seamless_boot = false;
 
 	for (i = 0; i < context->stream_count; i++) {
@@ -1294,6 +1295,21 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		}
 	}
 
+	/* Reset det size */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+		struct hubp *hubp = dc->res_pool->hubps[i];
+
+		/* Do not need to reset for seamless boot */
+		if (pipe_ctx->stream != NULL && can_apply_seamless_boot)
+			continue;
+
+		if (hubbub && hubp) {
+			if (hubbub->funcs->program_det_size)
+				hubbub->funcs->program_det_size(hubbub, hubp->inst, 0);
+		}
+	}
+
 	/* num_opp will be equal to number of mpcc */
 	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -1359,6 +1375,11 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		pipe_ctx->stream_res.tg = NULL;
 		pipe_ctx->plane_res.hubp = NULL;
 
+		if (tg->funcs->is_tg_enabled(tg)) {
+			if (tg->funcs->init_odm)
+				tg->funcs->init_odm(tg);
+		}
+
 		tg->funcs->tg_init(tg);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index 10f897b1cb63..c51f7dca94f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -213,6 +213,26 @@ void optc31_set_drr(
 	}
 }
 
+void optc3_init_odm(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_SET_5(OPTC_DATA_SOURCE_SELECT, 0,
+			OPTC_NUM_OF_INPUT_SEGMENT, 0,
+			OPTC_SEG0_SRC_SEL, optc->inst,
+			OPTC_SEG1_SRC_SEL, 0xf,
+			OPTC_SEG2_SRC_SEL, 0xf,
+			OPTC_SEG3_SRC_SEL, 0xf
+			);
+
+	REG_SET(OTG_H_TIMING_CNTL, 0,
+			OTG_H_TIMING_DIV_MODE, 0);
+
+	REG_SET(OPTC_MEMORY_CONFIG, 0,
+			OPTC_MEM_SEL, 0);
+	optc1->opp_count = 1;
+}
+
 static struct timing_generator_funcs dcn31_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -272,6 +292,7 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
+		.init_odm = optc3_init_odm,
 };
 
 void dcn31_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
index a37b16040c1d..9e881f2ce74b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -258,4 +258,6 @@ void dcn31_timing_generator_init(struct optc *optc1);
 
 void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
 
+void optc3_init_odm(struct timing_generator *optc);
+
 #endif /* __DC_OPTC_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 59a704781e34..554d2e33bd7f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -310,6 +310,8 @@ struct timing_generator_funcs {
 			uint32_t slave_pixel_clock_100Hz,
 			uint8_t master_clock_divider,
 			uint8_t slave_clock_divider);
+
+	void (*init_odm)(struct timing_generator *tg);
 };
 
 #endif
-- 
2.32.0


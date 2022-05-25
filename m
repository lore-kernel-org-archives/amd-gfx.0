Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAACBC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3394E10F802;
	Wed, 25 May 2022 16:20:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7358810F2D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YISPVliObj2vFwAmEZHPl0vlDpTqZLybxKqFI6IwJJPZyCV8Tt/yrrkMrT64DFEPacCAnFli1BkFt5Kx+EZtVWTkc5GhLombmkoCYbU/GhlBLhA3DWzhzx5lE4ucd0mb2sjAeJcGtLJbKaiQmFNq2T9x5SSom9GsRvSNVRZn5IgK+GPt2tBCh6yAggMIKeHT/32hiRMXO8eyzmQLYZ35WusXxkmFqSJWYg1uKBJ+Bl5LSHamJmY8fWieO5DGZvHQP49MznDtHv0klzzxocT7s/WJSk0ZaVM80nl7L/f/BcKQxu9pG068J3FydkuwaUKqSyAU0LTNvCQXc7tk2RPFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln3Pgu/fANQO5maE5XjZuXsLvgtf9dRYMDHdVRGu0zY=;
 b=k4N7aleelNNwqSOjh/Mk7eUVJOxm616voPISX5ZNUz6ndRzGy6ba56yVMU2rnKVf46JHf3sCeXIF9Kd1C+SsEjBc4msO4L6N5jY1dthJ6XTMwC7hIFozIwHf8bkPsvue8OmZ10enN3ohZ39Y/cip7h186eOmq+pYjHJgpp29WjgIcdMLLBJerjX55SemWVEKEw1EXtA5hG4rc6K/zYicRs0qkxWopFi+AE5kGp333B4+TD92QnEQwr6M3FYmFg3ZKEMOKo7dssPM+j2c7YRE+wTJyJOf5SqHdaZFsZKsqmfzD2GvQlAiqO8aOEhurrOa/kBW00jSELGpEMFo/k2Szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln3Pgu/fANQO5maE5XjZuXsLvgtf9dRYMDHdVRGu0zY=;
 b=2AZdBbXirEzJsXARaZCQbDjBib36iehiWa1IElNEtjRsRxLUjhyxsa1swAt1RTk6IBUBi2FP8VMkMVljxYZnukb75fe0Fq99AkFTTDyhfAWgwuzYmYiUUS1nnL/fbuw6Z7cQnoe/yHZTEIecjynrQPigVAOJNch8vuarUxBtRRs=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by BN6PR12MB1779.namprd12.prod.outlook.com (2603:10b6:404:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 16:20:29 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::da) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 16:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 42/43] drm/amd/display: Add ODM seamless boot support
Date: Wed, 25 May 2022 12:19:40 -0400
Message-ID: <20220525161941.2544055-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e6824b4-0827-42e2-0038-08da3e6a7c0d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1779:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1779D1E566DBF6F5E532BEB8F7D69@BN6PR12MB1779.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NK72TAaC7VhmgMGnfuQTnAZuuJWVC//gCfVPJq810BS7hrjPK0tX3CreV2c1rpaxkco0dC+mNa1IaV0ExJZFZCCOtou1IxsgTpZSh+AgbiDwgW1Q8G2bTEuwZgzW4PkfEivZAU7W8f1gxaAeUdCU3dXewhjR5dcGcMgGfSKeiojtU7zpAJhcv5P/Lk48btPpUajsmOEIvq6L3BTcJg4sfenPVpXfSSGHC6sglqJyAp/vRb/TWkaXTLq3qo0eX5wEdL72LIO8H38i3hhidgro/XmM0p9kDMggNJ4kGzv6daAyboAZlWvNNO9WWnQIDQi6h4iqRdkWxQvmD0fZs9yqZ0EYnUQ0iw3DIoh8sTyZeNiZZYcigRac5QY3cB2FNcPskOmXDr1ZlEb83JwEM/xG1aawjGJJ+H6DcUaqq3h31O0wVwNXiVyo/nHa2Zgyz4VSJOuea6kE7alDPkAyy0lOq8OYmQlqS4XtaaVaQA7X0pJnmXoZ67B96xqOup+fmJEyI/nhLi4OkbCGBJeumUHk/DKJUTVGh2+W79/e4kC6o97MsQ6xZRJmMf4oKCQMfZAcYbvdrO+odE19qgOzpYpFy9DfeLlPVZzvVtNgm6XisRjPsFaujNH7UbHsJSLXtn2XX3sT5InguL9UNeiJCwMmYwfwGZ8DEY3UtSNV+YzDZuz4MOw0zyDoGoQ8VDAYyjcQ+AoSJ8tmasiPQ8K6rsEdvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(6666004)(356005)(2616005)(8676002)(508600001)(426003)(316002)(70586007)(70206006)(4326008)(81166007)(16526019)(1076003)(36860700001)(2906002)(8936002)(336012)(186003)(54906003)(40460700003)(36756003)(83380400001)(26005)(7696005)(82310400005)(6916009)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:29.3935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6824b4-0827-42e2-0038-08da3e6a7c0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1779
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Duncan Ma <duncan.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

Revised validation logic when marking for seamless boot. Init resources
accordingly when Pre-OS has ODM enabled. Reset ODM when transitioning
Pre-OS odm to Post-OS non-odm to avoid corruption. Apply logic to set
odm accordingly upon commit.

Signed-off-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  9 +++++++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  5 +++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 21 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  4 ++--
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 ++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b087452e4590..7072b79d1207 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2165,7 +2165,7 @@ static int acquire_resource_from_hw_enabled_state(
 
 		if (pipe_ctx->stream_res.tg->funcs->get_optc_source)
 			pipe_ctx->stream_res.tg->funcs->get_optc_source(pipe_ctx->stream_res.tg,
-					&numPipes, &id_src[0], &id_src[1]);
+						&numPipes, &id_src[0], &id_src[1]);
 
 		if (id_src[0] == 0xf && id_src[1] == 0xf) {
 			id_src[0] = tg_inst;
@@ -2177,6 +2177,8 @@ static int acquire_resource_from_hw_enabled_state(
 			if (id_src[i] == 0xf)
 				return -1;
 
+			pipe_ctx = &res_ctx->pipe_ctx[id_src[i]];
+
 			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
 			pipe_ctx->plane_res.mi = pool->mis[id_src[i]];
 			pipe_ctx->plane_res.hubp = pool->hubps[id_src[i]];
@@ -2190,13 +2192,17 @@ static int acquire_resource_from_hw_enabled_state(
 
 				if (pool->mpc->funcs->read_mpcc_state) {
 					struct mpcc_state s = {0};
+
 					pool->mpc->funcs->read_mpcc_state(pool->mpc, pipe_ctx->plane_res.mpcc_inst, &s);
+
 					if (s.dpp_id < MAX_MPCC)
 						pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].dpp_id =
 								s.dpp_id;
+
 					if (s.bot_mpcc_id < MAX_MPCC)
 						pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].mpcc_bot =
 								&pool->mpc->mpcc_array[s.bot_mpcc_id];
+
 					if (s.opp_id < MAX_OPP)
 						pipe_ctx->stream_res.opp->mpc_tree_params.opp_id = s.opp_id;
 				}
@@ -2205,6 +2211,7 @@ static int acquire_resource_from_hw_enabled_state(
 
 			if (id_src[i] >= pool->timing_generator_count) {
 				id_src[i] = pool->timing_generator_count - 1;
+
 				pipe_ctx->stream_res.tg = pool->timing_generators[id_src[i]];
 				pipe_ctx->stream_res.opp = pool->opps[id_src[i]];
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1cb206dc8352..e3a62873c0e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1375,6 +1375,11 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
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
index 96fac715a77b..c4304f25ce95 100644
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
@@ -273,6 +293,7 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
+		.init_odm = optc3_init_odm,
 };
 
 void dcn31_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 04360553a43f..a10ec5919194 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -657,7 +657,7 @@ void dcn32_init_hw(struct dc *dc)
 	 * Otherwise, if taking control is not possible, we need to power
 	 * everything down.
 	 */
-	if (dcb->funcs->is_accelerated_mode(dcb) || dc->config.seamless_boot_edp_requested) {
+	if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
 		hws->funcs.init_pipes(dc, dc->current_state);
 		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
@@ -669,7 +669,7 @@ void dcn32_init_hw(struct dc *dc)
 	 * To avoid this, power down hardware on boot
 	 * if DIG is turned on and seamless boot not enabled
 	 */
-	if (dc->config.seamless_boot_edp_requested) {
+	if (!dc->config.seamless_boot_edp_requested) {
 		struct dc_link *edp_links[MAX_NUM_EDP];
 		struct dc_link *edp_link;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index a89b2230cd2c..62d4683f17a2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -318,6 +318,8 @@ struct timing_generator_funcs {
 			int vmin, int vmax);
 	bool (*validate_vtotal_change_limit)(struct timing_generator *optc,
 			uint32_t vtotal_change_limit);
+
+	void (*init_odm)(struct timing_generator *tg);
 };
 
 #endif
-- 
2.35.3


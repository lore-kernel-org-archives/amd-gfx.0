Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C1606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oQToIl/T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BD410F8E3;
	Wed, 11 Nov 2026 01:43:49 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F0210F8E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf0RvtK7wDktO+ynzTKkCgYp2EJPjGrLj1SiSbdi34QE26ijcd13mDTgXmuGKqU/21t7gyCcRxkWeC8RHwtdwdnw1dukQFDlQp/9jbWRVRZCjptvqinOZdvOrRBWtL5z3lFg5/NM/3zMV0h6fk3cR4D8uc096h+pNxW+VKbHXXSrxRVSOTJnp8+T65ZCr4sKy76YT+Th0v1r6AiW4DKoHqCICOlsbXdNhHFXqKSosY4iTboxrr9V+0KxdA4tG6V2zwmMaA7qQw+wdnJ8JWu9smtoXjWZseC1K6oDW7Fp+IfretnKOvD0nDXWq7PCxUJknHZ+9QQC7BsFIdNXb/Yy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MvWt6XIpp6fg8caEngOFw66sIVvOUJrTxlFS8jEpK0=;
 b=WyxWbYvpt0fgoggCZZQ40C8KlYFJibuJdPapGwzK1DMfKCrO9YW1ahE1hOki9XeG1tY7BPAys+3vS5Ms1ezbHYiBO4sl/kuSJEFxMRTQbQB5ixfyXwT7sCujkE3J+CSxPtetFRHE2rpLnSUiMu2/4WoWquCTwZ9lC1U1ACUvgU3TzY0krKfNK3B3kXbZZWu9M2VjZ6wLsGxCxmaV3Yyq6qxnG2aEBmgjle5G7Q+8Kch34JUDsNYxnFhzneHqIioxkSB3bFobLaRyWcE3JUIJvtgcjmNT9OV7gg1vXSLHswoKOH2AZIJ+e0w7VdfXeDVW7K+oNGK4h/O6MA3AP9B8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MvWt6XIpp6fg8caEngOFw66sIVvOUJrTxlFS8jEpK0=;
 b=oQToIl/To5yZ5speVApK/7kYz41C8PkNSQWrnN1sgZQOgXJuVRr4ohYt+bmB5OFUAO999k8ZGbMgKqsV02EYCW0gVBMLN1+t7cKfA91AxfRCK4nT35DR0MJgk1DraEiSTL0HqsMlkq4msRFmduunThECwrg2TBpKTqEbWUon+ss=
Received: from SJ0PR13CA0074.namprd13.prod.outlook.com (2603:10b6:a03:2c4::19)
 by DS0PR12MB329683.namprd12.prod.outlook.com (2603:10b6:8:4e9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:33 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::e) by SJ0PR13CA0074.outlook.office365.com
 (2603:10b6:a03:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:28 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:24 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 17/74] drm/amd/display: Resolve clk_mgr DPP DTO targets when
 the sequence is built
Date: Wed, 11 Nov 2026 09:28:23 +0800
Message-ID: <20261111014100.3596072-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS0PR12MB329683:EE_
X-MS-Office365-Filtering-Correlation-Id: 047610fb-8c6c-483c-4600-08df3f94ea4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|261021123027099003|261022105027099003|261022113327099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|10067099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: SNZND7g+0dxwYymd5uf+s2Pw8AxERJwKysGkA0CkCxGaAJ6Y8p2dYuURslGdep6TYzAZ3jh5VyFHXNo495GGEeqIwmm1ANUI7Ry6eXMIkIpT0PZrZxJ7fJE1cohIaOfQtz4hRWtOzgd1OBz/TgScsv91wYvsGtNB11RDJzqU4Q6TWneVp/QJ5gItmIqjumkJAerXSS3um8/Zl9NassPVwswzB0YuVRq5oPXhsPnhiuAdtE16EiAy2dMxCt30xfrjdsyeNudN6Seyj8eZonJMJzca3ajZao6wCLpmJ7falsrpmjwjkivfshFveOH4dfSqxuo8520ctD2GqIDrPpLAFUzxCYH2bF0DsuIFckm3kgB8r0B26g6SJERtji+i6pQdn6++EsVZTJ9l8lZ/isa1FLHqyR3uFXWkchsAho/Yp/HGyjQCSiGoJHzDd3jGJ67Z/ur4i/QKWfsDaNoFD827a3XdMyo8JLR7rBtlJ+7MuxXSSr5EYCqMYwfQb2riLEnNOWxWz5bEHgs4zgU9Of9NpEQcEDPqfRTLlJ0AWyKschrwJ42x6xPTg05Sapt3TX2Xt36ceuCfRT/jWKP6ETSQnCdJ6aYq0Ng8CSmpjFhXrYmHeBea4gIzvY1G4VqTLcRLDQxAZ9ndbGFeVfQNpAC7OiYbb46X4lE2Zlfs7f2N6+QGN7IxffIZ9Y+6GHys00yXeM+ZcF+SlpeoVdtpWKyt4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261022113327099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(10067099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iMFcnAgw2bT0EV6JYFB0++k/8ujw1KP05PepDEf3icvPm3IuEEPCvmR262JQQByvIjA2DXjdk+gkBUNq8poC2n9k4R8WpAOaGyUoOG0xLSLWisdhOamAM17nRS3eGIIe8Rnq34A54J3At5ZuXF+9FJisFssegUxiS9GyxUEYGHpy/oiMekDj5lQ3DNs2xPx1LoT+yJpDSKXeZ5fos2Mb+6BjE4O+eF+lBTDg6Es+hIdAdjjsxYuCotuaqv5IEF7g6DxvdmVuQSe2gO2PQHgjTjJsisDSPsb2z1G90/bb+9eXhh2bnzoAC3UQVmSbt2E6f0PMh31qGAoKoty66JHBKHZJpZSYwSQbwEP7Sh7825iLxAs6k46rkwKg53kP5bVj6NRx0cYVvkfWlJ0WJQ4CY+hMEBCorpaG1FVN8otWxAEjqOXBXcD3igyPKRhmiDu0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:32.7275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047610fb-8c6c-483c-4600-08df3f94ea4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB329683
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
The DCN401 and DCN60 clk_mgr block sequences keep a dc_state pointer
in the DPPCLK DTO step and walk res_ctx, dc->res_pool and the pipe's DPP
when the step executes. The step therefore depends on state outside its
parameters, and on that state still being valid when the sequence runs.

[HOW]
Add clk_mgr_build_dpp_dto_targets(), which records each pipe's DPP instance
and DPP clock while the sequence is built, and clk_mgr_program_dpp_dto(),
which programs them. The step carries the targets instead of the dc_state.
The reference clock stays a pointer into clk_mgr's own clocks, because an
earlier step in the same sequence stores the PMFW-granted DPPCLK there.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 46 ++++++++++++++++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 54 ++++---------------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |  4 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 54 ++++---------------
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |  4 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  | 22 ++++++++
 6 files changed, 90 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index bdc755be7bf6..cf1f1c8761c6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -98,6 +98,52 @@ int clk_mgr_helper_get_active_plane_cnt(
 	return total_plane_count;
 }
 
+void clk_mgr_build_dpp_dto_targets(
+		const struct dc *dc,
+		const struct dc_state *context,
+		bool safe_to_lower,
+		struct clk_mgr_dpp_dto_targets *targets)
+{
+	unsigned int i;
+
+	targets->safe_to_lower = safe_to_lower;
+	targets->count = 0;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		int dppclk_khz = pipe->plane_res.bw.dppclk_khz;
+
+		if (!pipe->plane_res.dpp) {
+			/* A harvested pipe has neither a DPP nor a DPP clock. */
+			ASSERT(dppclk_khz == 0);
+			continue;
+		}
+
+		targets->pipes[targets->count].pipe_idx = i;
+		targets->pipes[targets->count].dpp_inst = pipe->plane_res.dpp->inst;
+		targets->pipes[targets->count].dppclk_khz = dppclk_khz;
+		targets->count++;
+	}
+}
+
+void clk_mgr_program_dpp_dto(
+		struct dccg *dccg,
+		int ref_dppclk_khz,
+		const struct clk_mgr_dpp_dto_targets *targets)
+{
+	unsigned int i;
+
+	dccg->ref_dppclk = ref_dppclk_khz;
+	for (i = 0; i < targets->count; i++) {
+		int dppclk_khz = targets->pipes[i].dppclk_khz;
+
+		/* Unless lowering is safe, only raise over what DCCG last programmed. */
+		if (targets->safe_to_lower ||
+				dccg->pipe_dppclk_khz[targets->pipes[i].pipe_idx] < dppclk_khz)
+			dccg->funcs->update_dpp_dto(dccg, targets->pipes[i].dpp_inst, dppclk_khz);
+	}
+}
+
 void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 03aec7f4df7b..d609f77d5298 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -560,40 +560,6 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 	}
 }
 
-static void dcn401_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context, bool safe_to_lower, int ref_dppclk_khz)
-{
-	uint32_t i;
-
-	clk_mgr->dccg->ref_dppclk = ref_dppclk_khz;
-	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-		int dpp_inst = 0, dppclk_khz, prev_dppclk_khz;
-
-		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
-
-		if (context->res_ctx.pipe_ctx[i].plane_res.dpp)
-			dpp_inst = context->res_ctx.pipe_ctx[i].plane_res.dpp->inst;
-		else if (!context->res_ctx.pipe_ctx[i].plane_res.dpp && dppclk_khz == 0) {
-			/* dpp == NULL && dppclk_khz == 0 is valid because of pipe harvesting.
-			 * In this case just continue in loop
-			 */
-			continue;
-		} else if (!context->res_ctx.pipe_ctx[i].plane_res.dpp && dppclk_khz > 0) {
-			/* The software state is not valid if dpp resource is NULL and
-			 * dppclk_khz > 0.
-			 */
-			ASSERT(false);
-			continue;
-		}
-
-		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
-
-		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
-			clk_mgr->dccg->funcs->update_dpp_dto(
-							clk_mgr->dccg, dpp_inst, dppclk_khz);
-	}
-}
-
 static int dcn401_set_hard_min_by_freq_optimized(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, int requested_clk_khz)
 {
 	if (!clk_mgr->smu_present || !dcn401_is_ppclk_dpm_enabled(clk_mgr, clk))
@@ -739,11 +705,9 @@ static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 					params->indicate_drr_status_params.mod_drr_for_pstate);
 			break;
 		case CLK_MGR401_UPDATE_DPPCLK_DTO:
-			dcn401_update_clocks_update_dpp_dto(
-					clk_mgr_internal,
-					params->update_dppclk_dto_params.context,
-					params->update_dppclk_dto_params.safe_to_lower,
-					*params->update_dppclk_dto_params.ref_dppclk_khz);
+			clk_mgr_program_dpp_dto(clk_mgr_internal->dccg,
+					*params->update_dppclk_dto_params.ref_dppclk_khz,
+					&params->update_dppclk_dto_params.targets);
 			break;
 		case CLK_MGR401_UPDATE_DTBCLK_DTO:
 			dcn401_update_clocks_update_dtb_dto(
@@ -1186,9 +1150,9 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dppclk_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
-			block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
 			block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.dppclk_khz;
-			block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			clk_mgr_build_dpp_dto_targets(dc, context, safe_to_lower,
+					&block_sequence[num_steps].params.update_dppclk_dto_params.targets);
 			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
 			num_steps++;
 
@@ -1203,9 +1167,9 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 				block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
 				num_steps++;
 
-				block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
 				block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.actual_dppclk_khz;
-				block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+				clk_mgr_build_dpp_dto_targets(dc, context, safe_to_lower,
+						&block_sequence[num_steps].params.update_dppclk_dto_params.targets);
 				block_sequence[num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
 				num_steps++;
 			}
@@ -1225,9 +1189,9 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 				num_steps++;
 			}
 
-			block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
 			block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.actual_dppclk_khz;
-			block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			clk_mgr_build_dpp_dto_targets(dc, context, safe_to_lower,
+					&block_sequence[num_steps].params.update_dppclk_dto_params.targets);
 			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
 			num_steps++;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index d4cd69a5a8dd..7f03a30546a2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -53,9 +53,9 @@ union dcn401_clk_mgr_block_sequence_params {
 	} indicate_drr_status_params;
 	struct {
 		/* inputs */
-		struct dc_state *context;
+		/* clk_mgr's own clocks; an earlier step may store the PMFW-granted DPPCLK there. */
 		int *ref_dppclk_khz;
-		bool safe_to_lower;
+		struct clk_mgr_dpp_dto_targets targets;
 	} update_dppclk_dto_params;
 	struct {
 		/* inputs */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 4242a4b5c902..6f16bc33b6af 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -183,40 +183,6 @@ static bool dcn60_check_native_scaling(struct pipe_ctx *pipe)
 	return is_native_scaling;
 }
 
-static void dcn60_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
-	struct dc_state *context, bool safe_to_lower, int ref_dppclk_khz)
-{
-	uint32_t i;
-
-	clk_mgr->dccg->ref_dppclk = ref_dppclk_khz;
-	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-		int dpp_inst = 0, dppclk_khz, prev_dppclk_khz;
-
-		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
-
-		if (context->res_ctx.pipe_ctx[i].plane_res.dpp)
-			dpp_inst = context->res_ctx.pipe_ctx[i].plane_res.dpp->inst;
-		else if (!context->res_ctx.pipe_ctx[i].plane_res.dpp && dppclk_khz == 0) {
-			/* dpp == NULL && dppclk_khz == 0 is valid because of pipe harvesting.
-			 * In this case just continue in loop
-			 */
-			continue;
-		} else if (!context->res_ctx.pipe_ctx[i].plane_res.dpp && dppclk_khz > 0) {
-			/* The software state is not valid if dpp resource is NULL and
-			 * dppclk_khz > 0.
-			 */
-			ASSERT(false);
-			continue;
-		}
-
-		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
-
-		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
-			clk_mgr->dccg->funcs->update_dpp_dto(
-				clk_mgr->dccg, dpp_inst, dppclk_khz);
-	}
-}
-
 static int dcn60_set_clock_freq_optimized(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, int requested_clk_khz)
 {
 	if (!clk_mgr->smu_present || !dcn60_is_ppclk_dpm_enabled(clk_mgr, clk))
@@ -383,9 +349,9 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dppclk_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
-			block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
 			block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.dppclk_khz;
-			block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			clk_mgr_build_dpp_dto_targets(dc, context, safe_to_lower,
+					&block_sequence[num_steps].params.update_dppclk_dto_params.targets);
 			block_sequence[num_steps].func = CLK_MGR60_UPDATE_DPPCLK_DTO;
 			num_steps++;
 
@@ -396,9 +362,9 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 				block_sequence[num_steps].func = CLK_MGR60_SET_PPCLK_OPTIMIZED;
 				num_steps++;
 
-				block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
 				block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.actual_dppclk_khz;
-				block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+				clk_mgr_build_dpp_dto_targets(dc, context, safe_to_lower,
+						&block_sequence[num_steps].params.update_dppclk_dto_params.targets);
 				block_sequence[num_steps].func = CLK_MGR60_UPDATE_DPPCLK_DTO;
 				num_steps++;
 			}
@@ -412,9 +378,9 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 				num_steps++;
 			}
 
-			block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
 			block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.actual_dppclk_khz;
-			block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			clk_mgr_build_dpp_dto_targets(dc, context, safe_to_lower,
+					&block_sequence[num_steps].params.update_dppclk_dto_params.targets);
 			block_sequence[num_steps].func = CLK_MGR60_UPDATE_DPPCLK_DTO;
 			num_steps++;
 		}
@@ -1225,11 +1191,9 @@ static void dcn60_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 					params->indicate_pstate_status_params.alt_ch_enable);
 			break;
 		case CLK_MGR60_UPDATE_DPPCLK_DTO:
-			dcn60_update_clocks_update_dpp_dto(
-					clk_mgr_internal,
-					params->update_dppclk_dto_params.context,
-					params->update_dppclk_dto_params.safe_to_lower,
-					*params->update_dppclk_dto_params.ref_dppclk_khz);
+			clk_mgr_program_dpp_dto(clk_mgr_internal->dccg,
+					*params->update_dppclk_dto_params.ref_dppclk_khz,
+					&params->update_dppclk_dto_params.targets);
 			break;
 		case CLK_MGR60_UPDATE_DTBCLK_DTO:
 			dcn60_update_clocks_update_dtb_dto(
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
index 0625f060e8c6..6d96ec8440a2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
@@ -45,9 +45,9 @@ union dcn60_clk_mgr_block_sequence_params {
 	} indicate_pstate_status_params;
 	struct {
 		/* inputs */
-		struct dc_state *context;
+		/* clk_mgr's own clocks; an earlier step may store the PMFW-granted DPPCLK there. */
 		int *ref_dppclk_khz;
-		bool safe_to_lower;
+		struct clk_mgr_dpp_dto_targets targets;
 	} update_dppclk_dto_params;
 	struct {
 		/* inputs */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 68fd92258e8c..c6c087197f82 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -602,6 +602,28 @@ int clk_mgr_helper_get_active_plane_cnt(
 		struct dc *dc,
 		struct dc_state *context);
 
+/* Per-pipe DPP DTO programming resolved from dc_state when a clock update is built. */
+struct clk_mgr_dpp_dto_targets {
+	bool safe_to_lower;
+	unsigned int count;
+	struct {
+		unsigned int pipe_idx;
+		int dpp_inst;
+		int dppclk_khz;
+	} pipes[MAX_PIPES];
+};
+
+void clk_mgr_build_dpp_dto_targets(
+		const struct dc *dc,
+		const struct dc_state *context,
+		bool safe_to_lower,
+		struct clk_mgr_dpp_dto_targets *targets);
+
+void clk_mgr_program_dpp_dto(
+		struct dccg *dccg,
+		int ref_dppclk_khz,
+		const struct clk_mgr_dpp_dto_targets *targets);
+
 
 
 #endif //__DAL_CLK_MGR_INTERNAL_H__
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100DCD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C3E11215E;
	Wed, 10 Apr 2024 21:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sUd/inI2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7679110EA44
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCk0i2qWgHMIS6SHWAOt5uSfP5VxnT0qdVA9KT4DLWRZIWAPE0YiXl5dgicoBJLy3HVT48skZvERhBaLmogRHIBUyfVNg/PCupJEUP1yaqtLee4fbI2LwZogSM9X9bRDASeflQ2aoDyKj8ozoqd4aVdvlsUtGIYZZl6eyMbnx1ZAoX2BENpRb6c7lk9v4R/6N9iWlZyd3NWSGXALGZnodJA65zaNCkxQrxjYSvRcXGyKXqgKtgnOsmurxGAvDJw0m0i7LaIIVtj9Ivm/OM48GTXzj8SHEjgqwbuEkiTuNc0rmNMMhvjp3ns8y9ty9jw3nTf3Duhcep3OljK2T69mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2Em7xA7AUZ5ihzNNBkKCR7CeQwEYIWRv7J7RVTITEI=;
 b=lxUwFhqiQvJkPwxg/iawic9cEx+PFxg5lDyuSY2G9WqB1QCG3Qk3I+aqc4o5T1SzURCpumX4JrY0cHv4xVMMN62g0Rj0CSvNCOlA7J/WR2oLmu5+MMagKNBKWQyjnFNhjaOkpZuF8FGJGJd7mV5TvCKABW6IlPD16sipS5p/Za0vwcPu99MskY/fq3dLIQ4ZmLFaYWRX0XpcPOnCoTrKA8V4b64YHEoLAm95gxzo47+YD6pPcr2rm/NWiLndagANE2IMYgkUHq3q403sDLOyLizIig2Q4FeneY8gm7RTTFSRB9czSk2NqKgTaJtc5Zz6ydPoQWHH7PHB//avLVDw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2Em7xA7AUZ5ihzNNBkKCR7CeQwEYIWRv7J7RVTITEI=;
 b=sUd/inI27Zms+ezzGlHerSoUj36PYo1ctWxwhV7zon61xbJMx5LKb/UqE2IfLWdEVzlvU+ND2a99Okv9MvFlMc0MzmmuFEFnJVEbFXflYOlC+W71reyRaz5/EfEyx9HkJzyW5V4tag/AOZdG6b80wGXJsocabbqwgT98+kyix9E=
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:07 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::83) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:04 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung Joon Kim
 <sungjoon.kim@amd.com>, Xi Liu <xi.liu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 09/25] drm/amd/display: Rework power sequence and resource
 allocation logic
Date: Wed, 10 Apr 2024 15:25:58 -0600
Message-ID: <20240410212726.1312989-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 394ce6a3-5728-4f0c-b7df-08dc59a51d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEwHaAq4PF7nUzYHlD6eG6tvqqRnKuxFLQN1oSpKFZmJZN9ytWIewuzMsIIKsiqsRprjXn8agPPboaiHN0a0tKquXFZKxjxB3OmgY/54/WV58+bMrTYCUk+sbs+yzdxjsuVtpC+meJz5rOyh9afuSkiS3OMzvZusChp4VbnLkuD6kBhnCjCF5qF1FauQmu583E2bt5rA7vg/322W/g5vB3WRLG+RjWvHcDksJ1omUQll7dyO6k70Uj5xTBEKfcHLF+UDJLX31v/07G+UfnkMMxgIEVjpOyKuVoDUGP6s6X8RSPG9skwGETuPZRo6IIhdhhQ+n5it2ecXeh7FKaATHzvuCw19CuGiAtqym3sROH+CymLlDTj/T69thtIfeG5ZJeESWFzqUY31ywsrZdz8mRMD+9x6f4MIPYQRvkm1wGHWp8MtkYaUSHw7d+J9vpkl6lP6VNuqFgF6wxjFoFVHka2ya9HhrVUon3OqsuPYLyPYlBSxk+qib75MepIMXoN6/hoPMx9N8C8r9nkMZ8STwjvkkyeTM6EZP08F0t6zWqSGlqjo0/fCoaatihG9DwS15CxkIHCu/nGKjpGaiMUXCcwvudBnoIXBEOm82JUYvhipJXAVIbUjptZOhRy3ZoQ7T0QbJfSKbKZ+SMS5RtQ5IIH1d+n1BAFqUIz9H+/AFigUAt4AspX3ICBavos7IqcD9bXThqTbQz9QgVGK4IgvsaoHCw+EbxysVMcOD9fp0PJWLzLHJxuWQZ+Eb4ScAMT7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:07.2922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 394ce6a3-5728-4f0c-b7df-08dc59a51d33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungjoon.kim@amd.com>

Rework part of the modifications made to the power sequence and resource
allocation logic.

Reviewed-by: Xi (Alex) Liu <xi.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  8 ++---
 .../dc/resource/dcn351/dcn351_resource.c      | 36 +------------------
 .../dc/resource/dcn351/dcn351_resource.h      |  6 ----
 3 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index c4944478ed91..a53092cd619b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -116,10 +116,10 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
 	.update_dsc_pg = dcn32_update_dsc_pg,
-	.calc_blocks_to_gate = dcn351_calc_blocks_to_gate,
-	.calc_blocks_to_ungate = dcn351_calc_blocks_to_ungate,
-	.hw_block_power_up = dcn351_hw_block_power_up,
-	.hw_block_power_down = dcn351_hw_block_power_down,
+	.calc_blocks_to_gate = dcn35_calc_blocks_to_gate,
+	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
+	.hw_block_power_up = dcn35_hw_block_power_up,
+	.hw_block_power_down = dcn35_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index b29d7d47552b..3acfbbac8538 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1728,38 +1728,6 @@ static bool dcn351_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
-struct pipe_ctx *dcn351_acquire_free_pipe_as_secondary_dpp_pipe(
-		const struct dc_state *cur_ctx,
-		struct dc_state *new_ctx,
-		const struct resource_pool *pool,
-		const struct pipe_ctx *opp_head_pipe)
-{
-	int free_pipe_idx;
-	struct pipe_ctx *free_pipe;
-
-	free_pipe_idx = dcn32_find_optimal_free_pipe_as_secondary_dpp_pipe(
-					&cur_ctx->res_ctx, &new_ctx->res_ctx,
-					pool, opp_head_pipe);
-	if (free_pipe_idx >= 0) {
-		free_pipe = &new_ctx->res_ctx.pipe_ctx[free_pipe_idx];
-		free_pipe->pipe_idx = free_pipe_idx;
-		free_pipe->stream = opp_head_pipe->stream;
-		free_pipe->stream_res.tg = opp_head_pipe->stream_res.tg;
-		free_pipe->stream_res.opp = opp_head_pipe->stream_res.opp;
-
-		free_pipe->plane_res.hubp = pool->hubps[free_pipe->pipe_idx];
-		free_pipe->plane_res.ipp = pool->ipps[free_pipe->pipe_idx];
-		free_pipe->plane_res.dpp = pool->dpps[free_pipe->pipe_idx];
-		free_pipe->plane_res.mpcc_inst =
-				pool->dpps[free_pipe->pipe_idx]->inst;
-	} else {
-		ASSERT(opp_head_pipe);
-		free_pipe = NULL;
-	}
-
-	return free_pipe;
-}
-
 static struct resource_funcs dcn351_res_pool_funcs = {
 	.destroy = dcn351_destroy_resource_pool,
 	.link_enc_create = dcn35_link_encoder_create,
@@ -1771,8 +1739,7 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.calculate_wm_and_dlg = NULL,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn351_populate_dml_pipes_from_context_fpu,
-	.acquire_free_pipe_as_secondary_dpp_pipe = dcn351_acquire_free_pipe_as_secondary_dpp_pipe,
-	.acquire_free_pipe_as_secondary_opp_head = dcn32_acquire_free_pipe_as_secondary_opp_head,
+	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
 	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
@@ -2162,7 +2129,6 @@ static bool dcn351_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
-	dc->dml2_options.map_dc_pipes_with_callbacks = true;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h
index e4553c5100f8..f3e045777a3d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.h
@@ -20,10 +20,4 @@ struct resource_pool *dcn351_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
 
-struct pipe_ctx *dcn351_acquire_free_pipe_as_secondary_dpp_pipe(
-		const struct dc_state *cur_ctx,
-		struct dc_state *new_ctx,
-		const struct resource_pool *pool,
-		const struct pipe_ctx *opp_head_pipe);
-
 #endif /* _DCN351_RESOURCE_H_ */
-- 
2.43.0


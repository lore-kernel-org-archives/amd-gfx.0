Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8CFCD1299
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E23112E89;
	Wed,  3 Apr 2024 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIl7SC5y";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DAB4112E83
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAW6eVV574OmZ9npSt/wh1Fe+BS5DGF+pa2kl30WBZ09g0GgUCA2LOOk08OR4ZT+Rx/rE0U8C4r8QQfnWUd4cx6sXcE1udtDSA4BeZhaKasiuD1KAT+15IP6Kio7bQdwGpBd9nPd8l76LZqEqM1R2yNoGeercmGDchm1mluE27kfVTTP1kyLBaPcyruBmi+l02kbfjrz4GitT90TAoDmz8UTEi0GgPkwpdsCxAgl5seqmUnoouzdktturCr3+zjZWZCfla/afLE3yfz529zVS6DJxX6FRCF0cuuP1/x3mKuL4uPcK+m/PUQm6ekugoZWxT/2iEyld8Ga3uyEX3Mkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EqNhzC1ZJWmWS9MKPCg7ly2ZvrCO22MZPPibpSQb7w=;
 b=bwZC+L1uroikUVNx9/DWMqD85io1VUmnByfuHkkShayCp0L+zCaDmyEeBqH0BoZl95cpYm6WtY8b4ZqbG2PboX+rubYCvKZMg0GA+VdIh1EcN3q/RygPuaP9k6pPsh+2n3efBK2l1svAjilnZRo91q16P/jZyu47q/3zYz+EwnCBY7wYckKJQpCoFUk0Bs+w9EatWa7YBux9k+0Qjes1pFpdl+c9o9ETJ1cL1UuXLRmsaf9A7l/fET0d+VQso/UxeOlrJQDT8bvWhIfq3K8Qdg6YNJyBI+sa2haULnIrYp9n7cUiZ2Wu0epErL0BFaqUuPeOoEJwypzybA4EFMW2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EqNhzC1ZJWmWS9MKPCg7ly2ZvrCO22MZPPibpSQb7w=;
 b=dIl7SC5yvvSKiUh4lh+jdnNZw+1AQRTt92RUtREDG8ZJtDvMVcCAWM76LH8dg9o2TBo6I262dbgBOdsHASJHpkJh8+xNkZ93cNrX0jTpTMWsPdRrrp6XAxw6IFpd0Tyu3HEJbFnNwJ7qO4blUkECgEQrhZu2XV8CfiXboGTvPTI=
Received: from CH0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:610:74::33)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:53 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::af) by CH0PR04CA0088.outlook.office365.com
 (2603:10b6:610:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:52 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:48 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 20/28] drm/amd/display: Drop legacy code
Date: Wed, 3 Apr 2024 15:49:10 -0400
Message-ID: <20240403195116.25221-21-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: f51c2111-234b-4c96-6cab-08dc54178263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXiGX4NR/bu1GnP3RzuufRxatKjBhPAI9LUyyWeCRIji89YsodUOTd05/vmPrMT2MqKqbM33h+UpRj1b/pdlMs6/QjzYmbiTrtS1Nxk7N1Hz2x6SUhUIavsGvh5LF1JhCIBnobmtemK0vKtdzSyMAUwckHNLQnCFqUY95zW3w1Ilr+9PPY5xHlwcShtErwNwEzF64Ukt0xVfIzLSqm25+ni/kAN3r4ZHdH4ty3lzLi+0kyeSWmoz1PHBEKQ7oKhnuxdRKm1a1/wMR31aFr/R/zIVplM8fQ3O/vonalmzQJzPKM754YQsqCSMCHMSkPa3cD/WFNb9QYdx6VjPAk8EEmjDAHkbC+VfeKwS7aPyFqIuUGbjLR4L/q+k8pZfxitu44FqeNbSUsMiirDVLr8YBwdRh5zO6iGHLErvwpMxvq0OzE+nTSVgD5PMtBcgCvCj+3mTIhLI+yylBaFeD2ZQ04MpCnI/fzii1nL8RgAGpydlkq+jxlwHHJdf4aQyzcZWMjPhSyRHzxUG5JKrcffg1iLDNmZAi32uB5GY3lOo1o7J4n7YLlIATOXd64VGXQ9+PmsVtWAoReVTygFo5fpU/OgUjt9tcXu3NiiGd5v1KhDjY+O5hU9azQRYgi0Z0s0joUfV93u7tFZ3ltpAjqwryywgXOXQs0gy5s9UH8JpMRyyHDgkTTuNGn45JI5yfmdJWjd0f39JVka9fvI2yUSZk4888tF/eXjuU0rVVQCMoK7pEgZNEkfPphp0/m1WHadp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:52.7677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51c2111-234b-4c96-6cab-08dc54178263
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit removes code that are not used by display anymore.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/inc/hw/stream_encoder.h    |  4 ---
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  7 ----
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    | 10 ------
 .../dc/resource/dcn21/dcn21_resource.c        | 33 +------------------
 4 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index a15efadb9183..75b9ec21f297 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -178,10 +178,6 @@ struct stream_encoder_funcs {
 	void (*stop_dp_info_packets)(
 		struct stream_encoder *enc);
 
-	void (*reset_fifo)(
-		struct stream_encoder *enc
-	);
-
 	void (*dp_blank)(
 		struct dc_link *link,
 		struct stream_encoder *enc);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 7cb0ed612716..361ad6b16b96 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -584,13 +584,6 @@ bool get_temp_dp_link_res(struct dc_link *link,
 		struct link_resource *link_res,
 		struct dc_link_settings *link_settings);
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
-struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
-		const struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		const struct dc_link *link);
-#endif
-
 void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
 	struct dc_state *context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index 58bdbd859bf9..d6f095b4555d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -462,16 +462,6 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	/* Set the min/max selectors unconditionally so that
-	 * DMCUB fw may change OTG timings when necessary
-	 * TODO: Remove the w/a after fixing the issue in DMCUB firmware
-	 */
-	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
-				 OTG_V_TOTAL_MIN_SEL, 1,
-				 OTG_V_TOTAL_MAX_SEL, 1,
-				 OTG_FORCE_LOCK_ON_EVENT, 0,
-				 OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
-
 	REG_SET_8(OTG_TRIGA_CNTL, 0,
 			OTG_TRIGA_SOURCE_SELECT, 21,
 			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 65d337731f56..8663cbc3d1cf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -581,32 +581,6 @@ static const struct resource_caps res_cap_rn = {
 		.num_dsc = 3,
 };
 
-#ifdef DIAGS_BUILD
-static const struct resource_caps res_cap_rn_FPGA_4pipe = {
-		.num_timing_generator = 4,
-		.num_opp = 4,
-		.num_video_plane = 4,
-		.num_audio = 7,
-		.num_stream_encoder = 4,
-		.num_pll = 4,
-		.num_dwb = 1,
-		.num_ddc = 4,
-		.num_dsc = 0,
-};
-
-static const struct resource_caps res_cap_rn_FPGA_2pipe_dsc = {
-		.num_timing_generator = 2,
-		.num_opp = 2,
-		.num_video_plane = 2,
-		.num_audio = 7,
-		.num_stream_encoder = 2,
-		.num_pll = 4,
-		.num_dwb = 1,
-		.num_ddc = 4,
-		.num_dsc = 2,
-};
-#endif
-
 static const struct dc_plane_cap plane_cap = {
 	.type = DC_PLANE_TYPE_DCN_UNIVERSAL,
 	.per_pixel_alpha = true,
@@ -1415,16 +1389,11 @@ static bool dcn21_resource_construct(
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
 	uint32_t pipe_fuses = read_pipe_fuses(ctx);
-	uint32_t num_pipes;
+	uint32_t num_pipes = 0;
 
 	ctx->dc_bios->regs = &bios_regs;
 
 	pool->base.res_cap = &res_cap_rn;
-#ifdef DIAGS_BUILD
-	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		//pool->base.res_cap = &res_cap_nv10_FPGA_2pipe_dsc;
-		pool->base.res_cap = &res_cap_rn_FPGA_4pipe;
-#endif
 
 	pool->base.funcs = &dcn21_res_pool_funcs;
 
-- 
2.44.0


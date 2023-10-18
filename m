Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C7CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8915010E40E;
	Wed, 18 Oct 2023 17:42:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA0E10E413
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaKwX2DVxGBA67YjMZ8T+bInTMCCnUSKp8bQARzQ50OCv8viwm7y8a34T4om1VCwkw8AKZ63apmj+M7qD+//LSO1aajKAIKiPByJPaP3ZpUfbPO9jKYrs453mRY6CyVLjsOQ8df7aH+nRj5TN4DwHxfcF7NBhBAyGnSLJkhKaU8OlXXEf8qPWHH4gideJM1NtJf9ARsVAkpG4UHJ2Y6zQLdqsgbO9YMjbNM469LMtKhtYvIdHNJ97jKoicYKu77AiuRj5zbJJ+FqsoH6iU9aveoQDSoQR1gej8iGE5ommjKKg9OxSFbYDW4cusVPpHE0+z7OajFJ3V1sLw7RTD5Fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVLBg1SQ2KfxPv2V4Fs2AkS19sgRQdg5rrNQvn7hCSg=;
 b=lHIkqZbhxJIClJU4t+/WmdXJzLUN2thubyWyruNEZkN+6Y2sZZeSuvRFHqu7X0/yRnmZ13XrZkC5fq3Ox2nTeVSywgWcqv6UPC0p09Ztslvm8AcN0ttrBNoOSKEN+tNQlNRyTCWdn6Y6F5tBpqULhGbBTHrvAOoc+TMNl7K8T/yMWVmGb2zbQgvZH8UKSohXsD/Aqyp+nKDdRA1i4QNswbOrjt7EftKddgMujQt9RuCyiTYGGd0GaQS/TzL7djub15qhgAc61cypxwwrtfsXaKA70/paU1RoxqrT+KVP6EgvNCwUGngAdURSDGrw8O5JTIJivIdFscU3dWTjvI6qhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVLBg1SQ2KfxPv2V4Fs2AkS19sgRQdg5rrNQvn7hCSg=;
 b=ySDdnrKVyN/aqzJEKsZ5e2MRK9Mo1owPe7+A2XICq89O4ooB6t+ASr83n9zAfYm3kgRA4WrOZ+GBWGsse1UPybwBHJ1JUOnXNFrXQIff+jq1IV1Zv5B7/Vf/1yivRkE95EquS72/DEdUUGm2oYrZ/8SPdajcnxiUMec5XWcWI+U=
Received: from BY5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:1e0::29)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:41:55 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::e4) by BY5PR03CA0019.outlook.office365.com
 (2603:10b6:a03:1e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:41:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:49 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:41:49 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/26] drm/amd/display: remove duplicated edp relink to
 fastboot
Date: Wed, 18 Oct 2023 13:41:08 -0400
Message-ID: <20231018174133.1613439-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cd7905-6c82-4465-8364-08dbd001854a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0b5LAFlPadxW5OtE4F+Slbumagvz2f5ehbw116LcLCiFC0Zwk8fdEVQp3DJZpnzDwGoDKyq4th+B9ajmy1bz/Vh4OdbTMux8oSrmQUgmB1cmmCOxW6YRb1O7dUByPDxHQyjtNk246aeOIb62qIK6zBpOFuEU3rNTR3lDnNwsWzOUJzSfdLRWZRYXy6nj/j6wgCdH8sog66odOAoOiQq0gHg254gFhckpO3SIg23QWIY+I8GNMpBbHkOStGp6itMNEhHVWSstxP+IAZv1Kt1EK5s15D3B37aU6QtzpkCeW4Bk+Zd4Qy1gMLPqxJIdN39g++cq2W8G3ItVPUO26ggEjNJ0BRGXwOLp3/b/rsUWN2SMQRQ4FEW55xoP7SD3nhNgwniBn0pId3CQ4Dxhj2ulw4/iaRywL370xa0QGMIxyf/sqKFsAA3kw7lz+wtYy3pYCqbhVsFQxOyKFh8LWlJBR6rR5sJUIkOjaFZTG8pzfFPlotM0NwxtQdPQLCTKRHGgcOUr+sAF3ZsOu/SbZWgPUMbXsa+nVy78H23G/mwmJwXIvmo03tMRBUIN8czzuMsAlhwvtgcpXdJrJf9OvFaPyXCcK/mjI3VI8Oaibi4WafBcug2+h2GKM4zfhvg25fFEPni+4RfJaLaE3NF60FLsFPQ9TJ44SC/RlAwTDYRdBj5uvozHHFBDN4ZRxbZggBsjGfI1jw9yKfx3TCPjt/jmIWoNT7bbWYlIx0OZrQuEd8yewfuTrj7oCWJWzlOLmpEXrogf2BwERsnWMXSMhYlow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(36756003)(86362001)(40480700001)(40460700003)(70206006)(316002)(6916009)(70586007)(36860700001)(356005)(81166007)(82740400003)(54906003)(47076005)(83380400001)(336012)(8936002)(2616005)(26005)(7696005)(1076003)(426003)(6666004)(2906002)(478600001)(8676002)(5660300002)(41300700001)(4326008)(2876002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:41:55.1448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cd7905-6c82-4465-8364-08dbd001854a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Chiawen Huang <chiawen.huang@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why&How]
enable_accelerated_mode function is fully to check
whether fastboot support or not.
It is no longer to disable_vbios_mode_if_required.
enable_stream_timing is allowed when seamless/fast
boot are disabled.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 62 -------------------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  8 ++-
 2 files changed, 5 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f602ff0d4146..49e31bd52992 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1215,67 +1215,6 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	dc_release_state(current_ctx);
 }
 
-static void disable_vbios_mode_if_required(
-		struct dc *dc,
-		struct dc_state *context)
-{
-	unsigned int i, j;
-
-	/* check if timing_changed, disable stream*/
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct dc_stream_state *stream = NULL;
-		struct dc_link *link = NULL;
-		struct pipe_ctx *pipe = NULL;
-
-		pipe = &context->res_ctx.pipe_ctx[i];
-		stream = pipe->stream;
-		if (stream == NULL)
-			continue;
-
-		if (stream->apply_seamless_boot_optimization)
-			continue;
-
-		// only looking for first odm pipe
-		if (pipe->prev_odm_pipe)
-			continue;
-
-		if (stream->link->local_sink &&
-			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-			link = stream->link;
-		}
-
-		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
-			unsigned int enc_inst, tg_inst = 0;
-			unsigned int pix_clk_100hz;
-
-			enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
-			if (enc_inst != ENGINE_ID_UNKNOWN) {
-				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-					if (dc->res_pool->stream_enc[j]->id == enc_inst) {
-						tg_inst = dc->res_pool->stream_enc[j]->funcs->dig_source_otg(
-							dc->res_pool->stream_enc[j]);
-						break;
-					}
-				}
-
-				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
-					dc->res_pool->dp_clock_source,
-					tg_inst, &pix_clk_100hz);
-
-				if (link->link_status.link_active) {
-					uint32_t requested_pix_clk_100hz =
-						pipe->stream_res.pix_clk_params.requested_pix_clk_100hz;
-
-					if (pix_clk_100hz != requested_pix_clk_100hz) {
-						dc->link_srv->set_dpms_off(pipe);
-						pipe->stream->dpms_off = false;
-					}
-				}
-			}
-		}
-	}
-}
-
 static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
@@ -1845,7 +1784,6 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc_streams[i] =  context->streams[i];
 
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
-		disable_vbios_mode_if_required(dc, context);
 		dc->hwss.enable_accelerated_mode(dc, context);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 74602a5fd6dd..8bf7d36ff092 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1546,8 +1546,9 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	 */
 	if (!(hws->wa.dp_hpo_and_otg_sequence && dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)))
 		/*  */
-		/* Do not touch stream timing on seamless boot optimization. */
-		if (!pipe_ctx->stream->apply_seamless_boot_optimization)
+		/* Do not touch stream timing on seamless/fast boot optimization. */
+		if (!pipe_ctx->stream->apply_seamless_boot_optimization &&
+			!pipe_ctx->stream->apply_edp_fast_boot_optimization)
 			hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
 
 	if (hws->funcs.setup_vupdate_interrupt)
@@ -1587,7 +1588,8 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	 * function core_link_enable_stream
 	 */
 	if (hws->wa.dp_hpo_and_otg_sequence && dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
-		if (!pipe_ctx->stream->apply_seamless_boot_optimization)
+		if (!pipe_ctx->stream->apply_seamless_boot_optimization &&
+			!pipe_ctx->stream->apply_edp_fast_boot_optimization)
 			hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
 	}
 
-- 
2.34.1


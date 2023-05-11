Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01869C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 15:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6962210E040;
	Thu, 11 May 2023 15:38:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D90E10E4F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 15:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3X99ABWbB1JtxwX7K58PSWe/paNzbQROZaCq60vv9iPGq2u8MwuK+uYgdGGNdP8W/E5FKaUTyGkeHlmV/1kL+VVNUz68NKdQiRr32tCP2WM1m/iC7K6aQXuAIxLZdkX2GLEch7z2TmUJCYOiKHVO6PtL/eoptSRuz5RNz280mWuYOilD+6BEs7QCwTu3xg4TPz3unSvGAtcYRCs/s85I7Rn2iC/0sF6BNtUIrOgiwbb5qwEBPSri6Wc5EyJwCTOtnvNUgB8OCboXj+BillEgySd8iChUmkpvHuv1KYSBFVHHyQsJvcTMm5vBADiTEQopssFGFt8UvXj/Zz4xZYANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3BXRr9AdxRpJO0RzgeH75yoQTyKZPBaJnnV3UsOglY=;
 b=bXZb5cKBoJHFYjrLtAd/07hITjEoeIdN8WNbr7b03ehLLhC8XFDMFkrqCwT1VuD98kDyFBXgbp/3RRMOL9Dk3p0Moaa2DUAsPPiMa9gpKjTwQ+WUhu38BayoCqm6B+koSDFUA5wBfVWmzyc+8cBnP4MlbBEgyJLaJi3tGt1PW5OqY7x4S/hyQEaF7NbyFAr8jlbCAeDh/yL8ISBvomRQqkZ4qBRE8pf/6GLdVNWgifjPkI2G5NMScwSkFGj9VxbtE4mNeXOhL94an9eL+rgPiaIQ+isjI1qtCzkVydO2jYGEL56QYI27gE6Sfwvz1pDU5H96TD7EXjamJfbKogCxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3BXRr9AdxRpJO0RzgeH75yoQTyKZPBaJnnV3UsOglY=;
 b=Hcrgo6S6wuhi9fRFSimo3pS6tIwIe3z2hsSDDC9f1yLGl75YT6nRBHt5F4tpXwe25k1hqdyTzlHfpRauUkDB1z32d+iF8/gL95cqfZSHgt/EYFc8RW0W+PxwItYG6NwVOopmk6tzIz0OW0DbGJaz0qTo9F1QvYEAumHxsNKu+Sk=
Received: from BN0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:408:ec::24)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 15:38:09 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::c1) by BN0PR04CA0109.outlook.office365.com
 (2603:10b6:408:ec::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21 via Frontend
 Transport; Thu, 11 May 2023 15:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 15:38:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 10:38:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 08:38:08 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 11 May 2023 10:38:08 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: formatting fixes for dcn30_hwseq.c
Date: Thu, 11 May 2023 11:38:07 -0400
Message-ID: <20230511153807.1154612-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
References: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT042:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b411a9-e039-40c5-7849-08db5235b8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7OwUzoHboAFSRWMIzoGJlfHShYA5NfJaaCk5tRByguB2jcHVCCf+pdDsTPm/NzwkKnNuyw0OgAMP+gJTtMynD+wcHdO8LRlLrWkkJ4/oEY2LDZjbU6/yJI0Y3wIbm/axySMsMcDxaP2srFRVpExARv4ChpAXa2lPa2CY+lmCEZ8tTfyjn/FXF7bWLyoYBF8SlJN8JT44NeT38ksDZwpuYQzOk2GjT7hMV5QS/u7EgFLn0XrSz7fE5zI967fXfJFTJ15xhFRDpSLJlFJZqV/XsdskdJKZpjjlLeogAwDJPm2V1LWWrxmLJDecm2hr5JDYxNLhvT5XXSXj80eU5jGRHhkv1ORvMvpO+2fJat4q8YiYyAuGMTU/hVn1hb7+zFVeOZaoR+/NLugEO378qBUrXgCWzsGjka25NyW8EaHZPaAyZpADmjVmEbqwfe2DfB+XxOwa+LoR3TpSAYJ3owr1BU7dFR0hSRGl1YG22jkH4xfVLReW8g5rBaFzZSeoFNCke6XDHgKcNGKbyRNmZyBnqnG5JfnY6QAov0BF3n+qC3lTycuYXFK73g9IVeVjmxJiuOy7obxhS2/olVBaV6139X95J+NSG9+ScLaCI9OMuxCGbLiXGx3ZZImUa3o4SVtsXcu9Muy03yEfbHWMBBiFWdyC0Mk5DS6pnauxK/sDi7dAM3y3/bS9EDgT5VQF3ZL8HQaRlxt04k/B9GKGsKTIfjTrhdO95whxp86WjABLLs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(316002)(8676002)(54906003)(8936002)(478600001)(44832011)(2906002)(70586007)(6916009)(70206006)(5660300002)(4326008)(47076005)(26005)(1076003)(40480700001)(356005)(186003)(40460700003)(82740400003)(7696005)(2616005)(36860700001)(426003)(336012)(36756003)(83380400001)(81166007)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:38:09.2624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b411a9-e039-40c5-7849-08db5235b8f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix whitespace issues and other trivial formatting fixes

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index c9ec158c5aa7..287b9a2bfde4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -90,8 +90,7 @@ bool dcn30_set_blend_lut(
 	return result;
 }
 
-static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
-				       const struct dc_stream_state *stream)
+static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream)
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
@@ -106,14 +105,13 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 		if (stream->func_shaper->type == TF_TYPE_HWPWL) {
 			shaper_lut = &stream->func_shaper->pwl;
 		} else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(stream->func_shaper,
-							       &dpp_base->shaper_params, true);
+			cm_helper_translate_curve_to_hw_format(stream->func_shaper, &dpp_base->shaper_params, true);
 			shaper_lut = &dpp_base->shaper_params;
 		}
 	}
 
 	if (stream->lut3d_func &&
-	    stream->lut3d_func->state.bits.initialized == 1 &&
+		stream->lut3d_func->state.bits.initialized == 1 &&
 	    stream->lut3d_func->state.bits.rmu_idx_valid == 1) {
 		if (stream->lut3d_func->state.bits.rmu_mux_num == 0)
 			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu0_mux;
@@ -121,20 +119,18 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu1_mux;
 		else if (stream->lut3d_func->state.bits.rmu_mux_num == 2)
 			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu2_mux;
+
 		if (mpcc_id_projected != mpcc_id)
 			BREAK_TO_DEBUGGER();
 		/* find the reason why logical layer assigned a different
 		 * mpcc_id into acquire_post_bldn_3dlut
 		 */
-		acquired_rmu = mpc->funcs->acquire_rmu(mpc, mpcc_id,
-						       stream->lut3d_func->state.bits.rmu_mux_num);
+		acquired_rmu = mpc->funcs->acquire_rmu(mpc, mpcc_id, stream->lut3d_func->state.bits.rmu_mux_num);
 		if (acquired_rmu != stream->lut3d_func->state.bits.rmu_mux_num)
 			BREAK_TO_DEBUGGER();
 
-		result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,
-						   stream->lut3d_func->state.bits.rmu_mux_num);
-		result = mpc->funcs->program_shaper(mpc, shaper_lut,
-						    stream->lut3d_func->state.bits.rmu_mux_num);
+		result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,stream->lut3d_func->state.bits.rmu_mux_num);
+		result = mpc->funcs->program_shaper(mpc, shaper_lut, stream->lut3d_func->state.bits.rmu_mux_num);
 	} else {
 		// loop through the available mux and release the requested mpcc_id
 		mpc->funcs->release_rmu(mpc, mpcc_id);
@@ -208,9 +204,9 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
 					stream->out_transfer_func,
 					&mpc->blender_params, false))
 				params = &mpc->blender_params;
-			 /* there are no ROM LUTs in OUTGAM */
-			if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
-				BREAK_TO_DEBUGGER();
+		/* there are no ROM LUTs in OUTGAM */
+		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
+			BREAK_TO_DEBUGGER();
 		}
 	}
 
@@ -893,8 +889,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.mall.header.type = DMUB_CMD__MALL;
 	cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_DISALLOW;
-	cmd.mall.header.payload_bytes =
-		sizeof(cmd.mall) - sizeof(cmd.mall.header);
+	cmd.mall.header.payload_bytes = sizeof(cmd.mall) - sizeof(cmd.mall.header);
 
 	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
-- 
2.40.0


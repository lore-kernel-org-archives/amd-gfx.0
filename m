Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB0606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tvpowTCa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3E610F8F4;
	Wed, 11 Nov 2026 01:45:14 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D5910F8F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9g+6oqmJtP+kFLBF/ylmKLReyfnRiHMoRapFjwXkddDc5uleJOlbWqPGqeRksSc5pSn5jJJ6A9hDrcmPNtkqKclrUjdcq9zyJnkMAyws6XAdY7qFVlPheA/VJTpguLTsaqxiuN3QTYShSa8DxCNpI7AM+vmtp1YF7easV6EbNnBBCRSpo1fUMKLBJsjz5AoJFo+DM+1DkOlBrdxNoPAj+D606MvO/yuzapmelyzNZvNVHkg5kA5VfUc2KgEoxDtGLuBEfmDsI5QV8RvPj8Mo+C6oHuwlMG9+E1ZMe75i5YTDqrGvQ3rUVpldaEJErtZSaYq280AOUQU/JTTzzW8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viAFwuMyikZFEgsh3sex5L6psFDWWljQYqS0nS/+uXo=;
 b=oeQBEEqSpfaAPAAGKVOBlsZ7Bb2ShwKMzCByA2zrYrDVu8asKhOzlQtWu3/NetbmI0EBwJDzJJ31FoHJtXJGT5ikUXI4wHVd4JXlSCqG6YHY56iVLJJaki5bKUsdNq7r7etMbJS6SIx+YLzKEClvyCh5Vqi1OKi6ZHQGhwh1G+/FsQ0RMY8IL3tHK4JaiU8ncBxMXhDYxkORzfT5yw5as5Kww4XXWztGCNvLrU/HWw9gD3CZq5Nt9HQN6p1W9AYamybZxBT5R2cWPPqpPN2yw8wp5/t00DYQUblR//KoaBfUDg5MMdFCgUWY2RH4cJ6RSLfcJNNvRmeO7UcS3+XNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viAFwuMyikZFEgsh3sex5L6psFDWWljQYqS0nS/+uXo=;
 b=tvpowTCaPqHpHKb5FappJqgUwQnkxgENbzXotcyZDfb2zgHudzvydCHDdHr1Dp6/lGzCQtKqB3F09hPEhjpZUllf189RPscei4OwydKKNgDTOQA6Bsq4kjHu1bur0YcJZ/a7ICYELw8pbxScOda4p/zOLW9XGuV4jY6OvxOW2NU=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by IA4PR12MB469045.namprd12.prod.outlook.com (2603:10b6:207:108::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:06 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::a5) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 11 Nov 2026 01:45:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:04 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:01 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sridevi Arvindekar <sridevi.arvindekar@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 65/74] drm/amd/display: Bypass chroma upsampling without the
 DPP cap
Date: Wed, 11 Nov 2026 09:29:11 +0800
Message-ID: <20261111014100.3596072-66-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|IA4PR12MB469045:EE_
X-MS-Office365-Filtering-Correlation-Id: a48084aa-014b-45f1-1393-08df3f956928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261102123227099003|261026121527099003|261021123027099003|261021121427099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z5LApk++/sXEP0dSM23vczAsYQi/CHixivPBwKI0CCG9lXAN0SweeurM3sJmKzNkHx8KQeElVmcdl6eyGM1ppufeFbSn3neeciKEKz8/+3zNkBacFWMQcFJdouyPztkFr/ouUsb+ENuhU+eawQ1Kwwk/3VQ80xJP45mvrGYPxZmxzmtZdBGA4tbbvb3orzS5Osb2sNcXw4qzS0QAkZT6SyWMHZRzjKfB4X9sSk6nBvVKRY3Ctkv2LAYpzdtswAygpvockMOhyqzME7FpIOzRgGcajOzQaxR53ailt78kCDRho0nN94qcLmfzknHZWXIyCmCX3s3pnY6IaexnMOw6FQ2VUSpeA1RgNJ2vhq5yrbBgB9WL8RXRMGhXlCaaliwMSI0S2TyoJ+CHRDPXOVoq+HlwMn8UhUS36p1+sBVRh8i0hIOKoKoRV+sGTDCTdDACrXYQg542OS6X8Yk048CcE1yxDDtx9tb8Ouy8abXBpwp7bHi0jP0Ay5f2w6Hgb8qANzcED2JhUpocoM1Ewatqsg9edFpHe+++j82fpBxZzAqD62uSzGJqALTZ/oGJIGjlU0ofJNJbXQn+hDvd5Nh9Mxfl0rjN5uVYZMXxtLGXaMZKabbksHT4OlnNr5Wf4D9tHqyZXwH40kmr9nepYB8Q+QJZ28L7arMIyW0RG8EbBiwQbDB540yljZh2QYDHepa0spCncIt2PX9mmAUKljHVqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GoruZzSxxQcAgMr4PzMGAYyOF4/pUWUvP0+ZdRC9CRjn6oMy6TRYsqUcVasfeO5+sLqlDtJVl1bjqJNpKVvO/ME33l2I8qEQi7SY9kHiyj4sVyXW75jlYYKeB20J4CzxxLVvykgVIQPAX+HjL/dcpCL2IdVNpxqkAksSE9sb8iXa6fuViT5w0oATvNiTrZs0LdxszUMr8+LmzF8LOCAES6XLhWomFCROXJRnFXHOZ2lj/Yb4uZuoea28Feor7aFrs/VNyIWr/zPZC0FYV7qd+pE8gnfLgX20oeBP5qWV6rhw1ha7Z5hIY+hzBW1qohtjpq2oy5ckl9e06oEAtavD7l4H07bgk+cA7EU8jY2MQyP1hWn/U6JjzN5uWzs8hbpZ7imrEz0gmm3Y+X0UORCpgzI5i9gp14Xl3VfpL3yjU8auLrZfEcY2A9DrNANhv8Iz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:05.5467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48084aa-014b-45f1-1393-08df3f956928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB469045
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

From: Sridevi Arvindekar <sridevi.arvindekar@amd.com>

[Why]
420 and 422 planes scaled in linear light asked for chroma
upsampling even when the DPP has no pre-scaler for it. The
scaler input forced bypass only for DCN 4.01, 4.2 and 4.2B.

[How]
resource_is_upsp_required() returns UPSP_BYPASS when
caps.color.dpp.upsp_pre_scaler is 0. Only DCN6 sets that
cap. translate_SPL_in_params_from_pipe_ctx() copies
scl_data.upsp for every ASIC.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/bls_builder/dcn401_seamless_builder.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c  | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c         | 8 ++++----
 drivers/gpu/drm/amd/display/dc/inc/resource.h             | 3 ++-
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
index 23951ef4fe04..8a563386d725 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
@@ -1789,7 +1789,7 @@ static void dcn401_add_step(struct block_sequence_state *sequence,
 				plane->input_csc_color_matrix;
 		p->setup_dpp_params.color_space = plane->color_space;
 		p->setup_dpp_params.upsp_mode = resource_is_upsp_required(
-				plane->format, plane->scaling_linearity);
+				(bool) plane->ctx->dc->caps.color.dpp.upsp_pre_scaler, plane->format, plane->scaling_linearity);
 		break;
 	case DPP_SET_CURSOR_MATRIX:
 		p->dpp_set_cursor_matrix_params.dpp = dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index c5e8a88d051d..82ac4ca4a13b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -5793,7 +5793,7 @@ void hwss_add_dpp_setup_dpp(struct block_sequence_state *seq_state,
 		p->format = plane_state->format;
 		p->input_csc_color_matrix = plane_state->input_csc_color_matrix;
 		p->color_space = plane_state->color_space;
-		p->upsp_mode = resource_is_upsp_required(plane_state->format, plane_state->scaling_linearity);
+		p->upsp_mode = resource_is_upsp_required((bool)plane_state->ctx->dc->caps.color.dpp.upsp_pre_scaler, plane_state->format, plane_state->scaling_linearity);
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 3e87ec8ad6a5..2240afde4089 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1608,7 +1608,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
 
 		pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
-		pipe_ctx->plane_res.scl_data.upsp = resource_is_upsp_required(plane_state->format, plane_state->scaling_linearity);
+		pipe_ctx->plane_res.scl_data.upsp = resource_is_upsp_required((bool)plane_state->ctx->dc->caps.color.dpp.upsp_pre_scaler, plane_state->format, plane_state->scaling_linearity);
 
 		// Convert pipe_ctx to respective input params for SPL
 		translate_SPL_in_params_from_pipe_ctx(pipe_ctx, spl_in);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c
index 55dfa465163f..d3987be3ce39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c
@@ -26,9 +26,14 @@
 #include "sspl/dc_spl_types.h"
 #include "resource.h"
 
-enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format,
+enum upsp_mode resource_is_upsp_required(bool upsp_pre_scaler,
+		enum surface_pixel_format format,
 		enum dc_scaling_linearity scaling_linearity)
 {
+	/* UPSP is not supported on all ASICs */
+	if (!upsp_pre_scaler)
+		return UPSP_BYPASS;
+
 	bool scaling_in_linear = (scaling_linearity == DC_SCALING_LINEARITY_LINEAR);
 	bool is_420_format = (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
 		format <= SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 00e121bb8ef7..1b7f0ee6ba97 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -211,19 +211,19 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	// Translate linear light scaling preference
 	if (pipe_ctx->stream->ctx->dc->debug.force_lls > 0) {
 		spl_in->lls_pref = pipe_ctx->stream->ctx->dc->debug.force_lls;
-		spl_in->upsp_mode = pipe_ctx->plane_res.scl_data.upsp;
 	} else {
 		if ((plane_state->ctx->dce_version == DCN_VERSION_4_01) ||
 			(plane_state->ctx->dce_version == DCN_VERSION_4_2) ||
 			(plane_state->ctx->dce_version == DCN_VERSION_4_2B)) {
 			spl_in->lls_pref = LLS_PREF_DONT_CARE;
-			spl_in->upsp_mode = UPSP_BYPASS;
 		} else {
 			set_linear_light_scaling_preference(plane_state, spl_in);
-			/* Translate upsampling mode*/
-			spl_in->upsp_mode = pipe_ctx->plane_res.scl_data.upsp;
 		}
 	}
+
+	/* Translate upsampling mode*/
+	spl_in->upsp_mode = pipe_ctx->plane_res.scl_data.upsp;
+
 	/* Translate chroma subsampling offset ( cositing ) */
 	if (pipe_ctx->stream->ctx->dc->debug.force_cositing) {
 		spl_in->basic_in.cositing = pipe_ctx->stream->ctx->dc->debug.force_cositing - 1;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 0d9c9771ea7c..fbd874476aaf 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -123,7 +123,8 @@ void resource_build_test_pattern_params(
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pipe_ctx);
 
-enum upsp_mode resource_is_upsp_required(enum surface_pixel_format format,
+enum upsp_mode resource_is_upsp_required(bool upsp_pre_scaler,
+		enum surface_pixel_format format,
 		enum dc_scaling_linearity scaling_linearity);
 
 bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx);
-- 
2.43.0


Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9CC47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F74660FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F74660FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005926E92E;
	Mon,  7 Jun 2021 16:48:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F118A6E92E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK96qfkxR7Hqc0KJkV4JP0E+BBhbFDLvPCd1Et4akZ4DpKF3MbBXz42zWIkn7qNiUezNSO4xU65eZzeNi+6h2dvUMnubJ0M42TtLmJqC6UCzXevjmwMOp/OuNCYLS7fhY3RV97O0N2k98i0bD6YGpi+4wGQ9Y/e3ufDND5PAt8lRiPB43HwTPhb7nSjC+Ctbz/VJ0xDRHcDtPJFmNYYvgtRk5w5zCGALCfrKppQRzUQfPmyCDlz+jVT83/cD3oQ/o5XJsBZkUc+nOb8WhVw2O2v0yrJOG6IEVspSWxfUelTd5aLz9RWP4uUABJQffiyWGAJZvnoFXl6k6XysL565Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5un6lGL8esklBmdDNtbuuo6qkJLneu68EGdQj6mcEI=;
 b=E8zkHq9Ov4CSSd0gjNwH/L5xftgVUcQyFCbjWkPMYcCXE7MoJ4Af0ntUF3nRDGWJ3d6JLf1rH0SQ7SCj44ILGQ+JwMRPHfX2IqBqmhc7JkaP6ZMeaDsU3vcFmIExlXT2FWYlBB8IwtCJCtMc5+4Fx6Ogf5mSCu7SVsudGC4fviBRhASf/tI14xg6RfdT19g2rsYMBTsFTiyy7MITuupoFJlA6zGaDWukAIUujDW3bJeR+OVZQirXcF8fJSR1itNtsTNjySX7fawi7sKQgf0QCL3p2csOfV6utsuAeo+oFfJhPDJWjO344B3RNhj8HNn6uFZGxiBFwF53f9RwdsVKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5un6lGL8esklBmdDNtbuuo6qkJLneu68EGdQj6mcEI=;
 b=oJY9Ey0EY0kAiflmHg53oq9LFFxvitpsWlXW6K/HzLRqIRlLjI2FPB8a6GkM1nOEUwrHYDACgATuBNzow6gMK1myPZGT6VSOQkImVpDW4cWO4MporbVeHchqFWkRPKnnoEl5o4geLAuEpT9jNcFh209gCMjSxpaJ2r+e6SphlyI=
Received: from BN9PR03CA0263.namprd03.prod.outlook.com (2603:10b6:408:ff::28)
 by BN6PR12MB1812.namprd12.prod.outlook.com (2603:10b6:404:108::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:48:08 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::4) by BN9PR03CA0263.outlook.office365.com
 (2603:10b6:408:ff::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:07 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:03 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/30] drm/amd/display: Refactor visual confirm
Date: Tue, 8 Jun 2021 00:46:50 +0800
Message-ID: <20210607164714.311325-7-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6334b0c7-8ca5-4f80-5c02-08d929d406b8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1812:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18129A958483582C0FBAAA84FF389@BN6PR12MB1812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5sQB1wzkapyodOim1qY9fLn+z9RckSqXRAhzIkGY7dbnBKHW9qdfFppA9JL63ncZHGLD/DwXOQ2k3k0b86PfknvNaop6BpKAEhQs+i5uGLeZXubNFNIk/wJHd54LiKm5s3dfAO9/LsBVXQaVVBFyK91KdEgWpU97dnmr6hjgIul1+ichasSdApj5YV08YbYYxUhQSKFqReItys0+AWMmPJzQFiOs+WO9haWvMFj8SEO5OK9rgPV8AoGyhKfDPp1ipDjdwYIMegGaOTid9rCUGxlwFVIPYKtk2difLy8gG4bT9HuZwY0YYbQi5zKBuqpTUewjhdOtVXkCCAlGfdx2M4XxsqaOPcnUchHKeUi15qMEDGMc0YbL4B4Vv5bkZeVH+Rqw2VX4EeialxU5CPqF4iLkt2GK25kg5EycZ6czrYaR1XAeQ8zJUqYv+KCgiSdUDidT9CGrRKTWhqgQW3vyFspAT59zZo+ZwZBjN+ZdwUjxGptmCB6Irg8k1FudDOhiPzz2cfK6lo5kcp/6AiTH1hY2ulam5rc9mytqVkdue8Ex3zJWffxeEgImPsXk7b/GhKe5dvlG2u9MwlDbBPkhoYqebmCZV0jQaHrddRsCQCPoKBWl4ESH3VFaWd7fikL9NMXxSVoZ/AcWHNs7OLXfkzZDNGP9SOYobbqZ90QzCjUmRscTlMr44zssvUjZrSJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(36840700001)(46966006)(8936002)(6666004)(316002)(63350400001)(82740400003)(63370400001)(26005)(16526019)(426003)(30864003)(186003)(82310400003)(1076003)(70206006)(44832011)(70586007)(36756003)(356005)(478600001)(4326008)(6916009)(36860700001)(54906003)(7696005)(5660300002)(86362001)(2906002)(336012)(83380400001)(8676002)(81166007)(2616005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:07.1757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6334b0c7-8ca5-4f80-5c02-08d929d406b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1812
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why + How]
Visual confirm has no asic-specific logic,
so we can refactor and unify these functions
that are currently spread out across multiple
dcn files.
Add a new hw sequencer interface update_visual_confirm_color,
and a new mpc function pointer set_bg_color.
This will allow visual confirm to updated independently
of MPCC blending updates.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  98 ++++++++++++++++
 .../display/dc/dce110/dce110_hw_sequencer.c   |  35 ------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 108 +++---------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  12 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  43 +++----
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  15 +++
 .../amd/display/dc/inc/hw_sequencer_private.h |   5 -
 17 files changed, 170 insertions(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2a9080400bdd..e0badab842ba 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -291,3 +291,101 @@ bool hwss_wait_for_blank_complete(
 
 	return true;
 }
+
+void get_mpctree_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	const struct tg_color pipe_colors[6] = {
+			{MAX_TG_COLOR_VALUE, 0, 0}, /* red */
+			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE / 4, 0}, /* orange */
+			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE, 0}, /* yellow */
+			{0, MAX_TG_COLOR_VALUE, 0}, /* green */
+			{0, 0, MAX_TG_COLOR_VALUE}, /* blue */
+			{MAX_TG_COLOR_VALUE / 2, 0, MAX_TG_COLOR_VALUE / 2}, /* purple */
+	};
+
+	struct pipe_ctx *top_pipe = pipe_ctx;
+
+	while (top_pipe->top_pipe)
+		top_pipe = top_pipe->top_pipe;
+
+	*color = pipe_colors[top_pipe->pipe_idx];
+}
+
+void get_surface_visual_confirm_color(
+		const struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+
+	switch (pipe_ctx->plane_res.scl_data.format) {
+	case PIXEL_FORMAT_ARGB8888:
+		/* set border color to red */
+		color->color_r_cr = color_value;
+		break;
+
+	case PIXEL_FORMAT_ARGB2101010:
+		/* set border color to blue */
+		color->color_b_cb = color_value;
+		break;
+	case PIXEL_FORMAT_420BPP8:
+		/* set border color to green */
+		color->color_g_y = color_value;
+		break;
+	case PIXEL_FORMAT_420BPP10:
+		/* set border color to yellow */
+		color->color_g_y = color_value;
+		color->color_r_cr = color_value;
+		break;
+	case PIXEL_FORMAT_FP16:
+		/* set border color to white */
+		color->color_r_cr = color_value;
+		color->color_b_cb = color_value;
+		color->color_g_y = color_value;
+		break;
+	default:
+		break;
+	}
+}
+
+void get_hdr_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+
+	/* Determine the overscan color based on the top-most (desktop) plane's context */
+	struct pipe_ctx *top_pipe_ctx  = pipe_ctx;
+
+	while (top_pipe_ctx->top_pipe != NULL)
+		top_pipe_ctx = top_pipe_ctx->top_pipe;
+
+	switch (top_pipe_ctx->plane_res.scl_data.format) {
+	case PIXEL_FORMAT_ARGB2101010:
+		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
+			/* HDR10, ARGB2101010 - set border color to red */
+			color->color_r_cr = color_value;
+		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+			/* FreeSync 2 ARGB2101010 - set border color to pink */
+			color->color_r_cr = color_value;
+			color->color_b_cb = color_value;
+		}
+		break;
+	case PIXEL_FORMAT_FP16:
+		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
+			/* HDR10, FP16 - set border color to blue */
+			color->color_b_cb = color_value;
+		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
+			/* FreeSync 2 HDR - set border color to green */
+			color->color_g_y = color_value;
+		}
+		break;
+	default:
+		/* SDR - set border color to Gray */
+		color->color_r_cr = color_value/2;
+		color->color_b_cb = color_value/2;
+		color->color_g_y = color_value/2;
+		break;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index e73198738fd8..66405507a857 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1310,41 +1310,6 @@ static void build_audio_output(
 			pipe_ctx->pll_settings.ss_percentage;
 }
 
-static void get_surface_visual_confirm_color(const struct pipe_ctx *pipe_ctx,
-		struct tg_color *color)
-{
-	uint32_t color_value = MAX_TG_COLOR_VALUE * (4 - pipe_ctx->stream_res.tg->inst) / 4;
-
-	switch (pipe_ctx->plane_res.scl_data.format) {
-	case PIXEL_FORMAT_ARGB8888:
-		/* set boarder color to red */
-		color->color_r_cr = color_value;
-		break;
-
-	case PIXEL_FORMAT_ARGB2101010:
-		/* set boarder color to blue */
-		color->color_b_cb = color_value;
-		break;
-	case PIXEL_FORMAT_420BPP8:
-		/* set boarder color to green */
-		color->color_g_y = color_value;
-		break;
-	case PIXEL_FORMAT_420BPP10:
-		/* set boarder color to yellow */
-		color->color_g_y = color_value;
-		color->color_r_cr = color_value;
-		break;
-	case PIXEL_FORMAT_FP16:
-		/* set boarder color to white */
-		color->color_r_cr = color_value;
-		color->color_b_cb = color_value;
-		color->color_g_y = color_value;
-		break;
-	default:
-		break;
-	}
-}
-
 static void program_scaler(const struct dc *dc,
 		const struct pipe_ctx *pipe_ctx)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index ef37d3abaa56..be5287e39dc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2407,83 +2407,6 @@ void dcn10_program_output_csc(struct dc *dc,
 	}
 }
 
-void dcn10_get_surface_visual_confirm_color(
-		const struct pipe_ctx *pipe_ctx,
-		struct tg_color *color)
-{
-	uint32_t color_value = MAX_TG_COLOR_VALUE;
-
-	switch (pipe_ctx->plane_res.scl_data.format) {
-	case PIXEL_FORMAT_ARGB8888:
-		/* set border color to red */
-		color->color_r_cr = color_value;
-		break;
-
-	case PIXEL_FORMAT_ARGB2101010:
-		/* set border color to blue */
-		color->color_b_cb = color_value;
-		break;
-	case PIXEL_FORMAT_420BPP8:
-		/* set border color to green */
-		color->color_g_y = color_value;
-		break;
-	case PIXEL_FORMAT_420BPP10:
-		/* set border color to yellow */
-		color->color_g_y = color_value;
-		color->color_r_cr = color_value;
-		break;
-	case PIXEL_FORMAT_FP16:
-		/* set border color to white */
-		color->color_r_cr = color_value;
-		color->color_b_cb = color_value;
-		color->color_g_y = color_value;
-		break;
-	default:
-		break;
-	}
-}
-
-void dcn10_get_hdr_visual_confirm_color(
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color)
-{
-	uint32_t color_value = MAX_TG_COLOR_VALUE;
-
-	// Determine the overscan color based on the top-most (desktop) plane's context
-	struct pipe_ctx *top_pipe_ctx  = pipe_ctx;
-
-	while (top_pipe_ctx->top_pipe != NULL)
-		top_pipe_ctx = top_pipe_ctx->top_pipe;
-
-	switch (top_pipe_ctx->plane_res.scl_data.format) {
-	case PIXEL_FORMAT_ARGB2101010:
-		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
-			/* HDR10, ARGB2101010 - set border color to red */
-			color->color_r_cr = color_value;
-		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
-			/* FreeSync 2 ARGB2101010 - set border color to pink */
-			color->color_r_cr = color_value;
-			color->color_b_cb = color_value;
-		}
-		break;
-	case PIXEL_FORMAT_FP16:
-		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
-			/* HDR10, FP16 - set border color to blue */
-			color->color_b_cb = color_value;
-		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
-			/* FreeSync 2 HDR - set border color to green */
-			color->color_g_y = color_value;
-		}
-		break;
-	default:
-		/* SDR - set border color to Gray */
-		color->color_r_cr = color_value/2;
-		color->color_b_cb = color_value/2;
-		color->color_g_y = color_value/2;
-		break;
-	}
-}
-
 static void dcn10_update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
 {
 	struct dc_bias_and_scale bns_params = {0};
@@ -2502,9 +2425,24 @@ static void dcn10_update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state
 		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
 }
 
+void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
+{
+	struct mpc *mpc = dc->res_pool->mpc;
+
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
+		get_hdr_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
+		get_surface_visual_confirm_color(pipe_ctx, color);
+	else
+		color_space_to_black_color(
+				dc, pipe_ctx->stream->output_color_space, color);
+
+	if (mpc->funcs->set_bg_color)
+		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
+}
+
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	struct dce_hwseq *hws = dc->hwseq;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct mpcc_blnd_cfg blnd_cfg = {{0}};
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
@@ -2513,18 +2451,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR) {
-		hws->funcs.get_hdr_visual_confirm_color(
-				pipe_ctx, &blnd_cfg.black_color);
-	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE) {
-		hws->funcs.get_surface_visual_confirm_color(
-				pipe_ctx, &blnd_cfg.black_color);
-	} else {
-		color_space_to_black_color(
-				dc, pipe_ctx->stream->output_color_space,
-				&blnd_cfg.black_color);
-	}
-
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
@@ -2559,6 +2485,7 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	/* If there is no full update, don't need to touch MPC tree*/
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
+		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
 		return;
 	}
 
@@ -2580,6 +2507,7 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 			NULL,
 			hubp->inst,
 			mpcc_id);
+	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
 
 	ASSERT(new_mpcc != NULL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index c9bdffe5989b..9ae07c77fdc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -189,12 +189,6 @@ void dcn10_bios_golden_init(struct dc *dc);
 void dcn10_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
-void dcn10_get_surface_visual_confirm_color(
-		const struct pipe_ctx *pipe_ctx,
-		struct tg_color *color);
-void dcn10_get_hdr_visual_confirm_color(
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color);
 bool dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context);
@@ -206,4 +200,10 @@ void dcn10_verify_allow_pstate_change_high(struct dc *dc);
 
 void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits);
 
+void dcn10_update_visual_confirm_color(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color,
+		int mpcc_id);
+
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 680ca53455a2..34001a30d449 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -82,6 +82,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
@@ -111,8 +112,6 @@ static const struct hwseq_private_funcs dcn10_private_funcs = {
 	.dpp_pg_control = dcn10_dpp_pg_control,
 	.hubp_pg_control = dcn10_hubp_pg_control,
 	.dsc_pg_control = NULL,
-	.get_surface_visual_confirm_color = dcn10_get_surface_visual_confirm_color,
-	.get_hdr_visual_confirm_color = dcn10_get_hdr_visual_confirm_color,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index b096011acb49..11019c2c62cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -45,6 +45,8 @@ void mpc1_set_bg_color(struct mpc *mpc,
 	struct mpcc *bottommost_mpcc = mpc1_get_mpcc(mpc, mpcc_id);
 	uint32_t bg_r_cr, bg_g_y, bg_b_cb;
 
+	bottommost_mpcc->blnd_cfg.black_color = *bg_color;
+
 	/* find bottommost mpcc. */
 	while (bottommost_mpcc->mpcc_bot) {
 		bottommost_mpcc = bottommost_mpcc->mpcc_bot;
@@ -81,7 +83,6 @@ static void mpc1_update_blending(
 			MPCC_GLOBAL_ALPHA,		blnd_cfg->global_alpha,
 			MPCC_GLOBAL_GAIN,		blnd_cfg->global_gain);
 
-	mpc1_set_bg_color(mpc, &blnd_cfg->black_color, mpcc_id);
 	mpcc->blnd_cfg = *blnd_cfg;
 }
 
@@ -495,6 +496,7 @@ static const struct mpc_funcs dcn10_mpc_funcs = {
 	.set_output_csc = NULL,
 	.set_output_gamma = NULL,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
+	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn10_mpc_construct(struct dcn10_mpc *mpc10,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 14e322761645..6df9009a6764 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -51,6 +51,7 @@
 #include "dccg.h"
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "hw_sequencer.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -2245,31 +2246,24 @@ void dcn20_reset_hw_ctx_wrap(
 	}
 }
 
-void dcn20_get_mpctree_visual_confirm_color(
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color)
+void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
 {
-	const struct tg_color pipe_colors[6] = {
-			{MAX_TG_COLOR_VALUE, 0, 0}, // red
-			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE / 4, 0}, // orange
-			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE, 0}, // yellow
-			{0, MAX_TG_COLOR_VALUE, 0}, // green
-			{0, 0, MAX_TG_COLOR_VALUE}, // blue
-			{MAX_TG_COLOR_VALUE / 2, 0, MAX_TG_COLOR_VALUE / 2}, // purple
-	};
-
-	struct pipe_ctx *top_pipe = pipe_ctx;
-
-	while (top_pipe->top_pipe) {
-		top_pipe = top_pipe->top_pipe;
-	}
+	struct mpc *mpc = dc->res_pool->mpc;
 
-	*color = pipe_colors[top_pipe->pipe_idx];
+	// input to MPCC is always RGB, by default leave black_color at 0
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
+		get_hdr_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
+		get_surface_visual_confirm_color(pipe_ctx, color);
+	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE)
+		get_mpctree_visual_confirm_color(pipe_ctx, color);
+
+	if (mpc->funcs->set_bg_color)
+		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
 }
 
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	struct dce_hwseq *hws = dc->hwseq;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct mpcc_blnd_cfg blnd_cfg = { {0} };
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha;
@@ -2278,15 +2272,6 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 
-	// input to MPCC is always RGB, by default leave black_color at 0
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR) {
-		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
-	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE) {
-		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
-	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE) {
-		dcn20_get_mpctree_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
-	}
-
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
@@ -2324,6 +2309,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update &&
 		!pipe_ctx->update_flags.bits.mpcc) {
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
+		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
 		return;
 	}
 
@@ -2345,6 +2331,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 			NULL,
 			hubp->inst,
 			mpcc_id);
+	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
 
 	ASSERT(new_mpcc != NULL);
 	hubp->opp_id = pipe_ctx->stream_res.opp->inst;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index c69f766a40ce..6bba191cd33e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -146,5 +146,10 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
+void dcn20_update_visual_confirm_color(struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color,
+		int mpcc_id);
+
 #endif /* __DC_HWSS_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index b5bb613eed4d..5cfd4b0afea5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -96,6 +96,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 #endif
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
@@ -125,8 +126,6 @@ static const struct hwseq_private_funcs dcn20_private_funcs = {
 	.hubp_pg_control = dcn20_hubp_pg_control,
 	.update_odm = dcn20_update_odm,
 	.dsc_pg_control = dcn20_dsc_pg_control,
-	.get_surface_visual_confirm_color = dcn10_get_surface_visual_confirm_color,
-	.get_hdr_visual_confirm_color = dcn10_get_hdr_visual_confirm_color,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 6a99fdd55e8c..947eb0df3f12 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -67,7 +67,6 @@ void mpc2_update_blending(
 	REG_SET(MPCC_BOT_GAIN_INSIDE[mpcc_id], 0, MPCC_BOT_GAIN_INSIDE, blnd_cfg->bottom_inside_gain);
 	REG_SET(MPCC_BOT_GAIN_OUTSIDE[mpcc_id], 0, MPCC_BOT_GAIN_OUTSIDE, blnd_cfg->bottom_outside_gain);
 
-	mpc1_set_bg_color(mpc, &blnd_cfg->black_color, mpcc_id);
 	mpcc->blnd_cfg = *blnd_cfg;
 }
 
@@ -557,6 +556,7 @@ const struct mpc_funcs dcn20_mpc_funcs = {
 	.set_output_gamma = mpc2_set_output_gamma,
 	.power_on_mpc_mem_pwr = mpc20_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
+	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn20_mpc_construct(struct dcn20_mpc *mpc20,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 4f20a85ff396..54c11ba550ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
@@ -129,8 +130,6 @@ static const struct hwseq_private_funcs dcn21_private_funcs = {
 	.hubp_pg_control = dcn20_hubp_pg_control,
 	.update_odm = dcn20_update_odm,
 	.dsc_pg_control = dcn20_dsc_pg_control,
-	.get_surface_visual_confirm_color = dcn10_get_surface_visual_confirm_color,
-	.get_hdr_visual_confirm_color = dcn10_get_hdr_visual_confirm_color,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.s0i3_golden_init_wa = dcn21_s0i3_golden_init_wa,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index bf7fa98b39eb..3a5b53dd2f6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -99,6 +99,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
@@ -129,8 +130,6 @@ static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn20_update_odm,
 	.dsc_pg_control = dcn20_dsc_pg_control,
-	.get_surface_visual_confirm_color = dcn10_get_surface_visual_confirm_color,
-	.get_hdr_visual_confirm_color = dcn10_get_hdr_visual_confirm_color,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index 950c9bfd53de..a82319f4d081 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1431,7 +1431,7 @@ const struct mpc_funcs dcn30_mpc_funcs = {
 	.release_rmu = mpcc3_release_rmu,
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
-
+	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn30_mpc_construct(struct dcn30_mpc *mpc30,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 70b053d9ba40..e85b695f2351 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -101,6 +101,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
@@ -131,8 +132,6 @@ static const struct hwseq_private_funcs dcn301_private_funcs = {
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn20_update_odm,
 	.dsc_pg_control = dcn20_dsc_pg_control,
-	.get_surface_visual_confirm_color = dcn10_get_surface_visual_confirm_color,
-	.get_hdr_visual_confirm_color = dcn10_get_hdr_visual_confirm_color,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 75c77ad9cbfe..640bb432bd6a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -363,6 +363,9 @@ struct mpc_funcs {
 			struct mpc *mpc,
 			int opp_id);
 
+	void (*set_bg_color)(struct mpc *mpc,
+			struct tg_color *bg_color,
+			int mpcc_id);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 1d5853c95448..25b3933375c7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -235,6 +235,10 @@ struct hw_sequencer_funcs {
 			enum dc_color_depth color_depth,
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
+	void (*update_visual_confirm_color)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct tg_color *color,
+			int mpcc_id);
 };
 
 void color_space_to_black_color(
@@ -249,4 +253,15 @@ const uint16_t *find_color_matrix(
 		enum dc_color_space color_space,
 		uint32_t *array_size);
 
+void get_surface_visual_confirm_color(
+		const struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
+
+void get_hdr_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
+void get_mpctree_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 36e906bb6bfc..f7f7e4fff0c2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -127,11 +127,6 @@ struct hwseq_private_funcs {
 			const struct dc_stream_state *stream,
 			struct dc_state *context);
 	bool (*s0i3_golden_init_wa)(struct dc *dc);
-	void (*get_surface_visual_confirm_color)(
-			const struct pipe_ctx *pipe_ctx,
-			struct tg_color *color);
-	void (*get_hdr_visual_confirm_color)(struct pipe_ctx *pipe_ctx,
-			struct tg_color *color);
 	void (*set_hdr_multiplier)(struct pipe_ctx *pipe_ctx);
 	void (*verify_allow_pstate_change_high)(struct dc *dc);
 	void (*program_pipe)(struct dc *dc,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

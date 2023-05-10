Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA55C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B0210E51E;
	Wed, 10 May 2023 20:49:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B6110E522
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aapjOvK2ylC0yMCbi40hCCtep7n7TiCkUw/U+Uk3jN6z/37f3auayDFUJlo7CsL+uGPNZCdhvkGmNDzdAffpRyQIuQehTT+kpt2eizdxRMWYeC04MP9UHmJRJK1SeM+A4HDpsVW9yxS3nDue1zxS4N1OiwYZIpcefiPKWy3NiSAN3TK3OO3uNuvj89N8QrTRuBRJMTOtWnSpvG6gks4bwh3CwNCmy6Od7gfLU5cjG3XxP2fof6YkN8PFL24SYuzbDySLHBorQSTOwNKyNrRmt6n8nkuT/zf0UinzNvhlDQ7+gUdCW6puaTzS32Tx9tTJJkngvwhEbI0BoVkSAMI24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XjiqjcqY5WphH+CCH6n9X+hJwvBUgWLMqOzTbht9NQ=;
 b=QFm7e7tCwSXwF6/UVLcC3Dk9xmFrAFHBOfRkOkXKVHo8qve19b2VTebIslWPBvhtceQoaMVJW8Gum35NtDVKYIm9rDvUODT/lEc0CQ4Ao9JL1zCWqNI3N2xpn2bby76i1ifXOgbk5EKmanUzCCWrEPb26Fw7T/oXL/7AwcQkeNZQ50l95oioh15WNwP71OW/YEUGAl3m+obUt4nV9FQWUjODbrume/5SUlFcto9lCHOTcFjViCUrVmrHQu3pKWK2lNy0ExdY8EKmYVfD78YPC8MWuLOkoONL2XHVTYKI0MFPVU4fxgRyT5OaqNhcVGuAhaW903LE7LZppV0Ns/WXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XjiqjcqY5WphH+CCH6n9X+hJwvBUgWLMqOzTbht9NQ=;
 b=sZqPuH+HlGAzFvsU8fzuygXyvbYGGcAdnCjhX+7e0vaLZgA8XofEqNje7M2gNnOaySxNFLiuk+M02gcsabiN5W7CcDX3JhHiL1dfYp8ZQD7BXjYN0eW9Y/JZN3K07NO7fQ0Hvoez8fqQSKQa8Xei6XmPd+FB5yf+JheCPnbyZqo=
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 20:49:13 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::8a) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 20:49:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:12 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:11 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amd/display: Fix possible underflow for displays
 with large vblank
Date: Wed, 10 May 2023 16:48:55 -0400
Message-ID: <20230510204900.949963-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b01731-2465-4c78-2f75-08db519802dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2xdYsTv23lfSniKWvJzQM5XqAv5TxnN+bsM4LyfYC07MitQNV/4gnWbh0wHTgaLhxAAXX7G90Rx+i1k4bS12DZn9Kt14/v+ykXTmo9pFjlLpD7/zsSZ0sBFjkYEtQeUJxK4/atWCqelk7suHnU+vO5OtAIYrpji82/nbMjwLKIkMdho7zzvI5BOHbHVdP1Hj/VL+HdKwImgQd8wHm66XOm3B+d1MvhnXlAJ1Uft276TZ7PK3Sw33A9sdGkDYYV3ad6oQoZC2TCSZqwaxmkX96wEFGBI7bLaTZ5dvx0arPeHoGDxuBIZe5BGgw+x/6cEvRe7z9zQtSgnb+/Kl8RyKBSz0eDgP4JmWig0bVv1kyM8e+REhO1wk5u0xCjLMbfHFySnuQdzQbdrBU3E+sW6j4KFwCDB3nG9jxi0XKV7WC9sr5obgf5ykDIJuTSANwUXT/T4hb/imOpB1CRtt0nJLr0bRPgHZGK4jfxBlSX02sFMOqLuBTIt4td3vKjKTWFHwIWbxa+sN+boDmJ7ygG/Oh8pnQG2xrqk9wdb9H2fQ0wxVcSwVU9GlwbPkxMc2tUuLbgCazXlvddVcd95pFn6F9f7xgWuTFhzFAYp8KrkE159S+mtcSicS49xwD8AxRyN0B0+4AIpZBboKUEb3FTK8iSF+0MVFMKrhUr0pjaDY2ESHLsc3nnHHPhtenSdeh/FnVB9IhuuZWkh8iB3EFTR/flbIdz2g4pKjioN3DiZhdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(2616005)(47076005)(6666004)(2906002)(426003)(83380400001)(186003)(336012)(316002)(70206006)(36860700001)(4326008)(19627235002)(41300700001)(54906003)(70586007)(6916009)(1076003)(478600001)(5660300002)(44832011)(26005)(8676002)(7696005)(8936002)(40480700001)(82740400003)(82310400005)(86362001)(81166007)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:12.7517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b01731-2465-4c78-2f75-08db519802dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Underflow observed when using a display with a large vblank region
and low refresh rate

[How]
Simplify calculation of vblank_nom

Increase value for VBlankNomDefaultUS to 800us

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 1d00eb9e73c6..554152371eb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -33,7 +33,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 668,
+	.VBlankNomDefaultUS = 800,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
@@ -286,7 +286,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
-	bool isFreesyncVideo = false;
+	const unsigned int max_allowed_vblank_nom = 1023;
 
 	dc_assert_fp_enabled();
 
@@ -300,16 +300,11 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		isFreesyncVideo = pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min;
-		isFreesyncVideo = isFreesyncVideo && pipe->stream->adjust.v_total_min > timing->v_total;
-
-		if (!isFreesyncVideo) {
-			pipes[pipe_cnt].pipe.dest.vblank_nom =
-				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
-		} else {
-			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
-			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
-		}
+		pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
-- 
2.40.0


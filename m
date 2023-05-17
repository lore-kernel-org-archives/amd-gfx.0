Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9581DC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442F210E3F9;
	Wed, 17 May 2023 11:39:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD3E10E3F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvWn9zPgrj6FnhvnUSsJTFa6NymbJdZci5PDsHCZTCdnTcyp7OPmnBgGu4aUPnui7Jnqb0Q7Cr+FVE36RQ5AcNHOtiBHFWfYUtCm+8xbCFAenUQ02CR5u97HyCzRRbUvGlxx1tGystmEJ/eQWFByjp+C8MnFB5kwzECMBkQDN3x1q4F8Bz6POvo3iz9EGr58Kj++oQZKiSkb4M93DuVJBYl+ukE4oKGB987Dw+ZtPmeyoRb7Wzge1+Ce7Ze4N1DTOP0R6cabQelMT5s76AuDmA6VT3SwwlYnmlZWrWS4+j6g8iFNOzgkgxBqCQNkFJWUDdbysPrrUzFGDIzs5HUQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK+wkUnMK10ly7FSkTCwIf85snp/G8ee1VroqCFOVjQ=;
 b=cKJNWbHqJKr0AdsiAVfCDPItgaPnQpXCthMW77MRn/JQQwWd1oe6Embo2FqDmK1VA41nwlOw513G4PPA71Byyt0ubrbcDniwfnQyCVzMWqQJ64oSeuvyPQefQcaCuoGSEcip61UeNmZ0OdJ4bb3SqMmoCcBBHDOX9pJdzgzTmgw0P4EA0uHGtjGp5RLFhu1FOHUiXxnY6wULeVHgGhgk/PhtbpUdI7HNkj2sfjBkqw41aJhEX54hwD7OhwytB7vJV5KsFhSfe8e7Ix4Z6A4HZ3nsShx/aeJHmyFu7xXN7yJ5SsyNbSBN9tKTTVWKq+Ie+m8yMDn6ZjXwtMQ6jOyo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK+wkUnMK10ly7FSkTCwIf85snp/G8ee1VroqCFOVjQ=;
 b=idgPpxVM75PmJ/yBAQW7tp/pvj5c+n9Qm5NF+phPUAkjA9Eiw1RH/E4Gm/y/wSNGcLMrGSaNpWNV26VWtxF8Mw5JsNkAPBML/OxLbphKfceFwQYrzP2h2VwEOQrs85Kc4hhAhx18NPyVCL+/3vwCRrXnBOVxveE2n66ICSL9nss=
Received: from MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::10)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 11:39:47 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::c6) by MW4P223CA0005.outlook.office365.com
 (2603:10b6:303:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:39:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:44 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:39:39 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/18] drm/amd/display: Revert vblank change that causes null
 pointer crash
Date: Wed, 17 May 2023 19:37:15 +0800
Message-ID: <20230517113723.1757259-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdca598-8a47-4a34-8c1f-08db56cb6a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOzcqE7fX07+2Kn6UlX/Qg/S/mGwHMy9LCh3QVUUA3R+MqAboK418S/CCK0KVopEu9pryQQ74+zt8IUtPM+e8JY/kZWLfue4pHTMyLy0KaBmAGiFxphhdUsWZvZnN6svYK2Hw8+jBDkrgxCv/38Uwf69eQLYJT85ZyaTHqrtf7AMWu67/tTRbuCWvdcCUOyn1kQc29qAsvVxg/F85vAlkoVh+711kyQQzHafWjYlexnnuxE1nEvnMhvvjPFgrBjgfzdr/f9aiEyGMqMdZpEO/hNmKgST9jraCJznImwzPplz5hXtIgK1HjxG1KZ4HHCbMw3nvYyVx7JbF2R/LTVjwdO66ZbYLJC2DBd7GcGPlJwEcSgMiLw8csUCCESOJaz6wv2L0ls1spURuKABd4OnC7JrAQk44YsQ8kJlvv/yVtozWdIbAi86yl0O4d4Ehlg+m9vN7kaHhREYo8JXt6C9jvvqxM5Z+4iLGVpmNZeBEiLZgveFbVU/DzLPRQvrGooIfRjoziVJdcqubY+vofevi3xfWdw7FdxuNQEk1iGVCU+YgrP/nVPbClBVX/XEtJS07AXdbUKPiiuoPM89W0ziqQiwAGqANNs9CuhMss3HeWMuBk6jprZiw03DGuGKMe1jwBuR2mWZk5ByH4mzlA5znV9ByyvxRzgvhjYf5hDmd36uQZx6nwRfEwwMhbsuitTjglV0q+9nwARqXLnmMru81lTLVWRH/qEGAV+RWUvD3k7SdgkwB0TbZJPRaRqAoLuNfLiHLdJF6dIsaZnAByhOkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(19627235002)(63350400001)(36860700001)(63370400001)(83380400001)(26005)(54906003)(8936002)(1076003)(186003)(47076005)(426003)(478600001)(2616005)(336012)(8676002)(5660300002)(316002)(40460700003)(81166007)(356005)(82310400005)(86362001)(41300700001)(40480700001)(82740400003)(36756003)(7696005)(6666004)(70206006)(70586007)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:39:45.8683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdca598-8a47-4a34-8c1f-08db56cb6a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052
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
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

Revert commit 43e5893f10ff606e60d1494c41acc59f54efedb0
drm/amd/display: Fix possible underflow for displays with large vblank
Because it cause some regression

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 554152371eb5..1d00eb9e73c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -33,7 +33,7 @@
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 800,
+	.VBlankNomDefaultUS = 668,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
 	.hostvm_enable = 1,
@@ -286,7 +286,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
-	const unsigned int max_allowed_vblank_nom = 1023;
+	bool isFreesyncVideo = false;
 
 	dc_assert_fp_enabled();
 
@@ -300,11 +300,16 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
-		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
-		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
-		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
-		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
+		isFreesyncVideo = pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min;
+		isFreesyncVideo = isFreesyncVideo && pipe->stream->adjust.v_total_min > timing->v_total;
+
+		if (!isFreesyncVideo) {
+			pipes[pipe_cnt].pipe.dest.vblank_nom =
+				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
+		} else {
+			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		}
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
-- 
2.25.1


Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9BEC433E8
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C17F206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XcTw9g4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C17F206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2191D6E994;
	Fri, 24 Jul 2020 21:06:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBF56E98C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOUHSXnxD6Foc09AtDsHHez1PoOfLK1Za6AlIO0fSjNO3Xwe84LVIUH2kfAX19hk88V/tKEbijtGegPERddNBsXaBeDnd+ceWzBqz5oSf9xoWsIgGpysMBjC+kf90JlDt/rI2JKG8if3vpbib/Qj6WdDH31iEeJ7mAJJYFwTrAgtF5rxZvlpAckYwQT+8Hucdq0LACAgS4CwKe8pA6lRd1vOkkVVA6Ayo4zQz2gvHHXis97m21FieHV53GMayzGlcEKvrWMXyfx31aV9FwnGkbU+D/Vzih7UmRCZ9yp0k5c0fDjWdXFYhaoeXbGgnoZZBxetwbwa8v+JlznV+L8ecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNz6RI5nsqev6xx8GFQLcVlAJHkawRgWMDP3eqaXpXY=;
 b=X3w2RQgFadpQ2f8ZQ7IGpJ0YB27OtU6JUm6Kn+Az+Md0sz2PmHhmNj6UDoC93fHLm2AAWXKRJBKRVu4estzSU3pU7X95WRSr2U8ztVxdis9u8Q/d8NWJerGoijandkzEnyYFl50fEDWw2yEJjDjMMvwWoJXU+j5wEe4zizK9IlMWfpxVBuTZ0AuEwrEXQDnpHWGLd5/RP8gZ0tTpplFuUukvC6yioPTQAVj9chjKlA6R9OUNvs8jKJpGpm7sTyo8QxA6To4Q8NvCw8ix7rY/1PwDW75WUO23U0G8AcQDCrBqqAH9U285TCSMnoInfwYmy9ZrAXw/eOs48ZOFCeTo0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNz6RI5nsqev6xx8GFQLcVlAJHkawRgWMDP3eqaXpXY=;
 b=XcTw9g4ghPPJmu9o9v3VRkfVpzdG0aiOYWTVBfmyom9u3OfvVsFLdSU1tJPm5FGwpDONszsPA0mmN2+65ReXKGHJcfBoj89qHVlkkFnrTCIsOaSp4UzEEJgJaSgpNvZmGsqSotHzyGxZRf7xPV3SFrY10UatzfJeCUacQ2Eu0XM=
Received: from CO1PR15CA0077.namprd15.prod.outlook.com (2603:10b6:101:20::21)
 by MWHPR12MB1901.namprd12.prod.outlook.com (2603:10b6:300:113::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 24 Jul
 2020 21:06:43 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::47) by CO1PR15CA0077.outlook.office365.com
 (2603:10b6:101:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 21:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:06:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:06:42 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:06:41 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:06:36 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/15] drm/amd/display: Clean up global sync param retrieval
Date: Fri, 24 Jul 2020 17:06:04 -0400
Message-ID: <20200724210618.2709738-2-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724210618.2709738-1-eryk.brol@amd.com>
References: <20200724210618.2709738-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ad387c9-cf56-40c9-89bb-08d8301577bc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1901:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19019E9D931B1063C4F532C7E5770@MWHPR12MB1901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoy/+EP4TL6ySmdwRB81tKxGCNTX1OG/KrzEZGthuZlIq9PzBspB5cw1iQIJrkBLHSQHOS8zynN6rXZoWceL8gTcVwVYESA1r/2Cu+/Ax69AREKTwo/pRmd9mHJWFHfBwtfu7OhAKOrviyR6el2KLBxHn8iE/bMk+cggHm4LnBmcAAI+OsF0sHOAggWy0fXkAfh3KHvM9hs5tPhhFWInIXVh+GauCbYpyRRGlXi95Q3+axmVORKS5XZJY9nNXi5/gbWtC5PhNqoFd++lxfVj+idOZrOd2MPwa06PM0XDGUenzQ2hafQL8HcS5htvPfsOUUMKeTyMnaBplG9gNV2fdOsjmBIsJFpV/7PGGB4yBxrzNWqjkXOSyM3xJa52KrWUC75s9fWvWtvuzO6D3UMj7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966005)(1076003)(54906003)(316002)(186003)(44832011)(26005)(36756003)(336012)(356005)(478600001)(2906002)(8936002)(86362001)(2616005)(47076004)(6916009)(70586007)(70206006)(83380400001)(82310400002)(6666004)(82740400003)(5660300002)(81166007)(426003)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:06:43.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad387c9-cf56-40c9-89bb-08d8301577bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1901
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why]
This change replaces older looping code in favor of these functions.

[How]
There are built in functions for extracting global sync params
during mode validation now.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 49 ++-----------------
 .../drm/amd/display/dc/dml/display_mode_vba.c | 14 +-----
 .../drm/amd/display/dc/dml/display_mode_vba.h |  7 +--
 3 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 968a89bbcf24..2a5e7175926a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3069,8 +3069,7 @@ void dcn20_calculate_dlg_params(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, j, pipe_idx, pipe_idx_unsplit;
-	bool visited[MAX_PIPES] = { 0 };
+	int i, pipe_idx;
 
 	/* Writeback MCIF_WB arbitration parameters */
 	dc->res_pool->funcs->set_mcif_arb_params(dc, context, pipes, pipe_cnt);
@@ -3089,55 +3088,17 @@ void dcn20_calculate_dlg_params(
 	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
 		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
 
-	/*
-	 * An artifact of dml pipe split/odm is that pipes get merged back together for
-	 * calculation. Therefore we need to only extract for first pipe in ascending index order
-	 * and copy into the other split half.
-	 */
-	for (i = 0, pipe_idx = 0, pipe_idx_unsplit = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		if (!visited[pipe_idx]) {
-			display_pipe_source_params_st *src = &pipes[pipe_idx].pipe.src;
-			display_pipe_dest_params_st *dst = &pipes[pipe_idx].pipe.dest;
-
-			dst->vstartup_start = context->bw_ctx.dml.vba.VStartup[pipe_idx_unsplit];
-			dst->vupdate_offset = context->bw_ctx.dml.vba.VUpdateOffsetPix[pipe_idx_unsplit];
-			dst->vupdate_width = context->bw_ctx.dml.vba.VUpdateWidthPix[pipe_idx_unsplit];
-			dst->vready_offset = context->bw_ctx.dml.vba.VReadyOffsetPix[pipe_idx_unsplit];
-			/*
-			 * j iterates inside pipes array, unlike i which iterates inside
-			 * pipe_ctx array
-			 */
-			if (src->is_hsplit)
-				for (j = pipe_idx + 1; j < pipe_cnt; j++) {
-					display_pipe_source_params_st *src_j = &pipes[j].pipe.src;
-					display_pipe_dest_params_st *dst_j = &pipes[j].pipe.dest;
-
-					if (src_j->is_hsplit && !visited[j]
-							&& src->hsplit_grp == src_j->hsplit_grp) {
-						dst_j->vstartup_start = context->bw_ctx.dml.vba.VStartup[pipe_idx_unsplit];
-						dst_j->vupdate_offset = context->bw_ctx.dml.vba.VUpdateOffsetPix[pipe_idx_unsplit];
-						dst_j->vupdate_width = context->bw_ctx.dml.vba.VUpdateWidthPix[pipe_idx_unsplit];
-						dst_j->vready_offset = context->bw_ctx.dml.vba.VReadyOffsetPix[pipe_idx_unsplit];
-						visited[j] = true;
-					}
-				}
-			visited[pipe_idx] = true;
-			pipe_idx_unsplit++;
-		}
-		pipe_idx++;
-	}
-
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+		pipes[pipe_idx].pipe.dest.vready_offset = get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
 			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
 						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
-		ASSERT(visited[pipe_idx]);
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
 		pipe_idx++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 7916a7ea9336..b0064087b9bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -154,23 +154,11 @@ dml_get_pipe_attr_func(refcyc_per_meta_chunk_vblank_c_in_us, mode_lib->vba.TimeP
 dml_get_pipe_attr_func(refcyc_per_meta_chunk_flip_l_in_us, mode_lib->vba.TimePerMetaChunkFlip);
 dml_get_pipe_attr_func(refcyc_per_meta_chunk_flip_c_in_us, mode_lib->vba.TimePerChromaMetaChunkFlip);
 
+dml_get_pipe_attr_func(vstartup, mode_lib->vba.VStartup);
 dml_get_pipe_attr_func(vupdate_offset, mode_lib->vba.VUpdateOffsetPix);
 dml_get_pipe_attr_func(vupdate_width, mode_lib->vba.VUpdateWidthPix);
 dml_get_pipe_attr_func(vready_offset, mode_lib->vba.VReadyOffsetPix);
 
-unsigned int get_vstartup_calculated(
-		struct display_mode_lib *mode_lib,
-		const display_e2e_pipe_params_st *pipes,
-		unsigned int num_pipes,
-		unsigned int which_pipe)
-{
-	unsigned int which_plane;
-
-	recalculate_params(mode_lib, pipes, num_pipes);
-	which_plane = mode_lib->vba.pipe_plane[which_pipe];
-	return mode_lib->vba.VStartup[which_plane];
-}
-
 double get_total_immediate_flip_bytes(
 		struct display_mode_lib *mode_lib,
 		const display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 756d8eb1221c..21e5111ea7a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -98,16 +98,11 @@ dml_get_pipe_attr_decl(refcyc_per_meta_chunk_vblank_c_in_us);
 dml_get_pipe_attr_decl(refcyc_per_meta_chunk_flip_l_in_us);
 dml_get_pipe_attr_decl(refcyc_per_meta_chunk_flip_c_in_us);
 
+dml_get_pipe_attr_decl(vstartup);
 dml_get_pipe_attr_decl(vupdate_offset);
 dml_get_pipe_attr_decl(vupdate_width);
 dml_get_pipe_attr_decl(vready_offset);
 
-unsigned int get_vstartup_calculated(
-		struct display_mode_lib *mode_lib,
-		const display_e2e_pipe_params_st *pipes,
-		unsigned int num_pipes,
-		unsigned int which_pipe);
-
 double get_total_immediate_flip_bytes(
 		struct display_mode_lib *mode_lib,
 		const display_e2e_pipe_params_st *pipes,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

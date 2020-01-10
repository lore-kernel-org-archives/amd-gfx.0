Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421CC33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A22D2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qGT+QOUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A22D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B0F6EA2C;
	Fri, 10 Jan 2020 14:47:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E821F6EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxzYzWgn0WcwnZUD2T5r/jyixj5VzrEmXgCinwLTS4ilye/Jtz/8dL1XjHR45sqIuKt0NiWl5EnJ15nBR3LR7wPtRswO9YBRPGgPozgZp9LcB33hi7OgSdCTM0B6VQkkmNylnq4s23QwkPWEIU2JzYjrd7WRyDiqD7d+IkogGqI6qsW3EsOepDj86Z5pLX90TyuLNA3g4pb4p2ccqq6us8GwopjFV6RzzXDw0GqFI+frTGbdgruDI0zXjM3F7WUThwI3iBss0kHTdKtWZxAVkMbfHDfXhTgPITB3LYkPrYo6I3ynsbcj7lL/Xk3E0orIa6cELhNEFKmx/UgEeXW0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULgQBFy8GB95oKftgboFA1isdgpoYBYzT6Ly99VbrA=;
 b=Az1w+q+M3WzAx1NvjnT/H6Xk6OaEgjM55TQ3a9ghGsu9r7B5YFK7LyUXTSqwKvZkCVhy9Ix7sqAmeZrWTNIk8INu3h1ER9fgNl59D82yXkyHY4xW4+S+FfsbElU8xc6I6JmLhGkrIpLxgmcvfnx0GCtiydtgUlvL5TnGRbzK0qKeiyQxlfuFqKu8B3Maj4sb0HtUyU2tUCyKNF9YYC78G01RtzZQ73Tnw9k9EiHgJ/1yNZYAa+GlcRlc60AVgayxKM+AQ2RG8z1gU1OKijzOK2rYqxe6oVaJSaGnYGj++2zwzKr08SH/u7Wixt8VTm5XAHbFLJoEw5w22GnzCTRoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULgQBFy8GB95oKftgboFA1isdgpoYBYzT6Ly99VbrA=;
 b=qGT+QOUe4zCits5o8urlckHCmX+VrpKQR0NStJ5ofJ952KUTGbC1kOLdv6+RaKeU50pNj8JKzb17YFnnljC20r4yAnjHUNh+Cvuv5AfAnP9yPHHLSlMCLpCExxW+CPLE/51id4vMoe4HYAY/gARfowJSfi2aG1A4G6Ebbn/ICLo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:25 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/43] drm/amd/display: Fix 300Hz Freesync bug
Date: Fri, 10 Jan 2020 09:46:17 -0500
Message-Id: <20200110144655.55845-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:24 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7c5b223-ef22-45c5-7bb5-08d795dc0196
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25247AF2D39DD7261A91C96A98380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g47vTKzye5bD4QZq5Ix3pjhbxLPIKknikQR0efq83C9j6CeJLv7xyy7axQXanGXT/v4IFZsLXuFhFFfqR7+oLJe7j+872oEAEWzYgQv51KdGrbV08NsmjwuYny27y9bRDaafKpRdVBkdopUx4aULIwlLLEw6QuVgpdK+f/F7lJYwa5da7bAmMqskIqqCgYgePobkQKSUibqMDhg/9YneYRMtvOIMgY2LqFEv8icMQKeFmtuOMwznsTVVYdiPrbOe2KK2k42WFbghhydndi434R2akyPSNlpMMpN8GDNdiIXAw4aIfXQ0WC5CoqUOQjXtf3PugCx666cIc/R/aPVlE1gtq9RA3flaZuvBCqrQ5Nj5orjJk+Wse206mqBZ+s0xLY0NMUzBVlQmywb2QtWeT8d6cYMOAI8Ygts+ksUFSFbryzs4bPfR7q2gx0A0mJwT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c5b223-ef22-45c5-7bb5-08d795dc0196
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:25.0186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCRsWEyA6A4WrsQNXwyjAjt25X1CSowL0Y8lcMk5h/Z8FQnkPDdm4VtJudZL5qW+qJhFQeLyrrJ0XipEp6tdfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Martin Leung <Martin.Leung@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Needed to reprogram vblank_start in dml properly in order to get the
correct dlg params to program VTG.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                | 1 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 4 +++-
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3d89904003f0..46f2b54c3526 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -287,7 +287,6 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->stream == stream && pipe->stream_res.tg) {
-			pipe->stream->adjust = *adjust;
 			dc->hwss.set_drr(&pipe,
 					1,
 					adjust->v_total_min,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2dafa20d769d..b715ecc1b5e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1883,12 +1883,14 @@ int dcn20_populate_dml_pipes_from_context(
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing = &res_ctx->pipe_ctx[i].stream->timing;
 		unsigned int v_total;
+		unsigned int front_porch;
 		int output_bpc;
 
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
 
 		v_total = timing->v_total;
+		front_porch = timing->v_front_porch;
 		/* todo:
 		pipes[pipe_cnt].pipe.src.dynamic_metadata_enable = 0;
 		pipes[pipe_cnt].pipe.src.dcc = 0;
@@ -1915,7 +1917,7 @@ int dcn20_populate_dml_pipes_from_context(
 				- timing->h_addressable
 				- timing->h_border_left
 				- timing->h_border_right;
-		pipes[pipe_cnt].pipe.dest.vblank_start = v_total - timing->v_front_porch;
+		pipes[pipe_cnt].pipe.dest.vblank_start = v_total - front_porch;
 		pipes[pipe_cnt].pipe.dest.vblank_end = pipes[pipe_cnt].pipe.dest.vblank_start
 				- timing->v_addressable
 				- timing->v_border_top
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 832bc9b3b7d8..6e5ecefe7d9d 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -812,11 +812,12 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 			2 * in_out_vrr->min_refresh_in_uhz)
 		in_out_vrr->btr.btr_enabled = false;
 
-	in_out_vrr->fixed.fixed_active = false;
 	in_out_vrr->btr.btr_active = false;
 	in_out_vrr->btr.inserted_duration_in_us = 0;
 	in_out_vrr->btr.frames_to_insert = 0;
 	in_out_vrr->btr.frame_counter = 0;
+	in_out_vrr->fixed.fixed_active = false;
+	in_out_vrr->fixed.target_refresh_in_uhz = 0;
 
 	in_out_vrr->btr.mid_point_in_us =
 				(in_out_vrr->min_duration_in_us +
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

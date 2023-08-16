Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA6BC001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1B310E2D9;
	Wed, 16 Aug 2023 06:08:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC0F10E2D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfkLFAl8QrANTZ39cHD0TK7lOdTFvOf2UJDGhcqN2b7A6ghLjDnqfZ6Yv7GtDSpJRMcVRvqyhyYNpbW2iMGXiCGgB/ebyyOPK+mSnAQs+E9SoPJd8fHiodn6bKyv6JnQ53NNCOfvtcCb6nInEbyfQcV6bS1u079Gm3lH4lktwpVV4/SrXByBY9osTQ9aOIXpmrsVsO/BSivmi5F/mPhEFaRpr9i9/yoJT6DflxYsHxWYEbjfacvwnt4G7vJfXV6B4+BBUlR+KBU/SrOqyHlhO4m8BSFHKmnRZljXNzSdqGoMvWkLf71tPHD1c4lKGD/3zGKgNHCDIFpTlDQBQbB97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6+sl7ZNlVEUpZi/nbGrPy4T5/pTulvjwFhoozAXd44=;
 b=QVaqD4rQ/HXoe9wTKFi+Qy9VDtRvIxZJgnSZAWjFkkDXoSW6/Cf3jaaRvtivX6Z1tnIMyJpKSJTZA7zODGrivEvoYCibXqdK8RPTDdj2QlLUVyy6s+4x+mMwCZwxRwoZV9w9eDajqk6UXQU8A0TO4tN3MawerESY2oqvKK0yaXhFLpAuSIaZzJXEEvD954hkTH7dvbklsYRRXdn1y6wH4j98xEo2VUfxku3wQQh2jy04f6MQRZ9CT2S+0gMZbxBzy5RdU5qPVKZK7qauCrSeyrX0UwQJWYO64SQoyXD8joXRoeRYM9crib8aws2gs9ypDaIxkZ8wrvevUq8y73+zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6+sl7ZNlVEUpZi/nbGrPy4T5/pTulvjwFhoozAXd44=;
 b=gpgN+Jxz+IFF/3KW9e1jshPRyP3El57jY1/+7thsd8ek3IC72pT9mVzAhIycX32MvKa6sHRQ+32BXX4A3QjbgDPGwoRwoCbzAjh7tR54RFosr/mXlqlZUwSQ2x+CrHBBCYO5hgG9kmtv0FPwgMDfG9q9eG+/yLzOe3Z+PzCZYzo=
Received: from SJ0PR05CA0111.namprd05.prod.outlook.com (2603:10b6:a03:334::26)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Wed, 16 Aug
 2023 06:08:16 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::ad) by SJ0PR05CA0111.outlook.office365.com
 (2603:10b6:a03:334::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:08:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 23:08:15 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:10 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Roll back unit correction
Date: Wed, 16 Aug 2023 14:06:49 +0800
Message-ID: <20230816060658.2141009-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: addb130c-0a33-4a0d-42f8-08db9e1f2ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QGxiOyqIlkeO++B1qTB4vW3JkmmGpErPOQDjp9r39zuYlkzBlY9/4PqWRwMJ52wjmARIXpGOCGJeNejgiHOzwZVbgVauAalxzc9t+Y6BKKq/kf1aHv/on6bpMbsW78B1WtrEVJ1Bh8kDX2ApU68LSz4/Ln+Typxcmyruls1B3FQfwADNxB6AY1J7ZGopphpYPkGPkLm0G71pURCIMK7P5N2AOZwGRXJpHLpuq8f6GWBzmkJPJ1HDXn/7srlgBPCxHsnsID6XNTjopSvFwHF/h+bUTZO03szioe27au5QByLWPd803PEkLf8IDq2fcwi+XNi5m3fzAkYsWlszKcMH++xJv7tBYVFGISjC8otaWBV55v1Otrr7QtgoGlLQi85eiCj7wPGKGrbUWm1M1Q4aX/6RDAMDg7kD7w3EY1aKl9ugviVaOe7sVXuJqTFxabePgCOgfLr0p2LyW4zm/F2U5vH1BhXKQsAznMoNNGRbaN+a8MqaEovDNsYiFgWXQF7kVWx6zGfGlwWOcJJoY5xKOMyUL4K7iZi0QUMoG+Js1Dke8PyOVhtE3L4wpmeVpSDXjAU9FWEdwabBHnsWz8R6ubWv9e/tHQzASoSlANB2NNG2+8ftHPOLYsZxKnYQDFBOTjhrsym6awes9Dw7YL5rytZJ8OOkDOmnuXMmYPZDW9ffm5PtbxIRRJYjSOzc02X9BELYo7NKsmEzkvaOqwv+mI0lqGiB1zEkoFQuAd5alb6xq50SMWik/s2fJymtBI48p4qQh28TBvoYwnX5tUSkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:16.4833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: addb130c-0a33-4a0d-42f8-08db9e1f2ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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
Cc: stylon.wang@amd.com, Reza Amini <reza.amini@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why]
This Unit correction exposes a Replay corruption.

[how]
This reverts commit:
commit 7d3cedf18068 ("drm/amd/display: Correct unit conversion for vstartup")

Roll back unit conversion until Replay can fix their corruption.

Fixes: 7d3cedf18068 ("drm/amd/display: Correct unit conversion for vstartup")
Reviewed-by: Reza Amini <reza.amini@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
---
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 25 +------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 07adb614366e..ed8ddb75b333 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -31,7 +31,6 @@
 #include "dml/dcn20/dcn20_fpu.h"
 #include "dml/dcn31/dcn31_fpu.h"
 #include "dml/display_mode_vba.h"
-#include "dml/dml_inline_defs.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
 	.VBlankNomDefaultUS = 668,
@@ -274,25 +273,6 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
-/*
- * micro_sec_to_vert_lines () - converts time to number of vertical lines for a given timing
- *
- * @param: num_us: number of microseconds
- * @return: number of vertical lines. If exact number of vertical lines is not found then
- *          it will round up to next number of lines to guarantee num_us
- */
-static unsigned int micro_sec_to_vert_lines(unsigned int num_us, struct dc_crtc_timing *timing)
-{
-	unsigned int num_lines = 0;
-	unsigned int lines_time_in_ns = 1000.0 *
-			(((float)timing->h_total * 1000.0) /
-			 ((float)timing->pix_clk_100hz / 10.0));
-
-	num_lines = dml_ceil(1000.0 * num_us / lines_time_in_ns, 1.0);
-
-	return num_lines;
-}
-
 int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *context,
 					       display_e2e_pipe_params_st *pipes,
 					       bool fast_validate)
@@ -309,22 +289,19 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
-		unsigned int num_lines = 0;
 
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		num_lines = micro_sec_to_vert_lines(dcn3_14_ip.VBlankNomDefaultUS, timing);
-
 		if (pipe->stream->adjust.v_total_min != 0)
 			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
 		else
 			pipes[pipe_cnt].pipe.dest.vtotal = timing->v_total;
 
 		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
-		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, num_lines);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, dcn3_14_ip.VBlankNomDefaultUS);
 		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
 		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
 
-- 
2.37.3


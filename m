Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0FC55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFEE22202
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yNgVzo3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFEE22202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229D36EC5E;
	Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795C76EC56
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfwE8hukdExOpNRlDvYaOSV8aEfngmE+XYzlQXphCfOn/JVACXA/ClkUYDAIE86ldbpJxbzUWcfSBCD8Ho2z9hAUvoP4ftmcq0DX0SoDSFVbwDwGksNQ6mpWgy4NUzzbA4NmQ8fRmyDsoofZjMpJX7+9A/GEq4gMR/E0N/tpG3oOayt4Bvc0W7FbmBZfWZ1EhEflh//czUXiG2zOGOk8yYZ/f6i5biDTC+IyWKDxnXIG1h3HZh/AxHvlttX2/TiddwJDAvd4iWcLHydaFrN4Y89HN/7ZS9pRXSQi3wSCA6d+LknD3J0yamWS7vz2RbBY65SHsmuYgh65f1guNkjg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0xj6YgVFzyv7HLHImI4eGBoLW85PnjX1F9oHVn+GlY=;
 b=TsNJZ47/FJ0kqMaeTmdMFRFkj5F4MwkKyMa75k4bO0uGPbL2B4efC3UkbXwVfl0K2qkTzHCC/ZOzOD8lU3ThCY5EpkztXUO6DmMg8Sk4Hj3esP+wVk+AECqwrhJ8rYoKBtYO82xsKow+sRNsayH5D+mKFqyAIekUDOEA7CKuvqHwU0fbAJ6EgNjQfKVHyuH6f+n1KZfdgfK5XdnwSaQ+3rghytwOmcxcVhnxtevBXvnRieRgLVBtA0HsJhhP2htsFYX5bW8gttMq84Nte8UO49CohaxXGVadh105ZaxEetUZsKrwsHUeZCztZpcsh4zv+YW+I7XziDtQULtD5HbM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0xj6YgVFzyv7HLHImI4eGBoLW85PnjX1F9oHVn+GlY=;
 b=yNgVzo3JKk03UocltQ4iBsKj8sG5iK9r3Wn3vO3pp2S9sVL9/rbBXtLD98DJn5UoyKhg08Y9g0meYUrryvwyeP+hEbQw8Kvvjsv4BH4+O/f4cxoymEzUo4d4c+81BjhCuHXGbrT1Kis/KfgAmUzfSnUgxVLkLtUAa5qwgcgLTIA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:03 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:03 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/25] drm/amd/display: Blank HUBP during pixel data blank for
 DCN30 v2
Date: Tue, 27 Oct 2020 16:52:25 -0400
Message-Id: <20201027205234.8239-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f25aebf-fb2f-4f4d-8ba5-08d87aba475c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35952E84BC36510D6C8C2666FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9VZPLWo3O392kizPxLqEcITsFV0xju6stwRJlCpmdfBLybXTrQTjea786czfyQUh40IsUru3FgdcZsoJEMKVqqiadA7M38iEs4WEX4nmvFhkwmYzi4byYH0grv9jXA6+vaknkG96c2x+h6Hfrr/kxpmFf+1vMOjwWUcth2Q15lou5M42A/HDEzWUXDKZAdFxqL8Bq+DDc49Zux6YJH+yj40irlfS0IfNJJqthWzShWBF9xkMXK9nejilliCb5Ehl0EjCPJJ5or/dJhRGVwRHCEB6j9OhRlkJXva7e9+dXu2vxucKHduieaYd8kY9rT/KIQYTx6EBQIhJYt61QH2Bx/WnERz7FLPb3Zo61V/g8Et6NgjmGPEWLWn64j7c3NZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(30864003)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3NgVkVrwNUlUVPPCv73waOBPOFxD/hh46rO4WuEFTWgu4L1vCYUAnNZAQPqIgwnLLU/3Z/Jo/mhZpXhcO7/DbgXZf1ApmcJeg/TAC1awJJWsKg7VJGIiaZB7ro+uG9cgk4cxMMx5K0f1gakOPExjTSxbhC/QPgtnHLmEMri152wz7coF4viXor3eyyomRfA3oMDqkuzz9x+RghPGj5/jYYuGGvRrgy/2k+bc6gbEBBVHa7CxFFc+esuGwIiVNLyN/WH8HTH63gw0mCGIeittcteqcspOVBRRgMCZ9i55xiK2x8vqesjiR1dQ+iQgXcjD9ayrkPVvNVSYQsrTxaXJKdaIZROoD6L5TglQYrPkCrlvlsDFvHi3WWBGOD9X5kG/VPq9dUeljpa8kKTLNrXE2cKZmuWxCwlHG0iEZoTTEee3tQsWmb10i6SiywBBp2qQg9s+nR8vka62oEGxDbk2YMwjntgtlSvACydidwAvS4ADReS15syCVyVWkTCxdYx1p+/0uufzIPnDOBvLVfGhMBUm8gpG9TAf4oRIIvhwdGgWBZKSIiIiEFw7GyEMV8bewjptpYWIQ6zqhj9CapsYS9Ys4h7ry0H9pZzH0Ewp4f61QrTjIhBwdmJkhtMi+jnCBiCgKlf9mwyqECxu2GTWjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f25aebf-fb2f-4f4d-8ba5-08d87aba475c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:55.5387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6G4zc0lY4CqtqAvSSiTeRnyrsKgmFSJcHc62gK3I0JhrbB/v3XFUWBPYMNGs4VF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Prior commit "Blank HUBP during pixel data blank for DCN30"
missed the call to set_disp_pattern_generator from
set_crtc_test_pattern, which re-exposed the issue for which
we initially blocked active-only p-state switching.

[How]
 - remove dcn30_blank_pixel_data, set dcn30 back to dcn20 version
 - new hwss funciton set_disp_pattern_generator
 - dcn20 version just calls opp_set_disp_pattern_generator
 - dcn30 version implements the HUBP blank

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 62 ++++++------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 20 +++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  9 ++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 96 +++++--------------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  8 ++
 9 files changed, 100 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2114c280895a..9d1c5e1d06c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3848,7 +3848,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
 		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
 				controller_test_pattern, color_depth);
-		else if (opp->funcs->opp_set_disp_pattern_generator) {
+		else if (link->dc->hwss.set_disp_pattern_generator) {
 			struct pipe_ctx *odm_pipe;
 			enum controller_dp_color_space controller_color_space;
 			int opp_cnt = 1;
@@ -3878,26 +3878,29 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			dpg_width = width / opp_cnt;
 			offset = dpg_width;
 
-			opp->funcs->opp_set_disp_pattern_generator(opp,
-				controller_test_pattern,
-				controller_color_space,
-				color_depth,
-				NULL,
-				dpg_width,
-				height,
-				0);
-
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
-				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
-				odm_opp->funcs->opp_set_disp_pattern_generator(odm_opp,
+			link->dc->hwss.set_disp_pattern_generator(link->dc,
+					pipe_ctx,
 					controller_test_pattern,
 					controller_color_space,
 					color_depth,
 					NULL,
 					dpg_width,
 					height,
-					offset);
+					0);
+
+			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
+
+				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
+				link->dc->hwss.set_disp_pattern_generator(link->dc,
+						odm_pipe,
+						controller_test_pattern,
+						controller_color_space,
+						color_depth,
+						NULL,
+						dpg_width,
+						height,
+						offset);
 				offset += offset;
 			}
 		}
@@ -3913,7 +3916,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
 				CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 				color_depth);
-		else if (opp->funcs->opp_set_disp_pattern_generator) {
+		else if (link->dc->hwss.set_disp_pattern_generator) {
 			struct pipe_ctx *odm_pipe;
 			int opp_cnt = 1;
 			int dpg_width = width;
@@ -3926,7 +3929,18 @@ static void set_crtc_test_pattern(struct dc_link *link,
 				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
 
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
-				odm_opp->funcs->opp_set_disp_pattern_generator(odm_opp,
+				link->dc->hwss.set_disp_pattern_generator(link->dc,
+						odm_pipe,
+						CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
+						CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+						color_depth,
+						NULL,
+						dpg_width,
+						height,
+						0);
+			}
+			link->dc->hwss.set_disp_pattern_generator(link->dc,
+					pipe_ctx,
 					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 					CONTROLLER_DP_COLOR_SPACE_UDEFINED,
 					color_depth,
@@ -3934,15 +3948,6 @@ static void set_crtc_test_pattern(struct dc_link *link,
 					dpg_width,
 					height,
 					0);
-			}
-			opp->funcs->opp_set_disp_pattern_generator(opp,
-				CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
-				CONTROLLER_DP_COLOR_SPACE_UDEFINED,
-				color_depth,
-				NULL,
-				dpg_width,
-				height,
-				0);
 		}
 	}
 	break;
@@ -3977,10 +3982,7 @@ bool dc_link_dp_set_test_pattern(
 		}
 	}
 
-	/* Reset CRTC Test Pattern if it is currently running and request
-	 * is VideoMode Reset DP Phy Test Pattern if it is currently running
-	 * and request is VideoMode
-	 */
+	/* Reset CRTC Test Pattern if it is currently running and request is VideoMode */
 	if (link->test_pattern_enabled && test_pattern ==
 			DP_TEST_PATTERN_VIDEO_MODE) {
 		/* Set CRTC Test Pattern */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a195dfb718dd..62788ad28230 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1030,8 +1030,8 @@ void dcn20_blank_pixel_data(
 		test_pattern = CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
 	}
 
-	stream_res->opp->funcs->opp_set_disp_pattern_generator(
-			stream_res->opp,
+	dc->hwss.set_disp_pattern_generator(dc,
+			pipe_ctx,
 			test_pattern,
 			test_pattern_color_space,
 			stream->timing.display_color_depth,
@@ -1041,8 +1041,8 @@ void dcn20_blank_pixel_data(
 			0);
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		odm_pipe->stream_res.opp->funcs->opp_set_disp_pattern_generator(
-				odm_pipe->stream_res.opp,
+		dc->hwss.set_disp_pattern_generator(dc,
+				odm_pipe,
 				dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE && blank ?
 						CONTROLLER_DP_TEST_PATTERN_COLORRAMP : test_pattern,
 				test_pattern_color_space,
@@ -2569,3 +2569,15 @@ bool dcn20_optimize_timing_for_fsft(struct dc *dc,
 	return true;
 }
 #endif
+
+void dcn20_set_disp_pattern_generator(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		enum controller_dp_test_pattern test_pattern,
+		enum controller_dp_color_space color_space,
+		enum dc_color_depth color_depth,
+		const struct tg_color *solid_color,
+		int width, int height, int offset)
+{
+	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
+			color_space, color_depth, solid_color, width, height, offset);
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 83220e34c1a9..c69f766a40ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -137,5 +137,14 @@ bool dcn20_optimize_timing_for_fsft(struct dc *dc,
 		struct dc_crtc_timing *timing,
 		unsigned int max_input_rate_in_khz);
 #endif
+
+void dcn20_set_disp_pattern_generator(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		enum controller_dp_test_pattern test_pattern,
+		enum controller_dp_color_space color_space,
+		enum dc_color_depth color_depth,
+		const struct tg_color *solid_color,
+		int width, int height, int offset);
+
 #endif /* __DC_HWSS_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index f4bc2a44f806..de9dcbeea150 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -93,6 +93,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 #ifndef TRIM_FSFT
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
+	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 3e3eca1778cb..074e2713257f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
 	.is_abm_supported = dcn21_is_abm_supported,
+	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 53b892f16da4..6b6e92e261ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -801,85 +801,37 @@ void dcn30_hardware_release(struct dc *dc)
 				dc->res_pool->hubbub, true, true);
 }
 
-void dcn30_blank_pixel_data(struct dc *dc, struct pipe_ctx *pipe_ctx, bool blank)
+void dcn30_set_disp_pattern_generator(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		enum controller_dp_test_pattern test_pattern,
+		enum controller_dp_color_space color_space,
+		enum dc_color_depth color_depth,
+		const struct tg_color *solid_color,
+		int width, int height, int offset)
 {
-	struct tg_color black_color = {0};
 	struct stream_resource *stream_res = &pipe_ctx->stream_res;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	enum dc_color_space color_space = stream->output_color_space;
-	enum controller_dp_test_pattern test_pattern = CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR;
-	enum controller_dp_color_space test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
-	struct pipe_ctx *odm_pipe;
 	struct pipe_ctx *mpcc_pipe;
-	int odm_cnt = 1;
 
-	int width = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
-	int height = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
+	if (test_pattern != CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
+		/* turning on DPG */
+		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
+				color_depth, solid_color, width, height, 0);
 
-	if (stream->link->test_pattern_enabled)
-		return;
-
-	/* get opp dpg blank color */
-	color_space_to_black_color(dc, color_space, &black_color);
-
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		odm_cnt++;
-
-	width = width / odm_cnt;
-
-	if (blank) {
-		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+		/* wait for the next frame when enabling DPG */
+		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg))
+			dc->hwseq->funcs.wait_for_blank_complete(stream_res->opp);
 
-		if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE) {
-			test_pattern = CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
-			test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_RGB;
-		}
+		/* Blank HUBP to allow p-state during blank on all timings */
+		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
+		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
 	} else {
-		test_pattern = CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
-	}
+		/* turning off DPG */
+		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
+		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
 
-	stream_res->opp->funcs->opp_set_disp_pattern_generator(
-			stream_res->opp,
-			test_pattern,
-			test_pattern_color_space,
-			stream->timing.display_color_depth,
-			&black_color,
-			width,
-			height,
-			0);
-
-	/* wait for the next frame when enabling DPG */
-	if (blank && stream_res->tg->funcs->is_tg_enabled(stream_res->tg))
-		dc->hwseq->funcs.wait_for_blank_complete(pipe_ctx->stream_res.opp);
-
-	/* Blank HUBP to allow p-state during blank on all timings */
-	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, blank);
-	for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-		mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, blank);
-
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		odm_pipe->stream_res.opp->funcs->opp_set_disp_pattern_generator(
-				odm_pipe->stream_res.opp,
-				dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE && blank ?
-						CONTROLLER_DP_TEST_PATTERN_COLORRAMP : test_pattern,
-				test_pattern_color_space,
-				stream->timing.display_color_depth,
-				&black_color,
-				width,
-				height,
-				0);
-
-		if (blank && stream_res->tg->funcs->is_tg_enabled(stream_res->tg))
-			dc->hwseq->funcs.wait_for_blank_complete(pipe_ctx->stream_res.opp);
-
-		odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, blank);
-		for (mpcc_pipe = odm_pipe->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, blank);
+		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
+				color_depth, solid_color, width, height, 0);
 	}
-
-	if (!blank)
-		if (stream_res->abm) {
-			dc->hwss.set_pipe(pipe_ctx);
-			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
-		}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 7d9db7cdd2f7..7d32c43aafe0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -69,6 +69,12 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
 void dcn30_hardware_release(struct dc *dc);
 
-void dcn30_blank_pixel_data(struct dc *dc, struct pipe_ctx *pipe_ctx, bool blank);
+void dcn30_set_disp_pattern_generator(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		enum controller_dp_test_pattern test_pattern,
+		enum controller_dp_color_space color_space,
+		enum dc_color_depth color_depth,
+		const struct tg_color *solid_color,
+		int width, int height, int offset);
 
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 4d1b756f5cbf..6125fe440ad0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -95,6 +95,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
+	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
@@ -106,7 +107,7 @@ static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.set_output_transfer_func = dcn30_set_output_transfer_func,
 	.power_down = dce110_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
-	.blank_pixel_data = dcn30_blank_pixel_data,
+	.blank_pixel_data = dcn20_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index f728928cda5a..2313115b5628 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -223,6 +223,14 @@ struct hw_sequencer_funcs {
 
 	bool (*is_abm_supported)(struct dc *dc,
 			struct dc_state *context, struct dc_stream_state *stream);
+
+	void (*set_disp_pattern_generator)(const struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			enum controller_dp_test_pattern test_pattern,
+			enum controller_dp_color_space color_space,
+			enum dc_color_depth color_depth,
+			const struct tg_color *solid_color,
+			int width, int height, int offset);
 };
 
 void color_space_to_black_color(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

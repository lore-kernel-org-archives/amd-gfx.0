Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD3C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75F6218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="br1em026"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75F6218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8425D6EC57;
	Tue, 27 Oct 2020 20:52:59 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700077.outbound.protection.outlook.com [40.107.70.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAD66EC59
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGaCbnXMyJtmslLnkvCYkJXNOYg/2WPAO9oYnxG3wUTcZ9WnMeUabdRCLRq7gJ90i0DBLf4CtnTHPvEzqPZvafDVLuWQMV8ce9vCiL0l/E2UrTUZMN6k7LHBQ20cnFWP7Eh+mmTpc36VgldfqoR93T54oix6xUh17GTY6PSbY97uBXmhnoC/uesKfXOP5aKJtDJBsTjGNR0pR1VHK1lgej53/0zgwVjFUqsuhCKLew67oecRur/OkBxkZcG647Tah8+wjlthdDOmKKl01gPOb6UzXXNSwCIS5auAW2kAkI/PuiE9j2In+HQ53ssLRXBJ39Oa7+BW93q7e/5q1brYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXIbXTAGplzGu3kmPNBHY2wLymvCTnXYLwiBAikTA7Q=;
 b=aI3Ip+/78qCcXfkpZUq1jkp2RwXfhbkVfmiifbTkO9+BBWc8KHsgukRbOfR5PEIyV7KidFUe/cb7Wm79Yp5+WiCV63nepd2yYjzNYL2IiZUD7xEhkKYHmoIySSlgVAJE8xJuX8I6Ialkinu7JwJ4Nwi2Xy1ECZBJzheaOPtNFmH9IXe945cQ2A+M3RmySIsIdnZVuh1SAIid79ew7V879vC65L7AZoTWz+BQNMCW8WAk2Hf6wGti0FWdrSvq1l/3lgfaJunIKvQxPl/2xXKAYlUwiP7jBQ3M2Tk1RiJ8KzG/nXtj0bEKTAfdxmetYslXThbSfaA/1ydypiYFlMnTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXIbXTAGplzGu3kmPNBHY2wLymvCTnXYLwiBAikTA7Q=;
 b=br1em026YsOW9ryXVIlNNReR0sQRvF/jCg0H/apidIW4+soZB8ZJPoj0KDyyw66y4VG3zsGBbF+05imWfEiMwq+KqUc1HfxrOO/xkglLyVGqIbRsb8ZIPgfLWBW4GRfOZgrp7OMwwQRPNENfBu1VJznztbhPHFRQkR+nvE9Ui8c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:57 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:57 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/25] drm/amd/display: Blank HUBP during pixel data blank for
 DCN30
Date: Tue, 27 Oct 2020 16:52:17 -0400
Message-Id: <20201027205234.8239-9-qingqing.zhuo@amd.com>
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
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 020be341-e2d2-40b0-a7dc-08d87aba445f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595F453C57F06A4657AFE10FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItQFEjpFTp64zlANLD/bZyXAV+Yxp4KUrDYysrA2zvG9Xjkzxpkg9AChVOx84aCljbF6yD7urcrxUt2IbLddDP8qVG8uAhfLIdJG3pZXMloo28+dV9adWmcpK/w7F+ePBz+WX8y8t/TfRVFo54+hMX/4qmUVf7/dKja7se4FmDPhqKTSucBzynS1MYJ3Kj1R5SVJYa7KwIU1eFbYcu5sZx4jR4MQAf8SDfAdV/tqKVhu7RJ0QArbI+hi5UBp1bp91vmMAPFT6w23xqTc5P23WTdsRXovnEEKFIbIuqyeEhjgbr6/lJhQaw6gKjPI19ukLgdXsfNcKWdiwpDYqlL2HSsXhDpW5f53tM6MyblSjC7fmD+hhhp3vPw92hlnsyEv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oFUQP1Kt4eC0Pg5Mtf99pXVE1/kIHo8ugtnMsgIu6CjrZCbrk15NzwGSP6Tonwl0xj/5TsRMYs12cfYJS3Tl3fpxamWXOE3yhVIx2VEauJUsjYq40rKbP2jpY9W/QiAyjgf5THReYc6XdaqDxF0vJYPaE9vb8Bg4zx0gtsFDBlkaGWdsZZ0fDN2LmzbGuVWXFzCXMwgvun3YTJxqlSNoWJo7bsChF3hZPjgxtZT31PQ4NdTIDSJHv7nA/AXpxmblP6AItkxwSSFVErAkeDM+0qOHmFj89cMsNhwa3jPmvpyyJLpxHQIL3WdIrhqVfeQa7EJuKBBq430gIfk1gGqYfwNsagvg+KDpiE8sL0eRKjiEssO5+RR6rScxibTChZkgmGRhNxthzd9Kx92lbt6BslLtUzXceRA6dsTBj9bSBAXDe89gnaUpoCTbMxglToF4IdpbDB87o5qI9oTHl2hI/uu+4vMaNjhIMUan88hrT9IzVDwOAjoyjpU9uq4yUurj563qqJc32hThwkahJHp4WV8eDnUCjVTZhL0keIAqDkYNQr/aDfQTpn+VTy/DOx6jcAGST6tvXo9RaU9ldvkjG0pHXkP6TX4bEIcGePVQU282HQVZ1HkMzlYsCG+GF1Vur9Kb+9tYle2rf+6eJXGmkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020be341-e2d2-40b0-a7dc-08d87aba445f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:50.4269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqrcozmafxrAtqqt99V+3wU0yrla1i5fzN5cier4uCukqLYofbuloK3ue4VNwfB6
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
There are some timings for which we support p-state
switching in active, but not in blank. There was a
previous issue where a timing that had active-only
support would hang a p-state request when we were in
an extended blanking period. The workaround for that
issue was to block active-only p-state switching,
but that resulted in a lack of p-state support for
some common timings such as 1440p60. We want to fix
that issue properly by un-blocking p-state requests
while the display is blanked, so that we can re-enable
active-only p-state switching.

[How]
 - new version of blank_pixel_data for DCN30
 - call hubp->set_blank from dcn30_blank_pixel_data
 - blank every hubp in the mpcc tree, and odm tree
 - on blank enable, wait until the next frame before blanking HUBP

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 83 +++++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 4 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index f3ae208850b0..3699c9a2789c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -794,3 +794,86 @@ void dcn30_hardware_release(struct dc *dc)
 		dc->res_pool->hubbub->funcs->force_pstate_change_control(
 				dc->res_pool->hubbub, true, true);
 }
+
+void dcn30_blank_pixel_data(struct dc *dc, struct pipe_ctx *pipe_ctx, bool blank)
+{
+	struct tg_color black_color = {0};
+	struct stream_resource *stream_res = &pipe_ctx->stream_res;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	enum dc_color_space color_space = stream->output_color_space;
+	enum controller_dp_test_pattern test_pattern = CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR;
+	enum controller_dp_color_space test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
+	struct pipe_ctx *odm_pipe;
+	struct pipe_ctx *mpcc_pipe;
+	int odm_cnt = 1;
+
+	int width = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+	int height = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
+
+	if (stream->link->test_pattern_enabled)
+		return;
+
+	/* get opp dpg blank color */
+	color_space_to_black_color(dc, color_space, &black_color);
+
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		odm_cnt++;
+
+	width = width / odm_cnt;
+
+	if (blank) {
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+
+		if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE) {
+			test_pattern = CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
+			test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_RGB;
+		}
+	} else {
+		test_pattern = CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
+	}
+
+	stream_res->opp->funcs->opp_set_disp_pattern_generator(
+			stream_res->opp,
+			test_pattern,
+			test_pattern_color_space,
+			stream->timing.display_color_depth,
+			&black_color,
+			width,
+			height,
+			0);
+
+	/* wait for the next frame when enabling DPG */
+	if (blank && stream_res->tg->funcs->is_tg_enabled(stream_res->tg))
+		dc->hwseq->funcs.wait_for_blank_complete(pipe_ctx->stream_res.opp);
+
+	/* Blank HUBP to allow p-state during blank on all timings */
+	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, blank);
+	for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+		mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, blank);
+
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+		odm_pipe->stream_res.opp->funcs->opp_set_disp_pattern_generator(
+				odm_pipe->stream_res.opp,
+				dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE && blank ?
+						CONTROLLER_DP_TEST_PATTERN_COLORRAMP : test_pattern,
+				test_pattern_color_space,
+				stream->timing.display_color_depth,
+				&black_color,
+				width,
+				height,
+				0);
+
+		if (blank && stream_res->tg->funcs->is_tg_enabled(stream_res->tg))
+			dc->hwseq->funcs.wait_for_blank_complete(pipe_ctx->stream_res.opp);
+
+		odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, blank);
+		for (mpcc_pipe = odm_pipe->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, blank);
+	}
+
+	if (!blank)
+		if (stream_res->abm) {
+			dc->hwss.set_pipe(pipe_ctx);
+			stream_res->abm->funcs->set_abm_level(stream_res->abm, stream->abm_level);
+		}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 0ae047221afe..7d9db7cdd2f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -69,4 +69,6 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
 void dcn30_hardware_release(struct dc *dc);
 
+void dcn30_blank_pixel_data(struct dc *dc, struct pipe_ctx *pipe_ctx, bool blank);
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index b829cb116916..4d1b756f5cbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -106,7 +106,7 @@ static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.set_output_transfer_func = dcn30_set_output_transfer_func,
 	.power_down = dce110_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
-	.blank_pixel_data = dcn20_blank_pixel_data,
+	.blank_pixel_data = dcn30_blank_pixel_data,
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 9e0ae18e71fa..50b7d011705d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5558,7 +5558,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		}
 	}
 
-	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0 && PrefetchMode == 0) {
+	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vactive;
 	} else if (((mode_lib->vba.SynchronizedVBlank == true || mode_lib->vba.TotalNumberOfActiveOTG == 1 || SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank > 0) && PrefetchMode == 0)) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vblank;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

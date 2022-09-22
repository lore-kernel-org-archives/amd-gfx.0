Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF804ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAB810E9ED;
	Thu, 22 Sep 2022 00:18:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B9810E9EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8XrZn++Jt0hw2zmIvsOtyaMJbK9q1aTy/k/74tQRWgTSXYvcmrqsWmd92hj+b0DVYdhzNFl7io1O3a7PKj/H/1DacvOlC2+Oxluke0IaAYYjq8AIoDL04HNBcW4XlzKxnDdk2Fu8jdL4SYw357PxWU9O1OHA+jv92D/GJey9jGVQ0WCrAVl6VnVPe3uKxVvEyD0Fk1HwtGmEtgrrv7MUrNHvcqwMiyUrrd710LYHiCfTIBcjHcB+1KIHWTx0fJuzPdBfUb410nWInV6YHERX1MGb1QIU19d98sDzfknMsGwrMDJbruvrhDq4u1N0WXOzz0hMP5u06KlNw6zSQNDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnlCVWO/llarYmS+0G2n3yeaQVmgglI5is//QYy8IX4=;
 b=H1AuK3V5nPigGwHNJ4IL+T3V2DJUUMjaQah9gktO6y49I4u5E5uR+ocfYvU8tD7dv8tLwYm0EGWROjYFKMLgF/f0M3YIrtGYwCI0/LnW3P+jZvlQB4fc2OkDFMnwdPfQ0rut0l8gCYQttBrTrfqg5UJcjPhI6thaoe/0ZFahK1k9fJ3jMO6GqO34FTr3GS47FXNghCDbNQZA4VENwALI4eQERDRUeZ6WnuKBN2CYxao/Yhd38qJKzcYehcgqUu4eI6qYRUvZTCRKCt6Iiq+CaLi7PzxkMWBnuYkCxJri1S1M+2WSFBbLAuv/Pe0+TKqHI1sQVJmswX4fBqWSAof+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnlCVWO/llarYmS+0G2n3yeaQVmgglI5is//QYy8IX4=;
 b=ivEmaltBpFXvbWVBH+UENxpC7Kb0aaVZpuwE96sVRtgY0gUFfJKKEgBfPPLkc65dQ8DzeZ8sl0HN6AnlarwSeRg2exg8eFly9GsLzUCT98VjD3lWndDOBi99gXxk9edD+p3Ht30gMOWdY59Lj+hvzD0P4TjpyUlvgFArQzaHhyI=
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 00:18:49 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::f4) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:48 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:45 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/31] drm/amd/display: Remove interface for periodic
 interrupt 1
Date: Wed, 21 Sep 2022 20:17:54 -0400
Message-ID: <20220922001821.320255-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4b716b-acec-4501-5318-08da9c300549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRsjU7HCiHerxl9Xet8P2GQog+EXRDu5hHZUvXw2RY8xYhzItDYpJQqcVWf2U2F9jIx7gY673vsw9XoF+bS1TLH5L2Uh8HLwPRRedFfslBLSk2U6XlzaD/tAsapa9E1aZ+bE9wIBoU9QeIPHHKB4+JqamhoBGfK0YUg7JbmE5HFIBcxbZrTslF63lmezSiLNHNJUlOvppBEDA5/DjxXhWuDLpCk6XQOleOU9CWtgSMI/E9ALWX0CSR6okvOA2ptkRNWn6Wd135o/1tHpAinyel7uE3iknDdvQZooPg1dsHUCsl/i0BJucKIaH8BsckUoD1syZQw7PdmT5ieXNfa+uHp86fRPkN/EZtEP61We9h/XBD5n223KqVhxLQ3BbmDNHxogE5MtrtPBO5dr1mDLZBGxwQr4/ssEpLCNj1k25m0TtSpguuBR7TdRMA3RiRPxFEnzj2qWc+cp1lANG48vnAIXg2SYeuExkskb3iNRhRf3kQcFa61u5JQ+7gwAUxLKL+ATOEUTVIGMjYyVHr3WjbTZppQDz4XNzHFp3PwecUxGsmA9QO7C+kD0Iqb/RTow3Aoh6HgoJa9d8eRy/Rb/nCEwk4TWLsZYzh5PNkjg+WCVTt6zmfJ9DRySzSWi47TzdGaT67Wg/kfp9MPvAPGIHSK3/lfn9DZxmtrv4Hk0ztGemOH8+5d+WHNfSOCWD5W29akDZOr29VpRMYTk/Ry7InzuOigpF7aYXe6iT3Mkizgzd4DBWUXk/kMv3Ptks3KsjP1aVnIBkNxRKwY8acpHM7APUiwk7q+aUA4gdrdbPGXejnMswJuRwEg7pF/EA9c/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(82740400003)(4326008)(82310400005)(6916009)(316002)(16526019)(336012)(54906003)(356005)(6666004)(41300700001)(70206006)(8676002)(36756003)(70586007)(40480700001)(81166007)(40460700003)(26005)(36860700001)(5660300002)(8936002)(2906002)(83380400001)(186003)(1076003)(2616005)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:48.6776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4b716b-acec-4501-5318-08da9c300549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Jaehyun Chung <jaehyun.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
Only a single VLINE interrupt is available so interface should not
expose the second one which is used by DMU firmware.

[how]
Remove references to periodic_interrupt1 and VLINE1 from DC interfaces.

Reviewed-by: Jaehyun Chung <jaehyun.chung@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 16 +++------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  6 ++--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 35 ++++++-------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  8 +----
 5 files changed, 18 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 390adc00cd28..d93393cc66c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2768,11 +2768,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->abm_level)
 		stream->abm_level = *update->abm_level;
 
-	if (update->periodic_interrupt0)
-		stream->periodic_interrupt0 = *update->periodic_interrupt0;
-
-	if (update->periodic_interrupt1)
-		stream->periodic_interrupt1 = *update->periodic_interrupt1;
+	if (update->periodic_interrupt)
+		stream->periodic_interrupt = *update->periodic_interrupt;
 
 	if (update->gamut_remap)
 		stream->gamut_remap_matrix = *update->gamut_remap;
@@ -2992,13 +2989,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 		if (!pipe_ctx->top_pipe &&  !pipe_ctx->prev_odm_pipe && pipe_ctx->stream == stream) {
 
-			if (stream_update->periodic_interrupt0 &&
-					dc->hwss.setup_periodic_interrupt)
-				dc->hwss.setup_periodic_interrupt(dc, pipe_ctx, VLINE0);
-
-			if (stream_update->periodic_interrupt1 &&
-					dc->hwss.setup_periodic_interrupt)
-				dc->hwss.setup_periodic_interrupt(dc, pipe_ctx, VLINE1);
+			if (stream_update->periodic_interrupt && dc->hwss.setup_periodic_interrupt)
+				dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
 
 			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
 					stream_update->vrr_infopacket ||
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 9fcf9dc5bce4..9e6025c98db9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -212,8 +212,7 @@ struct dc_stream_state {
 	/* DMCU info */
 	unsigned int abm_level;
 
-	struct periodic_interrupt_config periodic_interrupt0;
-	struct periodic_interrupt_config periodic_interrupt1;
+	struct periodic_interrupt_config periodic_interrupt;
 
 	/* from core_stream struct */
 	struct dc_context *ctx;
@@ -281,8 +280,7 @@ struct dc_stream_update {
 	struct dc_info_packet *hdr_static_metadata;
 	unsigned int *abm_level;
 
-	struct periodic_interrupt_config *periodic_interrupt0;
-	struct periodic_interrupt_config *periodic_interrupt1;
+	struct periodic_interrupt_config *periodic_interrupt;
 
 	struct dc_info_packet *vrr_infopacket;
 	struct dc_info_packet *vsc_infopacket;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 287fdecc0b10..72521749c01d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3812,7 +3812,7 @@ void dcn10_calc_vupdate_position(
 {
 	const struct dc_crtc_timing *dc_crtc_timing = &pipe_ctx->stream->timing;
 	int vline_int_offset_from_vupdate =
-			pipe_ctx->stream->periodic_interrupt0.lines_offset;
+			pipe_ctx->stream->periodic_interrupt.lines_offset;
 	int vupdate_offset_from_vsync = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
 	int start_position;
 
@@ -3837,18 +3837,10 @@ void dcn10_calc_vupdate_position(
 static void dcn10_cal_vline_position(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
-		enum vline_select vline,
 		uint32_t *start_line,
 		uint32_t *end_line)
 {
-	enum vertical_interrupt_ref_point ref_point = INVALID_POINT;
-
-	if (vline == VLINE0)
-		ref_point = pipe_ctx->stream->periodic_interrupt0.ref_point;
-	else if (vline == VLINE1)
-		ref_point = pipe_ctx->stream->periodic_interrupt1.ref_point;
-
-	switch (ref_point) {
+	switch (pipe_ctx->stream->periodic_interrupt.ref_point) {
 	case START_V_UPDATE:
 		dcn10_calc_vupdate_position(
 				dc,
@@ -3857,7 +3849,9 @@ static void dcn10_cal_vline_position(
 				end_line);
 		break;
 	case START_V_SYNC:
-		// Suppose to do nothing because vsync is 0;
+		// vsync is line 0 so start_line is just the requested line offset
+		*start_line = pipe_ctx->stream->periodic_interrupt.lines_offset;
+		*end_line = *start_line + 2;
 		break;
 	default:
 		ASSERT(0);
@@ -3867,24 +3861,15 @@ static void dcn10_cal_vline_position(
 
 void dcn10_setup_periodic_interrupt(
 		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		enum vline_select vline)
+		struct pipe_ctx *pipe_ctx)
 {
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	uint32_t start_line = 0;
+	uint32_t end_line = 0;
 
-	if (vline == VLINE0) {
-		uint32_t start_line = 0;
-		uint32_t end_line = 0;
+	dcn10_cal_vline_position(dc, pipe_ctx, &start_line, &end_line);
 
-		dcn10_cal_vline_position(dc, pipe_ctx, vline, &start_line, &end_line);
-
-		tg->funcs->setup_vertical_interrupt0(tg, start_line, end_line);
-
-	} else if (vline == VLINE1) {
-		pipe_ctx->stream_res.tg->funcs->setup_vertical_interrupt1(
-				tg,
-				pipe_ctx->stream->periodic_interrupt1.lines_offset);
-	}
+	tg->funcs->setup_vertical_interrupt0(tg, start_line, end_line);
 }
 
 void dcn10_setup_vupdate_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 9ae07c77fdc0..0ef7bf7ddb75 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -175,8 +175,7 @@ void dcn10_set_cursor_attribute(struct pipe_ctx *pipe_ctx);
 void dcn10_set_cursor_sdr_white_level(struct pipe_ctx *pipe_ctx);
 void dcn10_setup_periodic_interrupt(
 		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		enum vline_select vline);
+		struct pipe_ctx *pipe_ctx);
 enum dc_status dcn10_set_clock(struct dc *dc,
 		enum dc_clock_type clock_type,
 		uint32_t clk_khz,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 60cbd423c911..d04b68dad413 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -32,11 +32,6 @@
 #include "inc/hw/link_encoder.h"
 #include "core_status.h"
 
-enum vline_select {
-	VLINE0,
-	VLINE1
-};
-
 struct pipe_ctx;
 struct dc_state;
 struct dc_stream_status;
@@ -118,8 +113,7 @@ struct hw_sequencer_funcs {
 			int group_index, int group_size,
 			struct pipe_ctx *grouped_pipes[]);
 	void (*setup_periodic_interrupt)(struct dc *dc,
-			struct pipe_ctx *pipe_ctx,
-			enum vline_select vline);
+			struct pipe_ctx *pipe_ctx);
 	void (*set_drr)(struct pipe_ctx **pipe_ctx, int num_pipes,
 			struct dc_crtc_timing_adjust adjust);
 	void (*set_static_screen_control)(struct pipe_ctx **pipe_ctx,
-- 
2.25.1


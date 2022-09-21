Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0010ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29BC10E98F;
	Wed, 21 Sep 2022 23:17:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 681E510E977
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnY67DXuO6/f5G9tTHczzjazgyRs6nQgpKULNST+/GFUciZB19IuHlVlw1ispewRm9FgReZq+49fZ1O07doXjJ/soFJt9UEkapcxUmCkMB++c6tmbpaNGxFwezAbL74AlWOY+4FWxiGxGVv9EFn1O8v4N97Y3PAwRGPXbMK3TPE7c1ZXdXuejil+NECe4eEvm2kPpZ8FJWj5GTLWNoHRfdCjACDMSxEZVdzzgOOMTWZels5+WW7bId/ihXa0yJcXR5JQWSmE/sfm7S9xPQ0SLM1eWfgtT21V1P4Dug5fn9Dk6EneCWMWToZ07Tm8jy9y1E2VZelvTJ9WFHO6kYIg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnlCVWO/llarYmS+0G2n3yeaQVmgglI5is//QYy8IX4=;
 b=Cd5Fiv1AthOTapfbjLN6E5ve9KLykXfBnqnqjHKghZimDJln7R7BlD7mh1zaSbS/CF7wVdw8pAIRdERrmYmmBTZRgkqWI+Mgzhg75q6vq9FQZfFgt53G2CHwfzrfVLXLDkvXpFVvSQDiZaXixX/4R1Q9ET49DnA86zAAmelerYpLK6aRj+AtczNmtQGzqAW52jcmBtbXwqKVbsEJSaJmr0JHtw2t2uLaWN6UoVmdUA+qCfFqmqxKMWaEI4GdfSdiF+MQeFNam0U7ZOYZIEtAyxNOgJ9ptvHrxop5OEqtlltl4x1feWbt3/M6BsUfzaDRSkj2t1XV2/dxerBY8T4pMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnlCVWO/llarYmS+0G2n3yeaQVmgglI5is//QYy8IX4=;
 b=Nu7WC3FsroAQ+hy3aLP78cmlPNEVwRR18uthPC1xbdwcMYInmRkPVbeSFNxvxYqkxtUp0HHOcWskujzLNhSOODEK1jjjqs9IsyAPdB+Mb/lznO4cUGrVcKs7XhAOooN4lwvEBDvpEsdbQKpNENn+yitK6fecjmMsNX7FNROQ4X0=
Received: from MW4PR03CA0073.namprd03.prod.outlook.com (2603:10b6:303:b6::18)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 23:17:39 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::7f) by MW4PR03CA0073.outlook.office365.com
 (2603:10b6:303:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:39 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:35 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/31] drm/amd/display: Remove interface for periodic
 interrupt 1
Date: Wed, 21 Sep 2022 19:16:47 -0400
Message-ID: <20220921231714.303727-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|MN2PR12MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c914341-e4a4-4e05-3c0e-08da9c277a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HPrkpnL2Eo60cSm7kjG/cqI1mtv2pl6sisUWwNRFa2qjKC4xIfinjLaYy+rrJMUyL0f2d1RpjhHWm4ElqbofzCEpaKRijr8WErT6ve/ELvufDrKv2oDACeFBpAbnZfh4s0SNtYuRUbtgMnyo2tf4K3qQaGlM4lBrFzAO+UoBZDpcDWdIFEpDwVAg154oH8Yt5VkhCeKz98SY+OS2qCDlyII/AsUcRymJBdcA0aI6/0IFcMT8BVDqKHNxxHInJMmVYnDjHRK7+6a79jc3DUlb1mqg8ORgW8R0ma8AgBJ3B6NhtdmFflIONjCGprBByyZiduFth1FICaKcQqKcAu9N6TlpWz+7A0vV44P4PPi914hsbX6o7nXq2E63nZTncnDVr5btfLpSK1LecdHyFh8nSb3phdWYV11N751zIXLNoO6ff0ks3jx/3aGN6kCqSZItGNTkunyLBsIBhPbYRU8tdnrkqvra3lTLq2dYf3eBpBao7GwV3rvNbJgvw4ny+pXKdQ07fsvI1O+EY4w1YXhSviDa1jqd9YR7hw7j7CNQwwLGFvaS8TKL+GP418cHuWs0ZUp9KScvWoU8vUUtL8YyRuQ44BzGp/kNY3BALZJNOcM+qg6kCtZkREa5ARi8caM/6u+e4QJ7LxA14dpnbzeFy2AHyrdFwChphZUHx+0z18KeHTXChqx87Z4q4pA6e9khH1qsBk+9knPWG+MVsvL1fAum+fXeBPYZriVg8lxvCy8PLZuq/Wq+IOecpiYP7bGVZbQEQIipINgkq5F6WEV2ZDWt7QEiIxmfoz6w10f1TjlLChNNo42o7pwTH7Y6uqL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(2906002)(8676002)(54906003)(6916009)(316002)(5660300002)(70586007)(40480700001)(70206006)(4326008)(82310400005)(81166007)(6666004)(478600001)(41300700001)(8936002)(1076003)(186003)(16526019)(26005)(47076005)(2616005)(426003)(336012)(356005)(36756003)(40460700003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:39.4469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c914341-e4a4-4e05-3c0e-08da9c277a54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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


Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18678C33CA5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AC22080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SO4MHKkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AC22080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B266EA4A;
	Fri, 10 Jan 2020 14:48:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12646EA45
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aklOQ2FP8m8AB7G8N7rYeXY0O2w6xcVMzbUmxh1TOusyCwCvpc/ZGDu2vY1lMujeUqXxTul5Yuzdd3KA61yslO7+OnZgNFrqDIenyKXHqm08HxKV68QmnrGH725KwdPFw3MItfGzRutteAk0KCuJIz9o0pjZjz0XLcTKJLbcRTOj/eOKU29QL2cZ2dj5J8O6aolvee1TY9CI3LuL9aiQF9BCuWfH6NRoag5SvBFvmOBLFmhGwFabZzEVjQER6cifoK6O07u2OSSqQXfijUJPYoSCjf4y/XkRISre8y2JBzd+X/GRXzdHERcYfZSGH3wktAS837XB41qpKnm+Nb9Efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVJO8CXJM2XUXYcpw3BAiuKqbQNEijO1gOWOaj6R2Ws=;
 b=hsPefOjwWbhWlMzJCBRJdv+uNjHLWsPmiSazqVeNTf3rp+0ZhpBOxLwXA71Poejzl9yaFxAiRnR1t+ATCFiIeDsBwI3wQHd3NHkzeotVt2XBEeoyL/b0t2VkoeeKlu9C255U/ip//PJpXD/Q6xuGIJq9ACW1MYPRM3WLnFMwrFu2tJMko++Xrn8y4Ah2DArHv4ClY8Y9ptLXyAC22mGzv83jtX8O60t3mcRUhqi7e8jHp1v/qS6heqxykmMN84TbkL4asRlejv3T24MkOMHZrbY7v0rgebG25ElDIYIvzZP+F/h54rL3TvAz3FkTPZg8RW0CtleKYwowaCqtlXWtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVJO8CXJM2XUXYcpw3BAiuKqbQNEijO1gOWOaj6R2Ws=;
 b=SO4MHKkT0KRMs8XCiG7R/k1/EPa5NiqEcJvbss3qhLKdbAWmIQhfoYRquL0ooUKpafaptZPib3H5Y7yNvtfOYJCvYAn0PlB5zu2wssdvVYSF+0+AqxwTpINiw+yCgXP5cFP7k4n24c2/vdlmw9eEWz/R1yPkQCTahFscuOLkUMg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:19 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:19 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/43] drm/amd/display: make PSR static screen entry within 30
 ms
Date: Fri, 10 Jan 2020 09:46:46 -0500
Message-Id: <20200110144655.55845-35-Rodrigo.Siqueira@amd.com>
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
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:50 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58c7699a-c168-40d3-d1e4-08d795dc1129
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2378A0D2742568C057DC867798380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(30864003)(316002)(8936002)(16526019)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+yqvgouMkQlSk7TcQEk+w+qzU5ldSVyZg9HdMLkquohqsG4hxQt6GpgP5cHtkn2QTISgdb4zCq5Ug5gW8mvKXlsaNSdF7zZBZFbdrNIzgvWXbyzBO+D3M1ZAsnFQpf8Qcsjknhcp3ujNKKQQyoXpfXEWUrlXBSKlU0z0Ms0Hi/Otj/OruBOZr+CucY9t2ouk8izqq4P0+qOTYWPkN0QSCVZrOWDjGkOd2gZW2DYem2TrnZVIiOLjSQJZLWwUSzs01/Ve3LP2f2p9NRP23g49PTRtc8aLu+BfAJnU6qELmC0Vdw9OVO/r6D3ISyaHgH6V3SHLeffvLTt5DPSPcSNBCjkoKgySu0q/zAfH1KIov4mAU9QzZMv0/qsgQmRjcoFydTK6ka88PM7tsaveoSENT/UMlG4BCYXPIX+dhnT3l6tVQ2GEGCEwUEH9BjPanDh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c7699a-c168-40d3-d1e4-08d795dc1129
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:51.1700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDkaQM412srs8fZdJpqSLGHOXW5Hv3ZNnnmtBuRvU0dDc0sl6/cgWZHtTSQqsIfPbseevY3BfCpuReJ+NlKcvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
With different refresh rate panels, the PSR entry/exit time is
different since it is dependent on 2 frame entry time today

[How]
Make static screen num frame entry time to be calculated
such that entry time is within 30 ms instead of fixed num
frames.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           | 13 ++++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 +--
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 35 +++++++++++--------
 .../dc/dce110/dce110_timing_generator.c       | 11 ++++--
 .../dc/dce110/dce110_timing_generator.h       |  3 +-
 .../dc/dce120/dce120_timing_generator.c       | 11 ++++--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 23 ++++++------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 15 +++++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  3 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +++-
 .../amd/display/dc/inc/hw/timing_generator.h  |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 +--
 .../amd/display/dc/inc/hw_sequencer_private.h |  2 +-
 18 files changed, 116 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bd51471a9c62..32885fed64af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8474,17 +8474,37 @@ static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 {
 	struct dc_link *link = stream->link;
-	struct dc_static_screen_events triggers = {0};
+	unsigned int vsync_rate_hz = 0;
+	struct dc_static_screen_params params = {0};
+	/* Calculate number of static frames before generating interrupt to
+	 * enter PSR.
+	 */
+	unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
+	// Init fail safe of 2 frames static
+	unsigned int num_frames_static = 2;
 
 	DRM_DEBUG_DRIVER("Enabling psr...\n");
 
-	triggers.cursor_update = true;
-	triggers.overlay_update = true;
-	triggers.surface_update = true;
+	vsync_rate_hz = div64_u64(div64_u64((
+			stream->timing.pix_clk_100hz * 100),
+			stream->timing.v_total),
+			stream->timing.h_total);
+
+	/* Round up
+	 * Calculate number of frames such that at least 30 ms of time has
+	 * passed.
+	 */
+	if (vsync_rate_hz != 0)
+		num_frames_static = (30000 / frame_time_microsec) + 1;
+
+	params.triggers.cursor_update = true;
+	params.triggers.overlay_update = true;
+	params.triggers.surface_update = true;
+	params.num_frames = num_frames_static;
 
-	dc_stream_set_static_screen_events(link->ctx->dc,
+	dc_stream_set_static_screen_params(link->ctx->dc,
 					   &stream, 1,
-					   &triggers);
+					   &params);
 
 	return dc_link_set_psr_allow_active(link, true, false);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c918a0cd8c60..6c797fac189d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -510,10 +510,10 @@ bool dc_stream_program_csc_matrix(struct dc *dc, struct dc_stream_state *stream)
 	return ret;
 }
 
-void dc_stream_set_static_screen_events(struct dc *dc,
+void dc_stream_set_static_screen_params(struct dc *dc,
 		struct dc_stream_state **streams,
 		int num_streams,
-		const struct dc_static_screen_events *events)
+		const struct dc_static_screen_params *params)
 {
 	int i = 0;
 	int j = 0;
@@ -532,7 +532,7 @@ void dc_stream_set_static_screen_events(struct dc *dc,
 		}
 	}
 
-	dc->hwss.set_static_screen_control(pipes_affected, num_pipes_affected, events);
+	dc->hwss.set_static_screen_control(pipes_affected, num_pipes_affected, params);
 }
 
 static void dc_destruct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 0faf582084d0..7fcae8d63811 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2542,7 +2542,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 		transmitter_to_phy_id(link->link_enc->transmitter);
 
 	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
-	psr_context->vsyncRateHz = div64_u64(div64_u64((stream->
+	psr_context->vsync_rate_hz = div64_u64(div64_u64((stream->
 					timing.pix_clk_100hz * 100),
 					stream->timing.v_total),
 					stream->timing.h_total);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e1c11af2bcaf..7639fa074c6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -157,11 +157,14 @@ struct dc_surface_dcc_cap {
 	bool const_color_support;
 };
 
-struct dc_static_screen_events {
-	bool force_trigger;
-	bool cursor_update;
-	bool surface_update;
-	bool overlay_update;
+struct dc_static_screen_params {
+	struct {
+		bool force_trigger;
+		bool cursor_update;
+		bool surface_update;
+		bool overlay_update;
+	} triggers;
+	unsigned int num_frames;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 37c10dbf269e..92096de79dec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -439,10 +439,10 @@ bool dc_stream_get_crc(struct dc *dc,
 		       uint32_t *g_y,
 		       uint32_t *b_cb);
 
-void dc_stream_set_static_screen_events(struct dc *dc,
+void dc_stream_set_static_screen_params(struct dc *dc,
 					struct dc_stream_state **stream,
 					int num_streams,
-					const struct dc_static_screen_events *events);
+					const struct dc_static_screen_params *params);
 
 void dc_stream_set_dyn_expansion(struct dc *dc, struct dc_stream_state *stream,
 		enum dc_dynamic_expansion option);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 4b5b97520733..e59532d98cb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -729,7 +729,7 @@ struct psr_context {
 	/* The VSync rate in Hz used to calculate the
 	 * step size for smooth brightness feature
 	 */
-	unsigned int vsyncRateHz;
+	unsigned int vsync_rate_hz;
 	unsigned int skipPsrWaitForPllLock;
 	unsigned int numberOfControllers;
 	/* Unused, for future use. To indicate that first changed frame from
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 4939cf3b316f..5b689273ff44 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1373,9 +1373,13 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	// DRR should set trigger event to monitor surface update event
 	if (stream->adjust.v_total_min != 0 && stream->adjust.v_total_max != 0)
 		event_triggers = 0x80;
+	/* Event triggers and num frames initialized for DRR, but can be
+	 * later updated for PSR use. Note DRR trigger events are generated
+	 * regardless of whether num frames met.
+	 */
 	if (pipe_ctx->stream_res.tg->funcs->set_static_screen_control)
 		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
-				pipe_ctx->stream_res.tg, event_triggers);
+				pipe_ctx->stream_res.tg, event_triggers, 2);
 
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
@@ -1706,6 +1710,8 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 	struct drr_params params = {0};
 	// DRR should set trigger event to monitor surface update event
 	unsigned int event_triggers = 0x80;
+	// Note DRR trigger events are generated regardless of whether num frames met.
+	unsigned int num_frames = 2;
 
 	params.vertical_total_max = vmax;
 	params.vertical_total_min = vmin;
@@ -1721,7 +1727,7 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 		if (vmax != 0 && vmin != 0)
 			pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
 					pipe_ctx[i]->stream_res.tg,
-					event_triggers);
+					event_triggers, num_frames);
 	}
 }
 
@@ -1738,30 +1744,31 @@ static void get_position(struct pipe_ctx **pipe_ctx,
 }
 
 static void set_static_screen_control(struct pipe_ctx **pipe_ctx,
-		int num_pipes, const struct dc_static_screen_events *events)
+		int num_pipes, const struct dc_static_screen_params *params)
 {
 	unsigned int i;
-	unsigned int value = 0;
+	unsigned int triggers = 0;
 
-	if (events->overlay_update)
-		value |= 0x100;
-	if (events->surface_update)
-		value |= 0x80;
-	if (events->cursor_update)
-		value |= 0x2;
-	if (events->force_trigger)
-		value |= 0x1;
+	if (params->triggers.overlay_update)
+		triggers |= 0x100;
+	if (params->triggers.surface_update)
+		triggers |= 0x80;
+	if (params->triggers.cursor_update)
+		triggers |= 0x2;
+	if (params->triggers.force_trigger)
+		triggers |= 0x1;
 
 	if (num_pipes) {
 		struct dc *dc = pipe_ctx[0]->stream->ctx->dc;
 
 		if (dc->fbc_compressor)
-			value |= 0x84;
+			triggers |= 0x84;
 	}
 
 	for (i = 0; i < num_pipes; i++)
 		pipe_ctx[i]->stream_res.tg->funcs->
-			set_static_screen_control(pipe_ctx[i]->stream_res.tg, value);
+			set_static_screen_control(pipe_ctx[i]->stream_res.tg,
+					triggers, params->num_frames);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 5f7c2c5641c4..1ea7db8eeb98 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -469,22 +469,27 @@ void dce110_timing_generator_set_drr(
 
 void dce110_timing_generator_set_static_screen_control(
 	struct timing_generator *tg,
-	uint32_t value)
+	uint32_t event_triggers,
+	uint32_t num_frames)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
 	uint32_t static_screen_cntl = 0;
 	uint32_t addr = 0;
 
+	// By register spec, it only takes 8 bit value
+	if (num_frames > 0xFF)
+		num_frames = 0xFF;
+
 	addr = CRTC_REG(mmCRTC_STATIC_SCREEN_CONTROL);
 	static_screen_cntl = dm_read_reg(tg->ctx, addr);
 
 	set_reg_field_value(static_screen_cntl,
-				value,
+				event_triggers,
 				CRTC_STATIC_SCREEN_CONTROL,
 				CRTC_STATIC_SCREEN_EVENT_MASK);
 
 	set_reg_field_value(static_screen_cntl,
-				2,
+				num_frames,
 				CRTC_STATIC_SCREEN_CONTROL,
 				CRTC_STATIC_SCREEN_FRAME_COUNT);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
index 768ccf27ada9..d8a5ed7b485d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.h
@@ -231,7 +231,8 @@ void dce110_timing_generator_set_drr(
 
 void dce110_timing_generator_set_static_screen_control(
 	struct timing_generator *tg,
-	uint32_t value);
+	uint32_t event_triggers,
+	uint32_t num_frames);
 
 void dce110_timing_generator_get_crtc_scanoutpos(
 	struct timing_generator *tg,
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index 098e56962f2a..82bc4e192bbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -819,13 +819,18 @@ void dce120_tg_set_colors(struct timing_generator *tg,
 
 static void dce120_timing_generator_set_static_screen_control(
 	struct timing_generator *tg,
-	uint32_t value)
+	uint32_t event_triggers,
+	uint32_t num_frames)
 {
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
 
+	// By register spec, it only takes 8 bit value
+	if (num_frames > 0xFF)
+		num_frames = 0xFF;
+
 	CRTC_REG_UPDATE_2(CRTC0_CRTC_STATIC_SCREEN_CONTROL,
-			CRTC_STATIC_SCREEN_EVENT_MASK, value,
-			CRTC_STATIC_SCREEN_FRAME_COUNT, 2);
+			CRTC_STATIC_SCREEN_EVENT_MASK, event_triggers,
+			CRTC_STATIC_SCREEN_FRAME_COUNT, num_frames);
 }
 
 void dce120_timing_generator_set_test_pattern(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 2baff3cd0ae5..5347a85f10d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2704,6 +2704,8 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 	struct drr_params params = {0};
 	// DRR set trigger event mapped to OTG_TRIG_A (bit 11) for manual control flow
 	unsigned int event_triggers = 0x800;
+	// Note DRR trigger events are generated regardless of whether num frames met.
+	unsigned int num_frames = 2;
 
 	params.vertical_total_max = vmax;
 	params.vertical_total_min = vmin;
@@ -2720,7 +2722,7 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 		if (vmax != 0 && vmin != 0)
 			pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
 					pipe_ctx[i]->stream_res.tg,
-					event_triggers);
+					event_triggers, num_frames);
 	}
 }
 
@@ -2737,21 +2739,22 @@ void dcn10_get_position(struct pipe_ctx **pipe_ctx,
 }
 
 void dcn10_set_static_screen_control(struct pipe_ctx **pipe_ctx,
-		int num_pipes, const struct dc_static_screen_events *events)
+		int num_pipes, const struct dc_static_screen_params *params)
 {
 	unsigned int i;
-	unsigned int value = 0;
+	unsigned int triggers = 0;
 
-	if (events->surface_update)
-		value |= 0x80;
-	if (events->cursor_update)
-		value |= 0x2;
-	if (events->force_trigger)
-		value |= 0x1;
+	if (params->triggers.surface_update)
+		triggers |= 0x80;
+	if (params->triggers.cursor_update)
+		triggers |= 0x2;
+	if (params->triggers.force_trigger)
+		triggers |= 0x1;
 
 	for (i = 0; i < num_pipes; i++)
 		pipe_ctx[i]->stream_res.tg->funcs->
-			set_static_screen_control(pipe_ctx[i]->stream_res.tg, value);
+			set_static_screen_control(pipe_ctx[i]->stream_res.tg,
+					triggers, params->num_frames);
 }
 
 static void dcn10_config_stereo_parameters(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 55b8f3b2fc4e..4d20f6586bb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -132,7 +132,7 @@ void dcn10_get_position(struct pipe_ctx **pipe_ctx,
 		int num_pipes,
 		struct crtc_position *position);
 void dcn10_set_static_screen_control(struct pipe_ctx **pipe_ctx,
-		int num_pipes, const struct dc_static_screen_events *events);
+		int num_pipes, const struct dc_static_screen_params *params);
 void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc);
 void dce110_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
 void dcn10_log_hw_state(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index cd7412dc42d1..a9a43b397db9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -789,21 +789,26 @@ void optc1_set_early_control(
 
 void optc1_set_static_screen_control(
 	struct timing_generator *optc,
-	uint32_t value)
+	uint32_t event_triggers,
+	uint32_t num_frames)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
+	// By register spec, it only takes 8 bit value
+	if (num_frames > 0xFF)
+		num_frames = 0xFF;
+
 	/* Bit 8 is no longer applicable in RV for PSR case,
 	 * set bit 8 to 0 if given
 	 */
-	if ((value & STATIC_SCREEN_EVENT_MASK_RANGETIMING_DOUBLE_BUFFER_UPDATE_EN)
+	if ((event_triggers & STATIC_SCREEN_EVENT_MASK_RANGETIMING_DOUBLE_BUFFER_UPDATE_EN)
 			!= 0)
-		value = value &
+		event_triggers = event_triggers &
 		~STATIC_SCREEN_EVENT_MASK_RANGETIMING_DOUBLE_BUFFER_UPDATE_EN;
 
 	REG_SET_2(OTG_STATIC_SCREEN_CONTROL, 0,
-			OTG_STATIC_SCREEN_EVENT_MASK, value,
-			OTG_STATIC_SCREEN_FRAME_COUNT, 2);
+			OTG_STATIC_SCREEN_EVENT_MASK, event_triggers,
+			OTG_STATIC_SCREEN_FRAME_COUNT, num_frames);
 }
 
 void optc1_setup_manual_trigger(struct timing_generator *optc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 3afeb1a30f21..f277656d5464 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -625,7 +625,8 @@ void optc1_set_drr(
 
 void optc1_set_static_screen_control(
 	struct timing_generator *optc,
-	uint32_t value);
+	uint32_t event_triggers,
+	uint32_t num_frames);
 
 void optc1_program_stereo(struct timing_generator *optc,
 	const struct dc_crtc_timing *timing, struct crtc_stereo_flags *flags);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5b9cbedaa0de..89920924a154 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -686,9 +686,13 @@ enum dc_status dcn20_enable_stream_timing(
 	// DRR should set trigger event to monitor surface update event
 	if (stream->adjust.v_total_min != 0 && stream->adjust.v_total_max != 0)
 		event_triggers = 0x80;
+	/* Event triggers and num frames initialized for DRR, but can be
+	 * later updated for PSR use. Note DRR trigger events are generated
+	 * regardless of whether num frames met.
+	 */
 	if (pipe_ctx->stream_res.tg->funcs->set_static_screen_control)
 		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
-				pipe_ctx->stream_res.tg, event_triggers);
+				pipe_ctx->stream_res.tg, event_triggers, 2);
 
 	/* TODO program crtc source select for non-virtual signal*/
 	/* TODO program FMT */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 2d3efd71fa51..e5e7d94026fc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -208,7 +208,8 @@ struct timing_generator_funcs {
 					bool enable, const struct dc_crtc_timing *timing);
 	void (*set_drr)(struct timing_generator *tg, const struct drr_params *params);
 	void (*set_static_screen_control)(struct timing_generator *tg,
-							uint32_t value);
+						uint32_t event_triggers,
+						uint32_t num_frames);
 	void (*set_test_pattern)(
 		struct timing_generator *tg,
 		enum controller_dp_test_pattern test_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index df3204645c6b..209118f9f193 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -42,7 +42,7 @@ struct dc_state;
 struct dc_stream_status;
 struct dc_writeback_info;
 struct dchub_init_data;
-struct dc_static_screen_events;
+struct dc_static_screen_params;
 struct resource_pool;
 struct dc_phy_addr_space_config;
 struct dc_virtual_addr_space_config;
@@ -102,7 +102,7 @@ struct hw_sequencer_funcs {
 			unsigned int vmid, unsigned int vmid_frame_number);
 	void (*set_static_screen_control)(struct pipe_ctx **pipe_ctx,
 			int num_pipes,
-			const struct dc_static_screen_events *events);
+			const struct dc_static_screen_params *events);
 
 	/* Stream Related */
 	void (*enable_stream)(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 8ba06f015975..ecf566378ccd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -51,7 +51,7 @@ struct dc_state;
 struct dc_stream_status;
 struct dc_writeback_info;
 struct dchub_init_data;
-struct dc_static_screen_events;
+struct dc_static_screen_params;
 struct resource_pool;
 struct resource_context;
 struct stream_resource;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A37C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04A810E295;
	Wed, 30 Nov 2022 06:40:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588C910E295
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTjeolV1rvkXPbD/qt/0PMg+bEin0XT0aONGNuErrcTmBP2/J+lhbxXF+itJVgD/18MOxYLZGhLk/hhJTZ544n9hhiUaXkjUdAsJimWXFsoJZuxl4n5F/YypHzYXQGDlh01gX3j3NX61DbR6vZ6MGFJSnB6laUYxd0jRpBVy0U8yhP2xpZk7d6DC1egeK/rqhX7vFRFOLe+5SeA9SuN17kZpx68abgZDLBHE2drdSOd3WCwVeooERRMqQLfxslIYKY4a/IFOiF1zraCXXkAg82UF0mq7tH5bAKa2TSVCECtCBQgFDRKl5JoUvWsE4M6VNWJbxDjJjCTgkvmFMNu9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKgoUdKKMZtRklJRV2hZAud/SydYIr2WL/LGZeJsA3U=;
 b=M65TN/P5wjyIAQTGJMuKP5KynD3+BibJUS5zF5plfGPXmr0B/qd2f/LO4TMbTmFRZZZkV5o03E39ID1X7k64+V5iRMebgSlpm3m12A2tMm6AtsW2i6LZoFKmIxTuSRaD/lxq6VB3GifnDYk+3gRgxj+4kn+jvSyVzb6ILdvo8NFbY1mNEIa1yXHonftZoTTHLQCGWEFmqPfQDCt7TW8Kzl525wulUXur1ExltONG5mUGH8Upy2+MpQd2QqKik5jSKL5avwsJXfiQrZnU2b89wXqvadx0yPOQiRInbK68O2fVYim0q0xXDS3zFKJTufebjZRnz5rBKIft4otFaisWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKgoUdKKMZtRklJRV2hZAud/SydYIr2WL/LGZeJsA3U=;
 b=DnNyape9iCwVW7XYNM/Wig99oamvLB566FLuoz7eNdKAxgSGomGeAlYeya/+/uSLjwI/m5MKirrgxqz11qXBgr1pVL63wqbKgeKBh7B8zIryK9u6FTeYIGpNfZ7E6FbBWzyE16ler6jpZM7zTfEzo3a0vWeVQq6TpHpr30965Vk=
Received: from BN9PR03CA0533.namprd03.prod.outlook.com (2603:10b6:408:131::28)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:40:06 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::56) by BN9PR03CA0533.outlook.office365.com
 (2603:10b6:408:131::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 30 Nov 2022 06:40:06 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:52 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: correct static_screen_event_mask
Date: Wed, 30 Nov 2022 14:36:23 +0800
Message-ID: <20221130063627.2398341-11-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9fcc42-5ea9-40ac-42bf-08dad29db7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtpT+kole/K3Ty59veDOl9DaF2f2oCxmjt4krWmNttNoSJ7FPRHWtPssIddri0KZB6xAku3yPJolpVC75qqY5ogRMFVSWg6VXyOIkncexsV+DW6AaReFEcQ97dpAsYvOMH1DqrcAwSnoS5ezqgMZg7WY+o61g8TOgb1iL4c54THsFJGyAok3qXx4XXpmcWnk8xp03DVFCXgQ6/WoD0Ih2PRGWIG1WrsC9/qqrN74ZgH8+oYKqf3HJ1bbaKcsTMJPp3c5rKDeT/71Cbh41M8/i7vQVsji1L3njZu4Lwg4u2VjJ3hiiOtIAqhIWUAXYc04+i+i4WeypqzvxEJp2ZkOw4oBwWBSZjT0zAqe8Qcf2jU3pzsiLVMlb70lDTa8I9YW6h0l2o5HaaSWUm8wQYL3vsWDsI9aGbOTYYxo5ctYkdHMMEArUEoPuB+Mi68Fv9XwUZRA+gyfZF/M0Xu+njvd6dEDOqDKuOI/pboXS4ls7nBA/76HvGibVT+8ATjQxMJHtDsI4yFRn8UGtvffAgDpntps7KQnw2i0pTIp6B8FCBVDuxBIWOa9o5DwECkEThKtgntro6v8m48B9c57x6f6llVOf0ngypq6maOoPyktRaT8eLsbEo29yUoolBoXKDueWFwhJvdd8GnrcNEe9Ccut1UyGi85h5xyb4z796BBB26v0nvouHIyLlf/env34q/AEg35YJjvYxO8TaDr0aBEidOsDrCGZoZVufMZzgJ2PovNYNEVb+5dHtCYCo7HiusApjiL5LIlV4B0t5A+bZnsTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(70206006)(36756003)(82310400005)(70586007)(8936002)(336012)(478600001)(26005)(4326008)(8676002)(7696005)(16526019)(6666004)(2616005)(40460700003)(1076003)(6916009)(81166007)(356005)(40480700001)(186003)(2906002)(83380400001)(47076005)(426003)(5660300002)(41300700001)(86362001)(316002)(36860700001)(54906003)(82740400003)(44832011)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:40:06.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9fcc42-5ea9-40ac-42bf-08dad29db7d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Zhan Liu <Zhan.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
HW register bit define changed.

Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 40 +++++++++++++++++++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |  4 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 29 +++++++++++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  5 ++-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  4 +-
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |  2 +-
 7 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 165c920ca776..4226a051df41 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -623,3 +623,43 @@ void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
 	if (hws->ctx->dc->debug.hpo_optimization)
 		REG_UPDATE(HPO_TOP_HW_CONTROL, HPO_IO_EN, !!enable);
 }
+void dcn31_set_drr(struct pipe_ctx **pipe_ctx,
+		int num_pipes, struct dc_crtc_timing_adjust adjust)
+{
+	int i = 0;
+	struct drr_params params = {0};
+	unsigned int event_triggers = 0x2;/*Bit[1]: OTG_TRIG_A*/
+	unsigned int num_frames = 2;
+	params.vertical_total_max = adjust.v_total_max;
+	params.vertical_total_min = adjust.v_total_min;
+	params.vertical_total_mid = adjust.v_total_mid;
+	params.vertical_total_mid_frame_num = adjust.v_total_mid_frame_num;
+	for (i = 0; i < num_pipes; i++) {
+		if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs) {
+			if (pipe_ctx[i]->stream_res.tg->funcs->set_drr)
+				pipe_ctx[i]->stream_res.tg->funcs->set_drr(
+					pipe_ctx[i]->stream_res.tg, &params);
+			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
+				if (pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control)
+					pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
+						pipe_ctx[i]->stream_res.tg,
+						event_triggers, num_frames);
+		}
+	}
+}
+void dcn31_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params)
+{
+	unsigned int i;
+	unsigned int triggers = 0;
+	if (params->triggers.surface_update)
+		triggers |= 0x600;/*bit 9 and bit10 : 110 0000 0000*/
+	if (params->triggers.cursor_update)
+		triggers |= 0x10;/*bit4*/
+	if (params->triggers.force_trigger)
+		triggers |= 0x1;
+	for (i = 0; i < num_pipes; i++)
+		pipe_ctx[i]->stream_res.tg->funcs->
+			set_static_screen_control(pipe_ctx[i]->stream_res.tg,
+					triggers, params->num_frames);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
index edfc01d6ad73..e7e03a8722e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
@@ -56,4 +56,8 @@ bool dcn31_is_abm_supported(struct dc *dc,
 void dcn31_init_pipes(struct dc *dc, struct dc_state *context);
 void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable);
 
+void dcn31_set_static_screen_control(struct pipe_ctx **pipe_ctx,
+		int num_pipes, const struct dc_static_screen_params *params);
+void dcn31_set_drr(struct pipe_ctx **pipe_ctx,
+		int num_pipes, struct dc_crtc_timing_adjust adjust);
 #endif /* __DC_HWSS_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 3a32810bbe38..7c2da70ffe21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -64,9 +64,9 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
-	.set_drr = dcn10_set_drr,
+	.set_drr = dcn31_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn10_set_static_screen_control,
+	.set_static_screen_control = dcn31_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index 63a677c8ee27..fe449f7aa771 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -40,6 +40,7 @@
 #define FN(reg_name, field_name) \
 	optc1->tg_shift->field_name, optc1->tg_mask->field_name
 
+#define STATIC_SCREEN_EVENT_MASK_DRR_DOUBLE_BUFFER_UPDATE_EN 0x2000 /*bit 13*/
 static void optc31_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
 		struct dc_crtc_timing *timing)
 {
@@ -231,6 +232,32 @@ void optc3_init_odm(struct timing_generator *optc)
 			OPTC_MEM_SEL, 0);
 	optc1->opp_count = 1;
 }
+void optc31_set_static_screen_control(
+	struct timing_generator *optc,
+	uint32_t event_triggers,
+	uint32_t num_frames)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t framecount;
+	uint32_t events;
+
+	if (num_frames > 0xFF)
+		num_frames = 0xFF;
+	REG_GET_2(OTG_STATIC_SCREEN_CONTROL,
+			OTG_STATIC_SCREEN_EVENT_MASK, &events,
+			OTG_STATIC_SCREEN_FRAME_COUNT, &framecount);
+
+	if (events == event_triggers && num_frames == framecount)
+		return;
+	if ((event_triggers & STATIC_SCREEN_EVENT_MASK_DRR_DOUBLE_BUFFER_UPDATE_EN)
+			!= 0)
+		event_triggers = event_triggers &
+		~STATIC_SCREEN_EVENT_MASK_DRR_DOUBLE_BUFFER_UPDATE_EN;
+
+	REG_UPDATE_2(OTG_STATIC_SCREEN_CONTROL,
+			OTG_STATIC_SCREEN_EVENT_MASK, event_triggers,
+			OTG_STATIC_SCREEN_FRAME_COUNT, num_frames);
+}
 
 static struct timing_generator_funcs dcn31_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
@@ -266,7 +293,7 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
 		.set_drr = optc31_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_vtotal_min_max = optc1_set_vtotal_min_max,
-		.set_static_screen_control = optc1_set_static_screen_control,
+		.set_static_screen_control = optc31_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
 		.tg_init = optc3_tg_init,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
index 30b81a448ce2..5fc6c63580d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -263,5 +263,8 @@ bool optc31_immediate_disable_crtc(struct timing_generator *optc);
 void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
 
 void optc3_init_odm(struct timing_generator *optc);
-
+void optc31_set_static_screen_control(
+	struct timing_generator *optc,
+	uint32_t event_triggers,
+	uint32_t num_frames);
 #endif /* __DC_OPTC_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 5b6c2d94ec71..31feb4b0edee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -66,9 +66,9 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
-	.set_drr = dcn10_set_drr,
+	.set_drr = dcn31_set_drr,
 	.get_position = dcn10_get_position,
-	.set_static_screen_control = dcn10_set_static_screen_control,
+	.set_static_screen_control = dcn31_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index f246aab23050..41edbd64ea21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -228,7 +228,7 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.set_drr = optc31_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_vtotal_min_max = optc1_set_vtotal_min_max,
-		.set_static_screen_control = optc1_set_static_screen_control,
+		.set_static_screen_control = optc31_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
 		.tg_init = optc3_tg_init,
-- 
2.25.1


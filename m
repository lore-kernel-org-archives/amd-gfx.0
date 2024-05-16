Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2645C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E4110EDBF;
	Thu, 16 May 2024 19:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fxKdXdsX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD3C10EDBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4bgd7+2T+ZiD46z6Y71AISW5j8RLeAiIu4Z27D/LZMi87w8BtzGtjm6+c2Q+hx4A6uv3HfRTSlmXidwUDh5nLfed3fZ4qrRKHzzWnfrDFxkj+YQDsfz8H+xgdSnSC4dhPb9lQD+/VafuY32rRVG8udxkk0FQKNLBPIzkJ2x1oB6fcw8qGWxvO7KaHmkaeetEM6sLJtDXmYi4oX8tyxHtfseqcuTa6y2cmR27eQ8u5T64sPwx2vcRpdR+r7S9vA85HhDPg8E1n9Uy7wlLhVqJ6jH6q9BotQXqJ9E+Ehr+l9iFLpxDONCirDdAXabqeMJRTf144hrN9Z2Az75c8UxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QltgQSIt4jA0fD6eH+rUeZ5HF/w2Xr/LvOXZo3a9jr4=;
 b=MZeBXRXviwORXGemE1lK7YUrUERmPzH1l9myIaBFBAMcA+QDUPTC12dKIC3NiJJo29SpZ7ftM4HkZak7iCjI1V1rmIoyncgtakR9gvlFkRpaEkpasq5azWofOO+2tx/8tmwLfmd+ebSwLTETa0KQODBx/rHxe+yyAhE5vj/j4L1WBlFXS/fQc4WBcxpC/Vlj+mm9/X5DZ+7wcwr4Lx5IH3Hb97AMvGvFz67VyFAXs1zb2qBbAFglardaOKHuYxAHUaeQWGZLgx/YoBMWrN9aiLgrepSqcOxPqai5kZBsK+LH5krGWXCklOHSgQ+hPi8ki1Z3RCozRhBEd/Chz0UbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QltgQSIt4jA0fD6eH+rUeZ5HF/w2Xr/LvOXZo3a9jr4=;
 b=fxKdXdsX5tTfPbXknX+xvgEPY08Us5z1nwMYc2saGgztSMsgnv6VKlCAwBoyLjqnanSeubDpOJmOnSeNdDhxLutBJ/9ChN9L/Wvypoz0uXlSyeK5JZu0pEjiqIPACX0jXrkkGgZh4R3J0SqAokRw75JfIUdDzwh3OzYT8G8HmKk=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:27:07 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::dc) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:03 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:02 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ilya Bakoulin <ilya.bakoulin@amd.com>, Krunoslav Kovac
 <krunoslav.kovac@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Add 3DLUT DMA load trigger
Date: Thu, 16 May 2024 15:26:36 -0400
Message-ID: <20240516192647.1522729-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 516434e3-bb64-4331-9cae-08dc75de2c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P626AD+AiNTUDBKHRziBJTlxK7Qmz6/Bh0OgOXWLzlXZaH2EsWV/CayvZaNr?=
 =?us-ascii?Q?MtQwMwCVG7sIt1uEa7FpKpp77Iwg06YSV5S03t3MWqmggY9OFOYFva4uW1Tc?=
 =?us-ascii?Q?lSaDbtQZAMZMpfAYJ0rhHzl6qggwQWIbCN8GNv95h8C+4x7l32oldYhzMruz?=
 =?us-ascii?Q?3AzB/ABk4sNO9npxczRj/jvCB+K844Oj5SfdgWVjNeH3Emjk76efvjczJlbu?=
 =?us-ascii?Q?YAvZY9MCalH5lS2zHJFlGUSaDDqNmclp3yhJQR3g1MNVfyjJd4FuIdyeyBBr?=
 =?us-ascii?Q?SzdoGaj8jBfr4phyIT7hbODQTv+NYGkpH/gQeUkAzQZPXox5kcZAsnxfXagu?=
 =?us-ascii?Q?IOPaF9etDCxcVDD3SHz+wEuVBdsjo8Y+Am6AqmYP3JHg0FKme3CL24vCddh1?=
 =?us-ascii?Q?it6MTdWzVS87S0k2ZLnuyp+01cK2tUQmB45klc4bMGOtRH89eREjVn9FA2IA?=
 =?us-ascii?Q?i1Ei43WIezT9eC3Wxn3c6rIM0NL7Pv5MQUUy6HNVdHKhCxecU0Hb5BpcE5Eu?=
 =?us-ascii?Q?T53QpC0jbhLAWldaINmLtJ1PSp7HIj+QbwmSOd/SHdL8SylxnDwkgyHW29bz?=
 =?us-ascii?Q?Aw+5mS0yhEd0JIXtPqwJK3sHGGSQgg9qyEUhouqwmoE1yqSSpp+2+HWXLTVB?=
 =?us-ascii?Q?CH+kMQFaaJ37U2fgtYwqXY5jwerf0LOtCT21aHfI6tefqDr7aEw1NSuILhEd?=
 =?us-ascii?Q?CfuXO9yvVtUkD0cGwfdw/fTqP6A7MigNjNOhN8A5xJBYVHQrfL3n1ebg9HmM?=
 =?us-ascii?Q?1Ju1h76hr74CwEoWYF7FUDaKJqo2U24U+e0HXE67oONIrsBH4XGiXmNonW79?=
 =?us-ascii?Q?P89n3cLU9oOQClR8LSIxQPzobyUWM3O0atDt7roSqfhZXrnbjZ+TM2GXD1eP?=
 =?us-ascii?Q?AtibnaZGtdNXdouCsB3APmECm3qrSiQ418WCFe8MYReSwVP5IFiFDPkSKoG9?=
 =?us-ascii?Q?vm1dkPOHCySMqO9QJhvf+eUgLIK10iFtDs/k5aRZgCuKgtmJCVoHRYSfyjPT?=
 =?us-ascii?Q?b8Blo2SsFIrcULJSchvQVyNTaMbC0G7iw3RmJ7mixVagoetsIZt5QYBIUoNW?=
 =?us-ascii?Q?B+ht5UdvLciRr6ldI4GPpJtdciyMAlQ/SfRY9PERXFiRIzteg8ApNr9c9d8d?=
 =?us-ascii?Q?TY1i5H+jbTsL1XR0b7AaiY2FQkaBijaq1b6VZLFHYGZoGTrvj8nYLWFXaM3B?=
 =?us-ascii?Q?jJQEs293y1YprYByaTg7Tx3zXLr6akeFUM1w4tNrlvuDPvj8E1T8OcNDifjo?=
 =?us-ascii?Q?YBa8CQSfFozTmVLlZYt2PSRPQMbJU+cBLKrb7fQuI/yEWBVfS+/wy8lT0p/A?=
 =?us-ascii?Q?8/MeRi5Jy2NVltyBpzCkaWtYis5F2iPUXAHCzF4P84vUN6do517ScQ5Hbgtj?=
 =?us-ascii?Q?SNurmYkg7kpx8MzZc3uu6xE78OMI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:06.4920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516434e3-bb64-4331-9cae-08dc75de2c40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why/How]
Need to be able to trigger a DMA load to update 3DLUT contents in MPC.
Adding a HWSS function to serve as the trigger.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  8 ++++++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c   | 17 +++++++++++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h   |  2 ++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c    |  1 +
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer.h  |  1 +
 5 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1008fbc57dbd..3a2101b052ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4074,6 +4074,14 @@ static void commit_planes_for_stream(struct dc *dc,
 				if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 					continue;
 
+				if (srf_updates[i].cm2_params &&
+						srf_updates[i].cm2_params->cm2_luts.lut3d_data.lut3d_src ==
+								DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM &&
+						srf_updates[i].cm2_params->component_settings.shaper_3dlut_setting ==
+								DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT &&
+						dc->hwss.trigger_3dlut_dma_load)
+					dc->hwss.trigger_3dlut_dma_load(dc, pipe_ctx);
+
 				/*program triple buffer after lock based on flip type*/
 				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 					/*only enable triplebuffer for  fast_update*/
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c3bed33eb5d6..a619da7716ed 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -498,9 +498,9 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		if (m_lut_params.pwl) {
 			if (mpc->funcs->populate_lut)
 				mpc->funcs->populate_lut(mpc, MCM_LUT_1DLUT, m_lut_params, lut_bank_a, mpcc_id);
-			if (mpc->funcs->program_lut_mode)
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut1d_xable, lut_bank_a, mpcc_id);
 		}
+		if (mpc->funcs->program_lut_mode)
+			mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut1d_xable, lut_bank_a, mpcc_id);
 	}
 
 	/* Shaper */
@@ -519,9 +519,9 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		if (m_lut_params.pwl) {
 			if (mpc->funcs->populate_lut)
 				mpc->funcs->populate_lut(mpc, MCM_LUT_SHAPER, m_lut_params, lut_bank_a, mpcc_id);
-			if (mpc->funcs->program_lut_mode)
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, shaper_xable, lut_bank_a, mpcc_id);
 		}
+		if (mpc->funcs->program_lut_mode)
+			mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, shaper_xable, lut_bank_a, mpcc_id);
 	}
 
 	/* 3DLUT */
@@ -635,6 +635,15 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	}
 }
 
+void dcn401_trigger_3dlut_dma_load(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+	if (hubp->funcs->hubp_enable_3dlut_fl) {
+		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+	}
+}
+
 bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index dd5bae93dc05..f91159a6e6d4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -40,6 +40,8 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 bool dcn401_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_stream_state *stream);
+void dcn401_trigger_3dlut_dma_load(struct dc *dc,
+				struct pipe_ctx *pipe_ctx);
 void dcn401_calculate_dccg_tmds_div_value(struct pipe_ctx *pipe_ctx,
 				unsigned int *tmds_div);
 enum dc_status dcn401_enable_stream_timing(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index b9fcde08fdc8..8358ba74405f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -24,6 +24,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
 	.program_output_csc = dcn20_program_output_csc,
+	.trigger_3dlut_dma_load = dcn401_trigger_3dlut_dma_load,
 	.enable_accelerated_mode = dce110_enable_accelerated_mode,
 	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
 	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d2d1ba30f6ae..a9f2b7ee9dd8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -304,6 +304,7 @@ struct hw_sequencer_funcs {
 	void (*program_output_csc)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			enum dc_color_space colorspace,
 			uint16_t *matrix, int opp_id);
+	void (*trigger_3dlut_dma_load)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 
 	/* VM Related */
 	int (*init_sys_ctx)(struct dce_hwseq *hws,
-- 
2.34.1


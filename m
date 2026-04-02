Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2138D6AAEC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6224810F283;
	Thu,  2 Apr 2026 18:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="493plctO";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B8110F28C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR8B2TBRtkM7oDa+O4lAGCiAEvr/aKVnunJTsV26ajVJxkdLnup0ElJiLpZMc1rmGE6Zp4WvtAWazk7s/5HnifxU39Zd6nqy7dD2mWDoF2TkkgHhOa43kFW2jp5cskpxt4+faMxt21TJjED9xO0QT6ZyApdAk0Ea75ZWpBqGfIpuMq+tuNCmI9t6/zyGYMsPy1BZj5qqkesbSv8gwAkClmKBaODw6bA+fC4G4fUqSopQiaGcjzOaR8nn102SqwMBGHSii2cxZvZp8hHcOkFhvtEtdcs63fHhPFJUa2YxUF/QeDPSKD1Mh3Nz1SxXgTU77rDiomlPznqyTPMlbfSXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTA5CScQh8Sf84TQfc0Qx217rkKfouoJUBe1MEmR3/g=;
 b=tPRcKdI5SM45rw3K3+LJtdpxs6FFzRkxd9P5aHXYNcEB+NTNi3GGSt1ynBHdMMQdaamRAjetOs+q/FhPIKUX2mr+8waF3J3Cj2WB2T8ZOC+IJUGMxObIERg/msUKRk/pAfRgFPkNMIq1hhv62W4qTO9Kc3vjhaAoynMa5rrzt8kfRGiXmJ2PlENCPLVQzATU5aIoJOixxOz60FX2DEUmGYkApAqCJx092U28MQIiMa25M6m2/hY2KiPGChB9+E1XeRNOEt1Gma6sAcTc3vu3RyZ1yWTAHxKeLDlOCNE+9u7sQwBlU4s2OutNAJNv8J7uRb8qqrpzJsHRkY4qg4DOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTA5CScQh8Sf84TQfc0Qx217rkKfouoJUBe1MEmR3/g=;
 b=493plctOL8bfsGLhrO/bniA23HAAYV+4TNvTL06h6ustBFGrWj3DSEA7r3wVdEwZI8xYu6CBtcM2klh9SMjwyuQNS2vGHgql49fvigg0vAp+1AgjdbLkjg0C4Pmc6Nsd2L9sAcW4nbLLUEW8M26n7lhh1WYur2EQsjLLuyECmrY=
Received: from CH5P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::21)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Thu, 2 Apr
 2026 18:34:23 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::91) by CH5P221CA0011.outlook.office365.com
 (2603:10b6:610:1f2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Thu,
 2 Apr 2026 18:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:13 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:12 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Yihan Zhu <yihan.zhu@amd.com>
Subject: [PATCH 17/22] drm/amd/display: Restore "Move setup_stream_attribute"
Date: Thu, 2 Apr 2026 14:33:09 -0400
Message-ID: <20260402183314.1388755-18-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1813a57a-1a43-417b-898c-08de90e67580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5xwVbxVfzGfe3m9e7vNlbQ3mj2E6jo9IcnVTD7+bMrNjU8plWKdfxBMXx36PvUcBJfdgiMxkkwxcrgp+LklFo7iZDRMXKRM0eJQ+ND0yiIt2AEZk9Tke1xDYV28Yci2THdjuXNOspJAUzYvaL1jPGOAGmP+3mLN2XzIl8+w/XswAgkGXVnNO64XJGJ03XUFJQAtTXOhhro0YJMfrm9EXPe9MeKxyKjMS6FZyKzK+GEVlgiB05bDzOy+9nyuC7Zb/sgtLH9fJosZoyMvPVQeDBQnvvF2yaIfbW5u8iPS3lM6qPWfUvWKdsBFJZ2liTlftR3xIvonjhOenwFI7kWWPrAdlBpibqGEq0uZlLRQ6GVnw6ZspX/DtwyMUdoLKqLLSza9T+XyLvDuqTqIwvp3PaGCgAVSt4m5cDEYOqZ9l9GfMKcLMgi1vQfIA/eNcnFhrqfmuvUTvt+H20lbICinF2cGH0oMGsYgqaS/r/hMht5mVsGrk8uvhURGvCYCxf+G4zftTvWhPP5Z+ha8xGoT+bEUhQQeyQS+dZuq8goMVWIIkbJc8o0S07Ox2g69n8q7A5+Q/SQ6hyzR6WO7leQuLY3yS//Rhid3jHjM/rFObcPWT8Z/aWbExmwYR31JR84jBk61VhxrBoK4H41PsoLdqaovWVkR89rbB90Xl1yj6jQR7zB+ZLFbNLh/DQKqT4O5QYA0T2Hu0y2LR2nK4Xrw5tGNwlYFmFU9hxcYG1xM1Gld7C5Khp25VjWrXwnw1GtCO8yZY26eBK1wzGMADXntkpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4aIZoqdR8Bfot+BBlAuyzNREjQHZwVpq568BisWJbuUvAQ+tVIgOSeir+vdLThkeWhB5Cy1e2FhQJ2FGe5waA+yYCRc1WzdJw8uq3se053LAb8st5Lb/w1Ovp1FAbZM0b9wCLR1wx0EEFH4RMzTA+6FijAFCqOSAPvfSITj9jGc1DF0AfCEyVsebavRNpHEFFXQA+bmXUAeTHYVY5pHGJ/KxQ/3ztVz0eLpdvt+UJq2qMFMbhzBe0JOmGMqWXDCXwEvJMFj2csk9zkThwA/F1Hq45d3tTlIMtvO2YUh/a6ycK9zx9oPH8IZtwNsk+8+LrPhtAhQPuSIpor4aX3BrMH0eBplqDmYF4uW48RB4VuxNKFpmCPWGVIZdu61brhUQtIg+yQwUcuiySjl0xkcCUbGBcb0nfznQNRUK2SP2ySWq7fNhPY6QR+aRiUUUK2/y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:22.0793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1813a57a-1a43-417b-898c-08de90e67580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

From: Charlene Liu <Charlene.Liu@amd.com>

This partially reverts commit 005452bcce65 ("Revert "drm/amd/display: Move setup_stream_attribute"").

[Why]
The original revert was applied to avoid HDMI blank screen regression.
The root cause has been identified and the setup_stream_attribute call
can now be moved back to enable_stream where it belongs.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/dio/virtual/virtual_stream_encoder.c    | 10 ++++++++++
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |  2 ++
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c        |  3 ---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
index 5be18cf54a13..4b27e3887822 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
@@ -59,6 +59,14 @@ static void virtual_stream_encoder_dvi_set_stream_attribute(
 		(void)is_dual_link;
 	}
 
+static void virtual_stream_encoder_lvds_set_stream_attribute(
+	struct stream_encoder *enc,
+	struct dc_crtc_timing *crtc_timing)
+{
+	(void)enc;
+	(void)crtc_timing;
+}
+
 static void virtual_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp) {
@@ -162,6 +170,8 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 		virtual_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		virtual_stream_encoder_dvi_set_stream_attribute,
+	.lvds_set_stream_attribute =
+		virtual_stream_encoder_lvds_set_stream_attribute,
 	.set_throttled_vcp_size =
 		virtual_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 288e4edaa9a2..494fdc4bfa7c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3064,6 +3064,8 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index e12c25896364..bd7a9248cdd7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2285,7 +2285,6 @@ void link_set_dpms_on(
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
-	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	bool apply_edp_fast_boot_optimization =
 		pipe_ctx->stream->apply_edp_fast_boot_optimization;
 
@@ -2331,8 +2330,6 @@ void link_set_dpms_on(
 		pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, otg_out_dest);
 	}
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
-
 	pipe_ctx->stream->apply_edp_fast_boot_optimization = false;
 
 	// Enable VPG before building infoframe
-- 
2.34.1


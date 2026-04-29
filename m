Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A20FF885A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE5E10E3A2;
	Wed, 29 Apr 2026 01:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCa8enhC";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0D810E3A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fpi0oxyekW8frLP9J6DxidWeK9TMOwiNGgII7qWrnvM5tnabi0tQ7nTU5Xr2sFbjq75cGP5GekK0q4XhMsSD5iXfLZNIDNbSQzkcENUsKl1mmzUP7gH7ivnp+XgzytTAxClsfnY2DHFS4P+POJHgMBpw0xH/KrsS6F61VoFjSIXX3NVx7+uD26a4vLZ84OZ00dZv4oXLGlkuvwwsJ428SbbLeCXy2Z/IphksL2RqQXwkOPrwUFMUCIPxzrvkH2FmBZyhLc0OZecxixowsAGBzrGw6Ca1QMd9dY9b23Dg51FZKzNF38AIKInXml+AOHHZZxKJVw0cSsr89QvIZ+5yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gownCel2VVhe0czpvUxZozikoKyyU73/OhIk2TQESSA=;
 b=ntk8HkP540bXe8q6RIR5Flju47bCttuuy2PqdrsZN835zfer6doC3IGJOBva/HP/aRWWygYzbPB8GC3qgjJ4eEdGgEofIPUC3iLl5cQx3CqKAfyM5gJ2l9d+gsDwoCNM8ezDKT2Zz1IMnaxP3poWL+9zF9sat3Y7AiBNvpjxtwhYL43a65T97mfltCx2WxsjKYXc2DEwRmLIrIrkglbjG9jjPvqWqEccnIKdoBxmSPjw6KqTr1ATn5s/RHHeRPC31RB5bRvl4kOh2KaddghQgEh97drDKf8tIMbUGJf/dJR8Jgqb8/WReFwvbowpuJs7IQx82mSXP9zMytJI61311Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gownCel2VVhe0czpvUxZozikoKyyU73/OhIk2TQESSA=;
 b=nCa8enhCQ+3ytNGNJpjQmPUl/NKBnHvF1niPWmshLQaStQB5pZN25nQfvJX7duu82rasezO7T6kwKpW/s30tTIPgijBp4cPLbD3idTASExYsoi8fb3S/lB+pN2dneqN1ICy6CfYydy1ycTPOViHG8ucDUhDl53H0UHsdhqu3AU4=
Received: from BN9PR03CA0866.namprd03.prod.outlook.com (2603:10b6:408:13d::31)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 01:53:18 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::20) by BN9PR03CA0866.outlook.office365.com
 (2603:10b6:408:13d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 01:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:53:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:17 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:53:09 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ian Chen <ian.chen@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Anthony Koo <anthony.koo@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 09/17] drm/amd/display: Skip HDR metadata update when Smart
 Power OLED enabled
Date: Wed, 29 Apr 2026 09:19:18 +0800
Message-ID: <20260429012055.2065869-10-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e6b027-6369-42f3-e06f-08dea59215f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZppnY1ocm7EWoThdd1F/gfQRNdpu0lUutKKSfQyXwgfQonb021p7ST53YX4Ne3Dvr5CAm18gIXUrzKWtbtiR2OKSuQZCHDq7rmszE+q4EO0IOOMscMLygqaZCBYT3UhO/hoql0m+CaOZ5cEQ3Gvg+eMGA9XjYuyJWlRhPk3CY8Pel6Xky5KKQEZ14M2aXA5v9fxsnssYeo0HX/ykhpZPA4mR2ZO5wqNmEdQmhSc5pJ6bFnOfMZ/JEcemHCzz99K6XmaGcMP4DIHGzONcVtzvfXCVWQfEqYAFDPIoo7oTlFKdWf3+FnDdJhHcU/+HMSm8BNtgiNDEuRBFscwJlUiMf2ahClQ4jipCWLenDxuQIh3gdOimpj7mLyPjRFD0TPV3nM58yYAzYbhb1fMftCqEOP0SQZmLs8nYh+N4eEAtrTZh7rTC1tqjuh4D1sV8yo+VCaNhQrstIAPBZGnI3w6rZ2ciUTcCmIYtBFkzot+bkegDgd6XQGufA4AqxIRqso2lKMzIhh/aT2Tr2ghrHQ0aHqdb2GIycn4VkRV1AI2VDjZ6kTZW8gmj5dUlmFIl+ZWqrSpUosynwZWSerDryoJv4P8tGz8F5EPTAVfRwgv63/MbKbGRZLG4bZ+rIgl2MX5RchkfpZThbo6gWccUIjD7nUxeLJvd9gP+XHkYB5rDOAnGYBmqAWNIRu2BExQUFqdpt6dpNMlmhBUUDItCgvIGEJn6SWt/57Y8dXWgA9uLyq6MdRtxWfW84X50wpk7w8Ga5ZQHZD5Vy4Je6gH5MOdWSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iPBbwuUEsLApof/Pwogz37GBm8YtR7Mf0qem2GSaRAshkMc2IudMkxht8P5470izw4TgeTyua4K4AM5xPKKdA1mk3FWjHOxn8H00v1dUxSQb9/bfFvlPRtvYAPi3PJGzR992YSM6dl6LLPEoOiMH+7Y5yvVoHf0n4yfY0FDysldc4frSC+BYxMGeWYSkTHC9zUJ0IvK8r128WpnOgm2Yxmz2f1glCgKQuDClPx7yDcr4IbjTs0pcezdQCOt8I7nDsKyt78HKvusJAhzr5VI8yGtye5uCpcNd1cj3ItO0nKvQm3BcdGIqmiUw/VpGQiIC/sz1hmYSV8n+47iSmIri5ob4n0ty072GSfdDvda/ydXRWBrzuCJGJfLtccnBnnao+3FFChdQ4DnGfTSy8AN1JG7ahtSJrdiYt4FCrMoVXSv0s1fZ3R2MoKcQxgkhMOD2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:53:18.5263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e6b027-6369-42f3-e06f-08dea59215f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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

From: Ian Chen <ian.chen@amd.com>

[Why & How]
While smart power oled is enabled,
the infopacket contents are tied to the frame histogram,
so it does not need driver side to update the hdr metadata.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                    | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h                  | 1 +
 .../drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c | 6 +++++-
 .../amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c     | 6 ++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h      | 1 +
 6 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6dd520663248..7f364d4ac279 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6534,6 +6534,10 @@ bool dc_smart_power_oled_enable(const struct dc_link *link, bool enable, uint16_
 	// send cmd
 	status = dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
+	// Update firmware_controlled_hdr_info_packet state on successful command execution
+	if (status && pipe_ctx)
+		pipe_ctx->stream->firmware_controlled_hdr_info_packet = enable;
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 25552f21faf3..32f7c7c076c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -304,6 +304,7 @@ struct dc_stream_state {
 	enum dc_drr_trigger_mode drr_trigger_mode;
 
 	struct dc_update_scratch_space *update_scratch;
+	bool firmware_controlled_hdr_info_packet;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
index e93be7b6d9b0..c14fb51c2611 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
@@ -470,7 +470,11 @@ void enc3_stream_encoder_update_dp_info_packets(
 				&info_frame->spd,
 				true);
 	}
-	if (info_frame->hdrsmd.valid) {
+	/* While smart power oled is enabled DMUB is scanning the contents of each frame
+	 * and updating the HDR infopacket contents. Therefore we transition the infopacket
+	 * programming control to DMUB while Smart Power OLED is enabled.
+	 */
+	if (info_frame->hdrsmd.valid && !info_frame->firmware_controlled_hdr_info_packet) {
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				3,  /* packetIndex */
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
index 92ed130aeaec..79d6ab8ed71c 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -468,7 +468,7 @@ static void dcn31_hpo_dp_stream_enc_update_dp_info_packets(
 				&info_frame->spd,
 				true);
 
-	if (info_frame->hdrsmd.valid)
+	if (info_frame->hdrsmd.valid && !info_frame->firmware_controlled_hdr_info_packet)
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
 				3,  /* packetIndex */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index b4afb2bc4493..5a90ff83b65c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -399,6 +399,9 @@ void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				&pipe_ctx->stream_res.encoder_info_frame);
 
+		pipe_ctx->stream_res.encoder_info_frame.firmware_controlled_hdr_info_packet
+			= pipe_ctx->stream->firmware_controlled_hdr_info_packet;
+
 		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->update_dp_info_packets(
 				pipe_ctx->stream_res.hpo_dp_stream_enc,
 				&pipe_ctx->stream_res.encoder_info_frame);
@@ -409,6 +412,9 @@ void dcn31_update_info_frame(struct pipe_ctx *pipe_ctx)
 				pipe_ctx->stream_res.stream_enc,
 				&pipe_ctx->stream_res.encoder_info_frame);
 
+		pipe_ctx->stream_res.encoder_info_frame.firmware_controlled_hdr_info_packet
+			= pipe_ctx->stream->firmware_controlled_hdr_info_packet;
+
 		pipe_ctx->stream_res.stream_enc->funcs->update_dp_info_packets(
 			pipe_ctx->stream_res.stream_enc,
 			&pipe_ctx->stream_res.encoder_info_frame);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 27f950ae45ee..a9bf960dacbc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -93,6 +93,7 @@ struct encoder_info_frame {
 	/* Adaptive Sync SDP*/
 	struct dc_info_packet adaptive_sync;
 	struct enc_sdp_line_num sdp_line_num;
+	bool firmware_controlled_hdr_info_packet;
 };
 
 struct encoder_unblank_param {
-- 
2.43.0


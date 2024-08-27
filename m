Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3BBC5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E1610E39B;
	Tue, 27 Aug 2024 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SKChDDgH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A06A10E38F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ6vWOkqW5weUqUouV8XIFeOuBE58COYkrXDIIThGBO66ABtpnssK+L12cEP4367Vz8Hrc9QdjZCOqFHR3vtj0EvoKsZVkLCIKZy97MVWfMfRxOFbYyzg5NQt19piWW2s0QsgXqE7abqTvxmemBVnKaAZOjsTf6MOPyG1fwZwb92YPpr1pnZ31OiAF1KkFZG6w9t5q72VUj8kpSJzKE8AxEt9i4TaUs0A9cMOB2FTwunZgNsqZdDMjk45ggAKst5cPeTNqvoHbB48EqCAHTquXrSOPNgW5lMGxv+0XQZZxGUwpPkjgQPtXbBVpSQ++3EwwSE+jqDg50iN7dikk+NBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dabOuRzSGCwWvPjsSSXuNvxzMgXiN0cwlxuBypLO/ZU=;
 b=wRLlUFOkMp/jAAlwMvZW5rUXh1oOigIe3WKB9hwNsSt6jI+VHdDs3PwzYxLKWKamAdy+QgkpA7lESz7Ocy9J6rEM5dye5KpBJMsNl4xDDdd+R8yI06K+8uXhBUPCXQV6Idg8TmbZlX9iJfz3T9CTQYFxJRBx18S/mdlQxypmTI7TZcaDB5nhhVfwkWcVOcARKHsyWwFFohchQBzWV1gPL1c7OC40Yo5pZz2+Y/+A5ACDKNN9oEmhTH1nAGLHzZ8fKK7JXx78oGxmwmhb8aeJR9cFEvyLGcv8+D233Z91/xCNx9r9duUjWXEpJvt64NRCDkSIfWQ1ix24RDO/44+PjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dabOuRzSGCwWvPjsSSXuNvxzMgXiN0cwlxuBypLO/ZU=;
 b=SKChDDgH3s3zPcPk5W2cFNwOY9ZHvG69lmvCbqOuPijVAgDrtVvy+F/W1iDocEh8VcZv/T+tLCx4ov2O7ddbRr7MKdrYkh8kClyH08V3lp6/Tv6Bc44mYTGWi36ggjOFFSrWKcWVYBQOaei61sK3jJpP0eFEqSzjtkqshx62XEQ=
Received: from BN9PR03CA0692.namprd03.prod.outlook.com (2603:10b6:408:ef::7)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:41:17 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::25) by BN9PR03CA0692.outlook.office365.com
 (2603:10b6:408:ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:16 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:12 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Relja
 Vojvodic" <Relja.Vojvodic@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 10/14] drm/amd/display: Add sharpness control interface
Date: Tue, 27 Aug 2024 12:37:30 -0400
Message-ID: <20240827164045.167557-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 67af4212-6653-4ae2-e5cd-08dcc6b71255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lRELQZ7qWnKpPu/9LRDBpfiVWK1GgNaqnUN1Mq5BayLcFUC6APEsv7kH60FW?=
 =?us-ascii?Q?Je/UsTJgRPzPjBFzktuaHebtnww72GpNapJgHuxs0Ot0AxvrDz8q9BSqlZ3Y?=
 =?us-ascii?Q?F5TdGmPr99MpGOsHh1hGywVhxsp1qqV7ykuFTPFx+dx6er4Tls/9ZkoedO+k?=
 =?us-ascii?Q?h0klPDLVd9uNFcZcQo2pYzrgNUKYK7HWn/tRfaSbmdquhZkrvMErB8E/H98k?=
 =?us-ascii?Q?YKNSx42zvD08eh29BOmPiyj8fUBLSlBVw3Cj8+QSiKmdB4t6fOoXFc5mkPM4?=
 =?us-ascii?Q?ZdGh6fucjiZCy/xlw9PBE1Q6h3+RqsUPvaoOSfiaNtl0U7YzwO3uQFTU9h4q?=
 =?us-ascii?Q?1EkINm8Sqmdu1ZFGSO9q5fjWLtqU1e8Yw940ImXMXV8LtKHzQb3xMl4Llsvi?=
 =?us-ascii?Q?7ACikDYlEN6+VgEqN/rT5gR5ENVmDVhgJLb9+aDDfZ+zMDKa6Gr53Z6W2IWC?=
 =?us-ascii?Q?eXZm6UKu3K+l6HAhW+8rPy75s80WIVnHpE1B4USLeTiuenm9CX/mJnUYHdjm?=
 =?us-ascii?Q?etFI+phe5BO3vXTUt17gxWE9EOtHlGA222drTUoHdG6eMRFXjHAebP4ssXvG?=
 =?us-ascii?Q?BMa6ltjLuGsXLWf7J1lX/Q5ARm0pWKgO8zy10MN0gLrw2EWlfOVNpE9CwbXN?=
 =?us-ascii?Q?WJZdFKrc059o7g0BcBLlO2uqzsjESQr33wlBG8IS+W/gVTqbf6dZSFaeoT0Y?=
 =?us-ascii?Q?HmWUL0l7gw+NOIJwbITIPorG0KKO7XzafOuIDwhn5rZf3eaQVZvj7Bl6V6Dq?=
 =?us-ascii?Q?vog91HLvq/tyYr6KRR6p7MDjtPTmPwEY1SJ9b2Ww/5dmBQZVcONVPy66NPCo?=
 =?us-ascii?Q?4+5fN565OYZ0P2uCaOfFG3ZfdIgN9hLKIhXpU9+L6799vyuQW6vE6Wa8g7z4?=
 =?us-ascii?Q?IqnHrtZw4E3WgNX8MJot/AgeVvfJg2qdeyW9zX/FhJL68Ml94CJ4yTQ7Ws1J?=
 =?us-ascii?Q?GYMLB1Rarn3891aB6ppZ7miSawuwp24oa6xsy6dDjq2r7yJHN9TZGllCSMIX?=
 =?us-ascii?Q?4GLUkOMr7i+6GSwMEymCuuTh0eC1mcAvKtnOR4TB2Uz1pbzdKItaOdWgml+C?=
 =?us-ascii?Q?gxP2P9iQvwWyqkrOQkoGQ+2AmUbuzezFuLH7VraigNFoC4mnTnh/UU1H1N8b?=
 =?us-ascii?Q?XJxZLh5mQG12sd32jSIKSZyCgvu4FD9JYmUVqtpap7KHM1t6SzO+mGgNEWDg?=
 =?us-ascii?Q?zsu03Lb2POT0cj+axlYkSTCwa7Q9e4X0J+mjYRxEp/lm9kqVYvAWYhCGdcXS?=
 =?us-ascii?Q?TrTiEzgiU8qgu2m4rK9c979JhlFJszLR8fj/HXzo03V4QAQrngq5ai8GpQc0?=
 =?us-ascii?Q?2AQlxw9wud6Svx5saDLW8YRUWjEx0LiBMMiW20Ncj85lMBQkpCrTsVPD2XkK?=
 =?us-ascii?Q?P03EBQXG7VUD0TfTVI4TSnoL9RXHqBbz91L8u3I8rkQFBkabD56AUOEbcKK1?=
 =?us-ascii?Q?Yv4r6MoCyZ5ci+DO3ALVYIfDlUZ86isp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:16.7920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67af4212-6653-4ae2-e5cd-08dcc6b71255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

- Add interface for controlling shapness level input into DCN.
- Update SPL to support custom sharpness values.
- Add support for different sharpness values depending on YUV/RGB
  content.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  46 ++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  24 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |   4 +-
 .../display/dc/spl/dc_spl_isharp_filters.c    | 213 +++++-------------
 .../display/dc/spl/dc_spl_isharp_filters.h    |   2 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  27 ++-
 9 files changed, 138 insertions(+), 192 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e07e47d74664..ae788154896c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2690,6 +2690,9 @@ static enum surface_update_type check_update_surfaces_for_stream(
 				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
 			su_flags->bits.fams_changed = 1;
 
+		if (stream_update->scaler_sharpener_update)
+			su_flags->bits.scaler_sharpener = 1;
+
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
 
@@ -3022,6 +3025,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
 			update->dsc_config = NULL;
 		}
 	}
+	if (update->scaler_sharpener_update)
+		stream->scaler_sharpener_update = *update->scaler_sharpener_update;
 }
 
 static void backup_planes_and_stream_state(
@@ -4713,7 +4718,8 @@ static bool full_update_required(struct dc *dc,
 			stream_update->func_shaper ||
 			stream_update->lut3d_func ||
 			stream_update->pending_test_pattern ||
-			stream_update->crtc_timing_adjust))
+			stream_update->crtc_timing_adjust ||
+			stream_update->scaler_sharpener_update))
 		return true;
 
 	if (stream) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index aaf1d7fdb73d..1a907ff82336 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1052,6 +1052,7 @@ struct dc_debug_options {
 	unsigned int disable_spl;
 	unsigned int force_easf;
 	unsigned int force_sharpness;
+	unsigned int force_sharpness_level;
 	unsigned int force_lls;
 	bool notify_dpia_hr_bw;
 	bool enable_ips_visual_confirm;
@@ -1348,7 +1349,7 @@ struct dc_plane_state {
 	enum mpcc_movable_cm_location mcm_location;
 	struct dc_csc_transform cursor_csc_color_matrix;
 	bool adaptive_sharpness_en;
-	unsigned int sharpnessX1000;
+	int sharpness_level;
 	enum linear_light_scaling linear_light_scaling;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 328499a77884..cd6de93eb91c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -139,24 +139,36 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	else if (pipe_ctx->stream->ctx->dc->debug.force_easf == 2)
 		spl_in->disable_easf = true;
 	/* Translate adaptive sharpening preference */
-	if (pipe_ctx->stream->ctx->dc->debug.force_sharpness > 0) {
-		spl_in->adaptive_sharpness.enable = (pipe_ctx->stream->ctx->dc->debug.force_sharpness > 1) ? true : false;
-		if (pipe_ctx->stream->ctx->dc->debug.force_sharpness == 2)
-			spl_in->adaptive_sharpness.sharpness = SHARPNESS_LOW;
-		else if (pipe_ctx->stream->ctx->dc->debug.force_sharpness == 3)
-			spl_in->adaptive_sharpness.sharpness = SHARPNESS_MID;
-		else if (pipe_ctx->stream->ctx->dc->debug.force_sharpness >= 4)
-			spl_in->adaptive_sharpness.sharpness = SHARPNESS_HIGH;
-	} else {
-		spl_in->adaptive_sharpness.enable = plane_state->adaptive_sharpness_en;
-		if (plane_state->sharpnessX1000 == 0)
+	unsigned int sharpness_setting = pipe_ctx->stream->ctx->dc->debug.force_sharpness;
+	unsigned int force_sharpness_level = pipe_ctx->stream->ctx->dc->debug.force_sharpness_level;
+	if (sharpness_setting == SHARPNESS_HW_OFF)
+		spl_in->adaptive_sharpness.enable = false;
+	else if (sharpness_setting == SHARPNESS_ZERO) {
+		spl_in->adaptive_sharpness.enable = true;
+		spl_in->adaptive_sharpness.sharpness_level = 0;
+	} else if (sharpness_setting == SHARPNESS_CUSTOM) {
+		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_min = 0;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_max = 1750;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_rgb_mid = 750;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_min = 0;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_max = 3500;
+		spl_in->adaptive_sharpness.sharpness_range.sdr_yuv_mid = 1500;
+		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_min = 0;
+		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_max = 2750;
+		spl_in->adaptive_sharpness.sharpness_range.hdr_rgb_mid = 1500;
+
+		if (force_sharpness_level > 0) {
+			if (force_sharpness_level > 10)
+				force_sharpness_level = 10;
+			spl_in->adaptive_sharpness.enable = true;
+			spl_in->adaptive_sharpness.sharpness_level = force_sharpness_level;
+		} else if (!plane_state->adaptive_sharpness_en) {
 			spl_in->adaptive_sharpness.enable = false;
-		else if (plane_state->sharpnessX1000 < 999)
-			spl_in->adaptive_sharpness.sharpness = SHARPNESS_LOW;
-		else if (plane_state->sharpnessX1000 < 1999)
-			spl_in->adaptive_sharpness.sharpness = SHARPNESS_MID;
-		else // Any other value is high sharpness
-			spl_in->adaptive_sharpness.sharpness = SHARPNESS_HIGH;
+			spl_in->adaptive_sharpness.sharpness_level = 0;
+		} else {
+			spl_in->adaptive_sharpness.enable = true;
+			spl_in->adaptive_sharpness.sharpness_level = plane_state->sharpness_level;
+		}
 	}
 	// Translate linear light scaling preference
 	if (pipe_ctx->stream->ctx->dc->debug.force_lls > 0)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index de9bd72ca514..14ea47eda0c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -142,6 +142,7 @@ union stream_update_flags {
 		uint32_t mst_bw : 1;
 		uint32_t crtc_timing_adjust : 1;
 		uint32_t fams_changed : 1;
+		uint32_t scaler_sharpener : 1;
 	} bits;
 
 	uint32_t raw;
@@ -308,6 +309,7 @@ struct dc_stream_state {
 	bool is_phantom;
 
 	struct luminance_data lumin_data;
+	bool scaler_sharpener_update;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
@@ -353,6 +355,7 @@ struct dc_stream_update {
 	struct dc_cursor_attributes *cursor_attributes;
 	struct dc_cursor_position *cursor_position;
 	bool *hw_cursor_req;
+	bool *scaler_sharpener_update;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 703d7b51c6c2..01f98139292e 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -957,6 +957,7 @@ static void dpp401_dscl_set_isharp_filter(
  */
 static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 		const struct scaler_data *scl_data,
+		bool program_isharp_1dlut,
 		bool *bs_coeffs_updated)
 {
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
@@ -1015,7 +1016,8 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 		ISHARP_LBA_PWL_BASE_SEG5, scl_data->dscl_prog_data.isharp_lba.base_seg[5]);
 
 	/* ISHARP_DELTA_LUT */
-	dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
+	if (!program_isharp_1dlut)
+		dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
 
 	/* ISHARP_NLDELTA_SOFT_CLIP */
 	REG_SET_6(ISHARP_NLDELTA_SOFT_CLIP, 0,
@@ -1071,13 +1073,29 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 			dpp_base, scl_data, dpp_base->ctx->dc->debug.always_scale);
 	bool ycbcr = scl_data->format >= PIXEL_FORMAT_VIDEO_BEGIN
 				&& scl_data->format <= PIXEL_FORMAT_VIDEO_END;
+	bool program_isharp_1dlut = false;
 	bool bs_coeffs_updated = false;
 
+
 	if (memcmp(&dpp->scl_data, scl_data, sizeof(*scl_data)) == 0)
 		return;
 
 	PERF_TRACE();
 
+	/* If only sharpness has changed, then only update 1dlut, then return */
+	if (scl_data->dscl_prog_data.isharp_en &&
+		(dpp->scl_data.dscl_prog_data.sharpness_level
+		!= scl_data->dscl_prog_data.sharpness_level)) {
+		/* ISHARP_DELTA_LUT */
+		dpp401_dscl_set_isharp_filter(dpp, scl_data->dscl_prog_data.isharp_delta);
+		dpp->scl_data.dscl_prog_data.sharpness_level = scl_data->dscl_prog_data.sharpness_level;
+		dpp->scl_data.dscl_prog_data.isharp_delta = scl_data->dscl_prog_data.isharp_delta;
+
+		if (memcmp(&dpp->scl_data, scl_data, sizeof(*scl_data)) == 0)
+			return;
+		program_isharp_1dlut = true;
+	}
+
 	dpp->scl_data = *scl_data;
 
 	if ((dpp->base.ctx->dc->config.use_spl) && (!dpp->base.ctx->dc->debug.disable_spl)) {
@@ -1131,7 +1149,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	if (dscl_mode == DSCL_MODE_SCALING_444_BYPASS) {
 		if (dpp->base.ctx->dc->config.prefer_easf)
 			dpp401_dscl_disable_easf(dpp_base, scl_data);
-		dpp401_dscl_program_isharp(dpp_base, scl_data, &bs_coeffs_updated);
+		dpp401_dscl_program_isharp(dpp_base, scl_data, program_isharp_1dlut, &bs_coeffs_updated);
 		return;
 	}
 
@@ -1165,7 +1183,7 @@ void dpp401_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 	 *   WB scaler coeffs and toggle coeff RAM together
 	 */
 	//if (dpp->base.ctx->dc->config.prefer_easf)
-	dpp401_dscl_program_isharp(dpp_base, scl_data, &bs_coeffs_updated);
+	dpp401_dscl_program_isharp(dpp_base, scl_data, program_isharp_1dlut, &bs_coeffs_updated);
 
 	dpp401_dscl_set_scl_filter(dpp, scl_data, ycbcr, bs_coeffs_updated);
 	/* Edge adaptive scaler function configuration */
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index b6d1cfc494fc..15f7eda903e6 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -1662,8 +1662,10 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		dscl_prog_data->isharp_lba.base_seg[5] = 0;	// ISHARP LBA PWL for Seg 5. BASE value in U0.6 format
 	}
 
-	spl_build_isharp_1dlut_from_reference_curve(ratio, setup, adp_sharpness.sharpness);
+
+	spl_build_isharp_1dlut_from_reference_curve(ratio, setup, adp_sharpness);
 	dscl_prog_data->isharp_delta = spl_get_pregen_filter_isharp_1D_lut(setup);
+	dscl_prog_data->sharpness_level = adp_sharpness.sharpness_level;
 
 	// Program the nldelta soft clip values
 	if (lls_pref == LLS_PREF_YES) {
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
index 8e4bcba2932a..33712f50d303 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.c
@@ -460,114 +460,6 @@ static uint16_t filter_isharp_bs_4tap_in_6_64p_s1_12[198];
 static uint16_t filter_isharp_bs_4tap_64p_s1_12[132];
 static uint16_t filter_isharp_bs_3tap_64p_s1_12[99];
 
-struct scale_ratio_to_sharpness_level_lookup scale_to_sharp_sdr_nl[3][6] = {
-	{ /* LOW */
-		{1125, 1000, 75, 100},
-		{11, 10, 6, 10},
-		{1075, 1000, 45, 100},
-		{105, 100, 3, 10},
-		{1025, 1000, 15, 100},
-		{1, 1, 0, 1},
-	},
-	{ /* MID */
-		{1125, 1000, 2, 1},
-		{11, 10, 175, 100},
-		{1075, 1000, 15, 10},
-		{105, 100, 125, 100},
-		{1025, 1000, 1, 1},
-		{1, 1, 75, 100},
-	},
-	{ /* HIGH */
-		{1125, 1000, 35, 10},
-		{11, 10, 32, 10},
-		{1075, 1000, 29, 10},
-		{105, 100, 26, 10},
-		{1025, 1000, 23, 10},
-		{1, 1, 2, 1},
-	},
-};
-
-struct scale_ratio_to_sharpness_level_lookup scale_to_sharp_sdr_l[3][6] = {
-	{ /* LOW */
-		{1125, 1000, 75, 100},
-		{11, 10, 6, 10},
-		{1075, 1000, 45, 100},
-		{105, 100, 3, 10},
-		{1025, 1000, 15, 100},
-		{1, 1, 0, 1},
-	},
-	{ /* MID */
-		{1125, 1000, 15, 10},
-		{11, 10, 135, 100},
-		{1075, 1000, 12, 10},
-		{105, 100, 105, 100},
-		{1025, 1000, 9, 10},
-		{1, 1, 75, 100},
-	},
-	{ /* HIGH */
-		{1125, 1000, 25, 10},
-		{11, 10, 23, 10},
-		{1075, 1000, 21, 10},
-		{105, 100, 19, 10},
-		{1025, 1000, 17, 10},
-		{1, 1, 15, 10},
-	},
-};
-
-struct scale_ratio_to_sharpness_level_lookup scale_to_sharp_hdr_nl[3][6] = {
-	{ /* LOW */
-		{1125, 1000, 5, 10},
-		{11, 10, 4, 10},
-		{1075, 1000, 3, 10},
-		{105, 100, 2, 10},
-		{1025, 1000, 1, 10},
-		{1, 1, 0, 1},
-	},
-	{ /* MID */
-		{1125, 1000, 1, 1},
-		{11, 10, 9, 10},
-		{1075, 1000, 8, 10},
-		{105, 100, 7, 10},
-		{1025, 1000, 6, 10},
-		{1, 1, 5, 10},
-	},
-	{ /* HIGH */
-		{1125, 1000, 15, 10},
-		{11, 10, 14, 10},
-		{1075, 1000, 13, 10},
-		{105, 100, 12, 10},
-		{1025, 1000, 11, 10},
-		{1, 1, 1, 1},
-	},
-};
-
-struct scale_ratio_to_sharpness_level_lookup scale_to_sharp_hdr_l[3][6] = {
-	{ /* LOW */
-		{1125, 1000, 75, 100},
-		{11, 10, 6, 10},
-		{1075, 1000, 45, 100},
-		{105, 100, 3, 10},
-		{1025, 1000, 15, 100},
-		{1, 1, 0, 1},
-	},
-	{ /* MID */
-		{1125, 1000, 15, 10},
-		{11, 10, 135, 100},
-		{1075, 1000, 12, 10},
-		{105, 100, 105, 100},
-		{1025, 1000, 9, 10},
-		{1, 1, 75, 100},
-	},
-	{ /* HIGH */
-		{1125, 1000, 25, 10},
-		{11, 10, 23, 10},
-		{1075, 1000, 21, 10},
-		{105, 100, 19, 10},
-		{1025, 1000, 17, 10},
-		{1, 1, 15, 10},
-	},
-};
-
 /* Pre-generated 1DLUT for given setup and sharpness level */
 struct isharp_1D_lut_pregen filter_isharp_1D_lut_pregen[NUM_SHARPNESS_SETUPS] = {
 	{
@@ -649,74 +541,72 @@ uint16_t *spl_get_filter_isharp_bs_3tap_64p(void)
 	return filter_isharp_bs_3tap_64p_s1_12;
 }
 
-void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup, enum explicit_sharpness sharpness)
+static unsigned int spl_calculate_sharpness_level(int discrete_sharpness_level, enum system_setup setup,
+		struct spl_sharpness_range sharpness_range)
 {
-	uint8_t *byte_ptr_1dlut_src, *byte_ptr_1dlut_dst;
-	struct spl_fixed31_32 sharp_base, sharp_calc, sharp_level, ratio_level;
-	int j;
-	struct scale_ratio_to_sharpness_level_lookup *setup_lookup_ptr;
-	int num_sharp_ramp_levels;
-	int size_1dlut;
-	int sharp_calc_int;
-	uint32_t filter_pregen_store[ISHARP_LUT_TABLE_SIZE];
+	unsigned int sharpness_level = 0;
+
+	int min_sharpness, max_sharpness, mid_sharpness;
 
-	/*
-	 * Given scaling ratio, setup and sharpness, build pregenerated
-	 * 1DLUT tables
-	 *
-	 * Based on setup ( HDR/SDR, L/NL ), get base scale ratio to
-	 *  sharpness curve
-	 */
 	switch (setup) {
+
 	case HDR_L:
-		setup_lookup_ptr = scale_to_sharp_hdr_l[sharpness];
-		num_sharp_ramp_levels = sizeof(scale_to_sharp_hdr_l[sharpness])/
-			sizeof(struct scale_ratio_to_sharpness_level_lookup);
+		min_sharpness = sharpness_range.hdr_rgb_min;
+		max_sharpness = sharpness_range.hdr_rgb_max;
+		mid_sharpness = sharpness_range.hdr_rgb_mid;
 		break;
 	case HDR_NL:
-		setup_lookup_ptr = scale_to_sharp_hdr_nl[sharpness];
-		num_sharp_ramp_levels = sizeof(scale_to_sharp_hdr_nl[sharpness])/
-			sizeof(struct scale_ratio_to_sharpness_level_lookup);
+		/* currently no use case, use Non-linear SDR values for now */
+	case SDR_NL:
+		min_sharpness = sharpness_range.sdr_yuv_min;
+		max_sharpness = sharpness_range.sdr_yuv_max;
+		mid_sharpness = sharpness_range.sdr_yuv_mid;
 		break;
 	case SDR_L:
-		setup_lookup_ptr = scale_to_sharp_sdr_l[sharpness];
-		num_sharp_ramp_levels = sizeof(scale_to_sharp_sdr_l[sharpness])/
-			sizeof(struct scale_ratio_to_sharpness_level_lookup);
-		break;
-	case SDR_NL:
 	default:
-		setup_lookup_ptr = scale_to_sharp_sdr_nl[sharpness];
-		num_sharp_ramp_levels = sizeof(scale_to_sharp_sdr_nl[sharpness])/
-			sizeof(struct scale_ratio_to_sharpness_level_lookup);
+		min_sharpness = sharpness_range.sdr_rgb_min;
+		max_sharpness = sharpness_range.sdr_rgb_max;
+		mid_sharpness = sharpness_range.sdr_rgb_mid;
 		break;
 	}
 
-	/*
-	 * Compare desired scaling ratio and find adjusted sharpness from
-	 *  base scale ratio to sharpness curve
-	 */
-	j = 0;
-	sharp_level = spl_fixpt_zero;
-	while (j < num_sharp_ramp_levels) {
-		ratio_level = spl_fixpt_from_fraction(setup_lookup_ptr->ratio_numer,
-			setup_lookup_ptr->ratio_denom);
-		if (ratio.value >= ratio_level.value) {
-			sharp_level = spl_fixpt_from_fraction(setup_lookup_ptr->sharpness_numer,
-				setup_lookup_ptr->sharpness_denom);
-			break;
-		}
-		setup_lookup_ptr++;
-		j++;
-	}
+	int lower_half_step_size = (mid_sharpness - min_sharpness) / 5;
+	int upper_half_step_size = (max_sharpness - mid_sharpness) / 5;
+
+	// lower half linear approximation
+	if (discrete_sharpness_level < 5)
+		sharpness_level = min_sharpness + (lower_half_step_size * discrete_sharpness_level);
+	// upper half linear approximation
+	else
+		sharpness_level = mid_sharpness + (upper_half_step_size * (discrete_sharpness_level - 5));
+
+	return sharpness_level;
+}
+
+void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup,
+	struct adaptive_sharpness sharpness)
+{
+	uint8_t *byte_ptr_1dlut_src, *byte_ptr_1dlut_dst;
+	struct spl_fixed31_32 sharp_base, sharp_calc, sharp_level;
+	int j;
+	int size_1dlut;
+	int sharp_calc_int;
+	uint32_t filter_pregen_store[ISHARP_LUT_TABLE_SIZE];
+
+	/* Custom sharpnessX1000 value */
+	unsigned int sharpnessX1000 = spl_calculate_sharpness_level(sharpness.sharpness_level,
+			setup, sharpness.sharpness_range);
+	sharp_level = spl_fixpt_from_fraction(sharpnessX1000, 1000);
 
 	/*
 	 * Check if pregen 1dlut table is already precalculated
 	 * If numer/denom is different, then recalculate
 	 */
-	if ((filter_isharp_1D_lut_pregen[setup].sharpness_numer == setup_lookup_ptr->sharpness_numer) &&
-		(filter_isharp_1D_lut_pregen[setup].sharpness_denom == setup_lookup_ptr->sharpness_denom))
+	if ((filter_isharp_1D_lut_pregen[setup].sharpness_numer == sharpnessX1000) &&
+		(filter_isharp_1D_lut_pregen[setup].sharpness_denom == 1000))
 		return;
 
+
 	/*
 	 * Calculate LUT_128_gained with this equation:
 	 *
@@ -737,8 +627,9 @@ void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, en
 		sharp_calc = spl_fixpt_min(spl_fixpt_from_int(255), sharp_calc);
 		sharp_calc = spl_fixpt_add(sharp_calc, spl_fixpt_from_fraction(1, 2));
 		sharp_calc_int = spl_fixpt_floor(sharp_calc);
-		if (sharp_calc_int > 255)
-			sharp_calc_int = 255;
+		/* Clamp it at 0x7F so it doesn't wrap */
+		if (sharp_calc_int > 127)
+			sharp_calc_int = 127;
 		*byte_ptr_1dlut_dst = (uint8_t)sharp_calc_int;
 
 		byte_ptr_1dlut_src++;
@@ -747,8 +638,8 @@ void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, en
 
 	/* Update 1dlut table and sharpness level */
 	memcpy((void *)filter_isharp_1D_lut_pregen[setup].value, (void *)filter_pregen_store, size_1dlut);
-	filter_isharp_1D_lut_pregen[setup].sharpness_numer = setup_lookup_ptr->sharpness_numer;
-	filter_isharp_1D_lut_pregen[setup].sharpness_denom = setup_lookup_ptr->sharpness_denom;
+	filter_isharp_1D_lut_pregen[setup].sharpness_numer = sharpnessX1000;
+	filter_isharp_1D_lut_pregen[setup].sharpness_denom = 1000;
 }
 
 uint32_t *spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup)
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
index 3d023a154a92..fe0b12571f2c 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_isharp_filters.h
@@ -45,6 +45,6 @@ void spl_init_blur_scale_coeffs(void);
 void spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
 	const struct spl_scaler_data *data);
 
-void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup, enum explicit_sharpness sharpness);
+void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup, struct adaptive_sharpness sharpness);
 uint32_t *spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup);
 #endif /* __DC_SPL_ISHARP_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 7c1a21c2305d..85b19ebe2c57 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -407,6 +407,7 @@ struct dscl_prog_data {
 	/* blur and scale filter */
 	const uint16_t *filter_blur_scale_v;
 	const uint16_t *filter_blur_scale_h;
+	int sharpness_level; /* Track sharpness level */
 };
 
 /* SPL input and output definitions */
@@ -460,14 +461,26 @@ struct basic_out {
 	bool alpha_en;
 	bool use_two_pixels_per_container;
 };
-enum explicit_sharpness	{
-	SHARPNESS_LOW = 0,
-	SHARPNESS_MID,
-	SHARPNESS_HIGH
-};
-struct adaptive_sharpness	{
+enum sharpness_setting	{
+	SHARPNESS_HW_OFF = 0,
+	SHARPNESS_ZERO,
+	SHARPNESS_CUSTOM
+};
+struct spl_sharpness_range {
+	int sdr_rgb_min;
+	int sdr_rgb_max;
+	int sdr_rgb_mid;
+	int sdr_yuv_min;
+	int sdr_yuv_max;
+	int sdr_yuv_mid;
+	int hdr_rgb_min;
+	int hdr_rgb_max;
+	int hdr_rgb_mid;
+};
+struct adaptive_sharpness {
 	bool enable;
-	enum explicit_sharpness sharpness;
+	int sharpness_level;
+	struct spl_sharpness_range sharpness_range;
 };
 enum linear_light_scaling	{	// convert it in translation logic
 	LLS_PREF_DONT_CARE = 0,
-- 
2.46.0

